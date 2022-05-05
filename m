Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4812D51C142
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380069AbiEENvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380004AbiEENvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:51:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EA657983;
        Thu,  5 May 2022 06:47:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n10so8856227ejk.5;
        Thu, 05 May 2022 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9QKZUK4bdyy+uG1UycNOMbAlDaNnK9qZ/IqgLIv4+L0=;
        b=RiGqbaZJ8DLPVryr8gOo9oueAC2XT77ogsIkuaiqlVj69JfMvdEe496R/G/toqFuEM
         dTAimQcK/DoQebyrEB3/KhKSoNEFd68d9XgCapVgKYZ87kSkFpJDeJF+3P9XUphy6DrN
         z6KWdaXPnSJ3WbbB131BvFUcKZXsqsV6SVhPLm7JpZmw7XdMx2rjQITbbbqMFI1kDZZ1
         LWkaH62GZP/80oWWhHRyXMDpVL+WZfcZGw9O7T5lLpWYtWV9hpFvXbJZW2+cM93/1AOh
         MWBM+LYb8DxFeMO5FZLV8INzBQvE9wdoLkbvWamiPa2BGAtCcUwXLTuiVy9xitY3Ql+y
         Dgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9QKZUK4bdyy+uG1UycNOMbAlDaNnK9qZ/IqgLIv4+L0=;
        b=tCYqgUiPyAkT3oeDNFPSqpF1pWltzLWvP3OdVIklEHM/JGh+X50KvxGQ9EYgGNnNS6
         rGmYpdAu5Q9JMoGV6oDrM29RP3riO/v9hjdvtHbIISGVDnbCNK1eXuNUmsK76sPpsB1B
         ya12t+SA10VL0jimweGj+ayI0RhkIVSnlErwnQYVj61mC94byDfG8n2qnZVXdkR3vUXA
         XO+UT3IdMItHbi2ukPCafdwSbitLY4rPonzRror1x6KMpnZi6OCUGKJC/Nfg2ZkMFQ7E
         AaeMYYI8TvRqrOm8q4mMGZBxe+QLFkiUYgre+miqNXbbhjQGy7OYZR4wwHpJ5lTEWvJp
         wumQ==
X-Gm-Message-State: AOAM533pDsSd7xQEM3eAjyujhifC5Hla8hXZZ8tbDmHEYnCBKFa4N4fe
        Dm/p1X1x+3X9je92nHtxfK4=
X-Google-Smtp-Source: ABdhPJwMlMoacefutCUyt8y8KcI2wSgS3+M9++q/aKOSi01UzKpkx35l/ntWLSBfHe/OHSFBZAsuSw==
X-Received: by 2002:a17:906:a454:b0:6f3:98ab:473d with SMTP id cb20-20020a170906a45400b006f398ab473dmr25960129ejb.423.1651758441986;
        Thu, 05 May 2022 06:47:21 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906301a00b006f3ef214e69sm728324ejz.207.2022.05.05.06.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:47:21 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com,
        keosung.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] scsi: ufshpb: Add handing of device reset HPB regions Infos in HPB device mode
Date:   Thu,  5 May 2022 15:47:06 +0200
Message-Id: <20220505134707.35929-6-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220505134707.35929-1-huobean@gmail.com>
References: <20220505134707.35929-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

In UFS HPB Spec JESD220-3A,

"5.8. Active and inactive information upon power cycle
...
When the device is powered off by the host, the device may restore L2P map data
upon power up or build from the host’s HPB READ command. In case device powered
up and lost HPB information, device can signal to the host through HPB Sense data,
by setting HPB Operation as ‘2’ which will inform the host that device reset HPB
information."

Therefore, for HPB device control mode, if the UFS device is reset via the RST_N
pin, the active region information in the device will be reset. If the host side
receives this notification from the device side, it is recommended to inactivate
all active regions in the host's HPB cache.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/scsi/ufs/ufshpb.c | 82 +++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 4833f20cc7d0..859e7ee7bf57 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -1137,6 +1137,39 @@ static int ufshpb_add_region(struct ufshpb_lu *hpb, struct ufshpb_region *rgn)
 	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
 	return ret;
 }
