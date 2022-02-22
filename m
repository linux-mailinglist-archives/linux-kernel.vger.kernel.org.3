Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09CD4BF287
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiBVHWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:22:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiBVHWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:22:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB775E157;
        Mon, 21 Feb 2022 23:22:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6EE7B81886;
        Tue, 22 Feb 2022 07:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C47C340E8;
        Tue, 22 Feb 2022 07:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645514533;
        bh=N5OOodQM5orTfwFxfN2SOmhucLQF1RkDS9TqftjrLNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cMzj8NyG13mkouqjlCErqMXPMUgHZK2BPGgXvA0o1EAfLn5km3WFeOJYsiPsz0qzu
         dDNf631WPWQKnFxNDkgmfChwk1FTi9yLW4m4VSUSHSqMfqn9Y9DJxTOuCuc6wur+Io
         cd6QoATakgXTVY1vz4ryVo+13Fsrso3yrB+KZJPYg8uWwyjczm77R+x0JW2AvrU1SU
         atlBAmMvC4n637B+VhYLe9H6PxD2HSQwq9xlp8GVMvJejbfpBNjQfvImcP1X4H+TYQ
         9+MwfW4su7gXri2U5UDug1SmYQWqiGNXYv7p0kZ+4J+ZpgUf7UZMgQ0VtBohgz0kmq
         99BDSUeCFVWMQ==
Date:   Tue, 22 Feb 2022 01:30:06 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 4/8][next] scsi: aacraid: Replace one-element array with
 flexible-array member in struct sgmap64
Message-ID: <b01c8a060d5da4a0b13fc518e7989b782d3d4a6a.1645513670.git.gustavoars@kernel.org>
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

Replace one-element array with flexible-array member in struct sgmap64.

Also, make use of the struct_size() helper and refactor the code
according to the flexible array transformation in struct sgmap64.

This issue was found with the help of Coccinelle and audited and fixed,
manually.

Link: https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/aacraid/aachba.c  | 15 +++++----------
 drivers/scsi/aacraid/aacraid.h |  2 +-
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 5014d8374916..02b75a2c3a88 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -1281,7 +1281,7 @@ static int aac_read_raw_io(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u3
 
 static int aac_read_block64(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u32 count)
 {
-	u16 fibsize;
+	size_t fibsize;
 	struct aac_read64 *readcmd;
 	long ret;
 
@@ -1297,9 +1297,7 @@ static int aac_read_block64(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u
 	ret = aac_build_sg64(cmd, &readcmd->sg);
 	if (ret < 0)
 		return ret;
-	fibsize = sizeof(struct aac_read64) +
-		((le32_to_cpu(readcmd->sg.count) - 1) *
-		 sizeof (struct sgentry64));
+	fibsize = struct_size(readcmd, sg.sg, le32_to_cpu(readcmd->sg.count));
 	BUG_ON (fibsize > (fib->dev->max_fib_size -
 				sizeof(struct aac_fibhdr)));
 	/*
@@ -1413,7 +1411,7 @@ static int aac_write_raw_io(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u
 
 static int aac_write_block64(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u32 count, int fua)
 {
-	u16 fibsize;
+	size_t fibsize;
 	struct aac_write64 *writecmd;
 	long ret;
 
@@ -1429,9 +1427,7 @@ static int aac_write_block64(struct fib * fib, struct scsi_cmnd * cmd, u64 lba,
 	ret = aac_build_sg64(cmd, &writecmd->sg);
 	if (ret < 0)
 		return ret;
-	fibsize = sizeof(struct aac_write64) +
-		((le32_to_cpu(writecmd->sg.count) - 1) *
-		 sizeof (struct sgentry64));
+	fibsize = struct_size(writecmd, sg.sg, le32_to_cpu(writecmd->sg.count));
 	BUG_ON (fibsize > (fib->dev->max_fib_size -
 				sizeof(struct aac_fibhdr)));
 	/*
@@ -2263,8 +2259,7 @@ int aac_get_adapter_info(struct aac_dev* dev)
 			dev->scsi_host_ptr->sg_tablesize =
 				(dev->max_fib_size -
 				sizeof(struct aac_fibhdr) -
-				sizeof(struct aac_write64) +
-				sizeof(struct sgentry64)) /
+				sizeof(struct aac_write64)) /
 					sizeof(struct sgentry64);
 		} else {
 			dev->a_ops.adapter_read = aac_read_block;
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index bcf97c1b8c0c..573cb36c2e15 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -516,7 +516,7 @@ struct user_sgmap {
 
 struct sgmap64 {
 	__le32		count;
-	struct sgentry64 sg[1];
+	struct sgentry64 sg[];
 };
 
 struct user_sgmap64 {
-- 
2.27.0

