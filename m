Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF4847F8B0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhLZT44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbhLZT4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:56:32 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BDDC061785
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:56:30 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zd4-0000Fz-JW; Sun, 26 Dec 2021 20:56:26 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 18/21] staging: r8188eu: summarize some BlinkingLedState
Date:   Sun, 26 Dec 2021 20:55:53 +0100
Message-Id: <20211226195556.159471-19-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226195556.159471-1-martin@kaiser.cx>
References: <20211226195556.159471-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move BlinkingLedState updates out of if clauses where the same update
is done for all possible paths.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c | 32 +++++++-------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index e554fef89c56..d1fdd5a4a3ad 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -95,60 +95,44 @@ static void SwLedBlink1(struct LED_871x *pLed)
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 		break;
 	case LED_BLINK_SCAN:
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
 		pLed->BlinkTimes--;
 		if (pLed->BlinkTimes == 0) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_NORMAL;
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
 				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedNoLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_SLOWLY;
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
 				schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 			}
 			pLed->bLedScanBlinkInProgress = false;
 		} else {
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
 			schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
 		}
 		break;
 	case LED_BLINK_TXRX:
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
 		pLed->BlinkTimes--;
 		if (pLed->BlinkTimes == 0) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_NORMAL;
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
 				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedNoLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_SLOWLY;
-				if (pLed->bLedOn)
-					pLed->BlinkingLedState = RTW_LED_OFF;
-				else
-					pLed->BlinkingLedState = RTW_LED_ON;
 				schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 			}
 			pLed->bLedBlinkInProgress = false;
 		} else {
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
 			schedule_delayed_work(&pLed->blink_work, LED_BLINK_FASTER_INTVL);
 		}
 		break;
-- 
2.30.2

