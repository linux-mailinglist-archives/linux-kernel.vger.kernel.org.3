Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AB55629D1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 05:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiGADtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 23:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiGADs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 23:48:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEBF65D74
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 20:48:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 128so1250766pfv.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 20:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=moDrQDciiD9zvGpAvAvRu8+57Oada2iCKxbwjOQrpi0=;
        b=yOpvXYiPN8Vj0CBxMyk71T1T0K2ZeNuEFa4bUEXZiDdRtO7/KTr/w4NsKnSwrz4+Cy
         eKsenOc6SbkjxWMsV7uoaogkh+r56JSdRcVB8kpc5w9dl1qMLUzNzhhCPwcti3QXzlBJ
         svHktb37/GesFbHHjthzbtI90ETY+WTTvcGTKuc/E0jirNsJRr2pCucyjw01iUrpIpWX
         jRIEIrlDbf6n2/vxYguLivxC5tRC7LOpQ68S4j8lRGtVbdYfI9ovePowDguCLqWgvHn/
         Cqy4ir3gQY7jkVHxdOZQZVeD1IixQqPuBewO8DXk0qLl6lwuatWJUCsDiKYaPW9ZXZ6B
         lbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=moDrQDciiD9zvGpAvAvRu8+57Oada2iCKxbwjOQrpi0=;
        b=MewESswj2/LSeq8mSmiPM7bmVTTLLAE4T9cMSZ9fP3SLh4lOg3g3nSdn5aTyJ7AziF
         IrPB7BC99qn+BSAmIfid7a3lFHtlGMtfZJZNfgqSh5+/7dV/NYm0Q9BXUGDySOha5YFf
         ksj4F+kNLw0aHWEyASVHWhCpe7z68hK9MThATrqIZs35BzyF0LN4n+MvTjg5dNWzWrQo
         zGeF7yzirertWfdKrFhfJnqdmjdB32XlxtUnN0MxGkqYkSzYw1Vasv6Qa1n7ogu4q0cJ
         jrG3I5bDMWo4dPAOcaouc0OTaNn6VGjNAXgKJeDMesVG+K+7lEhR11GGo3wCRg5TUZkz
         mtVA==
X-Gm-Message-State: AJIora/T2hIJFzzN3zu6HJcj77J23Oaar1XQx5lO7ixhsIJPJBtLEXd7
        MdL7YSC1yILIOoLun/oVSDnuAw==
X-Google-Smtp-Source: AGRyM1vo+Ino1U9gP0DFoIhUc0PxtTC0RrhDr8Q7jlwB60+d35aT1dw2ZgCS3pcQXlf0U4fx9s6j/Q==
X-Received: by 2002:a63:1566:0:b0:405:3aa3:23de with SMTP id 38-20020a631566000000b004053aa323demr10377420pgv.528.1656647337397;
        Thu, 30 Jun 2022 20:48:57 -0700 (PDT)
Received: from localhost.localdomain ([199.101.192.109])
        by smtp.gmail.com with ESMTPSA id p66-20020a625b45000000b0051b9ecb53e6sm14344328pfb.105.2022.06.30.20.48.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 20:48:57 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jean-philippe <jean-philippe@linaro.org>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     acc@openeuler.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        Yang Shen <shenyang39@huawei.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v3] uacce: Handle parent device removal or parent driver module rmmod
Date:   Fri,  1 Jul 2022 11:48:43 +0800
Message-Id: <20220701034843.7502-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The uacce driver must deal with a possible removal of the parent device
or parent driver module rmmod at any time.

Although uacce_remove(), called on device removal and on driver unbind,
prevents future use of the uacce fops by removing the cdev, fops that
were called before that point may still be running.

Serialize uacce_fops_open() and uacce_remove() with uacce->mutex.
Serialize other fops against uacce_remove() with q->mutex.
Since we need to protect uacce_fops_poll() which gets called on the fast
path, replace uacce->queues_lock with q->mutex to improve scalability.
The other fops are only used during setup.

uacce_queue_is_valid(), checked under q->mutex or uacce->mutex, denotes
whether uacce_remove() has disabled all queues. If that is the case,
don't go any further since the parent device is being removed and
uacce->ops should not be called anymore.

Reported-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---

v3: 
Drop patch 1, which set cdev owner with parent driver onwer, to block
parent driver rmmod.
Suggested from Greg, this behavior introduce layering violation.

Only keep patch 2, which can cover both parent moduel rmmod and
parent device removal.

 drivers/misc/uacce/uacce.c | 133 ++++++++++++++++++++++++-------------
 include/linux/uacce.h      |   6 +-
 2 files changed, 91 insertions(+), 48 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 281c54003edc..b70a013139c7 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -9,43 +9,38 @@
 
 static struct class *uacce_class;
 static dev_t uacce_devt;
-static DEFINE_MUTEX(uacce_mutex);
 static DEFINE_XARRAY_ALLOC(uacce_xa);
 
