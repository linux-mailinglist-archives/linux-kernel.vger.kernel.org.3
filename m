Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E344CAE29
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiCBTE6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 14:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244888AbiCBTEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:04:52 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABEE757B11
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:04:02 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-mf4lWGBZOLebSVfZQWgNwg-1; Wed, 02 Mar 2022 14:03:56 -0500
X-MC-Unique: mf4lWGBZOLebSVfZQWgNwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C58A84A5F2;
        Wed,  2 Mar 2022 19:03:55 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3DB319C59;
        Wed,  2 Mar 2022 19:03:52 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH V3 11/15] rtla/trace: Save event histogram output to a file
Date:   Wed,  2 Mar 2022 20:01:36 +0100
Message-Id: <b5c906af31d4e022ffe87fb0848fac5c089087c8.1646247211.git.bristot@kernel.org>
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

The hist: trigger generates a histogram in the file sys/event/hist.
If the hist: trigger is used, automatically save the histogram output of
the event sys:event in the sys_event_hist.txt file.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
2.34.1

