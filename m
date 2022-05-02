Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E543F516DDC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384373AbiEBKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384367AbiEBKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:06:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5980915706
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:02:48 -0700 (PDT)
From:   Viraj Shah <viraj.shah@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651485767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ormDq4ljLmV7zbEs3SyAq5bqxaVfYVolO3A1FU9LqqI=;
        b=KF5bUiPd1xvJEUNzH5Jfg7VHq/nTm6YNcaDdot5rXaEB4ZgyRp0+omT92v9ALMhF3QcoZA
        uyjg3zndeQ8OZsQuFkumhd273LRB8hEpmFTxA9rNYFR4F8PUzaj9WzETR+RH3Vo2b/rjYv
        8R6yIhDM9Qr7njvpgQJ4Mus0L3Ie3I2TqILmt4vauT0rYM4omVbs9zsQ3Mio2elQxUTeep
        uJT2UBdoC5Ms+5rvnyfyGWwTAqEpI9jHTVPrSwfeOr553tBWxFIGSrAnzbF8IRD1MFVm1k
        NWJA2XG2FCaOLx5YEZTNuiW/d0IvtuLyUyJ8JHeTeZZrdyKmoooJA1Zm/2vVDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651485767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ormDq4ljLmV7zbEs3SyAq5bqxaVfYVolO3A1FU9LqqI=;
        b=cbJbWE/OMsurhcX8/ELZJl231iZlSWzd9AvKg4lKJW5j9r7SIitra956FwmdfHlFj+RCHH
        JU3UZVennnjJRvAA==
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] soc: imx: imx8m-blk-ctrl: Add reset bits for mipi dsi phy
Date:   Mon,  2 May 2022 12:02:32 +0200
Message-Id: <20220502100233.6023-4-viraj.shah@linutronix.de>
In-Reply-To: <20220502100233.6023-1-viraj.shah@linutronix.de>
References: <20220502100233.6023-1-viraj.shah@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per reference manual page 3903, bit 16 (GPR_MIPI_S_RESETN)
as well as 17 (GPR_MIPI_M_RESETN) are the reset masks for mipi phy reset
mask.

Signed-off-by: Viraj Shah <viraj.shah@linutronix.de>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index ca63fd30e70a..d7638b7fa99d 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -502,7 +502,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[]
 		.gpc_name = "mipi-dsi",
 		.rst_mask = BIT(5),
 		.clk_mask = BIT(8) | BIT(9),
-		.mipi_phy_rst_mask = BIT(17),
+		.mipi_phy_rst_mask = BIT(17) | BIT(16),
 	},
 	[IMX8MM_DISPBLK_PD_MIPI_CSI] = {
 		.name = "dispblk-mipi-csi",
-- 
2.20.1

