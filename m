Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1467850D58F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbiDXWKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiDXWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:10:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA94A5E163;
        Sun, 24 Apr 2022 15:07:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id k27so1241731edk.4;
        Sun, 24 Apr 2022 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8fPGHGP26naPx3u4XdY7A6QtBbwdMGar9P7tHUKzWY=;
        b=nP1sYMmnWbNppTXXX2B2OPNnPRJkP+Tm9m8BWqvf7b4hN2n2SCo8EIxdtSGOn+dU9G
         hH/4tcYNsgx9PhBZTfTKrI5fqxnGx6dY92FZaL/CmZrH3ywj0lTBLnB8K6AFNF8Q0vWu
         kflRGklvsmPKmv4l0TDldBad/MvmsvFPXZvaIqC5yr0BVMrhWFO/e3rNDp8E+h+D6Kx4
         y7zb0L/og/oCSToVeBc7gA8e/CCow6wnxvj6T+jt05PMldK2qBb+wvpJBgBW7BrWqnQ8
         c4tzsZPrIE5kgyZRnxeQH/k3PByq7huOcgXocmU9ufI5K1LlLrHQuyqTWbyeKC8vnqgv
         3x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8fPGHGP26naPx3u4XdY7A6QtBbwdMGar9P7tHUKzWY=;
        b=zEz8r3hidMFdAd6cc78qMxxO1Msj0oc7OtVEGQfTyhMAgKM9w62JoDUso+fRPfE56X
         yMeV9bvGzlPCZggW4UZ+htPXfkt6V2apTVhdKZBKNU84XTpPeIT5jJYyIB7pU43Gmsih
         OLBW9EHmBDvR5VhA/t5XCX5tVp86tBxy0pvZZ+67FgYz6tBcAygw6TCNOcw7D3KFx/5f
         Adx2dQBuPaI5Shz+qcpzBV1dttT7TsWgqidPsBCeM+0/0dZm039fF8GSly9bH/TXn8AW
         zmwH6joAAn0EQcsNAzfSOPikNnfeak03i9gaEbmFUp9oOYz4EY3OEg9YRmC5d6Q6mESq
         AdoQ==
X-Gm-Message-State: AOAM530PcV/cwz5+SuV9rhgoepbHxoBztit2zeezXT7ix+rQf306N+wJ
        SpPrCJqwhFHAdm5mLWsZ8PKXf6gF9ckdkw==
X-Google-Smtp-Source: ABdhPJxWD5r4TSjHdo7qJgQXWpGobHIZKMXOJLtKYsvf9D8wS+xjk1/LTEH6QfR3dV2J6wBEN79btA==
X-Received: by 2002:a05:6402:11cb:b0:423:d7b9:109b with SMTP id j11-20020a05640211cb00b00423d7b9109bmr15967730edw.70.1650838042412;
        Sun, 24 Apr 2022 15:07:22 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm3672948edt.92.2022.04.24.15.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 15:07:22 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, keosung.park@samsung.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] scsi: ufshpb: Merge ufshpb_reset() and ufshpb_reset_host()
Date:   Mon, 25 Apr 2022 00:07:08 +0200
Message-Id: <20220424220713.1253049-2-huobean@gmail.com>
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

There is no functional change in this patch, just merge ufshpb_reset()
and ufshpb_reset_host() into one function ufshpb_toggle_state().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c |  4 ++--
 drivers/scsi/ufs/ufshpb.c | 36 +++++++++++++-----------------------
 drivers/scsi/ufs/ufshpb.h |  6 ++----
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3f9caafa91bf..62c7f5404353 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7223,7 +7223,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	 * Stop the host controller and complete the requests
 	 * cleared by h/w
 	 */
-	ufshpb_reset_host(hba);
+	ufshpb_toggle_state(hba, HPB_PRESENT, HPB_RESET);
 	ufshcd_hba_stop(hba);
 	hba->silence_err_logs = true;
 	ufshcd_complete_requests(hba);
@@ -8184,7 +8184,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
 
-	ufshpb_reset(hba);
+	ufshpb_toggle_state(hba, HPB_RESET, HPB_PRESENT);
 out:
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	if (ret)
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index fd31e516e491..167643969165 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -2272,38 +2272,28 @@ static bool ufshpb_check_hpb_reset_query(struct ufs_hba *hba)
 	return flag_res;
 }
 
-void ufshpb_reset(struct ufs_hba *hba)
+/**
+ * ufshpb_toggle_state - switch HPB state of all LUs
+ * @hba: per-adapter instance
+ * @src: expected current HPB state
+ * @dest: target HPB state to switch to
+ */
+void ufshpb_toggle_state(struct ufs_hba *hba, enum UFSHPB_STATE src, enum UFSHPB_STATE dest)
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
index b475dbd78988..7aa0dc58ee9f 100644
--- a/drivers/scsi/ufs/ufshpb.h
+++ b/drivers/scsi/ufs/ufshpb.h
@@ -288,8 +288,7 @@ static int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp) { return 0;
 static void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp) {}
 static void ufshpb_resume(struct ufs_hba *hba) {}
 static void ufshpb_suspend(struct ufs_hba *hba) {}
-static void ufshpb_reset(struct ufs_hba *hba) {}
-static void ufshpb_reset_host(struct ufs_hba *hba) {}
+static void ufshpb_toggle_state(struct ufs_hba *hba, enum UFSHPB_STATE src, enum UFSHPB_STATE dest) {}
 static void ufshpb_init(struct ufs_hba *hba) {}
 static void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev) {}
 static void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev) {}
@@ -303,8 +302,7 @@ int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
 void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
 void ufshpb_resume(struct ufs_hba *hba);
 void ufshpb_suspend(struct ufs_hba *hba);
-void ufshpb_reset(struct ufs_hba *hba);
-void ufshpb_reset_host(struct ufs_hba *hba);
+void ufshpb_toggle_state(struct ufs_hba *hba, enum UFSHPB_STATE src, enum UFSHPB_STATE dest);
 void ufshpb_init(struct ufs_hba *hba);
 void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev);
 void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev);
-- 
2.34.1

