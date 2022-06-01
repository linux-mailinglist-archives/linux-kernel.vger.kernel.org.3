Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B82353AFC6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiFAVjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiFAVjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:39:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339AF13A2D6;
        Wed,  1 Jun 2022 14:39:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c2so3907963edf.5;
        Wed, 01 Jun 2022 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ki1B0kxCriNipLEik01Dy6t2+shn6WYzhPizpkp6OVw=;
        b=fePmFcKY8w2vXh17LSCA63GZmFzJLhKH3kbwKuiBVnEjT01cCAVz9qb4pT1jQjCci2
         USgt/TvrKr5IFwdm+EoTanHjBtPW3sONQbfRAwlQIydBfcL7dAC/2X0CJXVqeC09cHWE
         X6Z2OFcDcv9zBbNZIWnCzsdVLe854rBYaM2SYtmyd6/KTfP5Zx+IejtApv5JxrCtfLte
         d0YXGLKBVVP+8hLI8SHM0YyUjbYkBKE31EXNXRPDHNQaYDU3SAHFDK4K1ebrcIP/7Hd/
         L5bwpsOe0mXr5krwAHuH+frg5n3c1YlcujzXi7FzHdWBW5MVZ5bt81lwedNpygNmwWow
         Cz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ki1B0kxCriNipLEik01Dy6t2+shn6WYzhPizpkp6OVw=;
        b=Hx7x3K0pFQNZ4c/7Eps4kk/p6pi2VzSaXjahLmLS+xhk8Sc+9T+BpbvsYtWK+/BTbf
         cmJ/m0lMTMTPuqzMNt74g1RMzcKXLQmLan+4bW5ddPyxJZht/l9oRNCkzbVvA/oT55SX
         iFIeqngTFTdmpZR3lM+nHrCDe365jgEMtbpYDc7jZir3GuSDHj6sP5Ig4pRJ9ZhnYbC6
         Ar5Gl6ZyzR7GdkkJS0gvFVJA4LrEqa/VSRZNfCewbPgAOsWTF/PRjmdFJZdlTtcyEy9m
         wK4Irvnd+q59awHhYNCmLSmSfQYoUGskznYTisDb6+CtX7QseKfARvW8oU7hcWRAtaU0
         dQMA==
X-Gm-Message-State: AOAM533VQlZlb7Z3XZpUD/Zxt/qU6kLE+s9qwvjaSuzIM28FO8mDr5Es
        SY6IDM1jorpX275oH+Ly1G5E6pmh3ywFDqMJ
X-Google-Smtp-Source: ABdhPJwQNJZ7Dm/k6oxW4I7fkNM8wChtUhFmnSrgxtH6xFS/qccDiTeHxJxDwrDiQFOzaexllEaETQ==
X-Received: by 2002:a05:6402:2211:b0:42d:cb9e:cbf with SMTP id cq17-20020a056402221100b0042dcb9e0cbfmr2010793edb.76.1654119569694;
        Wed, 01 Jun 2022 14:39:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id a14-20020a170906368e00b006fec5cef701sm1099080ejc.197.2022.06.01.14.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:39:29 -0700 (PDT)
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
Subject: [PATCH 3/5] clk: samsung: exynos7885: Implement CMU_FSYS domain
Date:   Thu,  2 Jun 2022 01:37:41 +0200
Message-Id: <20220601233743.56317-4-virag.david003@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601233743.56317-1-virag.david003@gmail.com>
References: <20220601233743.56317-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMU_FSYS clock domain provides clocks for FSYS IP-core providing clocks
for all MMC devices on Exynos7885, and USB30DRD.

This patch includes:
  - Bus clocks in CMU_TOP needed for CMU_FSYS
  - All clocks in CMU_FSYS needed for MMC devices

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 drivers/clk/samsung/clk-exynos7885.c | 158 +++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
index 368c50badd15..302937025409 100644
--- a/drivers/clk/samsung/clk-exynos7885.c
+++ b/drivers/clk/samsung/clk-exynos7885.c
@@ -27,6 +27,11 @@
 #define CLK_CON_MUX_MUX_CLKCMU_CORE_BUS		0x1014
 #define CLK_CON_MUX_MUX_CLKCMU_CORE_CCI		0x1018
 #define CLK_CON_MUX_MUX_CLKCMU_CORE_G3D		0x101c
