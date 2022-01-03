Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9EF4836EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiACSfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:35:22 -0500
Received: from drummond.us ([74.95.14.229]:40377 "EHLO
        talisker.home.drummond.us" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235705AbiACSfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:35:18 -0500
X-Greylist: delayed 875 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 13:35:12 EST
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 203IKWnj983506;
        Mon, 3 Jan 2022 10:20:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1641234033;
        bh=f6bKazr4Vyn0DnvfqZzgyhTykMFxWyhjSEgJ0jCBDjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4lMRRX8BRd9RmxIQ54Y0iCgerITrvWRZ0kWwIW5uwIYNkFVwOzawIdpalrZ6VEAf
         5tZUMrYbcFa+8X3iJQ3BgeVx9IW7EZnuaIa89s0YfvVoy2zH1ePVhdPKYi+RT2BVsL
         ljGqmYDki79peMJknxxH52oHdir1BVJJdLUSpJTsW1uXaKa2yDi2kHNl8olhisFSIT
         AYPW9bmNWNSbUgtQ4aAUAchkKtVp5DIkO/sNoVrGNs87A37VDvR4A96YjYvaex9YAO
         ftdTrGE2WqM4nrQPzKLN3yKXvPXugWew4M3CceUKmj7ImLWfUSE9tZXrsM7I1czP0l
         u6KO95Ig//NkA==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 203IKWSg983505;
        Mon, 3 Jan 2022 10:20:32 -0800
From:   Walt Drummond <walt@drummond.us>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, Walt Drummond <walt@drummond.us>
Subject: [RFC PATCH 2/8] signals: Put the full signal mask on the signal stack for x86_64, X32 and ia32 compatibility mode
Date:   Mon,  3 Jan 2022 10:19:50 -0800
Message-Id: <20220103181956.983342-3-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103181956.983342-1-walt@drummond.us>
References: <20220103181956.983342-1-walt@drummond.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the complete sigset_t in the real-tme signal stack frame for
x86_64, x32 and ia32 compatibility mode on x86.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 arch/x86/ia32/ia32_signal.c        |  5 +++--
 arch/x86/include/asm/sighandling.h | 34 ++++++++++++++++++++++++++++++
 arch/x86/kernel/signal.c           | 11 +++-------
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 5e3d9b7fd5fb..03a0ecd8c7f3 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -130,7 +130,8 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
+	if (copy_from_user(&set, &frame->uc.uc_sigmask,
+			   sizeof(frame->uc.uc_sigmask)))
 		goto badframe;
 
 	set_current_blocked(&set);
@@ -347,7 +348,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	 */
 	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
 	unsafe_put_sigcontext32(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask, Efault);
+	unsafe_put_compat_sigmask(set, frame, Efault);
 	user_access_end();
 
 	if (__copy_siginfo_to_user32(&frame->info, &ksig->info))
diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index 65e667279e0f..e247bea06a17 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -15,4 +15,38 @@
 
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
 
+static inline int
+__unsafe_put_sigmask(char *set, char __user *fp, size_t size)
+{
+	char *src;
+	char __user *dst;
+	size_t len;
+
+	len = size;
+	src = set;
+	dst = fp;
+	unsafe_copy_loop(dst, src, len, unsigned long, Efault);
+
+	return 0;
+Efault:
+	return -EFAULT;
+}
+
+#define unsafe_put_sigmask(set, frame, label)				\
+do {									\
+	if (__unsafe_put_sigmask((char *) set,				\
+				 (char __user *) &(frame)->uc.uc_sigmask, \
+				 sizeof(sigset_t)))			\
+		goto label;						\
+} while (0)
+
+#define unsafe_put_compat_sigmask(set, frame, label)			\
+do {									\
+	if (__unsafe_put_sigmask((char *) set,				\
+				 (char __user *) &(frame)->uc.uc_sigmask, \
+				 sizeof(compat_sigset_t)))		\
+		goto label;						\
+} while (0)
+
+
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index f4d21e470083..bb5f3f39c412 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -203,11 +203,6 @@ do {									\
 		goto label;						\
 } while(0);
 
-#define unsafe_put_sigmask(set, frame, label) \
-	unsafe_put_user(*(__u64 *)(set), \
-			(__u64 __user *)&(frame)->uc.uc_sigmask, \
-			label)
-
 /*
  * Set up a signal frame.
  */
@@ -587,7 +582,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 	restorer = ksig->ka.sa.sa_restorer;
 	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
 	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_sigmask(set, frame, Efault);
+	unsafe_put_compat_sigmask(set, frame, Efault);
 	user_access_end();
 
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
@@ -664,7 +659,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
+	if (copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(sigset_t)))
 		goto badframe;
 	if (__get_user(uc_flags, &frame->uc.uc_flags))
 		goto badframe;
@@ -922,7 +917,7 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
+	if (copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(compat_sigset_t)))
 		goto badframe;
 	if (__get_user(uc_flags, &frame->uc.uc_flags))
 		goto badframe;
-- 
2.30.2

