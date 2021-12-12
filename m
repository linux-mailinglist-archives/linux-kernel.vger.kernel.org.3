Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8369D47178F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhLLB0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhLLB0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:26:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA112C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 17:26:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B4C2B80B9B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 01:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493D6C341CF;
        Sun, 12 Dec 2021 01:26:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mwDdV-000kEH-FC;
        Sat, 11 Dec 2021 20:26:45 -0500
Message-ID: <20211212012645.307872958@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 11 Dec 2021 20:26:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 04/11] tracing: Iterate trace_[ku]probe objects directly
References: <20211212012617.690710310@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

As suggested by Linus [1] using list_for_each_entry to iterate
directly trace_[ku]probe objects so we can skip another call to
container_of in these loops.

[1] https://lore.kernel.org/r/CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com

Link: https://lkml.kernel.org/r/20211125202852.406405-1-jolsa@kernel.org

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 13 ++++---------
 kernel/trace/trace_uprobe.c | 23 ++++++++---------------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d10c01948e68..f8c26ee72de3 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -327,11 +327,9 @@ static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
 
 static void __disable_trace_kprobe(struct trace_probe *tp)
 {
-	struct trace_probe *pos;
 	struct trace_kprobe *tk;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		tk = container_of(pos, struct trace_kprobe, tp);
+	list_for_each_entry(tk, trace_probe_probe_list(tp), tp.list) {
 		if (!trace_kprobe_is_registered(tk))
 			continue;
 		if (trace_kprobe_is_return(tk))
@@ -348,7 +346,7 @@ static void __disable_trace_kprobe(struct trace_probe *tp)
 static int enable_trace_kprobe(struct trace_event_call *call,
 				struct trace_event_file *file)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_kprobe *tk;
 	bool enabled;
 	int ret = 0;
@@ -369,8 +367,7 @@ static int enable_trace_kprobe(struct trace_event_call *call,
 	if (enabled)
 		return 0;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		tk = container_of(pos, struct trace_kprobe, tp);
+	list_for_each_entry(tk, trace_probe_probe_list(tp), tp.list) {
 		if (trace_kprobe_has_gone(tk))
 			continue;
 		ret = __enable_trace_kprobe(tk);
@@ -559,11 +556,9 @@ static bool trace_kprobe_has_same_kprobe(struct trace_kprobe *orig,
 					 struct trace_kprobe *comp)
 {
 	struct trace_probe_event *tpe = orig->tp.event;
-	struct trace_probe *pos;
 	int i;
 
-	list_for_each_entry(pos, &tpe->probes, list) {
-		orig = container_of(pos, struct trace_kprobe, tp);
+	list_for_each_entry(orig, &tpe->probes, tp.list) {
 		if (strcmp(trace_kprobe_symbol(orig),
 			   trace_kprobe_symbol(comp)) ||
 		    trace_kprobe_offset(orig) != trace_kprobe_offset(comp))
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a4d5c624fe79..3bd09d612137 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -409,12 +409,10 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
 					 struct trace_uprobe *comp)
 {
 	struct trace_probe_event *tpe = orig->tp.event;
-	struct trace_probe *pos;
 	struct inode *comp_inode = d_real_inode(comp->path.dentry);
 	int i;
 
-	list_for_each_entry(pos, &tpe->probes, list) {
-		orig = container_of(pos, struct trace_uprobe, tp);
+	list_for_each_entry(orig, &tpe->probes, tp.list) {
 		if (comp_inode != d_real_inode(orig->path.dentry) ||
 		    comp->offset != orig->offset)
 			continue;
@@ -1072,14 +1070,12 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 
 static void __probe_event_disable(struct trace_probe *tp)
 {
-	struct trace_probe *pos;
 	struct trace_uprobe *tu;
 
 	tu = container_of(tp, struct trace_uprobe, tp);
 	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		tu = container_of(pos, struct trace_uprobe, tp);
+	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
 		if (!tu->inode)
 			continue;
 
@@ -1091,7 +1087,7 @@ static void __probe_event_disable(struct trace_probe *tp)
 static int probe_event_enable(struct trace_event_call *call,
 			struct trace_event_file *file, filter_func_t filter)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_uprobe *tu;
 	bool enabled;
 	int ret;
@@ -1126,8 +1122,7 @@ static int probe_event_enable(struct trace_event_call *call,
 	if (ret)
 		goto err_flags;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		tu = container_of(pos, struct trace_uprobe, tp);
+	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
 		ret = trace_uprobe_enable(tu, filter);
 		if (ret) {
 			__probe_event_disable(tp);
@@ -1272,7 +1267,7 @@ static bool trace_uprobe_filter_add(struct trace_uprobe_filter *filter,
 static int uprobe_perf_close(struct trace_event_call *call,
 			     struct perf_event *event)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_uprobe *tu;
 	int ret = 0;
 
@@ -1284,8 +1279,7 @@ static int uprobe_perf_close(struct trace_event_call *call,
 	if (trace_uprobe_filter_remove(tu->tp.event->filter, event))
 		return 0;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		tu = container_of(pos, struct trace_uprobe, tp);
+	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
 		ret = uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
 		if (ret)
 			break;
@@ -1297,7 +1291,7 @@ static int uprobe_perf_close(struct trace_event_call *call,
 static int uprobe_perf_open(struct trace_event_call *call,
 			    struct perf_event *event)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_uprobe *tu;
 	int err = 0;
 
@@ -1309,8 +1303,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
 	if (trace_uprobe_filter_add(tu->tp.event->filter, event))
 		return 0;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		tu = container_of(pos, struct trace_uprobe, tp);
+	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
 		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
 		if (err) {
 			uprobe_perf_close(call, event);
-- 
2.33.0
