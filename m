Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F0856AF50
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 02:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiGHAD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 20:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiGHADs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 20:03:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF6832ECC;
        Thu,  7 Jul 2022 17:03:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o25so35093360ejm.3;
        Thu, 07 Jul 2022 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TYMK3ln+pSNgbS7KOrXcaQql59e3lfO5o9Vh/Disa6M=;
        b=ZKbpRToMi6jyV3hwOSo1uUsp5A2qXN9wFJRa96gvk196hYnz5W3lWtILMPKgf8xOGU
         bU1bhSXK8XyDOv8nUKBXkkWGah30Ri55I/NA579nXfDv+atLw72BWOSDnRDx/KpRnSDP
         8/xGLCYDLOFfb82kEw8H66uEm7EJcHL8DQG2m+WA/aTIHBgjbvU2JJBBGaoNRd0aUJE/
         DKDYrFNkXxKnGv+RfPtS1PIYW3y1vrVVPBoFh8o79KEyTeJ8HyG+QckLe7R8BsbBkIi4
         spZmqNJ+9KkVf1lcfcbZov4st15H3888ekogdp/JXMlUCjVCZM49Q+y/R1NteVPigpLh
         2zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TYMK3ln+pSNgbS7KOrXcaQql59e3lfO5o9Vh/Disa6M=;
        b=nxOmtlXAA4zMFK12h1VOuUcy+tPGcfp9JmXU1MuZQPAthOVANGIItSVRgjKU0ZBndy
         2ZJmGaqzaUVC4U31Ai1+D84w0ndFBrwOCa90TnOG0eMr7b5W79IxW6U/J34Fc13HtkZi
         rvOgxMOHLIU6xG29Mxn68M+Jv8SvylWGi9WFottH6Co2QrUbvjPzOSEFgz5b/MusCuD2
         DpJ475XbP9LOI48ZOxHK2P7xYWFn5MKikI2kSmRnWtgaT+hmb1YiMDRO+vFHKBqpO5Em
         6dh01HC+lf3YDtfKvLVTSW0TPpBZe5TEZF6PE4I4NTz88llDF5MRuSGMA+UBqFpX6/yS
         SpuA==
X-Gm-Message-State: AJIora/g6hlE8BR5QRckZtScL+TSv4dlpIZabsLgp02yleOap+0AaDc+
        7SesJlMcsW/W2iD3KKDLxzfpK6rOhwA=
X-Google-Smtp-Source: AGRyM1t4pyloHNZGA9pASfm2WanV0iZW7zYakCRtwY8j58Z8FEO85octSai0Bvt1jLmD8WQaVJ69ZQ==
X-Received: by 2002:a17:907:1b25:b0:6da:8206:fc56 with SMTP id mp37-20020a1709071b2500b006da8206fc56mr697039ejc.81.1657238624470;
        Thu, 07 Jul 2022 17:03:44 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id f22-20020a056402069600b0043a7404314csm8093974edy.8.2022.07.07.17.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 17:03:44 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 2/3] clk: qcom: lcc-ipq806x: add reset definition
Date:   Fri,  8 Jul 2022 02:03:37 +0200
Message-Id: <20220708000338.26572-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708000338.26572-1-ansuelsmth@gmail.com>
References: <20220708000338.26572-1-ansuelsmth@gmail.com>
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

Add reset definition for lcc-ipq806x.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
v3:
 - Added review tag
v2:
 - Fix Sob tag

 drivers/clk/qcom/lcc-ipq806x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index 1a2be4aeb31d..ba90bebba597 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -22,6 +22,7 @@
 #include "clk-branch.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
+#include "reset.h"
 
 static struct clk_pll pll4 = {
 	.l_reg = 0x4,
@@ -405,6 +406,10 @@ static struct clk_regmap *lcc_ipq806x_clks[] = {
 	[AHBIX_CLK] = &ahbix_clk.clkr,
 };
 
+static const struct qcom_reset_map lcc_ipq806x_resets[] = {
+	[LCC_PCM_RESET] = { 0x54, 13 },
+};
+
 static const struct regmap_config lcc_ipq806x_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -417,6 +422,8 @@ static const struct qcom_cc_desc lcc_ipq806x_desc = {
 	.config = &lcc_ipq806x_regmap_config,
 	.clks = lcc_ipq806x_clks,
 	.num_clks = ARRAY_SIZE(lcc_ipq806x_clks),
+	.resets = lcc_ipq806x_resets,
+	.num_resets = ARRAY_SIZE(lcc_ipq806x_resets),
 };
 
 static const struct of_device_id lcc_ipq806x_match_table[] = {
-- 
2.36.1

