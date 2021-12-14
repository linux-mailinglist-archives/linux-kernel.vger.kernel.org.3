Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098D2474131
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhLNLLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:11:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38608 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLNLLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:11:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5578D1F37C;
        Tue, 14 Dec 2021 11:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639480301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UI7E9YaxqXRWd4aYGhXKP+x+evRGUMLUBEiz/8kze70=;
        b=oDBnPWBLj+MjeDWWSbO2j64TSV2j4jR6IuEGy8A99Q5tRV9mScDhYh23iw5l6D7yZF2sSn
        AqfhYuWwHt1SVyZClHVPMWXRGPy1i4unHDGwM242nNMdnxboIAW7RaUzvY0Bc8BdehJnFr
        EsQ3JU9lV1rbnZSo/mX/9ydM4o8uoKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639480301;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UI7E9YaxqXRWd4aYGhXKP+x+evRGUMLUBEiz/8kze70=;
        b=scvaA46e63hjZRMikDL23XHGGd2V0m5Co0KlCDuobhsZJyvMkJEg5QSqadEPnFhVYRYONB
        Q6zaZ/3GV9G+0sAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 4EF41A3B81;
        Tue, 14 Dec 2021 11:11:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 4110D5192149; Tue, 14 Dec 2021 12:11:41 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     Nilesh Javali <njavali@marvell.com>, linux-kernel@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3] qla2xxx: synchronize rport dev_loss_tmo setting
Date:   Tue, 14 Dec 2021 12:11:39 +0100
Message-Id: <20211214111139.52503-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

Currently, the dev_loss_tmo setting is only ever used for SCSI
devices. This patch reshuffles initialisation such that the SCSI
remote ports are registered before the NVMe ones, allowing the
dev_loss_tmo setting to be synchronized between SCSI and NVMe.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
We have this patch in our kernels for a while and it works
fine.

v3:
 - added additional check if fcport pointer is valid in
   qla2x00_set_rport_loss_tmo (crash reported)

v2:
 - https://lore.kernel.org/linux-scsi/20210702092052.93202-1-dwagner@suse.de/
 - fixed build failure for !NVME_FC reported by lkp

v1:
 - https://lore.kernel.org/linux-scsi/20210609094956.11286-1-dwagner@suse.de/
 - initial version
 
 drivers/scsi/qla2xxx/qla_attr.c |  6 ++++++
 drivers/scsi/qla2xxx/qla_init.c | 10 +++-------
 drivers/scsi/qla2xxx/qla_nvme.c |  5 ++++-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 032efb294ee5..db55737000ab 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2700,7 +2700,13 @@ qla2x00_get_starget_port_id(struct scsi_target *starget)
 static inline void
 qla2x00_set_rport_loss_tmo(struct fc_rport *rport, uint32_t timeout)
 {
+	fc_port_t *fcport = *(fc_port_t **)rport->dd_data;
+
 	rport->dev_loss_tmo = timeout ? timeout : 1;
+
+	if (IS_ENABLED(CONFIG_NVME_FC) && fcport && fcport->nvme_remote_port)
+		nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port,
+					       rport->dev_loss_tmo);
 }
 
 static void
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 070b636802d0..1fe4966fc2f6 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5828,13 +5828,6 @@ qla2x00_update_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
 
 	qla2x00_dfs_create_rport(vha, fcport);
 
-	if (NVME_TARGET(vha->hw, fcport)) {
-		qla_nvme_register_remote(vha, fcport);
-		qla2x00_set_fcport_disc_state(fcport, DSC_LOGIN_COMPLETE);
-		qla2x00_set_fcport_state(fcport, FCS_ONLINE);
-		return;
-	}
-
 	qla24xx_update_fcport_fcp_prio(vha, fcport);
 
 	switch (vha->host->active_mode) {
@@ -5856,6 +5849,9 @@ qla2x00_update_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
 		break;
 	}
 
+	if (NVME_TARGET(vha->hw, fcport))
+		qla_nvme_register_remote(vha, fcport);
+
 	qla2x00_set_fcport_state(fcport, FCS_ONLINE);
 
 	if (IS_IIDMA_CAPABLE(vha->hw) && vha->hw->flags.gpsc_supported) {
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 138ffdb5c92c..e22ec7cb65db 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -43,7 +43,7 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
 	req.port_name = wwn_to_u64(fcport->port_name);
 	req.node_name = wwn_to_u64(fcport->node_name);
 	req.port_role = 0;
-	req.dev_loss_tmo = 0;
+	req.dev_loss_tmo = fcport->dev_loss_tmo;
 
 	if (fcport->nvme_prli_service_param & NVME_PRLI_SP_INITIATOR)
 		req.port_role = FC_PORT_ROLE_NVME_INITIATOR;
@@ -70,6 +70,9 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
 		return ret;
 	}
 
+	nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port,
+				       fcport->dev_loss_tmo);
+
 	if (fcport->nvme_prli_service_param & NVME_PRLI_SP_SLER)
 		ql_log(ql_log_info, vha, 0x212a,
 		       "PortID:%06x Supports SLER\n", req.port_id);
-- 
2.29.2

