Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437AD4D792E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 02:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiCNBzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 21:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCNBzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 21:55:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835761FA7D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 18:54:23 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s8so12938650pfk.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 18:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLSI5DTfdZAfsDHGQkcA3WiBGQTVoj9JCzoyZ8csosI=;
        b=JmFQPTjrGuH5DpX0TBKEVlRxuBimlcc/k5AYIug3795U3wH129i14a3/ms1r1+S06S
         5MmnYoY/n2TaidSABqqJSD+1rfrn69jdjqmtOFy090ANFBzUoPLHkPEksgRKutMaNlrM
         J2Ox5AMddcK+oxowisewghksd/xZLYfdfyCsHy/N15EuKAr59dETUObCh/gmvkHXy35C
         i1DFJEEGOYtWLdbWKT4tqXfT8/UhH4Sms4IopkNwDHDUZXNoiIIpyI55tV4XakC0Osld
         ajrFU8+SKA0WI+IxGbxKfCEg4NbITAhGvFf8jsQniF9b/arCnaUp6DvsnPORojvhpvio
         zNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLSI5DTfdZAfsDHGQkcA3WiBGQTVoj9JCzoyZ8csosI=;
        b=q6NBoSn/oVljf3pjqRFOSdfDJNS7oj9wanUChDK4CFtxV3MgnwxkVO/YovxBdNmisS
         bbMDjafpYT9lrDe6XYh6oFKleNvIk8VUfewyl3zYWfobFpaWoJ8lXrCEpsmLDLFyoewY
         SRx1VB8CI96VanKvUPpnYfE3qjUEaFFvJmIhnm000z30SMJLV6XXS7k6xu5TFMfgSTw8
         BF7+mL59f1FLsh6synluVec5TVEu89jLhbVYIDSUJsc4LyJxSEtF5ZAoi4O+ygmOvfq+
         t3jyLXK4zb0EXoVXYcX2P9U0Q+A8yOD7EuLkkk5WRYF8ny2YVWmxQxUHqqIOWVfYdjHz
         JQhw==
X-Gm-Message-State: AOAM533GICZf7yBSehInM0Ye8Se6tZ4Lz1j20F/6p0lEjK2kb0BSFMs2
        UUtctJS08Z7EJUchMuCkNHE=
X-Google-Smtp-Source: ABdhPJzK99lg8c9LrlBXPBwUg5Wrbm0/JB+NmJ01xxEaFuUy7K7HKS9uwrXVDw3yXYjv/425931+RA==
X-Received: by 2002:a63:7d5d:0:b0:34c:17:6174 with SMTP id m29-20020a637d5d000000b0034c00176174mr18517043pgn.133.1647222863015;
        Sun, 13 Mar 2022 18:54:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s25-20020a056a00179900b004f737ce5c1asm17278447pfg.73.2022.03.13.18.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 18:54:22 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com
Cc:     akpm@linux-foundation.org, bristot@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH linux-next] ksm: Count ksm-merging pages for each process
Date:   Mon, 14 Mar 2022 01:53:55 +0000
Message-Id: <20220314015355.2111696-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

As current KSM only counts the number of KSM merging pages(e.g.
ksm_pages_sharing and ksm_pages_shared) of the whole system, we cannot
see the more fine-grained KSM merging, for the upper application
optimization, the merging area cannot be set easily according to the
KSM page merging probability of each process. Therefore, it is necessary
to add extra statistical means so that the upper level users can know
the detailed KSM merging information of each process.

We add a new proc file named as ksm_merging_pages under /proc/<pid>/
to indicate the involved ksm merging pages of this process.

Thanks-to: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 fs/proc/base.c        | 15 +++++++++++++++
 include/linux/sched.h |  5 +++++
 mm/ksm.c              | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 76bf1aa3cfe8..b044535df0d2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3155,6 +3155,15 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
 }
 #endif /* CONFIG_LIVEPATCH */
 
+#if defined(CONFIG_KSM) && defined(CONFIG_MEMCG)
+static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *ns,
+				struct pid *pid, struct task_struct *task)
+{
+	seq_printf(m, "%lu\n", task->ksm_merging_pages);
+	return 0;
+}
+#endif /* CONFIG_KSM and CONFIG_MEMCG */
+
 #ifdef CONFIG_STACKLEAK_METRICS
 static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
 				struct pid *pid, struct task_struct *task)
