Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C79525B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377243AbiEMGPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377236AbiEMGO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:14:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7A62734F6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:14:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f2so2990632wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLu21/EAMBj4rBYhFk0RNS4w0Ycj4tgK+zAO7gTd2s4=;
        b=BUxLVCLTDJ8V3dc/ZchI6ZEzQpiFZYUxB6fKnCDJGAwEUFZlOhFlMdutjcbkbXKmcn
         VLOG8rA/I+9qLBmuF70RthtGred4rFEN6Gi8OCXqtFUZoanoFwANjm5YUnynw/19DgSl
         JFu9mKmfGXpgW+6r7Vq5QTK2PMS0abfhMPiQwNPV40ggJ/acEGwFiFWXsVoAI/dmV3ms
         yxrcEfT5z2dQVoMgP9XtNxZdcoLuH3aW7IBr6eN8aBBbFSywOIKcyZAxSx2EieDBse5W
         vYv2J4lp/MetB05aaudq5ggLcMalbvoeBUToOOx15+9d3xLTGKX0NrnF0dMZVNuVF9ZF
         FE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLu21/EAMBj4rBYhFk0RNS4w0Ycj4tgK+zAO7gTd2s4=;
        b=F49LRGNSe2n1+L9E+D7nW/+6Bn5odoiSuJFHI8qZOA7jdTbrBvpPbT9xHaDfKlDwva
         0GmO38ppq5rRWHdnBinDGN56CWFOJu2Sh+g0/TClSUGNemyfNsTPxDRBCz++zxRC3dkr
         H0r+B2WHmneBdJPTSH49X/LAxJuZwjeWGtFNj2hHOSUn6HohJp0eVmGJoPXMFOOmy3fu
         dbMHXNlpcetmxmDf7a/VdSt0ZxHuS26HDCPcE2S1R+kUyK2kq35C7cqSB3XWowcRu0oR
         xXy9cxRytMw8xqc7bpLraJiwXhHr0kH13bMWdrSqrxcQwOJtMil/fmNoH1lpEOfYIX1I
         xCoQ==
X-Gm-Message-State: AOAM5321bwinzp5fwjCwat4tHIFv/DurnRhzEiCaKU5wwLe7jjHPWlz5
        7661Y4AHib41sjH9jWV3Svhucg==
X-Google-Smtp-Source: ABdhPJx1UCYChPWaV7usSuEDEzkAG38Ui94RRVT8rND6KcnUFi6DNGfzlVER+jUAUJQDT50g9fHzPw==
X-Received: by 2002:adf:e8cb:0:b0:20c:5584:ba44 with SMTP id k11-20020adfe8cb000000b0020c5584ba44mr2464665wrn.173.1652422458839;
        Thu, 12 May 2022 23:14:18 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g4-20020adfbc84000000b0020c5253d8f3sm1477760wrh.63.2022.05.12.23.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 23:14:18 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 5/7] PM: opp: allow control of multiple clocks
Date:   Fri, 13 May 2022 08:13:45 +0200
Message-Id: <20220513061347.46480-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices might need to control several clocks when scaling the frequency
and voltage.  Example is the Universal Flash Storage (UFS) which scales
several independent clocks with change of performance levels.

Add parsing of multiple clocks and clock names, similarly to parsing
multiple regulators, and store them for custom set_opp.  The custom
set_opp helper is a requirement in such case, otherwise OPP framework
will refuse to scale multiple clocks.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/opp/core.c          | 187 +++++++++++++++++++++++++++---------
 drivers/opp/opp.h           |   7 +-
 drivers/opp/ti-opp-supply.c |   6 +-
 include/linux/pm_opp.h      |  29 +++++-
 4 files changed, 177 insertions(+), 52 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 84063eaebb91..aac3c6d89ae0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -66,6 +66,18 @@ static struct opp_table *_find_opp_table_unlocked(struct device *dev)
 	return ERR_PTR(-ENODEV);
 }
 
