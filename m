Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B57514ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377672AbiD2PQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiD2PQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:16:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DB3D4C49
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:13:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g20so9424298edw.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bnc7xO3az7rccsOJO8obe46CTWWIlyZBBYGgk6otdQ=;
        b=A8J6mu0UHsKQyge26bU/j8tsK4sQ4qhNOGGgwNNeg3b/b8m++6m1tLlgJHDKHicALb
         p4nJZXY1d4v8f8AuUlfyGcZxjRymhNtIuoyC+4MpWPMCeyK4H8UD5UatT/Q4SgmPrUsi
         6kYTeGSgdbvEDo06m2qTqZHCt9eeOrJpSlHfV3NC8qsgJZqbxxbmv/eJpW86odZ3yA6O
         zJITUUwmsUV25gT7CW4PExxRMG9glIShIp35heNe4ZM3BygT3v49RskkaPDLJLYgzRYI
         96idROj+aMaW+VZ0QS1yB0lt0iEfB4lxrJYUOdePrY03LvdkKLTLcoKE0yPiiNCFTuey
         t+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bnc7xO3az7rccsOJO8obe46CTWWIlyZBBYGgk6otdQ=;
        b=kQ8AcJgAMMcLfTbNacgvaPvCt8KhWG0+P10YHOvsjTu9EExl9H/l7AVGASEtth9xWF
         Hu2S1WyPRnDb6ZNMxE9aENzpNMFoeU3uis6m//ir+V1/e+gdTyKiJJIi7L3NchfsZDTu
         ZWlslgIIpvZu0mu2PWowY3tUlMXWY0lDc7HbUimY/1yqnRg4j/QJ5wWYS234TYrE861E
         SRJYdMwoR2IklHSlloRmllGFr9aaIrh52dJjhnF8WP1KnxC16xiRFxDqKu+BFX6HCx7q
         dbhfyOtUqBuJ8ERamosHuq1BXKCKO/JjwyInpNhHQCA9UJThGvPo77LsH0VGPg2vqQvt
         sAWg==
X-Gm-Message-State: AOAM533gU+XGviB2277QpMpkv2B1Po6p4AJiy8KoE6651ZgCny4oCgvw
        hKTHwIETxHEWc3e4cpqHi3hSTw==
X-Google-Smtp-Source: ABdhPJxpoO0jVgbjIYzu0YiPS8lmBQC+2VUElZk/qV9jT9SDbwXvH0t1Tfb+3k/tEr45cGvg7pSY4w==
X-Received: by 2002:a05:6402:155a:b0:425:c0b1:ab07 with SMTP id p26-20020a056402155a00b00425c0b1ab07mr39234921edx.258.1651245189765;
        Fri, 29 Apr 2022 08:13:09 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id zp15-20020a17090684ef00b006f3ef214e4esm712677ejb.180.2022.04.29.08.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:13:09 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, tdas@codeaurora.org,
        anischal@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Steev Klimaszewski <steev@kali.org>
Subject: [PATCH v1 1/9] clk: qcom: rcg2: Cache rate changes for parked RCGs
Date:   Fri, 29 Apr 2022 17:12:39 +0200
Message-Id: <20220429151247.388837-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
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

From: Bjorn Andersson <bjorn.andersson@linaro.org>

As GDSCs are turned on and off some associated clocks are momentarily
enabled for house keeping purposes. Failure to enable these clocks seems
to have been silently ignored in the past, but starting in SM8350 this
failure will prevent the GDSC to turn on.

At least on SM8350 this operation will enable the RCG per the
configuration in CFG_REG. This means that the current model where the
current configuration is written back to CF_REG immediately after
parking the RCG doesn't work.

Instead, keep track of the currently requested rate of the clock and
upon enabling the clock reapply the configuration per the saved rate.

Fixes: 7ef6f11887bd ("clk: qcom: Configure the RCGs to a safe source as needed")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
---
 drivers/clk/qcom/clk-rcg.h  |  2 ++
 drivers/clk/qcom/clk-rcg2.c | 32 +++++++++++++++++---------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 00cea508d49e..8b41244b8dbf 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -140,6 +140,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
  * @freq_tbl: frequency table
  * @clkr: regmap clock handle
  * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
+ * @current_rate: cached rate for parked RCGs
  */
 struct clk_rcg2 {
 	u32			cmd_rcgr;
@@ -150,6 +151,7 @@ struct clk_rcg2 {
 	const struct freq_tbl	*freq_tbl;
 	struct clk_regmap	clkr;
 	u8			cfg_off;
+	unsigned long		current_rate;
 };
 
 #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index f675fd969c4d..81fd3a2db709 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -167,6 +167,7 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	u32 cfg, hid_div, m = 0, n = 0, mode = 0, mask;
+	unsigned long rate;
 
 	regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
 
@@ -186,7 +187,11 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	hid_div = cfg >> CFG_SRC_DIV_SHIFT;
 	hid_div &= mask;
 
-	return calc_rate(parent_rate, m, n, mode, hid_div);
+	rate = calc_rate(parent_rate, m, n, mode, hid_div);
+	if (!rcg->current_rate)
+		rcg->current_rate = rate;
+
+	return rate;
 }
 
 static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
@@ -978,12 +983,14 @@ static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!f)
 		return -EINVAL;
 
+	rcg->current_rate = rate;
+
 	/*
-	 * In case clock is disabled, update the CFG, M, N and D registers
-	 * and don't hit the update bit of CMD register.
+	 * In the case that the shared RCG is parked, current_rate will be
+	 * applied as the clock is unparked again, so just return here.
 	 */
 	if (!__clk_is_enabled(hw->clk))
-		return __clk_rcg2_configure(rcg, f);
+		return 0;
 
 	return clk_rcg2_shared_force_enable_clear(hw, f);
 }
@@ -997,8 +1004,13 @@ static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
 static int clk_rcg2_shared_enable(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_tbl *f = NULL;
 	int ret;
 
+	f = qcom_find_freq(rcg->freq_tbl, rcg->current_rate);
+	if (!f)
+		return -EINVAL;
+
 	/*
 	 * Set the update bit because required configuration has already
 	 * been written in clk_rcg2_shared_set_rate()
@@ -1007,7 +1019,7 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
 	if (ret)
 		return ret;
 
-	ret = update_config(rcg);
+	ret = clk_rcg2_configure(rcg, f);
 	if (ret)
 		return ret;
 
@@ -1017,13 +1029,6 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
 static void clk_rcg2_shared_disable(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
-	u32 cfg;
-
-	/*
-	 * Store current configuration as switching to safe source would clear
-	 * the SRC and DIV of CFG register
-	 */
-	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
 
 	/*
 	 * Park the RCG at a safe configuration - sourced off of safe source.
@@ -1041,9 +1046,6 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
 	update_config(rcg);
 
 	clk_rcg2_clear_force_enable(hw);
-
-	/* Write back the stored configuration corresponding to current rate */
-	regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, cfg);
 }
 
 const struct clk_ops clk_rcg2_shared_ops = {
-- 
2.32.0

