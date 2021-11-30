Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FCA464359
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbhK3X1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbhK3X1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:16 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F062DC061746;
        Tue, 30 Nov 2021 15:23:56 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id k2so44335868lji.4;
        Tue, 30 Nov 2021 15:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8oXDZz/nBiCoTxlA9cxo84oljRiezPiTcqnco4cDqBk=;
        b=XLJCgMVTmKwMDnr4RG5eYQpE9FsJM2y9fVDdPVIAH5kcazxZjIUW2SpduflsgGc3eB
         fLA3MbrcHO4RHDW5OkjazNWvA9hFc277AMv4N7pHrO7L1dnUHYQLBUdAPwEwaw/t6NvW
         hs/XuA+I5O2h55OwBE54dHrKZ2nU3IasUtX6kfoPfh0rYu6q9cmMxZsEsdIdTczjXLuG
         4+t50E20QynLHZbSg/ycbMWdatMbiTzUgoz8N+kJ1ptotFylyMa+GedCFpK/jbVmGKn6
         9K0ZXvSlcKUp6YhyKOg/MSwMH8LpC1CLDDh5R9GrSWgffH9SmiqS1mGvl64fn84K25r7
         h0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8oXDZz/nBiCoTxlA9cxo84oljRiezPiTcqnco4cDqBk=;
        b=7Ujg7UR2rzlyLFYrHqy5IKaJboV9MUSR/z3IVqISwtyki82df2mlz2uUuuinNUhoSl
         8AP+p2RR0cHb8DXd/b0TN605b7AwHylLqIy1M4q1P0I1yVyU8y/vb9lhZyDo8OWlmW8b
         kF0rhtkNCTMIFJ/85l+5esdXMCqopNfbidOfkG3QrBR7e7yOzR6QizuY+BqQ2UesR4uN
         skMhM+g8wS3zF1fnYrkxsk7qP9f+zdrU5F/EMxDTMWGclXeyc/jg4rjLWGsmGZI3QBGG
         59u0+JMQvTcmFu5QP5hTKtzJ+Pq0DP2+3rprOa6UPVOzwpsciYVd+T8K61KUc5B1qeMk
         MqHA==
X-Gm-Message-State: AOAM531JhiPpD0q3kZL3GkVPx7SVFyZRliKCwhY4bl3yxq7aU+7zzawM
        XvnlCuYVqcbRa9VUwnVXmvUX7c6bsb8=
X-Google-Smtp-Source: ABdhPJwhO36R3bhfl68pi/e8OJisT16/7YFpWDC1P8eGYpr3I9krZ+BceKfz24DQI/E5GNm2WLZwlA==
X-Received: by 2002:a05:651c:1024:: with SMTP id w4mr1886130ljm.154.1638314635334;
        Tue, 30 Nov 2021 15:23:55 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:23:55 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v16 01/40] soc/tegra: Enable runtime PM during OPP state-syncing
Date:   Wed,  1 Dec 2021 02:23:08 +0300
Message-Id: <20211130232347.950-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GENPD core now can set up domain's performance state properly while device
is RPM-suspended. Runtime PM of a device must be enabled during setup
because GENPD checks whether device is suspended and check doesn't work
while RPM is disabled. Instead of replicating the boilerplate RPM-enable
code around OPP helper for each driver, let's make OPP helper to take care
of enabling it.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/common.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index cd33e99249c3..35c882da55fc 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 
 #include <soc/tegra/common.h>
 #include <soc/tegra/fuse.h>
@@ -43,6 +44,7 @@ static int tegra_core_dev_init_opp_state(struct device *dev)
 {
 	unsigned long rate;
 	struct clk *clk;
+	bool rpm_enabled;
 	int err;
 
 	clk = devm_clk_get(dev, NULL);
@@ -57,8 +59,31 @@ static int tegra_core_dev_init_opp_state(struct device *dev)
 		return -EINVAL;
 	}
 
+	/*
+	 * Runtime PM of the device must be enabled in order to set up
+	 * GENPD's performance properly because GENPD core checks whether
+	 * device is suspended and this check doesn't work while RPM is
+	 * disabled. This makes sure the OPP vote below gets cached in
+	 * GENPD for the device. Instead, the vote is done the next time
+	 * the device gets runtime resumed.
+	 */
+	rpm_enabled = pm_runtime_enabled(dev);
+	if (!rpm_enabled)
+		pm_runtime_enable(dev);
+
+	/* should never happen in practice */
+	if (!pm_runtime_enabled(dev)) {
+		dev_WARN(dev, "failed to enable runtime PM\n");
+		pm_runtime_disable(dev);
+		return -EINVAL;
+	}
+
 	/* first dummy rate-setting initializes voltage vote */
 	err = dev_pm_opp_set_rate(dev, rate);
+
+	if (!rpm_enabled)
+		pm_runtime_disable(dev);
+
 	if (err) {
 		dev_err(dev, "failed to initialize OPP clock: %d\n", err);
 		return err;
-- 
2.33.1

