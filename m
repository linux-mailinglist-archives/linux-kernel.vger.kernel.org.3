Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6315654D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiGDMSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiGDMQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:16:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C7BE0B3;
        Mon,  4 Jul 2022 05:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656937011; x=1688473011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mOqz3ip1cdUQ034f0OXKJbRL6450ByCAe2pveDLY79s=;
  b=xAI5ZZs/aZpJ5BuP7gdyyDOiIij5Y3Q5OtMNrhp8xyRcbawjnVB9zsuK
   Cz/Nm2jzATlH49Cb9w3geZDlLmkfeSchKOrxZ+yQqcTfWlZeziCxPbQkN
   MxLGaMvERbjCwlD1gciF4gC3vgGfJQtJGOwsG5HkHg2LstUVJU72WOYX0
   0JroHk0sM2boPkN3cSnqnoxsWkMdc3JG5C/7t/SroKcJk8BxPx5aWf7qZ
   sbctW+S0itqqsElJNjsFmvDPSpMofYV0RIOsB9jsM2bA4gisk+eFVt/1p
   ebW511h3Y1xdGBS7t3luCxDLv+vV2TohHA45Hgm8b4z6W6W8ryu/GoA5N
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="170953313"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 05:16:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 05:16:50 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 4 Jul 2022 05:16:48 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH v2 10/12] clk: microchip: mpfs: delete 2 line mpfs_clk_register_foo()
Date:   Mon, 4 Jul 2022 13:15:57 +0100
Message-ID: <20220704121558.2088698-11-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704121558.2088698-1-conor.dooley@microchip.com>
References: <20220704121558.2088698-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register functions are now comprised of only a single operation
each and no longer add anything to the driver. Delete them.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 33 ++++++--------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 0330c2839a24..e58d0bc4669a 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -203,14 +203,6 @@ static struct mpfs_msspll_hw_clock mpfs_msspll_clks[] = {
 		MSSPLL_FBDIV_WIDTH, 0, REG_MSSPLL_SSCG_2_CR),
 };
 
-static int mpfs_clk_register_msspll(struct device *dev, struct mpfs_msspll_hw_clock *msspll_hw,
-				    void __iomem *base)
-{
-	msspll_hw->base = base;
-
-	return devm_clk_hw_register(dev, &msspll_hw->hw);
-}
-
 static int mpfs_clk_register_mssplls(struct device *dev, struct mpfs_msspll_hw_clock *msspll_hws,
 				     unsigned int num_clks, struct mpfs_clock_data *data)
 {
@@ -220,7 +212,8 @@ static int mpfs_clk_register_mssplls(struct device *dev, struct mpfs_msspll_hw_c
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_msspll_hw_clock *msspll_hw = &msspll_hws[i];
 
-		ret = mpfs_clk_register_msspll(dev, msspll_hw, data->msspll_base);
+		msspll_hw->base = data->msspll_base;
+		ret = devm_clk_hw_register(dev, &msspll_hw->hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register msspll id: %d\n",
 					     CLK_MSSPLL);
@@ -314,14 +307,6 @@ static struct mpfs_cfg_hw_clock mpfs_cfg_clks[] = {
 	}
 };
 
-static int mpfs_clk_register_cfg(struct device *dev, struct mpfs_cfg_hw_clock *cfg_hw,
-				 void __iomem *base)
-{
-	cfg_hw->cfg.reg = base + cfg_hw->reg_offset;
-
-	return devm_clk_hw_register(dev, &cfg_hw->hw);
-}
-
 static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *cfg_hws,
 				  unsigned int num_clks, struct mpfs_clock_data *data)
 {
@@ -331,7 +316,8 @@ static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_cfg_hw_clock *cfg_hw = &cfg_hws[i];
 
-		ret = mpfs_clk_register_cfg(dev, cfg_hw, data->base);
+		cfg_hw->cfg.reg = data->base + cfg_hw->reg_offset;
+		ret = devm_clk_hw_register(dev, &cfg_hw->hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     cfg_hw->id);
@@ -453,14 +439,6 @@ static struct mpfs_periph_hw_clock mpfs_periph_clks[] = {
 	CLK_PERIPH(CLK_CFM, "clk_periph_cfm", PARENT_CLK(AHB), 29, 0),
 };
 
-static int mpfs_clk_register_periph(struct device *dev, struct mpfs_periph_hw_clock *periph_hw,
-				    void __iomem *base)
-{
-	periph_hw->periph.reg = base + REG_SUBBLK_CLOCK_CR;
-
-	return devm_clk_hw_register(dev, &periph_hw->hw);
-}
-
 static int mpfs_clk_register_periphs(struct device *dev, struct mpfs_periph_hw_clock *periph_hws,
 				     int num_clks, struct mpfs_clock_data *data)
 {
@@ -470,7 +448,8 @@ static int mpfs_clk_register_periphs(struct device *dev, struct mpfs_periph_hw_c
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_periph_hw_clock *periph_hw = &periph_hws[i];
 
-		ret = mpfs_clk_register_periph(dev, periph_hw, data->base);
+		periph_hw->periph.reg = data->base + REG_SUBBLK_CLOCK_CR;
+		ret = devm_clk_hw_register(dev, &periph_hw->hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     periph_hw->id);
-- 
2.36.1

