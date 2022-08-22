Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BBC59C9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiHVUN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiHVUNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:13:49 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11AABCB3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:13:47 -0700 (PDT)
Received: from dslb-188-096-142-076.188.096.pools.vodafone-ip.de ([188.96.142.76] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oQDns-0000pA-4o; Mon, 22 Aug 2022 22:13:44 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/3] staging: r8188eu: always cancel blink_work
Date:   Mon, 22 Aug 2022 22:13:28 +0200
Message-Id: <20220822201329.95559-3-martin@kaiser.cx>
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

In rtw_led_control, we can always cancel a running blink worker when we
start blinking because of no link.

The worker will be scheduled again and there's no point in having more
than one pending blink worker.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index d3299fd1e39d..e63bcf9c0e84 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -222,14 +222,14 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
 			return;
-		if (pLed->bLedLinkBlinkInProgress) {
-			cancel_delayed_work(&pLed->blink_work);
+
+		cancel_delayed_work(&pLed->blink_work);
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
 
 		pLed->bLedNoLinkBlinkInProgress = true;
 		pLed->CurrLedState = LED_BLINK_SLOWLY;
-- 
2.30.2

