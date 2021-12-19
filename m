Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6047A1C9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 19:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbhLSSjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 13:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbhLSSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 13:39:48 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A9CC061746
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 10:39:48 -0800 (PST)
Received: from dslb-188-097-041-189.188.097.pools.vodafone-ip.de ([188.97.41.189] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mz15z-0000Iw-F2; Sun, 19 Dec 2021 19:39:43 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/9] staging: r8188: remove cut mask from power transitions
Date:   Sun, 19 Dec 2021 19:39:20 +0100
Message-Id: <20211219183926.4746-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211219183926.4746-1-martin@kaiser.cx>
References: <20211219183926.4746-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the power cut mask from the steps of the power transitions.
The power cut mask is not used, all values are allowed for all steps.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |  5 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  6 +-
 .../staging/r8188eu/include/Hal8188EPwrSeq.h  | 72 +++++++++----------
 .../staging/r8188eu/include/HalPwrSeqCmd.h    | 17 +----
 4 files changed, 42 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 0fd11aca7ac7..f64b5352f043 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -25,7 +25,7 @@ Major Change History:
  *	Assumption:
  *		We should follow specific format which was released from HW SD.
  */
-u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
+u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 fab_vers,
 		       u8 ifacetype, struct wl_pwr_cfg pwrseqcmd[])
 {
 	struct wl_pwr_cfg pwrcfgcmd = {0};
@@ -39,9 +39,8 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 	do {
 		pwrcfgcmd = pwrseqcmd[aryidx];
 
-		/* 2 Only Handle the command whose FAB, CUT, and Interface are matched */
+		/* 2 Only Handle the command whose FAB and Interface are matched */
 		if ((GET_PWR_CFG_FAB_MASK(pwrcfgcmd) & fab_vers) &&
-		    (GET_PWR_CFG_CUT_MASK(pwrcfgcmd) & cut_vers) &&
 		    (GET_PWR_CFG_INTF_MASK(pwrcfgcmd) & ifacetype)) {
 			switch (GET_PWR_CFG_CMD(pwrcfgcmd)) {
 			case PWR_CMD_WRITE:
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 40227078c4b6..528a53d3e61e 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -78,7 +78,7 @@ u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 	if (haldata->bMacPwrCtrlOn)
 		return _SUCCESS;
 
-	if (!HalPwrSeqCmdParsing(adapt, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_PWR_ON_FLOW)) {
+	if (!HalPwrSeqCmdParsing(adapt, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_PWR_ON_FLOW)) {
 		DBG_88E(KERN_ERR "%s: run power on flow fail\n", __func__);
 		return _FAIL;
 	}
@@ -824,7 +824,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	rtw_write8(Adapter, REG_CR, 0x0);
 
 	/*  Run LPS WL RFOFF flow */
-	HalPwrSeqCmdParsing(Adapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_LPS_ENTER_FLOW);
+	HalPwrSeqCmdParsing(Adapter, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_LPS_ENTER_FLOW);
 
 	/*  2. 0x1F[7:0] = 0		turn off RF */
 
@@ -845,7 +845,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	rtw_write8(Adapter, REG_32K_CTRL, val8 & (~BIT(0)));
 
 	/*  Card disable power action flow */
-	HalPwrSeqCmdParsing(Adapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_DISABLE_FLOW);
+	HalPwrSeqCmdParsing(Adapter, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_DISABLE_FLOW);
 
 	/*  Reset MCU IO Wrapper */
 	val8 = rtw_read8(Adapter, REG_RSV_CTRL + 1);
diff --git a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
index d36a2ab2ec7b..c1da4a4bf9c9 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
@@ -8,55 +8,55 @@
 
 #define RTL8188E_TRANS_CARDEMU_TO_ACT														\
 	/* format */																\
-	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
-	{0x0006, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(1), BIT(1)},/* wait till 0x04[17] = 1    power ready*/	\
-	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0)|BIT(1), 0}, /* 0x02[1:0] = 0	reset BB*/			\
-	{0x0026, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), 0}, /* 0x04[15] = 0 disable HWPDN (control by DRV)*/\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4)|BIT(3), 0}, /*0x04[12:11] = 2b'00 disable WL suspend*/	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), BIT(0)}, /*0x04[8] = 1 polling until return 0*/	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(0), 0}, /*wait till 0x04[8] = 0*/	\
-	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*LDO normal mode*/	\
-	{0x0074, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*SDIO Driving*/	\
+	/* { offset, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
+	{0x0006, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(1), BIT(1)},/* wait till 0x04[17] = 1    power ready*/	\
+	{0x0002, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0)|BIT(1), 0}, /* 0x02[1:0] = 0	reset BB*/			\
+	{0x0026, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
+	{0x0005, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), 0}, /* 0x04[15] = 0 disable HWPDN (control by DRV)*/\
+	{0x0005, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4)|BIT(3), 0}, /*0x04[12:11] = 2b'00 disable WL suspend*/	\
+	{0x0005, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), BIT(0)}, /*0x04[8] = 1 polling until return 0*/	\
+	{0x0005, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(0), 0}, /*wait till 0x04[8] = 0*/	\
+	{0x0023, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*LDO normal mode*/	\
+	{0x0074, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*SDIO Driving*/	\
 
 #define RTL8188E_TRANS_ACT_TO_CARDEMU													\
 	/* format */																\
-	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
-	{0x001F, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0},/*0x1F[7:0] = 0 turn off RF*/	\
-	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*LDO Sleep mode*/	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), BIT(1)}, /*0x04[9] = 1 turn off MAC by HW state machine*/	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(1), 0}, /*wait till 0x04[9] = 0 polling until return 0 to disable*/	\
+	/* { offset, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
+	{0x001F, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0},/*0x1F[7:0] = 0 turn off RF*/	\
+	{0x0023, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*LDO Sleep mode*/	\
+	{0x0005, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), BIT(1)}, /*0x04[9] = 1 turn off MAC by HW state machine*/	\
+	{0x0005, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(1), 0}, /*wait till 0x04[9] = 0 polling until return 0 to disable*/	\
 
 #define RTL8188E_TRANS_CARDEMU_TO_CARDDIS													\
 	/* format */																\
