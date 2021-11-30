Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4147D462AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhK3Cqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbhK3Cql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:46:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A164C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:43:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E89FB816C7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCBFC53FD3;
        Tue, 30 Nov 2021 02:43:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mrt71-000RU6-7W;
        Mon, 29 Nov 2021 21:43:19 -0500
Message-ID: <20211130024319.068451680@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Nov 2021 21:39:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/5] tracing: Have eprobes use filtering logic of trace events
References: <20211130023945.789683928@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The eprobes open code the reserving of the event on the ring buffer for
ftrace instead of using the ftrace event wrappers, which means that it
doesn't get affected by the filters, breaking the filtering logic on user
space.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_eprobe.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 928867f527e7..88487752d307 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -489,18 +489,12 @@ __eprobe_trace_func(struct eprobe_data *edata, void *rec)
 	if (trace_trigger_soft_disabled(edata->file))
 		return;
 
-	fbuffer.trace_ctx = tracing_gen_ctx();
-	fbuffer.trace_file = edata->file;
-
 	dsize = get_eprobe_size(&edata->ep->tp, rec);
-	fbuffer.regs = NULL;
-
-	fbuffer.event =
-		trace_event_buffer_lock_reserve(&fbuffer.buffer, edata->file,
-					call->event.type,
-					sizeof(*entry) + edata->ep->tp.size + dsize,
-					fbuffer.trace_ctx);
-	if (!fbuffer.event)
+
+	entry = trace_event_buffer_reserve(&fbuffer, edata->file,
+					   sizeof(*entry) + edata->ep->tp.size + dsize);
+
+	if (!entry)
 		return;
 
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
-- 
2.33.0
