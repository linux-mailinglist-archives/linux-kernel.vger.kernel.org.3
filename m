Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB85233E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbiEKNSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbiEKNRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:17:39 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3188A79811;
        Wed, 11 May 2022 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652275058; x=1683811058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6kVqlQi4G/TzQvInKYNo1+uLELfoNzJNr31O8DVh6us=;
  b=X0UFPOHqQXF8DU6RSXnjLdJG5NJjrVMTKpscAx+a6iGx83Z+vlAX8X/O
   yjkypM4C9FsrKqLzfQfBpnKsvcG29swWWPzPZGmiHtD3pp/QvHQQcOE8n
   VtjPLL3Jk/9Blq2jw6+0/rknZHG7cOmzcGoU4OlaV68ObiIrP6itx8JGz
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 May 2022 06:17:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 06:17:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:17:36 -0700
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:17:33 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH v2 5/6] soc: qcom: rpmh-rsc: Save base address of drv
Date:   Wed, 11 May 2022 18:46:55 +0530
Message-ID: <1652275016-13423-6-git-send-email-quic_mkshah@quicinc.com>
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

Add changes to save drv's base address for rsc. This is
used to read drv's configuration such as solver mode is
supported or to write into CONTROL_TCS registers.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/soc/qcom/rpmh-internal.h |  2 ++
 drivers/soc/qcom/rpmh-rsc.c      | 18 ++++++++----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index cd3d6ce..7866bb1 100644
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
@@ -114,6 +115,7 @@ struct rpmh_ctrlr {
  */
 struct rsc_drv {
 	const char *name;
+	void __iomem *base;
 	void __iomem *tcs_base;
 	int id;
 	int num_tcs;
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 050b5f5c..8e01697 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -881,8 +881,7 @@ static int rpmh_rsc_pd_attach(struct rsc_drv *drv, struct device *dev)
 	return ret;
 }
 
-static int rpmh_probe_tcs_config(struct platform_device *pdev,
-				 struct rsc_drv *drv, void __iomem *base)
+static int rpmh_probe_tcs_config(struct platform_device *pdev, struct rsc_drv *drv)
 {
 	struct tcs_type_config {
 		u32 type;
@@ -896,9 +895,9 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 	ret = of_property_read_u32(dn, "qcom,tcs-offset", &offset);
 	if (ret)
 		return ret;
-	drv->tcs_base = base + offset;
+	drv->tcs_base = drv->base + offset;
 
-	config = readl_relaxed(base + DRV_PRNT_CHLD_CONFIG);
+	config = readl_relaxed(drv->base + DRV_PRNT_CHLD_CONFIG);
 
 	max_tcs = config;
 	max_tcs &= DRV_NUM_TCS_MASK << (DRV_NUM_TCS_SHIFT * drv->id);
@@ -960,7 +959,6 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	char drv_id[10] = {0};
 	int ret, irq;
 	u32 solver_config;
-	void __iomem *base;
 
 	/*
 	 * Even though RPMh doesn't directly use cmd-db, all of its children
@@ -987,11 +985,11 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
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
 
@@ -1014,7 +1012,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
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

