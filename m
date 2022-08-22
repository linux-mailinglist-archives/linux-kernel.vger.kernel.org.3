Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05CA59C9B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiHVUNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiHVUNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:13:47 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8A9BC2D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:13:46 -0700 (PDT)
Received: from dslb-188-096-142-076.188.096.pools.vodafone-ip.de ([188.96.142.76] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oQDnq-0000pA-SZ; Mon, 22 Aug 2022 22:13:42 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] staging: r8188eu: don't restart "no link" blinking unnecessarily
Date:   Mon, 22 Aug 2022 22:13:27 +0200
Message-Id: <20220822201329.95559-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220822201329.95559-1-martin@kaiser.cx>
References: <20220822201329.95559-1-martin@kaiser.cx>
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

Simplify one of the cases in rtw_led_control. If we're already blinking
because we have no link, we don't have to restart this blinking when the
caller requests it again. We can simply return and keep on blinking.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c | 37 +++++++++++++-------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index d5c6c5e29621..d3299fd1e39d 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -217,26 +217,27 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 	switch (LedAction) {
 	case LED_CTL_START_TO_LINK:
 	case LED_CTL_NO_LINK:
-		if (!pLed->bLedNoLinkBlinkInProgress) {
-			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
-				return;
-			if (pLed->bLedLinkBlinkInProgress) {
-				cancel_delayed_work(&pLed->blink_work);
-				pLed->bLedLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedBlinkInProgress) {
-				cancel_delayed_work(&pLed->blink_work);
-				pLed->bLedBlinkInProgress = false;
-			}
+		if (pLed->bLedNoLinkBlinkInProgress)
+			return;
 
-			pLed->bLedNoLinkBlinkInProgress = true;
-			pLed->CurrLedState = LED_BLINK_SLOWLY;
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
-			schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
+		if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
+			return;
+		if (pLed->bLedLinkBlinkInProgress) {
+			cancel_delayed_work(&pLed->blink_work);
+			pLed->bLedLinkBlinkInProgress = false;
 		}
+		if (pLed->bLedBlinkInProgress) {
+			cancel_delayed_work(&pLed->blink_work);
+			pLed->bLedBlinkInProgress = false;
+		}
+
+		pLed->bLedNoLinkBlinkInProgress = true;
+		pLed->CurrLedState = LED_BLINK_SLOWLY;
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 		break;
 	case LED_CTL_LINK:
 		if (!pLed->bLedLinkBlinkInProgress) {
-- 
2.30.2

