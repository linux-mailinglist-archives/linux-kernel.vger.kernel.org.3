Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C477547F8C5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 21:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhLZUIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 15:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhLZUIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 15:08:41 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93805C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 12:08:41 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zd6-0000Fz-MP; Sun, 26 Dec 2021 20:56:28 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 20/21] staging: r8188eu: merge rtw_led_control and SwLedControlMode1
Date:   Sun, 26 Dec 2021 20:55:55 +0100
Message-Id: <20211226195556.159471-21-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226195556.159471-1-martin@kaiser.cx>
References: <20211226195556.159471-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_led_control is the only caller of SwLedControlMode1.
Pull SwLedControlMode1 into rtw_led_control.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c | 303 ++++++++++++-------------
 1 file changed, 148 insertions(+), 155 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 2b550e5821e0..09a9676eb503 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -62,12 +62,159 @@ static void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 	pLed->bLedOn = false;
 }
 
-static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAction)
+static void blink_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct LED_871x *pLed = container_of(dwork, struct LED_871x, blink_work);
+	struct adapter *padapter = pLed->padapter;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+
+	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
+		return;
+
+	if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
+		SwLedOff(padapter, pLed);
+		ResetLedStatus(pLed);
+		return;
+	}
+
+	/*  Change LED according to BlinkingLedState specified. */
+	if (pLed->BlinkingLedState == RTW_LED_ON)
+		SwLedOn(padapter, pLed);
+	else
+		SwLedOff(padapter, pLed);
+
+	switch (pLed->CurrLedState) {
+	case LED_BLINK_SLOWLY:
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
+		break;
+	case LED_BLINK_NORMAL:
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
+		break;
+	case LED_BLINK_SCAN:
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		pLed->BlinkTimes--;
+		if (pLed->BlinkTimes == 0) {
+			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
+				pLed->bLedLinkBlinkInProgress = true;
+				pLed->CurrLedState = LED_BLINK_NORMAL;
+				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
+			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
+				pLed->bLedNoLinkBlinkInProgress = true;
+				pLed->CurrLedState = LED_BLINK_SLOWLY;
+				schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
+			}
+			pLed->bLedScanBlinkInProgress = false;
+		} else {
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
+		}
+		break;
+	case LED_BLINK_TXRX:
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		pLed->BlinkTimes--;
+		if (pLed->BlinkTimes == 0) {
+			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
+				pLed->bLedLinkBlinkInProgress = true;
+				pLed->CurrLedState = LED_BLINK_NORMAL;
+				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
+			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
+				pLed->bLedNoLinkBlinkInProgress = true;
+				pLed->CurrLedState = LED_BLINK_SLOWLY;
+				schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
+			}
+			pLed->bLedBlinkInProgress = false;
+		} else {
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_FASTER_INTVL);
+		}
+		break;
+	case LED_BLINK_WPS:
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
+		break;
+	case LED_BLINK_WPS_STOP:	/* WPS success */
+		if (pLed->BlinkingLedState != RTW_LED_ON) {
+			pLed->bLedLinkBlinkInProgress = true;
+			pLed->CurrLedState = LED_BLINK_NORMAL;
+			if (pLed->bLedOn)
+				pLed->BlinkingLedState = RTW_LED_OFF;
+			else
+				pLed->BlinkingLedState = RTW_LED_ON;
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
+
+			pLed->bLedWPSBlinkInProgress = false;
+		} else {
+			pLed->BlinkingLedState = RTW_LED_OFF;
+			schedule_delayed_work(&pLed->blink_work, LED_BLINK_WPS_SUCESS_INTVL);
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+void rtl8188eu_InitSwLeds(struct adapter *padapter)
+{
+	struct led_priv *pledpriv = &padapter->ledpriv;
+	struct LED_871x *pLed = &pledpriv->SwLed0;
+
+	pLed->padapter = padapter;
+	ResetLedStatus(pLed);
+	INIT_DELAYED_WORK(&pLed->blink_work, blink_work);
+}
+
+void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
+{
+	struct led_priv	*ledpriv = &padapter->ledpriv;
+	struct LED_871x *pLed = &ledpriv->SwLed0;
+
+	cancel_delayed_work_sync(&pLed->blink_work);
+	ResetLedStatus(pLed);
+	SwLedOff(padapter, pLed);
+}
+
+void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
 	struct led_priv *ledpriv = &padapter->ledpriv;
+	struct registry_priv *registry_par;
 	struct LED_871x *pLed = &ledpriv->SwLed0;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
+	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped) ||
+	    (!padapter->hw_init_completed))
+		return;
+
+	if (!ledpriv->bRegUseLed)
+		return;
+
+	registry_par = &padapter->registrypriv;
+	if (!registry_par->led_enable)
+		return;
+
+	if ((padapter->pwrctrlpriv.rf_pwrstate != rf_on &&
+	     padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) &&
+	    (LedAction == LED_CTL_TX || LedAction == LED_CTL_RX ||
+	     LedAction == LED_CTL_SITE_SURVEY ||
+	     LedAction == LED_CTL_LINK ||
+	     LedAction == LED_CTL_NO_LINK))
+		return;
+
 	switch (LedAction) {
 	case LED_CTL_START_TO_LINK:
 	case LED_CTL_NO_LINK:
@@ -263,157 +410,3 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		break;
 	}
 }
