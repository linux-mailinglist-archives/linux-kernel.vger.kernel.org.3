Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9170753EB19
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiFFKFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiFFKF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E916BFEC;
        Mon,  6 Jun 2022 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509924; x=1686045924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Rq6Epv0uyMLUulCniZ8IRYQ84/AGOV0y8cwA8BYZnA=;
  b=XSQV2DzPZgByIuqUb84Duc4RFb8xbcXPXdO28sHSmGDmWWR/u9ETrObT
   F2yEXEdpIfV4f16XxrFdjN/EuoqRl/1P2Hb+ncCNPALGpAvoFJa9+vA4A
   R67uXQiWEOrYJbsXDh7nGYP5yKh9Tzhkcfk4mVAwrX3day/WDGGIxbKnq
   rA0FMHBlGwkLNLJE5AGAAjAEnafLonxxZA/1DslbXRJa9NBg7DMF2i+pY
   EopQf9TjRjB6A3VFsJmJwsHVE0suXFbUYlgXkElBCtl60/JFLai+fEwKL
   WjLC34BnKmF0ijdcm3DWC8M/SjUraH1Rz2Jyj59UbO5318cF2b7JDAeP5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987031"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987031"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:04:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523402"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:04:52 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 01/36] serial: Add uart_rs485_config()
Date:   Mon,  6 Jun 2022 13:03:58 +0300
Message-Id: <20220606100433.13793-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
References: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few serial drivers make a call to rs485_config() themselves (all
these seem to relate to init). Convert them all to use a common helper
which makes it easy to make adjustments on tasks related to it as
serial_rs485 struct sanitization is going to be added.

In pci_fintek_setup() (in 8250_pci.c), the rs485_config() call was made
with NULL, however, it can be changed to pass uart_port's rs485 struct.
No other callers should pass NULL into rs485_config() so the NULL check
can now be eliminated.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c  | 6 ++----
 drivers/tty/serial/8250/8250_port.c | 2 +-
 drivers/tty/serial/fsl_lpuart.c     | 2 +-
 drivers/tty/serial/imx.c            | 2 +-
 drivers/tty/serial/serial_core.c    | 6 ++++++
 include/linux/serial_core.h         | 1 +
 6 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index a17619db7939..fb0a49e39072 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1562,9 +1562,7 @@ static int pci_fintek_rs485_config(struct uart_port *port,
 
 	pci_read_config_byte(pci_dev, 0x40 + 8 * *index + 7, &setting);
 
-	if (!rs485)
-		rs485 = &port->rs485;
-	else if (rs485->flags & SER_RS485_ENABLED)
+	if (rs485->flags & SER_RS485_ENABLED)
 		memset(rs485->padding, 0, sizeof(rs485->padding));
 	else
 		memset(rs485, 0, sizeof(*rs485));
@@ -1689,7 +1687,7 @@ static int pci_fintek_init(struct pci_dev *dev)
 			 * pciserial_resume_ports()
 			 */
 			port = serial8250_get_port(priv->line[i]);
-			pci_fintek_rs485_config(&port->port, NULL);
+			uart_rs485_config(&port->port);
 		} else {
 			/* First init without port data
 			 * force init to RS232 Mode
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 78b6dedc43e6..d7384ab364d2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3199,7 +3199,7 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 		autoconfig(up);
 
 	if (port->rs485.flags & SER_RS485_ENABLED)
-		port->rs485_config(port, &port->rs485);
+		uart_rs485_config(port);
 
 	/* if access method is AU, it is a 16550 with a quirk */
 	if (port->type == PORT_16550A && port->iotype == UPIO_AU)
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 0d6e62f6bb07..509a7912fa9d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2724,7 +2724,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	    sport->port.rs485.delay_rts_after_send)
 		dev_err(&pdev->dev, "driver doesn't support RTS delays\n");
 
-	sport->port.rs485_config(&sport->port, &sport->port.rs485);
+	uart_rs485_config(&sport->port);
 
 	ret = devm_request_irq(&pdev->dev, sport->port.irq, handler, 0,
 				DRIVER_NAME, sport);
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7d2094dc5a59..9ce09b81ac9b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2338,7 +2338,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"low-active RTS not possible when receiver is off, enabling receiver\n");
 
-	imx_uart_rs485_config(&sport->port, &sport->port.rs485);
+	uart_rs485_config(&sport->port);
 
 	/* Disable interrupts before requesting them */
 	ucr1 = imx_uart_readl(sport, UCR1);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9a85b41caa0a..8466181db4e9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1276,6 +1276,12 @@ static int uart_get_icount(struct tty_struct *tty,
 	return 0;
 }
 
+int uart_rs485_config(struct uart_port *port)
+{
+	return port->rs485_config(port, &port->rs485);
+}
+EXPORT_SYMBOL_GPL(uart_rs485_config);
+
 static int uart_get_rs485_config(struct uart_port *port,
 			 struct serial_rs485 __user *rs485)
 {
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index cbd5070bc87f..d3ebb4db2d80 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -592,4 +592,5 @@ static inline int uart_handle_break(struct uart_port *port)
 					 !((cflag) & CLOCAL))
 
 int uart_get_rs485_mode(struct uart_port *port);
+int uart_rs485_config(struct uart_port *port);
 #endif /* LINUX_SERIAL_CORE_H */
-- 
2.30.2

