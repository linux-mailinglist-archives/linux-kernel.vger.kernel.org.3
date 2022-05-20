Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF7252E2BF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbiETC4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344910AbiETC4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:56:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65CC606C9;
        Thu, 19 May 2022 19:56:35 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m1so6311975plx.3;
        Thu, 19 May 2022 19:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qJb4ROMmqmKfjFw0cK9zc2HCnw8bdTldzzuHAWqviPg=;
        b=ldKwD0kyeenr2xn13JtRRmYYaxFPOmOCx8m60E1/VDCzs16Z9HlDo7N8U7A1aJs4va
         aBkorL20LetfJRSy8bWOP4WzLtm6JYZ/m23MZDSdHQTL7h55mNys6KtZvFHf67KnVVAm
         l0dtCD8Mgc3wRFIKSxbIvJn2juYwUOokjr0fcEUVkyTFNUajQ+39iChdymLmQHJUBzun
         U1QFsllV4V52xbneLA95qkXNyx9Y2xQDPj40N1p6zkMrzoY2jy8kv7KLBuDRTFJBmju+
         BFCffycP7Z/0pRFHl/7XNprsvCBY44RhAnxRPAWbbyzlSE6tu4050RDAsKaem3tp/TP1
         tRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qJb4ROMmqmKfjFw0cK9zc2HCnw8bdTldzzuHAWqviPg=;
        b=lH08cY2l9COURy0QI+h+WFFW1rnsqK6R6jr9BDYnz06NQaWYPyZwuzEKkU7Ua4RFoU
         4Ymnwku58NNe2ztgDy0AZhvWQUY8gCtxiTHFGbhFpir9Bm7L71BCpQl+/rPK55eOgCMA
         1M00y1nR2g+ztOw8qzF5bVOM+jnFrqk7cpx8NXOS6i4gRM5+btm5HVPmhSvfp5Tv+DuP
         Mt8fgsiLWqFNuPAh+oOKXVnfaPTQ0Mq050s8jw/OcGL66GObPAJ+Jf6wlILlFdog3V3o
         2zhmxbRJRVEJ8jHr+Iqo+J9evld+/jl4PqzBa3d58LdUyvb+LYG4LZIy5/CzRb5/HOvd
         lwIw==
X-Gm-Message-State: AOAM531bk1PRLS7QHSXGznQK6kzokAIbxsb/egfMRzJDqTR74iAnxF8L
        mDMqXxMhIa5YFHJCZJMHK9uB2KFz8ti+aJE=
X-Google-Smtp-Source: ABdhPJzvrveNw41bfaZMuN6O+FPmAul8PH1TnK3z4QpkhItBaSIQ8vftCGgwVksSUdgxE8JHgoWsFA==
X-Received: by 2002:a17:902:e808:b0:161:946c:d266 with SMTP id u8-20020a170902e80800b00161946cd266mr7742135plg.144.1653015395236;
        Thu, 19 May 2022 19:56:35 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id y9-20020a62b509000000b0050dc76281aasm413563pfe.132.2022.05.19.19.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 19:56:34 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     andy@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v3]  gpio: ml-ioh: Convert to use managed functions pcim* and devm_*
Date:   Fri, 20 May 2022 10:56:24 +0800
Message-Id: <20220520025624.3803776-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 When removing the module, we will get the following flaw:

[   14.204955] remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'gpio_ml_ioh'
[   14.205827] WARNING: CPU: 0 PID: 305 at fs/proc/generic.c:717 remove_proc_entry+0x389/0x3f0
...
[   14.220613]  ioh_gpio_remove+0xc5/0xe0 [gpio_ml_ioh]
[   14.221075]  pci_device_remove+0x92/0x240

Fix this by using managed functions, this makes the error handling more
simpler.

Fixes: e971ac9a564a ("gpio: ml-ioh: use resource management for irqs")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/gpio/gpio-ml-ioh.c | 76 ++++++++------------------------------
 1 file changed, 16 insertions(+), 60 deletions(-)

diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index b060c4773698..48e3768a830e 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -409,29 +409,27 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 	void *chip_save;
 	int irq_base;
 
