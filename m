Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C3050954C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 05:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383897AbiDUDTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 23:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbiDUDTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:19:35 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9288A12629
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:16:46 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-deb9295679so4116010fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JB0gUMTmyGNaaB0sHkZ7WLGgPRHKvvOXuIeU593CwY=;
        b=t6uXv3HdWpPzQFokq9nFqKyzjG8FMVTZXGj3xBOJq/tD78N6+spaYMgCxqM5o9UsUB
         yGF3TdM7WDSclO7v/4X59nZm15yhyybppqRr73qIBr+QdFyQS+UfpVM78ER/TMLazdND
         Zx/ioYJvXx8HYK+fRt+I2dSxnLglXJDGggYjBwDnt8ZUr+j0dezbtugfAue46BfNjfrm
         QHXu2UvboYOk5VnAPvLdKIqqJZIoUjkh3HmXXQ3H27EAN5K5g3NWXv4dSt934jWkHRMG
         cmtwklzhLNuFppsnepCWUcC1wkGVUTqcHwbBaGnpUjsrbcaG9AdMNNp9KfQq4j28gZoQ
         vILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JB0gUMTmyGNaaB0sHkZ7WLGgPRHKvvOXuIeU593CwY=;
        b=seltPFpa7alB6nnPa4FbyMReLbsAkROskQF3NhYoL6/8R1ZbyF1CPfyqrDMcSNaWGP
         v8YPrOQK1gbs71mLV/ZgOVBVPrhDdy+QopcNm+Rsd6RZ3KbgyiKGsdBEEp8Di6cQqbFa
         SikdXknoDhqXDJy/cdkI1e3jTpBCDxUkAcw0+SO+e8jc41jGyVur3sqsnIapSMv9RPMS
         bXv0EzCavdm8IzglSTLrrlgYXRrDtdvGt3ETBib+r8xZhrfQ8eaYDXNZaZf0Gwn2J0Nl
         yveYqavUWOifBQxph/pEi9N+4b6Zk2g9M8DrGv/QQhWIe6RQr4IB95qxHpfiuAs1er2H
         H1wA==
X-Gm-Message-State: AOAM531Jkf2CswIyVVX7UjC+vcfB/KLRwG5xhep48gPBk9cjM6gn+QTy
        2cWLberFTJggBGhL8kohFy3SOw==
X-Google-Smtp-Source: ABdhPJyQdEmZ1cOI+Mu68onPfacFGFzdSHci+WhfKL+DEbliYtaiQkOEIeu0U+r2ttiEQaeKCVb2IA==
X-Received: by 2002:a05:6870:8a0a:b0:e5:b7dd:9a04 with SMTP id p10-20020a0568708a0a00b000e5b7dd9a04mr2957492oaq.96.1650511005887;
        Wed, 20 Apr 2022 20:16:45 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id x20-20020a4ac594000000b00329a02f2f34sm7339509oop.16.2022.04.20.20.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 20:16:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] clk: qcom: rcg2: Cache CFG register updates for parked RCGs
Date:   Wed, 20 Apr 2022 20:18:49 -0700
Message-Id: <20220421031849.454626-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As GDSCs are turned on and off some associated clocks are momentarily
enabled for house keeping purposes. For this, and similar, purposes the
"shared RCGs" will park the RCG on a source clock which is known to be
available.
When the RCG is parked, a safe clock source will be selected and
committed, then the original source would be written back and upon enable
the change back to the unparked source would be committed.

But starting with SM8350 this fails, as the value in CFG is committed by
the GDSC handshake and without a ticking parent the GDSC enablement will
time out.

This becomes a concrete problem if the runtime supended state of a
device includes disabling such rcg's parent clock. As the device
attempts to power up the domain again the rcg will fail to enable and
hence the GDSC enablement will fail, preventing the device from
returning from the suspended state.

This can be seen in e.g. the display stack during probe on SM8350.

To avoid this problem, the software needs to ensure that the RCG is
configured to a active parent clock while it is disabled. This is done
by caching the CFG register content while the shared RCG is parked on
this safe source.

