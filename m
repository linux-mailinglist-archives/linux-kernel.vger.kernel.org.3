Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFA5527A43
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 23:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbiEOVB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 17:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbiEOVBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 17:01:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CDBDF68;
        Sun, 15 May 2022 14:01:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq17so25276418ejb.4;
        Sun, 15 May 2022 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5Mlp4MlPX47xiT5PAs3WlBL8yry+8fZ0v7z+93yv/A=;
        b=V6NJiJdQMSKmXj5nIF1KxDALUTPue0qi/+9Ay5DrugFOZUGZziNjp+1eRwRLZPd3Tw
         FT+hHc3qBRc4xd0ETQ2A5th0aHyzxj65hJXDaVZ4RYREFR70jMy9Rx7p3gfYsgn/cuHe
         BJ2Kt+UagTPD0R3ah4C1yRFcD6Jetv0PahmXiZSyxJs0gUSdwaTi8sLnyUel3KiSLL1F
         2vnVBqlkJh9hMk80g3EHERrGtdATqgSndlAtLtDidayklRc7xWWnzdt2czoKJDhz0kZe
         bVYtbgXhGykfrRPwkcM2IpNfa8IzV1+eOe+OEKF7CvXNs4BNWsqrGV65KLjsKXZFkpn+
         w9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5Mlp4MlPX47xiT5PAs3WlBL8yry+8fZ0v7z+93yv/A=;
        b=iw62XeMVqkFIfI5aPw/XVW0g4JTLR9u4e6BpedBl3qhp5yEqMi3nGpI5MHUsXo9m0J
         V8M9v8iy/pJOFr1LBUaFR9B+zlq9WFrofxJK41RncF5Qy/5IstLqb8TYM1KBTtaSvyVc
         HAzelsMlkiS006f1A/eNgS7lOQP9FLtUzR+m469Y5DjdyRixBrTK91oT1GuLuSwnAF4R
         e1tqfUmkV4vJRMxEf2cXvp57jMVh2zwaVpp0LcHguXIdW6wqX4G/yzjIu6e1FDn6VAEo
         /f4LMPr7NUiK1k9HPeUVc1oX6WWYrD8MldDHmCyll7pRaAGuOPAUkp1xAMIOxrBYtmM/
         SspA==
X-Gm-Message-State: AOAM5304I/uqATbTvioqTw/N6ETGGfL1wi530QAjhn78JqJ0NdasLvZQ
        UQNjE9era/1Lrx5Il69GDoU=
X-Google-Smtp-Source: ABdhPJyfbDHmxnETtisFSULc3VaOS7HbMiPdGO5yeOCaNDbXSKbT+wYIi84CIqptaR6cw1eI4/BoCg==
X-Received: by 2002:a17:906:ed1:b0:6f4:ebc2:da8a with SMTP id u17-20020a1709060ed100b006f4ebc2da8amr12612170eji.126.1652648460789;
        Sun, 15 May 2022 14:01:00 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id w12-20020aa7da4c000000b0042ab649183asm28917eds.35.2022.05.15.14.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 14:01:00 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 09/11] clk: qcom: ipq8074: add USB GDSCs
Date:   Sun, 15 May 2022 23:00:46 +0200
Message-Id: <20220515210048.483898-9-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515210048.483898-1-robimarko@gmail.com>
References: <20220515210048.483898-1-robimarko@gmail.com>
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
2.36.1

