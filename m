Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46292547A9A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiFLPAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbiFLPAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:00:35 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4149F84
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:00:33 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 42F564B010;
        Sun, 12 Jun 2022 20:00:18 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1655046018; bh=d75aH6lgsop7H0tTJMNEsXUOXMX4zeKLj6KVJaiEtl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EaGNG4X9LzC4R+SBFyBhIoZYMfcgbDfpjypiC3F+s1ziY2oFYp4ZxR1c7NGzgKnXT
         R5FPPlTa5+0WGxD2r3iYW5Edq1GrlBGkl6qHcBeY8Oi2rTfOdH/lBWt/2OFntqtE5n
         Muc7aBr1Gd/NyrlN9Rid1o9+t8behBxbQ8q1ADSbX0IoN1xpLyOgmpa8hK9UvHj+44
         RvHMh+N8eEB1DbfkGbrSN7/INyeQOcxBwWs/BSO6ybjdPie226PtZluC3UEF1bq4S9
         SDiprayGYE5Q3fhIOvC7RIwBQ9zmojnLDoi4473YR/2Mb4wKajIIBuKfcUB4QWt/e8
         RmeYtdHVNOckQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 4/4] clk: qcom: gcc-msm8916: Add rates to the GP clocks
Date:   Sun, 12 Jun 2022 19:59:55 +0500
Message-Id: <20220612145955.385787-5-nikita@trvn.ru>
In-Reply-To: <20220612145955.385787-1-nikita@trvn.ru>
References: <20220612145955.385787-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8916 has (at least) 6 "General Purpose" clocks that can be muxed to
SoC pins. These clocks are:

GP_CLK{0, 1} : GPIO_{31, 32} (Belongs to CAMSS according to Linux)
GP_CLK_{1-3}{A, B} : GPIO_{49-51, 97, 12, 13} (Belongs to GCC itself)
GP_MN : GPIO_110 (Doesn't seem to be described in gcc,
    ignored in this patch)

Those clocks may be used as e.g. PWM sources for external peripherals.
Add more frequencies to the table for those clocks so it's possible
for arbitrary peripherals to make use of them.

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/clk/qcom/gcc-msm8916.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.c
index 17e4a5a2a9fd..9a46794f6eb8 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -765,7 +765,20 @@ static struct clk_rcg2 cci_clk_src = {
 	},
 };
 
+/*
+ * This is a frequency table for "General Purpose" clocks.
+ * These clocks can be muxed to the SoC pins and may be used by
+ * external devices. They're often used as PWM source.
+ *
+ * See comment at ftbl_gcc_gp1_3_clk.
+ */
 static const struct freq_tbl ftbl_gcc_camss_gp0_1_clk[] = {
+	F(10000,   P_XO,    16,  1, 120),
+	F(100000,  P_XO,    16,  1,  12),
+	F(500000,  P_GPLL0, 16,  1, 100),
+	F(1000000, P_GPLL0, 16,  1,  50),
+	F(2500000, P_GPLL0, 16,  1,  20),
+	F(5000000, P_GPLL0, 16,  1,  10),
 	F(100000000, P_GPLL0, 8, 0, 0),
 	F(200000000, P_GPLL0, 4, 0, 0),
 	{ }
@@ -927,7 +940,29 @@ static struct clk_rcg2 crypto_clk_src = {
 	},
 };
 
+/*
+ * This is a frequency table for "General Purpose" clocks.
+ * These clocks can be muxed to the SoC pins and may be used by
+ * external devices. They're often used as PWM source.
+ *
+ * Please note that MND divider must be enabled for duty-cycle
+ * control to be possible. (M != N) Also since D register is configured
+ * with a value multiplied by 2, and duty cycle is calculated as
+ *                             (2 * D) % 2^W
+ *                DutyCycle = ----------------
+ *                              2 * (N % 2^W)
+ * (where W = .mnd_width)
+ * N must be half or less than maximum value for the register.
+ * Otherwise duty-cycle control would be limited.
+ * (e.g. for 8-bit NMD N should be less than 128)
+ */
 static const struct freq_tbl ftbl_gcc_gp1_3_clk[] = {
+	F(10000,   P_XO,    16,  1, 120),
+	F(100000,  P_XO,    16,  1,  12),
+	F(500000,  P_GPLL0, 16,  1, 100),
+	F(1000000, P_GPLL0, 16,  1,  50),
+	F(2500000, P_GPLL0, 16,  1,  20),
+	F(5000000, P_GPLL0, 16,  1,  10),
 	F(19200000, P_XO, 1, 0,	0),
 	{ }
 };
-- 
2.35.3

