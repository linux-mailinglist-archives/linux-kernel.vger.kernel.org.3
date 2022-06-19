Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5670D550C30
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbiFSQuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 12:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiFSQuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 12:50:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7C363C5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:50:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g4so11647697wrh.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gopwvsW4YZ7UonEyNdDMzhV85NCQ2TW0QKUGmgQ7L+A=;
        b=PPRsmuFvXCAnoP528hN1t16BHLynhT/bO2rdEnC0Xz4knixhQo48QsK8CVqIHwVuHt
         1MQg+IXAktJOWtHvgZLi01BCJEpfF/f0hjZVEfXIAxarIhHn6jci/o5r56pFckiE8lHO
         xL59bWW7auYReXeIDVHZsU0rdTbOm3y/6AU5GDj6hfOgM3Z9IUpA6BkY0zdE1EW5fB5f
         +23QiHLcxNZUnzSIlRpsFejQ2aPd3p1xJe3rpFvVIMpk/4G461je7S5b+gh2lMtMzirn
         D31QY5/tHoJHPcYQY9eO3U/UXkD5nKSCshArD8i5ieLniTPWojHTEIPDmte7x4BtDIla
         3uhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gopwvsW4YZ7UonEyNdDMzhV85NCQ2TW0QKUGmgQ7L+A=;
        b=CUfssGYreUA1VZC006PTf0UvQmYUWIg/qaje12EmlzQPCZ4sWA8FkCuWdEm0y/gDFQ
         l1bzYiCwMeVFAAaGj+g4OoJh1rZjBjr6h9m6DOZrpNJ1k1vUkctJydyDEacS+gZ73ola
         MGfhPCgeB6HtnTS1mj/GXQ0QW1DhaHsh2n7+/76zC0TpRweA3G/cs40EHRK7vmjTkIqq
         CpPEG7YKfm2V6qUy9anQTgvS/3KrDRN3jP8xCYiZIOt0NMVzDOSCmJO1URQlAFTJfxcN
         1UkWkDVeEBdUapszkPN8mUnofoQeWubf1hJah/ggl8jHT3IKlg1gIEX/PwE1tcMxbN4b
         IthA==
X-Gm-Message-State: AJIora/9Tg/1orRP4DyakahD5Ugr/kQmvlQdB6rMfL1w7wPD5LghGUpl
        QCC5HKr/MU7TBfi6IVx9UA+HWg==
X-Google-Smtp-Source: AGRyM1u8/TXPS06SfhDWZfnvfFABhGjitdfgdEIZo8EF7U4BuS6IZE7QVX/Y0ckD0cYHUGtSh+yJwA==
X-Received: by 2002:a05:6000:2c7:b0:219:b52d:d122 with SMTP id o7-20020a05600002c700b00219b52dd122mr18399366wry.507.1655657422909;
        Sun, 19 Jun 2022 09:50:22 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id m14-20020adfdc4e000000b0021a3c960214sm9189510wrj.6.2022.06.19.09.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 09:50:22 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC 5/6] net: macb: add polarfire soc reset support
Date:   Sun, 19 Jun 2022 17:49:35 +0100
Message-Id: <20220619164935.1492823-6-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619164935.1492823-1-mail@conchuod.ie>
References: <20220619164935.1492823-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

To date, the Microchip PolarFire SoC (MPFS) has been using the
cdns,macb compatible, however the generic device does not have reset
support. Add a new compatible & .data for MPFS to hook into the reset
functionality added for zynqmp support (and make the zynqmp init
function generic in the process).

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 25 +++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d89098f4ede8..325f0463fd42 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4689,33 +4689,32 @@ static const struct macb_config np4_config = {
 	.usrio = &macb_default_usrio,
 };
 
-static int zynqmp_init(struct platform_device *pdev)
+static int init_reset_optional(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct macb *bp = netdev_priv(dev);
 	int ret;
 
 	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
-		/* Ensure PS-GTR PHY device used in SGMII mode is ready */
+		/* Ensure PHY device used in SGMII mode is ready */
 		bp->sgmii_phy = devm_phy_optional_get(&pdev->dev, NULL);
 
 		if (IS_ERR(bp->sgmii_phy)) {
 			ret = PTR_ERR(bp->sgmii_phy);
 			dev_err_probe(&pdev->dev, ret,
-				      "failed to get PS-GTR PHY\n");
+				      "failed to get SGMII PHY\n");
 			return ret;
 		}
 
 		ret = phy_init(bp->sgmii_phy);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to init PS-GTR PHY: %d\n",
+			dev_err(&pdev->dev, "failed to init SGMII PHY: %d\n",
 				ret);
 			return ret;
 		}
 	}
 
-	/* Fully reset GEM controller at hardware level using zynqmp-reset driver,
-	 * if mapped in device tree.
+	/* Fully reset controller at hardware level if mapped in device tree
 	 */
 	ret = device_reset_optional(&pdev->dev);
 	if (ret) {
@@ -4737,7 +4736,7 @@ static const struct macb_config zynqmp_config = {
 			MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
-	.init = zynqmp_init,
+	.init = init_reset_optional,
 	.jumbo_max_len = 10240,
 	.usrio = &macb_default_usrio,
 };
@@ -4751,6 +4750,17 @@ static const struct macb_config zynq_config = {
 	.usrio = &macb_default_usrio,
 };
 
+static const struct macb_config mpfs_config = {
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
+			MACB_CAPS_JUMBO |
+			MACB_CAPS_GEM_HAS_PTP,
+	.dma_burst_length = 16,
+	.clk_init = macb_clk_init,
+	.init = init_reset_optional,
+	.usrio = &macb_default_usrio,
+	.jumbo_max_len = 10240,
+};
+
 static const struct macb_config sama7g5_gem_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_MIIONRGMII,
@@ -4787,6 +4797,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,zynqmp-gem", .data = &zynqmp_config},
 	{ .compatible = "cdns,zynq-gem", .data = &zynq_config },
 	{ .compatible = "sifive,fu540-c000-gem", .data = &fu540_c000_config },
+	{ .compatible = "microchip,mpfs-macb", .data = &mpfs_config },
 	{ .compatible = "microchip,sama7g5-gem", .data = &sama7g5_gem_config },
 	{ .compatible = "microchip,sama7g5-emac", .data = &sama7g5_emac_config },
 	{ /* sentinel */ }
-- 
2.36.1

