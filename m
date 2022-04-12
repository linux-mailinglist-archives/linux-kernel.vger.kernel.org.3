Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F93F4FE1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356158AbiDLNI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356980AbiDLNEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:04:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573F539B8C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:48:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bg24so5982112pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBWFAF/XPapM1EK+gmdZ5oUq3bsgCRTxORe+fGjXmTg=;
        b=hS5tvpYdRrcQrLpo6fyXay4Ko5tB5b0Tk9kxF6AXKdzCyRXRoKXlRtxnU0LPrXzC2T
         RVrBLWWd7e5dI5mwyLXJfdQOLRQ//pBARSuvuIAsUb5g2IxgOjr9QCmNueWBYCULomA8
         JI0C1mUlAXbCR9eLQBpFpfhJOQqV0yvnJb3pFmJ+s16ppdIZVkB2ds8cI3pf65QacvAH
         MwIQEUA1PjaP3S/rvKF7GavLtSJ7gdJWbWt1zRMQm/Muu1YuL8TxSDjlIfq3RQXNXLyf
         WY0a+kjOgpq7UvXsef0O5WHaQxgE04XbXEBmlHn1C2FVjiuI2V5pHcLuhbk8IBpg3pEn
         sGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBWFAF/XPapM1EK+gmdZ5oUq3bsgCRTxORe+fGjXmTg=;
        b=Q4xRjOrtGbxA7vsgBzXXTZlk7+gK2qcLRyTno3EazF+0V7G3B4dfUV0QGCyVtKeOGh
         p88tdY/51rifAx/vcm6ITPAgoT7O+jf5APDiSEJUYRLJsy6BoHzNgaMiOp9SXNYJ2q6A
         Pba0dvdYdyI91rVaWhehVwwR2hBO2XbknXR3c7cBckdBFSdqn+pBeecMCGcbk8Tk/i/6
         VhZWDdAnTxALftQlQ8zWr1fs/mdTac8qSNE9d8CqbolBgzH+9c2y96H7ogIVpkmxHLil
         keHUQOX7NpBPGA4glhPT8dbHVHlTTdgL3uITH2heLP1LfTjYqf7t+PuVgiz8RYndHOJS
         tVqQ==
X-Gm-Message-State: AOAM530Wn88OWEjTVBt9bSvtCEsaBkhglCp60xe8VjRMXYM/LpFi1NKd
        1DMKkj7hBjq51hzC4JTIr8qmCzWyG9c=
X-Google-Smtp-Source: ABdhPJw9nAilFk9LEP5VDPn8u/Q1uNGHuCf5UWZLKTzXDnHNJJE78DTtE3aajXwFTiKfSlgWF+YjvA==
X-Received: by 2002:a17:902:c94d:b0:158:4e50:7a32 with SMTP id i13-20020a170902c94d00b001584e507a32mr13357373pla.163.1649767702559;
        Tue, 12 Apr 2022 05:48:22 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id n24-20020aa79058000000b00505686a982asm17899192pfo.125.2022.04.12.05.48.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:48:22 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH V2] x86/sev: Mark the code returning to user space as syscall gap
Date:   Tue, 12 Apr 2022 20:49:08 +0800
Message-Id: <20220412124909.10467-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

When returning to user space, the %rsp is user controlled value.

If it is SNP-guest and the hypervisor decides to mess with the code-page
for this path while a CPU is executing it.  This will cause a #VC on
that CPU and that could hit in the syscall return path and mislead
the #VC handler.

So make ip_within_syscall_gap() return true in this case.

Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
[V1]: https://lore.kernel.org/lkml/20211213042215.3096-4-jiangshanlai@gmail.com/

Changed from V1:
	Update changelog.

 arch/x86/entry/entry_64.S        | 2 ++
 arch/x86/entry/entry_64_compat.S | 2 ++
 arch/x86/include/asm/proto.h     | 4 ++++
 arch/x86/include/asm/ptrace.h    | 4 ++++
 4 files changed, 12 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4faac48ebec5..4f678b6045cd 100644
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
index 4fdb007cddbd..3c0e14960e2b 100644
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
index 0f899c8d7a4e..647d71535ce3 100644
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
index 4357e0f2cd5f..f4db78b09c8f 100644
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
-- 
2.19.1.6.gb485710b

