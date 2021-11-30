Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7854631FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbhK3LRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbhK3LQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:16:57 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69301C06175A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:13:35 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k23so40477247lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjrKmm2WgaX87gIsGbMuz72ppQb8wewAQBmcfjqw3Gs=;
        b=VYYZ9M8DIi9wzC6KEpcXHN2kT/9Fkb/lAXo+ByBsrmxDnoeCG8q/7XN6OaSxo6T2y2
         HERQ2rLrfqkHw846RM4pfX8YAgR/6Od0x3Q+rqf8yhzR2o8E3XHHVbyL8yz3S9X52Gdy
         F9MvuoGN+ZiLuxDGhgp1HPkvVbEdzsBv45lkwUd0UlWR+Q7o2jQ9DHy+VmEeCHqPamcY
         TmyCjWYShOiqMTmAFOnbzjmJlUTY4UhPXaDFxxWrGawt2GK7znW0KocWfMAqDqcnEqBE
         kWJDOrhSrDkUZspKZ6oA9xyOJBaq5vmnA/5k8U1ifEKsdT6ZTCfgDUg67ZIN81BsBwXO
         LZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjrKmm2WgaX87gIsGbMuz72ppQb8wewAQBmcfjqw3Gs=;
        b=xeos/6Ser60VOmToJKyFIsFAyLD7gc6r9U8I89Kom92+YE+wRiBidi0F0ABK4laZDP
         ZE4EXKRHux/ExKObgYqGhpsy7pzW9K+vqCTHKAPEUnik0ih/6Qr3QJ4lZgDHBYiCckId
         kuEZMlPPJK45jiyuArKEwpzYDqfLOzeOrS9I33hE7DNCVujrGgxcG4ckikD2wKCj+xr2
         46AsnnqOkbhbtyev9mORHerz+k8OaQXXbESkRl1tHKLpN8YvTAPwttRWL2Ws8PTuWoS9
         W0U4cGJEF6ATwbyvZvt+nPALsmw2DBsslwMMtD4zP86tj9RAwWeIaYsgOZb92Nx507ey
         rNnQ==
X-Gm-Message-State: AOAM5318eoBi5/Olbew6YRVVoqfmgJw9NbIl8XrKUTs8ZahkewkTATKH
        7XQAI/gT7SmDyM8x62/hfdH5uPCQzQcGooe/
X-Google-Smtp-Source: ABdhPJyYyF/8V+rEAq5KS0E49woMPilIZ1j13Zp/4TTUwP69AJDDsWXvXEmZd/NOlDWL4F9ol3Sopw==
X-Received: by 2002:a2e:8515:: with SMTP id j21mr51890869lji.531.1638270813698;
        Tue, 30 Nov 2021 03:13:33 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id m18sm1679456lfu.71.2021.11.30.03.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:13:33 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 RESEND 4/5] tty: serial: samsung: Enable console as module
Date:   Tue, 30 Nov 2021 13:13:24 +0200
Message-Id: <20211130111325.29328-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130111325.29328-1-semen.protsenko@linaro.org>
References: <20211130111325.29328-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable serial driver to be built as a module. To do so, init the console
support on driver/module load instead of using console_initcall().

This is needed for proper support of USI driver (which can be built as
a module, which in turn makes SERIAL_SAMSUNG be a module too). It also
might be useful for Android GKI modularization efforts.

Inspired by commit 87a0b9f98ac5 ("tty: serial: meson: enable console as
module").

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Added error path handling in samsung_serial_init()
  - Added console unregister in samsung_serial_exit()

 drivers/tty/serial/Kconfig       |  2 +-
 drivers/tty/serial/samsung_tty.c | 36 ++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fc543ac97c13..0e5ccb25bdb1 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -263,7 +263,7 @@ config SERIAL_SAMSUNG_UARTS
 
 config SERIAL_SAMSUNG_CONSOLE
 	bool "Support for console on Samsung SoC serial port"
-	depends on SERIAL_SAMSUNG=y
+	depends on SERIAL_SAMSUNG
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index f986a9253dc8..61ccb359620a 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1715,15 +1715,21 @@ s3c24xx_serial_verify_port(struct uart_port *port, struct serial_struct *ser)
 
 static struct console s3c24xx_serial_console;
 
-static int __init s3c24xx_serial_console_init(void)
+static void __init s3c24xx_serial_register_console(void)
 {
 	register_console(&s3c24xx_serial_console);
-	return 0;
 }
-console_initcall(s3c24xx_serial_console_init);
+
+static void s3c24xx_serial_unregister_console(void)
+{
+	if (s3c24xx_serial_console.flags & CON_ENABLED)
+		unregister_console(&s3c24xx_serial_console);
+}
 
 #define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
 #else
+static inline void s3c24xx_serial_register_console(void) { }
+static inline void s3c24xx_serial_unregister_console(void) { }
 #define S3C24XX_SERIAL_CONSOLE NULL
 #endif
 
@@ -2898,7 +2904,29 @@ static struct platform_driver samsung_serial_driver = {
 	},
 };
 
-module_platform_driver(samsung_serial_driver);
+static int __init samsung_serial_init(void)
+{
+	int ret;
+
+	s3c24xx_serial_register_console();
+
+	ret = platform_driver_register(&samsung_serial_driver);
+	if (ret) {
+		s3c24xx_serial_unregister_console();
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit samsung_serial_exit(void)
+{
+	platform_driver_unregister(&samsung_serial_driver);
+	s3c24xx_serial_unregister_console();
+}
+
+module_init(samsung_serial_init);
+module_exit(samsung_serial_exit);
 
 #ifdef CONFIG_SERIAL_SAMSUNG_CONSOLE
 /*
-- 
2.30.2

