Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4B051E5FB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 11:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383916AbiEGJXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 05:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiEGJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 05:23:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF3957155
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 02:19:47 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KwMMF6VyNzhYxG;
        Sat,  7 May 2022 17:19:21 +0800 (CST)
Received: from [10.174.179.0] (10.174.179.0) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 7 May
 2022 17:19:45 +0800
Message-ID: <e4e135fe-c3c0-19a6-67d8-23ac139627f6@huawei.com>
Date:   Sat, 7 May 2022 17:19:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To:     <linux-kernel@vger.kernel.org>
CC:     <suweifeng1@huawei.com>, <linfeilong@huawei.com>,
        <akpm@linux-foundation.org>
From:   "zhanghongtao (A)" <zhanghongtao22@huawei.com>
Subject: [PATCH] drivers/uio: Fix system crashes during driver switchover
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongtao Zhang <zhanghongtao22@huawei.com>

Switch the driver of the SPDK program that is being read and written from the uio_pci_generic driver to the NVMe driver
(Unbind the UIO driver from the device and bind the NVMe driver to the device.) ,
the system crashes and restarts, and the stacks of each crash are different.
Bug reproduction: When the SPDK is reading or writing data, run the following command: /opt/spdk/setup.sh reset
The one with a higher probability of occurrence is as follows:
PANIC: "BUG: unable to handle kernel NULL pointer dereference at 0000000000000008"
         PID: 0
     COMMAND: "swapper/3"
        TASK: ffff8bc3836f1e80  (1 of 8)  [THREAD_INFO: ffff8bc3836f1e80]
         CPU: 3
       STATE: TASK_RUNNING (PANIC)
PID: 0      TASK: ffff8bc3836f1e80  CPU: 3   COMMAND: "swapper/3"
 #0 [ffff8bca9ecc3c28] machine_kexec at ffffffff82e5e45b
 #1 [ffff8bca9ecc3c80] __crash_kexec at ffffffff82f64e42
 #2 [ffff8bca9ecc3d40] panic at ffffffff82ebab29
 #3 [ffff8bca9ecc3dc8] oops_end at ffffffff82e23940
 #4 [ffff8bca9ecc3de8] no_context at ffffffff82e71630
 #5 [ffff8bca9ecc3e40] do_page_fault at ffffffff82e72301
 #6 [ffff8bca9ecc3e70] async_page_fault at ffffffff8380125e
    [exception RIP: _raw_spin_lock_irqsave+30]
    RIP: ffffffff836a1cae  RSP: ffff8bca9ecc3f20  RFLAGS: 00010046
    RAX: 0000000000000000  RBX: 0000000000000246  RCX: 0000000000000017
    RDX: 0000000000000001  RSI: 0000000000000000  RDI: 0000000000000008
    RBP: 0000000000000000   R8: 000000afb34e50f9   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000000  R12: ffff8bca9ecc3f50
    R13: 0000000000000004  R14: 0000000000000004  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffff8bca9ecc3f28] complete at ffffffff82f09bb8
 #8 [ffff8bca9ecc3f48] blk_done_softirq at ffffffff832069d1
 #9 [ffff8bca9ecc3f80] __softirqentry_text_start at ffffffff83a000e8
#10 [ffff8bca9ecc3fe0] irq_exit at ffffffff82ec1119
#11 [ffff8bca9ecc3ff0] call_function_single_interrupt at ffffffff83801daf
--- <IRQ stack> ---
#12 [ffff9866c319be08] call_function_single_interrupt at ffffffff83801daf
    [exception RIP: native_safe_halt+14]
    RIP: ffffffff836a188e  RSP: ffff9866c319beb0  RFLAGS: 00000246
    RAX: ffffffff836a1580  RBX: 0000000000000003  RCX: 0000000000000000
    RDX: 0000000000000001  RSI: 0000000000000000  RDI: 0000000000000000
    RBP: 0000000000000003   R8: 000000afb3323415   R9: 0000000000000000
    R10: ffff9866c3173ce0  R11: 000000000000009d  R12: 0000000000000000
    R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000000
    ORIG_RAX: ffffffffffffff04  CS: 0010  SS: 0018
#13 [ffff9866c319beb0] default_idle at ffffffff836a159a
#14 [ffff9866c319bed0] do_idle at ffffffff82ef1d4a
#15 [ffff9866c319bf10] cpu_startup_entry at ffffffff82ef1fcf
#16 [ffff9866c319bf30] start_secondary at ffffffff82e52667
#17 [ffff9866c319bf50] secondary_startup_64 at ffffffff82e000e7

After the driver switchover, the upper-layer program can still access the bar space of the NVMe disk controller and knock the doorbell.
As a result, the interrupt process of the NVMe driver is abnormal and the system crashes.
To solve this problem, a reference counting is added to prevent unbind execution before the application is closed or exited.

Signed-off-by: Hongtao Zhang <zhanghongtao22@huawei.com>
Reviewed-by: Weifeng Su <suweifeng1@huawei.com>
---
 drivers/uio/uio.c          | 13 +++++++++++++
 include/linux/uio_driver.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 43afbb7c5ab9..cb8ed29a8648 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -31,6 +31,7 @@ static int uio_major;
 static struct cdev *uio_cdev;
 static DEFINE_IDR(uio_idr);
 static const struct file_operations uio_fops;
+static DECLARE_WAIT_QUEUE_HEAD(refc_wait);

 /* Protect idr accesses */
 static DEFINE_MUTEX(minor_lock);
@@ -501,6 +502,7 @@ static int uio_open(struct inode *inode, struct file *filep)
 	mutex_unlock(&idev->info_lock);
 	if (ret)
 		goto err_infoopen;
+	refcount_inc(&idev->dev_refc);

 	return 0;

@@ -536,6 +538,9 @@ static int uio_release(struct inode *inode, struct file *filep)
 		ret = idev->info->release(idev->info, inode);
 	mutex_unlock(&idev->info_lock);

+	if (refcount_dec_and_test(&idev->dev_refc))
+			wake_up(&refc_wait);
+
 	module_put(idev->owner);
 	kfree(listener);
 	put_device(&idev->dev);
@@ -937,6 +942,7 @@ int __uio_register_device(struct module *owner,

 	idev->owner = owner;
 	idev->info = info;
+	refcount_set(&idev->dev_refc, 0);
 	mutex_init(&idev->info_lock);
 	init_waitqueue_head(&idev->wait);
 	atomic_set(&idev->event, 0);
@@ -1045,6 +1051,7 @@ void uio_unregister_device(struct uio_info *info)
 {
 	struct uio_device *idev;
 	unsigned long minor;
+	unsigned int dref_count;

 	if (!info || !info->uio_dev)
 		return;
@@ -1052,6 +1059,12 @@ void uio_unregister_device(struct uio_info *info)
 	idev = info->uio_dev;
 	minor = idev->minor;

+	dref_count = refcount_read(&idev->dev_refc);
+	if (dref_count > 0) {
+		dev_err(&idev->dev, "The device is in use, please close the file descriptor or kill the occupied process\n");
+		wait_event(refc_wait, !refcount_read(&idev->dev_refc));
+	}
+
 	mutex_lock(&idev->info_lock);
 	uio_dev_del_attributes(idev);

diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 47c5962b876b..28301dcc4d31 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -77,6 +77,7 @@ struct uio_device {
 	struct mutex		info_lock;
 	struct kobject          *map_dir;
 	struct kobject          *portio_dir;
+	refcount_t				dev_refc;
 };

 /**
-- 
2.27.0

