Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B042651B0F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378854AbiEDVhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378637AbiEDVgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:36:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331A55131A;
        Wed,  4 May 2022 14:33:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 53E791F44C5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651699978;
        bh=v76ogTPFgqbDaBdIgSTLg+Adv6TbMAFhEwKaG1q535Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ngK8Vg+sg6jW36cXZK0SGFR6DVSJIE3r6KkVaMx8W7MGyHq8sokZvtgDGw/zJl4/9
         vg/zUad29t+xBvvTfm1lcP6KLRhT0COIZOIco64i9IsyZfsbMTLOg/G4xJGuit4Ugk
         VAKsrCYodMOofPaSvOIzsdtwWMxPqqeORsexdzqHfZvcuylZvRauK5uZh/2UBDYf2h
         2xBdcwZ6VgF8lFQ7Jq9sTGBWHfJ0uxf8SXCIr+Q9Czec8s3wM+kUwGS779bBeLg8sq
         UK92hpC3apU5qMowxCV2BBoh1BkuTvPj2Q+ngcVVQtEac3cpLwilOuI/k8hxsV/kH4
         IHJygPNMltL9Q==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 3875A4819CA; Wed,  4 May 2022 23:32:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Elaine Zhang <zhangqing@rock-chips.com>, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 05/21] clk: rockchip: add pll type for RK3588
Date:   Wed,  4 May 2022 23:32:35 +0200
Message-Id: <20220504213251.264819-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504213251.264819-1-sebastian.reichel@collabora.com>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Add RK3588 PLL support fully relying on lookup tables like
the other upstream supported rockchip platforms.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
[rebase and modify code to avoid PLL parameter calculation]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

fix 'clk: rockchip: add pll type for RK3588'

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/clk/rockchip/clk-pll.c | 218 ++++++++++++++++++++++++++++++++-
 drivers/clk/rockchip/clk.h     |  18 +++
 2 files changed, 235 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index f7827b3b7fc1..4b9840994295 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -842,6 +842,213 @@ static const struct clk_ops rockchip_rk3399_pll_clk_ops = {
 	.init = rockchip_rk3399_pll_init,
 };
 