+#define CLK_CON_MUX_MUX_CLKCMU_FSYS_BUS		0x1028
+#define CLK_CON_MUX_MUX_CLKCMU_FSYS_MMC_CARD	0x102c
+#define CLK_CON_MUX_MUX_CLKCMU_FSYS_MMC_EMBD	0x1030
+#define CLK_CON_MUX_MUX_CLKCMU_FSYS_MMC_SDIO	0x1034
+#define CLK_CON_MUX_MUX_CLKCMU_FSYS_USB30DRD	0x1038
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_BUS		0x1058
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_SPI0	0x105c
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_SPI1	0x1060
@@ -39,6 +44,11 @@
 #define CLK_CON_DIV_CLKCMU_CORE_BUS		0x181c
 #define CLK_CON_DIV_CLKCMU_CORE_CCI		0x1820
 #define CLK_CON_DIV_CLKCMU_CORE_G3D		0x1824
+#define CLK_CON_DIV_CLKCMU_FSYS_BUS		0x1844
+#define CLK_CON_DIV_CLKCMU_FSYS_MMC_CARD	0x1848
+#define CLK_CON_DIV_CLKCMU_FSYS_MMC_EMBD	0x184c
+#define CLK_CON_DIV_CLKCMU_FSYS_MMC_SDIO	0x1850
+#define CLK_CON_DIV_CLKCMU_FSYS_USB30DRD	0x1854
 #define CLK_CON_DIV_CLKCMU_PERI_BUS		0x1874
 #define CLK_CON_DIV_CLKCMU_PERI_SPI0		0x1878
 #define CLK_CON_DIV_CLKCMU_PERI_SPI1		0x187c
@@ -59,6 +69,11 @@
 #define CLK_CON_GAT_GATE_CLKCMU_CORE_BUS	0x201c
 #define CLK_CON_GAT_GATE_CLKCMU_CORE_CCI	0x2020
 #define CLK_CON_GAT_GATE_CLKCMU_CORE_G3D	0x2024
+#define CLK_CON_GAT_GATE_CLKCMU_FSYS_BUS	0x2044
+#define CLK_CON_GAT_GATE_CLKCMU_FSYS_MMC_CARD	0x2048
+#define CLK_CON_GAT_GATE_CLKCMU_FSYS_MMC_EMBD	0x204c
+#define CLK_CON_GAT_GATE_CLKCMU_FSYS_MMC_SDIO	0x2050
+#define CLK_CON_GAT_GATE_CLKCMU_FSYS_USB30DRD	0x2054
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_BUS	0x207c
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_SPI0	0x2080
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_SPI1	0x2084
@@ -76,6 +91,11 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_MUX_MUX_CLKCMU_CORE_BUS,
 	CLK_CON_MUX_MUX_CLKCMU_CORE_CCI,
 	CLK_CON_MUX_MUX_CLKCMU_CORE_G3D,
+	CLK_CON_MUX_MUX_CLKCMU_FSYS_BUS,
+	CLK_CON_MUX_MUX_CLKCMU_FSYS_MMC_CARD,
+	CLK_CON_MUX_MUX_CLKCMU_FSYS_MMC_EMBD,
+	CLK_CON_MUX_MUX_CLKCMU_FSYS_MMC_SDIO,
+	CLK_CON_MUX_MUX_CLKCMU_FSYS_USB30DRD,
 	CLK_CON_MUX_MUX_CLKCMU_PERI_BUS,
 	CLK_CON_MUX_MUX_CLKCMU_PERI_SPI0,
 	CLK_CON_MUX_MUX_CLKCMU_PERI_SPI1,
