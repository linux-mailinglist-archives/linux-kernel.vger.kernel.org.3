Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0026B51C141
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380084AbiEENv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380001AbiEENvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:51:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38487579A5;
        Thu,  5 May 2022 06:47:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kq17so8862915ejb.4;
        Thu, 05 May 2022 06:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qXWnX76rjsfrPj31CpTpUU8O0igTZZuUO+H5t1tgSUc=;
        b=AW43zGhPY3PZXhJheLH5YyeEpE65Ckj4iTnNDTMJdQlQRv2YdCtlG6GCb56xG2qGEa
         tV6InkkCgv3R+kBVrv9Bru8BSQ8jdYhZfAyCSB+nVgyg4R6+NjoFAK0ParUZaP8f9Bvc
         23foDT8vnDEZOf5N+7tR/m7KcJN1lar3ayI4glbTRN3YT/Kuo1M6SuUrrcqvAlMLX89N
         s15JopNgwcaViXhETRwnaYT2okThhEfiPQqO5qOibXJLo+GIDqRpgQU1i+/p3yPCSFVB
         Ud4KnEcXPZnAG1mQDV+57ZqFvC5DxZCdy6ynXvT5XxAG95k8322sRfipKSdNiE7jrXp3
         MaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qXWnX76rjsfrPj31CpTpUU8O0igTZZuUO+H5t1tgSUc=;
        b=7X8RtxX+aXOVS7WXjSpxalDS4ZcTzXe7Z9Bsih0TeWReK54ObUSH2VV0kvwvMwO7sP
         1HIFBQWDqXhzacOndwp9toBZ063qR1pyxGLD3mtF18ub9CIfuilbj9rVRPzByfbZRnjA
         gdSwR9dwJj9s3DnErlP/qxURvN7+qeyMiimXkCPuuueXPttAyKdFIOl0aQvfiyoDEgEw
         DqZaiaOX8ZMwtMfxzDoFe8mp44rqYBMDPenFo/rAGeyP/8JX6zq8CxjW/loNYted4Eg9
         pyO2L8ka2YvLqXb2+qKIyUG2bPjIGPXaLA7LNJwjdc6pw7NIPE8gEh2QChem2nehND2d
         tmIw==
X-Gm-Message-State: AOAM532jkuyugqvDL3pUxF42DyZTMy3hlZ7lQThwj32FZyYcwY4vMQkm
        /B/VkGLX+lIZI63dFHyZ3fjL8ph8oEJpPw==
X-Google-Smtp-Source: ABdhPJyiL1CEMEEvmwcPqlqbbuqKjqWBO8QS1IaWuZsYMNQynea2Lx49kyXFAG20pv78EZ2YaiJl0A==
X-Received: by 2002:a17:907:7ea7:b0:6f4:7a72:da92 with SMTP id qb39-20020a1709077ea700b006f47a72da92mr15001481ejc.348.1651758442766;
        Thu, 05 May 2022 06:47:22 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906301a00b006f3ef214e69sm728324ejz.207.2022.05.05.06.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:47:22 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com,
        keosung.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] scsi: ufshpb: Cleanup ufshpb_suspend/resume
Date:   Thu,  5 May 2022 15:47:07 +0200
Message-Id: <20220505134707.35929-7-huobean@gmail.com>
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

ufshpb_resume() is only called when the HPB state is HPB_SUSPEND, so
the check statement for "ufshpb_get_state(hpb) != HPB_PRESENT" is useless.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/scsi/ufs/ufshpb.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 859e7ee7bf57..f1f65383e97d 100644
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

