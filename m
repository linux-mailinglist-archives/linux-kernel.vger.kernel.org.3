Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51A54814C3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhL2PxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:53:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40574 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhL2PxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:53:05 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0499D1F37F;
        Wed, 29 Dec 2021 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640793184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Q9bH3xpYfiMnv3bMUqyetJzt0d9Hx0SwUfvkjDcfmNc=;
        b=qOHeBhZN6xB1pBkw8jOzkxpoYHnwyp4nMwFMo2TeSM/5r09+qm1Sm+UYu2ciQKYAW+GIsT
        y4lP9k+0ADgm3sfOf7w6X1dTUXcV9T621JmuBkorn/CAUqFPh6UYAxgNbP5D2tPeiLCzDv
        Ca+8guhPimc+iureuztEQFD9mcbU40Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640793184;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Q9bH3xpYfiMnv3bMUqyetJzt0d9Hx0SwUfvkjDcfmNc=;
        b=zk4xbQP3+RHdhuIpTvHVtWx65SOqJBA2FxW5AeNNVKnwTIbxik1SSOxbK/0NVnbpWKQl4j
        HHhRoUIs3JT9P5AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 00E7DA3B85;
        Wed, 29 Dec 2021 15:53:04 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id E79405192579; Wed, 29 Dec 2021 16:53:03 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvmet: add support reading with offset from ANA log
Date:   Wed, 29 Dec 2021 16:53:02 +0100
Message-Id: <20211229155302.16789-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to read with offsets from ANA log buffer.

The controller claims to support extended data for the Get Log Page
command (including extended Number of Dwords and Log Page Offset 2
fields):

lpa     : 0x7
  [2:2] : 0x1   Extended data for Get Log Page Supported
  [1:1] : 0x1   Command Effects Log Page Supported
  [0:0] : 0x1   SMART/Health Log Page per NS Supported

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/admin-cmd.c | 37 +++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de06..7c8806f477e2 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -263,35 +263,40 @@ static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
 	desc->nnsids = cpu_to_le32(count);
 	desc->chgcnt = cpu_to_le64(nvmet_ana_chgcnt);
 	desc->state = req->port->ana_state[grpid];
-	memset(desc->rsvd17, 0, sizeof(desc->rsvd17));
 	return struct_size(desc, nsids, count);
 }
 
 static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 {
-	struct nvme_ana_rsp_hdr hdr = { 0, };
+	struct nvme_ana_rsp_hdr *hdr;
 	struct nvme_ana_group_desc *desc;
-	size_t offset = sizeof(struct nvme_ana_rsp_hdr); /* start beyond hdr */
+	u64 offset = nvmet_get_log_page_offset(req->cmd);
 	size_t len;
+	void *buffer;
 	u32 grpid;
 	u16 ngrps = 0;
 	u16 status;
 
+	if (offset & 0x3) {
+		req->error_loc =
+			offsetof(struct nvme_get_log_page_command, lpo);
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+
 	status = NVME_SC_INTERNAL;
-	desc = kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),
-		       GFP_KERNEL);
-	if (!desc)
+	len = sizeof(*hdr) + struct_size(desc, nsids, NVMET_MAX_NAMESPACES);
+	buffer = kzalloc(len, GFP_KERNEL);
+	if (!buffer)
 		goto out;
+	hdr = buffer;
+	desc = buffer + sizeof(*hdr);
 
 	down_read(&nvmet_ana_sem);
 	for (grpid = 1; grpid <= NVMET_MAX_ANAGRPS; grpid++) {
 		if (!nvmet_ana_group_enabled[grpid])
 			continue;
-		len = nvmet_format_ana_group(req, grpid, desc);
-		status = nvmet_copy_to_sgl(req, offset, desc, len);
-		if (status)
-			break;
-		offset += len;
+		nvmet_format_ana_group(req, grpid, desc);
 		ngrps++;
 	}
 	for ( ; grpid <= NVMET_MAX_ANAGRPS; grpid++) {
@@ -299,15 +304,15 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 			ngrps++;
 	}
 
-	hdr.chgcnt = cpu_to_le64(nvmet_ana_chgcnt);
-	hdr.ngrps = cpu_to_le16(ngrps);
+	hdr->chgcnt = cpu_to_le64(nvmet_ana_chgcnt);
+	hdr->ngrps = cpu_to_le16(ngrps);
 	nvmet_clear_aen_bit(req, NVME_AEN_BIT_ANA_CHANGE);
 	up_read(&nvmet_ana_sem);
 
-	kfree(desc);
+	status = nvmet_copy_to_sgl(req, 0, buffer + offset,
+				   nvmet_get_log_page_len(req->cmd));
 
-	/* copy the header last once we know the number of groups */
-	status = nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
+	kfree(buffer);
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.29.2

