Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB99599465
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbiHSFV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiHSFVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:21:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36601DFB4B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:21:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 2so3293232pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=u+CnDhjLlXCRY/C8SfiPEVXWRpNGtWX+sN9YvnfBPFM=;
        b=dhdaPmIgMJDiYHWmdRD2mmexEC15AOGCZEgkA+x/70ZLkhbS/b0vwfjbc1QhBz8D1/
         RcLiY+zmvvuNvdXKlqkEIsYs0RJVaBOsKmAt+51Cx//dd0iISgmFEilP9ZzRwUCMeQf4
         OQGfvJF0AGgRyySQONgiCAg2tMIO08nEV5bH0YoeUCXnvOQkq1xsLkeu0CUssQ2qVn5d
         eWhInBeu6Z64suSxJfGvier1QMz7qd9mpeP4VarSu8qy87SXqIya1l5/xyVKaW8ch2w+
         4nur+7Xlc4WBwDoxWyGPR9XhJqqfgYV6+lsoRhqyZPoNFhZGfBO07bfabGhyKRqXU+s+
         SRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=u+CnDhjLlXCRY/C8SfiPEVXWRpNGtWX+sN9YvnfBPFM=;
        b=2+ZbFFJDkNP26B/f5sWRQlMhg6sZrcvdGtgA31abv8qXcy9i9HFZQQJVilyPQWb9fs
         01ygpqfJH/Nz6szSiKlkU1QamPFFqOj7C5xQdwKR4LBCEl6o419wXcU9DhB5lihey1PZ
         OyGLhe873kkZhX118i1Nxm4ePhp31wHLsgt7dowxqOs/218S1xgMkEjmFnrtjix48Kcj
         3GKL3+O3pieFQM6TbpcfGn3ki6gdyzT+x/e2bztv1zHYUou1t6CG1gADu05Tl1h3piys
         HHWYnCv5/lfogmfpYTMz0TrV8UmN1bncQdyR4nrFNzbbNF7s/tAaZtB+8hBXitUn86kC
         B9zw==
X-Gm-Message-State: ACgBeo0Ca+DfBlAkqQ/UE/jlMxcSJBMPWVd0I/dReuY81ulUV18NFxu4
        cFgY1e8OUbqOxaYd+Qx0h6WvRw==
X-Google-Smtp-Source: AA6agR5UN1h3aOw5IGJ9ghH2y6DkLpD9X/Q2u6TYwxgSUscKyRGV9CR54pVNlevHpOj+aZ/G2cjZZQ==
X-Received: by 2002:a17:903:2d0:b0:172:b63b:3a1e with SMTP id s16-20020a17090302d000b00172b63b3a1emr4689539plk.76.1660886512411;
        Thu, 18 Aug 2022 22:21:52 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id q31-20020a635c1f000000b00421841943dfsm2116524pgb.12.2022.08.18.22.21.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Aug 2022 22:21:52 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev
Subject: [PATCH] mm: hugetlb: simplify per-node sysfs creation and removal
Date:   Fri, 19 Aug 2022 13:21:37 +0800
Message-Id: <20220819052137.7985-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit offload per-node sysfs creation and removal to a kworker and
did not say why it is needed.  And it also said "I don't know that this is
absolutely required".  It seems like the author was not sure as well.  Since it
only complicates the code, this patch will revert the changes to simplify the code.

  39da08cb074c ("hugetlb: offload per node attribute registrations")

We could use memory hotplug notifier to do per-node sysfs creation and removal
instead of inserting those operations to node registration and unregistration.
Then, it can reduce the code coupling between node.c and hugetlb.c.  Also, it can
simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c  | 139 ++-------------------------------------------------
 include/linux/node.h |  24 ++-------
 mm/hugetlb.c         |  45 +++++++++++------
 3 files changed, 36 insertions(+), 172 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index eb0f43784c2b..ed391cb09999 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -587,64 +587,9 @@ static const struct attribute_group *node_dev_groups[] = {
 	NULL
 };
 
