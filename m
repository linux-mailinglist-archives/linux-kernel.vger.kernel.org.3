Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2895E4E1CC0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245541AbiCTQ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245469AbiCTQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EA034641;
        Sun, 20 Mar 2022 09:28:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o30-20020a05600c511e00b0038c9cfb79cbso459452wms.1;
        Sun, 20 Mar 2022 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8P3wAYvgFlPve71dG0z5aPiI1G8WoaU4vYr3l4vmoOE=;
        b=SFtzoD64TaQzPSLPWXnXCW7cW+np83Bf6OQnuSus43XleVePiClweVC3y4JFv+jT9a
         bb7q9P/mkk0hjCT+w/RiFK/W4p29/Dq0+U0xLc3Qed9pU1O69bmIS4y4S8z08SmT20v7
         c9uB9aEUZDlrteDwrhXJDyEbGcZ4sl0YhF4hXhK1QNOFTYiESAZzc1bgqcevu/ywnKYJ
         oQENVuC6L8Wo6p/++tNda2hoDQsDtOSMD+ItG3mgkLsh5qYHG46WAI4GN7kMe6ypybLv
         PYnZEpTWlBivOmnjsEO15ZIWXi6M6LOagKQI4iV98H8zK6qGZkd3bP9V1gEj89bQtCix
         TZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8P3wAYvgFlPve71dG0z5aPiI1G8WoaU4vYr3l4vmoOE=;
        b=qis2QJZJbzq/xr79XdpaJRRNfum7C1dM93majSw/tsI3YQQG74O2WdapnWfhJxUyZ/
         90z2+DfXa90za1std4AXmdFohWAy57HVbReMTiBMiQdW0jagaRqVkSfrN7ePW0mkGiad
         aPvITdTft99fRjXRA8JY+zxwFxDiYxrvizVNb3GVEXglngDWvudUsDCCt0VT+JqifeGt
         pi8hKCrtMHuI3lVb33xI2VdqObpv6EAcE8gC7ivba7DfeUG8nu8TcOGHIyTPWSpvlJQU
         Jkcu91AjeehQT4cUzoB+gsr6VPoophZPytSY+DUsMtzbql35HWu9Ab9stP710+uPChW+
         Ntig==
X-Gm-Message-State: AOAM532R+8yY0wKbJVWSnyM/W7FeDbseY+I7gY+WOA19E3ro5NaKrxkd
        bpToMLLaVKGOV76VM6iwjRjvppaHdeI=
X-Google-Smtp-Source: ABdhPJz1GOmXaYQZUAA0skYDcx6omh1lEo3AeWkKPBF6mOQaprrVroYAY0T2KtU2owtV9IlwtGbYQg==
X-Received: by 2002:a05:600c:a06:b0:37b:fdd8:4f8 with SMTP id z6-20020a05600c0a0600b0037bfdd804f8mr24304139wmp.41.1647793692871;
        Sun, 20 Mar 2022 09:28:12 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:12 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 02/18] clk: qcom: gcc-ipq806x: skip pxo/cxo fixed clk if already present
Date:   Sun, 20 Mar 2022 12:34:14 +0100
Message-Id: <20220320113430.26076-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

