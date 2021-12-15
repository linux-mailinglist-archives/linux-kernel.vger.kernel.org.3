Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781EA4754C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhLOI5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbhLOI5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:57:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63615C061574;
        Wed, 15 Dec 2021 00:57:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03A2561861;
        Wed, 15 Dec 2021 08:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DDEC34600;
        Wed, 15 Dec 2021 08:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639558663;
        bh=g87a3lCDfyXFKokTIyZHhAv+dEssgItSGsoH0N4F4II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nN4h1B3CMYXUuicKdSjJpyPlX1bxS6WylSgYPCiuv0c9QfPD/UyBQpdB4997QEz/9
         3aDEULxpAgHKzB3m03+rVd2Rh5z4DtAK+px14RpE0pxyn/UHFdQEb5coGCzrL5064Y
         lL5TUw1Ew3I/JOtXJGCBGNegchPJvHS4Dg7iByRGB88fTIZq3ztZmuPDtrCSOTzNcp
         p2frO42uEv0Jr2uDF/FaLprEusXm0Y1/WkKDhgU1txmy4ou4uy8qTdKpRk+kMsIXYd
         LEO6Z1/VFGV/hbxFtTyBpxCMcbscU8g5NCDGB4BfeBCQ0UQPx+zhwITbxqUdTfRqZA
         fVbewB4VUv5ZQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mxQ6X-0054RC-Bo; Wed, 15 Dec 2021 09:57:41 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND(2) 1/1] clk: clk-hi3670: mark some clocks as CLK_IS_CRITICAL
Date:   Wed, 15 Dec 2021 09:57:39 +0100
Message-Id: <4203fe82f2a80d2a6d3ce549f09427f8499eb54f.1639558556.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639558556.git.mchehab+huawei@kernel.org>
References: <cover.1639558556.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks can't be disabled or the device stops working.

Mark those with CLK_IS_CRITICAL.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RESEND(2) 0/1] at: https://lore.kernel.org/all/cover.1639558556.git.mchehab+huawei@kernel.org/

 drivers/clk/hisilicon/clk-hi3670.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3670.c b/drivers/clk/hisilicon/clk-hi3670.c
