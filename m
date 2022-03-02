Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DD14CAE27
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244897AbiCBTFD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 14:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244883AbiCBTE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:04:59 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF92F44774
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:04:09 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-6mHa1rCaPEmsm4-0OR0J3g-1; Wed, 02 Mar 2022 14:04:00 -0500
X-MC-Unique: 6mHa1rCaPEmsm4-0OR0J3g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA3A5501E8;
        Wed,  2 Mar 2022 19:03:58 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC66A19C59;
        Wed,  2 Mar 2022 19:03:55 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH V3 12/15] rtla: Check for trace off also in the trace instance
Date:   Wed,  2 Mar 2022 20:01:37 +0100
Message-Id: <59fc7c6f23dddd5c8b7ef1782cf3da51ea2ce0f5.1646247211.git.bristot@kernel.org>
In-Reply-To: <cover.1646247211.git.bristot@kernel.org>
References: <cover.1646247211.git.bristot@kernel.org>
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

With the addition of --trigger option, it is also possible to stop
the trace from the -t tracing instance using the traceoff trigger.

Make rtla tools to check if the trace is stopped also in the trace
instance, stopping the execution of the tool.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
2.34.1

