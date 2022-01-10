Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF97E48983B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245239AbiAJMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:03:50 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:55864 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245195AbiAJMDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:03:35 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 6tOcndEAwLyIy6tOdnXf7n; Mon, 10 Jan 2022 13:03:32 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 10 Jan 2022 13:03:32 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hch@lst.de, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org
Subject: [PATCH v2] scsi: pmcraid: Fix memory allocation in 'pmcraid_alloc_sglist()'
Date:   Mon, 10 Jan 2022 13:02:53 +0100
Message-Id: <11a1bc98501de37baa5bcd10b61136f6e450b82e.1641816080.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the scatter list is allocated in 'pmcraid_alloc_sglist()', the
corresponding pointer should be stored in 'scatterlist' within the
'pmcraid_sglist' structure. Otherwise, 'scatterlist' is NULL.

This leads to a potential memory leak and NULL pointer dereference.

Fixes: ed4414cef2ad ("scsi: pmcraid: Use sgl_alloc_order() and sgl_free_order()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is completely speculative and untested.

Should it be correct, I think that their should be some trouble somewhere.
Either NULL pointer dereference or incorrect behavior.
The patch that introduced this potential bug is from 2018-02. So, this
should have been spotted earlier.

So unless this driver is mostly unused, this looks odd to me.
Feedback appreciated.

Review with care!

v2: synch with -next-20220110
---
 drivers/scsi/pmcraid.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 928532180d32..e314ea133827 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3221,8 +3221,9 @@ static struct pmcraid_sglist *pmcraid_alloc_sglist(int buflen)
 		return NULL;
 
 	sglist->order = order;
-	sgl_alloc_order(buflen, order, false, GFP_KERNEL | __GFP_ZERO,
-			&sglist->num_sg);
+	sglist->scatterlist = sgl_alloc_order(buflen, order, false,
+					      GFP_KERNEL | __GFP_ZERO,
+					      &sglist->num_sg);
 
 	return sglist;
 }
-- 
2.32.0

