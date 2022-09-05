Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741945ADA08
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiIEUCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiIEUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:02:08 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE735E549
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:02:05 -0700 (PDT)
Received: from dslb-178-004-201-030.178.004.pools.vodafone-ip.de ([178.4.201.30] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oVIIE-00063M-Dg; Mon, 05 Sep 2022 22:02:02 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/7] staging: r8188eu: don't restart WPS blinking unnecessarily
Date:   Mon,  5 Sep 2022 22:01:41 +0200
Message-Id: <20220905200146.82259-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220905200146.82259-1-martin@kaiser.cx>
References: <20220905200146.82259-1-martin@kaiser.cx>
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
during WPS, we don't have to restart this blinking when the caller
requests it again. We can simply return and keep on blinking.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c | 49 +++++++++++++-------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index dd3f0169ff94..d899e42b703d 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -309,31 +309,32 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 		}
 		break;
 	case LED_CTL_START_WPS: /* wait until xinpin finish */
-		if (!pLed->bLedWPSBlinkInProgress) {
-			if (pLed->bLedNoLinkBlinkInProgress) {
-				cancel_delayed_work(&pLed->blink_work);
-				pLed->bLedNoLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedLinkBlinkInProgress) {
-				cancel_delayed_work(&pLed->blink_work);
-				pLed->bLedLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedBlinkInProgress) {
-				cancel_delayed_work(&pLed->blink_work);
-				pLed->bLedBlinkInProgress = false;
-			}
-			if (pLed->bLedScanBlinkInProgress) {
-				cancel_delayed_work(&pLed->blink_work);
-				pLed->bLedScanBlinkInProgress = false;
-			}
-			pLed->bLedWPSBlinkInProgress = true;
-			pLed->CurrLedState = LED_BLINK_WPS;
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
-			schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
+		if (pLed->bLedWPSBlinkInProgress)
+			return;
+
+		if (pLed->bLedNoLinkBlinkInProgress) {
+			cancel_delayed_work(&pLed->blink_work);
+			pLed->bLedNoLinkBlinkInProgress = false;
 		}
+		if (pLed->bLedLinkBlinkInProgress) {
+			cancel_delayed_work(&pLed->blink_work);
+			pLed->bLedLinkBlinkInProgress = false;
+		}
+		if (pLed->bLedBlinkInProgress) {
+			cancel_delayed_work(&pLed->blink_work);
+			pLed->bLedBlinkInProgress = false;
+		}
+		if (pLed->bLedScanBlinkInProgress) {
+			cancel_delayed_work(&pLed->blink_work);
+			pLed->bLedScanBlinkInProgress = false;
+		}
+		pLed->bLedWPSBlinkInProgress = true;
+		pLed->CurrLedState = LED_BLINK_WPS;
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
 		break;
 	case LED_CTL_STOP_WPS:
 		if (pLed->bLedNoLinkBlinkInProgress) {
-- 
2.30.2

