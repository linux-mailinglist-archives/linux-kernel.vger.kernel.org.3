Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913894FC14E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbiDKPqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348187AbiDKPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:46:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F58D108D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:44:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u15so13104960ejf.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUHecTwVVvrne6C2zn7NEqF69WKs5io5wOl9BsR+pdo=;
        b=BaMULQQDH7+BY7SGNbOzUIqSAU7zrXml4onrxL4y4kDEEBKfZZ/bxvgYRMvA8nZB4y
         HGKNJHTI2Q54ob0+Rm+ceREjsPZrO+X5JYdUGI7pEIL95bJAlXHH/acTk3aqCLogGolG
         vsUFz93L4n6nI6UbeVVAFl98x13XvQtJ8zlOuro8bzhskFn5hn3Kap2o5d62qzicWJUD
         nGJzBH/IsQZ1NP4Cu5olOQN2X8l1QeN7oZ1HXZXl4r3S8+pn/iuIyTeWIKX2Zpgi5ZTw
         yBsGhkgqf727wDaQ2/rgiAe1GVW0FLHmnUoMD0BbfrbRdWM/FullRXxWoRXK5Nfy6WAw
         0nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUHecTwVVvrne6C2zn7NEqF69WKs5io5wOl9BsR+pdo=;
        b=B3dcIf/kgLCHKXrvXUiZu238tp6KHKpwodMA60LJ12SdWNUVpZFVJNxzdkhghlq5j5
         rB1AcwdELgsrD1y0Al4hWeKDjKyto09C11vJYnbbt/5I2FVpnRnLknUbYO6k9MCmd7+m
         xQsNK2sVQ0u08OXBNW2d+J5WHmaaZaqgPCaKG6wcnj5aeEs264harkhvNM5/+b0GxAZK
         10aiDMm67ZJpEwypk4/8zfNDZt03n5yMXYl84MiBx/OoRlcZM32dWUY41mlK/ctzA8ZG
         OSl2yIjVbNk6qfGtUCXsUW/xftnC+u4OUjGvBMU5rcrKE/V8GG3RUWD/D+hAAsvS8Kgy
         thYQ==
X-Gm-Message-State: AOAM532OLjkGflfB0F29qTrkHr+6YqN2zSezhtnSqsYnvb6z1BW0PUZB
        72xStpJbHBr3aF7ycnQQ0WnhqQ==
X-Google-Smtp-Source: ABdhPJwwG9Grjj6nk3K3sUNY+XKJcYXGnzmhTUqb0CMKRGbYy5SXYghPI801vigi57Cv8+gkb+cPHA==
X-Received: by 2002:a17:906:e110:b0:6e6:75e0:946c with SMTP id gj16-20020a170906e11000b006e675e0946cmr29924830ejb.611.1649691849033;
        Mon, 11 Apr 2022 08:44:09 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906608e00b006d1455acc62sm12173177ejj.74.2022.04.11.08.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:44:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH v2 4/6] PM: opp: allow control of multiple clocks
Date:   Mon, 11 Apr 2022 17:43:45 +0200
Message-Id: <20220411154347.491396-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
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

Devices might need to control several clocks when scaling the frequency
and voltage.  Example is the Universal Flash Storage (UFS) which scales
several independent clocks with change of performance levels.

Add parsing of multiple clocks and clock names and scale all of them,
when needed.  If only one clock is provided, the code should behave the
same as before.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/opp/core.c     | 205 ++++++++++++++++++++++++++++++++---------
 drivers/opp/of.c       |  48 ++++++++++
 drivers/opp/opp.h      |   9 +-
 include/linux/pm_opp.h |  23 +++++
 4 files changed, 242 insertions(+), 43 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2945f3c1ce09..5dcd7157f6ab 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -66,6 +66,21 @@ static struct opp_table *_find_opp_table_unlocked(struct device *dev)
 	return ERR_PTR(-ENODEV);
 }
 
