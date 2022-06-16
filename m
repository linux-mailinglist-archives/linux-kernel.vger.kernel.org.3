Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3B554DD49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359851AbiFPIqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359808AbiFPIqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:46:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942F75DBD4;
        Thu, 16 Jun 2022 01:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF2D161D78;
        Thu, 16 Jun 2022 08:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A16C34114;
        Thu, 16 Jun 2022 08:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369157;
        bh=qa1UKmJJVTSGhHfJiyJQ35RQtbOYfyr8tjVSosqFRI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNTXaE51gCqcnturGqLHl03q4uwui54XPP1ZRunXdI588fO5i9Km1cpq8PlONqyBv
         qAhgRJG8uwnNgQkpPaaMjbxKeeUB8qkGCKrXzAPbm2JDfXMjL1APBs89Uj2GdJrrPp
         flfxYjyk+viWPo7MBMc5U8pcHei5obaMryY59Yv+fGwQJQtkkQuFJu5vLRw06ENRbU
         KtqkfMzHjM6VsHf852HzaIv+Gj3uhXXHIbzDeYThwA7EhlPyvClaVHiVRVVee/dPvP
         Z6ftb6nesFl/wVSAo53Ij5Whf1KmlkhSd6OILkEVChrl8eAZER+Kvf9JHTdJTAhkhg
         y3hgbdvWWTGng==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V4 09/20] rv/monitor: wip instrumentation and Makefile/Kconfig entries
Date:   Thu, 16 Jun 2022 10:44:51 +0200
Message-Id: <9c05a95927c18bebcf0eb79bef15ec59667bc08c.1655368610.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the instrumentation to the previously created wip monitor, as an
example of the developer work. It also adds a Makefile, Kconfig and
tracepoint entries.

This is a good example of the manual work that is left for the
developer to do.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/trace/events/rv.h          | 10 ++++++++++
 kernel/trace/rv/Kconfig            |  7 +++++++
 kernel/trace/rv/Makefile           |  1 +
 kernel/trace/rv/monitors/wip/wip.c | 30 ++++++++++++++----------------
 4 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/include/trace/events/rv.h b/include/trace/events/rv.h
index 9f40f2a49f84..4e0dabffcf29 100644
--- a/include/trace/events/rv.h
+++ b/include/trace/events/rv.h
@@ -56,6 +56,16 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 		__entry->event,
 		__entry->state)
 );
+
+#ifdef CONFIG_RV_MON_WIP
+DEFINE_EVENT(event_da_monitor, event_wip,
+	    TP_PROTO(char *state, char *event, char *next_state, bool safe),
+	    TP_ARGS(state, event, next_state, safe));
+
+DEFINE_EVENT(error_da_monitor, error_wip,
+	     TP_PROTO(char *state, char *event),
+	     TP_ARGS(state, event));
+#endif /* CONFIG_RV_MON_WIP */
 #endif /* CONFIG_DA_MON_EVENTS_IMPLICIT */
 
 #ifdef CONFIG_DA_MON_EVENTS_ID
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 1eafb5adcfcb..e9246b0bec9d 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -26,6 +26,13 @@ menuconfig RV
 	  the system behavior.
 
 if RV
+config RV_MON_WIP
+	depends on PREEMPTIRQ_TRACEPOINTS
+	select DA_MON_EVENTS_IMPLICIT
+	bool "WIP monitor"
+	help
+	  Enable WIP sample monitor, this is a sample monitor that
+	  illustrates the usage of per-cpu monitors.
 
 config RV_REACTORS
 	bool "Runtime verification reactors"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 8944274d9b41..b41109d2750a 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
+obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index 08950e09b823..123827db0a03 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -10,11 +10,9 @@
 
 #define MODULE_NAME "wip"
 
-/*
- * XXX: include required tracepoint headers, e.g.,
- * #include <linux/trace/events/sched.h>
- */
 #include <trace/events/rv.h>
+#include <trace/events/sched.h>
+#include <trace/events/preemptirq.h>
 
 /*
  * This is the self-generated part of the monitor. Generally, there is no need
@@ -37,17 +35,17 @@ DECLARE_DA_MON_PER_CPU(wip, char);
  * are translated into model's event.
  *
  */
-static void handle_preempt_disable(void *data, /* XXX: fill header */)
+static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
 {
 	da_handle_event_wip(preempt_disable_wip);
 }
 
-static void handle_preempt_enable(void *data, /* XXX: fill header */)
+static void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_wip(preempt_enable_wip);
+	da_handle_init_event_wip(preempt_enable_wip);
 }
 
-static void handle_sched_waking(void *data, /* XXX: fill header */)
+static void handle_sched_waking(void *data, struct task_struct *task)
 {
 	da_handle_event_wip(sched_waking_wip);
 }
@@ -60,9 +58,9 @@ static int start_wip(void)
 	if (retval)
 		return retval;
 
-	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_disable);
-	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_enable);
-	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_sched_waking);
+	rv_attach_trace_probe("wip", preempt_disable, handle_preempt_disable);
+	rv_attach_trace_probe("wip", preempt_enable, handle_preempt_enable);
+	rv_attach_trace_probe("wip", sched_waking, handle_sched_waking);
 
 	return 0;
 }
@@ -71,9 +69,9 @@ static void stop_wip(void)
 {
 	rv_wip.enabled = 0;
 
-	rv_detach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_disable);
-	rv_detach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_enable);
-	rv_detach_trace_probe("wip", /* XXX: tracepoint */, handle_sched_waking);
+	rv_detach_trace_probe("wip", preempt_disable, handle_preempt_disable);
+	rv_detach_trace_probe("wip", preempt_enable, handle_preempt_enable);
+	rv_detach_trace_probe("wip", sched_waking, handle_sched_waking);
 
 	da_monitor_destroy_wip();
 }
@@ -108,5 +106,5 @@ module_init(register_wip);
 module_exit(unregister_wip);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("dot2k: auto-generated");
-MODULE_DESCRIPTION("wip");
+MODULE_AUTHOR("Daniel Bristot de Oliveira <bristot@kernel.org>");
+MODULE_DESCRIPTION("wip: wakeup in preemptive - per-cpu sample monitor.");
-- 
2.35.1

