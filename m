Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540EC562E6A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiGAIfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiGAIfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:35:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F2671255
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:35:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id jh14so1759493plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gf1z1i4Q1Q3vJR21rVGny9xQ3EfEJ5IGT6qjZgIHsA4=;
        b=IXDx8gCse9Dbez57gdpSuPhRjJlqmAZI+GdQmH1KAmICiEVRSI/O5+Nq/kTU02U7hs
         LBIYe71Gh0gNX8obI/NLPCQhq3SychtbXt/MFQWM0O+Y6Mycfh6fb8Qz7p5HKJceFDo2
         e8pZkr6GbKrNAE1WlImQhlmZ3qNuZ6F9rLjvItxpnhddyMPBWgZdL9s1822xMoF9nB4j
         ZZh9KaOBqrXBAZRjsMU7VHtyrAU2P5k9I/Ayz+zcje4Wjqtlw9pR7w650AUq2GdfbyBg
         VJNSADYhtqHpGbaX+nshdY/u1T51eM5OJEExmERQNYqDEUEl5qxBNOr6FavomcVWRY3/
         Yk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gf1z1i4Q1Q3vJR21rVGny9xQ3EfEJ5IGT6qjZgIHsA4=;
        b=Nc6mN26rLIuAGX9VxW6YM1Y0dfLKkeJwcHxhzjtB/5Q7u9PqJLHGPuwfNlBGBYIetV
         sOd/tizvZ3d8MV9xgfR4CqUs98sZx0ZcQ3AosBvuMhrE/OPI2eZq9jp4CPXXNs0grey/
         rB/z9Bd5a2qD6QtPueW0A7BmmvMwVj7rvUYjEGcH/g7xUQT6y7EvZ8l0mGnawIztQuEh
         FRePGFL5RYToSGIe5+nBiviqZCR2g/nEweMsmekyWTa2a3k7IXHZi0bNcB0lOZ9YgZ2N
         GHKXg1VxYGXSJzpsiPAyTgyyFNzGG/zNHFaj6UfXDPhibX8StBOaIHE0CpDsqIjKx54w
         jgdQ==
X-Gm-Message-State: AJIora/8WwXZVD72XybvVYqcvUElj/eEBEDwwPQHMEAuHw+vczd81aT8
        VsMjV7yYHuIVtnOeaQFsSgKUlQ==
X-Google-Smtp-Source: AGRyM1sVTkXdZm2N3xY+g4CzUVsxzz+8bjiH/v9tie3OzOBVHFHidbrtl6ZvsivohEm7kEn3+KaYJw==
X-Received: by 2002:a17:90a:6809:b0:1ec:c213:56c8 with SMTP id p9-20020a17090a680900b001ecc21356c8mr16973975pjj.82.1656664509946;
        Fri, 01 Jul 2022 01:35:09 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id y41-20020a056a001ca900b00518d06efbc8sm15129130pfw.98.2022.07.01.01.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:35:09 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/5] OPP: Add dev_pm_opp_get_supplies()
Date:   Fri,  1 Jul 2022 14:04:53 +0530
Message-Id: <a8bb169bad4498e4876e3c19e90b25ae23fa2e13.1656664183.git.viresh.kumar@linaro.org>
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

We already have an API for getting voltage information for a single
regulator, dev_pm_opp_get_voltage(), but there is nothing available for
multiple regulator case.

This patch adds a new API, dev_pm_opp_get_supplies(), to get all
information related to the supplies for an OPP.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 25 +++++++++++++++++++++++++
 include/linux/pm_opp.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index df0135f2cfec..ee842a3d27a6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -117,6 +117,31 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
 
+/**
+ * dev_pm_opp_get_supplies() - Gets the supply information corresponding to an opp
+ * @opp:	opp for which voltage has to be returned for
+ * @supplies:	Placeholder for copying the supply information.
+ *
+ * Return: negative error number on failure, 0 otherwise on success after
+ * setting @supplies.
+ *
+ * This can be used for devices with any number of power supplies. The caller
+ * must ensure the @supplies array must contain space for each regulator.
+ */
+int dev_pm_opp_get_supplies(struct dev_pm_opp *opp,
+			    struct dev_pm_opp_supply *supplies)
+{
+	if (IS_ERR_OR_NULL(opp) || !supplies) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return -EINVAL;
+	}
+
+	memcpy(supplies, opp->supplies,
+	       sizeof(*supplies) * opp->opp_table->regulator_count);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_supplies);
+
 /**
  * dev_pm_opp_get_power() - Gets the power corresponding to an opp
  * @opp:	opp for which power has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 721aa02bcaaf..4c1cce06a61c 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -132,6 +132,8 @@ void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
+int dev_pm_opp_get_supplies(struct dev_pm_opp *opp, struct dev_pm_opp_supply *supplies);
+
 unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
@@ -220,6 +222,11 @@ static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline int dev_pm_opp_get_supplies(struct dev_pm_opp *opp, struct dev_pm_opp_supply *supplies)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
 {
 	return 0;
-- 
2.31.1.272.g89b43f80a514

