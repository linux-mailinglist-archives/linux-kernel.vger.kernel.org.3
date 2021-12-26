Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C993247F8A2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhLZT4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbhLZT4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:56:16 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF30DC061401
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:56:15 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zcp-0000Fz-OW; Sun, 26 Dec 2021 20:56:11 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/21] staging: r8188eu: move (de)init functions from hal to rtw_led
Date:   Sun, 26 Dec 2021 20:55:38 +0100
Message-Id: <20211226195556.159471-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226195556.159471-1-martin@kaiser.cx>
References: <20211226195556.159471-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the led init and deinit functions from the hal layer to rtw_led.c.
rtl8188eu_led.c and rtl8188e_led.h can now be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/Makefile              |  1 -
 drivers/staging/r8188eu/core/rtw_led.c        | 16 ++++++++++
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   | 30 -------------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |  1 -
 .../staging/r8188eu/include/rtl8188e_led.h    | 16 ----------
 drivers/staging/r8188eu/include/rtw_led.h     |  3 ++
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  2 +-
 8 files changed, 21 insertions(+), 50 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_led.c
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_led.h

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index 580b9308d566..5e1649491ef4 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -22,7 +22,6 @@ r8188eu-y = \
 		hal/rtl8188e_rf6052.o \
 		hal/rtl8188e_rxdesc.o \
 		hal/rtl8188e_xmit.o \
-		hal/rtl8188eu_led.o \
 		hal/rtl8188eu_recv.o \
 		hal/rtl8188eu_xmit.o \
 		hal/usb_halinit.o \
diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 2e3a689fb2fd..50dabc3d2e29 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -417,6 +417,22 @@ void BlinkHandler(struct LED_871x *pLed)
 	SwLedBlink1(pLed);
 }
 
+void rtl8188eu_InitSwLeds(struct adapter *padapter)
+{
+	struct led_priv *pledpriv = &padapter->ledpriv;
+
+	pledpriv->LedControlHandler = LedControl8188eu;
+
+	InitLed871x(padapter, &pledpriv->SwLed0);
+}
+
+void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
+{
+	struct led_priv	*ledpriv = &padapter->ledpriv;
+
+	DeInitLed871x(&ledpriv->SwLed0);
+}
+
 void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
 	struct led_priv *ledpriv = &padapter->ledpriv;
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_led.c b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
deleted file mode 100644
index 46dd8c6703b7..000000000000
--- a/drivers/staging/r8188eu/hal/rtl8188eu_led.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#include "../include/osdep_service.h"
-#include "../include/drv_types.h"
-#include "../include/rtl8188e_hal.h"
-#include "../include/rtl8188e_led.h"
-
-/*  Interface to manipulate LED objects. */
-/*  Default LED behavior. */
-
-/*	Description: */
-/*		Initialize all LED_871x objects. */
-void rtl8188eu_InitSwLeds(struct adapter *padapter)
-{
-	struct led_priv *pledpriv = &padapter->ledpriv;
-
-	pledpriv->LedControlHandler = LedControl8188eu;
-
-	InitLed871x(padapter, &pledpriv->SwLed0);
-}
-
-/*	Description: */
-/*		DeInitialize all LED_819xUsb objects. */
-void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
-{
-	struct led_priv	*ledpriv = &padapter->ledpriv;
-
-	DeInitLed871x(&ledpriv->SwLed0);
-}
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 9edde72aebb2..293a616eabc6 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -8,7 +8,6 @@
 #include "../include/rtw_efuse.h"
 
 #include "../include/rtl8188e_hal.h"
-#include "../include/rtl8188e_led.h"
 #include "../include/rtw_iol.h"
 #include "../include/usb_ops.h"
 #include "../include/usb_osintf.h"
diff --git a/drivers/staging/r8188eu/include/rtl8188e_led.h b/drivers/staging/r8188eu/include/rtl8188e_led.h
deleted file mode 100644
index 02cdc970bb17..000000000000
--- a/drivers/staging/r8188eu/include/rtl8188e_led.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __RTL8188E_LED_H__
-#define __RTL8188E_LED_H__
-
-#include "osdep_service.h"
-#include "drv_types.h"
-
-/*  */
-/*  Interface to manipulate LED objects. */
-/*  */
-void rtl8188eu_InitSwLeds(struct adapter *padapter);
-void rtl8188eu_DeInitSwLeds(struct adapter *padapter);
-
-#endif
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 37f1dbc111f1..d4ba5ac3e48a 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -107,6 +107,9 @@ void ResetLedStatus(struct LED_871x * pLed);
 void InitLed871x(struct adapter *padapter, struct LED_871x *pLed);
 void DeInitLed871x(struct LED_871x *pLed);
 
+void rtl8188eu_InitSwLeds(struct adapter *padapter);
+void rtl8188eu_DeInitSwLeds(struct adapter *padapter);
+
 void BlinkHandler(struct LED_871x * pLed);
 
 #endif /* __RTW_LED_H_ */
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index e7f35143dfe1..88e9734b3094 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -12,7 +12,7 @@
 #include "../include/rtw_ioctl_set.h"
 #include "../include/usb_ops.h"
 #include "../include/rtl8188e_hal.h"
-#include "../include/rtl8188e_led.h"
+#include "../include/rtw_led.h"
 
 #include "../include/rtw_iol.h"
 
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index ad20ab12ee8c..f81e26785d66 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -11,7 +11,7 @@
 #include "../include/rtw_ioctl.h"
 #include "../include/usb_osintf.h"
 #include "../include/rtw_br_ext.h"
-#include "../include/rtl8188e_led.h"
+#include "../include/rtw_led.h"
 #include "../include/rtl8188e_dm.h"
 
 MODULE_LICENSE("GPL");
-- 
2.30.2

