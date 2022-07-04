Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36888565489
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiGDMKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiGDMJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:09:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F088612083
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:09:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o15so4667634pjh.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6OTH+s35Nt1rHwpbqRf4JhwqpF3oRIrQNAJMgMK39Yw=;
        b=zK04P3GaT+VUUatklviMx3RQPZ5FH4TAUHEC4agKXqi44pxINk1fo5Jz3fI4kka5wP
         FVZ8LEHy2jmA8cI3F8F+DDM+bIzgfMq2cumMWrieLIQP1VzdBp3WLiPbweQhTDpnYnOY
         fJuNzYwYkE0zxtQLYbh/hHHdJ94RNnYbi0S5lSwzhpli60Rwg7LuEXW2SbLGnCgw+mD1
         XhqR8v9gAm2hbx1QMSYujHzvpcfyQTQs5XGj1UVAJoacNonaIj4k3mgdqzFGreidzuNO
         CLqkkyVdzko/02shRWuLvLcgY2BsDIrb0DCxmf1UurwWgUlmAvH6SvQslFxVioLCi4ux
         e4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6OTH+s35Nt1rHwpbqRf4JhwqpF3oRIrQNAJMgMK39Yw=;
        b=0+sXZ3qvZXT7eGI1hWRo0/TjXEXWfIrQVVtx0cGNWbc4KjeiMJrQaKuLWQr0h1LJmJ
         NOa0C2Ik3XMzZTyi7pvmp2XTny8Yq5DJnztihk1aBU2/nRLR1AgZcy6BxM6tCWoyuZrY
         5cGEzJGQkEET58USbEGgHflawFq+0b7lUffVz/cdR2cl3VCDIDIxD2qdAY3Vfxe9RXuW
         nXY6yz9/K6KtH2Ri30bE20T+VuvN7oz6F5oZu6wkRaxVs7Hvxtl6CPOOxAuCJ2phw4yc
         J3dHbc1zLNXKqeXc+hOGdcz+FeAEGkNJsvOskP6DjJeCoCOUCm28TLFdYmkzct2QlQpj
         VAWA==
X-Gm-Message-State: AJIora8fjagIygbNKpiKq/lMcHvtFjRq3RDabAlLElII1Ehdp+3rvN6C
        GHbzqml1/PrK4Z2UOLcxjxs4WA==
X-Google-Smtp-Source: AGRyM1uQhX7ZSS88GaMyGgQj5OKjal1s7Chv2oZ0wsNkkPyfPZUdJGO+kmKzgoWtdsXc2I/AeAYgXQ==
X-Received: by 2002:a17:90a:fa01:b0:1ef:6e6a:4ff0 with SMTP id cm1-20020a17090afa0100b001ef6e6a4ff0mr15376041pjb.35.1656936539792;
        Mon, 04 Jul 2022 05:08:59 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a66c200b001ece55b938asm10020809pjl.32.2022.07.04.05.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:59 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 17/20] OPP: Make _generic_set_opp_regulator() a config_regulators() interface
Date:   Mon,  4 Jul 2022 17:37:55 +0530
Message-Id: <bccf9cb87d654ce05d4725416d64f9652f53e5d0.1656935522.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656935522.git.viresh.kumar@linaro.org>
References: <cover.1656935522.git.viresh.kumar@linaro.org>
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

In order to reuse the same code path, i.e. clk_set_rate() from
_set_opp(), migrate _generic_set_opp_regulator() to implement a
config_regulators() interface.

It is renamed to _opp_config_regulator_single() and is set as the
preferred config_regulators() interface whenever we have a single
regulator available.

Note that this also drops code responsible for restoring the
voltage/freq in case of errors. We aren't handling that properly
currently, restoring only some of the resources while leaving others out
(like bandwidth and required OPPs). It is better to drop all of it
instead of partial restoration.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 51 +++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 12bae79564f1..5ecf077b6b17 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -896,62 +896,34 @@ static inline int _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 	return ret;
 }
 
-static int _generic_set_opp_regulator(struct opp_table *opp_table,
-				      struct device *dev,
-				      struct dev_pm_opp *opp,
-				      unsigned long freq,
-				      int scaling_down)
+static int _opp_config_regulator_single(struct device *dev,
+			struct dev_pm_opp *old_opp, struct dev_pm_opp *new_opp,
+			struct regulator **regulators, unsigned int count)
 {
-	struct regulator *reg = opp_table->regulators[0];
-	struct dev_pm_opp *old_opp = opp_table->current_opp;
+	struct regulator *reg = regulators[0];
 	int ret;
 
 	/* This function only supports single regulator per device */
-	if (WARN_ON(opp_table->regulator_count > 1)) {
+	if (WARN_ON(count > 1)) {
 		dev_err(dev, "multiple regulators are not supported\n");
 		return -EINVAL;
 	}
 
-	/* Scaling up? Scale voltage before frequency */
-	if (!scaling_down) {
-		ret = _set_opp_voltage(dev, reg, opp->supplies);
-		if (ret)
-			goto restore_voltage;
-	}
-
-	/* Change frequency */
-	ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
+	ret = _set_opp_voltage(dev, reg, new_opp->supplies);
 	if (ret)
-		goto restore_voltage;
-
-	/* Scaling down? Scale voltage after frequency */
-	if (scaling_down) {
-		ret = _set_opp_voltage(dev, reg, opp->supplies);
-		if (ret)
-			goto restore_freq;
-	}
+		return ret;
 
 	/*
 	 * Enable the regulator after setting its voltages, otherwise it breaks
 	 * some boot-enabled regulators.
 	 */
-	if (unlikely(!opp_table->enabled)) {
+	if (unlikely(!new_opp->opp_table->enabled)) {
 		ret = regulator_enable(reg);
 		if (ret < 0)
 			dev_warn(dev, "Failed to enable regulator: %d", ret);
 	}
 
 	return 0;
-
-restore_freq:
-	if (_generic_set_opp_clk_only(dev, opp_table->clk, old_opp->rate))
-		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
-			__func__, old_opp->rate);
-restore_voltage:
-	/* This shouldn't harm even if the voltages weren't updated earlier */
-	_set_opp_voltage(dev, reg, old_opp->supplies);
-
-	return ret;
 }
 
 static int _set_opp_bw(const struct opp_table *opp_table,
@@ -1200,9 +1172,6 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 
 	if (opp_table->set_opp) {
 		ret = _set_opp_custom(opp_table, dev, opp, freq);
-	} else if (opp_table->regulators) {
-		ret = _generic_set_opp_regulator(opp_table, dev, opp, freq,
-						 scaling_down);
 	} else {
 		/* Only frequency scaling */
 		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
@@ -2121,6 +2090,10 @@ static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
 	}
 	mutex_unlock(&opp_table->lock);
 
+	/* Set generic config_regulators() for single regulators here */
+	if (count == 1)
+		opp_table->config_regulators = _opp_config_regulator_single;
+
 	return 0;
 
 free_regulators:
-- 
2.31.1.272.g89b43f80a514

