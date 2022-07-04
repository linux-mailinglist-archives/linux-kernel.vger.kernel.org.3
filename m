Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8865658F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiGDOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiGDOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:52:43 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60221BC18
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:52:42 -0700 (PDT)
Received: from dslb-178-004-207-027.178.004.pools.vodafone-ip.de ([178.4.207.27] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1o8NRG-0004hD-AR; Mon, 04 Jul 2022 16:52:38 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/5] staging: r8188eu: read pwr seq length, remove PWR_CMD_END
Date:   Mon,  4 Jul 2022 16:52:19 +0200
Message-Id: <20220704145221.159949-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704145221.159949-1-martin@kaiser.cx>
References: <20220704145221.159949-1-martin@kaiser.cx>
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

The definitions of the power sequences are in the same file as the function
which processes them. We can simply read the number of entries in a power
sequence. There's no need for a PWR_CMD_END command to indicate the end
of a sequence.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c | 25 ++++++----------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 273f134d0a40..6c0b1368383d 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -24,11 +24,6 @@
      /*  msk: N/A */
      /*  value: N/A */
 
-#define PWR_CMD_END			0x04
-     /*  offset: N/A */
-     /*  msk: N/A */
-     /*  value: N/A */
-
 struct wl_pwr_cfg {
 	u16 offset;
 	u8 cmd:4;
@@ -50,7 +45,6 @@ static struct wl_pwr_cfg rtl8188E_power_on_flow[] = {
 	{ 0x0005, PWR_CMD_WRITE, BIT(0), BIT(0) },
 	{ 0x0005, PWR_CMD_POLLING, BIT(0), 0 },
 	{ 0x0023, PWR_CMD_WRITE, BIT(4), 0 },
-	{ 0xFFFF, PWR_CMD_END, 0, 0 },
 };
 
 static struct wl_pwr_cfg rtl8188E_card_disable_flow[] = {
@@ -63,7 +57,6 @@ static struct wl_pwr_cfg rtl8188E_card_disable_flow[] = {
 	{ 0x0007, PWR_CMD_WRITE, 0xFF, 0 }, /* enable bandgap mbias in suspend */
 	{ 0x0041, PWR_CMD_WRITE, BIT(4), 0 }, /* Clear SIC_EN register */
 	{ 0xfe10, PWR_CMD_WRITE, BIT(4), BIT(4) }, /* Set USB suspend enable local register */
-	{ 0xFFFF, PWR_CMD_END, 0, 0 },
 };
 
 /* This is used by driver for LPSRadioOff Procedure, not for FW LPS Step */
@@ -78,7 +71,6 @@ static struct wl_pwr_cfg rtl8188E_enter_lps_flow[] = {
 	{ 0x0100, PWR_CMD_WRITE, 0xFF, 0x3F }, /* Reset MAC TRX */
 	{ 0x0101, PWR_CMD_WRITE, BIT(1), 0 }, /* check if removed later */
 	{ 0x0553, PWR_CMD_WRITE, BIT(5), BIT(5) }, /* Respond TxOK to scheduler */
-	{ 0xFFFF, PWR_CMD_END, 0, 0 },
 };
 
 u8 HalPwrSeqCmdParsing(struct adapter *padapter, enum r8188eu_pwr_seq seq)
@@ -86,7 +78,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, enum r8188eu_pwr_seq seq)
 	struct wl_pwr_cfg pwrcfgcmd = {0};
 	struct wl_pwr_cfg *pwrseqcmd;
 	u8 poll_bit = false;
-	u32 aryidx = 0;
+	u8 idx, num_steps;
 	u8 value = 0;
 	u32 offset = 0;
 	u32 poll_count = 0; /*  polling autoload done. */
@@ -96,19 +88,22 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, enum r8188eu_pwr_seq seq)
 	switch (seq) {
 	case PWR_ON_FLOW:
 		pwrseqcmd = rtl8188E_power_on_flow;
+		num_steps = ARRAY_SIZE(rtl8188E_power_on_flow);
 		break;
 	case DISABLE_FLOW:
 		pwrseqcmd = rtl8188E_card_disable_flow;
+		num_steps = ARRAY_SIZE(rtl8188E_card_disable_flow);
 		break;
 	case LPS_ENTER_FLOW:
 		pwrseqcmd = rtl8188E_enter_lps_flow;
+		num_steps = ARRAY_SIZE(rtl8188E_enter_lps_flow);
 		break;
 	default:
 		return false;
 	}
 
-	do {
-		pwrcfgcmd = pwrseqcmd[aryidx];
+	for (idx = 0; idx < num_steps; idx++) {
+		pwrcfgcmd = pwrseqcmd[idx];
 
 		switch (GET_PWR_CFG_CMD(pwrcfgcmd)) {
 		case PWR_CMD_WRITE:
@@ -146,15 +141,9 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, enum r8188eu_pwr_seq seq)
 		case PWR_CMD_DELAY:
 			udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd));
 			break;
-		case PWR_CMD_END:
-			/*  When this command is parsed, end the process */
-			return true;
-			break;
 		default:
 			break;
 		}
-
-		aryidx++;/* Add Array Index */
-	} while (1);
+	}
 	return true;
 }
-- 
2.30.2

