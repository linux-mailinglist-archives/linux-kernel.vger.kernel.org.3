Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A41651C136
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380057AbiEENvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbiEENvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:51:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D826F56FB1;
        Thu,  5 May 2022 06:47:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k27so5281177edk.4;
        Thu, 05 May 2022 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oUzFHC3hE5t2h2hEpNC3yEJlY0mdKqM3EtV1DCmd8D0=;
        b=Hw4Rv1FZo857VMcMzkbP/NlRckMrjb6LaVc/W34rmifYwa+w+HtW7CToobuVOZKHxe
         uYSmGpIUDOezRUgnWOyUdedYrRTxMfNuinkCZY5SABW3g4uWkXitK+Q2tJFaVAtEHl8T
         Har554npwR3GdE0C70jj1HmYVE65I9pPYOGNo84evkk38HuCnJUMfZVKeWAAm1dsP1FU
         sbZhA+m1mcEdWVw37GPDwF2kE5xCldSED5hfjZgvQDHU9YQrJeiThM7qv5AK4ruXWP3Z
         DW1xNgC6JODXYZ5V2VES9BLmDmNF8bY6FhfkO/f2PvBqTKUA73vlZIUBEWvzLAzFaG32
         axfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oUzFHC3hE5t2h2hEpNC3yEJlY0mdKqM3EtV1DCmd8D0=;
        b=u+uhP1qN5X0KKCt+YibBVf4+kdNYPcW0MNtWDfVz/lU3mw7940VNV6YIHb1gK52OUB
         t6LgQAsSYc2H+scUXVeBhnmB4Vtd29m5ch94mOQNjDJlzeZzTcFX/2bLFHpKTXtDvjBl
         63K3uYNbINotp++B60sPOfsZze/suNKiW95ESe9j+ND4bfHzADeRx3ViKzSsT8zX1AxM
         tBWqw7R52ztKTyaJAtBzAVQ8Yz5v8r0eX1PewxX7FhtYnq6vP5gVljzTgZ/AC9TuSfzP
         fKVgaIaliXDzeI8MjwsCApgIfWbSKDWm0rUGcz4po6ErCmqLMEeBuhTr+L5kfpSAgfQV
         FnEQ==
X-Gm-Message-State: AOAM5300K78bxdcpnqQ10J8F5/WSCFGK7UMfQ8a4PIWi9T41MnyV5t/v
        BD7pYJ1mzFUGUxSBujyTh3Y=
X-Google-Smtp-Source: ABdhPJyJdL4q8U7oYwe/rnrFKTifXUV7fNxTuXLNvsxOMg3y+OWIWr5uIetiADuFzBU7w5ZsyVb0VA==
X-Received: by 2002:a05:6402:5114:b0:427:cbe5:e9bd with SMTP id m20-20020a056402511400b00427cbe5e9bdmr21532765edd.255.1651758440492;
        Thu, 05 May 2022 06:47:20 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906301a00b006f3ef214e69sm728324ejz.207.2022.05.05.06.47.19
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
Subject: [PATCH v4 3/6] scsi: ufshpb: Cleanup the handler when device reset HPB information
Date:   Thu,  5 May 2022 15:47:04 +0200
Message-Id: <20220505134707.35929-4-huobean@gmail.com>
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

"When the device is powered off by the host, the device may restore L2P map data
upon power up or build from the host’s HPB READ command. In case device powered
up and lost HPB information, device can signal to the host through HPB Sense data,
by setting HPB Operation as ‘2’ which will inform the host that device reset HPB
information."

This patch is to clean up the handler and make the intent of this handler more
readable, no functional change.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/scsi/ufs/ufshpb.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 5412ce6309df..901e0a3d4836 100644
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