Writes to M, N and D registers are committed as they are requested. New
helpers for get_parent() and recalc_rate() are extracted from their
previous implementations and __clk_rcg2_configure() is modified to allow
it to operate on the cached value.

Fixes: 7ef6f11887bd ("clk: qcom: Configure the RCGs to a safe source as needed")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Explained the symptoms in commit message
- Reduced error in clk_rcg2_get_parent() to pr_debug()
- Reduced the size of the change in __clk_rcg2_configure()
- Polished comment in clk_rcg2_shared_set_rate()
- Use clk_hw_is_enabled() in clk_rcg2_shared_set_parent()

 drivers/clk/qcom/clk-rcg.h  |   2 +
 drivers/clk/qcom/clk-rcg2.c | 124 ++++++++++++++++++++++++++++--------
 2 files changed, 100 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 00cea508d49e..012e745794fd 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -140,6 +140,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
  * @freq_tbl: frequency table
  * @clkr: regmap clock handle
  * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
+ * @parked_cfg: cached value of the CFG register for parked RCGs
  */
 struct clk_rcg2 {
 	u32			cmd_rcgr;
@@ -150,6 +151,7 @@ struct clk_rcg2 {
 	const struct freq_tbl	*freq_tbl;
 	struct clk_regmap	clkr;
 	u8			cfg_off;
+	u32			parked_cfg;
 };
 
 #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index f675fd969c4d..9d218b04aa49 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -73,16 +73,11 @@ static int clk_rcg2_is_enabled(struct clk_hw *hw)
 	return (cmd & CMD_ROOT_OFF) == 0;
 }
 
-static u8 clk_rcg2_get_parent(struct clk_hw *hw)
+static u8 __clk_rcg2_get_parent(struct clk_hw *hw, u32 cfg)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	int num_parents = clk_hw_get_num_parents(hw);
-	u32 cfg;
-	int i, ret;
-
-	ret = regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
-	if (ret)
-		goto err;
+	int i;
 
 	cfg &= CFG_SRC_SEL_MASK;
 	cfg >>= CFG_SRC_SEL_SHIFT;
@@ -91,12 +86,27 @@ static u8 clk_rcg2_get_parent(struct clk_hw *hw)
 		if (cfg == rcg->parent_map[i].cfg)
 			return i;
 
-err:
 	pr_debug("%s: Clock %s has invalid parent, using default.\n",
 		 __func__, clk_hw_get_name(hw));
 	return 0;
 }
 
+static u8 clk_rcg2_get_parent(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	u32 cfg;
+	int ret;
+
+	ret = regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
+	if (ret) {
+		pr_debug("%s: Unable to read CFG register for %s\n",
+			 __func__, clk_hw_get_name(hw));
+		return 0;
+	}
+
+	return __clk_rcg2_get_parent(hw, cfg);
+}
+
 static int update_config(struct clk_rcg2 *rcg)
 {
 	int count, ret;
@@ -163,12 +173,10 @@ calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
 }
 
 static unsigned long
-clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+__clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate, u32 cfg)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
-	u32 cfg, hid_div, m = 0, n = 0, mode = 0, mask;
-
-	regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
+	u32 hid_div, m = 0, n = 0, mode = 0, mask;
 
 	if (rcg->mnd_width) {
 		mask = BIT(rcg->mnd_width) - 1;
@@ -189,6 +197,17 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return calc_rate(parent_rate, m, n, mode, hid_div);
 }
 
+static unsigned long
+clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	u32 cfg;
+
+	regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
+
+	return __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
+}
+
 static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 				    struct clk_rate_request *req,
 				    enum freq_policy policy)
@@ -262,7 +281,8 @@ static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,
 	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, FLOOR);
 }
 
