Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D624D11B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbiCHIKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344784AbiCHIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:10:22 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C323EA95
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:09:26 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0F0C33F618
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646726965;
        bh=Dwp/aQOBQEXJT+052j4TYlKoFTeM490hQz5ZQ8IolK4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GkgWIVEaTirXnRwDelGoi01Gli8aZ5HPIdhSzenB0f59kewQO0FMHflBvYoG//gAo
         yDENmjeEWX4eLP5MwCbt5quvQyrPwpCPkJsU2IGsXj5FKAFo54whQ73ydgVFuhlvCt
         7OZJGz55aeswfySJmGAq0lp/TQlH6ldU2qZZeS3GE/lqQW6ON6KT0epjFt77QK1ruD
         qAqF37X/IdbBvD5jH6UjYjSWHyW+lBojRwKu2gjyasr2UFHQXrrQcI0cWPXzvFASEy
         nF7CgiG4k647O73imKRhoHhm46qs6nZrCIjnU644lMdfJOeqzfJmxAzGKbT/vaxnHJ
         YTGaQUqWnDpWA==
Received: by mail-ed1-f70.google.com with SMTP id h17-20020a05640250d100b004133863d836so10157781edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dwp/aQOBQEXJT+052j4TYlKoFTeM490hQz5ZQ8IolK4=;
        b=aKTq86C+vu/zuKzeiRloqzAVJwLMpzLyMHNgFPXnKMbSziCPZ8/wjR/SiozvhkyUyI
         c/9aLITYy8xGcfjvlBrfkp0nH+DS/LBnxHXvv+ze1Hz1hDgrr40I7s79Tm67ak4rRz4d
         k7nO39eQmCfmjPOCj26pkdx+xaRA5RnFv3c+jN7kv+wUABc5nRha4TmlepCJLIAUUEyC
         4S4GS7/kFH1XCfFiPl/y143kjtONZV5ndZMMX5mvTPhD4GyOnfUeZcr6Q7CG2PBFzj06
         ypSy480U4qSbxutcyyRmyxhk3YsxZK2jOK4Ao5r05B89AXP/xXhGuqfro6KDkEPMOI6C
         DIVw==
X-Gm-Message-State: AOAM532wQnIKR/wT5Ghfw++njFRm+jGbnafU7klpYI2YM0qSdxhi4ljG
        b7AklbVVlrCIJfhNmFzeEp2pRgG/NZTDiSOw3Sxhb7fJYm+OVhU23pZhzblF9sRSDYQMojPYdHL
        GWbx85G/s1Mt595c0rIJBOljgK8C2S2k2fdp3oEb5bg==
X-Received: by 2002:a17:907:8688:b0:6d2:c19:e1a0 with SMTP id qa8-20020a170907868800b006d20c19e1a0mr11801069ejc.249.1646726963524;
        Tue, 08 Mar 2022 00:09:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQGA9AtYeOF5o4ZCAtjuIHASbFdPaBaVMJaKdXkELr+T4yRLutynO8tWxKX7iXVrYNqK6kmw==
X-Received: by 2002:a17:907:8688:b0:6d2:c19:e1a0 with SMTP id qa8-20020a170907868800b006d20c19e1a0mr11801059ejc.249.1646726963335;
        Tue, 08 Mar 2022 00:09:23 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402524400b00415b90801edsm7385697edd.57.2022.03.08.00.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:09:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 1/8] tty: serial: samsung: embed s3c24xx_uart_info in parent structure
Date:   Tue,  8 Mar 2022 09:09:12 +0100
Message-Id: <20220308080919.152715-2-krzysztof.kozlowski@canonical.com>
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

Embed "struct s3c24xx_uart_info" directly as a member of "struct
s3c24xx_serial_drv_data" instead of keeping it as a pointer.  This makes
the code clearer (obvious ownership of "struct s3c24xx_serial_drv_data")
and saves one pointer.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d002a4e48ed9..aa5678d03704 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -85,7 +85,7 @@ struct s3c24xx_uart_info {
 };
 
 struct s3c24xx_serial_drv_data {
-	struct s3c24xx_uart_info	*info;
+	struct s3c24xx_uart_info	info;
 	struct s3c2410_uartcfg		*def_cfg;
 	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
 };
@@ -2197,7 +2197,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	}
 
 	ourport->baudclk = ERR_PTR(-EINVAL);
-	ourport->info = ourport->drv_data->info;
+	ourport->info = &ourport->drv_data->info;
 	ourport->cfg = (dev_get_platdata(&pdev->dev)) ?
 			dev_get_platdata(&pdev->dev) :
 			ourport->drv_data->def_cfg;
@@ -2616,7 +2616,7 @@ static struct console s3c24xx_serial_console = {
 
 #ifdef CONFIG_CPU_S3C2410
 static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
+	.info = {
 		.name		= "Samsung S3C2410 UART",
 		.type		= TYPE_S3C24XX,
 		.port_type	= PORT_S3C2410,
@@ -2644,7 +2644,7 @@ static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
 
 #ifdef CONFIG_CPU_S3C2412
 static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
+	.info = {
 		.name		= "Samsung S3C2412 UART",
 		.type		= TYPE_S3C24XX,
 		.port_type	= PORT_S3C2412,
@@ -2674,7 +2674,7 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2416) || \
 	defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2442)
 static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
+	.info = {
 		.name		= "Samsung S3C2440 UART",
 		.type		= TYPE_S3C24XX,
 		.port_type	= PORT_S3C2440,
@@ -2704,7 +2704,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 
 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
 static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
+	.info = {
 		.name		= "Samsung S3C6400 UART",
 		.type		= TYPE_S3C6400,
 		.port_type	= PORT_S3C6400,
@@ -2733,7 +2733,7 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 
 #ifdef CONFIG_CPU_S5PV210
 static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
+	.info = {
 		.name		= "Samsung S5PV210 UART",
 		.type		= TYPE_S3C6400,
 		.port_type	= PORT_S3C6400,
@@ -2762,7 +2762,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 
 #if defined(CONFIG_ARCH_EXYNOS)
 #define EXYNOS_COMMON_SERIAL_DRV_DATA()				\
-	.info = &(struct s3c24xx_uart_info) {			\
+	.info = {						\
 		.name		= "Samsung Exynos UART",	\
 		.type		= TYPE_S3C6400,			\
 		.port_type	= PORT_S3C6400,			\
@@ -2811,7 +2811,7 @@ static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
 
 #ifdef CONFIG_ARCH_APPLE
 static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
+	.info = {
 		.name		= "Apple S5L UART",
 		.type		= TYPE_APPLE_S5L,
 		.port_type	= PORT_8250,
-- 
2.32.0

