Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8130533F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbiEYOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244893AbiEYOoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:44:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF16AE264
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:44:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f21so28476709ejh.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zygX1j3NUb3pBJg4u/kfXTe5+8mUez1qWzwTrAXUZLA=;
        b=1uTxjxDVjZ1589qAc+yUlZx2gu0yfmVV5WFgNvm1Lk0GScz1ZIurSObOQ8sOVvsqb/
         92wxURE0vv6XNW9f0BFmf3WEqnga0HbBBg3MVvAx/ew3ioWV0NTB8mZm2yI18A2z5S4n
         bIRlY0rpDCI464RFglNQyASN6yXI9ZoltaQrQaiXfuyEaETW2RVgq9AHkBo9JC1az5as
         Uq/SIrylw/cc1QgTKOx/kRQnEVn7zN5UE1UCQAgphIQKatuzugqasmrC4AUsd0BcwmQT
         nMv2lQGlf22ksxNRENs5QqRLN6OcIoQ8dA6aGhu0OvWf7ehyoHHS8Frei0SGC4Mu3t5x
         Agiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zygX1j3NUb3pBJg4u/kfXTe5+8mUez1qWzwTrAXUZLA=;
        b=ve01yfX/CzNw+xiwyyGt1v8FAhFfPOJeyoFnhRfiY5MTnIFk8YhgD2V3+dLaNA5mMb
         F1Z2oBuEUBUnI+c1Rjt0ru+h9V9cu0IVp5RI9PQB/M2KPotDjCrng4tldicaSqwa8Qi0
         ybya7NTPXdto6NMFayrFIGN95ae7AyLiBmZfVQEfizTbf3x0u9xyXFl64h0XsANahWLV
         zjZnnhFutukWIfTYLQCPQ5GYfVDltYmP9xYvZyHR7KyXHt3xDiFkX8+SNUhTBT3NairW
         RSJfCDaT7IMQ+lVtWNNLm18duNC3sKdTt6Ss23E86c6I5DNeQMEJ7y/MIaBdaaVYeMUS
         rbqw==
X-Gm-Message-State: AOAM530Ww98SUQY/qosiNhOUZ+aASs4AWg52YBtMlE2qlDxQbOkCCMpA
        iJpqj/j95yOfe6LdX/KocnCoTw==
X-Google-Smtp-Source: ABdhPJwR/X8GmEis1XndoKmONenBNFKf2mGpCkEdEpCOng6XTxPXsGaZ2kU7oGKTDDM+kpmCos5MYQ==
X-Received: by 2002:a17:906:4fd5:b0:6f8:5933:7073 with SMTP id i21-20020a1709064fd500b006f859337073mr28345982ejw.545.1653489879113;
        Wed, 25 May 2022 07:44:39 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906550200b006f3ef214de1sm8159596ejp.71.2022.05.25.07.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 07:44:38 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 4/5] interconnect: qcom: Add SM6350 driver support
Date:   Wed, 25 May 2022 16:44:00 +0200
Message-Id: <20220525144404.200390-5-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525144404.200390-1-luca.weiss@fairphone.com>
References: <20220525144404.200390-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver that handles the different NoCs found on SM6350, generated
from the downstream dtb.

We're exluding ALC, IP0 and all _display nodes. ALC will not be voted
from the kernel[1] and IP0 is handled by the clk-rpmh driver[2].

[1] https://lore.kernel.org/linux-arm-msm/1e79c73f22c8891dc9f868babd940fca@=
codeaurora.org/
[2] https://lore.kernel.org/linux-arm-msm/20220412220033.1273607-1-swboyd@c=
hromium.org/

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes since v2:
* none

 drivers/interconnect/qcom/Kconfig  |   9 +
 drivers/interconnect/qcom/Makefile |   2 +
 drivers/interconnect/qcom/sm6350.c | 493 +++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sm6350.h | 139 ++++++++
 4 files changed, 643 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sm6350.c
 create mode 100644 drivers/interconnect/qcom/sm6350.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/=
Kconfig
index 22adff5d7f53..25d5b4baf6f6 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -155,6 +155,15 @@ config INTERCONNECT_QCOM_SDX65
 	  This is a driver for the Qualcomm Network-on-Chip on sdx65-based
 	  platforms.
=20
+config INTERCONNECT_QCOM_SM6350
+	tristate "Qualcomm SM6350 interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on sm6350-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SM8150
 	tristate "Qualcomm SM8150 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom=
/Makefile
index 8d1fe9d38ac3..120e279a7427 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -17,6 +17,7 @@ qnoc-sdm660-objs			:=3D sdm660.o
 qnoc-sdm845-objs			:=3D sdm845.o
 qnoc-sdx55-objs				:=3D sdx55.o
 qnoc-sdx65-objs				:=3D sdx65.o
+qnoc-sm6350-objs			:=3D sm6350.o
 qnoc-sm8150-objs			:=3D sm8150.o
 qnoc-sm8250-objs			:=3D sm8250.o
 qnoc-sm8350-objs			:=3D sm8350.o
