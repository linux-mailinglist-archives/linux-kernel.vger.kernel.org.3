Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7897858151A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiGZOXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbiGZOXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:23:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E67427CC6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:23:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d8so20293570wrp.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iN4g8Q0MhfeR/u597UBROPVWFRobvvZk7geE/5YXWMo=;
        b=AmybggQ/afwLbYKutEwikc3w0YLeHJQvVO81EIa5bCBowVO0mViSM+LX8xqbgeCwLc
         4G2OkRdKPPUQtonPOAkYMx0+0V6oyBKvP/9+1UgTyl2GA3fWu1ZJ0ETAcqwf+ybIIrjK
         OiSj+VD5HtJjH3W2qYldwcTZGjVtVHAKeH9bd2//J7r9FKhG1CIBsXoJUqkEuWLOhQax
         8miUjFDD/jMfUW6ZmRxS3wyCA+5LQvWq1ZuGVNzl1+nn+6qNHZgkPFnBGbuIwo6w3jCb
         jD3VmWu15x6xA2Az+bv1TvTKjwnGgVbVBslli8NBtF7xqm2e34wD79JaLQDIMele9cxY
         Y4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iN4g8Q0MhfeR/u597UBROPVWFRobvvZk7geE/5YXWMo=;
        b=FT29Pe98SCxyVn+Rh+/4WkprHrJVLSaayPGR619nXUKREsmsSh8nAW3MpMEuZpKcuH
         PEyK7k5EsvgE53OCA/EXlGxI/HUk40A3KW6w7v7P8L1BCk5XT/qsj3g/Xj3NJ0LeLqQ9
         qL2wM7feSaoUsLvtZqFCuVUU1No7cdpkjnf2+pOmy5mQ6Y2Yl0bhOUqitGUluvLCTk6j
         TDUSTBPsjl62NkFAMGfenq9BVw671nHjCzmrC66hMXD0zQN/vIz/vlYxq9LEY6jYPQr+
         p/lqUW+v0995zQS8pZZ1xeBCckcIZ5iFTrAx0SV5Raykpupin8E784ThNra2sZSbVaYy
         ErkQ==
X-Gm-Message-State: AJIora8DHU/gOM+FMeyh/yvU+lnK9rgcvVhFPw+bnqTvxYEdeLVsgQ/J
        tHDM59pwcqbRih/2E4TQL75M3Q==
X-Google-Smtp-Source: AGRyM1tov4IGbHdLhoHIVZ1JTGggwsyOjMaENX4QMjzTNb/yYyfyp9LzGNuW+Pxx31lkOrgMF6dd+g==
X-Received: by 2002:adf:ea8c:0:b0:21e:463e:7480 with SMTP id s12-20020adfea8c000000b0021e463e7480mr11131837wrm.171.1658845423762;
        Tue, 26 Jul 2022 07:23:43 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t21-20020a1c7715000000b003a331c6bffdsm17017119wmi.47.2022.07.26.07.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:23:43 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC 1/9] clk: qcom: qcc-sdm845: Collapse gdsc structs into macros
Date:   Tue, 26 Jul 2022 17:22:55 +0300
Message-Id: <20220726142303.4126434-2-abel.vesa@linaro.org>
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

Collapse gdsc structs definitions into macros to make them
more compact visually.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 129 ++++------------------------------
 drivers/clk/qcom/gdsc.h       |  10 +++
 2 files changed, 23 insertions(+), 116 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 58aa3ec9a7fc..8529e9c8c90c 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3191,122 +3191,19 @@ static struct clk_branch gcc_lpass_sway_clk = {
 };
 #endif
 
