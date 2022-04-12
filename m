Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3C4FDE6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiDLLqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiDLLp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:45:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0958B7C17F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:26:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g18so11436621ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qH9iZ4zus+cGXdlCs2yVJVv4Bkzzmqc57kTdn4lPc/0=;
        b=KDPV8FRtYR4NwDTwvqZKSqo7mquubvwJvA8LAc28XJNo9E3T/7Ute6O42G95q4OZ38
         aQv7qh/QMKJA9+1iGRJbDtwaKIQxpgWCyuHYvYOp/AFLTOdanyDB8izQveVzQzCdgT4i
         pec7Ji/8pe3Y/o/9PONThczng1T5G9jvwe6yP+ohi811N+emu1yiel4yS+uDTNf7ZhAh
         83b1jh5JAkJ2yticG5OjHgkNYFjnFBBeC9TOGGG+awXg1Mhl2Xfp5iH1uz8AHkQyCtwz
         MCGt3IIUNCaq94/b3QeaVHWeH5rxISj1fxTgA8QDLpT/mFq7RlZo51lci90JA2T9H0JS
         5m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qH9iZ4zus+cGXdlCs2yVJVv4Bkzzmqc57kTdn4lPc/0=;
        b=3q43XpqA11u2lQlWzYoMLuFO31PCQdPNk3H4G5dhLVlFS3vNgP47XeLrnbPHvh9efe
         qmc3AZWDr1T7Nz2OBZp3rE7MYbeBD66c/or1yN4Lxi5/C48o9PCCZoYbsoqYomXPK9LP
         am2gS6bZYMfAJJhuqAjnOCNUXZ7ZTb5jdhM5NtiHmpGsFgC6p4YtlZ19NdXmw89YhX2D
         mXEqu/84wZrZVS1JipBfwHwOn2MMVx1VWsTlNQRHP/f+Ptt79Ro/AEjly9doyezGgip5
         BXFYiiMXmZ0nf5aMTY3NyBZllV7GKgHHftjqfj5+ZupQgYbNSXzLSO1Zx4DXE46TCeBy
         LHqg==
X-Gm-Message-State: AOAM533s4rZeRh14uxhw9fbn3vTkmLDgcN8+Q1sorcSUAcCh8rCkxs20
        qb74bSbdJNWYebiaV5kjiBnsrw==
X-Google-Smtp-Source: ABdhPJzVc/jAxTjQd43q+dsvx1UzKEmJiX0LiQHEVuexQ7qrNmVonFyA9Iu27ivuhNqsCwDOZEgU5A==
X-Received: by 2002:a17:906:694f:b0:6e8:b720:594 with SMTP id c15-20020a170906694f00b006e8b7200594mr1445781ejs.404.1649759189255;
        Tue, 12 Apr 2022 03:26:29 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm4468959ejm.189.2022.04.12.03.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 03:26:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] interconnect: qcom: constify icc_node pointers
Date:   Tue, 12 Apr 2022 12:26:22 +0200
Message-Id: <20220412102623.227607-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220412102623.227607-1-krzysztof.kozlowski@linaro.org>
References: <20220412102623.227607-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers to struct qcom_icc_node (and similar structures) are not
modified, so they can be made const for safety.  The contents of struct
qcom_icc_node must stay non-const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c  |  2 +-
 drivers/interconnect/qcom/icc-rpm.h  |  2 +-
 drivers/interconnect/qcom/icc-rpmh.c |  2 +-
 drivers/interconnect/qcom/icc-rpmh.h |  2 +-
 drivers/interconnect/qcom/msm8916.c  |  6 +++---
 drivers/interconnect/qcom/msm8939.c  |  8 ++++----
 drivers/interconnect/qcom/msm8974.c  | 16 ++++++++--------
 drivers/interconnect/qcom/msm8996.c  | 16 ++++++++--------
 drivers/interconnect/qcom/osm-l3.c   | 16 ++++++++--------
 drivers/interconnect/qcom/qcm2290.c  | 12 ++++++------
 drivers/interconnect/qcom/qcs404.c   |  6 +++---
 drivers/interconnect/qcom/sc7180.c   | 26 +++++++++++++-------------
 drivers/interconnect/qcom/sc7280.c   | 24 ++++++++++++------------
 drivers/interconnect/qcom/sc8180x.c  | 24 ++++++++++++------------
 drivers/interconnect/qcom/sdm660.c   | 12 ++++++------
 drivers/interconnect/qcom/sdm845.c   | 16 ++++++++--------
 drivers/interconnect/qcom/sdx55.c    |  8 ++++----
 drivers/interconnect/qcom/sm8150.c   | 22 +++++++++++-----------
 drivers/interconnect/qcom/sm8250.c   | 22 +++++++++++-----------
 drivers/interconnect/qcom/sm8350.c   | 20 ++++++++++----------
 drivers/interconnect/qcom/sm8450.c   | 24 ++++++++++++------------
 21 files changed, 143 insertions(+), 143 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 34125e8f8b60..874e65658a4f 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -301,7 +301,7 @@ int qnoc_probe(struct platform_device *pdev)
 	const struct qcom_icc_desc *desc;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes;
