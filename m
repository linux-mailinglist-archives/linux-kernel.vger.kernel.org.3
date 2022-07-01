Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B563562E69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbiGAIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiGAIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:35:10 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A483671240
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:35:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o18so1752655plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRM1PjazghlAlPXD7tv2+SDz7O4GVNObgvkudXkk8IM=;
        b=dQcvYUX3d0Hc0/3/lPi3x4cea9DpxT15pkG7XJcV/dRQwLiCxhr2Xy2LgqoLzItyej
         zzKQPqreKgGzKukt5sLNtRRhy3aFjlf5ekppgoSU04aLj0/JlX5XcRByJ9d9nRmIFCo4
         rc7FLitPNQPGO/3DrtFeyB5VoGynlR/kV8HnUbUPoMq1zupRxXfbRlk5wx9AJohtE7vV
         sakRnduEheX83YXsAudn/QPLOuPTh08lUjMVGflTR6LRRb0endklvEI7oyZYIDtuLcgH
         I3ziaBt2snD7ovzFYLq8MJBSiKQszyoRkM2D+fxEWbHk6CScZ/29a+wBeEcTvaFqv3fB
         FgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRM1PjazghlAlPXD7tv2+SDz7O4GVNObgvkudXkk8IM=;
        b=AIpBIMhyU6+cb/b8cQGb96N4mrr9I45eNpJG6s6cMg2jsL+jRKMPF/r8Xo/EIfX7aQ
         DKTUm7tzJr3yL3RYLf7Udl6ykM5J4CsO9Pfp3WXjEAF7Loh50ObBzQwr3dDOTBOBo+OT
         FOFNC7jFCRgHfBmPyqlN+erks+UYPlPLjV2g2rK1xRZ3RmQzt9zfkb9vtwhtWmepSklp
         q29cZh2gPitjVt/Z/isi3h+gOA6JreQxafQSxqm/jFCoaY2wDtSUZOhyLMdahXsdzuQy
         prgdiIPpmsq9bis2xw/qLqmeOSdugsYzee+FvFllmu5WTYfLBw7pAfwHWgQvuArepcP3
         tjbg==
X-Gm-Message-State: AJIora9K3SKww7jvC1MpLHYPaqoirey2Q1rx77Zf7MqmeK4aMz59QpUj
        wmYRhcPvkryORNtmr1Ap4FqgrA==
X-Google-Smtp-Source: AGRyM1vWS4XhZQ2vX+0HfYDGexiYN0ySk/slaYykTQoF5+866XV74mzfPyfUvGl17A9dviN85hDFtg==
X-Received: by 2002:a17:90b:895:b0:1ec:827c:ef0f with SMTP id bj21-20020a17090b089500b001ec827cef0fmr16875092pjb.10.1656664507206;
        Fri, 01 Jul 2022 01:35:07 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id d63-20020a621d42000000b0052532d9cb18sm14864102pfd.183.2022.07.01.01.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:35:06 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/5] OPP: Make _generic_set_opp_regulator() a config_regulators() interface
Date:   Fri,  1 Jul 2022 14:04:52 +0530
Message-Id: <2d9786a0e2460d3c4ac94a147a8b7ff77d36f696.1656664183.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656664183.git.viresh.kumar@linaro.org>
References: <cover.1656664183.git.viresh.kumar@linaro.org>
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
index d5e1ae6f5ea1..df0135f2cfec 100644
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
@@ -2113,6 +2082,10 @@ static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
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

