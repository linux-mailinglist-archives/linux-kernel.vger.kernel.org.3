Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F79056548F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiGDMKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiGDMJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:09:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6C0120A2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:09:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso918592pjk.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCXeMMqXv2ueskwr9AiX3zDSgl5Tmazujbdu2hn28cI=;
        b=B+l9aaVyvBZnrM9C9jn6t6+Xa3Gq5L62J6XNlXqVyPZshh7SYbeaVOpFsaYbxUnJKs
         1FvyXvkj+TeaGSgLeu1VB/xYGWor4OKdGmqBlCH2vMnr4cXmBljHeZ3C/njOmMHqlNkA
         4+uYjavLNkQMFvyBTDs8jDP3yscbFADJDelNDXFVCBVL/jPXogZdfIcl83KpVwx43sY0
         61/JmCXpe6Io3OMoijI65ZDrbVcNTahSK938BtxrQHD+g/4w0mNTvNeOUpq05bkpQhB+
         hILq0U0ZpW7Hr+evVtsggnlbDR4zBZ86SrolWfUK90SOk6JCtA35z12G/wS9b7mDMDLF
         w+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCXeMMqXv2ueskwr9AiX3zDSgl5Tmazujbdu2hn28cI=;
        b=3X3KMwryaigIVGJ7SE0VLtkw0NCtXdk2YRwIO0THHk4dCJq0EhPyUz4/YCtz6f2mav
         kUzfWr4UcyHe4GC5ZGQVzIhTUSKIFM6c43SPmIe4VFAM2PfFozEUZRYCaqc8i4y1Z2T0
         MPLmREx4D7TAFvc4LTnzZwRhCrgd4fSo02oX+IQMzSqCaWrnh4/vK9a63TgXl25EvQ/c
         DEbr8PNUFu5bwEzXQD/nSqOmyo4kPIYe2WZjo1OXC038kYUbqaJRl8ihMCqVEAWSuQ16
         uocAwwrSfa60o7HqykrDc4h9e5sV+msNqbSV09jB5Cvve08NpLt0JzktqrfZAeFu0okz
         XjYg==
X-Gm-Message-State: AJIora8CUZgB+MPg8T4q/8ta/04+4mJz8ezoARNwLTzxsqdxg+LLxjhm
        n7ez7oWya59AuOOqATaH51hVPw==
X-Google-Smtp-Source: AGRyM1v5EESwQRbGNtRH4Q4jVClkROes1qYVWShiDigZ+gU8Gck/CycG/K54DvsEYjsuOqlgTkm44A==
X-Received: by 2002:a17:902:c40c:b0:16a:1a72:56c8 with SMTP id k12-20020a170902c40c00b0016a1a7256c8mr35413578plk.107.1656936548425;
        Mon, 04 Jul 2022 05:09:08 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id l124-20020a622582000000b00518285976cdsm20998717pfl.9.2022.07.04.05.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:09:08 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 20/20] OPP: Remove custom OPP helper support
Date:   Mon,  4 Jul 2022 17:37:58 +0530
Message-Id: <20faa4894af53aa1a5dd8371236a978e3965862e.1656935522.git.viresh.kumar@linaro.org>
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

The only user of the custom helper is migrated to use
dev_pm_opp_set_config_regulators() interface. Remove the now unused
custom OPP helper support.

This cleans up _set_opp() and leaves a single code path to be used by
all users.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 132 +----------------------------------------
 drivers/opp/opp.h      |   7 ---
 include/linux/pm_opp.h |  51 ----------------
 3 files changed, 2 insertions(+), 188 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3a794bff2ba1..e74bdc134c5a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -979,36 +979,6 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_opp_custom(const struct opp_table *opp_table,
-			   struct device *dev, struct dev_pm_opp *opp,
-			   unsigned long freq)
-{
-	struct dev_pm_set_opp_data *data = opp_table->set_opp_data;
-	struct dev_pm_opp *old_opp = opp_table->current_opp;
-	int size;
-
-	/*
-	 * We support this only if dev_pm_opp_set_config() was called
-	 * earlier to set regulators.
-	 */
-	if (opp_table->sod_supplies) {
-		size = sizeof(*old_opp->supplies) * opp_table->regulator_count;
-		memcpy(data->old_opp.supplies, old_opp->supplies, size);
-		memcpy(data->new_opp.supplies, opp->supplies, size);
-		data->regulator_count = opp_table->regulator_count;
-	} else {
-		data->regulator_count = 0;
-	}
-
-	data->regulators = opp_table->regulators;
-	data->clk = opp_table->clk;
-	data->dev = dev;
-	data->old_opp.rate = old_opp->rate;
-	data->new_opp.rate = freq;
-
-	return opp_table->set_opp(data);
-}
-
 static int _set_required_opp(struct device *dev, struct device *pd_dev,
 			     struct dev_pm_opp *opp, int i)
 {
@@ -1195,13 +1165,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		}
 	}
 
