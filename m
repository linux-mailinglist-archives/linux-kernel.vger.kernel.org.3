Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6967486886
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbiAFRbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241843AbiAFRbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:31:41 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D1DC0611FD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:31:41 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id o17so3016842qtk.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TDDnwGKq7j79QqZXmn72oSVxIDOX3iu+00Xl+MNaV1M=;
        b=XEPnHUwAT8QfIVWdTQDeLIf0QFldNQzXv8Aj/4H2jwwTm5FXsyYf3UDL95WfEZnzAW
         NotmkqxYEvKgInwT0FOz+qMYeXdppmhnUYU4/P5bgTvHxkO/NRNMsXGROf5kifi9BviF
         4jvf8Z0FbZGB7bC2oIirK/EVZuCFxszao0tcMHu8d9S60gPskTnftUhi5xyip+YTMtSV
         EiAIRGy6wGwXT/cJ5nlfTHu9IGTYUyW81AcTO45PoyM/Il0gopuSHawxh+5e2kK76R2R
         d/WH6W3e8i/D258Iq3dWMJZs3vM3Q/M+HuH4Hs7SwDhvdZiXvWBYxFFqgaT9vjZZA9Th
         7GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDDnwGKq7j79QqZXmn72oSVxIDOX3iu+00Xl+MNaV1M=;
        b=zR3n7vrkZs9+ig6oGUNU2bwhFclIdoUrXyQn54TVgtGcNkt6E47dWerlf2qhdR15de
         hSmyyyPkDIegkOb+HNBcX/2EooshaJAEiL4xdywMU1wKpU189IgNPCjnlM2FDMYLMjEm
         c7uGVEh2NafJBF7lf012EFehMdy4tt0xcgqaOz4DmZKUmCjyVe/REjnZY1ARkTTADFLq
         8PBN7/8S8lJJnjGY83bgYKPqK8ty6gVvkrN98oQhwWBuGODfeNTP8dnBYb6f/clHaTQX
         j/f3xWODFJgidXoc1n9cp/jhD+Wcicw7ZfZk7HEei8vAE6DfP+DXY2b/GLKCzpt9Bp/G
         NAVw==
X-Gm-Message-State: AOAM533Z2q+BSdmFFeWnglr8hih7/fz8yIFFH6XjGIfg+wx5z2FiM/BY
        S2lAJXSutAr/E7ZoSzzGwF2t4Q==
X-Google-Smtp-Source: ABdhPJxDcpuylfy5ph9maf/00Exbhb7Ol9pBq9qIkLWae1lonkx08SVnpHHQ9GDFP+sUQCxF4nl/UA==
X-Received: by 2002:a05:622a:1743:: with SMTP id l3mr50383523qtk.98.1641490300756;
        Thu, 06 Jan 2022 09:31:40 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id i21sm2126536qti.31.2022.01.06.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:31:40 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v3 1/3] thermal: qcom: lmh: Add support for sm8150
Date:   Thu,  6 Jan 2022 12:31:36 -0500
Message-Id: <20220106173138.411097-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106173138.411097-1-thara.gopinath@linaro.org>
References: <20220106173138.411097-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible to support LMh for sm8150 SoC.
sm8150 does not require explicit enabling for various LMh subsystems.
Add a variable indicating the same as match data which is set for sdm845.
Execute the piece of code enabling various LMh subsystems only if
enable algorithm match data is present.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v2->v3:
	- use of_device_get_match_data to get the data from match table
	  rather than using of_match_device and subsequent ->data, as per
	  Bjorn's review comments.
	- Minor fixes as per Bjorn's review comments.

v1->v2:
	- Added LMH_ENABLE_ALGOS of_device_id match data to indicate
	  whether LMh subsytems need explicit enabling or not.
 drivers/thermal/qcom/lmh.c | 62 +++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index eafa7526eb8b..c7f91cbdccc7 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -28,6 +28,8 @@
 
 #define LMH_REG_DCVS_INTR_CLR		0x8
 
+#define LMH_ENABLE_ALGOS		1
+
 struct lmh_hw_data {
 	void __iomem *base;
 	struct irq_domain *domain;
@@ -90,6 +92,7 @@ static int lmh_probe(struct platform_device *pdev)
 	struct device_node *cpu_node;
 	struct lmh_hw_data *lmh_data;
 	int temp_low, temp_high, temp_arm, cpu_id, ret;
+	unsigned int enable_alg;
 	u32 node_id;
 
 	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
@@ -141,32 +144,36 @@ static int lmh_probe(struct platform_device *pdev)
 	if (!qcom_scm_lmh_dcvsh_available())
 		return -EINVAL;
 
-	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
-				 LMH_NODE_DCVS, node_id, 0);
-	if (ret)
-		dev_err(dev, "Error %d enabling current subfunction\n", ret);
-
-	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
-				 LMH_NODE_DCVS, node_id, 0);
-	if (ret)
-		dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
-
-	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
-				 LMH_NODE_DCVS, node_id, 0);
-	if (ret)
-		dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
-
-	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
-				 LMH_NODE_DCVS, node_id, 0);
-	if (ret) {
-		dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
-		return ret;
-	}
-
-	ret = qcom_scm_lmh_profile_change(0x1);
-	if (ret) {
-		dev_err(dev, "Error %d changing profile\n", ret);
-		return ret;
+	enable_alg = (uintptr_t)of_device_get_match_data(dev);
+
+	if (enable_alg) {
+		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
+					 LMH_NODE_DCVS, node_id, 0);
+		if (ret)
+			dev_err(dev, "Error %d enabling current subfunction\n", ret);
+
+		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
+					 LMH_NODE_DCVS, node_id, 0);
+		if (ret)
+			dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
+
+		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
+					 LMH_NODE_DCVS, node_id, 0);
+		if (ret)
+			dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
+
+		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
+					 LMH_NODE_DCVS, node_id, 0);
+		if (ret) {
+			dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
+			return ret;
+		}
+
+		ret = qcom_scm_lmh_profile_change(0x1);
+		if (ret) {
+			dev_err(dev, "Error %d changing profile\n", ret);
+			return ret;
+		}
 	}
 
 	/* Set default thermal trips */
@@ -213,7 +220,8 @@ static int lmh_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id lmh_table[] = {
-	{ .compatible = "qcom,sdm845-lmh", },
+	{ .compatible = "qcom,sdm845-lmh", .data = (void *)LMH_ENABLE_ALGOS},
+	{ .compatible = "qcom,sm8150-lmh", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, lmh_table);
-- 
2.25.1

