Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E994557634D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiGOOAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbiGOOAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:00:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA0B2610D;
        Fri, 15 Jul 2022 06:59:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 55F301FEBE;
        Fri, 15 Jul 2022 13:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657893592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ouhp+tjv2/sy7UFf5OPOV5rQgBpgb1NEHhyNPPI2fiQ=;
        b=PHXlBntZkbL1DLz8vzbafVTfv8yExQlz75mvaYrNY6Nh6yjNhM3bqoXFuoRfO+26o3neG7
        Kb31kWHAM70sYfxcL3XwuedlPiffm3gw3+jXRU0jo8vu4vlW9Mi/bRXxqNGNq7ElIPkaFw
        8d3R6zwinFt0b+EYXWGs73b9RVOsEys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657893592;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ouhp+tjv2/sy7UFf5OPOV5rQgBpgb1NEHhyNPPI2fiQ=;
        b=7tfIfAKK+3o+Wd4jb4LJK9nLhU1rz/+JtgyoVOnK9TBoqLJCjbdzZAc7lDQR1zX4h2enIl
        75M5e/TEI0HMRJDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 255A32C141;
        Fri, 15 Jul 2022 13:59:52 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] gpio: remove VR41XX related gpio driver
Date:   Fri, 15 Jul 2022 15:59:44 +0200
Message-Id: <20220715135945.135351-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Commit d3164e2f3b0a ("MIPS: Remove VR41xx support") removed support
for MIPS VR41xx platform, so remove exclusive drivers for this
platform, too.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/char/Kconfig       |   5 -
 drivers/char/Makefile      |   1 -
 drivers/char/tb0219.c      | 358 ------------------------
 drivers/gpio/Kconfig       |   6 -
 drivers/gpio/Makefile      |   1 -
 drivers/gpio/gpio-vr41xx.c | 541 -------------------------------------
 6 files changed, 912 deletions(-)
 delete mode 100644 drivers/char/tb0219.c
 delete mode 100644 drivers/gpio/gpio-vr41xx.c

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 30192e123e5f..0f378d29dab0 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -247,11 +247,6 @@ config SONYPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called sonypi.
 
-config GPIO_TB0219
-	tristate "TANBAC TB0219 GPIO support"
-	depends on TANBAC_TB022X
-	select GPIO_VR41XX
-
 source "drivers/char/pcmcia/Kconfig"
 
 config MWAVE
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 264eb398fdd4..1b35d1724565 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -31,7 +31,6 @@ obj-$(CONFIG_NWFLASH)		+= nwflash.o
 obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o
 obj-$(CONFIG_PC8736x_GPIO)	+= pc8736x_gpio.o
 obj-$(CONFIG_NSC_GPIO)		+= nsc_gpio.o
-obj-$(CONFIG_GPIO_TB0219)	+= tb0219.o
 obj-$(CONFIG_TELCLOCK)		+= tlclk.o
 
 obj-$(CONFIG_MWAVE)		+= mwave/
