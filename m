Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2874FDE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbiDLLrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiDLLqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:46:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EE27C781
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:26:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ks6so11749359ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrW/94cAa5hNSk55rAAwC9rYait37O4q4k3EokURmfk=;
        b=iAgiRWQdZyFos/TNNKR/PiDgndtsLB14oCW9Ap6BCQTuXAMLDNRKR+HEipBoV5j/RS
         rkaPVykP16ohiNJUwOcR8EVYzEb9rnwLUeLyJ9Mt4JxtcqrgqzKSe/5FCXr9B7jxlzGy
         NUA8BSXqE3wEaDP1U33TJogDAqq+dIHSLoyZcqBnri3Y8l0KtqB+kWSu5dBCEYRxbtUw
         PhULvB0uy7QNVggp+nanvQozu2dB1XUgTX1a+6hxk5X6dy5bAPX/M8UZf0A6VRjokkq9
         QF/yCuFIWp7BewrBNPiQgEW4leQZNbQseA4NoO8hiJPyIjWiF/HGlpuvHcHEdKbNV7IM
         z3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrW/94cAa5hNSk55rAAwC9rYait37O4q4k3EokURmfk=;
        b=DexyzrjvM4ddAvBMzkX+1XXRnDF6m+O/ttPkXp1Xl/Izo/lCr23GRl0OfaIdAjYRle
         iwKCCqkoqxCmsDvvwqh6B7X6T5H0f0BBsAMYAZ+wSahws9M7gzXznFgIAxz9XIE+Tg5r
         zbKmO2M2MN1A2Orb9/kR6yMvPdAP6KiDWBH8ufoscbHArC8lTSrq7OpSRI6+5eoVLalT
         oVf0FPsfznx+a4WqD5Z1E/xHgb9YwFsjBAlzCV63TVMxKLmEEKnmz1T3sdL7/2gEZJOn
         u2R2NNWOGH12TSqherEQxqw0yntczGAPSbt8TkTUXHnNp8OSMJtlcyWDPg20BJj7lKKp
         pGyQ==
X-Gm-Message-State: AOAM5302IuM4ecOWOrkNcVzGNAEAuLJ6JG9tRH5ch1AUALcAvcRs93ck
        nAOeDYTTKjaOQXk9S9cMhZr/dg==
X-Google-Smtp-Source: ABdhPJxQ0DFgtHdPc7npkD3wNC7QSKrKJsMeJGJez/mZHjEuG4i7/jCS+AcT2gEVgn28sGKCD8b45Q==
X-Received: by 2002:a17:906:3ecc:b0:6e7:f3f1:ea8b with SMTP id d12-20020a1709063ecc00b006e7f3f1ea8bmr13281643ejj.725.1649759190303;
        Tue, 12 Apr 2022 03:26:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm4468959ejm.189.2022.04.12.03.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 03:26:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] interconnect: qcom: constify qcom_icc_bcm pointers
Date:   Tue, 12 Apr 2022 12:26:23 +0200
Message-Id: <20220412102623.227607-3-krzysztof.kozlowski@linaro.org>
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

Pointers to struct qcom_icc_bcm are not modified, so they can be made
const for safety.  The contents of struct qcom_icc_bcm must stay
non-const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/icc-rpmh.h |  4 ++--
 drivers/interconnect/qcom/sc7180.c   | 22 +++++++++++-----------
 drivers/interconnect/qcom/sc7280.c   | 24 ++++++++++++------------
 drivers/interconnect/qcom/sc8180x.c  | 20 ++++++++++----------
 drivers/interconnect/qcom/sdm845.c   | 16 ++++++++--------
 drivers/interconnect/qcom/sdx55.c    |  8 ++++----
 drivers/interconnect/qcom/sm8150.c   | 22 +++++++++++-----------
 drivers/interconnect/qcom/sm8250.c   | 22 +++++++++++-----------
 drivers/interconnect/qcom/sm8350.c   | 20 ++++++++++----------
 drivers/interconnect/qcom/sm8450.c   | 22 +++++++++++-----------
 10 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 5dfc26072593..d29929461c17 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -22,7 +22,7 @@
 struct qcom_icc_provider {
 	struct icc_provider provider;
 	struct device *dev;
-	struct qcom_icc_bcm **bcms;
+	struct qcom_icc_bcm * const *bcms;
 	size_t num_bcms;
 	struct bcm_voter *voter;
 };
