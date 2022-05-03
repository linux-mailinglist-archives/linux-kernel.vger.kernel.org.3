Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBACE517D76
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiECGgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiECGfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:35:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C82381AE;
        Mon,  2 May 2022 23:31:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B99B6210ED;
        Tue,  3 May 2022 06:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651559486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UKMK+E1QOVMkS/+uRvdxjLGkgBWRpnWs4hXt5Uwgx3c=;
        b=Z2fTcPW4dTYMvC1fzMXVCph/bxUKQU+bHPtiMlrUyCvsn3znUe/1yWkhV9TeQJxs746FP6
        SX1F1PyahdGc1J6sLz4QMvaOki9WFjkveBICRZhesvngWyLgv1JcNe88H7yvDKvTdwN3rG
        szvJQpDRgfk+noeF2h3CNVmfFxoaa0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651559486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UKMK+E1QOVMkS/+uRvdxjLGkgBWRpnWs4hXt5Uwgx3c=;
        b=BV7G0c5/c6RE5e7w1NTcDWdG8/B9vRfEd1ILebOMr/8omMIjAArVfJmQOJ70qkoln/azf4
        kGtHo5a2ApJ/WDCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7EA2F2C141;
        Tue,  3 May 2022 06:31:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/11] serial: pic32: move header content to .c
Date:   Tue,  3 May 2022 08:31:13 +0200
Message-Id: <20220503063122.20957-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503063122.20957-1-jslaby@suse.cz>
References: <20220503063122.20957-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point keeping the header content separated. So move the
content to the appropriate source file.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pic32_uart.c | 104 +++++++++++++++++++++++++++-
 drivers/tty/serial/pic32_uart.h | 116 --------------------------------
 2 files changed, 103 insertions(+), 117 deletions(-)
 delete mode 100644 drivers/tty/serial/pic32_uart.h

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index b7a3a1b959b1..a1b8c05f3d46 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -25,13 +25,115 @@
 #include <linux/delay.h>
 
 #include <asm/mach-pic32/pic32.h>
-#include "pic32_uart.h"
 
 /* UART name and device definitions */
 #define PIC32_DEV_NAME		"pic32-uart"
 #define PIC32_MAX_UARTS		6
 #define PIC32_SDEV_NAME		"ttyPIC"
 
