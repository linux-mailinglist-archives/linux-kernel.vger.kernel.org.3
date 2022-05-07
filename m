Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7956151EA13
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358007AbiEGUkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiEGUkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:40:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119EB1401C;
        Sat,  7 May 2022 13:36:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d6so12151402ede.8;
        Sat, 07 May 2022 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=noiLEGjS69TNqfsR+PPtmcT72BXbzXlEteGUOjRdti4=;
        b=BbA6bRIpdAWpIV9pvdRT9NeS4/gk+YGmY08PtHTCbxrs+qXW6etY3ymmfXnazN3urS
         7IGH2l1Mjy/4xZBCzzsxtakmF6IuP8rIWpTNwhsGaiM/NAWfQA8ocCwU3Rl/q6xXQp5F
         318mY0SRMIcKA5uVV6ffp/wA1IYqwhZ0nW9RLZ1eE/7JJRbhS611lp2qmAr5htzK+vkM
         k2MrrZGKepeqdwyTTyYk4AXm8AW6daF+ksb3D/4GVO8E8V0aswRNg8FIQAqDwAxx+5wR
         K69uS2wNfMhsrxNy8L6aImVDTCyjoAYhhehkJHZef2wtWyweTdFoyn+U3phI4hge2JvO
         ZBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=noiLEGjS69TNqfsR+PPtmcT72BXbzXlEteGUOjRdti4=;
        b=CR5XB2CjLeJ+7uVsfvY2D6YTh++y1B9xdW9Ef0Mced3yu5I4pNBZkfd/s5QS/J60VX
         93i8s7X7018g1UyRu8TzcionSxNpOmR2xBY//WfZZSAWrTYPtsleJNjKqleeKvrW9qoE
         Jx2eCk8wKXr8IDRhJgAmUrwxYYJEN4RwZFmbPhGgIJjwTOnHgOVYpmlN7prOvxk6yGzO
         q2lOC0fSvbI54gDS7gMmLhSzZvFPztd0J6Y587YfyZJslXPmyc9dPws/AD7GrY6kXhlg
         IbnRxi1++4JEgpzOdg6ItQZE5h/ien08G+O0qMMJaoRswJO2AjGmUs6I/c4Y6fV83B2x
         eBcA==
X-Gm-Message-State: AOAM532slQb3HDdPjZvO8nXdxm+novSWcJ17lAjNRfkW343QjFM8P/Jz
        Qzl/E2HO//WSWj1sJoHMEkQ=
X-Google-Smtp-Source: ABdhPJxFYtQqx07mssLwTTmx7D8Hn0EBF7PbzlW992Y0hSoBrZ3bUfAwQiFX/5Kffi1SkxyloczqBw==
X-Received: by 2002:a05:6402:2318:b0:425:dd87:b4cd with SMTP id l24-20020a056402231800b00425dd87b4cdmr10111077eda.316.1651955783612;
        Sat, 07 May 2022 13:36:23 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id eb20-20020a170907281400b006f4c557b7d2sm3283456ejc.203.2022.05.07.13.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:36:23 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 1/6] clk: qcom: clk-alpha-pll: add support for APSS PLL
Date:   Sat,  7 May 2022 22:36:15 +0200
Message-Id: <20220507203620.399028-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
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

APSS PLL type will be used by the IPQ8074 APSS driver for providing the
CPU core clocks and enabling CPU Frequency scaling.

This is ported from the downstream 5.4 kernel.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 12 ++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 4406cf609aae..8270363ff98e 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -154,6 +154,18 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_TEST_CTL_U] = 0x30,
 		[PLL_OFF_TEST_CTL_U1] = 0x34,
 	},
+	[CLK_ALPHA_PLL_TYPE_APSS] = {
+		[PLL_OFF_L_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL_U] = 0xff,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0xff,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0x24,
+		[PLL_OFF_TEST_CTL] = 0x30,
+		[PLL_OFF_TEST_CTL_U] = 0x34,
+		[PLL_OFF_STATUS] = 0x28,
+	},
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 6e9907deaf30..626fdf80336d 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -18,6 +18,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_AGERA,
 	CLK_ALPHA_PLL_TYPE_ZONDA,
 	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
+	CLK_ALPHA_PLL_TYPE_APSS,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
-- 
2.35.1

