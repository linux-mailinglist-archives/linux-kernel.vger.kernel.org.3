Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4136D50D593
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbiDXWKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbiDXWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:10:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE2F5E77B;
        Sun, 24 Apr 2022 15:07:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id p4so799850edx.0;
        Sun, 24 Apr 2022 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+jWtMMAHpQUFdLCMp9InOSTuyV28IhzkfaPkZD8ILYI=;
        b=JYpz3b/jRwqxBUvI1A+yhTwa26Ulxo9/Rlg4YFc9ToE5TvSXyWl3iC4pLL7iJ7zHZQ
         tluNnXPAIKlEAwzaVmIp1uIFhLX72mtua6WQQllnQdWnp5PvLS4KM3ZLE78VkeBGYZlv
         8lWsinYgxM0FADkU7SQJIv8R84MAhNp+jpwGc0U/8TWDxUoednUta74vqtzxlrbmWpYd
         +CnahLU/zPdjAZ/Ex5CuPNI1wWONFItIsSQ+HRT/olCE/YvEnu6aOrD4glcl9m5FlcSZ
         gTWnhKfeWzXVmghbBsvIFsYey+UYxPKsgT0bN0ATEjlB2k6YHR3yuQlvUvHJSizn59XJ
         +ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+jWtMMAHpQUFdLCMp9InOSTuyV28IhzkfaPkZD8ILYI=;
        b=5dEabJUJ4Y24Pld4Sodhf89Tw5NKlEOQL7AdADHNC+/jZk1MrmqlpuSqPxZYUiqIAY
         vdj6PBmgmgMzjOmoQvNj3Hbjtah1whry82zU4Y01UP/BbxR7Rm1zzacRa4NaHcnxeUZs
         0SXzZADEES6BavLc8MHIDXr+uuAnQm96sZRNKtvkEPcff5D1tdV+OMmHLAXPP7fUNNUn
         nFCeu8EUNwEXvwIDinpP7ZoHroKZQNqpjVwQGcqc/xuoVSD7EQkIqG+4bvTCtn/xLP71
         sStDa06fzwkuAcubslPVVsYMpEdytRgkpaFgUsfkG3ZCwRB7hO/rG98eHD46BBiBt87L
         rA+g==
X-Gm-Message-State: AOAM532YAvwFjeyARk9ryR62knxOHmBfFzwlMOOQyQ6hja2RHfTcaApx
        sW33k/AJ/csDuG4aKpPvgYs=
X-Google-Smtp-Source: ABdhPJwty63lWTDhdkVpVAmODNP6+UhFQrpCRN9we0kjerGz72iP42t0wkhPSoH1kK+Sn7N2jPQcnw==
X-Received: by 2002:a05:6402:2747:b0:423:88ab:178f with SMTP id z7-20020a056402274700b0042388ab178fmr16067572edd.163.1650838044931;
        Sun, 24 Apr 2022 15:07:24 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm3672948edt.92.2022.04.24.15.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 15:07:24 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, keosung.park@samsung.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] scsi: ufshpb: Change sysfs node hpb_stats/rb_* prefix to start with rcmd_*
Date:   Mon, 25 Apr 2022 00:07:11 +0200
Message-Id: <20220424220713.1253049-5-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220424220713.1253049-1-huobean@gmail.com>
References: <20220424220713.1253049-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

According to the documentation of the sysfs nodes rb_noti_cnt, rb_active_cnt
and rb_inactive_cnt, they are all related to HPB recommendation in UPIU response
packet. I don't know what 'rb' refers to, I think 'rcmd'
(recommendation) should be the correct abbreviation.

Change the sysfs documentation about these sysfs nodes to highlight what they mean
under different HPB control modes.

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
index f1f30d4c3d65..e7f311bb4401 100644
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

