Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AD1494910
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359065AbiATIEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:04:38 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:33789 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358391AbiATIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:04:21 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MTAS1-1mjL0v21hH-00UbNX; Thu, 20
 Jan 2022 09:03:54 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v11 2/5] tty: goldfish: introduce gf_ioread32()/gf_iowrite32()
Date:   Thu, 20 Jan 2022 09:03:44 +0100
Message-Id: <20220120080347.1595379-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120080347.1595379-1-laurent@vivier.eu>
References: <20220120080347.1595379-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dJDSImD3kRyXEJdZ97I6Z1oPvkUw0A+R37WfUDA+HmbJZPkdRv6
 h3xLhhkYKYqikVzzyc5QQZEIWdDmgAKKUQ0UoJi4XHRwVjWCjqg4m9ypQhdGjfTA6zKZ9qr
 9SYerVo07QzqYQ0fRsnRb0rtQv4T3HZIf2zpQrVlms8AQHG3sl3vS6PgYs8YjqeN2agcch1
 3a304KWYcVg6juwIX7qYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wVMKcL8y36M=:cGtbXVXjpWs96O1RFZ1Xrp
 85st+Hag15JRWdUeOl9Xvh0ePhdMtRZRKUvMHy0FOqpqpyMey65YMZExJ3Z08L39SUx1a/Q1D
 DnHfBuwByGcQ0rXLQNEX/TvPp+h6wob7rVQ8p6ONlXHGDze0uk3Ck9UQY7aQfK3JFjCciwjN1
 9uq1m+gOZLu44ljunalK5yCAt7RB8HIHFXD2mCqeaLUv67JX2BgXW5jqGdJklALcUVD2qO1lm
 SaUAAsA8v2+jgkmH6woRfoOhKxo2PT23Kqji0g4IlMwkWc6jV+eCH+7K6dGEYMMMyoDocI564
 p114i1hzTOkXhQe+Kmc6GWkExL+ibaZHTOCM6823cxYUcL6nrLbgk6Nlb+iwkCVhX639YnCqY
 y6K6nrulCLjVYiDbFEt9XmGAODUFxbajzhhclP5TWDrB9APEeV8kEPCscHvjgAHTJ8kxVoVRZ
 MMvwes5MRsX6cg3MEFPCJzVlY7et96h1gJluzRyqeIVZi0NDd7kGs3IhnwohulvMlTvhEW//Q
 gCyECfUamJhU2TaRumpWGQC3ZI/t+Wn09o5r9/AABT8nlZvonVPTr/D5i4jQZgjxQ3n3xY89q
 OIJ1MbTD2Q1hbKVy4oA7EsGk9p10vcLpbKcKon78PhrCYFXFAnzbW1fblOSs08KNifB1PF6Ev
 KXnKTTRFP0umEc8u7C+qscoN6C7q6PlAXBQNk6ACXuyn8I5ZpfcEFtSJlpP7tFcl6EHU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert
commit da31de35cd2f ("tty: goldfish: use __raw_writel()/__raw_readl()")

to use accessors defined by the architecture.