diff --git a/drivers/char/tb0219.c b/drivers/char/tb0219.c
deleted file mode 100644
index 13c20b6594c3..000000000000
--- a/drivers/char/tb0219.c
+++ /dev/null
@@ -1,358 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  Driver for TANBAC TB0219 base board.
- *
- *  Copyright (C) 2005  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/platform_device.h>
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/uaccess.h>
-
-#include <asm/io.h>
-#include <asm/reboot.h>
-#include <asm/vr41xx/giu.h>
-#include <asm/vr41xx/tb0219.h>
-
-MODULE_AUTHOR("Yoichi Yuasa <yuasa@linux-mips.org>");
-MODULE_DESCRIPTION("TANBAC TB0219 base board driver");
-MODULE_LICENSE("GPL");
-
-static int major;	/* default is dynamic major device number */
-module_param(major, int, 0);
-MODULE_PARM_DESC(major, "Major device number");
-
-static void (*old_machine_restart)(char *command);
-static void __iomem *tb0219_base;
-static DEFINE_SPINLOCK(tb0219_lock);
-
-#define tb0219_read(offset)		readw(tb0219_base + (offset))
-#define tb0219_write(offset, value)	writew((value), tb0219_base + (offset))
-
-#define TB0219_START	0x0a000000UL
-#define TB0219_SIZE	0x20UL
-
-#define TB0219_LED			0x00
-#define TB0219_GPIO_INPUT		0x02
-#define TB0219_GPIO_OUTPUT		0x04
-#define TB0219_DIP_SWITCH		0x06
-#define TB0219_MISC			0x08
-#define TB0219_RESET			0x0e
-#define TB0219_PCI_SLOT1_IRQ_STATUS	0x10
-#define TB0219_PCI_SLOT2_IRQ_STATUS	0x12
-#define TB0219_PCI_SLOT3_IRQ_STATUS	0x14
-
-typedef enum {
-	TYPE_LED,
-	TYPE_GPIO_OUTPUT,
-} tb0219_type_t;
-
-/*
- * Minor device number
- *	 0 = 7 segment LED
- *
- *	16 = GPIO IN 0
- *	17 = GPIO IN 1
- *	18 = GPIO IN 2
- *	19 = GPIO IN 3
- *	20 = GPIO IN 4
- *	21 = GPIO IN 5
- *	22 = GPIO IN 6
- *	23 = GPIO IN 7
- *
- *	32 = GPIO OUT 0
- *	33 = GPIO OUT 1
- *	34 = GPIO OUT 2
- *	35 = GPIO OUT 3
- *	36 = GPIO OUT 4
- *	37 = GPIO OUT 5
- *	38 = GPIO OUT 6
- *	39 = GPIO OUT 7
- *
- *	48 = DIP switch 1
- *	49 = DIP switch 2
- *	50 = DIP switch 3
- *	51 = DIP switch 4
- *	52 = DIP switch 5
- *	53 = DIP switch 6
- *	54 = DIP switch 7
- *	55 = DIP switch 8
- */
-
-static inline char get_led(void)
-{
-	return (char)tb0219_read(TB0219_LED);
-}
-
-static inline char get_gpio_input_pin(unsigned int pin)
-{
-	uint16_t values;
-
-	values = tb0219_read(TB0219_GPIO_INPUT);
-	if (values & (1 << pin))
-		return '1';
-
-	return '0';
-}
-
-static inline char get_gpio_output_pin(unsigned int pin)
-{
-	uint16_t values;
-
-	values = tb0219_read(TB0219_GPIO_OUTPUT);
-	if (values & (1 << pin))
-		return '1';
-
-	return '0';
-}
-
-static inline char get_dip_switch(unsigned int pin)
-{
-	uint16_t values;
-
-	values = tb0219_read(TB0219_DIP_SWITCH);
-	if (values & (1 << pin))
-		return '1';
-
-	return '0';
-}
-
-static inline int set_led(char command)
-{
-	tb0219_write(TB0219_LED, command);
-
-	return 0;
-}
-
-static inline int set_gpio_output_pin(unsigned int pin, char command)
-{
-	unsigned long flags;
-	uint16_t value;
-
-	if (command != '0' && command != '1')
-		return -EINVAL;
-
-	spin_lock_irqsave(&tb0219_lock, flags);
-	value = tb0219_read(TB0219_GPIO_OUTPUT);
-	if (command == '0')
-		value &= ~(1 << pin);
-	else
-		value |= 1 << pin;
-	tb0219_write(TB0219_GPIO_OUTPUT, value);
-	spin_unlock_irqrestore(&tb0219_lock, flags);
-
-	return 0;
-
-}
-
-static ssize_t tanbac_tb0219_read(struct file *file, char __user *buf, size_t len,
-                                  loff_t *ppos)
-{
-	unsigned int minor;
-	char value;
-
-	minor = iminor(file_inode(file));
-	switch (minor) {
-	case 0:
-		value = get_led();
-		break;
-	case 16 ... 23:
-		value = get_gpio_input_pin(minor - 16);
-		break;
-	case 32 ... 39:
-		value = get_gpio_output_pin(minor - 32);
-		break;
-	case 48 ... 55:
-		value = get_dip_switch(minor - 48);
-		break;
-	default:
-		return -EBADF;
-	}
-
-	if (len <= 0)
-		return -EFAULT;
-
-	if (put_user(value, buf))
-		return -EFAULT;
-
-	return 1;
-}
-
-static ssize_t tanbac_tb0219_write(struct file *file, const char __user *data,
-                                   size_t len, loff_t *ppos)
-{
-	unsigned int minor;
-	tb0219_type_t type;
-	size_t i;
-	int retval = 0;
-	char c;
-
-	minor = iminor(file_inode(file));
-	switch (minor) {
-	case 0:
-		type = TYPE_LED;
-		break;
-	case 32 ... 39:
-		type = TYPE_GPIO_OUTPUT;
-		break;
-	default:
-		return -EBADF;
-	}
-
-	for (i = 0; i < len; i++) {
-		if (get_user(c, data + i))
-			return -EFAULT;
-
-		switch (type) {
-		case TYPE_LED:
-			retval = set_led(c);
-			break;
-		case TYPE_GPIO_OUTPUT:
-			retval = set_gpio_output_pin(minor - 32, c);
-			break;
-		}
-
-		if (retval < 0)
-			break;
-	}
-
-	return i;
-}
-
-static int tanbac_tb0219_open(struct inode *inode, struct file *file)
-{
-	unsigned int minor;
-
-	minor = iminor(inode);
-	switch (minor) {
-	case 0:
-	case 16 ... 23:
-	case 32 ... 39:
-	case 48 ... 55:
-		return stream_open(inode, file);
-	default:
-		break;
-	}
-
-	return -EBADF;
-}
-
-static int tanbac_tb0219_release(struct inode *inode, struct file *file)
-{
-	return 0;
-}
-
-static const struct file_operations tb0219_fops = {
-	.owner		= THIS_MODULE,
-	.read		= tanbac_tb0219_read,
-	.write		= tanbac_tb0219_write,
-	.open		= tanbac_tb0219_open,
-	.release	= tanbac_tb0219_release,
-};
-
-static void tb0219_restart(char *command)
-{
-	tb0219_write(TB0219_RESET, 0);
-}
-
-static void tb0219_pci_irq_init(void)
-{
-	/* PCI Slot 1 */
-	vr41xx_set_irq_trigger(TB0219_PCI_SLOT1_PIN, IRQ_TRIGGER_LEVEL, IRQ_SIGNAL_THROUGH);
-	vr41xx_set_irq_level(TB0219_PCI_SLOT1_PIN, IRQ_LEVEL_LOW);
-
-	/* PCI Slot 2 */
-	vr41xx_set_irq_trigger(TB0219_PCI_SLOT2_PIN, IRQ_TRIGGER_LEVEL, IRQ_SIGNAL_THROUGH);
-	vr41xx_set_irq_level(TB0219_PCI_SLOT2_PIN, IRQ_LEVEL_LOW);
-
-	/* PCI Slot 3 */
-	vr41xx_set_irq_trigger(TB0219_PCI_SLOT3_PIN, IRQ_TRIGGER_LEVEL, IRQ_SIGNAL_THROUGH);
-	vr41xx_set_irq_level(TB0219_PCI_SLOT3_PIN, IRQ_LEVEL_LOW);
-}
-
-static int tb0219_probe(struct platform_device *dev)
-{
-	int retval;
-
-	if (request_mem_region(TB0219_START, TB0219_SIZE, "TB0219") == NULL)
-		return -EBUSY;
-
-	tb0219_base = ioremap(TB0219_START, TB0219_SIZE);
-	if (tb0219_base == NULL) {
-		release_mem_region(TB0219_START, TB0219_SIZE);
-		return -ENOMEM;
-	}
-
-	retval = register_chrdev(major, "TB0219", &tb0219_fops);
-	if (retval < 0) {
-		iounmap(tb0219_base);
-		tb0219_base = NULL;
-		release_mem_region(TB0219_START, TB0219_SIZE);
-		return retval;
-	}
-
-	old_machine_restart = _machine_restart;
-	_machine_restart = tb0219_restart;
-
-	tb0219_pci_irq_init();
-
-	if (major == 0) {
-		major = retval;
-		printk(KERN_INFO "TB0219: major number %d\n", major);
-	}
-
-	return 0;
-}
-
-static int tb0219_remove(struct platform_device *dev)
-{
-	_machine_restart = old_machine_restart;
-
-	iounmap(tb0219_base);
-	tb0219_base = NULL;
-
-	release_mem_region(TB0219_START, TB0219_SIZE);
-
-	return 0;
-}
-
-static struct platform_device *tb0219_platform_device;
-
-static struct platform_driver tb0219_device_driver = {
-	.probe		= tb0219_probe,
-	.remove		= tb0219_remove,
-	.driver		= {
-		.name	= "TB0219",
-	},
-};
-
-static int __init tanbac_tb0219_init(void)
-{
-	int retval;
-
-	tb0219_platform_device = platform_device_alloc("TB0219", -1);
-	if (!tb0219_platform_device)
-		return -ENOMEM;
-
-	retval = platform_device_add(tb0219_platform_device);
-	if (retval < 0) {
-		platform_device_put(tb0219_platform_device);
-		return retval;
-	}
-
-	retval = platform_driver_register(&tb0219_device_driver);
-	if (retval < 0)
-		platform_device_unregister(tb0219_platform_device);
-
-	return retval;
-}
-
-static void __exit tanbac_tb0219_exit(void)
-{
-	platform_driver_unregister(&tb0219_device_driver);
-	platform_device_unregister(tb0219_platform_device);
-}
-
-module_init(tanbac_tb0219_init);
-module_exit(tanbac_tb0219_exit);
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 51b36c417704..4015f22365f7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -699,12 +699,6 @@ config GPIO_VISCONTI
 	help
 	  Say yes here to support GPIO on Tohisba Visconti.
 