@@ -114,7 +114,7 @@ struct qcom_icc_fabric {
 struct qcom_icc_desc {
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
-	struct qcom_icc_bcm **bcms;
+	struct qcom_icc_bcm * const *bcms;
 	size_t num_bcms;
 };
 
diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index 11e221edbd1c..67191230f05b 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -181,7 +181,7 @@ DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre1_noc);
 DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_aggre2_noc);
 DEFINE_QBCM(bcm_sn12, "SN12", false, &qnm_gemnoc);
 
-static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_cn1,
 };
 
@@ -203,7 +203,7 @@ static const struct qcom_icc_desc sc7180_aggre1_noc = {
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
 };
 
-static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
 	&bcm_ce0,
 };
 
@@ -226,7 +226,7 @@ static const struct qcom_icc_desc sc7180_aggre2_noc = {
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
 };
 
-static struct qcom_icc_bcm *camnoc_virt_bcms[] = {
+static struct qcom_icc_bcm * const camnoc_virt_bcms[] = {
 	&bcm_mm1,
 };
 
@@ -244,7 +244,7 @@ static const struct qcom_icc_desc sc7180_camnoc_virt = {
 	.num_bcms = ARRAY_SIZE(camnoc_virt_bcms),
 };
 
-static struct qcom_icc_bcm *compute_noc_bcms[] = {
+static struct qcom_icc_bcm * const compute_noc_bcms[] = {
 	&bcm_co0,
 	&bcm_co2,
 	&bcm_co3,
@@ -263,7 +263,7 @@ static const struct qcom_icc_desc sc7180_compute_noc = {
 	.num_bcms = ARRAY_SIZE(compute_noc_bcms),
 };
 
-static struct qcom_icc_bcm *config_noc_bcms[] = {
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
 	&bcm_cn0,
 	&bcm_cn1,
 };
@@ -342,7 +342,7 @@ static const struct qcom_icc_desc sc7180_dc_noc = {
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
 
-static struct qcom_icc_bcm *gem_noc_bcms[] = {
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh2,
 	&bcm_sh3,
@@ -372,7 +372,7 @@ static const struct qcom_icc_desc sc7180_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *ipa_virt_bcms[] = {
+static struct qcom_icc_bcm * const ipa_virt_bcms[] = {
 	&bcm_ip0,
 };
 
@@ -388,7 +388,7 @@ static const struct qcom_icc_desc sc7180_ipa_virt = {
 	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
 };
 
-static struct qcom_icc_bcm *mc_virt_bcms[] = {
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
 };
@@ -405,7 +405,7 @@ static const struct qcom_icc_desc sc7180_mc_virt = {
 	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
 };
 
-static struct qcom_icc_bcm *mmss_noc_bcms[] = {
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
 	&bcm_mm2,
@@ -451,7 +451,7 @@ static const struct qcom_icc_desc sc7180_npu_noc = {
 	.num_nodes = ARRAY_SIZE(npu_noc_nodes),
 };
 
-static struct qcom_icc_bcm *qup_virt_bcms[] = {
+static struct qcom_icc_bcm * const qup_virt_bcms[] = {
 	&bcm_qup0,
 };
 
@@ -469,7 +469,7 @@ static const  struct qcom_icc_desc sc7180_qup_virt = {
 	.num_bcms = ARRAY_SIZE(qup_virt_bcms),
 };
 
-static struct qcom_icc_bcm *system_noc_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn1,
 	&bcm_sn2,
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index d969bc6c4610..971f538bc98a 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1476,7 +1476,7 @@ static struct qcom_icc_bcm bcm_sn14 = {
 	.nodes = { &qns_pcie_mem_noc },
 };
 
-static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_sn5,
 	&bcm_sn6,
 	&bcm_sn14,
@@ -1507,7 +1507,7 @@ static const struct qcom_icc_desc sc7280_aggre1_noc = {
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
 };
 
-static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
 	&bcm_ce0,
 };
 
@@ -1529,7 +1529,7 @@ static const struct qcom_icc_desc sc7280_aggre2_noc = {
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
 };
 
-static struct qcom_icc_bcm *clk_virt_bcms[] = {
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
 	&bcm_qup0,
 	&bcm_qup1,
 };
@@ -1548,7 +1548,7 @@ static const struct qcom_icc_desc sc7280_clk_virt = {
 	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
 };
 
-static struct qcom_icc_bcm *cnoc2_bcms[] = {
+static struct qcom_icc_bcm * const cnoc2_bcms[] = {
 	&bcm_cn1,
 	&bcm_cn2,
 };
@@ -1610,7 +1610,7 @@ static const struct qcom_icc_desc sc7280_cnoc2 = {
 	.num_bcms = ARRAY_SIZE(cnoc2_bcms),
 };
 
-static struct qcom_icc_bcm *cnoc3_bcms[] = {
+static struct qcom_icc_bcm * const cnoc3_bcms[] = {
 	&bcm_cn0,
 	&bcm_cn1,
 	&bcm_sn3,
@@ -1642,7 +1642,7 @@ static const struct qcom_icc_desc sc7280_cnoc3 = {
 	.num_bcms = ARRAY_SIZE(cnoc3_bcms),
 };
 
-static struct qcom_icc_bcm *dc_noc_bcms[] = {
+static struct qcom_icc_bcm * const dc_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const dc_noc_nodes[] = {
@@ -1658,7 +1658,7 @@ static const struct qcom_icc_desc sc7280_dc_noc = {
 	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
 };
 
-static struct qcom_icc_bcm *gem_noc_bcms[] = {
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh2,
 	&bcm_sh3,
@@ -1694,7 +1694,7 @@ static const struct qcom_icc_desc sc7280_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
+static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
@@ -1714,7 +1714,7 @@ static const struct qcom_icc_desc sc7280_lpass_ag_noc = {
 	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
 };
 
-static struct qcom_icc_bcm *mc_virt_bcms[] = {
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
 };
@@ -1731,7 +1731,7 @@ static const struct qcom_icc_desc sc7280_mc_virt = {
 	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
 };
 
-static struct qcom_icc_bcm *mmss_noc_bcms[] = {
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
 	&bcm_mm4,
@@ -1758,7 +1758,7 @@ static const struct qcom_icc_desc sc7280_mmss_noc = {
 	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
 };
 
-static struct qcom_icc_bcm *nsp_noc_bcms[] = {
+static struct qcom_icc_bcm * const nsp_noc_bcms[] = {
 	&bcm_co0,
 	&bcm_co3,
 };
@@ -1777,7 +1777,7 @@ static const struct qcom_icc_desc sc7280_nsp_noc = {
 	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
 };
 
-static struct qcom_icc_bcm *system_noc_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn2,
 	&bcm_sn7,
diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index f6b69b9df410..136c62afb3b2 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -191,53 +191,53 @@ DEFINE_QBCM(bcm_sn11, "SN11", false, &mas_qnm_aggre2_noc);
 DEFINE_QBCM(bcm_sn14, "SN14", false, &slv_qns_pcie_mem_noc);
 DEFINE_QBCM(bcm_sn15, "SN15", false, &mas_qnm_gemnoc);
 
-static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_sn3,
 	&bcm_ce0,
 	&bcm_qup0,
 };
 
-static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
 	&bcm_sn14,
 	&bcm_ce0,
 	&bcm_qup0,
 };
 
-static struct qcom_icc_bcm *camnoc_virt_bcms[] = {
+static struct qcom_icc_bcm * const camnoc_virt_bcms[] = {
 	&bcm_mm1,
 };
 
-static struct qcom_icc_bcm *compute_noc_bcms[] = {
+static struct qcom_icc_bcm * const compute_noc_bcms[] = {
 	&bcm_co0,
 	&bcm_co2,
 };
 
-static struct qcom_icc_bcm *config_noc_bcms[] = {
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
 	&bcm_cn0,
 };
 
-static struct qcom_icc_bcm *gem_noc_bcms[] = {
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh2,
 	&bcm_sh3,
 };
 
-static struct qcom_icc_bcm *ipa_virt_bcms[] = {
+static struct qcom_icc_bcm * const ipa_virt_bcms[] = {
 	&bcm_ip0,
 };
 
-static struct qcom_icc_bcm *mc_virt_bcms[] = {
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_mc0,
 	&bcm_acv,
 };
 
-static struct qcom_icc_bcm *mmss_noc_bcms[] = {
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
 	&bcm_mm2,
 };
 
-static struct qcom_icc_bcm *system_noc_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn1,
 	&bcm_sn2,
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 1af0e6972bad..954e7bd13fc4 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -175,7 +175,7 @@ DEFINE_QBCM(bcm_sn12, "SN12", false, &qnm_gladiator_sodv, &xm_gic);
 DEFINE_QBCM(bcm_sn14, "SN14", false, &qnm_pcie_anoc);
 DEFINE_QBCM(bcm_sn15, "SN15", false, &qnm_memnoc);
 
-static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_sn9,
 	&bcm_qup0,
 };
@@ -201,7 +201,7 @@ static const struct qcom_icc_desc sdm845_aggre1_noc = {
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
 };
 
-static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
 	&bcm_ce0,
 	&bcm_sn11,
 	&bcm_qup0,
@@ -230,7 +230,7 @@ static const struct qcom_icc_desc sdm845_aggre2_noc = {
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
 };
 
-static struct qcom_icc_bcm *config_noc_bcms[] = {
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
 	&bcm_cn0,
 };
 
@@ -291,7 +291,7 @@ static const struct qcom_icc_desc sdm845_config_noc = {
 	.num_bcms = ARRAY_SIZE(config_noc_bcms),
 };
 
-static struct qcom_icc_bcm *dc_noc_bcms[] = {
+static struct qcom_icc_bcm * const dc_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const dc_noc_nodes[] = {
@@ -307,7 +307,7 @@ static const struct qcom_icc_desc sdm845_dc_noc = {
 	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
 };
 
-static struct qcom_icc_bcm *gladiator_noc_bcms[] = {
+static struct qcom_icc_bcm * const gladiator_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const gladiator_noc_nodes[] = {
@@ -325,7 +325,7 @@ static const struct qcom_icc_desc sdm845_gladiator_noc = {
 	.num_bcms = ARRAY_SIZE(gladiator_noc_bcms),
 };
 
-static struct qcom_icc_bcm *mem_noc_bcms[] = {
+static struct qcom_icc_bcm * const mem_noc_bcms[] = {
 	&bcm_mc0,
 	&bcm_acv,
 	&bcm_sh0,
@@ -360,7 +360,7 @@ static const struct qcom_icc_desc sdm845_mem_noc = {
 	.num_bcms = ARRAY_SIZE(mem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *mmss_noc_bcms[] = {
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
 	&bcm_mm2,
@@ -394,7 +394,7 @@ static const struct qcom_icc_desc sdm845_mmss_noc = {
 	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
 };
 
-static struct qcom_icc_bcm *system_noc_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn1,
 	&bcm_sn2,
diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index 74ebf107d62f..3477e7094718 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -102,7 +102,7 @@ DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_memnoc);
 DEFINE_QBCM(bcm_sn10, "SN10", false, &qnm_memnoc_pcie);
 DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_ipa, &xm_ipa2pcie_slv);
 
-static struct qcom_icc_bcm *mc_virt_bcms[] = {
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_mc0,
 };
 
@@ -118,7 +118,7 @@ static const struct qcom_icc_desc sdx55_mc_virt = {
 	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
 };
 
-static struct qcom_icc_bcm *mem_noc_bcms[] = {
+static struct qcom_icc_bcm * const mem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh3,
 	&bcm_sh4,
@@ -140,7 +140,7 @@ static const struct qcom_icc_desc sdx55_mem_noc = {
 	.num_bcms = ARRAY_SIZE(mem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *system_noc_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_ce0,
 	&bcm_pn0,
 	&bcm_pn1,
@@ -219,7 +219,7 @@ static const struct qcom_icc_desc sdx55_system_noc = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
-static struct qcom_icc_bcm *ipa_virt_bcms[] = {
+static struct qcom_icc_bcm * const ipa_virt_bcms[] = {
 	&bcm_ip0,
 };
 
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index 5e08f2fba2a8..1d04a4bfea80 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -186,7 +186,7 @@ DEFINE_QBCM(bcm_sn12, "SN12", false, &qxm_pimem, &xm_gic);
 DEFINE_QBCM(bcm_sn14, "SN14", false, &qns_pcie_mem_noc);
 DEFINE_QBCM(bcm_sn15, "SN15", false, &qnm_gemnoc);
 
-static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_qup0,
 	&bcm_sn3,
 };
@@ -209,7 +209,7 @@ static const struct qcom_icc_desc sm8150_aggre1_noc = {
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
 };
 
-static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
 	&bcm_ce0,
 	&bcm_qup0,
 	&bcm_sn14,
@@ -244,7 +244,7 @@ static const struct qcom_icc_desc sm8150_aggre2_noc = {
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
 };
 
-static struct qcom_icc_bcm *camnoc_virt_bcms[] = {
+static struct qcom_icc_bcm * const camnoc_virt_bcms[] = {
 	&bcm_mm1,
 };
 
@@ -262,7 +262,7 @@ static const struct qcom_icc_desc sm8150_camnoc_virt = {
 	.num_bcms = ARRAY_SIZE(camnoc_virt_bcms),
 };
 
-static struct qcom_icc_bcm *compute_noc_bcms[] = {
+static struct qcom_icc_bcm * const compute_noc_bcms[] = {
 	&bcm_co0,
 	&bcm_co1,
 };
@@ -279,7 +279,7 @@ static const struct qcom_icc_desc sm8150_compute_noc = {
 	.num_bcms = ARRAY_SIZE(compute_noc_bcms),
 };
 
-static struct qcom_icc_bcm *config_noc_bcms[] = {
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
 	&bcm_cn0,
 };
 
@@ -347,7 +347,7 @@ static const struct qcom_icc_desc sm8150_config_noc = {
 	.num_bcms = ARRAY_SIZE(config_noc_bcms),
 };
 
-static struct qcom_icc_bcm *dc_noc_bcms[] = {
+static struct qcom_icc_bcm * const dc_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const dc_noc_nodes[] = {
@@ -363,7 +363,7 @@ static const struct qcom_icc_desc sm8150_dc_noc = {
 	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
 };
 
-static struct qcom_icc_bcm *gem_noc_bcms[] = {
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh2,
 	&bcm_sh3,
@@ -398,7 +398,7 @@ static const struct qcom_icc_desc sm8150_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *ipa_virt_bcms[] = {
+static struct qcom_icc_bcm * const ipa_virt_bcms[] = {
 	&bcm_ip0,
 };
 
@@ -414,7 +414,7 @@ static const struct qcom_icc_desc sm8150_ipa_virt = {
 	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
 };
 
-static struct qcom_icc_bcm *mc_virt_bcms[] = {
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
 };
@@ -431,7 +431,7 @@ static const struct qcom_icc_desc sm8150_mc_virt = {
 	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
 };
 
-static struct qcom_icc_bcm *mmss_noc_bcms[] = {
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
 	&bcm_mm2,
@@ -461,7 +461,7 @@ static const struct qcom_icc_desc sm8150_mmss_noc = {
 	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
 };
 
-static struct qcom_icc_bcm *system_noc_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn1,
 	&bcm_sn11,
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index b186a76493ba..5cdb058fa095 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -195,7 +195,7 @@ DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_gemnoc_pcie);
 DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_gemnoc);
 DEFINE_QBCM(bcm_sn12, "SN12", false, &qns_pcie_modem_mem_noc, &qns_pcie_mem_noc);
 
-static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_qup0,
 	&bcm_sn12,
 };
@@ -223,7 +223,7 @@ static const struct qcom_icc_desc sm8250_aggre1_noc = {
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
 };
 
-static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
 	&bcm_ce0,
 	&bcm_qup0,
 	&bcm_sn12,
@@ -253,7 +253,7 @@ static const struct qcom_icc_desc sm8250_aggre2_noc = {
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
 };
 
-static struct qcom_icc_bcm *compute_noc_bcms[] = {
+static struct qcom_icc_bcm * const compute_noc_bcms[] = {
 	&bcm_co0,
 	&bcm_co2,
 };
@@ -270,7 +270,7 @@ static const struct qcom_icc_desc sm8250_compute_noc = {
 	.num_bcms = ARRAY_SIZE(compute_noc_bcms),
 };
 
-static struct qcom_icc_bcm *config_noc_bcms[] = {
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
 	&bcm_cn0,
 };
 
@@ -336,7 +336,7 @@ static const struct qcom_icc_desc sm8250_config_noc = {
 	.num_bcms = ARRAY_SIZE(config_noc_bcms),
 };
 
-static struct qcom_icc_bcm *dc_noc_bcms[] = {
+static struct qcom_icc_bcm * const dc_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const dc_noc_nodes[] = {
@@ -352,7 +352,7 @@ static const struct qcom_icc_desc sm8250_dc_noc = {
 	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
 };
 
-static struct qcom_icc_bcm *gem_noc_bcms[] = {
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh2,
 	&bcm_sh3,
@@ -386,7 +386,7 @@ static const struct qcom_icc_desc sm8250_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *ipa_virt_bcms[] = {
+static struct qcom_icc_bcm * const ipa_virt_bcms[] = {
 	&bcm_ip0,
 };
 
@@ -402,7 +402,7 @@ static const struct qcom_icc_desc sm8250_ipa_virt = {
 	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
 };
 
-static struct qcom_icc_bcm *mc_virt_bcms[] = {
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
 };
@@ -419,7 +419,7 @@ static const struct qcom_icc_desc sm8250_mc_virt = {
 	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
 };
 
-static struct qcom_icc_bcm *mmss_noc_bcms[] = {
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
 	&bcm_mm2,
@@ -449,7 +449,7 @@ static const struct qcom_icc_desc sm8250_mmss_noc = {
 	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
 };
 
-static struct qcom_icc_bcm *npu_noc_bcms[] = {
+static struct qcom_icc_bcm * const npu_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const npu_noc_nodes[] = {
@@ -475,7 +475,7 @@ static const struct qcom_icc_desc sm8250_npu_noc = {
 	.num_bcms = ARRAY_SIZE(npu_noc_bcms),
 };
 
-static struct qcom_icc_bcm *system_noc_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn1,
 	&bcm_sn11,
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index dd0809f08388..5398e7c8d826 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -198,7 +198,7 @@ DEFINE_QBCM(bcm_mm4_disp, "MM4", false, &qns_mem_noc_sf_disp);
 DEFINE_QBCM(bcm_mm5_disp, "MM5", false, &qxm_rot_disp);
 DEFINE_QBCM(bcm_sh0_disp, "SH0", false, &qns_llcc_disp);
 
-static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const aggre1_noc_nodes[] = {
@@ -220,7 +220,7 @@ static const struct qcom_icc_desc sm8350_aggre1_noc = {
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
 };
 
-static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
 	&bcm_ce0,
 	&bcm_sn5,
 	&bcm_sn6,
@@ -251,7 +251,7 @@ static const struct qcom_icc_desc sm8350_aggre2_noc = {
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
 };
 
-static struct qcom_icc_bcm *config_noc_bcms[] = {
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
 	&bcm_cn0,
 	&bcm_cn1,
 	&bcm_cn2,
@@ -330,7 +330,7 @@ static const struct qcom_icc_desc sm8350_config_noc = {
 	.num_bcms = ARRAY_SIZE(config_noc_bcms),
 };
 
-static struct qcom_icc_bcm *dc_noc_bcms[] = {
+static struct qcom_icc_bcm * const dc_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const dc_noc_nodes[] = {
@@ -346,7 +346,7 @@ static const struct qcom_icc_desc sm8350_dc_noc = {
 	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
 };
 
-static struct qcom_icc_bcm *gem_noc_bcms[] = {
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh2,
 	&bcm_sh3,
@@ -386,7 +386,7 @@ static const struct qcom_icc_desc sm8350_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
+static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
@@ -406,7 +406,7 @@ static const struct qcom_icc_desc sm8350_lpass_ag_noc = {
 	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
 };
 
-static struct qcom_icc_bcm *mc_virt_bcms[] = {
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
 	&bcm_acv_disp,
@@ -427,7 +427,7 @@ static const struct qcom_icc_desc sm8350_mc_virt = {
 	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
 };
 
-static struct qcom_icc_bcm *mmss_noc_bcms[] = {
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
 	&bcm_mm4,
@@ -466,7 +466,7 @@ static const struct qcom_icc_desc sm8350_mmss_noc = {
 	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
 };
 
-static struct qcom_icc_bcm *nsp_noc_bcms[] = {
+static struct qcom_icc_bcm * const nsp_noc_bcms[] = {
 	&bcm_co0,
 	&bcm_co3,
 };
@@ -485,7 +485,7 @@ static const struct qcom_icc_desc sm8350_compute_noc = {
 	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
 };
 
-static struct qcom_icc_bcm *system_noc_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn2,
 	&bcm_sn7,
diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 71fc31f59407..7e3d372b712f 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1526,7 +1526,7 @@ static struct qcom_icc_bcm bcm_sh1_disp = {
 	.nodes = { &qnm_pcie_disp },
 };
 
-static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const aggre1_noc_nodes[] = {
@@ -1547,7 +1547,7 @@ static const struct qcom_icc_desc sm8450_aggre1_noc = {
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
 };
 
-static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
 	&bcm_ce0,
 };
 
@@ -1574,7 +1574,7 @@ static const struct qcom_icc_desc sm8450_aggre2_noc = {
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
 };
 
-static struct qcom_icc_bcm *clk_virt_bcms[] = {
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
 	&bcm_qup0,
 	&bcm_qup1,
 	&bcm_qup2,
@@ -1596,7 +1596,7 @@ static const struct qcom_icc_desc sm8450_clk_virt = {
 	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
 };
 
-static struct qcom_icc_bcm *config_noc_bcms[] = {
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
 	&bcm_cn0,
 };
 
@@ -1665,7 +1665,7 @@ static const struct qcom_icc_desc sm8450_config_noc = {
 	.num_bcms = ARRAY_SIZE(config_noc_bcms),
 };
 
-static struct qcom_icc_bcm *gem_noc_bcms[] = {
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh1,
 	&bcm_sh0_disp,
@@ -1700,7 +1700,7 @@ static const struct qcom_icc_desc sm8450_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
+static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
@@ -1722,7 +1722,7 @@ static const struct qcom_icc_desc sm8450_lpass_ag_noc = {
 	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
 };
 
-static struct qcom_icc_bcm *mc_virt_bcms[] = {
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
 	&bcm_acv_disp,
@@ -1743,7 +1743,7 @@ static const struct qcom_icc_desc sm8450_mc_virt = {
 	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
 };
 
-static struct qcom_icc_bcm *mmss_noc_bcms[] = {
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
 	&bcm_mm0_disp,
@@ -1778,7 +1778,7 @@ static const struct qcom_icc_desc sm8450_mmss_noc = {
 	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
 };
 
-static struct qcom_icc_bcm *nsp_noc_bcms[] = {
+static struct qcom_icc_bcm * const nsp_noc_bcms[] = {
 	&bcm_co0,
 };
 
@@ -1796,7 +1796,7 @@ static const struct qcom_icc_desc sm8450_nsp_noc = {
 	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
 };
 
-static struct qcom_icc_bcm *pcie_anoc_bcms[] = {
+static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
 	&bcm_sn7,
 };
 
@@ -1815,7 +1815,7 @@ static const struct qcom_icc_desc sm8450_pcie_anoc = {
 	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
 };
 
-static struct qcom_icc_bcm *system_noc_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn1,
 	&bcm_sn2,
-- 
2.32.0

