Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417C05A6415
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiH3Myd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiH3Mx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:53:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716CF14FC87;
        Tue, 30 Aug 2022 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661864029; x=1693400029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EbmcAymNM1YIUUjdyCZltrBq2nVqbjLmU0iw126wIYs=;
  b=eTYdz0OrZAYmuBEfJZoUfFFk84YIHLmr4iZ9OqaEyxoi/tWUxHGNy8pm
   /tst858GpJo38EZfxM2IR/mRqbCJXWJte9DxTfsQelmJmvf8fbaIM2GuH
   5+ZH+xUf0z90kktk+iWsDju8io2XHQ9qpWbUu+ETw3Bs/bafTdg4OMtPW
   79RGD0mMZj7T31Sdm13PzxFztihXk+o9I9XDs3bQSU7RofPxPFR1RE3Jh
   Mtp7f4n8FlIBu7L8rC4HhGZJqL4K9QhiQYknKOL7wU5Iv9pvZ1k47COFQ
   OvENEzYrdtnkuT/dB/l0zLNljEI0i6JzE9l4NVbacQNlI7NYGimhVkBxt
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="174802848"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 05:53:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 05:53:47 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 05:53:44 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v4 11/13] clk: microchip: mpfs: convert cfg_clk to clk_divider
Date:   Tue, 30 Aug 2022 13:52:48 +0100
Message-ID: <20220830125249.2373416-11-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220830125110.2372514-1-conor.dooley@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cfg_clk struct is now just a redefinition of the clk_divider struct
with custom implentations of the ops, that implement an extra level of
redirection. Remove the custom struct and replace it with clk_divider.

Reviewed-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 78 ++++----------------------------
 1 file changed, 9 insertions(+), 69 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 538cb589d232..88a200e88e54 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -51,24 +51,13 @@ struct mpfs_msspll_hw_clock {
 
 #define to_mpfs_msspll_clk(_hw) container_of(_hw, struct mpfs_msspll_hw_clock, hw)
 
-struct mpfs_cfg_clock {
-	void __iomem *reg;
-	const struct clk_div_table *table;
-	u8 shift;
-	u8 width;
-	u8 flags;
-};
-
 struct mpfs_cfg_hw_clock {
-	struct mpfs_cfg_clock cfg;
-	struct clk_hw hw;
+	struct clk_divider cfg;
 	struct clk_init_data init;
 	unsigned int id;
 	u32 reg_offset;
 };
 
-#define to_mpfs_cfg_clk(_hw) container_of(_hw, struct mpfs_cfg_hw_clock, hw)
-
 struct mpfs_periph_clock {
 	void __iomem *reg;
 	u8 shift;
@@ -228,56 +217,6 @@ static int mpfs_clk_register_mssplls(struct device *dev, struct mpfs_msspll_hw_c
  * "CFG" clocks
  */
 
-static unsigned long mpfs_cfg_clk_recalc_rate(struct clk_hw *hw, unsigned long prate)
-{
-	struct mpfs_cfg_hw_clock *cfg_hw = to_mpfs_cfg_clk(hw);
-	struct mpfs_cfg_clock *cfg = &cfg_hw->cfg;
-	u32 val;
-
-	val = readl_relaxed(cfg->reg) >> cfg->shift;
-	val &= clk_div_mask(cfg->width);
-
-	return divider_recalc_rate(hw, prate, val, cfg->table, cfg->flags, cfg->width);
-}
-
-static long mpfs_cfg_clk_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *prate)
-{
-	struct mpfs_cfg_hw_clock *cfg_hw = to_mpfs_cfg_clk(hw);
-	struct mpfs_cfg_clock *cfg = &cfg_hw->cfg;
-
-	return divider_round_rate(hw, rate, prate, cfg->table, cfg->width, 0);
-}
-
-static int mpfs_cfg_clk_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long prate)
-{
-	struct mpfs_cfg_hw_clock *cfg_hw = to_mpfs_cfg_clk(hw);
-	struct mpfs_cfg_clock *cfg = &cfg_hw->cfg;
-	unsigned long flags;
-	u32 val;
-	int divider_setting;
-
-	divider_setting = divider_get_val(rate, prate, cfg->table, cfg->width, 0);
-
-	if (divider_setting < 0)
-		return divider_setting;
-
-	spin_lock_irqsave(&mpfs_clk_lock, flags);
-	val = readl_relaxed(cfg->reg);
-	val &= ~(clk_div_mask(cfg->width) << cfg_hw->cfg.shift);
-	val |= divider_setting << cfg->shift;
-	writel_relaxed(val, cfg->reg);
-
-	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
-
-	return 0;
-}
-
-static const struct clk_ops mpfs_clk_cfg_ops = {
-	.recalc_rate = mpfs_cfg_clk_recalc_rate,
-	.round_rate = mpfs_cfg_clk_round_rate,
-	.set_rate = mpfs_cfg_clk_set_rate,
-};
-
 #define CLK_CFG(_id, _name, _parent, _shift, _width, _table, _flags, _offset) {		\
 	.id = _id,									\
 	.cfg.shift = _shift,								\
@@ -285,7 +224,8 @@ static const struct clk_ops mpfs_clk_cfg_ops = {
 	.cfg.table = _table,								\
 	.reg_offset = _offset,								\
 	.cfg.flags = _flags,								\
-	.hw.init = CLK_HW_INIT(_name, _parent, &mpfs_clk_cfg_ops, 0),			\
+	.cfg.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_ops, 0),		\
+	.cfg.lock = &mpfs_clk_lock,							\
 }
 
 static struct mpfs_cfg_hw_clock mpfs_cfg_clks[] = {
@@ -302,8 +242,8 @@ static struct mpfs_cfg_hw_clock mpfs_cfg_clks[] = {
 		.cfg.table = mpfs_div_rtcref_table,
 		.reg_offset = REG_RTC_CLOCK_CR,
 		.cfg.flags = CLK_DIVIDER_ONE_BASED,
-		.hw.init =
-			CLK_HW_INIT_PARENTS_DATA("clk_rtcref", mpfs_ext_ref, &mpfs_clk_cfg_ops, 0),
+		.cfg.hw.init =
+			CLK_HW_INIT_PARENTS_DATA("clk_rtcref", mpfs_ext_ref, &clk_divider_ops, 0),
 	}
 };
 
