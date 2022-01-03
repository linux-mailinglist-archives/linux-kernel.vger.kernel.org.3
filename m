Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B995482E75
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 07:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiACGWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 01:22:17 -0500
Received: from foss.arm.com ([217.140.110.172]:34582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbiACGWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 01:22:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB0C86D;
        Sun,  2 Jan 2022 22:22:15 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.71.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 941263F774;
        Sun,  2 Jan 2022 22:22:13 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     david@redhat.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/mm/hotplug: Warn when memory limit has been reduced
Date:   Mon,  3 Jan 2022 11:51:56 +0530
Message-Id: <1641190916-24751-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the max memory limit has been reduced with 'mem=' kernel command line
option, there might be UEFI memory map described memory beyond that limit
which could be hot removed. This might be problematic for subsequent kexec
kernel which could just access such removed memory.

Memory offline notifier exists because there is no other way to block the
removal of boot memory, only the offlining (which isn't actually a problem)
But with 'mem=', there is no chance to stop such boot memory being offlined
as it where never in use by the kernel. As 'mem=' is a debug only option on
arm64 platform, just warn for such a situation and move on.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.16-rc8

Changes in V2:

- Moved has_mem_limit_reduced() inside hotplug notifier per Catalin
- Replaced pr_warn() with pr_warn_once() per Catalin

Changes in V1:

https://lore.kernel.org/linux-arm-kernel/1631602270-29215-1-git-send-email-anshuman.khandual@arm.com/

 arch/arm64/include/asm/memory.h |  1 +
 arch/arm64/mm/init.c            |  9 +++++++--
 arch/arm64/mm/mmu.c             | 12 ++++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 1b9a1e242612..dba58cf529e4 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -354,6 +354,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 })
 
 void dump_mem_limit(void);
+bool has_mem_limit_reduced(void);
 #endif /* !ASSEMBLY */
 
 /*
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a8834434af99..4cd3b2311199 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -174,6 +174,11 @@ EXPORT_SYMBOL(pfn_is_map_memory);
 
 static phys_addr_t memory_limit = PHYS_ADDR_MAX;
 
+bool has_mem_limit_reduced(void)
+{
+	return memory_limit != PHYS_ADDR_MAX;
+}
+
 /*
  * Limit the memory size that was specified via FDT.
  */
@@ -248,7 +253,7 @@ void __init arm64_memblock_init(void)
 	 * high up in memory, add back the kernel region that must be accessible
 	 * via the linear mapping.
 	 */
-	if (memory_limit != PHYS_ADDR_MAX) {
+	if (has_mem_limit_reduced()) {
 		memblock_mem_limit_remove_map(memory_limit);
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
@@ -422,7 +427,7 @@ void free_initmem(void)
 
 void dump_mem_limit(void)
 {
-	if (memory_limit != PHYS_ADDR_MAX) {
+	if (has_mem_limit_reduced()) {
 		pr_emerg("Memory Limit: %llu MB\n", memory_limit >> 20);
 	} else {
 		pr_emerg("Memory Limit: none\n");
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index acfae9b41cc8..9288cae136a1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1537,6 +1537,18 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
 	if ((action != MEM_GOING_OFFLINE) && (action != MEM_OFFLINE))
 		return NOTIFY_OK;
 
+	if (has_mem_limit_reduced()) {
+		/*
+		 * Physical memory limit has been reduced via the 'mem=' kernel
+		 * command line option. Memory beyond reduced limit could now be
+		 * removed and reassigned (guest ?) transparently to the kernel.
+		 * This might cause subsequent kexec kernel to crash or at least
+		 * corrupt the memory when accessing UEFI memory map enumerated
+		 * boot memory which might have been repurposed.
+		 */
+		pr_warn_once("Memory limit reduced, kexec might be problematic\n");
+	}
+
 	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
 		unsigned long start = PFN_PHYS(pfn);
 		unsigned long end = start + (1UL << PA_SECTION_SHIFT);
-- 
2.20.1