-config GPIO_VR41XX
-	tristate "NEC VR4100 series General-purpose I/O Unit support"
-	depends on CPU_VR41XX
-	help
-	  Say yes here to support the NEC VR4100 series General-purpose I/O Unit.
-
 config GPIO_VX855
 	tristate "VIA VX855/VX875 GPIO"
 	depends on (X86 || COMPILE_TEST) && PCI
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 30141fec12be..795e82af7d27 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -170,7 +170,6 @@ obj-$(CONFIG_GPIO_VF610)		+= gpio-vf610.o
 obj-$(CONFIG_GPIO_VIPERBOARD)		+= gpio-viperboard.o
 obj-$(CONFIG_GPIO_VIRTIO)		+= gpio-virtio.o
 obj-$(CONFIG_GPIO_VISCONTI)		+= gpio-visconti.o
-obj-$(CONFIG_GPIO_VR41XX)		+= gpio-vr41xx.o
 obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
 obj-$(CONFIG_GPIO_WCD934X)		+= gpio-wcd934x.o
 obj-$(CONFIG_GPIO_WHISKEY_COVE)		+= gpio-wcove.o
diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
deleted file mode 100644
index 8d09b619c166..000000000000
--- a/drivers/gpio/gpio-vr41xx.c
+++ /dev/null
@@ -1,541 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- *  Driver for NEC VR4100 series General-purpose I/O Unit.
- *
- *  Copyright (C) 2002 MontaVista Software Inc.
- *	Author: Yoichi Yuasa <source@mvista.com>
- *  Copyright (C) 2003-2009  Yoichi Yuasa <yuasa@linux-mips.org>
- */
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/gpio/driver.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
-
-#include <asm/vr41xx/giu.h>
-#include <asm/vr41xx/irq.h>
-#include <asm/vr41xx/vr41xx.h>
-
-MODULE_AUTHOR("Yoichi Yuasa <yuasa@linux-mips.org>");
-MODULE_DESCRIPTION("NEC VR4100 series General-purpose I/O Unit driver");
-MODULE_LICENSE("GPL");
-
-#define GIUIOSELL	0x00
-#define GIUIOSELH	0x02
-#define GIUPIODL	0x04
-#define GIUPIODH	0x06
-#define GIUINTSTATL	0x08
-#define GIUINTSTATH	0x0a
-#define GIUINTENL	0x0c
-#define GIUINTENH	0x0e
-#define GIUINTTYPL	0x10
-#define GIUINTTYPH	0x12
-#define GIUINTALSELL	0x14
-#define GIUINTALSELH	0x16
-#define GIUINTHTSELL	0x18
-#define GIUINTHTSELH	0x1a
-#define GIUPODATL	0x1c
-#define GIUPODATEN	0x1c
-#define GIUPODATH	0x1e
- #define PIOEN0		0x0100
- #define PIOEN1		0x0200
-#define GIUPODAT	0x1e
-#define GIUFEDGEINHL	0x20
-#define GIUFEDGEINHH	0x22
-#define GIUREDGEINHL	0x24
-#define GIUREDGEINHH	0x26
-
-#define GIUUSEUPDN	0x1e0
-#define GIUTERMUPDN	0x1e2
-
-#define GPIO_HAS_PULLUPDOWN_IO		0x0001
-#define GPIO_HAS_OUTPUT_ENABLE		0x0002
-#define GPIO_HAS_INTERRUPT_EDGE_SELECT	0x0100
-
-enum {
-	GPIO_INPUT,
-	GPIO_OUTPUT,
-};
-
-static DEFINE_SPINLOCK(giu_lock);
-static unsigned long giu_flags;
-
-static void __iomem *giu_base;
-static struct gpio_chip vr41xx_gpio_chip;
-
-#define giu_read(offset)		readw(giu_base + (offset))
-#define giu_write(offset, value)	writew((value), giu_base + (offset))
-
-#define GPIO_PIN_OF_IRQ(irq)	((irq) - GIU_IRQ_BASE)
-#define GIUINT_HIGH_OFFSET	16
-#define GIUINT_HIGH_MAX		32
-
-static inline u16 giu_set(u16 offset, u16 set)
-{
-	u16 data;
-
-	data = giu_read(offset);
-	data |= set;
-	giu_write(offset, data);
-
-	return data;
-}
-
-static inline u16 giu_clear(u16 offset, u16 clear)
-{
-	u16 data;
-
-	data = giu_read(offset);
-	data &= ~clear;
-	giu_write(offset, data);
-
-	return data;
-}
-
-static void ack_giuint_low(struct irq_data *d)
-{
-	giu_write(GIUINTSTATL, 1 << GPIO_PIN_OF_IRQ(d->irq));
-}
-
-static void mask_giuint_low(struct irq_data *d)
-{
-	giu_clear(GIUINTENL, 1 << GPIO_PIN_OF_IRQ(d->irq));
-}
-
-static void mask_ack_giuint_low(struct irq_data *d)
-{
-	unsigned int pin;
-
-	pin = GPIO_PIN_OF_IRQ(d->irq);
-	giu_clear(GIUINTENL, 1 << pin);
-	giu_write(GIUINTSTATL, 1 << pin);
-}
-
-static void unmask_giuint_low(struct irq_data *d)
-{
-	giu_set(GIUINTENL, 1 << GPIO_PIN_OF_IRQ(d->irq));
-}
-
-static unsigned int startup_giuint(struct irq_data *data)
-{
-	int ret;
-
-	ret = gpiochip_lock_as_irq(&vr41xx_gpio_chip, irqd_to_hwirq(data));
-	if (ret) {
-		dev_err(vr41xx_gpio_chip.parent,
-			"unable to lock HW IRQ %lu for IRQ\n",
-			data->hwirq);
-		return ret;
-	}
-
-	/* Satisfy the .enable semantics by unmasking the line */
-	unmask_giuint_low(data);
-	return 0;
-}
-
-static void shutdown_giuint(struct irq_data *data)
-{
-	mask_giuint_low(data);
-	gpiochip_unlock_as_irq(&vr41xx_gpio_chip, data->hwirq);
-}
-
-static struct irq_chip giuint_low_irq_chip = {
-	.name		= "GIUINTL",
-	.irq_ack	= ack_giuint_low,
-	.irq_mask	= mask_giuint_low,
-	.irq_mask_ack	= mask_ack_giuint_low,
-	.irq_unmask	= unmask_giuint_low,
-	.irq_startup	= startup_giuint,
-	.irq_shutdown	= shutdown_giuint,
-};
-
-static void ack_giuint_high(struct irq_data *d)
-{
-	giu_write(GIUINTSTATH,
-		  1 << (GPIO_PIN_OF_IRQ(d->irq) - GIUINT_HIGH_OFFSET));
-}
-
-static void mask_giuint_high(struct irq_data *d)
-{
-	giu_clear(GIUINTENH, 1 << (GPIO_PIN_OF_IRQ(d->irq) - GIUINT_HIGH_OFFSET));
-}
-
-static void mask_ack_giuint_high(struct irq_data *d)
-{
-	unsigned int pin;
-
-	pin = GPIO_PIN_OF_IRQ(d->irq) - GIUINT_HIGH_OFFSET;
-	giu_clear(GIUINTENH, 1 << pin);
-	giu_write(GIUINTSTATH, 1 << pin);
-}
-
-static void unmask_giuint_high(struct irq_data *d)
-{
-	giu_set(GIUINTENH, 1 << (GPIO_PIN_OF_IRQ(d->irq) - GIUINT_HIGH_OFFSET));
-}
-
-static struct irq_chip giuint_high_irq_chip = {
-	.name		= "GIUINTH",
-	.irq_ack	= ack_giuint_high,
-	.irq_mask	= mask_giuint_high,
-	.irq_mask_ack	= mask_ack_giuint_high,
-	.irq_unmask	= unmask_giuint_high,
-};
-
-static int giu_get_irq(unsigned int irq)
-{
-	u16 pendl, pendh, maskl, maskh;
-	int i;
-
-	pendl = giu_read(GIUINTSTATL);
-	pendh = giu_read(GIUINTSTATH);
-	maskl = giu_read(GIUINTENL);
-	maskh = giu_read(GIUINTENH);
-
-	maskl &= pendl;
-	maskh &= pendh;
-
-	if (maskl) {
-		for (i = 0; i < 16; i++) {
-			if (maskl & (1 << i))
-				return GIU_IRQ(i);
-		}
-	} else if (maskh) {
-		for (i = 0; i < 16; i++) {
-			if (maskh & (1 << i))
-				return GIU_IRQ(i + GIUINT_HIGH_OFFSET);
-		}
-	}
-
-	printk(KERN_ERR "spurious GIU interrupt: %04x(%04x),%04x(%04x)\n",
-	       maskl, pendl, maskh, pendh);
-
-	return -EINVAL;
-}
-
-void vr41xx_set_irq_trigger(unsigned int pin, irq_trigger_t trigger,
-			    irq_signal_t signal)
-{
-	u16 mask;
-
-	if (pin < GIUINT_HIGH_OFFSET) {
-		mask = 1 << pin;
-		if (trigger != IRQ_TRIGGER_LEVEL) {
-			giu_set(GIUINTTYPL, mask);
-			if (signal == IRQ_SIGNAL_HOLD)
-				giu_set(GIUINTHTSELL, mask);
-			else
-				giu_clear(GIUINTHTSELL, mask);
-			if (giu_flags & GPIO_HAS_INTERRUPT_EDGE_SELECT) {
-				switch (trigger) {
-				case IRQ_TRIGGER_EDGE_FALLING:
-					giu_set(GIUFEDGEINHL, mask);
-					giu_clear(GIUREDGEINHL, mask);
-					break;
-				case IRQ_TRIGGER_EDGE_RISING:
-					giu_clear(GIUFEDGEINHL, mask);
-					giu_set(GIUREDGEINHL, mask);
-					break;
-				default:
-					giu_set(GIUFEDGEINHL, mask);
-					giu_set(GIUREDGEINHL, mask);
-					break;
-				}
-			}
-			irq_set_chip_and_handler(GIU_IRQ(pin),
-						 &giuint_low_irq_chip,
-						 handle_edge_irq);
-		} else {
-			giu_clear(GIUINTTYPL, mask);
-			giu_clear(GIUINTHTSELL, mask);
-			irq_set_chip_and_handler(GIU_IRQ(pin),
-						 &giuint_low_irq_chip,
-						 handle_level_irq);
-		}
-		giu_write(GIUINTSTATL, mask);
-	} else if (pin < GIUINT_HIGH_MAX) {
-		mask = 1 << (pin - GIUINT_HIGH_OFFSET);
-		if (trigger != IRQ_TRIGGER_LEVEL) {
-			giu_set(GIUINTTYPH, mask);
-			if (signal == IRQ_SIGNAL_HOLD)
-				giu_set(GIUINTHTSELH, mask);
-			else
-				giu_clear(GIUINTHTSELH, mask);
-			if (giu_flags & GPIO_HAS_INTERRUPT_EDGE_SELECT) {
-				switch (trigger) {
-				case IRQ_TRIGGER_EDGE_FALLING:
-					giu_set(GIUFEDGEINHH, mask);
-					giu_clear(GIUREDGEINHH, mask);
-					break;
-				case IRQ_TRIGGER_EDGE_RISING:
-					giu_clear(GIUFEDGEINHH, mask);
-					giu_set(GIUREDGEINHH, mask);
-					break;
-				default:
-					giu_set(GIUFEDGEINHH, mask);
-					giu_set(GIUREDGEINHH, mask);
-					break;
-				}
-			}
-			irq_set_chip_and_handler(GIU_IRQ(pin),
-						 &giuint_high_irq_chip,
-						 handle_edge_irq);
-		} else {
-			giu_clear(GIUINTTYPH, mask);
-			giu_clear(GIUINTHTSELH, mask);
-			irq_set_chip_and_handler(GIU_IRQ(pin),
-						 &giuint_high_irq_chip,
-						 handle_level_irq);
-		}
-		giu_write(GIUINTSTATH, mask);
-	}
-}
-EXPORT_SYMBOL_GPL(vr41xx_set_irq_trigger);
-
-void vr41xx_set_irq_level(unsigned int pin, irq_level_t level)
-{
-	u16 mask;
-
-	if (pin < GIUINT_HIGH_OFFSET) {
-		mask = 1 << pin;
-		if (level == IRQ_LEVEL_HIGH)
-			giu_set(GIUINTALSELL, mask);
-		else
-			giu_clear(GIUINTALSELL, mask);
-		giu_write(GIUINTSTATL, mask);
-	} else if (pin < GIUINT_HIGH_MAX) {
-		mask = 1 << (pin - GIUINT_HIGH_OFFSET);
-		if (level == IRQ_LEVEL_HIGH)
-			giu_set(GIUINTALSELH, mask);
-		else
-			giu_clear(GIUINTALSELH, mask);
-		giu_write(GIUINTSTATH, mask);
-	}
-}
-EXPORT_SYMBOL_GPL(vr41xx_set_irq_level);
-
-static int giu_set_direction(struct gpio_chip *chip, unsigned pin, int dir)
-{
-	u16 offset, mask, reg;
-	unsigned long flags;
-
-	if (pin >= chip->ngpio)
-		return -EINVAL;
-
-	if (pin < 16) {
-		offset = GIUIOSELL;
-		mask = 1 << pin;
-	} else if (pin < 32) {
-		offset = GIUIOSELH;
-		mask = 1 << (pin - 16);
-	} else {
-		if (giu_flags & GPIO_HAS_OUTPUT_ENABLE) {
-			offset = GIUPODATEN;
-			mask = 1 << (pin - 32);
-		} else {
-			switch (pin) {
-			case 48:
-				offset = GIUPODATH;
-				mask = PIOEN0;
-				break;
-			case 49:
-				offset = GIUPODATH;
-				mask = PIOEN1;
-				break;
-			default:
-				return -EINVAL;
-			}
-		}
-	}
-
-	spin_lock_irqsave(&giu_lock, flags);
-
-	reg = giu_read(offset);
-	if (dir == GPIO_OUTPUT)
-		reg |= mask;
-	else
-		reg &= ~mask;
-	giu_write(offset, reg);
-
-	spin_unlock_irqrestore(&giu_lock, flags);
-
-	return 0;
-}
-
-static int vr41xx_gpio_get(struct gpio_chip *chip, unsigned pin)
-{
-	u16 reg, mask;
-
-	if (pin >= chip->ngpio)
-		return -EINVAL;
-
-	if (pin < 16) {
-		reg = giu_read(GIUPIODL);
-		mask = 1 << pin;
-	} else if (pin < 32) {
-		reg = giu_read(GIUPIODH);
-		mask = 1 << (pin - 16);
-	} else if (pin < 48) {
-		reg = giu_read(GIUPODATL);
-		mask = 1 << (pin - 32);
-	} else {
-		reg = giu_read(GIUPODATH);
-		mask = 1 << (pin - 48);
-	}
-
-	if (reg & mask)
-		return 1;
-
-	return 0;
-}
-
-static void vr41xx_gpio_set(struct gpio_chip *chip, unsigned pin,
-			    int value)
-{
-	u16 offset, mask, reg;
-	unsigned long flags;
-
-	if (pin >= chip->ngpio)
-		return;
-
-	if (pin < 16) {
-		offset = GIUPIODL;
-		mask = 1 << pin;
-	} else if (pin < 32) {
-		offset = GIUPIODH;
-		mask = 1 << (pin - 16);
-	} else if (pin < 48) {
-		offset = GIUPODATL;
-		mask = 1 << (pin - 32);
-	} else {
-		offset = GIUPODATH;
-		mask = 1 << (pin - 48);
-	}
-
-	spin_lock_irqsave(&giu_lock, flags);
-
-	reg = giu_read(offset);
-	if (value)
-		reg |= mask;
-	else
-		reg &= ~mask;
-	giu_write(offset, reg);
-
-	spin_unlock_irqrestore(&giu_lock, flags);
-}
-
-
-static int vr41xx_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	return giu_set_direction(chip, offset, GPIO_INPUT);
-}
-
-static int vr41xx_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
-				int value)
-{
-	vr41xx_gpio_set(chip, offset, value);
-
-	return giu_set_direction(chip, offset, GPIO_OUTPUT);
-}
-
-static int vr41xx_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
-{
-	if (offset >= chip->ngpio)
-		return -EINVAL;
-
-	return GIU_IRQ_BASE + offset;
-}
-
-static struct gpio_chip vr41xx_gpio_chip = {
-	.label			= "vr41xx",
-	.owner			= THIS_MODULE,
-	.direction_input	= vr41xx_gpio_direction_input,
-	.get			= vr41xx_gpio_get,
-	.direction_output	= vr41xx_gpio_direction_output,
-	.set			= vr41xx_gpio_set,
-	.to_irq			= vr41xx_gpio_to_irq,
-};
-
-static int giu_probe(struct platform_device *pdev)
-{
-	unsigned int trigger, i, pin;
-	struct irq_chip *chip;
-	int irq;
-
-	switch (pdev->id) {
-	case GPIO_50PINS_PULLUPDOWN:
-		giu_flags = GPIO_HAS_PULLUPDOWN_IO;
-		vr41xx_gpio_chip.ngpio = 50;
-		break;
-	case GPIO_36PINS:
-		vr41xx_gpio_chip.ngpio = 36;
-		break;
-	case GPIO_48PINS_EDGE_SELECT:
-		giu_flags = GPIO_HAS_INTERRUPT_EDGE_SELECT;
-		vr41xx_gpio_chip.ngpio = 48;
-		break;
-	default:
-		dev_err(&pdev->dev, "GIU: unknown ID %d\n", pdev->id);
-		return -ENODEV;
-	}
-
-	giu_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(giu_base))
-		return PTR_ERR(giu_base);
-
-	vr41xx_gpio_chip.parent = &pdev->dev;
-
-	if (gpiochip_add_data(&vr41xx_gpio_chip, NULL))
-		return -ENODEV;
-
-	giu_write(GIUINTENL, 0);
-	giu_write(GIUINTENH, 0);
-
-	trigger = giu_read(GIUINTTYPH) << 16;
-	trigger |= giu_read(GIUINTTYPL);
-	for (i = GIU_IRQ_BASE; i <= GIU_IRQ_LAST; i++) {
-		pin = GPIO_PIN_OF_IRQ(i);
-		if (pin < GIUINT_HIGH_OFFSET)
-			chip = &giuint_low_irq_chip;
-		else
-			chip = &giuint_high_irq_chip;
-
-		if (trigger & (1 << pin))
-			irq_set_chip_and_handler(i, chip, handle_edge_irq);
-		else
-			irq_set_chip_and_handler(i, chip, handle_level_irq);
-
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0 || irq >= nr_irqs)
-		return -EBUSY;
-
-	return cascade_irq(irq, giu_get_irq);
-}
-
-static int giu_remove(struct platform_device *pdev)
-{
-	if (giu_base) {
-		giu_base = NULL;
-	}
-
-	return 0;
-}
-
-static struct platform_driver giu_device_driver = {
-	.probe		= giu_probe,
-	.remove		= giu_remove,
-	.driver		= {
-		.name	= "GIU",
-	},
-};
-
-module_platform_driver(giu_device_driver);
-- 
2.29.2

