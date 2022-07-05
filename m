Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECDB566324
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiGEG0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGEG0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:26:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF7FBA1AB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:26:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C29C423A;
        Mon,  4 Jul 2022 23:26:06 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 504843F70D;
        Mon,  4 Jul 2022 23:26:04 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Define defer_reserve_crashkernel()
Date:   Tue,  5 Jul 2022 11:55:56 +0530
Message-Id: <20220705062556.1845734-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crash kernel memory reservation gets deferred, when either CONFIG_ZONE_DMA
or CONFIG_ZONE_DMA32 config is enabled on the platform. This deferral also
impacts overall linear mapping creation including the crash kernel itself.
Just encapsulate this deferral check in a new helper for better clarity.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/memory.h | 5 +++++
 arch/arm64/mm/init.c            | 4 ++--
 arch/arm64/mm/mmu.c             | 6 ++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0af70d9abede..b09b300360cf 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -351,6 +351,11 @@ static inline void *phys_to_virt(phys_addr_t x)
 })
 
 void dump_mem_limit(void);
+
+static inline bool defer_reserve_crashkernel(void)
+{
+	return IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
+}
 #endif /* !ASSEMBLY */
 
 /*
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 339ee84e5a61..b6ef26fc8ebe 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -389,7 +389,7 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
+	if (!defer_reserve_crashkernel())
 		reserve_crashkernel();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
@@ -438,7 +438,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
+	if (defer_reserve_crashkernel())
 		reserve_crashkernel();
 
 	memblock_dump_all();
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 626ec32873c6..03f0572f5b34 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -529,8 +529,7 @@ static void __init map_mem(pgd_t *pgdp)
 
 #ifdef CONFIG_KEXEC_CORE
 	if (crash_mem_map) {
-		if (IS_ENABLED(CONFIG_ZONE_DMA) ||
-		    IS_ENABLED(CONFIG_ZONE_DMA32))
+		if (defer_reserve_crashkernel())
 			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 		else if (crashk_res.end)
 			memblock_mark_nomap(crashk_res.start,
@@ -571,8 +570,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 * through /sys/kernel/kexec_crash_size interface.
 	 */
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map &&
-	    !IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) {
+	if (crash_mem_map && !defer_reserve_crashkernel()) {
 		if (crashk_res.end) {
 			__map_memblock(pgdp, crashk_res.start,
 				       crashk_res.end + 1,
-- 
2.20.1

