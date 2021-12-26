Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D686B47F8A6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhLZT4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbhLZT4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:56:20 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5222C061757
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:56:19 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zct-0000Fz-Tm; Sun, 26 Dec 2021 20:56:15 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/21] staging: r8188eu: clean up the blink worker code
Date:   Sun, 26 Dec 2021 20:55:42 +0100
Message-Id: <20211226195556.159471-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226195556.159471-1-martin@kaiser.cx>
References: <20211226195556.159471-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the BlinkWorkItemCallback and BlinkHandler functions.
Rename the resulting function to blink_work and make it
internal to the led layer.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c    | 13 ++++---------
 drivers/staging/r8188eu/include/rtw_led.h |  4 ----
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 52e31d3307df..517aef664bfc 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -5,13 +5,6 @@
 #include "../include/rtw_led.h"
 #include "../include/rtl8188e_spec.h"
 
-void BlinkWorkItemCallback(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct LED_871x *pLed = container_of(dwork, struct LED_871x, blink_work);
-	BlinkHandler(pLed);
-}
-
 static void ResetLedStatus(struct LED_871x *pLed)
 {
 	pLed->CurrLedState = RTW_LED_OFF; /*  Current LED state. */
@@ -391,8 +384,10 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 	}
 }
 
-void BlinkHandler(struct LED_871x *pLed)
+static void blink_work(struct work_struct *work)
 {
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct LED_871x *pLed = container_of(dwork, struct LED_871x, blink_work);
 	struct adapter *padapter = pLed->padapter;
 
 	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
@@ -410,7 +405,7 @@ void rtl8188eu_InitSwLeds(struct adapter *padapter)
 
 	pLed->padapter = padapter;
 	ResetLedStatus(pLed);
-	INIT_DELAYED_WORK(&pLed->blink_work, BlinkWorkItemCallback);
+	INIT_DELAYED_WORK(&pLed->blink_work, blink_work);
 }
 
 void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 984fba6363ad..cd9e40aa7c65 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -100,11 +100,7 @@ struct led_priv{
 			(adapt)->ledpriv.LedControlHandler((adapt), (action)); \
 	} while (0)
 
-void BlinkWorkItemCallback(struct work_struct *work);
-
 void rtl8188eu_InitSwLeds(struct adapter *padapter);
 void rtl8188eu_DeInitSwLeds(struct adapter *padapter);
 
-void BlinkHandler(struct LED_871x * pLed);
-
 #endif /* __RTW_LED_H_ */
-- 
2.30.2