+static void _put_clocks(struct opp_table *opp_table)
+{
+	int i;
+
+	if (!opp_table->clks)
+		return;
+
+	for (i = opp_table->clk_count - 1; i >= 0; i--)
+		clk_put(opp_table->clks[i]);
+
+	kfree(opp_table->clks);
+	opp_table->clks = NULL;
+	opp_table->clk_count = -1;
+};
+
 /**
  * _find_opp_table() - find opp_table struct using device pointer
  * @dev:	device pointer used to lookup OPP table
@@ -772,6 +787,30 @@ static inline int _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 	return ret;
 }
 
+static int _generic_set_opp_clks_only(struct device *dev,
+				      struct opp_table *opp_table,
+				      struct dev_pm_opp *opp)
+{
+	int i, ret;
+
+	if (!opp_table->clks)
+		return 0;
+
+	for (i = 0; i < opp_table->clk_count; i++) {
+		if (opp->rates[i]) {
+			ret = _generic_set_opp_clk_only(dev, opp_table->clks[i],
+							opp->rates[i]);
+			if (ret) {
+				dev_err(dev, "%s: failed to set clock %pC rate: %d\n",
+					__func__, opp_table->clks[i], ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int _generic_set_opp_regulator(struct opp_table *opp_table,
 				      struct device *dev,
 				      struct dev_pm_opp *opp,
@@ -796,7 +835,7 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 	}
 
 	/* Change frequency */
-	ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
+	ret = _generic_set_opp_clks_only(dev, opp_table, opp);
 	if (ret)
 		goto restore_voltage;
 
@@ -820,7 +859,7 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 	return 0;
 
 restore_freq:
-	if (_generic_set_opp_clk_only(dev, opp_table->clk, old_opp->rate))
+	if (_generic_set_opp_clks_only(dev, opp_table, old_opp))
 		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
 			__func__, old_opp->rate);
 restore_voltage:
@@ -880,7 +919,7 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 	}
 
 	data->regulators = opp_table->regulators;
-	data->clk = opp_table->clk;
+	data->clk = (opp_table->clks ? opp_table->clks[0] : NULL);
 	data->dev = dev;
 	data->old_opp.rate = old_opp->rate;
 	data->new_opp.rate = freq;
@@ -969,8 +1008,8 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
 	unsigned long freq;
 
-	if (!IS_ERR(opp_table->clk)) {
-		freq = clk_get_rate(opp_table->clk);
+	if (opp_table->clks && !IS_ERR(opp_table->clks[0])) {
+		freq = clk_get_rate(opp_table->clks[0]);
 		opp = _find_freq_ceil(opp_table, &freq);
 	}
 
@@ -1070,7 +1109,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 						 scaling_down);
 	} else {
 		/* Only frequency scaling */
-		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
+		ret = _generic_set_opp_clks_only(dev, opp_table, opp);
 	}
 
 	if (ret)
@@ -1135,11 +1174,15 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * equivalent to a clk_set_rate()
 		 */
 		if (!_get_opp_count(opp_table)) {
-			ret = _generic_set_opp_clk_only(dev, opp_table->clk, target_freq);
+			if (opp_table->clks)
+				ret = _generic_set_opp_clk_only(dev,
+								opp_table->clks[0],
+								target_freq);
 			goto put_opp_table;
 		}
 
-		freq = clk_round_rate(opp_table->clk, target_freq);
+		if (opp_table->clks)
+			freq = clk_round_rate(opp_table->clks[0], target_freq);
 		if ((long)freq <= 0)
 			freq = target_freq;
 
@@ -1156,6 +1199,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 				__func__, freq, ret);
 			goto put_opp_table;
 		}
+		/*
+		 * opp->rates are used for scaling clocks, so be sure accurate
+		 * 'freq' is used, instead what was defined via e.g. Devicetree.
+		 */
+		opp->rates[0] = freq;
 	}
 
 	ret = _set_opp(dev, opp_table, opp, freq);
@@ -1246,7 +1294,8 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	INIT_LIST_HEAD(&opp_table->dev_list);
 	INIT_LIST_HEAD(&opp_table->lazy);
 
