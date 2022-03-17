Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137D24DD0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiCQWh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiCQWhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:37:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C73126243C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:36:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h1so8262559edj.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUL7G4oOlZT6ZcSm0IypZD6C9fq3wHaBrHnjH9uPtcY=;
        b=bOpNBvfhoMLPtp0GDUuHsUff1/qKx7bzkXyoF5Zx6VrrBO7q8B/4cX0+mN+37dIlox
         YDHDC3DUdzKD6KtoOLORcZI+L02IV30xfDP2fyJVAOFAvwEAfRdeBB0SLBTxlgcLr9SP
         8GPEgGFswgaPIY1nVGh1/EI3Z6p8SGhW3wnGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUL7G4oOlZT6ZcSm0IypZD6C9fq3wHaBrHnjH9uPtcY=;
        b=A1r6YL38hfW4NNFUOn9mSZJX7/9kt2wv3dRKgQ4YSeAmeJQ8oedQm4P8l9xEZoPcvO
         2lWVobJ6B6vDRJpkS910QdkWnbhu6xR3YzSxpaG49YSeynm/J5ssN5TdE0vcT07sLyqv
         bF0gQ1LIkot4oFM518TitQES6RHQPS63BaMoEb8Ag+TUZzkNoRJAg5vMtllR0WktsbAV
         1JfwOeH+GJ4bMjSg3WGllc31dkVrtp52BqMxTzAhwQAbS2lQ2DcFbV4j24oX22e/+agn
         5uq8bBcOuP8lUXZ692tNqGH2LGM4BZwlwo8soW8jqMmgAA5wjfzXdN08uLAeMATbER6A
         LXZA==
X-Gm-Message-State: AOAM533HZAfcySqn2iiCM3yYjoeW83w7eJ6fV5XMnWzN+YnC0o7sJiWn
        U+qykCW1VZwJ6ewIiumzCSXQHA==
X-Google-Smtp-Source: ABdhPJydOD9qsL8/+g218ELmo+ZGkUSYcQYHwl3QeH92QppgAMEA4so62K4IOG1KKTFJ4W9Zx4CqFw==
X-Received: by 2002:aa7:cb0f:0:b0:416:201f:c64d with SMTP id s15-20020aa7cb0f000000b00416201fc64dmr6798503edt.48.1647556565058;
        Thu, 17 Mar 2022 15:36:05 -0700 (PDT)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id ec21-20020a170906b6d500b006d170a3444csm2893669ejb.164.2022.03.17.15.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 15:36:04 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] clk: imx8mn: add GPT support
Date:   Thu, 17 Mar 2022 23:35:59 +0100
Message-Id: <20220317223600.175894-2-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317223600.175894-1-alvin@pqrs.dk>
References: <20220317223600.175894-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Add support for the General Purpose Timer (GPT) clocks on the i.MX8MN.
The i.MX8MN GPT IP block is the same as on the i.MX8MM, on which this
patch is based.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
v1->v2: for reasons of consistency, change lines of the form:

    static const char *const imx8mn_gpt...

to

    static const char * const imx8mn_gpt...

and adjust the indentation accordingly.
---
 drivers/clk/imx/clk-imx8mn.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 92fcbab4f5be..fb058cb38c27 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -227,6 +227,30 @@ static const char * const imx8mn_pwm4_sels[] = {"osc_24m", "sys_pll2_100m", "sys
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
 						"sys_pll1_80m", "video_pll1_out", };
 
+static const char * const imx8mn_gpt1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
+						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"audio_pll1_out", "clk_ext1", };
+
+static const char * const imx8mn_gpt2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
+						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"audio_pll1_out", "clk_ext1", };
+
+static const char * const imx8mn_gpt3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
+						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"audio_pll1_out", "clk_ext1", };
+
+static const char * const imx8mn_gpt4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
+						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"audio_pll1_out", "clk_ext1", };
+
+static const char * const imx8mn_gpt5_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
+						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"audio_pll1_out", "clk_ext1", };
+
+static const char * const imx8mn_gpt6_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
+						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"audio_pll1_out", "clk_ext1", };
+
 static const char * const imx8mn_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m",
 						"vpu_pll_out", "sys_pll2_125m", "sys_pll3_out",
 						"sys_pll1_80m", "sys_pll2_166m", };
