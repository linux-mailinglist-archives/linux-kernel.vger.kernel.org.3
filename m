Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C8259991A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348239AbiHSJz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348125AbiHSJzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:55:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF43EEF2B;
        Fri, 19 Aug 2022 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660902895; x=1692438895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4uLFz6Q2WKjcMkrZechUyHOH9QV5mtcZ4CUpZRVa32E=;
  b=lzkR20BKe7v1W02AnwPfhXYfXsPxh7TNnwj/rblhlG8QZtG0Jlx3gTL3
   QSIqB4YxvdMs5TKlhZbYd2NAWIQoAre+9MLu+MR4OJz7xouvif5XFvw54
   esxtas36obovgxfXAhHm8B4ww+VofCIMHwXhrnuyU+b+aACthVHwWg7fg
   atoumGEFPhvW9gWh+NrWOx8pKGeiEHZVgx7uOA3sSl/QlnBJsZdF2rMuT
   wkB+P0fpEJUP1HkL+AqY5sQb+iZC6Sr1iwyE3r7IorgM7SZV1EwKjah7L
   xKEOn9v0of+gcgg5M8QOOETDNCy+gUhvkczJnlZfyB6zj5JfgMLNVA/op
   w==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="170010365"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 02:54:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 02:54:52 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 19 Aug 2022 02:54:50 -0700
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
Subject: [PATCH v3 07/13] clk: microchip: mpfs: add MSS pll's set & round rate
Date:   Fri, 19 Aug 2022 10:53:15 +0100
Message-ID: <20220819095320.40006-8-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819095320.40006-1-conor.dooley@microchip.com>
References: <20220819095320.40006-1-conor.dooley@microchip.com>
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

The MSS pll is not a fixed frequency clock, so add set() & round_rate()
support.
Control is limited to a 7 bit output divider as other devices on the
FPGA occupy the other three outputs of the PLL & prevent changing
the multiplier.

Reviewed-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 1034f7d69660..3c8cd0094143 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -131,8 +131,62 @@ static unsigned long mpfs_clk_msspll_recalc_rate(struct clk_hw *hw, unsigned lon
 	return prate * mult / (ref_div * MSSPLL_FIXED_DIV * postdiv);
 }
 
+static long mpfs_clk_msspll_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *prate)
+{
+	struct mpfs_msspll_hw_clock *msspll_hw = to_mpfs_msspll_clk(hw);
+	void __iomem *mult_addr = msspll_hw->base + msspll_hw->reg_offset;
+	void __iomem *ref_div_addr = msspll_hw->base + REG_MSSPLL_REF_CR;
+	u32 mult, ref_div;
+	unsigned long rate_before_ctrl;
+
+	mult = readl_relaxed(mult_addr) >> MSSPLL_FBDIV_SHIFT;
+	mult &= clk_div_mask(MSSPLL_FBDIV_WIDTH);
+	ref_div = readl_relaxed(ref_div_addr) >> MSSPLL_REFDIV_SHIFT;
+	ref_div &= clk_div_mask(MSSPLL_REFDIV_WIDTH);
+
+	rate_before_ctrl = rate * (ref_div * MSSPLL_FIXED_DIV) / mult;
+
+	return divider_round_rate(hw, rate_before_ctrl, prate, NULL, MSSPLL_POSTDIV_WIDTH,
+				  msspll_hw->flags);
+}
+
+static int mpfs_clk_msspll_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long prate)
+{
+	struct mpfs_msspll_hw_clock *msspll_hw = to_mpfs_msspll_clk(hw);
+	void __iomem *mult_addr = msspll_hw->base + msspll_hw->reg_offset;
+	void __iomem *ref_div_addr = msspll_hw->base + REG_MSSPLL_REF_CR;
+	void __iomem *postdiv_addr = msspll_hw->base + REG_MSSPLL_POSTDIV_CR;
+	u32 mult, ref_div, postdiv;
+	int divider_setting;
+	unsigned long rate_before_ctrl, flags;
+
+	mult = readl_relaxed(mult_addr) >> MSSPLL_FBDIV_SHIFT;
+	mult &= clk_div_mask(MSSPLL_FBDIV_WIDTH);
+	ref_div = readl_relaxed(ref_div_addr) >> MSSPLL_REFDIV_SHIFT;
+	ref_div &= clk_div_mask(MSSPLL_REFDIV_WIDTH);
+
+	rate_before_ctrl = rate * (ref_div * MSSPLL_FIXED_DIV) / mult;
+	divider_setting = divider_get_val(rate_before_ctrl, prate, NULL, MSSPLL_POSTDIV_WIDTH,
+					  msspll_hw->flags);
+
+	if (divider_setting < 0)
+		return divider_setting;
+
+	spin_lock_irqsave(&mpfs_clk_lock, flags);
+
+	postdiv = readl_relaxed(postdiv_addr);
+	postdiv &= ~(clk_div_mask(MSSPLL_POSTDIV_WIDTH) << MSSPLL_POSTDIV_SHIFT);
+	writel_relaxed(postdiv, postdiv_addr);
+
+	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
+
+	return 0;
+}
+
 static const struct clk_ops mpfs_clk_msspll_ops = {
 	.recalc_rate = mpfs_clk_msspll_recalc_rate,
+	.round_rate = mpfs_clk_msspll_round_rate,
+	.set_rate = mpfs_clk_msspll_set_rate,
 };
 
 #define CLK_PLL(_id, _name, _parent, _shift, _width, _flags, _offset) {			\
-- 
2.36.1

