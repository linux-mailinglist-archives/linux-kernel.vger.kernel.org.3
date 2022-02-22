Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3BF4BF28F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiBVHWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:22:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiBVHV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:21:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD227151;
        Mon, 21 Feb 2022 23:21:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9FF86119B;
        Tue, 22 Feb 2022 07:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F25C340E8;
        Tue, 22 Feb 2022 07:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645514491;
        bh=vybhf/bdeS9thoWgfLwfs9BW8K9Pb0wuGlFfmM+53TI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOwA4S/URYy+qsOUf44pr0kTH4rLHx4hdeiwNhLQRU4VXHmRSLjeHtNvnvyFujTdP
         b3twbCFP7Piy/EhnYZmKHHcByel70bilekFv2laJoaPBLYa2PsfTdGnCO0fRoLvM4q
         wQes/2x7yeLi9R/REZYJ8AOu4TphjeO9f+mJP/csW1LXCrD36GhFxK0vUOumO5XMXF
         QZ5DSaOCiKQFI7kkHJtoGjQB21yld9zJEtEVjRuigZR8DeerMJE3ZmU+/rjSPui4Rm
         +YuARY5nwnzy4LQz9au2Xh1+Dun+Y45XbU0d9XcXhdRVHUTYcgLh0+3P2Hj65vemur
         fvodaiGnvlS1A==
Date:   Tue, 22 Feb 2022 01:29:24 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 2/8][next] scsi: aacraid: Replace one-element array with
 flexible-array member in struct sgmap
Message-ID: <2262eb3384bbc71b9ed4fcbf04ab8a072bacd35f.1645513670.git.gustavoars@kernel.org>
References: <cover.1645513670.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645513670.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace one-element array with flexible-array member in struct sgmap.

Also, make use of the struct_size() helper and refactor the code
according to the flexible array transformation.

This issue was found with the help of Coccinelle and audited and fixed,
manually.

