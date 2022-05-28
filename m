Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515BD536BB9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 10:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349170AbiE1It3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiE1ItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 04:49:24 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08644248E3
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 01:49:22 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L9Fg6428Mz1JCJH;
        Sat, 28 May 2022 16:47:46 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 16:49:20 +0800
Received: from huawei.com (10.175.124.27) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 16:49:19 +0800
From:   liubo <liubo254@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ying.huang@intel.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <surenb@google.com>, <peterx@redhat.com>, <neilb@suse.de>,
        <naoya.horiguchi@nec.com>, <minchan@kernel.org>,
        <linmiaohe@huawei.com>, <louhongxiang@huawei.com>,
        <linfeilong@huawei.com>, <liubo254@huawei.com>
Subject: [PATCH] mm/swapfile: release swap info when swap device is unpluged
Date:   Sat, 28 May 2022 16:49:41 +0800
Message-ID: <20220528084941.28391-1-liubo254@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

When the swap partition is mounted through the swapon command,
the kernel will create the swap_info_struct data structure
and initialize it, and save it in the swap_info global array.
When the swap partition is no longer in use, the disk is
unloaded through the swapoff command.

However, if the disk is pulled out after swapon, an error will
occur when swapoff the disk, causing the swap_info_struct
data structure to remain in the kernel and cannot be cleared.

This patch identifies which disks are no longer available
by adding a traversal operation for swap_active_head available
swap partitions in the swapon and swapoff processes,
so as to clear the above data structures and
release the corresponding resources.

Example:
[root@localhost ~]# swapon -s
[root@localhost ~]# lsblk
NAME             MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                8:0    0  1.1T  0 disk
├─sda1             8:1    0  600M  0 part /boot/efi
├─sda2             8:2    0    1G  0 part /boot
└─sda3             8:3    0  1.1T  0 part
  ├─root 253:0    0   70G  0 lvm  /
  ├─swap 253:1    0    4G  0 lvm
  └─home 253:2    0    1T  0 lvm  /home
nvme0n1          259:0    0  3.6T  0 disk
└─nvme0n1p1      259:5    0   60G  0 part
[root@localhost ~]# swapon /dev/nvme0n1p1
[root@localhost ~]# swapon -s
Filename                   Type            Size    Used    Priority
/dev/nvme0n1p1             partition       62914556        0       -2
[root@localhost ~]# echo 1 > /sys/bus/pci/devices/0000:d8:00.0/remove
[root@localhost ~]# lsblk
NAME             MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                8:0    0  1.1T  0 disk
├─sda1             8:1    0  600M  0 part /boot/efi
├─sda2             8:2    0    1G  0 part /boot
└─sda3             8:3    0  1.1T  0 part
  ├─root 253:0    0   70G  0 lvm  /
  ├─swap 253:1    0    4G  0 lvm
  └─home 253:2    0    1T  0 lvm  /home
[root@localhost ~]# swapon -s
Filename                   Type            Size    Used    Priority
/dev/nvme0n1p1             partition       62914556        0       -2
[root@localhost ~]# swapoff /dev/nvme0n1p1
swapoff: /dev/nvme0n1p1: swapoff failed: No such file or directory
[root@localhost ~]# swapoff -a
[root@localhost ~]# swapon -s
Filename                   Type            Size    Used    Priority
/dev/nvme0n1p1             partition       62914556        0       -2

In the swapoff command, the device is acquired in the following ways,
but the device has been unplugged at this time, causing the "victim"
acquisition to fail, thus returning an error directly.
And the invalid swap_info_struct cannot be effectively released.

pathname = getname(specialfile);
if (IS_ERR(pathname))
	return PTR_ERR(pathname);

victim = file_open_name(pathname, O_RDWR|O_LARGEFILE, 0);
err = PTR_ERR(victim);
if (IS_ERR(victim))
	goto out;

In order to solve the above problems, by adding traversal of
swap_avail_heads (available swap partitions) in the swapoff
and swapon processes,
find the swap_info_struct whose disk partition has been
unplugged, and release resources.

The reason why the judgment of unavailable swap information is also
added to the swapon process is that the swapoff is executed by the
user, and the timing is uncontrollable.
The system supports swapon multiple disks, and the unavailable swap
can be deleted at the same time as swapon is mounted.

In order to realize the interface reuse in the swapoff resource
release process, some of the operations are abstracted
into separate interfaces.

del_useless_swap_info():
Remove specific swap_info_struct from swap_active_head and
update total_swap_pages.

