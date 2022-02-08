Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D5E4ADB6D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351431AbiBHOnN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Feb 2022 09:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbiBHOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:43:08 -0500
X-Greylist: delayed 325 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 06:43:06 PST
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B77E0C03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:43:06 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-gBPqdHwSMgifiW50WL7BZA-1; Tue, 08 Feb 2022 09:36:32 -0500
X-MC-Unique: gBPqdHwSMgifiW50WL7BZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72D0F189DF52;
        Tue,  8 Feb 2022 14:36:31 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27C917C141;
        Tue,  8 Feb 2022 14:36:29 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH V3] rtla: Fix segmentation fault when failing to enable -t
Date:   Tue,  8 Feb 2022 15:36:21 +0100
Message-Id: <5660a2b6bf66c2655842360f2d7f6b48db5dba23.1644327249.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
Fixes: a828cd18bc4a ("rtla: Add timerlat tool and timelart top mode")
Fixes: 1eeb6328e8b3 ("rtla/timerlat: Add timerlat hist mode")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
Changes from V2:
 - Init local variables as NULL (Steven)
 - Cleanup in the exit code
Changes from V1:
 - Make osnoise_destroy_tool handle NULL osnoise_tool (Steven)

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

