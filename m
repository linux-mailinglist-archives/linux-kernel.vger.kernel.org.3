Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F295B161D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIHH7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiIHH6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:58:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2918CC2759
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:58:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z187so17099222pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 00:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=dN1vu9YkPP2qvJgARkUVS3Lj2dJbT8tyN8H4FWEm0MA=;
        b=euS70EXnFyEuCkfB97RoVTfQScHu6QidJEayfqWFXllx6tKNbBDs8Aqmkx9TtVL12O
         TTq6BHiy3Isdo97zquLkpB1THGASkfqZ3BWxO2AqRvTdP2cR6xiMaQejSbm/PoPX3m0G
         OBtLuoI8XsX/QCbYSuCERMB/p3HDnuO6xd7/z5l9DGjkPVJJ8FLdKvSzAm8l75rggPPQ
         Gt9I+4k7JbdvuQvFMcer0YtnXbUSAbUaQDiwQWnjsVUd1G4KFasZbLWn3PbuSF3wayCO
         p5i4SHWeezrRST417Vp3epc7DIaEdTiwpGjgQygjXj5EgLWCMVGVf7lWqebLHYrIOaWd
         kKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=dN1vu9YkPP2qvJgARkUVS3Lj2dJbT8tyN8H4FWEm0MA=;
        b=yojHlJa7kt3vOhkzwgvOBWg3knWhQ1PzgpfLUkJYLNbmvCunIctBTnSmqNtrD0qFj+
         TLg8sox7vAB/YOmypbAwrQX3O0dgxSJyY0BT5ceC42r9U6+tdmDO0BZbHR6dEEmcMCPh
         ntLTQ/Tb2g4RtAXdI5KJPEftCrOq8Pmbg2GTg4EQPuj1HsnKJ1yrNvGoBuIuzj9ceJhw
         T/mkeSxdRL0tQbnCe0mU8M2wTinVI1H54gPErtdyOTxi59ZFFJn/E6iE8ng3DKw+Isvv
         LgI353ZeeGADfEGeYhTx+/IetTThOOL6Lyt6/2WJ8xW3uMLgfpj6AkNYDO/CZA09JvO8
         Mvew==
X-Gm-Message-State: ACgBeo2j2Iacrx00P/krdsqhAPcTKOx82c9KBtcnal8QKT8ry4K/CBL8
        +h58nomq7g8b5H6NLOuBg2Qnbg==
X-Google-Smtp-Source: AA6agR49G6QcDPmAfuup5cvjmfzK6UHcAZrEeHq1TcrNSokGuLivx7bOYj8Y++Xb1F3n0B7DFKo9zA==
X-Received: by 2002:a05:6a00:1650:b0:52f:20d6:e858 with SMTP id m16-20020a056a00165000b0052f20d6e858mr7863601pfc.36.1662623926544;
        Thu, 08 Sep 2022 00:58:46 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902bd0c00b001745919b197sm13629980pls.243.2022.09.08.00.58.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Sep 2022 00:58:45 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        rientjes@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev
Subject: [PATCH v3] mm: hugetlb: eliminate memory-less nodes handling
Date:   Thu,  8 Sep 2022 15:58:26 +0800
Message-Id: <20220908075826.37094-1-songmuchun@bytedance.com>
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

BTW, hotplug callback added because in hugetlb_register_all_nodes() we register sysfs
nodes only for N_MEMORY nodes, seeing commit 9b5e5d0fdc91, which said it was a preparation
for handling memory-less nodes via memory hotplug. Since we want to remove memory hotplug,
so make sure we only register per-node sysfs for online (N_ONLINE) nodes in
hugetlb_register_all_nodes().

https://lore.kernel.org/linux-mm/60933ffc-b850-976c-78a0-0ee6e0ea9ef0@redhat.com/ [1]
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v3:
 - Fix 'struct node' is not declared reported by LTP.

