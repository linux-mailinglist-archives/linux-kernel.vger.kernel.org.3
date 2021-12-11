Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BFC470FD4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 02:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345548AbhLKB35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 20:29:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51200 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhLKB35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 20:29:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 17B76CE2E81
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 01:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B424DC00446;
        Sat, 11 Dec 2021 01:26:17 +0000 (UTC)
Date:   Fri, 10 Dec 2021 20:26:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH] tracing: Use trace_iterator_reset() in tracing_read_pipe()
Message-ID: <20211210202616.64d432d2@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently tracing_read_pipe() open codes trace_iterator_reset(). Just have
it use trace_iterator_reset() instead.

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
2.31.1

