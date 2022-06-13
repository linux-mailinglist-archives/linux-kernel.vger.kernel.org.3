Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD0054A013
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348525AbiFMUsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245581AbiFMUqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:46:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E423DDF5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so9818420pjm.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oiy8pmLKd5jLwE+dzBEk9banUh3DFbG1WFtGbkSfj/I=;
        b=c6+KlRIbw7dOeJumIROHC3kDB5jhqjzQbZfzsMSGfzSozKqt5aS/Wa3QLHl4p5BfJX
         w6gdZ6G6uRq/1JG2TNKNopgLzXSG0jKQF/20mbk8ciaYMCJcf7uwJZqmmIvXwkaoJV1M
         GhY/r6UzywFAbQqmlMTEJEhLE0DxLy3mJuY8RuirFSavzCjd81lmXDJLEN2Sg40rIRg5
         4dsmhb5Z+GDfUHHTP2T9cQJuCXhcQdvMCOUgiPvhqWvFz+79cYlrTjV5R1ADkwh4yUqX
         63Cd84XuN1HIXEh2IvRcsvuyO4TTnZMx9d98DVMmOVakA0MK5t9FVV7Q6qO/wa2WFEYh
         T4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oiy8pmLKd5jLwE+dzBEk9banUh3DFbG1WFtGbkSfj/I=;
        b=Zx9itE+oGjL9xVX+fGGmCdMv/QoN95c38QcphMuNa3MWW49ntPlWbsy49SMoJK7AdG
         eIXfjxw5tWjINNRCTiRgCn6+6cXmXzSqQv9/gwHGkQcIbtnHfPG1Vu46vQs9GywqUd9A
         vkm2/+YdSaCQg/4EzbOrrbnl7UnehpblQUFwO0H9DnJeJTEmNKGe5TgOcdP46Tvwo1To
         J4YFYJ7NNBWbuj85X95E5lPR6cra/rN0owzZ8luYGjbFiDLGnMR2Xcuvnk/rBIF7Ad7x
         qaq51ZiuAKyVxibC6wc/6fk51lIjxrW/It47YfpTFAuddzhHVMjr67eYsX+wHl6hL7Iu
         79/A==
X-Gm-Message-State: AJIora/tAocwf4QhJ5b18rkrW/n9/0rssc5hw7Jp0lc5bAPovVLaW7uO
        FXp/pP2iN5VDQ9NngTvzIPwrkA==
X-Google-Smtp-Source: AGRyM1vcP+VOqsciXePe4Tq2ODUrI3S9zkRdb52odHxzTYFvBLU2YV+KgZUAphyN/P2Kp3HucqLGGQ==
X-Received: by 2002:a17:90b:1e44:b0:1e2:e772:5f08 with SMTP id pi4-20020a17090b1e4400b001e2e7725f08mr394531pjb.129.1655150272137;
        Mon, 13 Jun 2022 12:57:52 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:51 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 14/15] mfd: pensando-elbasr: Add AMD Pensando Elba System Resource chip
Date:   Mon, 13 Jun 2022 12:56:57 -0700
Message-Id: <20220613195658.5607-15-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add support for the AMD Pensando Elba SoC System Resource chip
using the SPI interface.  The Elba SR is a Multi-function Device
supporting device register access using CS0, smbus interface for
FRU and board peripherals using CS1, dual Lattice I2C masters for
transceiver management using CS2, and CS3 for flash access.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 drivers/mfd/Kconfig                 |  14 +
 drivers/mfd/Makefile                |   1 +
 drivers/mfd/pensando-elbasr.c       | 862 ++++++++++++++++++++++++++++
 include/linux/mfd/pensando-elbasr.h |  78 +++
 4 files changed, 955 insertions(+)
 create mode 100644 drivers/mfd/pensando-elbasr.c
 create mode 100644 include/linux/mfd/pensando-elbasr.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3b59456f5545..c5e10d302586 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1050,6 +1050,20 @@ config UCB1400_CORE
 	  To compile this driver as a module, choose M here: the
 	  module will be called ucb1400_core.
 
+config MFD_PENSANDO_ELBASR
+	bool "AMD Pensando Elba System Resource chip"
+	depends on SPI_MASTER=y
+	depends on (ARCH_PENSANDO && OF) || COMPILE_TEST
+	select REGMAP_SPI
+	select MFD_CORE
+	select MFD_SYSCON
+	help
+	  Support for the AMD Pensando Elba SoC System Resource chip using the
+	  SPI interface.  This driver provides userspace access to four device
+	  functions to include CS0 device registers, CS1 smbus interface for
+	  FRU and board peripherals, CS2 dual Lattice I2C masters for
+	  transceiver management, and CS3 flash for firmware update.
+
 config MFD_PM8XXX
 	tristate "Qualcomm PM8xxx PMIC chips driver"
 	depends on (ARM || HEXAGON || COMPILE_TEST)
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..917b128abe5b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -212,6 +212,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
 obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
 obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
 obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
