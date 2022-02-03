Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7964A9004
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbiBCVeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:34:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233983AbiBCVes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643924088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DwivsJAmIQcWiItzGQJe6rk1i+woIsVL4qVwp7qviSk=;
        b=VQB0OQsdL0tfjJkiaWZbBkyBCVCVKk50sHBx7cbJQoisp4KO3cw1fgGVMEQfteCaIu8tL4
        T5Pp0FOa/jh/f2C1nophd0cA4vzBudeI+RYdTjJSKh7wXbkiPgHenoCOECYOxkw2O4R3M/
        Fc35+fgArNFN1MCmoezS0c6TvMPwvgw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-pIAGX21yOgCWzIxJBFJ4Cw-1; Thu, 03 Feb 2022 16:34:47 -0500
X-MC-Unique: pIAGX21yOgCWzIxJBFJ4Cw-1
Received: by mail-qt1-f197.google.com with SMTP id 22-20020ac85656000000b002d2426b6fc1so3161943qtt.15
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DwivsJAmIQcWiItzGQJe6rk1i+woIsVL4qVwp7qviSk=;
        b=UgkkySBgloVa0VJowEGanMmB5st85mUtLn7T3bnaPTSOBDK6K4tKOxABNz7MsOiAbO
         UnZSzpCiX6PKsYg5+kb54kDWwRLA0vaN1GMFysh9IkYRDDl621/Nd/seZ+3PJz0N22+R
         xHgWQiSnj4n7DBlEtSfOvMnFQhbT15DpE4HqyBOuj3X2Ul0LOV6J5DjiRqc/SxqMHNpy
         kZc25b7GL/4wJXGz6oru5obogPkw48YXJEbMAQZh+63AxuwBy+C29of49I4e+C+viiDJ
         5sdjzeJMVYAN68UdOSrFs7OY5DF8yrvO9h7BFs2u0TVLffaK2TtMJy1IcooV4ASETF++
         v0Bg==
X-Gm-Message-State: AOAM533JgLUrbqdCHBC2exJ3TNA0u+N41Kj5mRYdPReYga28RaZc3xql
        ZX8AUcNdsKp2xKoD2gz+2uw0xzLWv18kUWxwoEzSrciMT68/wMrcrdyLhwIkhPjhqhCe3dUj8Xh
        0LBqnTSdLD/SYAc12Y6zcTLx9
X-Received: by 2002:a05:6214:301d:: with SMTP id ke29mr9812093qvb.48.1643924086376;
        Thu, 03 Feb 2022 13:34:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxHEopnL2jgYONCTx5yEZ9/0nOSx7Yo+Xfa7QOUzky3xkTECLhJwIE22fAEbumYz1d6eS1EA==
X-Received: by 2002:a05:6214:301d:: with SMTP id ke29mr9812084qvb.48.1643924086119;
        Thu, 03 Feb 2022 13:34:46 -0800 (PST)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id h9sm9645qkn.121.2022.02.03.13.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:34:45 -0800 (PST)
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
Subject: [PATCH v2] serial: 8250_bcm2835aux: Add ACPI support
Date:   Thu,  3 Feb 2022 16:34:08 -0500
Message-Id: <20220203213408.441407-1-athierry@redhat.com>
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
V1 -> V2: Refactored code to remove unnecessary conditional paths and
intermediate variables

 drivers/tty/serial/8250/8250_bcm2835aux.c | 87 ++++++++++++++++++-----
 1 file changed, 69 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index fd95860cd661..b7cec2a3b5f7 100644
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
@@ -82,8 +87,11 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port up = { };
 	struct bcm2835aux_data *data;
+	struct bcm2835_aux_serial_acpi_driver_data *acpi_data;
 	struct resource *res;
 	int ret;
+	resource_size_t offset = 0;
+	unsigned int uartclk;
 
 	/* allocate the custom structure */
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -110,8 +118,11 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 
 	/* get the clock - this also enables the HW */
 	data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(data->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");
+	if (IS_ERR(data->clk)) {
+		ret = device_property_read_u32(&pdev->dev, "clock-frequency", &uartclk);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "could not get clk\n");
+	}
 
 	/* get the interrupt */
 	ret = platform_get_irq(pdev, 0);
@@ -125,20 +136,47 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
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
+		offset = acpi_data->offset;
+	}
+
+	up.port.mapbase = res->start + offset;
+	up.port.mapsize = resource_size(res) - offset;
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
 	}
 
 	/* the HW-clock divider for bcm2835aux is 8,
@@ -146,7 +184,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	 * so we have to multiply the actual clock by 2
 	 * to get identical baudrates.
 	 */
-	up.port.uartclk = clk_get_rate(data->clk) * 2;
+	up.port.uartclk = uartclk * 2;
 
 	/* register the port */
 	ret = serial8250_register_8250_port(&up);
@@ -159,7 +197,9 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	return 0;
 
 dis_clk:
-	clk_disable_unprepare(data->clk);
+	if (dev_of_node(&pdev->dev))
+		clk_disable_unprepare(data->clk);
+
 	return ret;
 }
 
@@ -173,16 +213,27 @@ static int bcm2835aux_serial_remove(struct platform_device *pdev)
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

base-commit: 1f2cfdd349b7647f438c1e552dc1b983da86d830
-- 
2.34.1

