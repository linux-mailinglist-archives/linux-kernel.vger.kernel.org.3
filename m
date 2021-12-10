Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8746FD53
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbhLJJHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbhLJJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:07:19 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCF9C061746;
        Fri, 10 Dec 2021 01:03:44 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id l18so2817638pgj.9;
        Fri, 10 Dec 2021 01:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3XFOGIsP6ZZ5vZsBuRPmQLl3NqYf5+VCjncPR3DoDc=;
        b=ISJpK97yMHhZU+4Irs3+RjHVvAkfh2GTc49DKjmH9Sln1qxvRCdRcJPW/V+BcJJYUX
         pB4F4ZbCNk/9Cc+pQR7JNIwQJAlme1HoKPF42AbcdFiRkPy0GySl6qwLvN9mY2AZuqOL
         Gk3WxvToTMuupR+g96GCo8q8JkwYevQHylmSMn9Cf+IGN8xcj2QsOY7B2vsxsSStZ8bc
         GFlTCQ2IJuJYT+IYan5dBy2oMSWCZ/s83RVgu2SwTewszsX7rAUcLXw+hXgu8MeYFBsH
         KCJk5pWPNoIdVNufeLMQn/itZkdR8s8NLJSRJsyXf3AVm8MVTaOCXlvpaq3mhUeAxi+G
         skUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3XFOGIsP6ZZ5vZsBuRPmQLl3NqYf5+VCjncPR3DoDc=;
        b=XLt9JVKBipvMOkEfISlZVb9zN1IE33uGFkvR5x7oqQPiPNFxurxCrRhrwHpnjpQrC3
         Aa2Y1MSn9FYJ45Wg9ZdHuyyjDnUyZJl8dC4/2nsWaRMaISZgMz5bV7CBPALbRNRiEpaN
         SwoeSNtdk3kskt1jqiiahIWSwhuGSB+CWZFkmM3PJmOKlGrrs0c+FbNG8DPZfOffoV81
         T1+JoRAnPhRYJAIRzo+QB3rXWrRUvK7Ni+cdf18SC5+FSNWnp9vwO3j6Z++5KPCDsP3G
         bBDgq/CD4jBeQcHWctDCjqH6mTuNejubkgv7JiCNv8fz4QyX7KllpyhClYA+ADCERB7A
         FMLw==
X-Gm-Message-State: AOAM531mHrJSXUjhROul7He64VslXziiDo5tymFsCnSMvPS9YHJbFfK9
        2hXeH6MjXDcEpO6Y8BPbuz4gEak717ofAQ==
X-Google-Smtp-Source: ABdhPJz4trpsmo6mdN6rP8Pz16+sQ3RMK/aIc8nKIZ2dS64lTKF3Cz4FcydP8xNHuF65FAx+5Iwa+Q==
X-Received: by 2002:a62:820e:0:b0:4b1:3cea:f0f6 with SMTP id w14-20020a62820e000000b004b13ceaf0f6mr2126931pfd.47.1639127024373;
        Fri, 10 Dec 2021 01:03:44 -0800 (PST)
Received: from richard-System-Product-Name.. ([101.10.104.26])
        by smtp.gmail.com with ESMTPSA id u32sm2592357pfg.220.2021.12.10.01.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 01:03:43 -0800 (PST)
From:   Yuchang Hsu <saraon640529@gmail.com>
X-Google-Original-From: Yuchang Hsu <Richard_Hsu@asmedia.com.tw>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        Richard_Hsu@asmedia.com.tw, andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Cindy1_Hsu@asmedia.com.tw,
        Andrew_Su@asmedia.com.tw
Subject: [PATCH v4] gpio: amdpt: add new device ID and 24-pin support
Date:   Fri, 10 Dec 2021 17:03:15 +0800
Message-Id: <20211210090315.4889-1-Richard_Hsu@asmedia.com.tw>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hsu Yuchang <Richard_Hsu@asmedia.com.tw>

Add an ACPI HID(AMDIF031) and pin number in the pt_gpio_acpi_match.

Signed-off-by: Yuchang Hsu <Richard_Hsu@asmedia.com.tw>
---
Reposition and modify the changelog
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