+obj-$(CONFIG_MFD_PENSANDO_ELBASR)	+= pensando-elbasr.o
 obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
 obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
 obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
diff --git a/drivers/mfd/pensando-elbasr.c b/drivers/mfd/pensando-elbasr.c
new file mode 100644
index 000000000000..f689f68f5377
--- /dev/null
+++ b/drivers/mfd/pensando-elbasr.c
@@ -0,0 +1,862 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * AMD Pensando Elba System Resource MFD Driver
+ *
+ * Userspace interface and reset driver support for SPI connected
+ * Pensando Elba System Resource Chip.
+ *
+ * Adapted from spidev.c
+ *
+ * Copyright (C) 2006 SWAPP
+ *	Andrea Paterniani <a.paterniani@swapp-eng.it>
+ * Copyright (C) 2007 David Brownell (simplification, cleanup)
+ * Copyright (C) 2022 AMD Pensando
+ */
+
+#include <linux/mfd/pensando-elbasr.h>
+#include <linux/mfd/core.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ioctl.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/compat.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spidev.h>
+#include <linux/delay.h>
+
+#define ELBASR_SPI_CMD_REGRD	0x0b
+#define ELBASR_SPI_CMD_REGWR	0x02
+#define ELBASR_MAX_DEVS		4
+
+/* The main reason to have this class is to make mdev/udev create the
+ * /dev/pensrB.C character device nodes exposing our userspace API.
+ * It also simplifies memory management.  The device nodes
+ * /dev/pensrB.C are common across Pensando boards.
+ */
+static struct class *elbasr_class;
+
+static dev_t elbasr_devt;
+static DECLARE_BITMAP(minors, ELBASR_MAX_DEVS);
+static unsigned int bufsiz = 4096;
+
+static LIST_HEAD(device_list);
+static DEFINE_MUTEX(device_list_lock);
+
+static const struct mfd_cell pensando_elbasr_subdev_info[] = {
+	{
+		.name = "pensando_elbasr_reset",
+		.of_compatible = "amd,pensando-elbasr-reset",
+	},
+};
+
+/* Bit masks for spi_device.mode management.  Note that incorrect
+ * settings for some settings can cause *lots* of trouble for other
+ * devices on a shared bus:
+ *
+ *  - CS_HIGH ... this device will be active when it shouldn't be
+ *  - 3WIRE ... when active, it won't behave as it should
+ *  - NO_CS ... there will be no explicit message boundaries; this
+ *	is completely incompatible with the shared bus model
+ *  - READY ... transfers may proceed when they shouldn't.
+ */
+#define SPI_MODE_MASK		(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH \
+				| SPI_LSB_FIRST | SPI_3WIRE | SPI_LOOP \
+				| SPI_NO_CS | SPI_READY | SPI_TX_DUAL \
+				| SPI_TX_QUAD | SPI_TX_OCTAL | SPI_RX_DUAL \
+				| SPI_RX_QUAD | SPI_RX_OCTAL)
+
+static ssize_t
+elbasr_spi_sync(struct elbasr_data *elbasr_spi, struct spi_message *message)
+{
+	int status;
+	struct spi_device *spi;
+
+	spin_lock_irq(&elbasr_spi->spi_lock);
+	spi = elbasr_spi->spi;
+	spin_unlock_irq(&elbasr_spi->spi_lock);
+
+	if (spi == NULL)
+		status = -ESHUTDOWN;
+	else
+		status = spi_sync(spi, message);
+
+	if (status == 0)
+		status = message->actual_length;
+
+	return status;
+}
+
+static inline ssize_t
+elbasr_spi_sync_write(struct elbasr_data *elbasr, size_t len)
+{
+	struct spi_transfer	t = {
+			.tx_buf		= elbasr->tx_buffer,
+			.len		= len,
+			.speed_hz	= elbasr->speed_hz,
+		};
+	struct spi_message	m;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+	return elbasr_spi_sync(elbasr, &m);
+}
+
+static inline ssize_t
+elbasr_spi_sync_read(struct elbasr_data *elbasr, size_t len)
+{
+	struct spi_transfer	t = {
+			.rx_buf		= elbasr->rx_buffer,
+			.len		= len,
+			.speed_hz	= elbasr->speed_hz,
+		};
+	struct spi_message	m;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+	return elbasr_spi_sync(elbasr, &m);
+}
+
+/* Read-only message with current device setup */
+static ssize_t
+elbasr_spi_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
+{
+	struct elbasr_data *elbasr;
+	ssize_t status;
+
+	/* chipselect only toggles at start or end of operation */
+	if (count > bufsiz)
+		return -EMSGSIZE;
+
+	elbasr = filp->private_data;
+
+	mutex_lock(&elbasr->buf_lock);
+	status = elbasr_spi_sync_read(elbasr, count);
+	if (status > 0) {
+		unsigned long missing;
+
+		missing = copy_to_user(buf, elbasr->rx_buffer, status);
+		if (missing == status)
+			status = -EFAULT;
+		else
+			status = status - missing;
+	}
+	mutex_unlock(&elbasr->buf_lock);
+
+	return status;
+}
+
+/* Write-only message with current device setup */
+static ssize_t
+elbasr_spi_write(struct file *filp, const char __user *buf,
+		 size_t count, loff_t *f_pos)
+{
+	struct elbasr_data *elbasr;
+	ssize_t status;
+	unsigned long missing;
+
+	/* chipselect only toggles at start or end of operation */
+	if (count > bufsiz)
+		return -EMSGSIZE;
+
+	elbasr = filp->private_data;
+
+	mutex_lock(&elbasr->buf_lock);
+	missing = copy_from_user(elbasr->tx_buffer, buf, count);
+	if (missing == 0)
+		status = elbasr_spi_sync_write(elbasr, count);
+	else
+		status = -EFAULT;
+	mutex_unlock(&elbasr->buf_lock);
+
+	return status;
+}
+
+static int elbasr_spi_message(struct elbasr_data *elbasr,
+			      struct spi_ioc_transfer *u_xfers,
+			      unsigned int n_xfers)
+{
+	struct spi_message msg;
+	struct spi_transfer *k_xfers;
+	struct spi_transfer *k_tmp;
+	struct spi_ioc_transfer *u_tmp;
+	unsigned int n, total, tx_total, rx_total;
+	u8 *tx_buf, *rx_buf;
+	int status = -EFAULT;
+
+	spi_message_init(&msg);
+	k_xfers = kcalloc(n_xfers, sizeof(*k_tmp), GFP_KERNEL);
+	if (k_xfers == NULL)
+		return -ENOMEM;
+
+	/* Construct spi_message, copying any tx data to bounce buffer.
+	 * We walk the array of user-provided transfers, using each one
+	 * to initialize a kernel version of the same transfer.
+	 */
+	tx_buf = elbasr->tx_buffer;
+	rx_buf = elbasr->rx_buffer;
+	total = 0;
+	tx_total = 0;
+	rx_total = 0;
+	for (n = n_xfers, k_tmp = k_xfers, u_tmp = u_xfers;
+			n;
+			n--, k_tmp++, u_tmp++) {
+		/* Ensure that also following allocations from rx_buf/tx_buf will meet
+		 * DMA alignment requirements.
+		 */
+		unsigned int len_aligned = ALIGN(u_tmp->len,
+						 ARCH_KMALLOC_MINALIGN);
+
+		k_tmp->len = u_tmp->len;
+
+		total += k_tmp->len;
+		/* Since the function returns the total length of transfers
+		 * on success, restrict the total to positive int values to
+		 * avoid the return value looking like an error.  Also check
+		 * each transfer length to avoid arithmetic overflow.
+		 */
+		if (total > INT_MAX || k_tmp->len > INT_MAX) {
+			status = -EMSGSIZE;
+			goto done;
+		}
+
+		if (u_tmp->rx_buf) {
+			/* this transfer needs space in RX bounce buffer */
+			rx_total += len_aligned;
+			if (rx_total > bufsiz) {
+				status = -EMSGSIZE;
+				goto done;
+			}
+			k_tmp->rx_buf = rx_buf;
+			rx_buf += len_aligned;
+		}
+		if (u_tmp->tx_buf) {
+			/* this transfer needs space in TX bounce buffer */
+			tx_total += len_aligned;
+			if (tx_total > bufsiz) {
+				status = -EMSGSIZE;
+				goto done;
+			}
+			k_tmp->tx_buf = tx_buf;
+			if (copy_from_user(tx_buf, (const u8 __user *)
+						(uintptr_t) u_tmp->tx_buf,
+					u_tmp->len))
+				goto done;
+			tx_buf += len_aligned;
+		}
+
+		k_tmp->cs_change = !!u_tmp->cs_change;
+		k_tmp->tx_nbits = u_tmp->tx_nbits;
+		k_tmp->rx_nbits = u_tmp->rx_nbits;
+		k_tmp->bits_per_word = u_tmp->bits_per_word;
+		k_tmp->delay.value = u_tmp->delay_usecs;
+		k_tmp->delay.unit = SPI_DELAY_UNIT_USECS;
+		k_tmp->speed_hz = u_tmp->speed_hz;
+		k_tmp->word_delay.value = u_tmp->word_delay_usecs;
+		k_tmp->word_delay.unit = SPI_DELAY_UNIT_USECS;
+		if (!k_tmp->speed_hz)
+			k_tmp->speed_hz = elbasr->speed_hz;
+#ifdef VERBOSE
+		dev_dbg(&elbasr->spi->dev,
+			" xfer len %u %s%s%s%dbits %u usec %u usec %uHz (%u)\n",
+			k_tmp->len,
+			k_tmp->rx_buf ? "rx " : "",
+			k_tmp->tx_buf ? "tx " : "",
+			k_tmp->cs_change ? "cs " : "",
+			k_tmp->bits_per_word ? : elbasr->spi->bits_per_word,
+			k_tmp->delay.value,
+			k_tmp->word_delay.value,
+			k_tmp->speed_hz ? : elbasr->spi->max_speed_hz);
+#endif
+		spi_message_add_tail(k_tmp, &msg);
+	}
+
+	status = elbasr_spi_sync(elbasr, &msg);
+	if (status < 0)
+		goto done;
+
+	/* copy any rx data out of bounce buffer */
+	for (n = n_xfers, k_tmp = k_xfers, u_tmp = u_xfers;
+			n;
+			n--, k_tmp++, u_tmp++) {
+		if (u_tmp->rx_buf) {
+			if (copy_to_user((u8 __user *)
+					(uintptr_t) u_tmp->rx_buf, k_tmp->rx_buf,
+					u_tmp->len)) {
+				status = -EFAULT;
+				goto done;
+			}
+		}
+	}
+	status = total;
+
+done:
+	kfree(k_xfers);
+	return status;
+}
+
+static struct spi_ioc_transfer *
+elbasr_spi_get_ioc_message(unsigned int cmd,
+			   struct spi_ioc_transfer __user *u_ioc,
+			   unsigned int *n_ioc)
+{
+	u32 tmp;
+
+	/* Check type, command number and direction */
+	if (_IOC_TYPE(cmd) != SPI_IOC_MAGIC
+			|| _IOC_NR(cmd) != _IOC_NR(SPI_IOC_MESSAGE(0))
+			|| _IOC_DIR(cmd) != _IOC_WRITE)
+		return ERR_PTR(-ENOTTY);
+
+	tmp = _IOC_SIZE(cmd);
+	if ((tmp % sizeof(struct spi_ioc_transfer)) != 0)
+		return ERR_PTR(-EINVAL);
+	*n_ioc = tmp / sizeof(struct spi_ioc_transfer);
+	if (*n_ioc == 0)
+		return NULL;
+
+	/* copy into scratch area */
+	return memdup_user(u_ioc, tmp);
+}
+
+static long
+elbasr_spi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	int retval = 0;
+	struct elbasr_data *elbasr;
+	struct spi_device *spi;
+	u32 tmp;
+	unsigned int n_ioc;
+	struct spi_ioc_transfer	*ioc;
+
+	/* Check type and command number */
+	if (_IOC_TYPE(cmd) != SPI_IOC_MAGIC)
+		return -ENOTTY;
+
+	/* guard against device removal before, or while,
+	 * we issue this ioctl.
+	 */
+	elbasr = filp->private_data;
+	spin_lock_irq(&elbasr->spi_lock);
+	spi = spi_dev_get(elbasr->spi);
+	spin_unlock_irq(&elbasr->spi_lock);
+
+	if (spi == NULL)
+		return -ESHUTDOWN;
+
+	/* use the buffer lock here for triple duty:
+	 *  - prevent I/O (from us) so calling spi_setup() is safe;
+	 *  - prevent concurrent SPI_IOC_WR_* from morphing
+	 *    data fields while SPI_IOC_RD_* reads them;
+	 *  - SPI_IOC_MESSAGE needs the buffer locked "normally".
+	 */
+	mutex_lock(&elbasr->buf_lock);
+
+	switch (cmd) {
+	/* read requests */
+	case SPI_IOC_RD_MODE:
+		retval = put_user(spi->mode & SPI_MODE_MASK,
+					(__u8 __user *)arg);
+		break;
+	case SPI_IOC_RD_MODE32:
+		retval = put_user(spi->mode & SPI_MODE_MASK,
+					(__u32 __user *)arg);
+		break;
+	case SPI_IOC_RD_LSB_FIRST:
+		retval = put_user((spi->mode & SPI_LSB_FIRST) ?  1 : 0,
+					(__u8 __user *)arg);
+		break;
+	case SPI_IOC_RD_BITS_PER_WORD:
+		retval = put_user(spi->bits_per_word, (__u8 __user *)arg);
+		break;
+	case SPI_IOC_RD_MAX_SPEED_HZ:
+		retval = put_user(elbasr->speed_hz, (__u32 __user *)arg);
+		break;
+
+	/* write requests */
+	case SPI_IOC_WR_MODE:
+	case SPI_IOC_WR_MODE32:
+		if (cmd == SPI_IOC_WR_MODE)
+			retval = get_user(tmp, (u8 __user *)arg);
+		else
+			retval = get_user(tmp, (u32 __user *)arg);
+		if (retval == 0) {
+			struct spi_controller *ctlr = spi->controller;
+			u32	save = spi->mode;
+
+			if (tmp & ~SPI_MODE_MASK) {
+				retval = -EINVAL;
+				break;
+			}
+
+			if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
+			    ctlr->cs_gpiods[spi->chip_select])
+				tmp |= SPI_CS_HIGH;
+
+			tmp |= spi->mode & ~SPI_MODE_MASK;
+			spi->mode = (u16)tmp;
+			retval = spi_setup(spi);
+			if (retval < 0)
+				spi->mode = save;
+			else
+				dev_dbg(&spi->dev, "spi mode %x\n", tmp);
+		}
+		break;
+	case SPI_IOC_WR_LSB_FIRST:
+		retval = get_user(tmp, (__u8 __user *)arg);
+		if (retval == 0) {
+			u32	save = spi->mode;
+
+			if (tmp)
+				spi->mode |= SPI_LSB_FIRST;
+			else
+				spi->mode &= ~SPI_LSB_FIRST;
+			retval = spi_setup(spi);
+			if (retval < 0)
+				spi->mode = save;
+			else
+				dev_dbg(&spi->dev, "%csb first\n",
+						tmp ? 'l' : 'm');
+		}
+		break;
+	case SPI_IOC_WR_BITS_PER_WORD:
+		retval = get_user(tmp, (__u8 __user *)arg);
+		if (retval == 0) {
+			u8	save = spi->bits_per_word;
+
+			spi->bits_per_word = tmp;
+			retval = spi_setup(spi);
+			if (retval < 0)
+				spi->bits_per_word = save;
+			else
+				dev_dbg(&spi->dev, "%d bits per word\n", tmp);
+		}
+		break;
+	case SPI_IOC_WR_MAX_SPEED_HZ:
+		retval = get_user(tmp, (__u32 __user *)arg);
+		if (retval == 0) {
+			u32	save = spi->max_speed_hz;
+
+			spi->max_speed_hz = tmp;
+			retval = spi_setup(spi);
+			if (retval == 0) {
+				elbasr->speed_hz = tmp;
+				dev_dbg(&spi->dev, "%d Hz (max)\n",
+					elbasr->speed_hz);
+			}
+			spi->max_speed_hz = save;
+		}
+		break;
+
+	default:
+		/* segmented and/or full-duplex I/O request */
+		/* Check message and copy into scratch area */
+		ioc = elbasr_spi_get_ioc_message(cmd,
+				(struct spi_ioc_transfer __user *)arg, &n_ioc);
+		if (IS_ERR(ioc)) {
+			retval = PTR_ERR(ioc);
+			break;
+		}
+		if (!ioc)
+			break;	/* n_ioc is also 0 */
+
+		/* translate to spi_message, execute */
+		retval = elbasr_spi_message(elbasr, ioc, n_ioc);
+		kfree(ioc);
+		break;
+	}
+
+	mutex_unlock(&elbasr->buf_lock);
+	spi_dev_put(spi);
+	return retval;
+}
+
+#ifdef CONFIG_COMPAT
+static long
+elbasr_spi_compat_ioc_message(struct file *filp, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct spi_ioc_transfer __user *u_ioc;
+	int retval = 0;
+	struct elbasr_data *elbasr;
+	struct spi_device *spi;
+	unsigned int n_ioc, n;
+	struct spi_ioc_transfer *ioc;
+
+	u_ioc = (struct spi_ioc_transfer __user *) compat_ptr(arg);
+
+	/* guard against device removal before, or while,
+	 * we issue this ioctl.
+	 */
+	elbasr = filp->private_data;
+	spin_lock_irq(&elbasr->spi_lock);
+	spi = spi_dev_get(elbasr->spi);
+	spin_unlock_irq(&elbasr->spi_lock);
+
+	if (spi == NULL)
+		return -ESHUTDOWN;
+
+	/* SPI_IOC_MESSAGE needs the buffer locked "normally" */
+	mutex_lock(&elbasr->buf_lock);
+
+	/* Check message and copy into scratch area */
+	ioc = elbasr_spi_get_ioc_message(cmd, u_ioc, &n_ioc);
+	if (IS_ERR(ioc)) {
+		retval = PTR_ERR(ioc);
+		goto done;
+	}
+	if (!ioc)
+		goto done;	/* n_ioc is also 0 */
+
+	/* Convert buffer pointers */
+	for (n = 0; n < n_ioc; n++) {
+		ioc[n].rx_buf = (uintptr_t) compat_ptr(ioc[n].rx_buf);
+		ioc[n].tx_buf = (uintptr_t) compat_ptr(ioc[n].tx_buf);
+	}
+
+	/* translate to spi_message, execute */
+	retval = elbasr_spi_message(elbasr, ioc, n_ioc);
+	kfree(ioc);
+
+done:
+	mutex_unlock(&elbasr->buf_lock);
+	spi_dev_put(spi);
+	return retval;
+}
+
+static long
+elbasr_spi_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	if (_IOC_TYPE(cmd) == SPI_IOC_MAGIC
+			&& _IOC_NR(cmd) == _IOC_NR(SPI_IOC_MESSAGE(0))
+			&& _IOC_DIR(cmd) == _IOC_WRITE)
+		return elbasr_spi_compat_ioc_message(filp, cmd, arg);
+
+	return elbasr_spi_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#else
+#define elbasr_spi_compat_ioctl NULL
+#endif /* CONFIG_COMPAT */
+
+static int elbasr_spi_open(struct inode *inode, struct file *filp)
+{
+	struct elbasr_data *elbasr;
+	int status = -ENXIO;
+
+	mutex_lock(&device_list_lock);
+
+	list_for_each_entry(elbasr, &device_list, device_entry) {
+		if (elbasr->devt == inode->i_rdev) {
+			status = 0;
+			break;
+		}
+	}
+
+	if (status) {
+		pr_debug("elbasr_spi: nothing for minor %d\n", iminor(inode));
+		goto err_find_dev;
+	}
+
+	if (!elbasr->tx_buffer) {
+		elbasr->tx_buffer = kmalloc(bufsiz, GFP_KERNEL);
+		if (!elbasr->tx_buffer) {
+			status = -ENOMEM;
+			goto err_find_dev;
+		}
+	}
+
+	if (!elbasr->rx_buffer) {
+		elbasr->rx_buffer = kmalloc(bufsiz, GFP_KERNEL);
+		if (!elbasr->rx_buffer) {
+			status = -ENOMEM;
+			goto err_alloc_rx_buf;
+		}
+	}
+
+	elbasr->users++;
+	filp->private_data = elbasr;
+	stream_open(inode, filp);
+
+	mutex_unlock(&device_list_lock);
+	return 0;
+
+err_alloc_rx_buf:
+	kfree(elbasr->tx_buffer);
+	elbasr->tx_buffer = NULL;
+err_find_dev:
+	mutex_unlock(&device_list_lock);
+	return status;
+}
+
+static int elbasr_spi_release(struct inode *inode, struct file *filp)
+{
+	struct elbasr_data *elbasr;
+	int dofree;
+
+	mutex_lock(&device_list_lock);
+	elbasr = filp->private_data;
+	filp->private_data = NULL;
+
+	spin_lock_irq(&elbasr->spi_lock);
+	/* ... after we unbound from the underlying device? */
+	dofree = (elbasr->spi == NULL);
+	spin_unlock_irq(&elbasr->spi_lock);
+
+	/* last close? */
+	elbasr->users--;
+	if (!elbasr->users) {
+
+		kfree(elbasr->tx_buffer);
+		elbasr->tx_buffer = NULL;
+
+		kfree(elbasr->rx_buffer);
+		elbasr->rx_buffer = NULL;
+
+		if (dofree)
+			kfree(elbasr);
+		else
+			elbasr->speed_hz = elbasr->spi->max_speed_hz;
+	}
+#ifdef CONFIG_SPI_SLAVE
+	if (!dofree)
+		spi_slave_abort(elbasr->spi);
+#endif
+	mutex_unlock(&device_list_lock);
+
+	return 0;
+}
+
+static const struct file_operations elbasr_spi_fops = {
+	.owner =	THIS_MODULE,
+	.write =	elbasr_spi_write,
+	.read =		elbasr_spi_read,
+	.unlocked_ioctl = elbasr_spi_ioctl,
+	.compat_ioctl = elbasr_spi_compat_ioctl,
+	.open =		elbasr_spi_open,
+	.release =	elbasr_spi_release,
+	.llseek =	no_llseek,
+};
+
+static bool
+elbasr_reg_readable(struct device *dev, unsigned int reg)
+{
+	return reg <= ELBASR_MAX_REG;
+}
+
+static bool
+elbasr_reg_writeable(struct device *dev, unsigned int reg)
+{
+	return reg <= ELBASR_MAX_REG;
+}
+
+static int
+elbasr_regs_read(void *ctx, u32 reg, u32 *val)
+{
+	struct elbasr_data *elbasr = dev_get_drvdata(ctx);
+	struct spi_message m;
+	struct spi_transfer t[2] = { { 0 } };
+	int ret;
+	u8 txbuf[3];
+	u8 rxbuf[1];
+
+	spi_message_init(&m);
+
+	txbuf[0] = ELBASR_SPI_CMD_REGRD;
+	txbuf[1] = reg;
+	txbuf[2] = 0x0;
+	t[0].tx_buf = (u8 *)txbuf;
+	t[0].len = 3;
+
+	rxbuf[0] = 0x0;
+	t[1].rx_buf = rxbuf;
+	t[1].len = 1;
+
+	spi_message_add_tail(&t[0], &m);
+	spi_message_add_tail(&t[1], &m);
+
+	ret = elbasr_spi_sync(elbasr, &m);
+	if (ret == 4) {
+		// 3 Tx + 1 Rx = 4
+		*val = rxbuf[0];
+		return 0;
+	}
+	return -EIO;
+}
+
+static int
+elbasr_regs_write(void *ctx, u32 reg, u32 val)
+{
+	struct elbasr_data *elbasr = dev_get_drvdata(ctx);
+	struct spi_message m;
+	struct spi_transfer t[1] = { { 0 } };
+	u8 txbuf[4];
+
+	spi_message_init(&m);
+	txbuf[0] = ELBASR_SPI_CMD_REGWR;
+	txbuf[1] = reg;
+	txbuf[2] = val;
+	txbuf[3] = 0;
+
+	t[0].tx_buf = txbuf;
+	t[0].len = 4;
+
+	spi_message_add_tail(&t[0], &m);
+
+	return elbasr_spi_sync(elbasr, &m);
+}
+
+static const struct regmap_config pensando_elbasr_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_NONE,
+	.readable_reg = elbasr_reg_readable,
+	.writeable_reg = elbasr_reg_writeable,
+	.reg_read = elbasr_regs_read,
+	.reg_write = elbasr_regs_write,
+	.max_register = ELBASR_MAX_REG
+};
+
+/*
+ * Setup Elba SPI access to System Resource Chip registers on CS0
+ */
+static int
+elbasr_regs_setup(struct spi_device *spi, struct elbasr_data *elbasr)
+{
+	int ret;
+
+	spi->bits_per_word = 8;
+	spi_setup(spi);
+	elbasr->elbasr_regs = devm_regmap_init(&spi->dev, NULL, spi,
+					       &pensando_elbasr_regmap_config);
+	if (IS_ERR(elbasr->elbasr_regs)) {
+		ret = PTR_ERR(elbasr->elbasr_regs);
+		dev_err(&spi->dev, "Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
+				   pensando_elbasr_subdev_info,
+				   ARRAY_SIZE(pensando_elbasr_subdev_info),
+				   NULL, 0, NULL);
+	if (ret)
+		dev_err(&spi->dev, "Failed to register sub-devices: %d\n", ret);
+
+	return ret;
+}
+
+static int elbasr_spi_probe(struct spi_device *spi)
+{
+	struct elbasr_data *elbasr;
+	unsigned long minor;
+	int status;
+
+	if (spi->chip_select == 0) {
+		status = alloc_chrdev_region(&elbasr_devt, 0, ELBASR_MAX_DEVS,
+					     "elbasr");
+		if (status < 0)
+			return status;
+
+		elbasr_class = class_create(THIS_MODULE, "elbasr");
+		if (IS_ERR(elbasr_class)) {
+			unregister_chrdev(MAJOR(elbasr_devt), "elbasr");
+			return PTR_ERR(elbasr_class);
+		}
+	}
+
+	/* Allocate driver data */
+	elbasr = kzalloc(sizeof(*elbasr), GFP_KERNEL);
+	if (!elbasr)
+		return -ENOMEM;
+
+	/* Initialize the driver data */
+	elbasr->spi = spi;
+	elbasr->speed_hz = spi->max_speed_hz;
+	spin_lock_init(&elbasr->spi_lock);
+	mutex_init(&elbasr->buf_lock);
+
+	INIT_LIST_HEAD(&elbasr->device_entry);
+
+	mutex_lock(&device_list_lock);
+	minor = find_first_zero_bit(minors, ELBASR_MAX_DEVS);
+	if (minor < ELBASR_MAX_DEVS) {
+		struct device *dev;
+
+		elbasr->devt = MKDEV(MAJOR(elbasr_devt), minor);
+		dev = device_create(elbasr_class,
+				    &spi->dev,
+				    elbasr->devt,
+				    elbasr,
+				    "pensr%d.%d",
+				    spi->master->bus_num,
+				    spi->chip_select);
+
+		status = PTR_ERR_OR_ZERO(dev);
+	} else {
+		dev_dbg(&spi->dev, "no minor number available\n");
+		status = -ENODEV;
+		goto minor_failed;
+	}
+
+	set_bit(minor, minors);
+	list_add(&elbasr->device_entry, &device_list);
+	dev_dbg(&spi->dev,
+		"created device for major %d, minor %lu\n",
+		MAJOR(elbasr_devt), minor);
+	mutex_unlock(&device_list_lock);
+
+	/* Create cdev */
+	elbasr->cdev = cdev_alloc();
+	if (!elbasr->cdev) {
+		dev_err(elbasr->dev, "allocation of cdev failed");
+		status = -ENOMEM;
+		goto cdev_failed;
+	}
+	elbasr->cdev->owner = THIS_MODULE;
+	cdev_init(elbasr->cdev, &elbasr_spi_fops);
+
+	status = cdev_add(elbasr->cdev, elbasr->devt, 1);
+	if (status) {
+		dev_err(elbasr->dev, "register of cdev failed");
+		goto cdev_delete;
+	}
+	spi_set_drvdata(spi, elbasr);
+
+	/* Add Elba reset driver sub-device */
+	if (spi->chip_select == 0)
+		elbasr_regs_setup(spi, elbasr);
+
+	return 0;
+
+cdev_delete:
+	if (spi->chip_select == 0)
+		cdev_del(elbasr->cdev);
+cdev_failed:
+	if (spi->chip_select == 0)
+		device_destroy(elbasr_class, elbasr->devt);
+minor_failed:
+	kfree(elbasr);
+
+	return status;
+}
+
+static const struct of_device_id elbasr_spi_of_match[] = {
+	{ .compatible = "amd,pensando-elbasr" },
+	{ /* sentinel */ },
+};
+
+static struct spi_driver elbasr_spi_driver = {
+	.probe = elbasr_spi_probe,
+	.driver = {
+		.name = "elbasr",
+		.of_match_table = of_match_ptr(elbasr_spi_of_match),
+	},
+};
+builtin_driver(elbasr_spi_driver, spi_register_driver)
diff --git a/include/linux/mfd/pensando-elbasr.h b/include/linux/mfd/pensando-elbasr.h
new file mode 100644
index 000000000000..2b794218dca5
--- /dev/null
+++ b/include/linux/mfd/pensando-elbasr.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2022 AMD Pensando
+ *
+ * Declarations for AMD Pensando Elba System Resource Chip
+ */
+
+#ifndef __MFD_AMD_PENSANDO_ELBA_H
+#define __MFD_AMD_PENSANDO_ELBA_H
+
+#include <linux/cdev.h>
+#include <linux/regmap.h>
+
+#define ELBASR_REVISION_REG			0x00
+#define ELBASR_CTRL_REG				0x01
+#define ELBASR_QSFP_CTRL_REG			0x02
+#define ELBASR_INTERRUPT_ENABLE_REG		0x03
+#define ELBASR_INTERRUPT_STATUS_REG		0x04
+#define ELBASR_QSFP_LED_REG			0x05
+#define ELBASR_QSFP_LED_FREQUENCY_REG		0x0F
+#define ELBASR_CTRL0_REG			0x10
+#define ELBASR_CTRL1_REG			0x11
+#define ELBASR_CTRL2_REG			0x12
+#define ELBASR_SYSTEM_LED_REG			0x15
+#define ELBASR_CORE_TEMP_REG			0x16
+#define ELBASR_HBM_TEMP_REG			0x17
+#define ELBASR_BOARD_TEMP_REG			0x18
+#define ELBASR_QSFP_PORT1_TEMP_REG		0x19
+#define ELBASR_QSFP_PORT2_TEMP_REG		0x1a
+#define ELBASR_HBM_WARNING_TEMP_REG		0x1b
+#define ELBASR_HBM_CRITICAL_TEMP_REG		0x1c
+#define ELBASR_HBM_FATAL_TEMP_REG		0x1d
+#define ELBASR_ROT_REG0_CNTL_REG		0x23
+#define ELBASR_PUF_ERROR_LIMITS_REG		0x29
+#define ELBASR_PUF_ERROR_COUNT_REG		0x2a
+#define ELBASR_QSFP_PORT1_ALARM_TEMP_REG	0x34
+#define ELBASR_QSFP_PORT1_WARNING_TEMP_REG	0x35
+#define ELBASR_QSFP_PORT2_ALARM_TEMP_REG	0x36
+#define ELBASR_QSFP_PORT2_WARNING_TEMP_REG	0x37
+#define ELBASR_SYSTEM_HEALTH0_REG		0x38
+#define ELBASR_SYSTEM_HEALTH1_REG		0x39
+#define ELBASR_MAJOR_FW_VER_REG			0x3a
+#define ELBASR_MINOR_FW_VER_REG			0x3b
+#define ELBASR_MAINTANENCE_FW_VER_REG		0x3c
+#define ELBASR_PIPELINE_FW_REG			0x3d
+#define ELBASR_QSFP_PRESENT_REG			0x40
+#define ELBASR_OCP_SLOTID_REG			0x42
+#define ELBASR_OCP_SC_DATA0_REG			0x43
+#define ELBASR_OCP_SC_DATA1_REG			0x44
+#define ELBASR_ID				0x80
+
+#define ELBASR_MAX_REG				0x80
+#define ELBASR_NR_RESETS			1
+
+/*
+ * Pensando Elba System Resource MFD device private data structure
+ */
+struct elbasr_data {
+	dev_t devt;
+	int minor;
+	struct device *dev;
+	struct cdev *cdev;
+	struct spi_device *spi;
+	struct list_head device_entry;
+	spinlock_t spi_lock;
+
+	/* TX/RX buffers are NULL unless this device is open (users > 0) */
+	struct mutex buf_lock;
+	unsigned int users;
+	u8 *tx_buffer;
+	u8 *rx_buffer;
+	u32 speed_hz;
+
+	/* System Resource Chip CS0 register access */
+	struct regmap *elbasr_regs;
+};
+
+#endif /* __MFD_AMD_PENSANDO_ELBA_H */
-- 
2.17.1

