Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C087849EDA9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344524AbiA0Voo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344477AbiA0Vog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:44:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A9EC061749
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:44:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AABB61B27
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DD3C340E6;
        Thu, 27 Jan 2022 21:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643319875;
        bh=Q0y5wn24YklDkvVHK1u0viX9OsYVps/VGAHxFf/1zJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=GgvIvXKkU/lSPvW76QwvF03bSrXvlOutfcPM9Zae5Qg0LwQVBTVvx3KIw5gzF2BC2
         JYj40fwos8BKPLo7bp5uQ1FHe3Q439U/sEcU7i9wHql2THNYRsAe1KeqfVy17bwem8
         b4xmm66dWXf5AM62HkCuZSZ9HFtcBDK1bXljs8tAPl9Sn50uZv9OQb7j9BK0+cL2vA
         +30a6jeZWN8GZQ/Cc/3v9Rzjv4WF88RHTMfSkJ590gZNQfzIx+W8oqbobIQm/rzeEl
         Md9P6mC3Fkt2WoUb2cbc7msZ8dABBIrVNPa+aen5roKPUL3J2ItRBi2eqRmozljSh2
         90mknU9s0g46g==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 5/7] tracing: Remove size restriction on tracing_log_err cmd strings
Date:   Thu, 27 Jan 2022 15:44:19 -0600
Message-Id: <ca965f23256b350ebd94b3dc1a319f28e8267f5f.1643319703.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, tracing_log_err.cmd strings are restricted to a length of
MAX_FILTER_STR_VAL (256), which is too short for some commands already
seen in the wild (with cmd strings longer than that showing up
truncated).

Remove the restriction so that no command string is ever truncated.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.c | 55 +++++++++++++++++++++++++++++++++-----------
 kernel/trace/trace.h |  2 +-
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index addd8297874e..ba62607f9957 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7719,7 +7719,7 @@ const struct file_operations trace_min_max_fops = {
 struct err_info {
 	const char	**errs;	/* ptr to loc-specific array of err strings */
 	u8		type;	/* index into errs -> specific err string */
-	u8		pos;	/* MAX_FILTER_STR_VAL = 256 */
+	u16		pos;	/* caret position */
 	u64		ts;
 };
 
@@ -7727,26 +7727,52 @@ struct tracing_log_err {
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
@@ -7807,22 +7833,25 @@ unsigned int err_pos(char *cmd, const char *str)
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
@@ -7840,7 +7869,7 @@ static void clear_tracing_err_log(struct trace_array *tr)
 	mutex_lock(&tracing_err_log_lock);
 	list_for_each_entry_safe(err, next, &tr->err_log, list) {
 		list_del(&err->list);
-		kfree(err);
+		free_tracing_log_err(err);
 	}
 
 	tr->n_err_log_entries = 0;
@@ -7868,9 +7897,9 @@ static void tracing_err_log_seq_stop(struct seq_file *m, void *v)
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
2.17.1

