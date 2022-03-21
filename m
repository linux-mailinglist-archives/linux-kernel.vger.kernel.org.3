Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92EA4E34A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiCUXqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiCUXqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:46:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAC778FD7;
        Mon, 21 Mar 2022 16:45:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b19so22738153wrh.11;
        Mon, 21 Mar 2022 16:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8P3wAYvgFlPve71dG0z5aPiI1G8WoaU4vYr3l4vmoOE=;
        b=hi1U7vy+Z/G7HaX9Jgdh9FFV6s/SVC3iHxQighhGvy9F/4rhKwsNeB+PWRxBzy3RE/
         jlwU4rDmTxLbX1ZSPpSSL6BulGJ7nxr971pNp5cu2aD2+2pjeY8GftuzLdDxpFRup5SB
         5RvBsR9E7L2sZAvgdHct89raTo/Nod/4tNwbGj2z65++lb6UoyIfWb96omEpfjMSw4/V
         E46vaI/FxUJVVImLZQXhxQuyd2T8wsd6b2btAy9U+J6GWu4bqpxfvJdfUhcWqC9vnld2
         U6pVdf7yReE1cOB0WfC7IbjcMEP4G2LJYjKWox1r+ja3om9Stm4EbM8jt1v5g9ixtPL4
         rkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8P3wAYvgFlPve71dG0z5aPiI1G8WoaU4vYr3l4vmoOE=;
        b=e+8/C727yPvIUej/hUGZccwqaDyfL+71/rn2bxjmkczznRLerl0Y78YPSDxAGWR4oP
         B7iYIm5bvpoSaQMoAB/10VJw6qNiuDk6aQQs1DZMEB37zSgCzIxL7ZZvXO0S7q6hO/Tj
         5EVsVx0Mk+Hds2t9Z2P97yzGxhlVOn3MiEQ+3tU2hPEd6rjWQNqnxYSm616b3n5rUZn6
         wZoeDNEomhvXYyCXK3FTFPaG6V3k3wgbpG/7UNDMVCzwAC7BUxwNd+SRpLqzhgekLSmb
         LkUUcvxwqw+cASnR7x2P0fEFg8OliJz1LsVD8NJIeNN8SZegYOA7qaoLQRnoe/SXDpF/
         s/bQ==
X-Gm-Message-State: AOAM532SLDUnmMTTLUS15rCREeaQ+C1gjJvW1CD7clNUJ9A/W/omPdas
        I61PXFIFaEIeLyzZUdGlLlw=
X-Google-Smtp-Source: ABdhPJxCqoksIbuidDWuZ2vyRWDA/FC9D7WNQE/UQ+P3TesXaGZ3vwjVbSuJh4gCg82rE8TI1jGVhg==
X-Received: by 2002:a5d:6d8b:0:b0:203:e242:5e38 with SMTP id l11-20020a5d6d8b000000b00203e2425e38mr20670632wrs.105.1647906314193;
        Mon, 21 Mar 2022 16:45:14 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm105497wrf.80.2022.03.21.16.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:45:13 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 02/18] clk: qcom: gcc-ipq806x: skip pxo/cxo fixed clk if already present
Date:   Tue, 22 Mar 2022 00:15:32 +0100
Message-Id: <20220321231548.14276-3-ansuelsmth@gmail.com>
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

Skip pxo/cxo clock registration if they are already defined in DTS as fixed
clock.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index d6b7adb4be38..27f6d7626abb 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
@@ -3061,15 +3062,22 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
+	struct clk *clk;
 	int ret;
 
-	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 25000000);
-	if (ret)
-		return ret;
+	clk = clk_get(dev, "cxo");
+	if (IS_ERR(clk)) {
+		ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 25000000);
+		if (ret)
+			return ret;
+	}
 
-	ret = qcom_cc_register_board_clk(dev, "pxo_board", "pxo", 25000000);
-	if (ret)
-		return ret;
+	clk = clk_get(dev, "pxo");
+	if (IS_ERR(clk)) {
+		ret = qcom_cc_register_board_clk(dev, "pxo_board", "pxo", 25000000);
+		if (ret)
+			return ret;
+	}
 
 	ret = qcom_cc_probe(pdev, &gcc_ipq806x_desc);
 	if (ret)
-- 
2.34.1

