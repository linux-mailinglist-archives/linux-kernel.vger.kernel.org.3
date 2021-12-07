Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B8446B7BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhLGJrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhLGJrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:47:08 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A502FC061574;
        Tue,  7 Dec 2021 01:43:38 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v19so9029052plo.7;
        Tue, 07 Dec 2021 01:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bh0sgY0CynSVOBQygTqUBy2hQ/ibiJ6Lgv4CouwRzDU=;
        b=M9sgqrigFWPe+Yv6lI915lNQohM2FqNmsca8uGu7fmqqjqHTasDpOXMcu/mNV0wDTu
         +oIZOr1y5zzhruKUJJ+6RDolg8sfuheh7yCTD4kxlycwd+kwSXxevD1htyI2gp+vPxI0
         qwByNW/wqG2evb2d87yZv+ILl2spg7bsUmiYHdsaGeFwWFumll/zM9o6KxtRNBMnxsMu
         t4UYpZM8EvELVpsPDWLJsjuFCmnIcWVv2G0/BetRYlSUG5T0Psrq8uZpnWcEccgBHPLU
         o2osE3VuXrl3vnboQJtQ21Nw9gq4VEj4lRcCMPA5Tals/0FIiyCzGbUYMWEFj8jFd0yH
         gVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bh0sgY0CynSVOBQygTqUBy2hQ/ibiJ6Lgv4CouwRzDU=;
        b=xM1HHgthcQE4wbKYOkMmHzTcEPv5oDAMawvJnX9sKDIaMA19f1UIKGL2JdsVM/qgb8
         VOchi43vIEG7AchIXDKs5S20qaiL9E1swP6oo23K1MDgA+vMVN1Ut3vEx0XuTBjzmXwy
         DSosGgO39oB1i+xP4/GBXNwQgfPnPgNLU5M6ie+rfrCiW57TQJauH+1ShSy/gckizoOS
         AvBtNcd5/Sf65JOF3gUWjW72qp9K8UWIIWcw237NaS3FG0SbsVQHtkBRInyRzxZGc/Cr
         CnhGo3IzeGKFZOdeW6PFNXMEMXMBnrh+OJyQgA4g/TZsSFL08h6FlbPXp02HwoXUrehG
         0IeA==
X-Gm-Message-State: AOAM533rJbMcZCyEDAlKPQAHa/XziunTgirJMo7gIESRz2ELCHlWdy0/
        DGFtoc6X3Z71LLsWpGQa4Ik=
X-Google-Smtp-Source: ABdhPJx5dEKL7At1NDgZFuVNXph9MXWC4bBSWp/cWcLB63SBMOHIdxAHnG/gg7Pi+2M2mx5LMzgBLw==
X-Received: by 2002:a17:902:7c8a:b0:143:bb4a:7bb3 with SMTP id y10-20020a1709027c8a00b00143bb4a7bb3mr50544959pll.46.1638870218148;
        Tue, 07 Dec 2021 01:43:38 -0800 (PST)
Received: from richard-System-Product-Name.. ([101.10.104.26])
        by smtp.gmail.com with ESMTPSA id y190sm15281494pfg.153.2021.12.07.01.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 01:43:37 -0800 (PST)
From:   Richard Hsu <saraon640529@gmail.com>
X-Google-Original-From: Richard Hsu <Richard_Hsu@asmedia.com.tw>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        Richard_Hsu@asmedia.com.tw, andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Cindy1_Hsu@asmedia.com.tw,
        Andrew_Su@asmedia.com.tw
Subject: [PATCH] gpio:gpio-amdpt:add new device and that 24-pin support
Date:   Tue,  7 Dec 2021 17:42:39 +0800
Message-Id: <20211207094239.5059-1-Richard_Hsu@asmedia.com.tw>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: RichardHsu <Richard_Hsu@asmedia.com.tw>

New ACPI gpio device(AMDIF031) support 24 gpio pins. We add new device id and pin number to .driver_data of acpi_device_id structure
and then retrieve it by device_get_match_data() that Andy suggest it.

Signed-off-by: RichardHsu <Richard_Hsu@asmedia.com.tw>
---
 drivers/gpio/gpio-amdpt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index bbf53e289141..a45693423a07 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>

 #define PT_TOTAL_GPIO 8
+#define PT_TOTAL_GPIO_EX 24

 /* PCI-E MMIO register offsets */
 #define PT_DIRECTION_REG   0x00
@@ -103,7 +104,8 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	pt_gpio->gc.owner            = THIS_MODULE;
 	pt_gpio->gc.request          = pt_gpio_request;
 	pt_gpio->gc.free             = pt_gpio_free;
-	pt_gpio->gc.ngpio            = PT_TOTAL_GPIO;
+	/* retrieve pin number from .driver_data of acpi_device_id structure */
+	pt_gpio->gc.ngpio            = (uintptr_t)device_get_match_data(dev);
 #if defined(CONFIG_OF_GPIO)
 	pt_gpio->gc.of_node          = dev->of_node;
 #endif
@@ -133,8 +135,9 @@ static int pt_gpio_remove(struct platform_device *pdev)
 }

 static const struct acpi_device_id pt_gpio_acpi_match[] = {
-	{ "AMDF030", 0 },
-	{ "AMDIF030", 0 },
+	{ "AMDF030", PT_TOTAL_GPIO },
+	{ "AMDIF030", PT_TOTAL_GPIO },
+	{ "AMDIF031", PT_TOTAL_GPIO_EX },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, pt_gpio_acpi_match);
--
2.30.2

