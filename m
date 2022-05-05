Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745AC51C13A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiEENvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379994AbiEENvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:51:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A548757149;
        Thu,  5 May 2022 06:47:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l18so8835925ejc.7;
        Thu, 05 May 2022 06:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82ySVt2ChtjKl3QU+pguknZpdr/d2PyQOBQbWfayXGY=;
        b=SfVmRiTTUxzjc+1QZoWxa1YWNdnZkZqKrIovzyZA7N4h5pTax32kYUqqkv5Qb9uxti
         NlnIh7OU9kLgoTkHkU50NOjFPjJAjQXvG3nTSZ0J7Z9y7ugJsoXWR79WwG4/xVqwe2BB
         ZjpR+y3MEZpzxT9uLMhs6x+wT/EUCMMmckm2a53HDHPP33m7MV0FNJ54ZDOczpu3yf3G
         3OmN16ISbQmPrznnKOSILKAJtPup0JkgLrkBRO0RNTs97yB/6/h06mS8PQJ/y4zi9n8m
         Hg6m9IKFVpXVqUz4qYfCsf3hw/Z6bNu/sIBtRy7WxkLkVgCyACPoYAUdZhk+XXlZSnuF
         yMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82ySVt2ChtjKl3QU+pguknZpdr/d2PyQOBQbWfayXGY=;
        b=kuQWSk0XWVMaivVOEChs2B6NvRv1Lqq62X2lni06AvovikXoAHvWVZ3EPEKDG6wj3O
         VTVe6kC7+D7pUTrbLaPjmUXD0NtDlD2vUc3dbzX9NiflV7hSw4OhPHZn+YYy2DWbnIDm
         EBdc/I8fUInRARDgRn5+7Am2l7SYLJru7eDV+ipXvnx7UsWe2ezPgWieGnKTxze2F7ds
         2CfWbJaYq4T7n3H4q8uSUx+Chw3M0mc7jm3LLjpN21r1kkMI9/rXec1+G79gTNV6BLDP
         IluMGL4eFbOfOFCYyxNEAWhijs7wjhswk/kFkB+vI9+BqlzilHTPq3fvGAA6sLYjbHPU
         ptMQ==
X-Gm-Message-State: AOAM5330U+Gg2RKx3ScUSNviK+NQGSlerO46oxNJtMZVeZwXW69xqO36
        5jYofeAjZkSjEPAN9SswcqI=
X-Google-Smtp-Source: ABdhPJzIa3KAznxko5Ij9lTbofJCQziDWDQ/3MLAvLhDVUrzkmZMLbi/elDSrXqlTjrflBFhVYKmHw==
X-Received: by 2002:a17:907:2d11:b0:6f4:7cf0:2275 with SMTP id gs17-20020a1709072d1100b006f47cf02275mr14868896ejc.72.1651758441223;
        Thu, 05 May 2022 06:47:21 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906301a00b006f3ef214e69sm728324ejz.207.2022.05.05.06.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:47:20 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com,
        keosung.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] scsi: ufshpb: Change sysfs node hpb_stats/rb_* prefix to start with rcmd_*
Date:   Thu,  5 May 2022 15:47:05 +0200
Message-Id: <20220505134707.35929-5-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220505134707.35929-1-huobean@gmail.com>
References: <20220505134707.35929-1-huobean@gmail.com>
MIME-Version: 1.0
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

According to the documentation of the sysfs nodes rb_noti_cnt, rb_active_cnt
and rb_inactive_cnt, they are all related to HPB recommendation in UPIU response
packet. 'rcmd' (recommendation) should be the correct abbreviation.

Change the sysfs documentation about these sysfs nodes to highlight what they mean
under different HPB control modes.

Reviewed-by: Keoseong Park <keosung.park@samsung.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 18 +++++++++-------
 drivers/scsi/ufs/ufshpb.c                  | 24 +++++++++++-----------
 drivers/scsi/ufs/ufshpb.h                  |  6 +++---
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index a44ef8bfbadf..6b248abb1bd7 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1518,7 +1518,7 @@ Description:	This entry shows the number of reads that cannot be changed to
 
 		The file is read only.
 
-What:		/sys/class/scsi_device/*/device/hpb_stats/rb_noti_cnt
+What:		/sys/class/scsi_device/*/device/hpb_stats/rcmd_noti_cnt
 Date:		June 2021
 Contact:	Daejun Park <daejun7.park@samsung.com>
 Description:	This entry shows the number of response UPIUs that has
@@ -1526,19 +1526,23 @@ Description:	This entry shows the number of response UPIUs that has
 
 		The file is read only.
 
-What:		/sys/class/scsi_device/*/device/hpb_stats/rb_active_cnt
+What:		/sys/class/scsi_device/*/device/hpb_stats/rcmd_active_cnt
 Date:		June 2021
 Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the number of active sub-regions recommended by
-		response UPIUs.
+Description:	For the HPB device control mode, this entry shows the number of
+        active sub-regions recommended by response UPIUs. For the HPB host control
+        mode, this entry shows the number of active sub-regions recommended by the
+        HPB host control mode heuristic algorithm.
 
 		The file is read only.
 
