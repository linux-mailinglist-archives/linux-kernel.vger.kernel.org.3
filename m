Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C8358A480
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbiHEBfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240425AbiHEBfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586C76431
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 18:35:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB65A6194D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E75C433D6;
        Fri,  5 Aug 2022 01:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659663330;
        bh=vfY2k+u4yIXPvcqWi/tdQyVM65pO/1c8tUVm53H+awM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebq0bGrFq8GGmKrv2KZjjj3ZbidNQUvf3w2zqx/3KjMyz06yf7MGxTfmx2ELWdRX8
         BugfLJTd6+FKp8a/6U+UNGN7y1X3TSA07nm3bsSzdzhhENPk2cvhp6C4CwROeVoqAv
         8gBrGExW2NsvJ+z2QMpOh3VfWpqX9lS7OJaJMEAQS41JfV4PdBnNgYAXWaDyk06fnx
         FfOqM+L7XERg7BsbL2Q3j567o27dANMfNEMMRc/3oby8SaTi0ZJRhTvd23fnbxNLTh
         E7pyGl4CTYtLpx7KDBKxfBbDhuA2duRuz4KhMtqCqDgH3iRUDbMFpRoioqnMSusL23
         gDtiQ8n2PbrXA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] tracing: Add .graph suffix option to histogram value
Date:   Fri,  5 Aug 2022 10:35:26 +0900
Message-Id: <165966332610.3826604.10632938036058057943.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <165966330764.3826604.9358384228095103695.stgit@devnote2>
References: <165966330764.3826604.9358384228095103695.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add the .graph suffix which shows the bar graph of the histogram value.

For example, the below example shows that the bar graph
of the histogram of the runtime for each tasks.

------
  # cd /sys/kernel/debug/tracing/
  # echo hist:keys=pid:vals=runtime.graph:sort=pid > \
   events/sched/sched_stat_runtime/trigger
  # sleep 10
  # cat events/sched/sched_stat_runtime/hist
 # event histogram
 #
 # trigger info: hist:keys=pid:vals=hitcount,runtime.graph:sort=pid:size=2048 [active]
 #

 { pid:         14 } hitcount:          2  runtime:
 { pid:         16 } hitcount:          8  runtime:
 { pid:         26 } hitcount:          1  runtime:
 { pid:         57 } hitcount:          3  runtime:
 { pid:         61 } hitcount:         20  runtime: ###
 { pid:         66 } hitcount:          2  runtime:
 { pid:         70 } hitcount:          3  runtime:
 { pid:         72 } hitcount:          2  runtime:
 { pid:        145 } hitcount:         14  runtime: ####################
 { pid:        152 } hitcount:          5  runtime: #######
 { pid:        153 } hitcount:          2  runtime: ####

 Totals:
     Hits: 62
     Entries: 11
     Dropped: 0
-------

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Show an error when failing to calculate the percentage.
---
 kernel/trace/trace_events_hist.c |   78 +++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c774d2ff02a8..3d609f457e8c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -478,6 +478,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_BUCKET		= 1 << 17,
 	HIST_FIELD_FL_CONST		= 1 << 18,
 	HIST_FIELD_FL_PERCENT		= 1 << 19,
+	HIST_FIELD_FL_GRAPH		= 1 << 20,
 };
 
 struct var_defs {
@@ -1685,6 +1686,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "usecs";
 	else if (hist_field->flags & HIST_FIELD_FL_PERCENT)
 		flags_str = "percent";
+	else if (hist_field->flags & HIST_FIELD_FL_GRAPH)
+		flags_str = "graph";
 
 	return flags_str;
 }
@@ -2297,6 +2300,10 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			if (*flags & (HIST_FIELD_FL_VAR | HIST_FIELD_FL_KEY))
 				goto error;
 			*flags |= HIST_FIELD_FL_PERCENT;
+		} else if (strncmp(modifier, "graph", 5) == 0) {
+			if (*flags & (HIST_FIELD_FL_VAR | HIST_FIELD_FL_KEY))
+				goto error;
+			*flags |= HIST_FIELD_FL_GRAPH;
 		} else {
  error:
 			hist_err(tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(modifier));
@@ -4266,6 +4273,9 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 			if (strncmp(field_str + 8, ".percent", 8) == 0)
 				hist_data->fields[HITCOUNT_IDX]->flags |=
 					HIST_FIELD_FL_PERCENT;
+			if (strncmp(field_str + 8, ".graph", 8) == 0)
+				hist_data->fields[HITCOUNT_IDX]->flags |=
+					HIST_FIELD_FL_GRAPH;
 			continue;
 		}
 
@@ -5218,14 +5228,37 @@ static inline unsigned int __get_percentage(u64 val, u64 total)
 	return (unsigned int)div64_ul(val, total);
 }
 
