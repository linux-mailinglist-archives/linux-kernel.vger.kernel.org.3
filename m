Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C81E51EA0B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447091AbiEGUeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447025AbiEGUdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:33:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8209E26AC9;
        Sat,  7 May 2022 13:30:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l18so20101395ejc.7;
        Sat, 07 May 2022 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aekXutU6qQn7TvHCgvb/22PzNCDZUPryxE8p1lpIObE=;
        b=O312VQIjyYGWWkQQXEOOz2nSJU4st3VhuH2iaBWulF3jINfOKWb2iB5DTUyy8lhI+V
         qhRLsjtkwS+mqNAUmVDFt8Y8NlEph4DhcC8rRkByryODdxJoHIZri0IUlzVyxvE5pezW
         sFx3MBDGT3VWgXajWwq0nzZmxE/qdwTP2pLzjpofqPQGQdGp9hWxyLx1a9nOZLsbYhIn
         MotwiY8yUM+kG+6jPYvx10Yo48MlUeSGF7Rm+pFT+dkCzUi7Y8P/iDD6e6eRrMzK8IAm
         pZLrHOchoUUca+QXZD3mW+Wek1No+5s8jac3q6LwOiyg44IS8kRXjDsvaOD/kTD31ZVd
         NAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aekXutU6qQn7TvHCgvb/22PzNCDZUPryxE8p1lpIObE=;
        b=WaUEeXpIVlxKJiG3Ufm8tBfoNhP3oUGPC2AvEmA5iW9y3OjW52KZ2j+EfTiySzC7/d
         XLuNSOqGgBwjgYoALknQBP3VfUd6S6QrK6Nn5olt8pqjjUbvNaNRTKNS+Fbpa4qySScK
         +KZSBfFZ+ATHXwtfvON4yohBHMUyaPrd+kdfzYDfcts4tF/u+ckYC/4OTZJ3PI7SRC4M
         gls6hXKSOijX8Yed+g59EouelYw4MRd3ibetU0YR7oxW9RbmhlRsjXyzRL8h8350hYtn
         L9G5dS+HDGtju18zUZTOm4wSb7Jy49P7RT/wMO0y3qUihP7Lny31AbAGfAyenStXDD3g
         TYlw==
X-Gm-Message-State: AOAM5300hH9HSEZRkgsGRXhvyOker5maEiauB+bZBpBLUt5o7tpiCLX9
        tRzFrcC4faUDDHiMVM/dmPY=
X-Google-Smtp-Source: ABdhPJxn96hrjW3H8fK0t4I9UtYnFXfiaQynhBu02WS5/w5VtnP2jUBO600opUwpCdx/O/Ks8tx7OA==
X-Received: by 2002:a17:906:8806:b0:6f5:15aa:1f40 with SMTP id zh6-20020a170906880600b006f515aa1f40mr8448428ejb.595.1651955404975;
        Sat, 07 May 2022 13:30:04 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056402048b00b0042617ba6383sm3900777edv.13.2022.05.07.13.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:30:04 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 09/11] clk: qcom: ipq8074: add USB GDSCs
Date:   Sat,  7 May 2022 22:29:46 +0200
Message-Id: <20220507202948.397271-9-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507202948.397271-1-robimarko@gmail.com>
References: <20220507202948.397271-1-robimarko@gmail.com>
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
2.35.1

