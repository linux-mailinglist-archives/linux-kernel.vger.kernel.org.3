Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A4D4F0A31
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359016AbiDCOd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358997AbiDCOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077F2FFE0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2960C611D7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 14:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E450C3411C;
        Sun,  3 Apr 2022 14:31:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nb1GW-001EiY-HG;
        Sun, 03 Apr 2022 10:31:40 -0400
Message-ID: <20220403143140.369657075@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 03 Apr 2022 10:25:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [for-linus][PATCH 6/7] ftrace: Make ftrace_graph_is_dead() a static branch
References: <20220403142500.388473000@goodmis.org>
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

ftrace_graph_is_dead() is used on hot paths, it just reads a variable
in memory and is not worth suffering function call constraints.

For instance, at entry of prepare_ftrace_return(), inlining it avoids
saving prepare_ftrace_return() parameters to stack and restoring them
after calling ftrace_graph_is_dead().

While at it using a static branch is even more performant and is
rather well adapted considering that the returned value will almost
never change.

Inline ftrace_graph_is_dead() and replace 'kill_ftrace_graph' bool
by a static branch.

The performance improvement is noticeable.

Link: https://lkml.kernel.org/r/e0411a6a0ed3eafff0ad2bc9cd4b0e202b4617df.1648623570.git.christophe.leroy@csgroup.eu

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 16 +++++++++++++++-
 kernel/trace/fgraph.c  | 17 +++--------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 37b619185ec9..f15a4b76cbfc 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -9,6 +9,7 @@
 
 #include <linux/trace_recursion.h>
 #include <linux/trace_clock.h>
+#include <linux/jump_label.h>
 #include <linux/kallsyms.h>
 #include <linux/linkage.h>
 #include <linux/bitops.h>
@@ -1015,7 +1016,20 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 extern int register_ftrace_graph(struct fgraph_ops *ops);
 extern void unregister_ftrace_graph(struct fgraph_ops *ops);
 
-extern bool ftrace_graph_is_dead(void);
+/**
+ * ftrace_graph_is_dead - returns true if ftrace_graph_stop() was called
+ *
+ * ftrace_graph_stop() is called when a severe error is detected in
+ * the function graph tracing. This function is called by the critical
+ * paths of function graph to keep those paths from doing any more harm.
+ */
+DECLARE_STATIC_KEY_FALSE(kill_ftrace_graph);
+
+static inline bool ftrace_graph_is_dead(void)
+{
+	return static_branch_unlikely(&kill_ftrace_graph);
+}
+
 extern void ftrace_graph_stop(void);
 
 /* The current handlers in use */
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 19028e072cdb..8f4fb328133a 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -7,6 +7,7 @@
  *
  * Highly modified by Steven Rostedt (VMware).
  */
+#include <linux/jump_label.h>
 #include <linux/suspend.h>
 #include <linux/ftrace.h>
 #include <linux/slab.h>
@@ -23,24 +24,12 @@
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
-static bool kill_ftrace_graph;
+DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
-/**
- * ftrace_graph_is_dead - returns true if ftrace_graph_stop() was called
- *
- * ftrace_graph_stop() is called when a severe error is detected in
- * the function graph tracing. This function is called by the critical
- * paths of function graph to keep those paths from doing any more harm.
- */
-bool ftrace_graph_is_dead(void)
-{
-	return kill_ftrace_graph;
-}
-
 /**
  * ftrace_graph_stop - set to permanently disable function graph tracing
  *
@@ -51,7 +40,7 @@ bool ftrace_graph_is_dead(void)
  */
 void ftrace_graph_stop(void)
 {
-	kill_ftrace_graph = true;
+	static_branch_enable(&kill_ftrace_graph);
 }
 
 /* Add a function return address to the trace stack on thread info.*/
-- 
2.35.1
