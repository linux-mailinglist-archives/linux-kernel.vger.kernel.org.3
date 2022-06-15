Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74F054C250
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbiFOHC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiFOHC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:02:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAC12E682
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:02:24 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LNGPM6tFQzSgrL;
        Wed, 15 Jun 2022 14:59:03 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 15:02:17 +0800
Received: from huawei.com (10.175.124.27) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 15 Jun
 2022 15:02:16 +0800
From:   liubo <liubo254@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ying.huang@intel.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <surenb@google.com>, <peterx@redhat.com>, <neilb@suse.de>,
        <naoya.horiguchi@nec.com>, <minchan@kernel.org>,
        <linmiaohe@huawei.com>, <louhongxiang@huawei.com>,
        <linfeilong@huawei.com>, <liubo254@huawei.com>
Subject: [PATCH v2 2/2] mm/swapfile: release swap info when swap device is unpluged
Date:   Wed, 15 Jun 2022 15:02:28 +0800
Message-ID: <20220615070228.2858170-3-liubo254@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220615070228.2858170-1-liubo254@huawei.com>
References: <20220615070228.2858170-1-liubo254@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Signed-off-by: liubo <liubo254@huawei.com>
---
v2:
The possible solution to the problem that the swap resources
are not released when the swap partition is hot-pluged.
The actual fix of the former patch.

Former:https://lore.kernel.org/linux-mm/20220528084941.28391-1-liubo254@huawei.com/
---
 mm/swapfile.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2ef5e7b4918e..91208de9f689 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -68,6 +68,7 @@ static const char Bad_file[] = "Bad swap file entry ";
 static const char Unused_file[] = "Unused swap file entry ";
 static const char Bad_offset[] = "Bad swap offset entry ";
 static const char Unused_offset[] = "Unused swap offset entry ";
+static const char invalid_info[] = "deleted";
 
 /*
  * all active swap_info_structs
@@ -2476,6 +2477,88 @@ static void del_useless_swap_info(struct swap_info_struct *p)
 	spin_unlock(&p->lock);
 }
 
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
+	total_swap_pages -= p->pages;
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
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
@@ -2496,8 +2579,12 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
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
@@ -3028,6 +3115,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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

