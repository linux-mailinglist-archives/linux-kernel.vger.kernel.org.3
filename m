Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FAC46C61F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbhLGVJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbhLGVJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:09:23 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60353C061756
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:05:51 -0800 (PST)
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1muhel-00060K-4x; Tue, 07 Dec 2021 22:05:47 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/3] staging: r8188eu: remove LedPin from struct struct LED_871x
Date:   Tue,  7 Dec 2021 22:05:37 +0100
Message-Id: <20211207210537.23382-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211207210537.23382-1-martin@kaiser.cx>
References: <20211207210537.23382-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only support a single LED. LedPin in struct struct LED_871x is
always LED_PIN_LED0. There's no need to store this info or to pass it
to functions as a parameter.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c      |  3 +--
 drivers/staging/r8188eu/hal/rtl8188eu_led.c |  7 +------
 drivers/staging/r8188eu/include/rtw_led.h   | 10 +---------
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 1eda366c61aa..e1be1ba189cb 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -28,10 +28,9 @@ void ResetLedStatus(struct LED_871x *pLed)
 	pLed->bLedScanBlinkInProgress = false;
 }
 
-void InitLed871x(struct adapter *padapter, struct LED_871x *pLed, enum LED_PIN_871x LedPin)
+void InitLed871x(struct adapter *padapter, struct LED_871x *pLed)
 {
 	pLed->padapter = padapter;
-	pLed->LedPin = LedPin;
 
 	ResetLedStatus(pLed);
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_led.c b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
index dd692d6a3ab7..6fd1d1d476c7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
@@ -8,9 +8,6 @@
 
 /*  LED object. */
 
-/*  LED_819xUsb routines. */
-/*	Description: */
-/*		Turn on LED according to LedPin specified. */
 void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 {
 	u8	LedCfg;
@@ -23,8 +20,6 @@ void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 	pLed->bLedOn = true;
 }
 
-/*	Description: */
-/*		Turn off LED according to LedPin specified. */
 void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 {
 	u8	LedCfg;
@@ -54,7 +49,7 @@ void rtl8188eu_InitSwLeds(struct adapter *padapter)
 
 	pledpriv->LedControlHandler = LedControl8188eu;
 
-	InitLed871x(padapter, &pledpriv->SwLed0, LED_PIN_LED0);
+	InitLed871x(padapter, &pledpriv->SwLed0);
 }
 
 /*	Description: */
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index ff182878e371..e9b6d7768c2d 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -51,15 +51,9 @@ enum LED_STATE_871x {
 	LED_BLINK_ALWAYS_ON = 16,
 };
 
-enum LED_PIN_871x {
-	LED_PIN_LED0 = 1,
-};
-
 struct LED_871x {
 	struct adapter *padapter;
 
-	enum LED_PIN_871x	LedPin;	/* Identify how to implement this
-					 * SW led. */
 	enum LED_STATE_871x	CurrLedState; /*  Current LED state. */
 	enum LED_STATE_871x	BlinkingLedState; /*  Next state for blinking,
 				   * either RTW_LED_ON or RTW_LED_OFF are. */
@@ -110,9 +104,7 @@ void BlinkWorkItemCallback(struct work_struct *work);
 
 void ResetLedStatus(struct LED_871x * pLed);
 
-void InitLed871x(struct adapter *padapter, struct LED_871x *pLed,
-		 enum LED_PIN_871x LedPin);
-
+void InitLed871x(struct adapter *padapter, struct LED_871x *pLed);
 void DeInitLed871x(struct LED_871x *pLed);
 
 /* hal... */
-- 
2.20.1