@@ -317,13 +257,13 @@ static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *
 		struct mpfs_cfg_hw_clock *cfg_hw = &cfg_hws[i];
 
 		cfg_hw->cfg.reg = data->base + cfg_hw->reg_offset;
-		ret = devm_clk_hw_register(dev, &cfg_hw->hw);
+		ret = devm_clk_hw_register(dev, &cfg_hw->cfg.hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     cfg_hw->id);
 
 		id = cfg_hw->id;
-		data->hw_data.hws[id] = &cfg_hw->hw;
+		data->hw_data.hws[id] = &cfg_hw->cfg.hw;
 	}
 
 	return 0;
@@ -393,7 +333,7 @@ static const struct clk_ops mpfs_periph_clk_ops = {
 				  _flags),					\
 }
 
-#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT].hw)
+#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT].cfg.hw)
 
 /*
  * Critical clocks:
@@ -413,7 +353,7 @@ static struct mpfs_periph_hw_clock mpfs_periph_clks[] = {
 	CLK_PERIPH(CLK_MAC1, "clk_periph_mac1", PARENT_CLK(AHB), 2, 0),
 	CLK_PERIPH(CLK_MMC, "clk_periph_mmc", PARENT_CLK(AHB), 3, 0),
 	CLK_PERIPH(CLK_TIMER, "clk_periph_timer",
-		   &mpfs_cfg_clks[CLK_RTCREF - RTCREF_OFFSET].hw, 4, 0),
+		   &mpfs_cfg_clks[CLK_RTCREF - RTCREF_OFFSET].cfg.hw, 4, 0),
 	CLK_PERIPH(CLK_MMUART0, "clk_periph_mmuart0", PARENT_CLK(AHB), 5, CLK_IS_CRITICAL),
 	CLK_PERIPH(CLK_MMUART1, "clk_periph_mmuart1", PARENT_CLK(AHB), 6, 0),
 	CLK_PERIPH(CLK_MMUART2, "clk_periph_mmuart2", PARENT_CLK(AHB), 7, 0),
-- 
2.36.1