@@ -88,6 +108,11 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_DIV_CLKCMU_CORE_BUS,
 	CLK_CON_DIV_CLKCMU_CORE_CCI,
 	CLK_CON_DIV_CLKCMU_CORE_G3D,
+	CLK_CON_DIV_CLKCMU_FSYS_BUS,
+	CLK_CON_DIV_CLKCMU_FSYS_MMC_CARD,
+	CLK_CON_DIV_CLKCMU_FSYS_MMC_EMBD,
+	CLK_CON_DIV_CLKCMU_FSYS_MMC_SDIO,
+	CLK_CON_DIV_CLKCMU_FSYS_USB30DRD,
 	CLK_CON_DIV_CLKCMU_PERI_BUS,
 	CLK_CON_DIV_CLKCMU_PERI_SPI0,
 	CLK_CON_DIV_CLKCMU_PERI_SPI1,
@@ -108,6 +133,11 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_GAT_GATE_CLKCMU_CORE_BUS,
 	CLK_CON_GAT_GATE_CLKCMU_CORE_CCI,
 	CLK_CON_GAT_GATE_CLKCMU_CORE_G3D,
+	CLK_CON_GAT_GATE_CLKCMU_FSYS_BUS,
+	CLK_CON_GAT_GATE_CLKCMU_FSYS_MMC_CARD,
+	CLK_CON_GAT_GATE_CLKCMU_FSYS_MMC_EMBD,
+	CLK_CON_GAT_GATE_CLKCMU_FSYS_MMC_SDIO,
+	CLK_CON_GAT_GATE_CLKCMU_FSYS_USB30DRD,
 	CLK_CON_GAT_GATE_CLKCMU_PERI_BUS,
 	CLK_CON_GAT_GATE_CLKCMU_PERI_SPI0,
 	CLK_CON_GAT_GATE_CLKCMU_PERI_SPI1,
@@ -146,6 +176,13 @@ PNAME(mout_peri_usi0_p)		= { "oscclk", "dout_shared0_div4" };
 PNAME(mout_peri_usi1_p)		= { "oscclk", "dout_shared0_div4" };
 PNAME(mout_peri_usi2_p)		= { "oscclk", "dout_shared0_div4" };
 
