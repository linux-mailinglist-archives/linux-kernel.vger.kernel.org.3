Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14088563F5A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 11:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiGBJyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 05:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiGBJyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 05:54:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D5717A9A;
        Sat,  2 Jul 2022 02:54:31 -0700 (PDT)
Date:   Sat, 02 Jul 2022 09:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656755669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+lyg78/f+vkYSosHqwA/xIwCdURNsKuo0GycCCmwRTg=;
        b=TK6gD0vahkvhp9iuF3Rv5rsRBLwiIMGIeWYDY8txPoonNVRtz5zcioKvi9SCZl62faNoee
        mG3hXgd+XB/iqx9iYtwCsWWWpZzMavoL7A4K38o9ZLrUWBPv81iQJIzeUKrwpcVHLfA/iI
        /S9RE6ogicYvpL4AJj7/lr+gSFAxPc8fyMrX7lqVgtYUqp2Sox+tarTEvTtQMgUB8LI89E
        pv9s9y8eso1lrCCEzMhgnk6P/f7Wt9FKsH1fliS3cp978L47gLyd8wviYqqISf409aK3N8
        DyPmop+Y1rTNu6WXWxa4Lr8oP9/ZpBgGWRBoNk3JbukIMrs+inVAAagVASqF9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656755669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+lyg78/f+vkYSosHqwA/xIwCdURNsKuo0GycCCmwRTg=;
        b=dgV2wO58Ib3YzweaESCVjyCoJdkNjRvIqJdvQLtb2vo+u99qYvBPJz4jQyFcejqYz1K9Xp
        EmfSpKPG/x8K3kBQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/xen: Use clear_bss() for Xen PV guests
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220630071441.28576-2-jgross@suse.com>
References: <20220630071441.28576-2-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <165675566857.15455.1489447634414365811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     96e8fc5818686d4a1591bb6907e7fdb64ef29884
Gitweb:        https://git.kernel.org/tip/96e8fc5818686d4a1591bb6907e7fdb64ef29884
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 30 Jun 2022 09:14:39 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 01 Jul 2022 10:57:52 +02:00

x86/xen: Use clear_bss() for Xen PV guests

Instead of clearing the bss area in assembly code, use the clear_bss()
function.

This requires to pass the start_info address as parameter to
xen_start_kernel() in order to avoid the xen_start_info being zeroed
again.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Link: https://lore.kernel.org/r/20220630071441.28576-2-jgross@suse.com
---
 arch/x86/include/asm/setup.h |  3 +++
 arch/x86/kernel/head64.c     |  2 +-
 arch/x86/xen/enlighten_pv.c  |  8 ++++++--
 arch/x86/xen/xen-head.S      | 10 +---------
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f8b9ee9..f37cbff 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -120,6 +120,9 @@ void *extend_brk(size_t size, size_t align);
 	static char __brk_##name[size]
 
 extern void probe_roms(void);
+
+void clear_bss(void);
+
 #ifdef __i386__
 
 asmlinkage void __init i386_start_kernel(void);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index bd4a341..e7e2332 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -426,7 +426,7 @@ void __init do_early_exception(struct pt_regs *regs, int trapnr)
 
 /* Don't add a printk in there. printk relies on the PDA which is not initialized 
    yet. */
-static void __init clear_bss(void)
+void __init clear_bss(void)
 {
 	memset(__bss_start, 0,
 	       (unsigned long) __bss_stop - (unsigned long) __bss_start);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index e3297b1..70fb2ea 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1183,15 +1183,19 @@ static void __init xen_domu_set_legacy_features(void)
 extern void early_xen_iret_patch(void);
 
 /* First C function to be called on Xen boot */
-asmlinkage __visible void __init xen_start_kernel(void)
+asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 {
 	struct physdev_set_iopl set_iopl;
 	unsigned long initrd_start = 0;
 	int rc;
 
-	if (!xen_start_info)
+	if (!si)
 		return;
 
+	clear_bss();
+
+	xen_start_info = si;
+
 	__text_gen_insn(&early_xen_iret_patch,
 			JMP32_INSN_OPCODE, &early_xen_iret_patch, &xen_iret,
 			JMP32_INSN_SIZE);
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 3a2cd93..13af6fe 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -48,15 +48,6 @@ SYM_CODE_START(startup_xen)
 	ANNOTATE_NOENDBR
 	cld
 
-	/* Clear .bss */
-	xor %eax,%eax
-	mov $__bss_start, %rdi
-	mov $__bss_stop, %rcx
-	sub %rdi, %rcx
-	shr $3, %rcx
-	rep stosq
-
-	mov %rsi, xen_start_info
 	mov initial_stack(%rip), %rsp
 
 	/* Set up %gs.
@@ -71,6 +62,7 @@ SYM_CODE_START(startup_xen)
 	cdq
 	wrmsr
 
+	mov	%rsi, %rdi
 	call xen_start_kernel
 SYM_CODE_END(startup_xen)
 	__FINIT
