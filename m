Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F6B567569
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiGERSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiGERSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:18:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11C8D4A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:18:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l68so7430940wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oX0waMzWCEuj693FR9SoOyHPrpinuC5KqVJpuKLPzOY=;
        b=Y/oXhf0YAVX8Ii93/RMZ+kTN2KQXlxzN0g7K/o3q3wOmogGX6a39jaNoUoL7cxXLpg
         HTa9OQkztdIuetl2GVxIgISAL5wW/mLX5c63y8LEXG0hFsPCuvMYMYOuGr0FRkaP3JmN
         ZtV2Q2F8f2IjjX64bbybzACeYzsLVtcNxAnvM5cBV2ebYu0kiQC+Fmxw0YgPujSh3Lou
         32kVIAgst0SL5MEf6k5CQLWtWvgixNgeG9iGYccsDCzmHlcJHu2sHbmHo1hebkE3T1BB
         T4tAqX+XPe2ioiNjIo/ZdVPJKglUrJRe+Up2fh69wRISzLhqQDWBPWVQ4Yfa8UqIBaPb
         Rqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oX0waMzWCEuj693FR9SoOyHPrpinuC5KqVJpuKLPzOY=;
        b=NNTjAJERaTgBWA1sj0BSa4ndMcv1iIcHB6HE3RExYpRvFbMzYBV5xJ9iOFHF6UnIFR
         0fBcggTlszaXb8kkptFDC4SkWxP0Fn7l6tEQHjUko6kSnAMM6/4hnltkg7RInqLcolqX
         SMTfwHmq+WXa4KE4ghglSTFa/2u9tItisd3nmUYrGSlOlQotnkVnjlmOCqrMYzuDFfkZ
         agZc3dK3paZI3Z4zi8sUSvav8mVm7ZgxpB1Fr/MNVDYu4xACLaeDeMTPp8eamYC5WNtI
         vzcrHzDSmZw5AYhaaPXGNtMaTzgBAttcmPijTQz+1i241hgY+ZP019GYPdOJw/mhcCZz
         MFyA==
X-Gm-Message-State: AJIora9MgZkTf3ec4XkZxkDzwCxuzI366Q+NdQM8oJBuo+zsxh1Os/gF
        IRX3KQx8mnqOAXGqZKPkYyXwsQ==
X-Google-Smtp-Source: AGRyM1szwkCiOjMr/Boc1YPzQeJ73fhzcCToGws+FIpAom1h9GwM5q0EumyrHRDQ/z3kdNM3M2I8kg==
X-Received: by 2002:a05:600c:a03:b0:39e:4f0c:938c with SMTP id z3-20020a05600c0a0300b0039e4f0c938cmr36658288wmp.145.1657041518382;
        Tue, 05 Jul 2022 10:18:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a207:ad68:a28b:8a05])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d45c7000000b0021d6f03b524sm3445367wrs.48.2022.07.05.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 10:18:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hulk Robot <hulkci@huawei.com>,
        "Signed-off-by : Yuan Can" <yuancan@huawei.com>
Subject: [PATCH] gpio: pxa: schedule a devm action for the clock struct
Date:   Tue,  5 Jul 2022 19:18:35 +0200
Message-Id: <20220705171835.4923-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock is never released after probe(). Schedule devm actions for
putting and disabling the clock.

Reported-by: Hulk Robot <hulkci@huawei.com>
Reported-by: Signed-off-by: Yuan Can <yuancan@huawei.com>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpio-pxa.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index c7fbfa3ae43b..73a83b493b2e 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -610,6 +610,20 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev,
 #define pxa_gpio_probe_dt(pdev, pchip)		(-1)
 #endif
 
+static void pxa_gpio_clk_put(void *data)
+{
+	struct clk *clk = data;
+
+	clk_put(clk);
+}
+
+static void pxa_gpio_clk_disable_unprepare(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
 static int pxa_gpio_probe(struct platform_device *pdev)
 {
 	struct pxa_gpio_chip *pchip;
@@ -667,18 +681,24 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 			PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
+
+	ret = devm_add_action_or_reset(&pdev->dev, pxa_gpio_clk_put, clk);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(clk);
-	if (ret) {
-		clk_put(clk);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       pxa_gpio_clk_disable_unprepare, clk);
+	if (ret)
 		return ret;
-	}
 
 	/* Initialize GPIO chips */
 	ret = pxa_init_gpio_chip(pchip, pxa_last_gpio + 1, gpio_reg_base);
-	if (ret) {
-		clk_put(clk);
+	if (ret)
 		return ret;
-	}
 
 	/* clear all GPIO edge detects */
 	for_each_gpio_bank(gpio, c, pchip) {
-- 
2.34.1