+/*
+ * PLL used in RK3588
+ */
+
+#define RK3588_PLLCON(i)               (i * 0x4)
+#define RK3588_PLLCON0_M_MASK          0x3ff
+#define RK3588_PLLCON0_M_SHIFT         0
+#define RK3588_PLLCON1_P_MASK          0x3f
+#define RK3588_PLLCON1_P_SHIFT         0
+#define RK3588_PLLCON1_S_MASK          0x7
+#define RK3588_PLLCON1_S_SHIFT         6
+#define RK3588_PLLCON2_K_MASK          0xffff
+#define RK3588_PLLCON2_K_SHIFT         0
+#define RK3588_PLLCON1_PWRDOWN         BIT(13)
+#define RK3588_PLLCON6_LOCK_STATUS     BIT(15)
+
+static int rockchip_rk3588_pll_wait_lock(struct rockchip_clk_pll *pll)
+{
+	u32 pllcon;
+	int ret;
+
+	/*
+	 * Lock time typical 250, max 500 input clock cycles @24MHz
+	 * So define a very safe maximum of 1000us, meaning 24000 cycles.
+	 */
+	ret = readl_relaxed_poll_timeout(pll->reg_base + RK3588_PLLCON(6),
+					 pllcon,
+					 pllcon & RK3588_PLLCON6_LOCK_STATUS,
+					 0, 1000);
+	if (ret)
+		pr_err("%s: timeout waiting for pll to lock\n", __func__);
+
+	return ret;
+}
+
+static void rockchip_rk3588_pll_get_params(struct rockchip_clk_pll *pll,
+					   struct rockchip_pll_rate_table *rate)
+{
+	u32 pllcon;
+
+	pllcon = readl_relaxed(pll->reg_base + RK3588_PLLCON(0));
+	rate->m = ((pllcon >> RK3588_PLLCON0_M_SHIFT) & RK3588_PLLCON0_M_MASK);
+
+	pllcon = readl_relaxed(pll->reg_base + RK3588_PLLCON(1));
+	rate->p = ((pllcon >> RK3588_PLLCON1_P_SHIFT) & RK3588_PLLCON1_P_MASK);
+	rate->s = ((pllcon >> RK3588_PLLCON1_S_SHIFT) & RK3588_PLLCON1_S_MASK);
+
+	pllcon = readl_relaxed(pll->reg_base + RK3588_PLLCON(2));
+	rate->k = ((pllcon >> RK3588_PLLCON2_K_SHIFT) & RK3588_PLLCON2_K_MASK);
+}
+
+static unsigned long rockchip_rk3588_pll_recalc_rate(struct clk_hw *hw, unsigned long prate)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	struct rockchip_pll_rate_table cur;
+	u64 rate64 = prate, postdiv;
+
+	rockchip_rk3588_pll_get_params(pll, &cur);
+
+	rate64 *= cur.m;
+	do_div(rate64, cur.p);
+
+	if (cur.k) {
+		/* fractional mode */
+		u64 frac_rate64 = prate * cur.k;
+
+		postdiv = cur.p * 65535;
+		do_div(frac_rate64, postdiv);
+		rate64 += frac_rate64;
+	}
+	rate64 = rate64 >> cur.s;
+
+	return (unsigned long)rate64;
+}
+
+static int rockchip_rk3588_pll_set_params(struct rockchip_clk_pll *pll,
+					  const struct rockchip_pll_rate_table *rate)
+{
+	const struct clk_ops *pll_mux_ops = pll->pll_mux_ops;
+	struct clk_mux *pll_mux = &pll->pll_mux;
+	struct rockchip_pll_rate_table cur;
+	int rate_change_remuxed = 0;
+	int cur_parent;
+	int ret;
+
+	pr_debug("%s: rate settings for %lu p: %d, m: %d, s: %d, k: %d\n",
+		 __func__, rate->rate, rate->p, rate->m, rate->s, rate->k);
+
+	rockchip_rk3588_pll_get_params(pll, &cur);
+	cur.rate = 0;
+
+	if (pll->type == pll_rk3588) {
+		cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
+		if (cur_parent == PLL_MODE_NORM) {
+			pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
+			rate_change_remuxed = 1;
+		}
+	}
+
+	/* set pll power down */
+	writel(HIWORD_UPDATE(RK3588_PLLCON1_PWRDOWN,
+			     RK3588_PLLCON1_PWRDOWN, 0),
+	       pll->reg_base + RK3399_PLLCON(1));
+
+	/* update pll values */
+	writel_relaxed(HIWORD_UPDATE(rate->m, RK3588_PLLCON0_M_MASK, RK3588_PLLCON0_M_SHIFT),
+		       pll->reg_base + RK3399_PLLCON(0));
+
+	writel_relaxed(HIWORD_UPDATE(rate->p, RK3588_PLLCON1_P_MASK, RK3588_PLLCON1_P_SHIFT) |
+		       HIWORD_UPDATE(rate->s, RK3588_PLLCON1_S_MASK, RK3588_PLLCON1_S_SHIFT),
+		       pll->reg_base + RK3399_PLLCON(1));
+
+	writel_relaxed(HIWORD_UPDATE(rate->k, RK3588_PLLCON2_K_MASK, RK3588_PLLCON2_K_SHIFT),
+		       pll->reg_base + RK3399_PLLCON(2));
+
+	/* set pll power up */
+	writel(HIWORD_UPDATE(0, RK3588_PLLCON1_PWRDOWN, 0),
+	       pll->reg_base + RK3588_PLLCON(1));
+
+	/* wait for the pll to lock */
+	ret = rockchip_rk3588_pll_wait_lock(pll);
+	if (ret) {
+		pr_warn("%s: pll update unsuccessful, trying to restore old params\n",
+			__func__);
+		rockchip_rk3588_pll_set_params(pll, &cur);
+	}
+
+	if ((pll->type == pll_rk3588) && rate_change_remuxed)
+		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_NORM);
+
+	return ret;
+}
+
+static int rockchip_rk3588_pll_set_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long prate)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	const struct rockchip_pll_rate_table *rate;
+
+	pr_debug("%s: changing %s to %lu with a parent rate of %lu\n",
+		 __func__, __clk_get_name(hw->clk), drate, prate);
+
+	/* Get required rate settings from table */
+	rate = rockchip_get_pll_settings(pll, drate);
+	if (!rate) {
+		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
+			drate, __clk_get_name(hw->clk));
+		return -EINVAL;
+	}
+
+	return rockchip_rk3588_pll_set_params(pll, rate);
+}
+
+static int rockchip_rk3588_pll_enable(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+
+	writel(HIWORD_UPDATE(0, RK3588_PLLCON1_PWRDOWN, 0),
+	       pll->reg_base + RK3588_PLLCON(1));
+	rockchip_rk3588_pll_wait_lock(pll);
+
+	return 0;
+}
+
+static void rockchip_rk3588_pll_disable(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+
+	writel(HIWORD_UPDATE(RK3588_PLLCON1_PWRDOWN, RK3588_PLLCON1_PWRDOWN, 0),
+	       pll->reg_base + RK3588_PLLCON(1));
+}
+
+static int rockchip_rk3588_pll_is_enabled(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	u32 pllcon = readl(pll->reg_base + RK3588_PLLCON(1));
+
+	return !(pllcon & RK3588_PLLCON1_PWRDOWN);
+}
+
+static int rockchip_rk3588_pll_init(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+
+	if (!(pll->flags & ROCKCHIP_PLL_SYNC_RATE))
+		return 0;
+
+	return 0;
+}
+
+static const struct clk_ops rockchip_rk3588_pll_clk_norate_ops = {
+	.recalc_rate = rockchip_rk3588_pll_recalc_rate,
+	.enable = rockchip_rk3588_pll_enable,
+	.disable = rockchip_rk3588_pll_disable,
+	.is_enabled = rockchip_rk3588_pll_is_enabled,
+};
+
+static const struct clk_ops rockchip_rk3588_pll_clk_ops = {
+	.recalc_rate = rockchip_rk3588_pll_recalc_rate,
+	.round_rate = rockchip_pll_round_rate,
+	.set_rate = rockchip_rk3588_pll_set_rate,
+	.enable = rockchip_rk3588_pll_enable,
+	.disable = rockchip_rk3588_pll_disable,
+	.is_enabled = rockchip_rk3588_pll_is_enabled,
+	.init = rockchip_rk3588_pll_init,
+};
+
 /*
  * Common registering of pll clocks
  */
