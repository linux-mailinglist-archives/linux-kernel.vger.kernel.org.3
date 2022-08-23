Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8428959E7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244834AbiHWQpG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Aug 2022 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244934AbiHWQor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:44:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B307FD9E88
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73000B81E33
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C310C433D7;
        Tue, 23 Aug 2022 14:34:54 +0000 (UTC)
Date:   Tue, 23 Aug 2022 10:35:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Jingjin <wangjingjin1@huawei.com>,
        Song Liu <songliubraving@fb.com>
Subject: [GIT PULL] ftrace: Fix build warning for ops_references_rec() not
 used
Message-ID: <20220823103512.603d3b44@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing: Fix for 6.0-rc2

- Fix build warning for when MODULES and FTRACE_WITH_DIRECT_CALLS are not
  set. A warning happens with ops_references_rec() defined but not used.


The broken commit went through the BPF tree and this patch was never picked
up. Now that both my changes and BPF changes are in mainline, I can finally
post this fix and stop having those that act like Coccinelle scipts sending
me incorrect patches trying to fix this.

Please pull the latest trace-v6.0-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v6.0-rc2

Tag SHA1: 0a27eb38e8db36a4c4dbd4618ae2f6bbbf81e9a3
Head SHA1: 123d6455771ec577ce65f8d1bda548fb0eb7ef21


Wang Jingjin (1):
      ftrace: Fix build warning for ops_references_rec() not used

----
 kernel/trace/ftrace.c | 79 +++++++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 46 deletions(-)
---------------------------
commit 123d6455771ec577ce65f8d1bda548fb0eb7ef21
Author: Wang Jingjin <wangjingjin1@huawei.com>
Date:   Mon Aug 1 16:47:45 2022 +0800

    ftrace: Fix build warning for ops_references_rec() not used
    
    The change that made IPMODIFY and DIRECT ops work together needed access
    to the ops_references_ip() function, which it pulled out of the module
    only code. But now if both CONFIG_MODULES and
    CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is not set, we get the below
    warning:
    
        ‘ops_references_rec’ defined but not used.
    
    Since ops_references_rec() only calls ops_references_ip() replace the
    usage of ops_references_rec() with ops_references_ip() and encompass the
    function with an #ifdef of DIRECT_CALLS || MODULES being defined.
    
    Link: https://lkml.kernel.org/r/20220801084745.1187987-1-wangjingjin1@huawei.com
    
    Fixes: 53cd885bc5c3 ("ftrace: Allow IPMODIFY and DIRECT ops on the same function")
    Signed-off-by: Wang Jingjin <wangjingjin1@huawei.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 126c769d36c3..439e2ab6905e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1861,8 +1861,6 @@ static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops,
 	ftrace_hash_rec_update_modify(ops, filter_hash, 1);
 }
 
-static bool ops_references_ip(struct ftrace_ops *ops, unsigned long ip);
-
 /*
  * Try to update IPMODIFY flag on each ftrace_rec. Return 0 if it is OK
  * or no-needed to update, -EBUSY if it detects a conflict of the flag
@@ -3118,49 +3116,6 @@ static inline int ops_traces_mod(struct ftrace_ops *ops)
 		ftrace_hash_empty(ops->func_hash->notrace_hash);
 }
 
-/*
- * Check if the current ops references the given ip.
- *
- * If the ops traces all functions, then it was already accounted for.
- * If the ops does not trace the current record function, skip it.
- * If the ops ignores the function via notrace filter, skip it.
- */
-static bool
-ops_references_ip(struct ftrace_ops *ops, unsigned long ip)
-{
-	/* If ops isn't enabled, ignore it */
-	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
-		return false;
-
-	/* If ops traces all then it includes this function */
-	if (ops_traces_mod(ops))
-		return true;
-
-	/* The function must be in the filter */
-	if (!ftrace_hash_empty(ops->func_hash->filter_hash) &&
-	    !__ftrace_lookup_ip(ops->func_hash->filter_hash, ip))
-		return false;
-
-	/* If in notrace hash, we ignore it too */
-	if (ftrace_lookup_ip(ops->func_hash->notrace_hash, ip))
-		return false;
-
-	return true;
-}
-
-/*
- * Check if the current ops references the record.
- *
- * If the ops traces all functions, then it was already accounted for.
- * If the ops does not trace the current record function, skip it.
- * If the ops ignores the function via notrace filter, skip it.
- */
-static bool
-ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
-{
-	return ops_references_ip(ops, rec->ip);
-}
-
 static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 {
 	bool init_nop = ftrace_need_init_nop();
@@ -6822,6 +6777,38 @@ static int ftrace_get_trampoline_kallsym(unsigned int symnum,
 	return -ERANGE;
 }
 
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) || defined(CONFIG_MODULES)
+/*
+ * Check if the current ops references the given ip.
+ *
+ * If the ops traces all functions, then it was already accounted for.
+ * If the ops does not trace the current record function, skip it.
+ * If the ops ignores the function via notrace filter, skip it.
+ */
+static bool
+ops_references_ip(struct ftrace_ops *ops, unsigned long ip)
+{
+	/* If ops isn't enabled, ignore it */
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return false;
+
+	/* If ops traces all then it includes this function */
+	if (ops_traces_mod(ops))
+		return true;
+
+	/* The function must be in the filter */
+	if (!ftrace_hash_empty(ops->func_hash->filter_hash) &&
+	    !__ftrace_lookup_ip(ops->func_hash->filter_hash, ip))
+		return false;
+
+	/* If in notrace hash, we ignore it too */
+	if (ftrace_lookup_ip(ops->func_hash->notrace_hash, ip))
+		return false;
+
+	return true;
+}
+#endif
+
 #ifdef CONFIG_MODULES
 
 #define next_to_ftrace_page(p) container_of(p, struct ftrace_page, next)
@@ -6834,7 +6821,7 @@ static int referenced_filters(struct dyn_ftrace *rec)
 	int cnt = 0;
 
 	for (ops = ftrace_ops_list; ops != &ftrace_list_end; ops = ops->next) {
-		if (ops_references_rec(ops, rec)) {
+		if (ops_references_ip(ops, rec->ip)) {
 			if (WARN_ON_ONCE(ops->flags & FTRACE_OPS_FL_DIRECT))
 				continue;
 			if (WARN_ON_ONCE(ops->flags & FTRACE_OPS_FL_IPMODIFY))
