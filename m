Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3E471793
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhLLB1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhLLB0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:26:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D387FC0617A1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 17:26:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 17B20CE0AE6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 01:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF46C341D8;
        Sun, 12 Dec 2021 01:26:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mwDdW-000kFx-0k;
        Sat, 11 Dec 2021 20:26:46 -0500
Message-ID: <20211212012645.854116905@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 11 Dec 2021 20:26:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 07/11] tracing: Use trace_iterator_reset() in tracing_read_pipe()
References: <20211212012617.690710310@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently tracing_read_pipe() open codes trace_iterator_reset(). Just have
it use trace_iterator_reset() instead.

Link: https://lkml.kernel.org/r/20211210202616.64d432d2@gandalf.local.home

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 588de6df473f..547d82628c2e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6731,10 +6731,9 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 		cnt = PAGE_SIZE - 1;
 
 	/* reset all but tr, trace, and overruns */
-	memset_startat(iter, 0, seq);
+	trace_iterator_reset(iter);
 	cpumask_clear(iter->started);
 	trace_seq_init(&iter->seq);
-	iter->pos = -1;
 
 	trace_event_read_lock();
 	trace_access_lock(iter->cpu_file);
-- 
2.33.0
