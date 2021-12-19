Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DFB47A1CF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 19:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhLSSkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 13:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbhLSSj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 13:39:59 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D41C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 10:39:59 -0800 (PST)
Received: from dslb-188-097-041-189.188.097.pools.vodafone-ip.de ([188.97.41.189] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mz16B-0000Iw-L7; Sun, 19 Dec 2021 19:39:55 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 9/9] staging: r8188: move the steps into Hal8188EPwrSeq.c
Date:   Sun, 19 Dec 2021 19:39:26 +0100
Message-Id: <20211219183926.4746-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211219183926.4746-1-martin@kaiser.cx>
References: <20211219183926.4746-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the power transition steps into Hal8188EPwrSeq.c where the arrays
are defined.

There's no point in having defines for sequences of steps in the include
file. All of these sequences are used only once (apart from the end
sequence).

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c  | 50 ++++++++++++-------
 .../staging/r8188eu/include/Hal8188EPwrSeq.h  | 41 ---------------
 2 files changed, 33 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c b/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
index 0332286c1fa9..566a1701302c 100644
--- a/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
+++ b/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
@@ -1,29 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-#include "../include/Hal8188EPwrSeq.h"
+#include "../include/HalPwrSeqCmd.h"
 #include "../include/rtl8188e_hal.h"
 
-/*
-    drivers should parse below arrays and do the corresponding actions
-*/
-/* 3 Power on  Array */
 struct wl_pwr_cfg rtl8188E_power_on_flow[] = {
-	RTL8188E_TRANS_CARDEMU_TO_ACT
-	RTL8188E_TRANS_END
+	{ 0x0006, PWR_CMD_POLLING, BIT(1), BIT(1) },
+	{ 0x0002, PWR_CMD_WRITE, BIT(0) | BIT(1), 0 }, /* reset BB */
+	{ 0x0026, PWR_CMD_WRITE, BIT(7), BIT(7) }, /* schmitt trigger */
+	{ 0x0005, PWR_CMD_WRITE, BIT(7), 0 }, /* disable HWPDN (control by DRV)*/
+	{ 0x0005, PWR_CMD_WRITE, BIT(4) | BIT(3), 0 }, /* disable WL suspend*/
+	{ 0x0005, PWR_CMD_WRITE, BIT(0), BIT(0) },
+	{ 0x0005, PWR_CMD_POLLING, BIT(0), 0 },
+	{ 0x0023, PWR_CMD_WRITE, BIT(4), 0 },
+	{ 0xFFFF, PWR_CMD_END, 0, 0 },
 };
 
