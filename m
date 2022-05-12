Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E72524B85
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353139AbiELLWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353150AbiELLVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:21:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02B6D67;
        Thu, 12 May 2022 04:21:28 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KzTlp1Nw3z6GD8h;
        Thu, 12 May 2022 19:17:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 12 May 2022 13:21:26 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 12:21:25 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 2/3] scsi: hisi_sas: Use sas_ata_wait_after_reset() in IT nexus reset
Date:   Thu, 12 May 2022 19:15:33 +0800
Message-ID: <1652354134-171343-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1652354134-171343-1-git-send-email-john.garry@huawei.com>
References: <1652354134-171343-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have seen errors like this when a SATA device is probed:

[524.566298] hisi_sas_v3_hw 0000L74:02.0: erroneous completion iptt=4096 ...
[524.582827] sas: TMF task open reject failed 500e004aaaaaaaa00

Since commit 21c7e972475e ("scsi: hisi_sas: Disable SATA disk phy for
severe I_T nexus reset failure"), we issue an ATA softreset to disks after
a phy reset to ensure that they are in sound working order. If the
softreset is issued before the remote phy has come back up then the
softreset will fail (errors as above). Remedy this by waiting for the
phy to come back up after the reset.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 4bda2f6cb352..997f27e2f1e5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1710,13 +1710,18 @@ static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
 		/* report PHY down if timed out */
 		if (rc == -ETIMEDOUT)
 			hisi_sas_phy_down(hisi_hba, sas_phy->id, 0, GFP_KERNEL);
-	} else if (sas_dev->dev_status != HISI_SAS_DEV_INIT) {
-		/*
-		 * If in init state, we rely on caller to wait for link to be
-		 * ready; otherwise, except phy reset is fail, delay.
-		 */
-		if (!rc)
-			msleep(2000);
+		return rc;
+	}
+
+	if (rc)
+		return rc;
+
+	/* Remote phy */
+	if (dev_is_sata(device)) {
+		rc = sas_ata_wait_after_reset(device,
+					HISI_SAS_WAIT_PHYUP_TIMEOUT);
+	} else {
+		msleep(2000);
 	}
 
 	return rc;
-- 
2.26.2

