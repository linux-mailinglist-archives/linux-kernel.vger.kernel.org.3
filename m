Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AD54DA2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351294AbiCOTEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351231AbiCOTEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EFB522D8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81144616F1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B87DC340FA;
        Tue, 15 Mar 2022 19:02:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUCRQ-003jkU-F6;
        Tue, 15 Mar 2022 15:02:44 -0400
Message-ID: <20220315190244.299169345@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 15:02:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 09/15] rtla/trace: Add trace event filter helpers
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

Add a set of helper functions to allow rtla tools to filter events
in the trace instance.

Link: https://lkml.kernel.org/r/12623b1684684549d53b90f4bf66fae44584fd14.1646247211.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/trace.c | 83 ++++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/trace.h |  3 ++
 2 files changed, 86 insertions(+)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 7f8661b2724d..ef44bab0c404 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -204,6 +204,8 @@ static void trace_events_free(struct trace_events *events)
 
 		tevent = tevent->next;
 
+		if (free_event->filter)
+			free(free_event->filter);
 		if (free_event->trigger)
 			free(free_event->trigger);
 		free(free_event->system);
@@ -237,6 +239,21 @@ struct trace_events *trace_event_alloc(const char *event_string)
 	return tevent;
 }
 
+/*
+ * trace_event_add_filter - record an event filter
+ */
+int trace_event_add_filter(struct trace_events *event, char *filter)
+{
+	if (event->filter)
+		free(event->filter);
+
+	event->filter = strdup(filter);
+	if (!event->filter)
+		return 1;
+
+	return 0;
+}
+
 /*
  * trace_event_add_trigger - record an event trigger action
  */
@@ -252,6 +269,33 @@ int trace_event_add_trigger(struct trace_events *event, char *trigger)
 	return 0;
 }
 
+/*
+ * trace_event_disable_filter - disable an event filter
+ */
+static void trace_event_disable_filter(struct trace_instance *instance,
+				       struct trace_events *tevent)
+{
+	char filter[1024];
+	int retval;
+
+	if (!tevent->filter)
+		return;
+
+	if (!tevent->filter_enabled)
+		return;
+
+	debug_msg("Disabling %s:%s filter %s\n", tevent->system,
+		  tevent->event ? : "*", tevent->filter);
+
+	snprintf(filter, 1024, "!%s\n", tevent->filter);
+
+	retval = tracefs_event_file_write(instance->inst, tevent->system,
+					  tevent->event, "filter", filter);
+	if (retval < 0)
+		err_msg("Error disabling %s:%s filter %s\n", tevent->system,
+			tevent->event ? : "*", tevent->filter);
+}
+
 /*
  * trace_event_disable_trigger - disable an event trigger
  */
@@ -293,6 +337,7 @@ void trace_events_disable(struct trace_instance *instance,
 	while (tevent) {
 		debug_msg("Disabling event %s:%s\n", tevent->system, tevent->event ? : "*");
 		if (tevent->enabled) {
+			trace_event_disable_filter(instance, tevent);
 			trace_event_disable_trigger(instance, tevent);
 			tracefs_event_disable(instance->inst, tevent->system, tevent->event);
 		}
@@ -302,6 +347,41 @@ void trace_events_disable(struct trace_instance *instance,
 	}
 }
 
+/*
+ * trace_event_enable_filter - enable an event filter associated with an event
+ */
+static int trace_event_enable_filter(struct trace_instance *instance,
+				     struct trace_events *tevent)
+{
+	char filter[1024];
+	int retval;
+
+	if (!tevent->filter)
+		return 0;
+
+	if (!tevent->event) {
+		err_msg("Filter %s applies only for single events, not for all %s:* events\n",
+			tevent->filter, tevent->system);
+		return 1;
+	}
+
+	snprintf(filter, 1024, "%s\n", tevent->filter);
+
+	debug_msg("Enabling %s:%s filter %s\n", tevent->system,
+		  tevent->event ? : "*", tevent->filter);
+
+	retval = tracefs_event_file_write(instance->inst, tevent->system,
+					  tevent->event, "filter", filter);
+	if (retval < 0) {
+		err_msg("Error enabling %s:%s filter %s\n", tevent->system,
+			tevent->event ? : "*", tevent->filter);
+		return 1;
+	}
+
+	tevent->filter_enabled = 1;
+	return 0;
+}
+
 /*
  * trace_event_enable_trigger - enable an event trigger associated with an event
  */
@@ -356,6 +436,9 @@ int trace_events_enable(struct trace_instance *instance,
 			return 1;
 		}
 
+		retval = trace_event_enable_filter(instance, tevent);
+		if (retval)
+			return 1;
 
 		retval = trace_event_enable_trigger(instance, tevent);
 		if (retval)
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 856b26d93064..51ad344c600b 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -6,8 +6,10 @@ struct trace_events {
 	struct trace_events *next;
 	char *system;
 	char *event;
+	char *filter;
 	char *trigger;
 	char enabled;
+	char filter_enabled;
 	char trigger_enabled;
 };
 
@@ -43,4 +45,5 @@ void trace_events_destroy(struct trace_instance *instance,
 int trace_events_enable(struct trace_instance *instance,
 			  struct trace_events *events);
 
+int trace_event_add_filter(struct trace_events *event, char *filter);
 int trace_event_add_trigger(struct trace_events *event, char *trigger);
-- 
2.35.1
