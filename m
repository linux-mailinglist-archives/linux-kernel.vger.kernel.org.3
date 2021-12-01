Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3FF46587F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 22:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245737AbhLAVqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:46:35 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:37516 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhLAVq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:46:29 -0500
Received: by mail-oi1-f171.google.com with SMTP id bj13so51439795oib.4;
        Wed, 01 Dec 2021 13:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2DnjThda92gYDbdeLO1wf4FxmuOIHogNaNKDjeSi854=;
        b=dSuGVXBbytudtK7Mo5dKE4slRDejhI4Xmzm3o3/wYj3QqF5zWul6fmJ7S06uzpmu9M
         1d9phPpi6Cfj9zzceKV4PvNT/AEyIalPTxqxujB+5qnfzwyvMi5czesZ8Mss1kK+sHIT
         ANTlvq8ovo9qy/lTKRXTDpnqeOrsPGaCI5XTc+apr83EjaNRSHV2imKX/jtNtMBNvn51
         4LH/s+0x8nrM8U0ieDAW83FMpBbv6AK4+vj27bRgDQUl+1OM5tmInw8wdPHBYW6dCOJB
         NP1NbFYqQooCzzCik3fKI48feRNMqqFhm2xkUaXofeL9XRGHSK0LR8hTIBXJDgsgVg+Y
         FHsg==
X-Gm-Message-State: AOAM530lWln576y2l/CmBJK4u4exG2ApKOxc/cJDoaXcUziWYXrusBmZ
        lhqDUNkDDN0I1dzQZhRpFQ==
X-Google-Smtp-Source: ABdhPJwzwRQ+lX3EB3kBsdEGnB4Fog5blZXAeRbGzxOzSKTplhtRRW3fCSAGNZ/XiReYytDkE4XAYQ==
X-Received: by 2002:a05:6808:15a:: with SMTP id h26mr828757oie.123.1638394987136;
        Wed, 01 Dec 2021 13:43:07 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id p6sm379120oof.0.2021.12.01.13.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:43:06 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: xlp: Fix build errors from Netlogic XLP removal
Date:   Wed,  1 Dec 2021 15:43:05 -0600
Message-Id: <20211201214305.2725271-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ea708ac5bf41 ("gpio: xlp: Remove Netlogic XLP variants") has
build errors with CONFIG_ACPI:

drivers/gpio/gpio-xlp.c:300:23: error: 'GPIO_VARIANT_VULCAN' undeclared here (not in a function)

and !CONFIG_OF:

drivers/gpio/gpio-xlp.c:267:11: error: 'struct gpio_chip' has no member named 'of_node'

Fix these errors.

Fixes: ea708ac5bf41 ("gpio: xlp: Remove Netlogic XLP variants")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/gpio/gpio-xlp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-xlp.c b/drivers/gpio/gpio-xlp.c
index 814cc34aef97..0199f545335f 100644
--- a/drivers/gpio/gpio-xlp.c
+++ b/drivers/gpio/gpio-xlp.c
@@ -264,7 +264,6 @@ static int xlp_gpio_probe(struct platform_device *pdev)
 	gc->base = 0;
 	gc->parent = &pdev->dev;
 	gc->ngpio = 70;
-	gc->of_node = pdev->dev.of_node;
 	gc->direction_output = xlp_gpio_dir_output;
 	gc->direction_input = xlp_gpio_dir_input;
 	gc->set = xlp_gpio_set;
@@ -297,8 +296,8 @@ static int xlp_gpio_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id xlp_gpio_acpi_match[] = {
-	{ "BRCM9006", GPIO_VARIANT_VULCAN },
-	{ "CAV9006",  GPIO_VARIANT_VULCAN },
+	{ "BRCM9006" },
+	{ "CAV9006" },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, xlp_gpio_acpi_match);
-- 
2.32.0

