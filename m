Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C064DA2DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351223AbiCOTEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351208AbiCOTEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF985A150
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CE02616D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE55C340EE;
        Tue, 15 Mar 2022 19:02:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUCRO-003jg1-VQ;
        Tue, 15 Mar 2022 15:02:42 -0400
Message-ID: <20220315190242.813090716@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 15:02:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 01/15] rtla/osnoise: Add support to adjust the tracing_thresh
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

osnoise uses the tracing_thresh parameter to define the delta between
two reads of the time to be considered a noise.

Add support to get and set the tracing_thresh from osnoise tools.

Link: https://lkml.kernel.org/r/715ad2a53fd40e41bab8c3f1214c1a94e12fb595.1646247211.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise.c | 83 ++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/osnoise.h |  8 +++
 2 files changed, 91 insertions(+)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index e60f1862bad0..b8ec6c15bccb 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -655,6 +655,85 @@ void osnoise_put_print_stack(struct osnoise_context *context)
 	context->orig_print_stack = OSNOISE_OPTION_INIT_VAL;
 }
 
+/*
+ * osnoise_get_tracing_thresh - read and save the original "tracing_thresh"
+ */
+static long long
+osnoise_get_tracing_thresh(struct osnoise_context *context)
+{
+	long long tracing_thresh;
+
+	if (context->tracing_thresh != OSNOISE_OPTION_INIT_VAL)
+		return context->tracing_thresh;
+
+	if (context->orig_tracing_thresh != OSNOISE_OPTION_INIT_VAL)
+		return context->orig_tracing_thresh;
+
+	tracing_thresh = osnoise_read_ll_config("tracing_thresh");
+	if (tracing_thresh < 0)
+		goto out_err;
+
+	context->orig_tracing_thresh = tracing_thresh;
+	return tracing_thresh;
+
+out_err:
+	return OSNOISE_OPTION_INIT_VAL;
+}
+
+/*
+ * osnoise_set_tracing_thresh - set "tracing_thresh"
+ */
+int osnoise_set_tracing_thresh(struct osnoise_context *context, long long tracing_thresh)
+{
+	long long curr_tracing_thresh = osnoise_get_tracing_thresh(context);
+	int retval;
+
+	if (curr_tracing_thresh == OSNOISE_OPTION_INIT_VAL)
+		return -1;
+
+	retval = osnoise_write_ll_config("tracing_thresh", tracing_thresh);
+	if (retval < 0)
+		return -1;
+
+	context->tracing_thresh = tracing_thresh;
+
+	return 0;
+}
+
+/*
+ * osnoise_restore_tracing_thresh - restore the original "tracing_thresh"
+ */
+void osnoise_restore_tracing_thresh(struct osnoise_context *context)
+{
+	int retval;
+
+	if (context->orig_tracing_thresh == OSNOISE_OPTION_INIT_VAL)
+		return;
+
+	if (context->orig_tracing_thresh == context->tracing_thresh)
+		goto out_done;
+
+	retval = osnoise_write_ll_config("tracing_thresh", context->orig_tracing_thresh);
+	if (retval < 0)
+		err_msg("Could not restore original tracing_thresh\n");
+
+out_done:
+	context->tracing_thresh = OSNOISE_OPTION_INIT_VAL;
+}
+
+/*
+ * osnoise_put_tracing_thresh - restore original values and cleanup data
+ */
+void osnoise_put_tracing_thresh(struct osnoise_context *context)
+{
+	osnoise_restore_tracing_thresh(context);
+
+	if (context->orig_tracing_thresh == OSNOISE_OPTION_INIT_VAL)
+		return;
+
+	context->orig_tracing_thresh = OSNOISE_OPTION_INIT_VAL;
+}
+
 /*
  * enable_osnoise - enable osnoise tracer in the trace_instance
  */
@@ -716,6 +795,9 @@ struct osnoise_context *osnoise_context_alloc(void)
 	context->orig_print_stack	= OSNOISE_OPTION_INIT_VAL;
 	context->print_stack		= OSNOISE_OPTION_INIT_VAL;
 
+	context->orig_tracing_thresh	= OSNOISE_OPTION_INIT_VAL;
+	context->tracing_thresh		= OSNOISE_OPTION_INIT_VAL;
+
 	osnoise_get_context(context);
 
 	return context;
@@ -741,6 +823,7 @@ void osnoise_put_context(struct osnoise_context *context)
 	osnoise_put_stop_total_us(context);
 	osnoise_put_timerlat_period_us(context);
 	osnoise_put_print_stack(context);
+	osnoise_put_tracing_thresh(context);
 
 	free(context);
 }
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 9e4b2e2a4559..04a4384cc544 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -23,6 +23,10 @@ struct osnoise_context {
 	long long		orig_timerlat_period_us;
 	long long		timerlat_period_us;
 
+	/* 0 as init value */
+	long long		orig_tracing_thresh;
+	long long		tracing_thresh;
+
 	/* -1 as init value because 0 is disabled */
 	long long		orig_stop_us;
 	long long		stop_us;
@@ -67,6 +71,10 @@ int osnoise_set_timerlat_period_us(struct osnoise_context *context,
 				   long long timerlat_period_us);
 void osnoise_restore_timerlat_period_us(struct osnoise_context *context);
 
+int osnoise_set_tracing_thresh(struct osnoise_context *context,
+			       long long tracing_thresh);
+void osnoise_restore_tracing_thresh(struct osnoise_context *context);
+
 void osnoise_restore_print_stack(struct osnoise_context *context);
 int osnoise_set_print_stack(struct osnoise_context *context,
 			    long long print_stack);
-- 
2.35.1
