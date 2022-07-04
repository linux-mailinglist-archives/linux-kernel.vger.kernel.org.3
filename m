Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10425658F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiGDOwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbiGDOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:52:43 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35C7B7C6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:52:41 -0700 (PDT)
Received: from dslb-178-004-207-027.178.004.pools.vodafone-ip.de ([178.4.207.27] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1o8NRF-0004hD-BB; Mon, 04 Jul 2022 16:52:37 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/5] staging: r8188eu: support only us in PWR_CMD_DELAY
Date:   Mon,  4 Jul 2022 16:52:18 +0200
Message-Id: <20220704145221.159949-3-martin@kaiser.cx>
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

PWR_CMD_DELAY has only a single remaining user, who needs a delay in us.
Remove the code and defines for delays in ms.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index fb8eeaf51afa..273f134d0a40 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -20,20 +20,15 @@
      /*  } while (not timeout); */
 
 #define PWR_CMD_DELAY			0x03
-     /*  offset: the value to delay */
+     /*  offset: the value to delay (in us) */
      /*  msk: N/A */
-     /*  value: the unit of delay, 0: us, 1: ms */
+     /*  value: N/A */
 
 #define PWR_CMD_END			0x04
      /*  offset: N/A */
      /*  msk: N/A */
      /*  value: N/A */
 
-enum pwrseq_cmd_delat_unit {
-	PWRSEQ_DELAY_US,
-	PWRSEQ_DELAY_MS,
-};
-
 struct wl_pwr_cfg {
 	u16 offset;
 	u8 cmd:4;
@@ -79,7 +74,7 @@ static struct wl_pwr_cfg rtl8188E_enter_lps_flow[] = {
 	{ 0x05FA, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */
 	{ 0x05FB, PWR_CMD_POLLING, 0xFF, 0 }, /* Should be zero if no packet is transmitted */
 	{ 0x0002, PWR_CMD_WRITE, BIT(0), 0 }, /* CCK and OFDM are disabled, clocks are gated */
-	{ 0x0002, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_US },
+	{ 0x0002, PWR_CMD_DELAY, 0, 0 },
 	{ 0x0100, PWR_CMD_WRITE, 0xFF, 0x3F }, /* Reset MAC TRX */
 	{ 0x0101, PWR_CMD_WRITE, BIT(1), 0 }, /* check if removed later */
 	{ 0x0553, PWR_CMD_WRITE, BIT(5), BIT(5) }, /* Respond TxOK to scheduler */
@@ -149,10 +144,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, enum r8188eu_pwr_seq seq)
 			} while (!poll_bit);
 			break;
 		case PWR_CMD_DELAY:
-			if (GET_PWR_CFG_VALUE(pwrcfgcmd) == PWRSEQ_DELAY_US)
-				udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd));
-			else
-				udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd) * 1000);
+			udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd));
 			break;
 		case PWR_CMD_END:
 			/*  When this command is parsed, end the process */
-- 
2.30.2

