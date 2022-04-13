Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600FC4FF72D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiDMM41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiDMM40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:56:26 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA28B53B4C;
        Wed, 13 Apr 2022 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649854445; x=1681390445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=oG5OOK007UccrCZzkST7MFwM+RytHeVDHeZpaoXPgOI=;
  b=cnKRRO5KUynnzSRHE7LeXn/PltkBEmfScKWUkmlUgqQtC57XIMAOjM9c
   Rw2MWG9aMkKWO8j/o+OLgFBr+WiN6JPlaBziAKhgkOO8l7oT/Ijaw0B+N
   Y6CFBSKFq1mGpJd3QqEgmaPX78qDXAaHGgTyKYNwosxcV7niN5hvp0Q4U
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 13 Apr 2022 05:54:04 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 13 Apr 2022 05:54:02 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 13 Apr 2022 18:23:51 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 6CBBB3AC2; Wed, 13 Apr 2022 18:23:50 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 2/2] interconnect: qcom: Add SDX65 interconnect provider driver
Date:   Wed, 13 Apr 2022 18:23:35 +0530
Message-Id: <1649854415-11174-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649854415-11174-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1649854415-11174-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the Qualcomm interconnect buses found in SDX65 based
platforms.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/interconnect/qcom/Kconfig  |   9 ++
 drivers/interconnect/qcom/Makefile |   2 +
 drivers/interconnect/qcom/sdx65.c  | 231 +++++++++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sdx65.h  |  65 +++++++++++
 4 files changed, 307 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sdx65.c
 create mode 100644 drivers/interconnect/qcom/sdx65.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 91353e6..f01d663 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -137,6 +137,15 @@ config INTERCONNECT_QCOM_SDX55
 	  This is a driver for the Qualcomm Network-on-Chip on sdx55-based
 	  platforms.
 
+config INTERCONNECT_QCOM_SDX65
+	tristate "Qualcomm SDX65 interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on sdx65-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SM8150
 	tristate "Qualcomm SM8150 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index ceae9bb..07a589d 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -15,6 +15,7 @@ qnoc-sc8180x-objs			:= sc8180x.o
 qnoc-sdm660-objs			:= sdm660.o
 qnoc-sdm845-objs			:= sdm845.o
 qnoc-sdx55-objs				:= sdx55.o
+qnoc-sdx65-objs				:= sdx65.o
 qnoc-sm8150-objs			:= sm8150.o
 qnoc-sm8250-objs			:= sm8250.o
 qnoc-sm8350-objs			:= sm8350.o
