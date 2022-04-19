Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4215507918
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357019AbiDSSi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357617AbiDSShu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:37:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A23FD82;
        Tue, 19 Apr 2022 11:30:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 11so17378066edw.0;
        Tue, 19 Apr 2022 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nMLlDhPnop9g4KyrUFEvrHcvhanglhDeFL7ZQagGwQ=;
        b=bmW71mT1hdUwk4bLQJmEY7XNptT1RccKTZ1fmJs/u4VvfIiIwZ5jlOqvRCziZQ1NJX
         YaxJ3KRiTrZRMAeXzN7A3Az5oaiIDbkKYIiQJsVXes4crAU3WDShGG6KiKsZAvANX0F8
         uz5J7bATTpS6M8Xuivb6ZLHDfjUFwjWTsDGJmvrpQ5obPTAJclpHxYr8b4is+Fujg848
         lu4u8aotfVVJ6h5FQ6j0xpJxjc/y7uST9gOihiboBSTYoO0Tmzex0Ue/KcMm4JnSA9Bw
         rZnmz/y2yXYbFrwJFziFzEMW6FvkqnyeCfT5k+OoliJdhKg9z6A6xSwqWe3C3pTeVwbR
         yiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nMLlDhPnop9g4KyrUFEvrHcvhanglhDeFL7ZQagGwQ=;
        b=NQmADpJNAgbPM2nSZw0ree9yfTP+Q/L1vPzD6cRTq9V/LSUuhgDxUsKnXCc/5tzxIB
         mEPeCiFlnfjOhQ7ePPBV2nM3rrCJxgDkWOBkuRUPZOPicbToGQP49gN/d4FmMnEpfg2n
         O5JZsxJAEuzeRmIbDbcU9amCCg9o7AzGEND9AjOEzo7DA+MbOmbFxJMlM9oYcVvW+2lT
         UPQEei+dGfP9/b1m49coqfu/BZQG6O5PqKoIVVjsqABC6H/tA59pgfaMtXwL47VN1DC2
         KvkXGRvAvxOiDs1fFTrVW682WxJgvWg69XOQEYFHK6FxUYU2LzN5FaKKwbHeW2eddgf2
         49fw==
X-Gm-Message-State: AOAM530ToB8iklEgVOf59lTPKFErzL27RsRZeB6rMlG/37UTopsf4R5p
        6wj6P3EbPDTYWlGVJ1ouay0=
X-Google-Smtp-Source: ABdhPJyD7CINQv+BWj19/jswAEpH8TDbfJGztG6Bm1Zhnqje/oKF4xZP7cV+0xE259Km7F7M9XVrMQ==
X-Received: by 2002:a05:6402:ea8:b0:41d:78ca:b929 with SMTP id h40-20020a0564020ea800b0041d78cab929mr18899620eda.289.1650393054897;
        Tue, 19 Apr 2022 11:30:54 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id bq23-20020a056402215700b0041d8fcac53asm8799915edb.23.2022.04.19.11.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:30:54 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        powen.kao@mediatek.com, peter.wang@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] scsi: ufshpb: Merge ufshpb_reset() and ufshpb_reset_host()
Date:   Tue, 19 Apr 2022 20:30:40 +0200
Message-Id: <20220419183044.789065-2-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220419183044.789065-1-huobean@gmail.com>
References: <20220419183044.789065-1-huobean@gmail.com>
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
ufshpb_reset_host() into one function ufshpb_toggle()

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
index 3ca745ad616c..9df032e82ec3 100644
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
+ * @dest: target HPB state to switch to
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

