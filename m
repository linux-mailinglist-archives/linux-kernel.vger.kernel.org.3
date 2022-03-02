Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E224CAE0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244780AbiCBTDD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 14:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244506AbiCBTC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:02:59 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAD1245041
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:02:15 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-Piyvd3KKPNmzo_ajh44FHA-1; Wed, 02 Mar 2022 14:02:11 -0500
X-MC-Unique: Piyvd3KKPNmzo_ajh44FHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FC481800D50;
        Wed,  2 Mar 2022 19:02:10 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E30D19C59;
        Wed,  2 Mar 2022 19:02:06 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH V3 01/15] rtla/osnoise: Add support to adjust the tracing_thresh
Date:   Wed,  2 Mar 2022 20:01:26 +0100
Message-Id: <715ad2a53fd40e41bab8c3f1214c1a94e12fb595.1646247211.git.bristot@kernel.org>
In-Reply-To: <cover.1646247211.git.bristot@kernel.org>
References: <cover.1646247211.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

osnoise uses the tracing_thresh parameter to define the delta between
two reads of the time to be considered a noise.

Add support to get and set the tracing_thresh from osnoise tools.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
2.34.1

