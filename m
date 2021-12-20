Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A2347A81F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhLTLAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhLTLAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:00:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB510C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 03:00:09 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17CF11EC0567;
        Mon, 20 Dec 2021 12:00:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639998004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NVH+9Xv+mhJGrugUsoTinsKz21v2dpO7caEXunwTj4g=;
        b=VgsHUwyOifCQpiR3cvL/hgK0X6tE2JBvQTuLOdR9LdDOOuGWs7/JnxvJMvgkOtZ6oiHb0Z
        AE03A/omyUE/lLZMpgo/06bCgr+EM2B3qjftAsMUYsy7dXKd52allhqwL4axTUP36a+beI
        L71ePkgkKAduC5cNNi3YL25LF0ITDmE=
Date:   Mon, 20 Dec 2021 12:00:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     x86@kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Carel Si <beibei.si@intel.com>, Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, bfields@fieldses.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] x86/mm: Prevent early boot triple-faults with instrumentation
Message-ID: <YcBiNqhYrxBPZphJ@zn.tnic>
References: <YbjIoewxGaodXHKF@zn.tnic>
 <20211215070012.GA26582@linux.intel.com>
 <Ybm96seTxl+pWjTX@zn.tnic>
 <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com>
 <YbsPwyLnejLQMbTb@zn.tnic>
 <20211216115838.GA23522@linux.intel.com>
 <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com>
 <YbyIJYzqtHPKRMFt@zn.tnic>
 <YbzRHXEMnZjyXzWa@archlinux-ax161>
 <Yb2/QCOExDEsj47w@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yb2/QCOExDEsj47w@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Commit in Fixes added a global TLB flush on the early boot path, after
the kernel switches off of the trampoline page table.

Compiler profiling options add additional measurement code
which needs to be initialized prior to use. The global flush in
x86_64_start_kernel() happens before those initializations can happen,
leading to accessing invalid memory.

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
Link: https://lore.kernel.org/r/20211209144141.GC25654@xsang-OptiPlex-9020
---
 arch/x86/kernel/cpu/common.c |  2 +-
 arch/x86/kernel/head64.c     | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0083464de5e3..79b3d67addcc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -384,7 +384,7 @@ void native_write_cr0(unsigned long val)
 }
 EXPORT_SYMBOL(native_write_cr0);
 
-void native_write_cr4(unsigned long val)
+void __no_profile native_write_cr4(unsigned long val)
 {
 	unsigned long bits_changed = 0;
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 75acb6027a87..f5e80a8377ad 100644
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
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
