Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6064F66DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbiDFRLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiDFRKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:10:11 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6BC2EBA49
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:40:46 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso1844220otj.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=X5oMc4U0HqNOuSEIIO5YmO/jyPSOHRF2iW9CUgKZimc=;
        b=H+YslfvjvYJSBAjSHfHXe69XyGiB+acKjOtL/2uKvzT17hYUDuF4oSTCO4o9ZJB41E
         fBSKj6WwVmdEGgC7ltWol6E3X3uKIRegvrcB15ylIfLZVOXYWkDzbSyo39TzW/yWOfcS
         urnb6EgBcRqUn3R1N6yu1AVRYq0OWa/CrkLD/Y4axWhFVS3U70Mi+jZGt7zbViYSDO0U
         3iQCIHl3GsKoZEdSWe2VwXth89vdHh2cCFyx7aMQcS9Mh4SZIgXRHZ7CURhk/EKVYOTC
         boWgu9bzHxH2hVd+HFXU6OMkkY6xQ60/LmZ34vKjVpW6XvGKf3gXPmLIl+fhhBbaiprC
         UEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=X5oMc4U0HqNOuSEIIO5YmO/jyPSOHRF2iW9CUgKZimc=;
        b=dRn5TpntR6ulqwZm0Y97HCHFC9YNsnlyJhLlTEBrrKK8QLDCVvqLkcNVSMDT1hK6ld
         xLn2vgwSVRvFRuvCMGcy1sCfsYoA6nUuCdIhS6sDexueeanAgnhaW65FL2ETPSQL1xFh
         gtofvbPAFK5eLA67lmRLNWWY2LogVAp1xOQKBWWTxHHWPdgUdeLaZNWtEgeWB/8BPHRX
         1zTzzl6w10BlRtLq/PJvXcwOSP6EnZKDdwmPvn01YtOelma52CR5WMyiPuNDFI49g7tV
         2WLac/fwwQcwoElysFLFS398GfByXW38ud2GmGCpDVdaec5GQlYSSr9MLrOODucxAyqw
         R4dg==
X-Gm-Message-State: AOAM533YxxxBphIPPN7y7+aeJS7dapNVrIJHKSNPjhGbOXvUasI56A0V
        D4HS59LgN59GE62QJuy8cCO8n3jku3kCsqSB
X-Google-Smtp-Source: ABdhPJwOfW/d+537Pqtuw898HhxoPqXK6YCsX33hXKeYEl8RrBavIMsZvdDLq7o5gDeUSdOrri2aEQ==
X-Received: by 2002:a9d:6e98:0:b0:5cb:2560:9441 with SMTP id a24-20020a9d6e98000000b005cb25609441mr3194768otr.126.1649256045505;
        Wed, 06 Apr 2022 07:40:45 -0700 (PDT)
Received: from fedora ([2804:14d:8084:84c6:2e13:8e30:84f7:1597])
        by smtp.gmail.com with ESMTPSA id r10-20020a056830448a00b005c9344dac06sm7027163otv.19.2022.04.06.07.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 07:40:44 -0700 (PDT)
Date:   Wed, 6 Apr 2022 11:40:41 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: hi655x-pmic: Replace legacy gpio interface for gpiod
 interface
Message-ID: <Yk2maZuf+5FGL+eg@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the current transition of the GPIO subsystem, remove all
dependencies of the legacy GPIO interface (linux/gpio.h and linux
/of_gpio.h) and replace it with the descriptor-based GPIO approach.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/mfd/hi655x-pmic.c       | 27 ++++++++-------------------
 include/linux/mfd/hi655x-pmic.h |  4 +++-
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index 6909d075d017..a58e42ddcd0c 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -9,14 +9,13 @@
  * Fei  Wang <w.f@huawei.com>
  */
 
-#include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/hi655x-pmic.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -94,7 +93,6 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
 	int ret;
 	struct hi655x_pmic *pmic;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	void __iomem *base;
 
 	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
@@ -120,21 +118,12 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
 
 	hi655x_local_irq_clear(pmic->regmap);
 
-	pmic->gpio = of_get_named_gpio(np, "pmic-gpios", 0);
-	if (!gpio_is_valid(pmic->gpio)) {
-		dev_err(dev, "Failed to get the pmic-gpios\n");
-		return -ENODEV;
-	}
-
-	ret = devm_gpio_request_one(dev, pmic->gpio, GPIOF_IN,
-				    "hi655x_pmic_irq");
-	if (ret < 0) {
-		dev_err(dev, "Failed to request gpio %d  ret = %d\n",
-			pmic->gpio, ret);
-		return ret;
-	}
+	pmic->gpio = devm_gpiod_get_optional(dev, "pmic", GPIOD_IN);
+	if (IS_ERR(pmic->gpio))
+		return dev_err_probe(dev, PTR_ERR(pmic->gpio),
+				"Failed to request hi655x pmic-gpio");
 
-	ret = regmap_add_irq_chip(pmic->regmap, gpio_to_irq(pmic->gpio),
+	ret = regmap_add_irq_chip(pmic->regmap, gpiod_to_irq(pmic->gpio),
 				  IRQF_TRIGGER_LOW | IRQF_NO_SUSPEND, 0,
 				  &hi655x_irq_chip, &pmic->irq_data);
 	if (ret) {
@@ -149,7 +138,7 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
 			      regmap_irq_get_domain(pmic->irq_data));
 	if (ret) {
 		dev_err(dev, "Failed to register device %d\n", ret);
-		regmap_del_irq_chip(gpio_to_irq(pmic->gpio), pmic->irq_data);
+		regmap_del_irq_chip(gpiod_to_irq(pmic->gpio), pmic->irq_data);
 		return ret;
 	}
 
@@ -160,7 +149,7 @@ static int hi655x_pmic_remove(struct platform_device *pdev)
 {
 	struct hi655x_pmic *pmic = platform_get_drvdata(pdev);
 
-	regmap_del_irq_chip(gpio_to_irq(pmic->gpio), pmic->irq_data);
+	regmap_del_irq_chip(gpiod_to_irq(pmic->gpio), pmic->irq_data);
 	mfd_remove_devices(&pdev->dev);
 	return 0;
 }
diff --git a/include/linux/mfd/hi655x-pmic.h b/include/linux/mfd/hi655x-pmic.h
index af5d97239c0d..6a012784dd1b 100644
--- a/include/linux/mfd/hi655x-pmic.h
+++ b/include/linux/mfd/hi655x-pmic.h
@@ -12,6 +12,8 @@
 #ifndef __HI655X_PMIC_H
 #define __HI655X_PMIC_H
 
+#include <linux/gpio/consumer.h>
+
 /* Hi655x registers are mapped to memory bus in 4 bytes stride */
 #define HI655X_STRIDE                   4
 #define HI655X_BUS_ADDR(x)              ((x) << 2)
@@ -53,7 +55,7 @@ struct hi655x_pmic {
 	struct resource *res;
 	struct device *dev;
 	struct regmap *regmap;
-	int gpio;
+	struct gpio_desc *gpio;
 	unsigned int ver;
 	struct regmap_irq_chip_data *irq_data;
 };
-- 
2.31.1