@@ -36,6 +37,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SC8180X) += qnoc-sc8180x.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM660) += qnoc-sdm660.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) += qnoc-sdx55.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SDX65) += qnoc-sdx65.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) += qnoc-sm8350.o
diff --git a/drivers/interconnect/qcom/sdx65.c b/drivers/interconnect/qcom/sdx65.c
new file mode 100644
index 0000000..b16d31d
--- /dev/null
+++ b/drivers/interconnect/qcom/sdx65.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/interconnect/qcom,sdx65.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+#include "sdx65.h"
+
+DEFINE_QNODE(llcc_mc, SDX65_MASTER_LLCC, 1, 4, SDX65_SLAVE_EBI1);
+DEFINE_QNODE(acm_tcu, SDX65_MASTER_TCU_0, 1, 8, SDX65_SLAVE_LLCC, SDX65_SLAVE_MEM_NOC_SNOC, SDX65_SLAVE_MEM_NOC_PCIE_SNOC);
+DEFINE_QNODE(qnm_snoc_gc, SDX65_MASTER_SNOC_GC_MEM_NOC, 1, 16, SDX65_SLAVE_LLCC);
+DEFINE_QNODE(xm_apps_rdwr, SDX65_MASTER_APPSS_PROC, 1, 16, SDX65_SLAVE_LLCC, SDX65_SLAVE_MEM_NOC_SNOC, SDX65_SLAVE_MEM_NOC_PCIE_SNOC);
+DEFINE_QNODE(qhm_audio, SDX65_MASTER_AUDIO, 1, 4, SDX65_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(qhm_blsp1, SDX65_MASTER_BLSP_1, 1, 4, SDX65_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(qhm_qdss_bam, SDX65_MASTER_QDSS_BAM, 1, 4, SDX65_SLAVE_AOSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_BLSP_1, SDX65_SLAVE_CLK_CTL, SDX65_SLAVE_CRYPTO_0_CFG, SDX65_SLAVE_CNOC_DDRSS, SDX65_SLAVE_ECC_CFG, SDX65_SLAVE_IMEM_CFG, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_CNOC_MSS, SDX65_SLAVE_PCIE_PARF, SDX65_SLAVE_PDM, SDX65_SLAVE_PRNG, SDX65_SLAVE_QDSS_CFG, SDX65_SLAVE_QPIC, SDX65_SLAVE_SDCC_1, SDX65_SLAVE_SNOC_CFG, SDX65_SLAVE_SPMI_FETCHER, SDX65_SLAVE_SPMI_VGI_COEX, SDX65_SLAVE_TCSR, SDX65_SLAVE_TLMM, SDX65_SLAVE_USB3, SDX65_SLAVE_USB3_PHY_CFG, SDX65_SLAVE_SNOC_MEM_NOC_GC, SDX65_SLAVE_IMEM, SDX65_SLAVE_TCU);
+DEFINE_QNODE(qhm_qpic, SDX65_MASTER_QPIC, 1, 4, SDX65_SLAVE_AOSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(qhm_snoc_cfg, SDX65_MASTER_SNOC_CFG, 1, 4, SDX65_SLAVE_SERVICE_SNOC);
+DEFINE_QNODE(qhm_spmi_fetcher1, SDX65_MASTER_SPMI_FETCHER, 1, 4, SDX65_SLAVE_AOSS, SDX65_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(qnm_aggre_noc, SDX65_MASTER_ANOC_SNOC, 1, 8, SDX65_SLAVE_AOSS, SDX65_SLAVE_APPSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_BLSP_1, SDX65_SLAVE_CLK_CTL, SDX65_SLAVE_CRYPTO_0_CFG, SDX65_SLAVE_CNOC_DDRSS, SDX65_SLAVE_ECC_CFG, SDX65_SLAVE_IMEM_CFG, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_CNOC_MSS, SDX65_SLAVE_PCIE_PARF, SDX65_SLAVE_PDM, SDX65_SLAVE_PRNG, SDX65_SLAVE_QDSS_CFG, SDX65_SLAVE_QPIC, SDX65_SLAVE_SDCC_1, SDX65_SLAVE_SNOC_CFG, SDX65_SLAVE_SPMI_FETCHER, SDX65_SLAVE_SPMI_VGI_COEX, SDX65_SLAVE_TCSR, SDX65_SLAVE_TLMM, SDX65_SLAVE_USB3, SDX65_SLAVE_USB3_PHY_CFG, SDX65_SLAVE_SNOC_MEM_NOC_GC, SDX65_SLAVE_IMEM, SDX65_SLAVE_PCIE_0, SDX65_SLAVE_QDSS_STM, SDX65_SLAVE_TCU);
+DEFINE_QNODE(qnm_ipa, SDX65_MASTER_IPA, 1, 8, SDX65_SLAVE_AOSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_BLSP_1, SDX65_SLAVE_CLK_CTL, SDX65_SLAVE_CRYPTO_0_CFG, SDX65_SLAVE_CNOC_DDRSS, SDX65_SLAVE_ECC_CFG, SDX65_SLAVE_IMEM_CFG, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_CNOC_MSS, SDX65_SLAVE_PCIE_PARF, SDX65_SLAVE_PDM, SDX65_SLAVE_PRNG, SDX65_SLAVE_QDSS_CFG, SDX65_SLAVE_QPIC, SDX65_SLAVE_SDCC_1, SDX65_SLAVE_SNOC_CFG, SDX65_SLAVE_SPMI_FETCHER, SDX65_SLAVE_TCSR, SDX65_SLAVE_TLMM, SDX65_SLAVE_USB3, SDX65_SLAVE_USB3_PHY_CFG, SDX65_SLAVE_SNOC_MEM_NOC_GC, SDX65_SLAVE_IMEM, SDX65_SLAVE_PCIE_0, SDX65_SLAVE_QDSS_STM);
+DEFINE_QNODE(qnm_memnoc, SDX65_MASTER_MEM_NOC_SNOC, 1, 8, SDX65_SLAVE_AOSS, SDX65_SLAVE_APPSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_BLSP_1, SDX65_SLAVE_CLK_CTL, SDX65_SLAVE_CRYPTO_0_CFG, SDX65_SLAVE_CNOC_DDRSS, SDX65_SLAVE_ECC_CFG, SDX65_SLAVE_IMEM_CFG, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_CNOC_MSS, SDX65_SLAVE_PCIE_PARF, SDX65_SLAVE_PDM, SDX65_SLAVE_PRNG, SDX65_SLAVE_QDSS_CFG, SDX65_SLAVE_QPIC, SDX65_SLAVE_SDCC_1, SDX65_SLAVE_SNOC_CFG, SDX65_SLAVE_SPMI_FETCHER, SDX65_SLAVE_SPMI_VGI_COEX, SDX65_SLAVE_TCSR, SDX65_SLAVE_TLMM, SDX65_SLAVE_USB3, SDX65_SLAVE_USB3_PHY_CFG, SDX65_SLAVE_IMEM, SDX65_SLAVE_QDSS_STM, SDX65_SLAVE_TCU);
+DEFINE_QNODE(qnm_memnoc_pcie, SDX65_MASTER_MEM_NOC_PCIE_SNOC, 1, 8, SDX65_SLAVE_PCIE_0);
+DEFINE_QNODE(qxm_crypto, SDX65_MASTER_CRYPTO, 1, 8, SDX65_SLAVE_AOSS, SDX65_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(xm_ipa2pcie_slv, SDX65_MASTER_IPA_PCIE, 1, 8, SDX65_SLAVE_PCIE_0);
+DEFINE_QNODE(xm_pcie, SDX65_MASTER_PCIE_0, 1, 8, SDX65_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(xm_qdss_etr, SDX65_MASTER_QDSS_ETR, 1, 8, SDX65_SLAVE_AOSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_BLSP_1, SDX65_SLAVE_CLK_CTL, SDX65_SLAVE_CRYPTO_0_CFG, SDX65_SLAVE_CNOC_DDRSS, SDX65_SLAVE_ECC_CFG, SDX65_SLAVE_IMEM_CFG, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_CNOC_MSS, SDX65_SLAVE_PCIE_PARF, SDX65_SLAVE_PDM, SDX65_SLAVE_PRNG, SDX65_SLAVE_QDSS_CFG, SDX65_SLAVE_QPIC, SDX65_SLAVE_SDCC_1, SDX65_SLAVE_SNOC_CFG, SDX65_SLAVE_SPMI_FETCHER, SDX65_SLAVE_SPMI_VGI_COEX, SDX65_SLAVE_TCSR, SDX65_SLAVE_TLMM, SDX65_SLAVE_USB3, SDX65_SLAVE_USB3_PHY_CFG, SDX65_SLAVE_SNOC_MEM_NOC_GC, SDX65_SLAVE_IMEM, SDX65_SLAVE_TCU);
+DEFINE_QNODE(xm_sdc1, SDX65_MASTER_SDCC_1, 1, 8, SDX65_SLAVE_AOSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(xm_usb3, SDX65_MASTER_USB3, 1, 8, SDX65_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(ebi, SDX65_SLAVE_EBI1, 1, 4);
+DEFINE_QNODE(qns_llcc, SDX65_SLAVE_LLCC, 1, 16, SDX65_MASTER_LLCC);
+DEFINE_QNODE(qns_memnoc_snoc, SDX65_SLAVE_MEM_NOC_SNOC, 1, 8, SDX65_MASTER_MEM_NOC_SNOC);
+DEFINE_QNODE(qns_sys_pcie, SDX65_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8, SDX65_MASTER_MEM_NOC_PCIE_SNOC);
+DEFINE_QNODE(qhs_aoss, SDX65_SLAVE_AOSS, 1, 4);
+DEFINE_QNODE(qhs_apss, SDX65_SLAVE_APPSS, 1, 4);
+DEFINE_QNODE(qhs_audio, SDX65_SLAVE_AUDIO, 1, 4);
+DEFINE_QNODE(qhs_blsp1, SDX65_SLAVE_BLSP_1, 1, 4);
+DEFINE_QNODE(qhs_clk_ctl, SDX65_SLAVE_CLK_CTL, 1, 4);
+DEFINE_QNODE(qhs_crypto0_cfg, SDX65_SLAVE_CRYPTO_0_CFG, 1, 4);
+DEFINE_QNODE(qhs_ddrss_cfg, SDX65_SLAVE_CNOC_DDRSS, 1, 4);
+DEFINE_QNODE(qhs_ecc_cfg, SDX65_SLAVE_ECC_CFG, 1, 4);
+DEFINE_QNODE(qhs_imem_cfg, SDX65_SLAVE_IMEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_ipa, SDX65_SLAVE_IPA_CFG, 1, 4);
+DEFINE_QNODE(qhs_mss_cfg, SDX65_SLAVE_CNOC_MSS, 1, 4);
+DEFINE_QNODE(qhs_pcie_parf, SDX65_SLAVE_PCIE_PARF, 1, 4);
+DEFINE_QNODE(qhs_pdm, SDX65_SLAVE_PDM, 1, 4);
+DEFINE_QNODE(qhs_prng, SDX65_SLAVE_PRNG, 1, 4);
+DEFINE_QNODE(qhs_qdss_cfg, SDX65_SLAVE_QDSS_CFG, 1, 4);
+DEFINE_QNODE(qhs_qpic, SDX65_SLAVE_QPIC, 1, 4);
+DEFINE_QNODE(qhs_sdc1, SDX65_SLAVE_SDCC_1, 1, 4);
+DEFINE_QNODE(qhs_snoc_cfg, SDX65_SLAVE_SNOC_CFG, 1, 4, SDX65_MASTER_SNOC_CFG);
+DEFINE_QNODE(qhs_spmi_fetcher, SDX65_SLAVE_SPMI_FETCHER, 1, 4);
+DEFINE_QNODE(qhs_spmi_vgi_coex, SDX65_SLAVE_SPMI_VGI_COEX, 1, 4);
+DEFINE_QNODE(qhs_tcsr, SDX65_SLAVE_TCSR, 1, 4);
+DEFINE_QNODE(qhs_tlmm, SDX65_SLAVE_TLMM, 1, 4);
+DEFINE_QNODE(qhs_usb3, SDX65_SLAVE_USB3, 1, 4);
+DEFINE_QNODE(qhs_usb3_phy, SDX65_SLAVE_USB3_PHY_CFG, 1, 4);
+DEFINE_QNODE(qns_aggre_noc, SDX65_SLAVE_ANOC_SNOC, 1, 8, SDX65_MASTER_ANOC_SNOC);
+DEFINE_QNODE(qns_snoc_memnoc, SDX65_SLAVE_SNOC_MEM_NOC_GC, 1, 16, SDX65_MASTER_SNOC_GC_MEM_NOC);
+DEFINE_QNODE(qxs_imem, SDX65_SLAVE_IMEM, 1, 8);
+DEFINE_QNODE(srvc_snoc, SDX65_SLAVE_SERVICE_SNOC, 1, 4);
+DEFINE_QNODE(xs_pcie, SDX65_SLAVE_PCIE_0, 1, 8);
+DEFINE_QNODE(xs_qdss_stm, SDX65_SLAVE_QDSS_STM, 1, 4);
+DEFINE_QNODE(xs_sys_tcu_cfg, SDX65_SLAVE_TCU, 1, 8);
+
+DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
+DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
+DEFINE_QBCM(bcm_pn0, "PN0", true, &qhm_snoc_cfg, &qhs_aoss, &qhs_apss, &qhs_audio, &qhs_blsp1, &qhs_clk_ctl, &qhs_crypto0_cfg, &qhs_ddrss_cfg, &qhs_ecc_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mss_cfg, &qhs_pcie_parf, &qhs_pdm, &qhs_prng, &qhs_qdss_cfg, &qhs_qpic, &qhs_sdc1, &qhs_snoc_cfg, &qhs_spmi_fetcher, &qhs_spmi_vgi_coex, &qhs_tcsr, &qhs_tlmm, &qhs_usb3, &qhs_usb3_phy, &srvc_snoc);
+DEFINE_QBCM(bcm_pn1, "PN1", false, &xm_sdc1);
+DEFINE_QBCM(bcm_pn2, "PN2", false, &qhm_audio, &qhm_spmi_fetcher1);
+DEFINE_QBCM(bcm_pn3, "PN3", false, &qhm_blsp1, &qhm_qpic);
+DEFINE_QBCM(bcm_pn4, "PN4", false, &qxm_crypto);
+DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
+DEFINE_QBCM(bcm_sh1, "SH1", false, &qns_memnoc_snoc);
+DEFINE_QBCM(bcm_sh3, "SH3", false, &xm_apps_rdwr);
+DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_snoc_memnoc);
+DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
+DEFINE_QBCM(bcm_sn2, "SN2", false, &xs_qdss_stm);
+DEFINE_QBCM(bcm_sn3, "SN3", false, &xs_sys_tcu_cfg);
+DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_pcie);
+DEFINE_QBCM(bcm_sn6, "SN6", false, &qhm_qdss_bam, &xm_qdss_etr);
+DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre_noc, &xm_pcie, &xm_usb3, &qns_aggre_noc);
+DEFINE_QBCM(bcm_sn8, "SN8", false, &qnm_memnoc);
+DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_memnoc_pcie);
+DEFINE_QBCM(bcm_sn10, "SN10", false, &qnm_ipa, &xm_ipa2pcie_slv);
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static const struct qcom_icc_desc sdx65_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh1,
+	&bcm_sh3,
+};
+
+static struct qcom_icc_node * const mem_noc_nodes[] = {
+	[MASTER_TCU_0] = &acm_tcu,
+	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
+	[MASTER_APPSS_PROC] = &xm_apps_rdwr,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_SNOC] = &qns_memnoc_snoc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_sys_pcie,
+};
+
+static const struct qcom_icc_desc sdx65_mem_noc = {
+	.nodes = mem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
+	.bcms = mem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mem_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_ce0,
+	&bcm_pn0,
+	&bcm_pn1,
+	&bcm_pn2,
+	&bcm_pn3,
+	&bcm_pn4,
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn2,
+	&bcm_sn3,
+	&bcm_sn5,
+	&bcm_sn6,
+	&bcm_sn7,
+	&bcm_sn8,
+	&bcm_sn9,
+	&bcm_sn10,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_AUDIO] = &qhm_audio,
+	[MASTER_BLSP_1] = &qhm_blsp1,
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QPIC] = &qhm_qpic,
+	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
+	[MASTER_SPMI_FETCHER] = &qhm_spmi_fetcher1,
+	[MASTER_ANOC_SNOC] = &qnm_aggre_noc,
+	[MASTER_IPA] = &qnm_ipa,
+	[MASTER_MEM_NOC_SNOC] = &qnm_memnoc,
+	[MASTER_MEM_NOC_PCIE_SNOC] = &qnm_memnoc_pcie,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_IPA_PCIE] = &xm_ipa2pcie_slv,
+	[MASTER_PCIE_0] = &xm_pcie,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr,
+	[MASTER_SDCC_1] = &xm_sdc1,
+	[MASTER_USB3] = &xm_usb3,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_APPSS] = &qhs_apss,
+	[SLAVE_AUDIO] = &qhs_audio,
+	[SLAVE_BLSP_1] = &qhs_blsp1,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_CNOC_DDRSS] = &qhs_ddrss_cfg,
+	[SLAVE_ECC_CFG] = &qhs_ecc_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
+	[SLAVE_PCIE_PARF] = &qhs_pcie_parf,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QPIC] = &qhs_qpic,
+	[SLAVE_SDCC_1] = &qhs_sdc1,
+	[SLAVE_SNOC_CFG] = &qhs_snoc_cfg,
+	[SLAVE_SPMI_FETCHER] = &qhs_spmi_fetcher,
+	[SLAVE_SPMI_VGI_COEX] = &qhs_spmi_vgi_coex,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_USB3] = &qhs_usb3,
+	[SLAVE_USB3_PHY_CFG] = &qhs_usb3_phy,
+	[SLAVE_ANOC_SNOC] = &qns_aggre_noc,
+	[SLAVE_SNOC_MEM_NOC_GC] = &qns_snoc_memnoc,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
+	[SLAVE_PCIE_0] = &xs_pcie,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc sdx65_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,sdx65-mc-virt",
+	  .data = &sdx65_mc_virt},
+	{ .compatible = "qcom,sdx65-mem-noc",
+	  .data = &sdx65_mem_noc},
+	{ .compatible = "qcom,sdx65-system-noc",
+	  .data = &sdx65_system_noc},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-sdx65",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
+	},
+};
+module_platform_driver(qnoc_driver);
+
+MODULE_DESCRIPTION("Qualcomm SDX65 NoC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/sdx65.h b/drivers/interconnect/qcom/sdx65.h
new file mode 100644
index 0000000..5dca6e8
--- /dev/null
+++ b/drivers/interconnect/qcom/sdx65.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SDX65_H
+#define __DRIVERS_INTERCONNECT_QCOM_SDX65_H
+
+#define SDX65_MASTER_TCU_0		0
+#define SDX65_MASTER_LLCC		1
+#define SDX65_MASTER_AUDIO		2
+#define SDX65_MASTER_BLSP_1		3
+#define SDX65_MASTER_QDSS_BAM		4
+#define SDX65_MASTER_QPIC		5
+#define SDX65_MASTER_SNOC_CFG		6
+#define SDX65_MASTER_SPMI_FETCHER	7
+#define SDX65_MASTER_ANOC_SNOC		8
+#define SDX65_MASTER_IPA		9
+#define SDX65_MASTER_MEM_NOC_SNOC	10
+#define SDX65_MASTER_MEM_NOC_PCIE_SNOC	11
+#define SDX65_MASTER_SNOC_GC_MEM_NOC	12
+#define SDX65_MASTER_CRYPTO		13
+#define SDX65_MASTER_APPSS_PROC		14
+#define SDX65_MASTER_IPA_PCIE		15
+#define SDX65_MASTER_PCIE_0		16
+#define SDX65_MASTER_QDSS_ETR		17
+#define SDX65_MASTER_SDCC_1		18
+#define SDX65_MASTER_USB3		19
+#define SDX65_SLAVE_EBI1		512
+#define SDX65_SLAVE_AOSS		513
+#define SDX65_SLAVE_APPSS		514
+#define SDX65_SLAVE_AUDIO		515
+#define SDX65_SLAVE_BLSP_1		516
+#define SDX65_SLAVE_CLK_CTL		517
+#define SDX65_SLAVE_CRYPTO_0_CFG	518
+#define SDX65_SLAVE_CNOC_DDRSS		519
+#define SDX65_SLAVE_ECC_CFG		520
+#define SDX65_SLAVE_IMEM_CFG		521
+#define SDX65_SLAVE_IPA_CFG		522
+#define SDX65_SLAVE_CNOC_MSS		523
+#define SDX65_SLAVE_PCIE_PARF		524
+#define SDX65_SLAVE_PDM			525
+#define SDX65_SLAVE_PRNG		526
+#define SDX65_SLAVE_QDSS_CFG		527
+#define SDX65_SLAVE_QPIC		528
+#define SDX65_SLAVE_SDCC_1		529
+#define SDX65_SLAVE_SNOC_CFG		530
+#define SDX65_SLAVE_SPMI_FETCHER	531
+#define SDX65_SLAVE_SPMI_VGI_COEX	532
+#define SDX65_SLAVE_TCSR		533
+#define SDX65_SLAVE_TLMM		534
+#define SDX65_SLAVE_USB3		535
+#define SDX65_SLAVE_USB3_PHY_CFG	536
+#define SDX65_SLAVE_ANOC_SNOC		537
+#define SDX65_SLAVE_LLCC		538
+#define SDX65_SLAVE_MEM_NOC_SNOC	539
+#define SDX65_SLAVE_SNOC_MEM_NOC_GC	540
+#define SDX65_SLAVE_MEM_NOC_PCIE_SNOC	541
+#define SDX65_SLAVE_IMEM		542
+#define SDX65_SLAVE_SERVICE_SNOC	543
+#define SDX65_SLAVE_PCIE_0		544
+#define SDX65_SLAVE_QDSS_STM		545
+#define SDX65_SLAVE_TCU			546
+
+#endif
-- 
2.7.4