Link: https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/aacraid/aachba.c   | 38 +++++++++++----------------------
 drivers/scsi/aacraid/aacraid.h  |  2 +-
 drivers/scsi/aacraid/commctrl.c |  3 +--
 drivers/scsi/aacraid/comminit.c |  3 +--
 4 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 98100e28e95e..5014d8374916 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -1316,7 +1316,7 @@ static int aac_read_block64(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u
 
 static int aac_read_block(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u32 count)
 {
-	u16 fibsize;
+	size_t fibsize;
 	struct aac_read *readcmd;
 	struct aac_dev *dev = fib->dev;
 	long ret;
@@ -1332,9 +1332,7 @@ static int aac_read_block(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u32
 	ret = aac_build_sg(cmd, &readcmd->sg);
 	if (ret < 0)
 		return ret;
-	fibsize = sizeof(struct aac_read) +
-			((le32_to_cpu(readcmd->sg.count) - 1) *
-			 sizeof (struct sgentry));
+	fibsize = struct_size(readcmd, sg.sg, le32_to_cpu(readcmd->sg.count));
 	BUG_ON (fibsize > (fib->dev->max_fib_size -
 				sizeof(struct aac_fibhdr)));
 	/*
@@ -1450,7 +1448,7 @@ static int aac_write_block64(struct fib * fib, struct scsi_cmnd * cmd, u64 lba,
 
 static int aac_write_block(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u32 count, int fua)
 {
-	u16 fibsize;
+	size_t fibsize;
 	struct aac_write *writecmd;
 	struct aac_dev *dev = fib->dev;
 	long ret;
@@ -1468,9 +1466,7 @@ static int aac_write_block(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u3
 	ret = aac_build_sg(cmd, &writecmd->sg);
 	if (ret < 0)
 		return ret;
-	fibsize = sizeof(struct aac_write) +
-		((le32_to_cpu(writecmd->sg.count) - 1) *
-		 sizeof (struct sgentry));
+	fibsize = struct_size(writecmd, sg.sg, le32_to_cpu(writecmd->sg.count));
 	BUG_ON (fibsize > (fib->dev->max_fib_size -
 				sizeof(struct aac_fibhdr)));
 	/*
@@ -1574,8 +1570,8 @@ static void aac_srb_callback(void *context, struct fib * fibptr);
 
 static int aac_scsi_64(struct fib * fib, struct scsi_cmnd * cmd)
 {
-	u16 fibsize;
-	struct aac_srb * srbcmd = aac_scsi_common(fib, cmd);
+	size_t fibsize;
+	struct aac_srb *srbcmd = aac_scsi_common(fib, cmd);
 	long ret;
 
 	ret = aac_build_sg64(cmd, (struct sgmap64 *) &srbcmd->sg);
@@ -1588,9 +1584,7 @@ static int aac_scsi_64(struct fib * fib, struct scsi_cmnd * cmd)
 	/*
 	 *	Build Scatter/Gather list
 	 */
-	fibsize = sizeof (struct aac_srb) - sizeof (struct sgentry) +
-		((le32_to_cpu(srbcmd->sg.count) & 0xff) *
-		 sizeof (struct sgentry64));
+	fibsize = struct_size(srbcmd, sg.sg, le32_to_cpu(srbcmd->sg.count) & 0xff);
 	BUG_ON (fibsize > (fib->dev->max_fib_size -
 				sizeof(struct aac_fibhdr)));
 
@@ -1605,8 +1599,8 @@ static int aac_scsi_64(struct fib * fib, struct scsi_cmnd * cmd)
 
 static int aac_scsi_32(struct fib * fib, struct scsi_cmnd * cmd)
 {
-	u16 fibsize;
-	struct aac_srb * srbcmd = aac_scsi_common(fib, cmd);
+	size_t fibsize;
+	struct aac_srb *srbcmd = aac_scsi_common(fib, cmd);
 	long ret;
 
 	ret = aac_build_sg(cmd, (struct sgmap *)&srbcmd->sg);
@@ -1619,9 +1613,7 @@ static int aac_scsi_32(struct fib * fib, struct scsi_cmnd * cmd)
 	/*
 	 *	Build Scatter/Gather list
 	 */
-	fibsize = sizeof (struct aac_srb) +
-		(((le32_to_cpu(srbcmd->sg.count) & 0xff) - 1) *
-		 sizeof (struct sgentry));
+	fibsize = struct_size(srbcmd, sg.sg, le32_to_cpu(srbcmd->sg.count) & 0xff);
 	BUG_ON (fibsize > (fib->dev->max_fib_size -
 				sizeof(struct aac_fibhdr)));
 
@@ -1670,7 +1662,7 @@ static int aac_send_safw_bmic_cmd(struct aac_dev *dev,
 	struct fib	*fibptr;
 	dma_addr_t	addr;
 	int		rcode;
-	int		fibsize;
+	size_t		fibsize;
 	struct aac_srb	*srb;
 	struct aac_srb_reply *srb_reply;
 	struct sgmap64	*sg64;
@@ -1689,8 +1681,7 @@ static int aac_send_safw_bmic_cmd(struct aac_dev *dev,
 	fibptr->hw_fib_va->header.XferState &=
 		~cpu_to_le32(FastResponseCapable);
 
-	fibsize  = sizeof(struct aac_srb) - sizeof(struct sgentry) +
-						sizeof(struct sgentry64);
+	fibsize  = sizeof(struct aac_srb) + sizeof(struct sgentry64);
 
 	/* allocate DMA buffer for response */
 	addr = dma_map_single(&dev->pdev->dev, xfer_buf, xfer_len,
@@ -2261,8 +2252,7 @@ int aac_get_adapter_info(struct aac_dev* dev)
 	} else {
 		dev->a_ops.adapter_bounds = aac_bounds_32;
 		dev->scsi_host_ptr->sg_tablesize = (dev->max_fib_size -
-			sizeof(struct aac_fibhdr) -
-			sizeof(struct aac_write) + sizeof(struct sgentry)) /
+			sizeof(struct aac_fibhdr) - sizeof(struct aac_write)) /
 				sizeof(struct sgentry);
 		if (dev->dac_support) {
 			dev->a_ops.adapter_read = aac_read_block64;
@@ -3795,8 +3785,6 @@ static long aac_build_sg(struct scsi_cmnd *scsicmd, struct sgmap *psg)
 
 	// Get rid of old data
 	psg->count = 0;
-	psg->sg[0].addr = 0;
-	psg->sg[0].count = 0;
 
 	nseg = scsi_dma_map(scsicmd);
 	if (nseg <= 0)
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 704440a96daa..320a30865d58 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -506,7 +506,7 @@ struct sge_ieee1212 {
 
 struct sgmap {
 	__le32		count;
-	struct sgentry	sg[1];
+	struct sgentry	sg[];
 };
 
 struct user_sgmap {
diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index e7cc927ed952..5d6b0d9da0df 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -561,8 +561,7 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 		rcode = -EINVAL;
 		goto cleanup;
 	}
-	actual_fibsize = sizeof(struct aac_srb) - sizeof(struct sgentry) +
-		((user_srbcmd->sg.count & 0xff) * sizeof(struct sgentry));
+	actual_fibsize = struct_size(srbcmd, sg.sg, user_srbcmd->sg.count & 0xff);
 	actual_fibsize64 = actual_fibsize + (user_srbcmd->sg.count & 0xff) *
 	  (sizeof(struct sgentry64) - sizeof(struct sgentry));
 	/* User made a mistake - should not continue */
diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index 355b16f0b145..5f4a97f1f562 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -522,8 +522,7 @@ struct aac_dev *aac_init_adapter(struct aac_dev *dev)
 	spin_lock_init(&dev->iq_lock);
 	dev->max_fib_size = sizeof(struct hw_fib);
 	dev->sg_tablesize = host->sg_tablesize = (dev->max_fib_size
-		- sizeof(struct aac_fibhdr)
-		- sizeof(struct aac_write) + sizeof(struct sgentry))
+		- sizeof(struct aac_fibhdr) - sizeof(struct aac_write))
 			/ sizeof(struct sgentry);
 	dev->comm_interface = AAC_COMM_PRODUCER;
 	dev->raw_io_interface = dev->raw_io_64 = 0;
-- 
2.27.0

