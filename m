Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072FA5862E6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbiHADBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239489AbiHADBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:01:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891D464D2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 20:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F07F2B80113
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71359C433C1;
        Mon,  1 Aug 2022 03:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659322863;
        bh=tZsq7uvAfvS+HC2mgiS0f5oOfApEPOE8wSgS/5+gdwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3fvcSONFMVxY1AaNLNrBQCL3HBsOjEwKvYc2BYeumPpqlwZQ1hWjSb9wGS7J74xH
         MZkXkFmy4y90zr8ZkumuYM7fjQT73OWhaMR4T+3kMc1ZTEhvG/W6dwkIZ8ChQz5hoh
         uwjMzw8gO4o46eBW3SaOMJIKELP/iUaWXQE8vWnCqeJoK2afqnHY/Wspk0gut4SdIx
         9vIRQYK/EQGP6xGu5/WKtjUByYWmsrll7NEk4uiY+ZvHcGcUanQ8MsnH4+gqhwuwqp
         oLXQRlqeqkdNUmqcvixeC8vTS/l0e5kiSATQQi028P81EJhy27d5d0mBwcygFNe79f
         E0bzgoEaVA55w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing: Add .graph suffix option to histogram value
Date:   Mon,  1 Aug 2022 12:00:59 +0900
Message-Id: <165932285960.2881436.15976871648945832570.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <165932284025.2881436.6085809619146158354.stgit@devnote2>
References: <165932284025.2881436.6085809619146158354.stgit@devnote2>
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
 kernel/trace/trace_events_hist.c |   72 +++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1103b9eb0a74..9efb0b9426dd 100644
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
 
@@ -5211,14 +5221,31 @@ static inline unsigned int __get_percentage(u64 val, u64 total)
 		return val / (total / 10000);
 }
 
+#define BAR_CHAR '#'
+
+static inline const char *__fill_bar_str(char *buf, int size, u64 val, u64 max)
+{
+	unsigned int len = __get_percentage(val, max) * size / 10000;
+	int i;
+
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
@@ -5226,8 +5253,11 @@ static void hist_trigger_entry_print(struct seq_file *m,
 	i = HITCOUNT_IDX;
 	val = tracing_map_read_sum(elt, i);
 	if (hist_data->fields[i]->flags & HIST_FIELD_FL_PERCENT) {
-		pc = __get_percentage(val, totals[i]);
+		pc = __get_percentage(val, maxs[i]);
 		seq_printf(m, " hitcount: %7u.%02u", pc / 100, pc % 100);
+	} else if (hist_data->fields[i]->flags & HIST_FIELD_FL_GRAPH) {
+		seq_printf(m, " hitcount: %20s",
+			   __fill_bar_str(bar, 20, val, maxs[i]));
 	} else
 		seq_printf(m, " hitcount: %10llu", val);
 
@@ -5240,9 +5270,13 @@ static void hist_trigger_entry_print(struct seq_file *m,
 
 		if (hist_data->fields[i]->flags & HIST_FIELD_FL_PERCENT) {
 			val = tracing_map_read_sum(elt, i);
-			pc = __get_percentage(val, totals[i]);
+			pc = __get_percentage(val, maxs[i]);
 			seq_printf(m, "  %s: %7u.%02u", field_name,
 				   pc / 100, pc % 100);
+		} else if (hist_data->fields[i]->flags & HIST_FIELD_FL_GRAPH) {
+			val = tracing_map_read_sum(elt, i);
+			seq_printf(m, "  %s: %20s", field_name,
+				   __fill_bar_str(bar, 20, val, maxs[i]));
 		} else if (hist_data->fields[i]->flags & HIST_FIELD_FL_HEX) {
 			seq_printf(m, "  %s: %10llx", field_name,
 				   tracing_map_read_sum(elt, i));
@@ -5263,7 +5297,8 @@ static int print_entries(struct seq_file *m,
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
 	int i, j, n_entries;
-	u64 *totals = NULL;
+	u64 *maxs = NULL;
+	u64 val;
 
 	n_entries = tracing_map_sort_entries(map, hist_data->sort_keys,
 					     hist_data->n_sort_keys,
@@ -5272,27 +5307,36 @@ static int print_entries(struct seq_file *m,
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
 

