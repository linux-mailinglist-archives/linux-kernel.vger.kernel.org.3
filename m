Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC0B4CA18E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbiCBJ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240837AbiCBJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:58:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEC21CB07;
        Wed,  2 Mar 2022 01:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646215056; x=1677751056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6eiVEbbk45CnAZ8/EHrebW67L0OGGnBAhyrehZsBcas=;
  b=GpB7Q8rqyqjoDT2YGvpx3qIjB7vMCdpT12M4UAwMwRnnk3Hm+FqAejWt
   LNHrzLU93sbXNe7LILSK6q4W3kJ5YEHJ8x1S2XwddE8ckktlZTbitTPod
   78zz9UXViM1w+9/GQIDF77k80FoZ/FcRfLQslF+Qec6oDaFbySQEK0aKP
   cALKwhHPSC1NNpiYo6did9gjOvXG6qMGSPNWurSQPInxc5CSb41CwxXzq
   KuuwwnLuAaethjfEYGTCP+xMzfygdvqmI6DnQln1Y1LzHVOXfH474ZUcs
   592/VGsAVB6mydzT7J+kEBf7/2lSxK8fX0i3NHJqd2IrvaL01xRfdzbWj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="339794650"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="339794650"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:57:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="551182269"
Received: from abotoi-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.218.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:57:30 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
Subject: [RFC PATCH 7/7] serial: 8250_dwlib: Support for 9th bit multipoint addressing
Date:   Wed,  2 Mar 2022 11:56:06 +0200
Message-Id: <20220302095606.14818-8-ilpo.jarvinen@linux.intel.com>
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

This change adds 9th bit multipoint addressing mode for DW UART using
the new ioctls introduced in the previous change. 9th bit addressing
can be used only when HW RS485 is available.

Updating RAR (receive address register) is bit tricky because
busy indication is not be available when DW UART is strictly
16550 compatible, which is the case with the hardware I was
testing with. RAR should not be updated while receive is in
progress which is now achieved by deasserting RE and waiting
for one frame (in case rx would be in progress, the driver
seems to have no way of knowing it w/o busy indication).

Co-developed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Raymond Tan <raymond.tan@intel.com>
Co-developed-by: Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 124 +++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_dwlib.h |   3 +
 2 files changed, 127 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 51b0f55ee9d0..57bf6ca0309b 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -3,9 +3,11 @@
 
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/property.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
@@ -17,6 +19,9 @@
 #define DW_UART_DE_EN	0xb0 /* Driver Output Enable Register */
 #define DW_UART_RE_EN	0xb4 /* Receiver Output Enable Register */
 #define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
+#define DW_UART_RAR	0xc4 /* Receive Address Register */
+#define DW_UART_TAR	0xc8 /* Transmit Address Register */
+#define DW_UART_LCR_EXT	0xcc /* Line Extended Control Register */
 #define DW_UART_CPR	0xf4 /* Component Parameter Register */
 #define DW_UART_UCV	0xf8 /* UART Component Version */
 
@@ -29,6 +34,12 @@
 #define DW_UART_TCR_XFER_MODE_SW_DE_OR_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 1)
 #define DW_UART_TCR_XFER_MODE_DE_OR_RE		FIELD_PREP(DW_UART_TCR_XFER_MODE, 2)
 
+/* Line Extended Control Register bits */
+#define DW_UART_LCR_EXT_DLS_E		BIT(0)
+#define DW_UART_LCR_EXT_ADDR_MATCH	BIT(1)
+#define DW_UART_LCR_EXT_SEND_ADDR	BIT(2)
+#define DW_UART_LCR_EXT_TRANSMIT_MODE	BIT(3)
+
 /* Component Parameter Register bits */
 #define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
 #define DW_UART_CPR_AFCE_MODE		(1 << 4)
@@ -91,16 +102,126 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 	serial8250_do_set_divisor(p, baud, quot, quot_frac);
 }
 
