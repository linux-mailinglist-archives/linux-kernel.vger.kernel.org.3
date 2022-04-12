Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC974FDE69
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbiDLLqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiDLLp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:45:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F487C17C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:26:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so36383732ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXiKpkIadzd2P4u3JfwfuCOW4IhV2XdgM458yctU52E=;
        b=b4qGd9nSnM+PBhciYSzh5ZPM+HPgzALRXnb2cmHWSQDlxWlQYkUcZ1NOFrgfiOV3qP
         jqlXYWa8bh2QiSPURg0D0DoxyB0IfwepkJb7I9TTsa1iYzwalUGPwauHVgCa82MFld0Y
         OnWfmW7prnJX+r/8Xq6ycHz2ZNtihf2SDRp1t4+OcQ2XkGIspNF04B1+4kpyamsEI/nU
         q4trAbxc6D42GuMBSdzh2NG8k3msZ1uUxTPYYuMN59HDGtD08AaQ88z8KrcxviwSnz5e
         0nDus2KnTqA6TDvUE+gO7ic09eU6RngSB5sq334yKUub/2Biysxt5/Fvj8rhKakdSJ4H
         RiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXiKpkIadzd2P4u3JfwfuCOW4IhV2XdgM458yctU52E=;
        b=hdpuciLiX4+tgL4MVDdiRXC3r6/R7EnHh/JQKXs97ChfNQxNM9kjJruhLI9Wkj2jr0
         nM7p0pfufhjWf2BnFsoIVBGGMsy6wAMr4PmGqrm6lfETWwn8GFBxd7YWlBsvUla1+VnB
         MH9l8+OUfe6acFC7w1WtcwGamQ1EQwLIc5DWPVF3cZMO4JtauZpvQwxHhSwaX7QmjJLT
         ugJIcaiZBVBjHff7r1LnZjrYOrKrjyy02Kp0U8EZbReQ21CRqfOVrh5pPTie30/ciYA4
         EUiEAWTlWYep2s/dywbxakoTgOY2XI+E72tbYNbGtOASTPLF5Zo5yX7cBKkNrFAysDEw
         gfrw==
X-Gm-Message-State: AOAM531jEkRaxvFKTvzXIDttvmN89rZfJjDe0TglOLHv/WidHnJ9ldgW
        O0luOy48H6fU7QSRpfvhxgNpLg==
X-Google-Smtp-Source: ABdhPJxXr03utmF+YxUUq+UGPDVcVrCMHiSwonejxWoHCiI/qU5H2I5OMvirmeFdoOjoMuH+tXqZ+g==
X-Received: by 2002:a17:906:d055:b0:6e8:6cc1:124c with SMTP id bo21-20020a170906d05500b006e86cc1124cmr15043383ejb.758.1649759187812;
        Tue, 12 Apr 2022 03:26:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm4468959ejm.189.2022.04.12.03.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 03:26:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] interconnect: qcom: constify qcom_icc_desc
Date:   Tue, 12 Apr 2022 12:26:21 +0200
Message-Id: <20220412102623.227607-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

