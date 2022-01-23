Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC1E497487
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbiAWSlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbiAWSkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:40:43 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BCBC061765;
        Sun, 23 Jan 2022 10:40:39 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 187so12949541pga.10;
        Sun, 23 Jan 2022 10:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eBCqVqROfO1n2GtvmaN8kb1rlmDqWZOnUSJDskEB5Oo=;
        b=mJpgWld2B5wbHhAvTMo/0gMGWx3ZGMwlFDlFyfSZigS6cUmCqMZhCmhhnpUtMwHQvy
         U7vEWX2yv0mK4/592AvEUhGR8Bcq1qSOtPDaE68Fcx0iEHXFXSw+JfHNJwvdbsEQU8Nk
         Tzi0/XyxcEtaa0BR1NACnnrVqmbASiYnUX6wAv39ETD9AwBjexOS8Dq6D28L55v1DIeA
         z8LGQVXZcM/fQX5tf8gJB52u4N9LngjlLpLvLwTz9zLbczSKPpNuB1og0VOis8OQopte
         HszK8h97b+7fUeV0fxI+/kNFpek6zXMX2TbaxxRH0Jpoxd5rkk3XDT7S9kduvAKZlNGN
         xX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eBCqVqROfO1n2GtvmaN8kb1rlmDqWZOnUSJDskEB5Oo=;
        b=IRZxEoCn+McUkhmywm3VzhKsR0s2yfCfPa7cI8dcmn5LgWwy/ZiGAdJj6LpHLrRONb
         tjcaFMpBPVxk7hduAfYsYcUAARDqtwLzl5Kwvy5V8Yl7S4a7frEkZ3XEEKGHrdJ0kewQ
         Ai3xCpHzyodY3A0IlNiWWoEWd3xGNpFJqsJozKpdrbkf3aXaxvCphy/pkXE/3mtY7mob
         9ufx3FdXt9lzcv1CVIyEjtCr6cozWAeh6IcFSmxaGk45FwdisVzwso1AXIkHDg2AV8p0
         4YtyyxDhWcTtf0cFZk8z8Yt49dP3oV5dUey/vm+/JNbxzNeBe0w3PyePkQ0pWWmZmoQ4
         WwZw==
X-Gm-Message-State: AOAM533OKRVq4kq+drMIlfKCwt1g+Gyh2FR6GI1RmWsWIMIAWp6mpKgB
        KlRBZNFkqyIJKvQlMaVGX1QOK5DX42U=
X-Google-Smtp-Source: ABdhPJwRbsW8Pwf2wNB+Tms82WHgGwFZKC0sf8JW2mhyRDN3TsdWwUbRPyPzecSyKFotLcUKv7t4fA==
X-Received: by 2002:a62:4c3:0:b0:4c2:7817:7360 with SMTP id 186-20020a6204c3000000b004c278177360mr11429381pfe.24.1642963238546;
        Sun, 23 Jan 2022 10:40:38 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id h5sm13043609pfi.111.2022.01.23.10.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:38 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 16/54] cpufreq: replace cpumask_weight with cpumask_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:47 -0800
Message-Id: <20220123183925.1052919-17-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/cpufreq calls cpumask_weight() to check if any bit of a given
cpumask is set. We can do it more efficiently with cpumask_empty() because
cpumask_empty() stops traversing the cpumask as soon as it finds first set
bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 drivers/cpufreq/scmi-cpufreq.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 05f3d7876e44..95a0c57ab5bb 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -482,7 +482,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	qcom_get_related_cpus(index, policy->cpus);
-	if (!cpumask_weight(policy->cpus)) {
+	if (cpumask_empty(policy->cpus)) {
 		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
 		ret = -ENOENT;
 		goto error;
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 1e0cd4d165f0..919fa6e3f462 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -154,7 +154,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	 * table and opp-shared.
 	 */
 	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, priv->opp_shared_cpus);
-	if (ret || !cpumask_weight(priv->opp_shared_cpus)) {
+	if (ret || cpumask_empty(priv->opp_shared_cpus)) {
 		/*
 		 * Either opp-table is not set or no opp-shared was found.
 		 * Use the CPU mask from SCMI to designate CPUs sharing an OPP
-- 
2.30.2

