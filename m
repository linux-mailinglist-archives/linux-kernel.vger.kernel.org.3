Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B546432E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345501AbhK3Xa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345429AbhK3X1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:49 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EAAC06175D;
        Tue, 30 Nov 2021 15:24:27 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l22so57904736lfg.7;
        Tue, 30 Nov 2021 15:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fItgMJ65iQSV+grlztB0lQCNjAn4l4vCQ8OPUC2n0iM=;
        b=aF4Ycii/MaHg00ZE+3dfsIrypVoNheEl/2z4wZD7B5Fk4zUtHjBDfqlo141OzxnaQa
         zm7xSEYL4w0/XZL8aWRjqM5n7O15+U8YcTg7o7+rsRCOOJ+7pttZLn0qcR/xwzWBqYve
         PxVj+uhKmoR3sfiqx4R4gYJCydMQfiaMPrnKXLXxVM773tj/5onjnzuJXwHXUoWrZPPg
         8IFr+JCg0bz/nDHZxnUtA3fywTxkh8cpGh2JhevcLq4n6jeOJklKLfpzRcliS67IuVSk
         1rk4t2pC1AEteT5UDrCGSiGAshZfpndMymsOCMArlbIU+loriqB4r7KOF5yJaTSQXOlL
         l7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fItgMJ65iQSV+grlztB0lQCNjAn4l4vCQ8OPUC2n0iM=;
        b=HbWdGm5BAJe+JY32MDxtSFVZqc0n4t11AfpuTnRFAykC42TsIteqiwWL4L3SjWe6Zb
         5420Avaufa7Z3QAFKqR/CriEzEWSer2t0Q0MxMZzHFMQb3//TTIfQZpThHYWFZUDL05o
         7BetCfYyFWTtaTtgBrGjif3ihySaouHYvURRTq7ta+oUrnRqpDd7ERCkJAepTwpxxSi2
         CYAxjs5chsnDUhUTuYwMHGabplp99kCcbH75xZBJc4OPf5oEgBeXFVD4KyAp7CR+wA+g
         BhVV4GpRVRPxarsDCeuoodgE8PuG+s24sgTPXj0q9XH0TNePe0VWubUB6KGt+m3Kqv/b
         L7hA==
X-Gm-Message-State: AOAM530VrwUB1fTSQ7+RgrKr0orMvuPhUZkYKkuMPKthP79iL6QILM6N
        1JLQ2lpJPvrb9xY371OL+wo=
X-Google-Smtp-Source: ABdhPJxNNuml25jdJ1uBpe8+MC5krQ/60pjZWIeaI9zJ79Nq+G/T9R/n77kuIsPsf3+6jSdJfbWKRA==
X-Received: by 2002:a05:6512:2082:: with SMTP id t2mr2340563lfr.186.1638314665960;
        Tue, 30 Nov 2021 15:24:25 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:25 -0800 (PST)
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
Subject: [PATCH v16 32/40] soc/tegra: pmc: Rename core power domain
Date:   Wed,  1 Dec 2021 02:23:39 +0300
Message-Id: <20211130232347.950-33-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CORE power domain uses name of device-tree node, which is inconsistent with
the names of PMC domains. Set the name to "core" to make it consistent.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index e1fae1a5e36a..de6234ec4f9b 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1369,7 +1369,7 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 	if (!genpd)
 		return -ENOMEM;
 
-	genpd->name = np->name;
+	genpd->name = "core";
 	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
 	genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
 
-- 
2.33.1

