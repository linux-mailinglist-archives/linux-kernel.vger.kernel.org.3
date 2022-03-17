Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD4A4DD0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiCQW0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCQW0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:26:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DABD23576A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:25:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ja24so8216046ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZfilmYHEofOtZGObUor2LVeuuotlJwuDmGStM/5HWM=;
        b=LBQun4ZLprJhQy4lcg0rlMkxjD8+w89BISbRA+6e0n3Ak3QuX8r6xRyTrgXzs0KtMB
         okDzOO/8IitcG9YyjrMAheUDkE2T4AujZBiSmk0rdhiy5FBOQgZMgwOktfR2ujZPwD0H
         zdK3ZGIjCuNJ9lvC7vq2eMia1HZit0wfwquyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZfilmYHEofOtZGObUor2LVeuuotlJwuDmGStM/5HWM=;
        b=3ATVfAJng/CMoLu9doy4U0cW7qZSlkleDzMxlK8rEX3isEg4l9UxrZAOkBy2pAAV7G
         HZPxNv1IsCBJE7/ozyexd25WObwGmieaK06vMVnleeXDs3aCkWjGKBGy6Tav+0Y6X7sS
         Dx7WsVWOJtndteGLPA7Yykcc2N5eUQ1qnXX6NW02dTFln51mOHZeztM0yR2q8hLo3LAR
         FRVT2TDslbtK80go/sOVRKR9eDlvj5mgBmKKEsD7bAryTqAIeLEQc1TpeifWZ2DIcnqN
         cFqkcdXTT3k0aJNwBSV5ou0puzI8UsfO+9FEFTpWn99UxGYfNvQcMqiDmhXixPzXxH8e
         YNXQ==
X-Gm-Message-State: AOAM533In3/Bev/aZhLT3dX7V6FEMglQNbtFymyN9O2gSEhUC/wqnrFc
        E6L9foYV+NjmVD1RJ/oRRrrniQ==
X-Google-Smtp-Source: ABdhPJx9aL6eUBg4QeYDzR9Is7l5WFiUmAXRHp8oQLBL72F7SPxk1C+Qifc3fVbeWStLorfagn5wxA==
X-Received: by 2002:a17:906:a213:b0:6b5:b0f9:7567 with SMTP id r19-20020a170906a21300b006b5b0f97567mr6600807ejy.129.1647555927534;
        Thu, 17 Mar 2022 15:25:27 -0700 (PDT)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906161800b006d420027b63sm2949654ejd.18.2022.03.17.15.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 15:25:27 -0700 (PDT)
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
Subject: [PATCH 2/2] clk: imx8mn: add GPT support
Date:   Thu, 17 Mar 2022 23:25:21 +0100
Message-Id: <20220317222521.170762-2-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317222521.170762-1-alvin@pqrs.dk>
References: <20220317222521.170762-1-alvin@pqrs.dk>
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
 drivers/clk/imx/clk-imx8mn.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 92fcbab4f5be..aa7c6e02733d 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -227,6 +227,30 @@ static const char * const imx8mn_pwm4_sels[] = {"osc_24m", "sys_pll2_100m", "sys
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
 						"sys_pll1_80m", "video_pll1_out", };
 
+static const char *const imx8mn_gpt1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
+					       "sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+					       "audio_pll1_out", "clk_ext1", };
+
+static const char *const imx8mn_gpt2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
+					       "sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+					       "audio_pll1_out", "clk_ext1", };
+
+static const char *const imx8mn_gpt3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
+					       "sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+					       "audio_pll1_out", "clk_ext1", };
+
+static const char *const imx8mn_gpt4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
+					       "sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+					       "audio_pll1_out", "clk_ext1", };
+
+static const char *const imx8mn_gpt5_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
+					       "sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+					       "audio_pll1_out", "clk_ext1", };
+
+static const char *const imx8mn_gpt6_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
+					       "sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+					       "audio_pll1_out", "clk_ext1", };
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

