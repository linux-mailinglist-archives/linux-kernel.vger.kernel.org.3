Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A590D4BC41E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbiBSA4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:56:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240741AbiBSAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D78279905
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:55:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9A63B8240F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9051CC340ED;
        Sat, 19 Feb 2022 00:55:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nLE1o-0051XQ-OK;
        Fri, 18 Feb 2022 19:55:12 -0500
Message-ID: <20220219005512.589693373@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 19:54:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 02/16] tracing: Remove size restriction on hist trigger cmd error logging
References: <20220219005430.848118506@goodmis.org>
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

From: Tom Zanussi <zanussi@kernel.org>

Currently, hist trigger command error strings are restricted to a
length of MAX_FILTER_STR_VAL (256), which is too short for some
commands already seen in the wild (with cmd strings longer than that
showing up truncated in err_log).

Remove the restriction so that no hist trigger command error string is
ever truncated.

Link: https://lkml.kernel.org/r/0f9d46407222eaf6632cd3b417bc50a11f401b71.1643399022.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ada87bfb5bb8..5e8970624bce 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -727,11 +727,16 @@ static struct track_data *track_data_alloc(unsigned int key_len,
 	return data;
 }
 
-static char last_cmd[MAX_FILTER_STR_VAL];
+#define HIST_PREFIX "hist:"
+
+static char *last_cmd;
 static char last_cmd_loc[MAX_FILTER_STR_VAL];
 
 static int errpos(char *str)
 {
+	if (!str || !last_cmd)
+		return 0;
+
 	return err_pos(last_cmd, str);
 }
 
@@ -739,12 +744,19 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 {
 	const char *system = NULL, *name = NULL;
 	struct trace_event_call *call;
+	int len = 0;
 
 	if (!str)
 		return;
 
-	strcpy(last_cmd, "hist:");
-	strncat(last_cmd, str, MAX_FILTER_STR_VAL - 1 - sizeof("hist:"));
+	len += sizeof(HIST_PREFIX) + strlen(str) + 1;
+	kfree(last_cmd);
+	last_cmd = kzalloc(len, GFP_KERNEL);
+	if (!last_cmd)
+		return;
+
+	strcpy(last_cmd, HIST_PREFIX);
+	strncat(last_cmd, str, len - sizeof(HIST_PREFIX));
 
 	if (file) {
 		call = file->event_call;
@@ -757,18 +769,22 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 	}
 
 	if (system)
-		snprintf(last_cmd_loc, MAX_FILTER_STR_VAL, "hist:%s:%s", system, name);
+		snprintf(last_cmd_loc, MAX_FILTER_STR_VAL, HIST_PREFIX "%s:%s", system, name);
 }
 
-static void hist_err(struct trace_array *tr, u8 err_type, u8 err_pos)
+static void hist_err(struct trace_array *tr, u8 err_type, u16 err_pos)
 {
+	if (!last_cmd)
+		return;
+
 	tracing_log_err(tr, last_cmd_loc, last_cmd, err_text,
 			err_type, err_pos);
 }
 
 static void hist_err_clear(void)
 {
-	last_cmd[0] = '\0';
+	if (last_cmd)
+		last_cmd[0] = '\0';
 	last_cmd_loc[0] = '\0';
 }
 
@@ -5610,7 +5626,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 	bool have_var = false;
 	unsigned int i;
 
-	seq_puts(m, "hist:");
+	seq_puts(m, HIST_PREFIX);
 
 	if (data->name)
 		seq_printf(m, "%s:", data->name);
-- 
2.34.1
