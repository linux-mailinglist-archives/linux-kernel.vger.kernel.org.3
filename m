Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B3C468489
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350099AbhLDLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhLDLsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:48:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48456C0613F8;
        Sat,  4 Dec 2021 03:45:30 -0800 (PST)
Date:   Sat, 04 Dec 2021 11:45:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638618327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29pwrKpOyYif1yY9XHlHCFTl/Vz3hOt3yFKtfu8O/C0=;
        b=TdwbytO2l4FMYjlHZRHHs6okm+7bqhCGAk5qd9sIuILva18pGcDYlAzOQwGtgfO5ivdpxC
        n0oQ+hZevuXzKGRfllRXRdFTa8L0WNhujojEDBum7km9QevUOSHuv4P3PyaYQ4ajXCSNrq
        Gv6Mz/5EOmwlVzModmbhAIaDh4ustRbHqsvxT+ed1+0q74Mhuu4CXouRdIx8nve4zDg0Cz
        P7xzrSAVgjrU25/hnGzOmk4KXttar3d0hvkaImAk1VzFd3lJYt/ywvmK5iGtIkBA7T97qe
        mtxUZYuzuCgVnKqHMMJ6Qn6sZdDMG0aC57E2g/xivb32h6YORS9kQa2a+ulAZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638618327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29pwrKpOyYif1yY9XHlHCFTl/Vz3hOt3yFKtfu8O/C0=;
        b=VOJwYbRWLcCKPhi/QCYkqqRmvngubVDsNr6lcs4l2HADudbVwLvemJhMkCVlYYLbJ4SyUf
        zjqFJpduasM8MiAA==
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/xen: Add xenpv_restore_regs_and_return_to_usermode()
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@suse.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211126101209.8613-4-jiangshanlai@gmail.com>
References: <20211126101209.8613-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Message-ID: <163861832551.11128.1645285137833652414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5c8f6a2e316efebb3ba93d8c1af258155dcf5632
Gitweb:        https://git.kernel.org/tip/5c8f6a2e316efebb3ba93d8c1af258155dcf5632
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Fri, 26 Nov 2021 18:11:23 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 03 Dec 2021 19:21:15 +01:00

x86/xen: Add xenpv_restore_regs_and_return_to_usermode()

In the native case, PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is the
trampoline stack. But XEN pv doesn't use trampoline stack, so
PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is also the kernel stack.

In that case, source and destination stacks are identical, which means
that reusing swapgs_restore_regs_and_return_to_usermode() in XEN pv
would cause %rsp to move up to the top of the kernel stack and leave the
IRET frame below %rsp.

This is dangerous as it can be corrupted if #NMI / #MC hit as either of
these events occurring in the middle of the stack pushing would clobber
data on the (original) stack.

And, with  XEN pv, swapgs_restore_regs_and_return_to_usermode() pushing
the IRET frame on to the original address is useless and error-prone
when there is any future attempt to modify the code.

 [ bp: Massage commit message. ]

Fixes: 7f2590a110b8 ("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Link: https://lkml.kernel.org/r/20211126101209.8613-4-jiangshanlai@gmail.com
---
 arch/x86/entry/entry_64.S |  4 ++++
 arch/x86/xen/xen-asm.S    | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f9e1c06..97b1f84 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -574,6 +574,10 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	ud2
 1:
 #endif
+#ifdef CONFIG_XEN_PV
+	ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
+#endif
+
 	POP_REGS pop_rdi=0
 
 	/*
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 220dd96..444d824 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <../entry/calling.h>
 
 .pushsection .noinstr.text, "ax"
 /*
@@ -193,6 +194,25 @@ SYM_CODE_START(xen_iret)
 SYM_CODE_END(xen_iret)
 
 /*
+ * XEN pv doesn't use trampoline stack, PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is
+ * also the kernel stack.  Reusing swapgs_restore_regs_and_return_to_usermode()
+ * in XEN pv would cause %rsp to move up to the top of the kernel stack and
+ * leave the IRET frame below %rsp, which is dangerous to be corrupted if #NMI
+ * interrupts. And swapgs_restore_regs_and_return_to_usermode() pushing the IRET
+ * frame at the same address is useless.
+ */
+SYM_CODE_START(xenpv_restore_regs_and_return_to_usermode)
+	UNWIND_HINT_REGS
+	POP_REGS
+
+	/* stackleak_erase() can work safely on the kernel stack. */
+	STACKLEAK_ERASE_NOCLOBBER
+
+	addq	$8, %rsp	/* skip regs->orig_ax */
+	jmp xen_iret
+SYM_CODE_END(xenpv_restore_regs_and_return_to_usermode)
+
+/*
  * Xen handles syscall callbacks much like ordinary exceptions, which
  * means we have:
  * - kernel gs
