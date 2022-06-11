Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F80547295
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 09:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiFKHOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 03:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiFKHOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 03:14:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9266B18382
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 00:14:28 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LKptn5Y1Qz1K9DF;
        Sat, 11 Jun 2022 15:12:33 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 11 Jun 2022 15:14:26 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 11 Jun
 2022 15:14:26 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH 2/2] crypto: hisilicon/qm - defining the device isolation strategy
Date:   Sat, 11 Jun 2022 15:08:08 +0800
Message-ID: <20220611070808.49219-3-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220611070808.49219-1-yekai13@huawei.com>
References: <20220611070808.49219-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Define the device isolation strategy by the device driver. if the
AER error frequency exceeds the value of setting for a certain
period of time, The device will not be available in user space. The VF
device use the PF device isolation strategy. All the hardware errors
are processed by PF driver.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 149 +++++++++++++++++++++++++++++++---
 include/linux/hisi_acc_qm.h   |   8 ++
 2 files changed, 145 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index b4ca2eb034d7..73c12714a36b 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -12,7 +12,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-#include <linux/uacce.h>
 #include <linux/uaccess.h>
 #include <uapi/misc/uacce/hisi_qm.h>
 #include <linux/hisi_acc_qm.h>
@@ -417,6 +416,16 @@ struct hisi_qm_resource {
 	struct list_head list;
 };
 
+/**
+ * struct qm_hw_err - structure of describes the device err
+ * @list: hardware error list
+ * @tick_stamp: timestamp when the error occurred
+ */
+struct qm_hw_err {
+	struct list_head list;
+	unsigned long long tick_stamp;
+};
+
 struct hisi_qm_hw_ops {
 	int (*get_vft)(struct hisi_qm *qm, u32 *base, u32 *number);
 	void (*qm_db)(struct hisi_qm *qm, u16 qn,
@@ -3397,6 +3406,99 @@ static long hisi_qm_uacce_ioctl(struct uacce_queue *q, unsigned int cmd,
 	return 0;
 }
 
+/**
+ * qm_hw_err_isolate() - Try to isolate the uacce device with its VFs
+ * @qm: The qm which we want to configure.
+ *
+ * according to user's configuration of isolation strategy. Warning: this
+ * API should be called while there is no user on the device, or the users
+ * on this device are suspended by slot resetting preparation of PCI AER.
+ */
+static int qm_hw_err_isolate(struct hisi_qm *qm)
+{
+	struct qm_hw_err *err, *tmp, *hw_err;
+	struct qm_err_isolate *isolate;
+	u32 count = 0;
+
+	isolate = &qm->isolate_data;
+
+#define SECONDS_PER_HOUR	3600
+
+	/* All the hw errs are processed by PF driver */
+	if (qm->uacce->is_vf || atomic_read(&isolate->is_isolate) ||
+		!isolate->hw_err_isolate_hz)
+		return 0;
+
+	hw_err = kzalloc(sizeof(*hw_err), GFP_ATOMIC);
+	if (!hw_err)
+		return -ENOMEM;
+	hw_err->tick_stamp = jiffies;
+	list_for_each_entry_safe(err, tmp, &qm->uacce_hw_errs, list) {
+		if ((hw_err->tick_stamp - err->tick_stamp) / HZ >
+		    SECONDS_PER_HOUR) {
+			list_del(&err->list);
+			kfree(err);
+		} else {
+			count++;
+		}
+	}
+	list_add(&hw_err->list, &qm->uacce_hw_errs);
+
+	if (count >= isolate->hw_err_isolate_hz)
+		atomic_set(&isolate->is_isolate, 1);
+
+	return 0;
+}
+
+static void qm_hw_err_destroy(struct hisi_qm *qm)
+{
+	struct qm_hw_err *err, *tmp;
+
+	list_for_each_entry_safe(err, tmp, &qm->uacce_hw_errs, list) {
+		list_del(&err->list);
+		kfree(err);
+	}
+}
+
+static enum uacce_dev_state hisi_qm_get_isolate_state(struct uacce_device *uacce)
+{
+	struct hisi_qm *qm = uacce->priv;
+	struct hisi_qm *pf_qm;
+
+	if (uacce->is_vf) {
+		pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
+		qm->isolate_data.is_isolate = pf_qm->isolate_data.is_isolate;
+	}
+
+	return atomic_read(&qm->isolate_data.is_isolate) ?
+			UACCE_DEV_ISOLATE : UACCE_DEV_NORMAL;
+}
+
+static int hisi_qm_isolate_strategy_write(struct uacce_device *uacce,
+						const char *buf)
+{
+	struct hisi_qm *qm = uacce->priv;
+	unsigned long val = 0;
+
+#define MAX_ISOLATE_STRATEGY	65535
+
+	/* must be set by PF */
+	if (atomic_read(&qm->isolate_data.is_isolate) || uacce->is_vf)
+		return -EINVAL;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val > MAX_ISOLATE_STRATEGY)
+		return -EINVAL;
+
+	qm->isolate_data.hw_err_isolate_hz = val;
+	dev_info(&qm->pdev->dev,
+		"the value of isolate_strategy is set to %lu.\n", val);
+
+	return 0;
+}
+
 static const struct uacce_ops uacce_qm_ops = {
 	.get_available_instances = hisi_qm_get_available_instances,
 	.get_queue = hisi_qm_uacce_get_queue,
@@ -3405,9 +3507,22 @@ static const struct uacce_ops uacce_qm_ops = {
 	.stop_queue = hisi_qm_uacce_stop_queue,
 	.mmap = hisi_qm_uacce_mmap,
 	.ioctl = hisi_qm_uacce_ioctl,
+	.get_isolate_state = hisi_qm_get_isolate_state,
 	.is_q_updated = hisi_qm_is_q_updated,
+	.isolate_strategy_write = hisi_qm_isolate_strategy_write,
 };
 
+static void qm_remove_uacce(struct hisi_qm *qm)
+{
+	struct uacce_device *uacce = qm->uacce;
+
+	if (qm->use_sva) {
+		qm_hw_err_destroy(qm);
+		uacce_remove(uacce);
+		qm->uacce = NULL;
+	}
+}
+
 static int qm_alloc_uacce(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -3420,6 +3535,7 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 	};
 	int ret;
 
+	INIT_LIST_HEAD(&qm->uacce_hw_errs);
 	ret = strscpy(interface.name, dev_driver_string(&pdev->dev),
 		      sizeof(interface.name));
 	if (ret < 0)
@@ -3433,8 +3549,7 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 		qm->use_sva = true;
 	} else {
 		/* only consider sva case */
-		uacce_remove(uacce);
-		qm->uacce = NULL;
+		qm_remove_uacce(qm);
 		return -EINVAL;
 	}
 
@@ -5074,6 +5189,12 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 		return ret;
 	}
 
