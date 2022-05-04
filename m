Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951CC51960A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 05:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344344AbiEDDkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 23:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiEDDkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 23:40:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7194F27FE1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20D2AB822B5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98D1C385A4;
        Wed,  4 May 2022 03:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651635395;
        bh=bjQ56T29VFG1YiPrSmzz+EbcJnsSn4sEHFX27PEqq1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LkQHU7zu/69j8PnF4dkfXMHs33CzSIHamDndo2w1WA8MfMg+m2U7XK/bZmFmh5sIk
         wS1KW5uKuGMnx7F1Dl55VH4NW/HPqCpK3zFw4kXzGwpMpoLSMIFdYZfuVox1SsoFNG
         +wpD7L8taRbBvlahrMt2tFi+mDCs1BQLs0RQM7AjIQ94M5nh97gi2Uu1/k5hfCGVeN
         SDuY8ytu8pjwYldmGfD7VDAg/u6BRuEtQJCakZdo29DDusgK/80ugozwZtvO6dU/8g
         VhUQeht2jUzbLtxBde+kCKGxkUXkaY+I7S4Nh9a7TCCqIWC1YfkDVX+IJ/EbLiacPT
         js+dYjC0npF/w==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] kprobes: Fix build errors with CONFIG_KRETPROBES=n
Date:   Wed,  4 May 2022 12:36:31 +0900
Message-Id: <165163539094.74407.3838114721073251225.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502184050.1792743-1-jcmvbkbc@gmail.com>
References: <20220502184050.1792743-1-jcmvbkbc@gmail.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max Filippov reported:

When building kernel with CONFIG_KRETPROBES=n kernel/kprobes.c
compilation fails with the following messages:

  kernel/kprobes.c: In function ‘recycle_rp_inst’:
  kernel/kprobes.c:1273:32: error: implicit declaration of function
                                   ‘get_kretprobe’

  kernel/kprobes.c: In function ‘kprobe_flush_task’:
  kernel/kprobes.c:1299:35: error: ‘struct task_struct’ has no member
                                   named ‘kretprobe_instances’

This came from the commit d741bf41d7c7 ("kprobes: Remove
kretprobe hash") which introduced get_kretprobe() and
kretprobe_instances member in task_struct when CONFIG_KRETPROBES=y,
but did not make recycle_rp_inst() and kprobe_flush_task()
depending on CONFIG_KRETPORBES.

Since those functions are only used for kretprobe, move those
functions into #ifdef CONFIG_KRETPROBE area.

Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Fixes: d741bf41d7c7 ("kprobes: Remove kretprobe hash")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |    2 -
 kernel/kprobes.c        |  144 +++++++++++++++++++++++------------------------
 2 files changed, 72 insertions(+), 74 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 157168769fc2..55041d2f884d 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -424,7 +424,7 @@ void unregister_kretprobe(struct kretprobe *rp);
 int register_kretprobes(struct kretprobe **rps, int num);
 void unregister_kretprobes(struct kretprobe **rps, int num);
 
-#ifdef CONFIG_KRETPROBE_ON_RETHOOK
+#if defined(CONFIG_KRETPROBE_ON_RETHOOK) || !defined(CONFIG_KRETPROBES)
 #define kprobe_flush_task(tk)	do {} while (0)
 #else
 void kprobe_flush_task(struct task_struct *tk);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dd58c0be9ce2..f214f8c088ed 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1257,79 +1257,6 @@ void kprobe_busy_end(void)
 	preempt_enable();
 }
 
