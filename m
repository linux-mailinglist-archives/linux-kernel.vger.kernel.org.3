Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4971351218A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiD0SvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiD0Sua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CCBD1F8DB7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651084457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BWvHRfleSmV0RP4sJ9swxCYFlUlfYvho/X292m8mYZk=;
        b=V/gVaPUAlG/3xfGZXu5ekv5wxqqAuZkTy/p2OCxtaFmUOmAgNKzi76kWatLbH1ghZykg4e
        ptzGxH1YHWzXh5DmUSU0pDgJHHrDL8qhXddAxJr1WR/JB4jxh+9/FOTf4YeYj64+JcbYYd
        W+c0+TjF98V0QBuMDELqKI+t0uUcLF8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-vMEfxZPOOkiASFwCfwv5lg-1; Wed, 27 Apr 2022 14:34:13 -0400
X-MC-Unique: vMEfxZPOOkiASFwCfwv5lg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BF53802809;
        Wed, 27 Apr 2022 18:34:13 +0000 (UTC)
Received: from gluttony.redhat.com (unknown [10.22.16.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BA31463E0B;
        Wed, 27 Apr 2022 18:34:13 +0000 (UTC)
From:   David Jeffery <djeffery@redhat.com>
To:     target-devel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Jeffery <djeffery@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH] target: pscsi: set SCF_TREAT_READ_AS_NORMAL flag only if there is valid data
Date:   Wed, 27 Apr 2022 14:32:50 -0400
Message-Id: <20220427183250.291881-1-djeffery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With tape devices, the SCF_TREAT_READ_AS_NORMAL flag is used by the target
subsystem to mark commands which have both data to return as well as
sense data. But with pscsi, SCF_TREAT_READ_AS_NORMAL can be set even if
there is no data to return. The SCF_TREAT_READ_AS_NORMAL flag causes the
target core to call iscsit datain callbacks even if there is no data, which
iscsit does not support. This results in iscsit going into an error state
requiring recovery and being unable to complete the command to the
initiator.

This issue can be resolved by fixing pscsi to only set
SCF_TREAT_READ_AS_NORMAL if there is valid data to return along side the
sense data.

Fixes: bd81372065fa ("scsi: target: transport should handle st FM/EOM/ILI reads")
Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/target/target_core_pscsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index ff292b75e23f..60dafe4c581b 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -588,7 +588,7 @@ static void pscsi_destroy_device(struct se_device *dev)
 }
 
 static void pscsi_complete_cmd(struct se_cmd *cmd, u8 scsi_status,
-			       unsigned char *req_sense)
+			       unsigned char *req_sense, int valid_data)
 {
 	struct pscsi_dev_virt *pdv = PSCSI_DEV(cmd->se_dev);
 	struct scsi_device *sd = pdv->pdv_sd;
@@ -681,7 +681,7 @@ static void pscsi_complete_cmd(struct se_cmd *cmd, u8 scsi_status,
 		 * back despite framework assumption that a
 		 * check condition means there is no data
 		 */
-		if (sd->type == TYPE_TAPE &&
+		if (sd->type == TYPE_TAPE && valid_data &&
 		    cmd->data_direction == DMA_FROM_DEVICE) {
 			/*
 			 * is sense data valid, fixed format,
@@ -1032,6 +1032,7 @@ static void pscsi_req_done(struct request *req, blk_status_t status)
 	struct se_cmd *cmd = req->end_io_data;
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
 	enum sam_status scsi_status = scmd->result & 0xff;
+	int valid_data = cmd->data_length - scmd->resid_len;
 	u8 *cdb = cmd->priv;
 
 	if (scsi_status != SAM_STAT_GOOD) {
@@ -1039,12 +1040,11 @@ static void pscsi_req_done(struct request *req, blk_status_t status)
 			" 0x%02x Result: 0x%08x\n", cmd, cdb[0], scmd->result);
 	}
 
-	pscsi_complete_cmd(cmd, scsi_status, scmd->sense_buffer);
+	pscsi_complete_cmd(cmd, scsi_status, scmd->sense_buffer, valid_data);
 
 	switch (host_byte(scmd->result)) {
 	case DID_OK:
-		target_complete_cmd_with_length(cmd, scsi_status,
-			cmd->data_length - scmd->resid_len);
+		target_complete_cmd_with_length(cmd, scsi_status, valid_data);
 		break;
 	default:
 		pr_debug("PSCSI Host Byte exception at cmd: %p CDB:"
-- 
2.35.1

