Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F77544913
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbiFIKgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242304AbiFIKgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:36:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9522109F9;
        Thu,  9 Jun 2022 03:36:11 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgP55ZrNz6813w;
        Thu,  9 Jun 2022 18:31:21 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:09 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:06 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 04/18] scsi: core: Add support to send reserved commands
Date:   Thu, 9 Jun 2022 18:29:05 +0800
Message-ID: <1654770559-101375-5-git-send-email-john.garry@huawei.com>
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

Add a method to queue reserved commands.

TODO:
- fix timeout handler to call into reserved commands
- We don't clear host_scribble for libata qc, but we should be able to drop
  this if we store libata qc in the scsi cmnd priv_data

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hosts.c     |  6 ++++++
 drivers/scsi/scsi_lib.c  | 32 ++++++++++++++++++++++++++++++++
 include/scsi/scsi_cmnd.h |  5 +++++
 include/scsi/scsi_host.h |  1 +
 4 files changed, 44 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 27296addaf63..5c9b05a8fec8 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -221,6 +221,12 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 		goto fail;
 	}
 
+	if (shost->nr_reserved_cmds && !sht->reserved_queuecommand) {
+		shost_printk(KERN_ERR, shost,
+			"nr_reserved_cmds set but no method to queue\n");
+		goto fail;
+	}
+
 	/* Use min_t(int, ...) in case shost->can_queue exceeds SHRT_MAX */
 	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
 				   shost->can_queue);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index f6e53c6d913c..8c8b4c6767d9 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1422,6 +1422,16 @@ static void scsi_complete(struct request *rq)
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
 	enum scsi_disposition disposition;
 
+	if (scsi_is_reserved_cmd(cmd)) {
+		struct scsi_device *sdev = cmd->device;
+
+		scsi_mq_uninit_cmd(cmd);
+		scsi_device_unbusy(sdev, cmd);
+		__blk_mq_end_request(rq, 0);
+
+		return;
+	}
+
 	INIT_LIST_HEAD(&cmd->eh_entry);
 
 	atomic_inc(&cmd->device->iodone_cnt);
@@ -1706,6 +1716,28 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	WARN_ON_ONCE(cmd->budget_token < 0);
 
+	if (scsi_is_reserved_cmd(cmd)) {
+		unsigned char *host_scribble = cmd->host_scribble;
+
+		if (!(req->rq_flags & RQF_DONTPREP)) {
+			ret = scsi_prepare_cmd(req);
+			if (ret != BLK_STS_OK) {
+
+				goto out_dec_host_busy;
+			}
+
+			req->rq_flags |= RQF_DONTPREP;
+		} else {
+			clear_bit(SCMD_STATE_COMPLETE, &cmd->state);
+		}
+
+		cmd->host_scribble = host_scribble;
+
+		blk_mq_start_request(req);
+
+		return shost->hostt->reserved_queuecommand(shost, cmd);
+	}
+
 	/*
 	 * If the device is not in running state we will reject some or all
 	 * commands.
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 1e80e70dfa92..e47df5836070 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -152,6 +152,11 @@ static inline void *scsi_cmd_priv(struct scsi_cmnd *cmd)
 	return cmd + 1;
 }
 
+static inline bool scsi_is_reserved_cmd(struct scsi_cmnd *cmd)
+{
+	return blk_mq_is_reserved_rq(scsi_cmd_to_rq(cmd));
+}
+
 void scsi_done(struct scsi_cmnd *cmd);
 void scsi_done_direct(struct scsi_cmnd *cmd);
 
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 149dcbd4125e..88c8504395c8 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -73,6 +73,7 @@ struct scsi_host_template {
 	 * STATUS: REQUIRED
 	 */
 	int (* queuecommand)(struct Scsi_Host *, struct scsi_cmnd *);
+	int (* reserved_queuecommand)(struct Scsi_Host *, struct scsi_cmnd *);
 
 	/*
 	 * The commit_rqs function is used to trigger a hardware
-- 
2.26.2

