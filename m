Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28D55ADA06
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiIEUCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiIEUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:02:08 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0F75E316
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:02:06 -0700 (PDT)
Received: from dslb-178-004-201-030.178.004.pools.vodafone-ip.de ([178.4.201.30] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oVIIF-00063M-AM; Mon, 05 Sep 2022 22:02:03 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/7] staging: r8188eu: always cancel blink_work before WPS blinking
Date:   Mon,  5 Sep 2022 22:01:42 +0200
Message-Id: <20220905200146.82259-4-martin@kaiser.cx>
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

In rtw_led_control, we can always cancel a running blink worker when we
start WPS blinking.

The worker will be scheduled again and there's no point in having more
than one pending blink worker.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index d899e42b703d..72fef3ac8c0e 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -312,22 +312,19 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 		if (pLed->bLedWPSBlinkInProgress)
 			return;
 
-		if (pLed->bLedNoLinkBlinkInProgress) {
-			cancel_delayed_work(&pLed->blink_work);
+		cancel_delayed_work(&pLed->blink_work);
+		if (pLed->bLedNoLinkBlinkInProgress)
 			pLed->bLedNoLinkBlinkInProgress = false;
-		}
-		if (pLed->bLedLinkBlinkInProgress) {
-			cancel_delayed_work(&pLed->blink_work);
+
+		if (pLed->bLedLinkBlinkInProgress)
 			pLed->bLedLinkBlinkInProgress = false;
-		}
-		if (pLed->bLedBlinkInProgress) {
-			cancel_delayed_work(&pLed->blink_work);
+
+		if (pLed->bLedBlinkInProgress)
 			pLed->bLedBlinkInProgress = false;
-		}
-		if (pLed->bLedScanBlinkInProgress) {
-			cancel_delayed_work(&pLed->blink_work);
+
+		if (pLed->bLedScanBlinkInProgress)
 			pLed->bLedScanBlinkInProgress = false;
-		}
+
 		pLed->bLedWPSBlinkInProgress = true;
 		pLed->CurrLedState = LED_BLINK_WPS;
 		if (pLed->bLedOn)
-- 
2.30.2

