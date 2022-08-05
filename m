Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6397358A483
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbiHEBf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbiHEBfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:35:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614E36431
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 18:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC355B82415
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3C2C433D6;
        Fri,  5 Aug 2022 01:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659663320;
        bh=Ztli622f+ksDSgP2B6lolORJ2RzHynM5tQpo7fyEms0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAolu1H3Xrt0cerZdqgkEe/weSoLPGja1qMss+vdO2bzVF8dUcES+XmFCCNHK5HQl
         uwGFpTDFco3b0Xlj34XI97NI7BY2eHCJGaSluq2co9dO2VfbShhpLTJz1liqMNtP+N
         u5yX9F2/GA876TBTh+raiE1nIt4rjcXrr0vt+dVZpQrLXyE8o1+Gf9kqEfjICo8vRA
         jQVxi+Pc3/xqpmSFI42bRRMW09BF9tpcxCHw4Ay/yF7Pgo7+4kH2dO0ko9lSteGtku
         n34DNH7bQRPWNDROg9BX4/UySRnRK4pdtrrQGtwjDsbRLWM/l44v8n+5i7vkx5nd7F
         LrdoZMGt2RhHw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] tracing: Add .percent suffix option to histogram values
Date:   Fri,  5 Aug 2022 10:35:17 +0900
Message-Id: <165966331728.3826604.8334449332454082730.stgit@devnote2>
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

Add .percent suffix option to show the histogram values in percentage.
This feature is useful when we need yo undersntand the overall trend
for the histograms of large values.
E.g. this shows the runtime percentage for each tasks.

------
  # cd /sys/kernel/debug/tracing/
  # echo hist:keys=pid:vals=hitcount,runtime.percent:sort=pid > \
    events/sched/sched_stat_runtime/trigger
  # sleep 10
  # cat events/sched/sched_stat_runtime/hist
 # event histogram
 #
 # trigger info: hist:keys=pid:vals=hitcount,runtime.percent:sort=pid:size=2048 [active]
 #

 { pid:         14 } hitcount:          9  runtime:       2.48
 { pid:         16 } hitcount:         38  runtime:       5.11
 { pid:         59 } hitcount:         30  runtime:      10.30
 { pid:         61 } hitcount:         73  runtime:      13.19
 { pid:         64 } hitcount:          1  runtime:       0.22
 { pid:         65 } hitcount:         13  runtime:       2.53
 { pid:         67 } hitcount:         11  runtime:       2.35
 { pid:         69 } hitcount:          8  runtime:       1.40
 { pid:         77 } hitcount:          7  runtime:       1.83
 { pid:        145 } hitcount:         41  runtime:      33.03
 { pid:        152 } hitcount:          8  runtime:      11.90
 { pid:        153 } hitcount:          6  runtime:       8.09
 { pid:        154 } hitcount:          5  runtime:       7.50

 Totals:
     Hits: 250
     Entries: 13
     Dropped: 0
-----

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Use div64_*().
  - Show an error when failing to calculate the percentage.
---
 kernel/trace/trace.c             |    3 +
 kernel/trace/trace_events_hist.c |   79 +++++++++++++++++++++++++++++++++++---
 2 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7eb5bce62500..4f54f2494370 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5700,7 +5700,8 @@ static const char readme_msg[] =
 	"\t            .syscall    display a syscall id as a syscall name\n"
 	"\t            .log2       display log2 value rather than raw number\n"
 	"\t            .buckets=size  display values in groups of size rather than raw number\n"
-	"\t            .usecs      display a common_timestamp in microseconds\n\n"
+	"\t            .usecs      display a common_timestamp in microseconds\n"
+	"\t            .percent    display a number of percentage value\n\n"
 	"\t    The 'pause' parameter can be used to pause an existing hist\n"
 	"\t    trigger or to start a hist trigger but not log any events\n"
 	"\t    until told to do so.  'continue' can be used to start or\n"
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fdf784620c28..c774d2ff02a8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -477,6 +477,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_ALIAS		= 1 << 16,
 	HIST_FIELD_FL_BUCKET		= 1 << 17,
 	HIST_FIELD_FL_CONST		= 1 << 18,
+	HIST_FIELD_FL_PERCENT		= 1 << 19,
 };
 
 struct var_defs {
@@ -1682,6 +1683,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "buckets";
 	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
 		flags_str = "usecs";
+	else if (hist_field->flags & HIST_FIELD_FL_PERCENT)
+		flags_str = "percent";
 
 	return flags_str;
 }
@@ -2290,6 +2293,10 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			if (ret || !(*buckets))
 				goto error;
 			*flags |= HIST_FIELD_FL_BUCKET;
