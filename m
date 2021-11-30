Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46FA46432D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbhK3XaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345356AbhK3X1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:50 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4BEC06175E;
        Tue, 30 Nov 2021 15:24:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m27so57835753lfj.12;
        Tue, 30 Nov 2021 15:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmcymaX/CCDsjvKZ+BlarVFlOy3iTU1wE2LEPj5HoVo=;
        b=I/QkotZVXv315Oi1g8NIMhf14WBrbAp7YkWmPJEBawAZ5+UIJNbSWrXd4N3QlQ1Fwv
         7dbwKKWNE+5ITegxRC+PwokEIJZqQVuAf7G5gFSBhv8qlCbJK99My5FBSzTCUVQ0zbrh
         tdAO5CejqWmgsjkDPxLXZ0o/l3C7ITv4wHVbeYU9qqgcGxouQgIcYol9olH2AdOV+zFE
         0J9Nn+hVWIOMRN5VI0GqrfToZM0nPBQzyFIsI18+cWXe3T6O0qyS9+h7fcteTnF+aHYc
         HQeM1+YGNhdHBUYwFgnS5sLbHbN5buz6+OZSPXFNPUy4TEQ6HxDDfXNgVTOITU7ZLWwu
         t8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmcymaX/CCDsjvKZ+BlarVFlOy3iTU1wE2LEPj5HoVo=;
        b=r+2mvwKy6iG4KAkrDKvzxBqXhmP0MAG7CZQJEW7j5q0MFQwcnEc//BUvMTSBBckDjc
         UcGW0LXr30WS9Ze6AeP1OVgkNtGfdB7BmoHPCis0Uk04aT0fImBc3uDOkhbLJQaBmWxj
         C9zywlzVT8sbmHA8J5E4mqoHh7Fvhu+G71NIsUqWTkT3rBihSB2nccf8SVkbpTiH78Xm
         9aZXfP2Pa3GGmc7BJ4RMkmSwsrMtoaH9tsm/QvSuiuwDEWJUo4/Os0vL5ryEDwC7SWDS
         oEN2x9FPOz4y5smLrQqguv3D8b1zYBG+9NFUjpCYr7y150bBBH5O4e91dT/tk8iQoxMr
         9mGg==
X-Gm-Message-State: AOAM532UbIoHV2yYzxy5/VPHsJcnchT7DlGVTZEFzCrpKKnUqhACpWL+
        wM0XdyNwwwchrL55YToFtIw=
X-Google-Smtp-Source: ABdhPJwczFO7U2TRbH10RX6DKwTV7Tq6mEdV861qEmVo8euqcNnBcJJuYQVd4mp9nIOOAK6YBjgZzg==
X-Received: by 2002:a05:6512:118b:: with SMTP id g11mr715311lfr.46.1638314666849;
        Tue, 30 Nov 2021 15:24:26 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:26 -0800 (PST)
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
Subject: [PATCH v16 33/40] soc/tegra: pmc: Enable core domain support for Tegra20 and Tegra30
Date:   Wed,  1 Dec 2021 02:23:40 +0300
Message-Id: <20211130232347.950-34-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All device drivers got runtime PM and OPP support. Flip the core domain
support status for Tegra20 and Tegra30 SoCs.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index de6234ec4f9b..585a05968ea9 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3070,7 +3070,7 @@ static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 }
 
 static const struct tegra_pmc_soc tegra20_pmc_soc = {
-	.supports_core_domain = false,
+	.supports_core_domain = true,
 	.num_powergates = ARRAY_SIZE(tegra20_powergates),
 	.powergates = tegra20_powergates,
 	.num_cpu_powergates = 0,
@@ -3131,7 +3131,7 @@ static const char * const tegra30_reset_sources[] = {
 };
 
 static const struct tegra_pmc_soc tegra30_pmc_soc = {
-	.supports_core_domain = false,
+	.supports_core_domain = true,
 	.num_powergates = ARRAY_SIZE(tegra30_powergates),
 	.powergates = tegra30_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra30_cpu_powergates),
-- 
2.33.1

