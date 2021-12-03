Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB3C4670F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245328AbhLCD5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhLCD5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:57:53 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BB0C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 19:54:30 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bk14so3327035oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 19:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhvyA50uJRG7je6QLHwD3R7c8JzPQfTmm6dYn4D7d9Q=;
        b=PIZ6/tfDlcdEgNiK2v74b+SLK0rbKIMT0qsWxFe8VD6C4DjOmV3W9HDNvqq9BMbrmp
         tj7ZqSCZOv3fCN6j+ev3dTGrZcnz7U9MFIPeiSH64wi3oG33qBd3JqVsdT/SXqVHFkky
         JkV0vHC5UHhBrsUpTJl9wlDGpWpODSAnaLHPCh85WAiT1unWnQCON7H88H1zUQt9DVPy
         1BKoiYBeSbbk3h3cDwLz+PFozdsNmTHRhq/lfF56edpTIPGNKQAYaTY8r82OSWlJYUzF
         S62NVjCZRbzRc51FvpXUi2/akpKJgrU70i9CGLhXP79zf28051tyOyD8lFi96ts18cnj
         g89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhvyA50uJRG7je6QLHwD3R7c8JzPQfTmm6dYn4D7d9Q=;
        b=sIoktp26GxLlSYc1tFTryTtScqxP/soMKJ88k5KvDxrrT9dGqKisNz4evvgDfD5LE/
         yUvNYZfZbt9L6FW2i4vJgQ93LKQXClQJ/U3nddbNoMH/FgdpSQ2qRDHECD0wdx7Wf/5e
         C3sarvMn0jo14Qt0KSCzZ5/BsAlBh4raypGq2Z5v7SCOCUXnT1KaCxVPupXhyyw6qS/C
         Z3iO57e8/lwOKupoXcR9hDce0LRZa9roPH80RRSS6PY+ZH6jeo/eK3kNxmFEVDHlDsMq
         1XAAPa1qeHFvoya9WC9Yn6zVYJOJ3k7fAkJakffDFQVqrR4c9XHstyXhajC4a1FOx3Xy
         L9uQ==
X-Gm-Message-State: AOAM532RzL7UcPIjQAcA6mYNIcfwvMxhAtTGN4C0XDJI9hbnyct2jUA/
        L6UiW1Owq9snOrg8Bc+e1xxuuQ==
X-Google-Smtp-Source: ABdhPJxnAqD3eI50LTHgYY2dc+3Wkof5nuCA5fHXOJkx7hauNN3Cognh3v5aO7VHPpQEBpiMIWLN/g==
X-Received: by 2002:a05:6808:1246:: with SMTP id o6mr1263226oiv.73.1638503669871;
        Thu, 02 Dec 2021 19:54:29 -0800 (PST)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x16sm440578otq.47.2021.12.02.19.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 19:54:29 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: rcg2: Cache rate changes for parked RCGs
Date:   Thu,  2 Dec 2021 19:56:01 -0800
Message-Id: <20211203035601.3505780-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/clk/qcom/clk-rcg.h  |  2 ++
 drivers/clk/qcom/clk-rcg2.c | 32 +++++++++++++++++---------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 99efcc7f8d88..6939f4e62768 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -139,6 +139,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
  * @freq_tbl: frequency table
  * @clkr: regmap clock handle
  * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
+ * @current_rate: cached rate for parked RCGs
  */
 struct clk_rcg2 {
 	u32			cmd_rcgr;
@@ -149,6 +150,7 @@ struct clk_rcg2 {
 	const struct freq_tbl	*freq_tbl;
 	struct clk_regmap	clkr;
 	u8			cfg_off;
+	unsigned long		current_rate;
 };
 
 #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e1b1b426fae4..b574b38dcbd5 100644
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
@@ -968,12 +973,14 @@ static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
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
@@ -987,8 +994,13 @@ static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
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
@@ -997,7 +1009,7 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
 	if (ret)
 		return ret;
 
-	ret = update_config(rcg);
+	ret = clk_rcg2_configure(rcg, f);
 	if (ret)
 		return ret;
 
@@ -1007,13 +1019,6 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
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
@@ -1031,9 +1036,6 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
 	update_config(rcg);
 
 	clk_rcg2_clear_force_enable(hw);
-
-	/* Write back the stored configuration corresponding to current rate */
-	regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, cfg);
 }
 
 const struct clk_ops clk_rcg2_shared_ops = {
-- 
2.33.1

