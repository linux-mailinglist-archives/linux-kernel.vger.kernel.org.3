Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86B95738EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiGMOcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiGMOcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:32:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBE0371BB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:32:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l23so20188141ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0Ax0PdKtlmgzbmNbUhdLibkqTiXlSi4GkpYNg2JX4o=;
        b=bhIAzdm2Lk25zrx8rWtQxYw4bytPtsGCTma3ouKJDy/7t8d10zxSzPzBU7YT7y6ESl
         SvyXrn3ipOnWCcLZSw7FdJFIi05yKCQbBiiaGiA3YKk+Ajb7ZD7rmCh9RInO6LJrx91+
         23rmy9eZhM1BJleZZ0vBXMGbroTphk7SxXFUjss/bBbHQSwW6xXMswAQPOFJBn6VTwm8
         AkLc6D2VH0GOSV/N2EWaifCDu1MfS1eOBFUynvOdLz793srhlHVfYT0mkhqEAnU+IBtx
         c8vGg6fxbHfW++cGg+2BOdj7EQ0D3p0dXVBP6Cy8cG0kQzhp08I/CSas3N9TaOSBYC7B
         3PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0Ax0PdKtlmgzbmNbUhdLibkqTiXlSi4GkpYNg2JX4o=;
        b=E6NPyPWpgQ4Ok0jjuknTnuTI5N0tyFn03veOeUviglyq7tVuWwfNKf9uj/EoY1zC/m
         V/ZP0BJZSj+1JuCBE9q8KLmwLto+n5pLtcKr52xacy3aYCzXzwLzvUtxDzTppcEfxiZ4
         djQrH6lSKX4LHYfViRrb6HBLVxhFdGnQJsw6zz/3KsWv90ejrR6VX5PCazZlmOTwdfbk
         5Lsd5HY7U0ozLzY3yR9rmeL5bvK44GdlPm7JQCvmjgulyt44gwSYQBCsGd4maLXYrlG2
         UpqLFL2z9rtVb8VrQEXMIMcs07Yjrg0mK0nRAU92P+oNHbC+FyguhydwYwXjuctq1bHv
         q4Vg==
X-Gm-Message-State: AJIora/y00iYPelN+Bxin/uujqAZ3Z/j0r+kk/JOlZW8nY8ivTAx6rxD
        0ZQBAr4Lq5bZEnDEpfGwoXY9EQ==
X-Google-Smtp-Source: AGRyM1tNOcFC6J6ie9N0++h/j65gss5vtM22Su6a8LM5NN2uZQk4leASWHsI8kAvCVTfGMqZq5QJ0Q==
X-Received: by 2002:a17:907:7f24:b0:72b:8e8e:11e with SMTP id qf36-20020a1709077f2400b0072b8e8e011emr3590198ejc.429.1657722736681;
        Wed, 13 Jul 2022 07:32:16 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id o24-20020a170906769800b00726abf9a32bsm5034731ejm.138.2022.07.13.07.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:32:16 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH] clk: qcom: Drop mmcx gdsc supply for dispcc and videocc
Date:   Wed, 13 Jul 2022 17:32:00 +0300
Message-Id: <20220713143200.3686765-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both dispcc and videocc use mmcx power domain now.
Lets drop the supply mmcx from every gdsc.

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 266e5cf39a0f ("arm64: dts: qcom: sm8250: remove mmcx regulator")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8250.c  | 1 -
 drivers/clk/qcom/videocc-sm8250.c | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index 39b344ebb049..709076f0f9d7 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -1138,7 +1138,6 @@ static struct gdsc mdss_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = HW_CTRL,
-	.supply = "mmcx",
 };
 
 static struct clk_regmap *disp_cc_sm8250_clocks[] = {
diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index 8617454e4a77..f28f2cb051d7 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -277,7 +277,6 @@ static struct gdsc mvs0c_gdsc = {
 	},
 	.flags = 0,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct gdsc mvs1c_gdsc = {
@@ -287,7 +286,6 @@ static struct gdsc mvs1c_gdsc = {
 	},
 	.flags = 0,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct gdsc mvs0_gdsc = {
@@ -297,7 +295,6 @@ static struct gdsc mvs0_gdsc = {
 	},
 	.flags = HW_CTRL,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct gdsc mvs1_gdsc = {
@@ -307,7 +304,6 @@ static struct gdsc mvs1_gdsc = {
 	},
 	.flags = HW_CTRL,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct clk_regmap *video_cc_sm8250_clocks[] = {
-- 
2.34.3

