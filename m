Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58AD4C2B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiBXL5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbiBXL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:57:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A300106B04;
        Thu, 24 Feb 2022 03:57:12 -0800 (PST)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4B904WSGz67wMm;
        Thu, 24 Feb 2022 19:52:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 12:57:10 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 11:57:08 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Qi Liu <liuqi115@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 4/6] scsi: hisi_sas: Rename error labels in hisi_sas_v3_probe()
Date:   Thu, 24 Feb 2022 19:51:27 +0800
Message-ID: <1645703489-87194-5-git-send-email-john.garry@huawei.com>
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

From: Qi Liu <liuqi115@huawei.com>

To avoid doubt, rename the error labels to indicate the action they will
take.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 5b5557cab7ed..43d57b68c208 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -4723,7 +4723,7 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!hisi_hba->regs) {
 		dev_err(dev, "cannot map register\n");
 		rc = -ENOMEM;
-		goto err_out_ha;
+		goto err_out_free_host;
 	}
 
 	phy_nr = port_nr = hisi_hba->n_phy;
@@ -4732,7 +4732,7 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	arr_port = devm_kcalloc(dev, port_nr, sizeof(void *), GFP_KERNEL);
 	if (!arr_phy || !arr_port) {
 		rc = -ENOMEM;
-		goto err_out_ha;
+		goto err_out_free_host;
 	}
 
 	sha->sas_phy = arr_phy;
@@ -4773,19 +4773,19 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	rc = interrupt_preinit_v3_hw(hisi_hba);
 	if (rc)
-		goto err_out_debugfs;
+		goto err_out_undo_debugfs;
 
 	rc = scsi_add_host(shost, dev);
 	if (rc)
-		goto err_out_debugfs;
+		goto err_out_undo_debugfs;
 
 	rc = sas_register_ha(sha);
 	if (rc)
-		goto err_out_register_ha;
+		goto err_out_remove_host;
 
 	rc = hisi_sas_v3_init(hisi_hba);
 	if (rc)
-		goto err_out_hw_init;
+		goto err_out_unregister_ha;
 
 	scsi_scan_host(shost);
 
@@ -4804,13 +4804,13 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 
-err_out_hw_init:
+err_out_unregister_ha:
 	sas_unregister_ha(sha);
-err_out_register_ha:
+err_out_remove_host:
 	scsi_remove_host(shost);
-err_out_debugfs:
+err_out_undo_debugfs:
 	debugfs_exit_v3_hw(hisi_hba);
-err_out_ha:
+err_out_free_host:
 	hisi_sas_free(hisi_hba);
 	scsi_host_put(shost);
 err_out:
-- 
2.26.2

