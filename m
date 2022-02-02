Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40FB4A6F13
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbiBBKme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:42:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36830 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343586AbiBBKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:41:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 51CFB1F383;
        Wed,  2 Feb 2022 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643798503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24eClEaxIUy3+Ra1vQ5zT00O49a7gGQfd1LxZbnPUjk=;
        b=rX/KxoOu1vGNA+qlxZsyewQtubQyoIPmBbQS5HuCTGcQ3a1eDw6oOMkC1mZLLtby6kO9UO
        bYxukmPFn/x9lNvXJFpZMZ3KJtpao5k7HQvP5kIW6BjrE9Vgj8jJhCST1XUG8Jvxiz28t7
        E2bc+VUo4d/gH7sVmV6obB8SkoP1XwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643798503;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24eClEaxIUy3+Ra1vQ5zT00O49a7gGQfd1LxZbnPUjk=;
        b=YaPUvhOjcJH3NSLvK+eWvhONRQu2OftPwzP5SF4Ho3tDKKDmnkpWh1ChI+OWQwcA2n8sLR
        lZfVuHabzvfWTsBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CC9C13E02;
        Wed,  2 Feb 2022 10:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q0VpCedf+mGQbAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 02 Feb 2022 10:41:43 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v3 12/15] crypto: api - allow algs only in specific constructions in FIPS mode
Date:   Wed,  2 Feb 2022 11:40:09 +0100
Message-Id: <20220202104012.4193-13-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220202104012.4193-1-nstange@suse.de>
References: <20220202104012.4193-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we do not distinguish between algorithms that fail on
the self-test vs. those which are disabled in FIPS mode (not allowed).
Both are marked as having failed the self-test.

Recently the need arose to allow the usage of certain algorithms only
as arguments to specific template instantiations in FIPS mode. For
example, standalone "dh" must be blocked, but e.g. "ffdhe2048(dh)" is
allowed. Other potential use cases include "cbcmac(aes)", which must
only be used with ccm(), or "ghash", which must be used only for
gcm().

This patch allows this scenario by adding a new flag FIPS_INTERNAL to
indicate those algorithms that are not FIPS-allowed. They can then be
used as template arguments only, i.e. when looked up via
crypto_grab_spawn() to be more specific. The FIPS_INTERNAL bit gets
propagated upwards recursively into the surrounding template
instances, until the construction eventually matches an explicit
testmgr entry with ->fips_allowed being set, if any.

The behaviour to skip !->fips_allowed self-test executions in FIPS
mode will be retained. Note that this effectively means that
FIPS_INTERNAL algorithms are handled very similarly to the INTERNAL
ones in this regard. It is expected that the FIPS_INTERNAL algorithms
will receive sufficient testing when the larger constructions they're
a part of, if any, get exercised by testmgr.

Note that as a side-effect of this patch algorithms which are not
FIPS-allowed will now return ENOENT instead of ELIBBAD. Hopefully
this is not an issue as some people were relying on this already.

Link: https://lore.kernel.org/r/YeEVSaMEVJb3cQkq@gondor.apana.org.au
Originally-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/algapi.c        | 18 ++++++++++++++++--
 crypto/api.c           | 19 +++++++++++++++++--
 crypto/tcrypt.c        |  4 ++--
 crypto/testmgr.c       | 23 +++++++++++++++++++----
 include/linux/crypto.h |  9 +++++++++
 5 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 9f15e11f5d73..53c5149e6abf 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -328,9 +328,17 @@ void crypto_alg_tested(const char *name, int err)
 found:
 	q->cra_flags |= CRYPTO_ALG_DEAD;
 	alg = test->adult;
-	if (err || list_empty(&alg->cra_list))
+
+	if (list_empty(&alg->cra_list))
 		goto complete;
 
