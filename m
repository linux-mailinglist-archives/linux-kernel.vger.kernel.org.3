Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6CC4A6EFB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbiBBKmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:42:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41914 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbiBBKlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:41:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4D132113D;
        Wed,  2 Feb 2022 10:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643798499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JEwAZF4E7B6LWyjJtkgWALneLiAI/2/54TvfrrmtvSE=;
        b=j9jUfQGM57ya77WGZA0JVwgHXhGvNyaoTe0pbM5ec/KOVTIn5pod9EeKD+KmcnfX9f6YTH
        MQynpqZubn2CXn3yGcDopNlFZcr5g2qJzlB2ktbNp/4gP4NJPs7hkKiF97xEGKy2f6jHUf
        G8gRr/iKq4853tufFH+C3gHrHzHSR4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643798499;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JEwAZF4E7B6LWyjJtkgWALneLiAI/2/54TvfrrmtvSE=;
        b=uwIcRIAClbtgj1jLJE7LsIL5REekvgaJPKjFkXBJRmM/32pXJB+jkIBH3cyFCwstLHN5eW
        dqWQtSgWfV6yetDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F64B13E02;
        Wed,  2 Feb 2022 10:41:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id unx6IeNf+mGEbAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 02 Feb 2022 10:41:39 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v3 09/15] crypto: dh - implement private key generation primitive for ffdheXYZ(dh)
Date:   Wed,  2 Feb 2022 11:40:06 +0100
Message-Id: <20220202104012.4193-10-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220202104012.4193-1-nstange@suse.de>
References: <20220202104012.4193-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The support for NVME in-band authentication currently in the works ([1])
needs to generate ephemeral DH keys for use with the RFC 7919 safe-prime
FFDHE groups.

In analogy to ECDH and its ecc_gen_privkey(), implement a
dh_safe_prime_gen_privkey() and invoke it from the ffdheXYZ(dh) templates'
common ->set_secret(), i.e. dh_safe_prime_set_secret(), in case the input
->key_size is zero.