-static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
+static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f,
+				u32 *_cfg)
 {
 	u32 cfg, mask, d_val, not2d_val, n_minus_m;
 	struct clk_hw *hw = &rcg->clkr.hw;
@@ -304,15 +324,27 @@ static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 	cfg |= rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
 	if (rcg->mnd_width && f->n && (f->m != f->n))
 		cfg |= CFG_MODE_DUAL_EDGE;
-	return regmap_update_bits(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg),
-					mask, cfg);
+
+	*_cfg &= ~mask;
+	*_cfg |= cfg;
+
+	return 0;
 }
 
 static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 {
+	u32 cfg;
 	int ret;
 
-	ret = __clk_rcg2_configure(rcg, f);
+	ret = regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
+	if (ret)
+		return ret;
+
+	ret = __clk_rcg2_configure(rcg, f, &cfg);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), cfg);
 	if (ret)
 		return ret;
 
@@ -979,11 +1011,12 @@ static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
 		return -EINVAL;
 
 	/*
-	 * In case clock is disabled, update the CFG, M, N and D registers
-	 * and don't hit the update bit of CMD register.
+	 * In case clock is disabled, update the M, N and D registers, cache
+	 * the CFG value in parked_cfg and don't hit the update bit of CMD
+	 * register.
 	 */
 	if (!__clk_is_enabled(hw->clk))
-		return __clk_rcg2_configure(rcg, f);
+		return __clk_rcg2_configure(rcg, f, &rcg->parked_cfg);
 
 	return clk_rcg2_shared_force_enable_clear(hw, f);
 }
@@ -1007,6 +1040,11 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
 	if (ret)
 		return ret;
 
+	/* Write back the stored configuration corresponding to current rate */
+	ret = regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, rcg->parked_cfg);
+	if (ret)
+		return ret;
+
 	ret = update_config(rcg);
 	if (ret)
 		return ret;
@@ -1017,13 +1055,12 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
 static void clk_rcg2_shared_disable(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
-	u32 cfg;
 
 	/*
 	 * Store current configuration as switching to safe source would clear
 	 * the SRC and DIV of CFG register
 	 */
-	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &rcg->parked_cfg);
 
 	/*
 	 * Park the RCG at a safe configuration - sourced off of safe source.
@@ -1041,17 +1078,52 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
 	update_config(rcg);
 
 	clk_rcg2_clear_force_enable(hw);
+}
 
-	/* Write back the stored configuration corresponding to current rate */
-	regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, cfg);
+static u8 clk_rcg2_shared_get_parent(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/* If the shared rcg is parked used the cached cfg instead */
+	if (!__clk_is_enabled(hw->clk))
+		return __clk_rcg2_get_parent(hw, rcg->parked_cfg);
+
+	return clk_rcg2_get_parent(hw);
+}
+
+static int clk_rcg2_shared_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/* If the shared rcg is parked only update the cached cfg */
+	if (!clk_hw_is_enabled(hw)) {
+		rcg->parked_cfg &= ~CFG_SRC_SEL_MASK;
+		rcg->parked_cfg |= rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
+
+		return 0;
+	}
+
+	return clk_rcg2_set_parent(hw, index);
+}
+
+static unsigned long
+clk_rcg2_shared_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/* If the shared rcg is parked used the cached cfg instead */
+	if (!__clk_is_enabled(hw->clk))
+		return __clk_rcg2_recalc_rate(hw, parent_rate, rcg->parked_cfg);
+
+	return clk_rcg2_recalc_rate(hw, parent_rate);
 }
 
 const struct clk_ops clk_rcg2_shared_ops = {
 	.enable = clk_rcg2_shared_enable,
 	.disable = clk_rcg2_shared_disable,
-	.get_parent = clk_rcg2_get_parent,
-	.set_parent = clk_rcg2_set_parent,
-	.recalc_rate = clk_rcg2_recalc_rate,
+	.get_parent = clk_rcg2_shared_get_parent,
+	.set_parent = clk_rcg2_shared_set_parent,
+	.recalc_rate = clk_rcg2_shared_recalc_rate,
 	.determine_rate = clk_rcg2_determine_rate,
 	.set_rate = clk_rcg2_shared_set_rate,
 	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
-- 
2.35.1

