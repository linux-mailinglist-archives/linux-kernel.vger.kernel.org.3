Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1553849B7E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376522AbiAYPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351003AbiAYPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:44:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF5DC061763
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:44:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55C6EB81818
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6079FC340E5;
        Tue, 25 Jan 2022 15:44:09 +0000 (UTC)
Date:   Tue, 25 Jan 2022 10:44:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] tracing: Update print fmt check to handle new
 __get_sockaddr() macro
Message-ID: <20220125104408.7612fb0d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

A helper macro was added to make reading socket addresses easier in trace
events. It pairs %pISpc with __get_sockaddr() that reads the socket
address from the ring buffer into a human readable format.

The boot up check that makes sure that trace events do not reference
pointers to memory that can later be freed when the trace event is read,
incorrectly flagged this as a delayed reference. Update the check to
handle "__get_sockaddr" and not report an error on it.

Link: https://lore.kernel.org/all/20220125160505.068dbb52@canb.auug.org.au/

Fixes: 9580b78ebd878 ("tracing: Introduce helpers to safely handle dynamic-sized sockaddrs")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 3147614c1812..f527ae807e77 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -384,6 +384,12 @@ static void test_event_printk(struct trace_event_call *call)
 			if (!(dereference_flags & (1ULL << arg)))
 				goto next_arg;
 
+			/* Check for __get_sockaddr */;
+			if (str_has_prefix(fmt + i, "__get_sockaddr(")) {
+				dereference_flags &= ~(1ULL << arg);
+				goto next_arg;
+			}
+
 			/* Find the REC-> in the argument */
 			c = strchr(fmt + i, ',');
 			r = strstr(fmt + i, "REC->");
-- 
2.33.0

