Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6992E47A6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhLTJXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:23:43 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41010 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231962AbhLTJXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:23:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0V.CdykD_1639992205;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.CdykD_1639992205)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Dec 2021 17:23:25 +0800
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
Subject: [PATCH 4/5] crypto: sparc/sha - remove duplicate hash init function
Date:   Mon, 20 Dec 2021 17:23:17 +0800
Message-Id: <20211220092318.5793-5-tianjia.zhang@linux.alibaba.com>
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
 arch/sparc/crypto/sha1_glue.c   | 14 ++-----------
 arch/sparc/crypto/sha256_glue.c | 37 +++------------------------------
 arch/sparc/crypto/sha512_glue.c | 37 +++------------------------------
 3 files changed, 8 insertions(+), 80 deletions(-)

diff --git a/arch/sparc/crypto/sha1_glue.c b/arch/sparc/crypto/sha1_glue.c
index 86a654cce5ab..06b7becfcb21 100644
--- a/arch/sparc/crypto/sha1_glue.c
+++ b/arch/sparc/crypto/sha1_glue.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <crypto/sha1.h>
+#include <crypto/sha1_base.h>
 
 #include <asm/pstate.h>
 #include <asm/elf.h>
@@ -26,17 +27,6 @@
 asmlinkage void sha1_sparc64_transform(u32 *digest, const char *data,
 				       unsigned int rounds);
 
-static int sha1_sparc64_init(struct shash_desc *desc)
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
 static void __sha1_sparc64_update(struct sha1_state *sctx, const u8 *data,
 				  unsigned int len, unsigned int partial)
 {
@@ -128,7 +118,7 @@ static int sha1_sparc64_import(struct shash_desc *desc, const void *in)
 
 static struct shash_alg alg = {
 	.digestsize	=	SHA1_DIGEST_SIZE,
-	.init		=	sha1_sparc64_init,
+	.init		=	sha1_base_init,
 	.update		=	sha1_sparc64_update,
 	.final		=	sha1_sparc64_final,
 	.export		=	sha1_sparc64_export,
diff --git a/arch/sparc/crypto/sha256_glue.c b/arch/sparc/crypto/sha256_glue.c
index 60ec524cf9ca..285561a1cde5 100644
--- a/arch/sparc/crypto/sha256_glue.c
+++ b/arch/sparc/crypto/sha256_glue.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <crypto/sha2.h>
+#include <crypto/sha256_base.h>
 
 #include <asm/pstate.h>
 #include <asm/elf.h>
@@ -26,38 +27,6 @@
 asmlinkage void sha256_sparc64_transform(u32 *digest, const char *data,
 					 unsigned int rounds);
 
-static int sha224_sparc64_init(struct shash_desc *desc)
-{
-	struct sha256_state *sctx = shash_desc_ctx(desc);
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
-static int sha256_sparc64_init(struct shash_desc *desc)
-{
-	struct sha256_state *sctx = shash_desc_ctx(desc);
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
 static void __sha256_sparc64_update(struct sha256_state *sctx, const u8 *data,
 				    unsigned int len, unsigned int partial)
 {
@@ -158,7 +127,7 @@ static int sha256_sparc64_import(struct shash_desc *desc, const void *in)
 
 static struct shash_alg sha256_alg = {
 	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	sha256_sparc64_init,
+	.init		=	sha256_base_init,
 	.update		=	sha256_sparc64_update,
 	.final		=	sha256_sparc64_final,
 	.export		=	sha256_sparc64_export,
@@ -176,7 +145,7 @@ static struct shash_alg sha256_alg = {
 
 static struct shash_alg sha224_alg = {
 	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	sha224_sparc64_init,
+	.init		=	sha224_base_init,
 	.update		=	sha256_sparc64_update,
 	.final		=	sha224_sparc64_final,
 	.descsize	=	sizeof(struct sha256_state),
diff --git a/arch/sparc/crypto/sha512_glue.c b/arch/sparc/crypto/sha512_glue.c
index 273ce21918c1..d66efa4ec59a 100644
--- a/arch/sparc/crypto/sha512_glue.c
+++ b/arch/sparc/crypto/sha512_glue.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <crypto/sha2.h>
+#include <crypto/sha512_base.h>
 
 #include <asm/pstate.h>
 #include <asm/elf.h>
@@ -25,38 +26,6 @@
 asmlinkage void sha512_sparc64_transform(u64 *digest, const char *data,
 					 unsigned int rounds);
 
-static int sha512_sparc64_init(struct shash_desc *desc)
-{
-	struct sha512_state *sctx = shash_desc_ctx(desc);
-	sctx->state[0] = SHA512_H0;
-	sctx->state[1] = SHA512_H1;
-	sctx->state[2] = SHA512_H2;
-	sctx->state[3] = SHA512_H3;
-	sctx->state[4] = SHA512_H4;
-	sctx->state[5] = SHA512_H5;
-	sctx->state[6] = SHA512_H6;
-	sctx->state[7] = SHA512_H7;
-	sctx->count[0] = sctx->count[1] = 0;
-
-	return 0;
-}
-
-static int sha384_sparc64_init(struct shash_desc *desc)
-{
-	struct sha512_state *sctx = shash_desc_ctx(desc);
-	sctx->state[0] = SHA384_H0;
-	sctx->state[1] = SHA384_H1;
-	sctx->state[2] = SHA384_H2;
-	sctx->state[3] = SHA384_H3;
-	sctx->state[4] = SHA384_H4;
-	sctx->state[5] = SHA384_H5;
-	sctx->state[6] = SHA384_H6;
-	sctx->state[7] = SHA384_H7;
-	sctx->count[0] = sctx->count[1] = 0;
-
-	return 0;
-}
-
 static void __sha512_sparc64_update(struct sha512_state *sctx, const u8 *data,
 				    unsigned int len, unsigned int partial)
 {
@@ -146,7 +115,7 @@ static int sha384_sparc64_final(struct shash_desc *desc, u8 *hash)
 
 static struct shash_alg sha512 = {
 	.digestsize	=	SHA512_DIGEST_SIZE,
-	.init		=	sha512_sparc64_init,
+	.init		=	sha512_base_init,
 	.update		=	sha512_sparc64_update,
 	.final		=	sha512_sparc64_final,
 	.descsize	=	sizeof(struct sha512_state),
@@ -161,7 +130,7 @@ static struct shash_alg sha512 = {
 
 static struct shash_alg sha384 = {
 	.digestsize	=	SHA384_DIGEST_SIZE,
-	.init		=	sha384_sparc64_init,
+	.init		=	sha384_base_init,
 	.update		=	sha512_sparc64_update,
 	.final		=	sha384_sparc64_final,
 	.descsize	=	sizeof(struct sha512_state),
-- 
2.32.0