Define by default the accessor to be little-endian as we
have only little-endian architectures using goldfish devices.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/tty/goldfish.c   | 20 ++++++++++----------
 include/linux/goldfish.h | 15 +++++++++++----
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 5ed19a9857ad..10c13b93ed52 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -61,13 +61,13 @@ static void do_rw_io(struct goldfish_tty *qtty,
 	spin_lock_irqsave(&qtty->lock, irq_flags);
 	gf_write_ptr((void *)address, base + GOLDFISH_TTY_REG_DATA_PTR,
 		     base + GOLDFISH_TTY_REG_DATA_PTR_HIGH);
-	__raw_writel(count, base + GOLDFISH_TTY_REG_DATA_LEN);
+	gf_iowrite32(count, base + GOLDFISH_TTY_REG_DATA_LEN);
 
 	if (is_write)
-		__raw_writel(GOLDFISH_TTY_CMD_WRITE_BUFFER,
+		gf_iowrite32(GOLDFISH_TTY_CMD_WRITE_BUFFER,
 		       base + GOLDFISH_TTY_REG_CMD);
 	else
-		__raw_writel(GOLDFISH_TTY_CMD_READ_BUFFER,
+		gf_iowrite32(GOLDFISH_TTY_CMD_READ_BUFFER,
 		       base + GOLDFISH_TTY_REG_CMD);
 
 	spin_unlock_irqrestore(&qtty->lock, irq_flags);
@@ -142,7 +142,7 @@ static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 	unsigned char *buf;
 	u32 count;
 
-	count = __raw_readl(base + GOLDFISH_TTY_REG_BYTES_READY);
+	count = gf_ioread32(base + GOLDFISH_TTY_REG_BYTES_READY);
 	if (count == 0)
 		return IRQ_NONE;
 
@@ -159,7 +159,7 @@ static int goldfish_tty_activate(struct tty_port *port, struct tty_struct *tty)
 {
 	struct goldfish_tty *qtty = container_of(port, struct goldfish_tty,
 									port);
-	__raw_writel(GOLDFISH_TTY_CMD_INT_ENABLE, qtty->base + GOLDFISH_TTY_REG_CMD);
+	gf_iowrite32(GOLDFISH_TTY_CMD_INT_ENABLE, qtty->base + GOLDFISH_TTY_REG_CMD);
 	return 0;
 }
 
@@ -167,7 +167,7 @@ static void goldfish_tty_shutdown(struct tty_port *port)
 {
 	struct goldfish_tty *qtty = container_of(port, struct goldfish_tty,
 									port);
-	__raw_writel(GOLDFISH_TTY_CMD_INT_DISABLE, qtty->base + GOLDFISH_TTY_REG_CMD);
+	gf_iowrite32(GOLDFISH_TTY_CMD_INT_DISABLE, qtty->base + GOLDFISH_TTY_REG_CMD);
 }
 
 static int goldfish_tty_open(struct tty_struct *tty, struct file *filp)
@@ -202,7 +202,7 @@ static unsigned int goldfish_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct goldfish_tty *qtty = &goldfish_ttys[tty->index];
 	void __iomem *base = qtty->base;
-	return __raw_readl(base + GOLDFISH_TTY_REG_BYTES_READY);
+	return gf_ioread32(base + GOLDFISH_TTY_REG_BYTES_READY);
 }
 
 static void goldfish_tty_console_write(struct console *co, const char *b,
@@ -355,7 +355,7 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 	 * on Ranchu emulator (qemu2) returns 1 here and
 	 * driver will use physical addresses.
 	 */
-	qtty->version = __raw_readl(base + GOLDFISH_TTY_REG_VERSION);
+	qtty->version = gf_ioread32(base + GOLDFISH_TTY_REG_VERSION);
 
 	/*
 	 * Goldfish TTY device on Ranchu emulator (qemu2)
@@ -374,7 +374,7 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 		}
 	}
 
-	__raw_writel(GOLDFISH_TTY_CMD_INT_DISABLE, base + GOLDFISH_TTY_REG_CMD);
+	gf_iowrite32(GOLDFISH_TTY_CMD_INT_DISABLE, base + GOLDFISH_TTY_REG_CMD);
 
 	ret = request_irq(irq, goldfish_tty_interrupt, IRQF_SHARED,
 			  "goldfish_tty", qtty);
@@ -436,7 +436,7 @@ static int goldfish_tty_remove(struct platform_device *pdev)
 #ifdef CONFIG_GOLDFISH_TTY_EARLY_CONSOLE
 static void gf_early_console_putchar(struct uart_port *port, int ch)
 {
-	__raw_writel(ch, port->membase);
+	gf_iowrite32(ch, port->membase);
 }
 
 static void gf_early_write(struct console *con, const char *s, unsigned int n)
diff --git a/include/linux/goldfish.h b/include/linux/goldfish.h
index 12be1601fd84..bcc17f95b906 100644
--- a/include/linux/goldfish.h
+++ b/include/linux/goldfish.h
@@ -8,14 +8,21 @@
 
 /* Helpers for Goldfish virtual platform */
 
+#ifndef gf_ioread32
+#define gf_ioread32 ioread32
+#endif
+#ifndef gf_iowrite32
+#define gf_iowrite32 iowrite32
+#endif
+
 static inline void gf_write_ptr(const void *ptr, void __iomem *portl,
 				void __iomem *porth)
 {
 	const unsigned long addr = (unsigned long)ptr;
 
-	__raw_writel(lower_32_bits(addr), portl);
+	gf_iowrite32(lower_32_bits(addr), portl);
 #ifdef CONFIG_64BIT
-	__raw_writel(upper_32_bits(addr), porth);
+	gf_iowrite32(upper_32_bits(addr), porth);
 #endif
 }
 
@@ -23,9 +30,9 @@ static inline void gf_write_dma_addr(const dma_addr_t addr,
 				     void __iomem *portl,
 				     void __iomem *porth)
 {
-	__raw_writel(lower_32_bits(addr), portl);
+	gf_iowrite32(lower_32_bits(addr), portl);
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	__raw_writel(upper_32_bits(addr), porth);
+	gf_iowrite32(upper_32_bits(addr), porth);
 #endif
 }
 
-- 
2.34.1

