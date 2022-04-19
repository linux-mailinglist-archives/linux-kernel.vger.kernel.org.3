Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCDC507923
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbiDSSjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357621AbiDSShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:37:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3693FDAC;
        Tue, 19 Apr 2022 11:30:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 21so22452586edv.1;
        Tue, 19 Apr 2022 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=quF0kGFJZARtpZdxF32uHKlym+kdTs0MbLMlThQPGOk=;
        b=ALdJe0/n8CLQQkXATOw+mP6ETLroIdVvEXBh4bny8gcUHVzwFdgyQOYGaG3LLVBsOy
         R6CNsgFGBmNN0HLHdZMhmGFrFpLmvoml3mrYl4orTrSP8FjiKKl6motRIinRA8JbZhq1
         fGJXKqnvmz9ZXIFsUPwOF9JlnAsk3TqPA4xZnqoGhk7Qey9Mv6m6BcLJCco+tUO7JzaK
         q5Hv0k5D77eU+ohxtQ0XPZDZ3b+/Iq3NSEjYjrKlQu+F+l6VSss+WxH9oL0foBO9Wn93
         DVjDKVQlTsaIgvIkypzh3UINVqr9zaMxcTbEpxyUxb5FPjBx1G5GKtNc7ifzJdPiCNf+
         Od+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=quF0kGFJZARtpZdxF32uHKlym+kdTs0MbLMlThQPGOk=;
        b=1+y4zeP1mCmOrOdzzV6VLZsIzV0mSVX0i59C88ODx9XRr1geHarYTpnHNjmOmNwuLh
         /PsS6xp9DaM+VkELoNB5FL08jzgdaL9d5Gx0/U7XxgkyQl8Qid88wNXitmhXfYKtbO3a
         SfblcOzcpKYSFQrio+cHcKMpcifXN+6YErLVB8fS2KPQTYJaaBKCPcAs0ugvhsAUMAST
         RR0kvcRQ9A+M+50M3xE0UyKTuVB8yxE5AAdzeBfW2qmTPeqHN9VoqbBD4604C8xiuURy
         5VyTISNGzAX+6JIuc6xqUgtglnJHIulBoK/7A0QcrYDap2UjhnGFAtnxdhQiaC5v0reX
         wzGw==
X-Gm-Message-State: AOAM532thZIQC+nvoeGBcXzclQagS3ra2cEa8CNFLX9QeIMcwl5Nx1B8
        rGc0c4WKzbn5uEzifbmuF1U=
X-Google-Smtp-Source: ABdhPJyWEhY+u7KTDVJXiiqlYrBD+6qdbWkkxBlC3rcgahcZC2o0tXsZyNRMLfckCmul0NN+FKI0RQ==
X-Received: by 2002:aa7:db0f:0:b0:41d:7b44:2613 with SMTP id t15-20020aa7db0f000000b0041d7b442613mr18735469eds.126.1650393057426;
        Tue, 19 Apr 2022 11:30:57 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id bq23-20020a056402215700b0041d8fcac53asm8799915edb.23.2022.04.19.11.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:30:57 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        powen.kao@mediatek.com, peter.wang@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] scsi: ufshpb: Add handing of device reset HPB regions Infos in HPB device mode
Date:   Tue, 19 Apr 2022 20:30:43 +0200
Message-Id: <20220419183044.789065-5-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220419183044.789065-1-huobean@gmail.com>
References: <20220419183044.789065-1-huobean@gmail.com>
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
---
 drivers/scsi/ufs/ufshpb.c | 73 ++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 4538164fc493..4b15fa862beb 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -1143,6 +1143,39 @@ static int ufshpb_add_region(struct ufshpb_lu *hpb, struct ufshpb_region *rgn)
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
@@ -1202,25 +1235,8 @@ static void ufshpb_rsp_req_region_update(struct ufshpb_lu *hpb,
 
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
@@ -1255,7 +1271,10 @@ static void ufshpb_dev_reset_handler(struct ufs_hba *hba)
 
 	__shost_for_each_device(sdev, hba->host) {
 		hpb = ufshpb_get_hpb_data(sdev);
-		if (hpb && hpb->is_hcm)
+		if (!hpb)
+			continue;
+
+		if (hpb->is_hcm) {
 			/*
 			 * For the HPB host mode, in case device powered up and lost HPB
 			 * information, we will set the region flag to be RGN_FLAG_UPDATE,
@@ -1263,6 +1282,20 @@ static void ufshpb_dev_reset_handler(struct ufs_hba *hba)
 			 * in the UFS device).
 			 */
 			ufshpb_set_regions_update(hpb);
+		} else {
+			/*
+			 * For the HPB device mode, we add all active regions to inactive list,
+			 * they will be inactivated later in ufshpb_map_work_handler()
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

