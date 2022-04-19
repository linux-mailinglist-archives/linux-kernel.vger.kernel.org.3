Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A826507936
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357350AbiDSSik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357622AbiDSShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:37:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33C73FDB5;
        Tue, 19 Apr 2022 11:30:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c6so22390621edn.8;
        Tue, 19 Apr 2022 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=asQR7zN/XNqbk75IdkIIvMcykcD0n/R0IhNlXpw8b/8=;
        b=U8PVwNJbHKakFbCBfMIZNubo80awJYXhDlBQ0Lxsr52TsItMW0m1wMDFITolgED++c
         0MmcSveoAJ6MurJHyTJWf1XdI2qKth36l8s7fORa86DN+uu4JI2mzNAQ0kjb+n7mSrvT
         kyWvqR0Sw7zC/JB395xwttpT/WUrp/yttQzGp5NQzoKg/jjXdlG3d+qJDBv+jdH2mXJH
         WbZ0BNMeN4nd39DCM2c5KN7v7HTfrmSZts71k6eDBgeLMgW4QNlW5S9F5e4SilZKENo8
         p6FYgKApejZLmFJSaD7Sl3c20n/cfvWsLjeRAwgRz5wUMhvoAcMR05WQJcY/xaoB4wcq
         XPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=asQR7zN/XNqbk75IdkIIvMcykcD0n/R0IhNlXpw8b/8=;
        b=gZaZV3XLcZ6w1eWA/1xV4SgJkEDHhf+un4I2gt++z4aIqg5aZT/5lOrz5ybZDo5+ma
         n83VevgXGJ7l1dOi19JFMlcRUgUpHTZq06U4zrsHJTPBKeHgbkXZL/eGEt8Ds8cTFTRH
         ml5yJJxhEVk8U1QcEU7MMxkks3oBo/F0gPpsm0B7ShExPrVbcdXaMpPWAlZy1u9esz1Q
         wnqs62uTGzK3KRdX429BeN0z1rYC9HkERsx4vmi6n0T8I6xGrgcNhDjTL87Wz7PIFhVZ
         iqprAyxtdnJmyyCKw87O2AV//Qx3GLkjlWhdG7oFGY1jtsvdjckyW5DkdZAjS3HPHTme
         xFxg==
X-Gm-Message-State: AOAM530YtEJ3+XNTPQeeSNJJ54SLakx2olnoom0USCF6VtoyzShR/my1
        EuXBWRl1JhH8Y9k958+WTyM=
X-Google-Smtp-Source: ABdhPJykrYzUE5FPB44JUthiGF5Brjn/CSN4UgNGAv+EBxSn1Mae7UVPSGCEdYO2ivDR/3cpE4x0jg==
X-Received: by 2002:a05:6402:26c9:b0:423:d545:9d49 with SMTP id x9-20020a05640226c900b00423d5459d49mr16670208edd.242.1650393058264;
        Tue, 19 Apr 2022 11:30:58 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id bq23-20020a056402215700b0041d8fcac53asm8799915edb.23.2022.04.19.11.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:30:57 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        powen.kao@mediatek.com, peter.wang@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] scsi: ufshpb: Cleanup ufshpb_suspend/resume
Date:   Tue, 19 Apr 2022 20:30:44 +0200
Message-Id: <20220419183044.789065-6-huobean@gmail.com>
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

ufshpb_resume() is only called when the HPB state is HPB_SUSPEND, so
the check statement for "ufshpb_get_state(hpb) != HPB_PRESENT" is useless.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshpb.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 4b15fa862beb..0e3bfd241f87 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -2354,11 +2354,9 @@ void ufshpb_suspend(struct ufs_hba *hba)
 
 	shost_for_each_device(sdev, hba->host) {
 		hpb = ufshpb_get_hpb_data(sdev);
-		if (!hpb)
+		if (!hpb || ufshpb_get_state(hpb) != HPB_PRESENT)
 			continue;
 
-		if (ufshpb_get_state(hpb) != HPB_PRESENT)
-			continue;
 		ufshpb_set_state(hpb, HPB_SUSPEND);
 		ufshpb_cancel_jobs(hpb);
 	}
@@ -2371,20 +2369,15 @@ void ufshpb_resume(struct ufs_hba *hba)
 
 	shost_for_each_device(sdev, hba->host) {
 		hpb = ufshpb_get_hpb_data(sdev);
-		if (!hpb)
+		if (!hpb || ufshpb_get_state(hpb) != HPB_SUSPEND)
 			continue;
 
-		if ((ufshpb_get_state(hpb) != HPB_PRESENT) &&
-		    (ufshpb_get_state(hpb) != HPB_SUSPEND))
-			continue;
 		ufshpb_set_state(hpb, HPB_PRESENT);
 		ufshpb_kick_map_work(hpb);
 		if (hpb->is_hcm) {
-			unsigned int poll =
-				hpb->params.timeout_polling_interval_ms;
+			unsigned int poll = hpb->params.timeout_polling_interval_ms;
 
-			schedule_delayed_work(&hpb->ufshpb_read_to_work,
-				msecs_to_jiffies(poll));
+			schedule_delayed_work(&hpb->ufshpb_read_to_work, msecs_to_jiffies(poll));
 		}
 	}
 }
-- 
2.34.1

