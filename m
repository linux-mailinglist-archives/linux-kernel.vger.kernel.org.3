Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458324E5C34
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346699AbiCXAML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239189AbiCXAMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:12:10 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE17E73
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:10:38 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nXB0u-00055s-8y; Thu, 24 Mar 2022 01:07:40 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        hch@lst.de, arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 13/14] riscv: don't use global static vars to store alternative data
Date:   Thu, 24 Mar 2022 01:07:09 +0100
Message-Id: <20220324000710.575331-14-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324000710.575331-1-heiko@sntech.de>
References: <20220324000710.575331-1-heiko@sntech.de>
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

Right now the code uses a global struct to store vendor-ids
and another global variable to store the vendor-patch-function.

There exist specific cases where we'll need to patch the kernel
at an even earlier stage, where trying to write to a static
variable might actually result in hangs.

Also collecting the vendor-information consists of 3 sbi-ecalls
(or csr-reads) which is pretty negligible in the context of
booting a kernel.

So rework the code to not rely on static variables and instead
collect the vendor-information when a round of alternatives is
to be applied.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/kernel/alternative.c | 51 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index e6c9de9f9ba6..27f722ae452b 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -16,41 +16,35 @@
 #include <asm/sbi.h>
 #include <asm/csr.h>
 
-static struct cpu_manufacturer_info_t {
+struct cpu_manufacturer_info_t {
 	unsigned long vendor_id;
 	unsigned long arch_id;
 	unsigned long imp_id;
-} cpu_mfr_info;
+	void (*vendor_patch_func)(struct alt_entry *begin, struct alt_entry *end,
+				  unsigned long archid, unsigned long impid,
+				  unsigned int stage);
+};
 
-static void (*vendor_patch_func)(struct alt_entry *begin, struct alt_entry *end,
-				 unsigned long archid, unsigned long impid,
-				 unsigned int stage) __initdata_or_module;
-
-static inline void __init riscv_fill_cpu_mfr_info(void)
+static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info)
 {
 #ifdef CONFIG_RISCV_M_MODE
-	cpu_mfr_info.vendor_id = csr_read(CSR_MVENDORID);
-	cpu_mfr_info.arch_id = csr_read(CSR_MARCHID);
-	cpu_mfr_info.imp_id = csr_read(CSR_MIMPID);
+	cpu_mfr_info->vendor_id = csr_read(CSR_MVENDORID);
+	cpu_mfr_info->arch_id = csr_read(CSR_MARCHID);
+	cpu_mfr_info->imp_id = csr_read(CSR_MIMPID);
 #else
-	cpu_mfr_info.vendor_id = sbi_get_mvendorid();
-	cpu_mfr_info.arch_id = sbi_get_marchid();
-	cpu_mfr_info.imp_id = sbi_get_mimpid();
+	cpu_mfr_info->vendor_id = sbi_get_mvendorid();
+	cpu_mfr_info->arch_id = sbi_get_marchid();
+	cpu_mfr_info->imp_id = sbi_get_mimpid();
 #endif
-}
-
-static void __init init_alternative(void)
-{
-	riscv_fill_cpu_mfr_info();
 
-	switch (cpu_mfr_info.vendor_id) {
+	switch (cpu_mfr_info->vendor_id) {
 #ifdef CONFIG_ERRATA_SIFIVE
 	case SIFIVE_VENDOR_ID:
-		vendor_patch_func = sifive_errata_patch_func;
+		cpu_mfr_info->vendor_patch_func = sifive_errata_patch_func;
 		break;
 #endif
 	default:
-		vendor_patch_func = NULL;
+		cpu_mfr_info->vendor_patch_func = NULL;
 	}
 }
 
@@ -63,14 +57,19 @@ static void __init_or_module _apply_alternatives(struct alt_entry *begin,
 						 struct alt_entry *end,
 						 unsigned int stage)
 {
+	struct cpu_manufacturer_info_t cpu_mfr_info;
+
+	riscv_fill_cpu_mfr_info(&cpu_mfr_info);
+
 	riscv_cpufeature_patch_func(begin, end, stage);
 
-	if (!vendor_patch_func)
+	if (!cpu_mfr_info.vendor_patch_func)
 		return;
 
-	vendor_patch_func(begin, end,
-			  cpu_mfr_info.arch_id, cpu_mfr_info.imp_id,
-			  stage);
+	cpu_mfr_info.vendor_patch_func(begin, end,
+				   cpu_mfr_info.arch_id,
+				   cpu_mfr_info.imp_id,
+				   stage);
 }
 
 void __init apply_boot_alternatives(void)
@@ -78,8 +77,6 @@ void __init apply_boot_alternatives(void)
 	/* If called on non-boot cpu things could go wrong */
 	WARN_ON(smp_processor_id() != 0);
 
-	init_alternative();
-
 	_apply_alternatives((struct alt_entry *)__alt_start,
 			    (struct alt_entry *)__alt_end,
 			    RISCV_ALTERNATIVES_BOOT);
-- 
2.35.1

