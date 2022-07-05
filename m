Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE2E5663B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiGEHBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGEHBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:01:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125F1101C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:01:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso6333920pjo.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vLm3xPD9OxbHjcm/3fn6+SA6JSr3RLuVTRqSmxurVMY=;
        b=gKr6TFO1o5rV/BJddvsaeHxIruLKA4Z2tP5sqRSoBNOYHrukCuOEPGVo7e0FTYEgcl
         JPs+oG85x6SFfg1vEvtXP/lQAQshrSfhiZOrw0EvjkPoldint3hsdATSOECt1ld+kral
         1/fwMfJjCAslWGLERTlFONibnZ2X/aI+FyQheqN49D0SODJRUq9YvPe4bETtuDUx7lhn
         O+DgQG7qTltlnJSl6LpWP/hbMr85OFfSWtaXD2E472mS/yPchzfIXGR5RE6AgJums6Yp
         aZePjB4t17iRU707AGz931Cy7UL5f6O6XOmW21x0CWOznju7ZLKjwk5pBiGkT88ykqro
         SrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vLm3xPD9OxbHjcm/3fn6+SA6JSr3RLuVTRqSmxurVMY=;
        b=tgiMdhXOz3pC3SM7QfuYM76ugBputQg80p90HpCKsm0HKv/37+k2jDIIAPAB95sPiT
         v2sEJNQt5QEc5SX28SXXda16PnIVPJxajRs+aF9hqwclbEsTK0eoCO4AM2eOm77NwZtL
         PuUEgG4X1mgmkocFVsyrCyERWebKXqzC3dDuCi5sw3da2wJX/RB8sCjQO4y0d3qAEgNb
         QR87m9N19VEuiXoPqOqDhpMwYj82eBf0rpPm4ZczX1k1yqjRGepKdUyE+M39t9YPnwez
         ZWyfrdOg/jKxMiJQj/NUxmPTD6IVeBiOFqjKHGA03VpW+MBULu/QicoiTmZHhzpCOOZv
         ubTA==
X-Gm-Message-State: AJIora9CTUm8ieOuz3mAQc/gy3624E/pC4rHbhH2W6qdRM3lMK1X0b4x
        DTMFO5+BXbNdT6eoK4zMYqWa4Q==
X-Google-Smtp-Source: AGRyM1uxCpNI8nwgrEdlh7MZTqT7inkXpk5zwGEbVXLVh4hAaidUoOJ+LwVIrS0wKmYsGRPXdI//wQ==
X-Received: by 2002:a17:903:1246:b0:16b:a568:4f74 with SMTP id u6-20020a170903124600b0016ba5684f74mr31761798plh.0.1657004460632;
        Tue, 05 Jul 2022 00:01:00 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902650800b0016bee668a62sm1513972plk.108.2022.07.05.00.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:01:00 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 10/13] OPP: Provide a simple implementation to configure multiple clocks
Date:   Tue,  5 Jul 2022 12:30:13 +0530
Message-Id: <fe5461152cc3afd5e7ee750202d50b6301b11f7f.1657003420.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657003420.git.viresh.kumar@linaro.org>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
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

This provides a simple implementation to configure multiple clocks for a
device.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 10 ++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5b3542557f72..597f7df3e375 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -843,6 +843,40 @@ _opp_config_clk_single(struct device *dev, struct opp_table *opp_table,
 	return ret;
 }
 
+/*
+ * Simple implementation for configuring multiple clocks. Configure clocks in
+ * the order in which they are present in the array while scaling up.
+ */
+int dev_pm_opp_config_clks_simple(struct device *dev,
+		struct opp_table *opp_table, struct dev_pm_opp *opp, void *data,
+		bool scaling_down)
+{
+	int ret, i;
+
+	if (scaling_down) {
+		for (i = opp_table->clk_count - 1; i >= 0; i--) {
+			ret = clk_set_rate(opp_table->clks[i], opp->rates[i]);
+			if (ret) {
+				dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
+					ret);
+				return ret;
+			}
+		}
+	} else {
+		for (i = 0; i < opp_table->clk_count; i++) {
+			ret = clk_set_rate(opp_table->clks[i], opp->rates[i]);
+			if (ret) {
+				dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
+					ret);
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_config_clks_simple);
+
 static int _opp_config_regulator_single(struct device *dev,
 			struct dev_pm_opp *old_opp, struct dev_pm_opp *new_opp,
 			struct regulator **regulators, unsigned int count)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 104151dfe46c..683e6baf9618 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -159,6 +159,9 @@ int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb
 int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 void dev_pm_opp_clear_config(int token);
+int dev_pm_opp_config_clks_simple(struct device *dev,
+		struct opp_table *opp_table, struct dev_pm_opp *opp, void *data,
+		bool scaling_down);
 
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
@@ -342,6 +345,13 @@ static inline int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_c
 
 static inline void dev_pm_opp_clear_config(int token) {}
 
+static inline int dev_pm_opp_config_clks_simple(struct device *dev,
+		struct opp_table *opp_table, struct dev_pm_opp *opp, void *data,
+		bool scaling_down)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
 				struct opp_table *dst_table, struct dev_pm_opp *src_opp)
 {
-- 
2.31.1.272.g89b43f80a514

