Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA6F51C134
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380023AbiEENvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354819AbiEENvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:51:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9AA56C10;
        Thu,  5 May 2022 06:47:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g6so8866664ejw.1;
        Thu, 05 May 2022 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Le/mxbajMOWJ4rwuXZr5GF198bKTwEkjLMNW9f3gck8=;
        b=F7uHN4LQCRsa+LPIop1ceEubI1QGKhJPXINABZQ3JDtMaSgHHzSZpLE+KtygnHJGIp
         T2UpfWc7eJMSQL78BQqYzoVwIAmuUn6vnECAqV9hNPKWvw0QSam64B8TE3fPhMrfiZsc
         hGWYlwd7WTONnN/hVCecGYdllTU+oWrvUpRjGJa9yeMcTEeOX5zQG5c0D3PXWQ1FhY6A
         4524fti/Qzhsfm+GzQ8L35cigMxauevG9YQ7CJOw1LogQLSUFwXC8geK4DggnM244cS2
         YO6kQTlKFIZqVX+qpj8kS9V7NaSWhO1y62rKEcoxBFuqCCRDzchC9SnZfcWRtKzqmgqj
         DnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Le/mxbajMOWJ4rwuXZr5GF198bKTwEkjLMNW9f3gck8=;
        b=KOduExPh/V0OKzHtZVnHXa+ocJ+5slIwkeoeSe4n0smOSWfDn+UE6ebIqJRQTgOohn
         7AYbj9GQW0GwByiXQPqgpC/saYHVCaZGZYicr244TkyzjQW835utZ67PbWf/bTb1Gn1v
         nPPCN6mY/tji1JthCC7VrfK04XhucUcy74wb20bc0tHtsjjA+3yIq7NHE5O98Tf8y8+6
         bKDIJXzV+jPxApg8LJNnrmLO6C2ZNSy3/E1NskAMxs6HnnnEQZ49Iv/narodi0rYcdE+
         KRSfGQmNAUBjCezmJ3snaxpFvwhmvTWqe1vIbwbGBMkF1V4efEMkcG8Ia35P8zy8rxue
         Jp1g==
X-Gm-Message-State: AOAM533uWMSsAb/bjtVeKndhC2myTGRD49xVjpDfXvK9s8JErQ0wEGEe
        MLRGwoylcf4TAsIVcEkQagg=
X-Google-Smtp-Source: ABdhPJwOvd9CIBmxOqx5Wto9uJJfwa2V2w0gztP/K6GmTcQszXi5qSuRI1QPLBpmVetiOa+r9k8aAg==
X-Received: by 2002:a17:906:7304:b0:6da:9243:865 with SMTP id di4-20020a170906730400b006da92430865mr25767004ejc.665.1651758438538;
        Thu, 05 May 2022 06:47:18 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906301a00b006f3ef214e69sm728324ejz.207.2022.05.05.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:47:17 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com,
        keosung.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] scsi: ufshpb: Merge ufshpb_reset() and ufshpb_reset_host()
Date:   Thu,  5 May 2022 15:47:02 +0200
Message-Id: <20220505134707.35929-2-huobean@gmail.com>
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

There is no functional change in this patch, just merge ufshpb_reset()
and ufshpb_reset_host() into one function ufshpb_toggle_state().

Reviewed-by: Keoseong Park <keosung.park@samsung.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c |  4 ++--
 drivers/scsi/ufs/ufshpb.c | 36 +++++++++++++-----------------------
 drivers/scsi/ufs/ufshpb.h |  6 ++----
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 2b4390a1106e..34628bbf675e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7229,7 +7229,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	 * Stop the host controller and complete the requests
 	 * cleared by h/w
 	 */
-	ufshpb_reset_host(hba);
+	ufshpb_toggle_state(hba, HPB_PRESENT, HPB_RESET);
 	ufshcd_hba_stop(hba);
 	hba->silence_err_logs = true;
 	ufshcd_complete_requests(hba);
@@ -8196,7 +8196,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
 
-	ufshpb_reset(hba);
+	ufshpb_toggle_state(hba, HPB_RESET, HPB_PRESENT);
 out:
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	if (ret)
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 6e5237a041b5..5412ce6309df 100644
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

