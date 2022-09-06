Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7095ADE26
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiIFDnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIFDm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:42:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E5031D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 20:42:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z187so10090540pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 20:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uBO2shQhiYdiIdfEN7uZI5Kda1TTujTfZVMdt56XDUU=;
        b=M8P0n0eqv+ch5RjseM2rwI6DUTBFYHzu9u0cQrFIx+Bc1bZHgXj0elbWpx3+b2nCrl
         Six7gUXcdzJMayfC+VuHk3S0ipMwqXISSzOTYT2hdo+LA9ndF4yaEe77Sl1Rpb/ffumZ
         FsaOaLKEACBof5VUNhNgARA8wxU+oZhPlyg1thYp8WEGHfo6dwJDzUhfeeLEd82eerbz
         iI/XENB/elAGinzwCA/2tbSXIbRWOnhUpYLG7qB6+uhrEePUxe6QDx34E2BAKqDMQ+ZI
         NWvP2XsnA6eXJPCVK1KJYdpeKn2BwvRnLirSRPEt20L2VVoIHTXFvxNR8hnXvupjpMGL
         e6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uBO2shQhiYdiIdfEN7uZI5Kda1TTujTfZVMdt56XDUU=;
        b=OuloHKRPHH0ZupYTb1S8kwuAU6C550zUyQ0l0tqyA4nZU0bvwjTikKMpXNu3kEYptp
         7btIjAcZwUd8uzjSmzNGk0Gcpk7crSDS7RgbePmKBsKk6yB4NCadNxBtbyixBrg9wiEq
         Ba86mWKXTcEh7lPbblhC4E6xB/JuIVXvmdeNgjBxniadHc66QgpVQCQ8pOa2ZPCp+qPo
         Er6d/iuLoX8QgDBytQJpuzCJ9VzyGJxmnS6ava2eFXZSQxMVpkVjU3Kt3qFi/nRN5wfO
         a+RIbyoaimnrAhNeqiBZNmD2CWoSqlcWsRiXlng08OIHsYAYhQyPgEpEeha2sLvfGSt+
         rlsw==
X-Gm-Message-State: ACgBeo3DAt4sWi+8/DXPvBKkFKOpb6PxJE4ivqiV/Arh8IxeuUs5/RAI
        Kkmg2IIAmGFkR/p1tmSh8ylviQ==
X-Google-Smtp-Source: AA6agR5tdbE8RsEOD/daTBfmNgFT9AiyIeV1pe+1EfktbtGfk8xziir36cw4hKz4ZQTJ+vZ6B5BF5g==
X-Received: by 2002:a63:8048:0:b0:42b:1f02:93cd with SMTP id j69-20020a638048000000b0042b1f0293cdmr44313463pgd.499.1662435776086;
        Mon, 05 Sep 2022 20:42:56 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902778d00b001730a1af0fbsm8410751pll.23.2022.09.05.20.42.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Sep 2022 20:42:55 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        rientjes@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev
Subject: [PATCH v2] mm: hugetlb: eliminate memory-less nodes handling
Date:   Tue,  6 Sep 2022 11:42:39 +0800
Message-Id: <20220906034239.69436-1-songmuchun@bytedance.com>
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
make sure we only register per-node sysfs for online (N_ONLINE) nodes in
hugetlb_register_all_nodes().

https://lore.kernel.org/linux-mm/60933ffc-b850-976c-78a0-0ee6e0ea9ef0@redhat.com/ [1]
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
 - Move declaration of function related to hugetlb to hugetlb.h (David).
 - Introduce hugetlb_sysfs_initialized() and call it from hugetlb_sysfs_init() (David).
 - Move hugetlb_register_all_nodes() into hugetlb_sysfs_init() (David).
 - Fix implicit-function-declaration reported by LKP.
 - Register per-node sysfs for online (N_ONLINE) nodes instead of N_MEMORY (Aneesh).

 drivers/base/node.c     |  8 +++--
 include/linux/hugetlb.h | 13 ++++++++
 mm/hugetlb.c            | 81 ++++++++++++++++++++++---------------------------
 3 files changed, 56 insertions(+), 46 deletions(-)

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
index 852f911d676e..3b3d23bcad09 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -967,6 +967,11 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_NUMA
+void hugetlb_register_node(struct node *node);
+void hugetlb_unregister_node(struct node *node);
+#endif
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
@@ -1141,6 +1146,14 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
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