@@ -890,7 +1097,8 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 	if (pll_type == pll_rk3036 ||
 	    pll_type == pll_rk3066 ||
 	    pll_type == pll_rk3328 ||
-	    pll_type == pll_rk3399)
+	    pll_type == pll_rk3399 ||
+	    pll_type == pll_rk3588)
 		pll_mux->flags |= CLK_MUX_HIWORD_MASK;
 
 	/* the actual muxing is xin24m, pll-output, xin32k */
@@ -957,6 +1165,14 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 		else
 			init.ops = &rockchip_rk3399_pll_clk_ops;
 		break;
+	case pll_rk3588:
+	case pll_rk3588_core:
+		if (!pll->rate_table)
+			init.ops = &rockchip_rk3588_pll_clk_norate_ops;
+		else
+			init.ops = &rockchip_rk3588_pll_clk_ops;
+		init.flags = flags;
+		break;
 	default:
 		pr_warn("%s: Unknown pll type for pll clk %s\n",
 			__func__, name);
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 6aece7f07a7d..bf7c8d082fde 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -221,6 +221,8 @@ enum rockchip_pll_type {
 	pll_rk3066,
 	pll_rk3328,
 	pll_rk3399,
+	pll_rk3588,
+	pll_rk3588_core,
 };
 
 #define RK3036_PLL_RATE(_rate, _refdiv, _fbdiv, _postdiv1,	\
@@ -253,6 +255,15 @@ enum rockchip_pll_type {
 	.nb = _nb,						\
 }
 
+#define RK3588_PLL_RATE(_rate, _p, _m, _s, _k)			\
+{								\
+	.rate   = _rate##U,					\
+	.p = _p,						\
+	.m = _m,						\
+	.s = _s,						\
+	.k = _k,						\
+}
+
 /**
  * struct rockchip_clk_provider - information about clock provider
  * @reg_base: virtual address for the register base.
@@ -288,6 +299,13 @@ struct rockchip_pll_rate_table {
 			unsigned int dsmpd;
 			unsigned int frac;
 		};
+		struct {
+			/* for RK3588 */
+			unsigned int m;
+			unsigned int p;
+			unsigned int s;
+			unsigned int k;
+		};
 	};
 };
 
-- 
2.35.1

