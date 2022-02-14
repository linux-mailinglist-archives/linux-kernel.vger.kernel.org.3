Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3654B4E15
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350825AbiBNLWk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:22:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350974AbiBNLVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:21:48 -0500
X-Greylist: delayed 720 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 02:58:01 PST
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2C9426131
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:58:01 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-AzviTLmfNnyoGdmvJAGjjA-1; Mon, 14 Feb 2022 05:47:15 -0500
X-MC-Unique: AzviTLmfNnyoGdmvJAGjjA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFF7E814245;
        Mon, 14 Feb 2022 10:47:13 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 976C026DFB;
        Mon, 14 Feb 2022 10:47:03 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [RFC V2 11/21] rv/monitor: wwnr instrumentation and Makefile/Kconfig entries
Date:   Mon, 14 Feb 2022 11:45:02 +0100
Message-Id: <54803ae2333e001dbe46ea9fa9f1d5064e6f0db6.1644830251.git.bristot@kernel.org>
In-Reply-To: <cover.1644830251.git.bristot@kernel.org>
References: <cover.1644830251.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
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
 kernel/trace/rv/monitor_wwnr/wwnr.c | 35 +++++++++++++----------------
 kernel/trace/rv/monitor_wwnr/wwnr.h |  2 +-
 4 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 7338e661d78f..f2d0bed05a55 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -20,6 +20,13 @@ config RV_MON_WIP
 	  Enable WIP sample monitor, this is a sample monitor that
 	  illustrates the usage of per-cpu monitors.
 
+config RV_MON_WWNR
+	tristate "WWNR monitor"
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
index 91cb3b70a6a7..cb364a02639b 100644
--- a/kernel/trace/rv/monitor_wwnr/wwnr.c
+++ b/kernel/trace/rv/monitor_wwnr/wwnr.c
@@ -33,39 +33,34 @@ DECLARE_DA_MON_PER_TASK(wwnr, char);
  *
  */
 
-void handle_switch_in(void *data, /* XXX: fill header */)
+static void handle_switch(void *data, bool preempt, struct task_struct *p, struct task_struct *n)
 {
-	pid_t pid = /* XXX how do I get the pid? */;
-	da_handle_event_wwnr(pid, switch_in);
-}
+	int ppid = p->pid;
+	int npid = n->pid;
 
-void handle_switch_out(void *data, /* XXX: fill header */)
-{
-	pid_t pid = /* XXX how do I get the pid? */;
-	da_handle_event_wwnr(pid, switch_out);
+	if (ppid && ppid < MAX_PID)
+		da_handle_init_event_wwnr(ppid, switch_out);
+
+	if (npid && npid < MAX_PID)
+		da_handle_event_wwnr(npid, switch_in);
 }
 
-void handle_wakeup(void *data, /* XXX: fill header */)
+static void handle_wakeup(void *data, struct task_struct *p)
 {
-	pid_t pid = /* XXX how do I get the pid? */;
-	da_handle_event_wwnr(pid, wakeup);
+	if (p->pid && p->pid < MAX_PID)
+		da_handle_event_wwnr(p->pid, wakeup);
 }
 
-#define NR_TP   3
+#define NR_TP	2
 static struct tracepoint_hook_helper tracepoints_to_hook[NR_TP] = {
 	{
-		.probe = handle_switch_in,
-		.name = /* XXX: tracepoint name here */,
-		.registered = 0
-	},
-	{
-		.probe = handle_switch_out,
-		.name = /* XXX: tracepoint name here */,
+		.probe = handle_switch,
+		.name = "sched_switch",
 		.registered = 0
 	},
 	{
 		.probe = handle_wakeup,
-		.name = /* XXX: tracepoint name here */,
+		.name = "sched_wakeup",
 		.registered = 0
 	},
 };
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
2.33.1