-	if (opp_table->set_opp) {
-		ret = _set_opp_custom(opp_table, dev, opp, freq);
-	} else {
-		/* Only frequency scaling */
-		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
-	}
-
+	ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
 	if (ret)
 		return ret;
 
@@ -2065,7 +2029,6 @@ static void _opp_put_prop_name(struct opp_table *opp_table)
 static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
 			       const char * const names[])
 {
-	struct dev_pm_opp_supply *supplies;
 	const char * const *temp = names;
 	struct regulator *reg;
 	int count = 0, ret, i;
@@ -2101,20 +2064,6 @@ static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
 
 	opp_table->regulator_count = count;
 
-	supplies = kmalloc_array(count * 2, sizeof(*supplies), GFP_KERNEL);
-	if (!supplies) {
-		ret = -ENOMEM;
-		goto free_regulators;
-	}
-
-	mutex_lock(&opp_table->lock);
-	opp_table->sod_supplies = supplies;
-	if (opp_table->set_opp_data) {
-		opp_table->set_opp_data->old_opp.supplies = supplies;
-		opp_table->set_opp_data->new_opp.supplies = supplies + count;
-	}
-	mutex_unlock(&opp_table->lock);
-
 	/* Set generic config_regulators() for single regulators here */
 	if (count == 1)
 		opp_table->config_regulators = _opp_config_regulator_single;
@@ -2151,16 +2100,6 @@ static void _opp_put_regulators(struct opp_table *opp_table)
 	for (i = opp_table->regulator_count - 1; i >= 0; i--)
 		regulator_put(opp_table->regulators[i]);
 
-	mutex_lock(&opp_table->lock);
-	if (opp_table->set_opp_data) {
-		opp_table->set_opp_data->old_opp.supplies = NULL;
-		opp_table->set_opp_data->new_opp.supplies = NULL;
-	}
-
-	kfree(opp_table->sod_supplies);
-	opp_table->sod_supplies = NULL;
-	mutex_unlock(&opp_table->lock);
-
 	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
 	opp_table->regulator_count = -1;
@@ -2233,61 +2172,6 @@ static void _opp_put_clknames(struct opp_table *opp_table)
 	}
 }
 
