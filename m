Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB1599012
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbiHRWGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiHRWGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:06:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE6FD21F7;
        Thu, 18 Aug 2022 15:06:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c39so3563201edf.0;
        Thu, 18 Aug 2022 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=rXCQ8SbozupG6ha1H9wZwHDGGr1UUdJ24PVvc1F+k98=;
        b=qn5CAoIVHpQInp9BIT7gOkNmrutb2Ci1prwWfuAddCgSkrpdbHfyntWsKKfgPkgs44
         8UQYym3h8qBk9LSWTscOy/GeZxsfbxAPjcxIycTTWYuqsG3gx7N6gnckZCqHWSKpJJxO
         j9lOR9f6am7jmSfxx3VizQModuY3HRLCfBz+FnT9hjMXV1OD2289Ca5BPcdyfQCxv8G6
         FfQYhoIcD5eb+Y+nlBAAw+jzzXUzamGpRQolLg/WPKViRWshv+FywVcOb+4WtSMDeM05
         9nediODEpyS2l1vaPfbF8JpR16TVhcpZj6C0dG2NCVTJEJSeGeoeY+Hjtoq5ZFc4j+6G
         uldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=rXCQ8SbozupG6ha1H9wZwHDGGr1UUdJ24PVvc1F+k98=;
        b=zIOCTpLs0/NdRCvzM6bNNhAaYlTncCUhOqvNPz0iMrg+foaYcGu0CBVdyr47dThkGp
         hZ0im3PCJE82d3gMQGdFFPdBpLUo/Now8sCeakszfF/Q45DR2db5cP6h8Gqlqjyp5Vg4
         YeNOXuJVQGnHlJKprNtahEO/qfNhdeExktKCGHjWqD0mvpjBKrB0UMHRQXKLqXZwQECw
         bGBiJQrnueXEIjpnPlDy4UNQwNJTax9yLNH/XcHp9TlpwzzjPPRLN54PAljZ05U+Q2l/
         p6Hp/rCQfxveDRAWQJVww/6BvVuq8ezpKmD4bvCrclvIFsCWPwbRHyWdLPOL7i1zjORR
         ZvsA==
X-Gm-Message-State: ACgBeo0Fp2ar2/z0AFGm+dT0A+iSCrXBXf/A/vIDU9qQU+yzQ/NxYNZW
        MEtfaK5Smlur2F9EGfoUNerWUDYeO2A=
X-Google-Smtp-Source: AA6agR455XAlEKvdEXZh03rSWl/Cq/MwRL5ESK3iNkYuBOdA+v4ZUCmSFXNbYbvPrz93DjwqLNvMUQ==
X-Received: by 2002:aa7:d802:0:b0:445:e618:fae8 with SMTP id v2-20020aa7d802000000b00445e618fae8mr3817005edq.182.1660860393009;
        Thu, 18 Aug 2022 15:06:33 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id dk5-20020a0564021d8500b00442d5054a51sm1851584edb.87.2022.08.18.15.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:06:32 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 3/9] clk: qcom: apss-ipq6018: mark apcs_alias0_core_clk as critical
Date:   Fri, 19 Aug 2022 00:06:22 +0200
Message-Id: <20220818220628.339366-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818220628.339366-1-robimarko@gmail.com>
References: <20220818220628.339366-1-robimarko@gmail.com>
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

While fixing up the driver I noticed that my IPQ8074 board was hanging
after CPUFreq switched the frequency during boot, WDT would eventually
reset it.

So mark apcs_alias0_core_clk as critical since its the clock feeding the
CPU cluster and must never be disabled.

Fixes: 5e77b4ef1b19 ("clk: qcom: Add ipq6018 apss clock controller")
Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/apss-ipq6018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index be952d417ded..f2f502e2d5a4 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -56,7 +56,7 @@ static struct clk_branch apcs_alias0_core_clk = {
 			.parent_hws = (const struct clk_hw *[]){
 				&apcs_alias0_clk_src.clkr.hw },
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
-- 
2.37.2

