Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0AD514867
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358608AbiD2Lqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358073AbiD2Lqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:46:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32AB252AB;
        Fri, 29 Apr 2022 04:43:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x18so10481340wrc.0;
        Fri, 29 Apr 2022 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=noiLEGjS69TNqfsR+PPtmcT72BXbzXlEteGUOjRdti4=;
        b=VBCT5w1S0mXJE2U2KRraF7W92VzzhpTIuk/ertQoUbVYS6V+zNOL/nC3B4Taz2fGIq
         3Tc/0cnzp082Zxar3Q/FWb9rgXdmmmT1ipDxYlxmQgKMfRzHTZCh1wzvBRy7lEmL89Wv
         jthJtdv/9NLhlkTlkCJmP2G/qYS4i7VTGIec0/gipIVHy5JiF53Hmxl4SzmlX33RWnvF
         SfV1sxWgJa4Hj+cdzESUhBUXblaYGwLWZGKy+32z8PpIfpEjQmvlZO/mxFcwlXr/zlgS
         a9UztJBAFJSHXfT83Evm3497rnkjzZs32CrHndY9uS0Mez35COZnKz5vUQjXdcUyCc4i
         +BCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=noiLEGjS69TNqfsR+PPtmcT72BXbzXlEteGUOjRdti4=;
        b=OdPA5Tk2qxpOepY+p6fEUUZR1pY65SAeu4aGkFwcrG4/Sll3zZ3lNEEpkA7w5RJYVe
         yEdAvx9+Ja9mwsLGWf/5JS4Pu6ReSbdc180CZ+kggWgLvLkiDaYXMNY0r1fQloN2apGx
         U4WtRKWpTG+R1ByIjwK8fPPIxIhCK8qxc4OdVZmyNndy6pFHIwBiYJUKN4YI8v5FgVJS
         46gJqO3LwD4cQRdCQAUqvcXVd1AMFjuK6luHr22lXSDII7e3qRlrW+mXP7M7nGf3Qtm+
         mEruR2GOIg3ql2143SLIm5uXvedK3cD72jZ0kxO6tV3J04osEsM5zQ+8Oa0cIwRzNpPJ
         52VA==
X-Gm-Message-State: AOAM531Lvq3AEOT2ejDqvJakIOzbeFvmTIjzyyXW2ckJfNArAELr8K/Y
        YKoi13QAynSBms3AvUsVCYo=
X-Google-Smtp-Source: ABdhPJy8R+fDWCVWIT8z/71l8GYePMC7jBJ8hyQmGdE9wl+d1vgnwHXdLIyUlbQ1WNfE9YmD9FTuVQ==
X-Received: by 2002:a5d:498d:0:b0:20a:dc6b:35c9 with SMTP id r13-20020a5d498d000000b0020adc6b35c9mr19684389wrq.176.1651232613260;
        Fri, 29 Apr 2022 04:43:33 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-183.xnet.hr. [88.207.99.183])
        by smtp.googlemail.com with ESMTPSA id l6-20020a1c2506000000b0038e6fe8e8d8sm2990900wml.5.2022.04.29.04.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:43:32 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/6] clk: qcom: clk-alpha-pll: add support for APSS PLL
Date:   Fri, 29 Apr 2022 13:43:25 +0200
Message-Id: <20220429114330.59026-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