struct qcom_icc_desc is not modified so it can be made const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/msm8916.c |  6 +++---
 drivers/interconnect/qcom/msm8939.c |  8 ++++----
 drivers/interconnect/qcom/msm8974.c | 12 ++++++------
 drivers/interconnect/qcom/qcm2290.c | 12 ++++++------
 drivers/interconnect/qcom/qcs404.c  |  6 +++---
 drivers/interconnect/qcom/sc7180.c  | 26 +++++++++++++-------------
 drivers/interconnect/qcom/sc7280.c  | 24 ++++++++++++------------
 drivers/interconnect/qcom/sdm660.c  | 12 ++++++------
 drivers/interconnect/qcom/sm8150.c  | 22 +++++++++++-----------
 drivers/interconnect/qcom/sm8250.c  | 22 +++++++++++-----------
 drivers/interconnect/qcom/sm8350.c  | 20 ++++++++++----------
 drivers/interconnect/qcom/sm8450.c  | 22 +++++++++++-----------
 12 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 2f397a7c3322..4dc122ce9805 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -1228,7 +1228,7 @@ static const struct regmap_config msm8916_snoc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc msm8916_snoc = {
+static const struct qcom_icc_desc msm8916_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8916_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
@@ -1256,7 +1256,7 @@ static const struct regmap_config msm8916_bimc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc msm8916_bimc = {
+static const struct qcom_icc_desc msm8916_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = msm8916_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
@@ -1325,7 +1325,7 @@ static const struct regmap_config msm8916_pcnoc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc msm8916_pcnoc = {
+static const struct qcom_icc_desc msm8916_pcnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8916_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_pcnoc_nodes),
diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index f9c2d7d3100d..7838e332ee41 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -1281,7 +1281,7 @@ static const struct regmap_config msm8939_snoc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc msm8939_snoc = {
+static const struct qcom_icc_desc msm8939_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_nodes),
@@ -1301,7 +1301,7 @@ static struct qcom_icc_node *msm8939_snoc_mm_nodes[] = {
 	[SNOC_MM_INT_2] = &mm_int_2,
 };
 
-static struct qcom_icc_desc msm8939_snoc_mm = {
+static const struct qcom_icc_desc msm8939_snoc_mm = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_snoc_mm_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_mm_nodes),
@@ -1329,7 +1329,7 @@ static const struct regmap_config msm8939_bimc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc msm8939_bimc = {
+static const struct qcom_icc_desc msm8939_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = msm8939_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_bimc_nodes),
@@ -1400,7 +1400,7 @@ static const struct regmap_config msm8939_pcnoc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc msm8939_pcnoc = {
+static const struct qcom_icc_desc msm8939_pcnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_pcnoc_nodes),
diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index da68ce375a89..2eebe421f262 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -254,7 +254,7 @@ static struct msm8974_icc_node *msm8974_bimc_nodes[] = {
 	[BIMC_SLV_AMPSS_L2] = &slv_ampss_l2,
 };
 
-static struct msm8974_icc_desc msm8974_bimc = {
+static const struct msm8974_icc_desc msm8974_bimc = {
 	.nodes = msm8974_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8974_bimc_nodes),
 };
@@ -337,7 +337,7 @@ static struct msm8974_icc_node *msm8974_cnoc_nodes[] = {
 	[CNOC_SLV_SERVICE_CNOC] = &slv_service_cnoc,
 };
 
-static struct msm8974_icc_desc msm8974_cnoc = {
+static const struct msm8974_icc_desc msm8974_cnoc = {
 	.nodes = msm8974_cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8974_cnoc_nodes),
 };
@@ -390,7 +390,7 @@ static struct msm8974_icc_node *msm8974_mnoc_nodes[] = {
 	[MNOC_SLV_SERVICE_MNOC] = &slv_service_mnoc,
 };
 
-static struct msm8974_icc_desc msm8974_mnoc = {
+static const struct msm8974_icc_desc msm8974_mnoc = {
 	.nodes = msm8974_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8974_mnoc_nodes),
 };
@@ -425,7 +425,7 @@ static struct msm8974_icc_node *msm8974_onoc_nodes[] = {
 	[OCMEM_SLV_OCMEM] = &slv_ocmem,
 };
 
-static struct msm8974_icc_desc msm8974_onoc = {
+static const struct msm8974_icc_desc msm8974_onoc = {
 	.nodes = msm8974_onoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8974_onoc_nodes),
 };
@@ -488,7 +488,7 @@ static struct msm8974_icc_node *msm8974_pnoc_nodes[] = {
 	[PNOC_SLV_SERVICE_PNOC] = &slv_service_pnoc,
 };
 
-static struct msm8974_icc_desc msm8974_pnoc = {
+static const struct msm8974_icc_desc msm8974_pnoc = {
 	.nodes = msm8974_pnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8974_pnoc_nodes),
 };
@@ -545,7 +545,7 @@ static struct msm8974_icc_node *msm8974_snoc_nodes[] = {
 	[SNOC_SLV_QDSS_STM] = &slv_qdss_stm,
 };
 
-static struct msm8974_icc_desc msm8974_snoc = {
+static const struct msm8974_icc_desc msm8974_snoc = {
 	.nodes = msm8974_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8974_snoc_nodes),
 };
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 74404e0b2080..644dcd90e7ad 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1193,7 +1193,7 @@ static const struct regmap_config qcm2290_bimc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc qcm2290_bimc = {
+static const struct qcom_icc_desc qcm2290_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = qcm2290_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_bimc_nodes),
@@ -1248,7 +1248,7 @@ static const struct regmap_config qcm2290_cnoc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc qcm2290_cnoc = {
+static const struct qcom_icc_desc qcm2290_cnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = qcm2290_cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_cnoc_nodes),
@@ -1289,7 +1289,7 @@ static const struct regmap_config qcm2290_snoc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc qcm2290_snoc = {
+static const struct qcom_icc_desc qcm2290_snoc = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_snoc_nodes),
@@ -1303,7 +1303,7 @@ static struct qcom_icc_node *qcm2290_qup_virt_nodes[] = {
 	[SLAVE_QUP_CORE_0] = &slv_qup_core_0
 };
 
-static struct qcom_icc_desc qcm2290_qup_virt = {
+static const struct qcom_icc_desc qcm2290_qup_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_qup_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_qup_virt_nodes),
@@ -1316,7 +1316,7 @@ static struct qcom_icc_node *qcm2290_mmnrt_virt_nodes[] = {
 	[SLAVE_SNOC_BIMC_NRT] = &slv_snoc_bimc_nrt,
 };
 
-static struct qcom_icc_desc qcm2290_mmnrt_virt = {
+static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_mmnrt_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_mmnrt_virt_nodes),
@@ -1330,7 +1330,7 @@ static struct qcom_icc_node *qcm2290_mmrt_virt_nodes[] = {
 	[SLAVE_SNOC_BIMC_RT] = &slv_snoc_bimc_rt,
 };
 
-static struct qcom_icc_desc qcm2290_mmrt_virt = {
+static const struct qcom_icc_desc qcm2290_mmrt_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_mmrt_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_mmrt_virt_nodes),
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 416c8bff8efa..d5020b2b2236 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -984,7 +984,7 @@ static struct qcom_icc_node *qcs404_bimc_nodes[] = {
 	[SLAVE_BIMC_SNOC] = &slv_bimc_snoc,
 };
 
-static struct qcom_icc_desc qcs404_bimc = {
+static const struct qcom_icc_desc qcs404_bimc = {
 	.nodes = qcs404_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_bimc_nodes),
 };
@@ -1038,7 +1038,7 @@ static struct qcom_icc_node *qcs404_pcnoc_nodes[] = {
 	[SLAVE_PCNOC_SNOC] = &slv_pcnoc_snoc,
 };
 
-static struct qcom_icc_desc qcs404_pcnoc = {
+static const struct qcom_icc_desc qcs404_pcnoc = {
 	.nodes = qcs404_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_pcnoc_nodes),
 };
@@ -1066,7 +1066,7 @@ static struct qcom_icc_node *qcs404_snoc_nodes[] = {
 	[SLAVE_LPASS] = &slv_lpass,
 };
 
-static struct qcom_icc_desc qcs404_snoc = {
+static const struct qcom_icc_desc qcs404_snoc = {
 	.nodes = qcs404_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_snoc_nodes),
 };
diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index 12d59c36df53..712b50d4b1c3 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -196,7 +196,7 @@ static struct qcom_icc_node *aggre1_noc_nodes[] = {
 	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
 };
 
-static struct qcom_icc_desc sc7180_aggre1_noc = {
+static const struct qcom_icc_desc sc7180_aggre1_noc = {
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -219,7 +219,7 @@ static struct qcom_icc_node *aggre2_noc_nodes[] = {
 	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
 };
 
-static struct qcom_icc_desc sc7180_aggre2_noc = {
+static const struct qcom_icc_desc sc7180_aggre2_noc = {
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -237,7 +237,7 @@ static struct qcom_icc_node *camnoc_virt_nodes[] = {
 	[SLAVE_CAMNOC_UNCOMP] = &qns_camnoc_uncomp,
 };
 
-static struct qcom_icc_desc sc7180_camnoc_virt = {
+static const struct qcom_icc_desc sc7180_camnoc_virt = {
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -256,7 +256,7 @@ static struct qcom_icc_node *compute_noc_nodes[] = {
 	[SLAVE_CDSP_GEM_NOC] = &qns_cdsp_gemnoc,
 };
 
-static struct qcom_icc_desc sc7180_compute_noc = {
+static const struct qcom_icc_desc sc7180_compute_noc = {
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -324,7 +324,7 @@ static struct qcom_icc_node *config_noc_nodes[] = {
 	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
 };
 
-static struct qcom_icc_desc sc7180_config_noc = {
+static const struct qcom_icc_desc sc7180_config_noc = {
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -337,7 +337,7 @@ static struct qcom_icc_node *dc_noc_nodes[] = {
 	[SLAVE_LLCC_CFG] = &qhs_llcc,
 };
 
-static struct qcom_icc_desc sc7180_dc_noc = {
+static const struct qcom_icc_desc sc7180_dc_noc = {
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -365,7 +365,7 @@ static struct qcom_icc_node *gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC] = &srvc_gemnoc,
 };
 
-static struct qcom_icc_desc sc7180_gem_noc = {
+static const struct qcom_icc_desc sc7180_gem_noc = {
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -381,7 +381,7 @@ static struct qcom_icc_node *ipa_virt_nodes[] = {
 	[SLAVE_IPA_CORE] = &ipa_core_slave,
 };
 
-static struct qcom_icc_desc sc7180_ipa_virt = {
+static const struct qcom_icc_desc sc7180_ipa_virt = {
 	.nodes = ipa_virt_nodes,
 	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
 	.bcms = ipa_virt_bcms,
@@ -398,7 +398,7 @@ static struct qcom_icc_node *mc_virt_nodes[] = {
 	[SLAVE_EBI1] = &ebi,
 };
 
-static struct qcom_icc_desc sc7180_mc_virt = {
+static const struct qcom_icc_desc sc7180_mc_virt = {
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -425,7 +425,7 @@ static struct qcom_icc_node *mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
 };
 
-static struct qcom_icc_desc sc7180_mmss_noc = {
+static const struct qcom_icc_desc sc7180_mmss_noc = {
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -446,7 +446,7 @@ static struct qcom_icc_node *npu_noc_nodes[] = {
 	[SLAVE_SERVICE_NPU_NOC] = &srvc_noc,
 };
 
-static struct qcom_icc_desc sc7180_npu_noc = {
+static const struct qcom_icc_desc sc7180_npu_noc = {
 	.nodes = npu_noc_nodes,
 	.num_nodes = ARRAY_SIZE(npu_noc_nodes),
 };
@@ -462,7 +462,7 @@ static struct qcom_icc_node *qup_virt_nodes[] = {
 	[SLAVE_QUP_CORE_1] = &qup_core_slave_2,
 };
 
-static struct qcom_icc_desc sc7180_qup_virt = {
+static const  struct qcom_icc_desc sc7180_qup_virt = {
 	.nodes = qup_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qup_virt_nodes),
 	.bcms = qup_virt_bcms,
@@ -497,7 +497,7 @@ static struct qcom_icc_node *system_noc_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
-static struct qcom_icc_desc sc7180_system_noc = {
+static const struct qcom_icc_desc sc7180_system_noc = {
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index f8b34f6cbb0d..0464e5eb6a32 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1500,7 +1500,7 @@ static struct qcom_icc_node *aggre1_noc_nodes[] = {
 	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
 };
 
-static struct qcom_icc_desc sc7280_aggre1_noc = {
+static const struct qcom_icc_desc sc7280_aggre1_noc = {
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1522,7 +1522,7 @@ static struct qcom_icc_node *aggre2_noc_nodes[] = {
 	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
 };
 
-static struct qcom_icc_desc sc7280_aggre2_noc = {
+static const struct qcom_icc_desc sc7280_aggre2_noc = {
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1541,7 +1541,7 @@ static struct qcom_icc_node *clk_virt_nodes[] = {
 	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
 };
 
-static struct qcom_icc_desc sc7280_clk_virt = {
+static const struct qcom_icc_desc sc7280_clk_virt = {
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1603,7 +1603,7 @@ static struct qcom_icc_node *cnoc2_nodes[] = {
 	[SLAVE_SNOC_CFG] = &qns_snoc_cfg,
 };
 
-static struct qcom_icc_desc sc7280_cnoc2 = {
+static const struct qcom_icc_desc sc7280_cnoc2 = {
 	.nodes = cnoc2_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc2_nodes),
 	.bcms = cnoc2_bcms,
@@ -1635,7 +1635,7 @@ static struct qcom_icc_node *cnoc3_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
-static struct qcom_icc_desc sc7280_cnoc3 = {
+static const struct qcom_icc_desc sc7280_cnoc3 = {
 	.nodes = cnoc3_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc3_nodes),
 	.bcms = cnoc3_bcms,
@@ -1651,7 +1651,7 @@ static struct qcom_icc_node *dc_noc_nodes[] = {
 	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
 };
 
-static struct qcom_icc_desc sc7280_dc_noc = {
+static const struct qcom_icc_desc sc7280_dc_noc = {
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1687,7 +1687,7 @@ static struct qcom_icc_node *gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC] = &srvc_sys_gemnoc,
 };
 
-static struct qcom_icc_desc sc7280_gem_noc = {
+static const struct qcom_icc_desc sc7280_gem_noc = {
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1707,7 +1707,7 @@ static struct qcom_icc_node *lpass_ag_noc_nodes[] = {
 	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
 };
 
-static struct qcom_icc_desc sc7280_lpass_ag_noc = {
+static const struct qcom_icc_desc sc7280_lpass_ag_noc = {
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1724,7 +1724,7 @@ static struct qcom_icc_node *mc_virt_nodes[] = {
 	[SLAVE_EBI1] = &ebi,
 };
 
-static struct qcom_icc_desc sc7280_mc_virt = {
+static const struct qcom_icc_desc sc7280_mc_virt = {
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1751,7 +1751,7 @@ static struct qcom_icc_node *mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
 };
 
-static struct qcom_icc_desc sc7280_mmss_noc = {
+static const struct qcom_icc_desc sc7280_mmss_noc = {
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1770,7 +1770,7 @@ static struct qcom_icc_node *nsp_noc_nodes[] = {
 	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
 };
 
-static struct qcom_icc_desc sc7280_nsp_noc = {
+static const struct qcom_icc_desc sc7280_nsp_noc = {
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1795,7 +1795,7 @@ static struct qcom_icc_node *system_noc_nodes[] = {
 	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
 };
 
-static struct qcom_icc_desc sc7280_system_noc = {
+static const struct qcom_icc_desc sc7280_system_noc = {
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 274a7139fe1a..5bfc724e4c16 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1512,7 +1512,7 @@ static const struct regmap_config sdm660_a2noc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc sdm660_a2noc = {
+static const struct qcom_icc_desc sdm660_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_a2noc_nodes),
@@ -1540,7 +1540,7 @@ static const struct regmap_config sdm660_bimc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc sdm660_bimc = {
+static const struct qcom_icc_desc sdm660_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = sdm660_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_bimc_nodes),
@@ -1594,7 +1594,7 @@ static const struct regmap_config sdm660_cnoc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc sdm660_cnoc = {
+static const struct qcom_icc_desc sdm660_cnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_cnoc_nodes),
@@ -1615,7 +1615,7 @@ static const struct regmap_config sdm660_gnoc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc sdm660_gnoc = {
+static const struct qcom_icc_desc sdm660_gnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_gnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_gnoc_nodes),
@@ -1655,7 +1655,7 @@ static const struct regmap_config sdm660_mnoc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc sdm660_mnoc = {
+static const struct qcom_icc_desc sdm660_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
@@ -1692,7 +1692,7 @@ static const struct regmap_config sdm660_snoc_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct qcom_icc_desc sdm660_snoc = {
+static const struct qcom_icc_desc sdm660_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_snoc_nodes),
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index 745e3c36a61a..4f3bdc530dcf 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -202,7 +202,7 @@ static struct qcom_icc_node *aggre1_noc_nodes[] = {
 	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
 };
 
-static struct qcom_icc_desc sm8150_aggre1_noc = {
+static const struct qcom_icc_desc sm8150_aggre1_noc = {
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -237,7 +237,7 @@ static struct qcom_icc_node *aggre2_noc_nodes[] = {
 	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
 };
 
-static struct qcom_icc_desc sm8150_aggre2_noc = {
+static const struct qcom_icc_desc sm8150_aggre2_noc = {
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -255,7 +255,7 @@ static struct qcom_icc_node *camnoc_virt_nodes[] = {
 	[SLAVE_CAMNOC_UNCOMP] = &qns_camnoc_uncomp,
 };
 
-static struct qcom_icc_desc sm8150_camnoc_virt = {
+static const struct qcom_icc_desc sm8150_camnoc_virt = {
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -272,7 +272,7 @@ static struct qcom_icc_node *compute_noc_nodes[] = {
 	[SLAVE_CDSP_MEM_NOC] = &qns_cdsp_mem_noc,
 };
 
-static struct qcom_icc_desc sm8150_compute_noc = {
+static const struct qcom_icc_desc sm8150_compute_noc = {
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -340,7 +340,7 @@ static struct qcom_icc_node *config_noc_nodes[] = {
 	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
 };
 
-static struct qcom_icc_desc sm8150_config_noc = {
+static const struct qcom_icc_desc sm8150_config_noc = {
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -356,7 +356,7 @@ static struct qcom_icc_node *dc_noc_nodes[] = {
 	[SLAVE_GEM_NOC_CFG] = &qhs_memnoc,
 };
 
-static struct qcom_icc_desc sm8150_dc_noc = {
+static const struct qcom_icc_desc sm8150_dc_noc = {
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -391,7 +391,7 @@ static struct qcom_icc_node *gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC] = &srvc_gemnoc,
 };
 
-static struct qcom_icc_desc sm8150_gem_noc = {
+static const struct qcom_icc_desc sm8150_gem_noc = {
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -407,7 +407,7 @@ static struct qcom_icc_node *ipa_virt_nodes[] = {
 	[SLAVE_IPA_CORE] = &ipa_core_slave,
 };
 
-static struct qcom_icc_desc sm8150_ipa_virt = {
+static const struct qcom_icc_desc sm8150_ipa_virt = {
 	.nodes = ipa_virt_nodes,
 	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
 	.bcms = ipa_virt_bcms,
@@ -424,7 +424,7 @@ static struct qcom_icc_node *mc_virt_nodes[] = {
 	[SLAVE_EBI_CH0] = &ebi,
 };
 
-static struct qcom_icc_desc sm8150_mc_virt = {
+static const struct qcom_icc_desc sm8150_mc_virt = {
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -454,7 +454,7 @@ static struct qcom_icc_node *mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
 };
 
-static struct qcom_icc_desc sm8150_mmss_noc = {
+static const struct qcom_icc_desc sm8150_mmss_noc = {
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -495,7 +495,7 @@ static struct qcom_icc_node *system_noc_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
-static struct qcom_icc_desc sm8150_system_noc = {
+static const struct qcom_icc_desc sm8150_system_noc = {
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index aa707582ea01..b2e12b01a5e8 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -216,7 +216,7 @@ static struct qcom_icc_node *aggre1_noc_nodes[] = {
 	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
 };
 
-static struct qcom_icc_desc sm8250_aggre1_noc = {
+static const struct qcom_icc_desc sm8250_aggre1_noc = {
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -246,7 +246,7 @@ static struct qcom_icc_node *aggre2_noc_nodes[] = {
 	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
 };
 
-static struct qcom_icc_desc sm8250_aggre2_noc = {
+static const struct qcom_icc_desc sm8250_aggre2_noc = {
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -263,7 +263,7 @@ static struct qcom_icc_node *compute_noc_nodes[] = {
 	[SLAVE_CDSP_MEM_NOC] = &qns_cdsp_mem_noc,
 };
 
-static struct qcom_icc_desc sm8250_compute_noc = {
+static const struct qcom_icc_desc sm8250_compute_noc = {
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -329,7 +329,7 @@ static struct qcom_icc_node *config_noc_nodes[] = {
 	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
 };
 
-static struct qcom_icc_desc sm8250_config_noc = {
+static const struct qcom_icc_desc sm8250_config_noc = {
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -345,7 +345,7 @@ static struct qcom_icc_node *dc_noc_nodes[] = {
 	[SLAVE_GEM_NOC_CFG] = &qhs_memnoc,
 };
 
-static struct qcom_icc_desc sm8250_dc_noc = {
+static const struct qcom_icc_desc sm8250_dc_noc = {
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -379,7 +379,7 @@ static struct qcom_icc_node *gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC] = &srvc_sys_gemnoc,
 };
 
-static struct qcom_icc_desc sm8250_gem_noc = {
+static const struct qcom_icc_desc sm8250_gem_noc = {
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -395,7 +395,7 @@ static struct qcom_icc_node *ipa_virt_nodes[] = {
 	[SLAVE_IPA_CORE] = &ipa_core_slave,
 };
 
-static struct qcom_icc_desc sm8250_ipa_virt = {
+static const struct qcom_icc_desc sm8250_ipa_virt = {
 	.nodes = ipa_virt_nodes,
 	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
 	.bcms = ipa_virt_bcms,
@@ -412,7 +412,7 @@ static struct qcom_icc_node *mc_virt_nodes[] = {
 	[SLAVE_EBI_CH0] = &ebi,
 };
 
-static struct qcom_icc_desc sm8250_mc_virt = {
+static const struct qcom_icc_desc sm8250_mc_virt = {
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -442,7 +442,7 @@ static struct qcom_icc_node *mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
 };
 
-static struct qcom_icc_desc sm8250_mmss_noc = {
+static const struct qcom_icc_desc sm8250_mmss_noc = {
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -468,7 +468,7 @@ static struct qcom_icc_node *npu_noc_nodes[] = {
 	[SLAVE_SERVICE_NPU_NOC] = &srvc_noc,
 };
 
-static struct qcom_icc_desc sm8250_npu_noc = {
+static const struct qcom_icc_desc sm8250_npu_noc = {
 	.nodes = npu_noc_nodes,
 	.num_nodes = ARRAY_SIZE(npu_noc_nodes),
 	.bcms = npu_noc_bcms,
@@ -511,7 +511,7 @@ static struct qcom_icc_node *system_noc_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
-static struct qcom_icc_desc sm8250_system_noc = {
+static const struct qcom_icc_desc sm8250_system_noc = {
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index c79f93a1ac73..936164391d6a 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -213,7 +213,7 @@ static struct qcom_icc_node *aggre1_noc_nodes[] = {
 	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
 };
 
-static struct qcom_icc_desc sm8350_aggre1_noc = {
+static const struct qcom_icc_desc sm8350_aggre1_noc = {
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -244,7 +244,7 @@ static struct qcom_icc_node *aggre2_noc_nodes[] = {
 	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
 };
 
-static struct qcom_icc_desc sm8350_aggre2_noc = {
+static const struct qcom_icc_desc sm8350_aggre2_noc = {
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -323,7 +323,7 @@ static struct qcom_icc_node *config_noc_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
-static struct qcom_icc_desc sm8350_config_noc = {
+static const struct qcom_icc_desc sm8350_config_noc = {
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -339,7 +339,7 @@ static struct qcom_icc_node *dc_noc_nodes[] = {
 	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
 };
 
-static struct qcom_icc_desc sm8350_dc_noc = {
+static const struct qcom_icc_desc sm8350_dc_noc = {
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -379,7 +379,7 @@ static struct qcom_icc_node *gem_noc_nodes[] = {
 	[SLAVE_LLCC_DISP] = &qns_llcc_disp,
 };
 
-static struct qcom_icc_desc sm8350_gem_noc = {
+static const struct qcom_icc_desc sm8350_gem_noc = {
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -399,7 +399,7 @@ static struct qcom_icc_node *lpass_ag_noc_nodes[] = {
 	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
 };
 
-static struct qcom_icc_desc sm8350_lpass_ag_noc = {
+static const struct qcom_icc_desc sm8350_lpass_ag_noc = {
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -420,7 +420,7 @@ static struct qcom_icc_node *mc_virt_nodes[] = {
 	[SLAVE_EBI1_DISP] = &ebi_disp,
 };
 
-static struct qcom_icc_desc sm8350_mc_virt = {
+static const struct qcom_icc_desc sm8350_mc_virt = {
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -459,7 +459,7 @@ static struct qcom_icc_node *mmss_noc_nodes[] = {
 	[SLAVE_MNOC_SF_MEM_NOC_DISP] = &qns_mem_noc_sf_disp,
 };
 
-static struct qcom_icc_desc sm8350_mmss_noc = {
+static const struct qcom_icc_desc sm8350_mmss_noc = {
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -478,7 +478,7 @@ static struct qcom_icc_node *nsp_noc_nodes[] = {
 	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
 };
 
-static struct qcom_icc_desc sm8350_compute_noc = {
+static const struct qcom_icc_desc sm8350_compute_noc = {
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -503,7 +503,7 @@ static struct qcom_icc_node *system_noc_nodes[] = {
 	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
 };
 
-static struct qcom_icc_desc sm8350_system_noc = {
+static const struct qcom_icc_desc sm8350_system_noc = {
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 8d99ee6421df..dbec8228e2e4 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1540,7 +1540,7 @@ static struct qcom_icc_node *aggre1_noc_nodes[] = {
 	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
 };
 
-static struct qcom_icc_desc sm8450_aggre1_noc = {
+static const struct qcom_icc_desc sm8450_aggre1_noc = {
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1567,7 +1567,7 @@ static struct qcom_icc_node *aggre2_noc_nodes[] = {
 	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
 };
 
-static struct qcom_icc_desc sm8450_aggre2_noc = {
+static const struct qcom_icc_desc sm8450_aggre2_noc = {
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1589,7 +1589,7 @@ static struct qcom_icc_node *clk_virt_nodes[] = {
 	[SLAVE_QUP_CORE_2] = &qup2_core_slave,
 };
 
-static struct qcom_icc_desc sm8450_clk_virt = {
+static const struct qcom_icc_desc sm8450_clk_virt = {
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1658,7 +1658,7 @@ static struct qcom_icc_node *config_noc_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
-static struct qcom_icc_desc sm8450_config_noc = {
+static const struct qcom_icc_desc sm8450_config_noc = {
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1693,7 +1693,7 @@ static struct qcom_icc_node *gem_noc_nodes[] = {
 	[SLAVE_LLCC_DISP] = &qns_llcc_disp,
 };
 
-static struct qcom_icc_desc sm8450_gem_noc = {
+static const struct qcom_icc_desc sm8450_gem_noc = {
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1715,7 +1715,7 @@ static struct qcom_icc_node *lpass_ag_noc_nodes[] = {
 	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
 };
 
-static struct qcom_icc_desc sm8450_lpass_ag_noc = {
+static const struct qcom_icc_desc sm8450_lpass_ag_noc = {
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1736,7 +1736,7 @@ static struct qcom_icc_node *mc_virt_nodes[] = {
 	[SLAVE_EBI1_DISP] = &ebi_disp,
 };
 
-static struct qcom_icc_desc sm8450_mc_virt = {
+static const struct qcom_icc_desc sm8450_mc_virt = {
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1771,7 +1771,7 @@ static struct qcom_icc_node *mmss_noc_nodes[] = {
 	[SLAVE_MNOC_SF_MEM_NOC_DISP] = &qns_mem_noc_sf_disp,
 };
 
-static struct qcom_icc_desc sm8450_mmss_noc = {
+static const struct qcom_icc_desc sm8450_mmss_noc = {
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1789,7 +1789,7 @@ static struct qcom_icc_node *nsp_noc_nodes[] = {
 	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
 };
 
-static struct qcom_icc_desc sm8450_nsp_noc = {
+static const struct qcom_icc_desc sm8450_nsp_noc = {
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1808,7 +1808,7 @@ static struct qcom_icc_node *pcie_anoc_nodes[] = {
 	[SLAVE_SERVICE_PCIE_ANOC] = &srvc_pcie_aggre_noc,
 };
 
-static struct qcom_icc_desc sm8450_pcie_anoc = {
+static const struct qcom_icc_desc sm8450_pcie_anoc = {
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -1836,7 +1836,7 @@ static struct qcom_icc_node *system_noc_nodes[] = {
 	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
 };
 
-static struct qcom_icc_desc sm8450_system_noc = {
+static const struct qcom_icc_desc sm8450_system_noc = {
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
-- 
2.32.0

