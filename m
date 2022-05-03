Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3CD518D89
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbiECUAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiECUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:00:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B87536E25;
        Tue,  3 May 2022 12:56:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y21so21081267edo.2;
        Tue, 03 May 2022 12:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=noiLEGjS69TNqfsR+PPtmcT72BXbzXlEteGUOjRdti4=;
        b=S4q30YK8UtdzXlmER/cUQsmhgwwVII+w8iR7filfmKkbcqAmF7nwmMOzaGEQxi33QX
         XeoLcL/nkyeKnU+cEdMGePztwzXgHzgQUZ+O1cDm/UItbpWTqRAKM3SMgkgDpr8gtzsF
         WZ9j2tNhDzF3NAsc59l1NviXTPgNO9YGQAcjyld0lIGSOAQhrbYormdTVhrvsOm7sQl7
         0iGuW5b9cDLMH3VwOBZhq8OYqIR9mmeojFhqNVf7bSyKz+cG4ggFXNeUYdkyM7ANhfg3
         fSR4nNam307ymxFlxpXJY+PJ0SV3HeLs3cEKcWngxp1Y+AHtaCXgBnTiL+jKVHSryeez
         mGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=noiLEGjS69TNqfsR+PPtmcT72BXbzXlEteGUOjRdti4=;
        b=5FhvEvYYEQBJaCV1nam+0Y4EDD9sEwejlDNj44U8xAfc7CgB7EyLthilCoW3LCFbvP
         7ZyRMAmE2q3smG0fHZuwUr9JkxdXcKdq0Bot1QUCn7oExB09Nb3a9u6HAyMLmT3PTF69
         XV87h8QUS1MaxOZjs4L0PI+KDrNdp5iHzWavZ/LYfOXPZe4XWIMP0Iu//JjxC1aZtwar
         DY6QD2yfbGldLREAfo1iiTGIHvn4LpjxIZcHwyKY42UP0VAOOVKJ9/ZhNKlPuq/8DdKz
         41bmwxVA/05uC54UtKm4m/AapfuIHTjFRoeMn5azwNnCd5g+r5KMx3Tf77q3tO4SBTui
         9nLQ==
X-Gm-Message-State: AOAM532iEsZTT4Q94de9n9KgtojhCqeVsq9Ajpss96dtJgGrfFjdlJdx
        AgyLvRLCp4ROZaUKTg957DY=
X-Google-Smtp-Source: ABdhPJxZ/B0MK8Y13b0DpBCDP15xVOTmh/CUqB1zTVSt7z/hk14hIaljiq4B5rbSry7M4b+w0LNQdw==
X-Received: by 2002:a05:6402:278a:b0:427:d0e1:599e with SMTP id b10-20020a056402278a00b00427d0e1599emr8935785ede.58.1651607791072;
        Tue, 03 May 2022 12:56:31 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-149.xnet.hr. [88.207.96.149])
        by smtp.googlemail.com with ESMTPSA id i8-20020aa7c708000000b0042617ba63absm8229270edq.53.2022.05.03.12.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:56:30 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 1/6] clk: qcom: clk-alpha-pll: add support for APSS PLL
Date:   Tue,  3 May 2022 21:56:00 +0200
Message-Id: <20220503195605.4015616-1-robimarko@gmail.com>
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

