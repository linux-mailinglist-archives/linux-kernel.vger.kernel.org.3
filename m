Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F55A55C3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbiF0IyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiF0IyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:54:17 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90AD62DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:54:14 -0700 (PDT)
Received: from dslb-188-104-058-231.188.104.pools.vodafone-ip.de ([188.104.58.231] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1o5kVS-0005uS-KM; Mon, 27 Jun 2022 10:54:07 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: make power sequences static
Date:   Mon, 27 Jun 2022 10:53:54 +0200
Message-Id: <20220627085354.28849-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
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

Simplify the handling of "power sequences". At the moment, this is rather
complicated:
The hal layer calls HalPwrSeqCmdParsing. This function takes a pointer to
a power sequence. The sequences themselves are defined as global variables
in a separate file. There's an alias for each sequence, the callers of
HalPwrSeqCmdParsing use these aliases instead of the sequences themselves.

There's no point in passing the sequences around. We can move the
sequences into the same file as the HalPwrSeqCmdParsing function where
they are used. Callers of HalPwrSeqCmdParsing can refer to a sequence by
using a numeric define rather than a pointer to the sequence.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/Makefile              |  1 -
 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c  | 45 ---------------
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    | 57 ++++++++++++++++++-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  8 +--
 .../staging/r8188eu/include/Hal8188EPwrSeq.h  | 13 -----
 .../staging/r8188eu/include/HalPwrSeqCmd.h    |  8 ++-
 .../staging/r8188eu/include/rtl8188e_hal.h    |  5 --
 7 files changed, 67 insertions(+), 70 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
 delete mode 100644 drivers/staging/r8188eu/include/Hal8188EPwrSeq.h

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index 1d7982b618ba..eea16eb7caa0 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -5,7 +5,6 @@ r8188eu-y = \
 		hal/HalHWImg8188E_RF.o \
 		hal/HalPhyRf_8188e.o \
 		hal/HalPwrSeqCmd.o \
-		hal/Hal8188EPwrSeq.o \
 		hal/Hal8188ERateAdaptive.o \
 		hal/hal_intf.o \
 		hal/hal_com.o \
diff --git a/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c b/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
deleted file mode 100644
index 6505e1fcb070..000000000000
--- a/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#include "../include/Hal8188EPwrSeq.h"
-#include "../include/rtl8188e_hal.h"
-
-struct wl_pwr_cfg rtl8188E_power_on_flow[] = {
-	{ 0x0006, PWR_CMD_POLLING, BIT(1), BIT(1) },
-	{ 0x0002, PWR_CMD_WRITE, BIT(0) | BIT(1), 0 }, /* reset BB */
-	{ 0x0026, PWR_CMD_WRITE, BIT(7), BIT(7) }, /* schmitt trigger */
-	{ 0x0005, PWR_CMD_WRITE, BIT(7), 0 }, /* disable HWPDN (control by DRV)*/
-	{ 0x0005, PWR_CMD_WRITE, BIT(4) | BIT(3), 0 }, /* disable WL suspend*/
-	{ 0x0005, PWR_CMD_WRITE, BIT(0), BIT(0) },
-	{ 0x0005, PWR_CMD_POLLING, BIT(0), 0 },
-	{ 0x0023, PWR_CMD_WRITE, BIT(4), 0 },
-	{ 0xFFFF, PWR_CMD_END, 0, 0 },
-};
-
-struct wl_pwr_cfg rtl8188E_card_disable_flow[] = {
-	{ 0x001F, PWR_CMD_WRITE, 0xFF, 0 }, /* turn off RF */
-	{ 0x0023, PWR_CMD_WRITE, BIT(4), BIT(4) }, /* LDO Sleep mode */
-	{ 0x0005, PWR_CMD_WRITE, BIT(1), BIT(1) }, /* turn off MAC by HW state machine */
-	{ 0x0005, PWR_CMD_POLLING, BIT(1), 0 },
-	{ 0x0026, PWR_CMD_WRITE, BIT(7), BIT(7) }, /* schmitt trigger */
-	{ 0x0005, PWR_CMD_WRITE, BIT(3) | BIT(4), BIT(3) }, /* enable WL suspend */
-	{ 0x0007, PWR_CMD_WRITE, 0xFF, 0 }, /* enable bandgap mbias in suspend */
-	{ 0x0041, PWR_CMD_WRITE, BIT(4), 0 }, /* Clear SIC_EN register */
-	{ 0xfe10, PWR_CMD_WRITE, BIT(4), BIT(4) }, /* Set USB suspend enable local register */
-	{ 0xFFFF, PWR_CMD_END, 0, 0 },
-};
-
-/* This is used by driver for LPSRadioOff Procedure, not for FW LPS Step */
-struct wl_pwr_cfg rtl8188E_enter_lps_flow[] = {
-	{ 0x0522, PWR_CMD_WRITE, 0xFF, 0x7F },/* Tx Pause */
-	{ 0x05F8, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */
-	{ 0x05F9, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */
-	{ 0x05FA, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */
-	{ 0x05FB, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */
-	{ 0x0002, PWR_CMD_WRITE, BIT(0), 0 }, /* CCK and OFDM are disabled, clocks are gated */
-	{ 0x0002, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_US },
-	{ 0x0100, PWR_CMD_WRITE, 0xFF, 0x3F }, /* Reset MAC TRX */
-	{ 0x0101, PWR_CMD_WRITE, BIT(1), 0 }, /* check if removed later */
-	{ 0x0553, PWR_CMD_WRITE, BIT(5), BIT(5) }, /* Respond TxOK to scheduler */
-	{ 0xFFFF, PWR_CMD_END, 0, 0 },
-};
diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 4a4563b900b3..b5f6d41464db 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -3,9 +3,50 @@
 
 #include "../include/HalPwrSeqCmd.h"
 
-u8 HalPwrSeqCmdParsing(struct adapter *padapter, struct wl_pwr_cfg pwrseqcmd[])
+static struct wl_pwr_cfg rtl8188E_power_on_flow[] = {
+	{ 0x0006, PWR_CMD_POLLING, BIT(1), BIT(1) },
+	{ 0x0002, PWR_CMD_WRITE, BIT(0) | BIT(1), 0 }, /* reset BB */
+	{ 0x0026, PWR_CMD_WRITE, BIT(7), BIT(7) }, /* schmitt trigger */
+	{ 0x0005, PWR_CMD_WRITE, BIT(7), 0 }, /* disable HWPDN (control by DRV)*/
+	{ 0x0005, PWR_CMD_WRITE, BIT(4) | BIT(3), 0 }, /* disable WL suspend*/
+	{ 0x0005, PWR_CMD_WRITE, BIT(0), BIT(0) },
+	{ 0x0005, PWR_CMD_POLLING, BIT(0), 0 },
+	{ 0x0023, PWR_CMD_WRITE, BIT(4), 0 },
+	{ 0xFFFF, PWR_CMD_END, 0, 0 },
+};
+
+static struct wl_pwr_cfg rtl8188E_card_disable_flow[] = {
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
+};
+
+/* This is used by driver for LPSRadioOff Procedure, not for FW LPS Step */
+static struct wl_pwr_cfg rtl8188E_enter_lps_flow[] = {
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
+};
+
+u8 HalPwrSeqCmdParsing(struct adapter *padapter, enum r8188eu_pwr_seq seq)
 {
 	struct wl_pwr_cfg pwrcfgcmd = {0};
+	struct wl_pwr_cfg *pwrseqcmd;
 	u8 poll_bit = false;
 	u32 aryidx = 0;
 	u8 value = 0;
@@ -14,6 +55,20 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, struct wl_pwr_cfg pwrseqcmd[])
 	u32 max_poll_count = 5000;
 	int res;
 
+	switch (seq) {
+	case PWR_ON_FLOW:
+		pwrseqcmd = rtl8188E_power_on_flow;
+		break;
+	case DISABLE_FLOW:
+		pwrseqcmd = rtl8188E_card_disable_flow;
+		break;
+	case LPS_ENTER_FLOW:
+		pwrseqcmd = rtl8188E_enter_lps_flow;
+		break;
+	default:
+		return false;
+	};
+
 	do {
 		pwrcfgcmd = pwrseqcmd[aryidx];
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index cb9b4bcc536a..bb3045111147 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -11,7 +11,7 @@
 #include "../include/rtw_iol.h"
 #include "../include/usb_ops.h"
 #include "../include/usb_osintf.h"
-#include "../include/Hal8188EPwrSeq.h"
+#include "../include/HalPwrSeqCmd.h"
 
 static void _ConfigNormalChipOutEP_8188E(struct adapter *adapt, u8 NumOutPipe)
 {
@@ -59,7 +59,7 @@ u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 	if (haldata->bMacPwrCtrlOn)
 		return _SUCCESS;
 
-	if (!HalPwrSeqCmdParsing(adapt, Rtl8188E_NIC_PWR_ON_FLOW))
+	if (!HalPwrSeqCmdParsing(adapt, PWR_ON_FLOW))
 		return _FAIL;
 
 	/*  Enable MAC DMA/WMAC/SCHEDULE/SEC block */
@@ -798,7 +798,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	rtw_write8(Adapter, REG_CR, 0x0);
 
 	/*  Run LPS WL RFOFF flow */
-	HalPwrSeqCmdParsing(Adapter, Rtl8188E_NIC_LPS_ENTER_FLOW);
+	HalPwrSeqCmdParsing(Adapter, LPS_ENTER_FLOW);
 
 	/*  2. 0x1F[7:0] = 0		turn off RF */
 
@@ -828,7 +828,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	rtw_write8(Adapter, REG_32K_CTRL, val8 & (~BIT(0)));
 
 	/*  Card disable power action flow */
-	HalPwrSeqCmdParsing(Adapter, Rtl8188E_NIC_DISABLE_FLOW);
+	HalPwrSeqCmdParsing(Adapter, DISABLE_FLOW);
 
 	/*  Reset MCU IO Wrapper */
 	res = rtw_read8(Adapter, REG_RSV_CTRL + 1, &val8);
diff --git a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
deleted file mode 100644
index e4c5b5d23cb4..000000000000
--- a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __HAL8188EPWRSEQ_H__
-#define __HAL8188EPWRSEQ_H__
-
-#include "HalPwrSeqCmd.h"
-
-extern struct wl_pwr_cfg rtl8188E_power_on_flow[];
-extern struct wl_pwr_cfg rtl8188E_card_disable_flow[];
-extern struct wl_pwr_cfg rtl8188E_enter_lps_flow[];
-
-#endif /* __HAL8188EPWRSEQ_H__ */
diff --git a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
index 49c02cce569e..869f54d99e57 100644
--- a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
+++ b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
@@ -53,7 +53,13 @@ struct wl_pwr_cfg {
 #define GET_PWR_CFG_MASK(__PWR_CMD)		__PWR_CMD.msk
 #define GET_PWR_CFG_VALUE(__PWR_CMD)		__PWR_CMD.value
 
+enum r8188eu_pwr_seq {
+	PWR_ON_FLOW,
+	DISABLE_FLOW,
+	LPS_ENTER_FLOW,
+};
+
 /*	Prototype of protected function. */
-u8 HalPwrSeqCmdParsing(struct adapter *padapter, struct wl_pwr_cfg PwrCfgCmd[]);
+u8 HalPwrSeqCmdParsing(struct adapter *padapter, enum r8188eu_pwr_seq seq);
 
 #endif
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index d2a069d4e1cc..5cd62b216720 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -26,11 +26,6 @@
 #include "odm_RegConfig8188E.h"
 #include "odm_RTL8188E.h"
 
-/* 		RTL8188E Power Configuration CMDs for USB/SDIO interfaces */
-#define Rtl8188E_NIC_PWR_ON_FLOW		rtl8188E_power_on_flow
-#define Rtl8188E_NIC_DISABLE_FLOW		rtl8188E_card_disable_flow
-#define Rtl8188E_NIC_LPS_ENTER_FLOW		rtl8188E_enter_lps_flow
-
 #define DRVINFO_SZ	4 /*  unit is 8bytes */
 #define PageNum_128(_Len)	(u32)(((_Len)>>7) + ((_Len) & 0x7F ? 1 : 0))
 
-- 
2.30.2

