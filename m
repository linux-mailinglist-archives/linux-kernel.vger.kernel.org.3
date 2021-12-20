Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E743747A6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhLTJXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:23:40 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50962 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231840AbhLTJX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:23:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0V.B9zcJ_1639992203;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.B9zcJ_1639992203)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Dec 2021 17:23:24 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH 3/5] crypto: powerpc/sha - remove duplicate hash init function
Date:   Mon, 20 Dec 2021 17:23:16 +0800
Message-Id: <20211220092318.5793-4-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211220092318.5793-1-tianjia.zhang@linux.alibaba.com>
References: <20211220092318.5793-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sha*_base_init() series functions has implemented the initialization
of the hash context, this commit use sha*_base_init() function to
replace repeated implementations.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/powerpc/crypto/sha1-spe-glue.c   | 17 ++----------
 arch/powerpc/crypto/sha1.c            | 14 ++--------
 arch/powerpc/crypto/sha256-spe-glue.c | 39 +++------------------------
 3 files changed, 7 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/crypto/sha1-spe-glue.c b/arch/powerpc/crypto/sha1-spe-glue.c
index 88e8ea73bfa7..9170892a8557 100644
--- a/arch/powerpc/crypto/sha1-spe-glue.c
+++ b/arch/powerpc/crypto/sha1-spe-glue.c
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <crypto/sha1.h>
+#include <crypto/sha1_base.h>
 #include <asm/byteorder.h>
 #include <asm/switch_to.h>
 #include <linux/hardirq.h>
@@ -55,20 +56,6 @@ static inline void ppc_sha1_clear_context(struct sha1_state *sctx)
 	do { *ptr++ = 0; } while (--count);
 }
 
-static int ppc_spe_sha1_init(struct shash_desc *desc)
-{
-	struct sha1_state *sctx = shash_desc_ctx(desc);
-
-	sctx->state[0] = SHA1_H0;
-	sctx->state[1] = SHA1_H1;
-	sctx->state[2] = SHA1_H2;
-	sctx->state[3] = SHA1_H3;
-	sctx->state[4] = SHA1_H4;
-	sctx->count = 0;
-
-	return 0;
-}
-
 static int ppc_spe_sha1_update(struct shash_desc *desc, const u8 *data,
 			unsigned int len)
 {
@@ -168,7 +155,7 @@ static int ppc_spe_sha1_import(struct shash_desc *desc, const void *in)
 
 static struct shash_alg alg = {
 	.digestsize	=	SHA1_DIGEST_SIZE,
-	.init		=	ppc_spe_sha1_init,
+	.init		=	sha1_base_init,
 	.update		=	ppc_spe_sha1_update,
 	.final		=	ppc_spe_sha1_final,
 	.export		=	ppc_spe_sha1_export,
diff --git a/arch/powerpc/crypto/sha1.c b/arch/powerpc/crypto/sha1.c
index 7a55d790cdb1..f283bbd3f121 100644
--- a/arch/powerpc/crypto/sha1.c
+++ b/arch/powerpc/crypto/sha1.c
@@ -18,21 +18,11 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <crypto/sha1.h>
+#include <crypto/sha1_base.h>
 #include <asm/byteorder.h>
 
 void powerpc_sha_transform(u32 *state, const u8 *src);
 
-static int powerpc_sha1_init(struct shash_desc *desc)
-{
-	struct sha1_state *sctx = shash_desc_ctx(desc);
-
-	*sctx = (struct sha1_state){
-		.state = { SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4 },
-	};
-
-	return 0;
-}
-
 static int powerpc_sha1_update(struct shash_desc *desc, const u8 *data,
 			       unsigned int len)
 {
@@ -114,7 +104,7 @@ static int powerpc_sha1_import(struct shash_desc *desc, const void *in)
 
 static struct shash_alg alg = {
 	.digestsize	=	SHA1_DIGEST_SIZE,
-	.init		=	powerpc_sha1_init,
+	.init		=	sha1_base_init,
 	.update		=	powerpc_sha1_update,
 	.final		=	powerpc_sha1_final,
 	.export		=	powerpc_sha1_export,
diff --git a/arch/powerpc/crypto/sha256-spe-glue.c b/arch/powerpc/crypto/sha256-spe-glue.c
index ffedea7e4bef..2997d13236e0 100644
--- a/arch/powerpc/crypto/sha256-spe-glue.c
+++ b/arch/powerpc/crypto/sha256-spe-glue.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <crypto/sha2.h>
+#include <crypto/sha256_base.h>
 #include <asm/byteorder.h>
 #include <asm/switch_to.h>
 #include <linux/hardirq.h>
@@ -56,40 +57,6 @@ static inline void ppc_sha256_clear_context(struct sha256_state *sctx)
 	do { *ptr++ = 0; } while (--count);
 }
 
-static int ppc_spe_sha256_init(struct shash_desc *desc)
-{
-	struct sha256_state *sctx = shash_desc_ctx(desc);
-
-	sctx->state[0] = SHA256_H0;
-	sctx->state[1] = SHA256_H1;
-	sctx->state[2] = SHA256_H2;
-	sctx->state[3] = SHA256_H3;
-	sctx->state[4] = SHA256_H4;
-	sctx->state[5] = SHA256_H5;
-	sctx->state[6] = SHA256_H6;
-	sctx->state[7] = SHA256_H7;
-	sctx->count = 0;
-
-	return 0;
-}
-
-static int ppc_spe_sha224_init(struct shash_desc *desc)
-{
-	struct sha256_state *sctx = shash_desc_ctx(desc);
-
-	sctx->state[0] = SHA224_H0;
-	sctx->state[1] = SHA224_H1;
-	sctx->state[2] = SHA224_H2;
-	sctx->state[3] = SHA224_H3;
-	sctx->state[4] = SHA224_H4;
-	sctx->state[5] = SHA224_H5;
-	sctx->state[6] = SHA224_H6;
-	sctx->state[7] = SHA224_H7;
-	sctx->count = 0;
-
-	return 0;
-}
-
 static int ppc_spe_sha256_update(struct shash_desc *desc, const u8 *data,
 			unsigned int len)
 {
@@ -214,7 +181,7 @@ static int ppc_spe_sha256_import(struct shash_desc *desc, const void *in)
 
 static struct shash_alg algs[2] = { {
 	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	ppc_spe_sha256_init,
+	.init		=	sha256_base_init,
 	.update		=	ppc_spe_sha256_update,
 	.final		=	ppc_spe_sha256_final,
 	.export		=	ppc_spe_sha256_export,
@@ -230,7 +197,7 @@ static struct shash_alg algs[2] = { {
 	}
 }, {
 	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	ppc_spe_sha224_init,
+	.init		=	sha224_base_init,
 	.update		=	ppc_spe_sha256_update,
 	.final		=	ppc_spe_sha224_final,
 	.export		=	ppc_spe_sha256_export,
-- 
2.32.0

