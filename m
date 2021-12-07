Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEDA46C6E6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbhLGVsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:22 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53854 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241969AbhLGVsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DD453CE1E71
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826BCC341E7;
        Tue,  7 Dec 2021 21:44:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGE-000Hze-No;
        Tue, 07 Dec 2021 16:44:30 -0500
Message-ID: <20211207214430.584754749@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 09/13] tracing: Have eprobes use filtering logic of trace events
References: <20211207214406.148423650@goodmis.org>
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

Link: https://lkml.kernel.org/r/20211130024319.068451680@goodmis.org

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
