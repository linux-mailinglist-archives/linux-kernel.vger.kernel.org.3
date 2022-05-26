Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87362534E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347209AbiEZLnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345494AbiEZLne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:43:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD853C49B
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so1513333pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1SfGsAuCxadA/cDC19UzEIDjU/68K6RkhJ0RF22ULOY=;
        b=rbW8fueifXqw0HCB+T7bIwUUKmpncq69A58HME38ewGvneWCpXJINF4+3pXYVi8mMM
         sVjvpsnKL8B23XO0vR5r+vB/VRmko0NE3b7abTHcx8WZyxSjcAolF9m6yj7YTV+65/EJ
         5XRPWkKGnqHsqsxiD6dlwTxOts9w4eQRw6Nj+Us2sqrS4qaEoI9RFbTH9SLJjn6CQZNW
         OqTy6sS/4TOKv7bflxJ88Arg2ZGp+7zM+aAq0ue4ZEOOLSyyZFUzGlx7raDbM674t6K6
         DX0Krs505gxOK2/J07VN290ttpSt9gpjauYiO67qlTmTNsOdV6VdX+R9IQAVO3xSxcQs
         iEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SfGsAuCxadA/cDC19UzEIDjU/68K6RkhJ0RF22ULOY=;
        b=I9DedfTDdd6gYGljAMbpwZ+nIQYdr/kt4GMC2Ji3aj/27jeBK70gXKG130KcstHYtQ
         TFUX9rUdZMOqANi0p7zr9flGrjnaAT/wlIau81Soh3NkwVyOhsMISDo2MRrIfUVP78Xu
         CYkc1/fBZ3HVYv8jAqWEktWo1NR4sDRYJKfV3mpth63BqAzCsanw0bm1q34pLFiJvftc
         yLkpTE0z+aue1XYj9MLGCdRWR3V/edCyULQks8EPDvWNSCDt0mp6HHjmsuwmMsSPQecL
         PciGHGEa80UPVrW4rRQ0Q1u8a8iEQASIIytMFTApGXtIdtWfscvlNWgFQjaIoZ+IU+3U
         P7Jg==
X-Gm-Message-State: AOAM530yF9Lz9oJaxi14za/Zk+bJ++C126S41xxmEAAAb6hPmMIEedqw
        arCoVgAKAvpVQ++2jnbHcc/a5HQnhAjYdA==
X-Google-Smtp-Source: ABdhPJxy73Mag2moVhV6qx9boSqgvGT2G39KdgDtMteyXS2f66J7ZIFaU4ZWdVxmUBwORsIoXOOHKg==
X-Received: by 2002:a17:902:e804:b0:161:969c:ab59 with SMTP id u4-20020a170902e80400b00161969cab59mr39025208plg.142.1653565411326;
        Thu, 26 May 2022 04:43:31 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902789400b0015eaa9aee50sm1271235pll.202.2022.05.26.04.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:43:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/31] OPP: Add dev_pm_opp_set_config() and friends
Date:   Thu, 26 May 2022 17:12:01 +0530
Message-Id: <9c4b2bfe628bf7a583a96cee7cc3539e2e66245e.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
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

The OPP core already have few configuration specific APIs and it is
getting complex or messy for both the OPP core and its users.

Lets introduce a new set of API which will be used for all kind of
different configurations, and shall eventually replace all the existing
ones.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 145 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  42 ++++++++++++
 2 files changed, 187 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 254782b3a6a0..30dbef0f4d17 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2618,6 +2618,151 @@ int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names,
 }
 EXPORT_SYMBOL_GPL(devm_pm_opp_attach_genpd);
 
