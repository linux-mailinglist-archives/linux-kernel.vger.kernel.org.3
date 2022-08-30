Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4604C5A5D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiH3H45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiH3H4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:56:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD400D124B;
        Tue, 30 Aug 2022 00:56:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay12so5363836wmb.1;
        Tue, 30 Aug 2022 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WLkwF7893RGztbOFVwVZxp1PidhTkL05pG2d7q1S7tE=;
        b=g/8wR+KYJLrDK0/fi+xFTJ/aVAqXKQir1TJfhqHdVmTpBGqjTI0A09TA5cMSqj3TB+
         FhS+9rPXelH+pkzOdwH7ahDeZYwbtK+t1qVaghQpgc/dbpknG+DfJ4yvzl/CI0VDADOm
         QnBmiZd3x78E5vy3kmVHlSidEJhmS1uy40XX+rXdvHiYqdIzbfyCegH+eELIS0LE6KpB
         QEpe1Jhj7i7GZcVwRnHSXjqMdK3zbVXT0FvjumQoBu61VsLvDH30J9KocgR7b30aydcG
         zT/p95/B0HG+oPAn3iFq7SgEFE4HKZPgd9HVs7JBEtcZPZn2jm4L3qHZCM/CHOzJ9fae
         kE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WLkwF7893RGztbOFVwVZxp1PidhTkL05pG2d7q1S7tE=;
        b=3/QAilfea719DzLQa2TiSP7irucK79mOKlUD9AhNyWYn4yvvVPybzlF6gxLU6rHUx2
         1NmOuiN/xy0ZIz3ATpgqXSWWn+8AjWs3e4BckUzWop5X4PZL5BY+aAMBj7WaLN5Y4jgw
         /6/C8yzfXWIIozMmmMBQMeDrcctAUIEd9SjW2/H4c/aJ8wJ9E5jucqPW/UiPQR/t/6AF
         FwiWfgnLgAR01zMhMP98eZHZVtwrTXH6TVlcOsrkFXkx0uk8XOe0rjkW9Bm0THOG2Sia
         HJUMHtxE1plsDPrsTRcdZnBMKRAdv1ZIOhQTagw1ZAMLcR+0awwR6V4Opvk/O/X6SySi
         oimA==
X-Gm-Message-State: ACgBeo0FTo/giPQg5KcJPfm3B8FE5EvleHNmN9JHM4VGd9CeM/rw2hBf
        vz30RtJPB28n3YjkQ5AOSy0=
X-Google-Smtp-Source: AA6agR4e0YKEVMnJ54jlh0UnMJjy255mrJh6TY87bSI8ziNV2TS8InvZ+A6Gi1ZF+0z7hE/TARqdWw==
X-Received: by 2002:a05:600c:a46:b0:3a6:9c49:b751 with SMTP id c6-20020a05600c0a4600b003a69c49b751mr8950275wmq.169.1661846204310;
        Tue, 30 Aug 2022 00:56:44 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id q16-20020adffed0000000b00226d1821abesm8436842wrs.56.2022.08.30.00.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:56:43 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Adam Skladowski <a_skl39@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH 2/3] clk: qcom: gcc-sm6115: Move alpha pll bramo overrides
Date:   Tue, 30 Aug 2022 10:56:19 +0300
Message-Id: <20220830075620.974009-3-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830075620.974009-1-iskren.chernev@gmail.com>
References: <20220830075620.974009-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sm6115 uses a modified default and bramo alpha pll offsets. Put them in
the same place for consistency.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/clk/qcom/gcc-sm6115.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index e24a977c2580..dc2a99c3bc06 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -65,6 +65,16 @@ static const u8 clk_alpha_pll_regs_offset[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_CONFIG_CTL] = 0x20,
 		[PLL_OFF_STATUS] = 0x24,
 	},
+	[CLK_ALPHA_PLL_TYPE_BRAMMO] =  {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL_U] = 0x0c,
+		[PLL_OFF_TEST_CTL] = 0x10,
+		[PLL_OFF_TEST_CTL_U] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_CONFIG_CTL] = 0x1C,
+		[PLL_OFF_STATUS] = 0x20,
+	},
 };
 
 static struct clk_alpha_pll gpll0 = {
@@ -106,18 +116,6 @@ static struct clk_alpha_pll_postdiv gpll0_out_aux2 = {
 	},
 };
 
-/* listed as BRAMMO, but it doesn't really match */
-static const u8 clk_gpll9_regs[PLL_OFF_MAX_REGS] = {
-	[PLL_OFF_L_VAL] = 0x04,
-	[PLL_OFF_ALPHA_VAL] = 0x08,
-	[PLL_OFF_ALPHA_VAL_U] = 0x0c,
-	[PLL_OFF_TEST_CTL] = 0x10,
-	[PLL_OFF_TEST_CTL_U] = 0x14,
-	[PLL_OFF_USER_CTL] = 0x18,
-	[PLL_OFF_CONFIG_CTL] = 0x1C,
-	[PLL_OFF_STATUS] = 0x20,
-};
-
 static const struct clk_div_table post_div_table_gpll0_out_main[] = {
 	{ 0x0, 1 },
 	{ }
@@ -445,7 +443,7 @@ static struct clk_alpha_pll gpll9 = {
 	.offset = 0x9000,
 	.vco_table = gpll9_vco,
 	.num_vco = ARRAY_SIZE(gpll9_vco),
-	.regs = clk_gpll9_regs,
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_BRAMMO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(9),
@@ -471,7 +469,7 @@ static struct clk_alpha_pll_postdiv gpll9_out_main = {
 	.post_div_table = post_div_table_gpll9_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll9_out_main),
 	.width = 2,
-	.regs = clk_gpll9_regs,
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_BRAMMO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll9_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll9.clkr.hw },
-- 
2.37.2

