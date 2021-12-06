Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F146AB26
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356161AbhLFWB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344091AbhLFWBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:01:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAA6C0613FE;
        Mon,  6 Dec 2021 13:57:48 -0800 (PST)
Date:   Mon, 06 Dec 2021 21:57:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638827866;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjvAolElgLN2UoVLE0ULBn6BXUMiVW9SOvU/uPesDJI=;
        b=0E3V9D/2SkCZsdLTFUOWt8gCFPIpKgS8v+cU4FDAjosVtPb1fi8G1sA9DhyYwOq5O0OfEA
        tl69ugnrUsi1ARmKtfUNyU5fHy1W3SeDAYN9xCDWksxC2HLZxaKDCuoFuqwUbbJfGGolPa
        Y5rRRPD+/ONAb5kkwTPD4/6YWqQbgpTBbgGkK7amhnNvj5Q1yNB/yBbgOKaPepIdzD5XA9
        bVEm18Jk3TcrgF0BZAdH5MQ2YC1KrGASGL/ua+4iI5nR8awtu3A9I3nOGu/9BZGwDLJ6V3
        2L6/P3O093J6YGFQMD+fZOK6JyBav/yG2qhdqPq1fHC+q4+7V9ZjqmELHo9z2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638827866;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjvAolElgLN2UoVLE0ULBn6BXUMiVW9SOvU/uPesDJI=;
        b=HunI7Q+7ol9ZCFddjEZboVAwvRo7SzC/yqSbEeMQK0pAV6A1MV/B+rpAAGUgCkkgvo4aVD
        ibnSxxVzXU2iJlBA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Flush global TLB when switching to trampoline
 page-table
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211202153226.22946-4-joro@8bytes.org>
References: <20211202153226.22946-4-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <163882786459.11128.3328128025586592058.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     71d5049b053876afbde6c3273250b76935494ab2
Gitweb:        https://git.kernel.org/tip/71d5049b053876afbde6c3273250b76935494ab2
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Thu, 02 Dec 2021 16:32:25 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 06 Dec 2021 09:54:10 +01:00

x86/mm: Flush global TLB when switching to trampoline page-table

Move the switching code into a function so that it can be re-used and
add a global TLB flush. This makes sure that usage of memory which is
not mapped in the trampoline page-table is reliably caught.

Also move the clearing of CR4.PCIDE before the CR3 switch because the
cr4_clear_bits() function will access data not mapped into the
trampoline page-table.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211202153226.22946-4-joro@8bytes.org
---
 arch/x86/include/asm/realmode.h |  1 +
 arch/x86/kernel/reboot.c        | 12 ++----------
 arch/x86/realmode/init.c        | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 5db5d08..331474b 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -89,6 +89,7 @@ static inline void set_real_mode_mem(phys_addr_t mem)
 }
 
 void reserve_real_mode(void);
+void load_trampoline_pgtable(void);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0a40df6..fa700b4 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -113,17 +113,9 @@ void __noreturn machine_real_restart(unsigned int type)
 	spin_unlock(&rtc_lock);
 
 	/*
-	 * Switch back to the initial page table.
+	 * Switch to the trampoline page table.
 	 */
-#ifdef CONFIG_X86_32
-	load_cr3(initial_page_table);
-#else
-	write_cr3(real_mode_header->trampoline_pgd);
-
-	/* Exiting long mode will fail if CR4.PCIDE is set. */
-	if (boot_cpu_has(X86_FEATURE_PCID))
-		cr4_clear_bits(X86_CR4_PCIDE);
-#endif
+	load_trampoline_pgtable();
 
 	/* Jump to the identity-mapped low memory code */
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 4a3da75..6d98609 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -17,6 +17,32 @@ u32 *trampoline_cr4_features;
 /* Hold the pgd entry used on booting additional CPUs */
 pgd_t trampoline_pgd_entry;
 
+void load_trampoline_pgtable(void)
+{
+#ifdef CONFIG_X86_32
+	load_cr3(initial_page_table);
+#else
+	/*
+	 * This function is called before exiting to real-mode and that will
+	 * fail with CR4.PCIDE still set.
+	 */
+	if (boot_cpu_has(X86_FEATURE_PCID))
+		cr4_clear_bits(X86_CR4_PCIDE);
+
+	write_cr3(real_mode_header->trampoline_pgd);
+#endif
+
+	/*
+	 * The CR3 write above will not flush global TLB entries.
+	 * Stale, global entries from previous page tables may still be
+	 * present.  Flush those stale entries.
+	 *
+	 * This ensures that memory accessed while running with
+	 * trampoline_pgd is *actually* mapped into trampoline_pgd.
+	 */
+	__flush_tlb_all();
+}
+
 void __init reserve_real_mode(void)
 {
 	phys_addr_t mem;
