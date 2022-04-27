Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539095119CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiD0NPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbiD0NPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:15:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463B73A1A34
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:12:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so3277370ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zo30U2a3x9h8gZmVnKlzICGjV7EErdQKTWjBgF+XEsk=;
        b=enGbpjMNb0lU0hAevh127t9WQAvthP/Q1dK2zgs0wxhlwwIFvbgj5Cuu7QKBfxHl+T
         2LDymhT9ZWmyx2XdDPs4YM9LcX5jsNW+YqktQtP6wuAVoGlNFdnp6oL+f7xKlCxiGVBw
         5cECJlrL6DsG+Ek02hfGAJ66kPXL8MKGcGE0O/yR9bzjX6ci8bC2+naBcnej0Ob6bDzR
         RUX1AIGzIW7uFxhBZDiFtgJSCuasxH6RjUWYZxnKlhNoPWl3i0AXoJ6BLfCna0H1BVuB
         3KDduRORx764x67bpD8wj8jFxWOolm9rpT5sVNsVz09ZwgYC+3+0xrgFTnfI18UTVMsd
         WmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zo30U2a3x9h8gZmVnKlzICGjV7EErdQKTWjBgF+XEsk=;
        b=B9a/yPf7n4Po5lS1/EegsMUrgL9kX6XSbFfrBxDv0GShpmEbiwyj5+T1YBlbn8MaSn
         57A1mfx5QSR/SFYad7l0kDoN7PqPYb/I9UGWx4U2J+/pE1G7epAnO1iCOf1GYlYektS+
         /jOtKKTelTkbSS/18tKe1RAv3iN3UAgnY4g0ywndKNGTLSn+eR1K3mtD5fyHtBkjpg7V
         6YQMl0mVKOJpcEuhH4w7tp47pLeWwbMlWBAkAKgjJTAcUNlZSDNE+jaJ+zzpadWPrx2/
         w3tQXPFn4WeixuWqbc7NLduM4zEmqw7bz+D8/bpbZbYucouu7SQxcCvhMpAxlQR4sAmO
         kdRA==
X-Gm-Message-State: AOAM533OV458+kjO8Wf7MlQJau0cDl1Ounwv+mQMP/OxHJ+oivP8Zm0O
        m0MK8vtTw7ehVcnw3+OfYXKbHQ==
X-Google-Smtp-Source: ABdhPJxTjNa8hRlOr0lMdgB81fJ3uKNVMzPZ/Tat4sDhuysmdYW4gHfjUpOTAYgrl0MP0Wx5lpeXJQ==
X-Received: by 2002:a17:907:3e18:b0:6f3:6abc:a904 with SMTP id hp24-20020a1709073e1800b006f36abca904mr22192208ejc.341.1651065119149;
        Wed, 27 Apr 2022 06:11:59 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o23-20020a509b17000000b00425edfe72a3sm4881031edi.43.2022.04.27.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 06:11:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] interconnect: qcom: sc8280xp: constify icc_node pointers
Date:   Wed, 27 Apr 2022 15:11:53 +0200
Message-Id: <20220427131154.302581-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427131154.302581-1-krzysztof.kozlowski@linaro.org>
References: <20220427131154.302581-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/interconnect/qcom/sc8280xp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index 7e6967d7b4a7..408f6ade29e4 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -2014,7 +2014,7 @@ static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
 	&bcm_sn5,
 };
 
-static struct qcom_icc_node *aggre1_noc_nodes[] = {
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[MASTER_QSPI_0] = &qhm_qspi,
 	[MASTER_QUP_1] = &qhm_qup1,
 	[MASTER_QUP_2] = &qhm_qup2,
@@ -2046,7 +2046,7 @@ static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
 	&bcm_sn4,
 };
 