+	if (qm->use_sva) {
+		ret = qm_hw_err_isolate(qm);
+		if (ret)
+			pci_err(pdev, "failed to isolate hw err!\n");
+	}
+
 	ret = qm_wait_vf_prepare_finish(qm);
 	if (ret)
 		pci_err(pdev, "failed to stop by vfs in soft reset!\n");
@@ -5401,19 +5522,24 @@ static int qm_controller_reset(struct hisi_qm *qm)
 	ret = qm_soft_reset(qm);
 	if (ret) {
 		pci_err(pdev, "Controller reset failed (%d)\n", ret);
-		qm_reset_bit_clear(qm);
-		return ret;
+		goto err_reset;
 	}
 
 	ret = qm_controller_reset_done(qm);
-	if (ret) {
-		qm_reset_bit_clear(qm);
-		return ret;
-	}
+	if (ret)
+		goto err_reset;
 
 	pci_info(pdev, "Controller reset complete\n");
-
 	return 0;
+
+err_reset:
+	pci_err(pdev, "Controller reset failed (%d)\n", ret);
+	qm_reset_bit_clear(qm);
+
+	/* if resetting fails, isolate the device */
+	if (qm->use_sva && !qm->uacce->is_vf)
+		atomic_set(&qm->isolate_data.is_isolate, 1);
+	return ret;
 }
 
 /**
@@ -6186,8 +6312,7 @@ int hisi_qm_init(struct hisi_qm *qm)
 
 err_alloc_uacce:
 	if (qm->use_sva) {
-		uacce_remove(qm->uacce);
-		qm->uacce = NULL;
+		qm_remove_uacce(qm);
 	}
 err_irq_register:
 	qm_irq_unregister(qm);
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 6cabafffd0dd..757bb8df385e 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -8,6 +8,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/uacce.h>
 
 #define QM_QNUM_V1			4096
 #define QM_QNUM_V2			1024
@@ -265,6 +266,11 @@ struct hisi_qm_list {
 	void (*unregister_from_crypto)(struct hisi_qm *qm);
 };
 
+struct qm_err_isolate {
+	u32 hw_err_isolate_hz;	/* user cfg freq which triggers isolation */
+	atomic_t is_isolate;
+};
+
 struct hisi_qm {
 	enum qm_hw_ver ver;
 	enum qm_fun_type fun_type;
@@ -329,6 +335,8 @@ struct hisi_qm {
 	struct qm_shaper_factor *factor;
 	u32 mb_qos;
 	u32 type_rate;
+	struct list_head uacce_hw_errs;
+	struct qm_err_isolate isolate_data;
 };
 
 struct hisi_qp_status {
-- 
2.33.0

