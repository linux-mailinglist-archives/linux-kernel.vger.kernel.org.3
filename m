Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F424B40E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiBNEet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:34:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiBNEem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:34:42 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A074F9E2;
        Sun, 13 Feb 2022 20:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644813275; x=1676349275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=VSxKBpa0oforUacI1XM33IoNraoM0KyY+yGS684WVMQ=;
  b=JGZ0ayC2xjRG0Yolzyq1y52HLy+4CkiFYYPOgVJLT8CINmtcw0TTqvX3
   I7rA/J8qMMEketmRYP6cMkKrq4rzoqGk0hpks+Clmfx9etDMRdsmRH/Q+
   CrQMnv6lsy9SLB+pPZkYIlgbxIy0sX7GOfNWbPzyWNYRh6hJNx5SEIVys
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 13 Feb 2022 20:34:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 20:34:34 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 13 Feb 2022 20:34:33 -0800
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 13 Feb 2022 20:34:29 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>
CC:     <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <evgreen@chromium.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>, <mka@chromium.org>,
        <krzysztof.kozlowski@canonical.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 2/3] remoteproc: qcom_q6v5_mss: Add support for interconnect bandwidth voting
Date:   Mon, 14 Feb 2022 10:04:11 +0530
Message-ID: <1644813252-12897-3-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644813252-12897-1-git-send-email-quic_sibis@quicinc.com>
References: <1644813252-12897-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for proxy interconnect bandwidth votes during modem bootup on
SC7280 SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 95 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index a2c231a17b2b..5a37628311c6 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -12,6 +12,7 @@
 #include <linux/devcoredump.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/interconnect.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -125,6 +126,18 @@
 #define QDSP6SS_BOOT_CMD                0x404
 #define BOOT_FSM_TIMEOUT                10000
 