+#define PIC32_UART_DFLT_BRATE		9600
+#define PIC32_UART_TX_FIFO_DEPTH	8
+#define PIC32_UART_RX_FIFO_DEPTH	8
+
+#define PIC32_UART_MODE		0x00
+#define PIC32_UART_STA		0x10
+#define PIC32_UART_TX		0x20
+#define PIC32_UART_RX		0x30
+#define PIC32_UART_BRG		0x40
+
+/* struct pic32_sport - pic32 serial port descriptor
+ * @port: uart port descriptor
+ * @idx: port index
+ * @irq_fault: virtual fault interrupt number
+ * @irqflags_fault: flags related to fault irq
+ * @irq_fault_name: irq fault name
+ * @irq_rx: virtual rx interrupt number
+ * @irqflags_rx: flags related to rx irq
+ * @irq_rx_name: irq rx name
+ * @irq_tx: virtual tx interrupt number
+ * @irqflags_tx: : flags related to tx irq
+ * @irq_tx_name: irq tx name
+ * @cts_gpio: clear to send gpio
+ * @dev: device descriptor
+ **/
+struct pic32_sport {
+	struct uart_port port;
+	int idx;
+
+	int irq_fault;
+	int irqflags_fault;
+	const char *irq_fault_name;
+	int irq_rx;
+	int irqflags_rx;
+	const char *irq_rx_name;
+	int irq_tx;
+	int irqflags_tx;
+	const char *irq_tx_name;
+	u8 enable_tx_irq;
+
+	bool hw_flow_ctrl;
+	int cts_gpio;
+
+	int ref_clk;
+	struct clk *clk;
+
+	struct device *dev;
+};
+#define to_pic32_sport(c) container_of(c, struct pic32_sport, port)
+#define pic32_get_port(sport) (&sport->port)
+#define tx_irq_enabled(sport) (sport->enable_tx_irq)
+
+static inline void pic32_uart_writel(struct pic32_sport *sport,
+					u32 reg, u32 val)
+{
+	struct uart_port *port = pic32_get_port(sport);
+
+	__raw_writel(val, port->membase + reg);
+}
+
+static inline u32 pic32_uart_readl(struct pic32_sport *sport, u32 reg)
+{
+	struct uart_port *port = pic32_get_port(sport);
+
+	return	__raw_readl(port->membase + reg);
+}
+
+/* pic32 uart mode register bits */
+#define PIC32_UART_MODE_ON        BIT(15)
+#define PIC32_UART_MODE_FRZ       BIT(14)
+#define PIC32_UART_MODE_SIDL      BIT(13)
+#define PIC32_UART_MODE_IREN      BIT(12)
+#define PIC32_UART_MODE_RTSMD     BIT(11)
+#define PIC32_UART_MODE_RESV1     BIT(10)
+#define PIC32_UART_MODE_UEN1      BIT(9)
+#define PIC32_UART_MODE_UEN0      BIT(8)
+#define PIC32_UART_MODE_WAKE      BIT(7)
+#define PIC32_UART_MODE_LPBK      BIT(6)
+#define PIC32_UART_MODE_ABAUD     BIT(5)
+#define PIC32_UART_MODE_RXINV     BIT(4)
+#define PIC32_UART_MODE_BRGH      BIT(3)
+#define PIC32_UART_MODE_PDSEL1    BIT(2)
+#define PIC32_UART_MODE_PDSEL0    BIT(1)
+#define PIC32_UART_MODE_STSEL     BIT(0)
+
+/* pic32 uart status register bits */
+#define PIC32_UART_STA_UTXISEL1   BIT(15)
+#define PIC32_UART_STA_UTXISEL0   BIT(14)
+#define PIC32_UART_STA_UTXINV     BIT(13)
+#define PIC32_UART_STA_URXEN      BIT(12)
+#define PIC32_UART_STA_UTXBRK     BIT(11)
+#define PIC32_UART_STA_UTXEN      BIT(10)
+#define PIC32_UART_STA_UTXBF      BIT(9)
+#define PIC32_UART_STA_TRMT       BIT(8)
+#define PIC32_UART_STA_URXISEL1   BIT(7)
+#define PIC32_UART_STA_URXISEL0   BIT(6)
+#define PIC32_UART_STA_ADDEN      BIT(5)
+#define PIC32_UART_STA_RIDLE      BIT(4)
+#define PIC32_UART_STA_PERR       BIT(3)
+#define PIC32_UART_STA_FERR       BIT(2)
+#define PIC32_UART_STA_OERR       BIT(1)
+#define PIC32_UART_STA_URXDA      BIT(0)
+
 /* pic32_sport pointer for console use */
 static struct pic32_sport *pic32_sports[PIC32_MAX_UARTS];
 
