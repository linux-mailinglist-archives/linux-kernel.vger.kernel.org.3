Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E3A46F5B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhLIVPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:15:37 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:50798 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbhLIVPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:15:35 -0500
Received: from ubuntu-CJ.sitez.s.ibrowse.com ([146.0.31.27])
        by smtp.orange.fr with ESMTPA
        id vQhpme7oIMNzvvQhqmHER9; Thu, 09 Dec 2021 22:11:59 +0100
X-ME-Helo: ubuntu-CJ.sitez.s.ibrowse.com
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 09 Dec 2021 22:11:59 +0100
X-ME-IP: 146.0.31.27
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     don.brace@microchip.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: hpsa: Remove an unused variable in 'hpsa_update_scsi_devices()'
Date:   Thu,  9 Dec 2021 22:11:56 +0100
Message-Id: <9f80ea569867b5f7ae1e0f99d656e5a8bacad34e.1639084205.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'lunzerobits' is unused. Remove it.

This a left over of commit 2d62a33e05d4("hpsa: eliminate fake lun0
enclosures")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/hpsa.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index cdf3328cc065..a47bcce3c9c7 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -4354,7 +4354,6 @@ static void hpsa_update_scsi_devices(struct ctlr_info *h)
 	int i, ndevs_to_allocate;
 	int raid_ctlr_position;
 	bool physical_device;
-	DECLARE_BITMAP(lunzerobits, MAX_EXT_TARGETS);
 
 	currentsd = kcalloc(HPSA_MAX_DEVICES, sizeof(*currentsd), GFP_KERNEL);
 	physdev_list = kzalloc(sizeof(*physdev_list), GFP_KERNEL);
@@ -4368,7 +4367,6 @@ static void hpsa_update_scsi_devices(struct ctlr_info *h)
 		dev_err(&h->pdev->dev, "out of memory\n");
 		goto out;
 	}
-	memset(lunzerobits, 0, sizeof(lunzerobits));
 
 	h->drv_req_rescan = 0; /* cancel scheduled rescan - we're doing it. */
 
-- 
2.32.0

