Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B427A5233D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243341AbiEKNRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243273AbiEKNR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:17:28 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DDB737A5;
        Wed, 11 May 2022 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652275046; x=1683811046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lm+eKIBeDfpfN8Uv86tj5uXBOd5B3hzPERCDLOgucSs=;
  b=g8JxvUfOXtrCJUC0Aq/L66J/1Nk3c7yTykgeGWlVeyQkBTDm7PxAC+oU
   OJ+e1pjSGqfwW0ML1X1BZ69dUXXI+zjYameeMVvdmw7WxMkqPxHUTmAsv
   ACK0KZMKIc+763Pt9kDth9P7A1LwqESnWRrY+8c7iTIhfOneD6LsSQTsY
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 May 2022 06:17:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 06:17:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:17:25 -0700
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:17:21 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH v2 2/6] soc: qcom: rpmh-rsc: Attach RSC to cluster PM domain
Date:   Wed, 11 May 2022 18:46:52 +0530
Message-ID: <1652275016-13423-3-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com>
References: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/soc/qcom/rpmh-internal.h |  4 ++-
 drivers/soc/qcom/rpmh-rsc.c      | 67 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 344ba68..cd3d6ce 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -97,7 +97,8 @@ struct rpmh_ctrlr {
  * @rsc_pm:             CPU PM notifier for controller.
  *                      Used when solver mode is not present.
  * @cpus_in_pm:         Number of CPUs not in idle power collapse.
- *                      Used when solver mode is not present.
+ *                      Used when solver mode and "power-domains" is not present.
+ * @genpd_nb:           PM Domain notifier for cluster genpd notifications.
  * @tcs:                TCS groups.
  * @tcs_in_use:         S/W state of the TCS; only set for ACTIVE_ONLY
  *                      transfers, but might show a sleep/wake TCS in use if
@@ -117,6 +118,7 @@ struct rsc_drv {
 	int id;
 	int num_tcs;
 	struct notifier_block rsc_pm;
+	struct notifier_block genpd_nb;
 	atomic_t cpus_in_pm;
 	struct tcs_group tcs[TCS_TYPE_NR];
 	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 01c2f50c..050b5f5c 100644
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
@@ -834,6 +837,50 @@ static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
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
+	/* We don't need to lock as genpd on/off are serialized */
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
+	drv->genpd_nb.notifier_call = rpmh_rsc_pd_callback;
+	ret = dev_pm_genpd_add_notifier(dev, &drv->genpd_nb);
+	if (ret)
+		pm_runtime_disable(dev);
+
+	return ret;
+}
+
 static int rpmh_probe_tcs_config(struct platform_device *pdev,
 				 struct rsc_drv *drv, void __iomem *base)
 {
@@ -963,7 +1010,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 		return ret;
 
 	/*
-	 * CPU PM notification are not required for controllers that support
+	 * CPU PM/genpd notification are not required for controllers that support
 	 * 'HW solver' mode where they can be in autonomous mode executing low
 	 * power mode to power down.
 	 */
@@ -971,8 +1018,14 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	solver_config &= DRV_HW_SOLVER_MASK << DRV_HW_SOLVER_SHIFT;
 	solver_config = solver_config >> DRV_HW_SOLVER_SHIFT;
 	if (!solver_config) {
-		drv->rsc_pm.notifier_call = rpmh_rsc_cpu_pm_callback;
-		cpu_pm_register_notifier(&drv->rsc_pm);
+		if (pdev->dev.pm_domain) {
+			ret = rpmh_rsc_pd_attach(drv, &pdev->dev);
+			if (ret)
+				return ret;
+		} else {
+			drv->rsc_pm.notifier_call = rpmh_rsc_cpu_pm_callback;
+			cpu_pm_register_notifier(&drv->rsc_pm);
+		}
 	}
 
 	/* Enable the active TCS to send requests immediately */
@@ -985,7 +1038,13 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, drv);
 
-	return devm_of_platform_populate(&pdev->dev);
+	ret = devm_of_platform_populate(&pdev->dev);
+	if (ret && pdev->dev.pm_domain) {
+		dev_pm_genpd_remove_notifier(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+
+	return ret;
 }
 
 static const struct of_device_id rpmh_drv_match[] = {
-- 
2.7.4

