Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0747F8B2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhLZT5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhLZT4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:56:31 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1162FC06175F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:56:30 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zd3-0000Fz-Jo; Sun, 26 Dec 2021 20:56:25 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 17/21] staging: r8188eu: remove bStopBlinking
Date:   Sun, 26 Dec 2021 20:55:52 +0100
Message-Id: <20211226195556.159471-18-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226195556.159471-1-martin@kaiser.cx>
References: <20211226195556.159471-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the temporary variable bStopBlinking and check the conditions
directly in the if clauses. There's no need to save the result of
these checks.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 20e805718557..e554fef89c56 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -66,7 +66,6 @@ static void SwLedBlink1(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	u8 bStopBlinking = false;
 
 	/*  Change LED according to BlinkingLedState specified. */
 	if (pLed->BlinkingLedState == RTW_LED_ON)
@@ -97,9 +96,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 		break;
 	case LED_BLINK_SCAN:
 		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-		if (bStopBlinking) {
+		if (pLed->BlinkTimes == 0) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_NORMAL;
@@ -128,9 +125,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 		break;
 	case LED_BLINK_TXRX:
 		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0)
-			bStopBlinking = true;
-		if (bStopBlinking) {
+		if (pLed->BlinkTimes == 0) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_NORMAL;
@@ -165,12 +160,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
 		break;
 	case LED_BLINK_WPS_STOP:	/* WPS success */
-		if (pLed->BlinkingLedState == RTW_LED_ON)
-			bStopBlinking = false;
-		else
-			bStopBlinking = true;
-
-		if (bStopBlinking) {
+		if (pLed->BlinkingLedState != RTW_LED_ON) {
 			pLed->bLedLinkBlinkInProgress = true;
 			pLed->CurrLedState = LED_BLINK_NORMAL;
 			if (pLed->bLedOn)
-- 
2.30.2