-	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value },  comments here*/							\
-	{0x0026, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(3)|BIT(4), BIT(3)}, /*0x04[12:11] = 2b'01 enable WL suspend*/	\
-	{0x0007, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0}, /*  0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */	\
-	{0x0041, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*Clear SIC_EN register 0x40[12] = 1'b0 */	\
-	{0xfe10, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*Set USB suspend enable local register  0xfe10[4]=1 */	\
-	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT(0), BIT(0)}, /*Set SDIO suspend local register*/	\
-	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT(1), 0}, /*wait power state to suspend*/
+	/* { offset, fab_msk|interface_msk, base|cmd, msk, value },  comments here*/							\
+	{0x0026, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
+	{0x0005, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(3)|BIT(4), BIT(3)}, /*0x04[12:11] = 2b'01 enable WL suspend*/	\
+	{0x0007, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0}, /*  0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */	\
+	{0x0041, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*Clear SIC_EN register 0x40[12] = 1'b0 */	\
+	{0xfe10, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*Set USB suspend enable local register  0xfe10[4]=1 */	\
+	{0x0086, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT(0), BIT(0)}, /*Set SDIO suspend local register*/	\
+	{0x0086, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT(1), 0}, /*wait power state to suspend*/
 
 /* This is used by driver for LPSRadioOff Procedure, not for FW LPS Step */
 #define RTL8188E_TRANS_ACT_TO_LPS														\
 	/* format */																\
-	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here				*/   \
-	{0x0522, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x7F},/*Tx Pause*/	\
-	{0x05F8, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x05F9, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x05FA, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x05FB, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), 0},/*CCK and OFDM are disabled,and clock are gated*/	\
-	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_US},/*Delay 1us*/	\
-	{0x0100, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x3F},/*Reset MAC TRX*/	\
-	{0x0101, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), 0},/*check if removed later*/	\
-	{0x0553, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(5), BIT(5)},/*Respond TxOK to scheduler*/	\
+	/* { offset, fab_msk|interface_msk, base|cmd, msk, value }, comments here				*/   \
+	{0x0522, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x7F},/*Tx Pause*/	\
+	{0x05F8, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x05F9, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x05FA, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x05FB, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x0002, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), 0},/*CCK and OFDM are disabled,and clock are gated*/	\
+	{0x0002, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_US},/*Delay 1us*/	\
+	{0x0100, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x3F},/*Reset MAC TRX*/	\
+	{0x0101, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), 0},/*check if removed later*/	\
+	{0x0553, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(5), BIT(5)},/*Respond TxOK to scheduler*/	\
 
 #define RTL8188E_TRANS_END															\
 	/* format */																\
