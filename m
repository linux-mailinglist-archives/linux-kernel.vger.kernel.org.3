Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B365654DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiGDMSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiGDMRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:17:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD621261A;
        Mon,  4 Jul 2022 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656937018; x=1688473018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jypCj0+NdAqT0FeiSwpVevo69MKmHu5r7GP6Jh6Aj/U=;
  b=c97OCO3MGte6sYMyqYOQrM6x6GXcuNDfaGJDhijbUTd51CWcb6xfdql2
   hViK6MZKtEnlAtes42+yBzlLdzIRMGUF7JadXjlI7Nd+mLh8RSPzeT+3k
   W3yVzcTnkqg/tRPG/PEE1xPlA453IDEyi0zCHm3UILKeQiiRPMGflbb1l
   zZ82OveATiLYK+6nD5M+1vmJsqDs1ABc23ng2/gjzLi9MzOZfemnVS0hy
   Eot7ljmdsDNi08mJ9Q+OTXO61TM9cOXWsgISecw7W3C2KMeRoYPhoEQA7
   0N6plkZCl/LSsBF5YVZ8tHk0ArLzSsC6mhRl9s9Clo0ujweU7PmxVeZc+
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="170686875"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 05:16:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 05:16:56 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 4 Jul 2022 05:16:54 -0700
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
Subject: [PATCH v2 12/12] clk: microchip: mpfs: convert periph_clk to clk_gate
Date:   Mon, 4 Jul 2022 13:15:59 +0100
Message-ID: <20220704121558.2088698-13-conor.dooley@microchip.com>
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

With the reset code moved to the recently added reset controller, there
is no need for custom ops any longer. Remove the custom ops and the
custom struct by converting to a clk_gate.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 74 +++-----------------------------
 1 file changed, 7 insertions(+), 67 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 1d9e8c1e56b6..2d5585c6ef21 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -58,19 +58,11 @@ struct mpfs_cfg_hw_clock {
 	u32 reg_offset;
 };
 
-struct mpfs_periph_clock {
-	void __iomem *reg;
-	u8 shift;
-};
-
 struct mpfs_periph_hw_clock {
-	struct mpfs_periph_clock periph;
-	struct clk_hw hw;
+	struct clk_gate periph;
 	unsigned int id;
 };
 
-#define to_mpfs_periph_clk(_hw) container_of(_hw, struct mpfs_periph_hw_clock, hw)
-
 /*
  * mpfs_clk_lock prevents anything else from writing to the
  * mpfs clk block while a software locked register is being written.
@@ -273,64 +265,12 @@ static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *
  * peripheral clocks - devices connected to axi or ahb buses.
  */
 
-static int mpfs_periph_clk_enable(struct clk_hw *hw)
-{
-	struct mpfs_periph_hw_clock *periph_hw = to_mpfs_periph_clk(hw);
-	struct mpfs_periph_clock *periph = &periph_hw->periph;
-	u32 reg, val;
-	unsigned long flags;
-
-	spin_lock_irqsave(&mpfs_clk_lock, flags);
-
-	reg = readl_relaxed(periph->reg);
-	val = reg | (1u << periph->shift);
-	writel_relaxed(val, periph->reg);
-
-	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
-
-	return 0;
-}
-
-static void mpfs_periph_clk_disable(struct clk_hw *hw)
-{
-	struct mpfs_periph_hw_clock *periph_hw = to_mpfs_periph_clk(hw);
-	struct mpfs_periph_clock *periph = &periph_hw->periph;
-	u32 reg, val;
-	unsigned long flags;
-
-	spin_lock_irqsave(&mpfs_clk_lock, flags);
-
-	reg = readl_relaxed(periph->reg);
-	val = reg & ~(1u << periph->shift);
-	writel_relaxed(val, periph->reg);
-
-	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
-}
-
-static int mpfs_periph_clk_is_enabled(struct clk_hw *hw)
-{
-	struct mpfs_periph_hw_clock *periph_hw = to_mpfs_periph_clk(hw);
-	struct mpfs_periph_clock *periph = &periph_hw->periph;
-	u32 reg;
-
-	reg = readl_relaxed(periph->reg);
-	if (reg & (1u << periph->shift))
-		return 1;
-
-	return 0;
-}
-
-static const struct clk_ops mpfs_periph_clk_ops = {
-	.enable = mpfs_periph_clk_enable,
-	.disable = mpfs_periph_clk_disable,
-	.is_enabled = mpfs_periph_clk_is_enabled,
-};
-
 #define CLK_PERIPH(_id, _name, _parent, _shift, _flags) {			\
-	.id = _id,							\
-	.periph.shift = _shift,							\
-	.hw.init = CLK_HW_INIT_HW(_name, _parent, &mpfs_periph_clk_ops,		\
+	.id = _id,								\
+	.periph.bit_idx = _shift,						\
+	.periph.hw.init = CLK_HW_INIT_HW(_name, _parent, &clk_gate_ops,		\
 				  _flags),					\
+	.periph.lock = &mpfs_clk_lock,						\
 }
 
 #define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT].cfg.hw)
@@ -389,13 +329,13 @@ static int mpfs_clk_register_periphs(struct device *dev, struct mpfs_periph_hw_c
 		struct mpfs_periph_hw_clock *periph_hw = &periph_hws[i];
 
 		periph_hw->periph.reg = data->base + REG_SUBBLK_CLOCK_CR;
-		ret = devm_clk_hw_register(dev, &periph_hw->hw);
+		ret = devm_clk_hw_register(dev, &periph_hw->periph.hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     periph_hw->id);
 
 		id = periph_hws[i].id;
-		data->hw_data.hws[id] = &periph_hw->hw;
+		data->hw_data.hws[id] = &periph_hw->periph.hw;
 	}
 
 	return 0;
-- 
2.36.1

