Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB3C538E84
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245550AbiEaKKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245554AbiEaKKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:10:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B599804
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:10:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s14so12413458plk.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YyUyg3polV3O3U+GfR+R8JOfYv9TQjwFgBv3/tKFoOo=;
        b=Sr3ItoKPRjamyvCKHzR9XNPAHzYYBZieCF+M0MW4T0/N/fo1Fk5nZ6n/ZLQ0M+uIZW
         LyTAQXP+Rw4vstbqTLz2yjp2TgdUkhXrynJTqeLpPYazaQzgWYwrVg70LcL+Mq1xqV0E
         JR+7DPTA6MgZiyfLM4N1/4ElqKJBMuY+31qWY5PwZWggWJKkrjMH24uiYgLAKK3fm51C
         HWY9XuJ5jjQZwuEExFvMysJTGoxRJlbrGIlag3IOrTzeLxuRdiWJi6FjMjph/KxDPwPl
         sxPvUkIztZ0/DTHR+s+l8FKpLrVtQZTFzL4/KFUOPGOZ7SbGd+SN6XQzaSou3XvaNn9M
         YWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YyUyg3polV3O3U+GfR+R8JOfYv9TQjwFgBv3/tKFoOo=;
        b=fPq49oqfW6PUnJOVeoAKsteDwm2Nl+O2XL/8uVNFkffc1gdNV1e9UOzdN7tM8dCoey
         BvqYbOWiq72JI5iVgxF1tNKbOQK88EW8RzLaZ/ZfE8KC/5+mveup27wSTVuSfy0E3NiN
         FOIAI+LJUNd+c1Uf3LDCv8yKTZNHJLH4xZne86ZTnCBu5wrTOz4oe0wAnkGdmiUqJuDd
         av5qa3z2WD6DiqzxcYJ0/pEgEGd+2R3kYo7BA5m2zoZWiNsMuiakNizXera4TSSOv3Lo
         SBYTu2B3yxWu/WKtDaJSvoNa1YQ3LPNjLtCfIwd7CQ13ZDVgPNlMwHo/hZuuiz5531OY
         KdLw==
X-Gm-Message-State: AOAM532hOE5WEAHKf0iHn9lqoT5PAAs9xu5ai50a5bDfQdQKrqHlqhW5
        GfkPuCmdA83H3GabIA0Q1vvMWg==
X-Google-Smtp-Source: ABdhPJw8TkORQQRhDtHEl2r0rvyG1TzTesdGYRyFPHaSYsY70jPU0SdKG2Sc63FedMuwtLWqfugVuA==
X-Received: by 2002:a17:90a:4417:b0:1ca:a861:3fbf with SMTP id s23-20020a17090a441700b001caa8613fbfmr28142580pjg.80.1653991822433;
        Tue, 31 May 2022 03:10:22 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id ch12-20020a056a00288c00b004fa743ba3f9sm10217427pfb.2.2022.05.31.03.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:10:22 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] OPP: Make _generic_set_opp_regulator() a config_regulators() interface
Date:   Tue, 31 May 2022 15:40:01 +0530
Message-Id: <3720e177d6cb3924a2ea111cf1787898a2c743d1.1653991004.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653991004.git.viresh.kumar@linaro.org>
References: <cover.1653991004.git.viresh.kumar@linaro.org>
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 51 +++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index bac91d078cbb..2f76442845be 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -892,62 +892,34 @@ static inline int _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 	return ret;
 }
 
-static int _generic_set_opp_regulator(struct opp_table *opp_table,
-				      struct device *dev,
-				      struct dev_pm_opp *opp,
-				      unsigned long freq,
-				      int scaling_down)
+static int _opp_config_regulator_single(struct device *dev, struct dev_pm_opp *old_opp,
+					struct dev_pm_opp *new_opp, struct regulator **regulators,
+					unsigned int count)
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
@@ -1194,9 +1166,6 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 
 	if (opp_table->set_opp) {
 		ret = _set_opp_custom(opp_table, dev, opp, freq);
-	} else if (opp_table->regulators) {
-		ret = _generic_set_opp_regulator(opp_table, dev, opp, freq,
-						 scaling_down);
 	} else {
 		/* Only frequency scaling */
 		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
@@ -2103,6 +2072,10 @@ static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
 		opp_table->set_opp_data->old_opp.supplies = supplies;
 		opp_table->set_opp_data->new_opp.supplies = supplies + count;
 	}
+
+	/* Set generic config_regulators() for single regulators here */
+	if (count == 1)
+		opp_table->config_regulators = _opp_config_regulator_single;
 	mutex_unlock(&opp_table->lock);
 
 	return 0;
-- 
2.31.1.272.g89b43f80a514

