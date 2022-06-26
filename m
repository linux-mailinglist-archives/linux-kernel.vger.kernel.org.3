Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD03755B36C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 20:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiFZSKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 14:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiFZSKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 14:10:13 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D90A47F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:10:12 -0700 (PDT)
Received: from dslb-188-104-057-109.188.104.pools.vodafone-ip.de ([188.104.57.109] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1o5Whw-00075l-6b; Sun, 26 Jun 2022 20:10:04 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: merge two led structs
Date:   Sun, 26 Jun 2022 20:09:59 +0200
Message-Id: <20220626181000.287225-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The led layer uses struct led_priv and struct LED_871x to store state
info. Merge the two structs. Move LED_871x's components into led_priv.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c    | 27 ++++++++++-------------
 drivers/staging/r8188eu/include/rtw_led.h |  9 +++-----
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 25989acf5259..d5c6c5e29621 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -16,7 +16,7 @@
 	(l)->CurrLedState == LED_BLINK_WPS_STOP || \
 	(l)->bLedWPSBlinkInProgress)
 
-static void ResetLedStatus(struct LED_871x *pLed)
+static void ResetLedStatus(struct led_priv *pLed)
 {
 	pLed->CurrLedState = RTW_LED_OFF; /*  Current LED state. */
 	pLed->bLedOn = false; /*  true if LED is ON, false if LED is OFF. */
@@ -32,7 +32,7 @@ static void ResetLedStatus(struct LED_871x *pLed)
 	pLed->bLedScanBlinkInProgress = false;
 }
 
-static void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
+static void SwLedOn(struct adapter *padapter, struct led_priv *pLed)
 {
 	u8	LedCfg;
 	int res;
@@ -48,7 +48,7 @@ static void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 	pLed->bLedOn = true;
 }
 
-static void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
+static void SwLedOff(struct adapter *padapter, struct led_priv *pLed)
 {
 	u8	LedCfg;
 	int res;
@@ -75,7 +75,7 @@ static void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 static void blink_work(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
-	struct LED_871x *pLed = container_of(dwork, struct LED_871x, blink_work);
+	struct led_priv *pLed = container_of(dwork, struct led_priv, blink_work);
 	struct adapter *padapter = pLed->padapter;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
@@ -182,35 +182,32 @@ static void blink_work(struct work_struct *work)
 void rtl8188eu_InitSwLeds(struct adapter *padapter)
 {
 	struct led_priv *pledpriv = &padapter->ledpriv;
-	struct LED_871x *pLed = &pledpriv->SwLed0;
 
-	pLed->padapter = padapter;
-	ResetLedStatus(pLed);
-	INIT_DELAYED_WORK(&pLed->blink_work, blink_work);
+	pledpriv->padapter = padapter;
+	ResetLedStatus(pledpriv);
+	INIT_DELAYED_WORK(&pledpriv->blink_work, blink_work);
 }
 
 void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
 {
 	struct led_priv	*ledpriv = &padapter->ledpriv;
-	struct LED_871x *pLed = &ledpriv->SwLed0;
 
-	cancel_delayed_work_sync(&pLed->blink_work);
-	ResetLedStatus(pLed);
-	SwLedOff(padapter, pLed);
+	cancel_delayed_work_sync(&ledpriv->blink_work);
+	ResetLedStatus(ledpriv);
+	SwLedOff(padapter, ledpriv);
 }
 
 void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
-	struct led_priv *ledpriv = &padapter->ledpriv;
+	struct led_priv *pLed = &padapter->ledpriv;
 	struct registry_priv *registry_par;
-	struct LED_871x *pLed = &ledpriv->SwLed0;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped) ||
 	    (!padapter->hw_init_completed))
 		return;
 
-	if (!ledpriv->bRegUseLed)
+	if (!pLed->bRegUseLed)
 		return;
 
 	registry_par = &padapter->registrypriv;
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 2c14cb23d9ad..d6b0c1c2f9a2 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -37,9 +37,11 @@ enum LED_STATE_871x {
 	LED_BLINK_RUNTOP = 13, /*  Customized for RunTop */
 };
 
-struct LED_871x {
+struct led_priv {
 	struct adapter *padapter;
 
+	bool bRegUseLed;
+
 	enum LED_STATE_871x	CurrLedState; /*  Current LED state. */
 	enum LED_STATE_871x	BlinkingLedState; /*  Next state for blinking,
 				   * either RTW_LED_ON or RTW_LED_OFF are. */
@@ -58,11 +60,6 @@ struct LED_871x {
 	struct delayed_work blink_work;
 };
 
-struct led_priv{
-	struct LED_871x			SwLed0;
-	bool	bRegUseLed;
-};
-
 void rtl8188eu_InitSwLeds(struct adapter *padapter);
 void rtl8188eu_DeInitSwLeds(struct adapter *padapter);
 
-- 
2.30.2

