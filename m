Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA964A6438
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241960AbiBASu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:50:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229915AbiBASu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643741455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CXMEPCO/uu0dla1c1qYh6jAoya9d0BWMm4xi0Tv2h6E=;
        b=K6DtNxVTWRUq3slM6JRAzQcR0TTol5eER6IvAp3JfcuCwFWn2AL6nelF+xAtOSz43A86Il
        vrF3F5QXK6LEGTPjBwUWsR1heL6E8YlPw9PWg6VP9kdp58DINdXF8rbnJJniSH0eaRkQEI
        Z9kHT3jyqgKpoBD4xZdXXTCENkH7Uis=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-u83wDGirPWCbKuSqOIw8XQ-1; Tue, 01 Feb 2022 13:50:54 -0500
X-MC-Unique: u83wDGirPWCbKuSqOIw8XQ-1
Received: by mail-qv1-f72.google.com with SMTP id r12-20020a0562140c8c00b004226c4fc035so16771809qvr.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CXMEPCO/uu0dla1c1qYh6jAoya9d0BWMm4xi0Tv2h6E=;
        b=ixXX8R4TrkLyN8oXGNeb1SJTQNzLxrhWqpYc7seEPqVHBmjlJk7TKy2thY9AcQ8rUy
         Ltz8iKRjcC6do7kY9S4C231eWkjsM7eH6gR71mcAVyt0IEmUYPTdZsvkt5YN2I4Nu7EI
         3NXx39Wb+rk6GjUQMEDT4Bji0+PVSeRjJUSFw1ViuMmDQRdsE7q+7DKJGUjaUSH840En
         aMnBcNxyADNMliY82+HdhycsiZS3c/dIvGiG7y3j8HjUbFuhmuMLGXQgD7KElf1QSqfn
         r+/B1Wdw49EXGiHona5gZ+43i+Kr9yTTpf18ZojkaVhx6p+VK4Qv5m+OOUNViQBAOQd1
         asOw==
X-Gm-Message-State: AOAM532V3miRUT0B2XSfRqaSOtPqSyrkLj5gSQ/6IK+mxBGVTjSmt04u
        PB5SxzhSwLkx+N6ndVwZqXVpj5k3pfFIrlv0ohE/CULe1SfBALGPqJLttmLLIJZ06cAVj1iq8BD
        CJmhDmLfCKF0BQ+NyMNUYoARk
X-Received: by 2002:a05:620a:2802:: with SMTP id f2mr16767625qkp.507.1643741453755;
        Tue, 01 Feb 2022 10:50:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeYTqpwtK/INgbSNiwXFDLjZ29hCQC22MnWYuwPikv73Imxyj7d0mLQowMRGUhnvmg77nScw==
X-Received: by 2002:a05:620a:2802:: with SMTP id f2mr16767612qkp.507.1643741453530;
        Tue, 01 Feb 2022 10:50:53 -0800 (PST)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id w22sm6225383qtk.7.2022.02.01.10.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:50:53 -0800 (PST)
From:   Adrien Thierry <athierry@redhat.com>
To:     linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Adrien Thierry <athierry@redhat.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH] serial: 8250_bcm2835aux: Add ACPI support
Date:   Tue,  1 Feb 2022 13:50:01 -0500
Message-Id: <20220201185001.926338-1-athierry@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI support to 8250_bcm2835aux driver. This makes it possible to
use the miniuart on the Raspberry Pi with the tianocore/edk2 UEFI
firmware.

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 103 +++++++++++++++++-----
 1 file changed, 83 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index fd95860cd..b904b321e 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -12,6 +12,7 @@
  * simultaneously to rs485.
  */
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -44,6 +45,10 @@ struct bcm2835aux_data {
 	u32 cntl;
 };
 