-#ifdef CONFIG_HUGETLBFS
-/*
- * hugetlbfs per node attributes registration interface:
- * When/if hugetlb[fs] subsystem initializes [sometime after this module],
- * it will register its per node attributes for all online nodes with
- * memory.  It will also call register_hugetlbfs_with_node(), below, to
- * register its attribute registration functions with this node driver.
- * Once these hooks have been initialized, the node driver will call into
- * the hugetlb module to [un]register attributes for hot-plugged nodes.
- */
-static node_registration_func_t __hugetlb_register_node;
-static node_registration_func_t __hugetlb_unregister_node;
-
-static inline bool hugetlb_register_node(struct node *node)
-{
-	if (__hugetlb_register_node &&
-			node_state(node->dev.id, N_MEMORY)) {
-		__hugetlb_register_node(node);
-		return true;
-	}
-	return false;
-}
-
-static inline void hugetlb_unregister_node(struct node *node)
-{
-	if (__hugetlb_unregister_node)
-		__hugetlb_unregister_node(node);
-}
-
-void register_hugetlbfs_with_node(node_registration_func_t doregister,
-				  node_registration_func_t unregister)
-{
-	__hugetlb_register_node   = doregister;
-	__hugetlb_unregister_node = unregister;
-}
-#else
-static inline void hugetlb_register_node(struct node *node) {}
-
-static inline void hugetlb_unregister_node(struct node *node) {}
-#endif
-
 static void node_device_release(struct device *dev)
 {
-	struct node *node = to_node(dev);
-
-#if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_HUGETLBFS)
-	/*
-	 * We schedule the work only when a memory section is
-	 * onlined/offlined on this node. When we come here,
-	 * all the memory on this node has been offlined,
-	 * so we won't enqueue new work to this work.
-	 *
-	 * The work is using node->node_work, so we should
-	 * flush work before freeing the memory.
-	 */
-	flush_work(&node->node_work);
-#endif
-	kfree(node);
+	kfree(to_node(dev));
 }
 
 /*
@@ -665,11 +610,9 @@ static int register_node(struct node *node, int num)
 
 	if (error)
 		put_device(&node->dev);
-	else {
-		hugetlb_register_node(node);
-
+	else
 		compaction_register_node(node);
-	}
+
 	return error;
 }
 
@@ -683,7 +626,6 @@ static int register_node(struct node *node, int num)
 void unregister_node(struct node *node)
 {
 	compaction_unregister_node(node);
-	hugetlb_unregister_node(node);		/* no-op, if memoryless node */
 	node_remove_accesses(node);
 	node_remove_caches(node);
 	device_unregister(&node->dev);
@@ -905,74 +847,8 @@ void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
 			   (void *)&nid, func);
 	return;
 }
