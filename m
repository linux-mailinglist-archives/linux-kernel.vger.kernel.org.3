Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF134562E6E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiGAIfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiGAIfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:35:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3104F7126C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:35:16 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v126so1771527pgv.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bbGaxrRF9z3JzTpjw2cMWBIlZoYiw5+dq8IseSMnzvE=;
        b=egz3392MrBcS9XCUFKQppWh4bpC9pjna6ebMSdmLTG+1FhbZT2bYZBh5oXx2fK7+G/
         V2+x1mj+M9zfOGWQLQoLqPuWkxIiiMoZVoBtF+0rRl0hOFF3SwkoSO2GcFTGz5JRfRFp
         L3cmSHlKVgEj2BPv9qFDSQvDgap2gi8Acg4aislMyhPiL4VfYSmoTYTQtMMOSNsxErH1
         fXW3qz+dinMPddg9KO9rJu9f0JtQIgq/qmUn8e/X4TkV3r0cwIg2JBNVbYtuDC13frYz
         Pp/Hpj9AS68ksdPaXabZmdv4nZfs4Gy1xC9EjdejplJ2q4aQ/z4ANSmp5ZROi5ohuCRd
         05dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bbGaxrRF9z3JzTpjw2cMWBIlZoYiw5+dq8IseSMnzvE=;
        b=giGo6ZhNP6IUS+025QUMH23FcztSZgsukmbj1TRzR1t9/itkh3LEW73gCCnrpv0Dtg
         +f2ceZHrovEMAN+Z5n5QGc7KvQs7DdvttMRRscJxwWJco3CGVL7HJwyRvuZCvOsIcxp+
         Ou2LJ5QSaCarOUzLDsbzEvPOJnGtqjp9R1zEMbNiw53D2dHExXABi4Eo5oqo+9IgOhxS
         SK2OhEUpZlcjDUFy0umasPeTZrxRyhdQHUoFjq9zZL9QpcAIdJVkWNuYKOnhINEDevHE
         hF6cYX/jOvolNjK3mUtjYNBpH79YZB3zgu0ZlZx7GL4A4CLfMpFaaodILYxsk5nLyQ9S
         UQEQ==
X-Gm-Message-State: AJIora9YMEl7Vj/H0lP/EQ/06vT++EMo/t6JcD1UiOH8WdBGOwB4DM2l
        mjhr1tx9M7DMh5mr8SZ93hw6UQ==
X-Google-Smtp-Source: AGRyM1uJdfJJ02T/o5Ayf6i77jpCMazt3aujpCIl7UXPDwv/QnXbcV8QdAOBgzMhEhyqPSBevsq1uw==
X-Received: by 2002:a63:6c81:0:b0:3fd:4be3:8ee9 with SMTP id h123-20020a636c81000000b003fd4be38ee9mr11045731pgc.188.1656664515626;
        Fri, 01 Jul 2022 01:35:15 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id jf17-20020a17090b175100b001ec86a0490csm5769560pjb.32.2022.07.01.01.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:35:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/5] OPP: Remove custom OPP helper support
Date:   Fri,  1 Jul 2022 14:04:55 +0530
Message-Id: <370493d46e406c1d52541f0060edff8f9f116b85.1656664183.git.viresh.kumar@linaro.org>
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

The only user of the custom helper is migrated to use
config_regulators() interface. Remove the now unused custom OPP helper
support.

This cleans up _set_opp() and leaves a single code path to be used by
all users.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 132 +----------------------------------------
 drivers/opp/opp.h      |   7 ---
 include/linux/pm_opp.h |  35 -----------
 3 files changed, 2 insertions(+), 172 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ee842a3d27a6..024a9106b6d2 100644
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
 			       const char * const names[], unsigned int count)
 {
-	struct dev_pm_opp_supply *supplies;
 	struct regulator *reg;
 	int ret, i;
 
@@ -2093,20 +2056,6 @@ static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
 
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
@@ -2143,16 +2092,6 @@ static void _opp_put_regulators(struct opp_table *opp_table)
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
@@ -2211,61 +2150,6 @@ static void _opp_put_clknames(struct opp_table *opp_table)
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
@@ -2424,10 +2308,8 @@ static void _opp_clear_config(struct opp_config_data *data)
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
@@ -2499,16 +2381,6 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
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
index 4c1cce06a61c..25a1e15cb7fe 100644
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
@@ -99,7 +66,6 @@ typedef int (*config_regulators_t)(struct device *dev,
  * @clk_names: Clk name.
  * @clk_count: Number of clocks, max 1 for now.
  * @prop_name: Name to postfix to properties.
- * @set_opp: Custom set OPP helper.
  * @config_regulators: Custom set regulator helper.
  * @supported_hw: Array of hierarchy of versions to match.
  * @supported_hw_count: Number of elements in the array.
@@ -115,7 +81,6 @@ struct dev_pm_opp_config {
 	const char * const *clk_names;
 	unsigned int clk_count;
 	const char *prop_name;
-	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	config_regulators_t config_regulators;
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
-- 
2.31.1.272.g89b43f80a514