-/* 3Card Disable Array */
-struct wl_pwr_cfg
-rtl8188E_card_disable_flow[] = {
-	RTL8188E_TRANS_ACT_TO_CARDEMU
-	RTL8188E_TRANS_CARDEMU_TO_CARDDIS
-	RTL8188E_TRANS_END
+struct wl_pwr_cfg rtl8188E_card_disable_flow[] = {
+	{ 0x001F, PWR_CMD_WRITE, 0xFF, 0 }, /* turn off RF */
+	{ 0x0023, PWR_CMD_WRITE, BIT(4), BIT(4) }, /* LDO Sleep mode */
+	{ 0x0005, PWR_CMD_WRITE, BIT(1), BIT(1) }, /* turn off MAC by HW state machine */
+	{ 0x0005, PWR_CMD_POLLING, BIT(1), 0 },
+	{ 0x0026, PWR_CMD_WRITE, BIT(7), BIT(7) }, /* schmitt trigger */
+	{ 0x0005, PWR_CMD_WRITE, BIT(3) | BIT(4), BIT(3) }, /* enable WL suspend */
+	{ 0x0007, PWR_CMD_WRITE, 0xFF, 0 }, /* enable bandgap mbias in suspend */
+	{ 0x0041, PWR_CMD_WRITE, BIT(4), 0 }, /* Clear SIC_EN register */
+	{ 0xfe10, PWR_CMD_WRITE, BIT(4), BIT(4) }, /* Set USB suspend enable local register */
+	{ 0xFFFF, PWR_CMD_END, 0, 0 },
 };
 
-/* 3 Enter LPS */
+/* This is used by driver for LPSRadioOff Procedure, not for FW LPS Step */
 struct wl_pwr_cfg rtl8188E_enter_lps_flow[] = {
-	/* FW behavior */
-	RTL8188E_TRANS_ACT_TO_LPS
-	RTL8188E_TRANS_END
+	{ 0x0522, PWR_CMD_WRITE, 0xFF, 0x7F },/* Tx Pause */
+	{ 0x05F8, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */
+	{ 0x05F9, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */
+	{ 0x05FA, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */
+	{ 0x05FB, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */
+	{ 0x0002, PWR_CMD_WRITE, BIT(0), 0 }, /* CCK and OFDM are disabled, clocks are gated */
+	{ 0x0002, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_US },
+	{ 0x0100, PWR_CMD_WRITE, 0xFF, 0x3F }, /* Reset MAC TRX */
+	{ 0x0101, PWR_CMD_WRITE, BIT(1), 0 }, /* check if removed later */
+	{ 0x0553, PWR_CMD_WRITE, BIT(5), BIT(5) }, /* Respond TxOK to scheduler */
+	{ 0xFFFF, PWR_CMD_END, 0, 0 },
 };
diff --git a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
index 19cc5d627893..e4c5b5d23cb4 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
@@ -6,47 +6,6 @@
 
 #include "HalPwrSeqCmd.h"
 
-/* The format of all power transition steps is: { offset, cmd, msk, value } */
-
-#define RTL8188E_TRANS_CARDEMU_TO_ACT	\
-	{ 0x0006, PWR_CMD_POLLING, BIT(1), BIT(1) },	\
-	{ 0x0002, PWR_CMD_WRITE, BIT(0) | BIT(1), 0 }, /* reset BB */	\
-	{ 0x0026, PWR_CMD_WRITE, BIT(7), BIT(7) }, /* schmitt trigger */	\
-	{ 0x0005, PWR_CMD_WRITE, BIT(7), 0 }, /* disable HWPDN (control by DRV)*/	\
-	{ 0x0005, PWR_CMD_WRITE, BIT(4) | BIT(3), 0 }, /* disable WL suspend*/	\
-	{ 0x0005, PWR_CMD_WRITE, BIT(0), BIT(0) },	\
-	{ 0x0005, PWR_CMD_POLLING, BIT(0), 0 },	\
-	{ 0x0023, PWR_CMD_WRITE, BIT(4), 0 }, /* LDO normal mode */
-
-#define RTL8188E_TRANS_ACT_TO_CARDEMU	\
-	{ 0x001F, PWR_CMD_WRITE, 0xFF, 0 },/* turn off RF */	\
-	{ 0x0023, PWR_CMD_WRITE, BIT(4), BIT(4) }, /* LDO Sleep mode */	\
-	{ 0x0005, PWR_CMD_WRITE, BIT(1), BIT(1) }, /* turn off MAC by HW state machine */	\
-	{ 0x0005, PWR_CMD_POLLING, BIT(1), 0 },
-
-#define RTL8188E_TRANS_CARDEMU_TO_CARDDIS	\
-	{ 0x0026, PWR_CMD_WRITE, BIT(7), BIT(7) }, /* schmitt trigger */	\
-	{ 0x0005, PWR_CMD_WRITE, BIT(3) | BIT(4), BIT(3) }, /* enable WL suspend */	\
-	{ 0x0007, PWR_CMD_WRITE, 0xFF, 0 }, /* enable bandgap mbias in suspend */	\
-	{ 0x0041, PWR_CMD_WRITE, BIT(4), 0 }, /* Clear SIC_EN register */	\
-	{ 0xfe10, PWR_CMD_WRITE, BIT(4), BIT(4) }, /* Set USB suspend enable local register */
-
-/* This is used by driver for LPSRadioOff Procedure, not for FW LPS Step */
-#define RTL8188E_TRANS_ACT_TO_LPS	\
-	{ 0x0522, PWR_CMD_WRITE, 0xFF, 0x7F },/* Tx Pause */	\
-	{ 0x05F8, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */	\
-	{ 0x05F9, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */	\
-	{ 0x05FA, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */	\
-	{ 0x05FB, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */	\
-	{ 0x0002, PWR_CMD_WRITE, BIT(0), 0 }, /* CCK and OFDM are disabled, clocks are gated */	\
-	{ 0x0002, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_US },	\
-	{ 0x0100, PWR_CMD_WRITE, 0xFF, 0x3F }, /* Reset MAC TRX */	\
-	{ 0x0101, PWR_CMD_WRITE, BIT(1), 0 }, /* check if removed later */	\
-	{ 0x0553, PWR_CMD_WRITE, BIT(5), BIT(5) }, /* Respond TxOK to scheduler */
-
-#define RTL8188E_TRANS_END	\
-	{ 0xFFFF, PWR_CMD_END, 0, 0 },
-
 extern struct wl_pwr_cfg rtl8188E_power_on_flow[];
 extern struct wl_pwr_cfg rtl8188E_card_disable_flow[];
 extern struct wl_pwr_cfg rtl8188E_enter_lps_flow[];
-- 
2.20.1

