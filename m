Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2C852CF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiESJTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiESJTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:19:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1635D655;
        Thu, 19 May 2022 02:19:22 -0700 (PDT)
Date:   Thu, 19 May 2022 09:19:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652951960;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OogGodAJ/EfN+S1wVJQ/owg91eLh2YYZVD9UPkSJkmE=;
        b=4PR439hRQc/ZLWDst1YwoTdgyk1s59A5DbOx5l4Vk80R1ozK6Xsz5ZliaulVwJ5JWrx+M1
        IlnsqZhL9m8TdHs43LXomRsp3pcl8zPYYEHkVx8pJtMlwxvdQQ+JW3aGeyxfWBAHA/eCB6
        ESknoNWEXPIOFzxEh+GNXXQqpqcwrCq2l5Iq+7boAIxl62BHxoNZY7yPQtz2382Efka/4O
        ftOycQvNVr90CNo1NrWsg419gO/+as83p6yBbLjuNEiST/M8oUyCQmXT/Si5k2J9G9maH4
        NlfWn0R61RO1RLQl8uWjJBdCS4hgAFHbbBNWjIs5Xd3452LI5h+ezU27KwJJYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652951960;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OogGodAJ/EfN+S1wVJQ/owg91eLh2YYZVD9UPkSJkmE=;
        b=t5qD3YA5Q87to+VxqKTAkP1oZ+dnBzmaxGdzEDUzbIZ6lzpgkPaeWsCH7tefdGrKifWq4I
        SRlCP0Yd4xkE2wDw==
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Mark the code returning to user space as syscall gap
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Borislav Petkov <bp@suse.de>, Joerg Roedel <jroedel@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220412124909.10467-1-jiangshanlai@gmail.com>
References: <20220412124909.10467-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Message-ID: <165295195868.4207.8139978466736431186.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     47f33de4aafb2f5e43d480d590a939d0f1d566a9
Gitweb:        https://git.kernel.org/tip/47f33de4aafb2f5e43d480d590a939d0f1d566a9
Author:        Lai Jiangshan <jiangshan.ljs@antgroup.com>
AuthorDate:    Tue, 12 Apr 2022 20:49:08 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 19 May 2022 10:56:46 +02:00

x86/sev: Mark the code returning to user space as syscall gap

When returning to user space, %rsp is user-controlled value.

If it is a SNP-guest and the hypervisor decides to mess with the
code-page for this path while a CPU is executing it, a potential #VC
could hit in the syscall return path and mislead the #VC handler.

So make ip_within_syscall_gap() return true in this case.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20220412124909.10467-1-jiangshanlai@gmail.com
---
 arch/x86/entry/entry_64.S        | 2 ++
 arch/x86/entry/entry_64_compat.S | 2 ++
 arch/x86/include/asm/proto.h     | 4 ++++
 arch/x86/include/asm/ptrace.h    | 4 ++++
 4 files changed, 12 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f7bd800..2fd8a5c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -215,8 +215,10 @@ syscall_return_via_sysret:
 
 	popq	%rdi
 	popq	%rsp
+SYM_INNER_LABEL(entry_SYSRETQ_unsafe_stack, SYM_L_GLOBAL)
 	swapgs
 	sysretq
+SYM_INNER_LABEL(entry_SYSRETQ_end, SYM_L_GLOBAL)
 SYM_CODE_END(entry_SYSCALL_64)
 
 /*
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4fdb007..3c0e149 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -297,6 +297,7 @@ sysret32_from_system_call:
 	 * code.  We zero R8-R10 to avoid info leaks.
          */
 	movq	RSP-ORIG_RAX(%rsp), %rsp
+SYM_INNER_LABEL(entry_SYSRETL_compat_unsafe_stack, SYM_L_GLOBAL)
 
 	/*
 	 * The original userspace %rsp (RSP-ORIG_RAX(%rsp)) is stored
@@ -314,6 +315,7 @@ sysret32_from_system_call:
 	xorl	%r10d, %r10d
 	swapgs
 	sysretl
+SYM_INNER_LABEL(entry_SYSRETL_compat_end, SYM_L_GLOBAL)
 SYM_CODE_END(entry_SYSCALL_compat)
 
 /*
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index feed36d..f042cfc 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -13,6 +13,8 @@ void syscall_init(void);
 #ifdef CONFIG_X86_64
 void entry_SYSCALL_64(void);
 void entry_SYSCALL_64_safe_stack(void);
+void entry_SYSRETQ_unsafe_stack(void);
+void entry_SYSRETQ_end(void);
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 #endif
 
@@ -28,6 +30,8 @@ void entry_SYSENTER_compat(void);
 void __end_entry_SYSENTER_compat(void);
 void entry_SYSCALL_compat(void);
 void entry_SYSCALL_compat_safe_stack(void);
+void entry_SYSRETL_compat_unsafe_stack(void);
+void entry_SYSRETL_compat_end(void);
 void entry_INT80_compat(void);
 #ifdef CONFIG_XEN_PV
 void xen_entry_INT80_compat(void);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 4357e0f..f4db78b 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -186,9 +186,13 @@ static __always_inline bool ip_within_syscall_gap(struct pt_regs *regs)
 	bool ret = (regs->ip >= (unsigned long)entry_SYSCALL_64 &&
 		    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack);
 
+	ret = ret || (regs->ip >= (unsigned long)entry_SYSRETQ_unsafe_stack &&
+		      regs->ip <  (unsigned long)entry_SYSRETQ_end);
 #ifdef CONFIG_IA32_EMULATION
 	ret = ret || (regs->ip >= (unsigned long)entry_SYSCALL_compat &&
 		      regs->ip <  (unsigned long)entry_SYSCALL_compat_safe_stack);
+	ret = ret || (regs->ip >= (unsigned long)entry_SYSRETL_compat_unsafe_stack &&
+		      regs->ip <  (unsigned long)entry_SYSRETL_compat_end);
 #endif
 
 	return ret;