-
-#ifdef CONFIG_HUGETLBFS
-/*
- * Handle per node hstate attribute [un]registration on transistions
- * to/from memoryless state.
- */
-static void node_hugetlb_work(struct work_struct *work)
-{
-	struct node *node = container_of(work, struct node, node_work);
-
-	/*
-	 * We only get here when a node transitions to/from memoryless state.
-	 * We can detect which transition occurred by examining whether the
-	 * node has memory now.  hugetlb_register_node() already check this
-	 * so we try to register the attributes.  If that fails, then the
-	 * node has transitioned to memoryless, try to unregister the
-	 * attributes.
-	 */
-	if (!hugetlb_register_node(node))
-		hugetlb_unregister_node(node);
-}
-
-static void init_node_hugetlb_work(int nid)
-{
-	INIT_WORK(&node_devices[nid]->node_work, node_hugetlb_work);
-}
-
-static int node_memory_callback(struct notifier_block *self,
-				unsigned long action, void *arg)
-{
-	struct memory_notify *mnb = arg;
-	int nid = mnb->status_change_nid;
-
-	switch (action) {
-	case MEM_ONLINE:
-	case MEM_OFFLINE:
-		/*
-		 * offload per node hstate [un]registration to a work thread
-		 * when transitioning to/from memoryless state.
-		 */
-		if (nid != NUMA_NO_NODE)
-			schedule_work(&node_devices[nid]->node_work);
-		break;
-
-	case MEM_GOING_ONLINE:
-	case MEM_GOING_OFFLINE:
-	case MEM_CANCEL_ONLINE:
-	case MEM_CANCEL_OFFLINE:
-	default:
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-#endif	/* CONFIG_HUGETLBFS */
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
-#if !defined(CONFIG_MEMORY_HOTPLUG) || !defined(CONFIG_HUGETLBFS)
-static inline int node_memory_callback(struct notifier_block *self,
-				unsigned long action, void *arg)
-{
-	return NOTIFY_OK;
-}
-
-static void init_node_hugetlb_work(int nid) { }
-
-#endif
-
 int __register_one_node(int nid)
 {
 	int error;
@@ -991,8 +867,6 @@ int __register_one_node(int nid)
 	}
 
 	INIT_LIST_HEAD(&node_devices[nid]->access_list);
-	/* initialize work queue for memory hot plug */
-	init_node_hugetlb_work(nid);
 	node_init_caches(nid);
 
 	return error;
@@ -1063,13 +937,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
 	NULL,
 };
 
-#define NODE_CALLBACK_PRI	2	/* lower than SLAB */
 void __init node_dev_init(void)
 {
-	static struct notifier_block node_memory_callback_nb = {
-		.notifier_call = node_memory_callback,
-		.priority = NODE_CALLBACK_PRI,
-	};
 	int ret, i;
 
  	BUILD_BUG_ON(ARRAY_SIZE(node_state_attr) != NR_NODE_STATES);
@@ -1079,8 +948,6 @@ void __init node_dev_init(void)
 	if (ret)
 		panic("%s() failed to register subsystem: %d\n", __func__, ret);
 
-	register_hotmemory_notifier(&node_memory_callback_nb);
-
 	/*
 	 * Create all node devices, which will properly link the node
 	 * to applicable memory block devices and already created cpu devices.
diff --git a/include/linux/node.h b/include/linux/node.h
index 40d641a8bfb0..ea817b507f54 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -2,15 +2,15 @@
 /*
  * include/linux/node.h - generic node definition
  *
- * This is mainly for topological representation. We define the 
- * basic 'struct node' here, which can be embedded in per-arch 
+ * This is mainly for topological representation. We define the
+ * basic 'struct node' here, which can be embedded in per-arch
  * definitions of processors.
  *
  * Basic handling of the devices is done in drivers/base/node.c
- * and system devices are handled in drivers/base/sys.c. 
+ * and system devices are handled in drivers/base/sys.c.
  *
  * Nodes are exported via driverfs in the class/node/devices/
- * directory. 
+ * directory.
  */
 #ifndef _LINUX_NODE_H_
 #define _LINUX_NODE_H_
@@ -18,7 +18,6 @@
 #include <linux/device.h>
 #include <linux/cpumask.h>
 #include <linux/list.h>
-#include <linux/workqueue.h>
 
 /**
  * struct node_hmem_attrs - heterogeneous memory performance attributes
@@ -84,10 +83,6 @@ static inline void node_set_perf_attrs(unsigned int nid,
 struct node {
 	struct device	dev;
 	struct list_head access_list;
-
-#if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_HUGETLBFS)
-	struct work_struct	node_work;
-#endif
 #ifdef CONFIG_HMEM_REPORTING
 	struct list_head cache_attrs;
 	struct device *cache_dev;
@@ -96,7 +91,6 @@ struct node {
 
 struct memory_block;
 extern struct node *node_devices[];
-typedef  void (*node_registration_func_t)(struct node *);
 
 #if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_NUMA)
 void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
@@ -144,11 +138,6 @@ extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
 extern int register_memory_node_under_compute_node(unsigned int mem_nid,
 						   unsigned int cpu_nid,
 						   unsigned access);
-
-#ifdef CONFIG_HUGETLBFS
-extern void register_hugetlbfs_with_node(node_registration_func_t doregister,
-					 node_registration_func_t unregister);
-#endif
 #else
 static inline void node_dev_init(void)
 {
@@ -176,11 +165,6 @@ static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 static inline void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
 {
 }
-
-static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
-						node_registration_func_t unreg)
-{
-}
 #endif
 
 #define to_node(device) container_of(device, struct node, dev)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 536a52c29035..9a72499486c1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -33,6 +33,7 @@
 #include <linux/migrate.h>
 #include <linux/nospec.h>
 #include <linux/delayacct.h>
+#include <linux/memory.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -3967,19 +3968,19 @@ static void hugetlb_unregister_node(struct node *node)
  * Register hstate attributes for a single node device.
  * No-op if attributes already registered.
  */
-static void hugetlb_register_node(struct node *node)
+static int hugetlb_register_node(struct node *node)
 {
 	struct hstate *h;
 	struct node_hstate *nhs = &node_hstates[node->dev.id];
 	int err;
 
 	if (nhs->hugepages_kobj)
-		return;		/* already allocated */
+		return 0;		/* already allocated */
 
 	nhs->hugepages_kobj = kobject_create_and_add("hugepages",
 							&node->dev.kobj);
 	if (!nhs->hugepages_kobj)
-		return;
+		return -ENOMEM;
 
 	for_each_hstate(h) {
 		err = hugetlb_sysfs_add_hstate(h, nhs->hugepages_kobj,
@@ -3989,9 +3990,28 @@ static void hugetlb_register_node(struct node *node)
 			pr_err("HugeTLB: Unable to add hstate %s for node %d\n",
 				h->name, node->dev.id);
 			hugetlb_unregister_node(node);
-			break;
+			return -ENOMEM;
 		}
 	}
+	return 0;
+}
+
+static int __meminit hugetlb_memory_callback(struct notifier_block *self,
+					     unsigned long action, void *arg)
+{
+	int ret = 0;
+	struct memory_notify *mnb = arg;
+	int nid = mnb->status_change_nid;
+
+	if (nid == NUMA_NO_NODE)
+		return NOTIFY_DONE;
+
+	if (action == MEM_GOING_ONLINE)
+		ret = hugetlb_register_node(node_devices[nid]);
+	else if (action == MEM_CANCEL_ONLINE || action == MEM_OFFLINE)
+		hugetlb_unregister_node(node_devices[nid]);
+
+	return notifier_from_errno(ret);
 }
 
 /*
@@ -4003,18 +4023,11 @@ static void __init hugetlb_register_all_nodes(void)
 {
 	int nid;
 
-	for_each_node_state(nid, N_MEMORY) {
-		struct node *node = node_devices[nid];
-		if (node->dev.id == nid)
-			hugetlb_register_node(node);
-	}
-
-	/*
-	 * Let the node device driver know we're here so it can
-	 * [un]register hstate attributes on node hotplug.
-	 */
-	register_hugetlbfs_with_node(hugetlb_register_node,
-				     hugetlb_unregister_node);
+	get_online_mems();
+	hotplug_memory_notifier(hugetlb_memory_callback, 0);
+	for_each_node_state(nid, N_MEMORY)
+		hugetlb_register_node(node_devices[nid]);
+	put_online_mems();
 }
 #else	/* !CONFIG_NUMA */
 
-- 
2.11.0

