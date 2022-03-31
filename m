Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0E24EDA39
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiCaNHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiCaNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:07:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B5049FAF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b24so28072625edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Ctmuw6ZzQ/vE6l7pPQ1kZ77ejeBWjd65IhnZItF+7o=;
        b=PA9hp7AaOABt/iP+ZiFzFNht0r9TpK6+AtLyRBKegBFMk8C5TTBclQn/3LdhL06PYG
         vCXEC3ofAdzCzLcx3hkigp/Ez/+ECsVNcAidWqy4ylzm1/IsErOdS0ehjNX4VQCwNWOm
         Y3rzVugkTNFL7AcqMfXWysAlobQP8jaFe1u1XcqwoILhX/XOMfNyxW3269VcNK6sQbH7
         5SmqSKrL2hfV8nfOABpzrYgtGWIvmPxsRJ8Re7G8lyhKhhMNytkwb8nAARvaS180+8XK
         7ZMx+/DyaMLeLSXovfAkrykFPZDw0nTf5HP6IIR4zyrvW998SXgJGwbUuvrcY8iGxu7s
         UH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Ctmuw6ZzQ/vE6l7pPQ1kZ77ejeBWjd65IhnZItF+7o=;
        b=bGitDZfYVxB/myC8fd1PppxXp3nlkYH6h08OVJAG0xlNrNJEQcW9fYJsFGj4Tttpkm
         pbHAfR0xHTDtcfVfYJyLiXYAphYaBP/vxmxrIivzoKXIxAHZrIU5jIe9jK4FZdT5/J77
         BbLJOGLYlIN4/Eq3Il0K3tgls21rNvuwf53NPGY0MODjiuGKz6YLPDo/H2otiPrg25Et
         oRY9oXjhuK732hBKJwzKAQ8BWRkwxtvIWONzMf0g/+QlOh92HDh5gZfP3NzTcoWf52W3
         F5Tcz9/ASjnBPlUpDUQDkDarSgAzuwVyUBJA6b5erfoYkOlY46VYsnRmTKSlP73vRxnu
         pNVA==
X-Gm-Message-State: AOAM532pnzOzeJmztUMZYHgE6VuD564ryL7CKE3pEql3Vt3AoEV35uls
        2su07xZnQDWpb00I2Hr8v+E=
X-Google-Smtp-Source: ABdhPJw1Tgl4jd12QxFtucjF6mXHRFgjMS1MSm3qywNuDoODZr9ywM5BeRbkZWKKjLLztmCcMrcaFg==
X-Received: by 2002:a05:6402:2681:b0:419:4564:1bd4 with SMTP id w1-20020a056402268100b0041945641bd4mr16634407edd.358.1648731932488;
        Thu, 31 Mar 2022 06:05:32 -0700 (PDT)
Received: from localhost.localdomain ([95.90.187.85])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm9333358ejc.197.2022.03.31.06.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 06:05:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: remove HW_VAR_FWLPS_RF_ON from GetHwReg8188EU()
Date:   Thu, 31 Mar 2022 15:05:21 +0200
Message-Id: <20220331130522.6648-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331130522.6648-1-straube.linux@gmail.com>
References: <20220331130522.6648-1-straube.linux@gmail.com>
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

Move the functionality of the HW_VAR_FWLPS_RF_ON case in
GetHwReg8188EU() to a static function in rtw_pwrctrl.c and remove the
HW_VAR_FWLPS_RF_ON case from GetHwReg8188EU(). This is part of the
ongoing effort to get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 19 ++++++++++++++++---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 18 ------------------
 drivers/staging/r8188eu/include/hal_intf.h |  1 -
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 7beabf82eb92..0141de7ab08c 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -217,6 +217,21 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 
 }
 
+static bool lps_rf_on(struct adapter *adapter)
+{
+	/* When we halt NIC, we should check if FW LPS is leave. */
+	if (adapter->pwrctrlpriv.rf_pwrstate == rf_off) {
+		/*  If it is in HW/SW Radio OFF or IPS state, we do not check Fw LPS Leave, */
+		/*  because Fw is unload. */
+		return true;
+	}
+
+	if (rtw_read32(adapter, REG_RCR) & 0x00070000)
+		return false;
+
+	return true;
+}
+
 /*
  * Return:
  *	0:	Leave OK
@@ -226,13 +241,11 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 s32 LPS_RF_ON_check(struct adapter *padapter, u32 delay_ms)
 {
 	u32 start_time;
-	u8 bAwake = false;
 	s32 err = 0;
 
 	start_time = jiffies;
 	while (1) {
-		GetHwReg8188EU(padapter, HW_VAR_FWLPS_RF_ON, &bAwake);
-		if (bAwake)
+		if (lps_rf_on(padapter))
 			break;
 
 		if (padapter->bSurpriseRemoved) {
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 611785caa17f..37c56690b13a 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1292,24 +1292,6 @@ void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_DM_FLAG:
 		val[0] = podmpriv->SupportAbility;
 		break;
-	case HW_VAR_FWLPS_RF_ON:
-		{
-			/* When we halt NIC, we should check if FW LPS is leave. */
-			if (Adapter->pwrctrlpriv.rf_pwrstate == rf_off) {
-				/*  If it is in HW/SW Radio OFF or IPS state, we do not check Fw LPS Leave, */
-				/*  because Fw is unload. */
-				val[0] = true;
-			} else {
-				u32 valRCR;
-				valRCR = rtw_read32(Adapter, REG_RCR);
-				valRCR &= 0x00070000;
-				if (valRCR)
-					val[0] = false;
-				else
-					val[0] = true;
-			}
-		}
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index f0a6d697e68b..0033a0aca27b 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -26,7 +26,6 @@ enum hw_variables {
 	HW_VAR_AMPDU_FACTOR,
 	HW_VAR_H2C_FW_PWRMODE,
 	HW_VAR_H2C_FW_JOINBSSRPT,
-	HW_VAR_FWLPS_RF_ON,
 	HW_VAR_H2C_FW_P2P_PS_OFFLOAD,
 	HW_VAR_INITIAL_GAIN,
 	HW_VAR_ANTENNA_DIVERSITY_SELECT,
-- 
2.35.1

