Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF814DA2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351277AbiCOTEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351228AbiCOTEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B878B522C4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D292616E5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89B5C340EE;
        Tue, 15 Mar 2022 19:02:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUCRP-003jiE-NE;
        Tue, 15 Mar 2022 15:02:43 -0400
Message-ID: <20220315190243.552989934@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 15:02:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 05/15] rtla/trace: Add trace events helpers
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

Add a set of helper functions to allow the rtla tools to enable
additional tracepoints in the trace instance.

Link: https://lkml.kernel.org/r/932398b36c1bbaa22c7810d7a40ca9b8c5595b94.1646247211.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/trace.c | 104 +++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/trace.h |  15 +++++
 2 files changed, 119 insertions(+)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 83de259abcc1..9ad3d8890ec5 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -190,3 +190,107 @@ int trace_instance_start(struct trace_instance *trace)
 {
 	return tracefs_trace_on(trace->inst);
 }
+
+/*
+ * trace_events_free - free a list of trace events
+ */
+static void trace_events_free(struct trace_events *events)
+{
+	struct trace_events *tevent = events;
+	struct trace_events *free_event;
+
+	while (tevent) {
+		free_event = tevent;
+
+		tevent = tevent->next;
+
+		free(free_event->system);
+		free(free_event);
+	}
+}
+
+/*
+ * trace_event_alloc - alloc and parse a single trace event
+ */
+struct trace_events *trace_event_alloc(const char *event_string)
+{
+	struct trace_events *tevent;
+
+	tevent = calloc(1, sizeof(*tevent));
+	if (!tevent)
+		return NULL;
+
+	tevent->system = strdup(event_string);
+	if (!tevent->system) {
+		free(tevent);
+		return NULL;
+	}
+
+	tevent->event = strstr(tevent->system, ":");
+	if (tevent->event) {
+		*tevent->event = '\0';
+		tevent->event = &tevent->event[1];
+	}
+
+	return tevent;
+}
+
+/*
+ * trace_events_disable - disable all trace events
+ */
+void trace_events_disable(struct trace_instance *instance,
+			  struct trace_events *events)
+{
+	struct trace_events *tevent = events;
+
+	if (!events)
+		return;
+
+	while (tevent) {
+		debug_msg("Disabling event %s:%s\n", tevent->system, tevent->event ? : "*");
+		if (tevent->enabled)
+			tracefs_event_disable(instance->inst, tevent->system, tevent->event);
+
+		tevent->enabled = 0;
+		tevent = tevent->next;
+	}
+}
+
+/*
+ * trace_events_enable - enable all events
+ */
+int trace_events_enable(struct trace_instance *instance,
+			struct trace_events *events)
+{
+	struct trace_events *tevent = events;
+	int retval;
+
+	while (tevent) {
+		debug_msg("Enabling event %s:%s\n", tevent->system, tevent->event ? : "*");
+		retval = tracefs_event_enable(instance->inst, tevent->system, tevent->event);
+		if (retval < 0) {
+			err_msg("Error enabling event %s:%s\n", tevent->system,
+				tevent->event ? : "*");
+			return 1;
+		}
+
+
+		tevent->enabled = 1;
+		tevent = tevent->next;
+	}
+
+	return 0;
+}
+
+/*
+ * trace_events_destroy - disable and free all trace events
+ */
+void trace_events_destroy(struct trace_instance *instance,
+			  struct trace_events *events)
+{
+	if (!events)
+		return;
+
+	trace_events_disable(instance, events);
+	trace_events_free(events);
+}
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 0ea1df0ad9a7..9f9751f7ee36 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -2,6 +2,13 @@
 #include <tracefs.h>
 #include <stddef.h>
 
+struct trace_events {
+	struct trace_events *next;
+	char *system;
+	char *event;
+	char enabled;
+};
+
 struct trace_instance {
 	struct tracefs_instance		*inst;
 	struct tep_handle		*tep;
@@ -25,3 +32,11 @@ void destroy_instance(struct tracefs_instance *inst);
 int save_trace_to_file(struct tracefs_instance *inst, const char *filename);
 int collect_registered_events(struct tep_event *tep, struct tep_record *record,
 			      int cpu, void *context);
+
+struct trace_events *trace_event_alloc(const char *event_string);
+void trace_events_disable(struct trace_instance *instance,
+			  struct trace_events *events);
+void trace_events_destroy(struct trace_instance *instance,
+			  struct trace_events *events);
+int trace_events_enable(struct trace_instance *instance,
+			  struct trace_events *events);
-- 
2.35.1
