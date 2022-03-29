Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2694EB4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiC2UX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiC2UXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:23:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4623B3FD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id pv16so37466768ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFUJkKDNSDlaGRatgnjRTwnUsmUOuBgdOwxC6d/heDg=;
        b=ILwQiPuexznMlZzfZ499KkWWp3FTCt9En4hJq0G3JPeDcSovZzeVa6o+fkNo+6f6eZ
         rV5Kgk0uzq9H3a73qfvSqXAnlsaIrJOOxunyhgNqePq+uAXu2tdVqhw5WsB3fdrlGzSL
         6x6ISn0SUSjLio6JxqKCJqaie+dLsFgZ82vh+3AhpVJAdItkvtxjNcyBeOdhottgAJ6j
         2h50T+3vFPu1eIpMf4qLsqvq9KNgkSdtrxGpt00xjBjq7s0hdYaNGpVAVO7jxswUIZqg
         JAR9CTlO8XNn8cKXXW+4Epsly+Z26Y7+lwqLwoJJIMUsG1ITV6pSrtjvZyuoEi2cMbwX
         0/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFUJkKDNSDlaGRatgnjRTwnUsmUOuBgdOwxC6d/heDg=;
        b=s4rHvar9PsgoWaxNG3aNw8r37fsqyhhGfGU+lO4PnT3tcWkW2clF5McU9CK5T/ETl2
         s0NCJlKakzKyk+bdR8UijD23y3fiSzkH5Cvz6V1p2i6sC0awcq0DYN1jdVCOGLdMd99g
         OypOP3n36ogBRFzOwJMKT3fHO9MKNsXgQAQ6qYcnWB8EBUfKP1nvSFf0FQiQ9BLpy2Cu
         ZR6DZJWRl308hph5kl1M/RekvIu0mFnkK2DDmZEwfQBpIX3zNq7W12UZYVOUD1K3uYk4
         zmtPTYzkBbcaZL0Ct5VF/oM0w2x2BR+zXjuvEtvNar94gpy5B9to8tICuklXHIql80MV
         0XQA==
X-Gm-Message-State: AOAM5326S6pZPL7EflvenY/Dvwn8yy0UQ9r/prcv9VwmkVKHYVCr+GJy
        itUVfb/7AfhxdVaApFL0Hpw8RUIId0o=
X-Google-Smtp-Source: ABdhPJyoyU0t0fHUeTsbyn9P2w0/m69f5NzLf++en/S7/O08ht/Bf0ZI72Hz+EUn+qNGq1qQqicIQw==
X-Received: by 2002:a17:907:9801:b0:6db:ab31:96f4 with SMTP id ji1-20020a170907980100b006dbab3196f4mr36730399ejc.571.1648585312165;
        Tue, 29 Mar 2022 13:21:52 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id ss12-20020a170907038c00b006e0ec9e806dsm3938111ejb.136.2022.03.29.13.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:21:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/8] staging: r8188eu: remove HW_VAR_ACM_CTRL from SetHwReg8188EU()
Date:   Tue, 29 Mar 2022 22:21:37 +0200
Message-Id: <20220329202141.7028-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329202141.7028-1-straube.linux@gmail.com>
References: <20220329202141.7028-1-straube.linux@gmail.com>
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

SetHwReg8188EU() is called with HW_VAR_ACM_CTRL only from a function
in rtw_wlan_util.c. Move the functionality into a static function in
rtw_wlan_util.c and remove the HW_VAR_ACM_CTRL case from
SetHwReg8188EU(). This is part of the ongoing effort to get rid of the
unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: Moved the code into a function.

 drivers/staging/r8188eu/core/rtw_wlan_util.c | 27 +++++++++++++++++++-
 drivers/staging/r8188eu/hal/usb_halinit.c    | 26 -------------------
 drivers/staging/r8188eu/include/hal_intf.h   |  1 -
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index e44f4752f222..f005bd3c9ff2 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -503,6 +503,31 @@ int WMM_param_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 	return true;
 }
 
+static void set_acm_ctrl(struct adapter *adapter, u8 acm_mask)
+{
+	u8 acmctrl = rtw_read8(adapter, REG_ACMHWCTRL);
+
+	if (acm_mask > 1)
+		acmctrl = acmctrl | 0x1;
+
+	if (acm_mask & BIT(3))
+		acmctrl |= ACMHW_VOQEN;
+	else
+		acmctrl &= (~ACMHW_VOQEN);
+
+	if (acm_mask & BIT(2))
+		acmctrl |= ACMHW_VIQEN;
+	else
+		acmctrl &= (~ACMHW_VIQEN);
+
+	if (acm_mask & BIT(1))
+		acmctrl |= ACMHW_BEQEN;
+	else
+		acmctrl &= (~ACMHW_BEQEN);
+
+	rtw_write8(adapter, REG_ACMHWCTRL, acmctrl);
+}
+
 void WMMOnAssocRsp(struct adapter *padapter)
 {
 	u8	ACI, ACM, AIFS, ECWMin, ECWMax, aSifsTime;
@@ -564,7 +589,7 @@ void WMMOnAssocRsp(struct adapter *padapter)
 	}
 
 	if (padapter->registrypriv.acm_method == 1)
-		SetHwReg8188EU(padapter, HW_VAR_ACM_CTRL, (u8 *)(&acm_mask));
+		set_acm_ctrl(padapter, acm_mask);
 	else
 		padapter->mlmepriv.acm_mask = acm_mask;
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 8dc90f9636b5..1bf867123c48 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1139,32 +1139,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		haldata->AcParam_BE = ((u32 *)(val))[0];
 		rtw_write32(Adapter, REG_EDCA_BE_PARAM, ((u32 *)(val))[0]);
 		break;
-	case HW_VAR_ACM_CTRL:
-		{
-			u8 acm_ctrl = *((u8 *)val);
-			u8 AcmCtrl = rtw_read8(Adapter, REG_ACMHWCTRL);
-
-			if (acm_ctrl > 1)
-				AcmCtrl = AcmCtrl | 0x1;
-
-			if (acm_ctrl & BIT(3))
-				AcmCtrl |= ACMHW_VOQEN;
-			else
-				AcmCtrl &= (~ACMHW_VOQEN);
-
-			if (acm_ctrl & BIT(2))
-				AcmCtrl |= ACMHW_VIQEN;
-			else
-				AcmCtrl &= (~ACMHW_VIQEN);
-
-			if (acm_ctrl & BIT(1))
-				AcmCtrl |= ACMHW_BEQEN;
-			else
-				AcmCtrl &= (~ACMHW_BEQEN);
-
-			rtw_write8(Adapter, REG_ACMHWCTRL, AcmCtrl);
-		}
-		break;
 	case HW_VAR_AMPDU_MIN_SPACE:
 		{
 			u8 MinSpacingToSet;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index d481cc759e27..5b4de29a2e10 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -23,7 +23,6 @@ enum hw_variables {
 	HW_VAR_DM_FUNC_RESET,
 	HW_VAR_DM_FUNC_CLR,
 	HW_VAR_AC_PARAM_BE,
-	HW_VAR_ACM_CTRL,
 	HW_VAR_AMPDU_MIN_SPACE,
 	HW_VAR_AMPDU_FACTOR,
 	HW_VAR_RXDMA_AGG_PG_TH,
-- 
2.35.1

