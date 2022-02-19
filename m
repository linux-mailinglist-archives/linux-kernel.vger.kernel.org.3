Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98D04BC91A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 16:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbiBSP3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 10:29:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiBSP2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 10:28:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2685D1B8;
        Sat, 19 Feb 2022 07:28:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24F8BB80757;
        Sat, 19 Feb 2022 15:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACED2C340EF;
        Sat, 19 Feb 2022 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645284510;
        bh=ORQrNJck3y+vTxPsxb5R4Ugx936Ozv1wZAPpdgksmXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6MCk0KMXRaMBJ29tLBPVqlXSUEFb/00BE7/G7VioMDd20z5vq3bUpOOjW7LkDuJv
         Ffx+JRzzZoIjiOy7JnyUzwpj0iXInbJBJF3ZrjdjHdJrG+K93w2Cvva82URdvcpLTZ
         3B95qnIkc4o2rhbHmFZHsWBL5F87Q3JNzh6A8gTjJSOFyzYjwRbl/0LPZnsZBNf7FV
         5/WZ+gGRAsW/EVR96FTrso9yXIGIBu9MkRiOlnvE9OrAYalqFyDWfuYeY9KPkJjacB
         imzO0nbKVkrGmXQBnWdYxqlJWUz8cFZRKxhNH/fYoNxHgaz77x3IntsuZDqICuaSP3
         EAZETCDnYVnNg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v9 3/6] serial: mvebu-uart: implement UART clock driver for configuring UART base clock
Date:   Sat, 19 Feb 2022 16:28:15 +0100
Message-Id: <20220219152818.4319-4-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220219152818.4319-1-kabel@kernel.org>
References: <20220219152818.4319-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Implement a new device driver for controlling UART clocks on Marvell
Armada 3700 SoC. This device driver is loaded for devices which match
the compatible string "marvell,armada-3700-uart-clock".

There are more pitfalls related to UART clocks:
- both UARTs use same parent clock source (which can be xtal or one of
  the TBG clocks),
- if a TBG clock is used as the parent clock, there are two additional
  divisors that can both be configured to divide the rate by 1, 2, ... 6,
  but these divisors are again shared between the two UART controllers
  on the SOC,
- the configuration of the parent clock source and divisors is done in
  the address space of the first UART controller, UART1. Clocks can be
  gated separately for UART1 and UART2, but this setting also lives in
  the address space of UART1,
- Marvell's Functional Specification for Armada 3720 document has the
  clock gating bits swapped, so the one described to gate UART1 clock
  actually gates UART2 and vice versa,
- each UART has it's own "special divisor", and this uses the parent
  clock described above. These divisors are configure in each UART's
  address space separately.

Thus the driver for UART2 controller needs to have access to UART1
address space, since UART1 address space contains some bits exclusive
for UART2 and also some bits which are shared between UART1 and UART2.

Also, during boot, when early console is active on one of the UARTs,
and we want to switch parent clock from xtal (default) to TBG (to be
more flexible with baudrates), the driver changing UART clocks also
needs to be able to change the "special divisor", so that the baudrate
of earlycon is not changed when swtiching to normal console. Thus the
clock driver also needs to be able to access UART2 register space,
for UART2's "special divisor".

For these reasons, this new UART clock driver does not use
ioremap_resource(), but only ioremap() to prevent resource conflicts
between UART clock driver and UART driver.

We need to share only two 32-bit registers between the UART driver and
the UART clock driver:
- UART Clock Control
- UART 2 Baud Rate Divisor
Access to these two registers are protected by one spinlock to prevent
any conflicts. Access is required only during probing, when changing
baudrate or during suspend/resume.

Hardware can be configured to use one of following clocks as UART parent
clock: TBG-A-P, TBG-B-P, TBG-A-S, TBG-B-S, xtal. Not every clock is
usable for higher buadrates. Any subset can be specified in the
device-tree and the driver will choose the best one which also still
supports the mandatory baudrate of 9600 Bd. For smooth boot log output
it is needed to specify clock used by early console, otherwise garbage
would be printed on UART during probe of UART clock driver and
transitioning from early console to normal console.