-static int uacce_start_queue(struct uacce_queue *q)
+/*
+ * If the parent driver or the device disappears, the queue state is invalid and
+ * ops are not usable anymore.
+ */
+static bool uacce_queue_is_valid(struct uacce_queue *q)
 {
-	int ret = 0;
+	return q->state == UACCE_Q_INIT || q->state == UACCE_Q_STARTED;
+}
 
-	mutex_lock(&uacce_mutex);
+static int uacce_start_queue(struct uacce_queue *q)
+{
+	int ret;
 
-	if (q->state != UACCE_Q_INIT) {
-		ret = -EINVAL;
-		goto out_with_lock;
-	}
+	if (q->state != UACCE_Q_INIT)
+		return -EINVAL;
 
 	if (q->uacce->ops->start_queue) {
 		ret = q->uacce->ops->start_queue(q);
 		if (ret < 0)
-			goto out_with_lock;
+			return ret;
 	}
 
 	q->state = UACCE_Q_STARTED;
-
-out_with_lock:
-	mutex_unlock(&uacce_mutex);
-
-	return ret;
+	return 0;
 }
 
 static int uacce_put_queue(struct uacce_queue *q)
 {
 	struct uacce_device *uacce = q->uacce;
 
-	mutex_lock(&uacce_mutex);
-
-	if (q->state == UACCE_Q_ZOMBIE)
-		goto out;
-
 	if ((q->state == UACCE_Q_STARTED) && uacce->ops->stop_queue)
 		uacce->ops->stop_queue(q);
 
@@ -54,8 +49,6 @@ static int uacce_put_queue(struct uacce_queue *q)
 		uacce->ops->put_queue(q);
 
 	q->state = UACCE_Q_ZOMBIE;
-out:
-	mutex_unlock(&uacce_mutex);
 
 	return 0;
 }
