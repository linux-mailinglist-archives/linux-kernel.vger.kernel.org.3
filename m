Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B166E474F15
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbhLOAX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbhLOAX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:23:56 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D962C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:23:56 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id l10so7669447pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vHeiVK+B5X26/eDFKMWCp3RcUk0jd/ezzsySGzwPHjU=;
        b=Ojk3t0suV2kG+ucMhqSiDTdqGdmvtOghzs5xS5DDg5H0wXZTtym5ngBU+9NA3S0nnw
         s3LptuBWIJrBmBpav9yOdaJd7233DYzdslKBQZslHjXxevtCgdbADNOD07HH6QdrSoh3
         Dr8TAL5Nv4c7iaLLtBtjmr53cUNKiN2qqq6Vh/iFtOFRWEjXJmItA6uv+fW/ojgOW28Y
         E/FA/NfezD+Qgr/Mp+LEeVX2tvGGGYF/ySCbbOQVecDFoAKr9l84gtQW2gOlVZFsJxtN
         /E9h2zb5K0aF/NCu1/5I85f4qSBQaaTkHUxGK5+4HGPQxzyFrOA/aYJ0YsuRAbhXxNbP
         fBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vHeiVK+B5X26/eDFKMWCp3RcUk0jd/ezzsySGzwPHjU=;
        b=LLUOY3tirXQtmMzwA0zDHtRx9v6pbYNO1X9h0jWHvULxm94PK6Afly1giF8hzaqU7i
         g5dxFjULCSAdnvP5PL3n6U61mz7zvnPzng/oPauCGOyV3dbiOZaSWmpYHsi6mRjJFQYe
         Zhgr7qEUjWBV93HazGhPsKnHHMcC7w3FsRNLDgABR/glwx1kDLp2AM96GmzinzgxqS4h
         //0fAWntRwIEaj05e41h9YAl4VGK5y8Ec+TWFpANcQfym/gCnbZfKUzalGAemkWE2zCe
         i6w+yTGPUgyIxiGCTqZ+Owndwb2898IXSKUez4Hu4ZPx4cB+ne2J8OjiWYsxZ4FQDrkK
         53FA==
X-Gm-Message-State: AOAM530vKMUjUEeIo0mhQDSHk1xn6IGbfU5V8S52+4g4AT4DiSvAKq33
        bj3Vhi1d+uvsa/l+4o6Wtefnph9CqokT+q4v
X-Google-Smtp-Source: ABdhPJyd6I9bRI3W0gJLg014VgI6b8lVPAaUVkInfqDlHvnJUGm9+V0b+Qqjg31MATFr/1YOi4EEgA==
X-Received: by 2002:a62:7c8b:0:b0:49f:a8ae:de33 with SMTP id x133-20020a627c8b000000b0049fa8aede33mr6698920pfc.29.1639527835863;
        Tue, 14 Dec 2021 16:23:55 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id a12sm185840pgg.28.2021.12.14.16.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:23:47 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v4 1/5] interconnect: icc-rpm: Define ICC device type
Date:   Wed, 15 Dec 2021 08:23:20 +0800
Message-Id: <20211215002324.1727-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215002324.1727-1-shawn.guo@linaro.org>
References: <20211215002324.1727-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently uses .is_bimc_node to distinguish device type BIMC
from NOC.  Define type for bus/noc devices like what downstream[1] does
to make support for more types easier.

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.19/tree/drivers/soc/qcom/msm_bus/msm_bus_core.h?h=kernel.lnx.4.19.r22-rel#n46

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c |  4 ++--
 drivers/interconnect/qcom/icc-rpm.h | 11 ++++++++---
 drivers/interconnect/qcom/msm8916.c |  4 +++-
 drivers/interconnect/qcom/msm8939.c |  5 ++++-
 drivers/interconnect/qcom/msm8996.c |  9 ++++++++-
 drivers/interconnect/qcom/sdm660.c  |  7 ++++++-
 6 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 939045f7c349..429c377231e6 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -164,7 +164,7 @@ static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
 
 	dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
 
-	if (qp->is_bimc_node)
+	if (qp->type == QCOM_ICC_BIMC)
 		return qcom_icc_set_bimc_qos(node, sum_bw);
 
 	return qcom_icc_set_noc_qos(node, sum_bw);
