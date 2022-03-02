Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E760B4CAE21
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244867AbiCBTES convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 14:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244849AbiCBTEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:04:10 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C1F949681
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:03:14 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-j5JV5jAJPzKw3pQm9IliKQ-1; Wed, 02 Mar 2022 14:03:10 -0500
X-MC-Unique: j5JV5jAJPzKw3pQm9IliKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 725BD1800D50;
        Wed,  2 Mar 2022 19:03:09 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41B5919C59;
        Wed,  2 Mar 2022 19:02:45 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH V3 07/15] rtla/trace: Add trace event trigger helpers
Date:   Wed,  2 Mar 2022 20:01:32 +0100
Message-Id: <e0d31abe879a78a5600b64f904d0dfa8f76e4fbb.1646247211.git.bristot@kernel.org>
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

Add a set of helper functions to allow rtla tools to trigger event
actions in the trace instance.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/trace.c | 88 +++++++++++++++++++++++++++++++++-
 tools/tracing/rtla/src/trace.h |  4 ++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 9ad3d8890ec5..7f8661b2724d 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -204,6 +204,8 @@ static void trace_events_free(struct trace_events *events)
 
 		tevent = tevent->next;
 
+		if (free_event->trigger)
+			free(free_event->trigger);
 		free(free_event->system);
 		free(free_event);
 	}
@@ -235,6 +237,48 @@ struct trace_events *trace_event_alloc(const char *event_string)
 	return tevent;
 }
 
+/*
+ * trace_event_add_trigger - record an event trigger action
+ */
+int trace_event_add_trigger(struct trace_events *event, char *trigger)
+{
+	if (event->trigger)
+		free(event->trigger);
+
+	event->trigger = strdup(trigger);
+	if (!event->trigger)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * trace_event_disable_trigger - disable an event trigger
+ */
+static void trace_event_disable_trigger(struct trace_instance *instance,
+					struct trace_events *tevent)
+{
+	char trigger[1024];
+	int retval;
+
+	if (!tevent->trigger)
+		return;
+
+	if (!tevent->trigger_enabled)
+		return;
+
+	debug_msg("Disabling %s:%s trigger %s\n", tevent->system,
+		  tevent->event ? : "*", tevent->trigger);
+
+	snprintf(trigger, 1024, "!%s\n", tevent->trigger);
+
+	retval = tracefs_event_file_write(instance->inst, tevent->system,
+					  tevent->event, "trigger", trigger);
+	if (retval < 0)
+		err_msg("Error disabling %s:%s trigger %s\n", tevent->system,
+			tevent->event ? : "*", tevent->trigger);
+}
+
 /*
  * trace_events_disable - disable all trace events
  */
@@ -248,14 +292,52 @@ void trace_events_disable(struct trace_instance *instance,
 
 	while (tevent) {
 		debug_msg("Disabling event %s:%s\n", tevent->system, tevent->event ? : "*");
-		if (tevent->enabled)
+		if (tevent->enabled) {
+			trace_event_disable_trigger(instance, tevent);
 			tracefs_event_disable(instance->inst, tevent->system, tevent->event);
+		}
 
 		tevent->enabled = 0;
 		tevent = tevent->next;
 	}
 }
 
+/*
+ * trace_event_enable_trigger - enable an event trigger associated with an event
+ */
+static int trace_event_enable_trigger(struct trace_instance *instance,
+				      struct trace_events *tevent)
+{
+	char trigger[1024];
+	int retval;
+
+	if (!tevent->trigger)
+		return 0;
+
+	if (!tevent->event) {
+		err_msg("Trigger %s applies only for single events, not for all %s:* events\n",
+			tevent->trigger, tevent->system);
+		return 1;
+	}
+
+	snprintf(trigger, 1024, "%s\n", tevent->trigger);
+
+	debug_msg("Enabling %s:%s trigger %s\n", tevent->system,
+		  tevent->event ? : "*", tevent->trigger);
+
+	retval = tracefs_event_file_write(instance->inst, tevent->system,
+					  tevent->event, "trigger", trigger);
+	if (retval < 0) {
+		err_msg("Error enabling %s:%s trigger %s\n", tevent->system,
+			tevent->event ? : "*", tevent->trigger);
+		return 1;
+	}
+
+	tevent->trigger_enabled = 1;
+
+	return 0;
+}
+
 /*
  * trace_events_enable - enable all events
  */
@@ -275,6 +357,10 @@ int trace_events_enable(struct trace_instance *instance,
 		}
 
 
+		retval = trace_event_enable_trigger(instance, tevent);
+		if (retval)
+			return 1;
+
 		tevent->enabled = 1;
 		tevent = tevent->next;
 	}
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 9f9751f7ee36..856b26d93064 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -6,7 +6,9 @@ struct trace_events {
 	struct trace_events *next;
 	char *system;
 	char *event;
+	char *trigger;
 	char enabled;
+	char trigger_enabled;
 };
 
 struct trace_instance {
@@ -40,3 +42,5 @@ void trace_events_destroy(struct trace_instance *instance,
 			  struct trace_events *events);
 int trace_events_enable(struct trace_instance *instance,
 			  struct trace_events *events);
+
+int trace_event_add_trigger(struct trace_events *event, char *trigger);
-- 
2.34.1