-What:		/sys/class/scsi_device/*/device/hpb_stats/rb_inactive_cnt
+What:		/sys/class/scsi_device/*/device/hpb_stats/rcmd_inactive_cnt
 Date:		June 2021
 Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the number of inactive regions recommended by
-		response UPIUs.
+Description:	For the HPB device control mode, this entry shows the number of
+        inactive regions recommended by response UPIUs. For the HPB host control
+        mode, this entry shows the number of inactive regions recommended by the
+        HPB host control mode heuristic algorithm.
 
 		The file is read only.
 
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 901e0a3d4836..4833f20cc7d0 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -563,7 +563,7 @@ static void ufshpb_update_active_info(struct ufshpb_lu *hpb, int rgn_idx,
 	if (list_empty(&srgn->list_act_srgn))
 		list_add_tail(&srgn->list_act_srgn, &hpb->lh_act_srgn);
 
-	hpb->stats.rb_active_cnt++;
+	hpb->stats.rcmd_active_cnt++;
 }
 
 static void ufshpb_update_inactive_info(struct ufshpb_lu *hpb, int rgn_idx)
@@ -580,7 +580,7 @@ static void ufshpb_update_inactive_info(struct ufshpb_lu *hpb, int rgn_idx)
 	if (list_empty(&rgn->list_inact_rgn))
 		list_add_tail(&rgn->list_inact_rgn, &hpb->lh_inact_rgn);
 
-	hpb->stats.rb_inactive_cnt++;
+	hpb->stats.rcmd_inactive_cnt++;
 }
 
 static void ufshpb_activate_subregion(struct ufshpb_lu *hpb,
@@ -1321,7 +1321,7 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	if (!ufshpb_is_hpb_rsp_valid(hba, lrbp, rsp_field))
 		return;
 
-	hpb->stats.rb_noti_cnt++;
+	hpb->stats.rcmd_noti_cnt++;
 
 	switch (rsp_field->hpb_op) {
 	case HPB_RSP_REQ_REGION_UPDATE:
@@ -1724,18 +1724,18 @@ static DEVICE_ATTR_RO(__name)
 
 ufshpb_sysfs_attr_show_func(hit_cnt);
 ufshpb_sysfs_attr_show_func(miss_cnt);
-ufshpb_sysfs_attr_show_func(rb_noti_cnt);
-ufshpb_sysfs_attr_show_func(rb_active_cnt);
-ufshpb_sysfs_attr_show_func(rb_inactive_cnt);
+ufshpb_sysfs_attr_show_func(rcmd_noti_cnt);
+ufshpb_sysfs_attr_show_func(rcmd_active_cnt);
+ufshpb_sysfs_attr_show_func(rcmd_inactive_cnt);
 ufshpb_sysfs_attr_show_func(map_req_cnt);
 ufshpb_sysfs_attr_show_func(umap_req_cnt);
 
 static struct attribute *hpb_dev_stat_attrs[] = {
 	&dev_attr_hit_cnt.attr,
 	&dev_attr_miss_cnt.attr,
-	&dev_attr_rb_noti_cnt.attr,
-	&dev_attr_rb_active_cnt.attr,
-	&dev_attr_rb_inactive_cnt.attr,
+	&dev_attr_rcmd_noti_cnt.attr,
+	&dev_attr_rcmd_active_cnt.attr,
+	&dev_attr_rcmd_inactive_cnt.attr,
 	&dev_attr_map_req_cnt.attr,
 	&dev_attr_umap_req_cnt.attr,
 	NULL,
@@ -2098,9 +2098,9 @@ static void ufshpb_stat_init(struct ufshpb_lu *hpb)
 {
 	hpb->stats.hit_cnt = 0;
 	hpb->stats.miss_cnt = 0;
-	hpb->stats.rb_noti_cnt = 0;
-	hpb->stats.rb_active_cnt = 0;
-	hpb->stats.rb_inactive_cnt = 0;
+	hpb->stats.rcmd_noti_cnt = 0;
+	hpb->stats.rcmd_active_cnt = 0;
+	hpb->stats.rcmd_inactive_cnt = 0;
 	hpb->stats.map_req_cnt = 0;
 	hpb->stats.umap_req_cnt = 0;
 }
diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
index b83b9ec9044a..0d6e6004d783 100644
--- a/drivers/scsi/ufs/ufshpb.h
+++ b/drivers/scsi/ufs/ufshpb.h
@@ -211,9 +211,9 @@ struct ufshpb_params {
 struct ufshpb_stats {
 	u64 hit_cnt;
 	u64 miss_cnt;
-	u64 rb_noti_cnt;
-	u64 rb_active_cnt;
-	u64 rb_inactive_cnt;
+	u64 rcmd_noti_cnt;
+	u64 rcmd_active_cnt;
+	u64 rcmd_inactive_cnt;
 	u64 map_req_cnt;
 	u64 pre_req_cnt;
 	u64 umap_req_cnt;
-- 
2.34.1