-static struct qcom_icc_node *aggre2_noc_nodes[] = {
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
 	[MASTER_QUP_0] = &qhm_qup0,
 	[MASTER_A2NOC_CFG] = &qnm_a2noc_cfg,
@@ -2083,7 +2083,7 @@ static struct qcom_icc_bcm *clk_virt_bcms[] = {
 	&bcm_qup2,
 };
 
-static struct qcom_icc_node *clk_virt_nodes[] = {
+static struct qcom_icc_node * const clk_virt_nodes[] = {
 	[MASTER_IPA_CORE] = &ipa_core_master,
 	[MASTER_QUP_CORE_0] = &qup0_core_master,
 	[MASTER_QUP_CORE_1] = &qup1_core_master,
@@ -2110,7 +2110,7 @@ static struct qcom_icc_bcm *config_noc_bcms[] = {
 	&bcm_sn10,
 };
 
-static struct qcom_icc_node *config_noc_nodes[] = {
+static struct qcom_icc_node * const config_noc_nodes[] = {
 	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
 	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
 	[SLAVE_AHB2PHY_0] = &qhs_ahb2phy0,
@@ -2208,7 +2208,7 @@ static const struct qcom_icc_desc sc8280xp_config_noc = {
 static struct qcom_icc_bcm *dc_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *dc_noc_nodes[] = {
+static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[MASTER_CNOC_DC_NOC] = &qnm_cnoc_dc_noc,
 	[SLAVE_LLCC_CFG] = &qhs_llcc,
 	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
@@ -2226,7 +2226,7 @@ static struct qcom_icc_bcm *gem_noc_bcms[] = {
 	&bcm_sh2,
 };
 
-static struct qcom_icc_node *gem_noc_nodes[] = {
+static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[MASTER_GPU_TCU] = &alm_gpu_tcu,
 	[MASTER_PCIE_TCU] = &alm_pcie_tcu,
 	[MASTER_SYS_TCU] = &alm_sys_tcu,
@@ -2259,7 +2259,7 @@ static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
 	&bcm_sn9,
 };
 
-static struct qcom_icc_node *lpass_ag_noc_nodes[] = {
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 	[MASTER_CNOC_LPASS_AG_NOC] = &qhm_config_noc,
 	[MASTER_LPASS_PROC] = &qxm_lpass_dsp,
 	[SLAVE_LPASS_CORE_CFG] = &qhs_lpass_core,
@@ -2283,7 +2283,7 @@ static struct qcom_icc_bcm *mc_virt_bcms[] = {
 	&bcm_mc0,
 };
 
-static struct qcom_icc_node *mc_virt_nodes[] = {
+static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI1] = &ebi,
 };
@@ -2300,7 +2300,7 @@ static struct qcom_icc_bcm *mmss_noc_bcms[] = {
 	&bcm_mm1,
 };
 
-static struct qcom_icc_node *mmss_noc_nodes[] = {
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
 	[MASTER_MDP0] = &qnm_mdp0_0,
 	[MASTER_MDP1] = &qnm_mdp0_1,
@@ -2331,7 +2331,7 @@ static struct qcom_icc_bcm *nspa_noc_bcms[] = {
 	&bcm_nsa1,
 };
 
-static struct qcom_icc_node *nspa_noc_nodes[] = {
+static struct qcom_icc_node * const nspa_noc_nodes[] = {
 	[MASTER_CDSP_NOC_CFG] = &qhm_nsp_noc_config,
 	[MASTER_CDSP_PROC] = &qxm_nsp,
 	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
@@ -2351,7 +2351,7 @@ static struct qcom_icc_bcm *nspb_noc_bcms[] = {
 	&bcm_nsb1,
 };
 
-static struct qcom_icc_node *nspb_noc_nodes[] = {
+static struct qcom_icc_node * const nspb_noc_nodes[] = {
 	[MASTER_CDSPB_NOC_CFG] = &qhm_nspb_noc_config,
 	[MASTER_CDSP_PROC_B] = &qxm_nspb,
 	[SLAVE_CDSPB_MEM_NOC] = &qns_nspb_gemnoc,
@@ -2375,7 +2375,7 @@ static struct qcom_icc_bcm *system_noc_main_bcms[] = {
 	&bcm_sn9,
 };
 
-static struct qcom_icc_node *system_noc_main_nodes[] = {
+static struct qcom_icc_node * const system_noc_main_nodes[] = {
 	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
 	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
 	[MASTER_USB_NOC_SNOC] = &qnm_aggre_usb_noc,
-- 
2.32.0

