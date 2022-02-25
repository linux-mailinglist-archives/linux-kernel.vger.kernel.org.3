Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB774C4006
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbiBYIZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiBYIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:25:00 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D7E1FE564
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:24:28 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d17so4135191pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yum9+x02mmC9p3Nv4KcgRE/DjU3YZvYXccqQBT5GhAA=;
        b=JJFjSjikZK5vZ42MIyUM4iSPqZY2jgbF13UZMHQRLNtFjSNMjLXnuwbO4VW6owvNp0
         Uhm7Zwv6k+bYEQV/7S7y3PFsx5jIa7SiVxahJJucFDgycf0M4wCDAv81e6zLrcure5kI
         rJjHZAHHFAi5WUI91/1eCeb5q5aqeylMXG/E0Q1jvEewc5z0MD1DVGU/144Pn6W7xkyP
         +2mgWMHQ34F/aSqYEg6yN4TEh2ShMZ9Oolx7Sxn3wuSH+OUUcb9AWhhSjr60NcBdfya+
         HRu6hB6KpbqByDIY/4F0ahgpJcxg7kdbSqmKFR2ok7qANiq0fV+kwb3+M1yg2sXZJ7FR
         YhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yum9+x02mmC9p3Nv4KcgRE/DjU3YZvYXccqQBT5GhAA=;
        b=SsxhQaCTgSVTmTsyZBCCk+XD63PVg1W6ZwR7Mb1wIP3NLnQJ+Gc1oXYwDbQhbrBur/
         fvfdHzCPzclFpFdMW8pCUQUCLoLahVuyHrt7aabJlZDCrTie8YTDFmuw9aF2es7iR8eT
         5Ipqtu4iygMGV3J22JytIZndTnbwiuxF9pqdvCRZpu5qzy8YWxq2nc6Z2dmeU519MwWx
         O22sQZUU1KelwQi6VWzR5aki8vunGTcqWs6oo/v1Fs2d2Yz9+oN1722oQL7SG1egS0B/
         66C+XsWnG6pVbPSdBX8qlDZ2x0HV2oUNbNFCsYC7w7Rs8EUtHaBa+O7sGkiGYFvEiiNC
         /nyQ==
X-Gm-Message-State: AOAM533TaFGdeB1JzfVr/lIpaicr237fBEODp2p0sBER2OtJ3OR/6b3h
        oGer3XqRquM8dg6MEvNNyGOnug==
X-Google-Smtp-Source: ABdhPJxn496aHY+LlUfjJ+UwxuwXeyX/nvjvbcqDUnyAL8mg/Wu5Gs+Wu74+lDDqKI8EBIZ8qa78VQ==
X-Received: by 2002:a65:6746:0:b0:377:16e2:33a2 with SMTP id c6-20020a656746000000b0037716e233a2mr1478335pgu.47.1645777468098;
        Fri, 25 Feb 2022 00:24:28 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004e1414f0bb1sm2038607pfl.135.2022.02.25.00.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 00:24:27 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] cpuidle: psci: Iterate backwards over list in psci_pd_remove()
Date:   Fri, 25 Feb 2022 16:24:20 +0800
Message-Id: <20220225082420.450620-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
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

In case that psci_pd_init_topology() fails for some reason,
psci_pd_remove() will be responsible for deleting provider and removing
genpd from psci_pd_providers list.  There will be a failure when removing
the cluster PD, because the cpu (child) PDs haven't been removed.

[    0.050232] CPUidle PSCI: init PM domain cpu0
[    0.050278] CPUidle PSCI: init PM domain cpu1
[    0.050329] CPUidle PSCI: init PM domain cpu2
[    0.050370] CPUidle PSCI: init PM domain cpu3
[    0.050422] CPUidle PSCI: init PM domain cpu-cluster0
[    0.050475] PM: genpd_remove: unable to remove cpu-cluster0
[    0.051412] PM: genpd_remove: removed cpu3
[    0.051449] PM: genpd_remove: removed cpu2
[    0.051499] PM: genpd_remove: removed cpu1
[    0.051546] PM: genpd_remove: removed cpu0

Fix the problem by iterating the provider list in a reversely order, so
that parent PD gets removed before child's PDs.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index ff2c3f8e4668..ce5c415fb04d 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -182,7 +182,8 @@ static void psci_pd_remove(void)
 	struct psci_pd_provider *pd_provider, *it;
 	struct generic_pm_domain *genpd;
 
-	list_for_each_entry_safe(pd_provider, it, &psci_pd_providers, link) {
+	list_for_each_entry_safe_reverse(pd_provider, it,
+					 &psci_pd_providers, link) {
 		of_genpd_del_provider(pd_provider->node);
 
 		genpd = of_genpd_remove_last(pd_provider->node);
-- 
2.25.1

