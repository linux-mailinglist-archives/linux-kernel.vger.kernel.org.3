Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21D24D11B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbiCHIKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344789AbiCHIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:10:24 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9516E3EB92
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:09:28 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3FEF03F60D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646726967;
        bh=JiKqSLqC9cz+DomuU4Hx2hld8wGUXAiXEgnja8m8/QA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=qzy/0jMcFKkiyIMBaRsMnDlK80QqGFhkG5okvxsHwVU7zS+ry8KP5SVoW279J8+eI
         TlwUhhYq7rCEvWLnV11AmIWulN7GatZz8+NV7atHS64bF17f40y++mdLPKj2es875y
         PGJwNw/3060PHr3xnaT/+ek/j+ImdkKT9FmDqc0jx43ehXzVulvJXalBtJwYS7rOuh
         E5ZG2l803VglgfLNPsxzfOL1x+l3t99M7g0iJQc6egsfSKiSV5R4Lv8Dx/J0gDZ9PK
         bYXAfS78kwtOCC611FJGPYUT0fGEBgrpe4ksXfiAgik9D6B7mMdlWNuLq+BTs3xBDN
         kEiUMzR5ubemQ==
Received: by mail-ej1-f69.google.com with SMTP id d7-20020a1709061f4700b006bbf73a7becso8242174ejk.17
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JiKqSLqC9cz+DomuU4Hx2hld8wGUXAiXEgnja8m8/QA=;
        b=lRsQWGEEA4yp4Xq+Mi1b7Cx5E83yQpaFvvWclWuoRbZeSLx5rBus+9yDR/Lx5/P75p
         N44pH1t1gk5EuHbPir6Tq4Pzru/D8Is+vvApeKEpFIwRNLyzoy+2/l99k24UgiWlCh69
         VfLlOaxk1ZRituhVCs8p+C2JC0ba96TPBKiWB2bwYW8UUIT5Wsyb1jAW9NhboMHg7bz9
         uGMf3ChM21SPbs6dgs9CP54C+ErQKnLKJJPYyL+1GJd0e1RxWzC5tDIOODyQvaj/yH+O
         5v5WItCHycdSS/k5n+JCgoJ3Nf8SzvCLxPwT0uGJtD9wLynNWvls1QsL/2SPzSeJbxar
         Qi3w==
X-Gm-Message-State: AOAM531hpuDeXndthnIb5QF44EwBbqYrD63zyoPKI/OnXBzTF7k0Bkv5
        KeY/sBW2wo2wFjsi1nGHl1Amum5pPMdzT1C9x1xCGBDxNnmq/s2TrylGgPAts2UfX4TFQBU0ppK
        /YZPC2XUGiT/7mX65RtDIOfe3lTu+7kyC7F1OCtoeoQ==
X-Received: by 2002:a17:907:9691:b0:6d1:711d:9050 with SMTP id hd17-20020a170907969100b006d1711d9050mr12786631ejc.755.1646726966877;
        Tue, 08 Mar 2022 00:09:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyP0hp7rDrHBkxpGSi42kG38akSsQnOk/uybyIcsE8rFLwZ5IzvABPItTpU0pBtDEzT1lGCMw==
X-Received: by 2002:a17:907:9691:b0:6d1:711d:9050 with SMTP id hd17-20020a170907969100b006d1711d9050mr12786598ejc.755.1646726966458;
        Tue, 08 Mar 2022 00:09:26 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402524400b00415b90801edsm7385697edd.57.2022.03.08.00.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:09:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 3/8] tty: serial: samsung: reduce number of casts
Date:   Tue,  8 Mar 2022 09:09:14 +0100
Message-Id: <20220308080919.152715-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
References: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointers to instances of "struct s3c24xx_serial_drv_data" are first
cast to kernel_ulong_t and then either used directly
(in "platform_device_id.driver_data") or cast again to void * (in
"of_device_id.data").

One cast can be dropped, so at least for "of_device_id.data" case there
will be no casts at all.  This makes the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/samsung_tty.c | 72 ++++++++++++++++----------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index a9a75b5b9705..66434eb58db8 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2637,9 +2637,9 @@ static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
 };
-#define S3C2410_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2410_serial_drv_data)
+#define S3C2410_SERIAL_DRV_DATA (&s3c2410_serial_drv_data)
 #else
-#define S3C2410_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C2410_SERIAL_DRV_DATA NULL
 #endif
 
 #ifdef CONFIG_CPU_S3C2412
@@ -2666,9 +2666,9 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
 };
-#define S3C2412_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2412_serial_drv_data)
+#define S3C2412_SERIAL_DRV_DATA (&s3c2412_serial_drv_data)
 #else
-#define S3C2412_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C2412_SERIAL_DRV_DATA NULL
 #endif
 
 #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2416) || \
@@ -2697,9 +2697,9 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
 };
-#define S3C2440_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2440_serial_drv_data)
+#define S3C2440_SERIAL_DRV_DATA (&s3c2440_serial_drv_data)
 #else
-#define S3C2440_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C2440_SERIAL_DRV_DATA NULL
 #endif
 
 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
