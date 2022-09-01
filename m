Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219115A921A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiIAIbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIAIbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:31:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F091257E5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:31:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q3so13235107pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=h9K1JdCkfGUyld5oIiQQ6btcB74MqVy0ViUrjJEnwXc=;
        b=SCRGIWyselNx78NUYI2j5XKcbA5kANz3bKh54mV1XuswqQunJhY2OyslqIc8AP+TA1
         HOijRM9uo7ZA+nlNSAu6U+0Bg98ImbCj6Vf1pkq8gKJHvJdZEjAjmEjAAlpFWPfjE/WA
         hpKK+LGnkrsyHU9s4lPMbTOqCn7ZOfVTgwfXOc+k8b2//k+lKMuYz0V5xmPT0YOTn725
         wF+rG6eCD/jJltU/vWhadu3uzhIhZGvfygDKz8ueBzhkp9t6VF6e/g8LOUpEDuYgVSwv
         G1AR0w0YeFWvtttpZjSLo+zJGOQDUfjrrvPsoSgnwwdihiE4WisjYWOebM/8+EBBpE8L
         CAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=h9K1JdCkfGUyld5oIiQQ6btcB74MqVy0ViUrjJEnwXc=;
        b=WqD8FHrA85X4iErfnBfrtNPpQ1zpw561xyPcPER0S4KY+duZeEzV14WBTIMEC0gBVU
         tgvyjy3eXzgdYTdcdi2V7AsLpkZscaWeUNXDSkO0ipPSDk2w+oVOEJjuOEYfUFQMDUK/
         mCmZcE27WceB2zXrCRU3m/BRI8Di2oiHmh7iUt5iyMwaHS2hiHcOT9wSHpzAC9wLYiSC
         xC0agmrv2Efc0sRT2bevt/tE/Ys5AHSk4H5BkVWjNa8+PDMqkgPKNoMnL8Oc//hYezhh
         iOk2I4zkc3Qc3VabAPkUgcccNQYKk4IJcoIuaIwnWXJmTt9FNtGv2yKDEzIPb2FAvb9w
         MTFA==
X-Gm-Message-State: ACgBeo1ZZVAWSuwJGN7AxMYOARUKk3qPoywgr0/8qQ2KcyD+HDuMUVVF
        bfEu3WeGc4Uy8n+AOJYDK55ykg==
X-Google-Smtp-Source: AA6agR7gwi9Ox6nBbUQXNu8ESlA4qDXfc+ORyLUyKeccgLh1pRlns6P3HS//eZlalJOgWuK0cmDSUQ==
X-Received: by 2002:a17:903:2cb:b0:171:4f0d:beb6 with SMTP id s11-20020a17090302cb00b001714f0dbeb6mr29255338plk.53.1662021069616;
        Thu, 01 Sep 2022 01:31:09 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id 30-20020a630a1e000000b0041d70c03da5sm4666074pgk.60.2022.09.01.01.31.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 01:31:09 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        rientjes@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm: hugetlb: eliminate memory-less nodes handling
Date:   Thu,  1 Sep 2022 16:30:23 +0800
Message-Id: <20220901083023.42319-1-songmuchun@bytedance.com>
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

The memory-notify-based approach aims to handle meory-less nodes, however, it just adds
the complexity of code as pointed by David in thread [1].  The handling of memory-less
nodes is introduced by commit 4faf8d950ec4 ("hugetlb: handle memory hot-plug events").
From its commit message, we cannot find any necessity of handling this case. So, we can
simply register/unregister sysfs entries in register_node/unregister_node to simlify the
code.

https://lore.kernel.org/linux-mm/60933ffc-b850-976c-78a0-0ee6e0ea9ef0@redhat.com/ [1]
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c  |  7 +++++--
 include/linux/node.h |  5 +++++
 mm/hugetlb.c         | 37 ++++++++++---------------------------
 3 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index ed391cb09999..cf115d5a9b8a 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -608,10 +608,12 @@ static int register_node(struct node *node, int num)
 	node->dev.groups = node_dev_groups;
 	error = device_register(&node->dev);
 
