Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC845B275C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 22:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiIHUBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 16:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIHUBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:01:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7429AFDBB0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 13:01:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u9so40632872ejy.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sJutgZaaiAEFjukCzpUU88LdDzS+7mpdY2oGsPu2RIw=;
        b=WlKbt61P0JnLjrYXm0NV2LSO+O/+44c/fMlAA3Gq8sLDp2cEmyk4U1e6HVkPEhU2d/
         rDiSjSe7XlVWRJnraphCAfx4VeQ8WqrqArleY6EmI97PXEBJ+1gd0nXSdCe3gC7lo1kr
         gxgzFlnBic1orYduxL7Vp29aeCJGU+byfg5XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sJutgZaaiAEFjukCzpUU88LdDzS+7mpdY2oGsPu2RIw=;
        b=xa3HR5qxNeqBwcMKC1hC5olrATxykMf+SdlUEH0jfJBkz6cFveWw65megp5Hii8Y4e
         NUv+KJrtfQuOwjFWUGtMSWVLR04OEByzz9sWn+0sRHKlA8xo6jpatpH3TRqvgUzCOMm6
         6uhdqu//ePnR7yy557LWEFAEUrc7a+r20ihSNlN96Wzr4c/LI6sU4c5+pz/MRwdE18Uz
         Ymkiay3u7/9uBg3TBWTxu4TcRQ4GUo9Nw1jHOK2Ipo7iNq0AMe/0IHjLf5X9Jah36HSL
         rppFbS2E59Vz7ZVOKmNwKu0NcVzSjp+rdeu4DTz6QfdhMqDluVq1zs64EATTJ+vlysXg
         2waQ==
X-Gm-Message-State: ACgBeo1ZggsE2nAmDmWFY4LVZjD+HvlWv4QmrWYj0ps5Zqp+b+FYtEJ4
        CN2S+fTfFZLMtNTmY243rY5mTA==
X-Google-Smtp-Source: AA6agR4e3C42fv8Hwedi+Z+6b2MIPRqgh8V0m7BnzlidOqqGXQOH4QIMebPmOzsvrqyoj2WU029C8w==
X-Received: by 2002:a17:907:1ca9:b0:741:4f9a:5984 with SMTP id nb41-20020a1709071ca900b007414f9a5984mr7414525ejc.86.1662667267813;
        Thu, 08 Sep 2022 13:01:07 -0700 (PDT)
Received: from localhost.localdomain ([104.28.243.158])
        by smtp.gmail.com with ESMTPSA id kx11-20020a170907774b00b00778e3e2830esm521202ejc.9.2022.09.08.13.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:01:07 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lei he <helei.sig11@bytedance.com>, kernel-team@cloudflare.com,
        Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH 1/4] crypto: add ECDSA signature generation support
Date:   Thu,  8 Sep 2022 21:00:33 +0100
Message-Id: <20220908200036.2034-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220908200036.2034-1-ignat@cloudflare.com>
References: <20220908200036.2034-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ECDSA signature generation support to reach feature parity with RSA
and make it possible later to use ECDSA via asymmetric key support in
keyctl.

This code implements deterministic ECDSA from RFC 6979[1]. This has the
following advantages:
  * we can more easily test the implementation with KAT test vectors
  * on platforms with bad/limited entropy generation capabilities the
    generated signatures would still be secure

Probably, the disadvantage is that ECDSA now depends on CRYPTO_DRBG, which
is mostly enabled anyway.

[1]: https://datatracker.ietf.org/doc/html/rfc6979

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 crypto/Kconfig                |   3 +-
 crypto/Makefile               |   4 +-
 crypto/ecc.c                  |   9 +-
 crypto/ecdsa.c                | 373 +++++++++++++++++++++++++++++++++-
 crypto/ecprivkey.asn1         |   6 +
 include/crypto/internal/ecc.h |  11 +
 6 files changed, 394 insertions(+), 12 deletions(-)
 create mode 100644 crypto/ecprivkey.asn1

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 40423a14f86f..ae2c9c48d751 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -285,14 +285,13 @@ config CRYPTO_ECDSA
 	tristate "ECDSA (Elliptic Curve Digital Signature Algorithm)"
 	select CRYPTO_ECC
 	select CRYPTO_AKCIPHER
