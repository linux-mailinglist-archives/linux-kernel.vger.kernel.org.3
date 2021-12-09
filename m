Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4246ED3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbhLIQlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:41:22 -0500
Received: from box.trvn.ru ([194.87.146.52]:34419 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239931AbhLIQlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:41:19 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id D13DF41F30;
        Thu,  9 Dec 2021 21:37:39 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1639067860; bh=ITv8oy4gH8hvt2xoJZdnpKjB0KS+uuWG14QJNxq0uPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdTOfoNUh2FZzHLgyhKHTuJiEN7RICt1iz9vSWGI4vcYLO8WqzPb/NZBSICTfb9qY
         BtCUOMnbqCMLPh5/IS3tVUKlF+ijp/f6J4XH9p27bxgu/I1b/paCSmkc2TOBQ/mLeH
         uXYxin9jEwM1DeU+No2fparO5u8xWGaa7xRgeQ6VtiTTQ7xbvH3a8OfkcIBdiaUIVU
         1Ooo5nRmWIGQp3HuTVtBYG8UwvUhCSQ+pJGEobKYUoG7gE/0OhzfPt1NX3hDtqD+cq
         TNhQ7WK2M4E8Y6aXr1SYd5i5STg+f7twYFsytl25htkJZT8vKlEnFKYIQLdCWdfozQ
         mZvCDv/ib3OVA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 4/4] clk: qcom: gcc-msm8916: Add rates to the GP clocks
Date:   Thu,  9 Dec 2021 21:37:20 +0500
Message-Id: <20211209163720.106185-5-nikita@trvn.ru>
In-Reply-To: <20211209163720.106185-1-nikita@trvn.ru>
References: <20211209163720.106185-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.30.2

