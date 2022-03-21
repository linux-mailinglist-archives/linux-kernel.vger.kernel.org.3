Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1204E34B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiCUXrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiCUXqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:46:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193AF90FF3;
        Mon, 21 Mar 2022 16:45:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b19so22738246wrh.11;
        Mon, 21 Mar 2022 16:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8h0dp/sRCWnE/SzxqBhwWtp3OCJwunZ7486W2HMfBko=;
        b=QhmJY7LtPm+UvAuVmH0Cww45PV2j8fBGDZzJz0y2y8NId+Cd2mvbcbYsW0jWKvg0cT
         H5yZvlSLjtNd6YryThsWfap6lf9S595n3m12OhJ6ByBrw4SmgqiPtW9CoQyt7+FWQgxp
         pMn9Wo2SHTXpojc1YiHuyauPtb5JGp/j3JK4fdNYktj0X6J2JkbFwi5vZKZBsbNTTqad
         zch49jkz9Upu80QpWJlFWrDc2gbuLNXeuP/Q/4A/aXseR4aeGbvWFfMdkG+GWd0Rt50h
         WYGrGbQwdPTfHHbxt4E361MeP9qtRlymgDyPkZwadH5hN88ntwBCuIuRgpRg5JwW7y1R
         DC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8h0dp/sRCWnE/SzxqBhwWtp3OCJwunZ7486W2HMfBko=;
        b=g75Hh0CH0hETIjIofYLyTqydKl/PvOzy/UHGjdxY1o5KPeQ0V6FV1z+F95CNsrjdBr
         f5JzPrHCaZvHAPGrkt1iOCAMkeRP5jhfPlvtTXCcM4N7mep4K6WOwSEzDH61suqiEScy
         YCBstoGJp5DqUt122d7v7NbWIWTw0A4X/t9ZBfjTAUrakBq7zlNw3CBnBoAwXlm542jf
         8gEaO/ZzWcY0Zl+yVUvY6FLVlBeGFxhoeDGdFsTdzMk6xQqnJ0RXBufEf7N1m7jlpFQ9
         JnF0O+lF8sn8b9qy5Ywr0cIkzPJzLpD33FGWUDtU3BDc0DnziFIdyOCOdRmHq0RaxGpq
         wZ7w==
X-Gm-Message-State: AOAM533jvCSHcAuO4YeoTPZhgSIARiOn8O6ZfTXEw0Y7WhgYvifeZY1y
        M1c8uGd9jRsDS9pl4dNxLEE=
X-Google-Smtp-Source: ABdhPJxmRmoCgMsgyiwehFFD8Yzdprsgc3FoR5L8FzxPCvZuXmmLtGDZwpQkmpLlYovVVi/l7qu2fg==
X-Received: by 2002:a05:6000:18a3:b0:204:1f84:287e with SMTP id b3-20020a05600018a300b002041f84287emr1940879wri.184.1647906316517;
        Mon, 21 Mar 2022 16:45:16 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm105497wrf.80.2022.03.21.16.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:45:16 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 04/18] clk: qcom: clk-hfpll: use poll_timeout macro
Date:   Tue, 22 Mar 2022 00:15:34 +0100
Message-Id: <20220321231548.14276-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321231548.14276-1-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
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

