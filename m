Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143744B1A70
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346357AbiBKAcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:32:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242533AbiBKAcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:32:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784F7559A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:31:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26C75B827CD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B596FC004E1;
        Fri, 11 Feb 2022 00:31:55 +0000 (UTC)
Date:   Thu, 10 Feb 2022 19:31:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        JaeSang Yoo <js.yoo.5b@gmail.com>
Subject: [GIT PULL] tracing: Updates for v5.17-rc2
Message-ID: <20220210193154.0bcd3700@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes:

 - Fixes to the RTLA tooling and adding to MAINTAINERS file.

 - A fix to a tp_printk overriding tp_printk_stop_on_boot on command line.


Please pull the latest trace-v5.17-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.17-rc2

Tag SHA1: 164366d9d80f3791e063a02f79db39b49d14a74d
Head SHA1: 3203ce39ac0b2a57a84382ec184c7d4a0bede175


Daniel Bristot de Oliveira (5):
      rtla: Follow kernel version
      rtla/utils: Fix session duration parsing
      rtla/trace: Error message fixup
      rtla: Fix segmentation fault when failing to enable -t
      MAINTAINERS: Add RTLA entry

JaeSang Yoo (1):
      tracing: Fix tp_printk option related with tp_printk_stop_on_boot

----
 MAINTAINERS                            | 8 ++++++++
 kernel/trace/trace.c                   | 4 ++++
 tools/tracing/rtla/Makefile            | 4 +++-
 tools/tracing/rtla/src/osnoise.c       | 3 +++
 tools/tracing/rtla/src/osnoise_hist.c  | 7 +++----
 tools/tracing/rtla/src/osnoise_top.c   | 7 +++----
 tools/tracing/rtla/src/timerlat_hist.c | 7 +++----
 tools/tracing/rtla/src/timerlat_top.c  | 7 +++----
 tools/tracing/rtla/src/trace.c         | 8 ++++----
 tools/tracing/rtla/src/utils.c         | 4 ++--
 10 files changed, 36 insertions(+), 23 deletions(-)
---------------------------
diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..61d127e3314f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19576,6 +19576,14 @@ F:	Documentation/trace/timerlat-tracer.rst
 F:	Documentation/trace/hwlat_detector.rst
 F:	arch/*/kernel/trace.c
 
+Real-time Linux Analysis (RTLA) tools
+M:	Daniel Bristot de Oliveira <bristot@kernel.org>
+M:	Steven Rostedt <rostedt@goodmis.org>
+L:	linux-trace-devel@vger.kernel.org
+S:	Maintained
+F:	Documentation/tools/rtla/
+F:	tools/tracing/rtla/
+
 TRADITIONAL CHINESE DOCUMENTATION
 M:	Hu Haowen <src.res@email.cn>
 L:	linux-doc-tw-discuss@lists.sourceforge.net
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c860f582b078..7c2578efde26 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -252,6 +252,10 @@ __setup("trace_clock=", set_trace_boot_clock);
 
 static int __init set_tracepoint_printk(char *str)
 {
+	/* Ignore the "tp_printk_stop_on_boot" param */
+	if (*str == '_')
+		return 0;
+
 	if ((strcmp(str, "=0") != 0 && strcmp(str, "=off") != 0))
 		tracepoint_printk = 1;
 	return 1;
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 7c39728d08de..5a1eda617992 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -1,5 +1,6 @@
 NAME	:=	rtla
-VERSION	:=	0.5
+# Follow the kernel version
+VERSION :=	$(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion)
 
 # From libtracefs:
 # Makefiles suck: This macro sets a default value of $(2) for the
@@ -85,6 +86,7 @@ clean: doc_clean
 
 tarball: clean
 	rm -rf $(NAME)-$(VERSION) && mkdir $(NAME)-$(VERSION)
