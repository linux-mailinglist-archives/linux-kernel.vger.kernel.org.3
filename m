Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8962E50D594
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbiDXWLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbiDXWK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:10:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3565EBE4;
        Sun, 24 Apr 2022 15:07:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kq17so3122941ejb.4;
        Sun, 24 Apr 2022 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bs2RZ1HctDBw64PPVPS3C6pCKSaEHfE9IQYgmcStxr8=;
        b=b2u9VhD247prDS3n7rS0WmOcl/vfomXlP2jbViESjt4BB/UPvIAMLSAS6flZ5Uu7Vx
         0cgeZTCmmRQ5oAmTCgIhCh5QNWdthnW+Zc/5F2/gCoKZyQm571V75YL5x8BVE7a32khY
         nmTlk6poIjwvgOx2G7Qr+0N0MFqtbmJGGvP92cWZXBx29B+PRsO+CtUxqowNJNy21nie
         +59zDqWA5UlV1yhb9byGWLx8BDMyWWcDCzx8gwdzghYEEpFhT74YJCN4JcqjKGsxEpL2
         OEj1ODnfMB3LKqOZVnjagDq/1/s9VKecnlt5UMB91VWc2YSqUJOG7EST6/7dHiwGA5ft
         Zh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bs2RZ1HctDBw64PPVPS3C6pCKSaEHfE9IQYgmcStxr8=;
        b=OMwz2MwgWm0Ln5fGccu3nbU1Gwv6awW1qkIFLwd8Br1VDXLs1Mmg1su9xTrp+70cJF
         iTzaQ5uuMaQvMfOd6+af3R2CIVVskd31L/mvArVmDvvYdf3pn32wDG1luPJZnbDXxt4z
         5pOP4tLwr5WBFrySG/NpcfXAaE0AgG/BzOZAozBpIMVCgPN7Q16fDX9UrDSuak22nlwP
         CDSGueZCE5vlnWyH6WXsdPBkqKLyUpKRXOBFl0tj1Q6QnVTVRzA7aSX8h66jxgVSqZuf
         efllrDgkad4odAGRxV1QrFGlhdaSs75N9UM8BdfP/8QCEqIQFHseLYZuyKohxkB6QHrB
         TKpQ==
X-Gm-Message-State: AOAM5317JYkuVHTz/0aOHQkdgqVHtYvnM5XZgVGRfKOoPFGHXRTxxD72
        ZET6tHAbW5WYyEovkGLIeIA=
X-Google-Smtp-Source: ABdhPJxH1PsgGuRfDwnpIh1IDdPTqumcrLEHf2B1k21lgk/TJV9AFAu6jsNrjADnn0nW8ZLvRfa8/w==
X-Received: by 2002:a17:907:3ea7:b0:6f3:97f6:611b with SMTP id hs39-20020a1709073ea700b006f397f6611bmr1593071ejc.752.1650838046555;
        Sun, 24 Apr 2022 15:07:26 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm3672948edt.92.2022.04.24.15.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 15:07:26 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, keosung.park@samsung.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] scsi: ufshpb: Cleanup ufshpb_suspend/resume
Date:   Mon, 25 Apr 2022 00:07:13 +0200
Message-Id: <20220424220713.1253049-7-huobean@gmail.com>
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

ufshpb_resume() is only called when the HPB state is HPB_SUSPEND, so
the check statement for "ufshpb_get_state(hpb) != HPB_PRESENT" is useless.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshpb.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 7868412054bf..10f40e390dc5 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -2349,11 +2349,9 @@ void ufshpb_suspend(struct ufs_hba *hba)
 
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
@@ -2366,20 +2364,15 @@ void ufshpb_resume(struct ufs_hba *hba)
 
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

