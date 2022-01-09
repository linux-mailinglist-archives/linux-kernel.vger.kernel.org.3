Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A54488B27
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiAIR0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:26:32 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:10682 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiAIR0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641749178; x=1673285178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/j1ASWSSJnXUTMxZV8H1PViy5nXzvpI1Nl6Bv6aBACo=;
  b=ZkCkKse3YMIGM91wyey6lTRlbCsbCvsgLddSnwoQzW7Wakm7SWPtXP12
   Vf/3oVi4eqLiPpgb78Z0ZunFioxlWH2oLfwe3pKspKaLau1swwBUdqvSJ
   r5xx6nFGytmguUwspbHNKZNXI9CAJ3TTQurBudQXeYAAh7ONZ41Hu30fn
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Jan 2022 09:26:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 09:26:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:53 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:50 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH 09/10] soc: qcom: rpmh-rsc: Save base address of drv
Date:   Sun, 9 Jan 2022 22:55:06 +0530
Message-ID: <1641749107-31979-10-git-send-email-quic_mkshah@quicinc.com>
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

Add changes to save drv's base address for rsc. This is
used to read drv's configuration such as solver mode is
supported or to write into CONTROL_TCS registers.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/soc/qcom/rpmh-internal.h |  2 ++
 drivers/soc/qcom/rpmh-rsc.c      | 18 ++++++++----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 32ac117..6770bbb 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -91,6 +91,7 @@ struct rpmh_ctrlr {
  * Resource State Coordinator controller (RSC)
  *
  * @name:               Controller identifier.
+ * @base:               Start address of the DRV registers in this controller.
  * @tcs_base:           Start address of the TCS registers in this controller.
  * @id:                 Instance id in the controller (Direct Resource Voter).
  * @num_tcs:            Number of TCSes in this DRV.
@@ -115,6 +116,7 @@ struct rpmh_ctrlr {
  */
 struct rsc_drv {
 	const char *name;
+	void __iomem *base;
 	void __iomem *tcs_base;
 	int id;
 	int num_tcs;
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 5875ad5..c2a7c6c 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -882,8 +882,7 @@ static int rpmh_rsc_pd_attach(struct rsc_drv *drv, struct device *dev)
 	return dev_pm_genpd_add_notifier(dev, &drv->genpd_nb);
 }
 
-static int rpmh_probe_tcs_config(struct platform_device *pdev,
-				 struct rsc_drv *drv, void __iomem *base)
+static int rpmh_probe_tcs_config(struct platform_device *pdev, struct rsc_drv *drv)
 {
 	struct tcs_type_config {
 		u32 type;
@@ -897,9 +896,9 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 	ret = of_property_read_u32(dn, "qcom,tcs-offset", &offset);
 	if (ret)
 		return ret;
-	drv->tcs_base = base + offset;
+	drv->tcs_base = drv->base + offset;
 
-	config = readl_relaxed(base + DRV_PRNT_CHLD_CONFIG);
+	config = readl_relaxed(drv->base + DRV_PRNT_CHLD_CONFIG);
 
 	max_tcs = config;
 	max_tcs &= DRV_NUM_TCS_MASK << (DRV_NUM_TCS_SHIFT * drv->id);
@@ -961,7 +960,6 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	char drv_id[10] = {0};
 	int ret, irq;
 	u32 solver_config;
-	void __iomem *base;
 
 	/*
 	 * Even though RPMh doesn't directly use cmd-db, all of its children
@@ -988,11 +986,11 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 		drv->name = dev_name(&pdev->dev);
 
 	snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
-	base = devm_platform_ioremap_resource_byname(pdev, drv_id);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	drv->base = devm_platform_ioremap_resource_byname(pdev, drv_id);
+	if (IS_ERR(drv->base))
+		return PTR_ERR(drv->base);
 
-	ret = rpmh_probe_tcs_config(pdev, drv, base);
+	ret = rpmh_probe_tcs_config(pdev, drv);
 	if (ret)
 		return ret;
 
@@ -1015,7 +1013,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	 * 'HW solver' mode where they can be in autonomous mode executing low
 	 * power mode to power down.
 	 */
-	solver_config = readl_relaxed(base + DRV_SOLVER_CONFIG);
+	solver_config = readl_relaxed(drv->base + DRV_SOLVER_CONFIG);
 	solver_config &= DRV_HW_SOLVER_MASK << DRV_HW_SOLVER_SHIFT;
 	solver_config = solver_config >> DRV_HW_SOLVER_SHIFT;
 	if (!solver_config) {
-- 
2.7.4