+	if (err == -ECANCELED)
+		alg->cra_flags |= CRYPTO_ALG_FIPS_INTERNAL;
+	else if (err)
+		goto complete;
+	else
+		alg->cra_flags &= ~CRYPTO_ALG_FIPS_INTERNAL;
+
 	alg->cra_flags |= CRYPTO_ALG_TESTED;
 
 	/* Only satisfy larval waiters if we are the best. */
@@ -610,6 +618,7 @@ int crypto_register_instance(struct crypto_template *tmpl,
 {
 	struct crypto_larval *larval;
 	struct crypto_spawn *spawn;
+	u32 fips_internal = 0;
 	int err;
 
 	err = crypto_check_alg(&inst->alg);
@@ -632,11 +641,15 @@ int crypto_register_instance(struct crypto_template *tmpl,
 		spawn->inst = inst;
 		spawn->registered = true;
 
+		fips_internal |= spawn->alg->cra_flags;
+
 		crypto_mod_put(spawn->alg);
 
 		spawn = next;
 	}
 
+	inst->alg.cra_flags |= (fips_internal & CRYPTO_ALG_FIPS_INTERNAL);
+
 	larval = __crypto_register_alg(&inst->alg);
 	if (IS_ERR(larval))
 		goto unlock;
@@ -689,7 +702,8 @@ int crypto_grab_spawn(struct crypto_spawn *spawn, struct crypto_instance *inst,
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
-	alg = crypto_find_alg(name, spawn->frontend, type, mask);
+	alg = crypto_find_alg(name, spawn->frontend,
+			      type | CRYPTO_ALG_FIPS_INTERNAL, mask);
 	if (IS_ERR(alg))
 		return PTR_ERR(alg);
 
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
diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 82b5eef2246a..9558b6ad0c78 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -1667,8 +1667,8 @@ static inline int tcrypt_test(const char *alg)
 	pr_debug("testing %s\n", alg);
 
 	ret = alg_test(alg, alg, 0, 0);
-	/* non-fips algs return -EINVAL in fips mode */
-	if (fips_enabled && ret == -EINVAL)
+	/* non-fips algs return -EINVAL or -ECANCELED in fips mode */
+	if (fips_enabled && (ret == -EINVAL || ret == -ECANCELED))
 		ret = 0;
 	return ret;
 }
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 26400b46f298..d715ddc22c6b 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5647,6 +5647,13 @@ static int alg_find_test(const char *alg)
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
@@ -5683,9 +5690,13 @@ int alg_test(const char *driver, const char *alg, u32 type, u32 mask)
 	if (i < 0 && j < 0)
 		goto notest;
 
-	if (fips_enabled && ((i >= 0 && !alg_test_descs[i].fips_allowed) ||
-			     (j >= 0 && !alg_test_descs[j].fips_allowed)))
-		goto non_fips_alg;
+	if (fips_enabled) {
+		if (j >= 0 && !alg_test_descs[j].fips_allowed)
+			return -EINVAL;
+
+		if (i >= 0 && !alg_test_descs[i].fips_allowed)
+			goto non_fips_alg;
+	}
 
 	rc = 0;
 	if (i >= 0)
@@ -5715,9 +5726,13 @@ int alg_test(const char *driver, const char *alg, u32 type, u32 mask)
 
 notest:
 	printk(KERN_INFO "alg: No test for %s (%s)\n", alg, driver);
+
+	if (type & CRYPTO_ALG_FIPS_INTERNAL)
+		return alg_fips_disabled(driver, alg);
+
 	return 0;
 non_fips_alg:
-	return -EINVAL;
+	return alg_fips_disabled(driver, alg);
 }
 
 #endif /* CONFIG_CRYPTO_MANAGER_DISABLE_TESTS */
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 855869e1fd32..2324ab6f1846 100644
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
+ * a FIPS-approved algorithm (e.g., dh vs. ffdhe2048(dh)).
+ */
+#define CRYPTO_ALG_FIPS_INTERNAL	0x00020000
+
 /*
  * Transform masks and values (for crt_flags).
  */
-- 
2.26.2

