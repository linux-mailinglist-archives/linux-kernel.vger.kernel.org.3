Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298E0493194
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350372AbiASAFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:05:50 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:44203 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350331AbiASAFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:05:41 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MmD2M-1mS9GK0WwK-00i8a4; Wed, 19
 Jan 2022 01:05:12 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v10 3/5] tty: goldfish: use goldfish_ioread32()/goldfish_iowrite32()
Date:   Wed, 19 Jan 2022 01:05:04 +0100
Message-Id: <20220119000506.1299843-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119000506.1299843-1-laurent@vivier.eu>
References: <20220119000506.1299843-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QxFaS+c7ajuC5r/o5VtShEEJM53Ltn9w6NH3CVcVs0gjmbAzNdO
 mWy8QMazzBQSuz2IpKW/cEbGDFUPUj3P0IgJPmSAyvVCT7jOTamQCRliyv6W6TOZktDE/qB
 xV5YYh7vTHwB2FsENumu/n3AIlS2Wn5f3l2Xhz41RR9z/bjXgOGOHaxXaQGNJjQc3+bNDtf
 6zSGpn6cUtlpmhZuh+aXw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8nr+kI4ncSM=:88rohAjb4IR4em7WAxth4N
 VzKkXNa9tbHibxBak1t0l9CMdmD5rhHZYDUbBp7IsJO3MmYooQ2YapyEvsUB1qi1T/sWZI9b9
 CC/NUf+bAf0KeKqkBycA6nO4/67QZU2mjHLWlNL8BiEVD/C4AQJsBdY4KWH7+ZKQXweInicBl
 Xt+KTqjLm/Jbnm+Lg1Wy3jusbryMt/kvOr8lWOtShp27DuguwDWkoex0HRYkD+9LPmw7MlcQR
 /J7OVhwaTbyAf4rg1PFn/nlF/XWi4EBJh4DeelHR/AWFVYnpuumxqyEHaE6iCrReV3X3nK8Lf
 57y3vt4tPrFr12QC7omncQpbpKPvaLezljEJDNmRf9mmgVsoTdfTkHR/QE6xE7hA4/J88Pb03
 L/w8QyuF8xdLLlFqRe2VLq/uUua9Mjsc/UinKnoH5kDjQST51QlCOF65LVl9Mo8aURG5Lpq/d
 2/mtZMndWJZ64XkxjMOuiOtHaQTjUIZssi89pElPyeLHtGUZkCkPyku1OoM+5gO3Evu221hV1
 iQFxlPXGaBYUINxHhW3CnXx+bCi+cPLBGuwOsfbpjh4OwtiqeRHS1mgEvwymLQ943So//wTLO
 QDtrN5BhC9Br/AccV8b9uvHiVej7Yki1MkW2lMlpLrYrczcrwYM48nkNHaCznANUYEVBR5s0c
 XSIZKbqCQrLbBkrpiwl+HJsDu3karsDVotUBjdZx6kp4s+ODhJnkm9PO1+qbsVTTe8hw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use architecture endianness aware accessors as done for
