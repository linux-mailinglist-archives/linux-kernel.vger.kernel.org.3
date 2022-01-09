Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC4488B28
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiAIR0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:26:41 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:43026 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiAIR0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641749178; x=1673285178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NFcYIx9++qhumrrl4CNqWQ3EU5+nnEC/KIO7YgYlBHg=;
  b=N4IOPPa0JuiLzOWFYS6WciD/muU1urKeB7er/AHexOYHzMh/H+7KrO1o
   o5Hmr6Miki1cPC/ewrTHMZN5FAhgFyOEjTuu+O+zbYjxXKjeRW5XBv6hW
   8sYoDkhASUg5EOpy56ueoKXSbZ8/1VLMgUhRkDv3VTP3uOsAQ3mJtdrOb
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Jan 2022 09:26:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 09:26:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:42 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:39 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH 06/10] soc: qcom: rpmh-rsc: Attach RSC to cluster PM domain
Date:   Sun, 9 Jan 2022 22:55:03 +0530
Message-ID: <1641749107-31979-7-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

RSC is part the CPU subsystem and powers off the CPU domains when all
the CPUs and no RPMH transactions are pending from any of the drivers.
The RSC needs to flush the 'sleep' and 'wake' votes that are critical
for saving power when all the CPUs are in idle.

Let's make RSC part of the CPU PM domains, by attaching it to the
cluster power domain. Registering for PM domain notifications, RSC
driver can be notified that the last CPU is powering down. When the last
CPU is powering down the domain, let's flush the 'sleep' and 'wake'
votes that are stored in the data buffers into the hardware and also
write next wakeup in CONTROL_TCS.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/soc/qcom/rpmh-internal.h |  6 +++-
 drivers/soc/qcom/rpmh-rsc.c      | 60 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 344ba68..32ac117 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -97,7 +97,9 @@ struct rpmh_ctrlr {
  * @rsc_pm:             CPU PM notifier for controller.
  *                      Used when solver mode is not present.
  * @cpus_in_pm:         Number of CPUs not in idle power collapse.
- *                      Used when solver mode is not present.
+ *                      Used when solver mode and "power-domains" is not present.
+ * @genpd_nb:           PM Domain notifier for cluster genpd notifications.
+ * @genpdb:             PM Domain for cluster genpd.
  * @tcs:                TCS groups.
  * @tcs_in_use:         S/W state of the TCS; only set for ACTIVE_ONLY
  *                      transfers, but might show a sleep/wake TCS in use if
@@ -117,6 +119,8 @@ struct rsc_drv {
 	int id;
 	int num_tcs;
 	struct notifier_block rsc_pm;
+	struct notifier_block genpd_nb;
+	struct generic_pm_domain *genpd;
 	atomic_t cpus_in_pm;
 	struct tcs_group tcs[TCS_TYPE_NR];
 	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 01c2f50c..5875ad5 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -14,10 +14,13 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
@@ -834,6 +837,51 @@ static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
 	return ret;
 }
 
+/**
+ * rpmh_rsc_pd_callback() - Check if any of the AMCs are busy.
+ * @nfb:    Pointer to the genpd notifier block in struct rsc_drv.
+ * @action: GENPD_NOTIFY_PRE_OFF, GENPD_NOTIFY_OFF, GENPD_NOTIFY_PRE_ON or GENPD_NOTIFY_ON.
+ * @v:      Unused
+ *
+ * This function is given to dev_pm_genpd_add_notifier() so we can be informed
+ * about when cluster-pd is going down. When cluster go down we know no more active
+ * transfers will be started so we write sleep/wake sets. This function gets
+ * called from cpuidle code paths and also at system suspend time.
+ *
+ * If AMCs are not busy then writes cached sleep and wake messages to TCSes.
+ * The firmware then takes care of triggering them when entering deepest low power modes.
+ *
+ * Return:
+ * * NOTIFY_OK          - success
+ * * NOTIFY_BAD         - failure
+ */
+static int rpmh_rsc_pd_callback(struct notifier_block *nfb,
+				unsigned long action, void *v)
+{
+	struct rsc_drv *drv = container_of(nfb, struct rsc_drv, genpd_nb);
+
+	/* We don't need to lock as domin on/off are serialized */
+	if ((action == GENPD_NOTIFY_PRE_OFF) &&
+	    (rpmh_rsc_ctrlr_is_busy(drv) || rpmh_flush(&drv->client)))
+		return NOTIFY_BAD;
+
+	return NOTIFY_OK;
+}
+
+static int rpmh_rsc_pd_attach(struct rsc_drv *drv, struct device *dev)
+{
+	int ret;
+
+	pm_runtime_enable(dev);
+	ret = dev_pm_domain_attach(dev, false);
+	if (ret)
+		return ret;
+
+	drv->genpd = pd_to_genpd(dev->pm_domain);
+	drv->genpd_nb.notifier_call = rpmh_rsc_pd_callback;
+	return dev_pm_genpd_add_notifier(dev, &drv->genpd_nb);
+}
+
 static int rpmh_probe_tcs_config(struct platform_device *pdev,
 				 struct rsc_drv *drv, void __iomem *base)
 {
@@ -963,7 +1011,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 		return ret;
 
 	/*
-	 * CPU PM notification are not required for controllers that support
+	 * CPU PM/genpd notification are not required for controllers that support
 	 * 'HW solver' mode where they can be in autonomous mode executing low
 	 * power mode to power down.
 	 */
@@ -971,8 +1019,14 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	solver_config &= DRV_HW_SOLVER_MASK << DRV_HW_SOLVER_SHIFT;
 	solver_config = solver_config >> DRV_HW_SOLVER_SHIFT;
 	if (!solver_config) {
-		drv->rsc_pm.notifier_call = rpmh_rsc_cpu_pm_callback;
-		cpu_pm_register_notifier(&drv->rsc_pm);
+		if (of_find_property(dn, "power-domains", NULL)) {
+			ret = rpmh_rsc_pd_attach(drv, &pdev->dev);
+			if (ret)
+				return ret;
+		} else {
+			drv->rsc_pm.notifier_call = rpmh_rsc_cpu_pm_callback;
+			cpu_pm_register_notifier(&drv->rsc_pm);
+		}
 	}
 
 	/* Enable the active TCS to send requests immediately */
-- 
2.7.4

