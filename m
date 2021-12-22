Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE447D067
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbhLVK7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbhLVK7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:59:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A1AC061574;
        Wed, 22 Dec 2021 02:59:11 -0800 (PST)
Date:   Wed, 22 Dec 2021 10:59:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640170748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0Fb+4NOFZ2tiPBTOMkS+3TPNKaVHOtELQcnN1bSMBU=;
        b=wpvU5DXinSoM+rs07FAWNuQTvvoyJ4I62vSrfz5TFYD6YwIzBDxWX5yB3EzR2FwAyHW6Ie
        NdjW9gZumfEHJBsyGn3hCm95Ihd6PlKUnQW9Qz1mhUhlIKm/GL9t7Y0gZJCH9xN/nIpJJp
        vgTcP/LKC9akqNTUnD/35ZzSp3X4C9dNTFmu8BkEnufXOHxc9HSxjUO2gxK6cNl5YRyJQr
        xRnLabTTAS45NHL/XPj54Q9vg23lIzuWPCCgUdBXJrKPKW6qRKAMTGu/gj2HfMpkvov7L1
        kAG/TcGmuzheW4akLwX9n4vf1p0RuLAftmVg6I82KJ0ZUKBc+nefQ7XLui9MAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640170748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0Fb+4NOFZ2tiPBTOMkS+3TPNKaVHOtELQcnN1bSMBU=;
        b=c3ic2Pbuti2SLN8+XSszTE4w0WHeNZZUN50LFxBbAsY+MB/7NEZ5PrD+Rt8QDYO5RdGZkl
        i+0IM2IUexgnfvBQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Prevent early boot triple-faults with instrumentation
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        kernel test robot <oliver.sang@intel.com>,
        Borislav Petkov <bp@suse.de>, Carel Si <beibei.si@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211209144141.GC25654@xsang-OptiPlex-9020>
References: <20211209144141.GC25654@xsang-OptiPlex-9020>
MIME-Version: 1.0
Message-ID: <164017074764.16921.17573607590161623157.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     b64dfcde1ca9cb82e38e573753f0c0db8fb841c2
Gitweb:        https://git.kernel.org/tip/b64dfcde1ca9cb82e38e573753f0c0db8fb841c2
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 17 Dec 2021 16:48:29 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Dec 2021 11:51:20 +01:00

x86/mm: Prevent early boot triple-faults with instrumentation

Commit in Fixes added a global TLB flush on the early boot path, after
the kernel switches off of the trampoline page table.

Compiler profiling options enabled with GCOV_PROFILE add additional
measurement code on clang which needs to be initialized prior to
use. The global flush in x86_64_start_kernel() happens before those
initializations can happen, leading to accessing invalid memory.
GCOV_PROFILE builds with gcc are still ok so this is clang-specific.

The second issue this fixes is with KASAN: for a similar reason,
kasan_early_init() needs to have happened before KASAN-instrumented
functions are called.

Therefore, reorder the flush to happen after the KASAN early init
and prevent the compilers from adding profiling instrumentation to
native_write_cr4().

Fixes: f154f290855b ("x86/mm/64: Flush global TLB on boot and AP bringup")
Reported-by: "J. Bruce Fields" <bfields@fieldses.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Carel Si <beibei.si@intel.com>
Tested-by: "J. Bruce Fields" <bfields@fieldses.org>
Link: https://lore.kernel.org/r/20211209144141.GC25654@xsang-OptiPlex-9020
---
 arch/x86/kernel/cpu/common.c |  2 +-
 arch/x86/kernel/head64.c     | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0083464..79b3d67 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -384,7 +384,7 @@ set_register:
 }
 EXPORT_SYMBOL(native_write_cr0);
 
-void native_write_cr4(unsigned long val)
+void __no_profile native_write_cr4(unsigned long val)
 {
 	unsigned long bits_changed = 0;
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 75acb60..f5e80a8 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -483,10 +483,12 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 	/* Kill off the identity-map trampoline */
 	reset_early_page_tables();
 
-	__native_tlb_flush_global(native_read_cr4());
-
 	clear_bss();
 
+	/*
+	 * This needs to happen *before* kasan_early_init() because latter maps stuff
+	 * into that page.
+	 */
 	clear_page(init_top_pgt);
 
 	/*
@@ -498,6 +500,16 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 
 	kasan_early_init();
 
+	/*
+	 * Flush global TLB entries which could be left over from the trampoline page
+	 * table.
+	 *
+	 * This needs to happen *after* kasan_early_init() as KASAN-enabled .configs
+	 * instrument native_write_cr4() so KASAN must be initialized for that
+	 * instrumentation to work.
+	 */
+	__native_tlb_flush_global(this_cpu_read(cpu_tlbstate.cr4));
+
 	idt_setup_early_handler();
 
 	copy_bootdata(__va(real_mode_data));
