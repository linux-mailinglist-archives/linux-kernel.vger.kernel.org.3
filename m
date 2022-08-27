Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B730D5A3445
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 06:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbiH0EDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 00:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiH0EDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:03:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F6BE3C05
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 21:03:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 21C49CE29C0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4566C433D6;
        Sat, 27 Aug 2022 04:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661573027;
        bh=OOmpaaDy9ShZc/kMESeHiG2wVIE56UJPU3LZ7EpPjls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uSv3u/R8ZwpqM+tn3ceEmJptDLmcGihQuX0qHw9xuuWvLo70s3gHwDxSKaZ07t11m
         hRlVxKZwedI4XqF3wO6BR53NC0FS/d4Gh1WLEF+3dJ+oBjo3GFLeQM1AmaK3Tmo7Sm
         zigKlcf1UvwQStvqvU98r1rG4uPtSb9wvXuUTjmN5855Vx9R8bF9ILquOUonPF3X7O
         S355ryvTo/CwMAtHqFnlEc8IqHMHeIrAZw7Hx+U9ZP74CXWoUgBGS2IkxQbR9rNe6h
         L0zfbrlpc4nxHiCY57UbCLe+NxXYy/urZpjI4ncbnK1rZWh6uFcEkEx6y7PIyvgiH3
         tljYkrzskNyOQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] tracing: Add .graph suffix option to histogram value
Date:   Sat, 27 Aug 2022 13:03:43 +0900
Message-Id: <166157302302.348924.9998983489821621084.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166157298537.348924.2537162090505397377.stgit@devnote2>
References: <166157298537.348924.2537162090505397377.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
 Changes in v3:
  - Show hitcount.graph in trigger info correctly.
  - Show both hitcount.percent and hitcount.graph on the same histogram.
 Changes in v2:
  - Show an error when failing to calculate the percentage.
---
 kernel/trace/trace_events_hist.c |   82 +++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index af6c140f85e6..fceea784fded 100644
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
+			if (strncmp(field_str + 8, ".graph", 8) == 0)
+				hist_data->fields[HITCOUNT_IDX]->flags |=
+					HIST_FIELD_FL_GRAPH;
 			continue;
 		}
 
@@ -5316,20 +5326,52 @@ static inline unsigned int __get_percentage(u64 val, u64 total)
 	return val ? UINT_MAX : 0;
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
+struct hist_val_stat {
+	u64 max;
+	u64 total;
+};
+
 static void hist_trigger_print_val(struct seq_file *m, unsigned int idx,
 				   const char *field_name, unsigned long flags,
-				   u64 *totals, struct tracing_map_elt *elt)
+				   struct hist_val_stat *stats,
+				   struct tracing_map_elt *elt)
 {
 	u64 val = tracing_map_read_sum(elt, idx);
 	unsigned int pc;
+	char bar[21];
 
 	if (flags & HIST_FIELD_FL_PERCENT) {
-		pc = __get_percentage(val, totals[idx]);
+		pc = __get_percentage(val, stats[idx].total);
 		if (pc == UINT_MAX)
 			seq_printf(m, " %s (%%):[ERROR]", field_name);
 		else
 			seq_printf(m, " %s (%%): %3u.%02u", field_name,
 					pc / 100, pc % 100);
+	} else if (flags & HIST_FIELD_FL_GRAPH) {
+		seq_printf(m, " %s: %20s", field_name,
+			   __fill_bar_str(bar, 20, val, stats[idx].max));
 	} else if (flags & HIST_FIELD_FL_HEX) {
 		seq_printf(m, " %s: %10llx", field_name, val);
 	} else {
@@ -5339,7 +5381,7 @@ static void hist_trigger_print_val(struct seq_file *m, unsigned int idx,
 
 static void hist_trigger_entry_print(struct seq_file *m,
 				     struct hist_trigger_data *hist_data,
-				     u64 *totals,
+				     struct hist_val_stat *stats,
 				     void *key,
 				     struct tracing_map_elt *elt)
 {
@@ -5350,7 +5392,7 @@ static void hist_trigger_entry_print(struct seq_file *m,
 	hist_trigger_print_key(m, hist_data, key, elt);
 
 	flags = hist_data->fields[i]->flags;
-	hist_trigger_print_val(m, i, "hitcount", flags, totals, elt);
+	hist_trigger_print_val(m, i, "hitcount", flags, stats, elt);
 
 	for (i = 1; i < hist_data->n_vals; i++) {
 		field_name = hist_field_name(hist_data->fields[i], 0);
@@ -5360,7 +5402,7 @@ static void hist_trigger_entry_print(struct seq_file *m,
 			continue;
 
 		seq_puts(m, " ");
-		hist_trigger_print_val(m, i, field_name, flags, totals, elt);
+		hist_trigger_print_val(m, i, field_name, flags, stats, elt);
 	}
 
 	print_actions(m, hist_data, elt);
@@ -5374,7 +5416,8 @@ static int print_entries(struct seq_file *m,
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
 	int i, j, n_entries;
-	u64 *totals = NULL;
+	struct hist_val_stat *stats = NULL;
+	u64 val;
 
 	n_entries = tracing_map_sort_entries(map, hist_data->sort_keys,
 					     hist_data->n_sort_keys,
@@ -5382,28 +5425,33 @@ static int print_entries(struct seq_file *m,
 	if (n_entries < 0)
 		return n_entries;
 
+	/* Calculate the max and the total for each field if needed. */
 	for (j = 0; j < hist_data->n_vals; j++) {
-		if (!(hist_data->fields[j]->flags & HIST_FIELD_FL_PERCENT))
+		if (!(hist_data->fields[j]->flags &
+			(HIST_FIELD_FL_PERCENT | HIST_FIELD_FL_GRAPH)))
 			continue;
-		if (!totals) {
-			totals = kcalloc(hist_data->n_vals, sizeof(u64),
-					 GFP_KERNEL);
-			if (!totals) {
+		if (!stats) {
+			stats = kcalloc(hist_data->n_vals, sizeof(*stats),
+				       GFP_KERNEL);
+			if (!stats) {
 				n_entries = -ENOMEM;
 				goto out;
 			}
 		}
-		for (i = 0; i < n_entries; i++)
-			totals[j] += tracing_map_read_sum(
-					sort_entries[i]->elt, j);
+		for (i = 0; i < n_entries; i++) {
+			val = tracing_map_read_sum(sort_entries[i]->elt, j);
+			stats[j].total += val;
+			if (stats[j].max < val)
+				stats[j].max = val;
+		}
 	}
 
 	for (i = 0; i < n_entries; i++)
-		hist_trigger_entry_print(m, hist_data, totals,
+		hist_trigger_entry_print(m, hist_data, stats,
 					 sort_entries[i]->key,
 					 sort_entries[i]->elt);
 
-	kfree(totals);
+	kfree(stats);
 out:
 	tracing_map_destroy_sort_entries(sort_entries, n_entries);
 
@@ -5828,6 +5876,8 @@ static int event_hist_trigger_print(struct seq_file *m,
 			seq_puts(m, "hitcount");
 			if (field->flags & HIST_FIELD_FL_PERCENT)
 				seq_puts(m, ".percent");
+			else if (field->flags & HIST_FIELD_FL_GRAPH)
+				seq_puts(m, ".graph");
 		} else {
 			seq_puts(m, ",");
 			hist_field_print(m, field);

