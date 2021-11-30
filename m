Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCF9462AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbhK3Cql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhK3Cqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:46:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D682C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:43:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D99D4B81691
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9636AC53FC7;
        Tue, 30 Nov 2021 02:43:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mrt70-000RSz-Rj;
        Mon, 29 Nov 2021 21:43:18 -0500
Message-ID: <20211130024318.698165354@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Nov 2021 21:39:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/5] tracing: Use __this_cpu_read() in trace_event_buffer_lock_reserver()
References: <20211130023945.789683928@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The value read by this_cpu_read() is used later and its use is expected to
stay on the same CPU as being read. But this_cpu_read() does not warn if
it is called without preemption disabled, where as __this_cpu_read() will
check if preemption is disabled on CONFIG_DEBUG_PREEMPT

Currently all callers have preemption disabled, but there may be new
callers in the future that may not.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4821fe6a40a5..2e87b7bf2ba7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2746,7 +2746,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 
 	if (!tr->no_filter_buffering_ref &&
 	    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
-	    (entry = this_cpu_read(trace_buffered_event))) {
+	    (entry = __this_cpu_read(trace_buffered_event))) {
 		/*
 		 * Filtering is on, so try to use the per cpu buffer first.
 		 * This buffer will simulate a ring_buffer_event,
-- 
2.33.0