@@ -476,6 +500,12 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_PWM2] = imx8m_clk_hw_composite("pwm2", imx8mn_pwm2_sels, base + 0xb400);
 	hws[IMX8MN_CLK_PWM3] = imx8m_clk_hw_composite("pwm3", imx8mn_pwm3_sels, base + 0xb480);
 	hws[IMX8MN_CLK_PWM4] = imx8m_clk_hw_composite("pwm4", imx8mn_pwm4_sels, base + 0xb500);
+	hws[IMX8MN_CLK_GPT1] = imx8m_clk_hw_composite("gpt1", imx8mn_gpt1_sels, base + 0xb580);
+	hws[IMX8MN_CLK_GPT2] = imx8m_clk_hw_composite("gpt2", imx8mn_gpt2_sels, base + 0xb600);
+	hws[IMX8MN_CLK_GPT3] = imx8m_clk_hw_composite("gpt3", imx8mn_gpt3_sels, base + 0xb680);
+	hws[IMX8MN_CLK_GPT4] = imx8m_clk_hw_composite("gpt4", imx8mn_gpt4_sels, base + 0xb700);
+	hws[IMX8MN_CLK_GPT5] = imx8m_clk_hw_composite("gpt5", imx8mn_gpt5_sels, base + 0xb780);
+	hws[IMX8MN_CLK_GPT6] = imx8m_clk_hw_composite("gpt6", imx8mn_gpt6_sels, base + 0xb800);
 	hws[IMX8MN_CLK_WDOG] = imx8m_clk_hw_composite("wdog", imx8mn_wdog_sels, base + 0xb900);
 	hws[IMX8MN_CLK_WRCLK] = imx8m_clk_hw_composite("wrclk", imx8mn_wrclk_sels, base + 0xb980);
 	hws[IMX8MN_CLK_CLKO1] = imx8m_clk_hw_composite("clko1", imx8mn_clko1_sels, base + 0xba00);
@@ -501,6 +531,12 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_GPIO3_ROOT] = imx_clk_hw_gate4("gpio3_root_clk", "ipg_root", base + 0x40d0, 0);
 	hws[IMX8MN_CLK_GPIO4_ROOT] = imx_clk_hw_gate4("gpio4_root_clk", "ipg_root", base + 0x40e0, 0);
 	hws[IMX8MN_CLK_GPIO5_ROOT] = imx_clk_hw_gate4("gpio5_root_clk", "ipg_root", base + 0x40f0, 0);
+	hws[IMX8MN_CLK_GPT1_ROOT] = imx_clk_hw_gate4("gpt1_root_clk", "gpt1", base + 0x4100, 0);
+	hws[IMX8MN_CLK_GPT2_ROOT] = imx_clk_hw_gate4("gpt2_root_clk", "gpt2", base + 0x4110, 0);
+	hws[IMX8MN_CLK_GPT3_ROOT] = imx_clk_hw_gate4("gpt3_root_clk", "gpt3", base + 0x4120, 0);
+	hws[IMX8MN_CLK_GPT4_ROOT] = imx_clk_hw_gate4("gpt4_root_clk", "gpt4", base + 0x4130, 0);
+	hws[IMX8MN_CLK_GPT5_ROOT] = imx_clk_hw_gate4("gpt5_root_clk", "gpt5", base + 0x4140, 0);
+	hws[IMX8MN_CLK_GPT6_ROOT] = imx_clk_hw_gate4("gpt6_root_clk", "gpt6", base + 0x4150, 0);
 	hws[IMX8MN_CLK_I2C1_ROOT] = imx_clk_hw_gate4("i2c1_root_clk", "i2c1", base + 0x4170, 0);
 	hws[IMX8MN_CLK_I2C2_ROOT] = imx_clk_hw_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0);
 	hws[IMX8MN_CLK_I2C3_ROOT] = imx_clk_hw_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0);
@@ -549,6 +585,8 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_SDMA3_ROOT] = imx_clk_hw_gate4("sdma3_clk", "ipg_audio_root", base + 0x45f0, 0);
 	hws[IMX8MN_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root_clk", "sai7", base + 0x4650, 0, &share_count_sai7);
 
+	hws[IMX8MN_CLK_GPT_3M] = imx_clk_hw_fixed_factor("gpt_3m", "osc_24m", 1, 8);
+
 	hws[IMX8MN_CLK_DRAM_ALT_ROOT] = imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
 
 	hws[IMX8MN_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
-- 
2.35.1

