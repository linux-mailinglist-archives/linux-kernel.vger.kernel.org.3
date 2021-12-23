Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A761247DE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 05:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346396AbhLWEgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 23:36:03 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:60087 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346356AbhLWEf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 23:35:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V.TzZlD_1640234152;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.TzZlD_1640234152)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 12:35:53 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v3 3/6] crypto: sm2 - make dependent on sm3 library
Date:   Thu, 23 Dec 2021 12:35:44 +0800
Message-Id: <20211223043547.32297-4-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211223043547.32297-1-tianjia.zhang@linux.alibaba.com>
References: <20211223043547.32297-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM3 generic library is stand-alone implementation, it is necessary
for the calculation of sm2 z digest to depends on SM3 library
instead of sm3-generic.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/Kconfig |  2 +-
 crypto/sm2.c   | 38 +++++++++++++++++++-------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 01b9ca0836a5..60b252975dc4 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -267,7 +267,7 @@ config CRYPTO_ECRDSA
 
 config CRYPTO_SM2
 	tristate "SM2 algorithm"
-	select CRYPTO_SM3
+	select CRYPTO_LIB_SM3
 	select CRYPTO_AKCIPHER
 	select CRYPTO_MANAGER
 	select MPILIB
diff --git a/crypto/sm2.c b/crypto/sm2.c
index db8a4a265669..ae3f77a66070 100644
--- a/crypto/sm2.c
+++ b/crypto/sm2.c
@@ -13,7 +13,7 @@
 #include <crypto/internal/akcipher.h>
 #include <crypto/akcipher.h>
 #include <crypto/hash.h>
-#include <crypto/sm3_base.h>
+#include <crypto/sm3.h>
 #include <crypto/rng.h>
 #include <crypto/sm2.h>
 #include "sm2signature.asn1.h"
@@ -213,7 +213,7 @@ int sm2_get_signature_s(void *context, size_t hdrlen, unsigned char tag,
 	return 0;
 }
 
-static int sm2_z_digest_update(struct shash_desc *desc,
+static int sm2_z_digest_update(struct sm3_state *sctx,
 			MPI m, unsigned int pbytes)
 {
 	static const unsigned char zero[32];
@@ -226,20 +226,20 @@ static int sm2_z_digest_update(struct shash_desc *desc,
 
 	if (inlen < pbytes) {
 		/* padding with zero */
-		crypto_sm3_update(desc, zero, pbytes - inlen);
-		crypto_sm3_update(desc, in, inlen);
+		sm3_update(sctx, zero, pbytes - inlen);
+		sm3_update(sctx, in, inlen);
 	} else if (inlen > pbytes) {
 		/* skip the starting zero */
-		crypto_sm3_update(desc, in + inlen - pbytes, pbytes);
+		sm3_update(sctx, in + inlen - pbytes, pbytes);
 	} else {
-		crypto_sm3_update(desc, in, inlen);
+		sm3_update(sctx, in, inlen);
 	}
 
 	kfree(in);
 	return 0;
 }
 
-static int sm2_z_digest_update_point(struct shash_desc *desc,
+static int sm2_z_digest_update_point(struct sm3_state *sctx,
 		MPI_POINT point, struct mpi_ec_ctx *ec, unsigned int pbytes)
 {
 	MPI x, y;
@@ -249,8 +249,8 @@ static int sm2_z_digest_update_point(struct shash_desc *desc,
 	y = mpi_new(0);
 
 	if (!mpi_ec_get_affine(x, y, point, ec) &&
-		!sm2_z_digest_update(desc, x, pbytes) &&
-		!sm2_z_digest_update(desc, y, pbytes))
+	    !sm2_z_digest_update(sctx, x, pbytes) &&
+	    !sm2_z_digest_update(sctx, y, pbytes))
 		ret = 0;
 
 	mpi_free(x);
@@ -265,7 +265,7 @@ int sm2_compute_z_digest(struct crypto_akcipher *tfm,
 	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
 	uint16_t bits_len;
 	unsigned char entl[2];
-	SHASH_DESC_ON_STACK(desc, NULL);
+	struct sm3_state sctx;
 	unsigned int pbytes;
 
 	if (id_len > (USHRT_MAX / 8) || !ec->Q)
@@ -278,17 +278,17 @@ int sm2_compute_z_digest(struct crypto_akcipher *tfm,
 	pbytes = MPI_NBYTES(ec->p);
 
 	/* ZA = H256(ENTLA | IDA | a | b | xG | yG | xA | yA) */
-	sm3_base_init(desc);
-	crypto_sm3_update(desc, entl, 2);
-	crypto_sm3_update(desc, id, id_len);
-
-	if (sm2_z_digest_update(desc, ec->a, pbytes) ||
-		sm2_z_digest_update(desc, ec->b, pbytes) ||
-		sm2_z_digest_update_point(desc, ec->G, ec, pbytes) ||
-		sm2_z_digest_update_point(desc, ec->Q, ec, pbytes))
+	sm3_init(&sctx);
+	sm3_update(&sctx, entl, 2);
+	sm3_update(&sctx, id, id_len);
+
+	if (sm2_z_digest_update(&sctx, ec->a, pbytes) ||
+	    sm2_z_digest_update(&sctx, ec->b, pbytes) ||
+	    sm2_z_digest_update_point(&sctx, ec->G, ec, pbytes) ||
+	    sm2_z_digest_update_point(&sctx, ec->Q, ec, pbytes))
 		return -EINVAL;
 
-	crypto_sm3_final(desc, dgst);
+	sm3_final(&sctx, dgst);
 	return 0;
 }
 EXPORT_SYMBOL(sm2_compute_z_digest);
-- 
2.32.0

