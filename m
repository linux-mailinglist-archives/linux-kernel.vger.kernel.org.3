Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E902258B372
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 04:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbiHFChF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 22:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiHFCg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 22:36:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDDC7B7B0;
        Fri,  5 Aug 2022 19:36:53 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M065G4csbz1HBY8;
        Sat,  6 Aug 2022 10:35:30 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 6 Aug 2022 10:36:51 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 6 Aug
 2022 10:36:50 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        <yekai13@huawei.com>
Subject: [PATCH v7 3/3] crypto: hisilicon/qm - define the device isolation strategy
Date:   Sat, 6 Aug 2022 10:29:43 +0800
Message-ID: <20220806022943.47292-4-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220806022943.47292-1-yekai13@huawei.com>
References: <20220806022943.47292-1-yekai13@huawei.com>
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

Define the device isolation strategy by the device driver. The
user configures a frequency value by uacce interface. If the
slot reset frequency exceeds the value of setting for a certain
period of time, the device will not be available in user space.
The time window is one hour. The VF device use the PF device
isolation strategy. All the hardware errors are processed by PF
driver. This solution can be used for other drivers.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 163 +++++++++++++++++++++++++++++++---
 include/linux/hisi_acc_qm.h   |   9 ++
 2 files changed, 160 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index ad83c194d664..a519ddad0af5 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -417,6 +417,16 @@ struct hisi_qm_resource {
 	struct list_head list;
 };
 
