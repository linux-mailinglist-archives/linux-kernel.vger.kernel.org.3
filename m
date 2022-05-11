Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444185233E2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243405AbiEKNSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243402AbiEKNSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:18:00 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DF88FD67;
        Wed, 11 May 2022 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652275061; x=1683811061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7veflo9UbLlxTRHyg/FB//3GlHN50TVblda+zNS/H24=;
  b=j8mWWNNhcY3bcklZ6HZFFkEHqRh2xh9OCqpVRnS5pGi1YlL1Q8x0X5Ax
   4H5AKQ6VK8BHc71ANijk06m+DWmmkqSkKj9eEfVoDcFoSNXXOwegWvZYH
   0yc8w9RCSohzDyYQ+B6vTL1ofoHYjXPALHqHpdGSAJh0vuPq2mIoYbL8j
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 May 2022 06:17:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 06:17:40 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:17:40 -0700
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:17:36 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH v2 6/6] soc: qcom: rpmh-rsc: Write CONTROL_TCS with next timer wakeup
Date:   Wed, 11 May 2022 18:46:56 +0530
Message-ID: <1652275016-13423-7-git-send-email-quic_mkshah@quicinc.com>
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

The next wakeup timer value needs to be set in always on domain timer
as the arch timer interrupt can not wakeup the SoC if after the deepest
CPUidle states the SoC also enters deepest low power state.

To wakeup the SoC in such scenarios the earliest wakeup time is set in
CONTROL_TCS and the firmware takes care of setting up its own timer in
always on domain with next wakeup time. The timer wakes up the RSC and
sets resources back to wake state.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/soc/qcom/rpmh-internal.h |  3 ++
 drivers/soc/qcom/rpmh-rsc.c      | 61 ++++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c          |  4 ++-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 7866bb1..39f5358 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -112,6 +112,7 @@ struct rpmh_ctrlr {
  * @tcs_wait:           Wait queue used to wait for @tcs_in_use to free up a
  *                      slot
  * @client:             Handle to the DRV's client.
+ * @dev:                RSC device.
  */
 struct rsc_drv {
 	const char *name;
@@ -127,12 +128,14 @@ struct rsc_drv {
 	spinlock_t lock;
 	wait_queue_head_t tcs_wait;
 	struct rpmh_ctrlr client;
+	struct device *dev;
 };
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
 int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 			     const struct tcs_request *msg);
 void rpmh_rsc_invalidate(struct rsc_drv *drv);
+void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 int rpmh_flush(struct rpmh_ctrlr *ctrlr);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 8e01697..25b838b 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
@@ -25,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 
+#include <clocksource/arm_arch_timer.h>
 #include <soc/qcom/cmd-db.h>
 #include <soc/qcom/tcs.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -49,6 +51,14 @@
 #define DRV_NCPT_MASK			0x1F
 #define DRV_NCPT_SHIFT			27
 
+/* Offsets for CONTROL TCS Registers */
+#define RSC_DRV_CTL_TCS_DATA_HI		0x38
+#define RSC_DRV_CTL_TCS_DATA_HI_MASK	0xFFFFFF
+#define RSC_DRV_CTL_TCS_DATA_HI_VALID	BIT(31)
+#define RSC_DRV_CTL_TCS_DATA_LO		0x40
+#define RSC_DRV_CTL_TCS_DATA_LO_MASK	0xFFFFFFFF
+#define RSC_DRV_CTL_TCS_DATA_SIZE	32
+
 /* Offsets for common TCS Registers, one bit per TCS */
 #define RSC_DRV_IRQ_ENABLE		0x00
 #define RSC_DRV_IRQ_STATUS		0x04
@@ -142,6 +152,14 @@
  *  +---------------------------------------------------+
  */
 
+#define USECS_TO_CYCLES(time_usecs)			\
+	xloops_to_cycles((time_usecs) * 0x10C7UL)
+
+static inline unsigned long xloops_to_cycles(unsigned long xloops)
+{
+	return (xloops * loops_per_jiffy * HZ) >> 32;
+}
+
 static inline void __iomem *
 tcs_reg_addr(const struct rsc_drv *drv, int reg, int tcs_id)
 {
@@ -757,6 +775,48 @@ static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
 }
 
 /**
+ * rpmh_rsc_write_next_wakeup() - Write next wakeup in CONTROL_TCS.
+ * @drv: The controller
+ *
+ * Writes maximum wakeup cycles when called from suspend.
+ * Writes earliest hrtimer wakeup when called from idle.
+ */
+void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
+{
+	ktime_t now, wakeup;
+	u64 wakeup_us, wakeup_cycles = ~0;
+	u32 lo, hi;
+
+	if (!drv->tcs[CONTROL_TCS].num_tcs || !drv->genpd_nb.notifier_call)
+		return;
+
+	/* Set highest time when system (timekeeping) is suspended */
+	if (system_state == SYSTEM_SUSPEND)
+		goto exit;
+
+	/* Find the earliest hrtimer wakeup from online cpus */
+	wakeup = dev_pm_genpd_get_next_hrtimer(drv->dev);
+
+	/* Find the relative wakeup in kernel time scale */
+	now = ktime_get();
+	wakeup = ktime_sub(wakeup, now);
+	wakeup_us = ktime_to_us(wakeup);
+
+	/* Convert the wakeup to arch timer scale */
+	wakeup_cycles = USECS_TO_CYCLES(wakeup_us);
+	wakeup_cycles += arch_timer_read_counter();
+
+exit:
+	lo = wakeup_cycles & RSC_DRV_CTL_TCS_DATA_LO_MASK;
+	hi = wakeup_cycles >> RSC_DRV_CTL_TCS_DATA_SIZE;
+	hi &= RSC_DRV_CTL_TCS_DATA_HI_MASK;
+	hi |= RSC_DRV_CTL_TCS_DATA_HI_VALID;
+
+	writel_relaxed(lo, drv->base + RSC_DRV_CTL_TCS_DATA_LO);
+	writel_relaxed(hi, drv->base + RSC_DRV_CTL_TCS_DATA_HI);
+}
+
+/**
  * rpmh_rsc_cpu_pm_callback() - Check if any of the AMCs are busy.
  * @nfb:    Pointer to the notifier block in struct rsc_drv.
  * @action: CPU_PM_ENTER, CPU_PM_ENTER_FAILED, or CPU_PM_EXIT.
@@ -1035,6 +1095,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&drv->client.batch_cache);
 
 	dev_set_drvdata(&pdev->dev, drv);
+	drv->dev = &pdev->dev;
 
 	ret = devm_of_platform_populate(&pdev->dev);
 	if (ret && pdev->dev.pm_domain) {
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 01765ee..3a53ed9 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -450,7 +450,7 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 
 	if (!ctrlr->dirty) {
 		pr_debug("Skipping flush, TCS has latest data.\n");
-		goto exit;
+		goto write_next_wakeup;
 	}
 
 	/* Invalidate the TCSes first to avoid stale data */
@@ -479,6 +479,8 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 
 	ctrlr->dirty = false;
 
+write_next_wakeup:
+	rpmh_rsc_write_next_wakeup(ctrlr_to_drv(ctrlr));
 exit:
 	spin_unlock(&ctrlr->cache_lock);
 	return ret;
-- 
2.7.4

