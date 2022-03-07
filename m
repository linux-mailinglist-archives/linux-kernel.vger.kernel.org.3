Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65D04D0B57
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbiCGWr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343848AbiCGWrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:47:24 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC39852E15
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:46:26 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nRM7U-00032M-2K; Mon, 07 Mar 2022 23:46:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/2] riscv: implement cache-management errata for T-Head SoCs
Date:   Mon,  7 Mar 2022 23:46:20 +0100
Message-Id: <20220307224620.1933061-3-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220307224620.1933061-1-heiko@sntech.de>
References: <20220307224620.1933061-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T-Head C906 and C910 implement a scheme for handling
cache operations different from the generic Zicbom extension.

Add an errata for it next to the generic dma coherency ops.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/Kconfig.erratas           | 10 +++++++
 arch/riscv/errata/thead/errata.c     |  5 ++++
 arch/riscv/include/asm/errata_list.h | 45 ++++++++++++++++++++++++++--
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
index de4002baa1d0..89a6dcb8ac2a 100644
--- a/arch/riscv/Kconfig.erratas
+++ b/arch/riscv/Kconfig.erratas
@@ -50,4 +50,14 @@ config ERRATA_THEAD_PBMT
 
 	  If you don't know what to do here, say "Y".
 
+config ERRATA_THEAD_CMO
+	bool "Apply T-Head cache management errata"
+	depends on ERRATA_THEAD && RISCV_DMA_NONCOHERENT
+	default y
+	help
+	  This will apply the cache management errata to handle the
+	  non-standard handling on non-coherent operations on T-Head SoCs.
+
+	  If you don't know what to do here, say "Y".
+
 endmenu
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index fd8e0538a3f0..11c26c37425f 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -33,6 +33,11 @@ static const struct errata_info errata_list[ERRATA_THEAD_NUMBER] = {
 		.stage = RISCV_ALTERNATIVES_EARLY_BOOT,
 		.check_func = errata_mt_check_func
 	},
+	{
+		.name = "cache-management",
+		.stage = RISCV_ALTERNATIVES_BOOT,
+		.check_func = errata_mt_check_func
+	},
 };
 
 static u32 thead_errata_probe(unsigned int stage, unsigned long archid, unsigned long impid)
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 7a2dd61af24d..f7c6805daeab 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -16,7 +16,8 @@
 
 #ifdef CONFIG_ERRATA_THEAD
 #define	ERRATA_THEAD_PBMT 0
-#define	ERRATA_THEAD_NUMBER 1
+#define	ERRATA_THEAD_CMO 1
+#define	ERRATA_THEAD_NUMBER 2
 #endif
 
 #define	CPUFEATURE_SVPBMT 0
@@ -104,8 +105,37 @@ asm volatile(ALTERNATIVE(								\
 #define CBO_CLEAN_A0	".long 0x25200F"
 #define CBO_FLUSH_A0	".long 0x05200F"
 
+/*
+ * dcache.ipa rs1 (invalidate, physical address)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01010      rs1       000      00000  0001011
+ * dache.iva rs1 (invalida, virtual address)
+ *   0000001    00110      rs1       000      00000  0001011
+ *
+ * dcache.cpa rs1 (clean, physical address)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01001      rs1       000      00000  0001011
+ * dcache.cva rs1 (clean, virtual address)
+ *   0000001    00100      rs1       000      00000  0001011
+ *
+ * dcache.cipa rs1 (clean then invalidate, physical address)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01011      rs1       000      00000  0001011
+ * dcache.civa rs1 (... virtual address)
+ *   0000001    00111      rs1       000      00000  0001011
+ *
+ * sync.s (make sure all cache operations finished)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000000    11001     00000      000      00000  0001011
+ */
+#define THEAD_INVAL_A0	".long 0x0265000b"
+#define THEAD_CLEAN_A0	".long 0x0245000b"
+#define THEAD_FLUSH_A0	".long 0x0275000b"
+#define THEAD_SYNC_S	".long 0x0190000b"
+
 #define ALT_CMO_OP(_op, _start, _size)							\
-asm volatile(ALTERNATIVE(								\
+asm volatile(ALTERNATIVE_2(								\
+	"nop\n\t"									\
 	"nop\n\t"									\
 	"nop\n\t"									\
 	"nop\n\t"									\
@@ -117,7 +147,16 @@ asm volatile(ALTERNATIVE(								\
 	CBO_##_op##_A0 "\n\t"								\
 	"addi a0, a0, %0\n\t"								\
 	"2:\n\t"									\
-	"bltu a0, %2, 3b\n\t", 0, CPUFEATURE_CMO, CONFIG_RISCV_DMA_NONCOHERENT)		\
+	"bltu a0, %2, 3b\n\t"								\
+	"nop", 0, CPUFEATURE_CMO, CONFIG_RISCV_DMA_NONCOHERENT,				\
+	"mv a0, %1\n\t"									\
+	"j 2f\n\t"									\
+	"3:\n\t"									\
+	THEAD_##_op##_A0 "\n\t"								\
+	"addi a0, a0, %0\n\t"								\
+	"2:\n\t"									\
+	"bltu a0, %2, 3b\n\t"								\
+	THEAD_SYNC_S, THEAD_VENDOR_ID, ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
 	: : "I"(L1_CACHE_BYTES), "r"((_start) & ~(L1_CACHE_BYTES - 1)),			\
 	    "r"(ALIGN((_start) + (_size), L1_CACHE_BYTES)))
 
-- 
2.30.2