-#if !defined(CONFIG_KRETPROBE_ON_RETHOOK)
-static void free_rp_inst_rcu(struct rcu_head *head)
-{
-	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
-
-	if (refcount_dec_and_test(&ri->rph->ref))
-		kfree(ri->rph);
-	kfree(ri);
-}
-NOKPROBE_SYMBOL(free_rp_inst_rcu);
-
-static void recycle_rp_inst(struct kretprobe_instance *ri)
-{
-	struct kretprobe *rp = get_kretprobe(ri);
-
-	if (likely(rp))
-		freelist_add(&ri->freelist, &rp->freelist);
-	else
-		call_rcu(&ri->rcu, free_rp_inst_rcu);
-}
-NOKPROBE_SYMBOL(recycle_rp_inst);
-
-/*
- * This function is called from delayed_put_task_struct() when a task is
- * dead and cleaned up to recycle any kretprobe instances associated with
- * this task. These left over instances represent probed functions that
- * have been called but will never return.
- */
-void kprobe_flush_task(struct task_struct *tk)
-{
-	struct kretprobe_instance *ri;
-	struct llist_node *node;
-
-	/* Early boot, not yet initialized. */
-	if (unlikely(!kprobes_initialized))
-		return;
-
-	kprobe_busy_begin();
-
-	node = __llist_del_all(&tk->kretprobe_instances);
-	while (node) {
-		ri = container_of(node, struct kretprobe_instance, llist);
-		node = node->next;
-
-		recycle_rp_inst(ri);
-	}
-
-	kprobe_busy_end();
-}
-NOKPROBE_SYMBOL(kprobe_flush_task);
-
-static inline void free_rp_inst(struct kretprobe *rp)
-{
-	struct kretprobe_instance *ri;
-	struct freelist_node *node;
-	int count = 0;
-
-	node = rp->freelist.head;
-	while (node) {
-		ri = container_of(node, struct kretprobe_instance, freelist);
-		node = node->next;
-
-		kfree(ri);
-		count++;
-	}
-
-	if (refcount_sub_and_test(count, &rp->rph->ref)) {
-		kfree(rp->rph);
-		rp->rph = NULL;
-	}
-}
-#endif	/* !CONFIG_KRETPROBE_ON_RETHOOK */
-
 /* Add the new probe to 'ap->list'. */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
@@ -1928,6 +1855,77 @@ static struct notifier_block kprobe_exceptions_nb = {
 #ifdef CONFIG_KRETPROBES
 
 #if !defined(CONFIG_KRETPROBE_ON_RETHOOK)
+static void free_rp_inst_rcu(struct rcu_head *head)
+{
+	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
+
+	if (refcount_dec_and_test(&ri->rph->ref))
+		kfree(ri->rph);
+	kfree(ri);
+}
+NOKPROBE_SYMBOL(free_rp_inst_rcu);
+
+static void recycle_rp_inst(struct kretprobe_instance *ri)
+{
+	struct kretprobe *rp = get_kretprobe(ri);
+
+	if (likely(rp))
+		freelist_add(&ri->freelist, &rp->freelist);
+	else
+		call_rcu(&ri->rcu, free_rp_inst_rcu);
+}
+NOKPROBE_SYMBOL(recycle_rp_inst);
+
+/*
+ * This function is called from delayed_put_task_struct() when a task is
+ * dead and cleaned up to recycle any kretprobe instances associated with
+ * this task. These left over instances represent probed functions that
+ * have been called but will never return.
+ */
+void kprobe_flush_task(struct task_struct *tk)
+{
+	struct kretprobe_instance *ri;
+	struct llist_node *node;
+
+	/* Early boot, not yet initialized. */
+	if (unlikely(!kprobes_initialized))
+		return;
+
+	kprobe_busy_begin();
+
+	node = __llist_del_all(&tk->kretprobe_instances);
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, llist);
+		node = node->next;
+
+		recycle_rp_inst(ri);
+	}
+
+	kprobe_busy_end();
+}
+NOKPROBE_SYMBOL(kprobe_flush_task);
+
+static inline void free_rp_inst(struct kretprobe *rp)
+{
+	struct kretprobe_instance *ri;
+	struct freelist_node *node;
+	int count = 0;
+
+	node = rp->freelist.head;
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, freelist);
+		node = node->next;
+
+		kfree(ri);
+		count++;
+	}
+
+	if (refcount_sub_and_test(count, &rp->rph->ref)) {
+		kfree(rp->rph);
+		rp->rph = NULL;
+	}
+}
+
 /* This assumes the 'tsk' is the current task or the is not running. */
 static kprobe_opcode_t *__kretprobe_find_ret_addr(struct task_struct *tsk,
 						  struct llist_node **cur)

