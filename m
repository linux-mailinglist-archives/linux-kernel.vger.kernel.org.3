Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AFA538E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245565AbiEaKKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245547AbiEaKKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:10:32 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3E5996B0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:10:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 187so1205148pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t251UuYRX9Gpk6ss004lGbBIWKYfWc6ZdKzVbibvYPg=;
        b=fwlYso4ODGThWvb7mm55FvL2//jUk5biuuuIfzJ/5OIu19ucpglm2wXgyXpwwaAhiR
         SLNuPQIkSu1uXrlOPqHCRxVYEUVnSCnskiGNigQIAmlJ2Radzqn/hcu+/+XMtjWMZHt0
         cYnel2tgevynwXsSFmQSdjz3/4GJo0o3oxV0XRnR1TBozSkbCxDNyzxlZhUE8uVrUhHP
         eKf/E3qDpjGcTmeuSkn6Y9PDqNs1HhVfDn91YkVKiOD7WSisXVcvFjp8gSR+HJzjIbwT
         B5FEvws6wKGtZs5niQ7AfVzIUa1Blma2HIJPlb8IBhXffvt/h0SucIzG6pItPg9yenV4
         KuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t251UuYRX9Gpk6ss004lGbBIWKYfWc6ZdKzVbibvYPg=;
        b=1yN5ECTEHWBbeqfhOscbTxUpNsYabCVz6ppzPmrZFSJwJ6oP4cLgfgavBcMYY2M+CQ
         X7VkvJp2FB3ZeqJzyfKL8E7pzgRgsRIWTWogxTuoV2ab53GmsAm2UURnO3kQwL+y1pct
         W82Kl3af46fTGn65u5jiLk5rB+JTmdTggI4HE11C5XThm54Iig0delh8ZLLJboyYRALu
         L98vQ0iORU11ixo5Wsh8FUC70H3XeodzO6GcSYWlbRAg237vuOzrYs1MiqGVhVeOQphh
         8+LfRlqUdUhW8x0veC4tIQB2L5zh9OEpHGEcFlBROTarREkCNKHwuFNWvseROS1vNSY4
         I3VA==
X-Gm-Message-State: AOAM533nIQmd2uORgbvAJG9MjyxhQTsSaa1ldjT0QrkxCyEtUqfAA0kY
        kMghMpCPCzc2h3wMUcEP3WGv2g==
X-Google-Smtp-Source: ABdhPJzIj5N40D2+o6BjW/xwenMeZo+JSTMOCaseQ/RzunmkKENQLPvLgBAKbqXCR91riXsFu5HLoQ==
X-Received: by 2002:a05:6a00:b41:b0:50d:35fa:476d with SMTP id p1-20020a056a000b4100b0050d35fa476dmr61199182pfo.33.1653991825325;
        Tue, 31 May 2022 03:10:25 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id f3-20020aa79d83000000b0050dc76281f0sm10341595pfq.202.2022.05.31.03.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:10:25 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] OPP: Add dev_pm_opp_get_supplies()
Date:   Tue, 31 May 2022 15:40:02 +0530
Message-Id: <20838d8f1f883c6484ecd40db23097fbc727b55d.1653991004.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653991004.git.viresh.kumar@linaro.org>
References: <cover.1653991004.git.viresh.kumar@linaro.org>
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

We already have an API for getting voltage information for a single
regulator, dev_pm_opp_get_voltage(), but there is nothing available for
multiple regulator case.

This patch adds a new API, dev_pm_opp_get_supplies(), to get all
information related to the supplies for an OPP.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 22 ++++++++++++++++++++++
 include/linux/pm_opp.h |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2f76442845be..58ce1240e808 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -113,6 +113,28 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
 
+/**
+ * dev_pm_opp_get_supplies() - Gets the supply information corresponding to an opp
+ * @opp:	opp for which voltage has to be returned for
+ * @supplies:	Placeholder for copying the supply information.
+ *
+ * Return: negative error number on failure, 0 otherwise on success after setting @supplies.
+ *
+ * This can be used for devices with any number of power supplies. The caller must
+ * ensure the @supplies array must contain space for each regulator.
+ */
+int dev_pm_opp_get_supplies(struct dev_pm_opp *opp, struct dev_pm_opp_supply *supplies)
+{
+	if (IS_ERR_OR_NULL(opp) || !supplies) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return -EINVAL;
+	}
+
+	memcpy(supplies, opp->supplies, sizeof(*supplies) * opp->opp_table->regulator_count);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_supplies);
+
 /**
  * dev_pm_opp_get_power() - Gets the power corresponding to an opp
  * @opp:	opp for which power has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 7e7986106274..185503aab64d 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -128,6 +128,8 @@ void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
+int dev_pm_opp_get_supplies(struct dev_pm_opp *opp, struct dev_pm_opp_supply *supplies);
+
 unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
@@ -216,6 +218,11 @@ static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
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

