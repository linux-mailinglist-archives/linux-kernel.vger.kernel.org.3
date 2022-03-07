Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA524CF33A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiCGIJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiCGIJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:09:53 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE121BE81
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:08:59 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 240C23F605
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646640537;
        bh=eR7Mc9vi/w7iGpwa309YiCzl9zkdxojESdgSBLZGEv4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LCYw9LR02HlXPdwP+3ZrOyrR6ROD6a+t+6G7Xfk21TSR7F+Cn1c2qhz2FI6Coxk3n
         aPeeQLsYQih2aJaqWLkTEV/uqtOVykfnUj674bFOTtzoUWGr3TDawOe8pbXD/X+9cg
         4H4H98Fwa6ysuatFo5To85a117moSKx4ruwOMZLsqWiQ7NoL/oBxtD5axYR338d/Dm
         B5J2jHAwLhNPHuLBzYHS/b1HNC+fdflt/ttAqBPuVISL/r7o9H5sAxxalZ9Qgq28lX
         fGzZsRxKAjitMc2oN1MgnLD5CZBvDyZehOpwOx93h0eXfafScILNzk7bvn29D0Aw+T
         MJhp4GGM/BRJg==
Received: by mail-ej1-f69.google.com with SMTP id d7-20020a1709061f4700b006bbf73a7becso6598502ejk.17
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eR7Mc9vi/w7iGpwa309YiCzl9zkdxojESdgSBLZGEv4=;
        b=lHMKhOujP0Jju4pGjbgMrOTbohyKj6pbkQe8cIL0uewVIfni5HkYlKPbBrvvQwufRM
         d8O9lF+nv6TvI2Nk/PtCm+2+y1iISC/EjgerPicDStK1oOBVInnUrcOSFagxkt6CtNx3
         KRxqX/NcTuwOlQcBsevXd1twuYpaZSNIwT+eA0uj3LtSpQY2P4nC/L9vrW6JlhYqz0t+
         6Oo1ea5ezEzeD1Ia+hIuW7Kc5bfg2elNEQG3DCtWE3JPsZ40nBEm/S3asBlv26JLMRj5
         fvC0wWABpYNlx83OaAMO/ejQgI39w3GLF9wluOWi3eDVDgeZPB8PAeKKjFyaHXU7NOu5
         +iXg==
X-Gm-Message-State: AOAM532tVsvQdWhQKAgBVtDCN/LNcl1SjcxQMTlK2qWpfldUheR59g15
        1bx/kkb9Tv1zG/L/H5i4nQkZh5W7wVuwwNPp82szuXDyjtgT5FMXmELcQBfiyVg7jeIbBy+JqKl
        FxnooSRSBCbXOL2IxXERpMy4pbD98OXlXM6rrkOqjNA==
X-Received: by 2002:a17:907:d06:b0:6da:2902:e9ad with SMTP id gn6-20020a1709070d0600b006da2902e9admr8377711ejc.566.1646640535810;
        Mon, 07 Mar 2022 00:08:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCbsSDsaeQ5A3m0lusAuFH7GkNNgJvj5FHMB6/pMQ6cGRuCsKahqtP+fbfKW0QoSgQklboFw==
X-Received: by 2002:a17:907:d06:b0:6da:2902:e9ad with SMTP id gn6-20020a1709070d0600b006da2902e9admr8377700ejc.566.1646640535645;
        Mon, 07 Mar 2022 00:08:55 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906961500b006daac87ddb0sm3698300ejx.140.2022.03.07.00.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:08:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] tty: serial: samsung: embed s3c24xx_uart_info in parent structure
Date:   Mon,  7 Mar 2022 09:08:46 +0100
Message-Id: <20220307080852.53992-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
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

