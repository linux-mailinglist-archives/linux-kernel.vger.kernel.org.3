Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0028047A1CB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 19:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhLSSj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 13:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbhLSSjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 13:39:52 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34E6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 10:39:51 -0800 (PST)
Received: from dslb-188-097-041-189.188.097.pools.vodafone-ip.de ([188.97.41.189] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mz162-0000Iw-MH; Sun, 19 Dec 2021 19:39:46 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/9] staging: r8188: remove interface mask from power transitions
Date:   Sun, 19 Dec 2021 19:39:22 +0100
Message-Id: <20211219183926.4746-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211219183926.4746-1-martin@kaiser.cx>
References: <20211219183926.4746-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the r8188 driver, we always have a usb interface. We can remove
the power transition steps that are not applicable for a usb interface.

We can then remove the interface mask itself.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    | 81 +++++++++----------
 drivers/staging/r8188eu/hal/usb_halinit.c     |  6 +-
 .../staging/r8188eu/include/Hal8188EPwrSeq.h  | 69 ++++++++--------
 .../staging/r8188eu/include/HalPwrSeqCmd.h    | 12 +--
 4 files changed, 76 insertions(+), 92 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index ae8bcfe2319c..47ad4ea273cc 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -25,7 +25,7 @@ Major Change History:
  *	Assumption:
  *		We should follow specific format which was released from HW SD.
  */
-u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 ifacetype, struct wl_pwr_cfg pwrseqcmd[])
+u8 HalPwrSeqCmdParsing(struct adapter *padapter, struct wl_pwr_cfg pwrseqcmd[])
 {
 	struct wl_pwr_cfg pwrcfgcmd = {0};
 	u8 poll_bit = false;
@@ -38,52 +38,49 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 ifacetype, struct wl_pwr_cfg
 	do {
 		pwrcfgcmd = pwrseqcmd[aryidx];
 
-		/* 2 Only Handle the command whose Interface is matched */
-		if ((GET_PWR_CFG_INTF_MASK(pwrcfgcmd) & ifacetype)) {
-			switch (GET_PWR_CFG_CMD(pwrcfgcmd)) {
-			case PWR_CMD_WRITE:
-				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
+		switch (GET_PWR_CFG_CMD(pwrcfgcmd)) {
+		case PWR_CMD_WRITE:
+			offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
 
-				/*  Read the value from system register */
-				value = rtw_read8(padapter, offset);
-
-				value &= ~(GET_PWR_CFG_MASK(pwrcfgcmd));
-				value |= (GET_PWR_CFG_VALUE(pwrcfgcmd) & GET_PWR_CFG_MASK(pwrcfgcmd));
+			/*  Read the value from system register */
+			value = rtw_read8(padapter, offset);
 
-				/*  Write the value back to system register */
-				rtw_write8(padapter, offset, value);
-				break;
-			case PWR_CMD_POLLING:
-				poll_bit = false;
-				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
-				do {
-					value = rtw_read8(padapter, offset);
+			value &= ~(GET_PWR_CFG_MASK(pwrcfgcmd));
+			value |= (GET_PWR_CFG_VALUE(pwrcfgcmd) & GET_PWR_CFG_MASK(pwrcfgcmd));
 
-					value &= GET_PWR_CFG_MASK(pwrcfgcmd);
-					if (value == (GET_PWR_CFG_VALUE(pwrcfgcmd) & GET_PWR_CFG_MASK(pwrcfgcmd)))
-						poll_bit = true;
-					else
-						udelay(10);
+			/*  Write the value back to system register */
+			rtw_write8(padapter, offset, value);
+			break;
+		case PWR_CMD_POLLING:
+			poll_bit = false;
+			offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
+			do {
+				value = rtw_read8(padapter, offset);
 
-					if (poll_count++ > max_poll_count) {
-						DBG_88E("Fail to polling Offset[%#x]\n", offset);
-						return false;
-					}
-				} while (!poll_bit);
-				break;
-			case PWR_CMD_DELAY:
-				if (GET_PWR_CFG_VALUE(pwrcfgcmd) == PWRSEQ_DELAY_US)
-					udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd));
+				value &= GET_PWR_CFG_MASK(pwrcfgcmd);
+				if (value == (GET_PWR_CFG_VALUE(pwrcfgcmd) & GET_PWR_CFG_MASK(pwrcfgcmd)))
+					poll_bit = true;
 				else
-					udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd) * 1000);
-				break;
-			case PWR_CMD_END:
-				/*  When this command is parsed, end the process */
-				return true;
-				break;
-			default:
-				break;
-			}
+					udelay(10);
+
+				if (poll_count++ > max_poll_count) {
+					DBG_88E("Fail to polling Offset[%#x]\n", offset);
+					return false;
+				}
+			} while (!poll_bit);
+			break;
+		case PWR_CMD_DELAY:
+			if (GET_PWR_CFG_VALUE(pwrcfgcmd) == PWRSEQ_DELAY_US)
+				udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd));
+			else
+				udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd) * 1000);
+			break;
+		case PWR_CMD_END:
+			/*  When this command is parsed, end the process */
+			return true;
+			break;
+		default:
+			break;
 		}
 
 		aryidx++;/* Add Array Index */
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 3d73e6a96872..9edde72aebb2 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -78,7 +78,7 @@ u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 	if (haldata->bMacPwrCtrlOn)
 		return _SUCCESS;
 
