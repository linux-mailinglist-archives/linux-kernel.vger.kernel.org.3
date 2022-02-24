Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B604C2B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiBXL5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiBXL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:57:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63BF5371E;
        Thu, 24 Feb 2022 03:57:07 -0800 (PST)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4BFX1TvFz6H6s5;
        Thu, 24 Feb 2022 19:56:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 12:57:05 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 11:57:03 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/6] scsi: hisi_sas: Change hisi_sas_control_phy() phyup timeout
Date:   Thu, 24 Feb 2022 19:51:25 +0800
Message-ID: <1645703489-87194-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1645703489-87194-1-git-send-email-john.garry@huawei.com>
References: <1645703489-87194-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

The time of phyup not only depends on the controller but also the type of
disk connected. As an example, from experience, for some SATA disks the
amount of time from reset/power-on to receive the D2H FIS for phyup can
take upto and more than 10s sometimes. According to the specification of
some SATA disks such as ST14000NM0018, the max time from power-on to ready
is 30s.

Based on this the current timeout of phyup at 2s which is not enough. So
set the value as HISI_SAS_WAIT_PHYUP_TIMEOUT (30s) in
hisi_sas_control_phy().

For v3 hw there is a pre-existing workaround for a HW bug, being that we
issue a link reset when the OOB occurs but the phyup does not. The
current phyup timeout is HISI_SAS_WAIT_PHYUP_TIMEOUT. So if this does
occur from when issuing a phy enable or similar via
hisi_sas_control_phy(), the subsequent HW workaround linkreset processing
calls hisi_sas_control_phy(), but this will pend the original phy reset
timing out, so it is safe.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h      | 2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index fe0c15bbfca9..99ceffad4bd9 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -91,7 +91,7 @@
 
 #define HISI_SAS_PROT_MASK (HISI_SAS_DIF_PROT_MASK | HISI_SAS_DIX_PROT_MASK)
 
-#define HISI_SAS_WAIT_PHYUP_TIMEOUT	(20 * HZ)
+#define HISI_SAS_WAIT_PHYUP_TIMEOUT	(30 * HZ)
 #define HISI_SAS_CLEAR_ITCT_TIMEOUT	(20 * HZ)
 
 struct hisi_hba;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index efedfb3332c3..cd8ec851e760 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1201,7 +1201,8 @@ static int hisi_sas_control_phy(struct asd_sas_phy *sas_phy, enum phy_func func,
 		goto out;
 	}
 
-	if (sts && !wait_for_completion_timeout(&completion, 2 * HZ)) {
+	if (sts && !wait_for_completion_timeout(&completion,
+		HISI_SAS_WAIT_PHYUP_TIMEOUT)) {
 		dev_warn(dev, "phy%d wait phyup timed out for func %d\n",
 			 phy_no, func);
 		if (phy->in_reset)
-- 
2.26.2