+/**
+ * dev_pm_opp_set_config() - Set OPP configuration for the device.
+ * @dev: Device for which configuration is being set.
+ * @config: OPP configuration.
+ *
+ * This allows all device OPP configurations to be performed at once.
+ *
+ * This must be called before any OPPs are initialized for the device. This may
+ * be called multiple times for the same OPP table, for example once for each
+ * CPU that share the same table. This must be balanced by the same number of
+ * calls to dev_pm_opp_clear_config() in order to free the OPP table properly.
+ */
+struct opp_table *dev_pm_opp_set_config(struct device *dev,
+					struct dev_pm_opp_config *config)
+{
+	struct opp_table *opp_table, *ret;
+
+	opp_table = _add_opp_table(dev, false);
+	if (IS_ERR(opp_table))
+		return opp_table;
+
+	/* This should be called before OPPs are initialized */
+	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
+		ret = ERR_PTR(-EBUSY);
+		goto err;
+	}
+
+	// Configure clock
+	if (config->clk_name) {
+		ret = dev_pm_opp_set_clkname(dev, config->clk_name);
+		if (IS_ERR(ret))
+			goto err;
+	}
+
+	// Configure property names
+	if (config->prop_name) {
+		ret = dev_pm_opp_set_prop_name(dev, config->prop_name);
+		if (IS_ERR(ret))
+			goto err;
+	}
+
+	// Configure opp helper
+	if (config->set_opp) {
+		ret = dev_pm_opp_register_set_opp_helper(dev, config->set_opp);
+		if (IS_ERR(ret))
+			goto err;
+	}
+
+	// Configure supported hardware
+	if (config->supported_hw) {
+		ret = dev_pm_opp_set_supported_hw(dev, config->supported_hw,
+						  config->supported_hw_count);
+		if (IS_ERR(ret))
+			goto err;
+	}
+
+	// Configure supplies
+	if (config->regulator_names) {
+		ret = dev_pm_opp_set_regulators(dev, config->regulator_names,
+						config->regulator_count);
+		if (IS_ERR(ret))
+			goto err;
+	}
+
+	// Attach genpds
+	if (config->genpd_names) {
+		ret = dev_pm_opp_attach_genpd(dev, config->genpd_names,
+					      config->virt_devs);
+		if (IS_ERR(ret))
+			goto err;
+	}
+
+	return opp_table;
+
+err:
+	dev_pm_opp_clear_config(opp_table);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
+
+/**
+ * dev_pm_opp_clear_config() - Releases resources blocked for OPP configuration.
+ * @opp_table: OPP table returned from dev_pm_opp_set_config().
+ *
+ * This allows all device OPP configurations to be cleared at once. This must be
+ * called once for each call made to dev_pm_opp_set_config(), in order to free
+ * the OPPs properly.
+ *
+ * Currently the first call itself ends up freeing all the OPP configurations,
+ * while the later ones only drop the OPP table reference. This works well for
+ * now as we would never want to use an half initialized OPP table and want to
+ * remove the configurations together.
+ */
+void dev_pm_opp_clear_config(struct opp_table *opp_table)
+{
+	if (opp_table->genpd_virt_devs)
+		dev_pm_opp_detach_genpd(opp_table);
+
+	if (opp_table->regulators)
+		dev_pm_opp_put_regulators(opp_table);
+
+	if (opp_table->supported_hw)
+		dev_pm_opp_put_supported_hw(opp_table);
+
+	if (opp_table->set_opp)
+		dev_pm_opp_unregister_set_opp_helper(opp_table);
+
+	if (opp_table->prop_name)
+		dev_pm_opp_put_prop_name(opp_table);
+
+	if (opp_table->clk_configured)
+		dev_pm_opp_put_clkname(opp_table);
+
+	dev_pm_opp_put_opp_table(opp_table);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_clear_config);
+
+static void devm_pm_opp_config_release(void *data)
+{
+	dev_pm_opp_clear_config(data);
+}
+
+/**
+ * devm_pm_opp_set_config() - Set OPP configuration for the device.
+ * @dev: Device for which configuration is being set.
+ * @config: OPP configuration.
+ *
+ * This allows all device OPP configurations to be performed at once.
+ * This is a resource-managed variant of dev_pm_opp_set_config().
+ *
+ * Return: 0 on success and errorno otherwise.
+ */
+int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
+{
+	struct opp_table *opp_table;
+
+	opp_table = dev_pm_opp_set_config(dev, config);
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
+
+	return devm_add_action_or_reset(dev, devm_pm_opp_config_release,
+					opp_table);
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_set_config);
+
 /**
  * dev_pm_opp_xlate_required_opp() - Find required OPP for @src_table OPP.
  * @src_table: OPP table which has @dst_table as one of its required OPP table.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6708b4ec244d..0d5d07dd164a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -90,6 +90,32 @@ struct dev_pm_set_opp_data {
 	struct device *dev;
 };
 
+/**
+ * struct dev_pm_opp_config - Device OPP configuration values
+ * @clk_name: Clk name.
+ * @prop_name: Name to postfix to properties.
+ * @set_opp: Custom set OPP helper.
+ * @supported_hw: Array of hierarchy of versions to match.
+ * @supported_hw_count: Number of elements in the array.
+ * @regulator_names: Array of pointers to the names of the regulator.
+ * @regulator_count: Number of regulators.
+ * @genpd_names: Null terminated array of pointers containing names of genpd to attach.
+ * @virt_devs: Pointer to return the array of virtual devices.
+ *
+ * This structure contains platform specific OPP configurations for the device.
+ */
+struct dev_pm_opp_config {
+	const char *clk_name;
+	const char *prop_name;
+	int (*set_opp)(struct dev_pm_set_opp_data *data);
+	unsigned int *supported_hw;
+	unsigned int supported_hw_count;
+	const char * const *regulator_names;
+	unsigned int regulator_count;
+	const char * const *genpd_names;
+	struct device ***virt_devs;
+};
+
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
@@ -154,6 +180,10 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
 
+struct opp_table *dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
+int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
+void dev_pm_opp_clear_config(struct opp_table *opp_table);
+
 struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
 int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
@@ -419,6 +449,18 @@ static inline int devm_pm_opp_attach_genpd(struct device *dev,
 	return -EOPNOTSUPP;
 }
 
+static inline struct opp_table *dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void dev_pm_opp_clear_config(struct opp_table *opp_table) {}
+
 static inline struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
 				struct opp_table *dst_table, struct dev_pm_opp *src_opp)
 {
-- 
2.31.1.272.g89b43f80a514

