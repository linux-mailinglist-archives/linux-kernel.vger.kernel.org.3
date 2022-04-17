Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19B450486D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiDQQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbiDQQ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:56:05 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B9366A6;
        Sun, 17 Apr 2022 09:53:28 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 79so4225824iou.7;
        Sun, 17 Apr 2022 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SE/JUxfuW/QxTb++fk+mriOUA6JHM85iCZJkZkrQ1C4=;
        b=Sjse0foV8Q9We+8VbVwP9DRhkXZGEGAqTpumlGSau1lKbjW/wXHUkSEXl7Jd6GQFav
         O4NWHRtkzSXeM7uWlxT+yk3AbDu8/C4uzFgkr6XswILcRad1VV9lwFFyLkPfOuZajabk
         xmPNgfQMDO1iiLQdUkw45yN0JcaQe/lNUJuj1r+IbY+pcYnrV/v0GVCXsOUPJShGOwgR
         cWl/Mwsfg5GZNqs/Ie0J8y6dNcW+OAOx7A9dLWuE2oSBmzF+B8fBQsT5dh7YokZsu1CM
         KXKgm7P7rqLNO+TYDqCmifsS/Wq6otl5Ii7KEDGFw6ApGzgLqrmMZ0EiEFjAQZi/xBNF
         resw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SE/JUxfuW/QxTb++fk+mriOUA6JHM85iCZJkZkrQ1C4=;
        b=y4jKkucsv1ZnFatRngzvz7gEh5wFRsCzIGqVIzEWRi6IcUuGiBGx4MD0QH/ad4Ggqs
         MBU02932XxuBAV9VuQbrGEFm8bVCCLFetRwyDrfj10e6DcnF14a+XIg3Fo8mukZ7D0Et
         D8b43Y24r+whslMUZJxjADLZEXD+s1Y7Y+46zoPy0jJ8iipV5FAZxyjW45hoVgDVHZsn
         kseVyWoJKi90sT8bK2j5Q4Rx1CvXHaC8pSKtAKDVPeVsV7g7oPPiQ+gBD0ezD8LLu+wz
         L8MUx0RKmK711jd8F8XVk3mVf1xdxO2eiV3kOP0eWdDbbCDE4V/jSeOUFeUOprz+fykE
         ZPEg==
X-Gm-Message-State: AOAM531Kq5PXMMqqLCitPL17/HV4x1iQHKeYkKFdpsGWkM7ztcqp0IMe
        1A91m2Mp31w1o13JcbBlIC8=
X-Google-Smtp-Source: ABdhPJwNah/4aGnaAOv4hzit2lCkg4f0rwUk+60fuPdK0ACgwM89Me72jpv3MHOBwLLrtJHC6d4s4w==
X-Received: by 2002:a05:6638:4191:b0:326:3d26:6953 with SMTP id az17-20020a056638419100b003263d266953mr3427253jab.101.1650214408097;
        Sun, 17 Apr 2022 09:53:28 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id d16-20020a056e020bf000b002ca51236f60sm6047879ilu.9.2022.04.17.09.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:53:27 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 07/15] gpio: loongson1: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:52:00 +0800
Message-Id: <20220417165208.39754-7-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220417165208.39754-1-schspa@gmail.com>
References: <CAHp75Veo30c0BWb4Fykgvd-czSnEXsyA8wyMTeKQdS49=e5-nw@mail.gmail.com>
 <20220417165208.39754-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bgpio_lock is changed to raw lock, fellow the header change

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/gpio/gpio-loongson1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index 1b1ee94eeab4..5d90b3bc5a25 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -25,10 +25,10 @@ static int ls1x_gpio_request(struct gpio_chip *gc, unsigned int offset)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	__raw_writel(__raw_readl(gpio_reg_base + GPIO_CFG) | BIT(offset),
 		     gpio_reg_base + GPIO_CFG);
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	return 0;
 }
@@ -37,10 +37,10 @@ static void ls1x_gpio_free(struct gpio_chip *gc, unsigned int offset)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	__raw_writel(__raw_readl(gpio_reg_base + GPIO_CFG) & ~BIT(offset),
 		     gpio_reg_base + GPIO_CFG);
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static int ls1x_gpio_probe(struct platform_device *pdev)
-- 
2.24.3 (Apple Git-128)

