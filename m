Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261004CA172
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbiCBJ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiCBJ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:57:42 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7200797B96;
        Wed,  2 Mar 2022 01:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646215019; x=1677751019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=44LOYszFrJLEvO3q4+AUjDDBcsIz3GOTQUi+oFDrXX8=;
  b=i8iunL9Dhg9PWEMJoUtGX+SRT1mRe4LxGYnz05HQ97oEc+PsRvi2EneG
   GP9x8pYMdqdaq+sMCNRGMMed+ac6tuVkicAGbadofGfIHkdLj4I7xS+cF
   zYi0cx8T+qWmfsH1s+g7FUsUsQ5SqQehMYMC1sJXQlmJJIpiwmfy5yc61
   DsPBX+7EseMFbd2XNAg66FA8dW8rluNAyNhLi3M9dAx3VYAx1AWWGqXOw
   DU2DelbZVImCdwwJLI4/s2uIUupVNWyerwXiGy04XVm6AvGV2Lgo7GeRT
   yLqiXB33Oc/hYSaqSEGsGuz0ocZCZHTkFUFoJlBgjlDyK83WlmehBYk9c
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233980114"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="233980114"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:56:57 -0800
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="551182055"
Received: from abotoi-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.218.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:56:54 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
Date:   Wed,  2 Mar 2022 11:56:00 +0200
Message-Id: <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com>
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

The Synopsys DesignWare UART has a build-in support for the
RS485 protocol from IP version 4.0 onward. This commit
enables basic hardware-controlled half duplex mode support
for it.

HW will take care of managing DE and RE, the driver just gives
it permission to use either by setting both to 1.

Co-developed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Co-developed-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Raymond Tan <raymond.tan@intel.com>
Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 67 +++++++++++++++++++++++++++-
 drivers/tty/serial/8250/8250_dwlib.h |  3 ++
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 622d3b0d89e7..a4f09a95049b 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -2,19 +2,33 @@
 /* Synopsys DesignWare 8250 library. */
 
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/property.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 
 #include "8250_dwlib.h"
 
 /* Offsets for the DesignWare specific registers */
+#define DW_UART_TCR	0xac /* Transceiver Control Register (RS485) */
+#define DW_UART_DE_EN	0xb0 /* Driver Output Enable Register */
+#define DW_UART_RE_EN	0xb4 /* Receiver Output Enable Register */
 #define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
 #define DW_UART_CPR	0xf4 /* Component Parameter Register */
 #define DW_UART_UCV	0xf8 /* UART Component Version */
 
+/* Transceiver Control Register bits */
+#define DW_UART_TCR_RS485_EN		BIT(0)
+#define DW_UART_TCR_RE_POL		BIT(1)
+#define DW_UART_TCR_DE_POL		BIT(2)
+#define DW_UART_TCR_XFER_MODE		GENMASK(4, 3)
+#define DW_UART_TCR_XFER_MODE_DE_DURING_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 0)
+#define DW_UART_TCR_XFER_MODE_SW_DE_OR_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 1)
+#define DW_UART_TCR_XFER_MODE_DE_OR_RE		FIELD_PREP(DW_UART_TCR_XFER_MODE, 2)
+
 /* Component Parameter Register bits */
 #define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
 #define DW_UART_CPR_AFCE_MODE		(1 << 4)
@@ -87,11 +101,62 @@ void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct
 }
 EXPORT_SYMBOL_GPL(dw8250_do_set_termios);
 
+static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
+{
+	u32 tcr;
+
+	tcr = dw8250_readl_ext(p, DW_UART_TCR);
+	tcr &= ~DW_UART_TCR_XFER_MODE;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* Clearing unsupported flags. */
+		rs485->flags &= SER_RS485_ENABLED;
+
+		tcr |= DW_UART_TCR_RS485_EN | DW_UART_TCR_XFER_MODE_DE_OR_RE;
+		dw8250_writel_ext(p, DW_UART_DE_EN, 1);
+		dw8250_writel_ext(p, DW_UART_RE_EN, 1);
+	} else {
+		rs485->flags = 0;
+
+		tcr &= ~DW_UART_TCR_RS485_EN;
+		dw8250_writel_ext(p, DW_UART_DE_EN, 0);
+		dw8250_writel_ext(p, DW_UART_RE_EN, 0);
+	}
+
+	/* Resetting the default DE_POL & RE_POL */
+	tcr &= ~(DW_UART_TCR_DE_POL | DW_UART_TCR_RE_POL);
+
+	if (device_property_read_bool(p->dev, "snps,de-active-high"))
+		tcr |= DW_UART_TCR_DE_POL;
+	if (device_property_read_bool(p->dev, "snps,re-active-high"))
+		tcr |= DW_UART_TCR_RE_POL;
+
+	dw8250_writel_ext(p, DW_UART_TCR, tcr);
+
+	/*
+	 * XXX: Though we could interpret the "RTS" timings as Driver Enable
+	 * (DE) assertion/de-assertion timings, initially not supporting that.
+	 * Ideally we should have timing values for the Driver instead of the
+	 * RTS signal.
+	 */
+	rs485->delay_rts_before_send = 0;
+	rs485->delay_rts_after_send = 0;
+
+	p->rs485 = *rs485;
+
+	return 0;
+}
+
 void dw8250_setup_port(struct uart_port *p)
 {
+	struct dw8250_port_data *d = p->private_data;
 	struct uart_8250_port *up = up_to_u8250p(p);
 	u32 reg;
 
+	d->hw_rs485_support = device_property_read_bool(p->dev, "snps,rs485-interface-en");
+	if (d->hw_rs485_support)
+		p->rs485_config = dw8250_rs485_config;
+
 	/*
 	 * If the Component Version Register returns zero, we know that
 	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
@@ -108,8 +173,6 @@ void dw8250_setup_port(struct uart_port *p)
 	dw8250_writel_ext(p, DW_UART_DLF, 0);
 
 	if (reg) {
-		struct dw8250_port_data *d = p->private_data;
-
 		d->dlf_size = fls(reg);
 		p->get_divisor = dw8250_get_divisor;
 		p->set_divisor = dw8250_set_divisor;
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 83d528e5cc21..a8fa020ca544 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -14,6 +14,9 @@ struct dw8250_port_data {
 
 	/* Hardware configuration */
 	u8			dlf_size;
+
+	/* RS485 variables */
+	bool			hw_rs485_support;
 };
 
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct ktermios *old);
-- 
2.30.2

