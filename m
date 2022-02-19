Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C854F4BC408
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbiBSAzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:55:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbiBSAzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628F827792B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:55:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A2B61F8A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BEBC340EF;
        Sat, 19 Feb 2022 00:55:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nLE1o-0051Wr-IC;
        Fri, 18 Feb 2022 19:55:12 -0500
Message-ID: <20220219005512.400321023@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 19:54:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 01/16] tracing: Remove size restriction on tracing_log_err cmd strings
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

Currently, tracing_log_err.cmd strings are restricted to a length of
MAX_FILTER_STR_VAL (256), which is too short for some commands already
seen in the wild (with cmd strings longer than that showing up
truncated).

Remove the restriction so that no command string is ever truncated.

Link: https://lkml.kernel.org/r/ca965f23256b350ebd94b3dc1a319f28e8267f5f.1643319703.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 55 +++++++++++++++++++++++++++++++++-----------
 kernel/trace/trace.h |  2 +-
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7c2578efde26..7c85ce9ffdc3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7723,7 +7723,7 @@ const struct file_operations trace_min_max_fops = {
 struct err_info {
 	const char	**errs;	/* ptr to loc-specific array of err strings */
 	u8		type;	/* index into errs -> specific err string */
-	u8		pos;	/* MAX_FILTER_STR_VAL = 256 */
+	u16		pos;	/* caret position */
 	u64		ts;
 };
 
@@ -7731,26 +7731,52 @@ struct tracing_log_err {
 	struct list_head	list;
 	struct err_info		info;
 	char			loc[TRACING_LOG_LOC_MAX]; /* err location */
-	char			cmd[MAX_FILTER_STR_VAL]; /* what caused err */
+	char			*cmd;                     /* what caused err */
 };
 
 static DEFINE_MUTEX(tracing_err_log_lock);
 
-static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
+static struct tracing_log_err *alloc_tracing_log_err(int len)
+{
+	struct tracing_log_err *err;
+
+	err = kzalloc(sizeof(*err), GFP_KERNEL);
+	if (!err)
+		return ERR_PTR(-ENOMEM);
+
+	err->cmd = kzalloc(len, GFP_KERNEL);
+	if (!err->cmd) {
+		kfree(err);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return err;
+}
+
+static void free_tracing_log_err(struct tracing_log_err *err)
+{
+	kfree(err->cmd);
+	kfree(err);
+}
+
+static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr,
+						   int len)
 {
 	struct tracing_log_err *err;
 
 	if (tr->n_err_log_entries < TRACING_LOG_ERRS_MAX) {
-		err = kzalloc(sizeof(*err), GFP_KERNEL);
-		if (!err)
-			err = ERR_PTR(-ENOMEM);
-		else
+		err = alloc_tracing_log_err(len);
+		if (PTR_ERR(err) != -ENOMEM)
 			tr->n_err_log_entries++;
 
 		return err;
 	}
 
 	err = list_first_entry(&tr->err_log, struct tracing_log_err, list);
+	kfree(err->cmd);
+	err->cmd = kzalloc(len, GFP_KERNEL);
+	if (!err->cmd)
+		return ERR_PTR(-ENOMEM);
 	list_del(&err->list);
 
 	return err;
@@ -7811,22 +7837,25 @@ unsigned int err_pos(char *cmd, const char *str)
  */
 void tracing_log_err(struct trace_array *tr,
 		     const char *loc, const char *cmd,
-		     const char **errs, u8 type, u8 pos)
+		     const char **errs, u8 type, u16 pos)
 {
 	struct tracing_log_err *err;
+	int len = 0;
 
 	if (!tr)
 		tr = &global_trace;
 
+	len += sizeof(CMD_PREFIX) + 2 * sizeof("\n") + strlen(cmd) + 1;
+
 	mutex_lock(&tracing_err_log_lock);
-	err = get_tracing_log_err(tr);
+	err = get_tracing_log_err(tr, len);
 	if (PTR_ERR(err) == -ENOMEM) {
 		mutex_unlock(&tracing_err_log_lock);
 		return;
 	}
 
 	snprintf(err->loc, TRACING_LOG_LOC_MAX, "%s: error: ", loc);
-	snprintf(err->cmd, MAX_FILTER_STR_VAL,"\n" CMD_PREFIX "%s\n", cmd);
+	snprintf(err->cmd, len, "\n" CMD_PREFIX "%s\n", cmd);
 
 	err->info.errs = errs;
 	err->info.type = type;
@@ -7844,7 +7873,7 @@ static void clear_tracing_err_log(struct trace_array *tr)
 	mutex_lock(&tracing_err_log_lock);
 	list_for_each_entry_safe(err, next, &tr->err_log, list) {
 		list_del(&err->list);
-		kfree(err);
+		free_tracing_log_err(err);
 	}
 
 	tr->n_err_log_entries = 0;
@@ -7872,9 +7901,9 @@ static void tracing_err_log_seq_stop(struct seq_file *m, void *v)
 	mutex_unlock(&tracing_err_log_lock);
 }
 
-static void tracing_err_log_show_pos(struct seq_file *m, u8 pos)
+static void tracing_err_log_show_pos(struct seq_file *m, u16 pos)
 {
-	u8 i;
+	u16 i;
 
 	for (i = 0; i < sizeof(CMD_PREFIX) - 1; i++)
 		seq_putc(m, ' ');
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d038ddbf1bea..0f5e22238cd2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1878,7 +1878,7 @@ extern ssize_t trace_parse_run_command(struct file *file,
 extern unsigned int err_pos(char *cmd, const char *str);
 extern void tracing_log_err(struct trace_array *tr,
 			    const char *loc, const char *cmd,
-			    const char **errs, u8 type, u8 pos);
+			    const char **errs, u8 type, u16 pos);
 
 /*
  * Normal trace_printk() and friends allocates special buffers
-- 
2.34.1