+	select CRYPTO_DRBG_HMAC
 	select ASN1
 	help
 	  ECDSA (Elliptic Curve Digital Signature Algorithm) (FIPS 186,
 	  ISO/IEC 14888-3)
 	  using curves P-192, P-256, and P-384

-	  Only signature verification is implemented.
-
 config CRYPTO_ECRDSA
 	tristate "EC-RDSA (Elliptic Curve Russian Digital Signature Algorithm)"
 	select CRYPTO_ECC
diff --git a/crypto/Makefile b/crypto/Makefile
index a6f94e04e1da..3f7578790594 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -50,9 +50,11 @@ sm2_generic-y += sm2.o

 obj-$(CONFIG_CRYPTO_SM2) += sm2_generic.o

+$(obj)/ecprivkey.asn1.o: $(obj)/ecprivkey.asn1.c $(obj)/ecprivkey.asn1.h
 $(obj)/ecdsasignature.asn1.o: $(obj)/ecdsasignature.asn1.c $(obj)/ecdsasignature.asn1.h
-$(obj)/ecdsa.o: $(obj)/ecdsasignature.asn1.h
+$(obj)/ecdsa.o: $(obj)/ecdsasignature.asn1.h $(obj)/ecprivkey.asn1.h
 ecdsa_generic-y += ecdsa.o
+ecdsa_generic-y += ecprivkey.asn1.o
 ecdsa_generic-y += ecdsasignature.asn1.o
 obj-$(CONFIG_CRYPTO_ECDSA) += ecdsa_generic.o

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 7315217c8f73..e2a111e00eea 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -488,7 +488,7 @@ static void vli_square(u64 *result, const u64 *left, unsigned int ndigits)
 /* Computes result = (left + right) % mod.
  * Assumes that left < mod and right < mod, result != mod.
  */