@@ -3286,6 +3295,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_SECCOMP_CACHE_DEBUG
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
+#if defined(CONFIG_KSM) && defined(CONFIG_MEMCG)
+	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
@@ -3619,6 +3631,9 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_SECCOMP_CACHE_DEBUG
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
+#if defined(CONFIG_KSM) && defined(CONFIG_MEMCG)
+	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+#endif
 };
 
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ad710b3f664e..d092cf1a100d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1346,6 +1346,11 @@ struct task_struct {
 	unsigned int			kasan_depth;
 #endif
 
+#if defined(CONFIG_KSM) && defined(CONFIG_MEMCG)
+	unsigned long ksm_merging_pages;
+#endif
+
+
 #ifdef CONFIG_KCSAN
 	struct kcsan_ctx		kcsan_ctx;
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/mm/ksm.c b/mm/ksm.c
index 063a48eeb5ee..c79e7ff278bd 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -629,6 +629,9 @@ static inline void free_stable_node_chain(struct stable_node *chain,
 static void remove_node_from_stable_tree(struct stable_node *stable_node)
 {
 	struct rmap_item *rmap_item;
+#ifdef CONFIG_MEMCG
+	struct task_struct *owner;
+#endif
 
 	/* check it's not STABLE_NODE_CHAIN or negative */
 	BUG_ON(stable_node->rmap_hlist_len < 0);
@@ -638,6 +641,14 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
 			ksm_pages_sharing--;
 		else
 			ksm_pages_shared--;
+
+#ifdef CONFIG_MEMCG /*Condition of mm_struct with owner*/
+		BUG_ON(rmap_item->mm == NULL);
+		owner = rmap_item->mm->owner;
+		/* In case that the process of mm may be killed or exit */
+		if (owner)
+			owner->ksm_merging_pages--;
+#endif
 		VM_BUG_ON(stable_node->rmap_hlist_len <= 0);
 		stable_node->rmap_hlist_len--;
 		put_anon_vma(rmap_item->anon_vma);
@@ -771,6 +782,9 @@ static void remove_rmap_item_from_tree(struct rmap_item *rmap_item)
 	if (rmap_item->address & STABLE_FLAG) {
 		struct stable_node *stable_node;
 		struct page *page;
+#ifdef CONFIG_MEMCG
+		struct task_struct *owner;
+#endif
 
 		stable_node = rmap_item->head;
 		page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
@@ -785,6 +799,14 @@ static void remove_rmap_item_from_tree(struct rmap_item *rmap_item)
 			ksm_pages_sharing--;
 		else
 			ksm_pages_shared--;
+
+#ifdef CONFIG_MEMCG /*Condition of mm_struct with owner*/
+		BUG_ON(rmap_item->mm == NULL);
+		owner = rmap_item->mm->owner;
+		/* In case that the process of mm may be killed or exit */
+		if (owner)
+			owner->ksm_merging_pages--;
+#endif
 		VM_BUG_ON(stable_node->rmap_hlist_len <= 0);
 		stable_node->rmap_hlist_len--;
 
@@ -1981,6 +2003,9 @@ static void stable_tree_append(struct rmap_item *rmap_item,
 			       struct stable_node *stable_node,
 			       bool max_page_sharing_bypass)
 {
+#ifdef CONFIG_MEMCG
+	struct task_struct *owner;
+#endif
 	/*
 	 * rmap won't find this mapping if we don't insert the
 	 * rmap_item in the right stable_node
@@ -2007,6 +2032,14 @@ static void stable_tree_append(struct rmap_item *rmap_item,
 		ksm_pages_sharing++;
 	else
 		ksm_pages_shared++;
+
+#ifdef CONFIG_MEMCG /*Condition of mm_struct with owner*/
+	BUG_ON(rmap_item->mm == NULL);
+	owner = rmap_item->mm->owner;
+	/* In case that the process of mm may be killed or exit */
+	if (owner)
+		owner->ksm_merging_pages++;
+#endif
 }
 
 /*
-- 
2.25.1

