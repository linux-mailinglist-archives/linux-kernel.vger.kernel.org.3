Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008CE488B20
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiAIR0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:26:19 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:10682 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbiAIR0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641749163; x=1673285163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bRtDAUR1HBQGClmj5P/NZRMVY4q7jZ9IDnnULdmTqdQ=;
  b=A51ZkWrZivM+QRGp/GwLjlNo7Zk43WZ3wdvQ3UR1BeQ/XloCLeS9yBM7
   53ikIKnMRq2zeRuKIKcyiJyilyA0p226M8saQ5XDPy0Elq6vgrp2EgqD/
   nN5tI4Qf2ehkXCG4Q4uM+BnNJlDZ5h6TRFWu4YMPAH4Q+90vsyAAstR4t
   U=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Jan 2022 09:26:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 09:26:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:56 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:53 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH 10/10] soc: qcom: rpmh-rsc: Write CONTROL_TCS with next timer wakeup
Date:   Sun, 9 Jan 2022 22:55:07 +0530
Message-ID: <1641749107-31979-11-git-send-email-quic_mkshah@quicinc.com>
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

The next wakeup timer value needs to be set in always on domain timer
as the arch timer interrupt can not wakeup the SoC if after the deepest
CPUidle states the SoC also enters deepest low power state.

To wakeup the SoC in such scenarios the earliest wakeup time is set in
CONTROL_TCS and the firmware takes care of setting up its own timer in
always on domain with next wakeup time. The timer wakes up the RSC and
sets resources back to wake state.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/soc/qcom/rpmh-internal.h |  1 +
 drivers/soc/qcom/rpmh-rsc.c      | 60 ++++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c          |  4 ++-
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 6770bbb..04789a37 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -135,6 +135,7 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
 int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 			     const struct tcs_request *msg);
 void rpmh_rsc_invalidate(struct rsc_drv *drv);
+void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 int rpmh_flush(struct rpmh_ctrlr *ctrlr);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c2a7c6c..b3b85f1 100644
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
+	if (!drv->tcs[CONTROL_TCS].num_tcs || !drv->genpd)
+		return;
+
+	/* Set highest time when system (timekeeping) is suspended */
+	if (system_state == SYSTEM_SUSPEND)
+		goto exit;
+
+	/* Find the earliest hrtimer wakeup from online cpus */
+	wakeup = drv->genpd->next_hrtimer;
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