-static void vli_mod_add(u64 *result, const u64 *left, const u64 *right,
+void vli_mod_add(u64 *result, const u64 *left, const u64 *right,
 			const u64 *mod, unsigned int ndigits)
 {
 	u64 carry;
@@ -501,6 +501,7 @@ static void vli_mod_add(u64 *result, const u64 *left, const u64 *right,
 	if (carry || vli_cmp(result, mod, ndigits) >= 0)
 		vli_sub(result, result, mod, ndigits);
 }
+EXPORT_SYMBOL(vli_mod_add);

 /* Computes result = (left - right) % mod.
  * Assumes that left < mod and right < mod, result != mod.
@@ -963,7 +964,7 @@ void vli_mod_mult_slow(u64 *result, const u64 *left, const u64 *right,
 EXPORT_SYMBOL(vli_mod_mult_slow);

 /* Computes result = (left * right) % curve_prime. */
-static void vli_mod_mult_fast(u64 *result, const u64 *left, const u64 *right,
+void vli_mod_mult_fast(u64 *result, const u64 *left, const u64 *right,
 			      const struct ecc_curve *curve)
 {
 	u64 product[2 * ECC_MAX_DIGITS];
@@ -971,6 +972,7 @@ static void vli_mod_mult_fast(u64 *result, const u64 *left, const u64 *right,
 	vli_mult(product, left, right, curve->g.ndigits);
 	vli_mmod_fast(result, product, curve);
 }
+EXPORT_SYMBOL(vli_mod_mult_fast);

 /* Computes result = left^2 % curve_prime. */
 static void vli_mod_square_fast(u64 *result, const u64 *left,
@@ -1277,7 +1279,7 @@ static void xycz_add_c(u64 *x1, u64 *y1, u64 *x2, u64 *y2,
 	vli_set(x1, t7, ndigits);
 }

-static void ecc_point_mult(struct ecc_point *result,
+void ecc_point_mult(struct ecc_point *result,
 			   const struct ecc_point *point, const u64 *scalar,
 			   u64 *initial_z, const struct ecc_curve *curve,
 			   unsigned int ndigits)
@@ -1335,6 +1337,7 @@ static void ecc_point_mult(struct ecc_point *result,
 	vli_set(result->x, rx[0], ndigits);
 	vli_set(result->y, ry[0], ndigits);
 }
+EXPORT_SYMBOL(ecc_point_mult);

 /* Computes R = P + Q mod p */
 static void ecc_point_add(const struct ecc_point *result,
diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index b3a8a6b572ba..e98409d8a408 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -8,16 +8,23 @@
 #include <crypto/internal/ecc.h>
 #include <crypto/akcipher.h>
 #include <crypto/ecdh.h>
-#include <linux/asn1_decoder.h>
+#include <crypto/rng.h>
+#include <crypto/drbg.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
 #include <linux/scatterlist.h>
+#include <linux/oid_registry.h>

+#include "ecprivkey.asn1.h"
 #include "ecdsasignature.asn1.h"

 struct ecc_ctx {
 	unsigned int curve_id;
 	const struct ecc_curve *curve;
+	bool key_set;
+	bool is_private;

-	bool pub_key_set;
+	u64 d[ECC_MAX_DIGITS]; /* priv key big integer */
 	u64 x[ECC_MAX_DIGITS]; /* pub key x and y coordinates */
 	u64 y[ECC_MAX_DIGITS];
 	struct ecc_point pub_key;
@@ -148,7 +155,7 @@ static int ecdsa_verify(struct akcipher_request *req)
 	ssize_t diff;
 	int ret;

-	if (unlikely(!ctx->pub_key_set))
+	if (unlikely(!ctx->key_set))
 		return -EINVAL;

 	buffer = kmalloc(req->src_len + req->dst_len, GFP_KERNEL);
@@ -185,6 +192,241 @@ static int ecdsa_verify(struct akcipher_request *req)
 	return ret;
 }

+static int _ecdsa_sign(struct ecc_ctx *ctx, const u64 *hash, const u64 *k,
+		       struct ecdsa_signature_ctx *sig_ctx)
+{
+	unsigned int ndigits = ctx->curve->g.ndigits;
+	u64 rd_h[ECC_MAX_DIGITS];
+	u64 kinv[ECC_MAX_DIGITS];
+	/* we can use s as y coordinate here as we're discarding it anyway later */
+	struct ecc_point K = ECC_POINT_INIT(sig_ctx->r, sig_ctx->s, ndigits);
+
+	ecc_point_mult(&K, &ctx->curve->g, k, NULL, ctx->curve, ndigits);
+
+	if (vli_cmp(sig_ctx->r, ctx->curve->n, ndigits) >= 0)
+		vli_sub(sig_ctx->r, sig_ctx->r, ctx->curve->n, ndigits);
+
+	if (vli_is_zero(sig_ctx->r, ndigits))
+		return -EAGAIN;
+
+	vli_mod_mult_slow(rd_h, sig_ctx->r, ctx->d, ctx->curve->n, ndigits);
+	vli_mod_add(rd_h, rd_h, hash, ctx->curve->n, ndigits);
+	vli_mod_inv(kinv, k, ctx->curve->n, ndigits);
+	vli_mod_mult_slow(sig_ctx->s, kinv, rd_h, ctx->curve->n, ndigits);
+
+	if (vli_is_zero(sig_ctx->s, ndigits))
+		return -EAGAIN;
+
+	memzero_explicit(rd_h, sizeof(rd_h));
+	memzero_explicit(kinv, sizeof(kinv));
+	return 0;
+}
+
+/* RFC 6979 p. 3.1.1 selects the same hash function that was used to
+ * process the input message. However, we don't have this information in
+ * the context and can only guess based on the size of the hash. This is
+ * OK, because p. 3.6 states that a different function may be used of the
+ * same (or higher) strength. Therefore, we pick SHA-512 as the default
+ * case. The only disadvantage would be that the KAT vectors from the RFC
+ * will not be verifiable. Userspace should not depend on it anyway as any
+ * higher priority ECDSA crypto drivers may actually not implement
+ * deterministic signatures
+ */
+static struct crypto_rng *rfc6979_alloc_rng(struct ecc_ctx *ctx,
+					    size_t hash_size, u8 *rawhash)
+{
+	u64 seed[2 * ECC_MAX_DIGITS];
+	unsigned int ndigits = ctx->curve->g.ndigits;
+	struct drbg_string entropy, pers = {0};
+	struct drbg_test_data seed_data;
+	const char *alg;
+	struct crypto_rng *rng;
+	int err;
+
+	switch (hash_size) {
+	case SHA1_DIGEST_SIZE:
+		alg = "drbg_nopr_hmac_sha1";
+		break;
+	case SHA256_DIGEST_SIZE:
+		alg = "drbg_nopr_hmac_sha256";
+		break;
+	case SHA384_DIGEST_SIZE:
+		alg = "drbg_nopr_hmac_sha384";
+		break;
+	default:
+		alg = "drbg_nopr_hmac_sha512";
+	}
+
+	rng = crypto_alloc_rng(alg, 0, 0);
+	if (IS_ERR(rng))
+		return rng;
+
+	ecc_swap_digits(ctx->d, seed, ndigits);
+	memcpy(seed + ndigits, rawhash, ndigits << ECC_DIGITS_TO_BYTES_SHIFT);
+	drbg_string_fill(&entropy, (u8 *)seed, (ndigits * 2) << ECC_DIGITS_TO_BYTES_SHIFT);
+	seed_data.testentropy = &entropy;
+	err = crypto_drbg_reset_test(rng, &pers, &seed_data);
+	if (err) {
+		crypto_free_rng(rng);
+		return ERR_PTR(err);
+	}
+
+	return rng;
+}
+
+static int rfc6979_gen_k(struct ecc_ctx *ctx, struct crypto_rng *rng, u64 *k)
+{
+	unsigned int ndigits = ctx->curve->g.ndigits;
+	u8 K[ECC_MAX_BYTES];
+	int ret;
+
+	do {
+		ret = crypto_rng_get_bytes(rng, K, ndigits << ECC_DIGITS_TO_BYTES_SHIFT);
+		if (ret)
+			return ret;
+
+		ecc_swap_digits((u64 *)K, k, ndigits);
+	} while (vli_cmp(k, ctx->curve->n, ndigits) >= 0);
+
+	memzero_explicit(K, sizeof(K));
+	return 0;
+}
+
+/* scratch buffer should be at least ECC_MAX_BYTES */
+static int asn1_encode_signature_sg(struct akcipher_request *req,
+				    struct ecdsa_signature_ctx *sig_ctx,
+				    u8 *scratch)
+{
+	unsigned int ndigits = sig_ctx->curve->g.ndigits;
+	unsigned int r_bits = vli_num_bits(sig_ctx->r, ndigits);
+	unsigned int s_bits = vli_num_bits(sig_ctx->s, ndigits);
+	struct sg_mapping_iter miter;
+	unsigned int nents;
+	u8 *buf, *p;
+	size_t needed = 2; /* tag and len for the top ASN1 sequence */
+
+	needed += 2; /* tag and len for r as an ASN1 integer */
+	needed += BITS_TO_BYTES(r_bits);
+	if (r_bits % 8 == 0)
+		/* leftmost bit is set, so need another byte for 0x00 to make the
+		 * integer positive
+		 */
+		needed++;
+
+	needed += 2; /* tag and len for s as an ASN1 integer */
+	needed += BITS_TO_BYTES(s_bits);
+	if (s_bits % 8 == 0)
+		/* leftmost bit is set, so need another byte for 0x00 to make the
+		 * integer positive
+		 */
+		needed++;
+
+	if (req->dst_len < needed) {
+		req->dst_len = needed;
+		return -EOVERFLOW;
+	}
+
+	nents = sg_nents_for_len(req->dst, needed);
+	if (nents == 1) {
+		sg_miter_start(&miter, req->dst, nents, SG_MITER_ATOMIC | SG_MITER_TO_SG);
+		sg_miter_next(&miter);
+		buf = miter.addr;
+	} else {
+		buf = kmalloc(needed, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+	}
+
+	/* we will begin from the end */
+	ecc_swap_digits(sig_ctx->s, (u64 *)scratch, ndigits);
+	p = buf + needed - BITS_TO_BYTES(s_bits);
+	memcpy(p, scratch +
+	       (ndigits << ECC_DIGITS_TO_BYTES_SHIFT) - BITS_TO_BYTES(s_bits),
+	       BITS_TO_BYTES(s_bits));
+	if (s_bits % 8 == 0) {
+		p--;
+		*p = 0;
+	}
+	p -= 2;
+	p[0] = ASN1_INT;
+	p[1] = (s_bits % 8 == 0) ? BITS_TO_BYTES(s_bits) + 1 : BITS_TO_BYTES(s_bits);
+
+	ecc_swap_digits(sig_ctx->r, (u64 *)scratch, ndigits);
+	p -= BITS_TO_BYTES(r_bits);
+	memcpy(p, scratch +
+	       (ndigits << ECC_DIGITS_TO_BYTES_SHIFT) - BITS_TO_BYTES(r_bits),
+	       BITS_TO_BYTES(r_bits));
+	if (r_bits % 8 == 0) {
+		p--;
+		*p = 0;
+	}
+	p -= 2;
+	p[0] = ASN1_INT;
+	p[1] = (r_bits % 8 == 0) ? BITS_TO_BYTES(r_bits) + 1 : BITS_TO_BYTES(r_bits);
+
+	buf[0] = ASN1_CONS_BIT | ASN1_SEQ;
+	buf[1] = (needed - 2) & 0xff;
+
+	if (nents == 1)
+		sg_miter_stop(&miter);
+	else {
+		sg_copy_from_buffer(req->dst, nents, buf, needed);
+		kfree(buf);
+	}
+	req->dst_len = needed;
+
+	return 0;
+}
+
+static int ecdsa_sign(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	size_t keylen = ctx->curve->g.ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+	u8 rawhash_k[ECC_MAX_BYTES];
+	u64 hash[ECC_MAX_DIGITS];
+	struct ecdsa_signature_ctx sig_ctx = {
+		.curve = ctx->curve,
+	};
+	struct crypto_rng *rng;
+	ssize_t diff;
+	int ret;
+
+	/* if the hash is shorter then we will add leading zeros to fit to ndigits */
+	diff = keylen - req->src_len;
+	if (diff >= 0) {
+		if (diff)
+			memset(rawhash_k, 0, diff);
+		sg_copy_to_buffer(req->src, sg_nents_for_len(req->src, req->src_len),
+				  &rawhash_k[diff], req->src_len);
+	} else if (diff < 0) {
+		/* given hash is longer, we take the left-most bytes */
+		sg_copy_to_buffer(req->src, sg_nents_for_len(req->src, req->src_len),
+				  rawhash_k, req->src_len);
+	}
+
+	ecc_swap_digits((u64 *)rawhash_k, hash, ctx->curve->g.ndigits);
+
+	rng = rfc6979_alloc_rng(ctx, req->src_len, rawhash_k);
+	if (IS_ERR(rng))
+		return PTR_ERR(rng);
+
+	do {
+		ret = rfc6979_gen_k(ctx, rng, (u64 *)rawhash_k);
+		if (ret)
+			goto alloc_rng;
+
+		ret = _ecdsa_sign(ctx, hash, (u64 *)rawhash_k, &sig_ctx);
+	} while (ret == -EAGAIN);
+	memzero_explicit(rawhash_k, sizeof(rawhash_k));
+
+	ret = asn1_encode_signature_sg(req, &sig_ctx, rawhash_k);
+
+alloc_rng:
+	crypto_free_rng(rng);
+	return ret;
+}
+
 static int ecdsa_ecc_ctx_init(struct ecc_ctx *ctx, unsigned int curve_id)
 {
 	ctx->curve_id = curve_id;
@@ -198,7 +440,9 @@ static int ecdsa_ecc_ctx_init(struct ecc_ctx *ctx, unsigned int curve_id)

 static void ecdsa_ecc_ctx_deinit(struct ecc_ctx *ctx)
 {
-	ctx->pub_key_set = false;
+	ctx->key_set = false;
+	if (ctx->is_private)
+		memzero_explicit(ctx->d, sizeof(ctx->d));
 }

 static int ecdsa_ecc_ctx_reset(struct ecc_ctx *ctx)
@@ -246,7 +490,103 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
 	ecc_swap_digits(&digits[ndigits], ctx->pub_key.y, ndigits);
 	ret = ecc_is_pubkey_valid_full(ctx->curve, &ctx->pub_key);

-	ctx->pub_key_set = ret == 0;
+	ctx->key_set = ret == 0;
+	ctx->is_private = false;
+
+	return ret;
+}
+
+int ecc_get_priv_key(void *context, size_t hdrlen, unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct ecc_ctx *ctx = context;
+	size_t dlen = ctx->curve->g.ndigits * sizeof(u64);
+	ssize_t diff = vlen - dlen;
+	const char *d = value;
+	u8 priv[ECC_MAX_BYTES];
+
+	/* diff = 0: 'value' has exacly the right size
+	 * diff > 0: 'value' has too many bytes; one leading zero is allowed that
+	 *           makes the value a positive integer; error on more
+	 * diff < 0: 'value' is missing leading zeros, which we add
+	 */
+	if (diff > 0) {
+		/* skip over leading zeros that make 'value' a positive int */
+		if (*d == 0) {
+			vlen -= 1;
+			diff--;
+			d++;
+		}
+		if (diff)
+			return -EINVAL;
+	}
+	if (-diff >= dlen)
+		return -EINVAL;
+
+	if (diff) {
+		/* leading zeros not given in 'value' */
+		memset(priv, 0, -diff);
+	}
+
+	memcpy(&priv[-diff], d, vlen);
+
+	ecc_swap_digits((u64 *)priv, ctx->d, ctx->curve->g.ndigits);
+	memzero_explicit(priv, sizeof(priv));
+	return ecc_is_key_valid(ctx->curve_id, ctx->curve->g.ndigits, ctx->d, dlen);
+}
+
+int ecc_get_priv_params(void *context, size_t hdrlen, unsigned char tag,
+			const void *value, size_t vlen)
+{
+	struct ecc_ctx *ctx = context;
+
+	switch (look_up_OID(value, vlen)) {
+	case OID_id_prime192v1:
+		return (ctx->curve_id == ECC_CURVE_NIST_P192) ? 0 : -EINVAL;
+	case OID_id_prime256v1:
+		return (ctx->curve_id == ECC_CURVE_NIST_P256) ? 0 : -EINVAL;
+	case OID_id_ansip384r1:
+		return (ctx->curve_id == ECC_CURVE_NIST_P384) ? 0 : -EINVAL;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+int ecc_get_priv_version(void *context, size_t hdrlen, unsigned char tag,
+			 const void *value, size_t vlen)
+{
+	if (vlen == 1) {
+		if (*((u8 *)value) == 1)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ecdsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
+			      unsigned int keylen)
+{
+	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	int ret;
+
+	ret = ecdsa_ecc_ctx_reset(ctx);
+	if (ret < 0)
+		return ret;
+
+	ret = asn1_ber_decoder(&ecprivkey_decoder, ctx, key, keylen);
+	if (ret)
+		return ret;
+
+	ecc_point_mult(&ctx->pub_key, &ctx->curve->g, ctx->d, NULL, ctx->curve,
+		       ctx->curve->g.ndigits);
+	ret = ecc_is_pubkey_valid_full(ctx->curve, &ctx->pub_key);
+	if (ret)
+		return ret;
+
+	ctx->key_set = ret == 0;
+	ctx->is_private = true;

 	return ret;
 }
@@ -262,7 +602,22 @@ static unsigned int ecdsa_max_size(struct crypto_akcipher *tfm)
 {
 	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);

-	return ctx->pub_key.ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+	if (!ctx->key_set)
+		return 0;
+
+	if (ctx->is_private) {
+		/* see ecdsasignature.asn1
+		 * for a max 384 bit curve we would only need 1 byte length
+		 * ASN1 encoding for the top level sequence and r,s integers
+		 * 1 byte sequence tag + 1 byte sequence length (max 102 for 384
+		 * bit curve) + 2 (for r and s) * (1 byte integer tag + 1 byte
+		 * integer length (max 49 for 384 bit curve) + 1 zero byte (if r
+		 * or s has leftmost bit set) + sizeof(r or s)
+		 */
+		return 2 + 2 * (3 + (ctx->curve->g.ndigits << ECC_DIGITS_TO_BYTES_SHIFT));
+	}
+
+	return ctx->curve->g.ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 }

 static int ecdsa_nist_p384_init_tfm(struct crypto_akcipher *tfm)
@@ -273,7 +628,9 @@ static int ecdsa_nist_p384_init_tfm(struct crypto_akcipher *tfm)
 }

 static struct akcipher_alg ecdsa_nist_p384 = {
+	.sign = ecdsa_sign,
 	.verify = ecdsa_verify,
+	.set_priv_key = ecdsa_set_priv_key,
 	.set_pub_key = ecdsa_set_pub_key,
 	.max_size = ecdsa_max_size,
 	.init = ecdsa_nist_p384_init_tfm,
@@ -295,7 +652,9 @@ static int ecdsa_nist_p256_init_tfm(struct crypto_akcipher *tfm)
 }

 static struct akcipher_alg ecdsa_nist_p256 = {
+	.sign = ecdsa_sign,
 	.verify = ecdsa_verify,
+	.set_priv_key = ecdsa_set_priv_key,
 	.set_pub_key = ecdsa_set_pub_key,
 	.max_size = ecdsa_max_size,
 	.init = ecdsa_nist_p256_init_tfm,
@@ -317,7 +676,9 @@ static int ecdsa_nist_p192_init_tfm(struct crypto_akcipher *tfm)
 }

 static struct akcipher_alg ecdsa_nist_p192 = {
+	.sign = ecdsa_sign,
 	.verify = ecdsa_verify,
+	.set_priv_key = ecdsa_set_priv_key,
 	.set_pub_key = ecdsa_set_pub_key,
 	.max_size = ecdsa_max_size,
 	.init = ecdsa_nist_p192_init_tfm,
diff --git a/crypto/ecprivkey.asn1 b/crypto/ecprivkey.asn1
new file mode 100644
index 000000000000..92e7d7d0703c
--- /dev/null
+++ b/crypto/ecprivkey.asn1
@@ -0,0 +1,6 @@
+ECPrivateKey ::= SEQUENCE {
+	version	INTEGER ({ ecc_get_priv_version }),
+	privateKey	OCTET STRING ({ ecc_get_priv_key }),
+	parameters	[0] OBJECT IDENTIFIER OPTIONAL ({ ecc_get_priv_params }),
+	publicKey	[1] BIT STRING OPTIONAL
+}
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 4f6c1a68882f..be03a48302e5 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -182,6 +182,9 @@ int vli_cmp(const u64 *left, const u64 *right, unsigned int ndigits);
 u64 vli_sub(u64 *result, const u64 *left, const u64 *right,
 	    unsigned int ndigits);

+void vli_mod_add(u64 *result, const u64 *left, const u64 *right,
+			const u64 *mod, unsigned int ndigits);
+
 /**
  * vli_from_be64() - Load vli from big-endian u64 array
  *
@@ -225,6 +228,9 @@ void vli_mod_inv(u64 *result, const u64 *input, const u64 *mod,
 void vli_mod_mult_slow(u64 *result, const u64 *left, const u64 *right,
 		       const u64 *mod, unsigned int ndigits);

+void vli_mod_mult_fast(u64 *result, const u64 *left, const u64 *right,
+			      const struct ecc_curve *curve);
+
 /**
  * vli_num_bits() - Counts the number of bits required for vli.
  *
@@ -260,6 +266,11 @@ void ecc_free_point(struct ecc_point *p);
  */
 bool ecc_point_is_zero(const struct ecc_point *point);

+void ecc_point_mult(struct ecc_point *result,
+			   const struct ecc_point *point, const u64 *scalar,
+			   u64 *initial_z, const struct ecc_curve *curve,
+			   unsigned int ndigits);
+
 /**
  * ecc_point_mult_shamir() - Add two points multiplied by scalars
  *
--
2.36.1

