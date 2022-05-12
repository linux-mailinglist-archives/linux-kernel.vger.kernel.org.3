Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E7A524B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353299AbiELLWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353188AbiELLVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:21:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3F42983F;
        Thu, 12 May 2022 04:21:30 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KzTmW1tSHz687hF;
        Thu, 12 May 2022 19:18:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 12 May 2022 13:21:28 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 12:21:26 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 3/3] scsi: hisi_sas: Fix rescan after deleting a disk
Date:   Thu, 12 May 2022 19:15:34 +0800
Message-ID: <1652354134-171343-4-git-send-email-john.garry@huawei.com>
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

Removing an ATA device via sysfs means that the device may not be found
through re-scanning:

root@ubuntu:/home/john# lsscsi
[0:0:0:0] disk SanDisk LT0200MO P404 /dev/sda
[0:0:1:0] disk ATA HGST HUS724040AL A8B0 /dev/sdb
[0:0:8:0] enclosu 12G SAS Expander RevB -
root@ubuntu:/home/john# echo 1 > /sys/block/sdb/device/delete
root@ubuntu:/home/john# echo "- - -" > /sys/class/scsi_host/host0/scan
root@ubuntu:/home/john# lsscsi
[0:0:0:0] disk SanDisk LT0200MO P404 /dev/sda
[0:0:8:0] enclosu 12G SAS Expander RevB -
root@ubuntu:/home/john#

The problem is that the rescan of the device may conflict with the device
in being re-initialized, as follows:

- In the rescan we call hisi_sas_slave_alloc() in store_scan() ->
  sas_user_scan() -> [__]scsi_scan_target() -> scsi_probe_and_add_lunc() ->
  scsi_alloc_sdev() -> hisi_sas_slave_alloc() -> hisi_sas_init_device()
  In hisi_sas_init_device() we issue an IT nexus reset for ATA devices

- That IT nexus causes the remote PHY to go down and this triggers a bcast
  event

- In parallel libsas processes the bcast event, finds that the phy is down
  and marks the device as gone

The hard reset issued in hisi_sas_init_device() is unncessary - as
described in the code comment - so remove it. Also set dev status as
HISI_SAS_DEV_NORMAL as the hisi_sas_init_device() call.

Fixes: 36c6b7613ef1 ("scsi: hisi_sas: Initialise devices in .slave_alloc callback")
Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 47 ++++++++++-----------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 997f27e2f1e5..6803751dc4b1 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -709,8 +709,6 @@ static int hisi_sas_init_device(struct domain_device *device)
 	struct scsi_lun lun;
 	int retry = HISI_SAS_DISK_RECOVER_CNT;
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
-	struct device *dev = hisi_hba->dev;
-	struct sas_phy *local_phy;
 
 	switch (device->dev_type) {
 	case SAS_END_DEVICE:
@@ -729,30 +727,18 @@ static int hisi_sas_init_device(struct domain_device *device)
 	case SAS_SATA_PM_PORT:
 	case SAS_SATA_PENDING:
 		/*
-		 * send HARD RESET to clear previous affiliation of
-		 * STP target port
+		 * If an expander is swapped when a SATA disk is attached then
+		 * we should issue a hard reset to clear previous affiliation
+		 * of STP target port, see SPL (chapter 6.19.4).
+		 *
+		 * However we don't need to issue a hard reset here for these
+		 * reasons:
+		 * a. When probing the device, libsas/libata already issues a
+		 * hard reset in sas_probe_sata() -> ata_sas_async_probe().
+		 * Note that in hisi_sas_debug_I_T_nexus_reset() we take care
+		 * to issue a hard reset by checking the dev status (== INIT).
+		 * b. When resetting the controller, this is simply unnecessary.
 		 */
-		local_phy = sas_get_local_phy(device);
-		if (!scsi_is_sas_phy_local(local_phy) &&
-		    !test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags)) {
-			unsigned long deadline = ata_deadline(jiffies, 20000);
-			struct sata_device *sata_dev = &device->sata_dev;
-			struct ata_host *ata_host = sata_dev->ata_host;
-			struct ata_port_operations *ops = ata_host->ops;
-			struct ata_port *ap = sata_dev->ap;
-			struct ata_link *link;
-			unsigned int classes;
-
-			ata_for_each_link(link, ap, EDGE)
-				rc = ops->hardreset(link, &classes,
-						    deadline);
-		}
-		sas_put_local_phy(local_phy);
-		if (rc) {
-			dev_warn(dev, "SATA disk hardreset fail: %d\n", rc);
-			return rc;
-		}
-
 		while (retry-- > 0) {
 			rc = hisi_sas_softreset_ata_disk(device);
 			if (!rc)
@@ -768,15 +754,19 @@ static int hisi_sas_init_device(struct domain_device *device)
 
 int hisi_sas_slave_alloc(struct scsi_device *sdev)
 {
-	struct domain_device *ddev;
+	struct domain_device *ddev = sdev_to_domain_dev(sdev);
+	struct hisi_sas_device *sas_dev = ddev->lldd_dev;
 	int rc;
 
 	rc = sas_slave_alloc(sdev);
 	if (rc)
 		return rc;
-	ddev = sdev_to_domain_dev(sdev);
 
-	return hisi_sas_init_device(ddev);
+	rc = hisi_sas_init_device(ddev);
+	if (rc)
+		return rc;
+	sas_dev->dev_status = HISI_SAS_DEV_NORMAL;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(hisi_sas_slave_alloc);
 
@@ -826,7 +816,6 @@ static int hisi_sas_dev_found(struct domain_device *device)
 	dev_info(dev, "dev[%d:%x] found\n",
 		sas_dev->device_id, sas_dev->dev_type);
 
-	sas_dev->dev_status = HISI_SAS_DEV_NORMAL;
 	return 0;
 
 err_out:
-- 
2.26.2

