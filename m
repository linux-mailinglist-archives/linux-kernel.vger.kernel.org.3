Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153CE5658F3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiGDOwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiGDOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:52:43 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70BAB4A4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:52:41 -0700 (PDT)
Received: from dslb-178-004-207-027.178.004.pools.vodafone-ip.de ([178.4.207.27] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1o8NRE-0004hD-Do; Mon, 04 Jul 2022 16:52:36 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/5] staging: r8188eu: move pwr seq defines to HalPwrSeqCmd.c
Date:   Mon,  4 Jul 2022 16:52:17 +0200
Message-Id: <20220704145221.159949-2-martin@kaiser.cx>
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

The power sequences are now defined and processed in the same file. We
can move the defines for power sequences and the related struct and
enum from HalPwrSeqCmd.h to HalPwrSeqCmd.c. They don't have to be visible
in other files any more.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    | 43 +++++++++++++++++
 .../staging/r8188eu/include/HalPwrSeqCmd.h    | 47 -------------------
 2 files changed, 43 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 5b0f66573d94..fb8eeaf51afa 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -3,6 +3,49 @@
 
 #include "../include/HalPwrSeqCmd.h"
 
+#define PWR_CMD_WRITE			0x01
+     /*  offset: the read register offset */
+     /*  msk: the mask of the write bits */
+     /*  value: write value */
+     /*  note: driver shall implement this cmd by read & msk after write */
+
+#define PWR_CMD_POLLING			0x02
+     /*  offset: the read register offset */
+     /*  msk: the mask of the polled value */
+     /*  value: the value to be polled, masked by the msd field. */
+     /*  note: driver shall implement this cmd by */
+     /*  do{ */
+     /*  if ( (Read(offset) & msk) == (value & msk) ) */
+     /*  break; */
+     /*  } while (not timeout); */
+
+#define PWR_CMD_DELAY			0x03
+     /*  offset: the value to delay */
+     /*  msk: N/A */
+     /*  value: the unit of delay, 0: us, 1: ms */
+
+#define PWR_CMD_END			0x04
+     /*  offset: N/A */
+     /*  msk: N/A */
+     /*  value: N/A */
+
+enum pwrseq_cmd_delat_unit {
+	PWRSEQ_DELAY_US,
+	PWRSEQ_DELAY_MS,
+};
+
+struct wl_pwr_cfg {
+	u16 offset;
+	u8 cmd:4;
+	u8 msk;
+	u8 value;
+};
+
+#define GET_PWR_CFG_OFFSET(__PWR_CMD)		__PWR_CMD.offset
+#define GET_PWR_CFG_CMD(__PWR_CMD)		__PWR_CMD.cmd
+#define GET_PWR_CFG_MASK(__PWR_CMD)		__PWR_CMD.msk
+#define GET_PWR_CFG_VALUE(__PWR_CMD)		__PWR_CMD.value
+
 static struct wl_pwr_cfg rtl8188E_power_on_flow[] = {
 	{ 0x0006, PWR_CMD_POLLING, BIT(1), BIT(1) },
 	{ 0x0002, PWR_CMD_WRITE, BIT(0) | BIT(1), 0 }, /* reset BB */
diff --git a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
index 869f54d99e57..0886300d26bf 100644
--- a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
+++ b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
@@ -6,53 +6,6 @@
 
 #include "drv_types.h"
 
-/*---------------------------------------------*/
-/* 3 The value of cmd: 4 bits */
-/*---------------------------------------------*/
-
-#define PWR_CMD_WRITE			0x01
-     /*  offset: the read register offset */
-     /*  msk: the mask of the write bits */
-     /*  value: write value */
-     /*  note: driver shall implement this cmd by read & msk after write */
-
-#define PWR_CMD_POLLING			0x02
-     /*  offset: the read register offset */
-     /*  msk: the mask of the polled value */
-     /*  value: the value to be polled, masked by the msd field. */
-     /*  note: driver shall implement this cmd by */
-     /*  do{ */
-     /*  if ( (Read(offset) & msk) == (value & msk) ) */
-     /*  break; */
-     /*  } while (not timeout); */
-
-#define PWR_CMD_DELAY			0x03
-     /*  offset: the value to delay */
-     /*  msk: N/A */
-     /*  value: the unit of delay, 0: us, 1: ms */
-
-#define PWR_CMD_END			0x04
-     /*  offset: N/A */
-     /*  msk: N/A */
-     /*  value: N/A */
-
-enum pwrseq_cmd_delat_unit {
-	PWRSEQ_DELAY_US,
-	PWRSEQ_DELAY_MS,
-};
-
-struct wl_pwr_cfg {
-	u16 offset;
-	u8 cmd:4;
-	u8 msk;
-	u8 value;
-};
-
-#define GET_PWR_CFG_OFFSET(__PWR_CMD)		__PWR_CMD.offset
-#define GET_PWR_CFG_CMD(__PWR_CMD)		__PWR_CMD.cmd
-#define GET_PWR_CFG_MASK(__PWR_CMD)		__PWR_CMD.msk
-#define GET_PWR_CFG_VALUE(__PWR_CMD)		__PWR_CMD.value
-
 enum r8188eu_pwr_seq {
 	PWR_ON_FLOW,
 	DISABLE_FLOW,
-- 
2.30.2

