Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8634DDE07
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiCRQKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiCRQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:09:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F874AE34;
        Fri, 18 Mar 2022 09:08:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qa43so17850851ejc.12;
        Fri, 18 Mar 2022 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8P3wAYvgFlPve71dG0z5aPiI1G8WoaU4vYr3l4vmoOE=;
        b=i86czUUj48GF/XUBd4oJWgosZdkLhkpsIfS0o0q9ban90irXapDS3ihASlkLccZLVZ
         vxftBTmrSk1NlL6yjXf4B/FzqXhzxwf+ZJz7zEA05T9pf8nJJVeJtWYHaLCNL8+ZKAqF
         goBW0CL4ae5dfsVF2/mGpDDmIKja5BhFUh9o/Ligq1ATfufQ+qKrm0M4BeVzOsiYVxS3
         kvXhPJg384UydiFZeoaQWvs0Dwu2I8rM7lWnvgcQmlF6BHNhhkF4R9BRhvpDrFz6LgnE
         O+6HnVE5j4IbXmvRHwCqNnK8NCi6ATn8PWTOIMpBfSHBSWQlzhklOuNy/4LzpyjgrpsP
         gJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8P3wAYvgFlPve71dG0z5aPiI1G8WoaU4vYr3l4vmoOE=;
        b=N4Cge0b1tuAp+CZ5fvcCDsf0qMnAsYF2808bXvCsbs3Xf87OUSYMYjr/broKS9P7Xb
         gWNsaxAr8g5wj5+qS6XKx7mn6vOte3NBktdB6UyMEFryhi/QVlPKmOJQM2LU5B3ofRFJ
         I+lP2T5U1fv63ve9nDmS9SwMj4o4jCOiEaOt4tCVUDu5wQWEFY+QSyPbByOIhe3jGS11
         3AkhXew0ZzmlsilxhPZRLVU3GnsgfEyxhRd8K9ffbS3RNmLLs08anWE7o5OE+hQgaUWU
         6fw8KENf28nQSg5d2uB7/1SkC5JxtezjGpev1iJZN6tkXwfX+mMvCm1niZTGKBDHF7C2
         GfLA==
X-Gm-Message-State: AOAM531+Y8xC71dx/eS528Pm744++Wa/A+bZWuHNeTSUwO/tiC0D2GyY
        MKINVSp3RSwqxz46ZlZo28w=
X-Google-Smtp-Source: ABdhPJxL7N8UZ0Kslm/zsfSZruSQrN6GVCwekkXlKlbC+ExhJ6RwLyAgMrsRnk6FcrGLGa7kfNAZMw==
X-Received: by 2002:a17:906:b052:b0:6ce:88a5:e42a with SMTP id bj18-20020a170906b05200b006ce88a5e42amr9854436ejb.237.1647619711156;
        Fri, 18 Mar 2022 09:08:31 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:30 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 02/16] clk: qcom: gcc-ipq806x: skip pxo/cxo fixed clk if already present
Date:   Fri, 18 Mar 2022 17:08:13 +0100
Message-Id: <20220318160827.8860-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318160827.8860-1-ansuelsmth@gmail.com>
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
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

