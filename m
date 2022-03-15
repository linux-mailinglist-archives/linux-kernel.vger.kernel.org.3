Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F91F4D97F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346777AbiCOJq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbiCOJqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:46:16 -0400
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256F24E3A5;
        Tue, 15 Mar 2022 02:45:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V7HS1wM_1647337498;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V7HS1wM_1647337498)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Mar 2022 17:44:59 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Markku-Juhani O . Saarinen" <mjos@iki.fi>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>, zhuolong.lq@antfin.com
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH 1/4] crypto: lib/sm4 - export sm4 constant arrays
Date:   Tue, 15 Mar 2022 17:44:51 +0800
Message-Id: <20220315094454.45269-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220315094454.45269-1-tianjia.zhang@linux.alibaba.com>
References: <20220315094454.45269-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the constant arrays fk, ck, sbox of the SM4 algorithm, and
add the 'crypto_sm4_' prefix, where sbox is used in the SM4 NEON
implementation for the tbl/tbx instruction to replace the S-BOX,
and the fk, ck arrays are used in the SM4 CE implementation. Use
the sm4ekey instruction to speed up key expansion operations.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 include/crypto/sm4.h |  4 ++++
 lib/crypto/sm4.c     | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/crypto/sm4.h b/include/crypto/sm4.h
index 709f286e7b25..9656a9a40326 100644
--- a/include/crypto/sm4.h
+++ b/include/crypto/sm4.h
@@ -21,6 +21,10 @@ struct sm4_ctx {
 	u32 rkey_dec[SM4_RKEY_WORDS];
 };
 
+extern const u32 crypto_sm4_fk[];
+extern const u32 crypto_sm4_ck[];
+extern const u8 crypto_sm4_sbox[];
+
 /**
  * sm4_expandkey - Expands the SM4 key as described in GB/T 32907-2016
  * @ctx:	The location where the computed key will be stored.
diff --git a/lib/crypto/sm4.c b/lib/crypto/sm4.c
index 284e62576d0c..2c44193bc27e 100644
--- a/lib/crypto/sm4.c
+++ b/lib/crypto/sm4.c
@@ -11,7 +11,7 @@
 #include <asm/unaligned.h>
 #include <crypto/sm4.h>
 
-static const u32 fk[4] = {
+static const u32 ____cacheline_aligned fk[4] = {
 	0xa3b1bac6, 0x56aa3350, 0x677d9197, 0xb27022dc
 };
 
@@ -61,6 +61,14 @@ static const u8 ____cacheline_aligned sbox[256] = {
 	0x79, 0xee, 0x5f, 0x3e, 0xd7, 0xcb, 0x39, 0x48
 };
 
+extern const u32 crypto_sm4_fk[4] __alias(fk);
+extern const u32 crypto_sm4_ck[32] __alias(ck);
+extern const u8 crypto_sm4_sbox[256] __alias(sbox);
+
+EXPORT_SYMBOL(crypto_sm4_fk);
+EXPORT_SYMBOL(crypto_sm4_ck);
+EXPORT_SYMBOL(crypto_sm4_sbox);
+
 static inline u32 sm4_t_non_lin_sub(u32 x)
 {
 	u32 out;
-- 
2.24.3 (Apple Git-128)

