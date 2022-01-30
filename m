Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886BF4A39A1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356350AbiA3VCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiA3VCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:02:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9607BC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v123so8859105wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LuuKJA9f7YLqLdO+mCS1Ti2MxJr1lgIYr2C1PeNLK3o=;
        b=LbWR9zg7i3nGEVZfAWrd8y9KBE6WPoaZlzZMNezQfJDsHfPZRQQtgiktinT+/vS1eZ
         +UY3n/PqmpUdGOzOz5Aozq5DdIkf2+jj8Cdd63SLp/J04iN3p3mVFPSvkzqG76x72d8j
         tLcyE2g7Bzpmh5wcr+S1hjbV1KJ9m9fXw/Dr21UNoCBYdWEJclqzFUI7UEikNZ7lkazU
         leW6VN9weB8m9JEMqgXytYAJpTfamaR4Xre6JtDemJ7zB3QpCZvXRcBNVBaPBYAIiV1E
         9oxcQAWa2NggJ3uSlxchQWdlRHvj4x38j/LwzqGI+y9vwYE0RCheOrbTAPx4GCTEviJx
         fOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LuuKJA9f7YLqLdO+mCS1Ti2MxJr1lgIYr2C1PeNLK3o=;
        b=clMWxwavR/zT8apA1hsJCleoQw3Uvi7Ap1E4O6H1EfoS9bDJ9wKculXxdr7VF7Xv04
         OzzLvi6WPiAeSln0bt3u4QPU78KT4EPlMkpaGSsKDsqr5clSqFbIwQxGjWayXyzRCWXU
         hLWvzrawaItFFusAk7FC9eLSRrNBUxSAt+xs5Y5CJh8KCFHVBEDxeebQIAsHdK7OzZ7R
         tbfK+va2d8Sz3ePNKm+ekEKVzctjG9UUYv44BmtB7ri7vzcPplx+rhAqHStYee7WL3ud
         lZ5OEO+PD5ACNvvvo4Z9qegm0c0prylgWaLBVS8qSmZtGnKEeE9QsxVYOqBwdYauCBRf
         uqxw==
X-Gm-Message-State: AOAM5302KL3damk75+JO6ekNsLKk5IHDLDwl/V7m6dfN4jZtZw51Ue+w
        1osc2NEOKpXABhWY7/FMqtn5NQ==
X-Google-Smtp-Source: ABdhPJyWDx9xdG/aa6AnVmD8qw4WCzO4tJnIyuqpp5B3OJMmIPBunA3OFRRAHgysZmgFcQTbJRShXg==
X-Received: by 2002:a05:600c:3494:: with SMTP id a20mr16200921wmq.129.1643576536119;
        Sun, 30 Jan 2022 13:02:16 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.gmail.com with ESMTPSA id i6sm9845185wrw.8.2022.01.30.13.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:02:15 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 2/7] powercap/dtpm_cpu: Reset per_cpu variable in the release function
Date:   Sun, 30 Jan 2022 22:02:04 +0100
Message-Id: <20220130210210.549877-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130210210.549877-1-daniel.lezcano@linaro.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The release function does not reset the per cpu variable when it is
called. That will prevent creation again as the variable will be
already from the previous creation.

Fix it by resetting them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm_cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index eed5ad688d46..71f45d2f5a60 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -151,10 +151,17 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 static void pd_release(struct dtpm *dtpm)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
+	struct cpufreq_policy *policy;
 
 	if (freq_qos_request_active(&dtpm_cpu->qos_req))
 		freq_qos_remove_request(&dtpm_cpu->qos_req);
 
+	policy = cpufreq_cpu_get(dtpm_cpu->cpu);
+	if (policy) {
+		for_each_cpu(dtpm_cpu->cpu, policy->related_cpus)
+			per_cpu(dtpm_per_cpu, dtpm_cpu->cpu) = NULL;
+	}
+	
 	kfree(dtpm_cpu);
 }
 
-- 
2.25.1