-	ret = pci_enable_device(pdev);
+	ret = pcim_enable_device(pdev);
 	if (ret) {
-		dev_err(dev, "%s : pci_enable_device failed", __func__);
-		goto err_pci_enable;
+		dev_err(dev, "%s : pcim_enable_device failed", __func__);
+		return ret;
 	}
 
-	ret = pci_request_regions(pdev, KBUILD_MODNAME);
+	ret = pcim_iomap_regions(pdev, BIT(1), KBUILD_MODNAME);
 	if (ret) {
-		dev_err(dev, "pci_request_regions failed-%d", ret);
-		goto err_request_regions;
+		dev_err(dev, "pcim_iomap_regions failed-%d", ret);
+		return ret;
 	}
 
-	base = pci_iomap(pdev, 1, 0);
+	base = pcim_iomap_table(pdev)[1];
 	if (!base) {
-		dev_err(dev, "%s : pci_iomap failed", __func__);
-		ret = -ENOMEM;
-		goto err_iomap;
+		dev_err(dev, "%s : pcim_iomap_table failed", __func__);
+		return -ENOMEM;
 	}
 
-	chip_save = kcalloc(8, sizeof(*chip), GFP_KERNEL);
+	chip_save = devm_kcalloc(dev, 8, sizeof(*chip), GFP_KERNEL);
 	if (chip_save == NULL) {
-		ret = -ENOMEM;
-		goto err_kzalloc;
+		return -ENOMEM;
 	}
 
 	chip = chip_save;
@@ -442,10 +440,10 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 		chip->ch = i;
 		spin_lock_init(&chip->spinlock);
 		ioh_gpio_setup(chip, num_ports[i]);
-		ret = gpiochip_add_data(&chip->gpio, chip);
+		ret = devm_gpiochip_add_data(dev, &chip->gpio, chip);
 		if (ret) {
 			dev_err(dev, "IOH gpio: Failed to register GPIO\n");
-			goto err_gpiochip_add;
+			return ret;
 		}
 	}
 
@@ -456,15 +454,14 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 		if (irq_base < 0) {
 			dev_warn(dev,
 				"ml_ioh_gpio: Failed to get IRQ base num\n");
-			ret = irq_base;
-			goto err_gpiochip_add;
+			return irq_base;
 		}
 		chip->irq_base = irq_base;
 
 		ret = ioh_gpio_alloc_generic_chip(chip,
 						  irq_base, num_ports[j]);
 		if (ret)
-			goto err_gpiochip_add;
+			return ret;
 	}
 
 	chip = chip_save;
@@ -472,52 +469,12 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 			       IRQF_SHARED, KBUILD_MODNAME, chip);
 	if (ret != 0) {
 		dev_err(dev, "%s request_irq failed\n", __func__);
-		goto err_gpiochip_add;
+		return ret;
 	}
 
 	pci_set_drvdata(pdev, chip);
 
 	return 0;
-
-err_gpiochip_add:
-	chip = chip_save;
-	while (--i >= 0) {
-		gpiochip_remove(&chip->gpio);
-		chip++;
-	}
-	kfree(chip_save);
-
-err_kzalloc:
-	pci_iounmap(pdev, base);
-
-err_iomap:
-	pci_release_regions(pdev);
-
-err_request_regions:
-	pci_disable_device(pdev);
-
-err_pci_enable:
-
-	dev_err(dev, "%s Failed returns %d\n", __func__, ret);
-	return ret;
-}
-
-static void ioh_gpio_remove(struct pci_dev *pdev)
-{
-	int i;
-	struct ioh_gpio *chip = pci_get_drvdata(pdev);
-	void *chip_save;
-
-	chip_save = chip;
-
-	for (i = 0; i < 8; i++, chip++)
-		gpiochip_remove(&chip->gpio);
-
-	chip = chip_save;
-	pci_iounmap(pdev, chip->base);
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
-	kfree(chip);
 }
 
 static int __maybe_unused ioh_gpio_suspend(struct device *dev)
@@ -558,7 +515,6 @@ static struct pci_driver ioh_gpio_driver = {
 	.name = "ml_ioh_gpio",
 	.id_table = ioh_gpio_pcidev_id,
 	.probe = ioh_gpio_probe,
-	.remove = ioh_gpio_remove,
 	.driver = {
 		.pm = &ioh_gpio_pm_ops,
 	},
-- 
2.36.1

