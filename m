Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78A4D1240
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344918AbiCHIa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343878AbiCHIay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:30:54 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A163F88A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:29:57 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id w37so15818433pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=biY5ams/L/8gAUldcXYdkodIReIruP+fnC3UwnEvKik=;
        b=FR5UYtStER6p/1YZQvrw3ScM5SgcgyBONMffv5EQPqlHUrnjdoxfZZ+yRdnVbYNFxb
         w2ZvfSdx3sslpCnGLI6akBCeP5omUHdhKvrlVjutHND41gfD89CXojsSAnLK1GO/DR6A
         oxsx8HCMN402k9J7sAsMuVWb/eiLNQV6/Nvhvqqcv6uwPgRYT37sNuBxrsUMyjWGIYlt
         Eij8Eso6oHN5v9aEAUk3BYRCtCuyS6fFIa2nSsQtgukRMg4q+To4Xc14xbqQqtHR8z0H
         2G36AgBMtUHhcbZg8HzlPBY8neN/HVTz6ppBryGonswOhmkhPs+ErpWt+Zj/QCO+VmfC
         SFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=biY5ams/L/8gAUldcXYdkodIReIruP+fnC3UwnEvKik=;
        b=eM0sJ/nX8apUgzR7mrkFaQawPkhP7y3IHSXco280FMmBBQoGKA0z+j3b5cdRHBtAsL
         z4OENQdpNmd2TbCaMmEKM61F+xGXmngPtlJlcWo/nBBNn32+T5kl/1KOVd3eFai5FE/n
         BhNbHQmY3uDlg//pbyVu0H0BrQZDN1GnDm8zn2xS9Jg6iDtiGypti7GZf+EUEABNgYoI
         1TJj9B/SLoZ3NONY+/tHYf3dO8lj17dLxdsdu1fD8BlTUWt8HsivHZDBtAH/gxSq0Tgd
         rcryw9LdPYC9xTZ0K33vWfwgxICtobIIGxO/M5z7UaetzAijrGbe9dLFqJlK8GQD3o4z
         DOCg==
X-Gm-Message-State: AOAM5339SFkuGhJrI8VG1fbLDNLoDj8p0euc1Eqkiy9uw1iKYpTWelzK
        l0RpSfiIg97OF0HLhUurE5aJYg==
X-Google-Smtp-Source: ABdhPJwtleDHDeXzrBf/O+A+/gweObqeGpJC3OV68tzPuEyMJ5MfEfsiH62i5lEDEawS1VIox5YjAA==
X-Received: by 2002:a05:6a00:2815:b0:4f6:ecc6:1173 with SMTP id bl21-20020a056a00281500b004f6ecc61173mr12739958pfb.74.1646728196621;
        Tue, 08 Mar 2022 00:29:56 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id e18-20020a056a001a9200b004bc82d0e125sm18369364pfv.119.2022.03.08.00.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:29:56 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2] cpuidle: psci: Iterate backwards over list in psci_pd_remove()
Date:   Tue,  8 Mar 2022 16:29:31 +0800
Message-Id: <20220308082931.3385902-1-shawn.guo@linaro.org>
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

Fix the problem by iterating the provider list reversely, so that parent
PD gets removed after child's PDs like below.

[    0.029052] CPUidle PSCI: init PM domain cpu0
[    0.029076] CPUidle PSCI: init PM domain cpu1
[    0.029103] CPUidle PSCI: init PM domain cpu2
[    0.029124] CPUidle PSCI: init PM domain cpu3
[    0.029151] CPUidle PSCI: init PM domain cpu-cluster0
[    0.029647] PM: genpd_remove: removed cpu0
[    0.029666] PM: genpd_remove: removed cpu1
[    0.029690] PM: genpd_remove: removed cpu2
[    0.029714] PM: genpd_remove: removed cpu3
[    0.029738] PM: genpd_remove: removed cpu-cluster0

Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes since v1:
- Fix commit log
- Pick up Reviewed-by tag from Sudeep and Ulf (Thanks!)
- Add Fixes tag as suggested by Ulf

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