-	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value },  comments here*/					\
-	{0xFFFF, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK,0, PWR_CMD_END, 0, 0}, /*  */
+	/* { offset, fab_msk|interface_msk, base|cmd, msk, value },  comments here*/					\
+	{0xFFFF, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK,0, PWR_CMD_END, 0, 0}, /*  */
 
 extern struct wl_pwr_cfg rtl8188E_power_on_flow[];
 extern struct wl_pwr_cfg rtl8188E_card_disable_flow[];
diff --git a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
index fe7ac910beb8..f82860bd0e83 100644
--- a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
+++ b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
@@ -65,19 +65,6 @@
 #define	PWR_FAB_UMC_MSK			BIT(1)
 #define	PWR_FAB_ALL_MSK			(BIT(0)|BIT(1)|BIT(2)|BIT(3))
 
-/*---------------------------------------------*/
-/* 3 The value of cut_msk: 8 bits */
-/*---------------------------------------------*/
-#define	PWR_CUT_TESTCHIP_MSK		BIT(0)
-#define	PWR_CUT_A_MSK			BIT(1)
-#define	PWR_CUT_B_MSK			BIT(2)
-#define	PWR_CUT_C_MSK			BIT(3)
-#define	PWR_CUT_D_MSK			BIT(4)
-#define	PWR_CUT_E_MSK			BIT(5)
-#define	PWR_CUT_F_MSK			BIT(6)
-#define	PWR_CUT_G_MSK			BIT(7)
-#define	PWR_CUT_ALL_MSK			0xFF
-
 enum pwrseq_cmd_delat_unit {
 	PWRSEQ_DELAY_US,
 	PWRSEQ_DELAY_MS,
@@ -85,7 +72,6 @@ enum pwrseq_cmd_delat_unit {
 
 struct wl_pwr_cfg {
 	u16 offset;
-	u8 cut_msk;
 	u8 fab_msk:4;
 	u8 interface_msk:4;
 	u8 base:4;
@@ -95,7 +81,6 @@ struct wl_pwr_cfg {
 };
 
 #define GET_PWR_CFG_OFFSET(__PWR_CMD)		__PWR_CMD.offset
-#define GET_PWR_CFG_CUT_MASK(__PWR_CMD)		__PWR_CMD.cut_msk
 #define GET_PWR_CFG_FAB_MASK(__PWR_CMD)		__PWR_CMD.fab_msk
 #define GET_PWR_CFG_INTF_MASK(__PWR_CMD)	__PWR_CMD.interface_msk
 #define GET_PWR_CFG_BASE(__PWR_CMD)		__PWR_CMD.base
@@ -104,7 +89,7 @@ struct wl_pwr_cfg {
 #define GET_PWR_CFG_VALUE(__PWR_CMD)		__PWR_CMD.value
 
 /*	Prototype of protected function. */
-u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 CutVersion, u8 FabVersion,
+u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 FabVersion,
 		       u8 InterfaceType, struct wl_pwr_cfg PwrCfgCmd[]);
 
 #endif
-- 
2.20.1

