Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC35C4DA2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351309AbiCOTEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351242AbiCOTEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B83522CC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C2E4616E1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB71BC340EE;
        Tue, 15 Mar 2022 19:02:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUCRR-003jmC-1k;
        Tue, 15 Mar 2022 15:02:45 -0400
Message-ID: <20220315190244.879379941@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 15:02:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 12/15] rtla: Check for trace off also in the trace instance
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

With the addition of --trigger option, it is also possible to stop
the trace from the -t tracing instance using the traceoff trigger.

Make rtla tools to check if the trace is stopped also in the trace
instance, stopping the execution of the tool.

Link: https://lkml.kernel.org/r/59fc7c6f23dddd5c8b7ef1782cf3da51ea2ce0f5.1646247211.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise_hist.c  |  4 ++--
 tools/tracing/rtla/src/osnoise_top.c   |  4 ++--
 tools/tracing/rtla/src/timerlat_hist.c |  4 ++--
 tools/tracing/rtla/src/timerlat_top.c  |  4 ++--
 tools/tracing/rtla/src/trace.c         | 19 +++++++++++++++++++
 tools/tracing/rtla/src/trace.h         |  1 +
 6 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index f86b5fb94efd..b73b919bd6b4 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -848,7 +848,7 @@ int osnoise_hist_main(int argc, char *argv[])
 			goto out_hist;
 		}
 
-		if (!tracefs_trace_is_on(trace->inst))
+		if (trace_is_off(&tool->trace, &record->trace))
 			break;
 	};
 
@@ -858,7 +858,7 @@ int osnoise_hist_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (!tracefs_trace_is_on(trace->inst)) {
+	if (trace_is_off(&tool->trace, &record->trace)) {
 		printf("rtla timelat hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index c3d75ee456a5..fd29a4049322 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -629,7 +629,7 @@ int osnoise_top_main(int argc, char **argv)
 		if (!params->quiet)
 			osnoise_print_stats(params, tool);
 
-		if (!tracefs_trace_is_on(trace->inst))
+		if (trace_is_off(&tool->trace, &record->trace))
 			break;
 
 	} while (!stop_tracing);
@@ -638,7 +638,7 @@ int osnoise_top_main(int argc, char **argv)
 
 	return_value = 0;
 
-	if (!tracefs_trace_is_on(trace->inst)) {
+	if (trace_is_off(&tool->trace, &record->trace)) {
 		printf("osnoise hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 8341f38fd0b1..17188ccb6e8b 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -861,7 +861,7 @@ int timerlat_hist_main(int argc, char *argv[])
 			goto out_hist;
 		}
 
-		if (!tracefs_trace_is_on(trace->inst))
+		if (trace_is_off(&tool->trace, &record->trace))
 			break;
 	};
 
@@ -869,7 +869,7 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (!tracefs_trace_is_on(trace->inst)) {
+	if (trace_is_off(&tool->trace, &record->trace)) {
 		printf("rtla timelat hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 9ce5a09664bc..bf2a50350e61 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -655,7 +655,7 @@ int timerlat_top_main(int argc, char *argv[])
 		if (!params->quiet)
 			timerlat_print_stats(params, top);
 
-		if (!tracefs_trace_is_on(trace->inst))
+		if (trace_is_off(&top->trace, &record->trace))
 			break;
 
 	};
@@ -664,7 +664,7 @@ int timerlat_top_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (!tracefs_trace_is_on(trace->inst)) {
+	if (trace_is_off(&top->trace, &record->trace)) {
 		printf("rtla timelat hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 8249ec4d77cc..5784c9f9e570 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -516,3 +516,22 @@ void trace_events_destroy(struct trace_instance *instance,
 	trace_events_disable(instance, events);
 	trace_events_free(events);
 }
+
+int trace_is_off(struct trace_instance *tool, struct trace_instance *trace)
+{
+	/*
+	 * The tool instance is always present, it is the one used to collect
+	 * data.
+	 */
+	if (!tracefs_trace_is_on(tool->inst))
+		return 1;
+
+	/*
+	 * The trace instance is only enabled when -t is set. IOW, when the system
+	 * is tracing.
+	 */
+	if (trace && !tracefs_trace_is_on(trace->inst))
+		return 1;
+
+	return 0;
+}
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 51ad344c600b..2e9a89a25615 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -47,3 +47,4 @@ int trace_events_enable(struct trace_instance *instance,
 
 int trace_event_add_filter(struct trace_events *event, char *filter);
 int trace_event_add_trigger(struct trace_events *event, char *trigger);
+int trace_is_off(struct trace_instance *tool, struct trace_instance *trace);
-- 
2.35.1