v2:
 - Move declaration of function related to hugetlb to hugetlb.h (David).
 - Introduce hugetlb_sysfs_initialized() and call it from hugetlb_sysfs_init() (David).
 - Move hugetlb_register_all_nodes() into hugetlb_sysfs_init() (David).
 - Fix implicit-function-declaration reported by LKP.
 - Register per-node sysfs for online (N_ONLINE) nodes instead of N_MEMORY (Aneesh).

 drivers/base/node.c     |  8 +++--
 include/linux/hugetlb.h | 14 +++++++++
 mm/hugetlb.c            | 81 ++++++++++++++++++++++---------------------------
 3 files changed, 57 insertions(+), 46 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index ed391cb09999..80b1e91b9608 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/hugetlb.h>
 
 static struct bus_type node_subsys = {
 	.name = "node",
@@ -608,10 +609,12 @@ static int register_node(struct node *node, int num)
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
@@ -625,6 +628,7 @@ static int register_node(struct node *node, int num)
  */
 void unregister_node(struct node *node)
 {
+	hugetlb_unregister_node(node);
 	compaction_unregister_node(node);
 	node_remove_accesses(node);
 	node_remove_caches(node);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 852f911d676e..2d98d0ac4a48 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -16,6 +16,7 @@
 struct ctl_table;
 struct user_struct;
 struct mmu_gather;
+struct node;
 
 #ifndef is_hugepd
 typedef struct { unsigned long pd; } hugepd_t;
@@ -967,6 +968,11 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_NUMA
+void hugetlb_register_node(struct node *node);
+void hugetlb_unregister_node(struct node *node);
+#endif
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
@@ -1141,6 +1147,14 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 				   pte_t *ptep, pte_t pte)
 {
 }
+
+static inline void hugetlb_register_node(struct node *node)
+{
+}
+
+static inline void hugetlb_unregister_node(struct node *node)
+{
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0617d64d718..06ac469582da 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3880,24 +3880,14 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
 	return 0;
 }
 
-static void __init hugetlb_sysfs_init(void)
-{
-	struct hstate *h;
-	int err;
-
-	hugepages_kobj = kobject_create_and_add("hugepages", mm_kobj);
-	if (!hugepages_kobj)
-		return;
+#ifdef CONFIG_NUMA
+static bool hugetlb_sysfs_initialized __ro_after_init;
 
-	for_each_hstate(h) {
-		err = hugetlb_sysfs_add_hstate(h, hugepages_kobj,
-					 hstate_kobjs, &hstate_attr_group);
-		if (err)
-			pr_err("HugeTLB: Unable to add hstate %s", h->name);
-	}
+static inline void hugetlb_mark_sysfs_initialized(void)
+{
+	hugetlb_sysfs_initialized = true;
 }
 
-#ifdef CONFIG_NUMA
 
 /*
  * node_hstate/s - associate per node hstate attributes, via their kobjects,
@@ -3953,7 +3943,7 @@ static struct hstate *kobj_to_node_hstate(struct kobject *kobj, int *nidp)
  * Unregister hstate attributes from a single node device.
  * No-op if no hstate attributes attached.
  */
-static void hugetlb_unregister_node(struct node *node)
+void hugetlb_unregister_node(struct node *node)
 {
 	struct hstate *h;
 	struct node_hstate *nhs = &node_hstates[node->dev.id];
@@ -3983,19 +3973,22 @@ static void hugetlb_unregister_node(struct node *node)
  * Register hstate attributes for a single node device.
  * No-op if attributes already registered.
  */
-static int hugetlb_register_node(struct node *node)
+void hugetlb_register_node(struct node *node)
 {
 	struct hstate *h;
 	struct node_hstate *nhs = &node_hstates[node->dev.id];
 	int err;
 
+	if (!hugetlb_sysfs_initialized)
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
@@ -4005,28 +3998,9 @@ static int hugetlb_register_node(struct node *node)
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
@@ -4038,11 +4012,8 @@ static void __init hugetlb_register_all_nodes(void)
 {
 	int nid;
 
-	get_online_mems();
-	hotplug_memory_notifier(hugetlb_memory_callback, 0);
-	for_each_node_state(nid, N_MEMORY)
+	for_each_online_node(nid)
 		hugetlb_register_node(node_devices[nid]);
-	put_online_mems();
 }
 #else	/* !CONFIG_NUMA */
 
@@ -4056,8 +4027,31 @@ static struct hstate *kobj_to_node_hstate(struct kobject *kobj, int *nidp)
 
 static void hugetlb_register_all_nodes(void) { }
 
+static inline void hugetlb_mark_sysfs_initialized(void)
+{
+}
 #endif
 
+static void __init hugetlb_sysfs_init(void)
+{
+	struct hstate *h;
+	int err;
+
+	hugepages_kobj = kobject_create_and_add("hugepages", mm_kobj);
+	if (!hugepages_kobj)
+		return;
+
+	for_each_hstate(h) {
+		err = hugetlb_sysfs_add_hstate(h, hugepages_kobj,
+					 hstate_kobjs, &hstate_attr_group);
+		if (err)
+			pr_err("HugeTLB: Unable to add hstate %s", h->name);
+	}
+
+	hugetlb_mark_sysfs_initialized();
+	hugetlb_register_all_nodes();
+}
+
 static int __init hugetlb_init(void)
 {
 	int i;
@@ -4112,7 +4106,6 @@ static int __init hugetlb_init(void)
 	report_hugepages();
 
 	hugetlb_sysfs_init();
-	hugetlb_register_all_nodes();
 	hugetlb_cgroup_file_init();
 
 #ifdef CONFIG_SMP
-- 
2.11.0