release_swap_info_memory():
Clear the corresponding resources of swap_info_struct.

swapoff_invalid_swapinfo():
Traverse the swap_avail_heads list to release the invalid
swap area resources.

Signed-off-by: liubo <liubo254@huawei.com>
---
 mm/swapfile.c | 262 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 182 insertions(+), 80 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index a2e66d855b19..8d2e75891ff4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -68,7 +68,7 @@ static const char Bad_file[] = "Bad swap file entry ";
 static const char Unused_file[] = "Unused swap file entry ";
 static const char Bad_offset[] = "Bad swap offset entry ";
 static const char Unused_offset[] = "Unused swap offset entry ";
-
+static const char invalid_info[] = "deleted";
 /*
  * all active swap_info_structs
  * protected with swap_lock, and ordered by priority.
@@ -2384,18 +2384,184 @@ bool has_usable_swap(void)
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
+	total_swap_pages -= p->pages;
+	p->flags &= ~SWP_WRITEOK;
+	spin_unlock(&p->lock);
+}
+
+static int swapoff_invalid_swapinfo(void)
+{
+	struct swap_info_struct *p = NULL;
+	struct file *swap_file;
+	int err, found = 0;
+
+	char *tmp = NULL;
+	char *swap_name = NULL;
+
+	tmp = kvzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+rescan:
+	memset(tmp, 0, PAGE_SIZE);
+	spin_lock(&swap_lock);
+	plist_for_each_entry(p, &swap_active_head, list) {
+		if (p->flags & SWP_WRITEOK) {
+			swap_file = p->swap_file;
+			swap_name = d_path(&swap_file->f_path, tmp, PAGE_SIZE);
+
+			if (strstr(swap_name, invalid_info)) {
+				found = 1;
+				break;
+			}
+		}
+	}
+
+	if (!found) {
+		err = 0;
+		spin_unlock(&swap_lock);
+		goto out;
+	}
+
+	del_useless_swap_info(p);
+	spin_unlock(&swap_lock);
+
+	disable_swap_slots_cache_lock();
+	set_current_oom_origin();
+	try_to_unuse(p->type);
+	clear_current_oom_origin();
+
+	reenable_swap_slots_cache_unlock();
+
+	/*
+	 * wait for swap operations protected by get/put_swap_device()
+	 * to complete
+	 */
+	synchronize_rcu();
+
+	flush_work(&p->discard_work);
+
+	destroy_swap_extents(p);
+	if (p->flags & SWP_CONTINUED)
+		free_swap_count_continuations(p);
+
+	if (!p->bdev || !blk_queue_nonrot(bdev_get_queue(p->bdev)))
+		atomic_dec(&nr_rotate_swap);
+
+	release_swap_info_memory(p);
+
+	/*
+	 * Clear the SWP_USED flag after all resources are freed so that swapon
+	 * can reuse this swap_info in alloc_swap_info() safely.  It is ok to
+	 * not hold p->lock after we cleared its SWP_WRITEOK.
+	 */
+	spin_lock(&swap_lock);
+	p->flags = 0;
+	spin_unlock(&swap_lock);
+
+	err = 0;
+	atomic_inc(&proc_poll_event);
+	wake_up_interruptible(&proc_poll_wait);
+
+	found = 0;
+	goto rescan;
+out:
+	kfree(tmp);
+	return err;
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
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -2408,8 +2574,12 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	victim = file_open_name(pathname, O_RDWR|O_LARGEFILE, 0);
 	err = PTR_ERR(victim);
-	if (IS_ERR(victim))
+	if (IS_ERR(victim)) {
+		/* check if the pathname is a device that has been unpluged */
+		err = swapoff_invalid_swapinfo();
+		err = err < 0 ? err : PTR_ERR(victim);
 		goto out;
+	}
 
 	mapping = victim->f_mapping;
 	spin_lock(&swap_lock);
@@ -2433,27 +2603,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
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
-	total_swap_pages -= p->pages;
-	p->flags &= ~SWP_WRITEOK;
-	spin_unlock(&p->lock);
+	del_useless_swap_info(p);
 	spin_unlock(&swap_lock);
 
 	disable_swap_slots_cache_lock();
@@ -2491,60 +2642,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
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
@@ -3008,6 +3106,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (!swap_avail_heads)
 		return -ENOMEM;
 
+	error = swapoff_invalid_swapinfo();
+	if (error < 0)
+		return error;
+
 	p = alloc_swap_info();
 	if (IS_ERR(p))
 		return PTR_ERR(p);
-- 
2.27.0