@@ -2726,9 +2726,9 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
 };
-#define S3C6400_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c6400_serial_drv_data)
+#define S3C6400_SERIAL_DRV_DATA (&s3c6400_serial_drv_data)
 #else
-#define S3C6400_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C6400_SERIAL_DRV_DATA NULL
 #endif
 
 #ifdef CONFIG_CPU_S5PV210
@@ -2755,9 +2755,9 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 	},
 	.fifosize = { 256, 64, 16, 16 },
 };
-#define S5PV210_SERIAL_DRV_DATA ((kernel_ulong_t)&s5pv210_serial_drv_data)
+#define S5PV210_SERIAL_DRV_DATA (&s5pv210_serial_drv_data)
 #else
-#define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
+#define S5PV210_SERIAL_DRV_DATA	NULL
 #endif
 
 #if defined(CONFIG_ARCH_EXYNOS)
@@ -2799,14 +2799,14 @@ static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
 	.fifosize = { 256, 64, 64, 64 },
 };
 
-#define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos4210_serial_drv_data)
-#define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos5433_serial_drv_data)
-#define EXYNOS850_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos850_serial_drv_data)
+#define EXYNOS4210_SERIAL_DRV_DATA (&exynos4210_serial_drv_data)
+#define EXYNOS5433_SERIAL_DRV_DATA (&exynos5433_serial_drv_data)
+#define EXYNOS850_SERIAL_DRV_DATA (&exynos850_serial_drv_data)
 
 #else
-#define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
-#define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
-#define EXYNOS850_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
+#define EXYNOS4210_SERIAL_DRV_DATA NULL
+#define EXYNOS5433_SERIAL_DRV_DATA NULL
+#define EXYNOS850_SERIAL_DRV_DATA NULL
 #endif
 
 #ifdef CONFIG_ARCH_APPLE
@@ -2832,39 +2832,39 @@ static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
 };
-#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)&s5l_serial_drv_data)
+#define S5L_SERIAL_DRV_DATA (&s5l_serial_drv_data)
 #else
-#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
+#define S5L_SERIAL_DRV_DATA NULL
 #endif
 
 static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	{
 		.name		= "s3c2410-uart",
-		.driver_data	= S3C2410_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)S3C2410_SERIAL_DRV_DATA,
 	}, {
 		.name		= "s3c2412-uart",
-		.driver_data	= S3C2412_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)S3C2412_SERIAL_DRV_DATA,
 	}, {
 		.name		= "s3c2440-uart",
-		.driver_data	= S3C2440_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)S3C2440_SERIAL_DRV_DATA,
 	}, {
 		.name		= "s3c6400-uart",
-		.driver_data	= S3C6400_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)S3C6400_SERIAL_DRV_DATA,
 	}, {
 		.name		= "s5pv210-uart",
-		.driver_data	= S5PV210_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)S5PV210_SERIAL_DRV_DATA,
 	}, {
 		.name		= "exynos4210-uart",
-		.driver_data	= EXYNOS4210_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)EXYNOS4210_SERIAL_DRV_DATA,
 	}, {
 		.name		= "exynos5433-uart",
-		.driver_data	= EXYNOS5433_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)EXYNOS5433_SERIAL_DRV_DATA,
 	}, {
 		.name		= "s5l-uart",
-		.driver_data	= S5L_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)S5L_SERIAL_DRV_DATA,
 	}, {
 		.name		= "exynos850-uart",
-		.driver_data	= EXYNOS850_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)EXYNOS850_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -2873,23 +2873,23 @@ MODULE_DEVICE_TABLE(platform, s3c24xx_serial_driver_ids);
 #ifdef CONFIG_OF
 static const struct of_device_id s3c24xx_uart_dt_match[] = {
 	{ .compatible = "samsung,s3c2410-uart",
-		.data = (void *)S3C2410_SERIAL_DRV_DATA },
+		.data = S3C2410_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,s3c2412-uart",
-		.data = (void *)S3C2412_SERIAL_DRV_DATA },
+		.data = S3C2412_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,s3c2440-uart",
-		.data = (void *)S3C2440_SERIAL_DRV_DATA },
+		.data = S3C2440_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,s3c6400-uart",
-		.data = (void *)S3C6400_SERIAL_DRV_DATA },
+		.data = S3C6400_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,s5pv210-uart",
-		.data = (void *)S5PV210_SERIAL_DRV_DATA },
+		.data = S5PV210_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos4210-uart",
-		.data = (void *)EXYNOS4210_SERIAL_DRV_DATA },
+		.data = EXYNOS4210_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos5433-uart",
-		.data = (void *)EXYNOS5433_SERIAL_DRV_DATA },
+		.data = EXYNOS5433_SERIAL_DRV_DATA },
 	{ .compatible = "apple,s5l-uart",
-		.data = (void *)S5L_SERIAL_DRV_DATA },
+		.data = S5L_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos850-uart",
-		.data = (void *)EXYNOS850_SERIAL_DRV_DATA },
+		.data = EXYNOS850_SERIAL_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
-- 
2.32.0

