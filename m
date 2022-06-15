Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E173054C252
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbiFOHCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiFOHCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:02:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A129B41
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:02:37 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LNGPd4dyZzSgsZ;
        Wed, 15 Jun 2022 14:59:17 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 15:02:16 +0800
Received: from huawei.com (10.175.124.27) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 15 Jun
 2022 15:02:15 +0800
From:   liubo <liubo254@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ying.huang@intel.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <surenb@google.com>, <peterx@redhat.com>, <neilb@suse.de>,
        <naoya.horiguchi@nec.com>, <minchan@kernel.org>,
        <linmiaohe@huawei.com>, <louhongxiang@huawei.com>,
        <linfeilong@huawei.com>, <liubo254@huawei.com>
Subject: [PATCH v2 1/2] mm/swapfile: Extract operations of resource release in the swapoff process
Date:   Wed, 15 Jun 2022 15:02:27 +0800
Message-ID: <20220615070228.2858170-2-liubo254@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220615070228.2858170-1-liubo254@huawei.com>
References: <20220615070228.2858170-1-liubo254@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to realize the interface reuse in the swapoff resource
release process, some of the operations are abstracted
into separate interfaces.

Only code movement, no functional modifications and changes.

del_useless_swap_info():
Remove specific swap_info_struct from swap_active_head and
update total_swap_pages.

release_swap_info_memory():
Clear the corresponding resources of swap_info_struct.

Signed-off-by: liubo <liubo254@huawei.com>
---
v2:
Only code movement, no functional modifications and changes.
Former: https://lore.kernel.org/linux-mm/20220528084941.28391-1-liubo254@huawei.com/
---
 mm/swapfile.c | 168 +++++++++++++++++++++++++++-----------------------
 1 file changed, 91 insertions(+), 77 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3fa26f6971e9..2ef5e7b4918e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2386,18 +2386,103 @@ bool has_usable_swap(void)
 	return ret;
 }
 
-SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
+static void release_swap_info_memory(struct swap_info_struct *p)
 {
-	struct swap_info_struct *p = NULL;
 	unsigned char *swap_map;
 	struct swap_cluster_info *cluster_info;
 	unsigned long *frontswap_map;
-	struct file *swap_file, *victim;
+	struct file *swap_file;
 	struct address_space *mapping;
 	struct inode *inode;
+	unsigned int old_block_size;
+
+	mutex_lock(&swapon_mutex);
+	spin_lock(&swap_lock);
+	spin_lock(&p->lock);
+	drain_mmlist();
+
+	/* wait for anyone still in scan_swap_map */
+	p->highest_bit = 0;		/* cuts scans short */
+	while (p->flags >= SWP_SCANNING) {
+		spin_unlock(&p->lock);
+		spin_unlock(&swap_lock);
+		schedule_timeout_uninterruptible(1);
+		spin_lock(&swap_lock);
+		spin_lock(&p->lock);
+	}
+
+	swap_file = p->swap_file;
+	mapping = p->swap_file->f_mapping;
+	old_block_size = p->old_block_size;
+	p->swap_file = NULL;
+	p->max = 0;
+	swap_map = p->swap_map;
+	p->swap_map = NULL;
+	cluster_info = p->cluster_info;
+	p->cluster_info = NULL;
+	frontswap_map = frontswap_map_get(p);
+	spin_unlock(&p->lock);
+	spin_unlock(&swap_lock);
+	arch_swap_invalidate_area(p->type);
+	frontswap_invalidate_area(p->type);
+	frontswap_map_set(p, NULL);
+	mutex_unlock(&swapon_mutex);
+	free_percpu(p->percpu_cluster);
+	p->percpu_cluster = NULL;
+	free_percpu(p->cluster_next_cpu);
+	p->cluster_next_cpu = NULL;
+	vfree(swap_map);
+	kvfree(cluster_info);
+	kvfree(frontswap_map);
+	/* Destroy swap account information */
+	swap_cgroup_swapoff(p->type);
+	exit_swap_address_space(p->type);
+
+	inode = mapping->host;
+	if (S_ISBLK(inode->i_mode)) {
+		struct block_device *bdev = I_BDEV(inode);
+
+		set_blocksize(bdev, old_block_size);
+		blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+	}
+
+	inode_lock(inode);
+	inode->i_flags &= ~S_SWAPFILE;
+	inode_unlock(inode);
+	filp_close(swap_file, NULL);
+}
+
+static void del_useless_swap_info(struct swap_info_struct *p)
+{
+	del_from_avail_list(p);
+	spin_lock(&p->lock);
+	if (p->prio < 0) {
+		struct swap_info_struct *si = p;
+		int nid;
+
+		plist_for_each_entry_continue(si, &swap_active_head, list) {
+			si->prio++;
+			si->list.prio--;
+			for_each_node(nid) {
+				if (si->avail_lists[nid].prio != 1)
+					si->avail_lists[nid].prio--;
+			}
+		}
+		least_priority++;
+	}
+	plist_del(&p->list, &swap_active_head);
+	atomic_long_sub(p->pages, &nr_swap_pages);
+	p->flags &= ~SWP_WRITEOK;
+	spin_unlock(&p->lock);
+}
+
+SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
+{
+	struct swap_info_struct *p = NULL;
+	struct file *victim;
+	struct address_space *mapping;
 	struct filename *pathname;
 	int err, found = 0;
-	unsigned int old_block_size;
 	unsigned int inuse_pages;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -2440,26 +2525,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		spin_unlock(&swap_lock);
 		goto out_dput;
 	}
