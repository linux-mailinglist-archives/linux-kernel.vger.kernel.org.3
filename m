Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BA351E9FD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447081AbiEGUeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiEGUdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:33:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BB8BC95;
        Sat,  7 May 2022 13:29:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so20105066ejj.10;
        Sat, 07 May 2022 13:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55DAttT0wioJdsCUuVQUMBFRWSPkGrAf7r5fkDcJSFU=;
        b=QotIbjq4oy5plz50K8j0OCUcC6S5yDKTI3314ifmsZpThiEzZqR7iShyXlCQtaCthX
         AqEH8kEz8TqpPDe0IIXWRhd/P9Wmj7GS8tmaj2ZqdELTiqO2AL1v4/dydN6j6x2JMLSY
         l9sx/LYT/Rc4Gh66RntAQsmhWAVN6VZyqCC5Q2C3vpalHCLVvf/GLSryrWAagzUjEkhP
         +YruJuAYv7V1/P8LQgm14pj8O4OPHt8ytKC31NoQBQZeRGN+rcYC9GIW/yXPPF6zxE+a
         TfWXLgXlsD4HXJ/HyUPBBgI2Ksje7mz8fXJ+8MrWdUQKAUllUzkF+0xZ3jmc7Ypd/LKf
         /FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55DAttT0wioJdsCUuVQUMBFRWSPkGrAf7r5fkDcJSFU=;
        b=LVpav7oYRIg1eeNu+DrlpGYVgCw1Z5UNZ4Q4v9pwJHV6TQzawaB0Id3oFJczzUvvLh
         LF6ebnGlCFyyRW1w8DRgWhYf1bFeNt1P2S8aFBT9m+LXtsG1WFUgVWYx2F5obq9D6jTe
         5GnY4uojyGk4nwVmwiFYKtZCBJMUEZHNMQYFZYToD4sNkIo4HjZBLETZNjQuucsT+Uwj
         Dm6DIpP9HSKiVTN6HPqsKJzhJZ0bTP9p41HrMCLO0wYFndsJLC7JN2qjFciesvs0TsQY
         Y2AF5inVw/IhiYgp886en7xQWBZz/DUM0OI85MPhLYiPOIpd49fNa7huZ8cxVDzvW9Ww
         AuOg==
X-Gm-Message-State: AOAM531ouCAgiQmwvZM0QyP1cI0TUlHt/FSInHlPvuOFcziFC/6pYrLZ
        2KQxGRWUZVXcQ1MCSAm8Oj0=
X-Google-Smtp-Source: ABdhPJzPkS27gmX56xEuowGDVfSEWgl/a+9IGyNX3O6Tbbi7v50inMH7Wv7pW1/0eaz7jNHGssBhoQ==
X-Received: by 2002:a17:907:2d24:b0:6f4:3152:3d1a with SMTP id gs36-20020a1709072d2400b006f431523d1amr8241676ejc.324.1651955396080;
        Sat, 07 May 2022 13:29:56 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056402048b00b0042617ba6383sm3900777edv.13.2022.05.07.13.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:29:55 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 04/11] clk: qcom: ipq8074: add PPE crypto clock
Date:   Sat,  7 May 2022 22:29:41 +0200
Message-Id: <20220507202948.397271-4-robimarko@gmail.com>
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
2.35.1

