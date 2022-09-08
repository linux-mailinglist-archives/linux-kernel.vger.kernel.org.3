Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE505B29FA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiIHXMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIHXMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:12:42 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B5A109D3F;
        Thu,  8 Sep 2022 16:12:39 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c11so124443qtw.8;
        Thu, 08 Sep 2022 16:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7GbYCslF48I7fDwOVdzpc0jOBmHVLbyPOHBU4jxAGaA=;
        b=MNqblqXRv41x2WfZt9b7a2HBWyu40d86SzgQtgsU/Anvj2J1m2bd4UtWh+SSz+qO/4
         5I4/eB45HO7/in/fg02zNRFGVhvyScECnPJo7p4k2fvJTVj0Iv+cuegpxYNtSCUAmZh6
         O3AIjyrB/Tf6L5y3JKeluPozI3/HgR4gfRXWA+D/VaWnLMW5J/V7wamei+hUvYv8QTvQ
         M9VvEag02pIW1sUoqc2s9AbKyIF4jDJzbsw7I9SqB2kWLr5owyWx/ZWzwP5V0glCqS/0
         mFtmUkM/h8zV0kJAFoGwMoyBm9iy5/tlSJYXRPWm6uSqIqFJzny9bhIexPhR4WG+Rx4R
         pbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7GbYCslF48I7fDwOVdzpc0jOBmHVLbyPOHBU4jxAGaA=;
        b=ls2yqX2fAHizO3mkCEzJOjGEUqn5qY3AJFo/P9dvPfEAeTRtDGwRYSNgEIYZePWwgV
         7b/SkuWDVisr8PcAQ1Jy7tMU/O/NgKo18Du+U4HjlDGDZa2QYlMLOMpTX9kojEu/OrGf
         gx1vdAq+L9At/K5b3lGf2pXQ2DruptYjWoEfdENUX8QyFsZNOZtydtGcnqh+OWOd/qUj
         7BNMVeVwVsV8qwGivXpKIth/5zU+ZYqFrxd6rX7qY4YjGzKdrm1Pvy33TGkyaYUKFKm9
         10BN96cq6Z18dXprgKp/a/P2pucoIYHUYlY8qqcyqoSb2Dcn6iiJ5yoLqQTFvAjCvBEF
         I8rQ==
X-Gm-Message-State: ACgBeo0m9KjCxVD0wqwhXWRcs5uXQNiWEY2e2xzIGLqf/diOhkMqh2vR
        7KTioPax2kpQAKI2JmwDMlkp74N4z7k=
X-Google-Smtp-Source: AA6agR5OCtKJm7UxbDCgIiwuDUHGulzSLE9lv2MYOz31rzNNAlMdgP9wuSlRSrFEF0vzP1ucPflCgw==
X-Received: by 2002:a05:622a:15c7:b0:344:5321:5874 with SMTP id d7-20020a05622a15c700b0034453215874mr10130388qty.506.1662678758680;
        Thu, 08 Sep 2022 16:12:38 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::6f2a])
        by smtp.gmail.com with UTF8SMTPSA id s5-20020a05620a29c500b006b93ff541dasm117466qkp.8.2022.09.08.16.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 16:12:38 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        Joel Selvaraj <jo@jsfamily.in>,
        Richard Acayan <mailingradian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] clk: qcom: gcc-sdm845: use device tree match data
Date:   Thu,  8 Sep 2022 19:12:23 -0400
Message-Id: <20220908231224.209020-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908231224.209020-1-mailingradian@gmail.com>
References: <20220908231224.209020-1-mailingradian@gmail.com>
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

This driver will support more than one SoC's set of clocks, and set of
GDSCs. This behavior would be unclean with hard-coded static variables.
Support it by grabbing clocks, GDSCs, and BCRs in the match data.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 58aa3ec9a7fc..cd6e4e41dc9b 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3574,7 +3574,7 @@ static const struct qcom_cc_desc gcc_sdm845_desc = {
 };
 
 static const struct of_device_id gcc_sdm845_match_table[] = {
-	{ .compatible = "qcom,gcc-sdm845" },
+	{ .compatible = "qcom,gcc-sdm845", .data = &gcc_sdm845_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gcc_sdm845_match_table);
@@ -3600,6 +3600,7 @@ static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {
 
 static int gcc_sdm845_probe(struct platform_device *pdev)
 {
+	const struct qcom_cc_desc *gcc_desc;
 	struct regmap *regmap;
 	int ret;
 
@@ -3616,7 +3617,8 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
+	gcc_desc = of_device_get_match_data(&pdev->dev);
+	return qcom_cc_really_probe(pdev, gcc_desc, regmap);
 }
 
 static struct platform_driver gcc_sdm845_driver = {
-- 
2.37.3

