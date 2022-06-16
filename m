Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E123C54DD46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359786AbiFPIrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359719AbiFPIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:46:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6900E5DBE3;
        Thu, 16 Jun 2022 01:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 142C6B822A7;
        Thu, 16 Jun 2022 08:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F85C36AE3;
        Thu, 16 Jun 2022 08:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369166;
        bh=q2Nr0Do4T+VNYLHE7CNjZGMYVNS+vUVZnmunR/+50Bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJVathLlY3OD6ZpvCxIhusEa0wKl7DfZl2hmahA85dBfvkwSZMRr848G5H3M/D3I4
         WYLpEnGcX9vbipHbR6zdmVE7tckIrY1MqK8Zb2BMfZ29RDwK8C4izI5Dn7Q0LXFzih
         etj5tlof1DhAz74Jcw43VJwu19gSSc6ph8UbQPwyBVZSTJQKpg5bJqmhnSy+pt98GK
         y/zyUYcbgEIt/FyWVIUgpDzJJfoVwBio2itHw2AimTVWGGawPr6rGnbGgDeW9fythz
         WeIKDZC1Lq/iLIRisM2vovWbP1v8fNBRc7IgE11nlBUjHU6utqR+AWXoX9Ryc1uxUH
         vLduASJbhVUuA==
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
Subject: [PATCH V4 11/20] rv/monitor: wwnr instrumentation and Makefile/Kconfig entries
Date:   Thu, 16 Jun 2022 10:44:53 +0200
Message-Id: <944694879f67c0e635815ac57154be477a1b9108.1655368610.git.bristot@kernel.org>
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

Adds the instrumentation to the previously created wwnr monitor, as an
example of the developer work. It also adds a Makefile, Kconfig and
tracepoint entries.

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
 include/trace/events/rv.h            | 12 +++++++++
 kernel/trace/rv/Kconfig              |  8 ++++++
 kernel/trace/rv/Makefile             |  1 +
 kernel/trace/rv/monitors/wwnr/wwnr.c | 38 ++++++++++++----------------
 4 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/include/trace/events/rv.h b/include/trace/events/rv.h
index 4e0dabffcf29..00f11a8dac3b 100644
--- a/include/trace/events/rv.h
+++ b/include/trace/events/rv.h
@@ -122,6 +122,18 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 		__entry->event,
 		__entry->state)
 );
+
+#ifdef CONFIG_RV_MON_WWNR
+/* id is the pid of the task */
+DEFINE_EVENT(event_da_monitor_id, event_wwnr,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool safe),
+	     TP_ARGS(id, state, event, next_state, safe));
+
+DEFINE_EVENT(error_da_monitor_id, error_wwnr,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+#endif /* CONFIG_RV_MON_WWNR */
+
 #endif /* CONFIG_DA_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
 
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index e9246b0bec9d..fba2ace2a22b 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -34,6 +34,14 @@ config RV_MON_WIP
 	  Enable WIP sample monitor, this is a sample monitor that
 	  illustrates the usage of per-cpu monitors.
 
+config RV_MON_WWNR
+	select DA_MON_EVENTS_ID
+	bool "WWNR monitor"
+	help
+	  Enable WWNR sample monitor, this is a sample monitor that
+	  illustrates the usage of per-task monitor. The model is
+	  broken on purpose: it serves to test reactors.
+
 config RV_REACTORS
 	bool "Runtime verification reactors"
 	default y if RV
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index b41109d2750a..af0ff9a46418 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
+obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
index 8ba01f0f0df8..3fe1ad9125d3 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -10,11 +10,8 @@
 
 #define MODULE_NAME "wwnr"
 
-/*
- * XXX: include required tracepoint headers, e.g.,
- * #include <linux/trace/events/sched.h>
- */
 #include <trace/events/rv.h>
+#include <trace/events/sched.h>
 
 /*
  * This is the self-generated part of the monitor. Generally, there is no need
@@ -37,21 +34,20 @@ DECLARE_DA_MON_PER_TASK(wwnr, char);
  * are translated into model's event.
  *
  */
-static void handle_switch_in(void *data, /* XXX: fill header */)
+static void handle_switch(void *data, bool preempt, struct task_struct *p,
+			  struct task_struct *n, unsigned int prev_state)
 {
-	struct task_struct *p = /* XXX: how do I get p? */;
-	da_handle_event_wwnr(p, switch_in_wwnr);
-}
+	/* start monitoring only after the first suspension */
+	if (prev_state == TASK_INTERRUPTIBLE)
+		da_handle_init_event_wwnr(p, switch_out_wwnr);
+	else
+		da_handle_event_wwnr(p, switch_out_wwnr);
 
-static void handle_switch_out(void *data, /* XXX: fill header */)
-{
-	struct task_struct *p = /* XXX: how do I get p? */;
-	da_handle_event_wwnr(p, switch_out_wwnr);
+	da_handle_event_wwnr(n, switch_in_wwnr);
 }
 
-static void handle_wakeup(void *data, /* XXX: fill header */)
+static void handle_wakeup(void *data, struct task_struct *p)
 {
-	struct task_struct *p = /* XXX: how do I get p? */;
 	da_handle_event_wwnr(p, wakeup_wwnr);
 }
 
@@ -63,9 +59,8 @@ static int start_wwnr(void)
 	if (retval)
 		return retval;
 
-	rv_attach_trace_probe("wwnr", /* XXX: tracepoint */, handle_switch_in);
-	rv_attach_trace_probe("wwnr", /* XXX: tracepoint */, handle_switch_out);
-	rv_attach_trace_probe("wwnr", /* XXX: tracepoint */, handle_wakeup);
+	rv_attach_trace_probe("wwnr", sched_switch, handle_switch);
+	rv_attach_trace_probe("wwnr", sched_wakeup, handle_wakeup);
 
 	return 0;
 }
@@ -74,9 +69,8 @@ static void stop_wwnr(void)
 {
 	rv_wwnr.enabled = 0;
 
-	rv_detach_trace_probe("wwnr", /* XXX: tracepoint */, handle_switch_in);
-	rv_detach_trace_probe("wwnr", /* XXX: tracepoint */, handle_switch_out);
-	rv_detach_trace_probe("wwnr", /* XXX: tracepoint */, handle_wakeup);
+	rv_detach_trace_probe("wwnr", sched_switch, handle_switch);
+	rv_detach_trace_probe("wwnr", sched_wakeup, handle_wakeup);
 
 	da_monitor_destroy_wwnr();
 }
@@ -111,5 +105,5 @@ module_init(register_wwnr);
 module_exit(unregister_wwnr);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("dot2k: auto-generated");
-MODULE_DESCRIPTION("wwnr");
+MODULE_AUTHOR("Daniel Bristot de Oliveira <bristot@kernel.org>");
+MODULE_DESCRIPTION("wwnr: wakeup while not running monitor.");
-- 
2.35.1

