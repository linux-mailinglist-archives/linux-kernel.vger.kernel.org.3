Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4844EBB61
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243585AbiC3HCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243548AbiC3HCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:02:18 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27248DF484
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:00:33 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KSy4b67c7z9sS9;
        Wed, 30 Mar 2022 09:00:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RCdpq8d0SeNj; Wed, 30 Mar 2022 09:00:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KSy4b59wqz9sS8;
        Wed, 30 Mar 2022 09:00:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F8308B77B;
        Wed, 30 Mar 2022 09:00:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id P1-xpKC3Oz0p; Wed, 30 Mar 2022 09:00:31 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 761788B765;
        Wed, 30 Mar 2022 09:00:31 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22U70Mjd279108
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 09:00:22 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22U70LeF279107;
        Wed, 30 Mar 2022 09:00:21 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] ftrace: Make ftrace_graph_is_dead() a static branch
Date:   Wed, 30 Mar 2022 09:00:19 +0200
Message-Id: <e0411a6a0ed3eafff0ad2bc9cd4b0e202b4617df.1648623570.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648623618; l=3505; s=20211009; h=from:subject:message-id; bh=aCcAKl5FNjWRbsv3MCPz0tiPrIo7QmLsO8hbWKLshtE=; b=Ssufl5SrZq1mI9BBqpCSJGu2PAG8ypJPr+aKeZbTU2iNAVEhPsSQlAXql/uBE0A/atfYOwelonGX GnVbOCcAApbNCTtw6NSI2ANpwC9rBoNG/IsmWD5MMsJSFY0yyOs+
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
v3: Keep includes in upside-down x-mas tree

v2: Use a static branch instead of a global bool var.
---
 include/linux/ftrace.h | 16 +++++++++++++++-
 kernel/trace/fgraph.c  | 17 +++--------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ed8cf433a46a..4816b7e11047 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -9,6 +9,7 @@
 
 #include <linux/trace_recursion.h>
 #include <linux/trace_clock.h>
+#include <linux/jump_label.h>
 #include <linux/kallsyms.h>
 #include <linux/linkage.h>
 #include <linux/bitops.h>
@@ -1018,7 +1019,20 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
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

