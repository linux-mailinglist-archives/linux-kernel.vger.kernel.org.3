Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F4F5A3440
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 06:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiH0EEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 00:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240971AbiH0EEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:04:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06AE42F9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 21:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE62861E0E
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BDDC433C1;
        Sat, 27 Aug 2022 04:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661573036;
        bh=f9mXihupzTDK1250qHChyNfWYWBi2D+NT5drxWfjNVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEmwtVBod0GbmaXmMPKNucuW/S2OBHMTPsQoSnR2YoQK6xZ0HK/kbX5+qFTlLHT+i
         gNW0DlqV2nvg4ux8OrMj/2tHiTApgJ+rtDk44SSdaIFUrgzAG6x7CykljFQTQXx4ps
         C/a/f3tbG+XE0LHRwxpT2YYLXrCv3Iyohq/z8gGwpfI2w9e6gUGp94G+a6X0YlvCN5
         lUFtwYHDOkQxJJDGWJPwqZ+4VncIxdMhcMyZ0mc8XvtC80j9uWLEJSF2duhulBPqh1
         ZGLlYD7WJzc20+nAHnIusE4XIIylMzubBdwya1Y6d6A/8uJS/sfw4Le4T8M6/iGa75
         hyWKWzbULsqew==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] tracing: Show hitcount value only when specified
Date:   Sat, 27 Aug 2022 13:03:52 +0900
Message-Id: <166157303240.348924.7493529171143320258.stgit@devnote2>
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

Show the hitcount value only when it is specified explicitly or
no value is specified.

  # cd /sys/kernel/debug/tracing/
  # echo hist:keys=pid:vals=runtime.percent,runtime.graph:sort=pid > \
        events/sched/sched_stat_runtime/trigger
  # sleep 10
  # cat events/sched/sched_stat_runtime/hist
 # event histogram
 #
 # trigger info: hist:keys=pid:vals=runtime.percent,runtime.graph:sort=pid:size=2048 [active]
 #

 { pid:         14 }  runtime (%):   0.97  runtime:
 { pid:         16 }  runtime (%):   1.74  runtime:
 { pid:         26 }  runtime (%):   0.13  runtime:
 { pid:         57 }  runtime (%):   7.06  runtime: ###
 { pid:         61 }  runtime (%):  11.06  runtime: #####
 { pid:         65 }  runtime (%):   0.75  runtime:
 { pid:         70 }  runtime (%):   0.98  runtime:
 { pid:         77 }  runtime (%):   0.10  runtime:
 { pid:        125 }  runtime (%):   0.56  runtime:
 { pid:        146 }  runtime (%):  37.53  runtime: ####################
 { pid:        152 }  runtime (%):  23.67  runtime: ############
 { pid:        153 }  runtime (%):  15.39  runtime: ########


Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c |   33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fceea784fded..35feeea84a38 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -508,6 +508,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_CONST		= 1 << 18,
 	HIST_FIELD_FL_PERCENT		= 1 << 19,
 	HIST_FIELD_FL_GRAPH		= 1 << 20,
+	HIST_FIELD_FL_VAL		= 1 << 21,
 };
 
 struct var_defs {
@@ -4204,7 +4205,8 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 	if (WARN_ON(val_idx >= TRACING_MAP_VALS_MAX))
 		return -EINVAL;
 
-	return __create_val_field(hist_data, val_idx, file, NULL, field_str, 0);
+	return __create_val_field(hist_data, val_idx, file, NULL, field_str,
+				  HIST_FIELD_FL_VAL);
 }
 
 static const char no_comm[] = "(no comm)";
@@ -4355,8 +4357,11 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 		goto out;
 
 	fields_str = hist_data->attrs->vals_str;
-	if (!fields_str)
+	if (!fields_str) {
+		/* If there is no value, use hitcount as a value */
+		hist_data->fields[HITCOUNT_IDX]->flags |= HIST_FIELD_FL_VAL;
 		goto out;
+	}
 
 	for (i = 0, j = 1; i < TRACING_MAP_VALS_MAX &&
 		     j < TRACING_MAP_VALS_MAX; i++) {
@@ -4372,6 +4377,8 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 			if (strncmp(field_str + 8, ".graph", 8) == 0)
 				hist_data->fields[HITCOUNT_IDX]->flags |=
 					HIST_FIELD_FL_GRAPH;
+			hist_data->fields[HITCOUNT_IDX]->flags |=
+				HIST_FIELD_FL_VAL;
 			continue;
 		}
 
@@ -5392,13 +5399,13 @@ static void hist_trigger_entry_print(struct seq_file *m,
 	hist_trigger_print_key(m, hist_data, key, elt);
 
 	flags = hist_data->fields[i]->flags;
-	hist_trigger_print_val(m, i, "hitcount", flags, stats, elt);
+	if (flags & HIST_FIELD_FL_VAL)
+		hist_trigger_print_val(m, i, "hitcount", flags, stats, elt);
 
 	for (i = 1; i < hist_data->n_vals; i++) {
 		field_name = hist_field_name(hist_data->fields[i], 0);
 		flags = hist_data->fields[i]->flags;
-
-		if (flags & HIST_FIELD_FL_VAR || flags & HIST_FIELD_FL_EXPR)
+		if (!(flags & HIST_FIELD_FL_VAL))
 			continue;
 
 		seq_puts(m, " ");
@@ -5842,6 +5849,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 	struct hist_trigger_data *hist_data = data->private_data;
 	struct hist_field *field;
 	bool have_var = false;
+	bool show_val = false;
 	unsigned int i;
 
 	seq_puts(m, HIST_PREFIX);
@@ -5872,16 +5880,13 @@ static int event_hist_trigger_print(struct seq_file *m,
 			continue;
 		}
 
-		if (i == HITCOUNT_IDX) {
-			seq_puts(m, "hitcount");
-			if (field->flags & HIST_FIELD_FL_PERCENT)
-				seq_puts(m, ".percent");
-			else if (field->flags & HIST_FIELD_FL_GRAPH)
-				seq_puts(m, ".graph");
-		} else {
+		if (!(field->flags & HIST_FIELD_FL_VAL))
+			continue;
+
+		if (show_val)
 			seq_puts(m, ",");
-			hist_field_print(m, field);
-		}
+		hist_field_print(m, field);
+		show_val = true;
 	}
 
 	if (have_var) {