-	del_from_avail_list(p);
-	spin_lock(&p->lock);
-	if (p->prio < 0) {
-		struct swap_info_struct *si = p;
-		int nid;
 
-		plist_for_each_entry_continue(si, &swap_active_head, list) {
-			si->prio++;
-			si->list.prio--;
-			for_each_node(nid) {
-				if (si->avail_lists[nid].prio != 1)
-					si->avail_lists[nid].prio--;
-			}
-		}
-		least_priority++;
-	}
-	plist_del(&p->list, &swap_active_head);
-	atomic_long_sub(p->pages, &nr_swap_pages);
-	p->flags &= ~SWP_WRITEOK;
-	spin_unlock(&p->lock);
+	del_useless_swap_info(p);
 	spin_unlock(&swap_lock);
 
 	disable_swap_slots_cache_lock();
@@ -2497,60 +2564,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	if (!p->bdev || !bdev_nonrot(p->bdev))
 		atomic_dec(&nr_rotate_swap);
 
-	mutex_lock(&swapon_mutex);
-	spin_lock(&swap_lock);
-	spin_lock(&p->lock);
-	drain_mmlist();
-
-	/* wait for anyone still in scan_swap_map_slots */
-	p->highest_bit = 0;		/* cuts scans short */
-	while (p->flags >= SWP_SCANNING) {
-		spin_unlock(&p->lock);
-		spin_unlock(&swap_lock);
-		schedule_timeout_uninterruptible(1);
-		spin_lock(&swap_lock);
-		spin_lock(&p->lock);
-	}
-
-	swap_file = p->swap_file;
-	old_block_size = p->old_block_size;
-	p->swap_file = NULL;
-	p->max = 0;
-	swap_map = p->swap_map;
-	p->swap_map = NULL;
-	cluster_info = p->cluster_info;
-	p->cluster_info = NULL;
-	frontswap_map = frontswap_map_get(p);
-	spin_unlock(&p->lock);
-	spin_unlock(&swap_lock);
-	arch_swap_invalidate_area(p->type);
-	frontswap_invalidate_area(p->type);
-	frontswap_map_set(p, NULL);
-	mutex_unlock(&swapon_mutex);
-	free_percpu(p->percpu_cluster);
-	p->percpu_cluster = NULL;
-	free_percpu(p->cluster_next_cpu);
-	p->cluster_next_cpu = NULL;
-	vfree(swap_map);
-	kvfree(cluster_info);
-	kvfree(frontswap_map);
-	/* Destroy swap account information */
-	swap_cgroup_swapoff(p->type);
-	exit_swap_address_space(p->type);
-
-	inode = mapping->host;
-	if (S_ISBLK(inode->i_mode)) {
-		struct block_device *bdev = I_BDEV(inode);
-
-		set_blocksize(bdev, old_block_size);
-		blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
-	}
-
-	inode_lock(inode);
-	inode->i_flags &= ~S_SWAPFILE;
-	inode_unlock(inode);
-	filp_close(swap_file, NULL);
-
+	release_swap_info_memory(p);
 	/*
 	 * Clear the SWP_USED flag after all resources are freed so that swapon
 	 * can reuse this swap_info in alloc_swap_info() safely.  It is ok to
-- 
2.27.0

