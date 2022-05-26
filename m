Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACF253553B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344729AbiEZU5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239530AbiEZU44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:56:56 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC2C5C346
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:56:53 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nuKXL-0006ZH-FQ; Thu, 26 May 2022 22:56:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        hch@lst.de, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 5/5] riscv: remove usage of function-pointers from cpufeatures and t-head errata
Date:   Thu, 26 May 2022 22:56:46 +0200
Message-Id: <20220526205646.258337-6-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220526205646.258337-1-heiko@sntech.de>
References: <20220526205646.258337-1-heiko@sntech.de>
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

Having a list of alternatives to check with a per-entry function pointer
to a check function is nice style-wise. But in case of early-alternatives
it can clash with the non-relocated kernel and the function pointer in
the list pointing to a completely wrong location.

This isn't an issue with one or two list entries, as in that case the
compiler seems to unroll the loop and even usage of the list structure
and then only does relative jumps into the check functions based on this.

When adding a third entry to either list though, the issue that was
hiding there from the beginning is triggered resulting a jump to a
memory address that isn't part of the kernel at all.

The list of features/erratas only contained an unused name and the
pointer to the check function, so an easy solution for the problem
is to just unroll the loop in code, dismantle the whole list structure
and just call the relevant check functions one by one ourself.

For the T-Head errata this includes moving the stage-check inside
the check functions.

The issue is only relevant for things that might be called for early-
alternatives (T-Head and possible future main extensions), so the
SiFive erratas were not affected from the beginning, as they got
an early return for early-alternatives in the original patchset.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/errata/thead/errata.c | 38 ++++++++++----------------------
 arch/riscv/kernel/cpufeature.c   | 32 +++++++++------------------
 2 files changed, 22 insertions(+), 48 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index e5d75270b99c..cc155228247d 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -14,40 +14,26 @@
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
 
-struct errata_info {
-	char name[ERRATA_STRING_LENGTH_MAX];
-	bool (*check_func)(unsigned long arch_id, unsigned long impid);
-	unsigned int stage;
-};
-
-static bool errata_mt_check_func(unsigned long  arch_id, unsigned long impid)
+static bool errata_probe_pbmt(unsigned int stage,
+			      unsigned long arch_id, unsigned long impid)
 {
 	if (arch_id != 0 || impid != 0)
 		return false;
-	return true;
-}
 
-static const struct errata_info errata_list[ERRATA_THEAD_NUMBER] = {
-	{
-		.name = "memory-types",
-		.stage = RISCV_ALTERNATIVES_EARLY_BOOT,
-		.check_func = errata_mt_check_func
-	},
-};
+	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT ||
+	    stage == RISCV_ALTERNATIVES_MODULE)
+		return true;
+
+	return false;
+}
 
-static u32 thead_errata_probe(unsigned int stage, unsigned long archid, unsigned long impid)
+static u32 thead_errata_probe(unsigned int stage,
+			      unsigned long archid, unsigned long impid)
 {
-	const struct errata_info *info;
 	u32 cpu_req_errata = 0;
-	int idx;
-
-	for (idx = 0; idx < ERRATA_THEAD_NUMBER; idx++) {
-		info = &errata_list[idx];
 
-		if ((stage == RISCV_ALTERNATIVES_MODULE ||
-		     info->stage == stage) && info->check_func(archid, impid))
-			cpu_req_errata |= (1U << idx);
-	}
+	if (errata_probe_pbmt(stage, archid, impid))
+		cpu_req_errata |= (1U << ERRATA_THEAD_PBMT);
 
 	return cpu_req_errata;
 }
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b33564df81e1..b63c25c55bf1 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -246,12 +246,7 @@ void __init riscv_fill_hwcap(void)
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-struct cpufeature_info {
-	char name[ERRATA_STRING_LENGTH_MAX];
-	bool (*check_func)(unsigned int stage);
-};
-
-static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
+static bool __init_or_module cpufeature_probe_svpbmt(unsigned int stage)
 {
 #ifdef CONFIG_RISCV_ISA_SVPBMT
 	switch (stage) {
@@ -265,26 +260,19 @@ static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
 	return false;
 }
 
-static const struct cpufeature_info __initdata_or_module
-cpufeature_list[CPUFEATURE_NUMBER] = {
-	{
-		.name = "svpbmt",
-		.check_func = cpufeature_svpbmt_check_func
-	},
-};
-
+/*
+ * Probe presence of individual extensions.
+ *
+ * This code may also be executed before kernel relocation, so we cannot use
+ * addresses generated by the address-of operator as they won't be valid in
+ * this context.
+ */
 static u32 __init_or_module cpufeature_probe(unsigned int stage)
 {
-	const struct cpufeature_info *info;
 	u32 cpu_req_feature = 0;
-	int idx;
-
-	for (idx = 0; idx < CPUFEATURE_NUMBER; idx++) {
-		info = &cpufeature_list[idx];
 
-		if (info->check_func(stage))
-			cpu_req_feature |= (1U << idx);
-	}
+	if (cpufeature_probe_svpbmt(stage))
+		cpu_req_feature |= (1U << CPUFEATURE_SVPBMT);
 
 	return cpu_req_feature;
 }
-- 
2.35.1

