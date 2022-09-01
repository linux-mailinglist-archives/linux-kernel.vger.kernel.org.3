Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014DC5AA312
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiIAWac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiIAW3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:29:40 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844DA3ED60
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:28:25 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oTsfW-0007wk-5B; Fri, 02 Sep 2022 00:28:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     conor.dooley@microchip.com, guoren@kernel.org,
        apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/4] riscv: drop some idefs from CMO initialization
Date:   Fri,  2 Sep 2022 00:27:42 +0200
Message-Id: <20220901222744.2210215-2-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901222744.2210215-1-heiko@sntech.de>
References: <20220901222744.2210215-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrapping things in #ifdefs makes the code harder to read
while we also have IS_ENABLED() macros to do this in regular code
and the extension detection is not _that_ runtime critical.

So define a stub for riscv_noncoherent_supported() in the
non-CONFIG_RISCV_DMA_NONCOHERENT case and move the code to
us IS_ENABLED.

Suggested-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/errata/thead/errata.c    |  7 +++----
 arch/riscv/include/asm/cacheflush.h |  2 ++
 arch/riscv/kernel/cpufeature.c      | 22 +++++++++-------------
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 202c83f677b2..bffa711aaf64 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -30,7 +30,9 @@ static bool errata_probe_pbmt(unsigned int stage,
 static bool errata_probe_cmo(unsigned int stage,
 			     unsigned long arch_id, unsigned long impid)
 {
-#ifdef CONFIG_ERRATA_THEAD_CMO
+	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_CMO))
+		return false;
+
 	if (arch_id != 0 || impid != 0)
 		return false;
 
@@ -39,9 +41,6 @@ static bool errata_probe_cmo(unsigned int stage,
 
 	riscv_noncoherent_supported();
 	return true;
-#else
-	return false;
-#endif
 }
 
 static u32 thead_errata_probe(unsigned int stage,
diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index a60acaecfeda..4363d0beb38a 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -50,6 +50,8 @@ static inline void riscv_init_cbom_blocksize(void) { }
 
 #ifdef CONFIG_RISCV_DMA_NONCOHERENT
 void riscv_noncoherent_supported(void);
+#else
+static inline void riscv_noncoherent_supported(void) {}
 #endif
 
 /*
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 764ea220161f..729f7a218093 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -264,21 +264,17 @@ static bool __init_or_module cpufeature_probe_svpbmt(unsigned int stage)
 
 static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
 {
-#ifdef CONFIG_RISCV_ISA_ZICBOM
-	switch (stage) {
-	case RISCV_ALTERNATIVES_EARLY_BOOT:
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM))
+		return false;
+
+	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
+		return false;
+
+	if (!riscv_isa_extension_available(NULL, ZICBOM))
 		return false;
-	default:
-		if (riscv_isa_extension_available(NULL, ZICBOM)) {
-			riscv_noncoherent_supported();
-			return true;
-		} else {
-			return false;
-		}
-	}
-#endif
 
-	return false;
+	riscv_noncoherent_supported();
+	return true;
 }
 
 /*
-- 
2.35.1