+#define BAR_CHAR '#'
+
+static inline const char *__fill_bar_str(char *buf, int size, u64 val, u64 max)
+{
+	unsigned int len = __get_percentage(val, max);
+	int i;
+
+	if (len == UINT_MAX) {
+		snprintf(buf, size, "[ERROR]");
+		return buf;
+	}
+
+	len = len * size / 10000;
+	for (i = 0; i < len && i < size; i++)
+		buf[i] = BAR_CHAR;
+	while (i < size)
+		buf[i++] = ' ';
+	buf[size] = '\0';
+
+	return buf;
+}
+
 static void hist_trigger_entry_print(struct seq_file *m,
 				     struct hist_trigger_data *hist_data,
-				     u64 *totals,
+				     u64 *maxs,
 				     void *key,
 				     struct tracing_map_elt *elt)
 {
 	const char *field_name;
 	unsigned int i, pc;
+	char bar[21];
 	u64 val;
 
 	hist_trigger_print_key(m, hist_data, key, elt);
@@ -5233,11 +5266,14 @@ static void hist_trigger_entry_print(struct seq_file *m,
 	i = HITCOUNT_IDX;
 	val = tracing_map_read_sum(elt, i);
 	if (hist_data->fields[i]->flags & HIST_FIELD_FL_PERCENT) {
-		pc = __get_percentage(val, totals[i]);
+		pc = __get_percentage(val, maxs[i]);
 		if (pc == UINT_MAX)
 			seq_puts(m, " hitcount:    [ERROR]");
 		else
 			seq_printf(m, " hitcount: %7u.%02u", pc / 100, pc % 100);
+	} else if (hist_data->fields[i]->flags & HIST_FIELD_FL_GRAPH) {
+		seq_printf(m, " hitcount: %20s",
+			   __fill_bar_str(bar, 20, val, maxs[i]));
 	} else
 		seq_printf(m, " hitcount: %10llu", val);
 
@@ -5250,12 +5286,16 @@ static void hist_trigger_entry_print(struct seq_file *m,
 
 		if (hist_data->fields[i]->flags & HIST_FIELD_FL_PERCENT) {
 			val = tracing_map_read_sum(elt, i);
-			pc = __get_percentage(val, totals[i]);
+			pc = __get_percentage(val, maxs[i]);
 			if (pc == UINT_MAX)
 				seq_printf(m, "  %s:    [ERROR]", field_name);
 			else
 				seq_printf(m, "  %s: %7u.%02u", field_name,
 				   pc / 100, pc % 100);
+		} else if (hist_data->fields[i]->flags & HIST_FIELD_FL_GRAPH) {
+			val = tracing_map_read_sum(elt, i);
+			seq_printf(m, "  %s: %20s", field_name,
+				   __fill_bar_str(bar, 20, val, maxs[i]));
 		} else if (hist_data->fields[i]->flags & HIST_FIELD_FL_HEX) {
 			seq_printf(m, "  %s: %10llx", field_name,
 				   tracing_map_read_sum(elt, i));
@@ -5276,7 +5316,8 @@ static int print_entries(struct seq_file *m,
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
 	int i, j, n_entries;
-	u64 *totals = NULL;
+	u64 *maxs = NULL;
+	u64 val;
 
 	n_entries = tracing_map_sort_entries(map, hist_data->sort_keys,
 					     hist_data->n_sort_keys,
@@ -5285,27 +5326,36 @@ static int print_entries(struct seq_file *m,
 		return n_entries;
 
 	for (j = 0; j < hist_data->n_vals; j++) {
-		if (!(hist_data->fields[j]->flags & HIST_FIELD_FL_PERCENT))
+		if (!(hist_data->fields[j]->flags &
+			(HIST_FIELD_FL_PERCENT | HIST_FIELD_FL_GRAPH)))
 			continue;
-		if (!totals) {
-			totals = kcalloc(hist_data->n_vals, sizeof(u64),
-					 GFP_KERNEL);
-			if (!totals) {
+		if (!maxs) {
+			maxs = kcalloc(hist_data->n_vals, sizeof(u64),
+				       GFP_KERNEL);
+			if (!maxs) {
 				n_entries = -ENOMEM;
 				goto out;
 			}
 		}
-		for (i = 0; i < n_entries; i++)
-			totals[j] += tracing_map_read_sum(
-					sort_entries[i]->elt, j);
+		/*
+		 * If the n-th field shows percentage, the maxs[n] has the
+		 * total, or it has the maximum number.
+		 */
+		for (i = 0; i < n_entries; i++) {
+			val = tracing_map_read_sum(sort_entries[i]->elt, j);
+			if (hist_data->fields[j]->flags & HIST_FIELD_FL_PERCENT)
+				maxs[j] += val;
+			else if (maxs[j] < val)
+				maxs[j] = val;
+		}
 	}
 
 	for (i = 0; i < n_entries; i++)
-		hist_trigger_entry_print(m, hist_data, totals,
+		hist_trigger_entry_print(m, hist_data, maxs,
 					 sort_entries[i]->key,
 					 sort_entries[i]->elt);
 
-	kfree(totals);
+	kfree(maxs);
 out:
 	tracing_map_destroy_sort_entries(sort_entries, n_entries);
 

