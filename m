Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA153AF0C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiFAVjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiFAVje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:39:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB866139C96;
        Wed,  1 Jun 2022 14:39:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id rs12so6292573ejb.13;
        Wed, 01 Jun 2022 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMI0G6b7H83URAs1uvPb0cf5xzD2hQoldLlbC7p/ZWE=;
        b=XYKXwANgXigdlE3LxUNHWAIUOFrW9IRBMeTPHi3liiMI5bs69k4gtxIwmzRwx2b2ZK
         K58fc9g+0NrFsocsPptLlSKyas39eSPpR5EFcd1fQ8CiLPMtdO4lXjU0vZPKJysh9Ena
         Zzm0kUrPIn8VCj+d+QmIrHO4Uxh4rSbek71ykgtKnyasxmjfLY5jIjfzukmZutdBzmMb
         QdcKUw3sJVVqY8dfa8M8HGjFxS3XsG14U00BXoQspwPbeU0keqWIz+lCxv0XzmYtHgrk
         HCIiTdHIrQQAqe/9ZWtUzzeMDpqk62RwC7u6bjOeglOMFIpWiIj8BH/nlc5NmY5ZKU50
         iweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMI0G6b7H83URAs1uvPb0cf5xzD2hQoldLlbC7p/ZWE=;
        b=KQB6CyxfD9gNCjx6ed+vTN/85w9aASUILfcX3XbHntSgPVvmvJIugzi0d4Gjsry00P
         Yyyv8uySRD3TRUjY6rGKKQIYlmX5+2jyRi1T5NmuEuTAdyU+XMheT/oR+FYJD6FOoyWE
         I45rS1HPitd10nT92M1kPpSCSrRa14cgXG/RcYJxcNF5pmLNFlzMh0/8GXlJ5ZzT3oUu
         NPT41Vbd2ZvLHtcE2oq9An6f6Kj5kVqynSDf+D6teh/gkChbq/U4p1eCa7D8XL9yYTq0
         AmFSP75Z8/HhWqhoQ8qM8H9pS4ZeeqVmQcYv7P5WpaDfq5EMeWkzhk2AeXJVAO9ZT/Ge
         Anig==
X-Gm-Message-State: AOAM530deN81kfgeAuOe7kNHEMupvMwAObBFeJl2Ah3y6inJmGRN/ZzD
        5//thZZ/nZ/rpN2ucdxVttrHvzRc/Cga4dYR
X-Google-Smtp-Source: ABdhPJwxPIg/VcXVW/nHyd7ZMkDjh2//Xu460dJc9dLv4GkIXduVYWH78/0tfvCT+tkknbjvXB/i9g==
X-Received: by 2002:a17:906:9751:b0:6fe:ed24:ef48 with SMTP id o17-20020a170906975100b006feed24ef48mr1417823ejy.414.1654119571479;
        Wed, 01 Jun 2022 14:39:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id a14-20020a170906368e00b006fec5cef701sm1099080ejc.197.2022.06.01.14.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:39:30 -0700 (PDT)
From:   David Virag <virag.david003@gmail.com>
Cc:     phone-devel@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] clk: samsung: exynos7885: Add TREX clocks
Date:   Thu,  2 Jun 2022 01:37:42 +0200
Message-Id: <20220601233743.56317-5-virag.david003@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601233743.56317-1-virag.david003@gmail.com>
References: <20220601233743.56317-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TREX D Core and P core clocks seem to be related to the BTS (Bus Traffic
Shaper) inside the Exynos7885 SoC, and are needed for the SoC to
function correctly.

When clocks are cut from TREX D Core, the eMMC and the framebuffer stops
working properly. Other unknown things may stop working as well.

When clocks are cut from TREX P Core, the system locks up needing a hard
reset.