+		} else if (strncmp(modifier, "percent", 7) == 0) {
+			if (*flags & (HIST_FIELD_FL_VAR | HIST_FIELD_FL_KEY))
+				goto error;
+			*flags |= HIST_FIELD_FL_PERCENT;
 		} else {
  error:
 			hist_err(tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(modifier));
@@ -4254,8 +4261,13 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 		if (!field_str)
 			break;
 
-		if (strcmp(field_str, "hitcount") == 0)
+		if (strncmp(field_str, "hitcount", 8) == 0 &&
+		    (field_str[8] == '.' || field_str[8] == '\0')) {
+			if (strncmp(field_str + 8, ".percent", 8) == 0)
+				hist_data->fields[HITCOUNT_IDX]->flags |=
+					HIST_FIELD_FL_PERCENT;
 			continue;
+		}
 
 		ret = create_val_field(hist_data, j++, file, field_str);
 		if (ret)
@@ -5190,18 +5202,44 @@ static void hist_trigger_print_key(struct seq_file *m,
 	seq_puts(m, "}");
 }
 
+/* Get the 100 times of the percentage of @val in @total */
+static inline unsigned int __get_percentage(u64 val, u64 total)
+{
+	if (!total)
+		return UINT_MAX;
+
+	if (val < (U64_MAX / 10000))
+		return (unsigned int)div64_ul(val * 10000, total);
+
+	total = div64_u64(total, 10000);
+	if (!total)
+		return UINT_MAX;
+
+	return (unsigned int)div64_ul(val, total);
+}
+
 static void hist_trigger_entry_print(struct seq_file *m,
 				     struct hist_trigger_data *hist_data,
+				     u64 *totals,
 				     void *key,
 				     struct tracing_map_elt *elt)
 {
 	const char *field_name;
-	unsigned int i;
+	unsigned int i, pc;
+	u64 val;
 
 	hist_trigger_print_key(m, hist_data, key, elt);
 
-	seq_printf(m, " hitcount: %10llu",
-		   tracing_map_read_sum(elt, HITCOUNT_IDX));
+	i = HITCOUNT_IDX;
+	val = tracing_map_read_sum(elt, i);
+	if (hist_data->fields[i]->flags & HIST_FIELD_FL_PERCENT) {
+		pc = __get_percentage(val, totals[i]);
+		if (pc == UINT_MAX)
+			seq_puts(m, " hitcount:    [ERROR]");
+		else
+			seq_printf(m, " hitcount: %7u.%02u", pc / 100, pc % 100);
+	} else
+		seq_printf(m, " hitcount: %10llu", val);
 
 	for (i = 1; i < hist_data->n_vals; i++) {
 		field_name = hist_field_name(hist_data->fields[i], 0);
@@ -5210,7 +5248,15 @@ static void hist_trigger_entry_print(struct seq_file *m,
 		    hist_data->fields[i]->flags & HIST_FIELD_FL_EXPR)
 			continue;
 
-		if (hist_data->fields[i]->flags & HIST_FIELD_FL_HEX) {
+		if (hist_data->fields[i]->flags & HIST_FIELD_FL_PERCENT) {
+			val = tracing_map_read_sum(elt, i);
+			pc = __get_percentage(val, totals[i]);
+			if (pc == UINT_MAX)
+				seq_printf(m, "  %s:    [ERROR]", field_name);
+			else
+				seq_printf(m, "  %s: %7u.%02u", field_name,
+				   pc / 100, pc % 100);
+		} else if (hist_data->fields[i]->flags & HIST_FIELD_FL_HEX) {
 			seq_printf(m, "  %s: %10llx", field_name,
 				   tracing_map_read_sum(elt, i));
 		} else {
@@ -5229,7 +5275,8 @@ static int print_entries(struct seq_file *m,
 {
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
-	int i, n_entries;
+	int i, j, n_entries;
+	u64 *totals = NULL;
 
 	n_entries = tracing_map_sort_entries(map, hist_data->sort_keys,
 					     hist_data->n_sort_keys,
@@ -5237,11 +5284,29 @@ static int print_entries(struct seq_file *m,
 	if (n_entries < 0)
 		return n_entries;
 
+	for (j = 0; j < hist_data->n_vals; j++) {
+		if (!(hist_data->fields[j]->flags & HIST_FIELD_FL_PERCENT))
+			continue;
+		if (!totals) {
+			totals = kcalloc(hist_data->n_vals, sizeof(u64),
+					 GFP_KERNEL);
+			if (!totals) {
+				n_entries = -ENOMEM;
+				goto out;
+			}
+		}
+		for (i = 0; i < n_entries; i++)
+			totals[j] += tracing_map_read_sum(
+					sort_entries[i]->elt, j);
+	}
+
 	for (i = 0; i < n_entries; i++)
-		hist_trigger_entry_print(m, hist_data,
+		hist_trigger_entry_print(m, hist_data, totals,
 					 sort_entries[i]->key,
 					 sort_entries[i]->elt);
 
+	kfree(totals);
+out:
 	tracing_map_destroy_sort_entries(sort_entries, n_entries);
 
 	return n_entries;

