Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAE15150DF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379253AbiD2Qc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379191AbiD2Qbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48D6DA6EF;
        Fri, 29 Apr 2022 09:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 165FA62334;
        Fri, 29 Apr 2022 16:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3B7C385A7;
        Fri, 29 Apr 2022 16:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651249701;
        bh=4lrtZt+xUMPJ8Ezq88fkPeiAyPdqxUbg73T4XPBajD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snHBDj5YrOERK+bvl3H33E5gDYToZRN3iqrcRxCzSHiJedAByrFmYorhBKmcbGLtO
         m7STSnQXc+UfqNuClyMWHWD0VPQ3BzfWdXCFsieJdQikD3Hg3OTteji8VJds22YIDo
         u06D+Fu0nh30f0OQUvmE1d12A23HejdjL4fwBVGWB3iNtphqfZMh9cvD+o11URqqL6
         nTO3iCeV7jBmGf/WDj2b9ShtBP1WllFGem5/v1NM4ClCDLYnG+Z7uVZT3aMjoBux6G
         JiypYus+EIgJxns/NeuxeiQoqCMxH4ozIgP74xlj2MlQMo7ZfAHeOvGfEQGgJfTaX7
         kouqTt+kInnpA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>, kael_w@yeah.net
Subject: [PATCH 1/4] rtla: Avoid record NULL pointer dereference
Date:   Fri, 29 Apr 2022 18:28:10 +0200
Message-Id: <ae0e4500d383db0884eb2820286afe34ca303778.1651247710.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651247710.git.bristot@kernel.org>
References: <cover.1651247710.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wan Jiabing <wanjiabing@vivo.com>

Fix the following null/deref_null.cocci errors:
./tools/tracing/rtla/src/osnoise_hist.c:870:31-36: ERROR: record is NULL but dereferenced.
./tools/tracing/rtla/src/osnoise_top.c:650:31-36: ERROR: record is NULL but dereferenced.
./tools/tracing/rtla/src/timerlat_hist.c:905:31-36: ERROR: record is NULL but dereferenced.
./tools/tracing/rtla/src/timerlat_top.c:700:31-36: ERROR: record is NULL but dereferenced.

"record" is NULL before calling osnoise_init_trace_tool.
Add a tag "out_free" to avoid dereferring a NULL pointer.

Link: https://lore.kernel.org/r/20220408151406.34823-1-wanjiabing@vivo.com/

Cc: kael_w@yeah.net
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: 51d64c3a1819 ("rtla: Add -e/--event support")
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/osnoise_hist.c  |  5 +++--
 tools/tracing/rtla/src/osnoise_top.c   |  9 +++++----
 tools/tracing/rtla/src/timerlat_hist.c | 11 ++++++-----
 tools/tracing/rtla/src/timerlat_top.c  | 11 ++++++-----
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index b4380d45cacd..5d7ea479ac89 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -809,7 +809,7 @@ int osnoise_hist_main(int argc, char *argv[])
 		retval = set_comm_sched_attr("osnoise/", &params->sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
-			goto out_hist;
+			goto out_free;
 		}
 	}
 
@@ -819,7 +819,7 @@ int osnoise_hist_main(int argc, char *argv[])
 		record = osnoise_init_trace_tool("osnoise");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
-			goto out_hist;
+			goto out_free;
 		}
 
 		if (params->events) {
@@ -869,6 +869,7 @@ int osnoise_hist_main(int argc, char *argv[])
 out_hist:
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
+out_free:
 	osnoise_free_histogram(tool->data);
 out_destroy:
 	osnoise_destroy_tool(record);
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 72c2fd6ce005..76479bfb2922 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -572,7 +572,7 @@ int osnoise_top_main(int argc, char **argv)
 	retval = osnoise_top_apply_config(tool, params);
 	if (retval) {
 		err_msg("Could not apply config\n");
-		goto out_top;
+		goto out_free;
 	}
 
 	trace = &tool->trace;
@@ -580,14 +580,14 @@ int osnoise_top_main(int argc, char **argv)
 	retval = enable_osnoise(trace);
 	if (retval) {
 		err_msg("Failed to enable osnoise tracer\n");
-		goto out_top;
+		goto out_free;
 	}
 
 	if (params->set_sched) {
 		retval = set_comm_sched_attr("osnoise/", &params->sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
-			goto out_top;
+			goto out_free;
 		}
 	}
 
@@ -597,7 +597,7 @@ int osnoise_top_main(int argc, char **argv)
 		record = osnoise_init_trace_tool("osnoise");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
-			goto out_top;
+			goto out_free;
 		}
 
 		if (params->events) {
@@ -649,6 +649,7 @@ int osnoise_top_main(int argc, char **argv)
 out_top:
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
+out_free:
 	osnoise_free_top(tool->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index dc908126c610..f3ec628f5e51 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -821,7 +821,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	retval = timerlat_hist_apply_config(tool, params);
 	if (retval) {
 		err_msg("Could not apply config\n");
-		goto out_hist;
+		goto out_free;
 	}
 
 	trace = &tool->trace;
@@ -829,14 +829,14 @@ int timerlat_hist_main(int argc, char *argv[])
 	retval = enable_timerlat(trace);
 	if (retval) {
 		err_msg("Failed to enable timerlat tracer\n");
-		goto out_hist;
+		goto out_free;
 	}
 
 	if (params->set_sched) {
 		retval = set_comm_sched_attr("timerlat/", &params->sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
-			goto out_hist;
+			goto out_free;
 		}
 	}
 
@@ -844,7 +844,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
 		if (dma_latency_fd < 0) {
 			err_msg("Could not set /dev/cpu_dma_latency.\n");
-			goto out_hist;
+			goto out_free;
 		}
 	}
 
@@ -854,7 +854,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
-			goto out_hist;
+			goto out_free;
 		}
 
 		if (params->events) {
@@ -904,6 +904,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		close(dma_latency_fd);
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
+out_free:
 	timerlat_free_histogram(tool->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 1f754c3df53f..35452a1d45e9 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -612,7 +612,7 @@ int timerlat_top_main(int argc, char *argv[])
 	retval = timerlat_top_apply_config(top, params);
 	if (retval) {
 		err_msg("Could not apply config\n");
-		goto out_top;
+		goto out_free;
 	}
 
 	trace = &top->trace;
@@ -620,14 +620,14 @@ int timerlat_top_main(int argc, char *argv[])
 	retval = enable_timerlat(trace);
 	if (retval) {
 		err_msg("Failed to enable timerlat tracer\n");
-		goto out_top;
+		goto out_free;
 	}
 
 	if (params->set_sched) {
 		retval = set_comm_sched_attr("timerlat/", &params->sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
-			goto out_top;
+			goto out_free;
 		}
 	}
 
@@ -635,7 +635,7 @@ int timerlat_top_main(int argc, char *argv[])
 		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
 		if (dma_latency_fd < 0) {
 			err_msg("Could not set /dev/cpu_dma_latency.\n");
-			goto out_top;
+			goto out_free;
 		}
 	}
 
@@ -645,7 +645,7 @@ int timerlat_top_main(int argc, char *argv[])
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
-			goto out_top;
+			goto out_free;
 		}
 
 		if (params->events) {
@@ -699,6 +699,7 @@ int timerlat_top_main(int argc, char *argv[])
 		close(dma_latency_fd);
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
+out_free:
 	timerlat_free_top(top->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
-- 
2.32.0

