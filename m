Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B92544921
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbiFIKhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbiFIKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:36:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3DD215659;
        Thu,  9 Jun 2022 03:36:31 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgTW6TRpz67bS0;
        Thu,  9 Jun 2022 18:35:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:29 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:26 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 10/18] libata/scsi: libsas: Add sas_queuecommand_internal()
Date:   Thu, 9 Jun 2022 18:29:11 +0800
Message-ID: <1654770559-101375-11-git-send-email-john.garry@huawei.com>
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

Add a callback for sht reserved_queuecommand callback. We need to add
libata helper ata_is_scmd_ata_internal() as it is difficult to know
whether the request should be queued as an ATA internal command.

We will store the sas_task in the scsi_cmnd payload also in future.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-core.c           |  8 ++++++++
 drivers/scsi/libsas/sas_scsi_host.c | 21 +++++++++++++++++++++
 include/linux/libata.h              |  1 +
 include/scsi/libsas.h               |  8 ++++++++
 4 files changed, 38 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6b1aaeccb253..a9645951a0f0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1454,6 +1454,14 @@ static void ata_internal_end_rq(struct request *rq, blk_status_t error)
 	complete(waiting);
 }
 
+bool ata_is_scmd_ata_internal(struct scsi_cmnd *scmd)
+{
+	struct request *rq = scsi_cmd_to_rq(scmd);
+
+	return rq->end_io == ata_internal_end_rq;
+}
+EXPORT_SYMBOL_GPL(ata_is_scmd_ata_internal);
+
 /**
  *	ata_exec_internal_sg - execute libata internal command
  *	@dev: Device to which the command is sent
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 9c82e5dc4fcc..42279a6d6b06 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -158,6 +158,27 @@ static struct sas_task *sas_create_task(struct scsi_cmnd *cmd,
 	return task;
 }
 
+int sas_queuecommand_internal(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
+{
+	struct sas_ha_struct *ha = SHOST_TO_SAS_HA(shost);
+	struct sas_internal *i = to_sas_internal(ha->core.shost->transportt);
+	struct request *rq = scsi_cmd_to_rq(cmnd);
+
+	if (ata_is_scmd_ata_internal(cmnd)) {
+		struct ata_queued_cmd *qc = (struct ata_queued_cmd *)cmnd->host_scribble;
+		struct ata_port *ap = qc->ap;
+		int res;
+
+		spin_lock_irq(ap->lock);
+		res = ata_sas_queuecmd(cmnd, ap);
+		spin_unlock_irq(ap->lock);
+		return res;
+	}
+
+	return i->dft->lldd_execute_task(sas_rq_to_task(rq), GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(sas_queuecommand_internal);
+
 int sas_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 {
 	struct sas_internal *i = to_sas_internal(host->transportt);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5fa6f56bba81..6cb7a5bcb308 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1238,6 +1238,7 @@ extern int ata_sas_slave_configure(struct scsi_device *, struct ata_port *);
 extern int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
+extern bool ata_is_scmd_ata_internal(struct scsi_cmnd *scmd);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index ff04eb6d250b..261169ffdca6 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -725,6 +725,7 @@ int  sas_discover_sata(struct domain_device *);
 int  sas_discover_end_dev(struct domain_device *);
 
 void sas_unregister_dev(struct asd_sas_port *port, struct domain_device *);
+int sas_queuecommand_internal(struct Scsi_Host *shost, struct scsi_cmnd *cmnd);
 
 void sas_init_dev(struct domain_device *);
 
@@ -756,4 +757,11 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 			   gfp_t gfp_flags);
 
+static inline struct sas_task *sas_rq_to_task(struct request *rq)
+{
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
+
+	return (struct sas_task *)(scmd + 1);
+}
+
 #endif /* _SASLIB_H_ */
-- 
2.26.2

