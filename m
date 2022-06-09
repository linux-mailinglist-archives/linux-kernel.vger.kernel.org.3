Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4B6544923
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbiFIKhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243075AbiFIKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:36:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2565B215A42;
        Thu,  9 Jun 2022 03:36:28 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgQr35Vbz67sRl;
        Thu,  9 Jun 2022 18:32:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:26 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:22 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 09/18] scsi: ipr: Support reserved commands
Date:   Thu, 9 Jun 2022 18:29:10 +0800
Message-ID: <1654770559-101375-10-git-send-email-john.garry@huawei.com>
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

Support a single reserved command for ATA internal commands. We also
add SHT reserved_queuecommand callback to support queueing those internal
commands.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/ipr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 256ec6d08c16..4f4cf39cd2bc 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6740,6 +6740,19 @@ static const char *ipr_ioa_info(struct Scsi_Host *host)
 	return buffer;
 }
 
+static int ipr_reserved_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
+{
+	struct ata_queued_cmd *qc = (struct ata_queued_cmd *)scmd->host_scribble;
+	struct ata_port *ap = qc->ap;
+	int ret;
+
+	/* We're only going to be seeing ATA internal commands */
+	spin_lock_irq(ap->lock);
+	ret = ata_sas_queuecmd(scmd, ap);
+	spin_unlock_irq(ap->lock);
+	return ret;
+}
+
 static struct scsi_host_template driver_template = {
 	.module = THIS_MODULE,
 	.name = "IPR",
@@ -6749,6 +6762,7 @@ static struct scsi_host_template driver_template = {
 	.compat_ioctl = ipr_ioctl,
 #endif
 	.queuecommand = ipr_queuecommand,
+	.reserved_queuecommand = ipr_reserved_queuecommand,
 	.dma_need_drain = ata_scsi_dma_need_drain,
 	.eh_abort_handler = ipr_eh_abort,
 	.eh_device_reset_handler = ipr_eh_dev_reset,
@@ -9991,7 +10005,8 @@ static void ipr_init_ioa_cfg(struct ipr_ioa_cfg *ioa_cfg,
 
 	host->unique_id = host->host_no;
 	host->max_cmd_len = IPR_MAX_CDB_LEN;
-	host->can_queue = ioa_cfg->max_cmds;
+	host->can_queue = ioa_cfg->max_cmds - 1;
+	host->nr_reserved_cmds = 1;
 	pci_set_drvdata(pdev, ioa_cfg);
 
 	for (i = 0; i < ARRAY_SIZE(ioa_cfg->hrrq); i++) {
-- 
2.26.2

