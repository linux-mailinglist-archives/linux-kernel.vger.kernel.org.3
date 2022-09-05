Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C601D5AD1E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbiIELzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiIELzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:55:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187CA4198C;
        Mon,  5 Sep 2022 04:55:31 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MLn0y5Flqz67kSQ;
        Mon,  5 Sep 2022 19:51:30 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 13:55:29 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 12:55:27 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 4/5] scsi: hisi_sas: Add helper to process bcast events
Date:   Mon, 5 Sep 2022 19:48:48 +0800
Message-ID: <1662378529-101489-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1662378529-101489-1-git-send-email-john.garry@huawei.com>
References: <1662378529-101489-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper for bcast processing to reduce duplication.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 12 ++++++++++++
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  4 +---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  7 ++-----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  7 ++-----
 5 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 24c83bc4f5dc..9aebf4a26b13 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -649,6 +649,7 @@ extern void hisi_sas_phy_enable(struct hisi_hba *hisi_hba, int phy_no,
 				int enable);
 extern void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy,
 			      gfp_t gfp_flags);
+extern void hisi_sas_phy_bcast(struct hisi_sas_phy *phy);
 extern void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba,
 				    struct sas_task *task,
 				    struct hisi_sas_slot *slot);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 2edadd4008c0..32fa775e7d37 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1989,6 +1989,18 @@ void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy,
 }
 EXPORT_SYMBOL_GPL(hisi_sas_phy_down);
 
+void hisi_sas_phy_bcast(struct hisi_sas_phy *phy)
+{
+	struct asd_sas_phy *sas_phy = &phy->sas_phy;
+	struct hisi_hba	*hisi_hba = phy->hisi_hba;
+
+	if (test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags))
+		return;
+
+	sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD, GFP_ATOMIC);
+}
+EXPORT_SYMBOL_GPL(hisi_sas_phy_bcast);
+
 void hisi_sas_sync_irqs(struct hisi_hba *hisi_hba)
 {
 	int i;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 349546bacb2b..d643c5a49aa9 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1412,9 +1412,7 @@ static irqreturn_t int_bcast_v1_hw(int irq, void *p)
 		goto end;
 	}
 
-	if (!test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags))
-		sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD,
-				      GFP_ATOMIC);
+	hisi_sas_phy_bcast(phy);
 
 end:
 	hisi_sas_phy_write32(hisi_hba, phy_no, CHL_INT2,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 70e401fd432a..a9c16428906c 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2811,15 +2811,12 @@ static irqreturn_t int_phy_updown_v2_hw(int irq_no, void *p)
 static void phy_bcast_v2_hw(int phy_no, struct hisi_hba *hisi_hba)
 {
 	struct hisi_sas_phy *phy = &hisi_hba->phy[phy_no];
-	struct asd_sas_phy *sas_phy = &phy->sas_phy;
 	u32 bcast_status;
 
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_RX_BCAST_CHK_MSK, 1);
 	bcast_status = hisi_sas_phy_read32(hisi_hba, phy_no, RX_PRIMS_STATUS);
-	if ((bcast_status & RX_BCAST_CHG_MSK) &&
-	    !test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags))
-		sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD,
-				      GFP_ATOMIC);
+	if (bcast_status & RX_BCAST_CHG_MSK)
+		hisi_sas_phy_bcast(phy);
 	hisi_sas_phy_write32(hisi_hba, phy_no, CHL_INT0,
 			     CHL_INT0_SL_RX_BCST_ACK_MSK);
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_RX_BCAST_CHK_MSK, 0);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 1710f479a896..10b55cef5cf5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1626,15 +1626,12 @@ static irqreturn_t phy_down_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 static irqreturn_t phy_bcast_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 {
 	struct hisi_sas_phy *phy = &hisi_hba->phy[phy_no];
-	struct asd_sas_phy *sas_phy = &phy->sas_phy;
 	u32 bcast_status;
 
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_RX_BCAST_CHK_MSK, 1);
 	bcast_status = hisi_sas_phy_read32(hisi_hba, phy_no, RX_PRIMS_STATUS);
-	if ((bcast_status & RX_BCAST_CHG_MSK) &&
-	    !test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags))
-		sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD,
-				      GFP_ATOMIC);
+	if (bcast_status & RX_BCAST_CHG_MSK)
+		hisi_sas_phy_bcast(phy);
 	hisi_sas_phy_write32(hisi_hba, phy_no, CHL_INT0,
 			     CHL_INT0_SL_RX_BCST_ACK_MSK);
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_RX_BCAST_CHK_MSK, 0);
-- 
2.35.3

