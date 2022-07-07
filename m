Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047D056AD02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbiGGUxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbiGGUxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:53:14 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 13:53:12 PDT
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE0E2CE3B;
        Thu,  7 Jul 2022 13:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2562; q=dns/txt; s=iport;
  t=1657227192; x=1658436792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IGkApyCOPj4WsvWkXi+ev19llmpNYiOROU+qzijV/Sw=;
  b=S7nv4NzhWjbjEb0JbQAwE75XDfzAcW0Ojozrk8d/xv+a2dBO0bbieBu6
   rxQe2q3ZPAG6B2JmnSpaXvu4zlbWoYb7TH0CHjY4G3SFeMjLWAprpQlKm
   /Hku5D/w10tCZhpmcR1V1pnTWN6c3lZlBNT2TahZ+9SMZ517Kkm7y/F7U
   A=;
X-IronPort-AV: E=Sophos;i="5.92,253,1650931200"; 
   d="scan'208";a="930279870"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 Jul 2022 20:52:09 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPSA id 267Kq06B003512
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jul 2022 20:52:08 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        satishkh@cisco.com, gvaradar@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH] scsi: fnic: refactor code in fnic probe to initialize scsi layer
Date:   Thu,  7 Jul 2022 13:51:55 -0700
Message-Id: <20220707205155.692688-1-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: alln-core-6.cisco.com
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor code from fnic probe into a different function so that
scsi layer initialization code is grouped together.
Also, add log messages for better debugging.

Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic_main.c | 45 ++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 51e7c344ddc3..a666bf90f384 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -556,6 +556,39 @@ static void fnic_set_vlan(struct fnic *fnic, u16 vlan_id)
 	vnic_dev_set_default_vlan(fnic->vdev, vlan_id);
 }
 
+static int fnic_scsi_drv_init(struct fnic *fnic)
+{
+	struct Scsi_Host *host = fnic->lport->host;
+
+	/* Configure maximum outstanding IO reqs*/
+	if (fnic->config.io_throttle_count != FNIC_UCSM_DFLT_THROTTLE_CNT_BLD)
+		host->can_queue = min_t(u32, FNIC_MAX_IO_REQ,
+					max_t(u32, FNIC_MIN_IO_REQ,
+					fnic->config.io_throttle_count));
+
+	fnic->fnic_max_tag_id = host->can_queue;
+	host->max_lun = fnic->config.luns_per_tgt;
+	host->max_id = FNIC_MAX_FCP_TARGET;
+	host->max_cmd_len = FCOE_MAX_CMD_LEN;
+
+	host->nr_hw_queues = fnic->wq_copy_count;
+	if (host->nr_hw_queues > 1)
+		shost_printk(KERN_ERR, host,
+				"fnic: blk-mq is not supported");
+
+	host->nr_hw_queues = fnic->wq_copy_count = 1;
+
+	shost_printk(KERN_INFO, host,
+			"fnic: can_queue: %d max_lun: %llu",
+			host->can_queue, host->max_lun);
+
+	shost_printk(KERN_INFO, host,
+			"fnic: max_id: %d max_cmd_len: %d nr_hw_queues: %d",
+			host->max_id, host->max_cmd_len, host->nr_hw_queues);
+
+	return 0;
+}
+
 static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct Scsi_Host *host;
@@ -696,17 +729,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_dev_close;
 	}
 
-	/* Configure Maximum Outstanding IO reqs*/
-	if (fnic->config.io_throttle_count != FNIC_UCSM_DFLT_THROTTLE_CNT_BLD) {
-		host->can_queue = min_t(u32, FNIC_MAX_IO_REQ,
-					max_t(u32, FNIC_MIN_IO_REQ,
-					fnic->config.io_throttle_count));
-	}
-	fnic->fnic_max_tag_id = host->can_queue;
-
-	host->max_lun = fnic->config.luns_per_tgt;
-	host->max_id = FNIC_MAX_FCP_TARGET;
-	host->max_cmd_len = FCOE_MAX_CMD_LEN;
+	fnic_scsi_drv_init(fnic);
 
 	fnic_get_res_counts(fnic);
 
-- 
2.31.1