As the RFC 7919 FFDHE groups are classified as approved safe-prime groups
by SP800-56Arev3, it's worthwhile to make the new
dh_safe_prime_gen_privkey() to follow the approach specified in
SP800-56Arev3, sec. 5.6.1.1.3 ("Key-Pair Generation Using Extra Random
Bits") in order to achieve conformance.

SP800-56Arev3 specifies a lower as well as an upper bound on the generated
key's length:
- it must be >= two times the maximum supported security strength of
  the group in question and
- it must be <= the length of the domain parameter Q.

For any safe-prime group Q = (P - 1)/2 by definition and the individual
maximum supported security strengths as specified by SP800-56Arev3 have
been made available as part of the FFDHE dh_safe_prime definitions
introduced with a previous patch. Make dh_safe_prime_gen_privkey() pick
twice the maximum supported strength rounded up to the next power of two
for the output key size. This choice respects both, the lower and upper
bounds given by SP800-90Arev3 for any of the approved safe-prime groups and
is also in line with the NVME base spec 2.0, which requires the key size to
be >= 256bits.

[1] https://lore.kernel.org/r/20211202152358.60116-1-hare@suse.de

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/Kconfig |   1 +
 crypto/dh.c    | 140 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 138 insertions(+), 3 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index e041cabe93da..c47fe5da1440 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -235,6 +235,7 @@ config CRYPTO_DH_RFC7919_GROUPS
 	bool "Support for RFC 7919 FFDHE group parameters"
 	default n
 	depends on CRYPTO_DH
+	select CRYPTO_RNG_DEFAULT
 	help
 	  Provide support for RFC 7919 FFDHE group parameters. If unsure, say N.
 
diff --git a/crypto/dh.c b/crypto/dh.c
index d0adb1705fe7..869a0476e5e2 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -10,6 +10,7 @@
 #include <crypto/internal/kpp.h>
 #include <crypto/kpp.h>
 #include <crypto/dh.h>
+#include <crypto/rng.h>
 #include <linux/mpi.h>
 
 struct dh_ctx {
@@ -315,6 +316,128 @@ static void dh_safe_prime_exit_tfm(struct crypto_kpp *tfm)
 	crypto_free_kpp(tfm_ctx->dh_tfm);
 }
 
+static u64 __add_u64_to_be(__be64 *dst, unsigned int n, u64 val)
+{
+	unsigned int i;
+
+	for (i = n; val && i > 0; --i) {
+		u64 tmp = be64_to_cpu(dst[i - 1]);
+
+		tmp += val;
+		val = tmp >= val ? 0 : 1;
+		dst[i - 1] = cpu_to_be64(tmp);
+	}
+
+	return val;
+}
+
+static void *dh_safe_prime_gen_privkey(const struct dh_safe_prime *safe_prime,
+				       unsigned int *key_size)
+{
+	unsigned int n, oversampling_size;
+	__be64 *key;
+	int err;
+	u64 h, o;
+
+	/*
+	 * Generate a private key following NIST SP800-56Ar3,
+	 * sec. 5.6.1.1.1 and 5.6.1.1.3 resp..
+	 *
+	 * 5.6.1.1.1: choose key length N such that
+	 * 2 * ->max_strength <= N <= log2(q) + 1 = ->p_size * 8 - 1
+	 * with q = (p - 1) / 2 for the safe-prime groups.
+	 * Choose the lower bound's next power of two for N in order to
+	 * avoid excessively large private keys while still
+	 * maintaining some extra reserve beyond the bare minimum in
+	 * most cases. Note that for each entry in safe_prime_groups[],
+	 * the following holds for such N:
+	 * - N >= 256, in particular it is a multiple of 2^6 = 64
+	 *   bits and
+	 * - N < log2(q) + 1, i.e. N respects the upper bound.
+	 */
+	n = roundup_pow_of_two(2 * safe_prime->max_strength);
+	WARN_ON_ONCE(n & ((1u << 6) - 1));
+	n >>= 6; /* Convert N into units of u64. */
+
+	/*
+	 * Reserve one extra u64 to hold the extra random bits
+	 * required as per 5.6.1.1.3.
+	 */
+	oversampling_size = (n + 1) * sizeof(__be64);
+	key = kmalloc(oversampling_size, GFP_KERNEL);
+	if (!key)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * 5.6.1.1.3, step 3 (and implicitly step 4): obtain N + 64
+	 * random bits and interpret them as a big endian integer.
+	 */
+	err = -EFAULT;
+	if (crypto_get_default_rng())
+		goto out_err;
+
+	err = crypto_rng_get_bytes(crypto_default_rng, (u8 *)key,
+				   oversampling_size);
+	crypto_put_default_rng();
+	if (err)
+		goto out_err;
+
+	/*
+	 * 5.6.1.1.3, step 5 is implicit: 2^N < q and thus,
+	 * M = min(2^N, q) = 2^N.
+	 *
+	 * For step 6, calculate
+	 * key = (key[] mod (M - 1)) + 1 = (key[] mod (2^N - 1)) + 1.
+	 *
+	 * In order to avoid expensive divisions, note that
+	 * 2^N mod (2^N - 1) = 1 and thus, for any integer h,
+	 * 2^N * h mod (2^N - 1) = h mod (2^N - 1) always holds.
+	 * The big endian integer key[] composed of n + 1 64bit words
+	 * may be written as key[] = h * 2^N + l, with h = key[0]
+	 * representing the 64 most significant bits and l
+	 * corresponding to the remaining 2^N bits. With the remark
+	 * from above,
+	 * h * 2^N + l mod (2^N - 1) = l + h mod (2^N - 1).
+	 * As both, l and h are less than 2^N, their sum after
+	 * this first reduction is guaranteed to be <= 2^(N + 1) - 2.
+	 * Or equivalently, that their sum can again be written as
+	 * h' * 2^N + l' with h' now either zero or one and if one,
+	 * then l' <= 2^N - 2. Thus, all bits at positions >= N will
+	 * be zero after a second reduction:
+	 * h' * 2^N + l' mod (2^N - 1) = l' + h' mod (2^N - 1).
+	 * At this point, it is still possible that
+	 * l' + h' = 2^N - 1, i.e. that l' + h' mod (2^N - 1)
+	 * is zero. This condition will be detected below by means of
+	 * the final increment overflowing in this case.
+	 */
+	h = be64_to_cpu(key[0]);
+	h = __add_u64_to_be(key + 1, n, h);
+	h = __add_u64_to_be(key + 1, n, h);
+	WARN_ON_ONCE(h);
+
+	/* Increment to obtain the final result. */
+	o = __add_u64_to_be(key + 1, n, 1);
+	/*
+	 * The overflow bit o from the increment is either zero or
+	 * one. If zero, key[1:n] holds the final result in big-endian
+	 * order. If one, key[1:n] is zero now, but needs to be set to
+	 * one, c.f. above.
+	 */
+	if (o)
+		key[n] = cpu_to_be64(1);
+
+	/* n is in units of u64, convert to bytes. */
+	*key_size = n << 3;
+	/* Strip the leading extra __be64, which is (virtually) zero by now. */
+	memmove(key, &key[1], *key_size);
+
+	return key;
+
+out_err:
+	kfree_sensitive(key);
+	return ERR_PTR(err);
+}
+
 static int dh_safe_prime_set_secret(struct crypto_kpp *tfm, const void *buffer,
 				    unsigned int len)
 {
@@ -322,7 +445,7 @@ static int dh_safe_prime_set_secret(struct crypto_kpp *tfm, const void *buffer,
 		dh_safe_prime_instance_ctx(tfm);
 	struct dh_safe_prime_tfm_ctx *tfm_ctx = kpp_tfm_ctx(tfm);
 	struct dh params;
-	void *buf;
+	void *buf = NULL, *key = NULL;
 	unsigned int buf_size;
 	int err;
 
@@ -338,10 +461,20 @@ static int dh_safe_prime_set_secret(struct crypto_kpp *tfm, const void *buffer,
 	params.g = safe_prime_g;
 	params.g_size = sizeof(safe_prime_g);
 
+	if (!params.key_size) {
+		key = dh_safe_prime_gen_privkey(inst_ctx->safe_prime,
+						&params.key_size);
+		if (IS_ERR(key))
+			return PTR_ERR(key);
+		params.key = key;
+	}
+
 	buf_size = crypto_dh_key_len(&params);
 	buf = kmalloc(buf_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	if (!buf) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	err = crypto_dh_encode_key(buf, buf_size, &params);
 	if (err)
@@ -350,6 +483,7 @@ static int dh_safe_prime_set_secret(struct crypto_kpp *tfm, const void *buffer,
 	err = crypto_kpp_set_secret(tfm_ctx->dh_tfm, buf, buf_size);
 out:
 	kfree_sensitive(buf);
+	kfree_sensitive(key);
 	return err;
 }
 
-- 
2.26.2

