Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4694CAE15
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiCBTD1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 14:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244803AbiCBTDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:03:21 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6B622FFE3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:02:36 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-kl9SYdGJMKGzvSszpBwV2w-1; Wed, 02 Mar 2022 14:02:32 -0500
X-MC-Unique: kl9SYdGJMKGzvSszpBwV2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23D311091DA0;
        Wed,  2 Mar 2022 19:02:31 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D292619C59;
        Wed,  2 Mar 2022 19:02:27 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH V3 05/15] rtla/trace: Add trace events helpers
Date:   Wed,  2 Mar 2022 20:01:30 +0100
Message-Id: <932398b36c1bbaa22c7810d7a40ca9b8c5595b94.1646247211.git.bristot@kernel.org>
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
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
2.34.1

