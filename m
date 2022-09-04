Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019435AC241
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiIDEMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiIDEMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:12:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B6F4AD79
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 21:12:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D59A60EA6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 04:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E58C433C1;
        Sun,  4 Sep 2022 04:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662264763;
        bh=XSHUEMROafhiwqOPJ9+GeA4iG5g0bTInya8CRzegI70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxGZFfW7k/44SOg2qWmowee+Xa1UsJagZfs45Vd6W0HcshDn6Puj7mwfaw6IUOPS4
         7meoWbCvfRUaZ45BlyZO+ck8xMJz83iNG7psZBPYF+VWm57BUoYwHjvvqkwWi8YY5R
         mAxpKObTUufVIM7JjBcJEF8NI1ci9WyczDyfBcUX9D4PwWFo3Q90mpPZyEi8AeEOCq
         tIN5Ysp+DYfNOK002nqJviGU6/qNAe2oNCGvm5JPnSVHlxCIWnmh4Md/qRcIbhLq3U
         Mfi7mSp3u1aAsxEhvNP+rGGhlkTz3MfM4QrEarn3lVwk5Os/8yz/gdWhLXeez8xvdj
         fZpiBFKgkjk/g==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] tracing: Add .percent suffix option to histogram values
Date:   Sun,  4 Sep 2022 13:12:39 +0900
Message-Id: <166226475913.223837.6289430121343122141.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166226473132.223837.9011128463174539022.stgit@devnote2>
References: <166226473132.223837.9011128463174539022.stgit@devnote2>
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
 Changes in v5:
  - Show raw hitcount value always even if hitcount.percent
    is specified.
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
 kernel/trace/trace_events_hist.c |   90 ++++++++++++++++++++++++++++++++------
 2 files changed, 78 insertions(+), 15 deletions(-)

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
index e80a41e380bb..053b23e10c48 100644
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
@@ -5288,33 +5295,69 @@ static void hist_trigger_print_key(struct seq_file *m,
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
+	/* At first, show the raw hitcount always */
+	hist_trigger_print_val(m, i, "hitcount", 0, totals, elt);
 
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
@@ -5327,7 +5370,8 @@ static int print_entries(struct seq_file *m,
 {
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
-	int i, n_entries;
+	int i, j, n_entries;
+	u64 *totals = NULL;
 
 	n_entries = tracing_map_sort_entries(map, hist_data->sort_keys,
 					     hist_data->n_sort_keys,
@@ -5335,11 +5379,29 @@ static int print_entries(struct seq_file *m,
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

