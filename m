Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4D5AFA4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiIGCvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiIGCut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:50:49 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4852F5;
        Tue,  6 Sep 2022 19:50:47 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id i77so10478054ioa.7;
        Tue, 06 Sep 2022 19:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SmSdW9i3EThjbK8u7yyNrPgrBdo5J6YHi3eeJSF4bF4=;
        b=lq37ClPxtvYFPIHiefWnLuttJUtWTSr8QnybwKMNtyAyuIO+jCk1JEDLP685+J2ile
         qX8yHJQZ60am0iNNMxMkGQVwrUjech2+mB7GlRoBB4mcjMICIjfB80AWBuaxIFjGYxmr
         hdsK6CzAnFUs9Rpq57+qQaZK9B7dQm5PHLXpaKdGSeF6y+n2Vz2/bj3hlyvy5lCiZrau
         p+HZZ/l3eG9VTEypYqPKue4RHqbegOVXQiwkLPaUxGR/pL+oP4PAJN2T/FnMBwaiS1Uz
         HzIv2dzTQOKL8mmp9an2p3IDc+qtJ8avdathBDhNjQWl8eytJ191APVkO9k/MoaYr4M+
         LUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SmSdW9i3EThjbK8u7yyNrPgrBdo5J6YHi3eeJSF4bF4=;
        b=0J0wflGp8w+twW9GToCJ92O6MWLFoZdP6GH4xokByIs2/M5mEC2fhgYf089lW+Y5eX
         l7NqqmDejkCL3k3QooC0tBiPmvSYd/D1H8zOB/s0qyBKJwwIcG7ToUGADsC924PezxxP
         n6cToZ1kbsEnwx+CT7LOWWGP+a5yO5TpEcBAfW6XrS6hA5sMKOpMDrNZE+/EGqikHcNL
         73ngXrRDxFZIeR4W5K1jVg5zchGsYzEf9O8/ZdKvH92Ejj3ihR46cw8QjFeedX0F8rMK
         sFy38W26h+jICUQo/W2Y/Fa12i9qpDcgKU1MzCEJNARXSQOL6+bEZwrMz77/6euhXkjm
         /qkg==
X-Gm-Message-State: ACgBeo1o+/iHy7xPbVm8l6Xt5QTqpAzGMAyGh1RVaHQulwV+GUKUu1Zy
        +FxJRKb+HfsfrymCQ1yVElI=
X-Google-Smtp-Source: AA6agR7p+8dmCEBpGW0DjpRAYF+h6xNMbC+lI5UV/OGwDWBKw0HLY8/23zgP3M5d4tvthfPawK+7kg==
X-Received: by 2002:a02:29c2:0:b0:34a:195e:9574 with SMTP id p185-20020a0229c2000000b0034a195e9574mr979850jap.79.1662519046481;
        Tue, 06 Sep 2022 19:50:46 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4aff])
        by smtp.gmail.com with UTF8SMTPSA id b10-20020a05660214ca00b00689257fef39sm6780836iow.4.2022.09.06.19.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 19:50:46 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in, Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 2/3] clk: qcom: gcc-sdm845: use device tree match data
Date:   Tue,  6 Sep 2022 22:50:34 -0400
Message-Id: <20220907025035.15609-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907025035.15609-1-mailingradian@gmail.com>
References: <20220907025035.15609-1-mailingradian@gmail.com>
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

