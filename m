Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C5D46D124
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhLHKkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhLHKkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:40:41 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A267C061746;
        Wed,  8 Dec 2021 02:37:10 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s137so1704841pgs.5;
        Wed, 08 Dec 2021 02:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QAO9WgbdcG7XY4iq2f+Xd4Bi6s7cs1QXT9+5RcWd2OY=;
        b=XRF2lSZq+zGIP2Vkk5zwpHdGShHUprMtHTasrVm5VV0k7hlIj14fXYunPB4Xx++i81
         0sEbGMPstlp7VkUhKhOhE9fOhzgtxLUhDVKWaD73HCK5mqbPSUHJ85x3XdAnYOmZlFNG
         ofq0Yd5neuqffzsWAq2kpSNuVOlk5PRhZDmrPCmBqqD1QwdBx4OIUuMkHNi1YXRg4iNH
         vZdn8l1JZfWF+SLvWkXAm1rzNZ2JhOlqgK78uMJNFVFns5Y+h92Dykv2keSNNjme93mq
         EcHbBcwyBdXDjn0gcEO5N8Kb8IrQT5Isr4kjD6WX1LclHFpcNyIa/LsPpo9bBNIp84hB
         3MDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QAO9WgbdcG7XY4iq2f+Xd4Bi6s7cs1QXT9+5RcWd2OY=;
        b=bfS/FUCmxGFAhKxSESZJhKU2eCDu93ISLqeoTmDDv6An5SK9xsplLoAI0HBZAlSMb4
         lxAGQbf7TPP0A0xVgOnhR9+YaCZA4CBkMJY2Dvcr8gn+ZO6Ln7R2lO9Snr3niSWV+WMO
         qQsEqVV4pVhcEf98djeYe3ALgB7pzo3gACaC2rXqBmT6epMYt0b9UYw+U8VayCeE4EeC
         9VhekEbN6Jkx2oaZxLOR5cKc+cYrdGU/98nYl1vIWpGTdVqK5XhU7CnHpLr0VDm9PypF
         yAjSkjKb6FBdydX5fcbOog2Kg5YbfM94AFJmVcLvfEeL0JuM9aqpmgYEiheNHNuljFr8
         ZCdA==
X-Gm-Message-State: AOAM532VukTgVUpVqqAcm8intiW0Iy35C0XLWngUHdhWaHskk99bm3xg
        HyYAzR6uCsEFVV/TGPVVA3jlrhrvDFGnTw==
X-Google-Smtp-Source: ABdhPJyI9W9Imnrkv/isPspoZGYhH1PJFwKCqlQPI4jabpzGjOKIaRbBr1OjPZWVhWdYAjZGM1hqVg==
X-Received: by 2002:a63:5520:: with SMTP id j32mr29677836pgb.443.1638959829878;
        Wed, 08 Dec 2021 02:37:09 -0800 (PST)
Received: from richard-System-Product-Name.. ([101.10.104.26])
        by smtp.gmail.com with ESMTPSA id d21sm3247569pfu.52.2021.12.08.02.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 02:37:08 -0800 (PST)
From:   Yuchang Hsu <saraon640529@gmail.com>
X-Google-Original-From: Yuchang Hsu <Richard_Hsu@asmedia.com.tw>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        Richard_Hsu@asmedia.com.tw, andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Cindy1_Hsu@asmedia.com.tw,
        Andrew_Su@asmedia.com.tw
Subject: [PATCH v2] gpio:amdpt:add new device ID and 24-pin support
Date:   Wed,  8 Dec 2021 18:36:21 +0800
Message-Id: <20211208103621.9253-1-Richard_Hsu@asmedia.com.tw>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy Shevchenko,
How and what to put the Changelog after '---'?i just remove '---'.

This patch adds a ACPI HID(AMDIF031) and pin number in the pt_gpio_acpi_match.
And We retrieve pin number supporting by device_get_match_data().

Signed-off-by: Yuchang Hsu <Richard_Hsu@asmedia.com.tw>

 drivers/gpio/gpio-amdpt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index bbf53e289141..13f4e2af3800 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>

 #define PT_TOTAL_GPIO 8
+#define PT_TOTAL_GPIO_EX 24

 /* PCI-E MMIO register offsets */
 #define PT_DIRECTION_REG   0x00
@@ -103,7 +104,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	pt_gpio->gc.owner            = THIS_MODULE;
 	pt_gpio->gc.request          = pt_gpio_request;
 	pt_gpio->gc.free             = pt_gpio_free;
-	pt_gpio->gc.ngpio            = PT_TOTAL_GPIO;
+	pt_gpio->gc.ngpio            = (uintptr_t)device_get_match_data(dev);
 #if defined(CONFIG_OF_GPIO)
 	pt_gpio->gc.of_node          = dev->of_node;
 #endif
@@ -133,8 +134,9 @@ static int pt_gpio_remove(struct platform_device *pdev)
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

BR
 Richard

