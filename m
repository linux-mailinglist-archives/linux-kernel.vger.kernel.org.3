Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC89475AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243513AbhLOOnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:43:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4290 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243495AbhLOOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:43:18 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDdGW1zWsz67Q1M;
        Wed, 15 Dec 2021 22:41:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 15:43:15 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 14:43:13 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Qi Liu <liuqi115@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 7/8] scsi: hisi_sas: Fix phyup timeout on FPGA
Date:   Wed, 15 Dec 2021 22:37:40 +0800
Message-ID: <1639579061-179473-8-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
References: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Liu <liuqi115@huawei.com>

The OOB interrupt and phyup interrupt handlers may run out-of-order in
high CPU usage scenarios. Since the hisi_sas_phy.timer is added in
hisi_sas_phy_oob_ready() and disarmed in phy_up_v3_hw(), this
out-of-order execution will cause hisi_sas_phy.timer timeout to trigger.

To solve, protect hisi_sas_phy.timer and .attached with a lock, and ensure
that the timer won't be added after phyup handler completes.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 18 +++++++++++++-----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 10 ++++++++--
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 0e14f90dbb1e..66e63a336770 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -909,10 +909,14 @@ void hisi_sas_phy_oob_ready(struct hisi_hba *hisi_hba, int phy_no)
 {
 	struct hisi_sas_phy *phy = &hisi_hba->phy[phy_no];
 	struct device *dev = hisi_hba->dev;
+	unsigned long flags;
 
 	dev_dbg(dev, "phy%d OOB ready\n", phy_no);
-	if (phy->phy_attached)
+	spin_lock_irqsave(&phy->lock, flags);
+	if (phy->phy_attached) {
+		spin_unlock_irqrestore(&phy->lock, flags);
 		return;
+	}
 
 	if (!timer_pending(&phy->timer)) {
 		if (phy->wait_phyup_cnt < HISI_SAS_WAIT_PHYUP_RETRIES) {
@@ -920,13 +924,17 @@ void hisi_sas_phy_oob_ready(struct hisi_hba *hisi_hba, int phy_no)
 			phy->timer.expires = jiffies +
 					     HISI_SAS_WAIT_PHYUP_TIMEOUT;
 			add_timer(&phy->timer);
-		} else {
-			dev_warn(dev, "phy%d failed to come up %d times, giving up\n",
-				 phy_no, phy->wait_phyup_cnt);
-			phy->wait_phyup_cnt = 0;
+			spin_unlock_irqrestore(&phy->lock, flags);
+			return;
 		}
+
+		dev_warn(dev, "phy%d failed to come up %d times, giving up\n",
+			 phy_no, phy->wait_phyup_cnt);
+		phy->wait_phyup_cnt = 0;
 	}
+	spin_unlock_irqrestore(&phy->lock, flags);
 }
+
 EXPORT_SYMBOL_GPL(hisi_sas_phy_oob_ready);
 
 static void hisi_sas_phy_init(struct hisi_hba *hisi_hba, int phy_no)
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 11a44d9dd9b2..0239e2b4b84f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1484,7 +1484,6 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 	struct asd_sas_phy *sas_phy = &phy->sas_phy;
 	struct device *dev = hisi_hba->dev;
 
-	del_timer(&phy->timer);
 	hisi_sas_phy_write32(hisi_hba, phy_no, PHYCTRL_PHY_ENA_MSK, 1);
 
 	port_id = hisi_sas_read32(hisi_hba, PHY_PORT_NUM_MA);
@@ -1561,9 +1560,16 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 	}
 
 	phy->port_id = port_id;
-	phy->phy_attached = 1;
+
 	hisi_sas_notify_phy_event(phy, HISI_PHYE_PHY_UP);
+
 	res = IRQ_HANDLED;
+
+	spin_lock(&phy->lock);
+	/* Delete timer and set phy_attached atomically */
+	del_timer(&phy->timer);
+	phy->phy_attached = 1;
+	spin_unlock(&phy->lock);
 end:
 	if (phy->reset_completion)
 		complete(phy->reset_completion);
-- 
2.26.2

