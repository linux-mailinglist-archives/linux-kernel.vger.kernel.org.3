Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD384FB233
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiDKDPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241552AbiDKDPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:15:34 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBA72F3AE;
        Sun, 10 Apr 2022 20:13:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V9ggjyY_1649646797;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V9ggjyY_1649646797)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Apr 2022 11:13:18 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] crypto: arm64/sm4 - Fix wrong dependency of NEON/CE implementation
Date:   Mon, 11 Apr 2022 11:13:13 +0800
Message-Id: <20220411031313.35449-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d2825fa9365d ("crypto: sm3,sm4 - move into crypto directory")
moved the sm4 library implementation from the lib/crypto directory to
the crypto directory and configured the name as CRYPTO_SM4. The arm64
SM4 NEON/CE implementation depends on this and needs to be modified
uniformly.

Fixes: 4f1aef9b806f ("crypto: arm64/sm4 - add ARMv8 NEON implementation")
Fixes: 5b33e0ec881c ("crypto: arm64/sm4 - add ARMv8 Crypto Extensions implementation")
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 4fe7037d2347..ac85682c013c 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -57,13 +57,13 @@ config CRYPTO_SM4_ARM64_CE_BLK
 	tristate "SM4 in ECB/CBC/CFB/CTR modes using ARMv8 Crypto Extensions"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_SM4
+	select CRYPTO_SM4
 
 config CRYPTO_SM4_ARM64_NEON_BLK
 	tristate "SM4 in ECB/CBC/CFB/CTR modes using NEON instructions"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_SM4
+	select CRYPTO_SM4
 
 config CRYPTO_GHASH_ARM64_CE
 	tristate "GHASH/AES-GCM using ARMv8 Crypto Extensions"
-- 
2.24.3 (Apple Git-128)

