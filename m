Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009AD49EDA7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbiA0Vol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:44:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41322 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344472AbiA0Voj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:44:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C3ECB823BB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE7BC340E8;
        Thu, 27 Jan 2022 21:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643319877;
        bh=fSfNtuEYBnQ5rN5RWlV3wSy9TdJ6HHjYxnrKyJcSkRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=pM3VFquEj6AE3vDc/OZR4i9bCkjiCWq9nTk6zv8CGiy1NsDK5XPTy7vzq5ioqT2eY
         7uPeFaWzJ0h4qBUw4X5Gx06VzhfO5zFds9/1nG2e9mBUe9Q7QrwF9inlLza02CpByp
         BAnPkjLKpQ782YbU6OkMzpD+YBb0N+5yoYV6BtxQtqHzfIit7LmmygrnrdQEVBel52
         J/wNYfY0npd4eocatJtPmwGqtJ4r12woXatq4Fg1neiqWS9E0NfhnIEWIyftPDt/ps
         kBqPLNXngrKx/5MT7ampyppCYIWgIozRyEsjcuQ2DK46kW3ey18gJiaHy+Tuy7EvPH
         nmXaCNWhwxmHQ==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 6/7] tracing: Remove size restriction on hist trigger cmd error logging
Date:   Thu, 27 Jan 2022 15:44:20 -0600
Message-Id: <b519e15e681319e99055a92c8d090072ebb2b179.1643319703.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
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
index ada87bfb5bb8..be4a001a607f 100644
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
+	strncat(last_cmd, str, len - 1 - sizeof(HIST_PREFIX));
 
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

