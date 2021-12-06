Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0821D46911C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbhLFICY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbhLFICS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:02:18 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC9CC0698C2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 23:58:48 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id k26so5037785pfp.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 23:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xF+z+/w9tHZnATVNsG/rEi3Ra+Cy4gXrR47G7xJAFeI=;
        b=SfOp3tSvWyHu/Bc+PM4l/eL0wnNBz/bRtjt7EY8pe+bU/M5+tA5Y6H6xHB7udxbLMy
         rsmiG6BtdkX+QkvyU5qVIfs2cYDNOaU7t9iteGm1kN2cKKh41BzJKfGHrScdgNxFOPdu
         ycTjiqv48XTtEcAwSdvbLFcPu3SFHKU43bu21BNFp3RGM//rPzfr+8HvS5iJG6lvkco0
         HhsHyq7HbOKj9xbX6uiLBXZXYf8KtOzKnfzLVDBEnJ5jOf1oAlwnwfn/t789LbUBuD8B
         PO1qrK3CKDxSwfzV9y0L9O2z8jVP0CttpKNabMLQ84h7pwZY8JFSR+eQMwjWZzp1kbXT
         3Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xF+z+/w9tHZnATVNsG/rEi3Ra+Cy4gXrR47G7xJAFeI=;
        b=thNeaoA862WMyiEn61k+1xtOPHxsAl475vM5NBCiPdzbTRsNQp7qW1YZbLK1PJkWPc
         Rw1InvwUmFTJ2caBqmkk76APd8zFZHKh9BZFjQ238cfNVtQbpakgMYOJUVjluCS9IMc/
         lY4H0DSExfVLumVgdPZNkv6oBh4ioE8fFm2upG34nVUZyC16OyK9Q5KQ+pJKpYjtEygA
         a+sLx5k6OqlsiidDEggudTs9WPAepVqkRNTMSUb6XIezdgxjQAZNYZRAfRfTdyDXEhEs
         X76xiG5eep9yzrAI1GM1RVCo6ZCwjWACVomMBUlOkMFHday5GeqpsQprG9D0tyyi0TKz
         K3qg==
X-Gm-Message-State: AOAM533XVPEtn6/Fv005QWpikZX6BcRHme5C96Y3tLU+Uzh7AmCH99H1
        NKgTzmmwNIq+mI1lmHDGE5OuOA==
X-Google-Smtp-Source: ABdhPJz9VeUO3ICsF52Wmjdi/V57q8Zc69CTlooFsaEGmvD6RN048+PBgAXlRKT2coAUKASANhvaeQ==
X-Received: by 2002:a63:7d8:: with SMTP id 207mr363204pgh.310.1638777528085;
        Sun, 05 Dec 2021 23:58:48 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id p15sm11794476pfo.143.2021.12.05.23.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 23:58:47 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 6/6] interconnect: qcom: Add QCM2290 driver support
Date:   Mon,  6 Dec 2021 15:58:08 +0800
Message-Id: <20211206075808.18124-7-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211206075808.18124-1-shawn.guo@linaro.org>
References: <20211206075808.18124-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds interconnect driver support for QCM2290 platform.  The topology
consists of 3 NoCs: BIMC, Config NoC (CNOC) and System NoC (SNOC).  SNOC
is a QCOM_ICC_QNOC type device, as well as its 3 virtual child devices,
QUP, MMNRT and MMRT.  QUP is owned by RPM and thus has no .regmap_cfg,
while the other 2 share the same .regmap_cfg with SNOC (parent).

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/interconnect/qcom/Kconfig   |    9 +
 drivers/interconnect/qcom/Makefile  |    2 +
 drivers/interconnect/qcom/qcm2290.c | 1363 +++++++++++++++++++++++++++
 3 files changed, 1374 insertions(+)
 create mode 100644 drivers/interconnect/qcom/qcm2290.c

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index daf1e25f6042..8d24ee3732c8 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -42,6 +42,15 @@ config INTERCONNECT_QCOM_OSM_L3
 	  Say y here to support the Operating State Manager (OSM) interconnect
 	  driver which controls the scaling of L3 caches on Qualcomm SoCs.
 
+config INTERCONNECT_QCOM_QCM2290
+	tristate "Qualcomm QCM2290 interconnect driver"
+	depends on INTERCONNECT_QCOM
+	depends on QCOM_SMD_RPM
+	select INTERCONNECT_QCOM_SMD_RPM
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on qcm2290-based
+	  platforms.
+
 config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
 	depends on INTERCONNECT_QCOM
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 69300b1d48ef..8436279b7e1f 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -5,6 +5,7 @@ qnoc-msm8916-objs			:= msm8916.o
 qnoc-msm8939-objs			:= msm8939.o
 qnoc-msm8974-objs			:= msm8974.o
 icc-osm-l3-objs				:= osm-l3.o
+qnoc-qcm2290-objs			:= qcm2290.o
 qnoc-qcs404-objs			:= qcs404.o
 icc-rpmh-obj				:= icc-rpmh.o
 qnoc-sc7180-objs			:= sc7180.o
@@ -23,6 +24,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8939) += qnoc-msm8939.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
 obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
+obj-$(CONFIG_INTERCONNECT_QCOM_QCM2290) += qnoc-qcm2290.o
 obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
 obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