We are implementing this to be able to configure TBG clock as UART
parent clock, which is required to be able to achieve higher baudrates
than 230400 Bd. We achieve this by referencing this new UART clock
device node in UART's device node. UART clock device driver
automatically chooses the best clock source for UART driver.

Until now, UART's device-tree node needed to reference one of the static
clocks (xtal or one of the TBGs) as parent clock in the `clocks`
phandle - the parent clock which was configured before booting the
kernel. If bootloader changed UART's parent clock, it needed to change
the `clocks` phandle in DTB correspondingly before booting.

From now on both the old mechanism (xtal or TBG referenced as parent
clock in `clocks` phandle) and the new one (UART clock referenced in the
`clocks` phandle) are supported, to provide full backward compatibility
with existing DTS files, full backward compatibility with existing boot
loaders, and to provide new features (runtime clock configuration to
allow higher baudrates than 230400 Bd). New features are available only
with new DTS files.

There was also a discussion about how the UART node and the
clock-controller node could be wrapped together in a new binding [1, 2].
As explained there, this is not possible if we want to keep backwards
compatibility with existing bootloaders, and thus we are doing this by
putting the UART clock-controller node inside the UART1 node.

[1] https://lore.kernel.org/linux-serial/20220120000651.in7s6nazif5qjkme@pali/
[2] https://lore.kernel.org/linux-serial/20220125204006.A6D09C340E0@smtp.kernel.org/

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
Changes since v8:
- fixed typo in commit message
Changes since v7:
- commit message was rewritten
- changed comments a little
- fixed indentation at some places
- added Marek's Reviewed-by tag
---
 drivers/tty/serial/Kconfig      |   1 +
 drivers/tty/serial/mvebu-uart.c | 521 +++++++++++++++++++++++++++++++-
 2 files changed, 520 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0e5ccb25bdb1..9bc1325dd7ba 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1445,6 +1445,7 @@ config SERIAL_STM32_CONSOLE
 config SERIAL_MVEBU_UART
 	bool "Marvell EBU serial port support"
 	depends on ARCH_MVEBU || COMPILE_TEST
+	depends on COMMON_CLK
 	select SERIAL_CORE
 	help
 	  This driver is for Marvell EBU SoC's UART. If you have a machine
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index ab226da75f7b..56278b29f5f5 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -8,12 +8,14 @@
 */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -68,8 +70,31 @@
 #define  STAT_BRK_ERR		(STAT_BRK_DET | STAT_FRM_ERR \
 				 | STAT_PAR_ERR | STAT_OVR_ERR)
 
+/*
+ * Marvell Armada 3700 Functional Specifications describes that bit 21 of UART
+ * Clock Control register controls UART1 and bit 20 controls UART2. But in
+ * reality bit 21 controls UART2 and bit 20 controls UART1. This seems to be an
+ * error in Marvell's documentation. Hence following CLK_DIS macros are swapped.
+ */
+
 #define UART_BRDV		0x10
+/* These bits are located in UART1 address space and control UART2 */
+#define  UART2_CLK_DIS		BIT(21)
+/* These bits are located in UART1 address space and control UART1 */
+#define  UART1_CLK_DIS		BIT(20)
+/* These bits are located in UART1 address space and control both UARTs */
+#define  CLK_NO_XTAL		BIT(19)
+#define  CLK_TBG_DIV1_SHIFT	15
+#define  CLK_TBG_DIV1_MASK	0x7
+#define  CLK_TBG_DIV1_MAX	6
+#define  CLK_TBG_DIV2_SHIFT	12
+#define  CLK_TBG_DIV2_MASK	0x7
+#define  CLK_TBG_DIV2_MAX	6
+#define  CLK_TBG_SEL_SHIFT	10
+#define  CLK_TBG_SEL_MASK	0x3
+/* These bits are located in both UARTs address space */
 #define  BRDV_BAUD_MASK         0x3FF
