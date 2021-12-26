Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407AD47F8AD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhLZT4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhLZT40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:56:26 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A2FC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:56:26 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zd0-0000Fz-K0; Sun, 26 Dec 2021 20:56:22 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 14/21] staging: r8188eu: remove LedControlHandler
Date:   Sun, 26 Dec 2021 20:55:49 +0100
Message-Id: <20211226195556.159471-15-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226195556.159471-1-martin@kaiser.cx>
References: <20211226195556.159471-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the function that other layers use for setting the led.

Remove the function pointer and the macro to make the led control function
configurable. This driver supports only a single configuration.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c    |  4 +---
 drivers/staging/r8188eu/include/rtw_led.h | 12 ++----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 8223bddc490b..86c6c1a3b8bf 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -411,8 +411,6 @@ void rtl8188eu_InitSwLeds(struct adapter *padapter)
 	struct led_priv *pledpriv = &padapter->ledpriv;
 	struct LED_871x *pLed = &pledpriv->SwLed0;
 
-	pledpriv->LedControlHandler = LedControl8188eu;
-
 	pLed->padapter = padapter;
 	ResetLedStatus(pLed);
 	INIT_DELAYED_WORK(&pLed->blink_work, blink_work);
@@ -428,7 +426,7 @@ void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
 	SwLedOff(padapter, pLed);
 }
 
-void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction)
+void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
 	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct registry_priv *registry_par;
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 2672ab165784..5c7b33e70732 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -60,22 +60,14 @@ struct LED_871x {
 	struct delayed_work blink_work;
 };
 
-void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE	LedAction);
-
 struct led_priv{
 	struct LED_871x			SwLed0;
 	bool	bRegUseLed;
-	void (*LedControlHandler)(struct adapter *padapter,
-				  enum LED_CTL_MODE LedAction);
 };
 
-#define rtw_led_control(adapt, action) \
-	do { \
-		if ((adapt)->ledpriv.LedControlHandler) \
-			(adapt)->ledpriv.LedControlHandler((adapt), (action)); \
-	} while (0)
-
 void rtl8188eu_InitSwLeds(struct adapter *padapter);
 void rtl8188eu_DeInitSwLeds(struct adapter *padapter);
 
+void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction);
+
 #endif /* __RTW_LED_H_ */
-- 
2.30.2