+struct bcm2835_aux_serial_acpi_driver_data {
+	resource_size_t offset;
+};
+
 static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
 {
 	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
@@ -82,8 +87,12 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port up = { };
 	struct bcm2835aux_data *data;
+	struct bcm2835_aux_serial_acpi_driver_data *acpi_data;
 	struct resource *res;
 	int ret;
+	resource_size_t mapbase;
+	resource_size_t mapsize;
+	unsigned int uartclk;
 
 	/* allocate the custom structure */
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -108,10 +117,12 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	/* get the clock - this also enables the HW */
-	data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(data->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");
+	if (dev_of_node(&pdev->dev)) {
+		/* get the clock - this also enables the HW */
+		data->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(data->clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");
+	}
 
 	/* get the interrupt */
 	ret = platform_get_irq(pdev, 0);
@@ -125,20 +136,59 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "memory resource not found");
 		return -EINVAL;
 	}
-	up.port.mapbase = res->start;
-	up.port.mapsize = resource_size(res);
-
-	/* Check for a fixed line number */
-	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (ret >= 0)
-		up.port.line = ret;
-
-	/* enable the clock as a last step */
-	ret = clk_prepare_enable(data->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to enable uart clock - %d\n",
-			ret);
-		return ret;
+
+	mapbase = res->start;
+	mapsize = resource_size(res);
+
+	if (has_acpi_companion(&pdev->dev)) {
+		const struct acpi_device_id *match;
+
+		match = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
+		if (!match)
+			return -ENODEV;
+
+		acpi_data = (struct bcm2835_aux_serial_acpi_driver_data *)match->driver_data;
+
+		/* Some UEFI implementations (e.g. tianocore/edk2 for the Raspberry Pi)
+		 * describe the miniuart with a base address that encompasses the auxiliary
+		 * registers shared between the miniuart and spi.
+		 *
+		 * This is due to historical reasons, see discussion here :
+		 * https://edk2.groups.io/g/devel/topic/87501357#84349
+		 *
+		 * We need to add the offset between the miniuart and auxiliary
+		 * registers to get the real miniuart base address.
+		 */
+		up.port.mapbase = mapbase + acpi_data->offset;
+		up.port.mapsize = mapsize - acpi_data->offset;
+	} else {
+		up.port.mapbase = mapbase;
+		up.port.mapsize = mapsize;
+	}
+
+	if (dev_of_node(&pdev->dev)) {
+		/* Check for a fixed line number */
+		ret = of_alias_get_id(pdev->dev.of_node, "serial");
+		if (ret >= 0)
+			up.port.line = ret;
+
+		/* enable the clock as a last step */
+		ret = clk_prepare_enable(data->clk);
+		if (ret) {
+			dev_err(&pdev->dev, "unable to enable uart clock - %d\n",
+				ret);
+			return ret;
+		}
+
+		uartclk = clk_get_rate(data->clk);
+
+
+	} else {
+		ret = device_property_read_u32(&pdev->dev, "clock-frequency", &uartclk);
+		if (ret) {
+			dev_err(&pdev->dev, "unable to get clock frequency\n");
+			return ret;
+		}
 	}
 
 	/* the HW-clock divider for bcm2835aux is 8,
@@ -146,7 +196,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	 * so we have to multiply the actual clock by 2
 	 * to get identical baudrates.
 	 */
-	up.port.uartclk = clk_get_rate(data->clk) * 2;
+	up.port.uartclk = uartclk * 2;
 
 	/* register the port */
 	ret = serial8250_register_8250_port(&up);
@@ -159,7 +209,9 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	return 0;
 
 dis_clk:
-	clk_disable_unprepare(data->clk);
+	if (dev_of_node(&pdev->dev))
+		clk_disable_unprepare(data->clk);
+
 	return ret;
 }
 
@@ -173,16 +225,27 @@ static int bcm2835aux_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct bcm2835_aux_serial_acpi_driver_data bcm2835_acpi_data = {
+	.offset = 0x40
+};
+
 static const struct of_device_id bcm2835aux_serial_match[] = {
 	{ .compatible = "brcm,bcm2835-aux-uart" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm2835aux_serial_match);
 
+static const struct acpi_device_id bcm2835aux_serial_acpi_match[] = {
+	{ "BCM2836", (kernel_ulong_t)&bcm2835_acpi_data },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_match);
+
 static struct platform_driver bcm2835aux_serial_driver = {
 	.driver = {
 		.name = "bcm2835-aux-uart",
 		.of_match_table = bcm2835aux_serial_match,
+		.acpi_match_table = bcm2835aux_serial_acpi_match,
 	},
 	.probe  = bcm2835aux_serial_probe,
 	.remove = bcm2835aux_serial_remove,

base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
2.34.1

