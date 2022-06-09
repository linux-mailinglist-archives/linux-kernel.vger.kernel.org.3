Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28B054492A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbiFIKhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242983AbiFIKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:37:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A720E2162A2;
        Thu,  9 Jun 2022 03:36:37 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgR16xfvz67xvP;
        Thu,  9 Jun 2022 18:33:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:35 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:32 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 12/18] scsi: libsas drivers: Prepare for reserved commands
Date:   Thu, 9 Jun 2022 18:29:13 +0800
Message-ID: <1654770559-101375-13-git-send-email-john.garry@huawei.com>
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

Set the various LLDD fields to be able to use reserved commands. I have
only done this for hisi sas v2 HW, but all others need this treatment.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 5 +++--
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 3 +++
 drivers/scsi/libsas/sas_init.c         | 5 +++++
 include/scsi/libsas.h                  | 8 ++++++++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 0219ccac9062..2c5c6301f224 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2427,8 +2427,9 @@ int hisi_sas_probe(struct platform_device *pdev,
 	shost->max_channel = 1;
 	shost->max_cmd_len = 16;
 	if (hisi_hba->hw->slot_index_alloc) {
-		shost->can_queue = HISI_SAS_MAX_COMMANDS;
-		shost->cmd_per_lun = HISI_SAS_MAX_COMMANDS;
+		shost->can_queue = HISI_SAS_UNRESERVED_IPTT;
+		shost->nr_reserved_cmds = HISI_SAS_RESERVED_IPTT;
+		shost->cmd_per_lun = HISI_SAS_UNRESERVED_IPTT;
 	} else {
 		shost->can_queue = HISI_SAS_UNRESERVED_IPTT;
 		shost->cmd_per_lun = HISI_SAS_UNRESERVED_IPTT;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 455d49299ddf..a1e60d2ef070 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3564,6 +3564,7 @@ static struct scsi_host_template sht_v2_hw = {
 	.proc_name		= DRV_NAME,
 	.module			= THIS_MODULE,
 	.queuecommand		= sas_queuecommand,
+	.reserved_queuecommand = sas_queuecommand_internal,
 	.dma_need_drain		= ata_scsi_dma_need_drain,
 	.target_alloc		= sas_target_alloc,
 	.slave_configure	= hisi_sas_slave_configure,
@@ -3586,6 +3587,8 @@ static struct scsi_host_template sht_v2_hw = {
 	.host_reset		= hisi_sas_host_reset,
 	.map_queues		= map_queues_v2_hw,
 	.host_tagset		= 1,
+	.cmd_size = sizeof(struct sas_task),
+	.init_cmd_priv = sas_init_priv_cmd,
 };
 
 static const struct hisi_sas_hw hisi_sas_v2_hw = {
diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index dc35f0f8eae3..b0921fbc35b1 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -93,6 +93,11 @@ void sas_hash_addr(u8 *hashed, const u8 *sas_addr)
 	hashed[2] = r & 0xFF;
 }
 
+int sas_init_priv_cmd(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
+{
+	return 0;
+}
+
 int sas_register_ha(struct sas_ha_struct *sas_ha)
 {
 	char name[64];
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 261169ffdca6..92fc3e5ef297 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -693,6 +693,8 @@ extern void sas_resume_ha(struct sas_ha_struct *sas_ha);
 extern void sas_resume_ha_no_sync(struct sas_ha_struct *sas_ha);
 extern void sas_suspend_ha(struct sas_ha_struct *sas_ha);
 
+extern int sas_init_priv_cmd(struct Scsi_Host *shost, struct scsi_cmnd *cmd);
+
 int sas_set_phy_speed(struct sas_phy *phy, struct sas_phy_linkrates *rates);
 int sas_phy_reset(struct sas_phy *phy, int hard_reset);
 int sas_phy_enable(struct sas_phy *phy, int enable);
@@ -764,4 +766,10 @@ static inline struct sas_task *sas_rq_to_task(struct request *rq)
 	return (struct sas_task *)(scmd + 1);
 }
 
+static inline struct scsi_cmnd *sas_scmd_from_task(void *task)
+{
+	struct scsi_cmnd *scmd = task - sizeof(*scmd);
+
+	return scmd;
+}
 #endif /* _SASLIB_H_ */
-- 
2.26.2