+struct interconnect_info {
+	struct icc_path *path;
+	u32 average_bandwidth;
+	u32 peak_bandwidth;
+};
+
+struct qcom_mss_icc_res {
+	const char *name;
+	u32 average_bandwidth;
+	u32 peak_bandwidth;
+};
+
 struct reg_info {
 	struct regulator *reg;
 	int uV;
@@ -142,6 +155,7 @@ struct rproc_hexagon_res {
 	struct qcom_mss_reg_res *proxy_supply;
 	struct qcom_mss_reg_res *fallback_proxy_supply;
 	struct qcom_mss_reg_res *active_supply;
+	struct qcom_mss_icc_res *proxy_path;
 	char **proxy_clk_names;
 	char **reset_clk_names;
 	char **active_clk_names;
@@ -202,6 +216,9 @@ struct q6v5 {
 	int proxy_reg_count;
 	int fallback_proxy_reg_count;
 
+	struct interconnect_info interconnect[1];
+	int proxy_path_count;
+
 	bool dump_mba_loaded;
 	size_t current_dump_size;
 	size_t total_dump_size;
@@ -267,6 +284,29 @@ static int q6v5_regulator_init(struct device *dev, struct reg_info *regs,
 	return i;
 }
 
+static int q6v5_interconnect_init(struct device *dev, struct interconnect_info *interconnect,
+				  const struct qcom_mss_icc_res *icc_res)
+{
+	struct icc_path *path;
+	int i;
+
+	for (i = 0; icc_res[i].name; i++) {
+		path = devm_of_icc_get(dev, icc_res[i].name);
+		if (IS_ERR(path)) {
+			int ret = PTR_ERR(path);
+
+			dev_err_probe(dev, ret, "Failed to get %s interconnect\n", icc_res[i].name);
+			return ret;
+		}
+
+		interconnect[i].path = path;
+		interconnect[i].average_bandwidth = icc_res[i].average_bandwidth;
+		interconnect[i].peak_bandwidth = icc_res[i].peak_bandwidth;
+	}
+
+	return i;
+}
+
 static int q6v5_regulator_enable(struct q6v5 *qproc,
 				 struct reg_info *regs, int count)
 {
@@ -364,6 +404,36 @@ static void q6v5_clk_disable(struct device *dev,
 		clk_disable_unprepare(clks[i]);
 }
 
+static int q6v5_icc_enable(struct device *dev, struct interconnect_info *interconnect, int count)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		ret = icc_set_bw(interconnect[i].path, interconnect[i].average_bandwidth,
+				 interconnect[i].peak_bandwidth);
+		if (ret)
+			dev_err(dev, "Failed enabling %s interconnect\n",
+				icc_get_name(interconnect[i].path));
+		goto err;
+	}
+
+	return 0;
+err:
+	for (i--; i >= 0; i--)
+		icc_set_bw(interconnect[i].path, 0, 0);
+
+	return ret;
+}
+
+static void q6v5_icc_disable(struct device *dev, struct interconnect_info *interconnect, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		icc_set_bw(interconnect[i].path, 0, 0);
+}
+
 static int q6v5_pds_enable(struct q6v5 *qproc, struct device **pds,
 			   size_t pd_count)
 {
@@ -1011,10 +1081,14 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 	if (ret)
 		return ret;
 
+	ret = q6v5_icc_enable(qproc->dev, qproc->interconnect, qproc->proxy_path_count);
+	if (ret)
+		goto disable_irqs;
+
 	ret = q6v5_pds_enable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
 	if (ret < 0) {
 		dev_err(qproc->dev, "failed to enable proxy power domains\n");
-		goto disable_irqs;
+		goto disable_path;
 	}
 
 	ret = q6v5_regulator_enable(qproc, qproc->fallback_proxy_regs,
@@ -1158,6 +1232,8 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 			       qproc->fallback_proxy_reg_count);
 disable_proxy_pds:
 	q6v5_pds_disable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
+disable_path:
+	q6v5_icc_disable(qproc->dev, qproc->interconnect, qproc->proxy_path_count);
 disable_irqs:
 	qcom_q6v5_unprepare(&qproc->q6v5);
 
@@ -1232,6 +1308,7 @@ static void q6v5_mba_reclaim(struct q6v5 *qproc)
 				       qproc->fallback_proxy_reg_count);
 		q6v5_regulator_disable(qproc, qproc->proxy_regs,
 				       qproc->proxy_reg_count);
+		q6v5_icc_disable(qproc->dev, qproc->interconnect, qproc->proxy_path_count);
 	}
 }
 
@@ -1611,6 +1688,7 @@ static void qcom_msa_handover(struct qcom_q6v5 *q6v5)
 	q6v5_regulator_disable(qproc, qproc->fallback_proxy_regs,
 			       qproc->fallback_proxy_reg_count);
 	q6v5_pds_disable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
+	q6v5_icc_disable(qproc->dev, qproc->interconnect, qproc->proxy_path_count);
 }
 
 static int q6v5_init_mem(struct q6v5 *qproc, struct platform_device *pdev)
@@ -1942,6 +2020,13 @@ static int q6v5_probe(struct platform_device *pdev)
 	}
 	qproc->active_reg_count = ret;
 
+	ret = q6v5_interconnect_init(&pdev->dev, qproc->interconnect, desc->proxy_path);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to get proxy interconnects.\n");
+		goto free_rproc;
+	}
+	qproc->proxy_path_count = ret;
+
 	ret = q6v5_pds_attach(&pdev->dev, qproc->proxy_pds,
 			      desc->proxy_pd_names);
 	/* Fallback to regulators for old device trees */
@@ -2077,6 +2162,14 @@ static const struct rproc_hexagon_res sc7280_mss = {
 		"mss",
 		NULL
 	},
+	.proxy_path = (struct qcom_mss_icc_res[]) {
+		{
+			.name = "imem",
+			.average_bandwidth = 0,
+			.peak_bandwidth = 8532000,
+		},
+		{}
+	},
 	.need_mem_protection = true,
 	.has_alt_reset = false,
 	.has_mba_logs = true,
-- 
2.7.4

