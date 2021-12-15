Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AED47662C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhLOWsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:48:06 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:41593 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhLOWsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:48:03 -0500
Received: by mail-ot1-f44.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so26749330otl.8;
        Wed, 15 Dec 2021 14:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TfKY8WqNO2jATuIKQkmRGEjfz+Hm6FzWMXwCS8KIkx0=;
        b=nk2TZCV+bRF7Gf12tXCdaGXnhvX9QKOwsHzCJiLwzy1tvNNbLeTTXQ8/HIAnqj6xPR
         Rv3QTjH3XQyI+nusUreqVy1V2155Ya1v9lXnVZyTo9SzyrgSUKm3HtoULlyTrUrVZayo
         uv1wX5Ah4Ggg+/PepYoDfFONTfGNqtLTEXFpowIzuUaCFiq7/2yx1AaiF4mAtW5Co/B+
         x8zqXlECFCaHz2KmQ1eTWBAdXNuyI/FBRwCKiAIzfHwMjFGX7ygUE7qun96jmBmmeDH8
         KHtB7rNfbJJofsq5t0OKyLJ+bVGroeAeIWGlE7Gt1Z0lMab0gvaM1XcXWJX0RMGt7DRX
         qKZQ==
X-Gm-Message-State: AOAM532kZB6tZc4rt9roikb+xFD9lLCCitLxufReUcv1t1nBQJbT01eE
        R8v57WZ7bFYDCKuf2ZU5VBSZD1wg8w==
X-Google-Smtp-Source: ABdhPJxF+RkJXOq/t3sNTtkLcJm1RdLW3GpcjOal3CQZ7jJyt8zFAtiYzp7AKintfwdLEx19FL8MqA==
X-Received: by 2002:a9d:77ce:: with SMTP id w14mr10628974otl.252.1639608482182;
        Wed, 15 Dec 2021 14:48:02 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id l24sm684559oou.20.2021.12.15.14.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:48:01 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: lantiq: Use platform_get_irq() to get the interrupt
Date:   Wed, 15 Dec 2021 16:48:00 -0600
Message-Id: <20211215224800.1984391-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the preferred platform_get_irq() call to retrieve the interrupts. These
have the advantage of working with deferred probe and gets us one step
closer to removing of_irq_to_resource_table().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/lantiq.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 497b334bc845..bb059418cb82 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -16,8 +16,6 @@
 #include <linux/ioport.h>
 #include <linux/lantiq.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
@@ -728,19 +726,19 @@ static struct uart_driver lqasc_reg = {
 static int fetch_irq_lantiq(struct device *dev, struct ltq_uart_port *ltq_port)
 {
 	struct uart_port *port = &ltq_port->port;
-	struct resource irqres[3];
-	int ret;
+	struct platform_device *pdev = to_platform_device(dev);
 
-	ret = of_irq_to_resource_table(dev->of_node, irqres, 3);
-	if (ret != 3) {
-		dev_err(dev,
-			"failed to get IRQs for serial port\n");
-		return -ENODEV;
-	}
-	ltq_port->tx_irq = irqres[0].start;
-	ltq_port->rx_irq = irqres[1].start;
-	ltq_port->err_irq = irqres[2].start;
-	port->irq = irqres[0].start;
+	ltq_port->tx_irq = platform_get_irq(pdev, 0);
+	if (ltq_port->tx_irq < 0)
+		return ltq_port->tx_irq;
+	ltq_port->rx_irq = platform_get_irq(pdev, 1);
+	if (ltq_port->rx_irq < 0)
+		return ltq_port->rx_irq;
+	ltq_port->err_irq = platform_get_irq(pdev, 2);
+	if (ltq_port->err_irq < 0)
+		return ltq_port->err_irq;
+
+	port->irq = ltq_port->tx_irq;
 
 	return 0;
 }
@@ -793,7 +791,7 @@ static int fetch_irq_intel(struct device *dev, struct ltq_uart_port *ltq_port)
 	struct uart_port *port = &ltq_port->port;
 	int ret;
 
-	ret = of_irq_get(dev->of_node, 0);
+	ret = platform_get_irq(to_platform_device(dev), 0);
 	if (ret < 0) {
 		dev_err(dev, "failed to fetch IRQ for serial port\n");
 		return ret;
-- 
2.32.0

