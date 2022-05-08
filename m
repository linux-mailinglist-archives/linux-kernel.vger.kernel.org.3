Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F5751ED17
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiEHKxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiEHKw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:52:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AC8DED7;
        Sun,  8 May 2022 03:49:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kq17so21883319ejb.4;
        Sun, 08 May 2022 03:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNJHJYCxxfdyu7+KWLs4v3umHsmxXP/GIzj4jmPOymA=;
        b=CxjELPOVikgcjVOxG7YyyykGu9UvsfEDv54V2QwQeq/wT/HSE7mKv+ZhMBK1VQSsdP
         39FIM4DBRka467X4y1NeEqmLwL17awfYMJjNjgTerUQeG602OLFA4G8/cgBshFXjRZEe
         4tH8nRb4n2kHgGBci+njBD30siRECHKzYAlMFHTV0crAlPkh1x2QUUOnmU3ZL+Z2E9wT
         GBNgudcKTVHO50vf+3sDB4T1A0glvuqSoksbZuUWY40ffhRssb4D/d4HpzfuxYoPLGdp
         y4U+khzJP0KWGazJK5uU+46Se7zGV1y+vZ6V84ivFJwHUk1bYltyg472dnYtGq+mKlRg
         apHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNJHJYCxxfdyu7+KWLs4v3umHsmxXP/GIzj4jmPOymA=;
        b=RIKCumN7jgAURCFt8+xhEakkCmekLVEkfMxDkSocV5aZ/DfZjuXPJNiuXCwxhaHM89
         djOiLJgbVXOLomrWIx2qCyIaH9z3mkRPpQsyxhSSpTx4Whk07yeK23DlzWFiWOX0tbzp
         WpyJaeEABn4Lp5h+OOUTFUstczCqBngKvLhCQPcOI77sW9uH6WLhZhZLSJoqEHM+o4TN
         LfMrPq+rCjfzMZdjAIMKv+onqUrE46FFngQaohrFR7LrZGdxLCG+40zImcyfqwroinVd
         qw9TqdxUymmvdWK4kwvX/n1gbPDdNHg3Z7y1P1P+w1JAomMEk/vRa9+Qs7ckQhMvWuM4
         SG8Q==
X-Gm-Message-State: AOAM531sHb9IudUDru4B2ByC4qN0vMMfUBa3ZTaUFepP6lmp+jRZacth
        KNE6P7BtY0ornprqmkpF4JZNrIMBGk1E0Q==
X-Google-Smtp-Source: ABdhPJx4bFCFRoz0wS2CeD69sikc10lLJ83QKVyR0kP7wAwynFMYO5H4p4u9DqfhCTh8XK8RZKRX+A==
X-Received: by 2002:a17:906:a08b:b0:6cf:65bc:e7de with SMTP id q11-20020a170906a08b00b006cf65bce7demr10564954ejy.220.1652006945769;
        Sun, 08 May 2022 03:49:05 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id hg12-20020a1709072ccc00b006f3ef214e0csm3917471ejc.114.2022.05.08.03.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 03:49:05 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 05/11] clk: qcom: ipq8074: add PPE crypto clock
Date:   Sun,  8 May 2022 12:48:49 +0200
Message-Id: <20220508104855.78804-5-robimarko@gmail.com>
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

The built-in PPE engine has a dedicated clock for the EIP-197 crypto
engine.

So, since the required clock currently missing add support for it.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index f1017f2e61bd..c964e43ba68a 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -3182,6 +3182,24 @@ static struct clk_branch gcc_nss_ptp_ref_clk = {
 	},
 };
 
+static struct clk_branch gcc_crypto_ppe_clk = {
+	.halt_reg = 0x68310,
+	.halt_bit = 31,
+	.clkr = {
+		.enable_reg = 0x68310,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_crypto_ppe_clk",
+			.parent_names = (const char *[]){
+				"nss_ppe_clk_src"
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_nssnoc_ce_apb_clk = {
 	.halt_reg = 0x6830c,
 	.clkr = {
@@ -4644,6 +4662,7 @@ static struct clk_regmap *gcc_ipq8074_clks[] = {
 	[GCC_PCIE0_RCHNG_CLK_SRC] = &pcie0_rchng_clk_src.clkr,
 	[GCC_PCIE0_RCHNG_CLK] = &gcc_pcie0_rchng_clk.clkr,
 	[GCC_PCIE0_AXI_S_BRIDGE_CLK] = &gcc_pcie0_axi_s_bridge_clk.clkr,
+	[GCC_CRYPTO_PPE_CLK] = &gcc_crypto_ppe_clk.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq8074_resets[] = {
-- 
2.36.0