+/* List of parent clocks for Muxes in CMU_TOP: for CMU_FSYS */
+PNAME(mout_fsys_bus_p)		= { "dout_shared0_div2", "dout_shared1_div2" };
+PNAME(mout_fsys_mmc_card_p)	= { "dout_shared0_div2", "dout_shared1_div2" };
+PNAME(mout_fsys_mmc_embd_p)	= { "dout_shared0_div2", "dout_shared1_div2" };
+PNAME(mout_fsys_mmc_sdio_p)	= { "dout_shared0_div2", "dout_shared1_div2" };
+PNAME(mout_fsys_usb30drd_p)	= { "dout_shared0_div4", "dout_shared1_div4" };
+
 static const struct samsung_mux_clock top_mux_clks[] __initconst = {
 	/* CORE */
 	MUX(CLK_MOUT_CORE_BUS, "mout_core_bus", mout_core_bus_p,
@@ -174,6 +211,18 @@ static const struct samsung_mux_clock top_mux_clks[] __initconst = {
 	    CLK_CON_MUX_MUX_CLKCMU_PERI_USI1, 0, 1),
 	MUX(CLK_MOUT_PERI_USI2, "mout_peri_usi2", mout_peri_usi2_p,
 	    CLK_CON_MUX_MUX_CLKCMU_PERI_USI2, 0, 1),
+
+	/* FSYS */
+	MUX(CLK_MOUT_FSYS_BUS, "mout_fsys_bus", mout_fsys_bus_p,
+	    CLK_CON_MUX_MUX_CLKCMU_FSYS_BUS, 0, 1),
+	MUX(CLK_MOUT_FSYS_MMC_CARD, "mout_fsys_mmc_card", mout_fsys_mmc_card_p,
+	    CLK_CON_MUX_MUX_CLKCMU_FSYS_MMC_CARD, 0, 1),
+	MUX(CLK_MOUT_FSYS_MMC_EMBD, "mout_fsys_mmc_embd", mout_fsys_mmc_embd_p,
+	    CLK_CON_MUX_MUX_CLKCMU_FSYS_MMC_EMBD, 0, 1),
+	MUX(CLK_MOUT_FSYS_MMC_SDIO, "mout_fsys_mmc_sdio", mout_fsys_mmc_sdio_p,
+	    CLK_CON_MUX_MUX_CLKCMU_FSYS_MMC_SDIO, 0, 1),
+	MUX(CLK_MOUT_FSYS_USB30DRD, "mout_fsys_usb30drd", mout_fsys_usb30drd_p,
+	    CLK_CON_MUX_MUX_CLKCMU_FSYS_USB30DRD, 0, 1),
 };
 
 static const struct samsung_div_clock top_div_clks[] __initconst = {
@@ -220,6 +269,18 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
 	    CLK_CON_DIV_CLKCMU_PERI_USI1, 0, 4),
 	DIV(CLK_DOUT_PERI_USI2, "dout_peri_usi2", "gout_peri_usi2",
 	    CLK_CON_DIV_CLKCMU_PERI_USI2, 0, 4),
+
+	/* FSYS */
+	DIV(CLK_DOUT_FSYS_BUS, "dout_fsys_bus", "gout_fsys_bus",
+	    CLK_CON_DIV_CLKCMU_FSYS_BUS, 0, 4),
+	DIV(CLK_DOUT_FSYS_MMC_CARD, "dout_fsys_mmc_card", "gout_fsys_mmc_card",
+	    CLK_CON_DIV_CLKCMU_FSYS_MMC_CARD, 0, 9),
+	DIV(CLK_DOUT_FSYS_MMC_EMBD, "dout_fsys_mmc_embd", "gout_fsys_mmc_embd",
+	    CLK_CON_DIV_CLKCMU_FSYS_MMC_EMBD, 0, 9),
+	DIV(CLK_DOUT_FSYS_MMC_SDIO, "dout_fsys_mmc_sdio", "gout_fsys_mmc_sdio",
+	    CLK_CON_DIV_CLKCMU_FSYS_MMC_SDIO, 0, 9),
+	DIV(CLK_DOUT_FSYS_USB30DRD, "dout_fsys_usb30drd", "gout_fsys_usb30drd",
+	    CLK_CON_DIV_CLKCMU_FSYS_USB30DRD, 0, 4),
 };
 
 static const struct samsung_gate_clock top_gate_clks[] __initconst = {
@@ -250,6 +311,18 @@ static const struct samsung_gate_clock top_gate_clks[] __initconst = {
 	     CLK_CON_GAT_GATE_CLKCMU_PERI_USI1, 21, 0, 0),
 	GATE(CLK_GOUT_PERI_USI2, "gout_peri_usi2", "mout_peri_usi2",
 	     CLK_CON_GAT_GATE_CLKCMU_PERI_USI2, 21, 0, 0),
+
+	/* FSYS */
+	GATE(CLK_GOUT_FSYS_BUS, "gout_fsys_bus", "mout_fsys_bus",
+	     CLK_CON_GAT_GATE_CLKCMU_FSYS_BUS, 21, 0, 0),
+	GATE(CLK_GOUT_FSYS_MMC_CARD, "gout_fsys_mmc_card", "mout_fsys_mmc_card",
+	     CLK_CON_GAT_GATE_CLKCMU_FSYS_MMC_CARD, 21, 0, 0),
+	GATE(CLK_GOUT_FSYS_MMC_EMBD, "gout_fsys_mmc_embd", "mout_fsys_mmc_embd",
+	     CLK_CON_GAT_GATE_CLKCMU_FSYS_MMC_EMBD, 21, 0, 0),
+	GATE(CLK_GOUT_FSYS_MMC_SDIO, "gout_fsys_mmc_sdio", "mout_fsys_mmc_sdio",
+	     CLK_CON_GAT_GATE_CLKCMU_FSYS_MMC_SDIO, 21, 0, 0),
+	GATE(CLK_GOUT_FSYS_USB30DRD, "gout_fsys_usb30drd", "mout_fsys_usb30drd",
+	     CLK_CON_GAT_GATE_CLKCMU_FSYS_USB30DRD, 21, 0, 0),
 };
 
 static const struct samsung_cmu_info top_cmu_info __initconst = {
@@ -560,6 +633,88 @@ static const struct samsung_cmu_info core_cmu_info __initconst = {
 	.clk_name		= "dout_core_bus",
 };
 
+/* ---- CMU_FSYS ------------------------------------------------------------ */
+
+/* Register Offset definitions for CMU_FSYS (0x13400000) */
+#define PLL_CON0_MUX_CLKCMU_FSYS_BUS_USER	0x0100
+#define PLL_CON0_MUX_CLKCMU_FSYS_MMC_CARD_USER	0x0120
+#define PLL_CON0_MUX_CLKCMU_FSYS_MMC_EMBD_USER	0x0140
+#define PLL_CON0_MUX_CLKCMU_FSYS_MMC_SDIO_USER	0x0160
+#define PLL_CON0_MUX_CLKCMU_FSYS_USB30DRD_USER	0x0180
+#define CLK_CON_GAT_GOUT_FSYS_MMC_CARD_I_ACLK	0x2030
+#define CLK_CON_GAT_GOUT_FSYS_MMC_CARD_SDCLKIN	0x2034
+#define CLK_CON_GAT_GOUT_FSYS_MMC_EMBD_I_ACLK	0x2038
+#define CLK_CON_GAT_GOUT_FSYS_MMC_EMBD_SDCLKIN	0x203c
+#define CLK_CON_GAT_GOUT_FSYS_MMC_SDIO_I_ACLK	0x2040
+#define CLK_CON_GAT_GOUT_FSYS_MMC_SDIO_SDCLKIN	0x2044
+
+static const unsigned long fsys_clk_regs[] __initconst = {
+	PLL_CON0_MUX_CLKCMU_FSYS_BUS_USER,
+	PLL_CON0_MUX_CLKCMU_FSYS_MMC_CARD_USER,
+	PLL_CON0_MUX_CLKCMU_FSYS_MMC_EMBD_USER,
+	PLL_CON0_MUX_CLKCMU_FSYS_MMC_SDIO_USER,
+	PLL_CON0_MUX_CLKCMU_FSYS_USB30DRD_USER,
+	CLK_CON_GAT_GOUT_FSYS_MMC_CARD_I_ACLK,
+	CLK_CON_GAT_GOUT_FSYS_MMC_CARD_SDCLKIN,
+	CLK_CON_GAT_GOUT_FSYS_MMC_EMBD_I_ACLK,
+	CLK_CON_GAT_GOUT_FSYS_MMC_EMBD_SDCLKIN,
+	CLK_CON_GAT_GOUT_FSYS_MMC_SDIO_I_ACLK,
+	CLK_CON_GAT_GOUT_FSYS_MMC_SDIO_SDCLKIN,
+};
+
+/* List of parent clocks for Muxes in CMU_FSYS */
+PNAME(mout_fsys_bus_user_p)		= { "oscclk", "dout_fsys_bus" };
+PNAME(mout_fsys_mmc_card_user_p)	= { "oscclk", "dout_fsys_mmc_card" };
+PNAME(mout_fsys_mmc_embd_user_p)	= { "oscclk", "dout_fsys_mmc_embd" };
+PNAME(mout_fsys_mmc_sdio_user_p)	= { "oscclk", "dout_fsys_mmc_sdio" };
+PNAME(mout_fsys_usb30drd_user_p)	= { "oscclk", "dout_fsys_usb30drd" };
+
+static const struct samsung_mux_clock fsys_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_FSYS_BUS_USER, "mout_fsys_bus_user", mout_fsys_bus_user_p,
+	    PLL_CON0_MUX_CLKCMU_FSYS_BUS_USER, 4, 1),
+	MUX_F(CLK_MOUT_FSYS_MMC_CARD_USER, "mout_fsys_mmc_card_user",
+	      mout_fsys_mmc_card_user_p, PLL_CON0_MUX_CLKCMU_FSYS_MMC_CARD_USER,
+	      4, 1, CLK_SET_RATE_PARENT, 0),
+	MUX_F(CLK_MOUT_FSYS_MMC_EMBD_USER, "mout_fsys_mmc_embd_user",
+	      mout_fsys_mmc_embd_user_p, PLL_CON0_MUX_CLKCMU_FSYS_MMC_EMBD_USER,
+	      4, 1, CLK_SET_RATE_PARENT, 0),
+	MUX_F(CLK_MOUT_FSYS_MMC_SDIO_USER, "mout_fsys_mmc_sdio_user",
+	      mout_fsys_mmc_sdio_user_p, PLL_CON0_MUX_CLKCMU_FSYS_MMC_SDIO_USER,
+	      4, 1, CLK_SET_RATE_PARENT, 0),
+	MUX_F(CLK_MOUT_FSYS_USB30DRD_USER, "mout_fsys_usb30drd_user",
+	      mout_fsys_usb30drd_user_p, PLL_CON0_MUX_CLKCMU_FSYS_USB30DRD_USER,
+	      4, 1, CLK_SET_RATE_PARENT, 0),
+};
+
+static const struct samsung_gate_clock fsys_gate_clks[] __initconst = {
+	GATE(CLK_GOUT_MMC_CARD_ACLK, "gout_mmc_card_aclk", "mout_fsys_bus_user",
+	     CLK_CON_GAT_GOUT_FSYS_MMC_CARD_I_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_MMC_CARD_SDCLKIN, "gout_mmc_card_sdclkin",
+	     "mout_fsys_mmc_card_user", CLK_CON_GAT_GOUT_FSYS_MMC_CARD_SDCLKIN,
+	     21, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_GOUT_MMC_EMBD_ACLK, "gout_mmc_embd_aclk", "mout_fsys_bus_user",
+	     CLK_CON_GAT_GOUT_FSYS_MMC_EMBD_I_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_MMC_EMBD_SDCLKIN, "gout_mmc_embd_sdclkin",
+	     "mout_fsys_mmc_embd_user", CLK_CON_GAT_GOUT_FSYS_MMC_EMBD_SDCLKIN,
+	     21, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_GOUT_MMC_SDIO_ACLK, "gout_mmc_sdio_aclk", "mout_fsys_bus_user",
+	     CLK_CON_GAT_GOUT_FSYS_MMC_SDIO_I_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_MMC_SDIO_SDCLKIN, "gout_mmc_sdio_sdclkin",
+	     "mout_fsys_mmc_sdio_user", CLK_CON_GAT_GOUT_FSYS_MMC_SDIO_SDCLKIN,
+	     21, CLK_SET_RATE_PARENT, 0),
+};
+
+static const struct samsung_cmu_info fsys_cmu_info __initconst = {
+	.mux_clks		= fsys_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(fsys_mux_clks),
+	.gate_clks		= fsys_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(fsys_gate_clks),
+	.nr_clk_ids		= FSYS_NR_CLK,
+	.clk_regs		= fsys_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(fsys_clk_regs),
+	.clk_name		= "dout_fsys_bus",
+};
+
 /* ---- platform_driver ----------------------------------------------------- */
 
 static int __init exynos7885_cmu_probe(struct platform_device *pdev)
@@ -577,6 +732,9 @@ static const struct of_device_id exynos7885_cmu_of_match[] = {
 	{
 		.compatible = "samsung,exynos7885-cmu-core",
 		.data = &core_cmu_info,
+	}, {
+		.compatible = "samsung,exynos7885-cmu-fsys",
+		.data = &fsys_cmu_info,
 	}, {
 	},
 };
-- 
2.36.1

