Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA3501DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344752AbiDNWEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245017AbiDNWEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:04:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE21EA5E91;
        Thu, 14 Apr 2022 15:01:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g18so12478057ejc.10;
        Thu, 14 Apr 2022 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=looIiUbZXlEHUGlU5ZBgu9xV9eMHycErO1AbrDOXdUA=;
        b=FyV2uV6NBhFd3wt4SJN67bzxmm3Am6xXqYpdq05DNRDI3AGnX7ZXwVtyMCg6wc3fLw
         qdEdRUjzkKCromLtTM74dHOaZBKjTkaWATPsattxuHAgrIgrYaPwpS0DACeWcLD5EETD
         3Z2sAW6OnK4wU/zrJg7JWpf3oDxq1ivY8DnS0v6qDEVjt11zQL6tRGtTlBhN1+fp5QyE
         WNTWikUB2XCx7icC2O6H+JDy5WDAku1iJAkfD2SIaDTGRbqLvkWGdnOC5MPcxOR2aqKp
         qVTFKRLfw3AmbHBnxXA6hkbjzPnPkdnDu6wMPsGevjuvmuyrGE35WvghmM2qaUxZ9vYv
         XMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=looIiUbZXlEHUGlU5ZBgu9xV9eMHycErO1AbrDOXdUA=;
        b=trloA9EHdcm+YPloVsjJq8dbF7hZg67RXkhXZAG+u1KinnmTcOEQAD8DngZ4JDXvd0
         rI4JnpJXvPpZCjkO1p0fv8KLzHwDEYdH/TSjrpCgDUlvrQm6QZyDAmoJD7QjY/G22aOG
         Kx4Cjcs/8RjjqzS71WEbhHm4oFO7jGnrlwfTh1toeCM+SG3rtEx/vcToBg4WM6BmyIQa
         ynyQf/X9pYAwRqWolN3ttqD8YoS54F1BAm29oqLpAiekG717zZ15hSsI/+RBEVIX2BWs
         D6dWPxaKJLiRJq8pQktiQl4bRq3cc+68nhfSkM8Icz5iQg04GkRAp1J6DnCH1vopXIf7
         D+zg==
X-Gm-Message-State: AOAM533VAlNv2nHX0cTa60BsNFez290Hdd7Ro06kHOYLcAqIXF1vLQYk
        XgMy3Str0oxx1VAoTgvwX/Y=
X-Google-Smtp-Source: ABdhPJwjM+0SouYfVuEnSBI4qzOhytGd+BsNEp+lc539PycxGXCxQj9sG42ebPORnmP4hKKJXbw0Ug==
X-Received: by 2002:a17:906:7955:b0:6e8:a9b:8c7b with SMTP id l21-20020a170906795500b006e80a9b8c7bmr3963680ejo.691.1649973700278;
        Thu, 14 Apr 2022 15:01:40 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id e15-20020a170906044f00b006e897e110fcsm1060948eja.48.2022.04.14.15.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:01:39 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, powen.kao@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] scsi: ufshpb: Cleanup the handler when device reset HPB information
Date:   Fri, 15 Apr 2022 00:01:26 +0200
Message-Id: <20220414220127.587917-4-huobean@gmail.com>
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

"When the device is powered off by the host, the device may restore L2P map data
upon power up or build from the host’s HPB READ command. In case device powered
up and lost HPB information, device can signal to the host through HPB Sense data,
by setting HPB Operation as ‘2’ which will inform the host that device reset HPB
information."

This patch is to clean up the handler and make the intent of this handler more
readable.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshpb.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 4463a0fc619f..ac442f19d7f7 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -1231,7 +1231,10 @@ static void ufshpb_rsp_req_region_update(struct ufshpb_lu *hpb,
 		queue_work(ufshpb_wq, &hpb->map_work);
 }
 
-static void ufshpb_dev_reset_handler(struct ufshpb_lu *hpb)
+/**
+ * Set the flags of all active regions to RGN_FLAG_UPDATE, letting the host reload its L2P entries.
+ */
+static void ufshpb_set_region_update(struct ufshpb_lu *hpb)
 {
 	struct victim_select_info *lru_info = &hpb->lru_info;
 	struct ufshpb_region *rgn;
@@ -1245,6 +1248,24 @@ static void ufshpb_dev_reset_handler(struct ufshpb_lu *hpb)
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
+			ufshpb_set_region_update(hpb);
+	}
+}
+
 /*
  * This function will parse recommended active subregion information in sense
  * data field of response UPIU with SAM_STAT_GOOD state.
@@ -1319,17 +1340,7 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
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

