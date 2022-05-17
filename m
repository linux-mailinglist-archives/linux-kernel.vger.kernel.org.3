Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0155752A446
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348360AbiEQOHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348435AbiEQOGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:06:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A5A3E5DA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:06:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d17so17465998plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jbHJ9DXcGeuMwC9N2+XOhDP8Q1hP8OkPUBuzaHRk2o=;
        b=mEtBJuL5JpPfCz/fsT72F/BXMH9APCBPy4vh4OwNqvGqLJHaGdANAD9yqZKWyhWfBj
         I4905TUU9lxSKducmMkVlzy60McBD3OJvIHVStyJ3sHxSb6K6XjOZoyS+sgs0jGkbook
         nlGZ9W3l+2pZEwUoscmhTYlOOJtDI6jXR3GWZvOkP47UwzrmdeVryBPgQuuLenFO0jPh
         ItWThTh6uMMJdbyiPolHCJERIDyBX7cXhFysESwVG1Vx+hO138UzdTA1N4dw1Xr9HwuX
         Aq1x7BwnBOh/Xr6sJhTd+xS07QlPvZohne+sf6swqkUIVQiNOc4SUIXkzdHWTP+yW8xt
         zI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jbHJ9DXcGeuMwC9N2+XOhDP8Q1hP8OkPUBuzaHRk2o=;
        b=F5VYKkykbixOnMsdz+NbrDRW1TlgmeWgB85DFinbgVBsJUs18dRkFBGSmyHZrAh0Gw
         EovCcwGymUWWuKLTI4TP7EaVQO86cVIk3IAP8a6W0cuzOt7j5Xh3xVdqkX8XPm0SqZOz
         m+ou2npLq+vE35r+qoLHaF9OMJwD0nkqwo1xsUCSgbvv/8bW3OexpMkcbdV7zTzH4gUT
         9oWhQAEiSxTzdej0Xnt5RF4i/Zspv17YUdLjBEWi969jeoJbQ7uL8+86r98G7jEaRDQs
         pAaD5blJi/3O24uj2tfU99h7j+dIHLTlhUJcs7cK49lh3F4RUZfY8z4sBY1DZHNlQaIw
         lkQA==
X-Gm-Message-State: AOAM533mPxlm7V7rlFmGB+aOUfCzFYbFq+ImTFveeLXS0gXGJ3pjRhEN
        xNPELfHpj0xQdDo7GThUGvg=
X-Google-Smtp-Source: ABdhPJy/VZiv2rzW3k1La/4pQZltsRDHxnKk0dW4ieUxLZTpSUD3iwWMktfDCqvQkvRay5UFQYqY1w==
X-Received: by 2002:a17:902:e0d4:b0:161:74ba:9def with SMTP id e20-20020a170902e0d400b0016174ba9defmr10852821pla.28.1652796403676;
        Tue, 17 May 2022 07:06:43 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:1:3174:ae5c:a49e:4e77])
        by smtp.gmail.com with ESMTPSA id z34-20020a631922000000b003f27f91135asm3113289pgl.76.2022.05.17.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:06:43 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 2/3] staging: r8188eu: fix warnings in rtw_pwrctrl
Date:   Tue, 17 May 2022 19:36:25 +0530
Message-Id: <20220517140626.3716-3-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517140626.3716-1-makvihas@gmail.com>
References: <20220517140626.3716-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the code to fix following warnings:
    WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 6990808ef..a54d47ba8 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -59,7 +59,7 @@ int ips_leave(struct adapter *padapter)
 			pwrpriv->rf_pwrstate = rf_on;
 		}
 
-		if ((_WEP40_ == psecuritypriv->dot11PrivacyAlgrthm) || (_WEP104_ == psecuritypriv->dot11PrivacyAlgrthm)) {
+		if ((psecuritypriv->dot11PrivacyAlgrthm == _WEP40_) || (psecuritypriv->dot11PrivacyAlgrthm == _WEP104_)) {
 			set_channel_bwmode(padapter, padapter->mlmeextpriv.cur_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 			for (keyid = 0; keyid < 4; keyid++) {
 				if (pmlmepriv->key_mask & BIT(keyid)) {
@@ -198,7 +198,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 		return;
 
 	if (pwrpriv->pwr_mode == ps_mode) {
-		if (PS_MODE_ACTIVE == ps_mode)
+		if (ps_mode == PS_MODE_ACTIVE)
 			return;
 
 		if ((pwrpriv->smart_ps == smart_ps) &&
@@ -356,7 +356,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 
 	pwrctrlpriv->LpsIdleCount = 0;
 	pwrctrlpriv->power_mgnt = padapter->registrypriv.power_mgnt;/*  PS_MODE_MIN; */
-	pwrctrlpriv->bLeisurePs = PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt;
+	pwrctrlpriv->bLeisurePs = pwrctrlpriv->power_mgnt != PS_MODE_ACTIVE;
 
 	pwrctrlpriv->bFwCurrentInPSMode = false;
 
@@ -409,12 +409,12 @@ int rtw_pm_set_lps(struct adapter *padapter, u8 mode)
 
 	if (mode < PS_MODE_NUM) {
 		if (pwrctrlpriv->power_mgnt != mode) {
-			if (PS_MODE_ACTIVE == mode)
+			if (mode == PS_MODE_ACTIVE)
 				LeaveAllPowerSaveMode(padapter);
 			else
 				pwrctrlpriv->LpsIdleCount = 2;
 			pwrctrlpriv->power_mgnt = mode;
-			pwrctrlpriv->bLeisurePs = PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt;
+			pwrctrlpriv->bLeisurePs = pwrctrlpriv->power_mgnt != PS_MODE_ACTIVE;
 		}
 	} else {
 		ret = -EINVAL;
@@ -432,7 +432,7 @@ int rtw_pm_set_ips(struct adapter *padapter, u8 mode)
 		return 0;
 	} else if (mode == IPS_NONE) {
 		rtw_ips_mode_req(pwrctrlpriv, mode);
-		if ((padapter->bSurpriseRemoved == 0) && (_FAIL == rtw_pwr_wakeup(padapter)))
+		if ((padapter->bSurpriseRemoved == 0) && (rtw_pwr_wakeup(padapter) == _FAIL))
 			return -EFAULT;
 	} else {
 		return -EINVAL;
-- 
2.30.2

