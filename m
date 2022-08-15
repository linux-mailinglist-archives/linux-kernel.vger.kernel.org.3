Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B22592BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiHOJUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiHOJTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:19:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9923722513
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:19:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b4so5267901wrn.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=wrEhczNEpmqqq7VK32HILro+LXPMg7V+9Mu8TEubq68=;
        b=X9dKLxsx5J6Y0Q5apGeawGDjpRu57kpRQUxeUJqf1KVbC6afNd9EmZrdIqucXBRsUv
         6rsghCS7XYEqtlGxQXrxTtWqw/uz2JEoaWqT1ECMV5HYCkAlnAKFzjALqdPVhC0KY1/z
         Q+xGiKLrDToOb61FRXLx3tHl0enxF7pyPr7IiRLVAbCXfa6AxP2s7vm9402+zmYmb+5X
         qcUSsENWS41qJ3fg5J36gjQ4K9MPh6rneR5fMPlx0gOZn8s3PimkZHDGrPL42fPg8YEf
         rfshze6qCi0rofBpzqi4qXFnrOQ1CwpjdZhEhdUgszLZE5uAsIu/n9Wh5nbOS3uhJLbh
         4wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=wrEhczNEpmqqq7VK32HILro+LXPMg7V+9Mu8TEubq68=;
        b=LpxNliOAMSM3Cyz/1jVLGxMCVVYdjoVKS9erAx/pFNcMu5DZp04S7fTzLs8B165iQQ
         URKG+x+LEzW5K1o/KpUvSxb78THWZ6as6DZjDhHhDawJuC4H3LIx0uChw4OHYDNvmRqf
         E5KuglHtIy7QBQ4LcQjONw6J612ctsOs1vyyTb0D0I+3JAUuT0HMHLXZT88rIo/pVFYN
         HBVPTmuKaRtx+PqD0engK8e+JUnf28cbmiH+HFfGKCbcw7jWY3kYBF2YRe6DQlw2/Bid
         WFXs/tcF7GiSuiJMDi/vqf2Z691qk7QTtQEGn5jLDYImtTXhttvQNpIclaVjSn1d+w68
         OgKA==
X-Gm-Message-State: ACgBeo3v38EbAZNjn7fMqpW7GCFMw++Gg3aV4gc2qNVJfK4KUYxRG7qQ
        P2Uio/5fvktnXpATG4nsuLK/5Q==
X-Google-Smtp-Source: AA6agR7mMp/FaJHOcP3eNvxI6ohHw4X0eBa3uH6SugbJpC/+2RKXvZeOZjLBw9iy1OST3Aa3uGqvfw==
X-Received: by 2002:a05:6000:120a:b0:21f:dfb:ff12 with SMTP id e10-20020a056000120a00b0021f0dfbff12mr7985664wrx.215.1660555172222;
        Mon, 15 Aug 2022 02:19:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:84c4:662a:9629:cac6])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d48d1000000b0022159d92004sm6716993wrs.82.2022.08.15.02.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:19:31 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hulk Robot <hulkci@huawei.com>, Yuan Can <yuancan@huawei.com>
Subject: [PATCH] gpio: pxa: use devres for the clock struct
Date:   Mon, 15 Aug 2022 11:19:29 +0200
Message-Id: <20220815091929.130547-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock is never released after probe(). Use devres to not leak
resources.

Reported-by: Hulk Robot <hulkci@huawei.com>
Reported-by: Yuan Can <yuancan@huawei.com>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpio-pxa.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index c7fbfa3ae43b..1198ab0305d0 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -661,24 +661,17 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(gpio_reg_base))
 		return PTR_ERR(gpio_reg_base);
 
-	clk = clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "Error %ld to get gpio clock\n",
 			PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		clk_put(clk);
-		return ret;
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

