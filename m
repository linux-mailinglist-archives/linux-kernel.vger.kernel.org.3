Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2205646C61E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbhLGVJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237547AbhLGVJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:09:23 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E961BC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:05:49 -0800 (PST)
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1muhek-00060K-1J; Tue, 07 Dec 2021 22:05:46 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/3] staging: r8188eu: remove code to set led1 registers
Date:   Tue,  7 Dec 2021 22:05:36 +0100
Message-Id: <20211207210537.23382-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211207210537.23382-1-martin@kaiser.cx>
References: <20211207210537.23382-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses only led0. Remove the register settings to switch led1
on and off.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188eu_led.c | 32 +++++----------------
 drivers/staging/r8188eu/include/rtw_led.h   |  1 -
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_led.c b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
index 0d2d658af5bb..dd692d6a3ab7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
@@ -17,17 +17,9 @@ void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return;
+
 	LedCfg = rtw_read8(padapter, REG_LEDCFG2);
-	switch (pLed->LedPin) {
-	case LED_PIN_LED0:
-		rtw_write8(padapter, REG_LEDCFG2, (LedCfg & 0xf0) | BIT(5) | BIT(6)); /*  SW control led0 on. */
-		break;
-	case LED_PIN_LED1:
-		rtw_write8(padapter, REG_LEDCFG2, (LedCfg & 0x0f) | BIT(5)); /*  SW control led1 on. */
-		break;
-	default:
-		break;
-	}
+	rtw_write8(padapter, REG_LEDCFG2, (LedCfg & 0xf0) | BIT(5) | BIT(6)); /*  SW control led0 on. */
 	pLed->bLedOn = true;
 }
 
@@ -42,21 +34,11 @@ void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 
 	LedCfg = rtw_read8(padapter, REG_LEDCFG2);/* 0x4E */
 
-	switch (pLed->LedPin) {
-	case LED_PIN_LED0:
-		LedCfg &= 0x90; /*  Set to software control. */
-		rtw_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3)));
-		LedCfg = rtw_read8(padapter, REG_MAC_PINMUX_CFG);
-		LedCfg &= 0xFE;
-		rtw_write8(padapter, REG_MAC_PINMUX_CFG, LedCfg);
-		break;
-	case LED_PIN_LED1:
-		LedCfg &= 0x0f; /*  Set to software control. */
-		rtw_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3)));
-		break;
-	default:
-		break;
-	}
+	LedCfg &= 0x90; /*  Set to software control. */
+	rtw_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3)));
+	LedCfg = rtw_read8(padapter, REG_MAC_PINMUX_CFG);
+	LedCfg &= 0xFE;
+	rtw_write8(padapter, REG_MAC_PINMUX_CFG, LedCfg);
 exit:
 	pLed->bLedOn = false;
 }
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 87c41ac6f701..ff182878e371 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -53,7 +53,6 @@ enum LED_STATE_871x {
 
 enum LED_PIN_871x {
 	LED_PIN_LED0 = 1,
-	LED_PIN_LED1 = 2,
 };
 
 struct LED_871x {
-- 
2.20.1

