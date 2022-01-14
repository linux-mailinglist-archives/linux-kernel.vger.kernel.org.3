Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E36148E425
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239319AbiANGRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:17:06 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59496 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbiANGRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:17:05 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n8FtA-0006EA-VI; Fri, 14 Jan 2022 17:16:42 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Jan 2022 17:16:41 +1100
Date:   Fri, 14 Jan 2022 17:16:41 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Stephan Mueller <smueller@chronox.de>,
        "David S. Miller" <davem@davemloft.net>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org, simo@redhat.com,
        Eric Biggers <ebiggers@kernel.org>, Petr Vorel <pvorel@suse.cz>
Subject: [v2 PATCH] crypto: api - Disallow sha1 in FIPS-mode while allowing
 hmac(sha1)
Message-ID: <YeEVSaMEVJb3cQkq@gondor.apana.org.au>
References: <20211209090358.28231-1-nstange@suse.de>
 <87r1a7thy0.fsf@suse.de>
 <YcvEkfS4cONDXXB9@gondor.apana.org.au>
 <2468270.qO8rWLYou6@tauon.chronox.de>
 <YdepEhTI/LB9wdJr@gondor.apana.org.au>
 <Yd0gInht+V+Kcsw2@gondor.apana.org.au>
 <871r1eyamd.fsf@suse.de>
 <Yd1dK//76455cHdz@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd1dK//76455cHdz@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 09:34:19PM +1100, Herbert Xu wrote:
>
> You're right.  The real issue is that any algorithm with no tests
> at all is allowed in FIPS mode.  That's clearly suboptimal.  But we
> can't just ban every unknown algorithm because we rely on that
> to let things like echainiv through.
> 
> Let me figure out a way to differentiate these two cases.

So what I've done is modify hmac so that if the underlying algo
is FIPS_INTERNAL, then we pre-emptively set FIPS_INTERNAL on the
hmac side as well.  This can then be cleared if the hmac algorithm
is explicitly listed as fips_allowed.

---8<---
Currently we do not distinguish between algorithms that fail on
the self-test vs. those which are disabled in FIPS mode (not allowed).
Both are marked as having failed the self-test.

As it has been requested that we need to disable sha1 in FIPS
mode while still allowing hmac(sha1) this approach needs to change.

This patch allows this scenario by adding a new flag FIPS_INTERNAL
to indicate those algorithms that have passed the self-test and are
not FIPS-allowed.  They can then be used for the self-testing of
other algorithms or by those that are explicitly allowed to use them
(currently just hmac).

Note that as a side-effect of this patch algorithms which are not
FIPS-allowed will now return ENOENT instead of ELIBBAD.  Hopefully
this is not an issue as some people were relying on this already.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/algapi.c b/crypto/algapi.c
index a366cb3e8aa1..09fb75806e87 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -322,8 +322,16 @@ void crypto_alg_tested(const char *name, int err)
 found:
 	q->cra_flags |= CRYPTO_ALG_DEAD;
 	alg = test->adult;
-	if (err || list_empty(&alg->cra_list))
+
+	if (list_empty(&alg->cra_list))
+		goto complete;
+
+	if (err == -ECANCELED)
+		alg->cra_flags |= CRYPTO_ALG_FIPS_INTERNAL;
+	else if (err)
 		goto complete;
+	else
+		alg->cra_flags &= ~CRYPTO_ALG_FIPS_INTERNAL;
 
 	alg->cra_flags |= CRYPTO_ALG_TESTED;
 
diff --git a/crypto/api.c b/crypto/api.c
index cf0869dd130b..549f9aced1da 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -223,6 +223,8 @@ static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg)
 	else if (crypto_is_test_larval(larval) &&
 		 !(alg->cra_flags & CRYPTO_ALG_TESTED))
 		alg = ERR_PTR(-EAGAIN);
+	else if (alg->cra_flags & CRYPTO_ALG_FIPS_INTERNAL)
+		alg = ERR_PTR(-EAGAIN);
 	else if (!crypto_mod_get(alg))
 		alg = ERR_PTR(-EAGAIN);
 	crypto_mod_put(&larval->alg);
