Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE2B47F8A4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhLZT4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhLZT4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:56:18 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B845C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:56:17 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zcr-0000Fz-SE; Sun, 26 Dec 2021 20:56:13 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/21] staging: r8188eu: merge DeInitLed871x and rtl8188eu_DeInitSwLeds
Date:   Sun, 26 Dec 2021 20:55:40 +0100
Message-Id: <20211226195556.159471-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226195556.159471-1-martin@kaiser.cx>
References: <20211226195556.159471-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge DeInitLed871x and rtl8188eu_DeInitSwLeds, both of which are
small and simple.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c    | 12 ++++--------
 drivers/staging/r8188eu/include/rtw_led.h |  2 --
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 541aba6faaf0..1eb70f33c158 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -59,13 +59,6 @@ static void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 	pLed->bLedOn = false;
 }
 
-void DeInitLed871x(struct LED_871x *pLed)
-{
-	cancel_delayed_work_sync(&pLed->blink_work);
-	ResetLedStatus(pLed);
-	SwLedOff(pLed->padapter, pLed);
-}
-
 static void SwLedBlink1(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
@@ -423,8 +416,11 @@ void rtl8188eu_InitSwLeds(struct adapter *padapter)
 void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
 {
 	struct led_priv	*ledpriv = &padapter->ledpriv;
+	struct LED_871x *pLed = &ledpriv->SwLed0;
 
-	DeInitLed871x(&ledpriv->SwLed0);
+	cancel_delayed_work_sync(&pLed->blink_work);
+	ResetLedStatus(pLed);
+	SwLedOff(padapter, pLed);
 }
 
 void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction)
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 2c4dc361e469..ed8574c88288 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -104,8 +104,6 @@ void BlinkWorkItemCallback(struct work_struct *work);
 
 void ResetLedStatus(struct LED_871x * pLed);
 
-void DeInitLed871x(struct LED_871x *pLed);
-
 void rtl8188eu_InitSwLeds(struct adapter *padapter);
 void rtl8188eu_DeInitSwLeds(struct adapter *padapter);
 
-- 
2.30.2