-/**
- * _opp_register_set_opp_helper() - Register custom set OPP helper
- * @dev: Device for which the helper is getting registered.
- * @set_opp: Custom set OPP helper.
- *
- * This is useful to support complex platforms (like platforms with multiple
- * regulators per device), instead of the generic OPP set rate helper.
- *
- * This must be called before any OPPs are initialized for the device.
- */
-static int _opp_register_set_opp_helper(struct opp_table *opp_table,
-	struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data))
-{
-	struct dev_pm_set_opp_data *data;
-
-	/* Another CPU that shares the OPP table has set the helper ? */
-	if (opp_table->set_opp)
-		return 0;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	mutex_lock(&opp_table->lock);
-	opp_table->set_opp_data = data;
-	if (opp_table->sod_supplies) {
-		data->old_opp.supplies = opp_table->sod_supplies;
-		data->new_opp.supplies = opp_table->sod_supplies +
-					 opp_table->regulator_count;
-	}
-	mutex_unlock(&opp_table->lock);
-
-	opp_table->set_opp = set_opp;
-
-	return 0;
-}
-
-/**
- * _opp_unregister_set_opp_helper() - Releases resources blocked for set_opp helper
- * @opp_table: OPP table returned from _opp_register_set_opp_helper().
- *
- * Release resources blocked for platform specific set_opp helper.
- */
-static void _opp_unregister_set_opp_helper(struct opp_table *opp_table)
-{
-	if (opp_table->set_opp) {
-		opp_table->set_opp = NULL;
-
-		mutex_lock(&opp_table->lock);
-		kfree(opp_table->set_opp_data);
-		opp_table->set_opp_data = NULL;
-		mutex_unlock(&opp_table->lock);
-	}
-}
-
 /**
  * _opp_set_config_regulators_helper() - Register custom set regulator helper.
  * @dev: Device for which the helper is getting registered.
@@ -2446,10 +2330,8 @@ static void _opp_clear_config(struct opp_config_data *data)
 		_opp_put_regulators(data->opp_table);
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
 		_opp_put_supported_hw(data->opp_table);
-	if (data->flags & OPP_CONFIG_REGULATOR_HELPER) {
+	if (data->flags & OPP_CONFIG_REGULATOR_HELPER)
 		_opp_put_config_regulators_helper(data->opp_table);
-		_opp_unregister_set_opp_helper(data->opp_table);
-	}
 	if (data->flags & OPP_CONFIG_PROP_NAME)
 		_opp_put_prop_name(data->opp_table);
 	if (data->flags & OPP_CONFIG_CLK)
@@ -2520,16 +2402,6 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 		data->flags |= OPP_CONFIG_PROP_NAME;
 	}
 
-	/* Configure opp helper */
-	if (config->set_opp) {
-		ret = _opp_register_set_opp_helper(opp_table, dev,
-						   config->set_opp);
-		if (ret)
-			goto err;
-
-		data->flags |= OPP_CONFIG_REGULATOR_HELPER;
-	}
-
 	/* Configure config_regulators helper */
 	if (config->config_regulators) {
 		ret = _opp_set_config_regulators_helper(opp_table, dev,
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 45fd40737159..13abe991e811 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -182,9 +182,6 @@ enum opp_table_access {
  * @enabled: Set to true if the device's resources are enabled/configured.
  * @genpd_performance_state: Device's power domain support performance state.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
- * @set_opp: Platform specific set_opp callback
- * @sod_supplies: Set opp data supplies
- * @set_opp_data: Data to be passed to set_opp callback
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -234,10 +231,6 @@ struct opp_table {
 	bool genpd_performance_state;
 	bool is_genpd;
 
-	int (*set_opp)(struct dev_pm_set_opp_data *data);
-	struct dev_pm_opp_supply *sod_supplies;
-	struct dev_pm_set_opp_data *set_opp_data;
-
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	char dentry_name[NAME_MAX];
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 1e2b33d79ba6..9d59aedc2be3 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -57,39 +57,6 @@ struct dev_pm_opp_icc_bw {
 	u32 peak;
 };
 
-/**
- * struct dev_pm_opp_info - OPP freq/voltage/current values
- * @rate:	Target clk rate in hz
- * @supplies:	Array of voltage/current values for all power supplies
- *
- * This structure stores the freq/voltage/current values for a single OPP.
- */
-struct dev_pm_opp_info {
-	unsigned long rate;
-	struct dev_pm_opp_supply *supplies;
-};
-
-/**
- * struct dev_pm_set_opp_data - Set OPP data
- * @old_opp:	Old OPP info
- * @new_opp:	New OPP info
- * @regulators:	Array of regulator pointers
- * @regulator_count: Number of regulators
- * @clk:	Pointer to clk
- * @dev:	Pointer to the struct device
- *
- * This structure contains all information required for setting an OPP.
- */
-struct dev_pm_set_opp_data {
-	struct dev_pm_opp_info old_opp;
-	struct dev_pm_opp_info new_opp;
-
-	struct regulator **regulators;
-	unsigned int regulator_count;
-	struct clk *clk;
-	struct device *dev;
-};
-
 typedef int (*config_regulators_t)(struct device *dev,
 			struct dev_pm_opp *old_opp, struct dev_pm_opp *new_opp,
 			struct regulator **regulators, unsigned int count);
@@ -98,7 +65,6 @@ typedef int (*config_regulators_t)(struct device *dev,
  * struct dev_pm_opp_config - Device OPP configuration values
  * @clk_names: Clk names, NULL terminated array, max 1 clock for now.
  * @prop_name: Name to postfix to properties.
- * @set_opp: Custom set OPP helper.
  * @config_regulators: Custom set regulator helper.
  * @supported_hw: Array of hierarchy of versions to match.
  * @supported_hw_count: Number of elements in the array.
@@ -113,7 +79,6 @@ struct dev_pm_opp_config {
 	/* NULL terminated */
 	const char * const *clk_names;
 	const char *prop_name;
-	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	config_regulators_t config_regulators;
 	const unsigned int *supported_hw;
 	unsigned int supported_hw_count;
@@ -610,22 +575,6 @@ static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
 	return devm_pm_opp_set_config(dev, &config);
 }
 
-/* set-opp helpers */
-static inline int dev_pm_opp_register_set_opp_helper(struct device *dev,
-			int (*set_opp)(struct dev_pm_set_opp_data *data))
-{
-	struct dev_pm_opp_config config = {
-		.set_opp = set_opp,
-	};
-
-	return dev_pm_opp_set_config(dev, &config);
-}
-
-static inline void dev_pm_opp_unregister_set_opp_helper(int token)
-{
-	dev_pm_opp_clear_config(token);
-}
-
 /* config-regulators helpers */
 static inline int dev_pm_opp_set_config_regulators(struct device *dev,
 						   config_regulators_t helper)
-- 
2.31.1.272.g89b43f80a514

