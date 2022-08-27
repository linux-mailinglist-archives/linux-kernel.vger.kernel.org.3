Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB295A3444
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 06:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbiH0EDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 00:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239818AbiH0EDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B097AE3C36
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 21:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ABC361E10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB8DC433C1;
        Sat, 27 Aug 2022 04:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661573017;
        bh=Z/cNKmpFdYDoBjNtYCch9+5/pqpLwEDPB2B5qdUHBvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYPpJAnRjWkXpd+0lp7uZ1tn5WCPbzeHJE7vbS4F93ZmYqbQr3d0ZXqhhTi9Ux3W0
         2YtMiw2S2f89JOkEiO1Hcgl+weM987ETFmY3ALoKK4YySura/FaMxT7k6t11fyzANM
         YJLlSCFFcVs5M0+vAjwG/N7F2hQNJHAQpcgmmXycdLBLY1IOmsIjVdmSSRUKeLdyZ4
         M9aQYQY4hmwu0OC1kvSQsdUXLwXG2equehKjQ7h8dukuFkwszEyse8P5sFlfyXRbea
         zJ33t1e079+NsCXNyh/1v1diRAKc/npMuzsF7EpFg8Bu7g+wPfkAdUMER7pV2JKhsI
         bS/EGm61rMlLw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] tracing: Add .percent suffix option to histogram values
Date:   Sat, 27 Aug 2022 13:03:33 +0900
Message-Id: <166157301366.348924.3715744119667672294.stgit@devnote2>
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

 { pid:          8 } hitcount:          7  runtime (%):   4.14
 { pid:         14 } hitcount:          5  runtime (%):   3.69
 { pid:         16 } hitcount:         11  runtime (%):   3.41
 { pid:         61 } hitcount:         41  runtime (%):  19.75
 { pid:         65 } hitcount:          4  runtime (%):   1.48
 { pid:         70 } hitcount:          6  runtime (%):   3.60
 { pid:         72 } hitcount:          2  runtime (%):   1.10
 { pid:        144 } hitcount:         10  runtime (%):  32.01
 { pid:        151 } hitcount:          8  runtime (%):  22.66
 { pid:        152 } hitcount:          2  runtime (%):   8.10

 Totals:
     Hits: 96
     Entries: 10
     Dropped: 0
-----

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v4:
  - Port on the Tom's hitcount patch.
 Changes in v3:
  - Show "(%)" in the field name.
  - Return div0 error only if the value is not zero.
  - Simplify the print code with hist_trigger_print_val().
  - Show hitcount percentage correctly.
 Changes in v2:
  - Use div64_*().
  - Show an error when failing to calculate the percentage.
---
 kernel/trace/trace.c             |    3 +
 kernel/trace/trace_events_hist.c |  105 +++++++++++++++++++++++++++++++-------
 2 files changed, 88 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3005279165d..5e5efc550ac4 100644
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
index e80a41e380bb..af6c140f85e6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -506,6 +506,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_ALIAS		= 1 << 16,
 	HIST_FIELD_FL_BUCKET		= 1 << 17,
 	HIST_FIELD_FL_CONST		= 1 << 18,
+	HIST_FIELD_FL_PERCENT		= 1 << 19,
 };
 
 struct var_defs {
@@ -1707,6 +1708,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "buckets";
 	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
 		flags_str = "usecs";
+	else if (hist_field->flags & HIST_FIELD_FL_PERCENT)
+		flags_str = "percent";
 
 	return flags_str;
 }
@@ -2315,6 +2318,10 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
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
@@ -4350,9 +4357,12 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 		if (!field_str)
 			break;
 
