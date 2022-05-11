Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE75233DB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiEKNRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbiEKNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:17:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C757FF4D;
        Wed, 11 May 2022 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652275054; x=1683811054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=CsA9J9o/MgpNUx2wSs9ZCX8chdCnY07Hkflhf2D+yLk=;
  b=B7QXLNF2FmTD34k6Koi9CMOWVc77U6zupY1ZbGwt7PlNk+qROdhfYUeR
   kVO0b+cOTB+vEunBKJdahAKmjhokxSnh+7fCqJFi2lLa3rwJpHIAw401/
   NuOkAsZQVu1klOD5I5DFFEP+y7CGB6SCJTDRtio3ivKsNyRSwC5HMhtcT
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 May 2022 06:17:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 06:17:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:17:33 -0700
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:17:29 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH v2 4/6] PM: domains: Store the closest hrtimer event of the domain CPUs
Date:   Wed, 11 May 2022 18:46:54 +0530
Message-ID: <1652275016-13423-5-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com>
References: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch timer can not wake up the Qualcomm Technologies, Inc. (QTI)
SoCs when the deepest CPUidle modes results in the SoC also to enter
the low power mode.

RSC is part of CPU subsystem and APSS rsc device is attached to cluster
power domain. RSC has to setup next hrtimer wakeup in CONTROL_TCS which
can wakeup the SoC from deepest low power states. The CONTROL_TCS does
this by writing next wakeup in always on domain timer when the SoC is
entering the low power state.

Add dev_pm_genpd_get_next_hrtimer() to get the genpd wakeup time.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/base/power/domain.c          | 24 ++++++++++++++++++++++++
 drivers/base/power/domain_governor.c |  1 +
 include/linux/pm_domain.h            |  7 +++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 18cd796..f0d70d0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -487,6 +487,29 @@ void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
 
+/**
+ * dev_pm_genpd_get_next_hrtimer - Return genpd domain next_hrtimer.
+ *
+ * @dev: Device to handle
+ *
+ * Returns the aggregated domain wakeup time for CPU PM domain
+ * when all the subdomains are off.
+ */
+ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return KTIME_MAX;
+
+	if (atomic_read(&genpd->sd_count) > 0)
+		return KTIME_MAX;
+
+	return genpd->next_hrtimer;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_get_next_hrtimer);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -1998,6 +2021,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->max_off_time_changed = true;
 	genpd->provider = NULL;
 	genpd->has_provider = false;
+	genpd->next_hrtimer = KTIME_MAX;
 	genpd->accounting_time = ktime_get_mono_fast_ns();
 	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
 	genpd->domain.ops.runtime_resume = genpd_runtime_resume;
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index cd08c58..a4c7dd8 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -363,6 +363,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 				domain_wakeup = next_hrtimer;
 		}
 	}
+	genpd->next_hrtimer = domain_wakeup;
 
 	/* The minimum idle duration is from now - until the next wakeup. */
 	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 043d48e..6d9fb79 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -17,6 +17,7 @@
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
+#include <linux/time64.h>
 
 /*
  * Flags to control the behaviour of a genpd.
@@ -136,6 +137,7 @@ struct generic_pm_domain {
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	ktime_t next_wakeup;	/* Maintained by the domain governor */
+	ktime_t next_hrtimer;	/* Next hrtimer for the CPU PM domain */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
 	bool cached_power_down_state_idx;
@@ -228,6 +230,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
 void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
+ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -289,6 +292,10 @@ static inline int dev_pm_genpd_remove_notifier(struct device *dev)
 static inline void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
 { }
 
+static inline ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
+{
+	return KTIME_MAX;
+}
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.7.4