-	if (!HalPwrSeqCmdParsing(adapt, PWR_INTF_USB_MSK, Rtl8188E_NIC_PWR_ON_FLOW)) {
+	if (!HalPwrSeqCmdParsing(adapt, Rtl8188E_NIC_PWR_ON_FLOW)) {
 		DBG_88E(KERN_ERR "%s: run power on flow fail\n", __func__);
 		return _FAIL;
 	}
@@ -824,7 +824,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	rtw_write8(Adapter, REG_CR, 0x0);
 
 	/*  Run LPS WL RFOFF flow */
-	HalPwrSeqCmdParsing(Adapter, PWR_INTF_USB_MSK, Rtl8188E_NIC_LPS_ENTER_FLOW);
+	HalPwrSeqCmdParsing(Adapter, Rtl8188E_NIC_LPS_ENTER_FLOW);
 
 	/*  2. 0x1F[7:0] = 0		turn off RF */
 
@@ -845,7 +845,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	rtw_write8(Adapter, REG_32K_CTRL, val8 & (~BIT(0)));
 
 	/*  Card disable power action flow */
-	HalPwrSeqCmdParsing(Adapter, PWR_INTF_USB_MSK, Rtl8188E_NIC_DISABLE_FLOW);
+	HalPwrSeqCmdParsing(Adapter, Rtl8188E_NIC_DISABLE_FLOW);
 
 	/*  Reset MCU IO Wrapper */
 	val8 = rtw_read8(Adapter, REG_RSV_CTRL + 1);
diff --git a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
index 8682e33d4430..44016b798f89 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
@@ -8,55 +8,52 @@
 
 #define RTL8188E_TRANS_CARDEMU_TO_ACT														\
 	/* format */																\
-	/* { offset, interface_msk, base|cmd, msk, value }, comments here*/								\
-	{0x0006, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(1), BIT(1)},/* wait till 0x04[17] = 1    power ready*/	\
-	{0x0002, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0)|BIT(1), 0}, /* 0x02[1:0] = 0	reset BB*/			\
-	{0x0026, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
-	{0x0005, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), 0}, /* 0x04[15] = 0 disable HWPDN (control by DRV)*/\
-	{0x0005, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4)|BIT(3), 0}, /*0x04[12:11] = 2b'00 disable WL suspend*/	\
-	{0x0005, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), BIT(0)}, /*0x04[8] = 1 polling until return 0*/	\
-	{0x0005, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(0), 0}, /*wait till 0x04[8] = 0*/	\
-	{0x0023, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*LDO normal mode*/	\
-	{0x0074, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*SDIO Driving*/	\
+	/* { offset, base|cmd, msk, value }, comments here*/								\
+	{0x0006, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(1), BIT(1)},/* wait till 0x04[17] = 1    power ready*/	\
+	{0x0002, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0)|BIT(1), 0}, /* 0x02[1:0] = 0	reset BB*/			\
+	{0x0026, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
+	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), 0}, /* 0x04[15] = 0 disable HWPDN (control by DRV)*/\
+	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4)|BIT(3), 0}, /*0x04[12:11] = 2b'00 disable WL suspend*/	\
+	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), BIT(0)}, /*0x04[8] = 1 polling until return 0*/	\
+	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(0), 0}, /*wait till 0x04[8] = 0*/	\
+	{0x0023, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*LDO normal mode*/	\
 
 #define RTL8188E_TRANS_ACT_TO_CARDEMU													\
 	/* format */																\
-	/* { offset, interface_msk, base|cmd, msk, value }, comments here*/								\
-	{0x001F, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0},/*0x1F[7:0] = 0 turn off RF*/	\
-	{0x0023, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*LDO Sleep mode*/	\
-	{0x0005, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), BIT(1)}, /*0x04[9] = 1 turn off MAC by HW state machine*/	\
-	{0x0005, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(1), 0}, /*wait till 0x04[9] = 0 polling until return 0 to disable*/	\
+	/* { offset, base|cmd, msk, value }, comments here*/								\
+	{0x001F, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0},/*0x1F[7:0] = 0 turn off RF*/	\
+	{0x0023, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*LDO Sleep mode*/	\
+	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), BIT(1)}, /*0x04[9] = 1 turn off MAC by HW state machine*/	\
+	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(1), 0}, /*wait till 0x04[9] = 0 polling until return 0 to disable*/	\
 
 #define RTL8188E_TRANS_CARDEMU_TO_CARDDIS													\
 	/* format */																\
