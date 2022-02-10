Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9E84B16B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344146AbiBJUJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:09:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344105AbiBJUJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:09:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFCD273A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:09:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF54B618AC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 20:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB1CC340F8;
        Thu, 10 Feb 2022 20:09:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nIFkT-002zL6-EI;
        Thu, 10 Feb 2022 15:09:01 -0500
Message-ID: <20220210200901.278211884@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Feb 2022 15:05:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 4/6] rtla: Fix segmentation fault when failing to enable -t
References: <20220210200509.089236997@goodmis.org>
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

rtla osnoise and timerlat are causing a segmentation fault when running
with the --trace option on a kernel that does not support multiple
instances. For example:

    [root@f34 rtla]# rtla osnoise top -t
    failed to enable the tracer osnoise
    Could not enable osnoiser tracer for tracing
    Failed to enable the trace instance
    Segmentation fault (core dumped)

This error happens because the exit code of the tools is trying
to destroy the trace instance that failed to be created.

Make osnoise_destroy_tool() aware of possible NULL osnoise_tool *,
and do not attempt to destroy it. This also simplifies the exit code.

Link: https://lkml.kernel.org/r/5660a2b6bf66c2655842360f2d7f6b48db5dba23.1644327249.git.bristot@kernel.org

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
Fixes: a828cd18bc4a ("rtla: Add timerlat tool and timelart top mode")
Fixes: 1eeb6328e8b3 ("rtla/timerlat: Add timerlat hist mode")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise.c       | 3 +++
 tools/tracing/rtla/src/osnoise_hist.c  | 7 +++----
 tools/tracing/rtla/src/osnoise_top.c   | 7 +++----
 tools/tracing/rtla/src/timerlat_hist.c | 7 +++----
 tools/tracing/rtla/src/timerlat_top.c  | 7 +++----
 5 files changed, 15 insertions(+), 16 deletions(-)

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
-- 
2.34.1
