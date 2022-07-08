Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EA256B345
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbiGHHPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiGHHPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:15:06 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC376EA2;
        Fri,  8 Jul 2022 00:15:04 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LfPcK52sqz1L8wn;
        Fri,  8 Jul 2022 15:12:33 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 15:15:01 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Jul
 2022 15:15:01 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v5 1/3] uacce: supports device isolation feature
Date:   Fri, 8 Jul 2022 15:08:18 +0800
Message-ID: <20220708070820.43958-2-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220708070820.43958-1-yekai13@huawei.com>
References: <20220708070820.43958-1-yekai13@huawei.com>
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

UACCE adds the hardware error isolation API. Users can configure
the isolation frequency by this sysfs node. UACCE reports the device
isolate state to the user space. If the AER error frequency exceeds
the value of setting for a certain period of time, the device will be
isolated.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/misc/uacce/uacce.c | 55 ++++++++++++++++++++++++++++++++++++++
 include/linux/uacce.h      | 11 ++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 281c54003edc..d07b5f1f0596 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -7,6 +7,8 @@
 #include <linux/slab.h>
 #include <linux/uacce.h>
 
+#define MAX_ERR_ISOLATE_COUNT		65535
+
 static struct class *uacce_class;
 static dev_t uacce_devt;
 static DEFINE_MUTEX(uacce_mutex);
@@ -339,12 +341,63 @@ static ssize_t region_dus_size_show(struct device *dev,
 		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
 }
 
+static ssize_t isolate_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+
+	if (!uacce->ops->get_isolate_state)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%d\n", uacce->ops->get_isolate_state(uacce));
+}
+
+static ssize_t isolate_strategy_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+	u32 val;
+
+	if (!uacce->ops->isolate_strategy_read)
+		return -ENODEV;
+
+	val = uacce->ops->isolate_strategy_read(uacce);
+	if (val > MAX_ERR_ISOLATE_COUNT)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t isolate_strategy_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+	unsigned long val;
+	int ret;
+
+	if (!uacce->ops->isolate_strategy_write)
+		return -ENODEV;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val > MAX_ERR_ISOLATE_COUNT)
+		return -EINVAL;
+
+	ret = uacce->ops->isolate_strategy_write(uacce, val);
+
+	return ret ? ret : count;
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
@@ -353,6 +406,8 @@ static struct attribute *uacce_dev_attrs[] = {
 	&dev_attr_algorithms.attr,
 	&dev_attr_region_mmio_size.attr,
 	&dev_attr_region_dus_size.attr,
+	&dev_attr_isolate.attr,
+	&dev_attr_isolate_strategy.attr,
 	NULL,
 };
 
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 48e319f40275..69e8f238d80c 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -30,6 +30,9 @@ struct uacce_qfile_region {
  * @is_q_updated: check whether the task is finished
  * @mmap: mmap addresses of queue to user space
  * @ioctl: ioctl for user space users of the queue
+ * @get_isolate_state: get the device state after set the isolate strategy
+ * @isolate_strategy_write: stored the isolate strategy to the device
+ * @isolate_strategy_read: read the isolate strategy value from the device
  */
 struct uacce_ops {
 	int (*get_available_instances)(struct uacce_device *uacce);
@@ -43,6 +46,9 @@ struct uacce_ops {
 		    struct uacce_qfile_region *qfr);
 	long (*ioctl)(struct uacce_queue *q, unsigned int cmd,
 		      unsigned long arg);
+	enum uacce_dev_state (*get_isolate_state)(struct uacce_device *uacce);
+	int (*isolate_strategy_write)(struct uacce_device *uacce, u32 freq);
+	u32 (*isolate_strategy_read)(struct uacce_device *uacce);
 };
 
 /**
@@ -57,6 +63,11 @@ struct uacce_interface {
 	const struct uacce_ops *ops;
 };
 
+enum uacce_dev_state {
+	UACCE_DEV_NORMAL,
+	UACCE_DEV_ISOLATE,
+};
+
 enum uacce_q_state {
 	UACCE_Q_ZOMBIE = 0,
 	UACCE_Q_INIT,
-- 
2.33.0

