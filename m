Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11A94DA2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351321AbiCOTEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351245AbiCOTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1967856C33
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8E64616D2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F5DC340F6;
        Tue, 15 Mar 2022 19:02:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUCRQ-003jlb-Re;
        Tue, 15 Mar 2022 15:02:44 -0400
Message-ID: <20220315190244.681783686@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 15:02:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 11/15] rtla/trace: Save event histogram output to a file
References: <20220315190214.613102181@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

The hist: trigger generates a histogram in the file sys/event/hist.
If the hist: trigger is used, automatically save the histogram output of
the event sys:event in the sys_event_hist.txt file.

Link: https://lkml.kernel.org/r/b5c906af31d4e022ffe87fb0848fac5c089087c8.1646247211.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/tools/rtla/common_options.rst | 10 +++-
 tools/tracing/rtla/src/trace.c              | 53 +++++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index afd45bae821f..af76df6205d4 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -23,7 +23,15 @@
         Filter the previous **-e** *sys:event* event with *<filter>*. For further information about event filtering see https://www.kernel.org/doc/html/latest/trace/events.html#event-filtering.
 
 **--trigger** *<trigger>*
-        Enable a trace event trigger to the previous **-e** *sys:event*. For further information about event trigger see https://www.kernel.org/doc/html/latest/trace/events.html#event-triggers.
+        Enable a trace event trigger to the previous **-e** *sys:event*.
+        If the *hist:* trigger is activated, the output histogram will be automatically saved to a file named *system_event_hist.txt*.
+        For example, the command:
+
+        rtla <command> <mode> -t -e osnoise:irq_noise --trigger="hist:key=desc,duration/1000:sort=desc,duration/1000:vals=hitcount"
+
+        Will automatically save the content of the histogram associated to *osnoise:irq_noise* event in *osnoise_irq_noise_hist.txt*.
+
+        For further information about event trigger see https://www.kernel.org/doc/html/latest/trace/events.html#event-triggers.
 
 **-P**, **--priority** *o:prio|r:prio|f:prio|d:runtime:period*
 
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index ef44bab0c404..8249ec4d77cc 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -296,6 +296,57 @@ static void trace_event_disable_filter(struct trace_instance *instance,
 			tevent->event ? : "*", tevent->filter);
 }
 
+/*
+ * trace_event_save_hist - save the content of an event hist
+ *
+ * If the trigger is a hist: one, save the content of the hist file.
+ */
+static void trace_event_save_hist(struct trace_instance *instance,
+				  struct trace_events *tevent)
+{
+	int retval, index, out_fd;
+	mode_t mode = 0644;
+	char path[1024];
+	char *hist;
+
+	if (!tevent)
+		return;
+
+	/* trigger enables hist */
+	if (!tevent->trigger)
+		return;
+
+	/* is this a hist: trigger? */
+	retval = strncmp(tevent->trigger, "hist:", strlen("hist:"));
+	if (retval)
+		return;
+
+	snprintf(path, 1024, "%s_%s_hist.txt", tevent->system, tevent->event);
+
+	printf("  Saving event %s:%s hist to %s\n", tevent->system, tevent->event, path);
+
+	out_fd = creat(path, mode);
+	if (out_fd < 0) {
+		err_msg("  Failed to create %s output file\n", path);
+		return;
+	}
+
+	hist = tracefs_event_file_read(instance->inst, tevent->system, tevent->event, "hist", 0);
+	if (!hist) {
+		err_msg("  Failed to read %s:%s hist file\n", tevent->system, tevent->event);
+		goto out_close;
+	}
+
+	index = 0;
+	do {
+		index += write(out_fd, &hist[index], strlen(hist) - index);
+	} while (index < strlen(hist));
+
+	free(hist);
+out_close:
+	close(out_fd);
+}
+
 /*
  * trace_event_disable_trigger - disable an event trigger
  */
@@ -314,6 +365,8 @@ static void trace_event_disable_trigger(struct trace_instance *instance,
 	debug_msg("Disabling %s:%s trigger %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->trigger);
 
+	trace_event_save_hist(instance, tevent);
+
 	snprintf(trigger, 1024, "!%s\n", tevent->trigger);
 
 	retval = tracefs_event_file_write(instance->inst, tevent->system,
-- 
2.35.1
