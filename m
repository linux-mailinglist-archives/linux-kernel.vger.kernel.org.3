Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D9C47EC77
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 08:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351737AbhLXHHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 02:07:20 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:53148 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351729AbhLXHHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:07:20 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 0efen3FZU65jH0efenacKX; Fri, 24 Dec 2021 08:07:18 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 24 Dec 2021 08:07:18 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] scsi: lpfc: Use bitmap_zalloc() when applicable
Date:   Fri, 24 Dec 2021 08:07:17 +0100
Message-Id: <bf45160e2715b30ceacc83ab37b5310941b91629.1640328930.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1640328930.git.christophe.jaillet@wanadoo.fr>
References: <cover.1640328930.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'phba->fcf.fcf_rr_bmask' is a bitmap. So use bitmap_zalloc() to simplify
code, improve the semantic and avoid some open-coded arithmetic in
allocator arguments.

Also change the corresponding kfree() into bitmap_free() to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/lpfc/lpfc_init.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index a56f01f659f8..39e6e53773ee 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7858,7 +7858,6 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	LPFC_MBOXQ_t *mboxq;
 	MAILBOX_t *mb;
 	int rc, i, max_buf_size;
-	int longs;
 	int extra;
 	uint64_t wwn;
 	u32 if_type;
@@ -8286,9 +8285,8 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	}
 
 	/* Allocate eligible FCF bmask memory for FCF roundrobin failover */
-	longs = (LPFC_SLI4_FCF_TBL_INDX_MAX + BITS_PER_LONG - 1)/BITS_PER_LONG;
-	phba->fcf.fcf_rr_bmask = kcalloc(longs, sizeof(unsigned long),
-					 GFP_KERNEL);
+	phba->fcf.fcf_rr_bmask = bitmap_zalloc(LPFC_SLI4_FCF_TBL_INDX_MAX,
+					       GFP_KERNEL);
 	if (!phba->fcf.fcf_rr_bmask) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2759 Failed allocate memory for FCF round "
@@ -8387,7 +8385,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 out_free_hba_eq_hdl:
 	kfree(phba->sli4_hba.hba_eq_hdl);
 out_free_fcf_rr_bmask:
-	kfree(phba->fcf.fcf_rr_bmask);
+	bitmap_free(phba->fcf.fcf_rr_bmask);
 out_remove_rpi_hdrs:
 	lpfc_sli4_remove_rpi_hdrs(phba);
 out_free_active_sgl:
@@ -8441,7 +8439,7 @@ lpfc_sli4_driver_resource_unset(struct lpfc_hba *phba)
 	lpfc_sli4_remove_rpis(phba);
 
 	/* Free eligible FCF index bmask */
-	kfree(phba->fcf.fcf_rr_bmask);
+	bitmap_free(phba->fcf.fcf_rr_bmask);
 
 	/* Free the ELS sgl list */
 	lpfc_free_active_sgl(phba);
-- 
2.32.0

