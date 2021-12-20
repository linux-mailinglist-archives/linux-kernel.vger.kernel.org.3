Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B847A6DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhLTJXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:23:33 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:33963 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231989AbhLTJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:23:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0V.CdyjU_1639992201;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.CdyjU_1639992201)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Dec 2021 17:23:21 +0800
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
Subject: [PATCH 1/5] crypto: sha256 - remove duplicate generic hash init function
Date:   Mon, 20 Dec 2021 17:23:14 +0800
Message-Id: <20211220092318.5793-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211220092318.5793-1-tianjia.zhang@linux.alibaba.com>
References: <20211220092318.5793-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto_sha256_init() and sha256_base_init() are the same repeated
implementations, remove the crypto_sha256_init() in generic
implementation, sha224 is the same process.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/sha256_generic.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/crypto/sha256_generic.c b/crypto/sha256_generic.c
index 3b377197236e..bf147b01e313 100644
--- a/crypto/sha256_generic.c
+++ b/crypto/sha256_generic.c
@@ -33,18 +33,6 @@ const u8 sha256_zero_message_hash[SHA256_DIGEST_SIZE] = {
 };
 EXPORT_SYMBOL_GPL(sha256_zero_message_hash);
 
-static int crypto_sha256_init(struct shash_desc *desc)
-{
-	sha256_init(shash_desc_ctx(desc));
-	return 0;
-}
-
-static int crypto_sha224_init(struct shash_desc *desc)
-{
-	sha224_init(shash_desc_ctx(desc));
-	return 0;
-}
-
 int crypto_sha256_update(struct shash_desc *desc, const u8 *data,
 			  unsigned int len)
 {
@@ -72,7 +60,7 @@ EXPORT_SYMBOL(crypto_sha256_finup);
 
 static struct shash_alg sha256_algs[2] = { {
 	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	crypto_sha256_init,
+	.init		=	sha256_base_init,
 	.update		=	crypto_sha256_update,
 	.final		=	crypto_sha256_final,
 	.finup		=	crypto_sha256_finup,
@@ -86,7 +74,7 @@ static struct shash_alg sha256_algs[2] = { {
 	}
 }, {
 	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	crypto_sha224_init,
+	.init		=	sha224_base_init,
 	.update		=	crypto_sha256_update,
 	.final		=	crypto_sha256_final,
 	.finup		=	crypto_sha256_finup,
-- 
2.32.0

