Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929B3544919
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbiFIKhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243105AbiFIKg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:36:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1111215E6A;
        Thu,  9 Jun 2022 03:36:34 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgPX5R5Bz689NW;
        Thu,  9 Jun 2022 18:31:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:32 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:29 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 11/18] scsi: libsas: Don't attempt to find scsi host rphy in slave alloc
Date:   Thu, 9 Jun 2022 18:29:12 +0800
Message-ID: <1654770559-101375-12-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
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

It doesn't have one.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 12 ++++++++++--
 drivers/scsi/libsas/sas_scsi_host.c   | 17 +++++++++++++++--
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 764e859d0106..0219ccac9062 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -756,14 +756,22 @@ static int hisi_sas_init_device(struct domain_device *device)
 
 int hisi_sas_slave_alloc(struct scsi_device *sdev)
 {
-	struct domain_device *ddev = sdev_to_domain_dev(sdev);
-	struct hisi_sas_device *sas_dev = ddev->lldd_dev;
+	struct scsi_target *starget = sdev->sdev_target;
+	struct device *parent = starget->dev.parent;
+	struct hisi_sas_device *sas_dev;
+	struct domain_device *ddev;
 	int rc;
 
+	if (scsi_is_host_device(parent))
+		return 0;
+
 	rc = sas_slave_alloc(sdev);
 	if (rc)
 		return rc;
 
+	ddev = sdev_to_domain_dev(sdev);
+	sas_dev = ddev->lldd_dev;
+
 	rc = hisi_sas_init_device(ddev);
 	if (rc)
 		return rc;
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 42279a6d6b06..532e734c1fb6 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -847,8 +847,15 @@ struct domain_device *sas_find_dev_by_rphy(struct sas_rphy *rphy)
 
 int sas_target_alloc(struct scsi_target *starget)
 {
-	struct sas_rphy *rphy = dev_to_rphy(starget->dev.parent);
-	struct domain_device *found_dev = sas_find_dev_by_rphy(rphy);
+	struct device *parent = starget->dev.parent;
+	struct sas_rphy *rphy;
+	struct domain_device *found_dev;
+
+	if (scsi_is_host_device(parent))
+		return 0;
+
+	rphy = dev_to_rphy(parent);
+	found_dev = sas_find_dev_by_rphy(rphy);
 
 	if (!found_dev)
 		return -ENODEV;
@@ -1252,6 +1259,12 @@ EXPORT_SYMBOL_GPL(sas_task_abort);
 
 int sas_slave_alloc(struct scsi_device *sdev)
 {
+	struct scsi_target *starget = sdev->sdev_target;
+	struct device *parent = starget->dev.parent;
+
+	if (scsi_is_host_device(parent))
+		return 0;
+
 	if (dev_is_sata(sdev_to_domain_dev(sdev)) && sdev->lun)
 		return -ENXIO;
 
-- 
2.26.2