-	/* Mark regulator count uninitialized */
+	/* Mark regulator/clk count uninitialized */
+	opp_table->clk_count = -1;
 	opp_table->regulator_count = -1;
 
 	opp_dev = _add_opp_dev(dev, opp_table);
@@ -1295,21 +1344,32 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
 	 * Return early if we don't need to get clk or we have already tried it
 	 * earlier.
 	 */
-	if (!getclk || IS_ERR(opp_table) || opp_table->clk)
+	if (!getclk || IS_ERR(opp_table) || opp_table->clks)
 		return opp_table;
 
+	opp_table->clks = kmalloc_array(1, sizeof(*opp_table->clks),
+					GFP_KERNEL);
+	if (!opp_table->clks)
+		return ERR_PTR(-ENOMEM);
+
 	/* Find clk for the device */
-	opp_table->clk = clk_get(dev, NULL);
+	opp_table->clks[0] = clk_get(dev, NULL);
 
-	ret = PTR_ERR_OR_ZERO(opp_table->clk);
-	if (!ret)
+	ret = PTR_ERR_OR_ZERO(opp_table->clks[0]);
+	if (!ret) {
+		opp_table->clk_count = 1;
 		return opp_table;
+	}
 
 	if (ret == -ENOENT) {
+		opp_table->clk_count = 0;
 		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
 		return opp_table;
 	}
 
+	kfree(opp_table->clks);
+	opp_table->clks = NULL;
+	opp_table->clk_count = -1;
 	dev_pm_opp_put_opp_table(opp_table);
 	dev_err_probe(dev, ret, "Couldn't find clock\n");
 
@@ -1408,9 +1468,7 @@ static void _opp_table_kref_release(struct kref *kref)
 
 	_of_clear_opp_table(opp_table);
 
