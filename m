Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCC947EC7A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 08:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351748AbhLXHHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 02:07:31 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:60108 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351729AbhLXHHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:07:30 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 0efon3FeU65jH0efonacMZ; Fri, 24 Dec 2021 08:07:29 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 24 Dec 2021 08:07:29 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] scsi: lpfc: Make sure to completely clear some bitmaps
Date:   Fri, 24 Dec 2021 08:07:27 +0100
Message-Id: <78647b840c6e83b9b185541b12382c30a99d1788.1640328930.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1640328930.git.christophe.jaillet@wanadoo.fr>
References: <cover.1640328930.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the 'phba->fcf.fcf_rr_bmask' bitmap is cleared, the code makes the
assumption that it fits in only 1 long.
Depending on the value of LPFC_SLI4_FCF_TBL_INDX_MAX, this may be wrong
and only part of the bitmap would be cleared.

Up to now, LPFC_SLI4_FCF_TBL_INDX_MAX is 32, so it is not an issue. But
using bitmap_zero() is more future proof.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 7 ++++---
 drivers/scsi/lpfc/lpfc_sli.c     | 3 +--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 816fc406135b..5f142ee639ad 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -1517,7 +1517,8 @@ lpfc_sli4_clear_fcf_rr_bmask(struct lpfc_hba *phba)
 {
 	struct lpfc_fcf_pri *fcf_pri;
 	struct lpfc_fcf_pri *next_fcf_pri;
-	memset(phba->fcf.fcf_rr_bmask, 0, sizeof(*phba->fcf.fcf_rr_bmask));
+
+	bitmap_zero(phba->fcf.fcf_rr_bmask, LPFC_SLI4_FCF_TBL_INDX_MAX);
 	spin_lock_irq(&phba->hbalock);
 	list_for_each_entry_safe(fcf_pri, next_fcf_pri,
 				&phba->fcf.fcf_pri_list, list) {
@@ -2476,8 +2477,8 @@ static int lpfc_sli4_fcf_pri_list_add(struct lpfc_hba *phba,
 	if (new_fcf_pri->fcf_rec.priority <=  current_fcf_pri) {
 		list_add(&new_fcf_pri->list, &phba->fcf.fcf_pri_list);
 		if (new_fcf_pri->fcf_rec.priority <  current_fcf_pri) {
-			memset(phba->fcf.fcf_rr_bmask, 0,
-				sizeof(*phba->fcf.fcf_rr_bmask));
+			bitmap_zero(phba->fcf.fcf_rr_bmask,
+				    LPFC_SLI4_FCF_TBL_INDX_MAX);
 			/* fcfs_at_this_priority_level = 1; */
 			phba->fcf.eligible_fcf_cnt = 1;
 		} else
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 1bc0db572d9e..9ea1b0db42a6 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -20220,8 +20220,7 @@ lpfc_check_next_fcf_pri_level(struct lpfc_hba *phba)
 	 * Clear the rr_bmask and set all of the bits that are at this
 	 * priority.
 	 */
-	memset(phba->fcf.fcf_rr_bmask, 0,
-			sizeof(*phba->fcf.fcf_rr_bmask));
+	bitmap_zero(phba->fcf.fcf_rr_bmask, LPFC_SLI4_FCF_TBL_INDX_MAX);
 	spin_lock_irq(&phba->hbalock);
 	list_for_each_entry(fcf_pri, &phba->fcf.fcf_pri_list, list) {
 		if (fcf_pri->fcf_rec.flag & LPFC_FCF_FLOGI_FAILED)
-- 
2.32.0