@@ -309,7 +309,7 @@ int qnoc_probe(struct platform_device *pdev)
 		qp->bus_clks[i].id = cds[i];
 	qp->num_clks = cd_num;
 
-	qp->is_bimc_node = desc->is_bimc_node;
+	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
 
 	if (desc->regmap_cfg) {
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index fd06a3b9e3f7..2268777348cb 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -12,19 +12,24 @@
 #define to_qcom_provider(_provider) \
 	container_of(_provider, struct qcom_icc_provider, provider)
 
+enum qcom_icc_type {
+	QCOM_ICC_NOC,
+	QCOM_ICC_BIMC,
+};
+
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
  * @bus_clks: the clk_bulk_data table of bus clocks
  * @num_clks: the total number of clk_bulk_data entries
- * @is_bimc_node: indicates whether to use bimc specific setting
+ * @type: the ICC provider type
  * @qos_offset: offset to QoS registers
  * @regmap: regmap for QoS registers read/write access
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
 	int num_clks;
-	bool is_bimc_node;
+	enum qcom_icc_type type;
 	struct regmap *regmap;
 	unsigned int qos_offset;
 	struct clk_bulk_data bus_clks[];
@@ -78,7 +83,7 @@ struct qcom_icc_desc {
 	const char * const *clocks;
 	size_t num_clocks;
 	bool has_bus_pd;
-	bool is_bimc_node;
+	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
 	unsigned int qos_offset;
 };
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index e3c995b11357..2f397a7c3322 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -1229,6 +1229,7 @@ static const struct regmap_config msm8916_snoc_regmap_config = {
 };
 
 static struct qcom_icc_desc msm8916_snoc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = msm8916_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
 	.regmap_cfg = &msm8916_snoc_regmap_config,
@@ -1256,9 +1257,9 @@ static const struct regmap_config msm8916_bimc_regmap_config = {
 };
 
 static struct qcom_icc_desc msm8916_bimc = {
+	.type = QCOM_ICC_BIMC,
 	.nodes = msm8916_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
-	.is_bimc_node = true,
 	.regmap_cfg = &msm8916_bimc_regmap_config,
 	.qos_offset = 0x8000,
 };
@@ -1325,6 +1326,7 @@ static const struct regmap_config msm8916_pcnoc_regmap_config = {
 };
 
 static struct qcom_icc_desc msm8916_pcnoc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = msm8916_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_pcnoc_nodes),
 	.regmap_cfg = &msm8916_pcnoc_regmap_config,
diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index 16272a477bd8..d188f3636e4c 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -1282,6 +1282,7 @@ static const struct regmap_config msm8939_snoc_regmap_config = {
 };
 
 static struct qcom_icc_desc msm8939_snoc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_nodes),
 	.regmap_cfg = &msm8939_snoc_regmap_config,
@@ -1309,6 +1310,7 @@ static const struct regmap_config msm8939_snoc_mm_regmap_config = {
 };
 
 static struct qcom_icc_desc msm8939_snoc_mm = {
+	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_snoc_mm_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_mm_nodes),
 	.regmap_cfg = &msm8939_snoc_mm_regmap_config,
@@ -1336,9 +1338,9 @@ static const struct regmap_config msm8939_bimc_regmap_config = {
 };
 
 static struct qcom_icc_desc msm8939_bimc = {
+	.type = QCOM_ICC_BIMC,
 	.nodes = msm8939_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_bimc_nodes),
-	.is_bimc_node = true,
 	.regmap_cfg = &msm8939_bimc_regmap_config,
 	.qos_offset = 0x8000,
 };
@@ -1407,6 +1409,7 @@ static const struct regmap_config msm8939_pcnoc_regmap_config = {
 };
 
 static struct qcom_icc_desc msm8939_pcnoc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_pcnoc_nodes),
 	.regmap_cfg = &msm8939_pcnoc_regmap_config,
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index d8248ebdf6b3..499e11fbbd2e 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -1811,6 +1811,7 @@ static const struct regmap_config msm8996_a0noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc msm8996_a0noc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = a0noc_nodes,
 	.num_nodes = ARRAY_SIZE(a0noc_nodes),
 	.clocks = bus_a0noc_clocks,
