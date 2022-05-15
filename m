Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A308D527A42
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 23:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiEOVBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 17:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiEOVA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 17:00:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D7B7EC;
        Sun, 15 May 2022 14:00:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id en5so1909474edb.1;
        Sun, 15 May 2022 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tS71jE0WRdd742PGPX4S4NYBMalYLsRNuQATyXyB9rQ=;
        b=MHIz8aAXaKnFCMDAo6pZ92tifX30ncDe6+JJ5nxhXQMRDk/fFbhzy5tukIYRCq+zhy
         sUH28ulMlPcE8FD3lgnd1gl/omrrnbOteMf/t99NCzd9bykkcl9WeZUFAsX94B/ka46i
         Q/BVFvA6PdmG0z/c8+CktQ853xx4GCaF4vcg3JhslFkanDdhScIgSse5J872WtNyRBJu
         CRORsZfBv8gU2iBLUCBGO9ui2tbgWDHqVHs8JNwFItllRpl7qDY+mm10Bh8gTBUAixiX
         TqGnb01Z8ubeP+H9MtoBrLSNYVE2et5UNoivSfoR+28Ux4PPFdqxi7r/x4CNZaurR9XD
         AwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tS71jE0WRdd742PGPX4S4NYBMalYLsRNuQATyXyB9rQ=;
        b=aMe3p3wa0FX3RsUJALVOAxPSP3IfLl9H6XjF64KlPjL1iMn2e7nTLm/pDo7FN/0FTC
         hvyehf2lzR4H+1kJVXpSboxzfZprl7JMebygmiVp+UywCZPPH7ZX6OfJWnsy3pyA4cQ0
         dh1OKl/5FF9D3d/WZGqAE8nV91lPuQH5EBmoJUaQ0yJqD5t3V0bcw1ulIk30io3FhSvZ
         zNsPs5/iPQUhM+E8BWEeXkCWarbqnR2gbRMps61DOvHwXbsSj9yd1OsCK5WsUWFtNbzD
         yO3qd93MxFoj+qCwMT4F18hPX+m+XAjOP8FWrPtuQqVT7uVbbI7gBuAnE+RyaWs4ckSI
         2fmA==
X-Gm-Message-State: AOAM533fSLSZul8jlrKcGoCs05vXB5BsFoZy9JoRqobNmf1HZslzlXkL
        VVQTDomqL/7ZxOC6LtmhuXc=
X-Google-Smtp-Source: ABdhPJxFez/HsR9DDAfOesc1EVfyxsuhw1jTY0AN2DAooKGwjY8PEwVOLrdJjMndhBKxfBuv9CL1Xw==
X-Received: by 2002:a05:6402:1148:b0:413:11e0:1f58 with SMTP id g8-20020a056402114800b0041311e01f58mr9798398edw.113.1652648456228;
        Sun, 15 May 2022 14:00:56 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id w12-20020aa7da4c000000b0042ab649183asm28917eds.35.2022.05.15.14.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 14:00:55 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 05/11] clk: qcom: ipq8074: add PPE crypto clock
Date:   Sun, 15 May 2022 23:00:42 +0200
Message-Id: <20220515210048.483898-5-robimarko@gmail.com>
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
2.36.1