Add these clocks and mark them critical so that they are always on.

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 drivers/clk/samsung/clk-exynos7885.c | 49 ++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
index 302937025409..0d2a950ed184 100644
--- a/drivers/clk/samsung/clk-exynos7885.c
+++ b/drivers/clk/samsung/clk-exynos7885.c
@@ -571,13 +571,20 @@ CLK_OF_DECLARE(exynos7885_cmu_peri, "samsung,exynos7885-cmu-peri",
 /* ---- CMU_CORE ------------------------------------------------------------ */
 
 /* Register Offset definitions for CMU_CORE (0x12000000) */
-#define PLL_CON0_MUX_CLKCMU_CORE_BUS_USER	0x0100
-#define PLL_CON0_MUX_CLKCMU_CORE_CCI_USER	0x0120
-#define PLL_CON0_MUX_CLKCMU_CORE_G3D_USER	0x0140
-#define CLK_CON_MUX_MUX_CLK_CORE_GIC		0x1000
-#define CLK_CON_DIV_DIV_CLK_CORE_BUSP		0x1800
-#define CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK	0x2054
-#define CLK_CON_GAT_GOUT_CORE_GIC400_CLK	0x2058
+#define PLL_CON0_MUX_CLKCMU_CORE_BUS_USER		0x0100
+#define PLL_CON0_MUX_CLKCMU_CORE_CCI_USER		0x0120
+#define PLL_CON0_MUX_CLKCMU_CORE_G3D_USER		0x0140
+#define CLK_CON_MUX_MUX_CLK_CORE_GIC			0x1000
+#define CLK_CON_DIV_DIV_CLK_CORE_BUSP			0x1800
+#define CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK		0x2054
+#define CLK_CON_GAT_GOUT_CORE_GIC400_CLK		0x2058
+#define CLK_CON_GAT_GOUT_CORE_TREX_D_CORE_ACLK		0x215c
+#define CLK_CON_GAT_GOUT_CORE_TREX_D_CORE_GCLK		0x2160
+#define CLK_CON_GAT_GOUT_CORE_TREX_D_CORE_PCLK		0x2164
+#define CLK_CON_GAT_GOUT_CORE_TREX_P_CORE_ACLK_P_CORE	0x2168
+#define CLK_CON_GAT_GOUT_CORE_TREX_P_CORE_CCLK_P_CORE	0x216c
+#define CLK_CON_GAT_GOUT_CORE_TREX_P_CORE_PCLK		0x2170
+#define CLK_CON_GAT_GOUT_CORE_TREX_P_CORE_PCLK_P_CORE	0x2174
 
 static const unsigned long core_clk_regs[] __initconst = {
 	PLL_CON0_MUX_CLKCMU_CORE_BUS_USER,
@@ -587,6 +594,13 @@ static const unsigned long core_clk_regs[] __initconst = {
 	CLK_CON_DIV_DIV_CLK_CORE_BUSP,
 	CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK,
 	CLK_CON_GAT_GOUT_CORE_GIC400_CLK,
+	CLK_CON_GAT_GOUT_CORE_TREX_D_CORE_ACLK,
+	CLK_CON_GAT_GOUT_CORE_TREX_D_CORE_GCLK,
+	CLK_CON_GAT_GOUT_CORE_TREX_D_CORE_PCLK,
+	CLK_CON_GAT_GOUT_CORE_TREX_P_CORE_ACLK_P_CORE,
+	CLK_CON_GAT_GOUT_CORE_TREX_P_CORE_CCLK_P_CORE,
+	CLK_CON_GAT_GOUT_CORE_TREX_P_CORE_PCLK,
+	CLK_CON_GAT_GOUT_CORE_TREX_P_CORE_PCLK_P_CORE,
 };
 
 /* List of parent clocks for Muxes in CMU_CORE */
@@ -618,6 +632,27 @@ static const struct samsung_gate_clock core_gate_clks[] __initconst = {
 	/* GIC (interrupt controller) clock must be always running */
 	GATE(CLK_GOUT_GIC400_CLK, "gout_gic400_clk", "mout_core_gic",
 	     CLK_CON_GAT_GOUT_CORE_GIC400_CLK, 21, CLK_IS_CRITICAL, 0),
+	/*
+	 * TREX D and P Core (seems to be related to "bus traffic shaper")
+	 * clocks must always be running
+	 */
+	GATE(CLK_GOUT_TREX_D_CORE_ACLK, "gout_trex_d_core_aclk", "mout_core_bus_user",
+	     CLK_CON_GAT_GOUT_CORE_TREX_D_CORE_ACLK, 21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_TREX_D_CORE_GCLK, "gout_trex_d_core_gclk", "mout_core_g3d_user",
+	     CLK_CON_GAT_GOUT_CORE_TREX_D_CORE_GCLK, 21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_TREX_D_CORE_PCLK, "gout_trex_d_core_pclk", "dout_core_busp",
+	     CLK_CON_GAT_GOUT_CORE_TREX_D_CORE_PCLK, 21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_TREX_P_CORE_ACLK_P_CORE, "gout_trex_p_core_aclk_p_core",
+	     "mout_core_bus_user", CLK_CON_GAT_GOUT_CORE_TREX_P_CORE_ACLK_P_CORE, 21,
+	     CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_TREX_P_CORE_CCLK_P_CORE, "gout_trex_p_core_cclk_p_core",
+	     "mout_core_cci_user", CLK_CON_GAT_GOUT_CORE_TREX_P_CORE_CCLK_P_CORE, 21,
+	     CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_TREX_P_CORE_PCLK, "gout_trex_p_core_pclk", "dout_core_busp",
+	     CLK_CON_GAT_GOUT_CORE_TREX_P_CORE_PCLK, 21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_TREX_P_CORE_PCLK_P_CORE, "gout_trex_p_core_pclk_p_core",
+	     "dout_core_busp", CLK_CON_GAT_GOUT_CORE_TREX_P_CORE_PCLK_P_CORE, 21,
+	     CLK_IS_CRITICAL, 0),
 };
 
 static const struct samsung_cmu_info core_cmu_info __initconst = {
-- 
2.36.1

