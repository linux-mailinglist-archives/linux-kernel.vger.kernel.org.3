Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC30757277C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiGLUkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiGLUj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED63CC790
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:39:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C09A61A91
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE074C3411E;
        Tue, 12 Jul 2022 20:39:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oBMfj-0049Of-VY;
        Tue, 12 Jul 2022 16:39:56 -0400
Message-ID: <20220712203955.808599610@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Jul 2022 16:39:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [for-linus][PATCH 2/6] tracing: Fix sleeping while atomic in kdb ftdump
References: <20220712203924.060569640@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

If you drop into kdb and type "ftdump" you'll get a sleeping while
atomic warning from memory allocation in trace_find_next_entry().

This appears to have been caused by commit ff895103a84a ("tracing:
Save off entry when peeking at next entry"), which added the
allocation in that path. The problematic commit was already fixed by
commit 8e99cf91b99b ("tracing: Do not allocate buffer in
trace_find_next_entry() in atomic") but that fix missed the kdb case.

The fix here is easy: just move the assignment of the static buffer to
the place where it should have been to begin with:
trace_init_global_iter(). That function is called in two places, once
is right before the assignment of the static buffer added by the
previous fix and once is in kdb.

Note that it appears that there's a second static buffer that we need
to assign that was added in commit efbbdaa22bb7 ("tracing: Show real
address for trace event arguments"), so we'll move that too.

Link: https://lkml.kernel.org/r/20220708170919.1.I75844e5038d9425add2ad853a608cb44bb39df40@changeid

Fixes: ff895103a84a ("tracing: Save off entry when peeking at next entry")
Fixes: efbbdaa22bb7 ("tracing: Show real address for trace event arguments")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a8cfac0611bc..b8dd54627075 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9864,6 +9864,12 @@ void trace_init_global_iter(struct trace_iterator *iter)
 	/* Output in nanoseconds only if we are using a clock in nanoseconds. */
 	if (trace_clocks[iter->tr->clock_id].in_ns)
 		iter->iter_flags |= TRACE_FILE_TIME_IN_NS;
+
+	/* Can not use kmalloc for iter.temp and iter.fmt */
+	iter->temp = static_temp_buf;
+	iter->temp_size = STATIC_TEMP_BUF_SIZE;
+	iter->fmt = static_fmt_buf;
+	iter->fmt_size = STATIC_FMT_BUF_SIZE;
 }
 
 void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
@@ -9896,11 +9902,6 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 
 	/* Simulate the iterator */
 	trace_init_global_iter(&iter);
-	/* Can not use kmalloc for iter.temp and iter.fmt */
-	iter.temp = static_temp_buf;
-	iter.temp_size = STATIC_TEMP_BUF_SIZE;
-	iter.fmt = static_fmt_buf;
-	iter.fmt_size = STATIC_FMT_BUF_SIZE;
 
 	for_each_tracing_cpu(cpu) {
 		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
-- 
2.35.1