index 4d05a71683a5..d5813132df9c 100644
--- a/drivers/clk/hisilicon/clk-hi3670.c
+++ b/drivers/clk/hisilicon/clk-hi3670.c
@@ -82,13 +82,13 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_sep_clks[] = {
 	{ HI3670_PPLL2_EN_ACPU, "ppll2_en_acpu", "clk_ppll2",
 	  CLK_SET_RATE_PARENT, 0x0, 3, 0, },
 	{ HI3670_PPLL3_EN_ACPU, "ppll3_en_acpu", "clk_ppll3",
-	  CLK_SET_RATE_PARENT, 0x0, 27, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x0, 27, 0, },
 	{ HI3670_PPLL1_GT_CPU, "ppll1_gt_cpu", "clk_ppll1",
 	  CLK_SET_RATE_PARENT, 0x460, 16, 0, },
 	{ HI3670_PPLL2_GT_CPU, "ppll2_gt_cpu", "clk_ppll2",
 	  CLK_SET_RATE_PARENT, 0x460, 18, 0, },
 	{ HI3670_PPLL3_GT_CPU, "ppll3_gt_cpu", "clk_ppll3",
-	  CLK_SET_RATE_PARENT, 0x460, 20, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x460, 20, 0, },
 	{ HI3670_CLK_GATE_PPLL2_MEDIA, "clk_gate_ppll2_media", "clk_ppll2",
 	  CLK_SET_RATE_PARENT, 0x410, 27, 0, },
 	{ HI3670_CLK_GATE_PPLL3_MEDIA, "clk_gate_ppll3_media", "clk_ppll3",
@@ -166,7 +166,7 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_sep_clks[] = {
 	{ HI3670_CLK_CCI400_BYPASS, "clk_cci400_bypass", "clk_ddrc_freq",
 	  CLK_SET_RATE_PARENT, 0x22C, 28, 0, },
 	{ HI3670_CLK_GATE_CCI400, "clk_gate_cci400", "clk_ddrc_freq",
-	  CLK_SET_RATE_PARENT, 0x50, 14, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x50, 14, 0, },
 	{ HI3670_CLK_GATE_SD, "clk_gate_sd", "clk_mux_sd_sys",
 	  CLK_SET_RATE_PARENT, 0x40, 17, 0, },
 	{ HI3670_HCLK_GATE_SD, "hclk_gate_sd", "clk_div_sysbus",
@@ -248,15 +248,15 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_sep_clks[] = {
 	{ HI3670_CLK_GATE_AO_ASP, "clk_gate_ao_asp", "clk_div_ao_asp",
 	  CLK_SET_RATE_PARENT, 0x0, 26, 0, },
 	{ HI3670_PCLK_GATE_PCTRL, "pclk_gate_pctrl", "clk_div_ptp",
-	  CLK_SET_RATE_PARENT, 0x20, 31, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x20, 31, 0, },
 	{ HI3670_CLK_CSI_TRANS_GT, "clk_csi_trans_gt", "clk_div_csi_trans",
-	  CLK_SET_RATE_PARENT, 0x30, 24, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x30, 24, 0, },
 	{ HI3670_CLK_DSI_TRANS_GT, "clk_dsi_trans_gt", "clk_div_dsi_trans",
 	  CLK_SET_RATE_PARENT, 0x30, 25, 0, },
 	{ HI3670_CLK_GATE_PWM, "clk_gate_pwm", "clk_div_ptp",
 	  CLK_SET_RATE_PARENT, 0x20, 0, 0, },
 	{ HI3670_ABB_AUDIO_EN0, "abb_audio_en0", "clk_gate_abb_192",
-	  CLK_SET_RATE_PARENT, 0x30, 8, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x30, 8, 0, },
 	{ HI3670_ABB_AUDIO_EN1, "abb_audio_en1", "clk_gate_abb_192",
 	  CLK_SET_RATE_PARENT, 0x30, 9, 0, },
 	{ HI3670_ABB_AUDIO_GT_EN0, "abb_audio_gt_en0", "abb_audio_en0",
@@ -331,9 +331,9 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_clks[] = {
 	{ HI3670_CLK_GATE_DSI_TRANS, "clk_gate_dsi_trans", "clk_ppll2",
 	  CLK_SET_RATE_PARENT, 0xF4, 1, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_PTP, "clk_andgt_ptp", "clk_div_320m",
-	  CLK_SET_RATE_PARENT, 0xF8, 5, CLK_GATE_HIWORD_MASK, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0xF8, 5, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_OUT0, "clk_andgt_out0", "clk_ppll0",
-	  CLK_SET_RATE_PARENT, 0xF0, 10, CLK_GATE_HIWORD_MASK, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0xF0, 10, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_OUT1, "clk_andgt_out1", "clk_ppll0",
 	  CLK_SET_RATE_PARENT, 0xF0, 11, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLKGT_DP_AUDIO_PLL_AO, "clkgt_dp_audio_pll_ao", "clk_ppll6",
@@ -569,9 +569,9 @@ static const struct hisi_gate_clock hi3670_sctrl_gate_sep_clks[] = {
 	{ HI3670_PCLK_GATE_SPI, "pclk_gate_spi", "clk_div_ioperi",
 	  CLK_SET_RATE_PARENT, 0x1B0, 10, 0, },
 	{ HI3670_CLK_GATE_UFS_SUBSYS, "clk_gate_ufs_subsys", "clk_div_ufs_subsys",
-	  CLK_SET_RATE_PARENT, 0x1B0, 14, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x1B0, 14, 0, },
 	{ HI3670_CLK_GATE_UFSIO_REF, "clk_gate_ufsio_ref", "clkin_sys",
-	  CLK_SET_RATE_PARENT, 0x1b0, 12, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x1b0, 12, 0, },
 	{ HI3670_PCLK_AO_GPIO0, "pclk_ao_gpio0", "clk_div_aobus",
 	  CLK_SET_RATE_PARENT, 0x160, 11, 0, },
 	{ HI3670_PCLK_AO_GPIO1, "pclk_ao_gpio1", "clk_div_aobus",
@@ -593,7 +593,7 @@ static const struct hisi_gate_clock hi3670_sctrl_gate_sep_clks[] = {
 	{ HI3670_PCLK_GATE_SYSCNT, "pclk_gate_syscnt", "clk_div_aobus",
 	  CLK_SET_RATE_PARENT, 0x160, 19, 0, },
 	{ HI3670_CLK_GATE_SYSCNT, "clk_gate_syscnt", "clkin_sys",
-	  CLK_SET_RATE_PARENT, 0x160, 20, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x160, 20, 0, },
 	{ HI3670_CLK_GATE_ASP_SUBSYS_PERI, "clk_gate_asp_subsys_peri",
 	  "clk_mux_asp_subsys_peri",
 	  CLK_SET_RATE_PARENT, 0x170, 6, 0, },
@@ -703,7 +703,7 @@ static const struct hisi_gate_clock hi3670_media1_gate_sep_clks[] = {
 	{ HI3670_PCLK_GATE_DISP_NOC_SUBSYS, "pclk_gate_disp_noc_subsys", "clk_div_sysbus",
 	  CLK_SET_RATE_PARENT, 0x10, 18, 0, },
 	{ HI3670_ACLK_GATE_DISP_NOC_SUBSYS, "aclk_gate_disp_noc_subsys", "clk_gate_vivobusfreq",
-	  CLK_SET_RATE_PARENT, 0x10, 17, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x10, 17, 0, },
 	{ HI3670_PCLK_GATE_DSS, "pclk_gate_dss", "pclk_gate_disp_noc_subsys",
 	  CLK_SET_RATE_PARENT, 0x00, 14, 0, },
 	{ HI3670_ACLK_GATE_DSS, "aclk_gate_dss", "aclk_gate_disp_noc_subsys",
-- 
2.33.1

