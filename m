Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7446F633
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhLIVyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:54:46 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:64362 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhLIVym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:54:42 -0500
Received: from ubuntu-CJ.sitez.s.ibrowse.com ([146.0.31.27])
        by smtp.orange.fr with ESMTPA
        id vRJimeJelMNzvvRJimHHSO; Thu, 09 Dec 2021 22:51:07 +0100
X-ME-Helo: ubuntu-CJ.sitez.s.ibrowse.com
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 09 Dec 2021 22:51:07 +0100
X-ME-IP: 146.0.31.27
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     james.smart@broadcom.com, ram.vegesna@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de,
        dwagner@suse.de
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: elx: efct: Avoid a useless memset
Date:   Thu,  9 Dec 2021 22:51:04 +0100
Message-Id: <009cddb72f4a1b6d1744d5a8ab1955eb93509e41.1639086550.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'io->sgl' is kzalloced just a few lines above. There is no need to memset
it another time.


Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/elx/efct/efct_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/elx/efct/efct_io.c b/drivers/scsi/elx/efct/efct_io.c
index 71e21655916a..e483d936342b 100644
--- a/drivers/scsi/elx/efct/efct_io.c
+++ b/drivers/scsi/elx/efct/efct_io.c
@@ -62,7 +62,6 @@ efct_io_pool_create(struct efct *efct, u32 num_sgl)
 			return NULL;
 		}
 
-		memset(io->sgl, 0, sizeof(*io->sgl) * num_sgl);
 		io->sgl_allocated = num_sgl;
 		io->sgl_count = 0;
 
-- 
2.32.0

