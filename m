Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355DD5184FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbiECNIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbiECNI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:08:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456B5387BA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:04:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gh6so33400492ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKhh0bhyLCkC5pTKYAdfR5BRKIIHfoHsreEDjsLLID4=;
        b=xXxe3Eycu6qRIC04JO+pavYVa/wqvhMc9smGHFZUbdmj6IOKVTiGR1DqFOoEpp4z4S
         LBrMFhmGqXKl1s5C60mxTirJ0AZSnDpF4eQGyY4bP768m/HKVxCFAvDZB9uEtfVKagR1
         B3IFlu3hsQjZiinbEPXBAqidHewJKMpClSKwGYeDOpF9sjrd3Ve5CsxNeqybKcMBXHql
         9g/cEJ+6RQsp3Tp35XB2DkvanqzRPKVYFtM+ztfdPzD3QyQyrgpxX1egAJLqV25wLsUW
         1efvPBp3WXf54Vz18a91XbQu/92bVFgqkglbV5xmiFPkx0w+bSWHpmWCTqzkjY5qdtYP
         N28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKhh0bhyLCkC5pTKYAdfR5BRKIIHfoHsreEDjsLLID4=;
        b=YyabvahH54cfDBeQEAIQxkdxfbX/crv4l6GEnaVHohNJb+4r2vUYT4z7m3YyW2CRzT
         7Gl7FsjyTJGNtRyJ7lJj44iClRa8F+zvwo0N584lP/3ufwRe50axkHznckvq4qB007KC
         oB+H4ubZ45b3DQP2GF3GCdvPQpXIw3cww74+5ndpMQPIQY4VsrqTGj8Vb80r484S2OnV
         vsBhix3BrvKP6G+vsGUuJ5QN05X4Ko13UOEnPhGwCAMQE+q6lQvefkYj2j0Gqj94FyxY
         g05eylDQagcUvT6kp66/kDxYim6v7o6A6VSTLbwdlPpUcJhxsXKieo4fmy71jMU+sFo0
         N9xQ==
X-Gm-Message-State: AOAM530cPNhHjPLRqL9Y4+WiCHq6Fc1CvhdeyTGM93TdCWSMwpS2o8jE
        LKhiyH9W5HDwv9GV6gFIJ+7COQ==
X-Google-Smtp-Source: ABdhPJz+JcV4GpubVALOLerlASp0y4mGfBQsNh/CLjEdwGKiG4hGRMUXYaVdasEm22CLn5LbqcEyog==
X-Received: by 2002:a17:907:3e8c:b0:6f4:4fdb:6f24 with SMTP id hs12-20020a1709073e8c00b006f44fdb6f24mr8997901ejc.44.1651583093752;
        Tue, 03 May 2022 06:04:53 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id y13-20020aa7cccd000000b0042617ba639asm7868782edt.36.2022.05.03.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 06:04:53 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, tdas@codeaurora.org,
        anischal@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Steev Klimaszewski <steev@kali.org>
Subject: [PATCH v2 1/8] clk: qcom: rcg2: Cache rate changes for parked RCGs
Date:   Tue,  3 May 2022 15:04:41 +0200
Message-Id: <20220503130448.520470-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
2.34.1

