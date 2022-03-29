Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1BE4EB4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiC2UYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiC2UXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:23:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CEF12221F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qa43so37387800ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rm745D6xhclneBAjGr3VVkPQWEDVAMfJN6aO5oy/Yx4=;
        b=XWrTwpWwc6tx4JOrixKR++eET5FoOLIPUNU98mZounH+JyVXW/JA2DxPuCWY6QAjIy
         FoR1QyN8RiiMyWOvyAcD3ZI42e0tBW7EMVaOucIYOWPIotA4X6+pprt0WifmXxSmME4n
         O+XD2urLrbzI6/dzLc2oJ0zz4rgY4dLMPY45iE5BI2mPQVSt3C87UU8/wP0xDdSRWr/J
         9q/pHuhooyy63dz6MK9TvR5tdoZ/zICKUyhTIGAhIhFRLEl8Fog95CXJfmcZnE51vYoX
         QMnClf0/rGMyq+D3OeAHBC0KBUixpeH4XsxlHL4X+P4JjoG9Bj0QH4Clecfy43PpKTMW
         jLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rm745D6xhclneBAjGr3VVkPQWEDVAMfJN6aO5oy/Yx4=;
        b=jn7AxeV5H2DUfuIIK4vRHZgatse4d6TzWsLGckNF0D/CuEKPfgnh7YycGBlTohBVts
         lSetZcQefdno/W/xeqxbPoHTWrPVwdY03NJeb5xaPREwh1Xtkzah9AQi0D0DqywR4Cza
         BlJoDkyrO7ZzWGbU4/a7S1faSXgweC3xjXiqkxSoX+nX8X6ghKa8Jx8NQeD+gurZH1ZR
         Q7tT7WAkqh015U/ET4tvtNICkBQGGUy3EAyfs8nARFBhyAEmdC8Ob2zFg3D6xlG87a5G
         ToswklY0dnA1DUyMWJ7oRPkGZhwb5LCULo6MWEh2RFp+TVhws2KXblO5hVX1HVALA3d+
         4Rmw==
X-Gm-Message-State: AOAM531NlQRIVmv35CwuP7Hae+mU7omAbypQEp8oqaQ7zmZl1EEQWhSx
        k5mhh7vH6KVw0NKqZcLjj/8Ny5ebnYM=
X-Google-Smtp-Source: ABdhPJxSWEuMjJjWnQiMZVz+zwSjoXL8OwJOedad+fGqqzzmL0mySxT/9s/fOSJUHghYbZv0iDlabg==
X-Received: by 2002:a17:906:3adb:b0:6b7:876c:d11b with SMTP id z27-20020a1709063adb00b006b7876cd11bmr36234623ejd.250.1648585312922;
        Tue, 29 Mar 2022 13:21:52 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id ss12-20020a170907038c00b006e0ec9e806dsm3938111ejb.136.2022.03.29.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:21:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 5/8] staging: r8188eu: remove HW_VAR_RXDMA_AGG_PG_TH from SetHwReg8188EU()
Date:   Tue, 29 Mar 2022 22:21:38 +0200
Message-Id: <20220329202141.7028-6-straube.linux@gmail.com>
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

The HW_VAR_RXDMA_AGG_PG_TH case in SetHwReg8188EU() just sets a
variable conditionally and then calls rtw_write8(). Set the variable
in the caller and call rtw_write8() directly. Move the functionality
into a new static function to make the code cleaner. Remove the
HW_VAR_RXDMA_AGG_PG_TH case from SetHwReg8188EU(). This is part of the
ongoing effort to get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: Moved the code into a function and included patch 6/9 of v1.

 drivers/staging/r8188eu/core/rtw_mlme.c    | 34 +++++++++++++---------
 drivers/staging/r8188eu/hal/usb_halinit.c  |  8 -----
 drivers/staging/r8188eu/include/hal_intf.h |  1 -
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index f1e1627641cb..086d64542082 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1787,10 +1787,29 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 
 }
 
+static void rtw_set_threshold(struct adapter *adapter)
+{
+	u8 threshold;
+	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
+	struct ht_priv *htpriv = &mlmepriv->htpriv;
+
+	/*  TH = 1 => means that invalidate usb rx aggregation */
+	/*  TH = 0 => means that validate usb rx aggregation, use init value. */
+	if (htpriv->ht_option) {
+		if (adapter->registrypriv.wifi_spec == 1)
+			threshold = 1;
+		else
+			threshold = USB_RXAGG_PAGE_COUNT;
+
+		rtw_write8(adapter, REG_RXDMA_AGG_PG_TH, threshold);
+	} else {
+		rtw_write8(adapter, REG_RXDMA_AGG_PG_TH, 1);
+	}
+}
+
 /* the function is at passive_level */
 void rtw_joinbss_reset(struct adapter *padapter)
 {
-	u8	threshold;
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv		*phtpriv = &pmlmepriv->htpriv;
 
@@ -1801,18 +1820,7 @@ void rtw_joinbss_reset(struct adapter *padapter)
 
 	phtpriv->ampdu_enable = false;/* reset to disabled */
 
-	/*  TH = 1 => means that invalidate usb rx aggregation */
-	/*  TH = 0 => means that validate usb rx aggregation, use init value. */
-	if (phtpriv->ht_option) {
-		if (padapter->registrypriv.wifi_spec == 1)
-			threshold = 1;
-		else
-			threshold = 0;
-		SetHwReg8188EU(padapter, HW_VAR_RXDMA_AGG_PG_TH, (u8 *)(&threshold));
-	} else {
-		threshold = 1;
-		SetHwReg8188EU(padapter, HW_VAR_RXDMA_AGG_PG_TH, (u8 *)(&threshold));
-	}
+	rtw_set_threshold(padapter);
 }
 
 /* the function is >= passive_level */
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 1bf867123c48..1b08346f2afd 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1193,14 +1193,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_RXDMA_AGG_PG_TH:
-		{
-			u8 threshold = *((u8 *)val);
-			if (threshold == 0)
-				threshold = USB_RXAGG_PAGE_COUNT;
-			rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, threshold);
-		}
-		break;
 	case HW_VAR_H2C_FW_PWRMODE:
 		{
 			u8 psmode = (*(u8 *)val);
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 5b4de29a2e10..8708675c3478 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -25,7 +25,6 @@ enum hw_variables {
 	HW_VAR_AC_PARAM_BE,
 	HW_VAR_AMPDU_MIN_SPACE,
 	HW_VAR_AMPDU_FACTOR,
-	HW_VAR_RXDMA_AGG_PG_TH,
 	HW_VAR_H2C_FW_PWRMODE,
 	HW_VAR_H2C_FW_JOINBSSRPT,
 	HW_VAR_FWLPS_RF_ON,
-- 
2.35.1

