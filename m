Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3E515A1E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 05:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349226AbiD3D1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 23:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiD3D07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 23:26:59 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BF49A990
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 20:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1651289018;
        bh=saZ1ICHbU9lFksbXg59gPJ7eQi7BrCLxeXMUCvy8Ls0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=TRmoqBdyEIzD0PgS4pgitN9/buzLB7u2W2++KWlXr8u1+c14w1Ls9vzc1TTshrD13
         wmzTNQFhOM8ONWki9QHj2TqFeHFm/OaD0k/YPRczt8P7ogJA3yPWZio09WWS7zE735
         vSiZfWu5R1Of1xh/vyapgqxTM3bpFUOULAcCxyLI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 202311289FB3;
        Fri, 29 Apr 2022 23:23:38 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id whBwklBwMn_1; Fri, 29 Apr 2022 23:23:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1651289018;
        bh=saZ1ICHbU9lFksbXg59gPJ7eQi7BrCLxeXMUCvy8Ls0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=TRmoqBdyEIzD0PgS4pgitN9/buzLB7u2W2++KWlXr8u1+c14w1Ls9vzc1TTshrD13
         wmzTNQFhOM8ONWki9QHj2TqFeHFm/OaD0k/YPRczt8P7ogJA3yPWZio09WWS7zE735
         vSiZfWu5R1Of1xh/vyapgqxTM3bpFUOULAcCxyLI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::3774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8C1EF1289FAF;
        Fri, 29 Apr 2022 23:23:37 -0400 (EDT)
Message-ID: <c0cce549e81dd3b773bc30bda30212d94ae0759e.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.18-rc4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 29 Apr 2022 23:23:36 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One fix for an endless error loop with the target driver affecting
tapes.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

David Jeffery (1):
      scsi: target: pscsi: Set SCF_TREAT_READ_AS_NORMAL flag only if there is valid data

And the diffstat:

 drivers/target/target_core_pscsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

With full diff below.

James

---

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