-	/* { offset, interface_msk, base|cmd, msk, value },  comments here*/							\
-	{0x0026, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
-	{0x0005, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(3)|BIT(4), BIT(3)}, /*0x04[12:11] = 2b'01 enable WL suspend*/	\
-	{0x0007, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0}, /*  0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */	\
-	{0x0041, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*Clear SIC_EN register 0x40[12] = 1'b0 */	\
-	{0xfe10, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*Set USB suspend enable local register  0xfe10[4]=1 */	\
-	{0x0086, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT(0), BIT(0)}, /*Set SDIO suspend local register*/	\
-	{0x0086, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT(1), 0}, /*wait power state to suspend*/
+	/* { offset, base|cmd, msk, value },  comments here*/							\
+	{0x0026, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
+	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(3)|BIT(4), BIT(3)}, /*0x04[12:11] = 2b'01 enable WL suspend*/	\
+	{0x0007, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0}, /*  0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */	\
+	{0x0041, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*Clear SIC_EN register 0x40[12] = 1'b0 */	\
+	{0xfe10, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*Set USB suspend enable local register  0xfe10[4]=1 */	\
 
 /* This is used by driver for LPSRadioOff Procedure, not for FW LPS Step */
 #define RTL8188E_TRANS_ACT_TO_LPS														\
 	/* format */																\
-	/* { offset, interface_msk, base|cmd, msk, value }, comments here				*/   \
-	{0x0522, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x7F},/*Tx Pause*/	\
-	{0x05F8, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x05F9, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x05FA, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x05FB, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x0002, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), 0},/*CCK and OFDM are disabled,and clock are gated*/	\
-	{0x0002, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_US},/*Delay 1us*/	\
-	{0x0100, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x3F},/*Reset MAC TRX*/	\
-	{0x0101, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), 0},/*check if removed later*/	\
-	{0x0553, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(5), BIT(5)},/*Respond TxOK to scheduler*/	\
+	/* { offset, base|cmd, msk, value }, comments here				*/   \
+	{0x0522, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x7F},/*Tx Pause*/	\
+	{0x05F8, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x05F9, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x05FA, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x05FB, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x0002, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), 0},/*CCK and OFDM are disabled,and clock are gated*/	\
+	{0x0002, PWR_BASEADDR_MAC, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_US},/*Delay 1us*/	\
+	{0x0100, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x3F},/*Reset MAC TRX*/	\
+	{0x0101, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), 0},/*check if removed later*/	\
+	{0x0553, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(5), BIT(5)},/*Respond TxOK to scheduler*/	\
 
 #define RTL8188E_TRANS_END															\
 	/* format */																\
-	/* { offset, interface_msk, base|cmd, msk, value },  comments here*/					\
-	{0xFFFF, PWR_INTF_ALL_MSK,0, PWR_CMD_END, 0, 0}, /*  */
+	/* { offset, base|cmd, msk, value },  comments here*/					\
+	{0xFFFF, 0, PWR_CMD_END, 0, 0}, /*  */
 
 extern struct wl_pwr_cfg rtl8188E_power_on_flow[];
 extern struct wl_pwr_cfg rtl8188E_card_disable_flow[];
diff --git a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
index 69173c9970b7..e1826fc9c001 100644
--- a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
+++ b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
@@ -50,14 +50,6 @@
 #define PWR_BASEADDR_PCIE		0x02
 #define PWR_BASEADDR_SDIO		0x03
 
-/*---------------------------------------------*/
-/* 3 The value of interface_msk: 4 bits */
-/*---------------------------------------------*/
-#define	PWR_INTF_SDIO_MSK		BIT(0)
-#define	PWR_INTF_USB_MSK		BIT(1)
-#define	PWR_INTF_PCI_MSK		BIT(2)
-#define	PWR_INTF_ALL_MSK		(BIT(0)|BIT(1)|BIT(2)|BIT(3))
-
 enum pwrseq_cmd_delat_unit {
 	PWRSEQ_DELAY_US,
 	PWRSEQ_DELAY_MS,
@@ -65,7 +57,6 @@ enum pwrseq_cmd_delat_unit {
 
 struct wl_pwr_cfg {
 	u16 offset;
-	u8 interface_msk:4;
 	u8 base:4;
 	u8 cmd:4;
 	u8 msk;
@@ -73,13 +64,12 @@ struct wl_pwr_cfg {
 };
 
 #define GET_PWR_CFG_OFFSET(__PWR_CMD)		__PWR_CMD.offset
-#define GET_PWR_CFG_INTF_MASK(__PWR_CMD)	__PWR_CMD.interface_msk
 #define GET_PWR_CFG_BASE(__PWR_CMD)		__PWR_CMD.base
 #define GET_PWR_CFG_CMD(__PWR_CMD)		__PWR_CMD.cmd
 #define GET_PWR_CFG_MASK(__PWR_CMD)		__PWR_CMD.msk
 #define GET_PWR_CFG_VALUE(__PWR_CMD)		__PWR_CMD.value
 
 /*	Prototype of protected function. */
-u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 InterfaceType, struct wl_pwr_cfg PwrCfgCmd[]);
+u8 HalPwrSeqCmdParsing(struct adapter *padapter, struct wl_pwr_cfg PwrCfgCmd[]);
 
 #endif
-- 
2.20.1

