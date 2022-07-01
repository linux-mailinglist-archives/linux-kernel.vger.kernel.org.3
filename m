Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3304562E62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiGAIfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiGAIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:35:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1073E70E50
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:35:05 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k14so1744492plh.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+2Ef2YvOVbBd7DXhKAJTt40bhH4p1+0X7KiKVGhn8xc=;
        b=Cutz2882kef7/XZceTtXwkbS9R9cGf3o2gsVG+D0XcqYOxJ+dENYkHfHgDd/PcCDhp
         yEgFCDrUS9fQpfBFPokIJTMo1d3hmnaoQPNg0wDMhXwAWhCL/KLrInCXPn0CA6DTqPTm
         MKhCgz1YqItbg0r+skhyWZbi+qrQGteGxK7RidsAAhWpK/fhrX1FjGuLg/JPFOZRekzv
         Z0JI6PirJtxV9yPHD8gVE1h3CRlBUJmw7OxeEWlL0geT7ra7D7+sqXOcTEhcohHQKogz
         EIIUAVTJRnk2eCWHMkjMCs0F3Ldf3QFWKbZKWmvUFnnydwdmVJA8Q3AbZ/PZ6KrtQLk4
         +mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+2Ef2YvOVbBd7DXhKAJTt40bhH4p1+0X7KiKVGhn8xc=;
        b=PZSf4fyq5kyaqv2yQnFM1H4PD1HrJDK0wfHgh48GjZ3bRw/597PpCYwfczGnaM0Z85
         bHkKRIfNHEKcoL/uwu88mxzPwZK0Yj4erK0MWy+cLgJBOcqTdhmG2oaIO+ktAt2t0z0w
         zrRlRqCsaaFC0b2N8gi49k1lHyLfeNMmtfHP7m169+XN07mCmZXTgyxHGeBGkZf+Yxm9
         ywCrtCk1qxtXvEIVKcvHrS/+co9/89a+opWHw51l7JbRH1XIc17ly1HwxMhH7nAmmNwz
         NWfUGzzffb3j8T+jDD5jYTMxE5rhu8MXD+21mzDNGwHdO4kg0Jn4pHLnNJPnSKAeGpw7
         d/zA==
X-Gm-Message-State: AJIora/cd37NiVfq7B0j7xgedrc7nfsZ2v//ps8WOOKeVqW3Hn4CubMT
        BxoGwZtVwUoNDORozK1rK4Gx+A==
X-Google-Smtp-Source: AGRyM1tzmld+DWdaIe+aRx3rzjz6qqUei+ry37MD8LCIVKSWpEKf4HajzoISjcGr1l3jfltAf1ab1A==
X-Received: by 2002:a17:902:a503:b0:167:93c0:c602 with SMTP id s3-20020a170902a50300b0016793c0c602mr19546883plq.39.1656664504530;
        Fri, 01 Jul 2022 01:35:04 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b0016bc2e752eesm283312plf.159.2022.07.01.01.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:35:04 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/5] OPP: Add support for config_regulators() helper
Date:   Fri,  1 Jul 2022 14:04:51 +0530
Message-Id: <fa947f08b5a7c10ed460f999f75f497ef1882a8d.1656664183.git.viresh.kumar@linaro.org>
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

Extend the dev_pm_opp_set_config() interface to allow adding
config_regulators() helpers. This helper will be called to set the
voltages of the regulators from the regular path in _set_opp(), while we
are trying to change the OPP.

This will eventually replace the custom set_opp() helper.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 68 +++++++++++++++++++++++++++++++++++++++++-
 drivers/opp/opp.h      |  2 ++
 include/linux/pm_opp.h |  6 ++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 75bb570d30e4..d5e1ae6f5ea1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1185,6 +1185,17 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 			dev_err(dev, "Failed to set bw: %d\n", ret);
 			return ret;
 		}