-
-static void blink_work(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct LED_871x *pLed = container_of(dwork, struct LED_871x, blink_work);
-	struct adapter *padapter = pLed->padapter;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
-		return;
-
-	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON)
-		SwLedOn(padapter, pLed);
-	else
-		SwLedOff(padapter, pLed);
-
-	if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
-		SwLedOff(padapter, pLed);
-		ResetLedStatus(pLed);
-		return;
-	}
-
-	switch (pLed->CurrLedState) {
-	case LED_BLINK_SLOWLY:
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
-		schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
-		break;
-	case LED_BLINK_NORMAL:
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
-		schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
-		break;
-	case LED_BLINK_SCAN:
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
-		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0) {
-			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->bLedLinkBlinkInProgress = true;
-				pLed->CurrLedState = LED_BLINK_NORMAL;
-				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
-			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->bLedNoLinkBlinkInProgress = true;
-				pLed->CurrLedState = LED_BLINK_SLOWLY;
-				schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
-			}
-			pLed->bLedScanBlinkInProgress = false;
-		} else {
-			schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
-		}
-		break;
-	case LED_BLINK_TXRX:
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
-		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0) {
-			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->bLedLinkBlinkInProgress = true;
-				pLed->CurrLedState = LED_BLINK_NORMAL;
-				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
-			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->bLedNoLinkBlinkInProgress = true;
-				pLed->CurrLedState = LED_BLINK_SLOWLY;
-				schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
-			}
-			pLed->bLedBlinkInProgress = false;
-		} else {
-			schedule_delayed_work(&pLed->blink_work, LED_BLINK_FASTER_INTVL);
-		}
-		break;
-	case LED_BLINK_WPS:
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
-		schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
-		break;
-	case LED_BLINK_WPS_STOP:	/* WPS success */
-		if (pLed->BlinkingLedState != RTW_LED_ON) {
-			pLed->bLedLinkBlinkInProgress = true;
-			pLed->CurrLedState = LED_BLINK_NORMAL;
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
-			schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
-
-			pLed->bLedWPSBlinkInProgress = false;
-		} else {
-			pLed->BlinkingLedState = RTW_LED_OFF;
-			schedule_delayed_work(&pLed->blink_work, LED_BLINK_WPS_SUCESS_INTVL);
-		}
-		break;
-	default:
-		break;
-	}
-}
-
-void rtl8188eu_InitSwLeds(struct adapter *padapter)
-{
-	struct led_priv *pledpriv = &padapter->ledpriv;
-	struct LED_871x *pLed = &pledpriv->SwLed0;
-
-	pLed->padapter = padapter;
-	ResetLedStatus(pLed);
-	INIT_DELAYED_WORK(&pLed->blink_work, blink_work);
-}
-
-void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
-{
-	struct led_priv	*ledpriv = &padapter->ledpriv;
-	struct LED_871x *pLed = &ledpriv->SwLed0;
-
-	cancel_delayed_work_sync(&pLed->blink_work);
-	ResetLedStatus(pLed);
-	SwLedOff(padapter, pLed);
-}
-
-void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
-{
-	struct led_priv *ledpriv = &padapter->ledpriv;
-	struct registry_priv *registry_par;
-
-	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped) ||
-	    (!padapter->hw_init_completed))
-		return;
-
-	if (!ledpriv->bRegUseLed)
-		return;
-
-	registry_par = &padapter->registrypriv;
-	if (!registry_par->led_enable)
-		return;
-
-	if ((padapter->pwrctrlpriv.rf_pwrstate != rf_on &&
-	     padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) &&
-	    (LedAction == LED_CTL_TX || LedAction == LED_CTL_RX ||
-	     LedAction == LED_CTL_SITE_SURVEY ||
-	     LedAction == LED_CTL_LINK ||
-	     LedAction == LED_CTL_NO_LINK))
-		return;
-
-	SwLedControlMode1(padapter, LedAction);
-}
-- 
2.30.2

