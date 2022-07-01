Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429125636DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiGAP0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGAP0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:26:45 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF8637A8E;
        Fri,  1 Jul 2022 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1656689201;
        bh=ClmFZdrry37fw+lLLqr/AuaNad18Sy2Q0QcUtSkGe9A=;
        h=Message-ID:Subject:From:To:Date:From;
        b=Q5RNptTIimb2bU3TS9aoh0YBafyy2dU4gR6GJGkOirnzqU7ECFSXpWzt3dItEvc41
         6ssU24Q/F4ZRukJJDkI8FSsGftLM2/FRIgrJDMPBvoL3D+B05jqLmfd3yKAf/z9qV9
         PJFf1sygxIXG6Df+Zby6/VTUB3/boLb9uP6W9DZI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 960541281DD1;
        Fri,  1 Jul 2022 11:26:41 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NmyzEZW45oK9; Fri,  1 Jul 2022 11:26:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1656689201;
        bh=ClmFZdrry37fw+lLLqr/AuaNad18Sy2Q0QcUtSkGe9A=;
        h=Message-ID:Subject:From:To:Date:From;
        b=Q5RNptTIimb2bU3TS9aoh0YBafyy2dU4gR6GJGkOirnzqU7ECFSXpWzt3dItEvc41
         6ssU24Q/F4ZRukJJDkI8FSsGftLM2/FRIgrJDMPBvoL3D+B05jqLmfd3yKAf/z9qV9
         PJFf1sygxIXG6Df+Zby6/VTUB3/boLb9uP6W9DZI=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EF6FB1281C51;
        Fri,  1 Jul 2022 11:26:40 -0400 (EDT)
Message-ID: <ace8c857f48306f2c63169d85baf1f539f3a4fbd.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.19-rc4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 01 Jul 2022 11:26:39 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One simple driver fix for a dma overrun.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

John Garry (1):
      scsi: hisi_sas: Limit max hw sectors for v3 HW

And the diffstat:

 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 7 +++++++
 1 file changed, 7 insertions(+)

With full diff below.

James

---

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 7d819fc0395e..eb86afb21aab 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2782,6 +2782,7 @@ static int slave_configure_v3_hw(struct scsi_device *sdev)
 	struct hisi_hba *hisi_hba = shost_priv(shost);
 	struct device *dev = hisi_hba->dev;
 	int ret = sas_slave_configure(sdev);
+	unsigned int max_sectors;
 
 	if (ret)
 		return ret;
@@ -2799,6 +2800,12 @@ static int slave_configure_v3_hw(struct scsi_device *sdev)
 		}
 	}
 
+	/* Set according to IOMMU IOVA caching limit */
+	max_sectors = min_t(size_t, queue_max_hw_sectors(sdev->request_queue),
+			    (PAGE_SIZE * 32) >> SECTOR_SHIFT);
+
+	blk_queue_max_hw_sectors(sdev->request_queue, max_sectors);
+
 	return 0;
 }
 