-	/* Release clk */
-	if (!IS_ERR(opp_table->clk))
-		clk_put(opp_table->clk);
+	_put_clocks(opp_table);
 
 	if (opp_table->paths) {
 		for (i = 0; i < opp_table->path_count; i++)
@@ -2144,9 +2202,51 @@ EXPORT_SYMBOL_GPL(devm_pm_opp_set_regulators);
  * This must be called before any OPPs are initialized for the device.
  */
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
+{
+	return dev_pm_opp_set_clknames(dev, &name, 1);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_clkname);
+
+/**
+ * dev_pm_opp_put_clkname() - Releases resources blocked for clk.
+ * @opp_table: OPP table returned from dev_pm_opp_set_clkname().
+ */
+void dev_pm_opp_put_clkname(struct opp_table *opp_table)
+{
+	return dev_pm_opp_put_clknames(opp_table);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
+
+/**
+ * devm_pm_opp_set_clkname() - Set clk name for the device
+ * @dev: Device for which clk name is being set.
+ * @name: Clk name.
+ *
+ * This is a resource-managed variant of dev_pm_opp_set_clkname().
+ *
+ * Return: 0 on success and errorno otherwise.
+ */
+int devm_pm_opp_set_clkname(struct device *dev, const char *name)
+{
+	return devm_pm_opp_set_clknames(dev, &name, 1);
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_set_clkname);
+
+/**
+ * dev_pm_opp_set_clknames() - Set clk names for the device
+ * @dev: Device for which clock names are being set.
+ * @names: Array of pointers to the names of the clocks.
+ * @count: Number of clocks.
+ *
+ * See: dev_pm_opp_set_clkname()
+ */
+struct opp_table *dev_pm_opp_set_clknames(struct device *dev,
+					  const char * const names[],
+					  unsigned int count)
 {
 	struct opp_table *opp_table;
-	int ret;
+	struct clk *clk;
+	int ret, i;
 
 	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
@@ -2159,70 +2259,92 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 	}
 
 	/* clk shouldn't be initialized at this point */
-	if (WARN_ON(opp_table->clk)) {
+	if (WARN_ON(opp_table->clks)) {
 		ret = -EBUSY;
 		goto err;
 	}
 
-	/* Find clk for the device */
-	opp_table->clk = clk_get(dev, name);
-	if (IS_ERR(opp_table->clk)) {
-		ret = dev_err_probe(dev, PTR_ERR(opp_table->clk),
-				    "%s: Couldn't find clock\n", __func__);
+	opp_table->clks = kmalloc_array(count, sizeof(*opp_table->clks),
+					GFP_KERNEL);
+	if (!opp_table->clks) {
+		ret = -ENOMEM;
 		goto err;
 	}
 
+	for (i = 0; i < count; i++) {
+		clk = clk_get(dev, names[i]);
+		if (IS_ERR(clk)) {
+			ret =  dev_err_probe(dev, PTR_ERR(clk),
+					     "%s: Couldn't find clock %s\n",
+					     __func__, names[i]);
+			goto free_clks;
+		}
+
+		opp_table->clks[i] = clk;
+	}
+
+	opp_table->clk_count = count;
+
 	return opp_table;
 
+free_clks:
+	while (i != 0)
+		clk_put(opp_table->clks[--i]);
+
+	kfree(opp_table->clks);
+	opp_table->clks = NULL;
+	opp_table->clk_count = -1;
 err:
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_clkname);
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_clknames);
 
 /**
- * dev_pm_opp_put_clkname() - Releases resources blocked for clk.
- * @opp_table: OPP table returned from dev_pm_opp_set_clkname().
+ * dev_pm_opp_put_clknames() - Releases resources blocked for clk.
+ * @opp_table: OPP table returned from dev_pm_opp_set_clknames().
  */
-void dev_pm_opp_put_clkname(struct opp_table *opp_table)
+void dev_pm_opp_put_clknames(struct opp_table *opp_table)
 {
 	if (unlikely(!opp_table))
 		return;
 
-	clk_put(opp_table->clk);
-	opp_table->clk = ERR_PTR(-EINVAL);
+	_put_clocks(opp_table);
 
 	dev_pm_opp_put_opp_table(opp_table);
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_clknames);
 
-static void devm_pm_opp_clkname_release(void *data)
+static void devm_pm_opp_clknames_release(void *data)
 {
-	dev_pm_opp_put_clkname(data);
+	dev_pm_opp_put_clknames(data);
 }
 
 /**
- * devm_pm_opp_set_clkname() - Set clk name for the device
- * @dev: Device for which clk name is being set.
- * @name: Clk name.
+ * devm_pm_opp_set_clknames() - Set clock names for the device
+ * @dev: Device for which clock names are being set.
+ * @names: Array of pointers to the names of the clocks.
+ * @count: Number of clocks.
  *
- * This is a resource-managed variant of dev_pm_opp_set_clkname().
+ * This is a resource-managed variant of dev_pm_opp_set_clknames().
  *
  * Return: 0 on success and errorno otherwise.
  */
-int devm_pm_opp_set_clkname(struct device *dev, const char *name)
+int devm_pm_opp_set_clknames(struct device *dev,
+			     const char * const names[],
+			     unsigned int count)
 {
 	struct opp_table *opp_table;
 
-	opp_table = dev_pm_opp_set_clkname(dev, name);
+	opp_table = dev_pm_opp_set_clknames(dev, names, count);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
-	return devm_add_action_or_reset(dev, devm_pm_opp_clkname_release,
+	return devm_add_action_or_reset(dev, devm_pm_opp_clknames_release,
 					opp_table);
 }
-EXPORT_SYMBOL_GPL(devm_pm_opp_set_clkname);
+EXPORT_SYMBOL_GPL(devm_pm_opp_set_clknames);
 
 /**
  * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
@@ -2637,7 +2759,8 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
-	/* Fix regulator count for dynamic OPPs */
+	/* Fix regulator/clk count for dynamic OPPs */
+	opp_table->clk_count = 1;
 	opp_table->regulator_count = 1;
 
 	ret = _opp_add_v1(opp_table, dev, freq, u_volt, true);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 440ab5a03df9..26ab58b71c2d 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -767,6 +767,47 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
+static int _read_clocks(struct dev_pm_opp *opp, struct opp_table *opp_table,
+			struct device_node *np)
+{
+	int count, ret;
+	u64 *freq;
+
+	count = of_property_count_u64_elems(np, "opp-hz");
+	if (count < 0) {
+		pr_err("%s: Invalid %s property (%d)\n",
+			__func__, of_node_full_name(np), count);
+		return count;
+	}
+
+	if (count != opp_table->clk_count) {
+		pr_err("%s: number of rates %d does not match number of clocks %d in %s\n",
+		       __func__, count, opp_table->clk_count,
+		       of_node_full_name(np));
+		return -EINVAL;
+	}
+
+	freq = kmalloc_array(count, sizeof(*freq), GFP_KERNEL);
+	if (!freq)
+		return -ENOMEM;
+
+	ret = of_property_read_u64_array(np, "opp-hz", freq, count);
+	if (ret) {
+		pr_err("%s: error parsing %s: %d\n", __func__,
+		       of_node_full_name(np), ret);
+		ret = -EINVAL;
+		goto free_freq;
+	}
+
+	opp->rates = freq;
+	return 0;
+
+free_freq:
+	kfree(freq);
+
+	return ret;
+}
+
 static int _read_bw(struct dev_pm_opp *new_opp, struct opp_table *table,
 		    struct device_node *np, bool peak)
 {
@@ -827,6 +868,13 @@ static int _read_opp_key(struct dev_pm_opp *new_opp, struct opp_table *table,
 	}
 	*rate_not_available = !!ret;
 
+	if (!ret) {
+		ret = _read_clocks(new_opp, table, np);
+		/* The properties were found but we failed to parse them */
+		if (ret && ret != -ENODEV)
+			return ret;
+	}
+
 	/*
 	 * Bandwidth consists of peak and average (optional) values:
 	 * opp-peak-kBps = <path1_value path2_value>;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 45e3a55239a1..2c4502cff3b2 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -60,6 +60,7 @@ extern struct list_head opp_tables, lazy_opp_tables;
  * @pstate: Device's power domain's performance state.
  * @rate:	Frequency in hertz
  * @level:	Performance level
+ * @rates:	Frequency rates for the clocks.
  * @supplies:	Power supplies voltage/current values
  * @bandwidth:	Interconnect bandwidth values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
@@ -84,6 +85,7 @@ struct dev_pm_opp {
 	unsigned long rate;
 	unsigned int level;
 
+	u64 *rates;
 	struct dev_pm_opp_supply *supplies;
 	struct dev_pm_opp_icc_bw *bandwidth;
 
@@ -149,7 +151,9 @@ enum opp_table_access {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
- * @clk: Device's clock handle
+ * @clks: Device clocks handles
+ * @clk_count: Number of clocks. Its value can be -1 (uninitialized), 0 (no
+ * clock handle provided)  or > 0 (has clock handles).
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators. Its value can be -1
  * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
@@ -200,7 +204,8 @@ struct opp_table {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
-	struct clk *clk;
+	struct clk **clks;
+	int clk_count;
 	struct regulator **regulators;
 	int regulator_count;
 	struct icc_path **paths;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0d85a63a1f78..cb50ccf6f818 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -158,6 +158,13 @@ int devm_pm_opp_set_regulators(struct device *dev, const char * const names[], u
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 int devm_pm_opp_set_clkname(struct device *dev, const char *name);
+struct opp_table *dev_pm_opp_set_clknames(struct device *dev,
+					  const char * const names[],
+					  unsigned int count);
+void dev_pm_opp_put_clknames(struct opp_table *opp_table);
+int devm_pm_opp_set_clknames(struct device *dev,
+			     const char * const names[],
+			     unsigned int count);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 int devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
@@ -386,6 +393,22 @@ static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
 	return -EOPNOTSUPP;
 }
 
+static inline struct opp_table *dev_pm_opp_set_clknames(struct device *dev,
+							const char * const names[],
+							unsigned int count)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void dev_pm_opp_put_clknames(struct opp_table *opp_table) {}
+
+static inline int devm_pm_opp_set_clknames(struct device *dev,
+					   const char * const names[],
+					   unsigned int count)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs)
 {
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.32.0

