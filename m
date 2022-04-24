Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F5650D596
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbiDXWKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239750AbiDXWK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:10:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7185A5DE62;
        Sun, 24 Apr 2022 15:07:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so5534339ejj.10;
        Sun, 24 Apr 2022 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=COG2pB7EY8x9qomnPZfOrHzJQwF9/mN/WQraDu1oLko=;
        b=LoLS5C/AgpN9SECJLmqiFy1WT/xJSXWqfEtdtaeEGNj9uq7SjAo8llXOnr+K8B8GNq
         zixYmmzBL+TlBT77HCjCPuknMwtws9WizKA/0FVzfXc0nij2R1Ddt0xWbzsmmnPpx3Dz
         OAT9Z7ZPGW3xs+GEZhyMQrjuYM0r2mntHSmQ1po4MrK9LmdFymGWqMlH5G3IBV12ULOu
         eixFkdRs1tmVR1Dir7JjHC1VYR+MCReGMeaEQzByOYA8tAccVQd67jpMFcIFQYfoWo7o
         7MpH1PHXAiqLaL7TrBdfr648qz7btOUZmCo5cq+BRFjO6CAEFuUT+X+Sjc8PBVcdhub5
         ouHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COG2pB7EY8x9qomnPZfOrHzJQwF9/mN/WQraDu1oLko=;
        b=nex/66lGVle1LwrhEH9OjYG9hxXbrR1HLdqNpDgyiA2xdLdNpZQcAsZJiBPAGCaU72
         7m5uha06mORoTnQiBsAEhSVLFqjwD+WTEYa+QgYBPVk2q77BZa90esEXF+Z6J1cBsrR1
         FYicinDV25cmPXOw/+IuPmqCtqiLKtRm/wihmmZEuJusWlPuX6+truXR/bKB0py8gqsK
         4gdgrhBZ3stM5esmsOWLPdDNYlLY3pSzVBMduHtkN0eChc67h/wJbe8UWtO6PTp3uoyY
         lKz8xizYm9+ExqqqGG/mMXPp9n4AAFPKEYebeslhQ3sIV2z+DeltWqYm6NQ3wEe4cqBy
         dLWw==
X-Gm-Message-State: AOAM530WEJuqgEP7zlESObaTk8iOIWMAPr8j1Qp9jLP97fVgipMhWlBb
        7oOu3NKV9kuv/A/SqyuZNEw=
X-Google-Smtp-Source: ABdhPJwS0EkNuH4fvQutc2H9LWVZ+hMWeZw/1g2nAPIRo26UYUNvkdgQYM+aa40ajgPP282NDsdCIw==
X-Received: by 2002:a17:907:3fa9:b0:6ef:f0e6:7285 with SMTP id hr41-20020a1709073fa900b006eff0e67285mr13753720ejc.350.1650838044045;
        Sun, 24 Apr 2022 15:07:24 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm3672948edt.92.2022.04.24.15.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 15:07:23 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, keosung.park@samsung.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] scsi: ufshpb: Cleanup the handler when device reset HPB information
Date:   Mon, 25 Apr 2022 00:07:10 +0200
Message-Id: <20220424220713.1253049-4-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220424220713.1253049-1-huobean@gmail.com>
References: <20220424220713.1253049-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

"When the device is powered off by the host, the device may restore L2P map data
upon power up or build from the host’s HPB READ command. In case device powered
up and lost HPB information, device can signal to the host through HPB Sense data,
by setting HPB Operation as ‘2’ which will inform the host that device reset HPB
information."

This patch is to clean up the handler and make the intent of this handler more
readable, no functional change.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshpb.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 167643969165..f1f30d4c3d65 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -1225,7 +1225,10 @@ static void ufshpb_rsp_req_region_update(struct ufshpb_lu *hpb,
 		queue_work(ufshpb_wq, &hpb->map_work);
 }
 
-static void ufshpb_dev_reset_handler(struct ufshpb_lu *hpb)
+/*
+ * Set the flags of all active regions to RGN_FLAG_UPDATE to let host side reload L2P entries later
+ */
+static void ufshpb_set_regions_update(struct ufshpb_lu *hpb)
 {
 	struct victim_select_info *lru_info = &hpb->lru_info;
 	struct ufshpb_region *rgn;
@@ -1239,6 +1242,24 @@ static void ufshpb_dev_reset_handler(struct ufshpb_lu *hpb)
 	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
 }
 
+static void ufshpb_dev_reset_handler(struct ufs_hba *hba)
+{
+	struct scsi_device *sdev;
+	struct ufshpb_lu *hpb;
+
+	__shost_for_each_device(sdev, hba->host) {
+		hpb = ufshpb_get_hpb_data(sdev);
+		if (hpb && hpb->is_hcm)
+			/*
+			 * For the HPB host mode, in case device powered up and lost HPB
+			 * information, we will set the region flag to be RGN_FLAG_UPDATE,
+			 * it will let host reload its L2P entries(re-activate the region
+			 * in the UFS device).
+			 */
+			ufshpb_set_regions_update(hpb);
+	}
+}
+
 /*
  * This function will parse recommended active subregion information in sense
  * data field of response UPIU with SAM_STAT_GOOD state.
@@ -1313,17 +1334,7 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	case HPB_RSP_DEV_RESET:
 		dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
 			 "UFS device lost HPB information during PM.\n");
-
-		if (hpb->is_hcm) {
-			struct scsi_device *sdev;
-
-			__shost_for_each_device(sdev, hba->host) {
-				struct ufshpb_lu *h = sdev->hostdata;
-
-				if (h)
-					ufshpb_dev_reset_handler(h);
-			}
-		}
+		ufshpb_dev_reset_handler(hba);
 
 		break;
 	default:
-- 
2.34.1

