Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AAC4A016A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351111AbiA1UIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiA1UIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:08:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E807AC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:08:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81F6861DBF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 20:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88268C340E7;
        Fri, 28 Jan 2022 20:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643400512;
        bh=Ng5lD8gq9k8/TN+0eDDm3alPdjwfyAK3wLNSagvKgdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Sbp0/6y5FFhWim+N27W/ug2O6vOVgJgpAKMH600ylbVPb+wxDFhdmi1i4CpbhJ4D+
         6MbDeh2LxLCLVTxWY8B96XsKoCH6vcVBs556mCISpx0vjaQgrF3/wWnl9TL2UXHt4e
         XXiIeLojCpjK3PqhLMwjkh4ZLLGBR7nU73K2uSE3sb0AwcfHKSXLG68/IfdUZ9SElo
         X/O5XredoaSBsNjOU6TmlzY8ceVbCbdmgdJ52P0L148o2QTXz2pgj69acAC2SQ/+ct
         8687tZvhnHJrndulwbncOGsS4IbgYzlTKA3yzAxuIInG+MPiazVUplzOf9SKitQMbC
         hxJvjBfm+L3jA==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 1/2] tracing: Remove size restriction on hist trigger cmd error logging
Date:   Fri, 28 Jan 2022 14:08:26 -0600
Message-Id: <0f9d46407222eaf6632cd3b417bc50a11f401b71.1643399022.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1643399022.git.zanussi@kernel.org>
References: <cover.1643399022.git.zanussi@kernel.org>
In-Reply-To: <cover.1643399022.git.zanussi@kernel.org>
References: <cover.1643399022.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, hist trigger command error strings are restricted to a
length of MAX_FILTER_STR_VAL (256), which is too short for some
commands already seen in the wild (with cmd strings longer than that
showing up truncated in err_log).

Remove the restriction so that no hist trigger command error string is
ever truncated.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
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
2.17.1

