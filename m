Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0951C4DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381796AbiEEQMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381814AbiEEQMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:12:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2885C84A;
        Thu,  5 May 2022 09:08:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 026A1B82C77;
        Thu,  5 May 2022 16:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBC9C385B1;
        Thu,  5 May 2022 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651766886;
        bh=GqMOPlD2il+wz++dFhS/+qHxm8vwqwgLHG3Z+C7PKFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tk4IUdoljb84CnGejzZkeztjQ+RRB23FxVZGg2yusA8CE1n23mHiIwsjfZ/8+FJXb
         Um1hLc2EJ0W5FidIISbv7eA9/zRx8o224wvU7o6StkpTEXDktZpcyUyZ/9qyfhnjK6
         kFBfE24dIpb5JO9cswPm4eU8r4AcODJupeFxaNhFWLGc2O5y0pHAdxDHgxAq+OpHiH
         M18S55oYQanIe4P+PCKbK05no9gW9o0aOQVJTbW9t3+DdUN48YMgO45bqd7d9hRqkz
         XYn5r22I+pdefFADhDUOO6ig1I2j0Z5BEHhE/50qG3EE0FUv6R7039wkeEfZh7fKQj
         +yN4pQBJwDYSg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
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
        linux-doc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [RFC V3 11/20] rv/monitor: wwnr instrumentation and Makefile/Kconfig entries
Date:   Thu,  5 May 2022 18:06:51 +0200
Message-Id: <7c76c07269319156abdf9f1957f1eaa91320a271.1651766361.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651766361.git.bristot@kernel.org>
References: <cover.1651766361.git.bristot@kernel.org>
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
example of the developer work. It also adds a Makefile and Kconfig
entries.

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
 kernel/trace/rv/Kconfig             |  7 ++++++
 kernel/trace/rv/Makefile            |  1 +
 kernel/trace/rv/monitor_wwnr/wwnr.c | 38 ++++++++++++-----------------
 kernel/trace/rv/monitor_wwnr/wwnr.h |  2 +-
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index f2549cdd2de8..101d565cb53d 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -20,6 +20,13 @@ config RV_MON_WIP
 	  Enable WIP sample monitor, this is a sample monitor that
 	  illustrates the usage of per-cpu monitors.
 
+config RV_MON_WWNR
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
index 20f30741b933..edad01bb2b5d 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_MON_WIP) += monitor_wip/wip.o
+obj-$(CONFIG_RV_MON_WWNR) += monitor_wwnr/wwnr.o
diff --git a/kernel/trace/rv/monitor_wwnr/wwnr.c b/kernel/trace/rv/monitor_wwnr/wwnr.c
index 1ad3365c0d22..7a4b004ac311 100644
--- a/kernel/trace/rv/monitor_wwnr/wwnr.c
+++ b/kernel/trace/rv/monitor_wwnr/wwnr.c
@@ -8,12 +8,9 @@
 #include <rv/instrumentation.h>
 #include <rv/da_monitor.h>
 
-#define MODULE_NAME "wwnr"
+#include <trace/events/sched.h>
 
-/*
- * XXX: include required tracepoint headers, e.g.,
- * #include <linux/trace/events/sched.h>
- */
+#define MODULE_NAME "wwnr"
 
 /*
  * This is the self-generated part of the monitor. Generally, there is no need
@@ -39,25 +36,22 @@ DECLARE_DA_MON_PER_TASK(wwnr, char);
  * are translated into model's event.
  *
  */
-static void handle_switch_in(void *data, /* XXX: fill header */)
+static void handle_switch(void *data, bool preempt, unsigned int prev_state, struct task_struct *p, struct task_struct *n)
 {
-	struct task_struct *p = /* XXX: how do I get p? */;
-	da_handle_event_wwnr(p, switch_in);
-}
+	/* start monitoring only after the first suspension */
+	if (prev_state == TASK_INTERRUPTIBLE)
+		da_handle_init_event_wwnr(p, switch_out);
+	else
+		da_handle_event_wwnr(p, switch_out);
 
-static void handle_switch_out(void *data, /* XXX: fill header */)
-{
-	struct task_struct *p = /* XXX: how do I get p? */;
-	da_handle_event_wwnr(p, switch_out);
+	da_handle_event_wwnr(n, switch_in);
 }
 
-static void handle_wakeup(void *data, /* XXX: fill header */)
+static void handle_wakeup(void *data, struct task_struct *p)
 {
-	struct task_struct *p = /* XXX: how do I get p? */;
 	da_handle_event_wwnr(p, wakeup);
 }
 
-
 static int start_wwnr(void)
 {
 	int retval;
@@ -66,9 +60,8 @@ static int start_wwnr(void)
 	if (retval)
 		return retval;
 
-	rv_attach_trace_probe("wwnr", /* XXX: tracepoint */, handle_switch_in);
-	rv_attach_trace_probe("wwnr", /* XXX: tracepoint */, handle_switch_out);
-	rv_attach_trace_probe("wwnr", /* XXX: tracepoint */, handle_wakeup);
+	rv_attach_trace_probe("wwnr", sched_switch, handle_switch);
+	rv_attach_trace_probe("wwnr", sched_wakeup, handle_wakeup);
 
 	return 0;
 }
@@ -77,9 +70,8 @@ static void stop_wwnr(void)
 {
 	rv_wwnr.enabled = 0;
 
-	rv_detach_trace_probe("wwnr", /* XXX: tracepoint */, handle_switch_in);
-	rv_detach_trace_probe("wwnr", /* XXX: tracepoint */, handle_switch_out);
-	rv_detach_trace_probe("wwnr", /* XXX: tracepoint */, handle_wakeup);
+	rv_detach_trace_probe("wwnr", sched_switch, handle_switch);
+	rv_detach_trace_probe("wwnr", sched_wakeup, handle_wakeup);
 
 	da_monitor_destroy_wwnr();
 }
@@ -89,7 +81,7 @@ static void stop_wwnr(void)
  */
 struct rv_monitor rv_wwnr = {
 	.name = "wwnr",
-	.description = "auto-generated wwnr",
+	.description = "wwnr: wakeup while not running: per-task sample monitor.",
 	.start = start_wwnr,
 	.stop = stop_wwnr,
 	.reset = da_monitor_reset_all_wwnr,
diff --git a/kernel/trace/rv/monitor_wwnr/wwnr.h b/kernel/trace/rv/monitor_wwnr/wwnr.h
index 4af1827d2f16..387f5a83ee7c 100644
--- a/kernel/trace/rv/monitor_wwnr/wwnr.h
+++ b/kernel/trace/rv/monitor_wwnr/wwnr.h
@@ -65,6 +65,6 @@ TRACE_EVENT(error_wwnr,
 
 /* This part ust be outside protection */
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../kernel/trace/rv/monitor_wwnr/
 #define TRACE_INCLUDE_FILE wwnr
 #include <trace/define_trace.h>
-- 
2.35.1

