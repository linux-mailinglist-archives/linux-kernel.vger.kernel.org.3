Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578AC525F12
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379125AbiEMJkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379061AbiEMJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:40:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEEB291CDC
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:40:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L03Wm1QTJzgZ2p;
        Fri, 13 May 2022 17:39:32 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 17:40:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
Subject: [Question]: Decision-making swapoff process to fix problem
 feasibility
To:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Huang Ying <ying.huang@intel.com>,
        Matthew Wilcox <willy@infradead.org>, <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, <peterx@redhat.com>,
        NeilBrown <neilb@suse.de>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Minchan Kim <minchan@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "liubo (AW)" <liubo254@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8a8d3614-9081-3fff-ebca-011deffc4605@huawei.com>
Date:   Fri, 13 May 2022 17:40:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Background:
	When the swap partition is mounted through the swapon command,
	the kernel will create the swap_info_struct data structure
	and initialize it, and save it in the swap_info global array.
	When the swap partition is no longer in use, the disk is
	unloaded through the swapoff command.

	However, if the disk is pulled out after swapon, an error will
	occur when swapoff the disk, causing the swap_info_struct
	data structure to remain in the kernel and cannot be cleared.

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
	Filename                                Type            Size    Used    Priority
	/dev/nvme0n1p1                          partition       62914556        0       -2
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
	Filename                                Type            Size    Used    Priority
	/dev/nvme0n1p1                          partition       62914556        0       -2
	[root@localhost ~]# swapoff /dev/nvme0n1p1
	swapoff: /dev/nvme0n1p1: swapoff failed: No such file or directory
	[root@localhost ~]# swapoff -a
	[root@localhost ~]# swapon -s
	Filename                                Type            Size    Used    Priority
	/dev/nvme0n1p1                          partition       62914556        0       -2
	
Reason:
	In the swapoff command, the device is acquired in the following ways,
	but the device has been unplugged at this time, causing the "victim"
	acquisition to fail, thus returning an error directly.
	And the invalid swap_info_struct cannot be effectively released.

	sys_swapoff

	pathname = getname(specialfile);
	if (IS_ERR(pathname))
		return PTR_ERR(pathname);

	victim = file_open_name(pathname, O_RDWR|O_LARGEFILE, 0);
	err = PTR_ERR(victim);
	if (IS_ERR(victim))
		goto out;

Possible Solution:
	In order to solve the above problems, by adding traversal of
	swap_avail_heads (available swap partitions) in the swapoff
	and swapon processes, find the swap_info_struct whose disk
	partition has been unplugged, and release resources.

	swapoff/swapon process:
	
	...
	spin_lock(&swap_lock);
	plist_for_each_entry(p, &swap_active_head, list) {
			if (p->flags & SWP_WRITEOK) {
					swap_file = p->swap_file;
					swap_name = d_path(&swap_file->f_path, tmp, PAGE_SIZE);

					if (strstr(swap_name, "deleted")) {
							found = 1;
							break;
					}
			}
	}
	spin_unlock(&swap_lock);
	...
	/* do the resource release process */
	
	The reason why the judgment of unavailable swap information is also
	added to the swapon process is that the swapoff is executed by the
	user, and the timing is uncontrollable.
	The system supports swapon multiple disks, and the unavailable swap
	can be deleted at the same time as swapon is mounted.

It will be very appreciative if anyone can give any suggestions and comment! Thanks a lot in advance! :)