@@ -1834,6 +1835,7 @@ static const struct regmap_config msm8996_a1noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc msm8996_a1noc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = a1noc_nodes,
 	.num_nodes = ARRAY_SIZE(a1noc_nodes),
 	.regmap_cfg = &msm8996_a1noc_regmap_config
@@ -1854,6 +1856,7 @@ static const struct regmap_config msm8996_a2noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc msm8996_a2noc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(a2noc_nodes),
 	.regmap_cfg = &msm8996_a2noc_regmap_config
@@ -1879,9 +1882,9 @@ static const struct regmap_config msm8996_bimc_regmap_config = {
 };
 
 static const struct qcom_icc_desc msm8996_bimc = {
+	.type = QCOM_ICC_BIMC,
 	.nodes = bimc_nodes,
 	.num_nodes = ARRAY_SIZE(bimc_nodes),
-	.is_bimc_node = true,
 	.regmap_cfg = &msm8996_bimc_regmap_config
 };
 
@@ -1937,6 +1940,7 @@ static const struct regmap_config msm8996_cnoc_regmap_config = {
 };
 
 static const struct qcom_icc_desc msm8996_cnoc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_nodes),
 	.regmap_cfg = &msm8996_cnoc_regmap_config
@@ -1989,6 +1993,7 @@ static const struct regmap_config msm8996_mnoc_regmap_config = {
 };
 
 static const struct qcom_icc_desc msm8996_mnoc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(mnoc_nodes),
 	.clocks = bus_mm_clocks,
@@ -2026,6 +2031,7 @@ static const struct regmap_config msm8996_pnoc_regmap_config = {
 };
 
 static const struct qcom_icc_desc msm8996_pnoc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = pnoc_nodes,
 	.num_nodes = ARRAY_SIZE(pnoc_nodes),
 	.regmap_cfg = &msm8996_pnoc_regmap_config
@@ -2069,6 +2075,7 @@ static const struct regmap_config msm8996_snoc_regmap_config = {
 };
 
 static const struct qcom_icc_desc msm8996_snoc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = snoc_nodes,
 	.num_nodes = ARRAY_SIZE(snoc_nodes),
 	.regmap_cfg = &msm8996_snoc_regmap_config
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 471bb88f8828..274a7139fe1a 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1513,6 +1513,7 @@ static const struct regmap_config sdm660_a2noc_regmap_config = {
 };
 
 static struct qcom_icc_desc sdm660_a2noc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_a2noc_nodes),
 	.clocks = bus_a2noc_clocks,
@@ -1540,9 +1541,9 @@ static const struct regmap_config sdm660_bimc_regmap_config = {
 };
 
 static struct qcom_icc_desc sdm660_bimc = {
+	.type = QCOM_ICC_BIMC,
 	.nodes = sdm660_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_bimc_nodes),
-	.is_bimc_node = true,
 	.regmap_cfg = &sdm660_bimc_regmap_config,
 };
 
@@ -1594,6 +1595,7 @@ static const struct regmap_config sdm660_cnoc_regmap_config = {
 };
 
 static struct qcom_icc_desc sdm660_cnoc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_cnoc_nodes),
 	.regmap_cfg = &sdm660_cnoc_regmap_config,
@@ -1614,6 +1616,7 @@ static const struct regmap_config sdm660_gnoc_regmap_config = {
 };
 
 static struct qcom_icc_desc sdm660_gnoc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_gnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_gnoc_nodes),
 	.regmap_cfg = &sdm660_gnoc_regmap_config,
@@ -1653,6 +1656,7 @@ static const struct regmap_config sdm660_mnoc_regmap_config = {
 };
 
 static struct qcom_icc_desc sdm660_mnoc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
 	.clocks = bus_mm_clocks,
@@ -1689,6 +1693,7 @@ static const struct regmap_config sdm660_snoc_regmap_config = {
 };
 
 static struct qcom_icc_desc sdm660_snoc = {
+	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_snoc_nodes),
 	.regmap_cfg = &sdm660_snoc_regmap_config,
-- 
2.17.1

