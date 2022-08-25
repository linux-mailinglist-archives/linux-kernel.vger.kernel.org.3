Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489DB5A1C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbiHYWTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244237AbiHYWTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:19:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437C9BD0AD
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2976B82ACE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9ADC433D6;
        Thu, 25 Aug 2022 22:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661465952;
        bh=61yJdy1CU12tJc5JG4goNgQTDKMWhUH+DuAXzbk7b0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ikaCPQwVaKhRGYMzCuonJSu2t62maZVPE5ZChqnq6+kEZmyuKGZIlgb0TOpfYaZcx
         2J563OcEhkuuXETveYU31IOvTjxgbb6eaqi9RYKPyFfd3Y0n9mTU6uAMQiqaZbpIUe
         4FdqcAu6YsHgXRWfpdkCCq62K6rjHfjKlRpjz3tORLYZJthAGF2keHvGo9fygAqXNl
         7nbkNIA3+BhXxc1S1qhelG8MTt9jtNMJwR5Yg/DfPfuvqvyF4nONsRKviUYu9m5lRf
         0dDQYFusMvtuiDS688NikaAzPhMFVZ/+jxi4/o31YQ20uSGRNwDiUuNYqWVfqh2+bB
         csa/huvDyeBEA==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tracing: Add .graph suffix option to histogram value
Date:   Thu, 25 Aug 2022 17:19:03 -0500
Message-Id: <886fe9b6098eddb9d298e8a3f07bbea61acdac16.1661464992.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1661464992.git.zanussi@kernel.org>
References: <cover.1661464992.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

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

 Conflicts:
	kernel/trace/trace_events_hist.c
---
 kernel/trace/trace_events_hist.c | 80 ++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8e8942e62900..f31f1adab9fa 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -507,6 +507,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_BUCKET		= 1 << 17,
 	HIST_FIELD_FL_CONST		= 1 << 18,
 	HIST_FIELD_FL_PERCENT		= 1 << 19,
+	HIST_FIELD_FL_GRAPH		= 1 << 20,
 };
 
 struct var_defs {
@@ -1710,6 +1711,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "usecs";
 	else if (hist_field->flags & HIST_FIELD_FL_PERCENT)
 		flags_str = "percent";
+	else if (hist_field->flags & HIST_FIELD_FL_GRAPH)
+		flags_str = "graph";
 
 	return flags_str;
 }
@@ -2322,6 +2325,10 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
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
@@ -4362,6 +4369,9 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 				if (strncmp(field_str + 8, ".percent", 8) == 0)
 					hist_data->fields[HITCOUNT_IDX]->flags |=
 						HIST_FIELD_FL_PERCENT;
+				if (strncmp(field_str + 8, ".graph", 8) == 0)
+					hist_data->fields[HITCOUNT_IDX]->flags |=
+						HIST_FIELD_FL_GRAPH;
 			}
 			continue;
 		}
@@ -5315,14 +5325,37 @@ static inline unsigned int __get_percentage(u64 val, u64 total)
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
@@ -5330,11 +5363,14 @@ static void hist_trigger_entry_print(struct seq_file *m,
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
 
@@ -5347,12 +5383,16 @@ static void hist_trigger_entry_print(struct seq_file *m,
 
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
@@ -5373,7 +5413,8 @@ static int print_entries(struct seq_file *m,
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
 	int i, j, n_entries;
-	u64 *totals = NULL;
+	u64 *maxs = NULL;
+	u64 val;
 
 	n_entries = tracing_map_sort_entries(map, hist_data->sort_keys,
 					     hist_data->n_sort_keys,
@@ -5382,27 +5423,36 @@ static int print_entries(struct seq_file *m,
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
 
@@ -5827,6 +5877,8 @@ static int event_hist_trigger_print(struct seq_file *m,
 			seq_puts(m, "hitcount");
 			if (field->flags & HIST_FIELD_FL_PERCENT)
 				seq_puts(m, ".percent");
+			if (field->flags & HIST_FIELD_FL_GRAPH)
+				seq_puts(m, ".graph");
 		} else {
 			seq_puts(m, ",");
 			hist_field_print(m, field);
-- 
2.34.1