+	struct qcom_icc_node * const *qnodes;
 	struct qcom_icc_provider *qp;
 	struct icc_node *node;
 	size_t num_nodes, i;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 26dad006034f..56cf97ec1159 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -81,7 +81,7 @@ struct qcom_icc_node {
 };
 
 struct qcom_icc_desc {
-	struct qcom_icc_node **nodes;
+	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	const char * const *clocks;
 	size_t num_clocks;
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 2c8e12549804..3c40076eb5fb 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -189,7 +189,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes, *qn;
+	struct qcom_icc_node * const *qnodes, *qn;
 	struct qcom_icc_provider *qp;
 	struct icc_node *node;
 	size_t num_nodes, i, j;
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 4bfc060529ba..5dfc26072593 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -112,7 +112,7 @@ struct qcom_icc_fabric {
 };
 
 struct qcom_icc_desc {
-	struct qcom_icc_node **nodes;
+	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	struct qcom_icc_bcm **bcms;
 	size_t num_bcms;
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 4dc122ce9805..5c4ba2f37c8e 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -1191,7 +1191,7 @@ static struct qcom_icc_node snoc_pcnoc_slv = {
 	.links = snoc_pcnoc_slv_links,
 };
 
-static struct qcom_icc_node *msm8916_snoc_nodes[] = {
+static struct qcom_icc_node * const msm8916_snoc_nodes[] = {
 	[BIMC_SNOC_SLV] = &bimc_snoc_slv,
 	[MASTER_JPEG] = &mas_jpeg,
 	[MASTER_MDP_PORT0] = &mas_mdp,
@@ -1236,7 +1236,7 @@ static const struct qcom_icc_desc msm8916_snoc = {
 	.qos_offset = 0x7000,
 };
 
-static struct qcom_icc_node *msm8916_bimc_nodes[] = {
+static struct qcom_icc_node * const msm8916_bimc_nodes[] = {
 	[BIMC_SNOC_MAS] = &bimc_snoc_mas,
 	[MASTER_AMPSS_M0] = &mas_apss,
 	[MASTER_GRAPHICS_3D] = &mas_gfx,
@@ -1264,7 +1264,7 @@ static const struct qcom_icc_desc msm8916_bimc = {
 	.qos_offset = 0x8000,
 };
 
-static struct qcom_icc_node *msm8916_pcnoc_nodes[] = {
+static struct qcom_icc_node * const msm8916_pcnoc_nodes[] = {
 	[MASTER_BLSP_1] = &mas_blsp_1,
 	[MASTER_DEHR] = &mas_dehr,
 	[MASTER_LPASS] = &mas_audio,
diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index 7838e332ee41..63b31deea722 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -1251,7 +1251,7 @@ static struct qcom_icc_node snoc_pcnoc_slv = {
 	.links = snoc_pcnoc_slv_links,
 };
 
-static struct qcom_icc_node *msm8939_snoc_nodes[] = {
+static struct qcom_icc_node * const msm8939_snoc_nodes[] = {
 	[BIMC_SNOC_SLV] = &bimc_snoc_slv,
 	[MASTER_QDSS_BAM] = &mas_qdss_bam,
 	[MASTER_QDSS_ETR] = &mas_qdss_etr,
@@ -1289,7 +1289,7 @@ static const struct qcom_icc_desc msm8939_snoc = {
 	.qos_offset = 0x7000,
 };
 
-static struct qcom_icc_node *msm8939_snoc_mm_nodes[] = {
+static struct qcom_icc_node * const msm8939_snoc_mm_nodes[] = {
 	[MASTER_VIDEO_P0] = &mas_video,
 	[MASTER_JPEG] = &mas_jpeg,
 	[MASTER_VFE] = &mas_vfe,
@@ -1309,7 +1309,7 @@ static const struct qcom_icc_desc msm8939_snoc_mm = {
 	.qos_offset = 0x7000,
 };
 
-static struct qcom_icc_node *msm8939_bimc_nodes[] = {
+static struct qcom_icc_node * const msm8939_bimc_nodes[] = {
 	[BIMC_SNOC_MAS] = &bimc_snoc_mas,
 	[MASTER_AMPSS_M0] = &mas_apss,
 	[MASTER_GRAPHICS_3D] = &mas_gfx,
@@ -1337,7 +1337,7 @@ static const struct qcom_icc_desc msm8939_bimc = {
 	.qos_offset = 0x8000,
 };
 
-static struct qcom_icc_node *msm8939_pcnoc_nodes[] = {
+static struct qcom_icc_node * const msm8939_pcnoc_nodes[] = {
 	[MASTER_BLSP_1] = &mas_blsp_1,
 	[MASTER_DEHR] = &mas_dehr,
 	[MASTER_LPASS] = &mas_audio,
diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 2eebe421f262..6fa0ad90fc3d 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -220,7 +220,7 @@ struct msm8974_icc_node {
 };
 
 struct msm8974_icc_desc {
-	struct msm8974_icc_node **nodes;
+	struct msm8974_icc_node * const *nodes;
 	size_t num_nodes;
 };
 
@@ -244,7 +244,7 @@ DEFINE_QNODE(bimc_to_snoc, MSM8974_BIMC_TO_SNOC, 8, 3, 2, MSM8974_SNOC_TO_BIMC,
 DEFINE_QNODE(slv_ebi_ch0, MSM8974_BIMC_SLV_EBI_CH0, 8, -1, 0);
 DEFINE_QNODE(slv_ampss_l2, MSM8974_BIMC_SLV_AMPSS_L2, 8, -1, 1);
 
-static struct msm8974_icc_node *msm8974_bimc_nodes[] = {
+static struct msm8974_icc_node * const msm8974_bimc_nodes[] = {
 	[BIMC_MAS_AMPSS_M0] = &mas_ampss_m0,
 	[BIMC_MAS_AMPSS_M1] = &mas_ampss_m1,
 	[BIMC_MAS_MSS_PROC] = &mas_mss_proc,
@@ -297,7 +297,7 @@ DEFINE_QNODE(slv_ebi1_phy_cfg, MSM8974_CNOC_SLV_EBI1_PHY_CFG, 8, -1, 73);
 DEFINE_QNODE(slv_rpm, MSM8974_CNOC_SLV_RPM, 8, -1, 74);
 DEFINE_QNODE(slv_service_cnoc, MSM8974_CNOC_SLV_SERVICE_CNOC, 8, -1, 76);
 
-static struct msm8974_icc_node *msm8974_cnoc_nodes[] = {
+static struct msm8974_icc_node * const msm8974_cnoc_nodes[] = {
 	[CNOC_MAS_RPM_INST] = &mas_rpm_inst,
 	[CNOC_MAS_RPM_DATA] = &mas_rpm_data,
 	[CNOC_MAS_RPM_SYS] = &mas_rpm_sys,
@@ -365,7 +365,7 @@ DEFINE_QNODE(slv_mnoc_mpu_cfg, MSM8974_MNOC_SLV_MNOC_MPU_CFG, 16, -1, 14);
 DEFINE_QNODE(slv_onoc_mpu_cfg, MSM8974_MNOC_SLV_ONOC_MPU_CFG, 16, -1, 15);
 DEFINE_QNODE(slv_service_mnoc, MSM8974_MNOC_SLV_SERVICE_MNOC, 16, -1, 17);
 
-static struct msm8974_icc_node *msm8974_mnoc_nodes[] = {
+static struct msm8974_icc_node * const msm8974_mnoc_nodes[] = {
 	[MNOC_MAS_GRAPHICS_3D] = &mas_graphics_3d,
 	[MNOC_MAS_JPEG] = &mas_jpeg,
 	[MNOC_MAS_MDP_PORT0] = &mas_mdp_port0,
@@ -410,7 +410,7 @@ DEFINE_QNODE(ocmem_vnoc_to_onoc, MSM8974_OCMEM_VNOC_TO_OCMEM_NOC, 16, 56, 79, MS
 DEFINE_QNODE(ocmem_vnoc_to_snoc, MSM8974_OCMEM_VNOC_TO_SNOC, 8, 57, 80);
 DEFINE_QNODE(mas_v_ocmem_gfx3d, MSM8974_OCMEM_VNOC_MAS_GFX3D, 8, 55, -1, MSM8974_OCMEM_VNOC_TO_OCMEM_NOC);
 
-static struct msm8974_icc_node *msm8974_onoc_nodes[] = {
+static struct msm8974_icc_node * const msm8974_onoc_nodes[] = {
 	[OCMEM_NOC_TO_OCMEM_VNOC] = &ocmem_noc_to_ocmem_vnoc,
 	[OCMEM_MAS_JPEG_OCMEM] = &mas_jpeg_ocmem,
 	[OCMEM_MAS_MDP_OCMEM] = &mas_mdp_ocmem,
@@ -458,7 +458,7 @@ DEFINE_QNODE(slv_pnoc_mpu_cfg, MSM8974_PNOC_SLV_PNOC_MPU_CFG, 8, -1, 43);
 DEFINE_QNODE(slv_prng, MSM8974_PNOC_SLV_PRNG, 8, -1, 44, MSM8974_PNOC_TO_SNOC);
 DEFINE_QNODE(slv_service_pnoc, MSM8974_PNOC_SLV_SERVICE_PNOC, 8, -1, 46);
 
-static struct msm8974_icc_node *msm8974_pnoc_nodes[] = {
+static struct msm8974_icc_node * const msm8974_pnoc_nodes[] = {
 	[PNOC_MAS_PNOC_CFG] = &mas_pnoc_cfg,
 	[PNOC_MAS_SDCC_1] = &mas_sdcc_1,
 	[PNOC_MAS_SDCC_3] = &mas_sdcc_3,
@@ -518,7 +518,7 @@ DEFINE_QNODE(slv_snoc_ocmem, MSM8974_SNOC_SLV_SNOC_OCMEM, 8, -1, 27);
 DEFINE_QNODE(slv_service_snoc, MSM8974_SNOC_SLV_SERVICE_SNOC, 8, -1, 29);
 DEFINE_QNODE(slv_qdss_stm, MSM8974_SNOC_SLV_QDSS_STM, 8, -1, 30);
 
-static struct msm8974_icc_node *msm8974_snoc_nodes[] = {
+static struct msm8974_icc_node * const msm8974_snoc_nodes[] = {
 	[SNOC_MAS_LPASS_AHB] = &mas_lpass_ahb,
 	[SNOC_MAS_QDSS_BAM] = &mas_qdss_bam,
 	[SNOC_MAS_SNOC_CFG] = &mas_snoc_cfg,
@@ -648,7 +648,7 @@ static int msm8974_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
 static int msm8974_icc_probe(struct platform_device *pdev)
 {
 	const struct msm8974_icc_desc *desc;
-	struct msm8974_icc_node **qnodes;
+	struct msm8974_icc_node * const *qnodes;
 	struct msm8974_icc_provider *qp;
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 499e11fbbd2e..c2903ae3b3bc 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -1796,7 +1796,7 @@ static struct qcom_icc_node slv_srvc_snoc = {
 	.qos.qos_mode = NOC_QOS_MODE_INVALID
 };
 
-static struct qcom_icc_node *a0noc_nodes[] = {
+static struct qcom_icc_node * const a0noc_nodes[] = {
 	[MASTER_PCIE_0] = &mas_pcie_0,
 	[MASTER_PCIE_1] = &mas_pcie_1,
 	[MASTER_PCIE_2] = &mas_pcie_2
@@ -1820,7 +1820,7 @@ static const struct qcom_icc_desc msm8996_a0noc = {
 	.regmap_cfg = &msm8996_a0noc_regmap_config
 };
 
-static struct qcom_icc_node *a1noc_nodes[] = {
+static struct qcom_icc_node * const a1noc_nodes[] = {
 	[MASTER_CNOC_A1NOC] = &mas_cnoc_a1noc,
 	[MASTER_CRYPTO_CORE0] = &mas_crypto_c0,
 	[MASTER_PNOC_A1NOC] = &mas_pnoc_a1noc
@@ -1841,7 +1841,7 @@ static const struct qcom_icc_desc msm8996_a1noc = {
 	.regmap_cfg = &msm8996_a1noc_regmap_config
 };
 
-static struct qcom_icc_node *a2noc_nodes[] = {
+static struct qcom_icc_node * const a2noc_nodes[] = {
 	[MASTER_USB3] = &mas_usb3,
 	[MASTER_IPA] = &mas_ipa,
 	[MASTER_UFS] = &mas_ufs
@@ -1862,7 +1862,7 @@ static const struct qcom_icc_desc msm8996_a2noc = {
 	.regmap_cfg = &msm8996_a2noc_regmap_config
 };
 
-static struct qcom_icc_node *bimc_nodes[] = {
+static struct qcom_icc_node * const bimc_nodes[] = {
 	[MASTER_AMPSS_M0] = &mas_apps_proc,
 	[MASTER_GRAPHICS_3D] = &mas_oxili,
 	[MASTER_MNOC_BIMC] = &mas_mnoc_bimc,
@@ -1888,7 +1888,7 @@ static const struct qcom_icc_desc msm8996_bimc = {
 	.regmap_cfg = &msm8996_bimc_regmap_config
 };
 
-static struct qcom_icc_node *cnoc_nodes[] = {
+static struct qcom_icc_node * const cnoc_nodes[] = {
 	[MASTER_SNOC_CNOC] = &mas_snoc_cnoc,
 	[MASTER_QDSS_DAP] = &mas_qdss_dap,
 	[SLAVE_CNOC_A1NOC] = &slv_cnoc_a1noc,
@@ -1946,7 +1946,7 @@ static const struct qcom_icc_desc msm8996_cnoc = {
 	.regmap_cfg = &msm8996_cnoc_regmap_config
 };
 
-static struct qcom_icc_node *mnoc_nodes[] = {
+static struct qcom_icc_node * const mnoc_nodes[] = {
 	[MASTER_CNOC_MNOC_CFG] = &mas_cnoc_mnoc_cfg,
 	[MASTER_CPP] = &mas_cpp,
 	[MASTER_JPEG] = &mas_jpeg,
@@ -2001,7 +2001,7 @@ static const struct qcom_icc_desc msm8996_mnoc = {
 	.regmap_cfg = &msm8996_mnoc_regmap_config
 };
 
-static struct qcom_icc_node *pnoc_nodes[] = {
+static struct qcom_icc_node * const pnoc_nodes[] = {
 	[MASTER_SNOC_PNOC] = &mas_snoc_pnoc,
 	[MASTER_SDCC_1] = &mas_sdcc_1,
 	[MASTER_SDCC_2] = &mas_sdcc_2,
@@ -2037,7 +2037,7 @@ static const struct qcom_icc_desc msm8996_pnoc = {
 	.regmap_cfg = &msm8996_pnoc_regmap_config
 };
 
-static struct qcom_icc_node *snoc_nodes[] = {
+static struct qcom_icc_node * const snoc_nodes[] = {
 	[MASTER_HMSS] = &mas_hmss,
 	[MASTER_QDSS_BAM] = &mas_qdss_bam,
 	[MASTER_SNOC_CFG] = &mas_snoc_cfg,
diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index eec13099a6a3..4198656f4e59 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -67,7 +67,7 @@ struct qcom_osm_l3_node {
 };
 
 struct qcom_osm_l3_desc {
-	const struct qcom_osm_l3_node **nodes;
+	const struct qcom_osm_l3_node * const *nodes;
 	size_t num_nodes;
 	unsigned int lut_row_size;
 	unsigned int reg_freq_lut;
@@ -86,7 +86,7 @@ struct qcom_osm_l3_desc {
 DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, SDM845_SLAVE_OSM_L3);
 DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16);
 
-static const struct qcom_osm_l3_node *sdm845_osm_l3_nodes[] = {
+static const struct qcom_osm_l3_node * const sdm845_osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &sdm845_osm_apps_l3,
 	[SLAVE_OSM_L3] = &sdm845_osm_l3,
 };
@@ -102,7 +102,7 @@ static const struct qcom_osm_l3_desc sdm845_icc_osm_l3 = {
 DEFINE_QNODE(sc7180_osm_apps_l3, SC7180_MASTER_OSM_L3_APPS, 16, SC7180_SLAVE_OSM_L3);
 DEFINE_QNODE(sc7180_osm_l3, SC7180_SLAVE_OSM_L3, 16);
 
-static const struct qcom_osm_l3_node *sc7180_osm_l3_nodes[] = {
+static const struct qcom_osm_l3_node * const sc7180_osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &sc7180_osm_apps_l3,
 	[SLAVE_OSM_L3] = &sc7180_osm_l3,
 };
@@ -118,7 +118,7 @@ static const struct qcom_osm_l3_desc sc7180_icc_osm_l3 = {
 DEFINE_QNODE(sc7280_epss_apps_l3, SC7280_MASTER_EPSS_L3_APPS, 32, SC7280_SLAVE_EPSS_L3);
 DEFINE_QNODE(sc7280_epss_l3, SC7280_SLAVE_EPSS_L3, 32);
 
-static const struct qcom_osm_l3_node *sc7280_epss_l3_nodes[] = {
+static const struct qcom_osm_l3_node * const sc7280_epss_l3_nodes[] = {
 	[MASTER_EPSS_L3_APPS] = &sc7280_epss_apps_l3,
 	[SLAVE_EPSS_L3_SHARED] = &sc7280_epss_l3,
 };
@@ -134,7 +134,7 @@ static const struct qcom_osm_l3_desc sc7280_icc_epss_l3 = {
 DEFINE_QNODE(sc8180x_osm_apps_l3, SC8180X_MASTER_OSM_L3_APPS, 32, SC8180X_SLAVE_OSM_L3);
 DEFINE_QNODE(sc8180x_osm_l3, SC8180X_SLAVE_OSM_L3, 32);
 
-static const struct qcom_osm_l3_node *sc8180x_osm_l3_nodes[] = {
+static const struct qcom_osm_l3_node * const sc8180x_osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &sc8180x_osm_apps_l3,
 	[SLAVE_OSM_L3] = &sc8180x_osm_l3,
 };
@@ -150,7 +150,7 @@ static const struct qcom_osm_l3_desc sc8180x_icc_osm_l3 = {
 DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, SM8150_SLAVE_OSM_L3);
 DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32);
 
-static const struct qcom_osm_l3_node *sm8150_osm_l3_nodes[] = {
+static const struct qcom_osm_l3_node * const sm8150_osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &sm8150_osm_apps_l3,
 	[SLAVE_OSM_L3] = &sm8150_osm_l3,
 };
@@ -166,7 +166,7 @@ static const struct qcom_osm_l3_desc sm8150_icc_osm_l3 = {
 DEFINE_QNODE(sm8250_epss_apps_l3, SM8250_MASTER_EPSS_L3_APPS, 32, SM8250_SLAVE_EPSS_L3);
 DEFINE_QNODE(sm8250_epss_l3, SM8250_SLAVE_EPSS_L3, 32);
 
-static const struct qcom_osm_l3_node *sm8250_epss_l3_nodes[] = {
+static const struct qcom_osm_l3_node * const sm8250_epss_l3_nodes[] = {
 	[MASTER_EPSS_L3_APPS] = &sm8250_epss_apps_l3,
 	[SLAVE_EPSS_L3_SHARED] = &sm8250_epss_l3,
 };
@@ -228,7 +228,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	const struct qcom_osm_l3_desc *desc;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	const struct qcom_osm_l3_node **qnodes;
+	const struct qcom_osm_l3_node * const *qnodes;
 	struct icc_node *node;
 	size_t num_nodes;
 	struct clk *clk;
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 644dcd90e7ad..0da612d6398c 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1174,7 +1174,7 @@ static struct qcom_icc_node slv_anoc_snoc = {
 };
 
 /* NoC descriptors */
-static struct qcom_icc_node *qcm2290_bimc_nodes[] = {
+static struct qcom_icc_node * const qcm2290_bimc_nodes[] = {
 	[MASTER_APPSS_PROC] = &mas_appss_proc,
 	[MASTER_SNOC_BIMC_RT] = &mas_snoc_bimc_rt,
 	[MASTER_SNOC_BIMC_NRT] = &mas_snoc_bimc_nrt,
@@ -1202,7 +1202,7 @@ static const struct qcom_icc_desc qcm2290_bimc = {
 	.qos_offset = 0x8000,
 };
 
-static struct qcom_icc_node *qcm2290_cnoc_nodes[] = {
+static struct qcom_icc_node * const qcm2290_cnoc_nodes[] = {
 	[MASTER_SNOC_CNOC] = &mas_snoc_cnoc,
 	[MASTER_QDSS_DAP] = &mas_qdss_dap,
 	[SLAVE_BIMC_CFG] = &slv_bimc_cfg,
@@ -1255,7 +1255,7 @@ static const struct qcom_icc_desc qcm2290_cnoc = {
 	.regmap_cfg = &qcm2290_cnoc_regmap_config,
 };
 
-static struct qcom_icc_node *qcm2290_snoc_nodes[] = {
+static struct qcom_icc_node * const qcm2290_snoc_nodes[] = {
 	[MASTER_CRYPTO_CORE0] = &mas_crypto_core0,
 	[MASTER_SNOC_CFG] = &mas_snoc_cfg,
 	[MASTER_TIC] = &mas_tic,
@@ -1298,7 +1298,7 @@ static const struct qcom_icc_desc qcm2290_snoc = {
 	.qos_offset = 0x15000,
 };
 
-static struct qcom_icc_node *qcm2290_qup_virt_nodes[] = {
+static struct qcom_icc_node * const qcm2290_qup_virt_nodes[] = {
 	[MASTER_QUP_CORE_0] = &mas_qup_core_0,
 	[SLAVE_QUP_CORE_0] = &slv_qup_core_0
 };
@@ -1309,7 +1309,7 @@ static const struct qcom_icc_desc qcm2290_qup_virt = {
 	.num_nodes = ARRAY_SIZE(qcm2290_qup_virt_nodes),
 };
 
-static struct qcom_icc_node *qcm2290_mmnrt_virt_nodes[] = {
+static struct qcom_icc_node * const qcm2290_mmnrt_virt_nodes[] = {
 	[MASTER_CAMNOC_SF] = &mas_camnoc_sf,
 	[MASTER_VIDEO_P0] = &mas_video_p0,
 	[MASTER_VIDEO_PROC] = &mas_video_proc,
@@ -1324,7 +1324,7 @@ static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
 	.qos_offset = 0x15000,
 };
 
-static struct qcom_icc_node *qcm2290_mmrt_virt_nodes[] = {
+static struct qcom_icc_node * const qcm2290_mmrt_virt_nodes[] = {
 	[MASTER_CAMNOC_HF] = &mas_camnoc_hf,
 	[MASTER_MDP0] = &mas_mdp0,
 	[SLAVE_SNOC_BIMC_RT] = &slv_snoc_bimc_rt,
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index d5020b2b2236..fae155344332 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -974,7 +974,7 @@ static struct qcom_icc_node slv_lpass = {
 	.slv_rpm_id = -1,
 };
 
-static struct qcom_icc_node *qcs404_bimc_nodes[] = {
+static struct qcom_icc_node * const qcs404_bimc_nodes[] = {
 	[MASTER_AMPSS_M0] = &mas_apps_proc,
 	[MASTER_OXILI] = &mas_oxili,
 	[MASTER_MDP_PORT0] = &mas_mdp,
@@ -989,7 +989,7 @@ static const struct qcom_icc_desc qcs404_bimc = {
 	.num_nodes = ARRAY_SIZE(qcs404_bimc_nodes),
 };
 
-static struct qcom_icc_node *qcs404_pcnoc_nodes[] = {
+static struct qcom_icc_node * const qcs404_pcnoc_nodes[] = {
 	[MASTER_SPDM] = &mas_spdm,
 	[MASTER_BLSP_1] = &mas_blsp_1,
 	[MASTER_BLSP_2] = &mas_blsp_2,
@@ -1043,7 +1043,7 @@ static const struct qcom_icc_desc qcs404_pcnoc = {
 	.num_nodes = ARRAY_SIZE(qcs404_pcnoc_nodes),
 };
 
-static struct qcom_icc_node *qcs404_snoc_nodes[] = {
+static struct qcom_icc_node * const qcs404_snoc_nodes[] = {
 	[MASTER_QDSS_BAM] = &mas_qdss_bam,
 	[MASTER_BIMC_SNOC] = &mas_bimc_snoc,
 	[MASTER_PCNOC_SNOC] = &mas_pcnoc_snoc,
diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index 712b50d4b1c3..11e221edbd1c 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -185,7 +185,7 @@ static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
 	&bcm_cn1,
 };
 
-static struct qcom_icc_node *aggre1_noc_nodes[] = {
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[MASTER_A1NOC_CFG] = &qhm_a1noc_cfg,
 	[MASTER_QSPI] = &qhm_qspi,
 	[MASTER_QUP_0] = &qhm_qup_0,
@@ -207,7 +207,7 @@ static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
 	&bcm_ce0,
 };
 
-static struct qcom_icc_node *aggre2_noc_nodes[] = {
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[MASTER_A2NOC_CFG] = &qhm_a2noc_cfg,
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
 	[MASTER_QUP_1] = &qhm_qup_1,
@@ -230,7 +230,7 @@ static struct qcom_icc_bcm *camnoc_virt_bcms[] = {
 	&bcm_mm1,
 };
 
-static struct qcom_icc_node *camnoc_virt_nodes[] = {
+static struct qcom_icc_node * const camnoc_virt_nodes[] = {
 	[MASTER_CAMNOC_HF0_UNCOMP] = &qxm_camnoc_hf0_uncomp,
 	[MASTER_CAMNOC_HF1_UNCOMP] = &qxm_camnoc_hf1_uncomp,
 	[MASTER_CAMNOC_SF_UNCOMP] = &qxm_camnoc_sf_uncomp,
@@ -250,7 +250,7 @@ static struct qcom_icc_bcm *compute_noc_bcms[] = {
 	&bcm_co3,
 };
 
-static struct qcom_icc_node *compute_noc_nodes[] = {
+static struct qcom_icc_node * const compute_noc_nodes[] = {
 	[MASTER_NPU] = &qnm_npu,
 	[MASTER_NPU_PROC] = &qxm_npu_dsp,
 	[SLAVE_CDSP_GEM_NOC] = &qns_cdsp_gemnoc,
@@ -268,7 +268,7 @@ static struct qcom_icc_bcm *config_noc_bcms[] = {
 	&bcm_cn1,
 };
 
-static struct qcom_icc_node *config_noc_nodes[] = {
+static struct qcom_icc_node * const config_noc_nodes[] = {
 	[MASTER_SNOC_CNOC] = &qnm_snoc,
 	[MASTER_QDSS_DAP] = &xm_qdss_dap,
 	[SLAVE_A1NOC_CFG] = &qhs_a1_noc_cfg,
@@ -331,7 +331,7 @@ static const struct qcom_icc_desc sc7180_config_noc = {
 	.num_bcms = ARRAY_SIZE(config_noc_bcms),
 };
 
-static struct qcom_icc_node *dc_noc_nodes[] = {
+static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[MASTER_CNOC_DC_NOC] = &qhm_cnoc_dc_noc,
 	[SLAVE_GEM_NOC_CFG] = &qhs_gemnoc,
 	[SLAVE_LLCC_CFG] = &qhs_llcc,
@@ -349,7 +349,7 @@ static struct qcom_icc_bcm *gem_noc_bcms[] = {
 	&bcm_sh4,
 };
 
-static struct qcom_icc_node *gem_noc_nodes[] = {
+static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[MASTER_APPSS_PROC] = &acm_apps0,
 	[MASTER_SYS_TCU] = &acm_sys_tcu,
 	[MASTER_GEM_NOC_CFG] = &qhm_gemnoc_cfg,
@@ -376,7 +376,7 @@ static struct qcom_icc_bcm *ipa_virt_bcms[] = {
 	&bcm_ip0,
 };
 
-static struct qcom_icc_node *ipa_virt_nodes[] = {
+static struct qcom_icc_node * const ipa_virt_nodes[] = {
 	[MASTER_IPA_CORE] = &ipa_core_master,
 	[SLAVE_IPA_CORE] = &ipa_core_slave,
 };
@@ -393,7 +393,7 @@ static struct qcom_icc_bcm *mc_virt_bcms[] = {
 	&bcm_mc0,
 };
 
-static struct qcom_icc_node *mc_virt_nodes[] = {
+static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI1] = &ebi,
 };
@@ -411,7 +411,7 @@ static struct qcom_icc_bcm *mmss_noc_bcms[] = {
 	&bcm_mm2,
 };
 
-static struct qcom_icc_node *mmss_noc_nodes[] = {
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[MASTER_CNOC_MNOC_CFG] = &qhm_mnoc_cfg,
 	[MASTER_CAMNOC_HF0] = &qxm_camnoc_hf0,
 	[MASTER_CAMNOC_HF1] = &qxm_camnoc_hf1,
@@ -432,7 +432,7 @@ static const struct qcom_icc_desc sc7180_mmss_noc = {
 	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
 };
 
-static struct qcom_icc_node *npu_noc_nodes[] = {
+static struct qcom_icc_node * const npu_noc_nodes[] = {
 	[MASTER_NPU_SYS] = &amm_npu_sys,
 	[MASTER_NPU_NOC_CFG] = &qhm_npu_cfg,
 	[SLAVE_NPU_CAL_DP0] = &qhs_cal_dp0,
@@ -455,7 +455,7 @@ static struct qcom_icc_bcm *qup_virt_bcms[] = {
 	&bcm_qup0,
 };
 
-static struct qcom_icc_node *qup_virt_nodes[] = {
+static struct qcom_icc_node * const qup_virt_nodes[] = {
 	[MASTER_QUP_CORE_0] = &qup_core_master_1,
 	[MASTER_QUP_CORE_1] = &qup_core_master_2,
 	[SLAVE_QUP_CORE_0] = &qup_core_slave_1,
@@ -480,7 +480,7 @@ static struct qcom_icc_bcm *system_noc_bcms[] = {
 	&bcm_sn12,
 };
 
-static struct qcom_icc_node *system_noc_nodes[] = {
+static struct qcom_icc_node * const system_noc_nodes[] = {
 	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
 	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
 	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 0464e5eb6a32..d969bc6c4610 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1482,7 +1482,7 @@ static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
 	&bcm_sn14,
 };
 
-static struct qcom_icc_node *aggre1_noc_nodes[] = {
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[MASTER_QSPI_0] = &qhm_qspi,
 	[MASTER_QUP_0] = &qhm_qup0,
 	[MASTER_QUP_1] = &qhm_qup1,
@@ -1511,7 +1511,7 @@ static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
 	&bcm_ce0,
 };
 
-static struct qcom_icc_node *aggre2_noc_nodes[] = {
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
 	[MASTER_A2NOC_CFG] = &qnm_a2noc_cfg,
 	[MASTER_CNOC_A2NOC] = &qnm_cnoc_datapath,
@@ -1534,7 +1534,7 @@ static struct qcom_icc_bcm *clk_virt_bcms[] = {
 	&bcm_qup1,
 };
 
-static struct qcom_icc_node *clk_virt_nodes[] = {
+static struct qcom_icc_node * const clk_virt_nodes[] = {
 	[MASTER_QUP_CORE_0] = &qup0_core_master,
 	[MASTER_QUP_CORE_1] = &qup1_core_master,
 	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
@@ -1553,7 +1553,7 @@ static struct qcom_icc_bcm *cnoc2_bcms[] = {
 	&bcm_cn2,
 };
 
-static struct qcom_icc_node *cnoc2_nodes[] = {
+static struct qcom_icc_node * const cnoc2_nodes[] = {
 	[MASTER_CNOC3_CNOC2] = &qnm_cnoc3_cnoc2,
 	[MASTER_QDSS_DAP] = &xm_qdss_dap,
 	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
@@ -1617,7 +1617,7 @@ static struct qcom_icc_bcm *cnoc3_bcms[] = {
 	&bcm_sn4,
 };
 
-static struct qcom_icc_node *cnoc3_nodes[] = {
+static struct qcom_icc_node * const cnoc3_nodes[] = {
 	[MASTER_CNOC2_CNOC3] = &qnm_cnoc2_cnoc3,
 	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
 	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
@@ -1645,7 +1645,7 @@ static const struct qcom_icc_desc sc7280_cnoc3 = {
 static struct qcom_icc_bcm *dc_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *dc_noc_nodes[] = {
+static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[MASTER_CNOC_DC_NOC] = &qnm_cnoc_dc_noc,
 	[SLAVE_LLCC_CFG] = &qhs_llcc,
 	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
@@ -1665,7 +1665,7 @@ static struct qcom_icc_bcm *gem_noc_bcms[] = {
 	&bcm_sh4,
 };
 
-static struct qcom_icc_node *gem_noc_nodes[] = {
+static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[MASTER_GPU_TCU] = &alm_gpu_tcu,
 	[MASTER_SYS_TCU] = &alm_sys_tcu,
 	[MASTER_APPSS_PROC] = &chm_apps,
@@ -1697,7 +1697,7 @@ static const struct qcom_icc_desc sc7280_gem_noc = {
 static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *lpass_ag_noc_nodes[] = {
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 	[MASTER_CNOC_LPASS_AG_NOC] = &qhm_config_noc,
 	[SLAVE_LPASS_CORE_CFG] = &qhs_lpass_core,
 	[SLAVE_LPASS_LPI_CFG] = &qhs_lpass_lpi,
@@ -1719,7 +1719,7 @@ static struct qcom_icc_bcm *mc_virt_bcms[] = {
 	&bcm_mc0,
 };
 
-static struct qcom_icc_node *mc_virt_nodes[] = {
+static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI1] = &ebi,
 };
@@ -1738,7 +1738,7 @@ static struct qcom_icc_bcm *mmss_noc_bcms[] = {
 	&bcm_mm5,
 };
 
-static struct qcom_icc_node *mmss_noc_nodes[] = {
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[MASTER_CNOC_MNOC_CFG] = &qnm_mnoc_cfg,
 	[MASTER_VIDEO_P0] = &qnm_video0,
 	[MASTER_VIDEO_PROC] = &qnm_video_cpu,
@@ -1763,7 +1763,7 @@ static struct qcom_icc_bcm *nsp_noc_bcms[] = {
 	&bcm_co3,
 };
 
-static struct qcom_icc_node *nsp_noc_nodes[] = {
+static struct qcom_icc_node * const nsp_noc_nodes[] = {
 	[MASTER_CDSP_NOC_CFG] = &qhm_nsp_noc_config,
 	[MASTER_CDSP_PROC] = &qxm_nsp,
 	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
@@ -1784,7 +1784,7 @@ static struct qcom_icc_bcm *system_noc_bcms[] = {
 	&bcm_sn8,
 };
 
-static struct qcom_icc_node *system_noc_nodes[] = {
+static struct qcom_icc_node * const system_noc_nodes[] = {
 	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
 	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
 	[MASTER_SNOC_CFG] = &qnm_snoc_cfg,
diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index e9adf05b9330..f6b69b9df410 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -249,7 +249,7 @@ static struct qcom_icc_bcm *system_noc_bcms[] = {
 	&bcm_sn15,
 };
 
-static struct qcom_icc_node *aggre1_noc_nodes[] = {
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[MASTER_A1NOC_CFG] = &mas_qhm_a1noc_cfg,
 	[MASTER_UFS_CARD] = &mas_xm_ufs_card,
 	[MASTER_UFS_GEN4] = &mas_xm_ufs_g4,
@@ -261,7 +261,7 @@ static struct qcom_icc_node *aggre1_noc_nodes[] = {
 	[SLAVE_SERVICE_A1NOC] = &slv_srvc_aggre1_noc,
 };
 
-static struct qcom_icc_node *aggre2_noc_nodes[] = {
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[MASTER_A2NOC_CFG] = &mas_qhm_a2noc_cfg,
 	[MASTER_QDSS_BAM] = &mas_qhm_qdss_bam,
 	[MASTER_QSPI_0] = &mas_qhm_qspi,
@@ -285,19 +285,19 @@ static struct qcom_icc_node *aggre2_noc_nodes[] = {
 	[SLAVE_SERVICE_A2NOC] = &slv_srvc_aggre2_noc,
 };
 
-static struct qcom_icc_node *camnoc_virt_nodes[] = {
+static struct qcom_icc_node * const camnoc_virt_nodes[] = {
 	[MASTER_CAMNOC_HF0_UNCOMP] = &mas_qxm_camnoc_hf0_uncomp,
 	[MASTER_CAMNOC_HF1_UNCOMP] = &mas_qxm_camnoc_hf1_uncomp,
 	[MASTER_CAMNOC_SF_UNCOMP] = &mas_qxm_camnoc_sf_uncomp,
 	[SLAVE_CAMNOC_UNCOMP] = &slv_qns_camnoc_uncomp,
 };
 
-static struct qcom_icc_node *compute_noc_nodes[] = {
+static struct qcom_icc_node * const compute_noc_nodes[] = {
 	[MASTER_NPU] = &mas_qnm_npu,
 	[SLAVE_CDSP_MEM_NOC] = &slv_qns_cdsp_mem_noc,
 };
 
-static struct qcom_icc_node *config_noc_nodes[] = {
+static struct qcom_icc_node * const config_noc_nodes[] = {
 	[SNOC_CNOC_MAS] = &mas_qnm_snoc,
 	[SLAVE_A1NOC_CFG] = &slv_qhs_a1_noc_cfg,
 	[SLAVE_A2NOC_CFG] = &slv_qhs_a2_noc_cfg,
@@ -357,13 +357,13 @@ static struct qcom_icc_node *config_noc_nodes[] = {
 	[SLAVE_SERVICE_CNOC] = &slv_srvc_cnoc,
 };
 
-static struct qcom_icc_node *dc_noc_nodes[] = {
+static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[MASTER_CNOC_DC_NOC] = &mas_qhm_cnoc_dc_noc,
 	[SLAVE_GEM_NOC_CFG] = &slv_qhs_gemnoc,
 	[SLAVE_LLCC_CFG] = &slv_qhs_llcc,
 };
 
-static struct qcom_icc_node *gem_noc_nodes[] = {
+static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[MASTER_AMPSS_M0] = &mas_acm_apps,
 	[MASTER_GPU_TCU] = &mas_acm_gpu_tcu,
 	[MASTER_SYS_TCU] = &mas_acm_sys_tcu,
@@ -384,17 +384,17 @@ static struct qcom_icc_node *gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC_1] = &slv_srvc_gemnoc1,
 };
 
-static struct qcom_icc_node *ipa_virt_nodes[] = {
+static struct qcom_icc_node * const ipa_virt_nodes[] = {
 	[MASTER_IPA_CORE] = &mas_ipa_core_master,
 	[SLAVE_IPA_CORE] = &slv_ipa_core_slave,
 };
 
-static struct qcom_icc_node *mc_virt_nodes[] = {
+static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &mas_llcc_mc,
 	[SLAVE_EBI_CH0] = &slv_ebi,
 };
 
-static struct qcom_icc_node *mmss_noc_nodes[] = {
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[MASTER_CNOC_MNOC_CFG] = &mas_qhm_mnoc_cfg,
 	[MASTER_CAMNOC_HF0] = &mas_qxm_camnoc_hf0,
 	[MASTER_CAMNOC_HF1] = &mas_qxm_camnoc_hf1,
@@ -410,7 +410,7 @@ static struct qcom_icc_node *mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC] = &slv_srvc_mnoc,
 };
 
-static struct qcom_icc_node *system_noc_nodes[] = {
+static struct qcom_icc_node * const system_noc_nodes[] = {
 	[MASTER_SNOC_CFG] = &mas_qhm_snoc_cfg,
 	[A1NOC_SNOC_MAS] = &mas_qnm_aggre1_noc,
 	[A2NOC_SNOC_MAS] = &mas_qnm_aggre2_noc,
@@ -508,7 +508,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	const struct qcom_icc_desc *desc;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes;
+	struct qcom_icc_node * const *qnodes;
 	struct qcom_icc_provider *qp;
 	struct icc_node *node;
 	size_t num_nodes, i;
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 5bfc724e4c16..8d879b0bcabc 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1490,7 +1490,7 @@ static struct qcom_icc_node slv_srvc_snoc = {
 	.slv_rpm_id = 29,
 };
 
-static struct qcom_icc_node *sdm660_a2noc_nodes[] = {
+static struct qcom_icc_node * const sdm660_a2noc_nodes[] = {
 	[MASTER_IPA] = &mas_ipa,
 	[MASTER_CNOC_A2NOC] = &mas_cnoc_a2noc,
 	[MASTER_SDCC_1] = &mas_sdcc_1,
@@ -1521,7 +1521,7 @@ static const struct qcom_icc_desc sdm660_a2noc = {
 	.regmap_cfg = &sdm660_a2noc_regmap_config,
 };
 
-static struct qcom_icc_node *sdm660_bimc_nodes[] = {
+static struct qcom_icc_node * const sdm660_bimc_nodes[] = {
 	[MASTER_GNOC_BIMC] = &mas_gnoc_bimc,
 	[MASTER_OXILI] = &mas_oxili,
 	[MASTER_MNOC_BIMC] = &mas_mnoc_bimc,
@@ -1547,7 +1547,7 @@ static const struct qcom_icc_desc sdm660_bimc = {
 	.regmap_cfg = &sdm660_bimc_regmap_config,
 };
 
-static struct qcom_icc_node *sdm660_cnoc_nodes[] = {
+static struct qcom_icc_node * const sdm660_cnoc_nodes[] = {
 	[MASTER_SNOC_CNOC] = &mas_snoc_cnoc,
 	[MASTER_QDSS_DAP] = &mas_qdss_dap,
 	[SLAVE_CNOC_A2NOC] = &slv_cnoc_a2noc,
@@ -1601,7 +1601,7 @@ static const struct qcom_icc_desc sdm660_cnoc = {
 	.regmap_cfg = &sdm660_cnoc_regmap_config,
 };
 
-static struct qcom_icc_node *sdm660_gnoc_nodes[] = {
+static struct qcom_icc_node * const sdm660_gnoc_nodes[] = {
 	[MASTER_APSS_PROC] = &mas_apss_proc,
 	[SLAVE_GNOC_BIMC] = &slv_gnoc_bimc,
 	[SLAVE_GNOC_SNOC] = &slv_gnoc_snoc,
@@ -1622,7 +1622,7 @@ static const struct qcom_icc_desc sdm660_gnoc = {
 	.regmap_cfg = &sdm660_gnoc_regmap_config,
 };
 
-static struct qcom_icc_node *sdm660_mnoc_nodes[] = {
+static struct qcom_icc_node * const sdm660_mnoc_nodes[] = {
 	[MASTER_CPP] = &mas_cpp,
 	[MASTER_JPEG] = &mas_jpeg,
 	[MASTER_MDP_P0] = &mas_mdp_p0,
@@ -1664,7 +1664,7 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
 };
 
-static struct qcom_icc_node *sdm660_snoc_nodes[] = {
+static struct qcom_icc_node * const sdm660_snoc_nodes[] = {
 	[MASTER_QDSS_ETR] = &mas_qdss_etr,
 	[MASTER_QDSS_BAM] = &mas_qdss_bam,
 	[MASTER_SNOC_CFG] = &mas_snoc_cfg,
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index d2195079c228..1af0e6972bad 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -180,7 +180,7 @@ static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
 	&bcm_qup0,
 };
 
-static struct qcom_icc_node *aggre1_noc_nodes[] = {
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[MASTER_A1NOC_CFG] = &qhm_a1noc_cfg,
 	[MASTER_TSIF] = &qhm_tsif,
 	[MASTER_SDCC_2] = &xm_sdc2,
@@ -207,7 +207,7 @@ static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
 	&bcm_qup0,
 };
 
-static struct qcom_icc_node *aggre2_noc_nodes[] = {
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[MASTER_A2NOC_CFG] = &qhm_a2noc_cfg,
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
 	[MASTER_CNOC_A2NOC] = &qnm_cnoc,
@@ -234,7 +234,7 @@ static struct qcom_icc_bcm *config_noc_bcms[] = {
 	&bcm_cn0,
 };
 
-static struct qcom_icc_node *config_noc_nodes[] = {
+static struct qcom_icc_node * const config_noc_nodes[] = {
 	[MASTER_SPDM] = &qhm_spdm,
 	[MASTER_TIC] = &qhm_tic,
 	[MASTER_SNOC_CNOC] = &qnm_snoc,
@@ -294,7 +294,7 @@ static const struct qcom_icc_desc sdm845_config_noc = {
 static struct qcom_icc_bcm *dc_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *dc_noc_nodes[] = {
+static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[MASTER_CNOC_DC_NOC] = &qhm_cnoc,
 	[SLAVE_LLCC_CFG] = &qhs_llcc,
 	[SLAVE_MEM_NOC_CFG] = &qhs_memnoc,
@@ -310,7 +310,7 @@ static const struct qcom_icc_desc sdm845_dc_noc = {
 static struct qcom_icc_bcm *gladiator_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *gladiator_noc_nodes[] = {
+static struct qcom_icc_node * const gladiator_noc_nodes[] = {
 	[MASTER_APPSS_PROC] = &acm_l3,
 	[MASTER_GNOC_CFG] = &pm_gnoc_cfg,
 	[SLAVE_GNOC_SNOC] = &qns_gladiator_sodv,
@@ -335,7 +335,7 @@ static struct qcom_icc_bcm *mem_noc_bcms[] = {
 	&bcm_sh5,
 };
 
-static struct qcom_icc_node *mem_noc_nodes[] = {
+static struct qcom_icc_node * const mem_noc_nodes[] = {
 	[MASTER_TCU_0] = &acm_tcu,
 	[MASTER_MEM_NOC_CFG] = &qhm_memnoc_cfg,
 	[MASTER_GNOC_MEM_NOC] = &qnm_apps,
@@ -367,7 +367,7 @@ static struct qcom_icc_bcm *mmss_noc_bcms[] = {
 	&bcm_mm3,
 };
 
-static struct qcom_icc_node *mmss_noc_nodes[] = {
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[MASTER_CNOC_MNOC_CFG] = &qhm_mnoc_cfg,
 	[MASTER_CAMNOC_HF0] = &qxm_camnoc_hf0,
 	[MASTER_CAMNOC_HF1] = &qxm_camnoc_hf1,
@@ -411,7 +411,7 @@ static struct qcom_icc_bcm *system_noc_bcms[] = {
 	&bcm_sn15,
 };
 
-static struct qcom_icc_node *system_noc_nodes[] = {
+static struct qcom_icc_node * const system_noc_nodes[] = {
 	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
 	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
 	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index 03d604f84cc5..74ebf107d62f 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -106,7 +106,7 @@ static struct qcom_icc_bcm *mc_virt_bcms[] = {
 	&bcm_mc0,
 };
 
-static struct qcom_icc_node *mc_virt_nodes[] = {
+static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI_CH0] = &ebi,
 };
@@ -124,7 +124,7 @@ static struct qcom_icc_bcm *mem_noc_bcms[] = {
 	&bcm_sh4,
 };
 
-static struct qcom_icc_node *mem_noc_nodes[] = {
+static struct qcom_icc_node * const mem_noc_nodes[] = {
 	[MASTER_TCU_0] = &acm_tcu,
 	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
 	[MASTER_AMPSS_M0] = &xm_apps_rdwr,
@@ -159,7 +159,7 @@ static struct qcom_icc_bcm *system_noc_bcms[] = {
 	&bcm_sn11,
 };
 
-static struct qcom_icc_node *system_noc_nodes[] = {
+static struct qcom_icc_node * const system_noc_nodes[] = {
 	[MASTER_AUDIO] = &qhm_audio,
 	[MASTER_BLSP_1] = &qhm_blsp1,
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
@@ -223,7 +223,7 @@ static struct qcom_icc_bcm *ipa_virt_bcms[] = {
 	&bcm_ip0,
 };
 
-static struct qcom_icc_node *ipa_virt_nodes[] = {
+static struct qcom_icc_node * const ipa_virt_nodes[] = {
 	[MASTER_IPA_CORE] = &ipa_core_master,
 	[SLAVE_IPA_CORE] = &ipa_core_slave,
 };
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index 4f3bdc530dcf..5e08f2fba2a8 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -191,7 +191,7 @@ static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
 	&bcm_sn3,
 };
 
-static struct qcom_icc_node *aggre1_noc_nodes[] = {
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[MASTER_A1NOC_CFG] = &qhm_a1noc_cfg,
 	[MASTER_QUP_0] = &qhm_qup0,
 	[MASTER_EMAC] = &xm_emac,
@@ -216,7 +216,7 @@ static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
 	&bcm_sn3,
 };
 
-static struct qcom_icc_node *aggre2_noc_nodes[] = {
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[MASTER_A2NOC_CFG] = &qhm_a2noc_cfg,
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
 	[MASTER_QSPI] = &qhm_qspi,
@@ -248,7 +248,7 @@ static struct qcom_icc_bcm *camnoc_virt_bcms[] = {
 	&bcm_mm1,
 };
 
-static struct qcom_icc_node *camnoc_virt_nodes[] = {
+static struct qcom_icc_node * const camnoc_virt_nodes[] = {
 	[MASTER_CAMNOC_HF0_UNCOMP] = &qxm_camnoc_hf0_uncomp,
 	[MASTER_CAMNOC_HF1_UNCOMP] = &qxm_camnoc_hf1_uncomp,
 	[MASTER_CAMNOC_SF_UNCOMP] = &qxm_camnoc_sf_uncomp,
@@ -267,7 +267,7 @@ static struct qcom_icc_bcm *compute_noc_bcms[] = {
 	&bcm_co1,
 };
 
-static struct qcom_icc_node *compute_noc_nodes[] = {
+static struct qcom_icc_node * const compute_noc_nodes[] = {
 	[MASTER_NPU] = &qnm_npu,
 	[SLAVE_CDSP_MEM_NOC] = &qns_cdsp_mem_noc,
 };
@@ -283,7 +283,7 @@ static struct qcom_icc_bcm *config_noc_bcms[] = {
 	&bcm_cn0,
 };
 
-static struct qcom_icc_node *config_noc_nodes[] = {
+static struct qcom_icc_node * const config_noc_nodes[] = {
 	[MASTER_SPDM] = &qhm_spdm,
 	[SNOC_CNOC_MAS] = &qnm_snoc,
 	[MASTER_QDSS_DAP] = &xm_qdss_dap,
@@ -350,7 +350,7 @@ static const struct qcom_icc_desc sm8150_config_noc = {
 static struct qcom_icc_bcm *dc_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *dc_noc_nodes[] = {
+static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[MASTER_CNOC_DC_NOC] = &qhm_cnoc_dc_noc,
 	[SLAVE_LLCC_CFG] = &qhs_llcc,
 	[SLAVE_GEM_NOC_CFG] = &qhs_memnoc,
@@ -371,7 +371,7 @@ static struct qcom_icc_bcm *gem_noc_bcms[] = {
 	&bcm_sh5,
 };
 
-static struct qcom_icc_node *gem_noc_nodes[] = {
+static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[MASTER_AMPSS_M0] = &acm_apps,
 	[MASTER_GPU_TCU] = &acm_gpu_tcu,
 	[MASTER_SYS_TCU] = &acm_sys_tcu,
@@ -402,7 +402,7 @@ static struct qcom_icc_bcm *ipa_virt_bcms[] = {
 	&bcm_ip0,
 };
 
-static struct qcom_icc_node *ipa_virt_nodes[] = {
+static struct qcom_icc_node * const ipa_virt_nodes[] = {
 	[MASTER_IPA_CORE] = &ipa_core_master,
 	[SLAVE_IPA_CORE] = &ipa_core_slave,
 };
@@ -419,7 +419,7 @@ static struct qcom_icc_bcm *mc_virt_bcms[] = {
 	&bcm_mc0,
 };
 
-static struct qcom_icc_node *mc_virt_nodes[] = {
+static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI_CH0] = &ebi,
 };
@@ -438,7 +438,7 @@ static struct qcom_icc_bcm *mmss_noc_bcms[] = {
 	&bcm_mm3,
 };
 
-static struct qcom_icc_node *mmss_noc_nodes[] = {
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[MASTER_CNOC_MNOC_CFG] = &qhm_mnoc_cfg,
 	[MASTER_CAMNOC_HF0] = &qxm_camnoc_hf0,
 	[MASTER_CAMNOC_HF1] = &qxm_camnoc_hf1,
@@ -475,7 +475,7 @@ static struct qcom_icc_bcm *system_noc_bcms[] = {
 	&bcm_sn9,
 };
 
-static struct qcom_icc_node *system_noc_nodes[] = {
+static struct qcom_icc_node * const system_noc_nodes[] = {
 	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
 	[A1NOC_SNOC_MAS] = &qnm_aggre1_noc,
 	[A2NOC_SNOC_MAS] = &qnm_aggre2_noc,
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index b2e12b01a5e8..b186a76493ba 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -200,7 +200,7 @@ static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
 	&bcm_sn12,
 };
 
-static struct qcom_icc_node *aggre1_noc_nodes[] = {
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[MASTER_A1NOC_CFG] = &qhm_a1noc_cfg,
 	[MASTER_QSPI_0] = &qhm_qspi,
 	[MASTER_QUP_1] = &qhm_qup1,
@@ -229,7 +229,7 @@ static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
 	&bcm_sn12,
 };
 
-static struct qcom_icc_node *aggre2_noc_nodes[] = {
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[MASTER_A2NOC_CFG] = &qhm_a2noc_cfg,
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
 	[MASTER_QUP_0] = &qhm_qup0,
@@ -258,7 +258,7 @@ static struct qcom_icc_bcm *compute_noc_bcms[] = {
 	&bcm_co2,
 };
 
-static struct qcom_icc_node *compute_noc_nodes[] = {
+static struct qcom_icc_node * const compute_noc_nodes[] = {
 	[MASTER_NPU] = &qnm_npu,
 	[SLAVE_CDSP_MEM_NOC] = &qns_cdsp_mem_noc,
 };
@@ -274,7 +274,7 @@ static struct qcom_icc_bcm *config_noc_bcms[] = {
 	&bcm_cn0,
 };
 
-static struct qcom_icc_node *config_noc_nodes[] = {
+static struct qcom_icc_node * const config_noc_nodes[] = {
 	[SNOC_CNOC_MAS] = &qnm_snoc,
 	[MASTER_QDSS_DAP] = &xm_qdss_dap,
 	[SLAVE_A1NOC_CFG] = &qhs_a1_noc_cfg,
@@ -339,7 +339,7 @@ static const struct qcom_icc_desc sm8250_config_noc = {
 static struct qcom_icc_bcm *dc_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *dc_noc_nodes[] = {
+static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[MASTER_CNOC_DC_NOC] = &qhm_cnoc_dc_noc,
 	[SLAVE_LLCC_CFG] = &qhs_llcc,
 	[SLAVE_GEM_NOC_CFG] = &qhs_memnoc,
@@ -359,7 +359,7 @@ static struct qcom_icc_bcm *gem_noc_bcms[] = {
 	&bcm_sh4,
 };
 
-static struct qcom_icc_node *gem_noc_nodes[] = {
+static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[MASTER_GPU_TCU] = &alm_gpu_tcu,
 	[MASTER_SYS_TCU] = &alm_sys_tcu,
 	[MASTER_AMPSS_M0] = &chm_apps,
@@ -390,7 +390,7 @@ static struct qcom_icc_bcm *ipa_virt_bcms[] = {
 	&bcm_ip0,
 };
 
-static struct qcom_icc_node *ipa_virt_nodes[] = {
+static struct qcom_icc_node * const ipa_virt_nodes[] = {
 	[MASTER_IPA_CORE] = &ipa_core_master,
 	[SLAVE_IPA_CORE] = &ipa_core_slave,
 };
@@ -407,7 +407,7 @@ static struct qcom_icc_bcm *mc_virt_bcms[] = {
 	&bcm_mc0,
 };
 
-static struct qcom_icc_node *mc_virt_nodes[] = {
+static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI_CH0] = &ebi,
 };
@@ -426,7 +426,7 @@ static struct qcom_icc_bcm *mmss_noc_bcms[] = {
 	&bcm_mm3,
 };
 
-static struct qcom_icc_node *mmss_noc_nodes[] = {
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[MASTER_CNOC_MNOC_CFG] = &qhm_mnoc_cfg,
 	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
 	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
@@ -452,7 +452,7 @@ static const struct qcom_icc_desc sm8250_mmss_noc = {
 static struct qcom_icc_bcm *npu_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *npu_noc_nodes[] = {
+static struct qcom_icc_node * const npu_noc_nodes[] = {
 	[MASTER_NPU_SYS] = &amm_npu_sys,
 	[MASTER_NPU_CDP] = &amm_npu_sys_cdp_w,
 	[MASTER_NPU_NOC_CFG] = &qhm_cfg,
@@ -489,7 +489,7 @@ static struct qcom_icc_bcm *system_noc_bcms[] = {
 	&bcm_sn9,
 };
 
-static struct qcom_icc_node *system_noc_nodes[] = {
+static struct qcom_icc_node * const system_noc_nodes[] = {
 	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
 	[A1NOC_SNOC_MAS] = &qnm_aggre1_noc,
 	[A2NOC_SNOC_MAS] = &qnm_aggre2_noc,
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index 936164391d6a..dd0809f08388 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -201,7 +201,7 @@ DEFINE_QBCM(bcm_sh0_disp, "SH0", false, &qns_llcc_disp);
 static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *aggre1_noc_nodes[] = {
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[MASTER_QSPI_0] = &qhm_qspi,
 	[MASTER_QUP_1] = &qhm_qup1,
 	[MASTER_A1NOC_CFG] = &qnm_a1noc_cfg,
@@ -227,7 +227,7 @@ static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
 	&bcm_sn14,
 };
 
-static struct qcom_icc_node *aggre2_noc_nodes[] = {
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
 	[MASTER_QUP_0] = &qhm_qup0,
 	[MASTER_QUP_2] = &qhm_qup2,
@@ -259,7 +259,7 @@ static struct qcom_icc_bcm *config_noc_bcms[] = {
 	&bcm_sn4,
 };
 
-static struct qcom_icc_node *config_noc_nodes[] = {
+static struct qcom_icc_node * const config_noc_nodes[] = {
 	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
 	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
 	[MASTER_QDSS_DAP] = &xm_qdss_dap,
@@ -333,7 +333,7 @@ static const struct qcom_icc_desc sm8350_config_noc = {
 static struct qcom_icc_bcm *dc_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *dc_noc_nodes[] = {
+static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[MASTER_CNOC_DC_NOC] = &qnm_cnoc_dc_noc,
 	[SLAVE_LLCC_CFG] = &qhs_llcc,
 	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
@@ -354,7 +354,7 @@ static struct qcom_icc_bcm *gem_noc_bcms[] = {
 	&bcm_sh0_disp,
 };
 
-static struct qcom_icc_node *gem_noc_nodes[] = {
+static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[MASTER_GPU_TCU] = &alm_gpu_tcu,
 	[MASTER_SYS_TCU] = &alm_sys_tcu,
 	[MASTER_APPSS_PROC] = &chm_apps,
@@ -389,7 +389,7 @@ static const struct qcom_icc_desc sm8350_gem_noc = {
 static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *lpass_ag_noc_nodes[] = {
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 	[MASTER_CNOC_LPASS_AG_NOC] = &qhm_config_noc,
 	[SLAVE_LPASS_CORE_CFG] = &qhs_lpass_core,
 	[SLAVE_LPASS_LPI_CFG] = &qhs_lpass_lpi,
@@ -413,7 +413,7 @@ static struct qcom_icc_bcm *mc_virt_bcms[] = {
 	&bcm_mc0_disp,
 };
 
-static struct qcom_icc_node *mc_virt_nodes[] = {
+static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI1] = &ebi,
 	[MASTER_LLCC_DISP] = &llcc_mc_disp,
@@ -438,7 +438,7 @@ static struct qcom_icc_bcm *mmss_noc_bcms[] = {
 	&bcm_mm5_disp,
 };
 
-static struct qcom_icc_node *mmss_noc_nodes[] = {
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
 	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
 	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
@@ -471,7 +471,7 @@ static struct qcom_icc_bcm *nsp_noc_bcms[] = {
 	&bcm_co3,
 };
 
-static struct qcom_icc_node *nsp_noc_nodes[] = {
+static struct qcom_icc_node * const nsp_noc_nodes[] = {
 	[MASTER_CDSP_NOC_CFG] = &qhm_nsp_noc_config,
 	[MASTER_CDSP_PROC] = &qxm_nsp,
 	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
@@ -492,7 +492,7 @@ static struct qcom_icc_bcm *system_noc_bcms[] = {
 	&bcm_sn8,
 };
 
-static struct qcom_icc_node *system_noc_nodes[] = {
+static struct qcom_icc_node * const system_noc_nodes[] = {
 	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
 	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
 	[MASTER_SNOC_CFG] = &qnm_snoc_cfg,
diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index dbec8228e2e4..71fc31f59407 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1529,7 +1529,7 @@ static struct qcom_icc_bcm bcm_sh1_disp = {
 static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *aggre1_noc_nodes[] = {
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[MASTER_QSPI_0] = &qhm_qspi,
 	[MASTER_QUP_1] = &qhm_qup1,
 	[MASTER_A1NOC_CFG] = &qnm_a1noc_cfg,
@@ -1551,7 +1551,7 @@ static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
 	&bcm_ce0,
 };
 
-static struct qcom_icc_node *aggre2_noc_nodes[] = {
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
 	[MASTER_QUP_0] = &qhm_qup0,
 	[MASTER_QUP_2] = &qhm_qup2,
@@ -1580,7 +1580,7 @@ static struct qcom_icc_bcm *clk_virt_bcms[] = {
 	&bcm_qup2,
 };
 
-static struct qcom_icc_node *clk_virt_nodes[] = {
+static struct qcom_icc_node * const clk_virt_nodes[] = {
 	[MASTER_QUP_CORE_0] = &qup0_core_master,
 	[MASTER_QUP_CORE_1] = &qup1_core_master,
 	[MASTER_QUP_CORE_2] = &qup2_core_master,
@@ -1600,7 +1600,7 @@ static struct qcom_icc_bcm *config_noc_bcms[] = {
 	&bcm_cn0,
 };
 
-static struct qcom_icc_node *config_noc_nodes[] = {
+static struct qcom_icc_node * const config_noc_nodes[] = {
 	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
 	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
 	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
@@ -1672,7 +1672,7 @@ static struct qcom_icc_bcm *gem_noc_bcms[] = {
 	&bcm_sh1_disp,
 };
 
-static struct qcom_icc_node *gem_noc_nodes[] = {
+static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[MASTER_GPU_TCU] = &alm_gpu_tcu,
 	[MASTER_SYS_TCU] = &alm_sys_tcu,
 	[MASTER_APPSS_PROC] = &chm_apps,
@@ -1703,7 +1703,7 @@ static const struct qcom_icc_desc sm8450_gem_noc = {
 static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *lpass_ag_noc_nodes[] = {
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 	[MASTER_CNOC_LPASS_AG_NOC] = &qhm_config_noc,
 	[MASTER_LPASS_PROC] = &qxm_lpass_dsp,
 	[SLAVE_LPASS_CORE_CFG] = &qhs_lpass_core,
@@ -1729,7 +1729,7 @@ static struct qcom_icc_bcm *mc_virt_bcms[] = {
 	&bcm_mc0_disp,
 };
 
-static struct qcom_icc_node *mc_virt_nodes[] = {
+static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI1] = &ebi,
 	[MASTER_LLCC_DISP] = &llcc_mc_disp,
@@ -1750,7 +1750,7 @@ static struct qcom_icc_bcm *mmss_noc_bcms[] = {
 	&bcm_mm1_disp,
 };
 
-static struct qcom_icc_node *mmss_noc_nodes[] = {
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
 	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
 	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
@@ -1782,7 +1782,7 @@ static struct qcom_icc_bcm *nsp_noc_bcms[] = {
 	&bcm_co0,
 };
 
-static struct qcom_icc_node *nsp_noc_nodes[] = {
+static struct qcom_icc_node * const nsp_noc_nodes[] = {
 	[MASTER_CDSP_NOC_CFG] = &qhm_nsp_noc_config,
 	[MASTER_CDSP_PROC] = &qxm_nsp,
 	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
@@ -1800,7 +1800,7 @@ static struct qcom_icc_bcm *pcie_anoc_bcms[] = {
 	&bcm_sn7,
 };
 
-static struct qcom_icc_node *pcie_anoc_nodes[] = {
+static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 	[MASTER_PCIE_ANOC_CFG] = &qnm_pcie_anoc_cfg,
 	[MASTER_PCIE_0] = &xm_pcie3_0,
 	[MASTER_PCIE_1] = &xm_pcie3_1,
@@ -1823,7 +1823,7 @@ static struct qcom_icc_bcm *system_noc_bcms[] = {
 	&bcm_sn4,
 };
 
-static struct qcom_icc_node *system_noc_nodes[] = {
+static struct qcom_icc_node * const system_noc_nodes[] = {
 	[MASTER_GIC_AHB] = &qhm_gic,
 	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
 	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
@@ -1848,7 +1848,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	const struct qcom_icc_desc *desc;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes;
+	struct qcom_icc_node * const *qnodes;
 	struct qcom_icc_provider *qp;
 	struct icc_node *node;
 	size_t num_nodes, i;
-- 
2.32.0

