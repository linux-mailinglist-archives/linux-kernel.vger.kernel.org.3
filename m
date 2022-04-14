Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A250501DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbiDNWEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245126AbiDNWEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:04:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F8BA66DC;
        Thu, 14 Apr 2022 15:01:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bh17so12503120ejb.8;
        Thu, 14 Apr 2022 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3HuqqJ6TFrv0Wec+QhDogWW1PdyyO3M37oSooOZjklM=;
        b=aK7jMFu//JAMO93tr5N0H6x+6BVfiC1kWxpUKqIv6bAAVZrbCC35IcXTQdR5ppf4Yk
         Bxcx5Guumz40rr8pdOiKfdzNBqhF84Z9ZxniQrE/8n9ffKLnVs/ZGspSFOVoLJ7t90VN
         A4J2fF/MO4Z/aUM0cd9MfPoNBCJWwe1B09z7vcDwPldoPLtYIvlaXnxIcFf5tSvN/S4/
         WkSFbCikXjKrU/8U4ZFOYyh/a29s132RJWGSjifhLfia93ADx1C0UOX8Ethno3AWSO68
         B1Uq/PhDvL0IPFTOZpoP95wRrjY/TsXuSp99BeZsaree8p7KHlokJnJlMoOytdcoQJ5C
         SjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3HuqqJ6TFrv0Wec+QhDogWW1PdyyO3M37oSooOZjklM=;
        b=bnwv7a4esS/I+YU2JwIoLP22Ffwis4gGmVUMLCKy+y6MwqIZtFoiXLWKPvXUakO4d7
         CHKeT2CmIyK0E1s5qo7oFhv+rvO8qy7uvOgnkXvBQWgHK7DI+Kv2dnmoFp9lGiM3pN/A
         QEB2RsiGAbjtwG19G0/oUj0Uk9AkLizTZyOjQpVzs7DsRuY8s4jRlblXiCdO4BuWFg90
         b9k7XH8ILOmAT8jP3hnmrG2YXiwB0ZeIzrOPGQIuX0lD1mdDOwXEh6UEK14gmDgtGdZo
         uUU+sreuWnBTpQkDCwnEZxII8GnRfylVkw5tSzlEsP7ffulg7ZAgFwhm1ZyggWzSc+Pi
         Siog==
X-Gm-Message-State: AOAM533yG34H2wsq/5pq3B48kxVVFwNVTi2c/0L7jUXLQwjSAUY0SMti
        /IBciBNzkLlckms0q1BwoXE=
X-Google-Smtp-Source: ABdhPJzBWemjPsbUBDy+qiL1YPkFpFFTYIU3ys1ZIXkyNzACh2+aG69PH4I8lD+OsV1Vb/0AZlkIEA==
X-Received: by 2002:a17:906:32d0:b0:6ce:e1cf:3f2e with SMTP id k16-20020a17090632d000b006cee1cf3f2emr3876722ejk.214.1649973701365;
        Thu, 14 Apr 2022 15:01:41 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id e15-20020a170906044f00b006e897e110fcsm1060948eja.48.2022.04.14.15.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:01:40 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, powen.kao@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] scsi: ufshpb: Add device reset HPB regions Infor handling for HPB device mode
Date:   Fri, 15 Apr 2022 00:01:27 +0200
Message-Id: <20220414220127.587917-5-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414220127.587917-1-huobean@gmail.com>
References: <20220414220127.587917-1-huobean@gmail.com>
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

So, for the HPB device mode, if the UFS device is reset by the RST_N pin, the active
regions's information in the device will be reset, and then the device will notify
the host side that it is recommended to deactivate all active region in the host
HPB memory.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshpb.c | 73 ++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index ac442f19d7f7..82ca0dd5097c 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -1143,6 +1143,39 @@ static int ufshpb_add_region(struct ufshpb_lu *hpb, struct ufshpb_region *rgn)
 	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
 	return ret;
 }
+/**
+ *ufshpb_update_region_inactive - update a region to be deactivated later
+ *@hpb: per-LU HPB instance
+ *@region_index: the region index will be activated later
+ */
+static void ufshpb_update_region_inactive(struct ufshpb_lu *hpb, int region_index)
+{
+	int subregion_index;
+	struct ufshpb_region *rgn;
+	struct ufshpb_subregion *srgn;
+
+	/*
+	 * Delete this region from acctive list and add it to inactive list
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
+		ufshpb_update_region_inactive(hpb, rgn_i);
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
 			ufshpb_set_region_update(hpb);
+		} else {
+			/*
+			 * For the HPB device mode, we add all active regions to inactive list,
+			 * they will be inactivated later in ufshpb_map_work_handler()
+			 */
+			struct victim_select_info *lru_info = &hpb->lru_info;
+			struct ufshpb_region *rgn;
+
+			list_for_each_entry(rgn, &lru_info->lh_lru_rgn, list_lru_rgn)
+				ufshpb_update_region_inactive(hpb, rgn->rgn_idx);
+
+			if (ufshpb_get_state(hpb) == HPB_PRESENT)
+				queue_work(ufshpb_wq, &hpb->map_work);
+		}
 	}
 }
 
-- 
2.34.1