-		if (strcmp(field_str, "hitcount") == 0) {
-			if (!n_hitcount++)
-				continue;
+		if (!n_hitcount++ && strncmp(field_str, "hitcount", 8) == 0 &&
+		    (field_str[8] == '.' || field_str[8] == '\0')) {
+			if (strncmp(field_str + 8, ".percent", 8) == 0)
+				hist_data->fields[HITCOUNT_IDX]->flags |=
+					HIST_FIELD_FL_PERCENT;
+			continue;
 		}
 
 		ret = create_val_field(hist_data, j++, file, field_str);
@@ -5288,33 +5298,69 @@ static void hist_trigger_print_key(struct seq_file *m,
 	seq_puts(m, "}");
 }
 
+/* Get the 100 times of the percentage of @val in @total */
+static inline unsigned int __get_percentage(u64 val, u64 total)
+{
+	if (!total)
+		goto div0;
+
+	if (val < (U64_MAX / 10000))
+		return (unsigned int)div64_ul(val * 10000, total);
+
+	total = div64_u64(total, 10000);
+	if (!total)
+		goto div0;
+
+	return (unsigned int)div64_ul(val, total);
+div0:
+	return val ? UINT_MAX : 0;
+}
+
+static void hist_trigger_print_val(struct seq_file *m, unsigned int idx,
+				   const char *field_name, unsigned long flags,
+				   u64 *totals, struct tracing_map_elt *elt)
+{
+	u64 val = tracing_map_read_sum(elt, idx);
+	unsigned int pc;
+
+	if (flags & HIST_FIELD_FL_PERCENT) {
+		pc = __get_percentage(val, totals[idx]);
+		if (pc == UINT_MAX)
+			seq_printf(m, " %s (%%):[ERROR]", field_name);
+		else
+			seq_printf(m, " %s (%%): %3u.%02u", field_name,
+					pc / 100, pc % 100);
+	} else if (flags & HIST_FIELD_FL_HEX) {
+		seq_printf(m, " %s: %10llx", field_name, val);
+	} else {
+		seq_printf(m, " %s: %10llu", field_name, val);
+	}
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
+	unsigned int i = HITCOUNT_IDX;
+	unsigned long flags;
 
 	hist_trigger_print_key(m, hist_data, key, elt);
 
-	seq_printf(m, " hitcount: %10llu",
-		   tracing_map_read_sum(elt, HITCOUNT_IDX));
+	flags = hist_data->fields[i]->flags;
+	hist_trigger_print_val(m, i, "hitcount", flags, totals, elt);
 
 	for (i = 1; i < hist_data->n_vals; i++) {
 		field_name = hist_field_name(hist_data->fields[i], 0);
+		flags = hist_data->fields[i]->flags;
 
-		if (hist_data->fields[i]->flags & HIST_FIELD_FL_VAR ||
-		    hist_data->fields[i]->flags & HIST_FIELD_FL_EXPR)
+		if (flags & HIST_FIELD_FL_VAR || flags & HIST_FIELD_FL_EXPR)
 			continue;
 
-		if (hist_data->fields[i]->flags & HIST_FIELD_FL_HEX) {
-			seq_printf(m, "  %s: %10llx", field_name,
-				   tracing_map_read_sum(elt, i));
-		} else {
-			seq_printf(m, "  %s: %10llu", field_name,
-				   tracing_map_read_sum(elt, i));
-		}
+		seq_puts(m, " ");
+		hist_trigger_print_val(m, i, field_name, flags, totals, elt);
 	}
 
 	print_actions(m, hist_data, elt);
@@ -5327,7 +5373,8 @@ static int print_entries(struct seq_file *m,
 {
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
-	int i, n_entries;
+	int i, j, n_entries;
+	u64 *totals = NULL;
 
 	n_entries = tracing_map_sort_entries(map, hist_data->sort_keys,
 					     hist_data->n_sort_keys,
@@ -5335,11 +5382,29 @@ static int print_entries(struct seq_file *m,
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
@@ -5759,9 +5824,11 @@ static int event_hist_trigger_print(struct seq_file *m,
 			continue;
 		}
 
-		if (i == HITCOUNT_IDX)
+		if (i == HITCOUNT_IDX) {
 			seq_puts(m, "hitcount");
-		else {
+			if (field->flags & HIST_FIELD_FL_PERCENT)
+				seq_puts(m, ".percent");
+		} else {
 			seq_puts(m, ",");
 			hist_field_print(m, field);
 		}

