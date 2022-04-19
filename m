Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8749507924
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiDSSjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357620AbiDSShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:37:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D0F3FDA3;
        Tue, 19 Apr 2022 11:30:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k23so34681546ejd.3;
        Tue, 19 Apr 2022 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K58kqXUDzWjZzDY1bjT5aDipXJoJyyUTkMqZrlco4wA=;
        b=dKelcTJDsnum7ZKzW2/NDFb+blrxkiDUow4HfKE1eA7gJVJ+wKGOQtcoMduAtdaxzT
         gu8SlYfKb2+SmEWL5JzSHbyrmWX6hNpjqftqeoaTNj+nV1q3yZG/r9NfveimfV156zd4
         D/JTuN2WjW1pli8B998nbv2BAN3AXrc/4x76EcpOJ+gUc8g7z3qHuwaz2O0tf89KZgsP
         8DP444APaS7k+XuYBakOqfvmkBo4af9RUClHlXE2A/InMMLHSJM3Ac2EZW/8EpojIf73
         k/dIDPq+AXdvuMoba+rYqPf216cTiCeAhP/tsMNpAiY+krRRMYvgiI+w50o5T1Gwrvlk
         RZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K58kqXUDzWjZzDY1bjT5aDipXJoJyyUTkMqZrlco4wA=;
        b=3yAan5eUKPBBH3hHFgYw2VZ4Ucnr9XZpGFJQY0HAJQEIajYtnmApwjf4aaBraYQ0FQ
         O4VkXJVLyTwtGA/xfOrAxCf434nb+nsECW1rsdVS3e1fETiGWv8lqHEoeqPUBXZZEm6o
         nvINtGgjmK9tN8iTtwCk/c/ZnXyjyqQcWpbDztnqJP6hjjEOX3UWyXEaRQ5yDouJBZfp
         6e/jMPElr6Y8xyMoLmIG7pIfbEKvmhwoUuA/QSLpS2HGCjaNn8WrAjG4GOEzN1bnRbJU
         M/JweQa9mcuzAm0yZV4K419s2iVoy1Vj04LM7sjOKs/vJkZOuA1oc+954t3OPua5ItQJ
         dF7A==
X-Gm-Message-State: AOAM531FceVcNfb06nntV2dbca0FuASl4b1P5Sj0N3e/i2Qc6ILHCVgb
        zCDLGn0sinGnl1jazS/PVWo=
X-Google-Smtp-Source: ABdhPJxr5BSggcSmFl0rnn4nGLNOLvnNRvNGQXlTW6BCftocTCGsRt6GC3znJtiRxML6UhVrS8/vMA==
X-Received: by 2002:a17:907:7f9f:b0:6ef:a120:4ea6 with SMTP id qk31-20020a1709077f9f00b006efa1204ea6mr10818840ejc.607.1650393056549;
        Tue, 19 Apr 2022 11:30:56 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id bq23-20020a056402215700b0041d8fcac53asm8799915edb.23.2022.04.19.11.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:30:56 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        powen.kao@mediatek.com, peter.wang@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] scsi: ufshpb: Cleanup the handler when device reset HPB information
Date:   Tue, 19 Apr 2022 20:30:42 +0200
Message-Id: <20220419183044.789065-4-huobean@gmail.com>
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
index 9df032e82ec3..4538164fc493 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -1231,7 +1231,10 @@ static void ufshpb_rsp_req_region_update(struct ufshpb_lu *hpb,
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
+			ufshpb_set_regions_update(hpb);
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

