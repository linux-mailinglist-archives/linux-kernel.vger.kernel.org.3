Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECAB54B177
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbiFNMj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357749AbiFNMjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:39:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A614B411;
        Tue, 14 Jun 2022 05:37:01 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LMnvR6TFFzjY3m;
        Tue, 14 Jun 2022 20:34:59 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 20:36:04 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 14 Jun
 2022 20:36:03 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH 1/3] uacce: supports device isolation feature
Date:   Tue, 14 Jun 2022 20:29:41 +0800
Message-ID: <20220614122943.1406-5-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220614122943.1406-1-yekai13@huawei.com>
References: <20220614122943.1406-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UACCE add the hardware error isolation API. Users can configure
the error frequency threshold by this vfs node. This API interface
certainly supports the configuration of user protocol strategy. Then
parse it inside the device driver. UACCE only reports the device
isolate state. When the error frequency is exceeded, the device
will be isolated. The isolation strategy should be defined in each
driver module.

Signed-off-by: Kai Ye <yekai13@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/misc/uacce/uacce.c | 51 ++++++++++++++++++++++++++++++++++++++
 include/linux/uacce.h      | 15 ++++++++++-
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index b6219c6bfb48..4d9d9aeb145a 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -12,6 +12,20 @@ static dev_t uacce_devt;
 static DEFINE_MUTEX(uacce_mutex);
 static DEFINE_XARRAY_ALLOC(uacce_xa);
 
+static int cdev_get(struct device *dev, void *data)
+{
+	struct uacce_device *uacce;
+	struct device **t_dev = data;
+
+	uacce = container_of(dev, struct uacce_device, dev);
+	if (uacce->parent == *t_dev) {
+		*t_dev = dev;
+		return 1;
+	}
+
+	return 0;
+}
+
 static int uacce_start_queue(struct uacce_queue *q)
 {
 	int ret = 0;
@@ -346,12 +360,47 @@ static ssize_t region_dus_size_show(struct device *dev,
 		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
 }
 
+static ssize_t isolate_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+
+	return sysfs_emit(buf, "%d\n", uacce->ops->get_isolate_state(uacce));
+}
+
+static ssize_t isolate_strategy_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+
+	return sysfs_emit(buf, "%s\n", uacce->isolate_strategy);
+}
+
+static ssize_t isolate_strategy_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+	int ret;
+
+	if (!buf || sizeof(buf) > UACCE_MAX_ISOLATE_STRATEGY_LEN)
+		return -EINVAL;
+
+	memcpy(uacce->isolate_strategy, buf, strlen(buf));
+
+	ret = uacce->ops->isolate_strategy_write(uacce, buf);
+
+	return ret > 0 ? count : ret;
+}
+
 static DEVICE_ATTR_RO(api);
 static DEVICE_ATTR_RO(flags);
 static DEVICE_ATTR_RO(available_instances);
 static DEVICE_ATTR_RO(algorithms);
 static DEVICE_ATTR_RO(region_mmio_size);
 static DEVICE_ATTR_RO(region_dus_size);
+static DEVICE_ATTR_RO(isolate);
+static DEVICE_ATTR_RW(isolate_strategy);
 
 static struct attribute *uacce_dev_attrs[] = {
 	&dev_attr_api.attr,
@@ -360,6 +409,8 @@ static struct attribute *uacce_dev_attrs[] = {
 	&dev_attr_algorithms.attr,
 	&dev_attr_region_mmio_size.attr,
 	&dev_attr_region_dus_size.attr,
+	&dev_attr_isolate.attr,
+	&dev_attr_isolate_strategy.attr,
 	NULL,
 };
 
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 48e319f40275..e00a43a07e4b 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -8,6 +8,7 @@
 #define UACCE_NAME		"uacce"
 #define UACCE_MAX_REGION	2
 #define UACCE_MAX_NAME_SIZE	64
+#define UACCE_MAX_ISOLATE_STRATEGY_LEN	256
 
 struct uacce_queue;
 struct uacce_device;
@@ -30,6 +31,8 @@ struct uacce_qfile_region {
  * @is_q_updated: check whether the task is finished
  * @mmap: mmap addresses of queue to user space
  * @ioctl: ioctl for user space users of the queue
+ * @get_isolate_state: get the device state after set the isolate strategy
+ * @isolate_strategy_store: stored the isolate strategy to the device
  */
 struct uacce_ops {
 	int (*get_available_instances)(struct uacce_device *uacce);
@@ -43,6 +46,8 @@ struct uacce_ops {
 		    struct uacce_qfile_region *qfr);
 	long (*ioctl)(struct uacce_queue *q, unsigned int cmd,
 		      unsigned long arg);
+	enum uacce_dev_state (*get_isolate_state)(struct uacce_device *uacce);
+	int (*isolate_strategy_write)(struct uacce_device *uacce, const char *buf);
 };
 
 /**
@@ -57,6 +62,12 @@ struct uacce_interface {
 	const struct uacce_ops *ops;
 };
 
+enum uacce_dev_state {
+	UACCE_DEV_ERR = -1,
+	UACCE_DEV_NORMAL,
+	UACCE_DEV_ISOLATE,
+};
+
 enum uacce_q_state {
 	UACCE_Q_ZOMBIE = 0,
 	UACCE_Q_INIT,
@@ -99,6 +110,7 @@ struct uacce_queue {
  * @dev: dev of the uacce
  * @priv: private pointer of the uacce
  * @queues: list of queues
+ * @ref: reference of the uacce
  * @queues_lock: lock for queues list
  * @inode: core vfs
  */
@@ -117,6 +129,7 @@ struct uacce_device {
 	struct list_head queues;
 	struct mutex queues_lock;
 	struct inode *inode;
+	char isolate_strategy[UACCE_MAX_ISOLATE_STRATEGY_LEN];
 };
 
 #if IS_ENABLED(CONFIG_UACCE)
@@ -125,7 +138,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
 				 struct uacce_interface *interface);
 int uacce_register(struct uacce_device *uacce);
 void uacce_remove(struct uacce_device *uacce);
-
+struct uacce_device *dev_to_uacce(struct device *dev);
 #else /* CONFIG_UACCE */
 
 static inline
-- 
2.33.0

