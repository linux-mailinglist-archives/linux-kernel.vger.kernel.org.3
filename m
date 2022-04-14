Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC88501DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbiDNWER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244930AbiDNWEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:04:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32201A1472;
        Thu, 14 Apr 2022 15:01:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b24so7977812edu.10;
        Thu, 14 Apr 2022 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGPv67XD0S+UexNg1MndYpUIv/Udyr5RFRP/aJXCovE=;
        b=bI24UjLJzZzCmYaLHi0up6ApwHcMZAGRaQFWBw9xT+k8lezWFqpX3uBZyFl5yLfx1r
         j7fyxsvC07UZKJzfsknVLaC2ku2U4nEl+oc0uLCj9bKieaoVSWI7dtju3CUMSHzfX4x+
         UQaTf1gskvgo/VCOIn7aa2MLG7QP4RygVcGHsm0sMwXyynLU4mjvdQGHdyzs/RhrvYLM
         swjsEgGfezFCFgG/cFabKA9MgLIFEngZcJcn1p/DTiQqNglCmCYEunfMzfJ0JY2B733Z
         TTVf1hqc5GS1GnghJ/DL+UZcBjdx+zSKCRoPe0FE4IMLB64DcEG+s96oDdkSGnOF4vJG
         kpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGPv67XD0S+UexNg1MndYpUIv/Udyr5RFRP/aJXCovE=;
        b=u6mKZyxzheXQ6cuhvkjAxHgigYwEQtJPETHxC3n1xzJCxWWkvDYK+6XJcC2hjG207V
         DZDsnuAfClOB+E0cbZRZBC/WmtA6zFdOcr5xZm57e9aKtdOK8ZI6Uwywp84GDQ4HeehB
         gR8rCJiUJ8xxPpY/I3TU/NCsGxXl2B+SXW5pXXY2z307/HLMbHGoWq+1iaIJEv5b9wJj
         88TSw0OH3kbOuyje3m0d1mADtve3ajLLjD0LNBlCESlp146+fW7eqi2R/MnHkpBRZezF
         VzwgmjC5NQm99QOP6s206lsZfINXJikWnRO+MWe2NPQAuS9HKuk6CNvFdYs0/eextx1H
         s7Wg==
X-Gm-Message-State: AOAM5321Zrn8AhTXg5kmlo/zdhGdAeD7DnwtubV2v+0PgC1wB+Gc16zs
        KgOmQ3KFp0aud4Bzxeei6L8=
X-Google-Smtp-Source: ABdhPJyBo0dLY5PT89TrcCm/E+WmO1KFRDiGtRg1Uo31auDxnDTIel51F6IDjajU0S5kuhrK9mxUHw==
X-Received: by 2002:a05:6402:34d4:b0:421:16c7:f474 with SMTP id w20-20020a05640234d400b0042116c7f474mr4680908edc.356.1649973697755;
        Thu, 14 Apr 2022 15:01:37 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id e15-20020a170906044f00b006e897e110fcsm1060948eja.48.2022.04.14.15.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:01:37 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, powen.kao@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] scsi: ufshpb: Merge ufshpb_reset() and ufshpb_reset_host()
Date:   Fri, 15 Apr 2022 00:01:24 +0200
Message-Id: <20220414220127.587917-2-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414220127.587917-1-huobean@gmail.com>
References: <20220414220127.587917-1-huobean@gmail.com>
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

There is no functional change in this patch, just merge ufshpb_reset() and
ufshpb_reset_host() into one function ufshpb_toggle().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c |  4 ++--
 drivers/scsi/ufs/ufshpb.c | 36 +++++++++++++-----------------------
 drivers/scsi/ufs/ufshpb.h |  6 ++----
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 0899d5b8cdad..de0bc53e3ac6 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7223,7 +7223,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	 * Stop the host controller and complete the requests
 	 * cleared by h/w
 	 */
-	ufshpb_reset_host(hba);
+	ufshpb_toggle(hba, HPB_PRESENT, HPB_RESET);
 	ufshcd_hba_stop(hba);
 	hba->silence_err_logs = true;
 	ufshcd_complete_requests(hba);
@@ -8184,7 +8184,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
 
-	ufshpb_reset(hba);
+	ufshpb_toggle(hba, HPB_RESET, HPB_PRESENT);
 out:
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	if (ret)
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 3ca745ad616c..4463a0fc619f 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -2278,38 +2278,28 @@ static bool ufshpb_check_hpb_reset_query(struct ufs_hba *hba)
 	return flag_res;
 }
 
-void ufshpb_reset(struct ufs_hba *hba)
+/**
+ * ufshpb_toggle - switch HPB state of all LUs
+ * @hba: per-adapter instance
+ * @src: expected current HPB state
+ * @dest: expected target HPB state
+ */
+void ufshpb_toggle(struct ufs_hba *hba, enum UFSHPB_STATE src, enum UFSHPB_STATE dest)
 {
 	struct ufshpb_lu *hpb;
 	struct scsi_device *sdev;
 
 	shost_for_each_device(sdev, hba->host) {
 		hpb = ufshpb_get_hpb_data(sdev);
-		if (!hpb)
-			continue;
-
-		if (ufshpb_get_state(hpb) != HPB_RESET)
-			continue;
-
-		ufshpb_set_state(hpb, HPB_PRESENT);
-	}
-}
-
-void ufshpb_reset_host(struct ufs_hba *hba)
-{
-	struct ufshpb_lu *hpb;
-	struct scsi_device *sdev;
 
-	shost_for_each_device(sdev, hba->host) {
-		hpb = ufshpb_get_hpb_data(sdev);
-		if (!hpb)
+		if (!hpb || ufshpb_get_state(hpb) != src)
 			continue;
+		ufshpb_set_state(hpb, dest);
 
-		if (ufshpb_get_state(hpb) != HPB_PRESENT)
-			continue;
-		ufshpb_set_state(hpb, HPB_RESET);
-		ufshpb_cancel_jobs(hpb);
-		ufshpb_discard_rsp_lists(hpb);
+		if (dest == HPB_RESET) {
+			ufshpb_cancel_jobs(hpb);
+			ufshpb_discard_rsp_lists(hpb);
+		}
 	}
 }
 
diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
index b475dbd78988..2825ec69a6a6 100644
--- a/drivers/scsi/ufs/ufshpb.h
+++ b/drivers/scsi/ufs/ufshpb.h
@@ -288,8 +288,7 @@ static int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp) { return 0;
 static void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp) {}
 static void ufshpb_resume(struct ufs_hba *hba) {}
 static void ufshpb_suspend(struct ufs_hba *hba) {}
-static void ufshpb_reset(struct ufs_hba *hba) {}
-static void ufshpb_reset_host(struct ufs_hba *hba) {}
+static void ufshpb_toggle(struct ufs_hba *hba, enum UFSHPB_STATE src, enum UFSHPB_STATE dest) {}
 static void ufshpb_init(struct ufs_hba *hba) {}
 static void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev) {}
 static void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev) {}
@@ -303,8 +302,7 @@ int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
 void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
 void ufshpb_resume(struct ufs_hba *hba);
 void ufshpb_suspend(struct ufs_hba *hba);
-void ufshpb_reset(struct ufs_hba *hba);
-void ufshpb_reset_host(struct ufs_hba *hba);
+void ufshpb_toggle(struct ufs_hba *hba, enum UFSHPB_STATE src, enum UFSHPB_STATE dest);
 void ufshpb_init(struct ufs_hba *hba);
 void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev);
 void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev);
-- 
2.34.1

