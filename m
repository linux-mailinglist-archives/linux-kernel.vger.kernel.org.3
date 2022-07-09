Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267A856C864
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiGIJpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGIJpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:45:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC44655AC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:45:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m16so1066437edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w86aGmls26RXvVaGDrDa2oejtOB5CMWP3E/5Lu9xKXA=;
        b=JLBKU6up+BFrYN4tFgccOC2Wdv63Oq+hgnfnDMLNhsMzD80qGt9DQT+frlKh4dWnvV
         No5k6c3DkO2ZZ8nbTXKWTYTH3Cu2yL1+0WPIYfbfR4pK0CJRbYLdia0JMQoZYwMfp1Ka
         TKsT09Ey2R7gCjA1N6OC/9CR7vsjxGbj1GL2wXEo9rPfOOz8l2Uc3GLAvzunxZ6uqVYP
         pD94YWuOIJSvIGmbrA7t2OkzFD7Dh7Rav6x/+rsrHaEmILOIj1LeBNbDlA5y4Crk/Qaf
         Bjt+HfKi7R35Aqx5Vafv97QgU/VCuk0Y19NWB4WtbOSN2xPhYn9vvUxC9ma1MKrXwDqb
         VYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w86aGmls26RXvVaGDrDa2oejtOB5CMWP3E/5Lu9xKXA=;
        b=5SpCJopio5jKGUhHkHw8PooON4e+1tZYj7vlZEUiWh+DCeK8FsYlxzbcJwFIbqL0sf
         joPNmcOKvnIwf2LPsae5wMuH/6Ty1GidUlmQr8pzVUSbE7WRyZi2q+xkIBxKnUEUjAjk
         Tbt0Weqs9RLRLkmNWSJ5XW6ks4AsO+kaIr3FpmNJz5qVONr8gzu0OVBQw9kNxsKARXR1
         +EOUKCABwzgMDmu5+n9Kg5B6WDFy11e/DtwcZzcSlsVSBxd5COFmE5NqroNn8QPdA/0y
         iWhdbn9DiTELou+UQmH/eAsSRo5kR4uPdPn9H2Qky+hLuVrlQWMylISTrbKso76JCBpi
         bn+Q==
X-Gm-Message-State: AJIora+YaRBOD0F2QV9QPI8MMxrCZ27PykAUS+K0B6+t4FW/xUbHMBYq
        v9kwHfYmSHKkMVPGG0V/Q9wt/uZg/MQ=
X-Google-Smtp-Source: AGRyM1tKpt8g5xTPRgX/Pz6gDnRX4LHSFu/rOPzS/jEOd4gmnpBK9cBqHnkHcNjOlelVWW9BMNWLkg==
X-Received: by 2002:aa7:cb05:0:b0:439:aa77:6193 with SMTP id s5-20020aa7cb05000000b00439aa776193mr10503355edt.368.1657359909366;
        Sat, 09 Jul 2022 02:45:09 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6f.dynamic.kabel-deutschland.de. [95.90.187.111])
        by smtp.gmail.com with ESMTPSA id hy10-20020a1709068a6a00b00704757b1debsm441521ejc.9.2022.07.09.02.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 02:45:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: r8188eu: remove HW_VAR_DM_FUNC_OP from SetHwReg8188EU()
Date:   Sat,  9 Jul 2022 11:44:55 +0200
Message-Id: <20220709094458.9578-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220709094458.9578-1-straube.linux@gmail.com>
References: <20220709094458.9578-1-straube.linux@gmail.com>
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

Remove the HW_VAR_DM_FUNC_OP case from SetHwReg8188EU() and move the
functionality to the functions that call SetHwReg8188EU() with
HW_VAR_DM_FUNC_OP. This is part of the ongoing effort to get rid of
SetHwReg8188EU().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 10 ++++++----
 drivers/staging/r8188eu/hal/usb_halinit.c    |  6 ------
 drivers/staging/r8188eu/include/hal_intf.h   |  1 -
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 60c49e161c12..b48e0b9dfd7b 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -264,16 +264,18 @@ void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen)
 
 void Save_DM_Func_Flag(struct adapter *padapter)
 {
-	u8	saveflag = true;
+	struct hal_data_8188e *haldata = &padapter->haldata;
+	struct odm_dm_struct *odmpriv = &haldata->odmpriv;
 
-	SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_OP, (u8 *)(&saveflag));
+	odmpriv->BK_SupportAbility = odmpriv->SupportAbility;
 }
 
 void Restore_DM_Func_Flag(struct adapter *padapter)
 {
-	u8	saveflag = false;
+	struct hal_data_8188e *haldata = &padapter->haldata;
+	struct odm_dm_struct *odmpriv = &haldata->odmpriv;
 
-	SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_OP, (u8 *)(&saveflag));
+	odmpriv->SupportAbility = odmpriv->BK_SupportAbility;
 }
 
 void Set_MSR(struct adapter *padapter, u8 type)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 97893543d861..0aae713d2c1c 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1160,12 +1160,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_DM_FLAG:
 		podmpriv->SupportAbility = *((u8 *)val);
 		break;
-	case HW_VAR_DM_FUNC_OP:
-		if (val[0])
-			podmpriv->BK_SupportAbility = podmpriv->SupportAbility;
-		else
-			podmpriv->SupportAbility = podmpriv->BK_SupportAbility;
-		break;
 	case HW_VAR_DM_FUNC_RESET:
 		podmpriv->SupportAbility = pdmpriv->InitODMFlag;
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 3e0ee33aa131..261823e7e8e8 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -13,7 +13,6 @@ enum hw_variables {
 	HW_VAR_CORRECT_TSF,
 	HW_VAR_MLME_SITESURVEY,
 	HW_VAR_DM_FLAG,
-	HW_VAR_DM_FUNC_OP,
 	HW_VAR_DM_FUNC_RESET,
 	HW_VAR_DM_FUNC_CLR,
 };
-- 
2.36.1

