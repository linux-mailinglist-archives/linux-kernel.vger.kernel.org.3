Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A399D527C29
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiEPC5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiEPC5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:57:21 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDF31B1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:57:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VDCe1px_1652669831;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VDCe1px_1652669831)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 May 2022 10:57:14 +0800
From:   Guixin Liu <kanie@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] uio: replace mutex info_lock with percpu_ref
Date:   Mon, 16 May 2022 10:57:11 +0800
Message-Id: <1652669831-104542-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the underlying driver works in parallel, the mutex info_lock in uio
will force driver to work sequentially, so that become performance
bottleneck. Lets replace it with percpu_ref for better performance.

Use tcm_loop and tcmu(backstore is file, and I did some work to make tcmu
work in parallel at uio_write() path) to evaluate performance,
fio job: fio -filename=/dev/sdb  -direct=1 -size=2G -name=1 -thread
-runtime=60 -time_based  -rw=randread -numjobs=16 -iodepth=16 -bs=128k

Without this patch:
	READ: bw=2828MiB/s (2965MB/s), 176MiB/s-177MiB/s (185MB/s-186MB/s),
io=166GiB (178GB), run=60000-60001msec

With this patch:
	READ: bw=3382MiB/s (3546MB/s), 211MiB/s-212MiB/s (221MB/s-222MB/s),
io=198GiB (213GB), run=60001-60001msec

Reviewed-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/uio/uio.c          | 97 ++++++++++++++++++++++++++++++++++------------
 include/linux/uio_driver.h |  5 ++-
 2 files changed, 76 insertions(+), 26 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 43afbb7..5e7989f 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -24,6 +24,8 @@
 #include <linux/kobject.h>
 #include <linux/cdev.h>
 #include <linux/uio_driver.h>
+#include <linux/completion.h>
+#include <linux/percpu-refcount.h>
 
 #define UIO_MAX_DEVICES		(1U << MINORBITS)
 
