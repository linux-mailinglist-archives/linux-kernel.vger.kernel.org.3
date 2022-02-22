Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CE14BF298
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiBVHV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:21:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiBVHV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:21:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCA2116283;
        Mon, 21 Feb 2022 23:21:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82B20B81887;
        Tue, 22 Feb 2022 07:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF44C340E8;
        Tue, 22 Feb 2022 07:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645514461;
        bh=SjGYmTvLuGxpF6c1ZqY3bkENDPqYxpdfVh3sFIBch68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqWpOcW24adstDslnETNO2vFjjYqK4MMLH5y4UXr05HgLEF/7UexG/6E21GFxCJ+c
         7Rj1MKB3vEfpTOyq/ndTSN60oawhXlg8W0y/OmNEpxfVmJJw1X0oUt7B5Pq2yFFKcH
         8Yty02GN6JGPBmpxlWVmW0J3SB41uY/Ang3sghMOT5vUcPnYc/5K7GDRRsr96FD4vA
         yuJPHeNBuWedDSkRZVGVqKWkFgY/FoQkGVEh1QpD4c2bkqBF+Bb0LER8cfaoIa/C6h
         LlKaP89wCttGS+cbSnsd7z2soRM0qj66tIufI4UlJ+Mdesmx7UT6CRqCOuY530+aKT
         GugIgZOu4Gv6g==
Date:   Tue, 22 Feb 2022 01:28:54 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 1/8][next] scsi: aacraid: Replace one-element array with
 flexible-array member
Message-ID: <1fb4b0263611e3a28d94c5aba4b7c3d7c7791675.1645513670.git.gustavoars@kernel.org>
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

Replace one-element array with flexible-array member in struct
aac_ciss_phys_luns_resp.

Also, use the struct_size() helper to properly calculate the total size
for allocation.

This issue was found with the help of Coccinelle and audited and fixed,
manually.

Link: https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/aacraid/aachba.c  | 5 ++---
 drivers/scsi/aacraid/aacraid.h | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index b04d039da276..98100e28e95e 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -1823,13 +1823,12 @@ static inline void aac_free_safw_ciss_luns(struct aac_dev *dev)
 static int aac_get_safw_ciss_luns(struct aac_dev *dev)
 {
 	int rcode = -ENOMEM;
-	int datasize;
+	size_t datasize;
 	struct aac_srb *srbcmd;
 	struct aac_srb_unit srbu;
 	struct aac_ciss_phys_luns_resp *phys_luns;
 
-	datasize = sizeof(struct aac_ciss_phys_luns_resp) +
-		(AAC_MAX_TARGETS - 1) * sizeof(struct _ciss_lun);
+	datasize = struct_size(phys_luns, lun, AAC_MAX_TARGETS);
 	phys_luns = kmalloc(datasize, GFP_KERNEL);
 	if (phys_luns == NULL)
 		goto out;
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 3733df77bc65..704440a96daa 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -321,7 +321,7 @@ struct aac_ciss_phys_luns_resp {
 		u8	level3[2];
 		u8	level2[2];
 		u8	node_ident[16];	/* phys. node identifier */
-	} lun[1];			/* List of phys. devices */
+	} lun[];			/* List of phys. devices */
 };
 
 /*
-- 
2.27.0

