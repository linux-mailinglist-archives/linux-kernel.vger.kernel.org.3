Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792C14CE821
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 02:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiCFBio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 20:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiCFBim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 20:38:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0640213DEE
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 17:37:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 930AB6101C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 01:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E36C004E1;
        Sun,  6 Mar 2022 01:37:49 +0000 (UTC)
Date:   Sat, 5 Mar 2022 20:37:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [GIT PULL] tracing: Minor fixes for tracing
Message-ID: <20220305203747.560f8439@yoga.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Randy Dunlap <rdunlap@infradead.org>

Linus,

Two tracing fixes:

 - Fix sorting on old "cpu" value in histograms

 - Fix return value of __setup() boot parameter handlers.


Please pull the latest trace-v5.17-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.17-rc5

Tag SHA1: 9ae16c8b4d11a0c8c8924245258ccb2a1428899b
Head SHA1: 1d02b444b8d1345ea4708db3bab4db89a7784b55


Randy Dunlap (1):
      tracing: Fix return value of __setup handlers

Steven Rostedt (Google) (1):
      tracing/histogram: Fix sorting on old "cpu" value

----
 kernel/trace/trace.c             | 4 ++--
 kernel/trace/trace_events_hist.c | 6 +++---
 kernel/trace/trace_kprobe.c      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)
---------------------------
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3050892d1812..eb44418574f9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -235,7 +235,7 @@ static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
 static int __init set_trace_boot_options(char *str)
 {
 	strlcpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
-	return 0;
+	return 1;
 }
 __setup("trace_options=", set_trace_boot_options);
 
@@ -246,7 +246,7 @@ static int __init set_trace_boot_clock(char *str)
 {
 	strlcpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
 	trace_boot_clock = trace_boot_clock_buf;
-	return 0;
+	return 1;
 }
 __setup("trace_clock=", set_trace_boot_clock);
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ada87bfb5bb8..dc7f733b4cb3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2289,9 +2289,9 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			/*
 			 * For backward compatibility, if field_name
 			 * was "cpu", then we treat this the same as
-			 * common_cpu.
+			 * common_cpu. This also works for "CPU".
 			 */
-			if (strcmp(field_name, "cpu") == 0) {
+			if (field && field->filter_type == FILTER_CPU) {
 				*flags |= HIST_FIELD_FL_CPU;
 			} else {
 				hist_err(tr, HIST_ERR_FIELD_NOT_FOUND,
@@ -4832,7 +4832,7 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 
 			if (hist_field->flags & HIST_FIELD_FL_STACKTRACE)
 				cmp_fn = tracing_map_cmp_none;
-			else if (!field)
+			else if (!field || hist_field->flags & HIST_FIELD_FL_CPU)
 				cmp_fn = tracing_map_cmp_num(hist_field->size,
 							     hist_field->is_signed);
 			else if (is_string_field(field))
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 508f14af4f2c..b62fd785b599 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -32,7 +32,7 @@ static int __init set_kprobe_boot_events(char *str)
 	strlcpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
 	disable_tracing_selftest("running kprobe events");
 
-	return 0;
+	return 1;
 }
 __setup("kprobe_event=", set_kprobe_boot_events);
 
