Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5AB4BB7BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiBRLKH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 06:10:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiBRLKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:10:00 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C67C62AEDA2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:09:44 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-YTY_sJGoMAilkI0SQEnw7g-1; Fri, 18 Feb 2022 06:09:40 -0500
X-MC-Unique: YTY_sJGoMAilkI0SQEnw7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F7F71006AA3;
        Fri, 18 Feb 2022 11:09:39 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B92F2B4B5;
        Fri, 18 Feb 2022 11:09:37 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] rtla/trace: Add trace events helpers
Date:   Fri, 18 Feb 2022 12:09:17 +0100
Message-Id: <fc83e3162dd01df0b1635099fbf1f5b08b069834.1645182327.git.bristot@kernel.org>
In-Reply-To: <cover.1645182327.git.bristot@kernel.org>
References: <cover.1645182327.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a set of helper functions to allow the rtla tools to enable
additional tracepoints in the trace instance.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/trace.c | 105 +++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/trace.h |  15 +++++
 2 files changed, 120 insertions(+)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 83de259abcc1..1a3e346c6b17 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -190,3 +190,108 @@ int trace_instance_start(struct trace_instance *trace)
 {
 	return tracefs_trace_on(trace->inst);
 }
+
+/*
+ * free_trace_events - free a list of trace events
+ */
+static void free_trace_events(struct trace_events *events)
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
+ * alloc_trace_event - alloc and parse a single trace event
+ */
+struct trace_events *alloc_trace_event(const char *event_string)
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
+ * disable_trace_events - disable all trace events
+ */
+void disable_trace_events(struct trace_instance *instance,
+			  struct trace_events *events)
+{
+	struct trace_events *tevent = events;
+
+	if (!events)
+		return;
+
+	while (tevent) {
+		if (tevent->enabled)
+			tracefs_event_disable(instance->inst, tevent->system, tevent->event);
+
+		tevent->enabled = 0;
+		tevent = tevent->next;
+	}
+}
+
+/*
+ * enable_trace_events - enable all events
+ */
+int enable_trace_events(struct trace_instance *instance,
+			struct trace_events *events)
+{
+	struct trace_events *tevent = events;
+	int retval;
+
+	while (tevent) {
+		retval = tracefs_event_enable(instance->inst, tevent->system, tevent->event);
+		if (retval < 0) {
+			if (tevent->event)
+				err_msg("Error enabling event %s:%s\n",
+					tevent->system, tevent->event);
+			else
+				err_msg("Error enabling events %s:*\n",
+					tevent->system);
+			return 1;
+		}
+
+		tevent->enabled = 1;
+		tevent = tevent->next;
+	}
+
+	return 0;
+}
+
+/*
+ * destroy_trace_events - disable and free all trace events
+ */
+void destroy_trace_events(struct trace_instance *instance,
+			  struct trace_events *events)
+{
+	if (!events)
+		return;
+
+	disable_trace_events(instance, events);
+	free_trace_events(events);
+}
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 0ea1df0ad9a7..762a04667c51 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -2,6 +2,13 @@
 #include <tracefs.h>
 #include <stddef.h>
 
+struct trace_events {
+	struct trace_events *next;
+	char *system;
+	char *event;
+	int enabled;
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
+struct trace_events *alloc_trace_event(const char *event_string);
+void disable_trace_events(struct trace_instance *instance,
+			  struct trace_events *events);
+void destroy_trace_events(struct trace_instance *instance,
+			  struct trace_events *events);
+int enable_trace_events(struct trace_instance *instance,
+			  struct trace_events *events);
-- 
2.34.1