+/* Wait until re is de-asserted for sure. Without BUSY indication available,
+ * only available course of action is to wait until current frame is received.
+ */
+static void dw8250_wait_re_deassert(struct uart_port *p)
+{
+	struct dw8250_port_data *d = p->private_data;
+
+	if (d->rar_timeout_us)
+		udelay(d->rar_timeout_us);
+}
+
+static void dw8250_update_rar(struct uart_port *p, u32 addr)
+{
+	u32 re_en = dw8250_readl_ext(p, DW_UART_RE_EN);
+
+	/* RAR shouldn't be changed while receiving. Thus, de-assert RE_EN
+	 * if asserted and wait.
+	 */
+	if (re_en)
+		dw8250_writel_ext(p, DW_UART_RE_EN, 0);
+	dw8250_wait_re_deassert(p);
+	dw8250_writel_ext(p, DW_UART_RAR, addr);
+	if (re_en)
+		dw8250_writel_ext(p, DW_UART_RE_EN, re_en);
+}
+
+static void dw8250_addrmode_setup(struct uart_port *p, bool enable_addrmode)
+{
+	struct dw8250_port_data *d = p->private_data;
+
+	if (enable_addrmode) {
+		/* Clear RAR & TAR of any previous values */
+		dw8250_writel_ext(p, DW_UART_RAR, 0);
+		dw8250_writel_ext(p, DW_UART_TAR, 0);
+		dw8250_writel_ext(p, DW_UART_LCR_EXT, DW_UART_LCR_EXT_DLS_E);
+	} else {
+		dw8250_writel_ext(p, DW_UART_LCR_EXT, 0);
+	}
+
+	d->addrmode = enable_addrmode;
+}
+
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct ktermios *old)
 {
+	struct dw8250_port_data *d = p->private_data;
+
 	p->status &= ~UPSTAT_AUTOCTS;
 	if (termios->c_cflag & CRTSCTS)
 		p->status |= UPSTAT_AUTOCTS;
 
+	if (!(p->rs485.flags & SER_RS485_ENABLED) || !d->hw_rs485_support)
+		termios->c_cflag &= ~ADDRB;
+
+	if (!old || (termios->c_cflag ^ old->c_cflag) & ADDRB)
+		dw8250_addrmode_setup(p, termios->c_cflag & ADDRB);
+
 	serial8250_do_set_termios(p, termios, old);
+
+	d->rar_timeout_us = termios->c_ispeed ?
+			    DIV_ROUND_UP(tty_get_frame_size(termios->c_cflag) * USEC_PER_SEC,
+					 termios->c_ispeed) : 0;
 }
 EXPORT_SYMBOL_GPL(dw8250_do_set_termios);
 
+static int dw8250_rs485_set_addr(struct uart_port *p, struct serial_addr *addr)
+{
+	struct dw8250_port_data *d = p->private_data;
+	u32 lcr;
+
+	if (!(p->rs485.flags & SER_RS485_ENABLED) || !d->addrmode)
+		return -EINVAL;
+
+	addr->flags &= SER_ADDR_RECV | SER_ADDR_RECV_CLEAR | SER_ADDR_DEST;
+	if (!addr->flags)
+		return -EINVAL;
+
+	lcr = dw8250_readl_ext(p, DW_UART_LCR_EXT);
+	if (addr->flags & SER_ADDR_RECV) {
+		dw8250_update_rar(p, addr->addr & 0xff);
+		lcr |= DW_UART_LCR_EXT_ADDR_MATCH;
+		addr->flags &= ~SER_ADDR_RECV_CLEAR;
+	} else if (addr->flags & SER_ADDR_RECV_CLEAR) {
+		lcr &= DW_UART_LCR_EXT_ADDR_MATCH;
+	}
+	if (addr->flags & SER_ADDR_DEST) {
+		dw8250_writel_ext(p, DW_UART_TAR, addr->addr & 0xff);
+		lcr |= DW_UART_LCR_EXT_SEND_ADDR;
+	}
+	dw8250_writel_ext(p, DW_UART_LCR_EXT, lcr);
+
+	return 0;
+}
+
+static int dw8250_rs485_get_addr(struct uart_port *p, struct serial_addr *addr)
+{
+	struct dw8250_port_data *d = p->private_data;
+
+	if (!(p->rs485.flags & SER_RS485_ENABLED) || !d->addrmode)
+		return -EINVAL;
+
+	if (addr->flags == SER_ADDR_DEST) {
+		addr->addr = dw8250_readl_ext(p, DW_UART_TAR) & 0xff;
+		return 0;
+	}
+	if (addr->flags == SER_ADDR_RECV) {
+		u32 lcr = dw8250_readl_ext(p, DW_UART_LCR_EXT);
+
+		if (!(lcr & DW_UART_LCR_EXT_ADDR_MATCH)) {
+			addr->flags = SER_ADDR_RECV_CLEAR;
+			addr->addr = 0;
+		} else {
+			addr->addr = dw8250_readl_ext(p, DW_UART_RAR) & 0xff;
+		}
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static void dw8250_rs485_start_tx(struct uart_8250_port *up)
 {
 	struct uart_port *p = &(up->port);
@@ -157,6 +278,7 @@ static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
 		tcr &= ~DW_UART_TCR_RS485_EN;
 		dw8250_writel_ext(p, DW_UART_DE_EN, 0);
 		dw8250_writel_ext(p, DW_UART_RE_EN, 0);
+		dw8250_addrmode_setup(p, false);
 	}
 
 	/* Resetting the default DE_POL & RE_POL */
@@ -203,6 +325,8 @@ void dw8250_setup_port(struct uart_port *p)
 		p->rs485_config = dw8250_rs485_config;
 		up->rs485_start_tx = dw8250_rs485_start_tx;
 		up->rs485_stop_tx = dw8250_rs485_stop_tx;
+		p->set_addr = dw8250_rs485_set_addr;
+		p->get_addr = dw8250_rs485_get_addr;
 	} else {
 		p->rs485_config = serial8250_em485_config;
 		up->rs485_start_tx = serial8250_em485_start_tx;
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index a8fa020ca544..bfb1d8af7f0c 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -17,6 +17,9 @@ struct dw8250_port_data {
 
 	/* RS485 variables */
 	bool			hw_rs485_support;
+	/* 9-bit framing (9th bit is address indicator) */
+	bool			addrmode;
+	unsigned int		rar_timeout_us;
 };
 
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct ktermios *old);
-- 
2.30.2

