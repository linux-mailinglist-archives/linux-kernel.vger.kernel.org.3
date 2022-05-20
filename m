Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A7C52E9AA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348063AbiETKKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbiETKKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A806BDE30B;
        Fri, 20 May 2022 03:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F6A661CFD;
        Fri, 20 May 2022 10:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEEEC34113;
        Fri, 20 May 2022 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653041420;
        bh=GTkcfKFZihRoPL88FJ6O6bK52tDtWhzjFXKqXM8uLMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5vFWXgJwENjVzROfnACwPaIx7dBioOe+Xeh/4wV4mOvVaw5MXeMY0WFDYsxNlnZZ
         hWGFB2RBQcsVvOLQo6QpTycHHLMwRIJw/v/6krufCoNzFtSI/P66B720GJzsHliwFA
         Av3HrXU2Gl9RaLx8FUimeJA8IH1t8SoW52nfyIdyO70jPYpETVzS8AlVcyBentnJeh
         unSe2OrJufUicrXff5GnpYhXz37huQHsVDY9Xa9PHHdmSkRMmJJx5TN3FUy/JJAe4Z
         8nsbGgYwLAK480T3rrraLEzz9aikRe6c9a/5WTRv9TxNGzeT+0o4c6/vN5N+L6GL83
         gYMNci5dr4+IA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nrzaO-000572-IC; Fri, 20 May 2022 12:10:20 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/3] clk: qcom: gcc-sc8280xp: use collapse-voting for PCIe GDSCs
Date:   Fri, 20 May 2022 12:09:48 +0200
Message-Id: <20220520100948.19622-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520100948.19622-1-johan+linaro@kernel.org>
References: <20220520100948.19622-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe GDSCs can be shared with other masters and should use the APCS
collapse-vote register when updating the power state.

This is specifically also needed to be able to disable power domains
that have been enabled by boot firmware using the vote register.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/gcc-sc8280xp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index 887db5324ab8..4d7db13ed708 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -6778,58 +6778,79 @@ static struct clk_branch gcc_video_vcodec_throttle_clk = {
 
 static struct gdsc pcie_0_tunnel_gdsc = {
 	.gdscr = 0xa4004,
+	.collapse_ctrl = 0x52128,
+	.collapse_mask = BIT(0),
 	.pd = {
 		.name = "pcie_0_tunnel_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc pcie_1_tunnel_gdsc = {
 	.gdscr = 0x8d004,
+	.collapse_ctrl = 0x52128,
+	.collapse_mask = BIT(1),
 	.pd = {
 		.name = "pcie_1_tunnel_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc pcie_2a_gdsc = {
 	.gdscr = 0x9d004,
+	.collapse_ctrl = 0x52128,
+	.collapse_mask = BIT(2),
 	.pd = {
 		.name = "pcie_2a_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc pcie_2b_gdsc = {
 	.gdscr = 0x9e004,
+	.collapse_ctrl = 0x52128,
+	.collapse_mask = BIT(3),
 	.pd = {
 		.name = "pcie_2b_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc pcie_3a_gdsc = {
 	.gdscr = 0xa0004,
+	.collapse_ctrl = 0x52128,
+	.collapse_mask = BIT(4),
 	.pd = {
 		.name = "pcie_3a_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc pcie_3b_gdsc = {
 	.gdscr = 0xa2004,
+	.collapse_ctrl = 0x52128,
+	.collapse_mask = BIT(5),
 	.pd = {
 		.name = "pcie_3b_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc pcie_4_gdsc = {
 	.gdscr = 0x6b004,
+	.collapse_ctrl = 0x52128,
+	.collapse_mask = BIT(6),
 	.pd = {
 		.name = "pcie_4_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc ufs_card_gdsc = {
-- 
2.35.1

