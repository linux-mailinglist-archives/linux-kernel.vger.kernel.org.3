Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1644D46F6A1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhLIWTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhLIWTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:19:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D5C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:16:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v20-20020a25fc14000000b005c2109e5ad1so12966552ybd.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iFPytGgCXAEsrjhrGa1Z7QyY9naeGPAt+mdu0JuwAhY=;
        b=aC5AbIgBtCmBOawnf8+Eu9jc/bHGwEECFebeAmn2zdnC6Drn0OG23esT8abGXFQWxC
         H0gki52Fna1A0H8wcYimsMqdI0gqDnXdLkzPX/dKG5/Cz4bCKMQ7FIdvCCIgto3W4Ubt
         +eP5iKIkPwOPWks6BsYoZAzWGSUfbBaywd9e86i6IRvOSewWF5OC6qE5NoR/HGEyo/co
         3E1teh7iFX2s+iEx41c/nuWXV3pWkAIhNjme6edBnF1SNthNRuHvEqzP/Q1TCPaGiqVj
         LxSmrIv0CI08iGHkxQSZFk3vxxsfsoG0xDAyqVr1SU3r8e5QFRBOkHfeQ8axygz34ptU
         JDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iFPytGgCXAEsrjhrGa1Z7QyY9naeGPAt+mdu0JuwAhY=;
        b=pShGXm6vE2nJDbWz8nPd+15pYVdsUh4SMvJygWYRrUs2VMEwtVdHcgGZZFm+Va44Fn
         p0doKPofyHW+GVv4J8Lt9a8tsWyB6svtUCagg4cLqEnEKRnc5zhgH0hHFVtVwBMKHBmZ
         i0Q1DsQX/5z2JOWNvU8lfuz7TPU8MfVtV2lANw9v6LWSwjFbVbM/C1S+BykIZ3mwe8h/
         9ZY7EdfkB00G5u1UWwUClesjWF72f01OiK9YKy3DSmgBJR/Uk2FwpMpaoSxU3O5xBbLa
         yZVH/D30jeKhnphqOlwn0y8Khc04MrimedjOAAdfod2iCq0zCi/3SGACRcnFgbT4f7XX
         8ySQ==
X-Gm-Message-State: AOAM532pLTAR4JEfsN+sqXQ2i7wjjBEs2HmtrL7CDuimj4ayIquR0iR2
        /kK6Ad2Qgz2kY6d2ObLsGzdepJM=
X-Google-Smtp-Source: ABdhPJyYB7QYl/yNNSsx3aR3SNfH5iv+4KL2+UlKSeyCz8qdnjzt+Wi/BubxQn+H7Z/MMSL25Tc7YX0=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:f233:e324:8aa0:f65c])
 (user=pcc job=sendgmr) by 2002:a25:c789:: with SMTP id w131mr9854631ybe.227.1639088164465;
 Thu, 09 Dec 2021 14:16:04 -0800 (PST)
Date:   Thu,  9 Dec 2021 14:15:42 -0800
In-Reply-To: <20211209221545.2333249-1-pcc@google.com>
Message-Id: <20211209221545.2333249-6-pcc@google.com>
Mime-Version: 1.0
References: <20211209221545.2333249-1-pcc@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 5/7] arm64: add support for uaccess logging
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 does not use CONFIG_GENERIC_ENTRY, so add the support for
uaccess logging directly to the architecture.

Link: https://linux-review.googlesource.com/id/I88de539fb9c4a9d27fa8cccbe201a6e4382faf89
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
v4:
- remove unnecessary hunk

 arch/arm64/Kconfig                   | 1 +
 arch/arm64/include/asm/thread_info.h | 7 ++++++-
 arch/arm64/kernel/ptrace.c           | 7 +++++++
 arch/arm64/kernel/signal.c           | 5 +++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..6023946abe4a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -161,6 +161,7 @@ config ARM64
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
+	select HAVE_ARCH_UACCESS_BUFFER
 	select HAVE_ARCH_VMAP_STACK
 	select HAVE_ARM_SMCCC
 	select HAVE_ASM_MODVERSIONS
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index e1317b7c4525..0461b36251ea 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -82,6 +82,8 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define TIF_SVE_VL_INHERIT	24	/* Inherit SVE vl_onexec across exec */
 #define TIF_SSBD		25	/* Wants SSB mitigation */
 #define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
+#define TIF_UACCESS_BUFFER_ENTRY 27     /* thread has non-zero uaccess_desc_addr_addr */
+#define TIF_UACCESS_BUFFER_EXIT  28     /* thread has non-zero kcur */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -98,6 +100,8 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define _TIF_SVE		(1 << TIF_SVE)
 #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+#define _TIF_UACCESS_BUFFER_ENTRY	(1 << TIF_UACCESS_BUFFER_ENTRY)
+#define _TIF_UACCESS_BUFFER_EXIT	(1 << TIF_UACCESS_BUFFER_EXIT)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
@@ -106,7 +110,8 @@ int arch_dup_task_struct(struct task_struct *dst,
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
-				 _TIF_SYSCALL_EMU)
+				 _TIF_SYSCALL_EMU | _TIF_UACCESS_BUFFER_ENTRY | \
+				 _TIF_UACCESS_BUFFER_EXIT)
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 88a9034fb9b5..283372eccaeb 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -29,6 +29,7 @@
 #include <linux/regset.h>
 #include <linux/tracehook.h>
 #include <linux/elf.h>
+#include <linux/uaccess-buffer.h>
 
 #include <asm/compat.h>
 #include <asm/cpufeature.h>
@@ -1854,6 +1855,9 @@ int syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, regs->syscallno);
 
+	if (flags & _TIF_UACCESS_BUFFER_ENTRY)
+		uaccess_buffer_syscall_entry();
+
 	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
 			    regs->regs[2], regs->regs[3]);
 
@@ -1866,6 +1870,9 @@ void syscall_trace_exit(struct pt_regs *regs)
 
 	audit_syscall_exit(regs);
 
+	if (flags & _TIF_UACCESS_BUFFER_EXIT)
+		uaccess_buffer_syscall_exit();
+
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 8f6372b44b65..5bbd98e5c257 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -20,6 +20,7 @@
 #include <linux/tracehook.h>
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
+#include <linux/uaccess-buffer.h>
 
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
@@ -919,6 +920,8 @@ static void do_signal(struct pt_regs *regs)
 
 void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 {
+	bool uaccess_buffer_pending = uaccess_buffer_pre_exit_loop();
+
 	do {
 		if (thread_flags & _TIF_NEED_RESCHED) {
 			/* Unmask Debug and SError for the next task */
@@ -950,6 +953,8 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 		local_daif_mask();
 		thread_flags = READ_ONCE(current_thread_info()->flags);
 	} while (thread_flags & _TIF_WORK_MASK);
+
+	uaccess_buffer_post_exit_loop(uaccess_buffer_pending);
 }
 
 unsigned long __ro_after_init signal_minsigstksz;
-- 
2.34.1.173.g76aa8bc2d0-goog

