Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C29947BFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbhLUMdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:33:20 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30086 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhLUMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:33:19 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JJG4f0VNSz1DJwy;
        Tue, 21 Dec 2021 20:30:10 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 20:33:17 +0800
Subject: Re: [PATCH -next V3] ubi: fix race condition between ctrl_cdev_ioctl
 and ubi_cdev_ioctl
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <yukuai3@huawei.com>, Hulk Robot <hulkci@huawei.com>
References: <20211105093022.1360601-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <7e00eda5-3b35-6d3c-29fb-664b12cca6dd@huawei.com>
Date:   Tue, 21 Dec 2021 20:33:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20211105093022.1360601-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2021/11/5 17:30, Baokun Li Ð´µÀ:

ping

> Hulk Robot reported a KASAN report about use-after-free:
>   ==================================================================
>   BUG: KASAN: use-after-free in __list_del_entry_valid+0x13d/0x160
>   Read of size 8 at addr ffff888035e37d98 by task ubiattach/1385
>   [...]
>   Call Trace:
>    klist_dec_and_del+0xa7/0x4a0
>    klist_put+0xc7/0x1a0
>    device_del+0x4d4/0xed0
>    cdev_device_del+0x1a/0x80
>    ubi_attach_mtd_dev+0x2951/0x34b0 [ubi]
>    ctrl_cdev_ioctl+0x286/0x2f0 [ubi]
>
>   Allocated by task 1414:
>    device_add+0x60a/0x18b0
>    cdev_device_add+0x103/0x170
>    ubi_create_volume+0x1118/0x1a10 [ubi]
>    ubi_cdev_ioctl+0xb7f/0x1ba0 [ubi]
>
>   Freed by task 1385:
>    cdev_device_del+0x1a/0x80
>    ubi_remove_volume+0x438/0x6c0 [ubi]
>    ubi_cdev_ioctl+0xbf4/0x1ba0 [ubi]
>   [...]
>   ==================================================================
>
> The lock held by ctrl_cdev_ioctl is ubi_devices_mutex, but the lock held
> by ubi_cdev_ioctl is ubi->device_mutex. Therefore, the two locks can be
> concurrent.
>
> ctrl_cdev_ioctl contains two operations: ubi_attach and ubi_detach.
> ubi_detach is bug-free because it uses reference counting to prevent
> concurrency. However, uif_init and uif_close in ubi_attach may race with
> ubi_cdev_ioctl.
>
> uif_init will race with ubi_cdev_ioctl as in the following stack.
>             cpu1                   cpu2                  cpu3
> _______________________|________________________|______________________
> ctrl_cdev_ioctl
>   ubi_attach_mtd_dev
>    uif_init
>                             ubi_cdev_ioctl
>                              ubi_create_volume
>                               cdev_device_add
>     ubi_add_volume
>     // sysfs exist
>     kill_volumes
>                                                      ubi_cdev_ioctl
>                                                       ubi_remove_volume
>                                                        cdev_device_del
>                                                         // first free
>      ubi_free_volume
>       cdev_del
>       // double free
>     cdev_device_del
>
> And uif_close will race with ubi_cdev_ioctl as in the following stack.
>             cpu1                   cpu2                  cpu3
> _______________________|________________________|______________________
> ctrl_cdev_ioctl
>   ubi_attach_mtd_dev
>    uif_init
>                             ubi_cdev_ioctl
>                              ubi_create_volume
>                               cdev_device_add
>    ubi_debugfs_init_dev
>    //error goto out_uif;
>    uif_close
>     kill_volumes
>                                                      ubi_cdev_ioctl
>                                                       ubi_remove_volume
>                                                        cdev_device_del
>                                                         // first free
>      ubi_free_volume
>      // double free
>
> The cause of this problem is that commit 714fb87e8bc0 make device
> "available" before it becomes accessible via sysfs. Therefore, we
> roll back the modification. We will fix the race condition between
> ubi device creation and udev by removing ubi_get_device in
> vol_attribute_show and dev_attribute_show.This avoids accessing
> uninitialized ubi_devices[ubi_num].
>
> ubi_get_device is used to prevent devices from being deleted during
> sysfs execution. However, now kernfs ensures that devices will not
> be deleted before all reference counting are released.
> The key process is shown in the following stack.
>
> device_del
>    device_remove_attrs
>      device_remove_groups
>        sysfs_remove_groups
>          sysfs_remove_group
>            remove_files
>              kernfs_remove_by_name
>                kernfs_remove_by_name_ns
>                  __kernfs_remove
>                    kernfs_drain
>
> Fixes: 714fb87e8bc0 ("ubi: Fix race condition between ubi device creation and udev")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Add race in uif_close
> V2->V3:
> 	Solution modified becase ubi_add_volume might sleepping in spin_lock.
>
>   drivers/mtd/ubi/build.c | 9 +--------
>   drivers/mtd/ubi/vmt.c   | 8 +-------
>   2 files changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index a7e3eb9befb6..a32050fecabf 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -351,9 +351,6 @@ static ssize_t dev_attribute_show(struct device *dev,
>   	 * we still can use 'ubi->ubi_num'.
>   	 */
>   	ubi = container_of(dev, struct ubi_device, dev);
> -	ubi = ubi_get_device(ubi->ubi_num);
> -	if (!ubi)
> -		return -ENODEV;
>   
>   	if (attr == &dev_eraseblock_size)
>   		ret = sprintf(buf, "%d\n", ubi->leb_size);
> @@ -382,7 +379,6 @@ static ssize_t dev_attribute_show(struct device *dev,
>   	else
>   		ret = -EINVAL;
>   
> -	ubi_put_device(ubi);
>   	return ret;
>   }
>   
> @@ -979,9 +975,6 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
>   			goto out_detach;
>   	}
>   
> -	/* Make device "available" before it becomes accessible via sysfs */
> -	ubi_devices[ubi_num] = ubi;
> -
>   	err = uif_init(ubi);
>   	if (err)
>   		goto out_detach;
> @@ -1026,6 +1019,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
>   	wake_up_process(ubi->bgt_thread);
>   	spin_unlock(&ubi->wl_lock);
>   
> +	ubi_devices[ubi_num] = ubi;
>   	ubi_notify_all(ubi, UBI_VOLUME_ADDED, NULL);
>   	return ubi_num;
>   
> @@ -1034,7 +1028,6 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
>   out_uif:
>   	uif_close(ubi);
>   out_detach:
> -	ubi_devices[ubi_num] = NULL;
>   	ubi_wl_close(ubi);
>   	ubi_free_all_volumes(ubi);
>   	vfree(ubi->vtbl);
> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> index 139ee132bfbc..1bc7b3a05604 100644
> --- a/drivers/mtd/ubi/vmt.c
> +++ b/drivers/mtd/ubi/vmt.c
> @@ -56,16 +56,11 @@ static ssize_t vol_attribute_show(struct device *dev,
>   {
>   	int ret;
>   	struct ubi_volume *vol = container_of(dev, struct ubi_volume, dev);
> -	struct ubi_device *ubi;
> -
> -	ubi = ubi_get_device(vol->ubi->ubi_num);
> -	if (!ubi)
> -		return -ENODEV;
> +	struct ubi_device *ubi = vol->ubi;
>   
>   	spin_lock(&ubi->volumes_lock);
>   	if (!ubi->volumes[vol->vol_id]) {
>   		spin_unlock(&ubi->volumes_lock);
> -		ubi_put_device(ubi);
>   		return -ENODEV;
>   	}
>   	/* Take a reference to prevent volume removal */
> @@ -103,7 +98,6 @@ static ssize_t vol_attribute_show(struct device *dev,
>   	vol->ref_count -= 1;
>   	ubi_assert(vol->ref_count >= 0);
>   	spin_unlock(&ubi->volumes_lock);
> -	ubi_put_device(ubi);
>   	return ret;
>   }
>   