-static struct gdsc pcie_0_gdsc = {
-	.gdscr = 0x6b004,
-	.pd = {
-		.name = "pcie_0_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
-};
-
-static struct gdsc pcie_1_gdsc = {
-	.gdscr = 0x8d004,
-	.pd = {
-		.name = "pcie_1_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
-};
-
-static struct gdsc ufs_card_gdsc = {
-	.gdscr = 0x75004,
-	.pd = {
-		.name = "ufs_card_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
-};
-
-static struct gdsc ufs_phy_gdsc = {
-	.gdscr = 0x77004,
-	.pd = {
-		.name = "ufs_phy_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
-};
-
-static struct gdsc usb30_prim_gdsc = {
-	.gdscr = 0xf004,
-	.pd = {
-		.name = "usb30_prim_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
-};
-
-static struct gdsc usb30_sec_gdsc = {
-	.gdscr = 0x10004,
-	.pd = {
-		.name = "usb30_sec_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
-};
-
-static struct gdsc hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc = {
-	.gdscr = 0x7d030,
-	.pd = {
-		.name = "hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
-};
-
-static struct gdsc hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc = {
-	.gdscr = 0x7d03c,
-	.pd = {
-		.name = "hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
-};
-
-static struct gdsc hlos1_vote_aggre_noc_mmu_tbu1_gdsc = {
-	.gdscr = 0x7d034,
-	.pd = {
-		.name = "hlos1_vote_aggre_noc_mmu_tbu1_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
-};
-
-static struct gdsc hlos1_vote_aggre_noc_mmu_tbu2_gdsc = {
-	.gdscr = 0x7d038,
-	.pd = {
-		.name = "hlos1_vote_aggre_noc_mmu_tbu2_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
-};
-
-static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
-	.gdscr = 0x7d040,
-	.pd = {
-		.name = "hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
-};
-
-static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc = {
-	.gdscr = 0x7d048,
-	.pd = {
-		.name = "hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
-};
-
-static struct gdsc hlos1_vote_mmnoc_mmu_tbu_sf_gdsc = {
-	.gdscr = 0x7d044,
-	.pd = {
-		.name = "hlos1_vote_mmnoc_mmu_tbu_sf_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
-};
+DEFINE_QCOM_CC_GDSC(pcie_0_gdsc, 0x6b004, "pcie_0_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
+DEFINE_QCOM_CC_GDSC(pcie_1_gdsc, 0x8d004, "pcie_1_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
+DEFINE_QCOM_CC_GDSC(ufs_card_gdsc, 0x75004, "ufs_card_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
+DEFINE_QCOM_CC_GDSC(ufs_phy_gdsc, 0x77004, "ufs_phy_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
+DEFINE_QCOM_CC_GDSC(usb30_prim_gdsc, 0xf004, "usb30_prim_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
+DEFINE_QCOM_CC_GDSC(usb30_sec_gdsc, 0x10004, "usb30_sec_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
+DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc, 0x7d030, "hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc", PWRSTS_OFF_ON, VOTABLE);
+DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc, 0x7d03c, "hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc", PWRSTS_OFF_ON, VOTABLE);
+DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_tbu1_gdsc, 0x7d034, "hlos1_vote_aggre_noc_mmu_tbu1_gdsc", PWRSTS_OFF_ON, VOTABLE);
+DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_tbu2_gdsc, 0x7d038, "hlos1_vote_aggre_noc_mmu_tbu2_gdsc", PWRSTS_OFF_ON, VOTABLE);
+DEFINE_QCOM_CC_GDSC(hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc, 0x7d040, "hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc", PWRSTS_OFF_ON, VOTABLE);
+DEFINE_QCOM_CC_GDSC(hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc, 0x7d048, "hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc", PWRSTS_OFF_ON, VOTABLE);
+DEFINE_QCOM_CC_GDSC(hlos1_vote_mmnoc_mmu_tbu_sf_gdsc, 0x7d044, "hlos1_vote_mmnoc_mmu_tbu_sf_gdsc", PWRSTS_OFF_ON, VOTABLE);
 
 static struct clk_regmap *gcc_sdm845_clocks[] = {
 	[GCC_AGGRE_NOC_PCIE_TBU_CLK] = &gcc_aggre_noc_pcie_tbu_clk.clkr,
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 5de48c9439b2..c0e616b49dee 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -78,6 +78,16 @@ struct gdsc_desc {
 	size_t num;
 };
 
+#define DEFINE_QCOM_CC_GDSC(_name, _gdscr, _pd_name, _pwrsts, _flags) \
+	static struct gdsc _name = {			\
+		.gdscr = _gdscr,		\
+		.pd = {				\
+			.name = _pd_name,	\
+		},				\
+		.pwrsts = _pwrsts,		\
+		.flags = _flags,		\
+	}
+
 #ifdef CONFIG_QCOM_GDSC
 int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
 		  struct regmap *);
-- 
2.34.3

