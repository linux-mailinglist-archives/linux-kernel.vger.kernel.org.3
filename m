Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46DD57D5DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiGUVYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiGUVYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:24:37 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE95B92856
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:24:35 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEdep-001ttl-2D;
        Thu, 21 Jul 2022 22:24:31 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] serial: stm32: make info structs static to avoid sparse warnings
Date:   Thu, 21 Jul 2022 22:24:30 +0100
Message-Id: <20220721212430.453192-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The info structs are local only to the stm32-usart.c driver and are
triggering sparse warnings about being undecalred. Move these into
the main driver code and make them static to avoid the following
warnings:

drivers/tty/serial/stm32-usart.h:42:25: warning: symbol 'stm32f4_info' was not declared. Should it be static?
drivers/tty/serial/stm32-usart.h:63:25: warning: symbol 'stm32f7_info' was not declared. Should it be static?
drivers/tty/serial/stm32-usart.h:85:25: warning: symbol 'stm32h7_info' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/tty/serial/stm32-usart.c | 69 ++++++++++++++++++++++++++++++++
 drivers/tty/serial/stm32-usart.h | 68 -------------------------------
 2 files changed, 69 insertions(+), 68 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 0973b03eeeaa..01f1ab2c18c0 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -35,6 +35,75 @@
 #include "serial_mctrl_gpio.h"
 #include "stm32-usart.h"
 
+
+/* Register offsets */
+static struct stm32_usart_info stm32f4_info = {
+	.ofs = {
+		.isr	= 0x00,
+		.rdr	= 0x04,
+		.tdr	= 0x04,
+		.brr	= 0x08,
+		.cr1	= 0x0c,
+		.cr2	= 0x10,
+		.cr3	= 0x14,
+		.gtpr	= 0x18,
+		.rtor	= UNDEF_REG,
+		.rqr	= UNDEF_REG,
+		.icr	= UNDEF_REG,
+	},
+	.cfg = {
+		.uart_enable_bit = 13,
+		.has_7bits_data = false,
+		.fifosize = 1,
+	}
+};
+
+static struct stm32_usart_info stm32f7_info = {
+	.ofs = {
+		.cr1	= 0x00,
+		.cr2	= 0x04,
+		.cr3	= 0x08,
+		.brr	= 0x0c,
+		.gtpr	= 0x10,
+		.rtor	= 0x14,
+		.rqr	= 0x18,
+		.isr	= 0x1c,
+		.icr	= 0x20,
+		.rdr	= 0x24,
+		.tdr	= 0x28,
+	},
+	.cfg = {
+		.uart_enable_bit = 0,
+		.has_7bits_data = true,
+		.has_swap = true,
+		.fifosize = 1,
+	}
+};
+
+static struct stm32_usart_info stm32h7_info = {
+	.ofs = {
+		.cr1	= 0x00,
+		.cr2	= 0x04,
+		.cr3	= 0x08,
+		.brr	= 0x0c,
+		.gtpr	= 0x10,
+		.rtor	= 0x14,
+		.rqr	= 0x18,
+		.isr	= 0x1c,
+		.icr	= 0x20,
+		.rdr	= 0x24,
+		.tdr	= 0x28,
+	},
+	.cfg = {
+		.uart_enable_bit = 0,
+		.has_7bits_data = true,
+		.has_swap = true,
+		.has_wakeup = true,
+		.has_fifo = true,
+		.fifosize = 16,
+	}
+};
+
 static void stm32_usart_stop_tx(struct uart_port *port);
 static void stm32_usart_transmit_chars(struct uart_port *port);
 static void __maybe_unused stm32_usart_console_putchar(struct uart_port *port, unsigned char ch);
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index ee69c203b926..0ec41a732c88 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -38,74 +38,6 @@ struct stm32_usart_info {
 
 #define UNDEF_REG 0xff
 
-/* Register offsets */
-struct stm32_usart_info stm32f4_info = {
-	.ofs = {
-		.isr	= 0x00,
-		.rdr	= 0x04,
-		.tdr	= 0x04,
-		.brr	= 0x08,
-		.cr1	= 0x0c,
-		.cr2	= 0x10,
-		.cr3	= 0x14,
-		.gtpr	= 0x18,
-		.rtor	= UNDEF_REG,
-		.rqr	= UNDEF_REG,
-		.icr	= UNDEF_REG,
-	},
-	.cfg = {
-		.uart_enable_bit = 13,
-		.has_7bits_data = false,
-		.fifosize = 1,
-	}
-};
-
-struct stm32_usart_info stm32f7_info = {
-	.ofs = {
-		.cr1	= 0x00,
-		.cr2	= 0x04,
-		.cr3	= 0x08,
-		.brr	= 0x0c,
-		.gtpr	= 0x10,
-		.rtor	= 0x14,
-		.rqr	= 0x18,
-		.isr	= 0x1c,
-		.icr	= 0x20,
-		.rdr	= 0x24,
-		.tdr	= 0x28,
-	},
-	.cfg = {
-		.uart_enable_bit = 0,
-		.has_7bits_data = true,
-		.has_swap = true,
-		.fifosize = 1,
-	}
-};
-
-struct stm32_usart_info stm32h7_info = {
-	.ofs = {
-		.cr1	= 0x00,
-		.cr2	= 0x04,
-		.cr3	= 0x08,
-		.brr	= 0x0c,
-		.gtpr	= 0x10,
-		.rtor	= 0x14,
-		.rqr	= 0x18,
-		.isr	= 0x1c,
-		.icr	= 0x20,
-		.rdr	= 0x24,
-		.tdr	= 0x28,
-	},
-	.cfg = {
-		.uart_enable_bit = 0,
-		.has_7bits_data = true,
-		.has_swap = true,
-		.has_wakeup = true,
-		.has_fifo = true,
-		.fifosize = 16,
-	}
-};
-
 /* USART_SR (F4) / USART_ISR (F7) */
 #define USART_SR_PE		BIT(0)
 #define USART_SR_FE		BIT(1)
-- 
2.35.1