-	if (error)
+	if (error) {
 		put_device(&node->dev);
-	else
+	} else {
+		hugetlb_register_node(node);
 		compaction_register_node(node);
+	}
 
 	return error;
 }
@@ -625,6 +627,7 @@ static int register_node(struct node *node, int num)
  */
 void unregister_node(struct node *node)
 {
+	hugetlb_unregister_node(node);
 	compaction_unregister_node(node);
 	node_remove_accesses(node);
 	node_remove_caches(node);
diff --git a/include/linux/node.h b/include/linux/node.h
index 427a5975cf40..f5d41498c2bf 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -138,6 +138,11 @@ extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
 extern int register_memory_node_under_compute_node(unsigned int mem_nid,
 						   unsigned int cpu_nid,
 						   unsigned access);
+
+#ifdef CONFIG_HUGETLBFS
+void hugetlb_register_node(struct node *node);
+void hugetlb_unregister_node(struct node *node);
+#endif
 #else
 static inline void node_dev_init(void)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0617d64d718..722e862bb6be 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3898,6 +3898,7 @@ static void __init hugetlb_sysfs_init(void)
 }
 
 #ifdef CONFIG_NUMA
+static bool hugetlb_initialized __ro_after_init;
 
 /*
  * node_hstate/s - associate per node hstate attributes, via their kobjects,
@@ -3953,7 +3954,7 @@ static struct hstate *kobj_to_node_hstate(struct kobject *kobj, int *nidp)
  * Unregister hstate attributes from a single node device.
  * No-op if no hstate attributes attached.
  */
-static void hugetlb_unregister_node(struct node *node)
+void hugetlb_unregister_node(struct node *node)
 {
 	struct hstate *h;
 	struct node_hstate *nhs = &node_hstates[node->dev.id];
@@ -3983,19 +3984,22 @@ static void hugetlb_unregister_node(struct node *node)
  * Register hstate attributes for a single node device.
  * No-op if attributes already registered.
  */
-static int hugetlb_register_node(struct node *node)
+void hugetlb_register_node(struct node *node)
 {
 	struct hstate *h;
 	struct node_hstate *nhs = &node_hstates[node->dev.id];
 	int err;
 
+	if (!hugetlb_initialized)
+		return;
+
 	if (nhs->hugepages_kobj)
-		return 0;		/* already allocated */
+		return;		/* already allocated */
 
 	nhs->hugepages_kobj = kobject_create_and_add("hugepages",
 							&node->dev.kobj);
 	if (!nhs->hugepages_kobj)
-		return -ENOMEM;
+		return;
 
 	for_each_hstate(h) {
 		err = hugetlb_sysfs_add_hstate(h, nhs->hugepages_kobj,
@@ -4005,28 +4009,9 @@ static int hugetlb_register_node(struct node *node)
 			pr_err("HugeTLB: Unable to add hstate %s for node %d\n",
 				h->name, node->dev.id);
 			hugetlb_unregister_node(node);
-			return -ENOMEM;
+			break;
 		}
 	}
-	return 0;
-}
-
-static int __meminit hugetlb_memory_callback(struct notifier_block *self,
-					     unsigned long action, void *arg)
-{
-	int ret = 0;
-	struct memory_notify *mnb = arg;
-	int nid = mnb->status_change_nid;
-
-	if (nid == NUMA_NO_NODE)
-		return NOTIFY_DONE;
-
-	if (action == MEM_GOING_ONLINE)
-		ret = hugetlb_register_node(node_devices[nid]);
-	else if (action == MEM_CANCEL_ONLINE || action == MEM_OFFLINE)
-		hugetlb_unregister_node(node_devices[nid]);
-
-	return notifier_from_errno(ret);
 }
 
 /*
@@ -4038,11 +4023,9 @@ static void __init hugetlb_register_all_nodes(void)
 {
 	int nid;
 
-	get_online_mems();
-	hotplug_memory_notifier(hugetlb_memory_callback, 0);
+	hugetlb_initialized = true;
 	for_each_node_state(nid, N_MEMORY)
 		hugetlb_register_node(node_devices[nid]);
-	put_online_mems();
 }
 #else	/* !CONFIG_NUMA */
 
-- 
2.11.0