+static void _put_clocks(struct opp_table *opp_table)
+{
+	if (!opp_table->clks)
+		return;
+
+	clk_bulk_put(opp_table->clk_count, opp_table->clks);
+
+	kfree(opp_table->clks);
+	opp_table->clks = NULL;
+	opp_table->clk_count = -1;
+};
+
 /**
  * _find_opp_table() - find opp_table struct using device pointer
  * @dev:	device pointer used to lookup OPP table
@@ -874,11 +886,23 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 	return ret;
 }
 
-static inline int _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
+static inline int _generic_set_opp_clk_only(struct device *dev,
+					    struct opp_table *opp_table,
 					    unsigned long freq)
 {
+	struct clk *clk;
 	int ret;
 
+	/* This function only supports single clock per device */
+	if (WARN_ON(opp_table->clk_count > 1)) {
+		dev_err(dev, "multiple clocks are not supported\n");
+		return -EINVAL;
+	}
+
+	if (!opp_table->clks)
+		return 0;
+	clk = opp_table->clks[0].clk;
+
 	/* We may reach here for devices which don't change frequency */
 	if (IS_ERR(clk))
 		return 0;
@@ -903,8 +927,9 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 	int ret;
 
 	/* This function only supports single regulator per device */
-	if (WARN_ON(opp_table->regulator_count > 1)) {
-		dev_err(dev, "multiple regulators are not supported\n");
+	if (WARN_ON(opp_table->regulator_count > 1) ||
+	    WARN_ON(opp_table->clk_count > 1)) {
+		dev_err(dev, "multiple clocks/regulators are not supported\n");
 		return -EINVAL;
 	}
 
@@ -916,7 +941,7 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 	}
 
 	/* Change frequency */
-	ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
+	ret = _generic_set_opp_clk_only(dev, opp_table, freq);
 	if (ret)
 		goto restore_voltage;
 
@@ -940,7 +965,7 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 	return 0;
 
 restore_freq:
-	if (_generic_set_opp_clk_only(dev, opp_table->clk, old_opp->rate))
+	if (_generic_set_opp_clk_only(dev, opp_table, old_opp->rate))
 		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
 			__func__, old_opp->rate);
 restore_voltage:
@@ -987,8 +1012,8 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 	int size;
 
 	/*
-	 * We support this only if dev_pm_opp_set_regulators() was called
-	 * earlier.
+	 * We support this only if dev_pm_opp_set_regulators() or
+	 * dev_pm_opp_set_clknames() were called earlier.
 	 */
 	if (opp_table->sod_supplies) {
 		size = sizeof(*old_opp->supplies) * opp_table->regulator_count;
@@ -999,8 +1024,13 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 		data->regulator_count = 0;
 	}
 
+	if (opp_table->clks)
+		data->clk_count = opp_table->clk_count;
+	else
+		data->clk_count = 0;
+
 	data->regulators = opp_table->regulators;
-	data->clk = opp_table->clk;
+	data->clks = opp_table->clks;
 	data->dev = dev;
 	data->old_opp.rate = old_opp->rate;
 	data->new_opp.rate = freq;
@@ -1089,8 +1119,8 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
 	unsigned long freq;
 
-	if (!IS_ERR(opp_table->clk)) {
-		freq = clk_get_rate(opp_table->clk);
+	if (opp_table->clks && !IS_ERR(opp_table->clks[0].clk)) {
+		freq = clk_get_rate(opp_table->clks[0].clk);
 		opp = _find_freq_ceil(opp_table, &freq);
 	}
 
@@ -1190,7 +1220,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 						 scaling_down);
 	} else {
 		/* Only frequency scaling */
-		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
+		ret = _generic_set_opp_clk_only(dev, opp_table, freq);
 	}
 
 	if (ret)
@@ -1255,11 +1285,12 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * equivalent to a clk_set_rate()
 		 */
 		if (!_get_opp_count(opp_table)) {
-			ret = _generic_set_opp_clk_only(dev, opp_table->clk, target_freq);
+			ret = _generic_set_opp_clk_only(dev, opp_table, target_freq);
 			goto put_opp_table;
 		}
 
-		freq = clk_round_rate(opp_table->clk, target_freq);
+		if (opp_table->clks)
+			freq = clk_round_rate(opp_table->clks[0].clk, target_freq);
 		if ((long)freq <= 0)
 			freq = target_freq;
 
@@ -1366,7 +1397,8 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	INIT_LIST_HEAD(&opp_table->dev_list);
 	INIT_LIST_HEAD(&opp_table->lazy);
 
-	/* Mark regulator count uninitialized */
+	/* Mark regulator/clk count uninitialized */
+	opp_table->clk_count = -1;
 	opp_table->regulator_count = -1;
 
 	opp_dev = _add_opp_dev(dev, opp_table);
@@ -1415,21 +1447,29 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
 	 * Return early if we don't need to get clk or we have already tried it
 	 * earlier.
 	 */
-	if (!getclk || IS_ERR(opp_table) || opp_table->clk)
+	if (!getclk || IS_ERR(opp_table) || opp_table->clks)
 		return opp_table;
 
