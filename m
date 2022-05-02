Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2144516DDE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384379AbiEBKGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384355AbiEBKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:06:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D526B11A2E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:02:47 -0700 (PDT)
From:   Viraj Shah <viraj.shah@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651485766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BM11kXezS6ePXkdGQMiBvU9nitTToxjKm460+MZkks=;
        b=tC776zfxQWi3+yMroh1gn1FCwRpnVfuSgn8zfXKsaSXp4RveNqS2jbp5XbUyHu0xhIkBui
        eZQ5641WNbRApVzwNmwIIw8obxFYSfsdxP7qptpODaGX5Vbp16sCMGfMNMRFlzeTHXvNE7
        8UmiH8rs49DCjd1qRItUPzZApSTwKcoAnPqs95jKjyxNwFY9Blf3cI+nCmp+Oeq0YRZ9wq
        lHz7moeLg+Z26MsSmDbPiWV7roQ9DEGeqN34UHdbqyciFcjdTwrh9AdOJ4HxBNaV6Pf38+
        O/8ni4tA5WB2jr/zdN6P+IWEIhUJm9Urkdiqzn+GiVTk+p8KcMlb1b7wxXoriA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651485766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BM11kXezS6ePXkdGQMiBvU9nitTToxjKm460+MZkks=;
        b=24ayr0y6XLsSQr7YZZ655LtPamGU1XCASCo8dxtOywOIe2DvQlzEdxZmbDv4BiyiA0+ZNg
        k6FNp8P46Ti4siBQ==
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] soc: imx: imx8m-blk-ctrl: Display Power ON sequence
Date:   Mon,  2 May 2022 12:02:31 +0200
Message-Id: <20220502100233.6023-3-viraj.shah@linutronix.de>
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

Enable the dispmix software clock and release the resets
as shown in the 5.2.9.5 section of reference manual.

Signed-off-by: Viraj Shah <viraj.shah@linutronix.de>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 122f9c884b38..ca63fd30e70a 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -99,7 +99,10 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		dev_err(bc->dev, "failed to enable clocks\n");
 		goto bus_put;
 	}
-	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+	/* As per section 5.2.9.5 of reference manual imx-8MMini-yhsc.pdf,
+	 * enable dispmix sft clock to power on the display
+	 */
+	regmap_write(bc->regmap, BLK_CLK_EN, 0x1FFF);
 
 	/* power up upstream GPC domain */
 	ret = pm_runtime_get_sync(domain->power_dev);
@@ -112,7 +115,7 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	udelay(5);
 
 	/* release reset */
-	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
+	regmap_write(bc->regmap, BLK_SFT_RSTN, 0x7F);
 	if (data->mipi_phy_rst_mask)
 		regmap_set_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
 
-- 
2.20.1

