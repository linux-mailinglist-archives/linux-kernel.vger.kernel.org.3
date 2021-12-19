Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631A947A1CC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 19:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhLSSj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 13:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbhLSSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 13:39:54 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FAFC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 10:39:53 -0800 (PST)
Received: from dslb-188-097-041-189.188.097.pools.vodafone-ip.de ([188.97.41.189] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mz164-0000Iw-GC; Sun, 19 Dec 2021 19:39:48 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/9] staging: r8188: remove base address from power transitions
Date:   Sun, 19 Dec 2021 19:39:23 +0100
Message-Id: <20211219183926.4746-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211219183926.4746-1-martin@kaiser.cx>
References: <20211219183926.4746-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the base entry from the power transition steps. This field
is not used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/include/Hal8188EPwrSeq.h  | 66 +++++++++----------
 .../staging/r8188eu/include/HalPwrSeqCmd.h    | 11 ----
 2 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
index 44016b798f89..dc5cfc701aad 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
@@ -8,52 +8,52 @@
 
 #define RTL8188E_TRANS_CARDEMU_TO_ACT														\
 	/* format */																\
-	/* { offset, base|cmd, msk, value }, comments here*/								\
-	{0x0006, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(1), BIT(1)},/* wait till 0x04[17] = 1    power ready*/	\
-	{0x0002, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0)|BIT(1), 0}, /* 0x02[1:0] = 0	reset BB*/			\
-	{0x0026, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
-	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), 0}, /* 0x04[15] = 0 disable HWPDN (control by DRV)*/\
-	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4)|BIT(3), 0}, /*0x04[12:11] = 2b'00 disable WL suspend*/	\
-	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), BIT(0)}, /*0x04[8] = 1 polling until return 0*/	\
-	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(0), 0}, /*wait till 0x04[8] = 0*/	\
-	{0x0023, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*LDO normal mode*/	\
+	/* { offset, cmd, msk, value }, comments here*/								\
+	{0x0006, PWR_CMD_POLLING, BIT(1), BIT(1)},/* wait till 0x04[17] = 1    power ready*/	\
+	{0x0002, PWR_CMD_WRITE, BIT(0)|BIT(1), 0}, /* 0x02[1:0] = 0	reset BB*/			\
+	{0x0026, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
+	{0x0005, PWR_CMD_WRITE, BIT(7), 0}, /* 0x04[15] = 0 disable HWPDN (control by DRV)*/\
+	{0x0005, PWR_CMD_WRITE, BIT(4)|BIT(3), 0}, /*0x04[12:11] = 2b'00 disable WL suspend*/	\
+	{0x0005, PWR_CMD_WRITE, BIT(0), BIT(0)}, /*0x04[8] = 1 polling until return 0*/	\
+	{0x0005, PWR_CMD_POLLING, BIT(0), 0}, /*wait till 0x04[8] = 0*/	\
+	{0x0023, PWR_CMD_WRITE, BIT(4), 0}, /*LDO normal mode*/	\
 
 #define RTL8188E_TRANS_ACT_TO_CARDEMU													\
 	/* format */																\
-	/* { offset, base|cmd, msk, value }, comments here*/								\
-	{0x001F, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0},/*0x1F[7:0] = 0 turn off RF*/	\
-	{0x0023, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*LDO Sleep mode*/	\
-	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), BIT(1)}, /*0x04[9] = 1 turn off MAC by HW state machine*/	\
-	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(1), 0}, /*wait till 0x04[9] = 0 polling until return 0 to disable*/	\
+	/* { offset, cmd, msk, value }, comments here*/								\
+	{0x001F, PWR_CMD_WRITE, 0xFF, 0},/*0x1F[7:0] = 0 turn off RF*/	\
+	{0x0023, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*LDO Sleep mode*/	\
+	{0x0005, PWR_CMD_WRITE, BIT(1), BIT(1)}, /*0x04[9] = 1 turn off MAC by HW state machine*/	\
+	{0x0005, PWR_CMD_POLLING, BIT(1), 0}, /*wait till 0x04[9] = 0 polling until return 0 to disable*/	\
 
 #define RTL8188E_TRANS_CARDEMU_TO_CARDDIS													\
 	/* format */																\
-	/* { offset, base|cmd, msk, value },  comments here*/							\
-	{0x0026, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
-	{0x0005, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(3)|BIT(4), BIT(3)}, /*0x04[12:11] = 2b'01 enable WL suspend*/	\
-	{0x0007, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0}, /*  0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */	\
-	{0x0041, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*Clear SIC_EN register 0x40[12] = 1'b0 */	\
-	{0xfe10, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*Set USB suspend enable local register  0xfe10[4]=1 */	\
+	/* { offset, cmd, msk, value },  comments here*/							\
+	{0x0026, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
+	{0x0005, PWR_CMD_WRITE, BIT(3)|BIT(4), BIT(3)}, /*0x04[12:11] = 2b'01 enable WL suspend*/	\
+	{0x0007, PWR_CMD_WRITE, 0xFF, 0}, /*  0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */	\
+	{0x0041, PWR_CMD_WRITE, BIT(4), 0}, /*Clear SIC_EN register 0x40[12] = 1'b0 */	\
+	{0xfe10, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*Set USB suspend enable local register  0xfe10[4]=1 */	\
 
 /* This is used by driver for LPSRadioOff Procedure, not for FW LPS Step */
 #define RTL8188E_TRANS_ACT_TO_LPS														\
 	/* format */																\
-	/* { offset, base|cmd, msk, value }, comments here				*/   \
-	{0x0522, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x7F},/*Tx Pause*/	\
-	{0x05F8, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x05F9, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x05FA, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x05FB, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x0002, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), 0},/*CCK and OFDM are disabled,and clock are gated*/	\
-	{0x0002, PWR_BASEADDR_MAC, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_US},/*Delay 1us*/	\
-	{0x0100, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x3F},/*Reset MAC TRX*/	\
-	{0x0101, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), 0},/*check if removed later*/	\
-	{0x0553, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(5), BIT(5)},/*Respond TxOK to scheduler*/	\
+	/* { offset, cmd, msk, value }, comments here				*/   \
+	{0x0522, PWR_CMD_WRITE, 0xFF, 0x7F},/*Tx Pause*/	\
+	{0x05F8, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x05F9, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x05FA, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x05FB, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x0002, PWR_CMD_WRITE, BIT(0), 0},/*CCK and OFDM are disabled,and clock are gated*/	\
+	{0x0002, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_US},/*Delay 1us*/	\
+	{0x0100, PWR_CMD_WRITE, 0xFF, 0x3F},/*Reset MAC TRX*/	\
+	{0x0101, PWR_CMD_WRITE, BIT(1), 0},/*check if removed later*/	\
+	{0x0553, PWR_CMD_WRITE, BIT(5), BIT(5)},/*Respond TxOK to scheduler*/	\
 
 #define RTL8188E_TRANS_END															\
 	/* format */																\
-	/* { offset, base|cmd, msk, value },  comments here*/					\
-	{0xFFFF, 0, PWR_CMD_END, 0, 0}, /*  */
+	/* { offset, cmd, msk, value },  comments here*/					\
+	{0xFFFF, PWR_CMD_END, 0, 0}, /*  */
 
 extern struct wl_pwr_cfg rtl8188E_power_on_flow[];
 extern struct wl_pwr_cfg rtl8188E_card_disable_flow[];
diff --git a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
index e1826fc9c001..1667a22f0ac4 100644
--- a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
+++ b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
@@ -41,15 +41,6 @@
      /*  msk: N/A */
      /*  value: N/A */
 
-/*---------------------------------------------*/
-/* 3 The value of base: 4 bits */
-/*---------------------------------------------*/
-   /*  define the base address of each block */
-#define PWR_BASEADDR_MAC		0x00
-#define PWR_BASEADDR_USB		0x01
-#define PWR_BASEADDR_PCIE		0x02
-#define PWR_BASEADDR_SDIO		0x03
-
 enum pwrseq_cmd_delat_unit {
 	PWRSEQ_DELAY_US,
 	PWRSEQ_DELAY_MS,
@@ -57,14 +48,12 @@ enum pwrseq_cmd_delat_unit {
 
 struct wl_pwr_cfg {
 	u16 offset;
-	u8 base:4;
 	u8 cmd:4;
 	u8 msk;
 	u8 value;
 };
 
 #define GET_PWR_CFG_OFFSET(__PWR_CMD)		__PWR_CMD.offset
-#define GET_PWR_CFG_BASE(__PWR_CMD)		__PWR_CMD.base
 #define GET_PWR_CFG_CMD(__PWR_CMD)		__PWR_CMD.cmd
 #define GET_PWR_CFG_MASK(__PWR_CMD)		__PWR_CMD.msk
 #define GET_PWR_CFG_VALUE(__PWR_CMD)		__PWR_CMD.value
-- 
2.20.1

