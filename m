Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB846F6A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhLIWTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbhLIWTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:19:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90629C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:16:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so13096659ybj.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FqrxnquBZTtko9BgXrPYz8OM9HQeZt54ZJSaNv8spPQ=;
        b=jQlgqpqABmoSDMhC0f6Qnl7fD27iyQFDbN5T3LT3Lqxa6lEVdKbUcNYfBhPXkY45rU
         BXcZKwud2NUlWZ3kU1dYlexeBjY51JW4XuxO2VAWGDwDv8LZfKHrHvAwxW6I77JxMoek
         TpP2g0OWY8LDi4kr05Sj8id/av85FV+Dd2QpNlGmPpBI5o6HrF9GPUlPWjrW8crWSEVq
         8vK3/T7G/GLj0fOEsDL11ZAldUawwtlrUjC3Rb9PrFBlAXnxQCRK9aLzK8TQQTMI/EJq
         Ih86fCRJuVBphQCEWO4vHu+S/JhBEHf8M9Nd1VnQrbXIInApfvisvBMyZE+kCod1MAqJ
         AnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FqrxnquBZTtko9BgXrPYz8OM9HQeZt54ZJSaNv8spPQ=;
        b=ypdgQpmBS/o9b4VK5xZQh9/clm2xWKZ5V4YnhdhVhv55kYBv3xuUMpYrBopXnCH076
         Tr7JkGzAupfFk9NFCISLbjxqwqg76STZ+easKNed3KEv7AfhB9AVTBhmISgEaVS2u3u/
         gtO/+fu5dEupZJvxghftIMqUMMjkAuIRAohpE2RCFYZONId8QAdM8rLYRAmVi0KBUs0V
         UkQil5f9j9ryYXDwosr+gdHbc3YfR9uACLcggM+ecHtp1sOg9OusuWrnNk2d2z84SIgu
         KkwND+Xszmix+FVbq/LQ2gHiXnZS43GvrjEnmMZJpoOL9BVlQm5Q/kX65FdJa9VMbr7e
         Jrwg==
X-Gm-Message-State: AOAM530puU3gdQfWdfEpdTeNyUjh7beAFPNFxLmlgZMh9cNLmMh4TWfH
        d8KwJDgHxIZNOMSd512G0yinUGI=
X-Google-Smtp-Source: ABdhPJz7A/DINf05BcsrLAG8T6qlShSq6crx7l0ZreU7rhk+PSIj2ScgiWw65k8/EeZ03uva6ksbsbA=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:f233:e324:8aa0:f65c])
 (user=pcc job=sendgmr) by 2002:a25:69c1:: with SMTP id e184mr9817470ybc.235.1639088161742;
 Thu, 09 Dec 2021 14:16:01 -0800 (PST)
Date:   Thu,  9 Dec 2021 14:15:41 -0800
In-Reply-To: <20211209221545.2333249-1-pcc@google.com>
Message-Id: <20211209221545.2333249-5-pcc@google.com>
Mime-Version: 1.0
References: <20211209221545.2333249-1-pcc@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 4/7] uaccess-buffer: add CONFIG_GENERIC_ENTRY support
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
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
v4:
- move pre/post-exit-loop calls into if statement

 arch/Kconfig                 |  1 +
 include/linux/entry-common.h |  2 ++
 include/linux/thread_info.h  |  4 ++++
 kernel/entry/common.c        | 14 +++++++++++++-
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 17819f53ea80..bc849a61b636 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -31,6 +31,7 @@ config HOTPLUG_SMT
 	bool
 
 config GENERIC_ENTRY
+       select HAVE_ARCH_UACCESS_BUFFER
        bool
 
 config KPROBES
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
index d5a61d565ad5..59ec6e3f793b 100644
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
 
@@ -197,14 +201,19 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	bool uaccess_buffer_pending;
 
 	lockdep_assert_irqs_disabled();
 
 	/* Flush pending rcuog wakeup before the last need_resched() check */
 	tick_nohz_user_enter_prepare();
 
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
+	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK)) {
+		bool uaccess_buffer_pending = uaccess_buffer_pre_exit_loop();
+
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
+		uaccess_buffer_post_exit_loop(uaccess_buffer_pending);
+	}
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 
@@ -247,6 +256,9 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 
 	audit_syscall_exit(regs);
 
+	if (work & SYSCALL_WORK_UACCESS_BUFFER_EXIT)
+		uaccess_buffer_syscall_exit();
+
 	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
-- 
2.34.1.173.g76aa8bc2d0-goog

