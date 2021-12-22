Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6447CC4E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 05:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbhLVEue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 23:50:34 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:41055 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235801AbhLVEua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 23:50:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V.OXu.4_1640148626;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.OXu.4_1640148626)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 12:50:26 +0800
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
Subject: [PATCH v2 2/6] crypto: arm64/sm3-ce - make dependent on sm3 library
Date:   Wed, 22 Dec 2021 12:50:18 +0800
Message-Id: <20211222045022.27069-3-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211222045022.27069-1-tianjia.zhang@linux.alibaba.com>
References: <20211222045022.27069-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM3 generic library is stand-alone implementation, sm3-ce can depend
on the SM3 library instead of sm3-generic.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/Kconfig       |  2 +-
 arch/arm64/crypto/sm3-ce-glue.c | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index addfa413650b..2a965aa0188d 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -45,7 +45,7 @@ config CRYPTO_SM3_ARM64_CE
 	tristate "SM3 digest algorithm (ARMv8.2 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
-	select CRYPTO_SM3
+	select CRYPTO_LIB_SM3
 
 config CRYPTO_SM4_ARM64_CE
 	tristate "SM4 symmetric cipher (ARMv8.2 Crypto Extensions)"
diff --git a/arch/arm64/crypto/sm3-ce-glue.c b/arch/arm64/crypto/sm3-ce-glue.c
index d71faca322f2..3198f31c9446 100644
--- a/arch/arm64/crypto/sm3-ce-glue.c
+++ b/arch/arm64/crypto/sm3-ce-glue.c
@@ -27,7 +27,7 @@ static int sm3_ce_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
 	if (!crypto_simd_usable())
-		return crypto_sm3_update(desc, data, len);
+		return sm3_update(shash_desc_ctx(desc), data, len);
 
 	kernel_neon_begin();
 	sm3_base_do_update(desc, data, len, sm3_ce_transform);
@@ -39,7 +39,7 @@ static int sm3_ce_update(struct shash_desc *desc, const u8 *data,
 static int sm3_ce_final(struct shash_desc *desc, u8 *out)
 {
 	if (!crypto_simd_usable())
-		return crypto_sm3_finup(desc, NULL, 0, out);
+		return sm3_final(shash_desc_ctx(desc), out);
 
 	kernel_neon_begin();
 	sm3_base_do_finalize(desc, sm3_ce_transform);
@@ -51,14 +51,22 @@ static int sm3_ce_final(struct shash_desc *desc, u8 *out)
 static int sm3_ce_finup(struct shash_desc *desc, const u8 *data,
 			unsigned int len, u8 *out)
 {
-	if (!crypto_simd_usable())
-		return crypto_sm3_finup(desc, data, len, out);
+	if (!crypto_simd_usable()) {
+		struct sm3_state *sctx = shash_desc_ctx(desc);
+
+		if (len)
+			sm3_update(sctx, data, len);
+		sm3_final(sctx, out);
+		return 0;
+	}
 
 	kernel_neon_begin();
-	sm3_base_do_update(desc, data, len, sm3_ce_transform);
+	if (len)
+		sm3_base_do_update(desc, data, len, sm3_ce_transform);
+	sm3_base_do_finalize(desc, sm3_ce_transform);
 	kernel_neon_end();
 
-	return sm3_ce_final(desc, out);
+	return sm3_base_finish(desc, out);
 }
 
 static struct shash_alg sm3_alg = {
-- 
2.32.0