+	echo $(VERSION) > $(NAME)-$(VERSION)/VERSION
 	cp -r $(DIRS) $(FILES) $(NAME)-$(VERSION)
 	mkdir $(NAME)-$(VERSION)/Documentation/
 	cp -rp $(SRCTREE)/../../../Documentation/tools/rtla/* $(NAME)-$(VERSION)/Documentation/
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 7b73d1eccd0e..5648f9252e58 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -750,6 +750,9 @@ void osnoise_put_context(struct osnoise_context *context)
  */
 void osnoise_destroy_tool(struct osnoise_tool *top)
 {
+	if (!top)
+		return;
+
 	trace_instance_destroy(&top->trace);
 
 	if (top->context)
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 180fcbe423cd..1f0b7fce55cf 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -701,9 +701,9 @@ osnoise_hist_set_signals(struct osnoise_hist_params *params)
 int osnoise_hist_main(int argc, char *argv[])
 {
 	struct osnoise_hist_params *params;
+	struct osnoise_tool *record = NULL;
+	struct osnoise_tool *tool = NULL;
 	struct trace_instance *trace;
-	struct osnoise_tool *record;
-	struct osnoise_tool *tool;
 	int return_value = 1;
 	int retval;
 
@@ -792,9 +792,8 @@ int osnoise_hist_main(int argc, char *argv[])
 out_hist:
 	osnoise_free_histogram(tool->data);
 out_destroy:
+	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
-	if (params->trace_output)
-		osnoise_destroy_tool(record);
 	free(params);
 out_exit:
 	exit(return_value);
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 332b2ac205fc..c67dc28ef716 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -483,9 +483,9 @@ static void osnoise_top_set_signals(struct osnoise_top_params *params)
 int osnoise_top_main(int argc, char **argv)
 {
 	struct osnoise_top_params *params;
+	struct osnoise_tool *record = NULL;
+	struct osnoise_tool *tool = NULL;
 	struct trace_instance *trace;
-	struct osnoise_tool *record;
-	struct osnoise_tool *tool;
 	int return_value = 1;
 	int retval;
 
@@ -571,9 +571,8 @@ int osnoise_top_main(int argc, char **argv)
 
 out_top:
 	osnoise_free_top(tool->data);
+	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
-	if (params->trace_output)
-		osnoise_destroy_tool(record);
 out_exit:
 	exit(return_value);
 }
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 235f9620ef3d..436a799f9adf 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -729,9 +729,9 @@ timerlat_hist_set_signals(struct timerlat_hist_params *params)
 int timerlat_hist_main(int argc, char *argv[])
 {
 	struct timerlat_hist_params *params;
+	struct osnoise_tool *record = NULL;
+	struct osnoise_tool *tool = NULL;
 	struct trace_instance *trace;
-	struct osnoise_tool *record;
-	struct osnoise_tool *tool;
 	int return_value = 1;
 	int retval;
 
@@ -813,9 +813,8 @@ int timerlat_hist_main(int argc, char *argv[])
 
 out_hist:
 	timerlat_free_histogram(tool->data);
+	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
-	if (params->trace_output)
-		osnoise_destroy_tool(record);
 	free(params);
 out_exit:
 	exit(return_value);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 1ebd5291539c..d4187f6534ed 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -521,9 +521,9 @@ timerlat_top_set_signals(struct timerlat_top_params *params)
 int timerlat_top_main(int argc, char *argv[])
 {
 	struct timerlat_top_params *params;
+	struct osnoise_tool *record = NULL;
+	struct osnoise_tool *top = NULL;
 	struct trace_instance *trace;
-	struct osnoise_tool *record;
-	struct osnoise_tool *top;
 	int return_value = 1;
 	int retval;
 
@@ -609,9 +609,8 @@ int timerlat_top_main(int argc, char *argv[])
 
 out_top:
 	timerlat_free_top(top->data);
+	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
-	if (params->trace_output)
-		osnoise_destroy_tool(record);
 	free(params);
 out_exit:
 	exit(return_value);
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 107a0c6387f7..83de259abcc1 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -20,14 +20,14 @@ int enable_tracer_by_name(struct tracefs_instance *inst, const char *tracer_name
 
 	tracer = TRACEFS_TRACER_CUSTOM;
 
-	debug_msg("enabling %s tracer\n", tracer_name);
+	debug_msg("Enabling %s tracer\n", tracer_name);
 
 	retval = tracefs_tracer_set(inst, tracer, tracer_name);
 	if (retval < 0) {
 		if (errno == ENODEV)
-			err_msg("tracer %s not found!\n", tracer_name);
+			err_msg("Tracer %s not found!\n", tracer_name);
 
-		err_msg("failed to enable the tracer %s\n", tracer_name);
+		err_msg("Failed to enable the %s tracer\n", tracer_name);
 		return -1;
 	}
 
@@ -44,7 +44,7 @@ void disable_tracer(struct tracefs_instance *inst)
 
 	retval = tracefs_tracer_set(inst, t);
 	if (retval < 0)
-		err_msg("oops, error disabling tracer\n");
+		err_msg("Oops, error disabling tracer\n");
 }
 
 /*
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 1c9f0eea6166..ffaf8ec84001 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -77,11 +77,11 @@ void get_duration(time_t start_time, char *output, int output_size)
 	time_t duration;
 
 	duration = difftime(now, start_time);
-	tm_info = localtime(&duration);
+	tm_info = gmtime(&duration);
 
 	snprintf(output, output_size, "%3d %02d:%02d:%02d",
 			tm_info->tm_yday,
-			tm_info->tm_hour - 1,
+			tm_info->tm_hour,
 			tm_info->tm_min,
 			tm_info->tm_sec);
 }