@@ -233,6 +235,7 @@ static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg)
 static struct crypto_alg *crypto_alg_lookup(const char *name, u32 type,
 					    u32 mask)
 {
+	const u32 fips = CRYPTO_ALG_FIPS_INTERNAL;
 	struct crypto_alg *alg;
 	u32 test = 0;
 
@@ -240,8 +243,20 @@ static struct crypto_alg *crypto_alg_lookup(const char *name, u32 type,
 		test |= CRYPTO_ALG_TESTED;
 
 	down_read(&crypto_alg_sem);
-	alg = __crypto_alg_lookup(name, type | test, mask | test);
-	if (!alg && test) {
+	alg = __crypto_alg_lookup(name, (type | test) & ~fips,
+				  (mask | test) & ~fips);
+	if (alg) {
+		if (((type | mask) ^ fips) & fips)
+			mask |= fips;
+		mask &= fips;
+
+		if (!crypto_is_larval(alg) &&
+		    ((type ^ alg->cra_flags) & mask)) {
+			/* Algorithm is disallowed in FIPS mode. */
+			crypto_mod_put(alg);
+			alg = ERR_PTR(-ENOENT);
+		}
+	} else if (test) {
 		alg = __crypto_alg_lookup(name, type, mask);
 		if (alg && !crypto_is_larval(alg)) {
 			/* Test failed */
diff --git a/crypto/hmac.c b/crypto/hmac.c
index 25856aa7ccbf..af82e3eeb7d0 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -169,6 +169,7 @@ static int hmac_create(struct crypto_template *tmpl, struct rtattr **tb)
 	struct crypto_alg *alg;
 	struct shash_alg *salg;
 	u32 mask;
+	u32 type;
 	int err;
 	int ds;
 	int ss;
@@ -182,8 +183,9 @@ static int hmac_create(struct crypto_template *tmpl, struct rtattr **tb)
 		return -ENOMEM;
 	spawn = shash_instance_ctx(inst);
 
+	type = CRYPTO_ALG_FIPS_INTERNAL;
 	err = crypto_grab_shash(spawn, shash_crypto_instance(inst),
-				crypto_attr_alg_name(tb[1]), 0, mask);
+				crypto_attr_alg_name(tb[1]), type, mask);
 	if (err)
 		goto err_free_inst;
 	salg = crypto_spawn_shash_alg(spawn);
@@ -204,6 +206,7 @@ static int hmac_create(struct crypto_template *tmpl, struct rtattr **tb)
 	if (err)
 		goto err_free_inst;
 
+	inst->alg.base.cra_flags = alg->cra_flags & CRYPTO_ALG_FIPS_INTERNAL;
 	inst->alg.base.cra_priority = alg->cra_priority;
 	inst->alg.base.cra_blocksize = alg->cra_blocksize;
 	inst->alg.base.cra_alignmask = alg->cra_alignmask;
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 5831d4bbc64f..995d44db6154 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -1664,7 +1664,8 @@ static int test_hash_vs_generic_impl(const char *generic_driver,
 	if (strcmp(generic_driver, driver) == 0) /* Already the generic impl? */
 		return 0;
 
-	generic_tfm = crypto_alloc_shash(generic_driver, 0, 0);
+	generic_tfm = crypto_alloc_shash(generic_driver,
+					 CRYPTO_ALG_FIPS_INTERNAL, 0);
 	if (IS_ERR(generic_tfm)) {
 		err = PTR_ERR(generic_tfm);
 		if (err == -ENOENT) {
@@ -2387,7 +2388,8 @@ static int test_aead_vs_generic_impl(struct aead_extra_tests_ctx *ctx)
 	if (strcmp(generic_driver, driver) == 0) /* Already the generic impl? */
 		return 0;
 
-	generic_tfm = crypto_alloc_aead(generic_driver, 0, 0);
+	generic_tfm = crypto_alloc_aead(generic_driver,
+					CRYPTO_ALG_FIPS_INTERNAL, 0);
 	if (IS_ERR(generic_tfm)) {
 		err = PTR_ERR(generic_tfm);
 		if (err == -ENOENT) {
@@ -2986,7 +2988,8 @@ static int test_skcipher_vs_generic_impl(const char *generic_driver,
 	if (strcmp(generic_driver, driver) == 0) /* Already the generic impl? */
 		return 0;
 
-	generic_tfm = crypto_alloc_skcipher(generic_driver, 0, 0);
+	generic_tfm = crypto_alloc_skcipher(generic_driver,
+					    CRYPTO_ALG_FIPS_INTERNAL, 0);
 	if (IS_ERR(generic_tfm)) {
 		err = PTR_ERR(generic_tfm);
 		if (err == -ENOENT) {
@@ -5328,7 +5331,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 	}, {
 		.alg = "sha1",
 		.test = alg_test_hash,
-		.fips_allowed = 1,
 		.suite = {
 			.hash = __VECS(sha1_tv_template)
 		}
@@ -5613,6 +5615,13 @@ static int alg_find_test(const char *alg)
 	return -1;
 }
 
+static int alg_fips_disabled(const char *driver, const char *alg)
+{
+	pr_info("alg: %s (%s) is disabled due to FIPS\n", alg, driver);
+
+	return -ECANCELED;
+}
+
 int alg_test(const char *driver, const char *alg, u32 type, u32 mask)
 {
 	int i;
@@ -5637,9 +5646,6 @@ int alg_test(const char *driver, const char *alg, u32 type, u32 mask)
 		if (i < 0)
 			goto notest;
 
-		if (fips_enabled && !alg_test_descs[i].fips_allowed)
-			goto non_fips_alg;
-
 		rc = alg_test_cipher(alg_test_descs + i, driver, type, mask);
 		goto test_done;
 	}
@@ -5649,8 +5655,7 @@ int alg_test(const char *driver, const char *alg, u32 type, u32 mask)
 	if (i < 0 && j < 0)
 		goto notest;
 
-	if (fips_enabled && ((i >= 0 && !alg_test_descs[i].fips_allowed) ||
-			     (j >= 0 && !alg_test_descs[j].fips_allowed)))
+	if (fips_enabled && (j >= 0 && !alg_test_descs[j].fips_allowed))
 		goto non_fips_alg;
 
 	rc = 0;
@@ -5671,16 +5676,22 @@ int alg_test(const char *driver, const char *alg, u32 type, u32 mask)
 		}
 		WARN(1, "alg: self-tests for %s (%s) failed (rc=%d)",
 		     driver, alg, rc);
-	} else {
-		if (fips_enabled)
-			pr_info("alg: self-tests for %s (%s) passed\n",
-				driver, alg);
+	} else if (fips_enabled) {
+		pr_info("alg: self-tests for %s (%s) passed\n",
+			driver, alg);
+
+		if (i >= 0 && !alg_test_descs[i].fips_allowed)
+			rc = alg_fips_disabled(driver, alg);
 	}
 
 	return rc;
 
 notest:
 	printk(KERN_INFO "alg: No test for %s (%s)\n", alg, driver);
+
+	if (type & CRYPTO_ALG_FIPS_INTERNAL)
+		return alg_fips_disabled(driver, alg);
+
 	return 0;
 non_fips_alg:
 	return -EINVAL;
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 855869e1fd32..df3f68dfe8c7 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -132,6 +132,15 @@
  */
 #define CRYPTO_ALG_ALLOCATES_MEMORY	0x00010000
 
+/*
+ * Mark an algorithm as a service implementation only usable by a
+ * template and never by a normal user of the kernel crypto API.
+ * This is intended to be used by algorithms that are themselves
+ * not FIPS-approved but may instead be used to implement parts of
+ * a FIPS-approved algorithm (e.g., sha1 vs. hmac(sha1)).
+ */
+#define CRYPTO_ALG_FIPS_INTERNAL	0x00020000
+
 /*
  * Transform masks and values (for crt_flags).
  */
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
