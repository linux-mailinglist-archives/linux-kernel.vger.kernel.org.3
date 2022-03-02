Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D104CA17B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbiCBJ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240797AbiCBJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:58:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42071BDE4D;
        Wed,  2 Mar 2022 01:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646215046; x=1677751046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TdTwchJPNHkxf+9FPgkIGkROH/nCVAeMcrI7kyCJGrw=;
  b=BUCcIhCqDuoiclVu9EoTcn9rgjoKas97andM2PGusHDTsOuDgnWlwcLk
   t1F9JEnkmIhc7vigVhsTmdRnHuHo4tr2hactpoxjHhtXYxGR5wlkEmFLn
   yz2Qq4wIBZr/fOGg3y0dk93wtkLIi8TZGflUNjA3eG83X47Bmq/iZPW1X
   DkZGwgeptdC5XGcaTG4SE+mD99YgcHg4H2EIFnKcVnxMFf6VxUIeUidx2
   YPv88h9t454GvyH1vyLwlxHxO5cwFBmT7RD9SBthfWw5Ot8TjRWEov0Dw
   V7idkIAhrp39FMHw1Kr9yeR78lqh6ooSY/aO6UmSm7mrzbx8g2zowRMp8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233980161"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="233980161"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:57:06 -0800
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="551182087"
Received: from abotoi-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.218.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:57:03 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [RFC PATCH 3/7] serial: 8250_dwlib: Implement SW half duplex support
Date:   Wed,  2 Mar 2022 11:56:02 +0200
Message-Id: <20220302095606.14818-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables support for SW half-duplex mode. Synopsys
DesignWare UART has a build-in support for the RS485 protocol
from IP version 4.0 onward with dedicated RE/DE_EN registers.
This patch enables RS485 either using dedicated registers or
em485 as fallback.

In order to select preference for SW half-duplex mode (em485 +
RE/DE_EN) over HW managed one, as both are supported under
some configurations, SER_RS485_SW_RX_OR_TX flag is added to
serial_rs485.

This patch depends on UART_CAP_NOTEMT which is not provided
by this series but another one:
  https://lore.kernel.org/all/20210204161158.643-1-etremblay@distech-controls.com/

Cc: Eric Tremblay <etremblay@distech-controls.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 60 +++++++++++++++++++++++++---
 include/uapi/linux/serial.h          |  2 +
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index d26792999984..51b0f55ee9d0 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -101,8 +101,26 @@ void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct
 }
 EXPORT_SYMBOL_GPL(dw8250_do_set_termios);
 
+static void dw8250_rs485_start_tx(struct uart_8250_port *up)
+{
+	struct uart_port *p = &(up->port);
+
+	dw8250_writel_ext(p, DW_UART_RE_EN, 0);
+	dw8250_writel_ext(p, DW_UART_DE_EN, 1);
+}
+
+static void dw8250_rs485_stop_tx(struct uart_8250_port *up)
+{
+	struct uart_port *p = &(up->port);
+
+	dw8250_writel_ext(p, DW_UART_DE_EN, 0);
+	dw8250_writel_ext(p, DW_UART_RE_EN, 1);
+}
+
 static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
 {
+	struct uart_8250_port *up = up_to_u8250p(p);
+	u32 re_en, de_en;
 	u32 tcr;
 
 	tcr = dw8250_readl_ext(p, DW_UART_TCR);
@@ -110,16 +128,29 @@ static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
 
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Clearing unsupported flags. */
-		rs485->flags &= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX;
+		rs485->flags &= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS485_SW_RX_OR_TX;
 		tcr |= DW_UART_TCR_RS485_EN;
 
 		if (rs485->flags & SER_RS485_RX_DURING_TX) {
 			tcr |= DW_UART_TCR_XFER_MODE_DE_DURING_RE;
+			re_en = 1;
+			de_en = 1;
+			rs485->flags &= ~SER_RS485_SW_RX_OR_TX;
+		} else if (rs485->flags & SER_RS485_SW_RX_OR_TX) {
+			tcr |= DW_UART_TCR_XFER_MODE_SW_DE_OR_RE;
+			re_en = 1;
+			de_en = 0;
+			if (up->em485 && !up->em485->tx_stopped) {
+				re_en = 0;
+				de_en = 1;
+			}
 		} else {
 			tcr |= DW_UART_TCR_XFER_MODE_DE_OR_RE;
+			re_en = 1;
+			de_en = 1;
 		}
-		dw8250_writel_ext(p, DW_UART_DE_EN, 1);
-		dw8250_writel_ext(p, DW_UART_RE_EN, 1);
+		dw8250_writel_ext(p, DW_UART_DE_EN, de_en);
+		dw8250_writel_ext(p, DW_UART_RE_EN, re_en);
 	} else {
 		rs485->flags = 0;
 
@@ -147,7 +178,16 @@ static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
 	rs485->delay_rts_before_send = 0;
 	rs485->delay_rts_after_send = 0;
 
-	p->rs485 = *rs485;
+	if (rs485->flags & SER_RS485_SW_RX_OR_TX) {
+		int ret;
+
+		ret = serial8250_em485_config(p, rs485);
+		if (ret)
+			return ret;
+	} else {
+		serial8250_em485_destroy(up_to_u8250p(p));
+		p->rs485 = *rs485;
+	}
 
 	return 0;
 }
@@ -159,8 +199,16 @@ void dw8250_setup_port(struct uart_port *p)
 	u32 reg;
 
 	d->hw_rs485_support = device_property_read_bool(p->dev, "snps,rs485-interface-en");
-	if (d->hw_rs485_support)
+	if (d->hw_rs485_support) {
 		p->rs485_config = dw8250_rs485_config;
+		up->rs485_start_tx = dw8250_rs485_start_tx;
+		up->rs485_stop_tx = dw8250_rs485_stop_tx;
+	} else {
+		p->rs485_config = serial8250_em485_config;
+		up->rs485_start_tx = serial8250_em485_start_tx;
+		up->rs485_stop_tx = serial8250_em485_stop_tx;
+	}
+	up->capabilities |= UART_CAP_NOTEMT;
 
 	/*
 	 * If the Component Version Register returns zero, we know that
@@ -192,7 +240,7 @@ void dw8250_setup_port(struct uart_port *p)
 		p->type = PORT_16550A;
 		p->flags |= UPF_FIXED_TYPE;
 		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
-		up->capabilities = UART_CAP_FIFO;
+		up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT;
 	}
 
 	if (reg & DW_UART_CPR_AFCE_MODE)
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index fa6b16e5fdd8..f868685b35a0 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -126,6 +126,8 @@ struct serial_rs485 {
 #define SER_RS485_TERMINATE_BUS		(1 << 5)	/* Enable bus
 							   termination
 							   (if supported) */
+#define SER_RS485_SW_RX_OR_TX		(1 << 6)	/* Prefer SW half-duplex
+							   mode over HW one */
 	__u32	delay_rts_before_send;	/* Delay before send (milliseconds) */
 	__u32	delay_rts_after_send;	/* Delay after send (milliseconds) */
 	__u32	padding[5];		/* Memory is cheap, new structs
-- 
2.30.2

