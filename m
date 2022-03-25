Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965EC4E6F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348412AbiCYIE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiCYIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:04:54 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15313A76FA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:03:19 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KPvjL23cSz9sRq;
        Fri, 25 Mar 2022 09:03:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bgz314D1biRI; Fri, 25 Mar 2022 09:03:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KPvjL16jBz9sRn;
        Fri, 25 Mar 2022 09:03:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 11A508B780;
        Fri, 25 Mar 2022 09:03:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id W7T8NCjv481w; Fri, 25 Mar 2022 09:03:17 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DCF308B763;
        Fri, 25 Mar 2022 09:03:17 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22P838xt1938379
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 09:03:09 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22P838rI1938378;
        Fri, 25 Mar 2022 09:03:08 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] ftrace: Make ftrace_graph_is_dead() a static branch
Date:   Fri, 25 Mar 2022 09:03:08 +0100
Message-Id: <8628338322fa74287ca8d432d5c0c1964acd6f2a.1648195329.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648195387; l=3391; s=20211009; h=from:subject:message-id; bh=aDg2tLJ31D9Fssnue1+3mTD1ZvJRLunpzUIjiG3Tp+U=; b=6M11MNmE57VZlDVfkH/7QjX25JLUjqLLvueXJDxGpryW7KJXnECXnaDypvSTvOCukMz4Chc2GdqX pa1MChfWB8xFBthSd6ZauqKLw5XtIKW4i4ynxmv/dTv0m23Lq21x
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Use a static branch instead of a global bool var.
---
 include/linux/ftrace.h | 16 +++++++++++++++-
 kernel/trace/fgraph.c  | 17 +++--------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9999e29187de..9e639e05666d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/jump_label.h>
 
 #include <asm/ftrace.h>
 
@@ -1006,7 +1007,20 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
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
index 22061d38fc00..15acd48f0718 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -10,6 +10,7 @@
 #include <linux/suspend.h>
 #include <linux/ftrace.h>
 #include <linux/slab.h>
+#include <linux/jump_label.h>
 
 #include <trace/events/sched.h>
 
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

