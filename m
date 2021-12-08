Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F56846CCB3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244320AbhLHEwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244293AbhLHEv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:51:59 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25D7C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 20:48:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d9-20020a251d09000000b005c208092922so2434557ybd.20
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 20:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=efI4VGE3sof2fQql9BlEqQVxwYAZcmtpPH9in/kXoik=;
        b=PuwSA+qIKrc3RQd2I/5ygmWc7LSlVgf/7FLnARGyOSH32W5MessMoD7fplrR1NUuOt
         WcY5c0YgdzFBZNrHX0yc+4sU/Zl8lwHNqu3r/V9rhoIRmJXxpDkAMlDIOEDAf2WcT8vH
         U9BccwTofdXAVLA89oUW+Rmt/lhG9SGvKbvABUEHb8wRN+xZBn6IdIdzKpjjufUyZQCJ
         cNfZFjbqrX0nIynOmq6p8szCPiI/14YEjYzMGQ1ZRG1AaFGZuMpty+0aL1NO3l0P+IoP
         v0ovyLur8nY1+O0ZqghNgpzgH/4vmUfw0ase3ReE0fA3jPzVeOf+yuz6v6uIn8PnpLyZ
         4soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=efI4VGE3sof2fQql9BlEqQVxwYAZcmtpPH9in/kXoik=;
        b=NtQ+6nir2lo5RH6epJdVbPEYsFfcmQJGyW/izb9L2kQa9stxbeOZtikxbgikT5txUg
         MYFCTMjSJgkAplj3IDB1wHozez56t2Qs1DRXaQOx4Bb6C6MhNaoR99z/ntDlyfLK6jCq
         ZycaZYbWrhmIbu/GAmpu5K53mJLy7zkUJ8XVSbcoVaZejJ+GadtsRsabYUoRubATT/DA
         3vaPyS9HM+P/E7uJaTMj5S1uAG+aMlTHFTUu9WU2EnIxqUKqr+tKCwVySLlSB/bGafBt
         CFoBhz1AYatajixoxdRH/NbdbPvfBoyo9f4RkmHxJRdG4sxzyvRhleccDPGN+wdtmJ4x
         PWeA==
X-Gm-Message-State: AOAM533aCYKzgGGnwg545S2ThqQyvMopj0zAOXuAb+rqiWsFglHMEZSm
        Aw0ligDQmqNMBrfoHSLYgrbqyOE=
X-Google-Smtp-Source: ABdhPJxP7dPKK2Ljuj5NjmKRJvgeiWRQ19jHcTiWCxLdBcR4NxN8mBZmENJLbs8PFNf5jy5WQZvu5o8=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:be2d:924d:844b:d2fa])
 (user=pcc job=sendgmr) by 2002:a05:6902:1105:: with SMTP id
 o5mr60159435ybu.519.1638938907050; Tue, 07 Dec 2021 20:48:27 -0800 (PST)
Date:   Tue,  7 Dec 2021 20:48:06 -0800
In-Reply-To: <20211208044808.872554-1-pcc@google.com>
Message-Id: <20211208044808.872554-5-pcc@google.com>
Mime-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 4/6] uaccess-buffer: add CONFIG_GENERIC_ENTRY support
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

Add uaccess logging support on architectures that use
CONFIG_GENERIC_ENTRY (currently only s390 and x86).

Link: https://linux-review.googlesource.com/id/I3c5eb19a7e4a1dbe6095f6971f7826c4b0663f7d
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 arch/Kconfig                 |  6 ++++++
 include/linux/entry-common.h |  2 ++
 include/linux/thread_info.h  |  4 ++++
 kernel/entry/common.c        | 10 ++++++++++
 4 files changed, 22 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index d3c4ab249e9c..c4dcab5279ac 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -31,6 +31,7 @@ config HOTPLUG_SMT
 	bool
 
 config GENERIC_ENTRY
+       select HAVE_ARCH_UACCESS_BUFFER
        bool
 
 config KPROBES
@@ -1312,6 +1313,11 @@ config ARCH_HAS_PARANOID_L1D_FLUSH
 config DYNAMIC_SIGFRAME
 	bool
 
+config HAVE_ARCH_UACCESS_BUFFER
+	bool
+	help
+	  Select if the architecture's syscall entry/exit code supports uaccess buffers.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6140ed..973fcd1d48a3 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -42,12 +42,14 @@
 				 SYSCALL_WORK_SYSCALL_EMU |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
+				 SYSCALL_WORK_UACCESS_BUFFER_ENTRY |	\
 				 ARCH_SYSCALL_WORK_ENTER)
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
 				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
+				 SYSCALL_WORK_UACCESS_BUFFER_EXIT |	\
 				 ARCH_SYSCALL_WORK_EXIT)
 
 /*
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index ad0c4e041030..b0f8ea86967f 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -46,6 +46,8 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SYSCALL_AUDIT,
 	SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
 	SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP,
+	SYSCALL_WORK_BIT_UACCESS_BUFFER_ENTRY,
+	SYSCALL_WORK_BIT_UACCESS_BUFFER_EXIT,
 };
 
 #define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
@@ -55,6 +57,8 @@ enum syscall_work_bit {
 #define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
 #define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
 #define SYSCALL_WORK_SYSCALL_EXIT_TRAP	BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP)
+#define SYSCALL_WORK_UACCESS_BUFFER_ENTRY	BIT(SYSCALL_WORK_BIT_UACCESS_BUFFER_ENTRY)
+#define SYSCALL_WORK_UACCESS_BUFFER_EXIT	BIT(SYSCALL_WORK_BIT_UACCESS_BUFFER_EXIT)
 #endif
 
 #include <asm/thread_info.h>
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d5a61d565ad5..57c4bb01a554 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -6,6 +6,7 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 #include <linux/tick.h>
+#include <linux/uaccess-buffer.h>
 
 #include "common.h"
 
@@ -70,6 +71,9 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 			return ret;
 	}
 
+	if (work & SYSCALL_WORK_UACCESS_BUFFER_ENTRY)
+		uaccess_buffer_syscall_entry();
+
 	/* Either of the above might have changed the syscall number */
 	syscall = syscall_get_nr(current, regs);
 
@@ -197,14 +201,17 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	bool uaccess_buffer_pending;
 
 	lockdep_assert_irqs_disabled();
 
 	/* Flush pending rcuog wakeup before the last need_resched() check */
 	tick_nohz_user_enter_prepare();
 
+	uaccess_buffer_pending = uaccess_buffer_pre_exit_loop();
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
+	uaccess_buffer_post_exit_loop(uaccess_buffer_pending);
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 
@@ -247,6 +254,9 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 
 	audit_syscall_exit(regs);
 
+	if (work & SYSCALL_WORK_UACCESS_BUFFER_EXIT)
+		uaccess_buffer_syscall_exit();
+
 	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
-- 
2.34.1.173.g76aa8bc2d0-goog

