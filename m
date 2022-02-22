Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6C44BF29F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiBVHXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:23:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiBVHXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:23:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD338CDAF;
        Mon, 21 Feb 2022 23:22:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ECB4611D6;
        Tue, 22 Feb 2022 07:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6174CC340E8;
        Tue, 22 Feb 2022 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645514562;
        bh=cVN6s5q2QWyjNoZlX6Op8Vx2PlbO9x+lAycqiMMemRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3cX1Dg48Hes+NYmcLo3vfSrP0WJGNcGPvWZ/JFeqZs8gytcG0O+2iFRETDmsxUxq
         PTMgVog7Si+u5B2AoMnFuyQy3hEofjlbKnQ/rW6ii8Q0i5CBm3unn/S+5/+Ce5fZs8
         +Q9g6JiSc2y5M47R2UaFtupqYLTU9bYYzbY7IFZ+UG1uxG+zGkGAyJaKQPD2FQd0lT
         NI1CZHgbtSZhEjn6rOKE6/u3I+BgBCJrCCsHTT0eHRUWDY6gOkXqyIjrCha/Gv9Tiq
         od6ksIC+qov5oXTwObytin+/zeOPGv7GYPQ8IF9p7t8/O5vkED8hfP7L4IbxV5DhKD
         TpJ3hnA4RdFpw==
Date:   Tue, 22 Feb 2022 01:30:35 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 6/8][next] scsi: aacraid: Replace one-element array with
 flexible-array member in struct sgmapraw
Message-ID: <141553000a3dcfcf01cc3de08e6be17bdfd9f80a.1645513670.git.gustavoars@kernel.org>
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

Replace one-element array with flexible-array member in struct sgmapraw.

This issue was found with the help of Coccinelle and audited and fixed,
manually.

Link: https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/aacraid/aachba.c  | 18 ++++++------------
 drivers/scsi/aacraid/aacraid.h |  2 +-
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 02b75a2c3a88..5c089993cf2a 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -1224,7 +1224,8 @@ static void io_callback(void *context, struct fib * fibptr);
 static int aac_read_raw_io(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u32 count)
 {
 	struct aac_dev *dev = fib->dev;
-	u16 fibsize, command;
+	size_t fibsize;
+	u16 command;
 	long ret;
 
 	aac_fib_init(fib);
@@ -1262,8 +1263,7 @@ static int aac_read_raw_io(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u3
 		if (ret < 0)
 			return ret;
 		command = ContainerRawIo;
-		fibsize = sizeof(struct aac_raw_io) +
-			((le32_to_cpu(readcmd->sg.count)-1) * sizeof(struct sgentryraw));
+		fibsize = struct_size(readcmd, sg.sg, le32_to_cpu(readcmd->sg.count));
 	}
 
 	BUG_ON(fibsize > (fib->dev->max_fib_size - sizeof(struct aac_fibhdr)));
@@ -1348,7 +1348,8 @@ static int aac_read_block(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u32
 static int aac_write_raw_io(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u32 count, int fua)
 {
 	struct aac_dev *dev = fib->dev;
-	u16 fibsize, command;
+	size_t fibsize;
+	u16 command;
 	long ret;
 
 	aac_fib_init(fib);
@@ -1392,8 +1393,7 @@ static int aac_write_raw_io(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u
 		if (ret < 0)
 			return ret;
 		command = ContainerRawIo;
-		fibsize = sizeof(struct aac_raw_io) +
-			((le32_to_cpu(writecmd->sg.count)-1) * sizeof (struct sgentryraw));
+		fibsize = struct_size(writecmd, sg.sg, le32_to_cpu(writecmd->sg.count));
 	}
 
 	BUG_ON(fibsize > (fib->dev->max_fib_size - sizeof(struct aac_fibhdr)));
@@ -3861,12 +3861,6 @@ static long aac_build_sgraw(struct scsi_cmnd *scsicmd, struct sgmapraw *psg)
 
 	// Get rid of old data
 	psg->count = 0;
-	psg->sg[0].next = 0;
-	psg->sg[0].prev = 0;
-	psg->sg[0].addr[0] = 0;
-	psg->sg[0].addr[1] = 0;
-	psg->sg[0].count = 0;
-	psg->sg[0].flags = 0;
 
 	nseg = scsi_dma_map(scsicmd);
 	if (nseg <= 0)
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index fa5a93b4dc7b..511a58ec5c9d 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -526,7 +526,7 @@ struct user_sgmap64 {
 
 struct sgmapraw {
 	__le32		  count;
-	struct sgentryraw sg[1];
+	struct sgentryraw sg[];
 };
 
 struct user_sgmapraw {
-- 
2.27.0

