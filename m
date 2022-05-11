Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB3D52367A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245276AbiEKO7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245354AbiEKO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F231EABA0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:39 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 16so2916673lju.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03vwMXkNSh1Yi/ACwjbmjbNGWKBFAPs5qBvgCoLQeEk=;
        b=AGjrrVJCLBarjIjTSR4m++R4rn4Nqfv0gx/0iKgijlo/HyHKY4TU9boFbkOMdNQr+v
         0nh+AUV9zFAuU2hJpx8BbRRJ/RQWYTglsMMWiZZOOLd9UPYWZNziBgy8ui4Z0DaPTDlM
         ixVWOHtmkHmIVNkiuQ9p1dmc+TQK6GmJjoF4cDpmW4HKjKC3+mp09EE1HpSJ+QJpG1Sr
         rFgRKP4AKv+Wkilh1NaQRPxMSp1jPU/2PDoftAuQb5IxRJJTABh/XkcV/GcMD2F3dGst
         6AuskXb4OOwjt5HaH4WwBhx/TTMtZz7gT0HB0+sJ+o8HJQA8yYlHSbGwaTN0zZdMJvvu
         sf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03vwMXkNSh1Yi/ACwjbmjbNGWKBFAPs5qBvgCoLQeEk=;
        b=sjfPhMgI0n9e0kD7TRtLWf+P9BJkyxP9jOTVK1LIkYibz1KRdGAl8OfjjsKOAG9Lkk
         FIdvlLCwZOZ6yTpNg220qyYqjHLhtIlqgxSlhNa4Jsbq8+/ypl3eM3KIJOh4s9ws42hH
         XipBxUSyb2AhDkcWnfOPXoyNas6Rvgra11g3cP+lTuPRkCUqic9BH6jbdWfLQgN35lEx
         nwZEH6vtJXMAnkQ52xh13TkJ0YGptAV9rVz3zBd2SIjmtdPy4/q0CoZUnuFMDpCO2Rjx
         12ltGi2IjaJ5vgofLQbbOzr5Ii4tRwx9Ji0T4OlwkElA1zrjn1z5Nr1WgcCJYe46ESBT
         vNJg==
X-Gm-Message-State: AOAM533J5XNS1b9/F26VNxJ0SCc7eud3xhGuAAXT2cc+8mcXzKQYbO65
        8CpDa5Wl5H68Xhm91kSUdFxbKw==
X-Google-Smtp-Source: ABdhPJwVzMZbFVWKNFxTrZgdyNeO0VWVLulqT/QD/hKAzX3rlaU1s0usPzyUT3MXIIuzEBhg1WmgVg==
X-Received: by 2002:a05:651c:1792:b0:235:1df3:7b8e with SMTP id bn18-20020a05651c179200b002351df37b8emr17300088ljb.464.1652281058272;
        Wed, 11 May 2022 07:57:38 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:37 -0700 (PDT)
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
Subject: [PATCH 11/14] PM: domains: Clean up some code in pm_genpd_init() and genpd_remove()
Date:   Wed, 11 May 2022 16:57:01 +0200
Message-Id: <20220511145704.698189-12-ulf.hansson@linaro.org>
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

To improve the readability of the code, let's move the parts that deals
with allocation/freeing of data, into two separate functions.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 56 +++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9922fd763739..ac1eb7d2470b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1968,6 +1968,37 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 	return 0;
 }
 
+static int genpd_alloc_data(struct generic_pm_domain *genpd)
+{
+	int ret;
+
+	if (genpd_is_cpu_domain(genpd) &&
+	    !zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	/* Use only one "off" state if there were no states declared */
+	if (genpd->state_count == 0) {
+		ret = genpd_set_default_power_state(genpd);
+		if (ret)
+			goto free;
+	}
+
+	return 0;
+
+free:
+	if (genpd_is_cpu_domain(genpd))
+		free_cpumask_var(genpd->cpus);
+	return ret;
+}
+
+static void genpd_free_data(struct generic_pm_domain *genpd)
+{
+	if (genpd_is_cpu_domain(genpd))
+		free_cpumask_var(genpd->cpus);
+	if (genpd->free_states)
+		genpd->free_states(genpd->states, genpd->state_count);
+}
+
 static void genpd_lock_init(struct generic_pm_domain *genpd)
 {
 	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
@@ -2037,21 +2068,13 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 			!genpd_status_on(genpd))
 		return -EINVAL;
 
-	if (genpd_is_cpu_domain(genpd) &&
-	    !zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
-		return -ENOMEM;
-
-	/* Use only one "off" state if there were no states declared */
-	if (genpd->state_count == 0) {
-		ret = genpd_set_default_power_state(genpd);
-		if (ret) {
-			if (genpd_is_cpu_domain(genpd))
-				free_cpumask_var(genpd->cpus);
-			return ret;
-		}
-	} else if (!gov && genpd->state_count > 1) {
+	/* Multiple states but no governor doesn't make sense. */
+	if (!gov && genpd->state_count > 1)
 		pr_warn("%s: no governor for states\n", genpd->name);
-	}
+
+	ret = genpd_alloc_data(genpd);
+	if (ret)
+		return ret;
 
 	device_initialize(&genpd->dev);
 	dev_set_name(&genpd->dev, "%s", genpd->name);
@@ -2096,10 +2119,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	genpd_unlock(genpd);
 	genpd_debug_remove(genpd);
 	cancel_work_sync(&genpd->power_off_work);
-	if (genpd_is_cpu_domain(genpd))
-		free_cpumask_var(genpd->cpus);
-	if (genpd->free_states)
-		genpd->free_states(genpd->states, genpd->state_count);
+	genpd_free_data(genpd);
 
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
 
-- 
2.25.1