+/**
+ * struct qm_hw_err - Structure describing the device errors
+ * @list: hardware error list
+ * @timestamp: timestamp when the error occurred
+ */
+struct qm_hw_err {
+	struct list_head list;
+	unsigned long long timestamp;
+};
+
 struct hisi_qm_hw_ops {
 	int (*get_vft)(struct hisi_qm *qm, u32 *base, u32 *number);
 	void (*qm_db)(struct hisi_qm *qm, u16 qn,
@@ -3410,6 +3420,111 @@ static long hisi_qm_uacce_ioctl(struct uacce_queue *q, unsigned int cmd,
 	return 0;
 }
 
+/**
+ * qm_hw_err_isolate() - Try to isolate the uacce device with its VFs
+ * according to user's configuration of isolation strategy. Warning: this
+ * API should be called while there the users on this device are suspended
+ * by slot resetting preparation of PCI AER.
+ * @qm: the uacce device
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
+	if (qm->uacce->is_vf || isolate->is_isolate ||
+	    !isolate->hw_err_isolate_hz)
+		return 0;
+
+	hw_err = kzalloc(sizeof(*hw_err), GFP_KERNEL);
+	if (!hw_err)
+		return -ENOMEM;
+
+	mutex_lock(&isolate->isolate_lock);
+	hw_err->timestamp = jiffies;
+	list_for_each_entry_safe(err, tmp, &isolate->uacce_hw_errs, list) {
+		if ((hw_err->timestamp - err->timestamp) / HZ >
+		    SECONDS_PER_HOUR) {
+			list_del(&err->list);
+			kfree(err);
+		} else {
+			count++;
+		}
+	}
+	list_add(&hw_err->list, &isolate->uacce_hw_errs);
+	mutex_unlock(&isolate->isolate_lock);
+
+	if (count >= isolate->hw_err_isolate_hz)
+		isolate->is_isolate = true;
+
+	return 0;
+}
+
+static void qm_hw_err_destroy(struct hisi_qm *qm)
+{
+	struct qm_hw_err *err, *tmp;
+
+	mutex_lock(&qm->isolate_data.isolate_lock);
+	list_for_each_entry_safe(err, tmp, &qm->isolate_data.uacce_hw_errs, list) {
+		list_del(&err->list);
+		kfree(err);
+	}
+	mutex_unlock(&qm->isolate_data.isolate_lock);
+}
+
+static enum uacce_dev_state hisi_qm_get_isolate_state(struct uacce_device *uacce)
+{
+	struct hisi_qm *qm = uacce->priv;
+	struct hisi_qm *pf_qm;
+
+	if (uacce->is_vf)
+		pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
+	else
+		pf_qm = qm;
+
+	return pf_qm->isolate_data.is_isolate ?
+			UACCE_DEV_ISOLATE : UACCE_DEV_NORMAL;
+}
+
+static int hisi_qm_isolate_strategy_write(struct uacce_device *uacce,
+					  u32 freq)
+{
+	struct hisi_qm *qm = uacce->priv;
+
+	/* Must be set by PF */
+	if (uacce->is_vf)
+		return -EPERM;
+
+	if (qm->isolate_data.is_isolate)
+		return -EPERM;
+
+	qm->isolate_data.hw_err_isolate_hz = freq;
+
+	/* After the policy is updated, need to reset the hardware err list */
+	qm_hw_err_destroy(qm);
+
+	return 0;
+}
+
+static u32 hisi_qm_isolate_strategy_read(struct uacce_device *uacce)
+{
+	struct hisi_qm *qm = uacce->priv;
+	struct hisi_qm *pf_qm;
+
+	if (uacce->is_vf) {
+		pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
+		return pf_qm->isolate_data.hw_err_isolate_hz;
+	} else {
+		return qm->isolate_data.hw_err_isolate_hz;
+	}
+}
+
 static const struct uacce_ops uacce_qm_ops = {
 	.get_available_instances = hisi_qm_get_available_instances,
 	.get_queue = hisi_qm_uacce_get_queue,
@@ -3419,8 +3534,22 @@ static const struct uacce_ops uacce_qm_ops = {
 	.mmap = hisi_qm_uacce_mmap,
 	.ioctl = hisi_qm_uacce_ioctl,
 	.is_q_updated = hisi_qm_is_q_updated,
+	.get_isolate_state = hisi_qm_get_isolate_state,
+	.isolate_strategy_write = hisi_qm_isolate_strategy_write,
+	.isolate_strategy_read = hisi_qm_isolate_strategy_read,
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
@@ -3446,8 +3575,7 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 		qm->use_sva = true;
 	} else {
 		/* only consider sva case */
-		uacce_remove(uacce);
-		qm->uacce = NULL;
+		qm_remove_uacce(qm);
 		return -EINVAL;
 	}
 
@@ -3479,6 +3607,8 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 	uacce->qf_pg_num[UACCE_QFRT_DUS]  = dus_page_nr;
 
 	qm->uacce = uacce;
+	INIT_LIST_HEAD(&qm->isolate_data.uacce_hw_errs);
+	mutex_init(&qm->isolate_data.isolate_lock);
 
 	return 0;
 }
@@ -5109,6 +5239,12 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
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
@@ -5436,19 +5572,25 @@ static int qm_controller_reset(struct hisi_qm *qm)
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
 
 	return 0;
+
+err_reset:
+	pci_err(pdev, "Controller reset failed (%d)\n", ret);
+	qm_reset_bit_clear(qm);
+
+	/* if resetting fails, isolate the device */
+	if (qm->use_sva && !qm->uacce->is_vf)
+		qm->isolate_data.is_isolate = true;
+	return ret;
 }
 
 /**
@@ -6246,10 +6388,7 @@ int hisi_qm_init(struct hisi_qm *qm)
 err_free_qm_memory:
 	hisi_qm_memory_uninit(qm);
 err_alloc_uacce:
-	if (qm->use_sva) {
-		uacce_remove(qm->uacce);
-		qm->uacce = NULL;
-	}
+	qm_remove_uacce(qm);
 err_irq_register:
 	qm_irq_unregister(qm);
 err_pci_init:
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 116e8bd68c99..e7aa6a451ec9 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -271,6 +271,14 @@ struct hisi_qm_poll_data {
 	u16 *qp_finish_id;
 };
 
+struct qm_err_isolate {
+	struct mutex isolate_lock;
+	/* user cfg freq which triggers isolation */
+	u32 hw_err_isolate_hz;
+	bool is_isolate;
+	struct list_head uacce_hw_errs;
+};
+
 struct hisi_qm {
 	enum qm_hw_ver ver;
 	enum qm_fun_type fun_type;
@@ -335,6 +343,7 @@ struct hisi_qm {
 	struct qm_shaper_factor *factor;
 	u32 mb_qos;
 	u32 type_rate;
+	struct qm_err_isolate isolate_data;
 };
 
 struct hisi_qp_status {
-- 
2.33.0

