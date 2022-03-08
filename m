Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF954D11AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbiCHIK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344785AbiCHIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:10:22 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531E43EAA8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:09:26 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3278F3F79D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646726965;
        bh=RaO5N5+xpc6qv0C5C+2+SP0aJMALLkB4br4l3fJLsRI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=BdgUOyLggHdP9lzIgR65TSCLNFsbrhCJxfwBq9I+iSu1TljH75CFwmoH4zwRfHknE
         91DaYOqkWzQca3UfMc0wgNFDbmUtNptGs9E1oy2Mo4XKcJCYrj+1whz7DoYnY/nybz
         XcUxP5cf9mwfKEGumdk9wbyV3/zCaFOCrjXGjWClNVgLMkvQXT4Is5W2bnYIEuWLmc
         jxCjPFnNElUfo/TH6fM8QltQ3UpXsdovC5Y7iIZvlB4Fx2LpmjQoKHNxq2aO7Nh2Jf
         r59g/PifU2Sy0KMemr7Docc8q2tTKfjvmecG79Npr14oZi4F+PeOHYwCzQQA4ENVzt
         7zJFKdQVCQuUA==
Received: by mail-ej1-f70.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so8186728ejw.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RaO5N5+xpc6qv0C5C+2+SP0aJMALLkB4br4l3fJLsRI=;
        b=46/FMph8ifjyD1fhAN36VDmgEse4rmFYPylBAHCXw1/XUlxUBlbBR2Sl+hl/qnQkO4
         K3ajL2lmY5OauUUo1JsQlTBMwfOUITjjaO+aXWRkSEn8xarJNIIbASMizrF+InNhgDbD
         46DvI18sB39GE8aSP/dsiR2yz0rBzGokuPPC/ZsAkbsx9OPg+MsTh1GKoYM4/O8LRyuw
         t0BWl85wkfSOrGHgwqJnsPI5mL8F7gkJMsG9v9Uy6LAPphVO6svEihcHYqUSyxrsMadf
         Io/S1K9t3nEaEAtcdmJBzfgX2rd3asBwzX9quQiVRo9OqjzRw0NKrdvR6KPU9dwLj7az
         xSAA==
X-Gm-Message-State: AOAM532PoF607Bz7SmBpvgEQFPaR4M8pMVuu1gUwSXAnMNIlQzCj9IFU
        G3ftS03Puf7eki4jnDQDoOFkscgwAuNXFtfaoyBW2A7GWkaK8klnesFsH4D4kq+MSGh97pp4TFR
        Eqprx2chcMs4CqqrggEIi96afcIJxG3YkdcZd/vpUJw==
X-Received: by 2002:a17:906:7d83:b0:6ce:fee:9256 with SMTP id v3-20020a1709067d8300b006ce0fee9256mr12751422ejo.647.1646726964793;
        Tue, 08 Mar 2022 00:09:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6SJAGGC/ezAoZpSp4TpDtyzbSfuJ1xdN0lOAmzmlE3wQWBFRDDMvLFPw6x2SrFrtTdkAZ4g==
X-Received: by 2002:a17:906:7d83:b0:6ce:fee:9256 with SMTP id v3-20020a1709067d8300b006ce0fee9256mr12751408ejo.647.1646726964615;
        Tue, 08 Mar 2022 00:09:24 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402524400b00415b90801edsm7385697edd.57.2022.03.08.00.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:09:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 2/8] tty: serial: samsung: embed s3c2410_uartcfg in parent structure
Date:   Tue,  8 Mar 2022 09:09:13 +0100
Message-Id: <20220308080919.152715-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
References: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Embed "struct s3c2410_uartcfg" directly as a member of "struct
s3c24xx_serial_drv_data" instead of keeping it as a pointer.  This makes
the code clearer (obvious ownership of "s3c2410_uartcfg
s3c24xx_serial_drv_data") and saves one pointer.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index aa5678d03704..a9a75b5b9705 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -86,7 +86,7 @@ struct s3c24xx_uart_info {
 
 struct s3c24xx_serial_drv_data {
 	struct s3c24xx_uart_info	info;
-	struct s3c2410_uartcfg		*def_cfg;
+	struct s3c2410_uartcfg		def_cfg;
 	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
 };
 
@@ -2200,7 +2200,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	ourport->info = &ourport->drv_data->info;
 	ourport->cfg = (dev_get_platdata(&pdev->dev)) ?
 			dev_get_platdata(&pdev->dev) :
-			ourport->drv_data->def_cfg;
+			&ourport->drv_data->def_cfg;
 
 	switch (ourport->info->type) {
 	case TYPE_S3C24XX:
@@ -2632,7 +2632,7 @@ static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
 		.clksel_mask	= S3C2410_UCON_CLKMASK,
 		.clksel_shift	= S3C2410_UCON_CLKSHIFT,
 	},
-	.def_cfg = &(struct s3c2410_uartcfg) {
+	.def_cfg = {
 		.ucon		= S3C2410_UCON_DEFAULT,
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
@@ -2661,7 +2661,7 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 		.clksel_mask	= S3C2412_UCON_CLKMASK,
 		.clksel_shift	= S3C2412_UCON_CLKSHIFT,
 	},
-	.def_cfg = &(struct s3c2410_uartcfg) {
+	.def_cfg = {
 		.ucon		= S3C2410_UCON_DEFAULT,
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
@@ -2692,7 +2692,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 		.clksel_shift	= S3C2412_UCON_CLKSHIFT,
 		.ucon_mask	= S3C2440_UCON0_DIVMASK,
 	},
-	.def_cfg = &(struct s3c2410_uartcfg) {
+	.def_cfg = {
 		.ucon		= S3C2410_UCON_DEFAULT,
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
@@ -2721,7 +2721,7 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 		.clksel_mask	= S3C6400_UCON_CLKMASK,
 		.clksel_shift	= S3C6400_UCON_CLKSHIFT,
 	},
-	.def_cfg = &(struct s3c2410_uartcfg) {
+	.def_cfg = {
 		.ucon		= S3C2410_UCON_DEFAULT,
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
@@ -2749,7 +2749,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 		.clksel_mask	= S5PV210_UCON_CLKMASK,
 		.clksel_shift	= S5PV210_UCON_CLKSHIFT,
 	},
-	.def_cfg = &(struct s3c2410_uartcfg) {
+	.def_cfg = {
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
@@ -2778,7 +2778,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 		.clksel_mask	= 0,				\
 		.clksel_shift	= 0,				\
 	},							\
-	.def_cfg = &(struct s3c2410_uartcfg) {			\
+	.def_cfg = {						\
 		.ucon		= S5PV210_UCON_DEFAULT,		\
 		.ufcon		= S5PV210_UFCON_DEFAULT,	\
 		.has_fracval	= 1,				\
@@ -2827,7 +2827,7 @@ static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 		.clksel_mask	= 0,
 		.clksel_shift	= 0,
 	},
-	.def_cfg = &(struct s3c2410_uartcfg) {
+	.def_cfg = {
 		.ucon		= APPLE_S5L_UCON_DEFAULT,
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
-- 
2.32.0