new file mode 100644
index 000000000000..74404e0b2080
--- /dev/null
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -0,0 +1,1363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm QCM2290 Network-on-Chip (NoC) QoS driver
+ *
+ * Copyright (c) 2021, Linaro Ltd.
+ *
+ */
+
+#include <dt-bindings/interconnect/qcom,qcm2290.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "icc-rpm.h"
+#include "smd-rpm.h"
+
+enum {
+	QCM2290_MASTER_APPSS_PROC = 1,
+	QCM2290_MASTER_SNOC_BIMC_RT,
+	QCM2290_MASTER_SNOC_BIMC_NRT,
+	QCM2290_MASTER_SNOC_BIMC,
+	QCM2290_MASTER_TCU_0,
+	QCM2290_MASTER_GFX3D,
+	QCM2290_MASTER_SNOC_CNOC,
+	QCM2290_MASTER_QDSS_DAP,
+	QCM2290_MASTER_CRYPTO_CORE0,
+	QCM2290_MASTER_SNOC_CFG,
+	QCM2290_MASTER_TIC,
+	QCM2290_MASTER_ANOC_SNOC,
+	QCM2290_MASTER_BIMC_SNOC,
+	QCM2290_MASTER_PIMEM,
+	QCM2290_MASTER_QDSS_BAM,
+	QCM2290_MASTER_QUP_0,
+	QCM2290_MASTER_IPA,
+	QCM2290_MASTER_QDSS_ETR,
+	QCM2290_MASTER_SDCC_1,
+	QCM2290_MASTER_SDCC_2,
+	QCM2290_MASTER_QPIC,
+	QCM2290_MASTER_USB3_0,
+	QCM2290_MASTER_QUP_CORE_0,
+	QCM2290_MASTER_CAMNOC_SF,
+	QCM2290_MASTER_VIDEO_P0,
+	QCM2290_MASTER_VIDEO_PROC,
+	QCM2290_MASTER_CAMNOC_HF,
+	QCM2290_MASTER_MDP0,
+
+	QCM2290_SLAVE_EBI1,
+	QCM2290_SLAVE_BIMC_SNOC,
+	QCM2290_SLAVE_BIMC_CFG,
+	QCM2290_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+	QCM2290_SLAVE_CAMERA_RT_THROTTLE_CFG,
+	QCM2290_SLAVE_CAMERA_CFG,
+	QCM2290_SLAVE_CLK_CTL,
+	QCM2290_SLAVE_CRYPTO_0_CFG,
+	QCM2290_SLAVE_DISPLAY_CFG,
+	QCM2290_SLAVE_DISPLAY_THROTTLE_CFG,
+	QCM2290_SLAVE_GPU_CFG,
+	QCM2290_SLAVE_HWKM,
+	QCM2290_SLAVE_IMEM_CFG,
+	QCM2290_SLAVE_IPA_CFG,
+	QCM2290_SLAVE_LPASS,
+	QCM2290_SLAVE_MESSAGE_RAM,
+	QCM2290_SLAVE_PDM,
+	QCM2290_SLAVE_PIMEM_CFG,
+	QCM2290_SLAVE_PKA_WRAPPER,
+	QCM2290_SLAVE_PMIC_ARB,
+	QCM2290_SLAVE_PRNG,
+	QCM2290_SLAVE_QDSS_CFG,
+	QCM2290_SLAVE_QM_CFG,
+	QCM2290_SLAVE_QM_MPU_CFG,
+	QCM2290_SLAVE_QPIC,
+	QCM2290_SLAVE_QUP_0,
+	QCM2290_SLAVE_SDCC_1,
+	QCM2290_SLAVE_SDCC_2,
+	QCM2290_SLAVE_SNOC_CFG,
+	QCM2290_SLAVE_TCSR,
+	QCM2290_SLAVE_USB3,
+	QCM2290_SLAVE_VENUS_CFG,
+	QCM2290_SLAVE_VENUS_THROTTLE_CFG,
+	QCM2290_SLAVE_VSENSE_CTRL_CFG,
+	QCM2290_SLAVE_SERVICE_CNOC,
+	QCM2290_SLAVE_APPSS,
+	QCM2290_SLAVE_SNOC_CNOC,
+	QCM2290_SLAVE_IMEM,
+	QCM2290_SLAVE_PIMEM,
+	QCM2290_SLAVE_SNOC_BIMC,
+	QCM2290_SLAVE_SERVICE_SNOC,
+	QCM2290_SLAVE_QDSS_STM,
+	QCM2290_SLAVE_TCU,
+	QCM2290_SLAVE_ANOC_SNOC,
+	QCM2290_SLAVE_QUP_CORE_0,
+	QCM2290_SLAVE_SNOC_BIMC_NRT,
+	QCM2290_SLAVE_SNOC_BIMC_RT,
+};
+
+/* Master nodes */
+static const u16 mas_appss_proc_links[] = {
+	QCM2290_SLAVE_EBI1,
+	QCM2290_SLAVE_BIMC_SNOC,
+};
+
+static struct qcom_icc_node mas_appss_proc = {
+	.id = QCM2290_MASTER_APPSS_PROC,
+	.name = "mas_apps_proc",
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_port = 0,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.mas_rpm_id = 0,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_appss_proc_links),
+	.links = mas_appss_proc_links,
+};
+
+static const u16 mas_snoc_bimc_rt_links[] = {
+	QCM2290_SLAVE_EBI1,
+};
+
+static struct qcom_icc_node mas_snoc_bimc_rt = {
+	.id = QCM2290_MASTER_SNOC_BIMC_RT,
+	.name = "mas_snoc_bimc_rt",
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_port = 2,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.mas_rpm_id = 163,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_bimc_rt_links),
+	.links = mas_snoc_bimc_rt_links,
+};
+
+static const u16 mas_snoc_bimc_nrt_links[] = {
+	QCM2290_SLAVE_EBI1,
+};
+
+static struct qcom_icc_node mas_snoc_bimc_nrt = {
+	.id = QCM2290_MASTER_SNOC_BIMC_NRT,
+	.name = "mas_snoc_bimc_nrt",
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_port = 2,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.mas_rpm_id = 163,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_bimc_nrt_links),
+	.links = mas_snoc_bimc_nrt_links,
+};
+
+static const u16 mas_snoc_bimc_links[] = {
+	QCM2290_SLAVE_EBI1,
+};
+
+static struct qcom_icc_node mas_snoc_bimc = {
+	.id = QCM2290_MASTER_SNOC_BIMC,
+	.name = "mas_snoc_bimc",
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_port = 2,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.mas_rpm_id = 164,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_bimc_links),
+	.links = mas_snoc_bimc_links,
+};
+
+static const u16 mas_tcu_0_links[] = {
+	QCM2290_SLAVE_EBI1,
+	QCM2290_SLAVE_BIMC_SNOC,
+};
+
+static struct qcom_icc_node mas_tcu_0 = {
+	.id = QCM2290_MASTER_TCU_0,
+	.name = "mas_tcu_0",
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_port = 4,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.prio_level = 6,
+	.qos.areq_prio = 6,
+	.mas_rpm_id = 102,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_tcu_0_links),
+	.links = mas_tcu_0_links,
+};
+
+static const u16 mas_snoc_cnoc_links[] = {
+	QCM2290_SLAVE_CAMERA_RT_THROTTLE_CFG,
+	QCM2290_SLAVE_SDCC_2,
+	QCM2290_SLAVE_SDCC_1,
+	QCM2290_SLAVE_QM_CFG,
+	QCM2290_SLAVE_BIMC_CFG,
+	QCM2290_SLAVE_USB3,
+	QCM2290_SLAVE_QM_MPU_CFG,
+	QCM2290_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+	QCM2290_SLAVE_QDSS_CFG,
+	QCM2290_SLAVE_PDM,
+	QCM2290_SLAVE_IPA_CFG,
+	QCM2290_SLAVE_DISPLAY_THROTTLE_CFG,
+	QCM2290_SLAVE_TCSR,
+	QCM2290_SLAVE_MESSAGE_RAM,
+	QCM2290_SLAVE_PMIC_ARB,
+	QCM2290_SLAVE_LPASS,
+	QCM2290_SLAVE_DISPLAY_CFG,
+	QCM2290_SLAVE_VENUS_CFG,
+	QCM2290_SLAVE_GPU_CFG,
+	QCM2290_SLAVE_IMEM_CFG,
+	QCM2290_SLAVE_SNOC_CFG,
+	QCM2290_SLAVE_SERVICE_CNOC,
+	QCM2290_SLAVE_VENUS_THROTTLE_CFG,
+	QCM2290_SLAVE_PKA_WRAPPER,
+	QCM2290_SLAVE_HWKM,
+	QCM2290_SLAVE_PRNG,
+	QCM2290_SLAVE_VSENSE_CTRL_CFG,
+	QCM2290_SLAVE_CRYPTO_0_CFG,
+	QCM2290_SLAVE_PIMEM_CFG,
+	QCM2290_SLAVE_QUP_0,
+	QCM2290_SLAVE_CAMERA_CFG,
+	QCM2290_SLAVE_CLK_CTL,
+	QCM2290_SLAVE_QPIC,
+};
+
+static struct qcom_icc_node mas_snoc_cnoc = {
+	.id = QCM2290_MASTER_SNOC_CNOC,
+	.name = "mas_snoc_cnoc",
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = 52,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_cnoc_links),
+	.links = mas_snoc_cnoc_links,
+};
+
+static const u16 mas_qdss_dap_links[] = {
+	QCM2290_SLAVE_CAMERA_RT_THROTTLE_CFG,
+	QCM2290_SLAVE_SDCC_2,
+	QCM2290_SLAVE_SDCC_1,
+	QCM2290_SLAVE_QM_CFG,
+	QCM2290_SLAVE_BIMC_CFG,
+	QCM2290_SLAVE_USB3,
+	QCM2290_SLAVE_QM_MPU_CFG,
+	QCM2290_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+	QCM2290_SLAVE_QDSS_CFG,
+	QCM2290_SLAVE_PDM,
+	QCM2290_SLAVE_IPA_CFG,
+	QCM2290_SLAVE_DISPLAY_THROTTLE_CFG,
+	QCM2290_SLAVE_TCSR,
+	QCM2290_SLAVE_MESSAGE_RAM,
+	QCM2290_SLAVE_PMIC_ARB,
+	QCM2290_SLAVE_LPASS,
+	QCM2290_SLAVE_DISPLAY_CFG,
+	QCM2290_SLAVE_VENUS_CFG,
+	QCM2290_SLAVE_GPU_CFG,
+	QCM2290_SLAVE_IMEM_CFG,
+	QCM2290_SLAVE_SNOC_CFG,
+	QCM2290_SLAVE_SERVICE_CNOC,
+	QCM2290_SLAVE_VENUS_THROTTLE_CFG,
+	QCM2290_SLAVE_PKA_WRAPPER,
+	QCM2290_SLAVE_HWKM,
+	QCM2290_SLAVE_PRNG,
+	QCM2290_SLAVE_VSENSE_CTRL_CFG,
+	QCM2290_SLAVE_CRYPTO_0_CFG,
+	QCM2290_SLAVE_PIMEM_CFG,
+	QCM2290_SLAVE_QUP_0,
+	QCM2290_SLAVE_CAMERA_CFG,
+	QCM2290_SLAVE_CLK_CTL,
+	QCM2290_SLAVE_QPIC,
+};
+
+static struct qcom_icc_node mas_qdss_dap = {
+	.id = QCM2290_MASTER_QDSS_DAP,
+	.name = "mas_qdss_dap",
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = 49,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_qdss_dap_links),
+	.links = mas_qdss_dap_links,
+};
+
+static const u16 mas_crypto_core0_links[] = {
+	QCM2290_SLAVE_ANOC_SNOC
+};
+
+static struct qcom_icc_node mas_crypto_core0 = {
+	.id = QCM2290_MASTER_CRYPTO_CORE0,
+	.name = "mas_crypto_core0",
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_port = 22,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 2,
+	.mas_rpm_id = 23,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_crypto_core0_links),
+	.links = mas_crypto_core0_links,
+};
+
+static const u16 mas_qup_core_0_links[] = {
+	QCM2290_SLAVE_QUP_CORE_0,
+};
+
+static struct qcom_icc_node mas_qup_core_0 = {
+	.id = QCM2290_MASTER_QUP_CORE_0,
+	.name = "mas_qup_core_0",
+	.buswidth = 4,
+	.mas_rpm_id = 170,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_qup_core_0_links),
+	.links = mas_qup_core_0_links,
+};
+
+static const u16 mas_camnoc_sf_links[] = {
+	QCM2290_SLAVE_SNOC_BIMC_NRT,
+};
+
+static struct qcom_icc_node mas_camnoc_sf = {
+	.id = QCM2290_MASTER_CAMNOC_SF,
+	.name = "mas_camnoc_sf",
+	.buswidth = 32,
+	.qos.ap_owned = true,
+	.qos.qos_port = 4,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 3,
+	.mas_rpm_id = 172,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_camnoc_sf_links),
+	.links = mas_camnoc_sf_links,
+};
+
+static const u16 mas_camnoc_hf_links[] = {
+	QCM2290_SLAVE_SNOC_BIMC_RT,
+};
+
+static struct qcom_icc_node mas_camnoc_hf = {
+	.id = QCM2290_MASTER_CAMNOC_HF,
+	.name = "mas_camnoc_hf",
+	.buswidth = 32,
+	.qos.ap_owned = true,
+	.qos.qos_port = 10,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 3,
+	.qos.urg_fwd_en = true,
+	.mas_rpm_id = 173,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_camnoc_hf_links),
+	.links = mas_camnoc_hf_links,
+};
+
+static const u16 mas_mdp0_links[] = {
+	QCM2290_SLAVE_SNOC_BIMC_RT,
+};
+
+static struct qcom_icc_node mas_mdp0 = {
+	.id = QCM2290_MASTER_MDP0,
+	.name = "mas_mdp0",
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_port = 5,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 3,
+	.qos.urg_fwd_en = true,
+	.mas_rpm_id = 8,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_mdp0_links),
+	.links = mas_mdp0_links,
+};
+
+static const u16 mas_video_p0_links[] = {
+	QCM2290_SLAVE_SNOC_BIMC_NRT,
+};
+
+static struct qcom_icc_node mas_video_p0 = {
+	.id = QCM2290_MASTER_VIDEO_P0,
+	.name = "mas_video_p0",
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_port = 9,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 3,
+	.qos.urg_fwd_en = true,
+	.mas_rpm_id = 9,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_video_p0_links),
+	.links = mas_video_p0_links,
+};
+
+static const u16 mas_video_proc_links[] = {
+	QCM2290_SLAVE_SNOC_BIMC_NRT,
+};
+
+static struct qcom_icc_node mas_video_proc = {
+	.id = QCM2290_MASTER_VIDEO_PROC,
+	.name = "mas_video_proc",
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_port = 13,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 4,
+	.mas_rpm_id = 168,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_video_proc_links),
+	.links = mas_video_proc_links,
+};
+
+static const u16 mas_snoc_cfg_links[] = {
+	QCM2290_SLAVE_SERVICE_SNOC,
+};
+
+static struct qcom_icc_node mas_snoc_cfg = {
+	.id = QCM2290_MASTER_SNOC_CFG,
+	.name = "mas_snoc_cfg",
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = 20,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_cfg_links),
+	.links = mas_snoc_cfg_links,
+};
+
+static const u16 mas_tic_links[] = {
+	QCM2290_SLAVE_PIMEM,
+	QCM2290_SLAVE_IMEM,
+	QCM2290_SLAVE_APPSS,
+	QCM2290_SLAVE_SNOC_BIMC,
+	QCM2290_SLAVE_SNOC_CNOC,
+	QCM2290_SLAVE_TCU,
+	QCM2290_SLAVE_QDSS_STM,
+};
+
+static struct qcom_icc_node mas_tic = {
+	.id = QCM2290_MASTER_TIC,
+	.name = "mas_tic",
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_port = 8,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 2,
+	.mas_rpm_id = 51,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_tic_links),
+	.links = mas_tic_links,
+};
+
+static const u16 mas_anoc_snoc_links[] = {
+	QCM2290_SLAVE_PIMEM,
+	QCM2290_SLAVE_IMEM,
+	QCM2290_SLAVE_APPSS,
+	QCM2290_SLAVE_SNOC_BIMC,
+	QCM2290_SLAVE_SNOC_CNOC,
+	QCM2290_SLAVE_TCU,
+	QCM2290_SLAVE_QDSS_STM,
+};
+
+static struct qcom_icc_node mas_anoc_snoc = {
+	.id = QCM2290_MASTER_ANOC_SNOC,
+	.name = "mas_anoc_snoc",
+	.buswidth = 16,
+	.mas_rpm_id = 110,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_anoc_snoc_links),
+	.links = mas_anoc_snoc_links,
+};
+
+static const u16 mas_bimc_snoc_links[] = {
+	QCM2290_SLAVE_PIMEM,
+	QCM2290_SLAVE_IMEM,
+	QCM2290_SLAVE_APPSS,
+	QCM2290_SLAVE_SNOC_CNOC,
+	QCM2290_SLAVE_TCU,
+	QCM2290_SLAVE_QDSS_STM,
+};
+
+static struct qcom_icc_node mas_bimc_snoc = {
+	.id = QCM2290_MASTER_BIMC_SNOC,
+	.name = "mas_bimc_snoc",
+	.buswidth = 8,
+	.mas_rpm_id = 21,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_bimc_snoc_links),
+	.links = mas_bimc_snoc_links,
+};
+
+static const u16 mas_pimem_links[] = {
+	QCM2290_SLAVE_IMEM,
+	QCM2290_SLAVE_SNOC_BIMC,
+};
+
+static struct qcom_icc_node mas_pimem = {
+	.id = QCM2290_MASTER_PIMEM,
+	.name = "mas_pimem",
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_port = 20,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 2,
+	.mas_rpm_id = 113,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_pimem_links),
+	.links = mas_pimem_links,
+};
+
+static const u16 mas_qdss_bam_links[] = {
+	QCM2290_SLAVE_ANOC_SNOC,
+};
+
+static struct qcom_icc_node mas_qdss_bam = {
+	.id = QCM2290_MASTER_QDSS_BAM,
+	.name = "mas_qdss_bam",
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_port = 2,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 2,
+	.mas_rpm_id = 19,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
+	.links = mas_qdss_bam_links,
+};
+
+static const u16 mas_qup_0_links[] = {
+	QCM2290_SLAVE_ANOC_SNOC,
+};
+
+static struct qcom_icc_node mas_qup_0 = {
+	.id = QCM2290_MASTER_QUP_0,
+	.name = "mas_qup_0",
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_port = 0,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 2,
+	.mas_rpm_id = 166,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_qup_0_links),
+	.links = mas_qup_0_links,
+};
+
+static const u16 mas_ipa_links[] = {
+	QCM2290_SLAVE_ANOC_SNOC,
+};
+
+static struct qcom_icc_node mas_ipa = {
+	.id = QCM2290_MASTER_IPA,
+	.name = "mas_ipa",
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_port = 3,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 2,
+	.mas_rpm_id = 59,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_ipa_links),
+	.links = mas_ipa_links,
+};
+
+static const u16 mas_qdss_etr_links[] = {
+	QCM2290_SLAVE_ANOC_SNOC,
+};
+
+static struct qcom_icc_node mas_qdss_etr = {
+	.id = QCM2290_MASTER_QDSS_ETR,
+	.name = "mas_qdss_etr",
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_port = 12,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 2,
+	.mas_rpm_id = 31,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
+	.links = mas_qdss_etr_links,
+};
+
+static const u16 mas_sdcc_1_links[] = {
+	QCM2290_SLAVE_ANOC_SNOC,
+};
+
+static struct qcom_icc_node mas_sdcc_1 = {
+	.id = QCM2290_MASTER_SDCC_1,
+	.name = "mas_sdcc_1",
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_port = 17,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 2,
+	.mas_rpm_id = 33,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_sdcc_1_links),
+	.links = mas_sdcc_1_links,
+};
+
+static const u16 mas_sdcc_2_links[] = {
+	QCM2290_SLAVE_ANOC_SNOC,
+};
+
+static struct qcom_icc_node mas_sdcc_2 = {
+	.id = QCM2290_MASTER_SDCC_2,
+	.name = "mas_sdcc_2",
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_port = 23,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 2,
+	.mas_rpm_id = 35,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_sdcc_2_links),
+	.links = mas_sdcc_2_links,
+};
+
+static const u16 mas_qpic_links[] = {
+	QCM2290_SLAVE_ANOC_SNOC,
+};
+
+static struct qcom_icc_node mas_qpic = {
+	.id = QCM2290_MASTER_QPIC,
+	.name = "mas_qpic",
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_port = 1,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 2,
+	.mas_rpm_id = 58,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_qpic_links),
+	.links = mas_qpic_links,
+};
+
+static const u16 mas_usb3_0_links[] = {
+	QCM2290_SLAVE_ANOC_SNOC,
+};
+
+static struct qcom_icc_node mas_usb3_0 = {
+	.id = QCM2290_MASTER_USB3_0,
+	.name = "mas_usb3_0",
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_port = 24,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 2,
+	.mas_rpm_id = 32,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_usb3_0_links),
+	.links = mas_usb3_0_links,
+};
+
+static const u16 mas_gfx3d_links[] = {
+	QCM2290_SLAVE_EBI1,
+};
+
+static struct qcom_icc_node mas_gfx3d = {
+	.id = QCM2290_MASTER_GFX3D,
+	.name = "mas_gfx3d",
+	.buswidth = 32,
+	.qos.ap_owned = true,
+	.qos.qos_port = 1,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.mas_rpm_id = 6,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_gfx3d_links),
+	.links = mas_gfx3d_links,
+};
+
+/* Slave nodes */
+static struct qcom_icc_node slv_ebi1 = {
+	.name = "slv_ebi1",
+	.id = QCM2290_SLAVE_EBI1,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 0,
+};
+
+static const u16 slv_bimc_snoc_links[] = {
+	QCM2290_MASTER_BIMC_SNOC,
+};
+
+static struct qcom_icc_node slv_bimc_snoc = {
+	.name = "slv_bimc_snoc",
+	.id = QCM2290_SLAVE_BIMC_SNOC,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 2,
+	.num_links = ARRAY_SIZE(slv_bimc_snoc_links),
+	.links = slv_bimc_snoc_links,
+};
+
+static struct qcom_icc_node slv_bimc_cfg = {
+	.name = "slv_bimc_cfg",
+	.id = QCM2290_SLAVE_BIMC_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 56,
+};
+
+static struct qcom_icc_node slv_camera_nrt_throttle_cfg = {
+	.name = "slv_camera_nrt_throttle_cfg",
+	.id = QCM2290_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 271,
+};
+
+static struct qcom_icc_node slv_camera_rt_throttle_cfg = {
+	.name = "slv_camera_rt_throttle_cfg",
+	.id = QCM2290_SLAVE_CAMERA_RT_THROTTLE_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 279,
+};
+
+static struct qcom_icc_node slv_camera_cfg = {
+	.name = "slv_camera_cfg",
+	.id = QCM2290_SLAVE_CAMERA_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 3,
+};
+
+static struct qcom_icc_node slv_clk_ctl = {
+	.name = "slv_clk_ctl",
+	.id = QCM2290_SLAVE_CLK_CTL,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 47,
+};
+
+static struct qcom_icc_node slv_crypto_0_cfg = {
+	.name = "slv_crypto_0_cfg",
+	.id = QCM2290_SLAVE_CRYPTO_0_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 52,
+};
+
+static struct qcom_icc_node slv_display_cfg = {
+	.name = "slv_display_cfg",
+	.id = QCM2290_SLAVE_DISPLAY_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 4,
+};
+
+static struct qcom_icc_node slv_display_throttle_cfg = {
+	.name = "slv_display_throttle_cfg",
+	.id = QCM2290_SLAVE_DISPLAY_THROTTLE_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 156,
+};
+
+static struct qcom_icc_node slv_gpu_cfg = {
+	.name = "slv_gpu_cfg",
+	.id = QCM2290_SLAVE_GPU_CFG,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 275,
+};
+
+static struct qcom_icc_node slv_hwkm = {
+	.name = "slv_hwkm",
+	.id = QCM2290_SLAVE_HWKM,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 280,
+};
+
+static struct qcom_icc_node slv_imem_cfg = {
+	.name = "slv_imem_cfg",
+	.id = QCM2290_SLAVE_IMEM_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 54,
+};
+
+static struct qcom_icc_node slv_ipa_cfg = {
+	.name = "slv_ipa_cfg",
+	.id = QCM2290_SLAVE_IPA_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 183,
+};
+
+static struct qcom_icc_node slv_lpass = {
+	.name = "slv_lpass",
+	.id = QCM2290_SLAVE_LPASS,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 21,
+};
+
+static struct qcom_icc_node slv_message_ram = {
+	.name = "slv_message_ram",
+	.id = QCM2290_SLAVE_MESSAGE_RAM,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 55,
+};
+
+static struct qcom_icc_node slv_pdm = {
+	.name = "slv_pdm",
+	.id = QCM2290_SLAVE_PDM,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 41,
+};
+
+static struct qcom_icc_node slv_pimem_cfg = {
+	.name = "slv_pimem_cfg",
+	.id = QCM2290_SLAVE_PIMEM_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 167,
+};
+
+static struct qcom_icc_node slv_pka_wrapper = {
+	.name = "slv_pka_wrapper",
+	.id = QCM2290_SLAVE_PKA_WRAPPER,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 281,
+};
+
+static struct qcom_icc_node slv_pmic_arb = {
+	.name = "slv_pmic_arb",
+	.id = QCM2290_SLAVE_PMIC_ARB,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 59,
+};
+
+static struct qcom_icc_node slv_prng = {
+	.name = "slv_prng",
+	.id = QCM2290_SLAVE_PRNG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 44,
+};
+
+static struct qcom_icc_node slv_qdss_cfg = {
+	.name = "slv_qdss_cfg",
+	.id = QCM2290_SLAVE_QDSS_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 63,
+};
+
+static struct qcom_icc_node slv_qm_cfg = {
+	.name = "slv_qm_cfg",
+	.id = QCM2290_SLAVE_QM_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 212,
+};
+
+static struct qcom_icc_node slv_qm_mpu_cfg = {
+	.name = "slv_qm_mpu_cfg",
+	.id = QCM2290_SLAVE_QM_MPU_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 231,
+};
+
+static struct qcom_icc_node slv_qpic = {
+	.name = "slv_qpic",
+	.id = QCM2290_SLAVE_QPIC,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 80,
+};
+
+static struct qcom_icc_node slv_qup_0 = {
+	.name = "slv_qup_0",
+	.id = QCM2290_SLAVE_QUP_0,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 261,
+};
+
+static struct qcom_icc_node slv_sdcc_1 = {
+	.name = "slv_sdcc_1",
+	.id = QCM2290_SLAVE_SDCC_1,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 31,
+};
+
+static struct qcom_icc_node slv_sdcc_2 = {
+	.name = "slv_sdcc_2",
+	.id = QCM2290_SLAVE_SDCC_2,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 33,
+};
+
+static const u16 slv_snoc_cfg_links[] = {
+	QCM2290_MASTER_SNOC_CFG,
+};
+
+static struct qcom_icc_node slv_snoc_cfg = {
+	.name = "slv_snoc_cfg",
+	.id = QCM2290_SLAVE_SNOC_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 70,
+	.num_links = ARRAY_SIZE(slv_snoc_cfg_links),
+	.links = slv_snoc_cfg_links,
+};
+
+static struct qcom_icc_node slv_tcsr = {
+	.name = "slv_tcsr",
+	.id = QCM2290_SLAVE_TCSR,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 50,
+};
+
+static struct qcom_icc_node slv_usb3 = {
+	.name = "slv_usb3",
+	.id = QCM2290_SLAVE_USB3,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 22,
+};
+
+static struct qcom_icc_node slv_venus_cfg = {
+	.name = "slv_venus_cfg",
+	.id = QCM2290_SLAVE_VENUS_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 10,
+};
+
+static struct qcom_icc_node slv_venus_throttle_cfg = {
+	.name = "slv_venus_throttle_cfg",
+	.id = QCM2290_SLAVE_VENUS_THROTTLE_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 178,
+};
+
+static struct qcom_icc_node slv_vsense_ctrl_cfg = {
+	.name = "slv_vsense_ctrl_cfg",
+	.id = QCM2290_SLAVE_VSENSE_CTRL_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 263,
+};
+
+static struct qcom_icc_node slv_service_cnoc = {
+	.name = "slv_service_cnoc",
+	.id = QCM2290_SLAVE_SERVICE_CNOC,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 76,
+};
+
+static struct qcom_icc_node slv_qup_core_0 = {
+	.name = "slv_qup_core_0",
+	.id = QCM2290_SLAVE_QUP_CORE_0,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 264,
+};
+
+static const u16 slv_snoc_bimc_nrt_links[] = {
+	QCM2290_MASTER_SNOC_BIMC_NRT,
+};
+
+static struct qcom_icc_node slv_snoc_bimc_nrt = {
+	.name = "slv_snoc_bimc_nrt",
+	.id = QCM2290_SLAVE_SNOC_BIMC_NRT,
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 259,
+	.num_links = ARRAY_SIZE(slv_snoc_bimc_nrt_links),
+	.links = slv_snoc_bimc_nrt_links,
+};
+
+static const u16 slv_snoc_bimc_rt_links[] = {
+	QCM2290_MASTER_SNOC_BIMC_RT,
+};
+
+static struct qcom_icc_node slv_snoc_bimc_rt = {
+	.name = "slv_snoc_bimc_rt",
+	.id = QCM2290_SLAVE_SNOC_BIMC_RT,
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 260,
+	.num_links = ARRAY_SIZE(slv_snoc_bimc_rt_links),
+	.links = slv_snoc_bimc_rt_links,
+};
+
+static struct qcom_icc_node slv_appss = {
+	.name = "slv_appss",
+	.id = QCM2290_SLAVE_APPSS,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 20,
+};
+
+static const u16 slv_snoc_cnoc_links[] = {
+	QCM2290_MASTER_SNOC_CNOC,
+};
+
+static struct qcom_icc_node slv_snoc_cnoc = {
+	.name = "slv_snoc_cnoc",
+	.id = QCM2290_SLAVE_SNOC_CNOC,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 25,
+	.num_links = ARRAY_SIZE(slv_snoc_cnoc_links),
+	.links = slv_snoc_cnoc_links,
+};
+
+static struct qcom_icc_node slv_imem = {
+	.name = "slv_imem",
+	.id = QCM2290_SLAVE_IMEM,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 26,
+};
+
+static struct qcom_icc_node slv_pimem = {
+	.name = "slv_pimem",
+	.id = QCM2290_SLAVE_PIMEM,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 166,
+};
+
+static const u16 slv_snoc_bimc_links[] = {
+	QCM2290_MASTER_SNOC_BIMC,
+};
+
+static struct qcom_icc_node slv_snoc_bimc = {
+	.name = "slv_snoc_bimc",
+	.id = QCM2290_SLAVE_SNOC_BIMC,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 24,
+	.num_links = ARRAY_SIZE(slv_snoc_bimc_links),
+	.links = slv_snoc_bimc_links,
+};
+
+static struct qcom_icc_node slv_service_snoc = {
+	.name = "slv_service_snoc",
+	.id = QCM2290_SLAVE_SERVICE_SNOC,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 29,
+};
+
+static struct qcom_icc_node slv_qdss_stm = {
+	.name = "slv_qdss_stm",
+	.id = QCM2290_SLAVE_QDSS_STM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 30,
+};
+
+static struct qcom_icc_node slv_tcu = {
+	.name = "slv_tcu",
+	.id = QCM2290_SLAVE_TCU,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 133,
+};
+
+static const u16 slv_anoc_snoc_links[] = {
+	QCM2290_MASTER_ANOC_SNOC,
+};
+
+static struct qcom_icc_node slv_anoc_snoc = {
+	.name = "slv_anoc_snoc",
+	.id = QCM2290_SLAVE_ANOC_SNOC,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 141,
+	.num_links = ARRAY_SIZE(slv_anoc_snoc_links),
+	.links = slv_anoc_snoc_links,
+};
+
+/* NoC descriptors */
+static struct qcom_icc_node *qcm2290_bimc_nodes[] = {
+	[MASTER_APPSS_PROC] = &mas_appss_proc,
+	[MASTER_SNOC_BIMC_RT] = &mas_snoc_bimc_rt,
+	[MASTER_SNOC_BIMC_NRT] = &mas_snoc_bimc_nrt,
+	[MASTER_SNOC_BIMC] = &mas_snoc_bimc,
+	[MASTER_TCU_0] = &mas_tcu_0,
+	[MASTER_GFX3D] = &mas_gfx3d,
+	[SLAVE_EBI1] = &slv_ebi1,
+	[SLAVE_BIMC_SNOC] = &slv_bimc_snoc,
+};
+
+static const struct regmap_config qcm2290_bimc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x80000,
+	.fast_io	= true,
+};
+
+static struct qcom_icc_desc qcm2290_bimc = {
+	.type = QCOM_ICC_BIMC,
+	.nodes = qcm2290_bimc_nodes,
+	.num_nodes = ARRAY_SIZE(qcm2290_bimc_nodes),
+	.regmap_cfg = &qcm2290_bimc_regmap_config,
+	/* M_REG_BASE() in vendor msm_bus_bimc_adhoc driver */
+	.qos_offset = 0x8000,
+};
+
+static struct qcom_icc_node *qcm2290_cnoc_nodes[] = {
+	[MASTER_SNOC_CNOC] = &mas_snoc_cnoc,
+	[MASTER_QDSS_DAP] = &mas_qdss_dap,
+	[SLAVE_BIMC_CFG] = &slv_bimc_cfg,
+	[SLAVE_CAMERA_NRT_THROTTLE_CFG] = &slv_camera_nrt_throttle_cfg,
+	[SLAVE_CAMERA_RT_THROTTLE_CFG] = &slv_camera_rt_throttle_cfg,
+	[SLAVE_CAMERA_CFG] = &slv_camera_cfg,
+	[SLAVE_CLK_CTL] = &slv_clk_ctl,
+	[SLAVE_CRYPTO_0_CFG] = &slv_crypto_0_cfg,
+	[SLAVE_DISPLAY_CFG] = &slv_display_cfg,
+	[SLAVE_DISPLAY_THROTTLE_CFG] = &slv_display_throttle_cfg,
+	[SLAVE_GPU_CFG] = &slv_gpu_cfg,
+	[SLAVE_HWKM] = &slv_hwkm,
+	[SLAVE_IMEM_CFG] = &slv_imem_cfg,
+	[SLAVE_IPA_CFG] = &slv_ipa_cfg,
+	[SLAVE_LPASS] = &slv_lpass,
+	[SLAVE_MESSAGE_RAM] = &slv_message_ram,
+	[SLAVE_PDM] = &slv_pdm,
+	[SLAVE_PIMEM_CFG] = &slv_pimem_cfg,
+	[SLAVE_PKA_WRAPPER] = &slv_pka_wrapper,
+	[SLAVE_PMIC_ARB] = &slv_pmic_arb,
+	[SLAVE_PRNG] = &slv_prng,
+	[SLAVE_QDSS_CFG] = &slv_qdss_cfg,
+	[SLAVE_QM_CFG] = &slv_qm_cfg,
+	[SLAVE_QM_MPU_CFG] = &slv_qm_mpu_cfg,
+	[SLAVE_QPIC] = &slv_qpic,
+	[SLAVE_QUP_0] = &slv_qup_0,
+	[SLAVE_SDCC_1] = &slv_sdcc_1,
+	[SLAVE_SDCC_2] = &slv_sdcc_2,
+	[SLAVE_SNOC_CFG] = &slv_snoc_cfg,
+	[SLAVE_TCSR] = &slv_tcsr,
+	[SLAVE_USB3] = &slv_usb3,
+	[SLAVE_VENUS_CFG] = &slv_venus_cfg,
+	[SLAVE_VENUS_THROTTLE_CFG] = &slv_venus_throttle_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] = &slv_vsense_ctrl_cfg,
+	[SLAVE_SERVICE_CNOC] = &slv_service_cnoc,
+};
+
+static const struct regmap_config qcm2290_cnoc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x8200,
+	.fast_io	= true,
+};
+
+static struct qcom_icc_desc qcm2290_cnoc = {
+	.type = QCOM_ICC_NOC,
+	.nodes = qcm2290_cnoc_nodes,
+	.num_nodes = ARRAY_SIZE(qcm2290_cnoc_nodes),
+	.regmap_cfg = &qcm2290_cnoc_regmap_config,
+};
+
+static struct qcom_icc_node *qcm2290_snoc_nodes[] = {
+	[MASTER_CRYPTO_CORE0] = &mas_crypto_core0,
+	[MASTER_SNOC_CFG] = &mas_snoc_cfg,
+	[MASTER_TIC] = &mas_tic,
+	[MASTER_ANOC_SNOC] = &mas_anoc_snoc,
+	[MASTER_BIMC_SNOC] = &mas_bimc_snoc,
+	[MASTER_PIMEM] = &mas_pimem,
+	[MASTER_QDSS_BAM] = &mas_qdss_bam,
+	[MASTER_QUP_0] = &mas_qup_0,
+	[MASTER_IPA] = &mas_ipa,
+	[MASTER_QDSS_ETR] = &mas_qdss_etr,
+	[MASTER_SDCC_1] = &mas_sdcc_1,
+	[MASTER_SDCC_2] = &mas_sdcc_2,
+	[MASTER_QPIC] = &mas_qpic,
+	[MASTER_USB3_0] = &mas_usb3_0,
+	[SLAVE_APPSS] = &slv_appss,
+	[SLAVE_SNOC_CNOC] = &slv_snoc_cnoc,
+	[SLAVE_IMEM] = &slv_imem,
+	[SLAVE_PIMEM] = &slv_pimem,
+	[SLAVE_SNOC_BIMC] = &slv_snoc_bimc,
+	[SLAVE_SERVICE_SNOC] = &slv_service_snoc,
+	[SLAVE_QDSS_STM] = &slv_qdss_stm,
+	[SLAVE_TCU] = &slv_tcu,
+	[SLAVE_ANOC_SNOC] = &slv_anoc_snoc,
+};
+
+static const struct regmap_config qcm2290_snoc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x60200,
+	.fast_io	= true,
+};
+
+static struct qcom_icc_desc qcm2290_snoc = {
+	.type = QCOM_ICC_QNOC,
+	.nodes = qcm2290_snoc_nodes,
+	.num_nodes = ARRAY_SIZE(qcm2290_snoc_nodes),
+	.regmap_cfg = &qcm2290_snoc_regmap_config,
+	/* Vendor DT node fab-sys_noc property 'qcom,base-offset' */
+	.qos_offset = 0x15000,
+};
+
+static struct qcom_icc_node *qcm2290_qup_virt_nodes[] = {
+	[MASTER_QUP_CORE_0] = &mas_qup_core_0,
+	[SLAVE_QUP_CORE_0] = &slv_qup_core_0
+};
+
+static struct qcom_icc_desc qcm2290_qup_virt = {
+	.type = QCOM_ICC_QNOC,
+	.nodes = qcm2290_qup_virt_nodes,
+	.num_nodes = ARRAY_SIZE(qcm2290_qup_virt_nodes),
+};
+
+static struct qcom_icc_node *qcm2290_mmnrt_virt_nodes[] = {
+	[MASTER_CAMNOC_SF] = &mas_camnoc_sf,
+	[MASTER_VIDEO_P0] = &mas_video_p0,
+	[MASTER_VIDEO_PROC] = &mas_video_proc,
+	[SLAVE_SNOC_BIMC_NRT] = &slv_snoc_bimc_nrt,
+};
+
+static struct qcom_icc_desc qcm2290_mmnrt_virt = {
+	.type = QCOM_ICC_QNOC,
+	.nodes = qcm2290_mmnrt_virt_nodes,
+	.num_nodes = ARRAY_SIZE(qcm2290_mmnrt_virt_nodes),
+	.regmap_cfg = &qcm2290_snoc_regmap_config,
+	.qos_offset = 0x15000,
+};
+
+static struct qcom_icc_node *qcm2290_mmrt_virt_nodes[] = {
+	[MASTER_CAMNOC_HF] = &mas_camnoc_hf,
+	[MASTER_MDP0] = &mas_mdp0,
+	[SLAVE_SNOC_BIMC_RT] = &slv_snoc_bimc_rt,
+};
+
+static struct qcom_icc_desc qcm2290_mmrt_virt = {
+	.type = QCOM_ICC_QNOC,
+	.nodes = qcm2290_mmrt_virt_nodes,
+	.num_nodes = ARRAY_SIZE(qcm2290_mmrt_virt_nodes),
+	.regmap_cfg = &qcm2290_snoc_regmap_config,
+	.qos_offset = 0x15000,
+};
+
+static const struct of_device_id qcm2290_noc_of_match[] = {
+	{ .compatible = "qcom,qcm2290-bimc", .data = &qcm2290_bimc },
+	{ .compatible = "qcom,qcm2290-cnoc", .data = &qcm2290_cnoc },
+	{ .compatible = "qcom,qcm2290-snoc", .data = &qcm2290_snoc },
+	{ .compatible = "qcom,qcm2290-qup-virt", .data = &qcm2290_qup_virt },
+	{ .compatible = "qcom,qcm2290-mmrt-virt", .data = &qcm2290_mmrt_virt },
+	{ .compatible = "qcom,qcm2290-mmnrt-virt", .data = &qcm2290_mmnrt_virt },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcm2290_noc_of_match);
+
+static struct platform_driver qcm2290_noc_driver = {
+	.probe = qnoc_probe,
+	.remove = qnoc_remove,
+	.driver = {
+		.name = "qnoc-qcm2290",
+		.of_match_table = qcm2290_noc_of_match,
+	},
+};
+module_platform_driver(qcm2290_noc_driver);
+
+MODULE_DESCRIPTION("Qualcomm QCM2290 NoC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

