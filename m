Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB8C58152A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbiGZOYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiGZOXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:23:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC502873B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:23:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k11so19935062wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKLGP2qPzgMF9JIPFpzjZnDTtYjHelZSup8J9alZBu8=;
        b=U1XOgt3bZn2IcKKy9pWIiKOZ0N6PHjznOEin05pMxGLGJlw9b9CgYIJZAevmnlJesm
         d48sE38iDPthjK4ZW3LpcvPYGOjSADx2gsBFqPumkJaoerZMEcuBuw1+12lfEVqXNGhE
         o0kzVVPbuFc5uwQj97/bdyhICVYNVcr6OOzyiL3eBS+L/G0rEMpKCsLulSuGcm+7WkYh
         rjaqjoFTrEi1yLDMbMyiJ0dn2nwqBx3ywQsTugz1qm5wphX08b6of3mThjTbtFE4kmrG
         ULdorjFDxbKU5TjdqcIQkr3mcKeRemN1KB/O9Y4cck02/eR1CdeHul989cQWsh+2gHDS
         6vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKLGP2qPzgMF9JIPFpzjZnDTtYjHelZSup8J9alZBu8=;
        b=ESaKZTCL5ZgrSYAm1Q1LEqOBRBV+w9WD47KYtDnMQYxiHxYL6xOpVq+1nsLO/Z6dfg
         xcQVURhG4WnsbM+RgE1YoPlGJC7xmVLA9G67p2aATVbtQyNPJZL8/dGwyPq8oRDGdrC4
         fksOBn4PKTMJVwwWYnzfL4X8q10A17MxW3+T4ECVR0WxhRsH8oc104uyDk248eSrwxEu
         PgwHWb4btfkvlkwLmRY+ZENiZN3cIPNS9dnXd2ivfe62xHNT7D0NIn12AOczLpco/m/J
         mO4+CQDieo+7jLBFa8fKEDduVcBV/354lgiCkV+D+zFT6ZyWPbsgdFB6hWoi1bPIpk4r
         3seA==
X-Gm-Message-State: AJIora/QefRJkgP1CUKTvxD1qfZ7XTuGfky0tiJH3lJtYngFsgAAiQ7v
        71ei6TePNwf5/Wtu0hbFDFO65g==
X-Google-Smtp-Source: AGRyM1v/++bDN9uncj+DNn5WVSAMtqf5oScOAxpt7e+nbg14PznY6OGSAtPsZZZE5ZCFwRfVcg/tNA==
X-Received: by 2002:a5d:59c6:0:b0:21e:86fe:fcc6 with SMTP id v6-20020a5d59c6000000b0021e86fefcc6mr7404719wry.139.1658845425146;
        Tue, 26 Jul 2022 07:23:45 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t21-20020a1c7715000000b003a331c6bffdsm17017119wmi.47.2022.07.26.07.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:23:44 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC 2/9] clk: qcom: gcc-sdm845: Switch from parent_hws to parent_data