+#define  BRDV_BAUD_MAX		BRDV_BAUD_MASK
 
 #define UART_OSAMP		0x14
 #define  OSAMP_DEFAULT_DIVISOR	16
@@ -153,6 +178,8 @@ static struct mvebu_uart *to_mvuart(struct uart_port *port)
 
 static struct uart_port mvebu_uart_ports[MVEBU_NR_UARTS];
 
+static DEFINE_SPINLOCK(mvebu_uart_lock);
+
 /* Core UART Driver Operations */
 static unsigned int mvebu_uart_tx_empty(struct uart_port *port)
 {
@@ -445,6 +472,7 @@ static void mvebu_uart_shutdown(struct uart_port *port)
 static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 {
 	unsigned int d_divisor, m_divisor;
+	unsigned long flags;
 	u32 brdv, osamp;
 
 	if (!port->uartclk)
@@ -463,10 +491,12 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 	m_divisor = OSAMP_DEFAULT_DIVISOR;
 	d_divisor = DIV_ROUND_CLOSEST(port->uartclk, baud * m_divisor);
 
+	spin_lock_irqsave(&mvebu_uart_lock, flags);
 	brdv = readl(port->membase + UART_BRDV);
 	brdv &= ~BRDV_BAUD_MASK;
 	brdv |= d_divisor;
 	writel(brdv, port->membase + UART_BRDV);
+	spin_unlock_irqrestore(&mvebu_uart_lock, flags);
 
 	osamp = readl(port->membase + UART_OSAMP);
 	osamp &= ~OSAMP_DIVISORS_MASK;
@@ -762,6 +792,7 @@ static int mvebu_uart_suspend(struct device *dev)
 {
 	struct mvebu_uart *mvuart = dev_get_drvdata(dev);
 	struct uart_port *port = mvuart->port;
+	unsigned long flags;
 
 	uart_suspend_port(&mvebu_uart_driver, port);
 
@@ -770,7 +801,9 @@ static int mvebu_uart_suspend(struct device *dev)
 	mvuart->pm_regs.ctrl = readl(port->membase + UART_CTRL(port));
 	mvuart->pm_regs.intr = readl(port->membase + UART_INTR(port));
 	mvuart->pm_regs.stat = readl(port->membase + UART_STAT);
+	spin_lock_irqsave(&mvebu_uart_lock, flags);
 	mvuart->pm_regs.brdv = readl(port->membase + UART_BRDV);
+	spin_unlock_irqrestore(&mvebu_uart_lock, flags);
 	mvuart->pm_regs.osamp = readl(port->membase + UART_OSAMP);
 
 	device_set_wakeup_enable(dev, true);
@@ -782,13 +815,16 @@ static int mvebu_uart_resume(struct device *dev)
 {
 	struct mvebu_uart *mvuart = dev_get_drvdata(dev);
 	struct uart_port *port = mvuart->port;
+	unsigned long flags;
 
 	writel(mvuart->pm_regs.rbr, port->membase + UART_RBR(port));
 	writel(mvuart->pm_regs.tsh, port->membase + UART_TSH(port));
 	writel(mvuart->pm_regs.ctrl, port->membase + UART_CTRL(port));
 	writel(mvuart->pm_regs.intr, port->membase + UART_INTR(port));
 	writel(mvuart->pm_regs.stat, port->membase + UART_STAT);
+	spin_lock_irqsave(&mvebu_uart_lock, flags);
 	writel(mvuart->pm_regs.brdv, port->membase + UART_BRDV);
+	spin_unlock_irqrestore(&mvebu_uart_lock, flags);
 	writel(mvuart->pm_regs.osamp, port->membase + UART_OSAMP);
 
 	uart_resume_port(&mvebu_uart_driver, port);
@@ -972,6 +1008,478 @@ static struct platform_driver mvebu_uart_platform_driver = {
 	},
 };
 
+/* This code is based on clk-fixed-factor.c driver and modified. */
+
+struct mvebu_uart_clock {
+	struct clk_hw clk_hw;
+	int clock_idx;
+	u32 pm_context_reg1;
+	u32 pm_context_reg2;
+};
+
+struct mvebu_uart_clock_base {
+	struct mvebu_uart_clock clocks[2];
+	unsigned int parent_rates[5];
+	int parent_idx;
+	unsigned int div;
+	void __iomem *reg1;
+	void __iomem *reg2;
+	bool configured;
+};
+
+#define PARENT_CLOCK_XTAL 4
+
+#define to_uart_clock(hw) container_of(hw, struct mvebu_uart_clock, clk_hw)
+#define to_uart_clock_base(uart_clock) container_of(uart_clock, \
+	struct mvebu_uart_clock_base, clocks[uart_clock->clock_idx])
+
+static int mvebu_uart_clock_prepare(struct clk_hw *hw)
+{
+	struct mvebu_uart_clock *uart_clock = to_uart_clock(hw);
+	struct mvebu_uart_clock_base *uart_clock_base =
+						to_uart_clock_base(uart_clock);
+	unsigned int prev_clock_idx, prev_clock_rate, prev_d1d2;
+	unsigned int parent_clock_idx, parent_clock_rate;
+	unsigned long flags;
+	unsigned int d1, d2;
+	u64 divisor;
+	u32 val;
+
+	/*
+	 * This function just reconfigures UART Clock Control register (located
+	 * in UART1 address space which controls both UART1 and UART2) to
+	 * selected UART base clock and recalculates current UART1/UART2
+	 * divisors in their address spaces, so that final baudrate will not be
+	 * changed by switching UART parent clock. This is required for
+	 * otherwise kernel's boot log stops working - we need to ensure that
+	 * UART baudrate does not change during this setup. It is a one time
+	 * operation, it will execute only once and set `configured` to true,
+	 * and be skipped on subsequent calls. Because this UART Clock Control
+	 * register (UART_BRDV) is shared between UART1 baudrate function,
+	 * UART1 clock selector and UART2 clock selector, every access to
+	 * UART_BRDV (reg1) needs to be protected by a lock.
+	 */
+
+	spin_lock_irqsave(&mvebu_uart_lock, flags);
+
+	if (uart_clock_base->configured) {
+		spin_unlock_irqrestore(&mvebu_uart_lock, flags);
+		return 0;
+	}
+
+	parent_clock_idx = uart_clock_base->parent_idx;
+	parent_clock_rate = uart_clock_base->parent_rates[parent_clock_idx];
+
+	val = readl(uart_clock_base->reg1);
+
+	if (uart_clock_base->div > CLK_TBG_DIV1_MAX) {
+		d1 = CLK_TBG_DIV1_MAX;
+		d2 = uart_clock_base->div / CLK_TBG_DIV1_MAX;
+	} else {
+		d1 = uart_clock_base->div;
+		d2 = 1;
+	}
+
+	if (val & CLK_NO_XTAL) {
+		prev_clock_idx = (val >> CLK_TBG_SEL_SHIFT) & CLK_TBG_SEL_MASK;
+		prev_d1d2 = ((val >> CLK_TBG_DIV1_SHIFT) & CLK_TBG_DIV1_MASK) *
+			    ((val >> CLK_TBG_DIV2_SHIFT) & CLK_TBG_DIV2_MASK);
+	} else {
+		prev_clock_idx = PARENT_CLOCK_XTAL;
+		prev_d1d2 = 1;
+	}
+
+	/* Note that uart_clock_base->parent_rates[i] may not be available */
+	prev_clock_rate = uart_clock_base->parent_rates[prev_clock_idx];
+
+	/* Recalculate UART1 divisor so UART1 baudrate does not change */
+	if (prev_clock_rate) {
+		divisor = DIV_U64_ROUND_CLOSEST((u64)(val & BRDV_BAUD_MASK) *
+						parent_clock_rate * prev_d1d2,
+						prev_clock_rate * d1 * d2);
+		if (divisor < 1)
+			divisor = 1;
+		else if (divisor > BRDV_BAUD_MAX)
+			divisor = BRDV_BAUD_MAX;
+		val = (val & ~BRDV_BAUD_MASK) | divisor;
+	}
+
+	if (parent_clock_idx != PARENT_CLOCK_XTAL) {
+		/* Do not use XTAL, select TBG clock and TBG d1 * d2 divisors */
+		val |= CLK_NO_XTAL;
+		val &= ~(CLK_TBG_DIV1_MASK << CLK_TBG_DIV1_SHIFT);
+		val |= d1 << CLK_TBG_DIV1_SHIFT;
+		val &= ~(CLK_TBG_DIV2_MASK << CLK_TBG_DIV2_SHIFT);
+		val |= d2 << CLK_TBG_DIV2_SHIFT;
+		val &= ~(CLK_TBG_SEL_MASK << CLK_TBG_SEL_SHIFT);
+		val |= parent_clock_idx << CLK_TBG_SEL_SHIFT;
+	} else {
+		/* Use XTAL, TBG bits are then ignored */
+		val &= ~CLK_NO_XTAL;
+	}
+
+	writel(val, uart_clock_base->reg1);
+
+	/* Recalculate UART2 divisor so UART2 baudrate does not change */
+	if (prev_clock_rate) {
+		val = readl(uart_clock_base->reg2);
+		divisor = DIV_U64_ROUND_CLOSEST((u64)(val & BRDV_BAUD_MASK) *
+						parent_clock_rate * prev_d1d2,
+						prev_clock_rate * d1 * d2);
+		if (divisor < 1)
+			divisor = 1;
+		else if (divisor > BRDV_BAUD_MAX)
+			divisor = BRDV_BAUD_MAX;
+		val = (val & ~BRDV_BAUD_MASK) | divisor;
+		writel(val, uart_clock_base->reg2);
+	}
+
+	uart_clock_base->configured = true;
+
+	spin_unlock_irqrestore(&mvebu_uart_lock, flags);
+
+	return 0;
+}
+
+static int mvebu_uart_clock_enable(struct clk_hw *hw)
+{
+	struct mvebu_uart_clock *uart_clock = to_uart_clock(hw);
+	struct mvebu_uart_clock_base *uart_clock_base =
+						to_uart_clock_base(uart_clock);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&mvebu_uart_lock, flags);
+
+	val = readl(uart_clock_base->reg1);
+
+	if (uart_clock->clock_idx == 0)
+		val &= ~UART1_CLK_DIS;
+	else
+		val &= ~UART2_CLK_DIS;
+
+	writel(val, uart_clock_base->reg1);
+
+	spin_unlock_irqrestore(&mvebu_uart_lock, flags);
+
+	return 0;
+}
+
+static void mvebu_uart_clock_disable(struct clk_hw *hw)
+{
+	struct mvebu_uart_clock *uart_clock = to_uart_clock(hw);
+	struct mvebu_uart_clock_base *uart_clock_base =
+						to_uart_clock_base(uart_clock);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&mvebu_uart_lock, flags);
+
+	val = readl(uart_clock_base->reg1);
+
+	if (uart_clock->clock_idx == 0)
+		val |= UART1_CLK_DIS;
+	else
+		val |= UART2_CLK_DIS;
+
+	writel(val, uart_clock_base->reg1);
+
+	spin_unlock_irqrestore(&mvebu_uart_lock, flags);
+}
+
+static int mvebu_uart_clock_is_enabled(struct clk_hw *hw)
+{
+	struct mvebu_uart_clock *uart_clock = to_uart_clock(hw);
+	struct mvebu_uart_clock_base *uart_clock_base =
+						to_uart_clock_base(uart_clock);
+	u32 val;
+
+	val = readl(uart_clock_base->reg1);
+
+	if (uart_clock->clock_idx == 0)
+		return !(val & UART1_CLK_DIS);
+	else
+		return !(val & UART2_CLK_DIS);
+}
+
+static int mvebu_uart_clock_save_context(struct clk_hw *hw)
+{
+	struct mvebu_uart_clock *uart_clock = to_uart_clock(hw);
+	struct mvebu_uart_clock_base *uart_clock_base =
+						to_uart_clock_base(uart_clock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mvebu_uart_lock, flags);
+	uart_clock->pm_context_reg1 = readl(uart_clock_base->reg1);
+	uart_clock->pm_context_reg2 = readl(uart_clock_base->reg2);
+	spin_unlock_irqrestore(&mvebu_uart_lock, flags);
+
+	return 0;
+}
+
+static void mvebu_uart_clock_restore_context(struct clk_hw *hw)
+{
+	struct mvebu_uart_clock *uart_clock = to_uart_clock(hw);
+	struct mvebu_uart_clock_base *uart_clock_base =
+						to_uart_clock_base(uart_clock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mvebu_uart_lock, flags);
+	writel(uart_clock->pm_context_reg1, uart_clock_base->reg1);
+	writel(uart_clock->pm_context_reg2, uart_clock_base->reg2);
+	spin_unlock_irqrestore(&mvebu_uart_lock, flags);
+}
+
+static unsigned long mvebu_uart_clock_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct mvebu_uart_clock *uart_clock = to_uart_clock(hw);
+	struct mvebu_uart_clock_base *uart_clock_base =
+						to_uart_clock_base(uart_clock);
+
+	return parent_rate / uart_clock_base->div;
+}
+
+static long mvebu_uart_clock_round_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long *parent_rate)
+{
+	struct mvebu_uart_clock *uart_clock = to_uart_clock(hw);
+	struct mvebu_uart_clock_base *uart_clock_base =
+						to_uart_clock_base(uart_clock);
+
+	return *parent_rate / uart_clock_base->div;
+}
+
+static int mvebu_uart_clock_set_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
+{
+	/*
+	 * We must report success but we can do so unconditionally because
+	 * mvebu_uart_clock_round_rate returns values that ensure this call is a
+	 * nop.
+	 */
+
+	return 0;
+}
+
+static const struct clk_ops mvebu_uart_clock_ops = {
+	.prepare = mvebu_uart_clock_prepare,
+	.enable = mvebu_uart_clock_enable,
+	.disable = mvebu_uart_clock_disable,
+	.is_enabled = mvebu_uart_clock_is_enabled,
+	.save_context = mvebu_uart_clock_save_context,
+	.restore_context = mvebu_uart_clock_restore_context,
+	.round_rate = mvebu_uart_clock_round_rate,
+	.set_rate = mvebu_uart_clock_set_rate,
+	.recalc_rate = mvebu_uart_clock_recalc_rate,
+};
+
+static int mvebu_uart_clock_register(struct device *dev,
+				     struct mvebu_uart_clock *uart_clock,
+				     const char *name,
+				     const char *parent_name)
+{
+	struct clk_init_data init = { };
+
+	uart_clock->clk_hw.init = &init;
+
+	init.name = name;
+	init.ops = &mvebu_uart_clock_ops;
+	init.flags = 0;
+	init.num_parents = 1;
+	init.parent_names = &parent_name;
+
+	return devm_clk_hw_register(dev, &uart_clock->clk_hw);
+}
+
+static int mvebu_uart_clock_probe(struct platform_device *pdev)
+{
+	static const char *const uart_clk_names[] = { "uart_1", "uart_2" };
+	static const char *const parent_clk_names[] = { "TBG-A-P", "TBG-B-P",
+							"TBG-A-S", "TBG-B-S",
+							"xtal" };
+	struct clk *parent_clks[ARRAY_SIZE(parent_clk_names)];
+	struct mvebu_uart_clock_base *uart_clock_base;
+	struct clk_hw_onecell_data *hw_clk_data;
+	struct device *dev = &pdev->dev;
+	int i, parent_clk_idx, ret;
+	unsigned long div, rate;
+	struct resource *res;
+	unsigned int d1, d2;
+
+	BUILD_BUG_ON(ARRAY_SIZE(uart_clk_names) !=
+		     ARRAY_SIZE(uart_clock_base->clocks));
+	BUILD_BUG_ON(ARRAY_SIZE(parent_clk_names) !=
+		     ARRAY_SIZE(uart_clock_base->parent_rates));
+
+	uart_clock_base = devm_kzalloc(dev,
+				       sizeof(*uart_clock_base),
+				       GFP_KERNEL);
+	if (!uart_clock_base)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "Couldn't get first register\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * UART Clock Control register (reg1 / UART_BRDV) is in the address
+	 * space of UART1 (standard UART variant), controls parent clock and
+	 * dividers for both UART1 and UART2 and is supplied via DT as the first
+	 * resource. Therefore use ioremap() rather than ioremap_resource() to
+	 * avoid conflicts with UART1 driver. Access to UART_BRDV is protected
+	 * by a lock shared between clock and UART driver.
+	 */
+	uart_clock_base->reg1 = devm_ioremap(dev, res->start,
+					     resource_size(res));
+	if (IS_ERR(uart_clock_base->reg1))
+		return PTR_ERR(uart_clock_base->reg1);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(dev, "Couldn't get second register\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * UART 2 Baud Rate Divisor register (reg2 / UART_BRDV) is in address
+	 * space of UART2 (extended UART variant), controls only one UART2
+	 * specific divider and is supplied via DT as second resource.
+	 * Therefore use ioremap() rather than ioremap_resource() to avoid
+	 * conflicts with UART2 driver. Access to UART_BRDV is protected by a
+	 * by lock shared between clock and UART driver.
+	 */
+	uart_clock_base->reg2 = devm_ioremap(dev, res->start,
+					     resource_size(res));
+	if (IS_ERR(uart_clock_base->reg2))
+		return PTR_ERR(uart_clock_base->reg2);
+
+	hw_clk_data = devm_kzalloc(dev,
+				   struct_size(hw_clk_data, hws,
+					       ARRAY_SIZE(uart_clk_names)),
+				   GFP_KERNEL);
+	if (!hw_clk_data)
+		return -ENOMEM;
+
+	hw_clk_data->num = ARRAY_SIZE(uart_clk_names);
+	for (i = 0; i < ARRAY_SIZE(uart_clk_names); i++) {
+		hw_clk_data->hws[i] = &uart_clock_base->clocks[i].clk_hw;
+		uart_clock_base->clocks[i].clock_idx = i;
+	}
+
+	parent_clk_idx = -1;
+
+	for (i = 0; i < ARRAY_SIZE(parent_clk_names); i++) {
+		parent_clks[i] = devm_clk_get(dev, parent_clk_names[i]);
+		if (IS_ERR(parent_clks[i])) {
+			if (PTR_ERR(parent_clks[i]) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			dev_warn(dev, "Couldn't get the parent clock %s: %ld\n",
+				 parent_clk_names[i], PTR_ERR(parent_clks[i]));
+			continue;
+		}
+
+		ret = clk_prepare_enable(parent_clks[i]);
+		if (ret) {
+			dev_warn(dev, "Couldn't enable parent clock %s: %d\n",
+				 parent_clk_names[i], ret);
+			continue;
+		}
+		rate = clk_get_rate(parent_clks[i]);
+		uart_clock_base->parent_rates[i] = rate;
+
+		if (i != PARENT_CLOCK_XTAL) {
+			/*
+			 * Calculate the smallest TBG d1 and d2 divisors that
+			 * still can provide 9600 baudrate.
+			 */
+			d1 = DIV_ROUND_UP(rate, 9600 * OSAMP_DEFAULT_DIVISOR *
+					  BRDV_BAUD_MAX);
+			if (d1 < 1)
+				d1 = 1;
+			else if (d1 > CLK_TBG_DIV1_MAX)
+				d1 = CLK_TBG_DIV1_MAX;
+
+			d2 = DIV_ROUND_UP(rate, 9600 * OSAMP_DEFAULT_DIVISOR *
+					  BRDV_BAUD_MAX * d1);
+			if (d2 < 1)
+				d2 = 1;
+			else if (d2 > CLK_TBG_DIV2_MAX)
+				d2 = CLK_TBG_DIV2_MAX;
+		} else {
+			/*
+			 * When UART clock uses XTAL clock as a source then it
+			 * is not possible to use d1 and d2 divisors.
+			 */
+			d1 = d2 = 1;
+		}
+
+		/* Skip clock source which cannot provide 9600 baudrate */
+		if (rate > 9600 * OSAMP_DEFAULT_DIVISOR * BRDV_BAUD_MAX * d1 *
+			   d2)
+			continue;
+
+		/*
+		 * Choose TBG clock source with the smallest divisors. Use XTAL
+		 * clock source only in case TBG is not available as XTAL cannot
+		 * be used for baudrates higher than 230400.
+		 */
+		if (parent_clk_idx == -1 ||
+		    (i != PARENT_CLOCK_XTAL && div > d1 * d2)) {
+			parent_clk_idx = i;
+			div = d1 * d2;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(parent_clk_names); i++) {
+		if (i == parent_clk_idx || IS_ERR(parent_clks[i]))
+			continue;
+		clk_disable_unprepare(parent_clks[i]);
+		devm_clk_put(dev, parent_clks[i]);
+	}
+
+	if (parent_clk_idx == -1) {
+		dev_err(dev, "No usable parent clock\n");
+		return -ENOENT;
+	}
+
+	uart_clock_base->parent_idx = parent_clk_idx;
+	uart_clock_base->div = div;
+
+	dev_notice(dev, "Using parent clock %s as base UART clock\n",
+		   __clk_get_name(parent_clks[parent_clk_idx]));
+
+	for (i = 0; i < ARRAY_SIZE(uart_clk_names); i++) {
+		ret = mvebu_uart_clock_register(dev,
+				&uart_clock_base->clocks[i],
+				uart_clk_names[i],
+				__clk_get_name(parent_clks[parent_clk_idx]));
+		if (ret) {
+			dev_err(dev, "Can't register UART clock %d: %d\n",
+				i, ret);
+			return ret;
+		}
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   hw_clk_data);
+}
+
+static const struct of_device_id mvebu_uart_clock_of_match[] = {
+	{ .compatible = "marvell,armada-3700-uart-clock", },
+	{ }
+};
+
+static struct platform_driver mvebu_uart_clock_platform_driver = {
+	.probe = mvebu_uart_clock_probe,
+	.driver		= {
+		.name	= "mvebu-uart-clock",
+		.of_match_table = mvebu_uart_clock_of_match,
+	},
+};
+
 static int __init mvebu_uart_init(void)
 {
 	int ret;
@@ -980,10 +1488,19 @@ static int __init mvebu_uart_init(void)
 	if (ret)
 		return ret;
 
+	ret = platform_driver_register(&mvebu_uart_clock_platform_driver);
+	if (ret) {
+		uart_unregister_driver(&mvebu_uart_driver);
+		return ret;
+	}
+
 	ret = platform_driver_register(&mvebu_uart_platform_driver);
-	if (ret)
+	if (ret) {
+		platform_driver_unregister(&mvebu_uart_clock_platform_driver);
 		uart_unregister_driver(&mvebu_uart_driver);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 arch_initcall(mvebu_uart_init);
-- 
2.34.1