-	/* Find clk for the device */
-	opp_table->clk = clk_get(dev, NULL);
+	opp_table->clks = kcalloc(1, sizeof(*opp_table->clks), GFP_KERNEL);
+	if (!opp_table->clks)
+		return ERR_PTR(-ENOMEM);
 
-	ret = PTR_ERR_OR_ZERO(opp_table->clk);
-	if (!ret)
+	/* Find clk for the device */
+	ret = clk_bulk_get(dev, 1, opp_table->clks);
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
 
@@ -1528,9 +1568,7 @@ static void _opp_table_kref_release(struct kref *kref)
 
 	_of_clear_opp_table(opp_table);
 
-	/* Release clk */
-	if (!IS_ERR(opp_table->clk))
-		clk_put(opp_table->clk);
+	_put_clocks(opp_table);
 
 	if (opp_table->paths) {
 		for (i = 0; i < opp_table->path_count; i++)
@@ -2263,9 +2301,50 @@ EXPORT_SYMBOL_GPL(devm_pm_opp_set_regulators);
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
+	int ret, i;
 
 	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
@@ -2278,70 +2357,83 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
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
+	opp_table->clks = kcalloc(count, sizeof(*opp_table->clks), GFP_KERNEL);
+	if (!opp_table->clks) {
+		ret = -ENOMEM;
 		goto err;
 	}
 
+	for (i = 0; i < count; i++)
+		opp_table->clks[i].id = names[i];
+
+	ret = clk_bulk_get(dev, count, opp_table->clks);
+	if (ret)
+		goto free_clks;
+
+	opp_table->clk_count = count;
+
 	return opp_table;
 
+free_clks:
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
@@ -2756,7 +2848,8 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
-	/* Fix regulator count for dynamic OPPs */
+	/* Fix regulator/clk count for dynamic OPPs */
+	opp_table->clk_count = 1;
 	opp_table->regulator_count = 1;
 
 	ret = _opp_add_v1(opp_table, dev, freq, u_volt, true);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 45e3a55239a1..59aac08baf82 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -149,7 +149,9 @@ enum opp_table_access {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
- * @clk: Device's clock handle
+ * @clks: Device clocks handles (clk bulk API).
+ * @clk_count: Number of clocks. Its value can be -1 (uninitialized), 0 (no
+ * clock handle provided)  or > 0 (has clock handles).
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators. Its value can be -1
  * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
@@ -200,7 +202,8 @@ struct opp_table {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
-	struct clk *clk;
+	struct clk_bulk_data *clks;
+	int clk_count;
 	struct regulator **regulators;
 	int regulator_count;
 	struct icc_path **paths;
diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index bd4771f388ab..ebb6531f39c4 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -281,12 +281,16 @@ static int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
 	struct dev_pm_opp_supply *new_supply_vbb = &data->new_opp.supplies[1];
 	struct device *dev = data->dev;
 	unsigned long old_freq = data->old_opp.rate, freq = data->new_opp.rate;
-	struct clk *clk = data->clk;
 	struct regulator *vdd_reg = data->regulators[0];
 	struct regulator *vbb_reg = data->regulators[1];
+	struct clk *clk;
 	int vdd_uv;
 	int ret;
 
+	if (WARN_ON_ONCE(!data->clk_count))
+		return -EINVAL;
+
+	clk = data->clks[0].clk;
 	vdd_uv = _get_optimal_vdd_voltage(dev, &opp_data,
 					  new_supply_vdd->u_volt);
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6708b4ec244d..5f17f10fcc3f 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -75,7 +75,8 @@ struct dev_pm_opp_info {
  * @new_opp:	New OPP info
  * @regulators:	Array of regulator pointers
  * @regulator_count: Number of regulators
- * @clk:	Pointer to clk
+ * @clks:	Device clocks handles (clk bulk API)
+ * @clk_count:	Number of clocks
  * @dev:	Pointer to the struct device
  *
  * This structure contains all information required for setting an OPP.
@@ -86,7 +87,8 @@ struct dev_pm_set_opp_data {
 
 	struct regulator **regulators;
 	unsigned int regulator_count;
-	struct clk *clk;
+	struct clk_bulk_data *clks;
+	unsigned int clk_count;
 	struct device *dev;
 };
 
@@ -165,6 +167,13 @@ int devm_pm_opp_set_regulators(struct device *dev, const char * const names[], u
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
@@ -405,6 +414,22 @@ static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
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

