Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084714ACD18
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbiBHBEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbiBGXWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:22:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49F79C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644276118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Iw9wt34aXKvuMxoYZcgwMJfoVHqXFAcM6CtavfIfEfU=;
        b=FtKsJjEEkdrpKxHaHXlWkTpg7Ie/MDEM4hFZqMW9DqTIntJhK2HyOz8M8M3wxwyynurYwR
        Nff+R7rrlFGeUOwT0YU8yIpxGYY6K5LqRv0JG8ThWHsY0TcVs+B4j2ozIfuNStvWIICaoN
        01ctCY5HeRnMVstWOrC8LnXwHPQ5bow=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-9CfCEObdOymLaN9fMMgv0w-1; Mon, 07 Feb 2022 18:21:57 -0500
X-MC-Unique: 9CfCEObdOymLaN9fMMgv0w-1
Received: by mail-qk1-f200.google.com with SMTP id x16-20020a05620a449000b00508582d0db2so5257029qkp.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 15:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iw9wt34aXKvuMxoYZcgwMJfoVHqXFAcM6CtavfIfEfU=;
        b=teOJuvq9QQqRpkWuN7wDxr6mhC/ANpVl2bF0vsrkFkx0irqy2aJY1i0BKfdEzgnDhf
         g31QOUb2MJ6nYWpyFqpyz9i66guw40xeA+CVPAOdOZnOiAaacsXQqtnz0mqnUlD5OoKy
         G/T+HbOYSl1xPX67kmizYPEVOBVzStq8f4ssnOy2HPPzOA8f5nKa74C8MFp59T32+AeY
         /uKz/0hufI56aVDQTP05+91Dx4aCLX/DvT8UuF/GXBxYQ46ME4/uF05Zxy0IyGNrr2Uv
         RcqI9KR2LtHlRFJ8w5gR4fow2DXwb/cwqPpzfFfyFmd+ey8/NhE4YuAlGqPrnQWSYH4F
         3zkg==
X-Gm-Message-State: AOAM532g+OiAsb6NZZOrzSOtrPVww0HLzY1sXm/ZFTFx1DdpylQTaUL9
        avCAk0NEDv7XHj5k8aN4t0yk1Fz0THj4k+MIawyFHvH4cN+R/M7MgM/fkxptPDlr36AVlmoz9sh
        UlElJ5LGj3eqgeckThtorgXkd
X-Received: by 2002:ad4:5ce7:: with SMTP id iv7mr1363045qvb.121.1644276116278;
        Mon, 07 Feb 2022 15:21:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1NtXQcsm5FW3EBilz/ZfT3Cvi3lIDzaSf3isXw3sfYe4piCqut0wV1cRBs/K/pJ1jR71oUg==
X-Received: by 2002:ad4:5ce7:: with SMTP id iv7mr1363030qvb.121.1644276116076;
        Mon, 07 Feb 2022 15:21:56 -0800 (PST)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id y2sm5906567qke.33.2022.02.07.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 15:21:55 -0800 (PST)
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
Subject: [PATCH v3] serial: 8250_bcm2835aux: Add ACPI support
Date:   Mon,  7 Feb 2022 18:21:29 -0500
Message-Id: <20220207232129.402882-1-athierry@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
V2 -> V3: Cleaned up coding style and addressed review comments

 drivers/tty/serial/8250/8250_bcm2835aux.c | 52 ++++++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index fd95860cd661..2a1226a78a0c 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include "8250.h"
 
@@ -44,6 +45,10 @@ struct bcm2835aux_data {
 	u32 cntl;
 };
 
+struct bcm2835_aux_serial_driver_data {
+	resource_size_t offset;
+};
+
 static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
 {
 	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
@@ -80,9 +85,12 @@ static void bcm2835aux_rs485_stop_tx(struct uart_8250_port *up)
 
 static int bcm2835aux_serial_probe(struct platform_device *pdev)
 {
+	const struct bcm2835_aux_serial_driver_data *bcm_data;
 	struct uart_8250_port up = { };
 	struct bcm2835aux_data *data;
+	resource_size_t offset = 0;
 	struct resource *res;
+	unsigned int uartclk;
 	int ret;
 
 	/* allocate the custom structure */
@@ -109,9 +117,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	/* get the clock - this also enables the HW */
-	data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(data->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");
+	data->clk = devm_clk_get_optional(&pdev->dev, NULL);
 
 	/* get the interrupt */
 	ret = platform_get_irq(pdev, 0);
@@ -125,8 +131,24 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "memory resource not found");
 		return -EINVAL;
 	}
-	up.port.mapbase = res->start;
-	up.port.mapsize = resource_size(res);
+
+	bcm_data = device_get_match_data(&pdev->dev);
+
+	/* Some UEFI implementations (e.g. tianocore/edk2 for the Raspberry Pi)
+	 * describe the miniuart with a base address that encompasses the auxiliary
+	 * registers shared between the miniuart and spi.
+	 *
+	 * This is due to historical reasons, see discussion here :
+	 * https://edk2.groups.io/g/devel/topic/87501357#84349
+	 *
+	 * We need to add the offset between the miniuart and auxiliary
+	 * registers to get the real miniuart base address.
+	 */
+	if (bcm_data)
+		offset = bcm_data->offset;
+
+	up.port.mapbase = res->start + offset;
+	up.port.mapsize = resource_size(res) - offset;
 
 	/* Check for a fixed line number */
 	ret = of_alias_get_id(pdev->dev.of_node, "serial");
@@ -141,12 +163,19 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	uartclk = clk_get_rate(data->clk);
+	if (!uartclk) {
+		ret = device_property_read_u32(&pdev->dev, "clock-frequency", &uartclk);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "could not get clk rate\n");
+	}
+
 	/* the HW-clock divider for bcm2835aux is 8,
 	 * but 8250 expects a divider of 16,
 	 * so we have to multiply the actual clock by 2
 	 * to get identical baudrates.
 	 */
-	up.port.uartclk = clk_get_rate(data->clk) * 2;
+	up.port.uartclk = uartclk * 2;
 
 	/* register the port */
 	ret = serial8250_register_8250_port(&up);
@@ -173,16 +202,27 @@ static int bcm2835aux_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct bcm2835_aux_serial_driver_data bcm2835_acpi_data = {
+	.offset = 0x40,
+};
+
 static const struct of_device_id bcm2835aux_serial_match[] = {
 	{ .compatible = "brcm,bcm2835-aux-uart" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm2835aux_serial_match);
 
+static const struct acpi_device_id bcm2835aux_serial_acpi_match[] = {
+	{ "BCM2836", (kernel_ulong_t)&bcm2835_acpi_data },
+	{ }
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

base-commit: 2ade8eef993c37a2a43e51a9b1f6c25509a2acce
-- 
2.34.1