Date:   Tue, 26 Jul 2022 17:22:56 +0300
Message-Id: <20220726142303.4126434-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220726142303.4126434-1-abel.vesa@linaro.org>
References: <20220726142303.4126434-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using parent_data instead of parent_hws, we align more with
those clocks that pass fw_name. This will allow us to have cleaner
macros for defining them later on.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 256 +++++++++++++++++-----------------
 1 file changed, 128 insertions(+), 128 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 8529e9c8c90c..599e7d23aeca 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -1028,8 +1028,8 @@ static struct clk_branch gcc_aggre_ufs_card_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_aggre_ufs_card_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_ufs_card_axi_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_ufs_card_axi_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1048,8 +1048,8 @@ static struct clk_branch gcc_aggre_ufs_phy_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_aggre_ufs_phy_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_ufs_phy_axi_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_ufs_phy_axi_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1066,8 +1066,8 @@ static struct clk_branch gcc_aggre_usb3_prim_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_aggre_usb3_prim_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_usb30_prim_master_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_usb30_prim_master_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1084,8 +1084,8 @@ static struct clk_branch gcc_aggre_usb3_sec_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_aggre_usb3_sec_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_usb30_sec_master_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_usb30_sec_master_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1102,8 +1102,8 @@ static struct clk_branch gcc_apc_vs_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_apc_vs_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_vsensor_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_vsensor_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1219,8 +1219,8 @@ static struct clk_branch gcc_cfg_noc_usb3_prim_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_cfg_noc_usb3_prim_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_usb30_prim_master_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_usb30_prim_master_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1237,8 +1237,8 @@ static struct clk_branch gcc_cfg_noc_usb3_sec_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_cfg_noc_usb3_sec_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_usb30_sec_master_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_usb30_sec_master_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1255,8 +1255,8 @@ static struct clk_branch gcc_cpuss_ahb_clk = {
 		.enable_mask = BIT(21),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_cpuss_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_cpuss_ahb_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_cpuss_ahb_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
@@ -1273,8 +1273,8 @@ static struct clk_branch gcc_cpuss_rbcpr_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_cpuss_rbcpr_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_cpuss_rbcpr_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_cpuss_rbcpr_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1332,8 +1332,8 @@ static struct clk_branch gcc_disp_gpll0_clk_src = {
 		.enable_mask = BIT(18),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_disp_gpll0_clk_src",
-			.parent_hws = (const struct clk_hw*[]){
-				&gpll0.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gpll0.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_aon_ops,
@@ -1348,8 +1348,8 @@ static struct clk_branch gcc_disp_gpll0_div_clk_src = {
 		.enable_mask = BIT(19),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_disp_gpll0_div_clk_src",
-			.parent_hws = (const struct clk_hw*[]){
-				&gpll0_out_even.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gpll0_out_even.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -1379,8 +1379,8 @@ static struct clk_branch gcc_gp1_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_gp1_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_gp1_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_gp1_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1397,8 +1397,8 @@ static struct clk_branch gcc_gp2_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_gp2_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_gp2_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_gp2_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1415,8 +1415,8 @@ static struct clk_branch gcc_gp3_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_gp3_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_gp3_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_gp3_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1448,8 +1448,8 @@ static struct clk_branch gcc_gpu_gpll0_clk_src = {
 		.enable_mask = BIT(15),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_gpu_gpll0_clk_src",
-			.parent_hws = (const struct clk_hw*[]){
-				&gpll0.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gpll0.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -1464,8 +1464,8 @@ static struct clk_branch gcc_gpu_gpll0_div_clk_src = {
 		.enable_mask = BIT(16),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_gpu_gpll0_div_clk_src",
-			.parent_hws = (const struct clk_hw*[]){
-				&gpll0_out_even.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gpll0_out_even.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -1520,8 +1520,8 @@ static struct clk_branch gcc_gpu_vs_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_gpu_vs_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_vsensor_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_vsensor_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1619,8 +1619,8 @@ static struct clk_branch gcc_mss_vs_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_mss_vs_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_vsensor_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_vsensor_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1637,8 +1637,8 @@ static struct clk_branch gcc_pcie_0_aux_clk = {
 		.enable_mask = BIT(3),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_pcie_0_aux_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_pcie_0_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1741,8 +1741,8 @@ static struct clk_branch gcc_pcie_1_aux_clk = {
 		.enable_mask = BIT(29),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_pcie_1_aux_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_pcie_1_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1844,8 +1844,8 @@ static struct clk_branch gcc_pcie_phy_aux_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_phy_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_pcie_0_aux_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_pcie_0_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1862,8 +1862,8 @@ static struct clk_branch gcc_pcie_phy_refgen_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_phy_refgen_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_pcie_phy_refgen_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_pcie_phy_refgen_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1880,8 +1880,8 @@ static struct clk_branch gcc_pdm2_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pdm2_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_pdm2_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_pdm2_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1999,8 +1999,8 @@ static struct clk_branch gcc_qspi_core_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qspi_core_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qspi_core_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qspi_core_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2017,8 +2017,8 @@ static struct clk_branch gcc_qupv3_wrap0_s0_clk = {
 		.enable_mask = BIT(10),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s0_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap0_s0_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap0_s0_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2035,8 +2035,8 @@ static struct clk_branch gcc_qupv3_wrap0_s1_clk = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s1_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap0_s1_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap0_s1_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2053,8 +2053,8 @@ static struct clk_branch gcc_qupv3_wrap0_s2_clk = {
 		.enable_mask = BIT(12),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s2_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap0_s2_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap0_s2_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2071,8 +2071,8 @@ static struct clk_branch gcc_qupv3_wrap0_s3_clk = {
 		.enable_mask = BIT(13),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s3_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap0_s3_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap0_s3_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2089,8 +2089,8 @@ static struct clk_branch gcc_qupv3_wrap0_s4_clk = {
 		.enable_mask = BIT(14),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s4_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap0_s4_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap0_s4_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2107,8 +2107,8 @@ static struct clk_branch gcc_qupv3_wrap0_s5_clk = {
 		.enable_mask = BIT(15),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s5_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap0_s5_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap0_s5_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2125,8 +2125,8 @@ static struct clk_branch gcc_qupv3_wrap0_s6_clk = {
 		.enable_mask = BIT(16),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s6_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap0_s6_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap0_s6_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2143,8 +2143,8 @@ static struct clk_branch gcc_qupv3_wrap0_s7_clk = {
 		.enable_mask = BIT(17),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s7_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap0_s7_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap0_s7_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2161,8 +2161,8 @@ static struct clk_branch gcc_qupv3_wrap1_s0_clk = {
 		.enable_mask = BIT(22),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s0_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap1_s0_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap1_s0_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2179,8 +2179,8 @@ static struct clk_branch gcc_qupv3_wrap1_s1_clk = {
 		.enable_mask = BIT(23),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s1_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap1_s1_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap1_s1_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2197,8 +2197,8 @@ static struct clk_branch gcc_qupv3_wrap1_s2_clk = {
 		.enable_mask = BIT(24),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s2_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap1_s2_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap1_s2_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2215,8 +2215,8 @@ static struct clk_branch gcc_qupv3_wrap1_s3_clk = {
 		.enable_mask = BIT(25),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s3_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap1_s3_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap1_s3_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2233,8 +2233,8 @@ static struct clk_branch gcc_qupv3_wrap1_s4_clk = {
 		.enable_mask = BIT(26),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s4_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap1_s4_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap1_s4_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2251,8 +2251,8 @@ static struct clk_branch gcc_qupv3_wrap1_s5_clk = {
 		.enable_mask = BIT(27),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s5_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap1_s5_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap1_s5_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2269,8 +2269,8 @@ static struct clk_branch gcc_qupv3_wrap1_s6_clk = {
 		.enable_mask = BIT(28),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s6_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap1_s6_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap1_s6_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2287,8 +2287,8 @@ static struct clk_branch gcc_qupv3_wrap1_s7_clk = {
 		.enable_mask = BIT(29),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s7_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_qupv3_wrap1_s7_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_qupv3_wrap1_s7_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2374,8 +2374,8 @@ static struct clk_branch gcc_sdcc2_apps_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_sdcc2_apps_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_sdcc2_apps_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_sdcc2_apps_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2405,8 +2405,8 @@ static struct clk_branch gcc_sdcc4_apps_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_sdcc4_apps_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_sdcc4_apps_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_sdcc4_apps_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2423,8 +2423,8 @@ static struct clk_branch gcc_sys_noc_cpuss_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_sys_noc_cpuss_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_cpuss_ahb_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_cpuss_ahb_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
@@ -2467,8 +2467,8 @@ static struct clk_branch gcc_tsif_ref_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_tsif_ref_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_tsif_ref_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_tsif_ref_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2502,8 +2502,8 @@ static struct clk_branch gcc_ufs_card_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_ufs_card_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_ufs_card_axi_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_ufs_card_axi_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2535,8 +2535,8 @@ static struct clk_branch gcc_ufs_card_ice_core_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_ufs_card_ice_core_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_ufs_card_ice_core_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_ufs_card_ice_core_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2555,8 +2555,8 @@ static struct clk_branch gcc_ufs_card_phy_aux_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_ufs_card_phy_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_ufs_card_phy_aux_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_ufs_card_phy_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2611,8 +2611,8 @@ static struct clk_branch gcc_ufs_card_unipro_core_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_ufs_card_unipro_core_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_ufs_card_unipro_core_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_ufs_card_unipro_core_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2659,8 +2659,8 @@ static struct clk_branch gcc_ufs_phy_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_ufs_phy_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_ufs_phy_axi_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_ufs_phy_axi_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2679,8 +2679,8 @@ static struct clk_branch gcc_ufs_phy_ice_core_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_ufs_phy_ice_core_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_ufs_phy_ice_core_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_ufs_phy_ice_core_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2699,8 +2699,8 @@ static struct clk_branch gcc_ufs_phy_phy_aux_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_ufs_phy_phy_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_ufs_phy_phy_aux_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_ufs_phy_phy_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2755,8 +2755,8 @@ static struct clk_branch gcc_ufs_phy_unipro_core_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_ufs_phy_unipro_core_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_ufs_phy_unipro_core_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_ufs_phy_unipro_core_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2773,8 +2773,8 @@ static struct clk_branch gcc_usb30_prim_master_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb30_prim_master_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_usb30_prim_master_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_usb30_prim_master_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2791,8 +2791,8 @@ static struct clk_branch gcc_usb30_prim_mock_utmi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb30_prim_mock_utmi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_usb30_prim_mock_utmi_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_usb30_prim_mock_utmi_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2822,8 +2822,8 @@ static struct clk_branch gcc_usb30_sec_master_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb30_sec_master_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_usb30_sec_master_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_usb30_sec_master_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2840,8 +2840,8 @@ static struct clk_branch gcc_usb30_sec_mock_utmi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb30_sec_mock_utmi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_usb30_sec_mock_utmi_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_usb30_sec_mock_utmi_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2884,8 +2884,8 @@ static struct clk_branch gcc_usb3_prim_phy_aux_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb3_prim_phy_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2902,8 +2902,8 @@ static struct clk_branch gcc_usb3_prim_phy_com_aux_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb3_prim_phy_com_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2945,8 +2945,8 @@ static struct clk_branch gcc_usb3_sec_phy_aux_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb3_sec_phy_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_usb3_sec_phy_aux_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_usb3_sec_phy_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2963,8 +2963,8 @@ static struct clk_branch gcc_usb3_sec_phy_com_aux_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb3_sec_phy_com_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_usb3_sec_phy_aux_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_usb3_sec_phy_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -3008,8 +3008,8 @@ static struct clk_branch gcc_vdda_vs_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_vdda_vs_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_vsensor_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_vsensor_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -3026,8 +3026,8 @@ static struct clk_branch gcc_vddcx_vs_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_vddcx_vs_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_vsensor_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_vsensor_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -3044,8 +3044,8 @@ static struct clk_branch gcc_vddmx_vs_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_vddmx_vs_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_vsensor_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_vsensor_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -3120,8 +3120,8 @@ static struct clk_branch gcc_vs_ctrl_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_vs_ctrl_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_vs_ctrl_clk_src.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.hw = &gcc_vs_ctrl_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
-- 
2.34.3

