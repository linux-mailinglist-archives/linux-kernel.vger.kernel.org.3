Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A52E4F0018
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354127AbiDBJ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352019AbiDBJZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:25:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA804A936
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:23:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z92so5503742ede.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYft2sVX3IyvMb409T7bGyIltinifxK7HKRWoSehlTM=;
        b=fYFpSp3Vy5HlvCtf3vpmqt9If72x33fvBQA08FDCU+mwbVJiMNJ+FGlPYntyxsgGsD
         84dZYnjVzldZMSO8vDInElRhVXMJmf79O94hQerYtywVDpOBW/Ab4l11kKnYiuaq9MIZ
         4xPqav+ja09C3Cp5BzCQcvYPxC4Vtv22GjVjY8M9L1bbQb/8CbMeYWzCPbXsLu2GPsJL
         CVT3Zl3E2Om/nGadiUclKOe6TwY9PSd4uuQJ9vzGDyBxE/3kyb/l8qCjHFH7/8xEUF2q
         a1/cFn5j24Ov/19O7eNs/467SQzlZl+c5TAlMxTC2KJO1c1C2PxSpa11PJtRwp5UjKFD
         sP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYft2sVX3IyvMb409T7bGyIltinifxK7HKRWoSehlTM=;
        b=VjzsAI0HJbu48ZpB4aVIorno/fZjeQg7VRsk3tguRPL/YH4iJHcO5NCTJZXE73TSOx
         kxepojf5jWb11FWfygKDrHnYtlR2zNSVJiuKbiimjzIVWI0Ig9jhz/06ojEOdRSA5mg6
         3eRDGwVNLeQaVhBCj5PY918HTrUG2DYbiY7sKklgyhBo6CbOFVKVtHekhhKnZPzRRWTd
         H711hp4MRI65/Z6jRBrTU5emXYHhrZOuxk9l8kP9+IXcCncAl80MEVq9zXTyQrtB17c8
         2XEvohI/s7e/zpxziXbbvZF9EiSt+NgsNdZ9bVUS3A+TF/o0Yy4tJM83sgvqiKEsDds7
         7ITA==
X-Gm-Message-State: AOAM531bYzXWS1pjo0JhN0KED7aUG1GjTKiEtE0ZT/h9WR5KOMTym6HW
        0r1m5deqU5DOF0M68W+b/Z0=
X-Google-Smtp-Source: ABdhPJyomnaPNSKug4pGhCvWr9Ivk7HdNe5zQBeHGSOuQabe7cB6mCLgmitBbafVm1KUz7sB1dmzyg==
X-Received: by 2002:a50:d90f:0:b0:418:8a5a:14b2 with SMTP id t15-20020a50d90f000000b004188a5a14b2mr24302277edj.241.1648891421150;
        Sat, 02 Apr 2022 02:23:41 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id jv19-20020a170907769300b006e095c047d6sm1897679ejc.109.2022.04.02.02.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 02:23:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/7] staging: r8188eu: remove HW_VAR_ANTENNA_DIVERSITY_SELECT from SetHwReg8188EU()
Date:   Sat,  2 Apr 2022 11:23:29 +0200
Message-Id: <20220402092332.6627-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220402092332.6627-1-straube.linux@gmail.com>
References: <20220402092332.6627-1-straube.linux@gmail.com>
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

Remove the HW_VAR_ANTENNA_DIVERSITY_SELECT case from SetHwReg8188EU()
and move its functionality to rtw_cmd.c where it is actually used.
This is part of the ongoing effort to get rid of the unwanted hal
layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c     |  8 +++++++-
 drivers/staging/r8188eu/hal/usb_halinit.c  | 13 -------------
 drivers/staging/r8188eu/include/hal_intf.h |  1 -
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 4fda2fe07ecc..a9152db589c7 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1086,7 +1086,13 @@ u8 rtw_rpt_timer_cfg_cmd(struct adapter *padapter, u16 min_time)
 
 static void antenna_select_wk_hdl(struct adapter *padapter, u8 antenna)
 {
-	SetHwReg8188EU(padapter, HW_VAR_ANTENNA_DIVERSITY_SELECT, (u8 *)(&antenna));
+	struct hal_data_8188e *haldata = &padapter->haldata;
+
+	/* switch current antenna to optimum antenna */
+	if (haldata->CurAntenna != antenna) {
+		ODM_UpdateRxIdleAnt_88E(&haldata->odmpriv, antenna == 2 ? MAIN_ANT : AUX_ANT);
+		haldata->CurAntenna = antenna;
+	}
 }
 
 u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 7b231e9a2193..39db038d75fd 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1181,19 +1181,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			ODM_RA_Set_TxRPT_Time(podmpriv, min_rpt_time);
 		}
 		break;
-	case HW_VAR_ANTENNA_DIVERSITY_SELECT:
-		{
-			u8 Optimum_antenna = (*(u8 *)val);
-			u8 Ant;
-			/* switch antenna to Optimum_antenna */
-			if (haldata->CurAntenna !=  Optimum_antenna) {
-				Ant = (Optimum_antenna == 2) ? MAIN_ANT : AUX_ANT;
-				ODM_UpdateRxIdleAnt_88E(&haldata->odmpriv, Ant);
-
-				haldata->CurAntenna = Optimum_antenna;
-			}
-		}
-		break;
 	case HW_VAR_FIFO_CLEARN_UP:
 		{
 			struct pwrctrl_priv *pwrpriv = &Adapter->pwrctrlpriv;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index c18ff1469c2b..1ba2eb0a46b2 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -25,7 +25,6 @@ enum hw_variables {
 	HW_VAR_H2C_FW_JOINBSSRPT,
 	HW_VAR_H2C_FW_P2P_PS_OFFLOAD,
 	HW_VAR_INITIAL_GAIN,
-	HW_VAR_ANTENNA_DIVERSITY_SELECT,
 	HW_VAR_FIFO_CLEARN_UP,
 	HW_VAR_RPT_TIMER_SETTING,
 	HW_VAR_H2C_MEDIA_STATUS_RPT,
-- 
2.35.1

