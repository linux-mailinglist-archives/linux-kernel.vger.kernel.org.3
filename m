Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F1A46E0DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhLICbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhLICbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:31:08 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494A2C061746;
        Wed,  8 Dec 2021 18:27:36 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id o4so4052934pfp.13;
        Wed, 08 Dec 2021 18:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NN4IHOXyChcCNha1Aa97FuoLYA9NC8iJD0LFtZlQUGQ=;
        b=etIqSRpLMHUKDoIm5qc8PDyOOzpna4ucc27Z9BJ5nuD3HXuHjBEhSxqREofrc21pIs
         mSaY9ic6MrobARAMVXZd6E5+NzuPOMnGkZXG+mvcdaFiXTA48DoQm8oxX/+UxV7l0WhC
         lZHaSEee7A+4V0DStL93cuiTHbf+uTbS7hqMAALaI1XfuDZ6y9V+Q1lwActv5hDarHuv
         G8ZzkehRvc0LDOK8ezwEW0dFZJBUoclWRjQGq4tiUjsO1g4XGs2CT/FbmKE0KJIcI6qI
         rhAPaXOzCd+Iw4xtEmcSTLq51IbkGz+JlQyKEu1UdLkWsTUeFwitq1tS0PM60A1AsoAZ
         YQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NN4IHOXyChcCNha1Aa97FuoLYA9NC8iJD0LFtZlQUGQ=;
        b=CJswmZftmgg0hYlx1Cdaauxbm0PAKjblr2+mMNpOsui6JWEVA7KJUlDX+x7t7DxKbY
         i6VdgJswBB0ld/wjeJcyO6XxCibu6n/sodK4xfEv5vNNSU4OcLQpG+xL0GChMpnQr5hH
         gjg2XJped1AuAvxoqKqtT6VJ9irhhKgmMsL3d2eH2azeyG2Rw6gr6gmgG5KP7yeQGP1N
         BHH8yTuz/67BG+Jwch1tgKjvDcHqNFOls0IVXGwQ0pXcQMRtTw1nsC0uSmSwWv+w5PRE
         Ysbss5hHAMj+b5CsY8+EGX+Q2SUMbMsHdZXvmQROOW3dXFz+rE4HlGvwF/nL2S0XDncq
         c8TA==
X-Gm-Message-State: AOAM530prLvYTNVDRS7yFPs6Juw2BjwY1XcOCUULeFfHYcShGOpFJHhj
        yDgw5R60aH2NYlaaJWj4oRk=
X-Google-Smtp-Source: ABdhPJxdL3gQtt60ZSUlfI4bfXKzmcyjeO/FpWKhWC2wMULyepz2/CrPJkPqfR/P9ka2nUxSuQWCeg==
X-Received: by 2002:a63:ee04:: with SMTP id e4mr32290947pgi.266.1639016855788;
        Wed, 08 Dec 2021 18:27:35 -0800 (PST)
Received: from richard-System-Product-Name.. ([101.10.104.26])
        by smtp.gmail.com with ESMTPSA id q8sm5318749pfk.152.2021.12.08.18.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 18:27:35 -0800 (PST)
From:   Yuchang Hsu <saraon640529@gmail.com>
X-Google-Original-From: Yuchang Hsu <Richard_Hsu@asmedia.com.tw>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        Richard_Hsu@asmedia.com.tw, andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Cindy1_Hsu@asmedia.com.tw,
        Andrew_Su@asmedia.com.tw
Subject: [PATCH v3] gpio:amdpt:add new device ID and 24-pin support
Date:   Thu,  9 Dec 2021 10:26:05 +0800
Message-Id: <20211209022605.11250-1-Richard_Hsu@asmedia.com.tw>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hsu Yuchang <Richard_Hsu@asmedia.com.tw>

This patch add an ACPI HID(AMDIF031) and pin number in the pt_gpio_acpi_match.
And we retrieve pin number by device_get_match_data().

Signed-off-by: Yuchang Hsu <Richard_Hsu@asmedia.com.tw>
--- Add AMDIF031 support
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

