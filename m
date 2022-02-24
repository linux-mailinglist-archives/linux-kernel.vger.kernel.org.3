Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94314C31D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiBXQts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiBXQte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25291B8BFD;
        Thu, 24 Feb 2022 08:48:49 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p4so221904wmg.1;
        Thu, 24 Feb 2022 08:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9rr9T3jHq1p5MnOaUfvIk/32mF11xXbOKrKi9IRlR1g=;
        b=EPLDIBW9KcmMDX7CSXoBjRYYwqMnfX7uapjOiad6nF2+18tAxYzlDoiRYdDuF9Asex
         waJT4kxVEGrfiQCI4JqZ5nYInnfhGZKIPmKBjKi5UivOJ0xdtD4HpoCZPP8LcmTcLCWV
         4RHUMVriOObBmh0x69vHAhn2fss8z65tTZG2rYlqX5vzlJOfYbckmXDdZcGHELJPCYrL
         l7o5nxJ1SgNOa3dvMQMZlkQBN25I6ZiflhTEKbcOKEn3T6/BfFeyop3INfvyxD8Q0ppp
         pexqY8cOIts08ARnpGilo4o+m+VftSQHuStYFL7wBHndzyCSNN2XfI5+xo85eeYfaL76
         65cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9rr9T3jHq1p5MnOaUfvIk/32mF11xXbOKrKi9IRlR1g=;
        b=tnAxq0cv0Li6FztyaSlRpJ0pl5FOCV9s7/0bI8FoVlqLTN0OyRruknRs4xnj8kDQ+s
         81OHCXaBeOb7ikXJUeQ8B7yARsbIbTQFPjGXoiZ7yh4vre6/7EUzy36Wx9xW4iYSzrLO
         nfubGj77GFNT/sMKkOoAgqo3428zaxhya/ju4Pki9JGg9mGKRva6bW7HVA5Vhi145QLg
         nPzmuqcKbGQVgiWxa1ZO6l34IdcpGon6epCbHOz6UuzHXb1auMJMjKh9G436Dn3u5qXM
         MnoCcEE2u1wiC7mR2UjA4TpVWHwi2xuX2jtczeZubgqutxcYGfAdfD91GJ6tQGowpfhC
         liMA==
X-Gm-Message-State: AOAM532SKLj1adnn216vOOEwISUmS0AiqTe/8/t42dEdFs1EN2L/Q/nX
        hOGXsMngplyEXvxfV1lzMdsimeZ76tM=
X-Google-Smtp-Source: ABdhPJyc20+GiaTPqClCbSN5TDttqrt95zRkNja6ERxt2m+X/LLDAsy2RB454j7W8+i0VROmp4sfKw==
X-Received: by 2002:a05:600c:4f55:b0:381:2322:6b2 with SMTP id m21-20020a05600c4f5500b00381232206b2mr149521wmq.169.1645721328153;
        Thu, 24 Feb 2022 08:48:48 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:48:47 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/15] clk: qcom: gcc-ipq806x: add additional freq nss cores
Date:   Thu, 24 Feb 2022 17:48:23 +0100
Message-Id: <20220224164831.21475-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224164831.21475-1-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
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

Ipq8065 SoC (an evolution of ipq8064 SoC) contains nss cores that can be
clocked to 800MHz. Add these missing freq to the gcc driver.
Set the freq_tbl for the ubi32_cores to the correct values based on the
machine compatible.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 3a9001830f0c..0a3ba3480de8 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -233,7 +233,9 @@ static struct clk_regmap pll14_vote = {
 
 static struct pll_freq_tbl pll18_freq_tbl[] = {
 	NSS_PLL_RATE(550000000, 44, 0, 1, 0x01495625),
+	NSS_PLL_RATE(600000000, 48, 0, 1, 0x01495625),
 	NSS_PLL_RATE(733000000, 58, 16, 25, 0x014b5625),
+	NSS_PLL_RATE(800000000, 64, 0, 1, 0x01495625),
 };
 
 static struct clk_pll pll18 = {
@@ -2705,7 +2707,7 @@ static struct clk_branch nss_tcm_clk = {
 	},
 };
 
-static const struct freq_tbl clk_tbl_nss[] = {
+static const struct freq_tbl clk_tbl_nss_ipq8064[] = {
 	{ 110000000, P_PLL18, 1, 1, 5 },
 	{ 275000000, P_PLL18, 2, 0, 0 },
 	{ 550000000, P_PLL18, 1, 0, 0 },
@@ -2713,6 +2715,14 @@ static const struct freq_tbl clk_tbl_nss[] = {
 	{ }
 };
 
+static const struct freq_tbl clk_tbl_nss_ipq8065[] = {
+	{ 110000000, P_PLL18, 1, 1, 5 },
+	{ 275000000, P_PLL18, 2, 0, 0 },
+	{ 600000000, P_PLL18, 1, 0, 0 },
+	{ 800000000, P_PLL18, 1, 0, 0 },
+	{ }
+};
+
 static struct clk_dyn_rcg ubi32_core1_src_clk = {
 	.ns_reg[0] = 0x3d2c,
 	.ns_reg[1] = 0x3d30,
@@ -2752,7 +2762,7 @@ static struct clk_dyn_rcg ubi32_core1_src_clk = {
 		.pre_div_width = 2,
 	},
 	.mux_sel_bit = 0,
-	.freq_tbl = clk_tbl_nss,
+	/* nss freq table is selected based on the SoC compatible */
 	.clkr = {
 		.enable_reg = 0x3d20,
 		.enable_mask = BIT(1),
@@ -2805,7 +2815,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
 		.pre_div_width = 2,
 	},
 	.mux_sel_bit = 0,
-	.freq_tbl = clk_tbl_nss,
+	/* nss freq table is selected based on the SoC compatible */
 	.clkr = {
 		.enable_reg = 0x3d40,
 		.enable_mask = BIT(1),
@@ -3138,6 +3148,14 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (of_machine_is_compatible("qcom,ipq8065")) {
+		ubi32_core1_src_clk.freq_tbl = clk_tbl_nss_ipq8065;
+		ubi32_core2_src_clk.freq_tbl = clk_tbl_nss_ipq8065;
+	} else {
+		ubi32_core1_src_clk.freq_tbl = clk_tbl_nss_ipq8064;
+		ubi32_core2_src_clk.freq_tbl = clk_tbl_nss_ipq8064;
+	}
+
 	ret = qcom_cc_probe(pdev, &gcc_ipq806x_desc);
 	if (ret)
 		return ret;
-- 
2.34.1