+/**
+ *ufshpb_submit_region_inactive() - submit a region to be inactivated later
+ *@hpb: per-LU HPB instance
+ *@region_index: the index associated with the region that will be inactivated later
+ */
+static void ufshpb_submit_region_inactive(struct ufshpb_lu *hpb, int region_index)
+{
+	int subregion_index;
+	struct ufshpb_region *rgn;
+	struct ufshpb_subregion *srgn;
+
+	/*
+	 * Remove this region from active region list and add it to inactive list
+	 */
+	spin_lock(&hpb->rsp_list_lock);
+	ufshpb_update_inactive_info(hpb, region_index);
+	spin_unlock(&hpb->rsp_list_lock);
+
+	rgn = hpb->rgn_tbl + region_index;
+
+	/*
+	 * Set subregion state to be HPB_SRGN_INVALID, there will no HPB read on this subregion
+	 */
+	spin_lock(&hpb->rgn_state_lock);
+	if (rgn->rgn_state != HPB_RGN_INACTIVE) {
+		for (subregion_index = 0; subregion_index < rgn->srgn_cnt; subregion_index++) {
+			srgn = rgn->srgn_tbl + subregion_index;
+			if (srgn->srgn_state == HPB_SRGN_VALID)
+				srgn->srgn_state = HPB_SRGN_INVALID;
+		}
+	}
+	spin_unlock(&hpb->rgn_state_lock);
+}
 
 static void ufshpb_rsp_req_region_update(struct ufshpb_lu *hpb,
 					 struct utp_hpb_rsp *rsp_field)
@@ -1196,25 +1229,8 @@ static void ufshpb_rsp_req_region_update(struct ufshpb_lu *hpb,
 
 	for (i = 0; i < rsp_field->inactive_rgn_cnt; i++) {
 		rgn_i = be16_to_cpu(rsp_field->hpb_inactive_field[i]);
-		dev_dbg(&hpb->sdev_ufs_lu->sdev_dev,
-			"inactivate(%d) region %d\n", i, rgn_i);
-
-		spin_lock(&hpb->rsp_list_lock);
-		ufshpb_update_inactive_info(hpb, rgn_i);
-		spin_unlock(&hpb->rsp_list_lock);
-
-		rgn = hpb->rgn_tbl + rgn_i;
-
-		spin_lock(&hpb->rgn_state_lock);
-		if (rgn->rgn_state != HPB_RGN_INACTIVE) {
-			for (srgn_i = 0; srgn_i < rgn->srgn_cnt; srgn_i++) {
-				srgn = rgn->srgn_tbl + srgn_i;
-				if (srgn->srgn_state == HPB_SRGN_VALID)
-					srgn->srgn_state = HPB_SRGN_INVALID;
-			}
-		}
-		spin_unlock(&hpb->rgn_state_lock);
-
+		dev_dbg(&hpb->sdev_ufs_lu->sdev_dev, "inactivate(%d) region %d\n", i, rgn_i);
+		ufshpb_submit_region_inactive(hpb, rgn_i);
 	}
 
 out:
@@ -1249,14 +1265,32 @@ static void ufshpb_dev_reset_handler(struct ufs_hba *hba)
 
 	__shost_for_each_device(sdev, hba->host) {
 		hpb = ufshpb_get_hpb_data(sdev);
-		if (hpb && hpb->is_hcm)
+		if (!hpb)
+			continue;
+
+		if (hpb->is_hcm) {
 			/*
-			 * For the HPB host mode, in case device powered up and lost HPB
-			 * information, we will set the region flag to be RGN_FLAG_UPDATE,
-			 * it will let host reload its L2P entries(re-activate the region
-			 * in the UFS device).
+			 * For the HPB host control mode, in case device powered up and lost HPB
+			 * information, we will set the region flag to be RGN_FLAG_UPDATE, it will
+			 * let host reload its L2P entries(reactivate region in the UFS device).
 			 */
 			ufshpb_set_regions_update(hpb);
+		} else {
+			/*
+			 * For the HPB device control mode, if host side receives 02h:HPB Operation
+			 * in UPIU response, which means device recommends the host side should
+			 * inactivate all active regions. Here we add all active regions to inactive
+			 * list, they will be inactivated later in ufshpb_map_work_handler().
+			 */
+			struct victim_select_info *lru_info = &hpb->lru_info;
+			struct ufshpb_region *rgn;
+
+			list_for_each_entry(rgn, &lru_info->lh_lru_rgn, list_lru_rgn)
+				ufshpb_submit_region_inactive(hpb, rgn->rgn_idx);
+
+			if (ufshpb_get_state(hpb) == HPB_PRESENT)
+				queue_work(ufshpb_wq, &hpb->map_work);
+		}
 	}
 }
 
-- 
2.34.1