diff --git a/drivers/tty/serial/pic32_uart.h b/drivers/tty/serial/pic32_uart.h
deleted file mode 100644
index a7dba1d57236..000000000000
--- a/drivers/tty/serial/pic32_uart.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * PIC32 Integrated Serial Driver.
- *
- * Copyright (C) 2015 Microchip Technology, Inc.
- *
- * Authors:
- *   Sorin-Andrei Pistirica <andrei.pistirica@microchip.com>
- */
-#ifndef __DT_PIC32_UART_H__
-#define __DT_PIC32_UART_H__
-
-#define PIC32_UART_DFLT_BRATE		(9600)
-#define PIC32_UART_TX_FIFO_DEPTH	(8)
-#define PIC32_UART_RX_FIFO_DEPTH	(8)
-
-#define PIC32_UART_MODE		0x00
-#define PIC32_UART_STA		0x10
-#define PIC32_UART_TX		0x20
-#define PIC32_UART_RX		0x30
-#define PIC32_UART_BRG		0x40
-
-/* struct pic32_sport - pic32 serial port descriptor
- * @port: uart port descriptor
- * @idx: port index
- * @irq_fault: virtual fault interrupt number
- * @irqflags_fault: flags related to fault irq
- * @irq_fault_name: irq fault name
- * @irq_rx: virtual rx interrupt number
- * @irqflags_rx: flags related to rx irq
- * @irq_rx_name: irq rx name
- * @irq_tx: virtual tx interrupt number
- * @irqflags_tx: : flags related to tx irq
- * @irq_tx_name: irq tx name
- * @cts_gpio: clear to send gpio
- * @dev: device descriptor
- **/
-struct pic32_sport {
-	struct uart_port port;
-	int idx;
-
-	int irq_fault;
-	int irqflags_fault;
-	const char *irq_fault_name;
-	int irq_rx;
-	int irqflags_rx;
-	const char *irq_rx_name;
-	int irq_tx;
-	int irqflags_tx;
-	const char *irq_tx_name;
-	u8 enable_tx_irq;
-
-	bool hw_flow_ctrl;
-	int cts_gpio;
-
-	int ref_clk;
-	struct clk *clk;
-
-	struct device *dev;
-};
-#define to_pic32_sport(c) container_of(c, struct pic32_sport, port)
-#define pic32_get_port(sport) (&sport->port)
-#define tx_irq_enabled(sport) (sport->enable_tx_irq)
-
-static inline void pic32_uart_writel(struct pic32_sport *sport,
-					u32 reg, u32 val)
-{
-	struct uart_port *port = pic32_get_port(sport);
-
-	__raw_writel(val, port->membase + reg);
-}
-
-static inline u32 pic32_uart_readl(struct pic32_sport *sport, u32 reg)
-{
-	struct uart_port *port = pic32_get_port(sport);
-
-	return	__raw_readl(port->membase + reg);
-}
-
-/* pic32 uart mode register bits */
-#define PIC32_UART_MODE_ON        BIT(15)
-#define PIC32_UART_MODE_FRZ       BIT(14)
-#define PIC32_UART_MODE_SIDL      BIT(13)
-#define PIC32_UART_MODE_IREN      BIT(12)
-#define PIC32_UART_MODE_RTSMD     BIT(11)
-#define PIC32_UART_MODE_RESV1     BIT(10)
-#define PIC32_UART_MODE_UEN1      BIT(9)
-#define PIC32_UART_MODE_UEN0      BIT(8)
-#define PIC32_UART_MODE_WAKE      BIT(7)
-#define PIC32_UART_MODE_LPBK      BIT(6)
-#define PIC32_UART_MODE_ABAUD     BIT(5)
-#define PIC32_UART_MODE_RXINV     BIT(4)
-#define PIC32_UART_MODE_BRGH      BIT(3)
-#define PIC32_UART_MODE_PDSEL1    BIT(2)
-#define PIC32_UART_MODE_PDSEL0    BIT(1)
-#define PIC32_UART_MODE_STSEL     BIT(0)
-
-/* pic32 uart status register bits */
-#define PIC32_UART_STA_UTXISEL1   BIT(15)
-#define PIC32_UART_STA_UTXISEL0   BIT(14)
-#define PIC32_UART_STA_UTXINV     BIT(13)
-#define PIC32_UART_STA_URXEN      BIT(12)
-#define PIC32_UART_STA_UTXBRK     BIT(11)
-#define PIC32_UART_STA_UTXEN      BIT(10)
-#define PIC32_UART_STA_UTXBF      BIT(9)
-#define PIC32_UART_STA_TRMT       BIT(8)
-#define PIC32_UART_STA_URXISEL1   BIT(7)
-#define PIC32_UART_STA_URXISEL0   BIT(6)
-#define PIC32_UART_STA_ADDEN      BIT(5)
-#define PIC32_UART_STA_RIDLE      BIT(4)
-#define PIC32_UART_STA_PERR       BIT(3)
-#define PIC32_UART_STA_FERR       BIT(2)
-#define PIC32_UART_STA_OERR       BIT(1)
-#define PIC32_UART_STA_URXDA      BIT(0)
-
-#endif /* __DT_PIC32_UART_H__ */
-- 
2.36.0

