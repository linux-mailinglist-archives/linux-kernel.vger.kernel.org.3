Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC1347F8A3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhLZT4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbhLZT4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:56:16 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC83FC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:56:16 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zcq-0000Fz-Qg; Sun, 26 Dec 2021 20:56:12 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/21] staging: r8188eu: merge InitLed871x and rtl8188eu_InitSwLeds
Date:   Sun, 26 Dec 2021 20:55:39 +0100
Message-Id: <20211226195556.159471-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226195556.159471-1-martin@kaiser.cx>
References: <20211226195556.159471-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy InitLed871x into rtl8188eu_InitSwLeds. There's no need for two
separate functions.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c    | 14 ++++----------
 drivers/staging/r8188eu/include/rtw_led.h |  1 -
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 50dabc3d2e29..541aba6faaf0 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -59,15 +59,6 @@ static void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 	pLed->bLedOn = false;
 }
 
-void InitLed871x(struct adapter *padapter, struct LED_871x *pLed)
-{
-	pLed->padapter = padapter;
-
-	ResetLedStatus(pLed);
-
-	INIT_DELAYED_WORK(&pLed->blink_work, BlinkWorkItemCallback);
-}
-
 void DeInitLed871x(struct LED_871x *pLed)
 {
 	cancel_delayed_work_sync(&pLed->blink_work);
@@ -420,10 +411,13 @@ void BlinkHandler(struct LED_871x *pLed)
 void rtl8188eu_InitSwLeds(struct adapter *padapter)
 {
 	struct led_priv *pledpriv = &padapter->ledpriv;
+	struct LED_871x *pLed = &pledpriv->SwLed0;
 
 	pledpriv->LedControlHandler = LedControl8188eu;
 
-	InitLed871x(padapter, &pledpriv->SwLed0);
+	pLed->padapter = padapter;
+	ResetLedStatus(pLed);
+	INIT_DELAYED_WORK(&pLed->blink_work, BlinkWorkItemCallback);
 }
 
 void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index d4ba5ac3e48a..2c4dc361e469 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -104,7 +104,6 @@ void BlinkWorkItemCallback(struct work_struct *work);
 
 void ResetLedStatus(struct LED_871x * pLed);
 
-void InitLed871x(struct adapter *padapter, struct LED_871x *pLed);
 void DeInitLed871x(struct LED_871x *pLed);
 
 void rtl8188eu_InitSwLeds(struct adapter *padapter);
-- 
2.30.2

