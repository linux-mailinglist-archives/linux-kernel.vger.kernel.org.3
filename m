Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EFE4D77AE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiCMTG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbiCMTGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D24C7B5;
        Sun, 13 Mar 2022 12:05:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t1so16836989edc.3;
        Sun, 13 Mar 2022 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8h0dp/sRCWnE/SzxqBhwWtp3OCJwunZ7486W2HMfBko=;
        b=fTZnAXUYeZUwUee4NNITJDgsbxWYwAQoG/PGVk3BVITqzJRM2B26EaS6H9Yn+xeLOW
         i+NVYI2pBj2MkklsM3/9DyssGo9vfdbueNZd+Sg8+Bf696+rKJBmP5TWauHlQrN0lTGH
         IagMD2jwPspZz6XvTLiRhmWngCZhWpIqSihNi+XycGs8Tp79jlAqQhKduD1YZKm+c/pR
         c6OnVAhsrOvFsAEigFXHBaw5pILlpvGBOfoM6Z7sP8DZ7m49+Fj3jFTk7MwdsMevruKB
         SPYhWZIThu9OaMKG8FldOj84uXfkp5OKl3A7ItCQm0Rok675LBjVDIkStbHfCviFc2CD
         J+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8h0dp/sRCWnE/SzxqBhwWtp3OCJwunZ7486W2HMfBko=;
        b=BgtPPxeMmeALm2VYvC+a1p3IMjexEAwCRceDAtbOXjDaH5JvZMM+5CsN4sq53kV0g9
         MwwEWmT6yMxV/1Rq4UiN4zhi1+HGaMh/+dCy4JR8MLljNuFjyV5IPpoGmtsGaaWr5ht6
         GOrVLS8tm8Tz1Y6/3ee08rvRsFOoerzl6z8hTkWZHhyN7hjNP4CuvyTwAI55o24y2bTW
         jwTws2iE3rDM+iI3QrMMqdhcxB6Z/mmgAzHOS5k5s5Y9IU94wXecBbCMdKIo+GjVAcPc
         n2ZsRxoHxnhVwNQjZr/TcRzhKyL7dw4KcdAo1Dip8sOTf40DN7JH5W7lAC/GYbbjMejR
         bo6Q==
X-Gm-Message-State: AOAM533lPqXrzCSsikOw5p2/19VI7SNRCqxgPhxxx7ZQdjeogbUb9aI2
        xWYWyqFrxfYa56Ed/tVK5Kw=
X-Google-Smtp-Source: ABdhPJwYxPIShgzFqu9DIExRZEI3B0Qg1ODsH5xSucqCFcL2oZov01PvEvnKI71D+RrrLT7jHyrb6A==
X-Received: by 2002:a50:ab53:0:b0:415:d2cc:de46 with SMTP id t19-20020a50ab53000000b00415d2ccde46mr17268064edc.193.1647198305679;
        Sun, 13 Mar 2022 12:05:05 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:05 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 04/16] clk: qcom: clk-hfpll: use poll_timeout macro
Date:   Sun, 13 Mar 2022 20:04:07 +0100
Message-Id: <20220313190419.2207-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220313190419.2207-1-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
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

Use regmap_read_poll_timeout macro instead of do-while structure.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-hfpll.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
index e847d586a73a..a4e347eb4d4d 100644
--- a/drivers/clk/qcom/clk-hfpll.c
+++ b/drivers/clk/qcom/clk-hfpll.c
@@ -12,6 +12,8 @@
 #include "clk-regmap.h"
 #include "clk-hfpll.h"
 
+#define HFPLL_BUSY_WAIT_TIMEOUT	100
+
 #define PLL_OUTCTRL	BIT(0)
 #define PLL_BYPASSNL	BIT(1)
 #define PLL_RESET_N	BIT(2)
@@ -72,13 +74,12 @@ static void __clk_hfpll_enable(struct clk_hw *hw)
 	regmap_update_bits(regmap, hd->mode_reg, PLL_RESET_N, PLL_RESET_N);
 
 	/* Wait for PLL to lock. */
-	if (hd->status_reg) {
-		do {
-			regmap_read(regmap, hd->status_reg, &val);
-		} while (!(val & BIT(hd->lock_bit)));
-	} else {
+	if (hd->status_reg)
+		regmap_read_poll_timeout(regmap, hd->status_reg, val,
+					 !(val & BIT(hd->lock_bit)), USEC_PER_MSEC * 2,
+					 HFPLL_BUSY_WAIT_TIMEOUT * USEC_PER_MSEC);
+	else
 		udelay(60);
-	}
 
 	/* Enable PLL output. */
 	regmap_update_bits(regmap, hd->mode_reg, PLL_OUTCTRL, PLL_OUTCTRL);
-- 
2.34.1

