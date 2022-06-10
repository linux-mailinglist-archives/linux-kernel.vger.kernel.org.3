Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0253545ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244976AbiFJIZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346743AbiFJIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:24:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75B53FB122
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:21:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e9so12900290pju.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9IQH3f+hWlu/9/XT0cEj9lqHfnbsk8bolxLv7nv6D0=;
        b=nC/e0rCWWccgg+dWFsl2cdg+XLCq5mE001XmdFOx5bsYyPfjbc5YkOzCUgUHvuk10M
         76cSux1zFPmYh5zOtYB2Igosm+xdMGD2ZU1pgGnUXeLEWQPx+AJS6EnEkyUNuuL1n1Ft
         8QTxgSlNakQZhWlA90Bl+vUNZySfTeRYw/aga3tV8/1x+omQGwf9B7T+fb4N/6TAKN1x
         hBs6zRb1MxNx7+fPp1522M/k/p03ulpvJiobwYGNmzcrTKr55UpISIdFUP4LKxjtpYRU
         uujF6bf0TqOfaGyB2pOS2YGlOh8m1Pda2hc8mjAQYEoq5ETMa2tI77FQhvrFc/E0JPt0
         2dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9IQH3f+hWlu/9/XT0cEj9lqHfnbsk8bolxLv7nv6D0=;
        b=lBVxSvQ02uNe7DCsAdotXomJ0XNp7PKMm1Hd+17uyA9/J81646cf5YWH6aMfIyuYnY
         TIXnAPOZ2q1e/5fa910dP28n83T9nO72M+k2jl9x1+pytGULumu6mCmV5k41rJA80+wr
         ZqfcVSn7dft2k/cBvDFp53IhfyGMQqslIpRMBfQajS4qy4jD1zKnghvQao06YZ1ICMXM
         lUrQHmoUfbYjwXKIM8dIqHkNTFBaP+MSpQb7ASI1Pz9nuPhFLb+6T4UPkMNq2PVFS3xg
         JTPN++wcEZ1rTjGU0t7tzx9urbcyTT9dbeo6dqYQUyzgjCimVWhnsNIj8VATfOpUuhax
         Zpeg==
X-Gm-Message-State: AOAM530A5rOt7Em9HPS+VI7XyIi1OSGqQpTu5vUCWpMmtAGtc/9mjr+J
        x6xEyukr5fRRkV+LMKx9jx1rGA==
X-Google-Smtp-Source: ABdhPJzi/0ZgaUsiiXZ34sJtcUMki2ea9mVcEE3SSAZi1r84WghHlJPIkMNeBasiZBmCiDVXJVK2rA==
X-Received: by 2002:a17:902:ec81:b0:163:3142:e0dd with SMTP id x1-20020a170902ec8100b001633142e0ddmr37480633plg.40.1654849284635;
        Fri, 10 Jun 2022 01:21:24 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id iz12-20020a170902ef8c00b00162037fbb68sm18132723plb.215.2022.06.10.01.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:21:24 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] OPP: Assert clk_count == 1 for single clk helpers
Date:   Fri, 10 Jun 2022 13:50:51 +0530
Message-Id: <a62471a6205813e478c21edb405d62285ea6be6e.1654849214.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1654849214.git.viresh.kumar@linaro.org>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many helpers can be safely called only for devices that have a single
clk associated with them. Assert the same for those routines.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b8e6dc0a9b36..5635f4ad6d59 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -93,6 +93,12 @@ struct opp_table *_find_opp_table(struct device *dev)
 	return opp_table;
 }
 
+/* Returns true for single clock, false with WARN otherwise */
+bool assert_single_clk(struct opp_table *opp_table)
+{
+	return !WARN_ON(opp_table->clk_count != 1);
+}
+
 /**
  * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an opp
  * @opp:	opp for which voltage has to be returned for
@@ -177,6 +183,9 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 		return 0;
 	}
 
+	if (!assert_single_clk(opp->opp_table))
+		return 0;
+
 	return opp->rates[0];
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
@@ -597,7 +606,8 @@ static struct dev_pm_opp *_find_key_floor(struct device *dev,
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 		unsigned long freq, bool available)
 {
-	return _find_key_exact(dev, freq, 0, available, _read_freq, NULL);
+	return _find_key_exact(dev, freq, 0, available, _read_freq,
+			       assert_single_clk);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
@@ -605,7 +615,7 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 						   unsigned long *freq)
 {
 	return _opp_table_find_key_ceil(opp_table, freq, 0, true, _read_freq,
-					NULL);
+					assert_single_clk);
 }
 
 /**
@@ -629,7 +639,7 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq)
 {
-	return _find_key_ceil(dev, freq, 0, true, _read_freq, NULL);
+	return _find_key_ceil(dev, freq, 0, true, _read_freq, assert_single_clk);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
@@ -654,7 +664,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq)
 {
-	return _find_key_floor(dev, freq, 0, true, _read_freq, NULL);
+	return _find_key_floor(dev, freq, 0, true, _read_freq, assert_single_clk);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
@@ -1507,6 +1517,9 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 	if (IS_ERR(opp_table))
 		return;
 
+	if (!assert_single_clk(opp_table))
+		goto put_table;
+
 	mutex_lock(&opp_table->lock);
 
 	list_for_each_entry(iter, &opp_table->opp_list, node) {
@@ -1528,6 +1541,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 			 __func__, freq);
 	}
 
+put_table:
 	/* Drop the reference taken by _find_opp_table() */
 	dev_pm_opp_put_opp_table(opp_table);
 }
@@ -1819,6 +1833,9 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	unsigned long tol;
 	int ret;
 
+	if (!assert_single_clk(opp_table))
+		return -EINVAL;
+
 	new_opp = _opp_allocate(opp_table);
 	if (!new_opp)
 		return -ENOMEM;
@@ -2600,6 +2617,11 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 		return r;
 	}
 
+	if (!assert_single_clk(opp_table)) {
+		r = -EINVAL;
+		goto put_table;
+	}
+
 	mutex_lock(&opp_table->lock);
 
 	/* Do we have the frequency? */
@@ -2671,6 +2693,11 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 		return r;
 	}
 
+	if (!assert_single_clk(opp_table)) {
+		r = -EINVAL;
+		goto put_table;
+	}
+
 	mutex_lock(&opp_table->lock);
 
 	/* Do we have the frequency? */
@@ -2702,11 +2729,11 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 				     opp);
 
 	dev_pm_opp_put(opp);
-	goto adjust_put_table;
+	goto put_table;
 
 adjust_unlock:
 	mutex_unlock(&opp_table->lock);
-adjust_put_table:
+put_table:
 	dev_pm_opp_put_opp_table(opp_table);
 	return r;
 }
-- 
2.31.1.272.g89b43f80a514

