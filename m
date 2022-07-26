Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F119581514
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbiGZOYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbiGZOX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:23:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D6827CE8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:23:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m17so20102859wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7i/uQ3DjdzEQt9s+bjB4ZzmhQ5Ksdu2J2iSUOzx3xk=;
        b=VlExN11m/xKEq6RFZyFwqCm718lldPuvAc6HVpMi/5/h+DaMSpAhxFoFZm9wlYWdPC
         mLYeO1btAPFHCLtM7JyiqDazfmfAGvy5D/cAgiHpn43q/LtdojNgYcFFgk3MnXkPLU72
         94v/39sulSTDebkiaJcZVRSmeFNjAFVukmwsLTdrK5Ev/RZaLBPl2RTnKUOahSOLgGqo
         djalSCBUaASFFHxGVkZLI64jWZO21/hNI4FjQBfJpziVfgjY2M+L4mvRThOwsvkHY3ej
         hPha7ITJyh7tAyJd+wRGByWeL2B+ITLqvuHYIIpcru0mSWp6ygP4W5Df1uQR7nUQ67Rx
         3o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7i/uQ3DjdzEQt9s+bjB4ZzmhQ5Ksdu2J2iSUOzx3xk=;
        b=76E6oNw4GR6gDY+o2syX9x2XD6TO2rdOz/v1tRVOCRBgeFfMG//7GORnIqPdsdfuw3
         ylBFD7KNgTZ+jDZ+3kBOr74pcKSIZgaVdxps1VA+ArcFyYyQjB/SR3AlD+KXCa3Ya5bi
         jjs1fWgmmQC0JeB8zSRKhhlrpo4e5kOHZ+HAZz+bTjNy3ZclEZYcvFj8IGXNJfV2pdj2
         tZ4ra9RUDbjuEa1vSPlWM+Jeh8LqAMHFB/zcN9Fgn22/NXFj/tQVk1dY5Yn8KvA5tA55
         fS3PLIyh0CGCiY8rNaMEVMcQ3xfxvQLa3MZ7fIIbYrDAPsfu9k0ym3up1jeJS3qvEFF2
         T3AQ==
X-Gm-Message-State: AJIora+/lG6Rnxh19kHDNHOz77zq3dcj2RQMUY+0acPhU7MEm87bcZP2
        bEla65qo8SWv6jDADJw8590UiQ==
X-Google-Smtp-Source: AGRyM1ssWbDVP8KtCaTsELE8oiR0zedtzDuwa0zZbYxnUqO2A7hPAE4VoEG8Bq55+p6xbz4rS1+xtQ==
X-Received: by 2002:a05:6000:18af:b0:21d:93a5:2d2 with SMTP id b15-20020a05600018af00b0021d93a502d2mr10909154wri.301.1658845433165;
        Tue, 26 Jul 2022 07:23:53 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t21-20020a1c7715000000b003a331c6bffdsm17017119wmi.47.2022.07.26.07.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:23:52 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC 8/9] clk: qcom: gcc-sdm845: Switch to macros to collapse rcg2 clocks definitions
Date:   Tue, 26 Jul 2022 17:23:02 +0300
Message-Id: <20220726142303.4126434-9-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220726142303.4126434-1-abel.vesa@linaro.org>
References: <20220726142303.4126434-1-abel.vesa@linaro.org>
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

Switch from the expanded rcg2 clocks definitions to the more compact
macros.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 712 +++-------------------------------
 1 file changed, 51 insertions(+), 661 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 2e66256599d3..d9751d7e617c 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -200,39 +200,11 @@ static const struct freq_tbl ftbl_gcc_cpuss_ahb_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
-	.cmd_rcgr = 0x48014,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_cpuss_ahb_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_cpuss_ahb_clk_src",
-		.parent_data = gcc_parent_data_7_ao,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_7_ao),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_cpuss_rbcpr_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	{ }
 };
 
