Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E37D546AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349903AbiFJQxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349830AbiFJQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:52:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657CF1056A;
        Fri, 10 Jun 2022 09:52:50 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LKRj86l8dz688G2;
        Sat, 11 Jun 2022 00:47:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 18:52:48 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:52:45 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.de>, <damien.lemoal@opensource.wdc.com>,
        <Ajish.Koshy@microchip.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 2/4] scsi: pm8001: Setup tags before using them
Date:   Sat, 11 Jun 2022 00:46:40 +0800
Message-ID: <1654879602-33497-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
References: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
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

The current code is buggy in that the tags are set up after they are
needed in pm80xx_chip_init() -> pm80xx_set_sas_protocol_timer_config().
The tag depth is earlier read in pm80xx_chip_init() ->
read_main_config_table().

Add a post init callback to do the pm80xx work which needs to be done
after reading the tags. I don't see a better way to do this.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c  |  5 +++++
 drivers/scsi/pm8001/pm8001_init.c | 18 +++++++++---------
 drivers/scsi/pm8001/pm8001_sas.h  |  1 +
 drivers/scsi/pm8001/pm80xx_hwi.c  | 11 +++++++++--
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index f7466a895d3b..a37595621d51 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -699,6 +699,10 @@ static int pm8001_chip_init(struct pm8001_hba_info *pm8001_ha)
 	return 0;
 }
 
+static void pm8001_chip_post_init(struct pm8001_hba_info *pm8001_ha)
+{
+}
+
 static int mpi_uninit_check(struct pm8001_hba_info *pm8001_ha)
 {
 	u32 max_wait_count;
@@ -4947,6 +4951,7 @@ pm8001_chip_sas_re_initialization(struct pm8001_hba_info *pm8001_ha)
 const struct pm8001_dispatch pm8001_8001_dispatch = {
 	.name			= "pmc8001",
 	.chip_init		= pm8001_chip_init,
+	.chip_post_init		= pm8001_chip_post_init,
 	.chip_soft_rst		= pm8001_chip_soft_rst,
 	.chip_rst		= pm8001_hw_chip_rst,
 	.chip_iounmap		= pm8001_chip_iounmap,
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 4288c6b8f041..171f0a2cf2d6 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -56,7 +56,7 @@ MODULE_PARM_DESC(link_rate, "Enable link rate.\n"
 		" 8: Link rate 12.0G\n");
 
 static struct scsi_transport_template *pm8001_stt;
-static int pm8001_init_ccb_tag(struct pm8001_hba_info *, struct Scsi_Host *, struct pci_dev *);
+static int pm8001_init_ccb_tag(struct pm8001_hba_info *);
 
 /*
  * chip info structure to identify chip key functionality as
@@ -1119,10 +1119,12 @@ static int pm8001_pci_probe(struct pci_dev *pdev,
 		goto err_out_ha_free;
 	}
 
-	rc = pm8001_init_ccb_tag(pm8001_ha, shost, pdev);
+	rc = pm8001_init_ccb_tag(pm8001_ha);
 	if (rc)
 		goto err_out_enable;
 
+	PM8001_CHIP_DISP->chip_post_init(pm8001_ha);
+
 	rc = scsi_add_host(shost, &pdev->dev);
 	if (rc)
 		goto err_out_ha_free;
@@ -1172,16 +1174,14 @@ static int pm8001_pci_probe(struct pci_dev *pdev,
 /**
  * pm8001_init_ccb_tag - allocate memory to CCB and tag.
  * @pm8001_ha: our hba card information.
- * @shost: scsi host which has been allocated outside.
- * @pdev: pci device.
  */
-static int
-pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha, struct Scsi_Host *shost,
-			struct pci_dev *pdev)
+static int pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha)
 {
-	int i = 0;
+	struct Scsi_Host *shost = pm8001_ha->shost;
+	struct device *dev = pm8001_ha->dev;
 	u32 max_out_io, ccb_count;
 	u32 can_queue;
+	int i;
 
 	max_out_io = pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_out_io;
 	ccb_count = min_t(int, PM8001_MAX_CCB, max_out_io);
@@ -1204,7 +1204,7 @@ pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha, struct Scsi_Host *shost,
 		goto err_out_noccb;
 	}
 	for (i = 0; i < ccb_count; i++) {
-		pm8001_ha->ccb_info[i].buf_prd = dma_alloc_coherent(&pdev->dev,
+		pm8001_ha->ccb_info[i].buf_prd = dma_alloc_coherent(dev,
 				sizeof(struct pm8001_prd) * PM8001_MAX_DMA_SG,
 				&pm8001_ha->ccb_info[i].ccb_dma_handle,
 				GFP_KERNEL);
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 060ab680a7ed..c761a2fd25e5 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -172,6 +172,7 @@ struct forensic_data {
 struct pm8001_dispatch {
 	char *name;
 	int (*chip_init)(struct pm8001_hba_info *pm8001_ha);
+	void (*chip_post_init)(struct pm8001_hba_info *pm8001_ha);
 	int (*chip_soft_rst)(struct pm8001_hba_info *pm8001_ha);
 	void (*chip_rst)(struct pm8001_hba_info *pm8001_ha);
 	int (*chip_ioremap)(struct pm8001_hba_info *pm8001_ha);
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 01c5e8ff4cc5..d5cc726c034e 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1469,11 +1469,18 @@ static int pm80xx_chip_init(struct pm8001_hba_info *pm8001_ha)
 	} else
 		return -EBUSY;
 
+	return 0;
+}
+
+static void pm80xx_chip_post_init(struct pm8001_hba_info *pm8001_ha)
+{
 	/* send SAS protocol timer configuration page to FW */
-	ret = pm80xx_set_sas_protocol_timer_config(pm8001_ha);
+	pm80xx_set_sas_protocol_timer_config(pm8001_ha);
 
 	/* Check for encryption */
 	if (pm8001_ha->chip->encrypt) {
+		int ret;
+
 		pm8001_dbg(pm8001_ha, INIT, "Checking for encryption\n");
 		ret = pm80xx_get_encrypt_info(pm8001_ha);
 		if (ret == -1) {
@@ -1485,7 +1492,6 @@ static int pm80xx_chip_init(struct pm8001_hba_info *pm8001_ha)
 			}
 		}
 	}
-	return 0;
 }
 
 static int mpi_uninit_check(struct pm8001_hba_info *pm8001_ha)
@@ -5007,6 +5013,7 @@ void pm8001_set_phy_profile_single(struct pm8001_hba_info *pm8001_ha,
 const struct pm8001_dispatch pm8001_80xx_dispatch = {
 	.name			= "pmc80xx",
 	.chip_init		= pm80xx_chip_init,
+	.chip_post_init		= pm80xx_chip_post_init,
 	.chip_soft_rst		= pm80xx_chip_soft_rst,
 	.chip_rst		= pm80xx_hw_chip_rst,
 	.chip_iounmap		= pm8001_chip_iounmap,
-- 
2.26.2

