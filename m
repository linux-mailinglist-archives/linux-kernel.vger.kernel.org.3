Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392D44E2BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349981AbiCUPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349912AbiCUPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438FB113D01;
        Mon, 21 Mar 2022 08:17:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a1so19788573wrh.10;
        Mon, 21 Mar 2022 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8P3wAYvgFlPve71dG0z5aPiI1G8WoaU4vYr3l4vmoOE=;
        b=W3ChpJLmwyrqPCndWOIVoo8/LzEsb1GaL6fs3Idbl4VVZS1J/DuIYBCHOtxEfsXK1V
         13WBmhNyRHS2Z29fkHal0LKEyGn5w41lCFkCZUn9WoAwVFZvzO4dmex0REgLmCt+8GqD
         BPitPzLyNJkL+myNs/77Bb98mwEBw8OSDz66amqb07C7HcgIpIr5v6RYvjTiWb05a1/j
         a0nyiVI+UcJVlrqOWfkj37l4nNelwHQZYVWPIvTKXTko7Ey+NXIplJhydL6nSBt564yr
         DoO90JO62JLi9fzohLMLK5GTkYQmHd32MhzeiU0+vR3yNvCaolf/Dho+HDGch86kbWDM
         5enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8P3wAYvgFlPve71dG0z5aPiI1G8WoaU4vYr3l4vmoOE=;
        b=Hi37aFjbt8VbxIhxVYduxt+CTs/qgE1fyCw5cTTHzK3fW7t3T6PkkUJqCgHnyt6fxq
         l1xLbzbZcOS0WZg20MjP0sn7sUQEam5Bkt6wvLifUK6KLAOH7dVY4gRfOWhX5ayxR1BU
         JCa+ciYe50T7S57Ia3EK5mfW7bUe+Bieo0jJwNrZ8ourUSVwKWOyaSd+VhImRwbbTPTx
         mvAdfs6iJ4glk4IpFr6maYWcHsPPc2LX6didwIPaUkrmHYerklfmz4GFqgNx7Jmx9cb8
         sSMzTUr0Ye+TNiOcfdb/u6ES+R9QKoRn01CGggvqTA72B+yQFVSVMnKyE+F6zDNG/avd
         AIvw==
X-Gm-Message-State: AOAM531GB2LppovOi3PEGDemaDsLZMnPa4EUce/CrHK5/R9gUvMwzqqy
        /Cbx50X+9cLsZ6z6UwzlmNE=
X-Google-Smtp-Source: ABdhPJysgBK1LnHyN+rGxiVt/F3ggQ40uJfDym2izMHgFoeqY5yLmZ6E75oijCclQCyteGdoF0aS3g==
X-Received: by 2002:a05:6000:128f:b0:1f1:e586:87af with SMTP id f15-20020a056000128f00b001f1e58687afmr18727182wrx.222.1647875867682;
        Mon, 21 Mar 2022 08:17:47 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:17:47 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 02/18] clk: qcom: gcc-ipq806x: skip pxo/cxo fixed clk if already present
Date:   Mon, 21 Mar 2022 15:48:09 +0100
Message-Id: <20220321144825.11736-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321144825.11736-1-ansuelsmth@gmail.com>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
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

