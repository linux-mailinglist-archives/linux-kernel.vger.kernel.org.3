Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A3F50360E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiDPKye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiDPKyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:54:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FCD3AA72;
        Sat, 16 Apr 2022 03:51:50 -0700 (PDT)
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KgVPb1LDvzgYsg;
        Sat, 16 Apr 2022 18:51:47 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 18:51:49 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 18:51:48 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 4/4] crypto: hisilicon/qm - remove hisi_qm_get_free_qp_num()
Date:   Sat, 16 Apr 2022 18:45:59 +0800
Message-ID: <20220416104559.10826-5-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220416104559.10826-1-qianweili@huawei.com>
References: <20220416104559.10826-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hisi_qm_get_free_qp_num() is to get the free queue number on the function.
It is a simple function and is only called by
hisi_qm_get_available_instances().

This patch modifies to get the free queue directly in
hisi_qm_get_available_instances(), and remove hisi_qm_get_free_qp_num().

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 28 +++++++++-------------------
 include/linux/hisi_acc_qm.h   |  1 -
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index f708a632a2f5..cd4c146340dd 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3051,9 +3051,17 @@ static void qm_qp_event_notifier(struct hisi_qp *qp)
 	wake_up_interruptible(&qp->uacce_q->wait);
 }
 
+ /* This function returns free number of qp in qm. */
 static int hisi_qm_get_available_instances(struct uacce_device *uacce)
 {
-	return hisi_qm_get_free_qp_num(uacce->priv);
+	struct hisi_qm *qm = uacce->priv;
+	int ret;
+
+	down_read(&qm->qps_lock);
+	ret = qm->qp_num - qm->qp_in_used;
+	up_read(&qm->qps_lock);
+
+	return ret;
 }
 
 static void hisi_qm_set_hw_reset(struct hisi_qm *qm, int offset)
@@ -3365,24 +3373,6 @@ void hisi_qm_wait_task_finish(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_wait_task_finish);
 
-/**
- * hisi_qm_get_free_qp_num() - Get free number of qp in qm.
- * @qm: The qm which want to get free qp.
- *
- * This function return free number of qp in qm.
- */
-int hisi_qm_get_free_qp_num(struct hisi_qm *qm)
-{
-	int ret;
-
-	down_read(&qm->qps_lock);
-	ret = qm->qp_num - qm->qp_in_used;
-	up_read(&qm->qps_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(hisi_qm_get_free_qp_num);
-
 static void hisi_qp_memory_uninit(struct hisi_qm *qm, int num)
 {
 	struct device *dev = &qm->pdev->dev;
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 46974d641af1..545f58432412 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -436,7 +436,6 @@ int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r);
 int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg);
 int hisi_qm_stop_qp(struct hisi_qp *qp);
 int hisi_qp_send(struct hisi_qp *qp, const void *msg);
-int hisi_qm_get_free_qp_num(struct hisi_qm *qm);
 void hisi_qm_debug_init(struct hisi_qm *qm);
 void hisi_qm_debug_regs_clear(struct hisi_qm *qm);
 int hisi_qm_sriov_enable(struct pci_dev *pdev, int max_vfs);
-- 
2.33.0

