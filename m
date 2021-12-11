Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FF4471301
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhLKI4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:56:11 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32910 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhLKI4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:56:09 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JB1p0601Mzcbt4;
        Sat, 11 Dec 2021 16:55:52 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 16:56:07 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 16:56:07 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH] crypto: hisilicon/qm - fix deadlock for remove driver
Date:   Sat, 11 Dec 2021 16:56:55 +0800
Message-ID: <20211211085655.30294-1-shenyang39@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When remove the driver and executing the task occur at the same time,
the following deadlock will be triggered:

Chain exists of:
    sva_lock --> uacce_mutex --> &qm->qps_lock
    Possible unsafe locking scenario:
		CPU0                    CPU1
		----                    ----
	lock(&qm->qps_lock);
					lock(uacce_mutex);
					lock(&qm->qps_lock);
	lock(sva_lock);

And the lock 'qps_lock' is used to protect qp. Therefore, it's reasonable
cycle is to continue until the qp memory is released. So move the release
lock infront of 'uacce_remove'.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 896255aec87f..bea8622d80e6 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3425,6 +3425,7 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 		dma_free_coherent(dev, qm->qdma.size,
 				  qm->qdma.va, qm->qdma.dma);
 	}
+	up_write(&qm->qps_lock);

 	qm_irq_unregister(qm);
 	hisi_qm_pci_uninit(qm);
@@ -3432,8 +3433,6 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 		uacce_remove(qm->uacce);
 		qm->uacce = NULL;
 	}
-
-	up_write(&qm->qps_lock);
 }
 EXPORT_SYMBOL_GPL(hisi_qm_uninit);

--
2.33.0