@@ -40,6 +41,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SDM660) +=3D qnoc-sdm660.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) +=3D qnoc-sdm845.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) +=3D qnoc-sdx55.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX65) +=3D qnoc-sdx65.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SM6350) +=3D qnoc-sm6350.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) +=3D qnoc-sm8150.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) +=3D qnoc-sm8250.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) +=3D qnoc-sm8350.o
diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom=
/sm6350.c
new file mode 100644
index 000000000000..a3d46e59444e
--- /dev/null
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/interconnect/qcom,sm6350.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+#include "sm6350.h"
+
+DEFINE_QNODE(qhm_a1noc_cfg, SM6350_MASTER_A1NOC_CFG, 1, 4, SM6350_SLAVE_SE=
RVICE_A1NOC);
+DEFINE_QNODE(qhm_qup_0, SM6350_MASTER_QUP_0, 1, 4, SM6350_A1NOC_SNOC_SLV);
+DEFINE_QNODE(xm_emmc, SM6350_MASTER_EMMC, 1, 8, SM6350_A1NOC_SNOC_SLV);
+DEFINE_QNODE(xm_ufs_mem, SM6350_MASTER_UFS_MEM, 1, 8, SM6350_A1NOC_SNOC_SL=
V);
+DEFINE_QNODE(qhm_a2noc_cfg, SM6350_MASTER_A2NOC_CFG, 1, 4, SM6350_SLAVE_SE=
RVICE_A2NOC);
+DEFINE_QNODE(qhm_qdss_bam, SM6350_MASTER_QDSS_BAM, 1, 4, SM6350_A2NOC_SNOC=
_SLV);
+DEFINE_QNODE(qhm_qup_1, SM6350_MASTER_QUP_1, 1, 4, SM6350_A2NOC_SNOC_SLV);
+DEFINE_QNODE(qxm_crypto, SM6350_MASTER_CRYPTO_CORE_0, 1, 8, SM6350_A2NOC_S=
NOC_SLV);
+DEFINE_QNODE(qxm_ipa, SM6350_MASTER_IPA, 1, 8, SM6350_A2NOC_SNOC_SLV);
+DEFINE_QNODE(xm_qdss_etr, SM6350_MASTER_QDSS_ETR, 1, 8, SM6350_A2NOC_SNOC_=
SLV);
+DEFINE_QNODE(xm_sdc2, SM6350_MASTER_SDCC_2, 1, 8, SM6350_A2NOC_SNOC_SLV);
+DEFINE_QNODE(xm_usb3_0, SM6350_MASTER_USB3, 1, 8, SM6350_A2NOC_SNOC_SLV);
+DEFINE_QNODE(qxm_camnoc_hf0_uncomp, SM6350_MASTER_CAMNOC_HF0_UNCOMP, 2, 32=
, SM6350_SLAVE_CAMNOC_UNCOMP);
+DEFINE_QNODE(qxm_camnoc_icp_uncomp, SM6350_MASTER_CAMNOC_ICP_UNCOMP, 1, 32=
, SM6350_SLAVE_CAMNOC_UNCOMP);
+DEFINE_QNODE(qxm_camnoc_sf_uncomp, SM6350_MASTER_CAMNOC_SF_UNCOMP, 1, 32, =
SM6350_SLAVE_CAMNOC_UNCOMP);
+DEFINE_QNODE(qup0_core_master, SM6350_MASTER_QUP_CORE_0, 1, 4, SM6350_SLAV=
E_QUP_CORE_0);
+DEFINE_QNODE(qup1_core_master, SM6350_MASTER_QUP_CORE_1, 1, 4, SM6350_SLAV=
E_QUP_CORE_1);
+DEFINE_QNODE(qnm_npu, SM6350_MASTER_NPU, 2, 32, SM6350_SLAVE_CDSP_GEM_NOC);
+DEFINE_QNODE(qxm_npu_dsp, SM6350_MASTER_NPU_PROC, 1, 8, SM6350_SLAVE_CDSP_=
GEM_NOC);
+DEFINE_QNODE(qnm_snoc, SM6350_SNOC_CNOC_MAS, 1, 8, SM6350_SLAVE_CAMERA_CFG=
, SM6350_SLAVE_SDCC_2, SM6350_SLAVE_CNOC_MNOC_CFG, SM6350_SLAVE_UFS_MEM_CFG=
, SM6350_SLAVE_QM_CFG, SM6350_SLAVE_SNOC_CFG, SM6350_SLAVE_QM_MPU_CFG, SM63=
50_SLAVE_GLM, SM6350_SLAVE_PDM, SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG, SM635=
0_SLAVE_A2NOC_CFG, SM6350_SLAVE_QDSS_CFG, SM6350_SLAVE_VSENSE_CTRL_CFG, SM6=
350_SLAVE_CAMERA_RT_THROTTLE_CFG, SM6350_SLAVE_DISPLAY_CFG, SM6350_SLAVE_TC=
SR, SM6350_SLAVE_DCC_CFG, SM6350_SLAVE_CNOC_DDRSS, SM6350_SLAVE_DISPLAY_THR=
OTTLE_CFG, SM6350_SLAVE_NPU_CFG, SM6350_SLAVE_AHB2PHY, SM6350_SLAVE_GRAPHIC=
S_3D_CFG, SM6350_SLAVE_BOOT_ROM, SM6350_SLAVE_VENUS_CFG, SM6350_SLAVE_IPA_C=
FG, SM6350_SLAVE_SECURITY, SM6350_SLAVE_IMEM_CFG, SM6350_SLAVE_CNOC_MSS, SM=
6350_SLAVE_SERVICE_CNOC, SM6350_SLAVE_USB3, SM6350_SLAVE_VENUS_THROTTLE_CFG=
, SM6350_SLAVE_RBCPR_CX_CFG, SM6350_SLAVE_A1NOC_CFG, SM6350_SLAVE_AOSS, SM6=
350_SLAVE_PRNG, SM6350_SLAVE_EMMC_CFG, SM6350_SLAVE_CRYPTO_0_CFG, SM6350_SL=
AVE_PIMEM_CFG, SM6350_SLAVE_RBCPR_MX_CFG, SM6350_SLAVE_QUP_0, SM6350_SLAVE_=
QUP_1, SM6350_SLAVE_CLK_CTL);
+DEFINE_QNODE(xm_qdss_dap, SM6350_MASTER_QDSS_DAP, 1, 8, SM6350_SLAVE_CAMER=
A_CFG, SM6350_SLAVE_SDCC_2, SM6350_SLAVE_CNOC_MNOC_CFG, SM6350_SLAVE_UFS_ME=
M_CFG, SM6350_SLAVE_QM_CFG, SM6350_SLAVE_SNOC_CFG, SM6350_SLAVE_QM_MPU_CFG,=
 SM6350_SLAVE_GLM, SM6350_SLAVE_PDM, SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG, =
SM6350_SLAVE_A2NOC_CFG, SM6350_SLAVE_QDSS_CFG, SM6350_SLAVE_VSENSE_CTRL_CFG=
, SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG, SM6350_SLAVE_DISPLAY_CFG, SM6350_SLA=
VE_TCSR, SM6350_SLAVE_DCC_CFG, SM6350_SLAVE_CNOC_DDRSS, SM6350_SLAVE_DISPLA=
Y_THROTTLE_CFG, SM6350_SLAVE_NPU_CFG, SM6350_SLAVE_AHB2PHY, SM6350_SLAVE_GR=
APHICS_3D_CFG, SM6350_SLAVE_BOOT_ROM, SM6350_SLAVE_VENUS_CFG, SM6350_SLAVE_=
IPA_CFG, SM6350_SLAVE_SECURITY, SM6350_SLAVE_IMEM_CFG, SM6350_SLAVE_CNOC_MS=
S, SM6350_SLAVE_SERVICE_CNOC, SM6350_SLAVE_USB3, SM6350_SLAVE_VENUS_THROTTL=
E_CFG, SM6350_SLAVE_RBCPR_CX_CFG, SM6350_SLAVE_A1NOC_CFG, SM6350_SLAVE_AOSS=
, SM6350_SLAVE_PRNG, SM6350_SLAVE_EMMC_CFG, SM6350_SLAVE_CRYPTO_0_CFG, SM63=
50_SLAVE_PIMEM_CFG, SM6350_SLAVE_RBCPR_MX_CFG, SM6350_SLAVE_QUP_0, SM6350_S=
LAVE_QUP_1, SM6350_SLAVE_CLK_CTL);
+DEFINE_QNODE(qhm_cnoc_dc_noc, SM6350_MASTER_CNOC_DC_NOC, 1, 4, SM6350_SLAV=
E_LLCC_CFG, SM6350_SLAVE_GEM_NOC_CFG);
+DEFINE_QNODE(acm_apps, SM6350_MASTER_AMPSS_M0, 1, 16, SM6350_SLAVE_LLCC, S=
M6350_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(acm_sys_tcu, SM6350_MASTER_SYS_TCU, 1, 8, SM6350_SLAVE_LLCC, =
SM6350_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(qhm_gemnoc_cfg, SM6350_MASTER_GEM_NOC_CFG, 1, 4, SM6350_SLAVE=
_MCDMA_MS_MPU_CFG, SM6350_SLAVE_SERVICE_GEM_NOC, SM6350_SLAVE_MSS_PROC_MS_M=
PU_CFG);
+DEFINE_QNODE(qnm_cmpnoc, SM6350_MASTER_COMPUTE_NOC, 1, 32, SM6350_SLAVE_LL=
CC, SM6350_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(qnm_mnoc_hf, SM6350_MASTER_MNOC_HF_MEM_NOC, 1, 32, SM6350_SLA=
VE_LLCC, SM6350_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(qnm_mnoc_sf, SM6350_MASTER_MNOC_SF_MEM_NOC, 1, 32, SM6350_SLA=
VE_LLCC, SM6350_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(qnm_snoc_gc, SM6350_MASTER_SNOC_GC_MEM_NOC, 1, 8, SM6350_SLAV=
E_LLCC);
+DEFINE_QNODE(qnm_snoc_sf, SM6350_MASTER_SNOC_SF_MEM_NOC, 1, 16, SM6350_SLA=
VE_LLCC);
+DEFINE_QNODE(qxm_gpu, SM6350_MASTER_GRAPHICS_3D, 2, 32, SM6350_SLAVE_LLCC,=
 SM6350_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(llcc_mc, SM6350_MASTER_LLCC, 2, 4, SM6350_SLAVE_EBI_CH0);
+DEFINE_QNODE(qhm_mnoc_cfg, SM6350_MASTER_CNOC_MNOC_CFG, 1, 4, SM6350_SLAVE=
_SERVICE_MNOC);
+DEFINE_QNODE(qnm_video0, SM6350_MASTER_VIDEO_P0, 1, 32, SM6350_SLAVE_MNOC_=
SF_MEM_NOC);
+DEFINE_QNODE(qnm_video_cvp, SM6350_MASTER_VIDEO_PROC, 1, 8, SM6350_SLAVE_M=
NOC_SF_MEM_NOC);
+DEFINE_QNODE(qxm_camnoc_hf, SM6350_MASTER_CAMNOC_HF, 2, 32, SM6350_SLAVE_M=
NOC_HF_MEM_NOC);
+DEFINE_QNODE(qxm_camnoc_icp, SM6350_MASTER_CAMNOC_ICP, 1, 8, SM6350_SLAVE_=
MNOC_SF_MEM_NOC);
+DEFINE_QNODE(qxm_camnoc_sf, SM6350_MASTER_CAMNOC_SF, 1, 32, SM6350_SLAVE_M=
NOC_SF_MEM_NOC);
+DEFINE_QNODE(qxm_mdp0, SM6350_MASTER_MDP_PORT0, 1, 32, SM6350_SLAVE_MNOC_H=
F_MEM_NOC);
+DEFINE_QNODE(amm_npu_sys, SM6350_MASTER_NPU_SYS, 2, 32, SM6350_SLAVE_NPU_C=
OMPUTE_NOC);
+DEFINE_QNODE(qhm_npu_cfg, SM6350_MASTER_NPU_NOC_CFG, 1, 4, SM6350_SLAVE_SE=
RVICE_NPU_NOC, SM6350_SLAVE_ISENSE_CFG, SM6350_SLAVE_NPU_LLM_CFG, SM6350_SL=
AVE_NPU_INT_DMA_BWMON_CFG, SM6350_SLAVE_NPU_CP, SM6350_SLAVE_NPU_TCM, SM635=
0_SLAVE_NPU_CAL_DP0, SM6350_SLAVE_NPU_DPM);
+DEFINE_QNODE(qhm_snoc_cfg, SM6350_MASTER_SNOC_CFG, 1, 4, SM6350_SLAVE_SERV=
ICE_SNOC);
+DEFINE_QNODE(qnm_aggre1_noc, SM6350_A1NOC_SNOC_MAS, 1, 16, SM6350_SLAVE_SN=
OC_GEM_NOC_SF, SM6350_SLAVE_PIMEM, SM6350_SLAVE_OCIMEM, SM6350_SLAVE_APPSS,=
 SM6350_SNOC_CNOC_SLV, SM6350_SLAVE_QDSS_STM);
+DEFINE_QNODE(qnm_aggre2_noc, SM6350_A2NOC_SNOC_MAS, 1, 16, SM6350_SLAVE_SN=
OC_GEM_NOC_SF, SM6350_SLAVE_PIMEM, SM6350_SLAVE_OCIMEM, SM6350_SLAVE_APPSS,=
 SM6350_SNOC_CNOC_SLV, SM6350_SLAVE_TCU, SM6350_SLAVE_QDSS_STM);
+DEFINE_QNODE(qnm_gemnoc, SM6350_MASTER_GEM_NOC_SNOC, 1, 8, SM6350_SLAVE_PI=
MEM, SM6350_SLAVE_OCIMEM, SM6350_SLAVE_APPSS, SM6350_SNOC_CNOC_SLV, SM6350_=
SLAVE_TCU, SM6350_SLAVE_QDSS_STM);
+DEFINE_QNODE(qxm_pimem, SM6350_MASTER_PIMEM, 1, 8, SM6350_SLAVE_SNOC_GEM_N=
OC_GC, SM6350_SLAVE_OCIMEM);
+DEFINE_QNODE(xm_gic, SM6350_MASTER_GIC, 1, 8, SM6350_SLAVE_SNOC_GEM_NOC_GC=
);
+DEFINE_QNODE(qns_a1noc_snoc, SM6350_A1NOC_SNOC_SLV, 1, 16, SM6350_A1NOC_SN=
OC_MAS);
+DEFINE_QNODE(srvc_aggre1_noc, SM6350_SLAVE_SERVICE_A1NOC, 1, 4);
+DEFINE_QNODE(qns_a2noc_snoc, SM6350_A2NOC_SNOC_SLV, 1, 16, SM6350_A2NOC_SN=
OC_MAS);
+DEFINE_QNODE(srvc_aggre2_noc, SM6350_SLAVE_SERVICE_A2NOC, 1, 4);
+DEFINE_QNODE(qns_camnoc_uncomp, SM6350_SLAVE_CAMNOC_UNCOMP, 1, 32);
+DEFINE_QNODE(qup0_core_slave, SM6350_SLAVE_QUP_CORE_0, 1, 4);
+DEFINE_QNODE(qup1_core_slave, SM6350_SLAVE_QUP_CORE_1, 1, 4);
+DEFINE_QNODE(qns_cdsp_gemnoc, SM6350_SLAVE_CDSP_GEM_NOC, 1, 32, SM6350_MAS=
TER_COMPUTE_NOC);
+DEFINE_QNODE(qhs_a1_noc_cfg, SM6350_SLAVE_A1NOC_CFG, 1, 4, SM6350_MASTER_A=
1NOC_CFG);
+DEFINE_QNODE(qhs_a2_noc_cfg, SM6350_SLAVE_A2NOC_CFG, 1, 4, SM6350_MASTER_A=
2NOC_CFG);
+DEFINE_QNODE(qhs_ahb2phy0, SM6350_SLAVE_AHB2PHY, 1, 4);
+DEFINE_QNODE(qhs_ahb2phy2, SM6350_SLAVE_AHB2PHY_2, 1, 4);
+DEFINE_QNODE(qhs_aoss, SM6350_SLAVE_AOSS, 1, 4);
+DEFINE_QNODE(qhs_boot_rom, SM6350_SLAVE_BOOT_ROM, 1, 4);
+DEFINE_QNODE(qhs_camera_cfg, SM6350_SLAVE_CAMERA_CFG, 1, 4);
+DEFINE_QNODE(qhs_camera_nrt_thrott_cfg, SM6350_SLAVE_CAMERA_NRT_THROTTLE_C=
FG, 1, 4);
+DEFINE_QNODE(qhs_camera_rt_throttle_cfg, SM6350_SLAVE_CAMERA_RT_THROTTLE_C=
FG, 1, 4);
+DEFINE_QNODE(qhs_clk_ctl, SM6350_SLAVE_CLK_CTL, 1, 4);
+DEFINE_QNODE(qhs_cpr_cx, SM6350_SLAVE_RBCPR_CX_CFG, 1, 4);
+DEFINE_QNODE(qhs_cpr_mx, SM6350_SLAVE_RBCPR_MX_CFG, 1, 4);
+DEFINE_QNODE(qhs_crypto0_cfg, SM6350_SLAVE_CRYPTO_0_CFG, 1, 4);
+DEFINE_QNODE(qhs_dcc_cfg, SM6350_SLAVE_DCC_CFG, 1, 4);
+DEFINE_QNODE(qhs_ddrss_cfg, SM6350_SLAVE_CNOC_DDRSS, 1, 4, SM6350_MASTER_C=
NOC_DC_NOC);
+DEFINE_QNODE(qhs_display_cfg, SM6350_SLAVE_DISPLAY_CFG, 1, 4);
+DEFINE_QNODE(qhs_display_throttle_cfg, SM6350_SLAVE_DISPLAY_THROTTLE_CFG, =
1, 4);
+DEFINE_QNODE(qhs_emmc_cfg, SM6350_SLAVE_EMMC_CFG, 1, 4);
+DEFINE_QNODE(qhs_glm, SM6350_SLAVE_GLM, 1, 4);
+DEFINE_QNODE(qhs_gpuss_cfg, SM6350_SLAVE_GRAPHICS_3D_CFG, 1, 8);
+DEFINE_QNODE(qhs_imem_cfg, SM6350_SLAVE_IMEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_ipa, SM6350_SLAVE_IPA_CFG, 1, 4);
+DEFINE_QNODE(qhs_mnoc_cfg, SM6350_SLAVE_CNOC_MNOC_CFG, 1, 4, SM6350_MASTER=
_CNOC_MNOC_CFG);
+DEFINE_QNODE(qhs_mss_cfg, SM6350_SLAVE_CNOC_MSS, 1, 4);
+DEFINE_QNODE(qhs_npu_cfg, SM6350_SLAVE_NPU_CFG, 1, 4, SM6350_MASTER_NPU_NO=
C_CFG);
+DEFINE_QNODE(qhs_pdm, SM6350_SLAVE_PDM, 1, 4);
+DEFINE_QNODE(qhs_pimem_cfg, SM6350_SLAVE_PIMEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_prng, SM6350_SLAVE_PRNG, 1, 4);
+DEFINE_QNODE(qhs_qdss_cfg, SM6350_SLAVE_QDSS_CFG, 1, 4);
+DEFINE_QNODE(qhs_qm_cfg, SM6350_SLAVE_QM_CFG, 1, 4);
+DEFINE_QNODE(qhs_qm_mpu_cfg, SM6350_SLAVE_QM_MPU_CFG, 1, 4);
+DEFINE_QNODE(qhs_qup0, SM6350_SLAVE_QUP_0, 1, 4);
+DEFINE_QNODE(qhs_qup1, SM6350_SLAVE_QUP_1, 1, 4);
+DEFINE_QNODE(qhs_sdc2, SM6350_SLAVE_SDCC_2, 1, 4);
+DEFINE_QNODE(qhs_security, SM6350_SLAVE_SECURITY, 1, 4);
+DEFINE_QNODE(qhs_snoc_cfg, SM6350_SLAVE_SNOC_CFG, 1, 4, SM6350_MASTER_SNOC=
_CFG);
+DEFINE_QNODE(qhs_tcsr, SM6350_SLAVE_TCSR, 1, 4);
+DEFINE_QNODE(qhs_ufs_mem_cfg, SM6350_SLAVE_UFS_MEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_usb3_0, SM6350_SLAVE_USB3, 1, 4);
+DEFINE_QNODE(qhs_venus_cfg, SM6350_SLAVE_VENUS_CFG, 1, 4);
+DEFINE_QNODE(qhs_venus_throttle_cfg, SM6350_SLAVE_VENUS_THROTTLE_CFG, 1, 4=
);
+DEFINE_QNODE(qhs_vsense_ctrl_cfg, SM6350_SLAVE_VSENSE_CTRL_CFG, 1, 4);
+DEFINE_QNODE(srvc_cnoc, SM6350_SLAVE_SERVICE_CNOC, 1, 4);
+DEFINE_QNODE(qhs_gemnoc, SM6350_SLAVE_GEM_NOC_CFG, 1, 4, SM6350_MASTER_GEM=
_NOC_CFG);
+DEFINE_QNODE(qhs_llcc, SM6350_SLAVE_LLCC_CFG, 1, 4);
+DEFINE_QNODE(qhs_mcdma_ms_mpu_cfg, SM6350_SLAVE_MCDMA_MS_MPU_CFG, 1, 4);
+DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SM6350_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4);
+DEFINE_QNODE(qns_gem_noc_snoc, SM6350_SLAVE_GEM_NOC_SNOC, 1, 8, SM6350_MAS=
TER_GEM_NOC_SNOC);
+DEFINE_QNODE(qns_llcc, SM6350_SLAVE_LLCC, 1, 16, SM6350_MASTER_LLCC);
+DEFINE_QNODE(srvc_gemnoc, SM6350_SLAVE_SERVICE_GEM_NOC, 1, 4);
+DEFINE_QNODE(ebi, SM6350_SLAVE_EBI_CH0, 2, 4);
+DEFINE_QNODE(qns_mem_noc_hf, SM6350_SLAVE_MNOC_HF_MEM_NOC, 1, 32, SM6350_M=
ASTER_MNOC_HF_MEM_NOC);
+DEFINE_QNODE(qns_mem_noc_sf, SM6350_SLAVE_MNOC_SF_MEM_NOC, 1, 32, SM6350_M=
ASTER_MNOC_SF_MEM_NOC);
+DEFINE_QNODE(srvc_mnoc, SM6350_SLAVE_SERVICE_MNOC, 1, 4);
+DEFINE_QNODE(qhs_cal_dp0, SM6350_SLAVE_NPU_CAL_DP0, 1, 4);
+DEFINE_QNODE(qhs_cp, SM6350_SLAVE_NPU_CP, 1, 4);
+DEFINE_QNODE(qhs_dma_bwmon, SM6350_SLAVE_NPU_INT_DMA_BWMON_CFG, 1, 4);
+DEFINE_QNODE(qhs_dpm, SM6350_SLAVE_NPU_DPM, 1, 4);
+DEFINE_QNODE(qhs_isense, SM6350_SLAVE_ISENSE_CFG, 1, 4);
+DEFINE_QNODE(qhs_llm, SM6350_SLAVE_NPU_LLM_CFG, 1, 4);
+DEFINE_QNODE(qhs_tcm, SM6350_SLAVE_NPU_TCM, 1, 4);
+DEFINE_QNODE(qns_npu_sys, SM6350_SLAVE_NPU_COMPUTE_NOC, 2, 32);
+DEFINE_QNODE(srvc_noc, SM6350_SLAVE_SERVICE_NPU_NOC, 1, 4);
+DEFINE_QNODE(qhs_apss, SM6350_SLAVE_APPSS, 1, 8);
+DEFINE_QNODE(qns_cnoc, SM6350_SNOC_CNOC_SLV, 1, 8, SM6350_SNOC_CNOC_MAS);
+DEFINE_QNODE(qns_gemnoc_gc, SM6350_SLAVE_SNOC_GEM_NOC_GC, 1, 8, SM6350_MAS=
TER_SNOC_GC_MEM_NOC);
+DEFINE_QNODE(qns_gemnoc_sf, SM6350_SLAVE_SNOC_GEM_NOC_SF, 1, 16, SM6350_MA=
STER_SNOC_SF_MEM_NOC);
+DEFINE_QNODE(qxs_imem, SM6350_SLAVE_OCIMEM, 1, 8);
+DEFINE_QNODE(qxs_pimem, SM6350_SLAVE_PIMEM, 1, 8);
+DEFINE_QNODE(srvc_snoc, SM6350_SLAVE_SERVICE_SNOC, 1, 4);
+DEFINE_QNODE(xs_qdss_stm, SM6350_SLAVE_QDSS_STM, 1, 4);
+DEFINE_QNODE(xs_sys_tcu_cfg, SM6350_SLAVE_TCU, 1, 8);
+
+DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
+DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
+DEFINE_QBCM(bcm_cn0, "CN0", true, &qnm_snoc, &xm_qdss_dap, &qhs_a1_noc_cfg=
, &qhs_a2_noc_cfg, &qhs_ahb2phy0, &qhs_aoss, &qhs_boot_rom, &qhs_camera_cfg=
, &qhs_camera_nrt_thrott_cfg, &qhs_camera_rt_throttle_cfg, &qhs_clk_ctl, &q=
hs_cpr_cx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_dcc_cfg, &qhs_ddrss_cfg, &qh=
s_display_cfg, &qhs_display_throttle_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_im=
em_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_mss_cfg, &qhs_npu_cfg, &qhs_pimem_cfg=
, &qhs_prng, &qhs_qdss_cfg, &qhs_qm_cfg, &qhs_qm_mpu_cfg, &qhs_qup0, &qhs_q=
up1, &qhs_security, &qhs_snoc_cfg, &qhs_tcsr, &qhs_ufs_mem_cfg, &qhs_usb3_0=
, &qhs_venus_cfg, &qhs_venus_throttle_cfg, &qhs_vsense_ctrl_cfg, &srvc_cnoc=
);
+DEFINE_QBCM(bcm_cn1, "CN1", false, &xm_emmc, &xm_sdc2, &qhs_ahb2phy2, &qhs=
_emmc_cfg, &qhs_pdm, &qhs_sdc2);
+DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_gemnoc);
+DEFINE_QBCM(bcm_co2, "CO2", false, &qnm_npu);
+DEFINE_QBCM(bcm_co3, "CO3", false, &qxm_npu_dsp);
+DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
+DEFINE_QBCM(bcm_mm0, "MM0", true, &qns_mem_noc_hf);
+DEFINE_QBCM(bcm_mm1, "MM1", true, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_icp_=
uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf, &qxm_mdp0);
+DEFINE_QBCM(bcm_mm2, "MM2", false, &qns_mem_noc_sf);
+DEFINE_QBCM(bcm_mm3, "MM3", false, &qhm_mnoc_cfg, &qnm_video0, &qnm_video_=
cvp, &qxm_camnoc_sf);
+DEFINE_QBCM(bcm_qup0, "QUP0", false, &qup0_core_master, &qup1_core_master,=
 &qup0_core_slave, &qup1_core_slave);
+DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
+DEFINE_QBCM(bcm_sh2, "SH2", false, &acm_sys_tcu);
+DEFINE_QBCM(bcm_sh3, "SH3", false, &qnm_cmpnoc);
+DEFINE_QBCM(bcm_sh4, "SH4", false, &acm_apps);
+DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_gemnoc_sf);
+DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
+DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
+DEFINE_QBCM(bcm_sn3, "SN3", false, &qxs_pimem);
+DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_qdss_stm);
+DEFINE_QBCM(bcm_sn5, "SN5", false, &qnm_aggre1_noc);
+DEFINE_QBCM(bcm_sn6, "SN6", false, &qnm_aggre2_noc);
+DEFINE_QBCM(bcm_sn10, "SN10", false, &qnm_gemnoc);
+
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] =3D {
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] =3D {
+	[MASTER_A1NOC_CFG] =3D &qhm_a1noc_cfg,
+	[MASTER_QUP_0] =3D &qhm_qup_0,
+	[MASTER_EMMC] =3D &xm_emmc,
+	[MASTER_UFS_MEM] =3D &xm_ufs_mem,
+	[A1NOC_SNOC_SLV] =3D &qns_a1noc_snoc,
+	[SLAVE_SERVICE_A1NOC] =3D &srvc_aggre1_noc,
+};
+
+static const struct qcom_icc_desc sm6350_aggre1_noc =3D {
+	.nodes =3D aggre1_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms =3D aggre1_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] =3D {
+	&bcm_ce0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const aggre2_noc_nodes[] =3D {
+	[MASTER_A2NOC_CFG] =3D &qhm_a2noc_cfg,
+	[MASTER_QDSS_BAM] =3D &qhm_qdss_bam,
+	[MASTER_QUP_1] =3D &qhm_qup_1,
+	[MASTER_CRYPTO_CORE_0] =3D &qxm_crypto,
+	[MASTER_IPA] =3D &qxm_ipa,
+	[MASTER_QDSS_ETR] =3D &xm_qdss_etr,
+	[MASTER_SDCC_2] =3D &xm_sdc2,
+	[MASTER_USB3] =3D &xm_usb3_0,
+	[A2NOC_SNOC_SLV] =3D &qns_a2noc_snoc,
+	[SLAVE_SERVICE_A2NOC] =3D &srvc_aggre2_noc,
+};
+
+static const struct qcom_icc_desc sm6350_aggre2_noc =3D {
+	.nodes =3D aggre2_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms =3D aggre2_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const clk_virt_bcms[] =3D {
+	&bcm_acv,
+	&bcm_mc0,
+	&bcm_mm1,
+	&bcm_qup0,
+};
+
+static struct qcom_icc_node * const clk_virt_nodes[] =3D {
+	[MASTER_CAMNOC_HF0_UNCOMP] =3D &qxm_camnoc_hf0_uncomp,
+	[MASTER_CAMNOC_ICP_UNCOMP] =3D &qxm_camnoc_icp_uncomp,
+	[MASTER_CAMNOC_SF_UNCOMP] =3D &qxm_camnoc_sf_uncomp,
+	[MASTER_QUP_CORE_0] =3D &qup0_core_master,
+	[MASTER_QUP_CORE_1] =3D &qup1_core_master,
+	[MASTER_LLCC] =3D &llcc_mc,
+	[SLAVE_CAMNOC_UNCOMP] =3D &qns_camnoc_uncomp,
+	[SLAVE_QUP_CORE_0] =3D &qup0_core_slave,
+	[SLAVE_QUP_CORE_1] =3D &qup1_core_slave,
+	[SLAVE_EBI_CH0] =3D &ebi,
+};
+
+static const struct qcom_icc_desc sm6350_clk_virt =3D {
+	.nodes =3D clk_virt_nodes,
+	.num_nodes =3D ARRAY_SIZE(clk_virt_nodes),
+	.bcms =3D clk_virt_bcms,
+	.num_bcms =3D ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const compute_noc_bcms[] =3D {
+	&bcm_co0,
+	&bcm_co2,
+	&bcm_co3,
+};
+
+static struct qcom_icc_node * const compute_noc_nodes[] =3D {
+	[MASTER_NPU] =3D &qnm_npu,
+	[MASTER_NPU_PROC] =3D &qxm_npu_dsp,
+	[SLAVE_CDSP_GEM_NOC] =3D &qns_cdsp_gemnoc,
+};
+
+static const struct qcom_icc_desc sm6350_compute_noc =3D {
+	.nodes =3D compute_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(compute_noc_nodes),
+	.bcms =3D compute_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(compute_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const config_noc_bcms[] =3D {
+	&bcm_cn0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const config_noc_nodes[] =3D {
+	[SNOC_CNOC_MAS] =3D &qnm_snoc,
+	[MASTER_QDSS_DAP] =3D &xm_qdss_dap,
+	[SLAVE_A1NOC_CFG] =3D &qhs_a1_noc_cfg,
+	[SLAVE_A2NOC_CFG] =3D &qhs_a2_noc_cfg,
+	[SLAVE_AHB2PHY] =3D &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_2] =3D &qhs_ahb2phy2,
+	[SLAVE_AOSS] =3D &qhs_aoss,
+	[SLAVE_BOOT_ROM] =3D &qhs_boot_rom,
+	[SLAVE_CAMERA_CFG] =3D &qhs_camera_cfg,
+	[SLAVE_CAMERA_NRT_THROTTLE_CFG] =3D &qhs_camera_nrt_thrott_cfg,
+	[SLAVE_CAMERA_RT_THROTTLE_CFG] =3D &qhs_camera_rt_throttle_cfg,
+	[SLAVE_CLK_CTL] =3D &qhs_clk_ctl,
+	[SLAVE_RBCPR_CX_CFG] =3D &qhs_cpr_cx,
+	[SLAVE_RBCPR_MX_CFG] =3D &qhs_cpr_mx,
+	[SLAVE_CRYPTO_0_CFG] =3D &qhs_crypto0_cfg,
+	[SLAVE_DCC_CFG] =3D &qhs_dcc_cfg,
+	[SLAVE_CNOC_DDRSS] =3D &qhs_ddrss_cfg,
+	[SLAVE_DISPLAY_CFG] =3D &qhs_display_cfg,
+	[SLAVE_DISPLAY_THROTTLE_CFG] =3D &qhs_display_throttle_cfg,
+	[SLAVE_EMMC_CFG] =3D &qhs_emmc_cfg,
+	[SLAVE_GLM] =3D &qhs_glm,
+	[SLAVE_GRAPHICS_3D_CFG] =3D &qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] =3D &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] =3D &qhs_ipa,
+	[SLAVE_CNOC_MNOC_CFG] =3D &qhs_mnoc_cfg,
+	[SLAVE_CNOC_MSS] =3D &qhs_mss_cfg,
+	[SLAVE_NPU_CFG] =3D &qhs_npu_cfg,
+	[SLAVE_PDM] =3D &qhs_pdm,
+	[SLAVE_PIMEM_CFG] =3D &qhs_pimem_cfg,
+	[SLAVE_PRNG] =3D &qhs_prng,
+	[SLAVE_QDSS_CFG] =3D &qhs_qdss_cfg,
+	[SLAVE_QM_CFG] =3D &qhs_qm_cfg,
+	[SLAVE_QM_MPU_CFG] =3D &qhs_qm_mpu_cfg,
+	[SLAVE_QUP_0] =3D &qhs_qup0,
+	[SLAVE_QUP_1] =3D &qhs_qup1,
+	[SLAVE_SDCC_2] =3D &qhs_sdc2,
+	[SLAVE_SECURITY] =3D &qhs_security,
+	[SLAVE_SNOC_CFG] =3D &qhs_snoc_cfg,
+	[SLAVE_TCSR] =3D &qhs_tcsr,
+	[SLAVE_UFS_MEM_CFG] =3D &qhs_ufs_mem_cfg,
+	[SLAVE_USB3] =3D &qhs_usb3_0,
+	[SLAVE_VENUS_CFG] =3D &qhs_venus_cfg,
+	[SLAVE_VENUS_THROTTLE_CFG] =3D &qhs_venus_throttle_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] =3D &qhs_vsense_ctrl_cfg,
+	[SLAVE_SERVICE_CNOC] =3D &srvc_cnoc,
+};
+
+static const struct qcom_icc_desc sm6350_config_noc =3D {
+	.nodes =3D config_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(config_noc_nodes),
+	.bcms =3D config_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(config_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const dc_noc_bcms[] =3D {
+};
+
+static struct qcom_icc_node * const dc_noc_nodes[] =3D {
+	[MASTER_CNOC_DC_NOC] =3D &qhm_cnoc_dc_noc,
+	[SLAVE_GEM_NOC_CFG] =3D &qhs_gemnoc,
+	[SLAVE_LLCC_CFG] =3D &qhs_llcc,
+};
+
+static const struct qcom_icc_desc sm6350_dc_noc =3D {
+	.nodes =3D dc_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(dc_noc_nodes),
+	.bcms =3D dc_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(dc_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] =3D {
+	&bcm_sh0,
+	&bcm_sh2,
+	&bcm_sh3,
+	&bcm_sh4,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] =3D {
+	[MASTER_AMPSS_M0] =3D &acm_apps,
+	[MASTER_SYS_TCU] =3D &acm_sys_tcu,
+	[MASTER_GEM_NOC_CFG] =3D &qhm_gemnoc_cfg,
+	[MASTER_COMPUTE_NOC] =3D &qnm_cmpnoc,
+	[MASTER_MNOC_HF_MEM_NOC] =3D &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] =3D &qnm_mnoc_sf,
+	[MASTER_SNOC_GC_MEM_NOC] =3D &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] =3D &qnm_snoc_sf,
+	[MASTER_GRAPHICS_3D] =3D &qxm_gpu,
+	[SLAVE_MCDMA_MS_MPU_CFG] =3D &qhs_mcdma_ms_mpu_cfg,
+	[SLAVE_MSS_PROC_MS_MPU_CFG] =3D &qhs_mdsp_ms_mpu_cfg,
+	[SLAVE_GEM_NOC_SNOC] =3D &qns_gem_noc_snoc,
+	[SLAVE_LLCC] =3D &qns_llcc,
+	[SLAVE_SERVICE_GEM_NOC] =3D &srvc_gemnoc,
+};
+
+static const struct qcom_icc_desc sm6350_gem_noc =3D {
+	.nodes =3D gem_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(gem_noc_nodes),
+	.bcms =3D gem_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] =3D {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm2,
+	&bcm_mm3,
+};
+
+static struct qcom_icc_node * const mmss_noc_nodes[] =3D {
+	[MASTER_CNOC_MNOC_CFG] =3D &qhm_mnoc_cfg,
+	[MASTER_VIDEO_P0] =3D &qnm_video0,
+	[MASTER_VIDEO_PROC] =3D &qnm_video_cvp,
+	[MASTER_CAMNOC_HF] =3D &qxm_camnoc_hf,
+	[MASTER_CAMNOC_ICP] =3D &qxm_camnoc_icp,
+	[MASTER_CAMNOC_SF] =3D &qxm_camnoc_sf,
+	[MASTER_MDP_PORT0] =3D &qxm_mdp0,
+	[SLAVE_MNOC_HF_MEM_NOC] =3D &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] =3D &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC] =3D &srvc_mnoc,
+};
+
+static const struct qcom_icc_desc sm6350_mmss_noc =3D {
+	.nodes =3D mmss_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(mmss_noc_nodes),
+	.bcms =3D mmss_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const npu_noc_bcms[] =3D {
+};
+
+static struct qcom_icc_node * const npu_noc_nodes[] =3D {
+	[MASTER_NPU_SYS] =3D &amm_npu_sys,
+	[MASTER_NPU_NOC_CFG] =3D &qhm_npu_cfg,
+	[SLAVE_NPU_CAL_DP0] =3D &qhs_cal_dp0,
+	[SLAVE_NPU_CP] =3D &qhs_cp,
+	[SLAVE_NPU_INT_DMA_BWMON_CFG] =3D &qhs_dma_bwmon,
+	[SLAVE_NPU_DPM] =3D &qhs_dpm,
+	[SLAVE_ISENSE_CFG] =3D &qhs_isense,
+	[SLAVE_NPU_LLM_CFG] =3D &qhs_llm,
+	[SLAVE_NPU_TCM] =3D &qhs_tcm,
+	[SLAVE_NPU_COMPUTE_NOC] =3D &qns_npu_sys,
+	[SLAVE_SERVICE_NPU_NOC] =3D &srvc_noc,
+};
+
+static const struct qcom_icc_desc sm6350_npu_noc =3D {
+	.nodes =3D npu_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(npu_noc_nodes),
+	.bcms =3D npu_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(npu_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] =3D {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn10,
+	&bcm_sn2,
+	&bcm_sn3,
+	&bcm_sn4,
+	&bcm_sn5,
+	&bcm_sn6,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] =3D {
+	[MASTER_SNOC_CFG] =3D &qhm_snoc_cfg,
+	[A1NOC_SNOC_MAS] =3D &qnm_aggre1_noc,
+	[A2NOC_SNOC_MAS] =3D &qnm_aggre2_noc,
+	[MASTER_GEM_NOC_SNOC] =3D &qnm_gemnoc,
+	[MASTER_PIMEM] =3D &qxm_pimem,
+	[MASTER_GIC] =3D &xm_gic,
+	[SLAVE_APPSS] =3D &qhs_apss,
+	[SNOC_CNOC_SLV] =3D &qns_cnoc,
+	[SLAVE_SNOC_GEM_NOC_GC] =3D &qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] =3D &qns_gemnoc_sf,
+	[SLAVE_OCIMEM] =3D &qxs_imem,
+	[SLAVE_PIMEM] =3D &qxs_pimem,
+	[SLAVE_SERVICE_SNOC] =3D &srvc_snoc,
+	[SLAVE_QDSS_STM] =3D &xs_qdss_stm,
+	[SLAVE_TCU] =3D &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc sm6350_system_noc =3D {
+	.nodes =3D system_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(system_noc_nodes),
+	.bcms =3D system_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] =3D {
+	{ .compatible =3D "qcom,sm6350-aggre1-noc",
+	  .data =3D &sm6350_aggre1_noc},
+	{ .compatible =3D "qcom,sm6350-aggre2-noc",
+	  .data =3D &sm6350_aggre2_noc},
+	{ .compatible =3D "qcom,sm6350-clk-virt",
+	  .data =3D &sm6350_clk_virt},
+	{ .compatible =3D "qcom,sm6350-compute-noc",
+	  .data =3D &sm6350_compute_noc},
+	{ .compatible =3D "qcom,sm6350-config-noc",
+	  .data =3D &sm6350_config_noc},
+	{ .compatible =3D "qcom,sm6350-dc-noc",
+	  .data =3D &sm6350_dc_noc},
+	{ .compatible =3D "qcom,sm6350-gem-noc",
+	  .data =3D &sm6350_gem_noc},
+	{ .compatible =3D "qcom,sm6350-mmss-noc",
+	  .data =3D &sm6350_mmss_noc},
+	{ .compatible =3D "qcom,sm6350-npu-noc",
+	  .data =3D &sm6350_npu_noc},
+	{ .compatible =3D "qcom,sm6350-system-noc",
+	  .data =3D &sm6350_system_noc},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver =3D {
+	.probe =3D qcom_icc_rpmh_probe,
+	.remove =3D qcom_icc_rpmh_remove,
+	.driver =3D {
+		.name =3D "qnoc-sm6350",
+		.of_match_table =3D qnoc_of_match,
+		.sync_state =3D icc_sync_state,
+	},
+};
+module_platform_driver(qnoc_driver);
+
+MODULE_DESCRIPTION("Qualcomm SM6350 NoC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/sm6350.h b/drivers/interconnect/qcom=
/sm6350.h
new file mode 100644
index 000000000000..43cf2930c88a
--- /dev/null
+++ b/drivers/interconnect/qcom/sm6350.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm #define SM6350 interconnect IDs
+ *
+ * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SM6350_H
+#define __DRIVERS_INTERCONNECT_QCOM_SM6350_H
+
+#define SM6350_A1NOC_SNOC_MAS			0
+#define SM6350_A1NOC_SNOC_SLV			1
+#define SM6350_A2NOC_SNOC_MAS			2
+#define SM6350_A2NOC_SNOC_SLV			3
+#define SM6350_MASTER_A1NOC_CFG			4
+#define SM6350_MASTER_A2NOC_CFG			5
+#define SM6350_MASTER_AMPSS_M0			6
+#define SM6350_MASTER_CAMNOC_HF			7
+#define SM6350_MASTER_CAMNOC_HF0_UNCOMP		8
+#define SM6350_MASTER_CAMNOC_ICP		9
+#define SM6350_MASTER_CAMNOC_ICP_UNCOMP		10
+#define SM6350_MASTER_CAMNOC_SF			11
+#define SM6350_MASTER_CAMNOC_SF_UNCOMP		12
+#define SM6350_MASTER_CNOC_DC_NOC		13
+#define SM6350_MASTER_CNOC_MNOC_CFG		14
+#define SM6350_MASTER_COMPUTE_NOC		15
+#define SM6350_MASTER_CRYPTO_CORE_0		16
+#define SM6350_MASTER_EMMC			17
+#define SM6350_MASTER_GEM_NOC_CFG		18
+#define SM6350_MASTER_GEM_NOC_SNOC		19
+#define SM6350_MASTER_GIC			20
+#define SM6350_MASTER_GRAPHICS_3D		21
+#define SM6350_MASTER_IPA			22
+#define SM6350_MASTER_LLCC			23
+#define SM6350_MASTER_MDP_PORT0			24
+#define SM6350_MASTER_MNOC_HF_MEM_NOC		25
+#define SM6350_MASTER_MNOC_SF_MEM_NOC		26
+#define SM6350_MASTER_NPU			27
+#define SM6350_MASTER_NPU_NOC_CFG		28
+#define SM6350_MASTER_NPU_PROC			29
+#define SM6350_MASTER_NPU_SYS			30
+#define SM6350_MASTER_PIMEM			31
+#define SM6350_MASTER_QDSS_BAM			32
+#define SM6350_MASTER_QDSS_DAP			33
+#define SM6350_MASTER_QDSS_ETR			34
+#define SM6350_MASTER_QUP_0			35
+#define SM6350_MASTER_QUP_1			36
+#define SM6350_MASTER_QUP_CORE_0		37
+#define SM6350_MASTER_QUP_CORE_1		38
+#define SM6350_MASTER_SDCC_2			39
+#define SM6350_MASTER_SNOC_CFG			40
+#define SM6350_MASTER_SNOC_GC_MEM_NOC		41
+#define SM6350_MASTER_SNOC_SF_MEM_NOC		42
+#define SM6350_MASTER_SYS_TCU			43
+#define SM6350_MASTER_UFS_MEM			44
+#define SM6350_MASTER_USB3			45
+#define SM6350_MASTER_VIDEO_P0			46
+#define SM6350_MASTER_VIDEO_PROC		47
+#define SM6350_SLAVE_A1NOC_CFG			48
+#define SM6350_SLAVE_A2NOC_CFG			49
+#define SM6350_SLAVE_AHB2PHY			50
+#define SM6350_SLAVE_AHB2PHY_2			51
+#define SM6350_SLAVE_AOSS			52
+#define SM6350_SLAVE_APPSS			53
+#define SM6350_SLAVE_BOOT_ROM			54
+#define SM6350_SLAVE_CAMERA_CFG			55
+#define SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG	56
+#define SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG	57
+#define SM6350_SLAVE_CAMNOC_UNCOMP		58
+#define SM6350_SLAVE_CDSP_GEM_NOC		59
+#define SM6350_SLAVE_CLK_CTL			60
+#define SM6350_SLAVE_CNOC_DDRSS			61
+#define SM6350_SLAVE_CNOC_MNOC_CFG		62
+#define SM6350_SLAVE_CNOC_MSS			63
+#define SM6350_SLAVE_CRYPTO_0_CFG		64
+#define SM6350_SLAVE_DCC_CFG			65
+#define SM6350_SLAVE_DISPLAY_CFG		66
+#define SM6350_SLAVE_DISPLAY_THROTTLE_CFG	67
+#define SM6350_SLAVE_EBI_CH0			68
+#define SM6350_SLAVE_EMMC_CFG			69
+#define SM6350_SLAVE_GEM_NOC_CFG		70
+#define SM6350_SLAVE_GEM_NOC_SNOC		71
+#define SM6350_SLAVE_GLM			72
+#define SM6350_SLAVE_GRAPHICS_3D_CFG		73
+#define SM6350_SLAVE_IMEM_CFG			74
+#define SM6350_SLAVE_IPA_CFG			75
+#define SM6350_SLAVE_ISENSE_CFG			76
+#define SM6350_SLAVE_LLCC			77
+#define SM6350_SLAVE_LLCC_CFG			78
+#define SM6350_SLAVE_MCDMA_MS_MPU_CFG		79
+#define SM6350_SLAVE_MNOC_HF_MEM_NOC		80
+#define SM6350_SLAVE_MNOC_SF_MEM_NOC		81
+#define SM6350_SLAVE_MSS_PROC_MS_MPU_CFG	82
+#define SM6350_SLAVE_NPU_CAL_DP0		83
+#define SM6350_SLAVE_NPU_CFG			84
+#define SM6350_SLAVE_NPU_COMPUTE_NOC		85
+#define SM6350_SLAVE_NPU_CP			86
+#define SM6350_SLAVE_NPU_DPM			87
+#define SM6350_SLAVE_NPU_INT_DMA_BWMON_CFG	88
+#define SM6350_SLAVE_NPU_LLM_CFG		89
+#define SM6350_SLAVE_NPU_TCM			90
+#define SM6350_SLAVE_OCIMEM			91
+#define SM6350_SLAVE_PDM			92
+#define SM6350_SLAVE_PIMEM			93
+#define SM6350_SLAVE_PIMEM_CFG			94
+#define SM6350_SLAVE_PRNG			95
+#define SM6350_SLAVE_QDSS_CFG			96
+#define SM6350_SLAVE_QDSS_STM			97
+#define SM6350_SLAVE_QM_CFG			98
+#define SM6350_SLAVE_QM_MPU_CFG			99
+#define SM6350_SLAVE_QUP_0			100
+#define SM6350_SLAVE_QUP_1			101
+#define SM6350_SLAVE_QUP_CORE_0			102
+#define SM6350_SLAVE_QUP_CORE_1			103
+#define SM6350_SLAVE_RBCPR_CX_CFG		104
+#define SM6350_SLAVE_RBCPR_MX_CFG		105
+#define SM6350_SLAVE_SDCC_2			106
+#define SM6350_SLAVE_SECURITY			107
+#define SM6350_SLAVE_SERVICE_A1NOC		108
+#define SM6350_SLAVE_SERVICE_A2NOC		109
+#define SM6350_SLAVE_SERVICE_CNOC		110
+#define SM6350_SLAVE_SERVICE_GEM_NOC		111
+#define SM6350_SLAVE_SERVICE_MNOC		112
+#define SM6350_SLAVE_SERVICE_NPU_NOC		113
+#define SM6350_SLAVE_SERVICE_SNOC		114
+#define SM6350_SLAVE_SNOC_CFG			115
+#define SM6350_SLAVE_SNOC_GEM_NOC_GC		116
+#define SM6350_SLAVE_SNOC_GEM_NOC_SF		117
+#define SM6350_SLAVE_TCSR			118
+#define SM6350_SLAVE_TCU			119
+#define SM6350_SLAVE_UFS_MEM_CFG		120
+#define SM6350_SLAVE_USB3			121
+#define SM6350_SLAVE_VENUS_CFG			122
+#define SM6350_SLAVE_VENUS_THROTTLE_CFG		123
+#define SM6350_SLAVE_VSENSE_CTRL_CFG		124
+#define SM6350_SNOC_CNOC_MAS			125
+#define SM6350_SNOC_CNOC_SLV			126
+
+#endif
--=20
2.36.1

