Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E3E5148C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358869AbiD2MHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbiD2MHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:07:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF04C6EFF;
        Fri, 29 Apr 2022 05:04:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l7so15054447ejn.2;
        Fri, 29 Apr 2022 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MAO8TPdkS/wAOL2z8gJwcoS1KWOSvDeDfX6yBFnKhlo=;
        b=TwcVT36ACatSdJjbWQLZgjEG36se8Dz+a5bmDrzbkrad5tPBuu0MiVBj5T8oGBgs0q
         K21iFlb7ZOEYoOLZR8s5Ir/5K8KNtWR1TCEwjFhCCARFESV9Si0DyyQLybpdJUEPm40A
         bbRNfOjaDrSqXwE0lNnuXOHZa5Lb7TxY3Y4/VAufcgTH5pzJEytuLlN3A1TEutvvGE5f
         3NCIj/zzcfR4K+jnHqPXUv1JsyiIkUZg+wSNG8wS6h7kGDaiG/rH7BOhLzEyciEtKEr/
         1aHZy5wbuKWWgTDR709B21Ga7CBrBPposaZDBdv5R7skC/qTh/A/wwjgFooMiP8jnIwP
         Nl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MAO8TPdkS/wAOL2z8gJwcoS1KWOSvDeDfX6yBFnKhlo=;
        b=mDK/tgc9QVchQYR28xph/enku6n5YHXPW7JLbg2umejJF89e3rNxHmTpisTnY8ij38
         32nPH3MKKuZ0YqF5eslKO5TWgasdxBEzStux+OKpqdc54GpUpe4ZxmGBHnalushJBLbH
         +YKL3Is98GcC4d6rpBwKfth5X3bN68Oz+SDDAIBSeMdSUmi9BMvtDbfrrKPN/sQH4ebS
         ECFBm1yemq3p4I8SLvaE3WK/WVM5nCbxyj2NF2w/ZSrViF/PhcHAtj4QaGxyULZ+WYug
         l/zj1SHHXnOwTNMYq2ori0ujK/mjsH4MR1L49XGcQ8bf+zsdNPqf6yHa2+S0w9Amc8CA
         8DGw==
X-Gm-Message-State: AOAM533LwHGC/uPfQGn+pxYGiiQcL7H6YUgaNMJiESVKorVfqg7HtWje
        J5GJBtmas9NBwYT4rOYq2R0=
X-Google-Smtp-Source: ABdhPJwms9n5YioYF4+hBcM2Zmu04MxgSvYY6gQcH8JnomaZd3SQJeH9a2YqGVtSxDPxUnCHm0+MrA==
X-Received: by 2002:a17:907:7202:b0:6df:83a9:67d2 with SMTP id dr2-20020a170907720200b006df83a967d2mr35225102ejc.327.1651233868057;
        Fri, 29 Apr 2022 05:04:28 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id eo9-20020a1709069b0900b006f3ef214e02sm581338ejc.104.2022.04.29.05.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:04:26 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 1/4] clk: qcom: clk-hfpll: use poll_timeout macro
Date:   Fri, 29 Apr 2022 14:01:05 +0200
Message-Id: <20220429120108.9396-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429120108.9396-1-ansuelsmth@gmail.com>
References: <20220429120108.9396-1-ansuelsmth@gmail.com>
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

Use regmap_read_poll_timeout macro instead of do-while structure to tidy
things up. Also set a timeout to prevent any sort of system stall.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-hfpll.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
index e847d586a73a..7dd17c184b69 100644
--- a/drivers/clk/qcom/clk-hfpll.c
+++ b/drivers/clk/qcom/clk-hfpll.c
@@ -72,13 +72,16 @@ static void __clk_hfpll_enable(struct clk_hw *hw)
 	regmap_update_bits(regmap, hd->mode_reg, PLL_RESET_N, PLL_RESET_N);
 
 	/* Wait for PLL to lock. */
-	if (hd->status_reg) {
-		do {
-			regmap_read(regmap, hd->status_reg, &val);
-		} while (!(val & BIT(hd->lock_bit)));
-	} else {
+	if (hd->status_reg)
+		/*
+		 * Busy wait. Should never timeout, we add a timeout to
+		 * prevent any sort of stall.
+		 */
+		regmap_read_poll_timeout(regmap, hd->status_reg, val,
+					 !(val & BIT(hd->lock_bit)), 0,
+					 100 * USEC_PER_MSEC);
+	else
 		udelay(60);
-	}
 
 	/* Enable PLL output. */
 	regmap_update_bits(regmap, hd->mode_reg, PLL_OUTCTRL, PLL_OUTCTRL);
-- 
2.34.1

