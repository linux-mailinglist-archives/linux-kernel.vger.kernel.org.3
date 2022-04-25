Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB97A50E80D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbiDYS0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244345AbiDYS0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:26:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD9C8930A;
        Mon, 25 Apr 2022 11:23:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y3so10901158ejo.12;
        Mon, 25 Apr 2022 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sy9YYlqoJiTojSfiEVFCuiM/Ui3tj6aKx8yzbCiNSKs=;
        b=gWJUKBpSNwQFr5FQCSopcOkFGCSxYO3JlAbeOsu7x1AJ/1kgbLtOit+EL5oX5DYcy+
         yWAH3TZfoNrhUhWEeNahXRJFVDxeaZdPJ7N60qTt4EPNaF/NviRRjU8RxFcMXSHnStO+
         nFrHoZ3XKbFdlQtwQ6PHTJ3a2YRnSPlX5IYjeNIOB6O71ypz2zNzPh8S2iYgYvdFyDx2
         N8MWLfpyWU8qYxN8NwvGfSuxcd0r2mU32pAg9e0WnJCktAQRu1PrMMAUtuv5abhq4wKQ
         kXbJSZ4MaXf3eyNMUSOJj4cM48BpKqZDaMT9CSaIUogNMpIB1vXWWD0fJH4+LSMl0YJE
         AWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sy9YYlqoJiTojSfiEVFCuiM/Ui3tj6aKx8yzbCiNSKs=;
        b=5quaRHLe9z3i5gcqChriCo8JbFYW1haje4xMl4iELiQOQZeH1IBb+WOIS24E1sKIgQ
         Z69LmoaFgOaLThWwU6lZaryY672lo3h7caaU13zums8/YZReVMTvD5XNUA15FmRxdCQ7
         jC/Kc+an8o1nJVe67FjG080dzoCTlEV9HzvRnMt1EgRDJrU+Ae9q/mrQohm7WjcjXsiR
         El53BS1o5mFTxMuzZz5KQq2XPMJtgKJ3phuvcjvoNExg/eAoRkVmdf92iudk6H4YS1w5
         /7OkXD+fGWTkwLo1+cZKHsoruy8h12Rtm0eA1Dy28qD5ZMN2cnq2FW82FlT+zllZopSh
         3ZAQ==
X-Gm-Message-State: AOAM531PDlqhLhJctSQcQKOVqArlMOHr9DDTvT2l0/dGDlDtK3BN7WRY
        mkdAEw3Ro8yroNp8trIVh+E=
X-Google-Smtp-Source: ABdhPJwTJ8vN7QbZjR6I7kkhlLs864ySN5/U5PHeZeg8Vr/EZIRGA3WvQ+7FlD8PpWlxTuiA5NRUyA==
X-Received: by 2002:a17:907:1c92:b0:6f0:f17:14a with SMTP id nb18-20020a1709071c9200b006f00f17014amr17007620ejc.475.1650910979850;
        Mon, 25 Apr 2022 11:22:59 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-91.zg.cable.xnet.hr. [94.253.165.91])
        by smtp.googlemail.com with ESMTPSA id h13-20020a170906590d00b006f39021e683sm1677210ejq.12.2022.04.25.11.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:22:59 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 5/7] clk: qcom: ipq8074: add PPE crypto clock
Date:   Mon, 25 Apr 2022 20:22:47 +0200
Message-Id: <20220425182249.2753690-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425182249.2753690-1-robimarko@gmail.com>
References: <20220425182249.2753690-1-robimarko@gmail.com>
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

The built-in PPE engine has a dedicated clock for the EIP-197 crypto
engine.

So, since the required clock currently missing add support for it.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 37af41d8b192..e6625b9fab35 100644
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
2.35.1

