Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F647464271
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbhK3X1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344640AbhK3X1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:19 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE26C061574;
        Tue, 30 Nov 2021 15:23:58 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 13so44200549ljj.11;
        Tue, 30 Nov 2021 15:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BYMzBVvFXat+EF6D7Xq1trPhz10Qnf9JVl9Iy6huEzk=;
        b=lajLqZROAECuoHKxexs4CSVKYhbsBMDk4I1TxsQBgo1ZcmQMZhfPetyzsORD1zUCbT
         dg49kWtezjJpQBK5De5XGtS6PmAIV8AcWv7ISkgw36PvZ966QCiDmThWPOo3MWqhB59E
         9NWdXH88LqbUoLDEDfHYniJEPnxIqXE3YK64a4RArEYtZj6vhf1ql01+HDGMoNmwoJMJ
         8xK5pmdLDLlILMd/ZNLXmSTlz9AUxgw7wpZMucKTVtUCcElxPXgzZUH7ut0zd5jzEaCe
         wx59Hsx56KukR46I4wdrR54+MyKERQkeZz2TT3jor4xjgMa3u508cow2zk75oiUyzMwS
         +cbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BYMzBVvFXat+EF6D7Xq1trPhz10Qnf9JVl9Iy6huEzk=;
        b=D8rkqw8eBQRzrUGiY7I6InbEoWdCsaOanMtwfNEJUuCUbYWglBmXndB53nEPOvt2h0
         q60Ly3zEpZOvHLdr9Vy/NCaMAAZaI844BAL01nA/f8iwGmZ6Fh5pD78Y/i9NVmVtgD+V
         bO6mzSXUdmTgXEQ9tW/jiRSZbQAUqNN0et978MMMQv1MYXDI6T4KHRkUMJiQhfzbXaPU
         Sv4ywRLxjr41ywWmzh45MtA/Px4VAsYtx8KIYL6JoWYmeQkD73B4hju/eMrFmg5sILIO
         qDbyuZ0DHKcq9u5rWJmiHGloYa1M6PQpRaZF447G+8dEoXZoWP/+/P5CICSB+v+06Ahh
         TmZw==
X-Gm-Message-State: AOAM531p+RMAo9eON1pZh8/Sgwem6uFu7YXLulqSqDc9Vqpz/RXA49gK
        WQhb9wG8l+KtBGKdYq9YWKU=
X-Google-Smtp-Source: ABdhPJzDqM3LD+qXyxpdHhNPXxTaxrLKFRpuZ2TirfMAQAsFquYJGar5RSjZrTnAyk3PPNjBUIRI1A==
X-Received: by 2002:a2e:2e0b:: with SMTP id u11mr1918056lju.190.1638314636269;
        Tue, 30 Nov 2021 15:23:56 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.23.55
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
Subject: [PATCH v16 02/40] soc/tegra: Add devm_tegra_core_dev_init_opp_table_common()
Date:   Wed,  1 Dec 2021 02:23:09 +0300
Message-Id: <20211130232347.950-3-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only couple drivers need to get the -ENODEV error code and majority of
drivers need to explicitly initialize the performance state. Add new
common helper which sets up OPP table for these drivers.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/common.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
index af41ad80ec21..8ec1ac07fc85 100644
--- a/include/soc/tegra/common.h
+++ b/include/soc/tegra/common.h
@@ -39,4 +39,19 @@ devm_tegra_core_dev_init_opp_table(struct device *dev,
 }
 #endif
 
+static inline int
+devm_tegra_core_dev_init_opp_table_common(struct device *dev)
+{
+	struct tegra_core_opp_params opp_params = {};
+	int err;
+
+	opp_params.init_state = true;
+
+	err = devm_tegra_core_dev_init_opp_table(dev, &opp_params);
+	if (err != -ENODEV)
+		return err;
+
+	return 0;
+}
+
 #endif /* __SOC_TEGRA_COMMON_H__ */
-- 
2.33.1