@@ -218,7 +220,9 @@ static ssize_t name_show(struct device *dev,
 	struct uio_device *idev = dev_get_drvdata(dev);
 	int ret;
 
-	mutex_lock(&idev->info_lock);
+	if (!percpu_ref_tryget_live(&idev->info_ref))
+		return -EINVAL;
+
 	if (!idev->info) {
 		ret = -EINVAL;
 		dev_err(dev, "the device has been unregistered\n");
@@ -228,7 +232,7 @@ static ssize_t name_show(struct device *dev,
 	ret = sprintf(buf, "%s\n", idev->info->name);
 
 out:
-	mutex_unlock(&idev->info_lock);
+	percpu_ref_put(&idev->info_ref);
 	return ret;
 }
 static DEVICE_ATTR_RO(name);
@@ -239,7 +243,9 @@ static ssize_t version_show(struct device *dev,
 	struct uio_device *idev = dev_get_drvdata(dev);
 	int ret;
 
-	mutex_lock(&idev->info_lock);
+	if (!percpu_ref_tryget_live(&idev->info_ref))
+		return -EINVAL;
+
 	if (!idev->info) {
 		ret = -EINVAL;
 		dev_err(dev, "the device has been unregistered\n");
@@ -249,7 +255,7 @@ static ssize_t version_show(struct device *dev,
 	ret = sprintf(buf, "%s\n", idev->info->version);
 
 out:
-	mutex_unlock(&idev->info_lock);
+	percpu_ref_put(&idev->info_ref);
 	return ret;
 }
 static DEVICE_ATTR_RO(version);
@@ -489,16 +495,20 @@ static int uio_open(struct inode *inode, struct file *filep)
 	listener->event_count = atomic_read(&idev->event);
 	filep->private_data = listener;
 
-	mutex_lock(&idev->info_lock);
+	if (!percpu_ref_tryget_live(&idev->info_ref)) {
+		ret = -EINVAL;
+		goto err_alloc_listener;
+	}
+
 	if (!idev->info) {
-		mutex_unlock(&idev->info_lock);
+		percpu_ref_put(&idev->info_ref);
 		ret = -EINVAL;
 		goto err_infoopen;
 	}
 
 	if (idev->info->open)
 		ret = idev->info->open(idev->info, inode);
-	mutex_unlock(&idev->info_lock);
+	percpu_ref_put(&idev->info_ref);
 	if (ret)
 		goto err_infoopen;
 
@@ -531,10 +541,12 @@ static int uio_release(struct inode *inode, struct file *filep)
 	struct uio_listener *listener = filep->private_data;
 	struct uio_device *idev = listener->dev;
 
-	mutex_lock(&idev->info_lock);
+	if (!percpu_ref_tryget_live(&idev->info_ref))
+		return -EINVAL;
+
 	if (idev->info && idev->info->release)
 		ret = idev->info->release(idev->info, inode);
-	mutex_unlock(&idev->info_lock);
+	percpu_ref_put(&idev->info_ref);
 
 	module_put(idev->owner);
 	kfree(listener);
@@ -548,10 +560,12 @@ static __poll_t uio_poll(struct file *filep, poll_table *wait)
 	struct uio_device *idev = listener->dev;
 	__poll_t ret = 0;
 
-	mutex_lock(&idev->info_lock);
+	if (!percpu_ref_tryget_live(&idev->info_ref))
+		return EPOLLERR;
+
 	if (!idev->info || !idev->info->irq)
-		ret = -EIO;
-	mutex_unlock(&idev->info_lock);
+		ret = EPOLLERR;
+	percpu_ref_put(&idev->info_ref);
 
 	if (ret)
 		return ret;
@@ -577,13 +591,17 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
 	add_wait_queue(&idev->wait, &wait);
 
 	do {
-		mutex_lock(&idev->info_lock);
+		if (!percpu_ref_tryget_live(&idev->info_ref)) {
+			retval = -EINVAL;
+			break;
+		}
+
 		if (!idev->info || !idev->info->irq) {
 			retval = -EIO;
-			mutex_unlock(&idev->info_lock);
+			percpu_ref_put(&idev->info_ref);
 			break;
 		}
-		mutex_unlock(&idev->info_lock);
+		percpu_ref_put(&idev->info_ref);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
@@ -631,7 +649,9 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
 	if (copy_from_user(&irq_on, buf, count))
 		return -EFAULT;
 
-	mutex_lock(&idev->info_lock);
+	if (!percpu_ref_tryget_live(&idev->info_ref))
+		return -EINVAL;
+
 	if (!idev->info) {
 		retval = -EINVAL;
 		goto out;
@@ -650,7 +670,7 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
 	retval = idev->info->irqcontrol(idev->info, irq_on);
 
 out:
-	mutex_unlock(&idev->info_lock);
+	percpu_ref_put(&idev->info_ref);
 	return retval ? retval : sizeof(s32);
 }
 
@@ -675,7 +695,9 @@ static vm_fault_t uio_vma_fault(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	int mi;
 
-	mutex_lock(&idev->info_lock);
+	if (!percpu_ref_tryget_live(&idev->info_ref))
+		return VM_FAULT_SIGBUS;
+
 	if (!idev->info) {
 		ret = VM_FAULT_SIGBUS;
 		goto out;
@@ -702,8 +724,7 @@ static vm_fault_t uio_vma_fault(struct vm_fault *vmf)
 	vmf->page = page;
 
 out:
-	mutex_unlock(&idev->info_lock);
-
+	percpu_ref_put(&idev->info_ref);
 	return ret;
 }
 
@@ -772,7 +793,9 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 
 	vma->vm_private_data = idev;
 
-	mutex_lock(&idev->info_lock);
+	if (!percpu_ref_tryget_live(&idev->info_ref))
+		return -EINVAL;
+
 	if (!idev->info) {
 		ret = -EINVAL;
 		goto out;
@@ -811,7 +834,7 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 	}
 
  out:
-	mutex_unlock(&idev->info_lock);
+	percpu_ref_put(&idev->info_ref);
 	return ret;
 }
 
@@ -907,6 +930,13 @@ static void uio_device_release(struct device *dev)
 	kfree(idev);
 }
 
+static void uio_info_free(struct percpu_ref *ref)
+{
+	struct uio_device *idev = container_of(ref, struct uio_device, info_ref);
+
+	complete(&idev->free_done);
+}
+
 /**
  * __uio_register_device - register a new userspace IO device
  * @owner:	module that creates the new device
@@ -937,10 +967,17 @@ int __uio_register_device(struct module *owner,
 
 	idev->owner = owner;
 	idev->info = info;
-	mutex_init(&idev->info_lock);
 	init_waitqueue_head(&idev->wait);
 	atomic_set(&idev->event, 0);
 
+	ret = percpu_ref_init(&idev->info_ref, uio_info_free, 0, GFP_KERNEL);
+	if (ret) {
+		pr_err("percpu_ref init failed!\n");
+		return ret;
+	}
+	init_completion(&idev->confirm_done);
+	init_completion(&idev->free_done);
+
 	ret = uio_get_minor(idev);
 	if (ret) {
 		kfree(idev);
@@ -1036,6 +1073,13 @@ int __devm_uio_register_device(struct module *owner,
 }
 EXPORT_SYMBOL_GPL(__devm_uio_register_device);
 
+static void uio_confirm_info(struct percpu_ref *ref)
+{
+	struct uio_device *idev = container_of(ref, struct uio_device, info_ref);
+
+	complete(&idev->confirm_done);
+}
+
 /**
  * uio_unregister_device - unregister a industrial IO device
  * @info:	UIO device capabilities
@@ -1052,14 +1096,17 @@ void uio_unregister_device(struct uio_info *info)
 	idev = info->uio_dev;
 	minor = idev->minor;
 
-	mutex_lock(&idev->info_lock);
+	percpu_ref_kill_and_confirm(&idev->info_ref, uio_confirm_info);
+	wait_for_completion(&idev->confirm_done);
+	wait_for_completion(&idev->free_done);
+
+	/* now, we can set info to NULL */
 	uio_dev_del_attributes(idev);
 
 	if (info->irq && info->irq != UIO_IRQ_CUSTOM)
 		free_irq(info->irq, idev);
 
 	idev->info = NULL;
-	mutex_unlock(&idev->info_lock);
 
 	wake_up_interruptible(&idev->wait);
 	kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 47c5962..6d3d87f 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
+#include <linux/percpu-refcount.h>
 
 struct module;
 struct uio_map;
@@ -74,9 +75,11 @@ struct uio_device {
 	struct fasync_struct    *async_queue;
 	wait_queue_head_t       wait;
 	struct uio_info         *info;
-	struct mutex		info_lock;
 	struct kobject          *map_dir;
 	struct kobject          *portio_dir;
+	struct percpu_ref       info_ref;
+	struct completion       confirm_done;
+	struct completion       free_done;
 };
 
 /**
-- 
1.8.3.1

