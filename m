Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B71B48B403
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344896AbiAKRc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:32:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45386 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344397AbiAKRbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:31:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03653B81C56
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A1DC36AEB;
        Tue, 11 Jan 2022 17:31:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7KzO-0032LE-UP;
        Tue, 11 Jan 2022 12:31:18 -0500
Message-ID: <20220111173118.778024396@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jan 2022 12:31:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [for-next][PATCH 30/31] tracing: Remove duplicate warnings when calling trace_create_file()
References: <20220111173030.999527342@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuntao Wang <ytcoode@gmail.com>

Since the same warning message is already printed in the
trace_create_file() function, there is no need to print it again.

Link: https://lkml.kernel.org/r/20220109162232.361747-1-ytcoode@gmail.com

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 92be9cb1d7d4..3147614c1812 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3461,10 +3461,8 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 
 	entry = trace_create_file("enable", TRACE_MODE_WRITE, d_events,
 				  tr, &ftrace_tr_enable_fops);
-	if (!entry) {
-		pr_warn("Could not create tracefs 'enable' entry\n");
+	if (!entry)
 		return -ENOMEM;
-	}
 
 	/* There are not as crucial, just warn if they are not created */
 
@@ -3480,17 +3478,13 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 		pr_warn("Could not create tracefs 'set_event_notrace_pid' entry\n");
 
 	/* ring buffer internal formats */
-	entry = trace_create_file("header_page", TRACE_MODE_READ, d_events,
+	trace_create_file("header_page", TRACE_MODE_READ, d_events,
 				  ring_buffer_print_page_header,
 				  &ftrace_show_header_fops);
-	if (!entry)
-		pr_warn("Could not create tracefs 'header_page' entry\n");
 
-	entry = trace_create_file("header_event", TRACE_MODE_READ, d_events,
+	trace_create_file("header_event", TRACE_MODE_READ, d_events,
 				  ring_buffer_print_entry_header,
 				  &ftrace_show_header_fops);
-	if (!entry)
-		pr_warn("Could not create tracefs 'header_event' entry\n");
 
 	tr->event_dir = d_events;
 
-- 
2.33.0