+
+		if (opp_table->config_regulators) {
+			ret = opp_table->config_regulators(dev, old_opp, opp,
+							   opp_table->regulators,
+							   opp_table->regulator_count);
+			if (ret) {
+				dev_err(dev, "Failed to set regulator voltages: %d\n",
+					ret);
+				return ret;
+			}
+		}
 	}
 
 	if (opp_table->set_opp) {
@@ -1202,6 +1213,17 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 
 	/* Scaling down? Configure required OPPs after frequency */
 	if (scaling_down) {
+		if (opp_table->config_regulators) {
+			ret = opp_table->config_regulators(dev, old_opp, opp,
+							   opp_table->regulators,
+							   opp_table->regulator_count);
+			if (ret) {
+				dev_err(dev, "Failed to set regulator voltages: %d\n",
+					ret);
+				return ret;
+			}
+		}
+
 		ret = _set_opp_bw(opp_table, opp, dev);
 		if (ret) {
 			dev_err(dev, "Failed to set bw: %d\n", ret);
@@ -2246,6 +2268,38 @@ static void _opp_unregister_set_opp_helper(struct opp_table *opp_table)
 	}
 }
 
+/**
+ * _opp_set_config_regulators_helper() - Register custom set regulator helper.
+ * @dev: Device for which the helper is getting registered.
+ * @config_regulators: Custom set regulator helper.
+ *
+ * This is useful to support platforms with multiple regulators per device.
+ *
+ * This must be called before any OPPs are initialized for the device.
+ */
+static int _opp_set_config_regulators_helper(struct opp_table *opp_table,
+		struct device *dev, config_regulators_t config_regulators)
+{
+	/* Another CPU that shares the OPP table has set the helper ? */
+	if (!opp_table->config_regulators)
+		opp_table->config_regulators = config_regulators;
+
+	return 0;
+}
+
+/**
+ * _opp_put_config_regulators_helper() - Releases resources blocked for
+ *					 config_regulators helper.
+ * @opp_table: OPP table returned from _opp_set_config_regulators_helper().
+ *
+ * Release resources blocked for platform specific config_regulators helper.
+ */
+static void _opp_put_config_regulators_helper(struct opp_table *opp_table)
+{
+	if (opp_table->config_regulators)
+		opp_table->config_regulators = NULL;
+}
+
 static void _detach_genpd(struct opp_table *opp_table)
 {
 	int index;
@@ -2372,8 +2426,10 @@ static void _opp_clear_config(struct opp_config_data *data)
 		_opp_put_regulators(data->opp_table);
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
 		_opp_put_supported_hw(data->opp_table);
-	if (data->flags & OPP_CONFIG_REGULATOR_HELPER)
+	if (data->flags & OPP_CONFIG_REGULATOR_HELPER) {
+		_opp_put_config_regulators_helper(data->opp_table);
 		_opp_unregister_set_opp_helper(data->opp_table);
+	}
 	if (data->flags & OPP_CONFIG_PROP_NAME)
 		_opp_put_prop_name(data->opp_table);
 	if (data->flags & OPP_CONFIG_CLK)
@@ -2455,6 +2511,16 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 		data->flags |= OPP_CONFIG_REGULATOR_HELPER;
 	}
 
+	/* Configure config_regulators helper */
+	if (config->config_regulators) {
+		ret = _opp_set_config_regulators_helper(opp_table, dev,
+						config->config_regulators);
+		if (ret)
+			goto err;
+
+		data->flags |= OPP_CONFIG_REGULATOR_HELPER;
+	}
+
 	/* Configure supported hardware */
 	if (config->supported_hw) {
 		ret = _opp_set_supported_hw(opp_table, config->supported_hw,
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index d652f0cc84f1..45fd40737159 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -172,6 +172,7 @@ enum opp_table_access {
  * @prop_name: A name to postfix to many DT properties, while parsing them.
  * @clk_configured: Clock name is configured by the platform.
  * @clk: Device's clock handle
+ * @config_regulators: Platform specific config_regulators() callback.
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators. Its value can be -1
  * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
@@ -224,6 +225,7 @@ struct opp_table {
 	const char *prop_name;
 	bool clk_configured;
 	struct clk *clk;
+	config_regulators_t config_regulators;
 	struct regulator **regulators;
 	int regulator_count;
 	struct icc_path **paths;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 26653be21dc0..721aa02bcaaf 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -90,12 +90,17 @@ struct dev_pm_set_opp_data {
 	struct device *dev;
 };
 
+typedef int (*config_regulators_t)(struct device *dev,
+			struct dev_pm_opp *old_opp, struct dev_pm_opp *new_opp,
+			struct regulator **regulators, unsigned int count);
+
 /**
  * struct dev_pm_opp_config - Device OPP configuration values
  * @clk_names: Clk name.
  * @clk_count: Number of clocks, max 1 for now.
  * @prop_name: Name to postfix to properties.
  * @set_opp: Custom set OPP helper.
+ * @config_regulators: Custom set regulator helper.
  * @supported_hw: Array of hierarchy of versions to match.
  * @supported_hw_count: Number of elements in the array.
  * @regulator_names: Array of pointers to the names of the regulator.
@@ -111,6 +116,7 @@ struct dev_pm_opp_config {
 	unsigned int clk_count;
 	const char *prop_name;
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
+	config_regulators_t config_regulators;
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char * const *regulator_names;
-- 
2.31.1.272.g89b43f80a514

