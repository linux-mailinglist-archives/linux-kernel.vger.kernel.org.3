Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38B85261E0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380263AbiEMMaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350172AbiEMMaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:30:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCF14249A;
        Fri, 13 May 2022 05:30:13 -0700 (PDT)
Date:   Fri, 13 May 2022 12:30:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652445010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPQ2hW+g443c1/58m1zWtLBd/8L9CEje+od8ufelfyU=;
        b=O0a1SR3TXVJGd8p4VzQmk7Ee40+s1cji9+p+2ccrqrD3rlr2oEIX8++TzWAKVL0d8rqL41
        DNTQCQLc8p3j6ORgeK9sX19bPGSalybZEx/l4qVT8uNMU/6x1CmFjC9kOpQkY1GSGPepPW
        CxRmMPdesVaj5sMLDL6/s5oVd32GapVt2I2CWAGscM9pwUkYEg9Ha6XCQMKSsvjOt6p7ex
        yhENC+Jc5nqZOtJXW8UawLudY/FZpfES7uRtfLm4PaVyaF6fa1u95PJBiYAYFgUZ+xM2QG
        IaaN4ldXwWrLBmVpQTNzfp+wbwzqR3xJNO3ZXsmwi5dTkcZetNxu/QAqaaZ87w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652445010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPQ2hW+g443c1/58m1zWtLBd/8L9CEje+od8ufelfyU=;
        b=vFI8vIWzpXYFoeLyW6FvbG9Gg/id3iMpb9pRTxAYVdUSP8NV1+lDBVkygOF9k56Ri60iOL
        KikmF7MLxRNWI1Cg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/prctl: Remove pointless task argument
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87lev7vtxj.ffs@tglx>
References: <87lev7vtxj.ffs@tglx>
MIME-Version: 1.0
Message-ID: <165244500878.4207.14888343701387601439.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     f5c0b4f30416c670408a77be94703d04d22b57df
Gitweb:        https://git.kernel.org/tip/f5c0b4f30416c670408a77be94703d04d22b57df
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 12 May 2022 14:04:08 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 13 May 2022 12:56:28 +02:00

x86/prctl: Remove pointless task argument

The functions invoked via do_arch_prctl_common() can only operate on
the current task and none of these function uses the task argument.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/87lev7vtxj.ffs@tglx
---
 arch/x86/include/asm/fpu/api.h |  3 +--
 arch/x86/include/asm/proto.h   |  3 +--
 arch/x86/kernel/fpu/xstate.c   |  5 +----
 arch/x86/kernel/process.c      |  9 ++++-----
 arch/x86/kernel/process_32.c   |  2 +-
 arch/x86/kernel/process_64.c   |  4 ++--
 6 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index c83b302..6b0f31f 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -162,7 +162,6 @@ static inline bool fpstate_is_confidential(struct fpu_guest *gfpu)
 }
 
 /* prctl */
-struct task_struct;
-extern long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg2);
+extern long fpu_xstate_prctl(int option, unsigned long arg2);
 
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index feed36d..80be803 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -39,7 +39,6 @@ void x86_report_nx(void);
 
 extern int reboot_force;
 
-long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long arg2);
+long do_arch_prctl_common(int option, unsigned long arg2);
 
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 39e1c86..1b016a1 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1687,16 +1687,13 @@ EXPORT_SYMBOL_GPL(xstate_get_guest_group_perm);
  * e.g. for AMX which requires XFEATURE_XTILE_CFG(17) and
  * XFEATURE_XTILE_DATA(18) this would be XFEATURE_XTILE_DATA(18).
  */
-long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg2)
+long fpu_xstate_prctl(int option, unsigned long arg2)
 {
 	u64 __user *uptr = (u64 __user *)arg2;
 	u64 permitted, supported;
 	unsigned long idx = arg2;
 	bool guest = false;
 
-	if (tsk != current)
-		return -EPERM;
-
 	switch (option) {
 	case ARCH_GET_XCOMP_SUPP:
 		supported = fpu_user_cfg.max_features |	fpu_user_cfg.legacy_features;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b3d2d41..e86d09a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -334,7 +334,7 @@ static int get_cpuid_mode(void)
 	return !test_thread_flag(TIF_NOCPUID);
 }
 
-static int set_cpuid_mode(struct task_struct *task, unsigned long cpuid_enabled)
+static int set_cpuid_mode(unsigned long cpuid_enabled)
 {
 	if (!boot_cpu_has(X86_FEATURE_CPUID_FAULT))
 		return -ENODEV;
@@ -985,20 +985,19 @@ unsigned long __get_wchan(struct task_struct *p)
 	return addr;
 }
 
-long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long arg2)
+long do_arch_prctl_common(int option, unsigned long arg2)
 {
 	switch (option) {
 	case ARCH_GET_CPUID:
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
-		return set_cpuid_mode(task, arg2);
+		return set_cpuid_mode(arg2);
 	case ARCH_GET_XCOMP_SUPP:
 	case ARCH_GET_XCOMP_PERM:
 	case ARCH_REQ_XCOMP_PERM:
 	case ARCH_GET_XCOMP_GUEST_PERM:
 	case ARCH_REQ_XCOMP_GUEST_PERM:
-		return fpu_xstate_prctl(task, option, arg2);
+		return fpu_xstate_prctl(option, arg2);
 	}
 
 	return -EINVAL;
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 26edb1c..0faa5e2 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -222,5 +222,5 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
-	return do_arch_prctl_common(current, option, arg2);
+	return do_arch_prctl_common(option, arg2);
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e459253..1962008 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -844,7 +844,7 @@ SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 
 	ret = do_arch_prctl_64(current, option, arg2);
 	if (ret == -EINVAL)
-		ret = do_arch_prctl_common(current, option, arg2);
+		ret = do_arch_prctl_common(option, arg2);
 
 	return ret;
 }
@@ -852,7 +852,7 @@ SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 #ifdef CONFIG_IA32_EMULATION
 COMPAT_SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
-	return do_arch_prctl_common(current, option, arg2);
+	return do_arch_prctl_common(option, arg2);
 }
 #endif
 
