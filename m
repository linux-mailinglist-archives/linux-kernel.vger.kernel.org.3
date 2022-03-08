Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B344D0E84
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 05:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbiCHEDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 23:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiCHEDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 23:03:01 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACC934666
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:02:04 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso3238538otj.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 20:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lL2jwquuB5a1bVZ3DDxZSoQNHav7KSw0idCUxdrZUO4=;
        b=HRK0rxQEbLI+AV+583AuIQ/lhxdQPR/ugRj8NfVtUG5sH4r/szAQTyirCldbNOcqdB
         zy/JQwkfv/1ncYXk4UHWediqxlwq2MdKfEMBeuM740RC5X925zrKVegxX4KfM4E2+MrB
         722pHMKj62741Jrfbb557NT8yB4+RTdOyQUwfy7WsZvoTSIsc9Y4nTj4O3hnVZiOE9Rl
         ZgI1nzUoPkWDKRUovI6TfgtT8UXvaCd9sZ0IXGHxboFEVTucW68aDvcbbre4yG8HDyLv
         xtQWwQ0TB0LPbx7LQs1LyD8wmhYyfo5p//r8hHgQYAb2iPNFrshw6vLDfYU1nZeUK1wd
         kUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lL2jwquuB5a1bVZ3DDxZSoQNHav7KSw0idCUxdrZUO4=;
        b=LITnn4AJCh6g3Gf1e+N41xsbT6jx7vcFTjwuggRXLSMTzy5gLlwN9hV0LkkJw6oqqa
         pXJPoH1QKGKs7YwzPSzDER2zuhndEafcKKlD5aWQsV+1PHm7Yfwpuf5R/NI6F2k89bR0
         qwjhxS05m9GATHNHGSWH/g5sZNGQ+z1VT9AyookfYA+NixuEl2M3AnBv7CDIABycXNNF
         mVo5BV5MAqA8v04D8kRk26gdHjL3bYRH1s3t7btPWA+1pC8lfSysGwAoAzMYSXbpSzYp
         YOUtGOdRKpnGST9NYXZTdb6m9N5bWrDrcZHeuBb81gmEXpp7WXsGOhJWjuiqqImUvN3I
         p1qQ==
X-Gm-Message-State: AOAM533sG6nCg3wF/Kx84eemG0AVI29rq38yoJpXryC8wPckji4NOA9p
        xAYIfbrYt7XkoYZrL9OGV86LDA==
X-Google-Smtp-Source: ABdhPJysS6dMaKwQEavYolUtYHmmOh0f0I+99qjQrxBpzIFAVQJ6ws+v8JgBMwlHODQofOxzC+XCOg==
X-Received: by 2002:a05:6830:1e8a:b0:5ad:c4c:c52a with SMTP id n10-20020a0568301e8a00b005ad0c4cc52amr7559488otr.90.1646712124079;
        Mon, 07 Mar 2022 20:02:04 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id l84-20020aca3e57000000b002d97bda3872sm7199789oia.55.2022.03.07.20.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 20:02:03 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: qcom: rcg2: Cache CFG register updates for parked RCGs
Date:   Mon,  7 Mar 2022 20:03:48 -0800
Message-Id: <20220308040348.1340405-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
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

As GDSCs are turned on and off some associated clocks are momentarily
enabled for house keeping purposes. For this, and similar, purposes the
"shared RCGs" will park the RCG on a source clock which is known to be
available.
When the RCG is parked, a safe clock source will be selected and
committed, then the original source would be written back and upon enable
the change back to the unparked source would be committed.

But starting with SM8350 this fails, as the value in CFG is committed by
the GDSC handshake and without a valid parent the GDSC enablement will
fail.

To avoid this problem, the software needs to cache the CFG register
content while the shared RCG is parked.

Writes to M, N and D registers are committed as they are requested. New
helpers for get_parent() and recalc_rate() are extracted from their
previous implementations and __clk_rcg2_configure() is modified to allow
it to operate on the cached value.

Fixes: 7ef6f11887bd ("clk: qcom: Configure the RCGs to a safe source as needed")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Rather than caching the last requested freqnecy, cache and update the CFG
  register value while the shared RCG is disabled.
- Use/modify the cached RCG value in get_parent(), set_parent() and
  recalc_rate() for parked shared RCGs as well.
- Rewrote the commit message.

 drivers/clk/qcom/clk-rcg.h  |   2 +
 drivers/clk/qcom/clk-rcg2.c | 134 +++++++++++++++++++++++++++---------
 2 files changed, 104 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 99efcc7f8d88..7bcbda8e4f17 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -139,6 +139,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
  * @freq_tbl: frequency table
  * @clkr: regmap clock handle
  * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
+ * @parked_cfg: cached value of the CFG register for parked RCGs
  */
 struct clk_rcg2 {
 	u32			cmd_rcgr;
@@ -149,6 +150,7 @@ struct clk_rcg2 {
 	const struct freq_tbl	*freq_tbl;
 	struct clk_regmap	clkr;
 	u8			cfg_off;
+	u32			parked_cfg;
 };
 
 #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e1b1b426fae4..8e3aebb72191 100644
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
+		pr_err("%s: Unable to read CFG register for %s\n",
+		       __func__, clk_hw_get_name(hw));
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
@@ -262,9 +281,10 @@ static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,
 	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, FLOOR);
 }
 
-static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
+static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f,
+				u32 *cfg)
 {
-	u32 cfg, mask;
+	u32 mask;
 	struct clk_hw *hw = &rcg->clkr.hw;
 	int ret, index = qcom_find_src_index(hw, rcg->parent_map, f->src);
 
@@ -289,21 +309,31 @@ static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 			return ret;
 	}
 
-	mask = BIT(rcg->hid_width) - 1;
-	mask |= CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK;
-	cfg = f->pre_div << CFG_SRC_DIV_SHIFT;
-	cfg |= rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
+	*cfg &= ~GENMASK(rcg->hid_width - 1, 0);
+	*cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK);
+
+	*cfg = f->pre_div << CFG_SRC_DIV_SHIFT;
+	*cfg |= rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
 	if (rcg->mnd_width && f->n && (f->m != f->n))
-		cfg |= CFG_MODE_DUAL_EDGE;
-	return regmap_update_bits(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg),
-					mask, cfg);
+		*cfg |= CFG_MODE_DUAL_EDGE;
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
 
@@ -969,11 +999,12 @@ static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
 		return -EINVAL;
 
 	/*
-	 * In case clock is disabled, update the CFG, M, N and D registers
-	 * and don't hit the update bit of CMD register.
+	 * In case clock is disabled, update the M, N and D registers and cache
+	 * the CFG value in parked_cfg.
 	 */
+
 	if (!__clk_is_enabled(hw->clk))
-		return __clk_rcg2_configure(rcg, f);
+		return __clk_rcg2_configure(rcg, f, &rcg->parked_cfg);
 
 	return clk_rcg2_shared_force_enable_clear(hw, f);
 }
@@ -997,6 +1028,11 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
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
@@ -1007,13 +1043,12 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
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
@@ -1031,17 +1066,52 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
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
+	if (!__clk_is_enabled(hw->clk)) {
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
2.33.1

