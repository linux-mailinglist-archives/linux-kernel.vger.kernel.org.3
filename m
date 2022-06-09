Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13B1544911
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbiFIKhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242914AbiFIKgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:36:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AA3213A2B;
        Thu,  9 Jun 2022 03:36:18 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgQf4zxwz68967;
        Thu,  9 Jun 2022 18:32:42 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:16 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:13 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 06/18] libata-scsi: Add ata_scsi_queue_internal()
Date:   Thu, 9 Jun 2022 18:29:07 +0800
Message-ID: <1654770559-101375-7-git-send-email-john.garry@huawei.com>
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

Add a function to handle queued ATA internal SCSI cmnds - does much the
same as ata_exec_internal_sg() does (which will be fixed up later to
actually queue internal cmnds through this function).

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-scsi.c | 47 ++++++++++++++++++++++++++++++++++++++-
 include/linux/libata.h    |  6 +++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 42cecf95a4e5..baac35dd17ca 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3963,6 +3963,49 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 	return NULL;
 }
 
+static unsigned int ata_scsi_queue_internal(struct scsi_cmnd *scmd,
+					    struct ata_device *dev)
+{
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
+	struct ata_queued_cmd *qc;
+
+	/* no internal command while frozen */
+	if (ap->pflags & ATA_PFLAG_FROZEN)
+		goto did_err;
+
+	/* initialize internal qc */
+	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
+	link->preempted_tag = link->active_tag;
+	link->preempted_sactive = link->sactive;
+	ap->preempted_qc_active = ap->qc_active;
+	ap->preempted_nr_active_links = ap->nr_active_links;
+	link->active_tag = ATA_TAG_POISON;
+	link->sactive = 0;
+	ap->qc_active = 0;
+	ap->nr_active_links = 0;
+
+	if (qc->dma_dir != DMA_NONE) {
+		int n_elem;
+
+		n_elem = 1;
+		qc->n_elem = n_elem;
+		qc->sg = scsi_sglist(scmd);
+		qc->nbytes = qc->sg->length;
+		ata_sg_init(qc, qc->sg, n_elem);
+	}
+
+	scmd->submitter = SUBMITTED_BY_BLOCK_LAYER;
+
+	ata_qc_issue(qc);
+
+	return 0;
+did_err:
+	scmd->result = (DID_ERROR << 16);
+	scsi_done(scmd);
+	return 0;
+}
+
 int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 {
 	u8 scsi_op = scmd->cmnd[0];
@@ -3971,7 +4014,9 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 	if (unlikely(!scmd->cmd_len))
 		goto bad_cdb_len;
 
-	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
+	if (scsi_is_reserved_cmd(scmd)) {
+		return ata_scsi_queue_internal(scmd, dev);
+	} else if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
 		if (unlikely(scmd->cmd_len > dev->cdb_len))
 			goto bad_cdb_len;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 732de9014626..43f4bcfe9a5f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -767,7 +767,9 @@ struct ata_link {
 
 	struct device		tdev;
 	unsigned int		active_tag;	/* active tag on this link */
+	unsigned int		preempted_tag;
 	u32			sactive;	/* active NCQ commands */
+	u32			preempted_sactive;
 
 	unsigned int		flags;		/* ATA_LFLAG_xxx */
 
@@ -861,6 +863,10 @@ struct ata_port {
 #ifdef CONFIG_ATA_ACPI
 	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
+
+	u64 preempted_qc_active;
+	int preempted_nr_active_links;
+
 	/* owned by EH */
 	u8			sector_buf[ATA_SECT_SIZE] ____cacheline_aligned;
 };
-- 
2.26.2

