Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5E51ED1E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiEHKxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiEHKxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:53:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC2CE0CF;
        Sun,  8 May 2022 03:49:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j6so21837962ejc.13;
        Sun, 08 May 2022 03:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LhdyFUF6lZ0ZAM234mZVD3RqGmEW+gwWcf23USU26BQ=;
        b=Lamwd2r87pQHyK9oPjh6gAmpP7nLMeVNiIHKL2taohQDlJOfnFCATD00O4R4FTLWkw
         RdtMJz4vdiGIaX9ihC0MelO3Tt1rUKktxHr51B9G0A/0FwnCIVGXvd4IfMNDa8+XF3/7
         YCkHZppgAi0LFSFCpyMPcI+2wVG0Yfclb4WFlN+f3uG/aLFcVtAbnE0O979lJVJhI57U
         fJLMUb/UQFo3plXKxfCWurLvLs0PxuZJU70BhTfomfry6Q6ipx6JiBwikm5VK3eVpbFT
         5RGy2nT5w/ZmC8qFSjf5YaUL8SyN+Xv/xaDQg1KThp8SGfAjPtjOzbrMe5Id9la+bJsa
         Sd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhdyFUF6lZ0ZAM234mZVD3RqGmEW+gwWcf23USU26BQ=;
        b=pCQJiTQvOl1stRP/SDJrjQ12xCtDWQAnPn+fJyDDirQKjfnqJhGoRaqPbyoaeHa42h
         Z69V4r4M1DhxsAQKv4JRh6y+BKMM8ShAxdZ0QWIMmdup43jlBy+9B7c1zFwM2dTXUutg
         MI0CfikpfFsteyGJ6DXgSBKOF8p9jsG95ov9A1tiMZuPWj6ORDdiRgueRJeySdkh5J+B
         8off0LdqYa70GFxlc51oyGcxf45hoTCY6KqTEUXCW2ybck3DU6ssWTeJ4H9wIwJJqDwP
         j42GD00qMnpDj0McnH1HhMtOvUAeX+CzVd6Ek4rWnUAzXFmQDcLxOwSbaM2iNTd31Cw5
         EWxg==
X-Gm-Message-State: AOAM533pqefx+RidP61BiL+qI0FOXPEoOfEj8hGvtCKCID809gO4NwDk
        BH0ODrhpVBUohVsImqBStgc=
X-Google-Smtp-Source: ABdhPJxaK1R8JK60+GOYGt4Pk+XE/lRbVgZ3mOIsnkicE3rPNXymgeYtsOvLdXpN11a7+0fXNLnCFg==
X-Received: by 2002:a17:907:1c82:b0:6f4:60e5:1ddd with SMTP id nb2-20020a1709071c8200b006f460e51dddmr10116004ejc.274.1652006951691;
        Sun, 08 May 2022 03:49:11 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id hg12-20020a1709072ccc00b006f3ef214e0csm3917471ejc.114.2022.05.08.03.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 03:49:11 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 09/11] clk: qcom: ipq8074: add USB GDSCs
Date:   Sun,  8 May 2022 12:48:53 +0200
Message-Id: <20220508104855.78804-9-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220508104855.78804-1-robimarko@gmail.com>
References: <20220508104855.78804-1-robimarko@gmail.com>
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

Add GDSC-s for each of the two USB controllers built-in the IPQ8074.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Use proper GSDCs instead of raw regmap writes.
---
 drivers/clk/qcom/Kconfig       |  1 +
 drivers/clk/qcom/gcc-ipq8074.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index d01436be6d7a..00fe5f066de5 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -166,6 +166,7 @@ config IPQ_LCC_806X
 
 config IPQ_GCC_8074
 	tristate "IPQ8074 Global Clock Controller"
+	select QCOM_GDSC
 	help
 	  Support for global clock controller on ipq8074 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 85076c1383c7..3204d550ff76 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -22,6 +22,7 @@
 #include "clk-alpha-pll.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
+#include "gdsc.h"
 #include "reset.h"
 
 enum {
@@ -4407,6 +4408,22 @@ static struct clk_branch gcc_pcie0_axi_s_bridge_clk = {
 	},
 };
 
+static struct gdsc usb0_gdsc = {
+	.gdscr = 0x3e078,
+	.pd = {
+		.name = "usb0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc usb1_gdsc = {
+	.gdscr = 0x3f078,
+	.pd = {
+		.name = "usb1_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
 static const struct alpha_pll_config ubi32_pll_config = {
 	.l = 0x4e,
 	.config_ctl_val = 0x200d4aa8,
@@ -4810,6 +4827,11 @@ static const struct qcom_reset_map gcc_ipq8074_resets[] = {
 	[GCC_PCIE1_AXI_MASTER_STICKY_ARES] = { 0x76040, 6 },
 };
 
+static struct gdsc *gcc_ipq8074_gdscs[] = {
+	[USB0_GDSC] = &usb0_gdsc,
+	[USB1_GDSC] = &usb1_gdsc,
+};
+
 static const struct of_device_id gcc_ipq8074_match_table[] = {
 	{ .compatible = "qcom,gcc-ipq8074" },
 	{ }
@@ -4832,6 +4854,8 @@ static const struct qcom_cc_desc gcc_ipq8074_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq8074_resets),
 	.clk_hws = gcc_ipq8074_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq8074_hws),
+	.gdscs = gcc_ipq8074_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_ipq8074_gdscs),
 };
 
 static int gcc_ipq8074_probe(struct platform_device *pdev)
-- 
2.36.0