-static struct clk_rcg2 gcc_cpuss_rbcpr_clk_src = {
-	.cmd_rcgr = 0x4815c,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_3,
-	.freq_tbl = ftbl_gcc_cpuss_rbcpr_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_cpuss_rbcpr_clk_src",
-		.parent_data = gcc_parent_data_8_ao,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_8_ao),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(25000000, P_GPLL0_OUT_EVEN, 12, 0, 0),
@@ -242,102 +214,18 @@ static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_gp1_clk_src = {
-	.cmd_rcgr = 0x64004,
-	.mnd_width = 8,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_1,
-	.freq_tbl = ftbl_gcc_gp1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_gp1_clk_src",
-		.parent_data = gcc_parent_data_1,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_rcg2 gcc_gp2_clk_src = {
-	.cmd_rcgr = 0x65004,
-	.mnd_width = 8,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_1,
-	.freq_tbl = ftbl_gcc_gp1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_gp2_clk_src",
-		.parent_data = gcc_parent_data_1,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_rcg2 gcc_gp3_clk_src = {
-	.cmd_rcgr = 0x66004,
-	.mnd_width = 8,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_1,
-	.freq_tbl = ftbl_gcc_gp1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_gp3_clk_src",
-		.parent_data = gcc_parent_data_1,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_pcie_0_aux_clk_src[] = {
 	F(9600000, P_BI_TCXO, 2, 0, 0),
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	{ }
 };
 
-static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
-	.cmd_rcgr = 0x6b028,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_2,
-	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_pcie_0_aux_clk_src",
-		.parent_data = gcc_parent_data_2,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_rcg2 gcc_pcie_1_aux_clk_src = {
-	.cmd_rcgr = 0x8d028,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_2,
-	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_pcie_1_aux_clk_src",
-		.parent_data = gcc_parent_data_2,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_pcie_phy_refgen_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
 	{ }
 };
 
-static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src = {
-	.cmd_rcgr = 0x6f014,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_pcie_phy_refgen_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_pcie_phy_refgen_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_qspi_core_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
@@ -346,20 +234,6 @@ static const struct freq_tbl ftbl_gcc_qspi_core_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_qspi_core_clk_src = {
-	.cmd_rcgr = 0x4b008,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qspi_core_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_qspi_core_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_floor_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
 	F(9600000, P_BI_TCXO, 2, 0, 0),
 	F(19200000, P_BI_TCXO, 1, 0, 0),
@@ -367,20 +241,6 @@ static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_pdm2_clk_src = {
-	.cmd_rcgr = 0x33010,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_pdm2_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_pdm2_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 	F(7372800, P_GPLL0_OUT_EVEN, 1, 384, 15625),
 	F(14745600, P_GPLL0_OUT_EVEN, 1, 768, 15625),
@@ -400,262 +260,6 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 	{ }
 };
 
-static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
-	.name = "gcc_qupv3_wrap0_s0_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
-	.cmd_rcgr = 0x17034,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap0_s0_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
-	.name = "gcc_qupv3_wrap0_s1_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
-	.cmd_rcgr = 0x17164,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap0_s1_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
-	.name = "gcc_qupv3_wrap0_s2_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
-	.cmd_rcgr = 0x17294,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap0_s2_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
-	.name = "gcc_qupv3_wrap0_s3_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
-	.cmd_rcgr = 0x173c4,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap0_s3_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
-	.name = "gcc_qupv3_wrap0_s4_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
-	.cmd_rcgr = 0x174f4,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap0_s4_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
-	.name = "gcc_qupv3_wrap0_s5_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
-	.cmd_rcgr = 0x17624,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap0_s5_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap0_s6_clk_src_init = {
-	.name = "gcc_qupv3_wrap0_s6_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
-	.cmd_rcgr = 0x17754,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap0_s6_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap0_s7_clk_src_init = {
-	.name = "gcc_qupv3_wrap0_s7_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
-	.cmd_rcgr = 0x17884,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap0_s7_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
-	.name = "gcc_qupv3_wrap1_s0_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
-	.cmd_rcgr = 0x18018,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap1_s0_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
-	.name = "gcc_qupv3_wrap1_s1_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
-	.cmd_rcgr = 0x18148,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap1_s1_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
-	.name = "gcc_qupv3_wrap1_s2_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
-	.cmd_rcgr = 0x18278,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap1_s2_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
-	.name = "gcc_qupv3_wrap1_s3_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
-	.cmd_rcgr = 0x183a8,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap1_s3_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
-	.name = "gcc_qupv3_wrap1_s4_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
-	.cmd_rcgr = 0x184d8,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap1_s4_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
-	.name = "gcc_qupv3_wrap1_s5_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
-	.cmd_rcgr = 0x18608,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap1_s5_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap1_s6_clk_src_init = {
-	.name = "gcc_qupv3_wrap1_s6_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
-	.cmd_rcgr = 0x18738,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap1_s6_clk_src_init,
-};
-
-static struct clk_init_data gcc_qupv3_wrap1_s7_clk_src_init = {
-	.name = "gcc_qupv3_wrap1_s7_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
-};
-
-static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
-	.cmd_rcgr = 0x18868,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init = &gcc_qupv3_wrap1_s7_clk_src_init,
-};
-
 static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	F(400000, P_BI_TCXO, 12, 1, 4),
 	F(9600000, P_BI_TCXO, 2, 0, 0),
@@ -667,20 +271,6 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
-	.cmd_rcgr = 0x1400c,
-	.mnd_width = 8,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_10,
-	.freq_tbl = ftbl_gcc_sdcc2_apps_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_sdcc2_apps_clk_src",
-		.parent_data = gcc_parent_data_10,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_10),
-		.ops = &clk_rcg2_floor_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_sdcc4_apps_clk_src[] = {
 	F(400000, P_BI_TCXO, 12, 1, 4),
 	F(9600000, P_BI_TCXO, 2, 0, 0),
@@ -691,39 +281,11 @@ static const struct freq_tbl ftbl_gcc_sdcc4_apps_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
-	.cmd_rcgr = 0x1600c,
-	.mnd_width = 8,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_sdcc4_apps_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_floor_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_tsif_ref_clk_src[] = {
 	F(105495, P_BI_TCXO, 2, 1, 91),
 	{ }
 };
 
-static struct clk_rcg2 gcc_tsif_ref_clk_src = {
-	.cmd_rcgr = 0x36010,
-	.mnd_width = 8,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_6,
-	.freq_tbl = ftbl_gcc_tsif_ref_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_tsif_ref_clk_src",
-		.parent_data = gcc_parent_data_6,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_6),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_ufs_card_axi_clk_src[] = {
 	F(25000000, P_GPLL0_OUT_EVEN, 12, 0, 0),
 	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
@@ -733,20 +295,6 @@ static const struct freq_tbl ftbl_gcc_ufs_card_axi_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_ufs_card_axi_clk_src = {
-	.cmd_rcgr = 0x7501c,
-	.mnd_width = 8,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_ufs_card_axi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_ufs_card_axi_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_ufs_card_ice_core_clk_src[] = {
 	F(37500000, P_GPLL0_OUT_EVEN, 8, 0, 0),
 	F(75000000, P_GPLL0_OUT_EVEN, 4, 0, 0),
@@ -755,34 +303,6 @@ static const struct freq_tbl ftbl_gcc_ufs_card_ice_core_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_ufs_card_ice_core_clk_src = {
-	.cmd_rcgr = 0x7505c,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_ufs_card_ice_core_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_ufs_card_ice_core_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
-static struct clk_rcg2 gcc_ufs_card_phy_aux_clk_src = {
-	.cmd_rcgr = 0x75090,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_4,
-	.freq_tbl = ftbl_gcc_cpuss_rbcpr_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_ufs_card_phy_aux_clk_src",
-		.parent_data = gcc_parent_data_4,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_ufs_card_unipro_core_clk_src[] = {
 	F(37500000, P_GPLL0_OUT_EVEN, 8, 0, 0),
 	F(75000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
@@ -790,20 +310,6 @@ static const struct freq_tbl ftbl_gcc_ufs_card_unipro_core_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_ufs_card_unipro_core_clk_src = {
-	.cmd_rcgr = 0x75074,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_ufs_card_unipro_core_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_ufs_card_unipro_core_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
 	F(25000000, P_GPLL0_OUT_EVEN, 12, 0, 0),
 	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
@@ -813,62 +319,6 @@ static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
-	.cmd_rcgr = 0x7701c,
-	.mnd_width = 8,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_ufs_phy_axi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_ufs_phy_axi_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
-static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
-	.cmd_rcgr = 0x7705c,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_ufs_card_ice_core_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_ufs_phy_ice_core_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
-static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
-	.cmd_rcgr = 0x77090,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_4,
-	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_ufs_phy_phy_aux_clk_src",
-		.parent_data = gcc_parent_data_4,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
-static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
-	.cmd_rcgr = 0x77074,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_ufs_card_unipro_core_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_ufs_phy_unipro_core_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	F(33333333, P_GPLL0_OUT_EVEN, 9, 0, 0),
 	F(66666667, P_GPLL0_OUT_EVEN, 4.5, 0, 0),
@@ -878,20 +328,6 @@ static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
-	.cmd_rcgr = 0xf018,
-	.mnd_width = 8,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_usb30_prim_master_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_usb30_prim_master_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_usb30_prim_mock_utmi_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(20000000, P_GPLL0_OUT_EVEN, 15, 0, 0),
@@ -900,90 +336,6 @@ static const struct freq_tbl ftbl_gcc_usb30_prim_mock_utmi_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
-	.cmd_rcgr = 0xf030,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_usb30_prim_mock_utmi_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
-static struct clk_rcg2 gcc_usb30_sec_master_clk_src = {
-	.cmd_rcgr = 0x10018,
-	.mnd_width = 8,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_usb30_prim_master_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_usb30_sec_master_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_rcg2 gcc_usb30_sec_mock_utmi_clk_src = {
-	.cmd_rcgr = 0x10030,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_usb30_sec_mock_utmi_clk_src",
-		.parent_data = gcc_parent_data_0,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
-	.cmd_rcgr = 0xf05c,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_2,
-	.freq_tbl = ftbl_gcc_cpuss_rbcpr_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_usb3_prim_phy_aux_clk_src",
-		.parent_data = gcc_parent_data_2,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_rcg2 gcc_usb3_sec_phy_aux_clk_src = {
-	.cmd_rcgr = 0x1005c,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_2,
-	.freq_tbl = ftbl_gcc_cpuss_rbcpr_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_usb3_sec_phy_aux_clk_src",
-		.parent_data = gcc_parent_data_2,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
-static struct clk_rcg2 gcc_vs_ctrl_clk_src = {
-	.cmd_rcgr = 0x7a030,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_3,
-	.freq_tbl = ftbl_gcc_cpuss_rbcpr_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_vs_ctrl_clk_src",
-		.parent_data = gcc_parent_data_3,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_vsensor_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
@@ -991,19 +343,57 @@ static const struct freq_tbl ftbl_gcc_vsensor_clk_src[] = {
 	{ }
 };
 
-static struct clk_rcg2 gcc_vsensor_clk_src = {
-	.cmd_rcgr = 0x7a018,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_3,
-	.freq_tbl = ftbl_gcc_vsensor_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_vsensor_clk_src",
-		.parent_data = gcc_parent_data_8,
-		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
-		.ops = &clk_rcg2_ops,
-	},
-};
+DEFINE_QCOM_CC_CLK(RCG2, gcc_cpuss_ahb_clk_src, 0x48014, 0, 5, gcc_parent_map_0, ftbl_gcc_cpuss_ahb_clk_src, gcc_parent_data_7_ao);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_cpuss_rbcpr_clk_src, 0x4815c, 0, 5, gcc_parent_map_3, ftbl_gcc_cpuss_rbcpr_clk_src, gcc_parent_data_8_ao);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_gp1_clk_src, 0x64004, 8, 5, gcc_parent_map_1, ftbl_gcc_gp1_clk_src, gcc_parent_data_1);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_gp2_clk_src, 0x65004, 8, 5, gcc_parent_map_1, ftbl_gcc_gp1_clk_src, gcc_parent_data_1);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_gp3_clk_src, 0x6b028, 8, 5, gcc_parent_map_1, ftbl_gcc_gp1_clk_src, gcc_parent_data_1);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_pcie_0_aux_clk_src, 0x6b028, 16, 5, gcc_parent_map_2, ftbl_gcc_pcie_0_aux_clk_src, gcc_parent_data_2);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_pcie_1_aux_clk_src, 0x8d028, 16, 5, gcc_parent_map_2, ftbl_gcc_pcie_0_aux_clk_src, gcc_parent_data_2);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_pcie_phy_refgen_clk_src, 0x6f014, 0, 5, gcc_parent_map_0, ftbl_gcc_pcie_phy_refgen_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_FLOOR, gcc_qspi_core_clk_src, 0x4b008, 0, 5, gcc_parent_map_0, ftbl_gcc_qspi_core_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_pdm2_clk_src, 0x33010, 0, 5, gcc_parent_map_0, ftbl_gcc_pdm2_clk_src, gcc_parent_data_0);
+
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap0_s0_clk_src, 0x17034, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap0_s1_clk_src, 0x17164, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap0_s2_clk_src, 0x17294, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap0_s3_clk_src, 0x173c4, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap0_s4_clk_src, 0x174f4, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap0_s5_clk_src, 0x17624, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap0_s6_clk_src, 0x17754, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap0_s7_clk_src, 0x17884, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap1_s0_clk_src, 0x18018, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap1_s1_clk_src, 0x18148, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap1_s2_clk_src, 0x18278, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap1_s3_clk_src, 0x183a8, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap1_s4_clk_src, 0x184d8, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap1_s5_clk_src, 0x18608, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap1_s6_clk_src, 0x18738, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_qupv3_wrap1_s7_clk_src, 0x18868, 16, 5, gcc_parent_map_0, ftbl_gcc_qupv3_wrap0_s0_clk_src, gcc_parent_data_0);
+
+DEFINE_QCOM_CC_CLK(RCG2_FLOOR, gcc_sdcc2_apps_clk_src, 0x1400c, 8, 5, gcc_parent_map_10, ftbl_gcc_sdcc2_apps_clk_src, gcc_parent_data_10);
+DEFINE_QCOM_CC_CLK(RCG2_FLOOR, gcc_sdcc4_apps_clk_src, 0x1600c, 8, 5, gcc_parent_map_0, ftbl_gcc_sdcc4_apps_clk_src, gcc_parent_data_0);
+
+DEFINE_QCOM_CC_CLK(RCG2, gcc_tsif_ref_clk_src, 0x36010, 8, 5, gcc_parent_map_6, ftbl_gcc_tsif_ref_clk_src, gcc_parent_data_6);
+
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_ufs_card_axi_clk_src, 0x7501c, 8, 5, gcc_parent_map_0, ftbl_gcc_ufs_card_axi_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_ufs_card_ice_core_clk_src, 0x7505c, 0, 5, gcc_parent_map_0, ftbl_gcc_ufs_card_ice_core_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_ufs_card_phy_aux_clk_src, 0x75090, 0, 5, gcc_parent_map_4, ftbl_gcc_cpuss_rbcpr_clk_src, gcc_parent_data_4);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_ufs_card_unipro_core_clk_src, 0x75074, 0, 5, gcc_parent_map_0, ftbl_gcc_ufs_card_unipro_core_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_ufs_phy_axi_clk_src, 0x7701c, 8, 5, gcc_parent_map_0, ftbl_gcc_ufs_phy_axi_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_ufs_phy_ice_core_clk_src, 0x7705c, 0, 5, gcc_parent_map_0, ftbl_gcc_ufs_card_ice_core_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_ufs_phy_phy_aux_clk_src, 0x77090, 0, 5, gcc_parent_map_4, ftbl_gcc_pcie_0_aux_clk_src, gcc_parent_data_4);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_ufs_phy_unipro_core_clk_src, 0x77074, 0, 5, gcc_parent_map_0, ftbl_gcc_ufs_card_ice_core_clk_src, gcc_parent_data_0);
+
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_usb30_prim_master_clk_src, 0xf018, 8, 5, gcc_parent_map_0, ftbl_gcc_usb30_prim_master_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_usb30_prim_mock_utmi_clk_src, 0xf030, 8, 5, gcc_parent_map_0, ftbl_gcc_usb30_prim_mock_utmi_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_usb30_sec_master_clk_src, 0x10018, 8, 5, gcc_parent_map_0, ftbl_gcc_usb30_prim_master_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_usb30_sec_mock_utmi_clk_src, 0x10030, 0, 5, gcc_parent_map_0, ftbl_gcc_usb30_prim_master_clk_src, gcc_parent_data_0);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_usb3_prim_phy_aux_clk_src, 0xf05c, 0, 5, gcc_parent_map_2, ftbl_gcc_cpuss_rbcpr_clk_src, gcc_parent_data_2);
+DEFINE_QCOM_CC_CLK(RCG2_SHARED, gcc_usb3_sec_phy_aux_clk_src, 0x1005c, 8, 5, gcc_parent_map_2, ftbl_gcc_cpuss_rbcpr_clk_src, gcc_parent_data_2);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_vs_ctrl_clk_src, 0x7a030, 0, 5, gcc_parent_map_3, ftbl_gcc_cpuss_rbcpr_clk_src, gcc_parent_data_3);
+DEFINE_QCOM_CC_CLK(RCG2, gcc_vsensor_clk_src, 0x7a018, 0, 5, gcc_parent_map_3, ftbl_gcc_vsensor_clk_src, gcc_parent_data_3);
 
 DEFINE_QCOM_CC_CLK(BRANCH, HALT, gcc_aggre_noc_pcie_tbu_clk, 0, 0x90014, 0, 0, 0x90014, BIT(0), 0);
 DEFINE_QCOM_CC_CLK(BRANCH, HALT, gcc_aggre_ufs_card_axi_clk, 1, 0x82028, 0x82028, 1, 0x82028, BIT(0), CLK_SET_RATE_PARENT, &gcc_ufs_card_axi_clk_src.clkr.hw);
-- 
2.34.3

