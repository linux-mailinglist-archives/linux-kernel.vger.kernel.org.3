Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39AB51EA09
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387300AbiEGUeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446940AbiEGUds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:33:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BB017048;
        Sat,  7 May 2022 13:30:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l18so20101395ejc.7;
        Sat, 07 May 2022 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZvwpsTuNNY2QM4J9Gfm3Onc86YrwY8xfFuqMd4xZS98=;
        b=Nd6HniGip2fEmspwZImYlPY0jXyufFZaxWOmTHax7KB0Lv7tMip837MZNUy5Qha52z
         ijmySf/kZwxYKrgbLwl6Hu5IDWsO9VqlKI6ccSd2siznSwXKRlJ6+qGUhGnh07HQmenx
         LAFh//BO6/JZir2BhoBkcf4nWDwwCNeqj7sObP9wi9zMHZJuY0LSY/hjGPb7nj8Q1ffs
         r02uTfv2RY5e0qkoyFGfdDjxuftaZwAyJZXga7Y06PDcSJh6GCHuBcWIjlZvmbaEjGba
         v0WB8J3IhQrWY7afCDf9FbvHN545SurzCMsyZdIoT7IQfgM0rWSDOXhc9Hx6lqx5tM1c
         cZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvwpsTuNNY2QM4J9Gfm3Onc86YrwY8xfFuqMd4xZS98=;
        b=6QuakEGtcY3PfUVHT1Ttf4Q5JU4JDT2BadNff9QTwTX8l/Xok61novZtqcw17lslFv
         mAtSA7L53laaC1rbihnX/auYGiMXcSQSkb2xgdgziQ2GJ3p16J/Dt3FGWnrNS/DvNrK4
         CM0J+PBrgDNcfhqqY4E1uCPXrkZYfqNywEH5x2xJBcov+G3XmgGCxXmpGhd3u3sHNhcN
         pJSFE0qtgvWv/pkBjFtJrGLjbnnofUKVNPGthh6h4XnxbSNRv3PQDcPaTj4eoPKXvspU
         Er0CzmTbiUxJyH61pVwynxIS4uZWCFxoxB0JwWiFkxRKaB5DOnefTFxkDB2lCrJ2jlEa
         6AAg==
X-Gm-Message-State: AOAM532q12/TpTN41trm8462mSvedtYgjEchq5a0E9aSSJnpFY8nVsg3
        G/11+xR5GNrC/xfxTPNoqMU=
X-Google-Smtp-Source: ABdhPJwuL1uV0cmyuv1gxr3r5s91t5zVFDsOvRkDQfcw8KqKS5DCswu7qbKB0JNCa95JlBx1ScR1JQ==
X-Received: by 2002:a17:906:314b:b0:6d6:da31:e545 with SMTP id e11-20020a170906314b00b006d6da31e545mr8778513eje.125.1651955399459;
        Sat, 07 May 2022 13:29:59 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056402048b00b0042617ba6383sm3900777edv.13.2022.05.07.13.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:29:59 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 06/11] clk: qcom: ipq8074: set BRANCH_HALT_DELAY flag for UBI clocks
Date:   Sat,  7 May 2022 22:29:43 +0200
Message-Id: <20220507202948.397271-6-robimarko@gmail.com>
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

Currently, attempting to enable the UBI clocks will cause the stuck at
off warning to be printed and clk_enable will fail.

[   14.936694] gcc_ubi1_ahb_clk status stuck at 'off'

Downstream 5.4 QCA kernel has fixed this by seting the BRANCH_HALT_DELAY
flag on UBI clocks, so lets do the same.

Fixes: 5736294aef83 ("clk: qcom: ipq8074: add NSS clocks")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index c964e43ba68a..85076c1383c7 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -3372,6 +3372,7 @@ static struct clk_branch gcc_nssnoc_ubi1_ahb_clk = {
 
 static struct clk_branch gcc_ubi0_ahb_clk = {
 	.halt_reg = 0x6820c,
+	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
 		.enable_reg = 0x6820c,
 		.enable_mask = BIT(0),
@@ -3389,6 +3390,7 @@ static struct clk_branch gcc_ubi0_ahb_clk = {
 
 static struct clk_branch gcc_ubi0_axi_clk = {
 	.halt_reg = 0x68200,
+	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
 		.enable_reg = 0x68200,
 		.enable_mask = BIT(0),
@@ -3406,6 +3408,7 @@ static struct clk_branch gcc_ubi0_axi_clk = {
 
 static struct clk_branch gcc_ubi0_nc_axi_clk = {
 	.halt_reg = 0x68204,
+	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
 		.enable_reg = 0x68204,
 		.enable_mask = BIT(0),
@@ -3423,6 +3426,7 @@ static struct clk_branch gcc_ubi0_nc_axi_clk = {
 
 static struct clk_branch gcc_ubi0_core_clk = {
 	.halt_reg = 0x68210,
+	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
 		.enable_reg = 0x68210,
 		.enable_mask = BIT(0),
@@ -3440,6 +3444,7 @@ static struct clk_branch gcc_ubi0_core_clk = {
 
 static struct clk_branch gcc_ubi0_mpt_clk = {
 	.halt_reg = 0x68208,
+	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
 		.enable_reg = 0x68208,
 		.enable_mask = BIT(0),
@@ -3457,6 +3462,7 @@ static struct clk_branch gcc_ubi0_mpt_clk = {
 
 static struct clk_branch gcc_ubi1_ahb_clk = {
 	.halt_reg = 0x6822c,
+	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
 		.enable_reg = 0x6822c,
 		.enable_mask = BIT(0),
@@ -3474,6 +3480,7 @@ static struct clk_branch gcc_ubi1_ahb_clk = {
 
 static struct clk_branch gcc_ubi1_axi_clk = {
 	.halt_reg = 0x68220,
+	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
 		.enable_reg = 0x68220,
 		.enable_mask = BIT(0),
@@ -3491,6 +3498,7 @@ static struct clk_branch gcc_ubi1_axi_clk = {
 
 static struct clk_branch gcc_ubi1_nc_axi_clk = {
 	.halt_reg = 0x68224,
+	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
 		.enable_reg = 0x68224,
 		.enable_mask = BIT(0),
@@ -3508,6 +3516,7 @@ static struct clk_branch gcc_ubi1_nc_axi_clk = {
 
 static struct clk_branch gcc_ubi1_core_clk = {
 	.halt_reg = 0x68230,
+	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
 		.enable_reg = 0x68230,
 		.enable_mask = BIT(0),
@@ -3525,6 +3534,7 @@ static struct clk_branch gcc_ubi1_core_clk = {
 
 static struct clk_branch gcc_ubi1_mpt_clk = {
 	.halt_reg = 0x68228,
+	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
 		.enable_reg = 0x68228,
 		.enable_mask = BIT(0),
-- 
2.35.1

