Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D33447F8AE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhLZT4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbhLZT41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:56:27 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E83FC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:56:27 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zd1-0000Fz-IC; Sun, 26 Dec 2021 20:56:23 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 15/21] staging: r8188eu: LED_CTL_POWER_ON is not used
Date:   Sun, 26 Dec 2021 20:55:50 +0100
Message-Id: <20211226195556.159471-16-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226195556.159471-1-martin@kaiser.cx>
References: <20211226195556.159471-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LED_CTL_POWER_ON mode is not used by this driver.
Remove the define and related dead code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c    | 4 +---
 drivers/staging/r8188eu/include/rtw_led.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 86c6c1a3b8bf..42d7a645389a 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -197,7 +197,6 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	switch (LedAction) {
-	case LED_CTL_POWER_ON:
 	case LED_CTL_START_TO_LINK:
 	case LED_CTL_NO_LINK:
 		if (!pLed->bLedNoLinkBlinkInProgress) {
@@ -447,8 +446,7 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 	    (LedAction == LED_CTL_TX || LedAction == LED_CTL_RX ||
 	     LedAction == LED_CTL_SITE_SURVEY ||
 	     LedAction == LED_CTL_LINK ||
-	     LedAction == LED_CTL_NO_LINK ||
-	     LedAction == LED_CTL_POWER_ON))
+	     LedAction == LED_CTL_NO_LINK))
 		return;
 
 	SwLedControlMode1(padapter, LedAction);
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 5c7b33e70732..e170db6f3e37 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -8,7 +8,6 @@
 #include "drv_types.h"
 
 enum LED_CTL_MODE {
-	LED_CTL_POWER_ON = 1,
 	LED_CTL_LINK = 2,
 	LED_CTL_NO_LINK = 3,
 	LED_CTL_TX = 4,
-- 
2.30.2