@@ -65,20 +58,36 @@ static long uacce_fops_unl_ioctl(struct file *filep,
 {
 	struct uacce_queue *q = filep->private_data;
 	struct uacce_device *uacce = q->uacce;
+	long ret = -ENXIO;
+
+	/*
+	 * uacce->ops->ioctl() may take the mmap_lock when copying arg to/from
+	 * user. Avoid a circular lock dependency with uacce_fops_mmap(), which
+	 * gets called with mmap_lock held, by taking uacce->mutex instead of
+	 * q->mutex. Doing this in uacce_fops_mmap() is not possible because
+	 * uacce_fops_open() calls iommu_sva_bind_device(), which takes
+	 * mmap_lock, while holding uacce->mutex.
+	 */
+	mutex_lock(&uacce->mutex);
+	if (!uacce_queue_is_valid(q))
+		goto out_unlock;
 
 	switch (cmd) {
 	case UACCE_CMD_START_Q:
-		return uacce_start_queue(q);
-
+		ret = uacce_start_queue(q);
+		break;
 	case UACCE_CMD_PUT_Q:
-		return uacce_put_queue(q);
-
+		ret = uacce_put_queue(q);
+		break;
 	default:
-		if (!uacce->ops->ioctl)
-			return -EINVAL;
-
-		return uacce->ops->ioctl(q, cmd, arg);
+		if (uacce->ops->ioctl)
+			ret = uacce->ops->ioctl(q, cmd, arg);
+		else
+			ret = -EINVAL;
 	}
+out_unlock:
+	mutex_unlock(&uacce->mutex);
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT
@@ -136,6 +145,13 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 	if (!q)
 		return -ENOMEM;
 
+	mutex_lock(&uacce->mutex);
+
+	if (!uacce->parent) {
+		ret = -EINVAL;
+		goto out_with_mem;
+	}
+
 	ret = uacce_bind_queue(uacce, q);
 	if (ret)
 		goto out_with_mem;
@@ -152,10 +168,9 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 	filep->private_data = q;
 	uacce->inode = inode;
 	q->state = UACCE_Q_INIT;
-
-	mutex_lock(&uacce->queues_lock);
+	mutex_init(&q->mutex);
 	list_add(&q->list, &uacce->queues);
-	mutex_unlock(&uacce->queues_lock);
+	mutex_unlock(&uacce->mutex);
 
 	return 0;
 
@@ -163,18 +178,20 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 	uacce_unbind_queue(q);
 out_with_mem:
 	kfree(q);
+	mutex_unlock(&uacce->mutex);
 	return ret;
 }
 
 static int uacce_fops_release(struct inode *inode, struct file *filep)
 {
 	struct uacce_queue *q = filep->private_data;
+	struct uacce_device *uacce = q->uacce;
 
-	mutex_lock(&q->uacce->queues_lock);
-	list_del(&q->list);
-	mutex_unlock(&q->uacce->queues_lock);
+	mutex_lock(&uacce->mutex);
 	uacce_put_queue(q);
 	uacce_unbind_queue(q);
+	list_del(&q->list);
+	mutex_unlock(&uacce->mutex);
 	kfree(q);
 
 	return 0;
@@ -217,10 +234,9 @@ static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 	vma->vm_private_data = q;
 	qfr->type = type;
 
-	mutex_lock(&uacce_mutex);
-
-	if (q->state != UACCE_Q_INIT && q->state != UACCE_Q_STARTED) {
-		ret = -EINVAL;
+	mutex_lock(&q->mutex);
+	if (!uacce_queue_is_valid(q)) {
+		ret = -ENXIO;
 		goto out_with_lock;
 	}
 
@@ -248,12 +264,12 @@ static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 	}
 
 	q->qfrs[type] = qfr;
-	mutex_unlock(&uacce_mutex);
+	mutex_unlock(&q->mutex);
 
 	return ret;
 
 out_with_lock:
-	mutex_unlock(&uacce_mutex);
+	mutex_unlock(&q->mutex);
 	kfree(qfr);
 	return ret;
 }
@@ -262,12 +278,20 @@ static __poll_t uacce_fops_poll(struct file *file, poll_table *wait)
 {
 	struct uacce_queue *q = file->private_data;
 	struct uacce_device *uacce = q->uacce;
+	__poll_t ret = 0;
+
+	mutex_lock(&q->mutex);
+	if (!uacce_queue_is_valid(q))
+		goto out_unlock;
 
 	poll_wait(file, &q->wait, wait);
+
 	if (uacce->ops->is_q_updated && uacce->ops->is_q_updated(q))
-		return EPOLLIN | EPOLLRDNORM;
+		ret = EPOLLIN | EPOLLRDNORM;
 
-	return 0;
+out_unlock:
+	mutex_unlock(&q->mutex);
+	return ret;
 }
 
 static const struct file_operations uacce_fops = {
@@ -450,7 +474,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
 		goto err_with_uacce;
 
 	INIT_LIST_HEAD(&uacce->queues);
-	mutex_init(&uacce->queues_lock);
+	mutex_init(&uacce->mutex);
 	device_initialize(&uacce->dev);
 	uacce->dev.devt = MKDEV(MAJOR(uacce_devt), uacce->dev_id);
 	uacce->dev.class = uacce_class;
@@ -507,13 +531,23 @@ void uacce_remove(struct uacce_device *uacce)
 	if (uacce->inode)
 		unmap_mapping_range(uacce->inode->i_mapping, 0, 0, 1);
 
+	/*
+	 * uacce_fops_open() may be running concurrently, even after we remove
+	 * the cdev. Holding uacce->mutex ensures that open() does not obtain a
+	 * removed uacce device.
+	 */
+	mutex_lock(&uacce->mutex);
 	/* ensure no open queue remains */
-	mutex_lock(&uacce->queues_lock);
 	list_for_each_entry_safe(q, next_q, &uacce->queues, list) {
+		/*
+		 * Taking q->mutex ensures that fops do not use the defunct
+		 * uacce->ops after the queue is disabled.
+		 */
+		mutex_lock(&q->mutex);
 		uacce_put_queue(q);
+		mutex_unlock(&q->mutex);
 		uacce_unbind_queue(q);
 	}
-	mutex_unlock(&uacce->queues_lock);
 
 	/* disable sva now since no opened queues */
 	uacce_disable_sva(uacce);
@@ -521,6 +555,13 @@ void uacce_remove(struct uacce_device *uacce)
 	if (uacce->cdev)
 		cdev_device_del(uacce->cdev, &uacce->dev);
 	xa_erase(&uacce_xa, uacce->dev_id);
+	/*
+	 * uacce exists as long as there are open fds, but ops will be freed
+	 * now. Ensure that bugs cause NULL deref rather than use-after-free.
+	 */
+	uacce->ops = NULL;
+	uacce->parent = NULL;
+	mutex_unlock(&uacce->mutex);
 	put_device(&uacce->dev);
 }
 EXPORT_SYMBOL_GPL(uacce_remove);
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 48e319f40275..9ce88c28b0a8 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -70,6 +70,7 @@ enum uacce_q_state {
  * @wait: wait queue head
  * @list: index into uacce queues list
  * @qfrs: pointer of qfr regions
+ * @mutex: protects queue state
  * @state: queue state machine
  * @pasid: pasid associated to the mm
  * @handle: iommu_sva handle returned by iommu_sva_bind_device()
@@ -80,6 +81,7 @@ struct uacce_queue {
 	wait_queue_head_t wait;
 	struct list_head list;
 	struct uacce_qfile_region *qfrs[UACCE_MAX_REGION];
+	struct mutex mutex;
 	enum uacce_q_state state;
 	u32 pasid;
 	struct iommu_sva *handle;
@@ -97,9 +99,9 @@ struct uacce_queue {
  * @dev_id: id of the uacce device
  * @cdev: cdev of the uacce
  * @dev: dev of the uacce
+ * @mutex: protects uacce operation
  * @priv: private pointer of the uacce
  * @queues: list of queues
- * @queues_lock: lock for queues list
  * @inode: core vfs
  */
 struct uacce_device {
@@ -113,9 +115,9 @@ struct uacce_device {
 	u32 dev_id;
 	struct cdev *cdev;
 	struct device dev;
+	struct mutex mutex;
 	void *priv;
 	struct list_head queues;
-	struct mutex queues_lock;
 	struct inode *inode;
 };
 
-- 
2.36.1

