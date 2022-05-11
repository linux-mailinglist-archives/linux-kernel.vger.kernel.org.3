Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59F52366A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245255AbiEKO6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245287AbiEKO5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:34 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCED6B0B1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q130so2955253ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0SVdNZTesTCt27Lh8nfNAnhtcZlgzCNi0eR/b6PWgs=;
        b=btWLqxTiISmaw5e1BljDRvBH2qafHAGi+/5/pMimaSVkt/0UTBLhs9SqsV0uEaLFt2
         NLn2wz4Srkn2BZJWzNPD8D/xV9qv29WDGHyd4GTTH77GWOwL8X+5HeezMNr8KpbEXnJD
         EfUOJNVvwQetEL9xVC5VFP2V3XykQ+SV6lo4cXjoRhkSHwkCLhFrN4vG4mPGvGHoC/Dx
         MrPIXa+Re/2PPgzGTzW2iqBCM/4ex3tpxxlh+HTTyNyfWxFis6pD6197IP8JhpVVXsGw
         3uzdXjzSPnP2uZ+PpprRuKT01aeOrPl/BcMZd3fN4wKMy5RWss1bpCc9q3pT0Cjpi3bF
         7bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0SVdNZTesTCt27Lh8nfNAnhtcZlgzCNi0eR/b6PWgs=;
        b=bTmys73FVUtxxbW5Gu9keR7F80yKmHtv4Hfgp2VTL7zKi0FJhRIM0j5L69o1Odrlo7
         6510eR6YlK/IZy1NKaK7hrXnAvgQmlh0LGVdqOXnfawWDnce/KnPHL4aX1Cwpbi+Y5W6
         kcuAdJ7Q15s7MdBN2Stt0gyRDMKtDqGVEwcDyF1uI3MR9rnsdiN56pFCZqoHRD+/4WBG
         iZoSl5X30tVUyMpA3HTkBNf885CxSvlNxdJM2HWCMBSnZQrh/stDjDeXIUbiwBoEWqWZ
         X6i/X/3aw4Sf4BMvXFAojgd2VsDgwhqGdcd67/tV6ihoSrAz/Tg009w7CeyHLiurqMdL
         DuOA==
X-Gm-Message-State: AOAM532ASa5s3GxyFIykHIf/0rXF3uQJmeNbgXP4VRs79kWW6MkA6gFw
        oAnFp66UlcyKu70YnpWPFNlVVQ==
X-Google-Smtp-Source: ABdhPJzGAxm2Ip0gBbvXZ4HIZMDDktzLw0NmQQSoajM67RWvgRmy7EZgRS/ywmFdRNSc6+KE8jk78g==
X-Received: by 2002:a2e:8496:0:b0:24f:130d:e38b with SMTP id b22-20020a2e8496000000b0024f130de38bmr17242674ljh.498.1652281045536;
        Wed, 11 May 2022 07:57:25 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:24 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] PM: domains: Rename irq_safe_dev_in_no_sleep_domain() in genpd
Date:   Wed, 11 May 2022 16:56:54 +0200
Message-Id: <20220511145704.698189-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511145704.698189-1-ulf.hansson@linaro.org>
References: <20220511145704.698189-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name "irq_safe_dev_in_no_sleep_domain", doesn't really match the
conditions that are being checked in the function, hence the code becomes a
bit confusing to read.

Let's clarify this by renaming it into "irq_safe_dev_in_sleep_domain" and
let's also take the opportunity to clarify a corresponding comment in the
code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5059c5d2e64a..269bfa3d2303 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -131,7 +131,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
 
-static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
+static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
 {
 	bool ret;
@@ -139,9 +139,9 @@ static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 	ret = pm_runtime_is_irq_safe(dev) && !genpd_is_irq_safe(genpd);
 
 	/*
-	 * Warn once if an IRQ safe device is attached to a no sleep domain, as
-	 * to indicate a suboptimal configuration for PM. For an always on
-	 * domain this isn't case, thus don't warn.
+	 * Warn once if an IRQ safe device is attached to a domain, which
+	 * callbacks are allowed to sleep. This indicates a suboptimal
+	 * configuration for PM, but it doesn't matter for an always on domain.
 	 */
 	if (ret && !genpd_is_always_on(genpd))
 		dev_warn_once(dev, "PM domain %s will not be powered off\n",
@@ -653,7 +653,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 		 * device is part of a non-IRQ safe domain.
 		 */
 		if (!pm_runtime_suspended(pdd->dev) ||
-			irq_safe_dev_in_no_sleep_domain(pdd->dev, genpd))
+			irq_safe_dev_in_sleep_domain(pdd->dev, genpd))
 			not_suspended++;
 	}
 
@@ -925,7 +925,7 @@ static int genpd_runtime_suspend(struct device *dev)
 	 * If power.irq_safe is set, this routine may be run with
 	 * IRQs disabled, so suspend only if the PM domain also is irq_safe.
 	 */
-	if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
+	if (irq_safe_dev_in_sleep_domain(dev, genpd))
 		return 0;
 
 	genpd_lock(genpd);
@@ -965,7 +965,7 @@ static int genpd_runtime_resume(struct device *dev)
 	 * As we don't power off a non IRQ safe domain, which holds
 	 * an IRQ safe device, we don't need to restore power to it.
 	 */
-	if (irq_safe_dev_in_no_sleep_domain(dev, genpd)) {
+	if (irq_safe_dev_in_sleep_domain(dev, genpd)) {
 		timed = false;
 		goto out;
 	}
-- 
2.25.1