rtc-goldfish.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/tty/goldfish.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index d24af649a8bb..267f1f084629 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -61,13 +61,13 @@ static void do_rw_io(struct goldfish_tty *qtty,
 	spin_lock_irqsave(&qtty->lock, irq_flags);
 	gf_write_ptr((void *)address, base + GOLDFISH_TTY_REG_DATA_PTR,
 		     base + GOLDFISH_TTY_REG_DATA_PTR_HIGH);
-	__raw_writel(count, base + GOLDFISH_TTY_REG_DATA_LEN);
+	goldfish_iowrite32(count, base + GOLDFISH_TTY_REG_DATA_LEN);
 
 	if (is_write)
-		__raw_writel(GOLDFISH_TTY_CMD_WRITE_BUFFER,
+		goldfish_iowrite32(GOLDFISH_TTY_CMD_WRITE_BUFFER,
 		       base + GOLDFISH_TTY_REG_CMD);
 	else
-		__raw_writel(GOLDFISH_TTY_CMD_READ_BUFFER,
+		goldfish_iowrite32(GOLDFISH_TTY_CMD_READ_BUFFER,
 		       base + GOLDFISH_TTY_REG_CMD);
 
 	spin_unlock_irqrestore(&qtty->lock, irq_flags);
@@ -142,7 +142,7 @@ static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 	unsigned char *buf;
 	u32 count;
 
-	count = __raw_readl(base + GOLDFISH_TTY_REG_BYTES_READY);
+	count = goldfish_ioread32(base + GOLDFISH_TTY_REG_BYTES_READY);
 	if (count == 0)
 		return IRQ_NONE;
 
@@ -159,7 +159,7 @@ static int goldfish_tty_activate(struct tty_port *port, struct tty_struct *tty)
 {
 	struct goldfish_tty *qtty = container_of(port, struct goldfish_tty,
 									port);
-	__raw_writel(GOLDFISH_TTY_CMD_INT_ENABLE, qtty->base + GOLDFISH_TTY_REG_CMD);
+	goldfish_iowrite32(GOLDFISH_TTY_CMD_INT_ENABLE, qtty->base + GOLDFISH_TTY_REG_CMD);
 	return 0;
 }
 
@@ -167,7 +167,7 @@ static void goldfish_tty_shutdown(struct tty_port *port)
 {
 	struct goldfish_tty *qtty = container_of(port, struct goldfish_tty,
 									port);
-	__raw_writel(GOLDFISH_TTY_CMD_INT_DISABLE, qtty->base + GOLDFISH_TTY_REG_CMD);
+	goldfish_iowrite32(GOLDFISH_TTY_CMD_INT_DISABLE, qtty->base + GOLDFISH_TTY_REG_CMD);
 }
 
 static int goldfish_tty_open(struct tty_struct *tty, struct file *filp)
@@ -202,7 +202,7 @@ static unsigned int goldfish_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct goldfish_tty *qtty = &goldfish_ttys[tty->index];
 	void __iomem *base = qtty->base;
-	return __raw_readl(base + GOLDFISH_TTY_REG_BYTES_READY);
+	return goldfish_ioread32(base + GOLDFISH_TTY_REG_BYTES_READY);
 }
 
 static void goldfish_tty_console_write(struct console *co, const char *b,
@@ -357,7 +357,7 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 	 * on Ranchu emulator (qemu2) returns 1 here and
 	 * driver will use physical addresses.
 	 */
-	qtty->version = __raw_readl(base + GOLDFISH_TTY_REG_VERSION);
+	qtty->version = goldfish_ioread32(base + GOLDFISH_TTY_REG_VERSION);
 
 	/*
 	 * Goldfish TTY device on Ranchu emulator (qemu2)
@@ -376,7 +376,7 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 		}
 	}
 
-	__raw_writel(GOLDFISH_TTY_CMD_INT_DISABLE, base + GOLDFISH_TTY_REG_CMD);
+	goldfish_iowrite32(GOLDFISH_TTY_CMD_INT_DISABLE, base + GOLDFISH_TTY_REG_CMD);
 
 	ret = request_irq(irq, goldfish_tty_interrupt, IRQF_SHARED,
 			  "goldfish_tty", qtty);
@@ -438,7 +438,7 @@ static int goldfish_tty_remove(struct platform_device *pdev)
 #ifdef CONFIG_GOLDFISH_TTY_EARLY_CONSOLE
 static void gf_early_console_putchar(struct uart_port *port, int ch)
 {
-	__raw_writel(ch, port->membase);
+	goldfish_iowrite32(ch, port->membase);
 }
 
 static void gf_early_write(struct console *con, const char *s, unsigned int n)
-- 
2.34.1

