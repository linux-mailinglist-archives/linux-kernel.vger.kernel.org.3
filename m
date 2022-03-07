Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34C14CFEEF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiCGMjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiCGMjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:39:05 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0482630F46
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:38:08 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 315941A00D2;
        Mon,  7 Mar 2022 13:38:07 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 610F41A00FD;
        Mon,  7 Mar 2022 13:38:06 +0100 (CET)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B7E53183AC96;
        Mon,  7 Mar 2022 20:38:04 +0800 (+08)
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        manjunatha.venkatesh@nxp.com, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org
Subject: [PATCH] Uwb: Nxp: sr1xx: Uwb driver support for sr1xx series chip
Date:   Mon,  7 Mar 2022 18:07:32 +0530
Message-Id: <20220307123732.2194907-1-manjunatha.venkatesh@nxp.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new uwb driver that supports the integrated Uwb for
Nxp SoCs, especially the sr1xx series and depends on the SPI module.
basically this driver works with UCI packet structure(FiRa Compliance).
Internally driver will handle two modes of operation.
1.HBCI mode (sr1xx BootROM Code Interface)
  sr1xx firmware download sequence during init sequence.
2.UCI mode (UWB control interface)
  After Firmware boot sequence any command/response/ntf will handle as
 per the UCI packet structure.

Its IRQ based driver and sr1xx speicifc irq handshake mechanism logic
implemented.
This driver needs dts config update as per the sr1xx datasheet.

Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
---
 drivers/Kconfig                |    2 +
 drivers/Makefile               |    1 +
 drivers/uwb/Kconfig            |    7 +
 drivers/uwb/Makefile           |    6 +
 drivers/uwb/nxp/Kconfig        |    7 +
 drivers/uwb/nxp/Makefile       |    6 +
 drivers/uwb/nxp/sr1xx/Kconfig  |   16 +
 drivers/uwb/nxp/sr1xx/Makefile |    5 +
 drivers/uwb/nxp/sr1xx/sr1xx.c  | 1037 ++++++++++++++++++++++++++++++++
 drivers/uwb/nxp/sr1xx/sr1xx.h  |  107 ++++
 10 files changed, 1194 insertions(+)
 create mode 100644 drivers/uwb/Kconfig
 create mode 100644 drivers/uwb/Makefile
 create mode 100644 drivers/uwb/nxp/Kconfig
 create mode 100644 drivers/uwb/nxp/Makefile
 create mode 100644 drivers/uwb/nxp/sr1xx/Kconfig
 create mode 100644 drivers/uwb/nxp/sr1xx/Makefile
 create mode 100644 drivers/uwb/nxp/sr1xx/sr1xx.c
 create mode 100644 drivers/uwb/nxp/sr1xx/sr1xx.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 0d399ddaa185..26b3cb95923c 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -236,4 +236,6 @@ source "drivers/interconnect/Kconfig"
 source "drivers/counter/Kconfig"
 
 source "drivers/most/Kconfig"
+
+source "drivers/uwb/Kconfig"
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index a110338c860c..987ab8b820ee 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -187,3 +187,4 @@ obj-$(CONFIG_GNSS)		+= gnss/
 obj-$(CONFIG_INTERCONNECT)	+= interconnect/
 obj-$(CONFIG_COUNTER)		+= counter/
 obj-$(CONFIG_MOST)		+= most/
+obj-y    		        += uwb/
diff --git a/drivers/uwb/Kconfig b/drivers/uwb/Kconfig
new file mode 100644
index 000000000000..28f161dc45a9
--- /dev/null
+++ b/drivers/uwb/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# UWB
+#
+
+source "drivers/uwb/nxp/Kconfig"
+
diff --git a/drivers/uwb/Makefile b/drivers/uwb/Makefile
new file mode 100644
index 000000000000..c74aa17e270d
--- /dev/null
+++ b/drivers/uwb/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for the uwb drivers.
+#
+
+obj-y					+= nxp/
diff --git a/drivers/uwb/nxp/Kconfig b/drivers/uwb/nxp/Kconfig
new file mode 100644
index 000000000000..48f5b47dbfe9
--- /dev/null
+++ b/drivers/uwb/nxp/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# UWB
+#
+
+source "drivers/uwb/nxp/sr1xx/Kconfig"
+
diff --git a/drivers/uwb/nxp/Makefile b/drivers/uwb/nxp/Makefile
new file mode 100644
index 000000000000..8873e388f139
--- /dev/null
+++ b/drivers/uwb/nxp/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for the uwb drivers.
+#
+
+obj-y					+= sr1xx/
diff --git a/drivers/uwb/nxp/sr1xx/Kconfig b/drivers/uwb/nxp/sr1xx/Kconfig
new file mode 100644
index 000000000000..654dcfac5dad
--- /dev/null
+++ b/drivers/uwb/nxp/sr1xx/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Uwb driver configuration
+#
+
+config NXP_UWB_SPI
+        tristate "Nxp UWB UCI protocol driver (SPI) devices"
+	depends on SPI
+        help
+          This option enables the UWB driver for Nxp sr1xx
+          device. Such device supports UCI packet structure,
+          FiRa compliance.
+
+          Say Y here to compile support for sr1xx into the kernel or
+          say M  to compile it as a module. The module will be called
+          sr1xx.ko.
diff --git a/drivers/uwb/nxp/sr1xx/Makefile b/drivers/uwb/nxp/sr1xx/Makefile
new file mode 100644
index 000000000000..63d1106b3632
--- /dev/null
+++ b/drivers/uwb/nxp/sr1xx/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for the uwb drivers.
+#
+obj-$(CONFIG_NXP_UWB_SPI) += sr1xx.o
diff --git a/drivers/uwb/nxp/sr1xx/sr1xx.c b/drivers/uwb/nxp/sr1xx/sr1xx.c
new file mode 100644
index 000000000000..e638e3de3894
--- /dev/null
+++ b/drivers/uwb/nxp/sr1xx/sr1xx.c
@@ -0,0 +1,1037 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SPI driver for UWB SR1xx
+ * Copyright (C) 2018-2022 NXP.
+ *
+ * Author: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
+ */
+#include "sr1xx.h"
+
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/jiffies.h>
+#include <linux/list.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/poll.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/uaccess.h>
+
+/**
+ * Function    : sr1xx_dev_open
+ *
+ * Description : Open sr1xx device node and returns instance to the user space
+ *
+ * Parameters  : inode  :  sr1xx device node path
+ *               filep  :  File pointer to structure of sr1xx device
+ *
+ * Returns     : Returns 0 always
+ */
+static int sr1xx_dev_open(struct inode *inode, struct file *filp)
+{
+	struct sr1xx_dev *sr1xx_dev = container_of(
+		filp->private_data, struct sr1xx_dev, sr1xx_device);
+	filp->private_data = sr1xx_dev;
+	pr_debug("%s : Major No: %d, Minor No: %d\n", __func__, imajor(inode),
+		 iminor(inode));
+	return 0;
+}
+
+/**
+ * Function    : sr1xx_disable_irq
+ *
+ * Description : Disable the interrupt if it is enabled
+ *
+ * Parameters  : sr1xx_dev  :  sr1xx device structure pointer
+ *
+ * Returns     : Returns void
+ */
+static void sr1xx_disable_irq(struct sr1xx_dev *sr1xx_dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sr1xx_dev->irq_enabled_lock, flags);
+	if ((sr1xx_dev->irq_enabled)) {
+		disable_irq_nosync(sr1xx_dev->spi->irq);
+		sr1xx_dev->irq_received = true;
+		sr1xx_dev->irq_enabled = false;
+	}
+	spin_unlock_irqrestore(&sr1xx_dev->irq_enabled_lock, flags);
+}
+
+/**
+ * Function    : sr1xx_enable_irq
+ *
+ * Description : Enable the interrupt, if it is disabled
+ *
+ * Parameters  : sr1xx_dev  :  sr1xx device structure pointer
+ *
+ * Returns     : Returns void
+ */
+static void sr1xx_enable_irq(struct sr1xx_dev *sr1xx_dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sr1xx_dev->irq_enabled_lock, flags);
+	if (!sr1xx_dev->irq_enabled) {
+		enable_irq(sr1xx_dev->spi->irq);
+		sr1xx_dev->irq_enabled = true;
+		sr1xx_dev->irq_received = false;
+	}
+	spin_unlock_irqrestore(&sr1xx_dev->irq_enabled_lock, flags);
+}
+
+/**
+ * Function    : sr1xx_dev_irq_handler
+ *
+ * Description : Will get called when interrupt line asserted from SR1XX
+ *
+ * Parameters  : irq    :  IRQ Number
+ *               dev_id :  sr1xx device Id
+ *
+ * Returns     : Returns IRQ_HANDLED
+ */
+static irqreturn_t sr1xx_dev_irq_handler(int irq, void *dev_id)
+{
+	struct sr1xx_dev *sr1xx_dev = dev_id;
+
+	sr1xx_disable_irq(sr1xx_dev);
+	/* Wake up waiting readers */
+	wake_up(&sr1xx_dev->read_wq);
+	if (device_may_wakeup(&sr1xx_dev->spi->dev))
+		pm_wakeup_event(&sr1xx_dev->spi->dev, WAKEUP_SRC_TIMEOUT);
+	return IRQ_HANDLED;
+}
+
+/**
+ * Function    : sr1xx_dev_iotcl
+ *
+ * Description : Input/OutPut control from user space to perform required
+ *               operation on sr1xx device.
+ *
+ * Parameters  : cmd    :  Indicates what operation needs to be done sr1xx
+ *               arg    :  Value to be passed to sr1xx to do the required
+ *                         opeation
+ *
+ * Returns     : 0 on success and (-1) on error
+ */
+static long sr1xx_dev_ioctl(struct file *filp, unsigned int cmd,
+			    unsigned long arg)
+{
+	int ret = 0;
+	struct sr1xx_dev *sr1xx_dev = NULL;
+
+	pr_debug("sr1xx - %s\n", __func__);
+	sr1xx_dev = filp->private_data;
+	switch (cmd) {
+	case SR1XX_SET_PWR:
+		if (arg == PWR_ENABLE) {
+			pr_debug(" enable power request...");
+			gpio_set_value(sr1xx_dev->ce_gpio, 1);
+			usleep_range(10000, 12000);
+		} else if (arg == PWR_DISABLE) {
+			pr_debug("disable power request...");
+			gpio_set_value(sr1xx_dev->ce_gpio, 0);
+			sr1xx_disable_irq(sr1xx_dev);
+			usleep_range(10000, 12000);
+		} else if (arg == ABORT_READ_PENDING) {
+			pr_debug("%s Abort Read Pending\n", __func__);
+			sr1xx_dev->read_abort_requested = true;
+			sr1xx_disable_irq(sr1xx_dev);
+			/* Wake up waiting readers */
+			wake_up(&sr1xx_dev->read_wq);
+		}
+		break;
+	case SR1XX_SET_FWD:
+		if (arg == 1) {
+			sr1xx_dev->is_fw_dwnld_enabled = true;
+			sr1xx_dev->read_abort_requested = false;
+			pr_debug("%s FW download enabled.\n", __func__);
+		} else if (arg == 0) {
+			sr1xx_dev->is_fw_dwnld_enabled = false;
+			pr_debug("%s FW download disabled.\n", __func__);
+		}
+		break;
+	case SR1XX_GET_THROUGHPUT:
+		if (arg == 0) {
+#if (ENABLE_THROUGHPUT_MEASUREMENT == 1)
+			write_read_throughput();
+#endif
+		}
+		break;
+	default:
+		pr_err(" Error case");
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+/**
+ * Function    : sr1xx_wait_for_irq_gpio_low
+ *
+ * Description : Function to wait for irq gpio low state
+ *
+ */
+void sr1xx_wait_for_irq_gpio_low(struct sr1xx_dev *sr1xx_dev)
+{
+	int retry_count = 0;
+
+	do {
+		udelay(10);
+		retry_count++;
+		if (retry_count == MAX_RETRY_COUNT_FOR_HANDSHAKE) {
+			pr_err("Slave not released the IRQ even after 10ms");
+			break;
+		}
+	} while (gpio_get_value(sr1xx_dev->irq_gpio));
+}
+
+/**
+ * Function    : sr1xx_dev_transceive
+ *
+ * Description : Used to Write/read data from SR1XX
+ *
+ * Parameters  : sr1xx_dev :sr1xx  device structure pointer
+ *               op_mode   :Indicates write/read mode
+ *               count  :  Number of bytes to be write/read
+ * Returns     : Number of bytes write/read if read is success else (-1)
+ *               otherwise indicate each error code
+ */
+static int sr1xx_dev_transceive(struct sr1xx_dev *sr1xx_dev, int op_mode,
+				int count)
+{
+	int ret, retry_count;
+
+	mutex_lock(&sr1xx_dev->sr1xx_access_lock);
+	sr1xx_dev->mode = op_mode;
+	sr1xx_dev->total_bytes_to_read = 0;
+	sr1xx_dev->is_extended_len_bit_set = 0;
+	ret = -1;
+	retry_count = 0;
+
+	switch (sr1xx_dev->mode) {
+	case SR1XX_WRITE_MODE: {
+		sr1xx_dev->write_count = 0;
+		/* UCI Header write */
+		ret = spi_write(sr1xx_dev->spi, sr1xx_dev->tx_buffer,
+				UCI_HEADER_LEN);
+		if (ret < 0) {
+			ret = -EIO;
+			pr_err("spi_write header : Failed.\n");
+			goto transceive_end;
+		} else {
+			count -= UCI_HEADER_LEN;
+		}
+		if (count > 0) {
+			/* In between header write and payload write slave need some time */
+			usleep_range(30, 50);
+			/* UCI Payload write */
+			ret = spi_write(sr1xx_dev->spi,
+					sr1xx_dev->tx_buffer + UCI_HEADER_LEN,
+					count);
+			if (ret < 0) {
+				ret = -EIO;
+				pr_err("spi_write payload : Failed.\n");
+				goto transceive_end;
+			}
+		}
+		sr1xx_dev->write_count = count + UCI_HEADER_LEN;
+		ret = TRANSCEIVE_SUCCESS;
+	} break;
+	case SR1XX_READ_MODE: {
+		if (!gpio_get_value(sr1xx_dev->irq_gpio)) {
+			pr_debug("IRQ might have gone low due to write ");
+			ret = IRQ_WAIT_REQUEST;
+			goto transceive_end;
+		}
+		retry_count = 0;
+		gpio_set_value(sr1xx_dev->spi_handshake_gpio, 1);
+		while (gpio_get_value(sr1xx_dev->irq_gpio)) {
+			if (retry_count == MAX_RETRY_COUNT_FOR_IRQ_CHECK)
+				break;
+			udelay(10);
+			retry_count++;
+		}
+		sr1xx_enable_irq(sr1xx_dev);
+		sr1xx_dev->read_count = 0;
+		retry_count = 0;
+		/* Wait for inetrrupt upto 500ms */
+		ret = wait_event_interruptible_timeout(
+			sr1xx_dev->read_wq, sr1xx_dev->irq_received,
+			sr1xx_dev->timeout_in_ms);
+		if (ret == 0) {
+			pr_err("wait_event_interruptible timeout() : Failed.\n");
+			ret = IRQ_WAIT_TIMEOUT;
+			goto transceive_end;
+		}
+		if (!gpio_get_value(sr1xx_dev->irq_gpio)) {
+			pr_debug("Second IRQ is Low");
+			ret = -1;
+			goto transceive_end;
+		}
+		ret = spi_read(sr1xx_dev->spi, (void *)sr1xx_dev->rx_buffer,
+			       UCI_HEADER_LEN);
+		if (ret < 0) {
+			pr_err("sr1xx_dev_read: spi read error %d\n ", ret);
+			goto transceive_end;
+		}
+		sr1xx_dev->is_extended_len_bit_set =
+			(sr1xx_dev->rx_buffer[UCI_EXT_PAYLOAD_LEN_IND_OFFSET] &
+			 UCI_EXT_PAYLOAD_LEN_IND_OFFSET_MASK);
+		sr1xx_dev->total_bytes_to_read =
+			sr1xx_dev->rx_buffer[UCI_PAYLOAD_LEN_OFFSET];
+		if (sr1xx_dev->is_extended_len_bit_set) {
+			sr1xx_dev->total_bytes_to_read =
+				((sr1xx_dev->total_bytes_to_read << 8) |
+				 sr1xx_dev
+					 ->rx_buffer[UCI_EXT_PAYLOAD_LEN_OFFSET]);
+		}
+		if (sr1xx_dev->total_bytes_to_read >
+		    (MAX_UCI_PKT_SIZE - UCI_HEADER_LEN)) {
+			pr_err("Length %d  exceeds the max limit %d....",
+			       (int)sr1xx_dev->total_bytes_to_read,
+			       (int)MAX_UCI_PKT_SIZE);
+			ret = -1;
+			goto transceive_end;
+		}
+		if (sr1xx_dev->total_bytes_to_read > 0) {
+			ret = spi_read(
+				sr1xx_dev->spi,
+				(void *)(sr1xx_dev->rx_buffer + UCI_HEADER_LEN),
+				sr1xx_dev->total_bytes_to_read);
+			if (ret < 0) {
+				pr_err("sr1xx_dev_read: spi read error.. %d\n ",
+				       ret);
+				goto transceive_end;
+			}
+		}
+		sr1xx_dev->read_count =
+			(unsigned int)(sr1xx_dev->total_bytes_to_read +
+				       UCI_HEADER_LEN);
+		sr1xx_wait_for_irq_gpio_low(sr1xx_dev);
+		ret = TRANSCEIVE_SUCCESS;
+		gpio_set_value(sr1xx_dev->spi_handshake_gpio, 0);
+	} break;
+	default:
+		pr_err("invalid operation .....");
+		break;
+	}
+transceive_end:
+	if (sr1xx_dev->mode == SR1XX_READ_MODE)
+		gpio_set_value(sr1xx_dev->spi_handshake_gpio, 0);
+
+	mutex_unlock(&sr1xx_dev->sr1xx_access_lock);
+	return ret;
+}
+
+/**
+ * Function    : sr1xx_hbci_write
+ *
+ * Description : Used to write hbci(SR1xx BootROM Command Interface) packets
+ *
+ * Parameters  : sr1xx_dev :sr1xx  device structure pointer
+ *               count  :  Number of bytes to be write
+ * Returns     : return  success(TRANSCEIVE_SUCCESS)or fail (-1)
+ */
+static int sr1xx_hbci_write(struct sr1xx_dev *sr1xx_dev, int count)
+{
+	int ret;
+
+	sr1xx_dev->write_count = 0;
+	/* HBCI write */
+	ret = spi_write(sr1xx_dev->spi, sr1xx_dev->tx_buffer, count);
+	if (ret < 0) {
+		ret = -EIO;
+		pr_err("spi_write fw download : Failed.\n");
+		goto hbci_write_fail;
+	}
+	sr1xx_dev->write_count = count;
+	sr1xx_enable_irq(sr1xx_dev);
+	ret = TRANSCEIVE_SUCCESS;
+	return ret;
+hbci_write_fail:
+	pr_err("%s failed...%d", __func__, ret);
+	return ret;
+}
+
+/**
+ * Function    : sr1xx_dev_write
+ *
+ * Description : Write Data to sr1xx on SPI line
+ *
+ * Parameters  : filp   :  Device Node  File Pointer
+ *               buf    :  Buffer which contains data to be sent to sr1xx
+ *               count  :  Number of bytes to be send
+ *               offset :  Pointer to a object that indicates file position
+ *                         user is accessing.
+ * Returns     : Number of bytes writen if write is success else (-1)
+ *               otherwise indicate each error code
+ */
+static ssize_t sr1xx_dev_write(struct file *filp, const char *buf, size_t count,
+			       loff_t *offset)
+{
+	int ret;
+	struct sr1xx_dev *sr1xx_dev;
+
+	sr1xx_dev = filp->private_data;
+	if (count > SR1XX_MAX_TX_BUF_SIZE || count > SR1XX_TXBUF_SIZE) {
+		pr_err("%s : Write Size Exceeds\n", __func__);
+		ret = -ENOBUFS;
+		goto write_end;
+	}
+	if (copy_from_user(sr1xx_dev->tx_buffer, buf, count)) {
+		pr_err("%s : failed to copy from user space\n", __func__);
+		return -EFAULT;
+	}
+#if (ENABLE_THROUGHPUT_MEASUREMENT == 1)
+	sr1xx_start_throughput_measurement(WRITE_THROUGHPUT);
+#endif
+	if (sr1xx_dev->is_fw_dwnld_enabled)
+		ret = sr1xx_hbci_write(sr1xx_dev, count);
+	else
+		ret = sr1xx_dev_transceive(sr1xx_dev, SR1XX_WRITE_MODE, count);
+	if (ret == TRANSCEIVE_SUCCESS)
+		ret = sr1xx_dev->write_count;
+	else
+		pr_err("write failed......");
+#if (ENABLE_THROUGHPUT_MEASUREMENT == 1)
+	sr1xx_stop_throughput_measurement(WRITE_THROUGHPUT, ret);
+#endif
+write_end:
+	return ret;
+}
+
+/**
+ * Function    : sr1xx_hbci_read
+ *
+ * Description : Read Data From sr1xx on SPI line
+ *
+ * Parameters  : sr1xx_dev : sr1xx device structure
+ *               buf    :  Buffer which contains data to be read from sr1xx
+ *               count  :  Number of bytes to be read
+ *
+ * Returns     : Number of bytes read if read is success else (-1)
+ *               otherwise indicate each error code
+ */
+static ssize_t sr1xx_hbci_read(struct sr1xx_dev *sr1xx_dev, char *buf,
+			       size_t count)
+{
+	int ret = -EIO;
+
+	if (count > SR1XX_RXBUF_SIZE) {
+		pr_err("count(%zu) out of range(0-%d)\n", count,
+		       SR1XX_RXBUF_SIZE);
+		ret = -EINVAL;
+		goto hbci_fail;
+	}
+	/* Wait for inetrrupt upto 500ms */
+	ret = wait_event_interruptible_timeout(sr1xx_dev->read_wq,
+					       sr1xx_dev->irq_received,
+					       sr1xx_dev->timeout_in_ms);
+	if (ret == 0) {
+		pr_err("hbci wait_event_interruptible timeout() : Failed.\n");
+		ret = -1;
+		goto hbci_fail;
+	}
+	if (sr1xx_dev->read_abort_requested) {
+		sr1xx_dev->read_abort_requested = false;
+		pr_debug("HBCI Abort Read pending......");
+		return ret;
+	}
+	if (!gpio_get_value(sr1xx_dev->irq_gpio)) {
+		pr_err("IRQ is low during firmware download");
+		goto hbci_fail;
+	}
+#if (ENABLE_THROUGHPUT_MEASUREMENT == 1)
+	sr1xx_start_throughput_measurement(READ_THROUGHPUT);
+#endif
+	ret = spi_read(sr1xx_dev->spi, (void *)sr1xx_dev->rx_buffer, count);
+	if (ret < 0) {
+		pr_err("sr1xx_dev_read: spi read error %d\n ", ret);
+		goto hbci_fail;
+	}
+	ret = count;
+#if (ENABLE_THROUGHPUT_MEASUREMENT == 1)
+	sr1xx_stop_throughput_measurement(READ_THROUGHPUT, count);
+#endif
+	if (copy_to_user(buf, sr1xx_dev->rx_buffer, count)) {
+		pr_err("sr1xx_dev_read: copy to user failed\n");
+		ret = -EFAULT;
+	}
+	return ret;
+hbci_fail:
+	pr_err("Error sr1xx_fw_download ret %d Exit\n", ret);
+	return ret;
+}
+
+/**
+ * Function    : sr1xx_dev_read
+ *
+ * Description : Used to read data from SR1XX
+ *
+ * Parameters  : filp   :  Device Node  File Pointer
+ *               buf    :  Buffer which contains data to be read from sr1xx
+ *               count  :  Number of bytes to be read
+ *               offset :  Pointer to a object that indicates file position
+ *                         user is accessing.
+ * Returns     : Number of bytes read if read is success else (-1)
+ *               otherwise indicate each error code
+ */
+static ssize_t sr1xx_dev_read(struct file *filp, char *buf, size_t count,
+			      loff_t *offset)
+{
+	struct sr1xx_dev *sr1xx_dev = filp->private_data;
+	int ret = -EIO;
+
+	/* 500ms timeout in jiffies */
+	sr1xx_dev->timeout_in_ms = ((500 * HZ) / 1000);
+	memset(sr1xx_dev->rx_buffer, 0x00, SR1XX_RXBUF_SIZE);
+	if (!gpio_get_value(sr1xx_dev->irq_gpio)) {
+		if (filp->f_flags & O_NONBLOCK) {
+			ret = -EAGAIN;
+			goto read_end;
+		}
+	}
+	/* HBCI packet read */
+	if (sr1xx_dev->is_fw_dwnld_enabled)
+		return sr1xx_hbci_read(sr1xx_dev, buf, count);
+	/* UCI packet read */
+first_irq_wait:
+	sr1xx_enable_irq(sr1xx_dev);
+	if (!sr1xx_dev->read_abort_requested) {
+		ret = wait_event_interruptible(sr1xx_dev->read_wq,
+					       sr1xx_dev->irq_received);
+		if (ret) {
+			pr_err("wait_event_interruptible() : Failed.\n");
+			goto read_end;
+		}
+	}
+	if (sr1xx_dev->read_abort_requested) {
+		sr1xx_dev->read_abort_requested = false;
+		pr_debug("Abort Read pending......");
+		return ret;
+	}
+	ret = sr1xx_dev_transceive(sr1xx_dev, SR1XX_READ_MODE, count);
+	if (ret == TRANSCEIVE_SUCCESS) {
+		if (copy_to_user(buf, sr1xx_dev->rx_buffer,
+				 sr1xx_dev->read_count)) {
+			pr_err("%s: copy to user failed\n", __func__);
+			ret = -EFAULT;
+			goto read_end;
+		}
+		ret = sr1xx_dev->read_count;
+	} else if (ret == IRQ_WAIT_REQUEST) {
+		pr_debug(
+			" irg is low due to write hence irq is requested again...");
+		goto first_irq_wait;
+	} else if (ret == IRQ_WAIT_TIMEOUT) {
+		pr_err("Second irq is not received..Time out...");
+		ret = -1;
+	} else {
+		pr_err("spi read failed...%d", ret);
+		ret = -1;
+	}
+read_end:
+	return ret;
+}
+
+#if (ENABLE_THROUGHPUT_MEASUREMENT == 1)
+/**
+ * Function    : write_read_throughput
+ *
+ * Description : Function to print throughput measurement
+ *
+ */
+static void write_read_throughput(void)
+{
+	pr_debug(" **************** Write-Read Throughput: **************");
+	pr_debug(" No of Write Bytes = %ld",
+		 sr1xx_throughput_info.total_through_put_wbytes);
+	pr_debug(" No of Read Bytes = %ld",
+		 sr1xx_throughput_info.total_through_put_rbytes);
+	pr_debug(" Total Write Time (uSec) = %ld",
+		 sr1xx_throughput_info.total_through_put_wtime);
+	pr_debug(" Total Read Time (uSec) = %ld",
+		 sr1xx_throughput_info.total_through_put_rtime);
+	pr_debug(" Total Write-Read Time (uSec) = %ld",
+		 sr1xx_throughput_info.total_through_put_wtime +
+			 sr1xx_throughput_info.total_through_put_rtime);
+	sr1xx_throughput_info.total_through_put_wbytes = 0;
+	sr1xx_throughput_info.total_through_put_rbytes = 0;
+	sr1xx_throughput_info.total_through_put_wtime = 0;
+	sr1xx_throughput_info.total_through_put_rtime = 0;
+	pr_debug(" **************** Write-Read Throughput: **************");
+}
+
+/**
+ * Function    : sr1xx_start_throughput_measurement
+ *
+ * Description : Start this api to measaure the spi performance
+ *
+ * Parameters  : type  :  sr1xx device Write/Read
+ *
+ * Returns     : Returns void
+ */
+static void sr1xx_start_throughput_measurement(unsigned int type)
+{
+	if (type == READ_THROUGHPUT) {
+		memset(&sr1xx_throughput_info.rstart_tv, 0x00,
+		       sizeof(struct timeval));
+		do_gettimeofday(&sr1xx_throughput_info.rstart_tv);
+	} else if (type == WRITE_THROUGHPUT) {
+		memset(&sr1xx_throughput_info.wstart_tv, 0x00,
+		       sizeof(struct timeval));
+		do_gettimeofday(&sr1xx_throughput_info.wstart_tv);
+	} else {
+		pr_err(" %s: wrong type = %d", __func__, type);
+	}
+}
+
+/**
+ * Function    : sr1xx_stop_throughput_measurement
+ *
+ * Description : Call this api to end the measaure of the spi performance
+ *
+ * Parameters  : type  :  sr1xx device Write/Read
+ *
+ * Returns     : Returns void
+ */
+static void sr1xx_stop_throughput_measurement(unsigned int type,
+					      int no_of_bytes)
+{
+	if (type == READ_THROUGHPUT) {
+		memset(&sr1xx_throughput_info.rstop_tv, 0x00,
+		       sizeof(struct timeval));
+		do_gettimeofday(&sr1xx_throughput_info.rstop_tv);
+		sr1xx_throughput_info.total_through_put_rbytes += no_of_bytes;
+		sr1xx_throughput_info.total_through_put_rtime +=
+			(sr1xx_throughput_info.rstop_tv.tv_usec -
+			 sr1xx_throughput_info.rstart_tv.tv_usec) +
+			((sr1xx_throughput_info.rstop_tv.tv_sec -
+			  sr1xx_throughput_info.rstart_tv.tv_sec) *
+			 1000000);
+	} else if (type == WRITE_THROUGHPUT) {
+		memset(&sr1xx_throughput_info.wstop_tv, 0x00,
+		       sizeof(struct timeval));
+		do_gettimeofday(&sr1xx_throughput_info.wstop_tv);
+		sr1xx_throughput_info.total_through_put_wbytes += no_of_bytes;
+		sr1xx_throughput_info.total_through_put_wtime +=
+			(sr1xx_throughput_info.wstop_tv.tv_usec -
+			 sr1xx_throughput_info.wstart_tv.tv_usec) +
+			((sr1xx_throughput_info.wstop_tv.tv_sec -
+			  sr1xx_throughput_info.wstart_tv.tv_sec) *
+			 1000000);
+	} else {
+		pr_err(" %s: wrong type = %d", __func__, type);
+	}
+}
+#endif
+
+/**
+ * Function    : sr1xx_hw_setup
+ *
+ * Description : Used to read data from SR1XX
+ *
+ * Parameters  : platform_data :  struct sr1xx_spi_platform_data *
+ *
+ * Returns     : return 0 in case of success else error code
+ */
+static int sr1xx_hw_setup(struct sr1xx_spi_platform_data *platform_data)
+{
+	int ret;
+
+	ret = gpio_request(platform_data->irq_gpio, "sr1xx irq");
+	if (ret < 0) {
+		pr_err("gpio request failed gpio = 0x%x\n",
+		       platform_data->irq_gpio);
+		goto fail;
+	}
+
+	ret = gpio_direction_input(platform_data->irq_gpio);
+	if (ret < 0) {
+		pr_err("gpio request failed gpio = 0x%x\n",
+		       platform_data->irq_gpio);
+		goto fail_irq;
+	}
+
+	ret = gpio_request(platform_data->ce_gpio, "sr1xx ce");
+	if (ret < 0) {
+		pr_err("gpio request failed gpio = 0x%x\n",
+		       platform_data->ce_gpio);
+		goto fail_gpio;
+	}
+
+	ret = gpio_direction_output(platform_data->ce_gpio, 0);
+	if (ret < 0) {
+		pr_err("sr1xx - Failed setting ce gpio - %d\n",
+		       platform_data->ce_gpio);
+		goto fail_ce_gpio;
+	}
+
+	ret = gpio_request(platform_data->spi_handshake_gpio, "sr1xx ri");
+	if (ret < 0) {
+		pr_err("sr1xx - Failed requesting ri gpio - %d\n",
+		       platform_data->spi_handshake_gpio);
+		goto fail_gpio;
+	}
+
+	ret = gpio_direction_output(platform_data->spi_handshake_gpio, 0);
+	if (ret < 0) {
+		pr_err("sr1xx - Failed setting spi handeshake gpio - %d\n",
+		       platform_data->spi_handshake_gpio);
+		goto fail_handshake_gpio;
+	}
+
+	ret = 0;
+	return ret;
+
+fail_gpio:
+fail_handshake_gpio:
+	gpio_free(platform_data->spi_handshake_gpio);
+fail_ce_gpio:
+	gpio_free(platform_data->ce_gpio);
+fail_irq:
+	gpio_free(platform_data->irq_gpio);
+fail:
+	pr_err("%s failed\n", __func__);
+	return ret;
+}
+
+/**
+ * Function    : sr1xx_set_data
+ *
+ * Description : Set the SR1XX device specific context for future use
+ *
+ * Parameters  : spi :  struct spi_device *
+ *               data:  void*
+ *
+ */
+static inline void sr1xx_set_data(struct spi_device *spi, void *data)
+{
+	dev_set_drvdata(&spi->dev, data);
+}
+
+/**
+ * Function    : sr1xx_get_data
+ *
+ * Description : Get the SR1XX device specific context
+ *
+ * Parameters  : spi :  struct spi_device *
+ *
+ * Returns     : retval 0 if ok else -1 on error
+ */
+static inline void *sr1xx_get_data(const struct spi_device *spi)
+{
+	return dev_get_drvdata(&spi->dev);
+}
+
+/* Possible fops on the sr1xx device */
+static const struct file_operations sr1xx_dev_fops = {
+	.owner = THIS_MODULE,
+	.read = sr1xx_dev_read,
+	.write = sr1xx_dev_write,
+	.open = sr1xx_dev_open,
+	.unlocked_ioctl = sr1xx_dev_ioctl,
+};
+
+/**
+ * Function    : sr1xx_parse_dt
+ *
+ * Description : Parse the dtsi configartion
+ *
+ * Parameters  : dev :  struct spi_device *
+ *               pdata: Ponter to platform data
+ *
+ * Returns     : retval 0 if ok else -1 on error
+ */
+static int sr1xx_parse_dt(struct device *dev,
+			  struct sr1xx_spi_platform_data *pdata)
+{
+	struct device_node *np = dev->of_node;
+
+	pr_info("sr1xx - %s\n", __func__);
+	pdata->irq_gpio = of_get_named_gpio(np, "nxp,sr1xx-irq", 0);
+	if (!gpio_is_valid(pdata->irq_gpio))
+		return -EINVAL;
+	pdata->ce_gpio = of_get_named_gpio(np, "nxp,sr1xx-ce", 0);
+	if (!gpio_is_valid(pdata->ce_gpio))
+		return -EINVAL;
+	pdata->spi_handshake_gpio = of_get_named_gpio(np, "nxp,sr1xx-ri", 0);
+	if (!gpio_is_valid(pdata->spi_handshake_gpio))
+		return -EINVAL;
+	pr_info("sr1xx : irq_gpio = %d, ce_gpio = %d, spi_handshake_gpio = %d\n",
+		pdata->irq_gpio, pdata->ce_gpio, pdata->spi_handshake_gpio);
+	return 0;
+}
+
+/**
+ * Function    : sr1xx_gpio_cleanup
+ *
+ * Description : Release requested gpios
+ *
+ * Parameters  : struct sr1xx_spi_platform_data *pdata
+ *
+ */
+static void sr1xx_gpio_cleanup(struct sr1xx_spi_platform_data *pdata)
+{
+	if (gpio_is_valid(pdata->spi_handshake_gpio))
+		gpio_free(pdata->spi_handshake_gpio);
+	if (gpio_is_valid(pdata->ce_gpio))
+		gpio_free(pdata->ce_gpio);
+	if (gpio_is_valid(pdata->irq_gpio))
+		gpio_free(pdata->irq_gpio);
+}
+
+/**
+ * Function    : sr1xx_probe
+ *
+ * Description : To probe for SR1XX SPI interface. If found initialize the SPI
+ *               clock,bit rate & SPI mode. It will create the dev entry
+ *               (SR1XX) for user space.
+ * Parameters  : spi :  struct spi_device *
+ *
+ * Returns     : retval 0 if ok else -1 on error
+ */
+static int sr1xx_probe(struct spi_device *spi)
+{
+	int ret;
+	struct sr1xx_spi_platform_data *platform_data = NULL;
+	struct sr1xx_spi_platform_data platform_data1;
+	struct sr1xx_dev *sr1xx_dev = NULL;
+	unsigned int irq_flags;
+
+	pr_info("%s chip select : %d , bus number = %d\n", __func__,
+		spi->chip_select, spi->master->bus_num);
+
+	ret = sr1xx_parse_dt(&spi->dev, &platform_data1);
+	if (ret) {
+		pr_err("%s - Failed to parse DT\n", __func__);
+		goto err_exit;
+	}
+	platform_data = &platform_data1;
+
+	sr1xx_dev = kzalloc(sizeof(*sr1xx_dev), GFP_KERNEL);
+	if (sr1xx_dev == NULL) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+	ret = sr1xx_hw_setup(platform_data);
+	if (ret < 0) {
+		pr_err("Failed to sr1xx_enable_SR1XX_IRQ_ENABLE\n");
+		goto err_setup;
+	}
+
+	spi->bits_per_word = 8;
+	spi->mode = SPI_MODE_0;
+	spi->max_speed_hz = SR1XX_SPI_CLOCK;
+	ret = spi_setup(spi);
+	if (ret < 0) {
+		pr_err("failed to do spi_setup()\n");
+		goto err_setup;
+	}
+
+	sr1xx_dev->spi = spi;
+	sr1xx_dev->sr1xx_device.minor = MISC_DYNAMIC_MINOR;
+	sr1xx_dev->sr1xx_device.name = "sr1xx";
+	sr1xx_dev->sr1xx_device.fops = &sr1xx_dev_fops;
+	sr1xx_dev->sr1xx_device.parent = &spi->dev;
+	sr1xx_dev->irq_gpio = platform_data->irq_gpio;
+	sr1xx_dev->ce_gpio = platform_data->ce_gpio;
+	sr1xx_dev->spi_handshake_gpio = platform_data->spi_handshake_gpio;
+
+	dev_set_drvdata(&spi->dev, sr1xx_dev);
+
+	/* init mutex and queues */
+	init_waitqueue_head(&sr1xx_dev->read_wq);
+	mutex_init(&sr1xx_dev->sr1xx_access_lock);
+
+	spin_lock_init(&sr1xx_dev->irq_enabled_lock);
+
+	ret = misc_register(&sr1xx_dev->sr1xx_device);
+	if (ret < 0) {
+		pr_err("misc_register failed! %d\n", ret);
+		goto err_setup;
+	}
+
+	sr1xx_dev->tx_buffer = kzalloc(SR1XX_TXBUF_SIZE, GFP_KERNEL);
+	sr1xx_dev->rx_buffer = kzalloc(SR1XX_RXBUF_SIZE, GFP_KERNEL);
+	if (sr1xx_dev->tx_buffer == NULL) {
+		ret = -ENOMEM;
+		goto exit_free_dev;
+	}
+	if (sr1xx_dev->rx_buffer == NULL) {
+		ret = -ENOMEM;
+		goto exit_free_dev;
+	}
+
+	sr1xx_dev->spi->irq = gpio_to_irq(platform_data->irq_gpio);
+
+	if (sr1xx_dev->spi->irq < 0) {
+		pr_err("gpio_to_irq request failed gpio = 0x%x\n",
+		       platform_data->irq_gpio);
+		goto err_irq_request;
+	}
+	/* request irq. The irq is set whenever the chip has data available
+	 * for reading. It is cleared when all data has been read.
+	 */
+	irq_flags = IRQ_TYPE_LEVEL_HIGH;
+	sr1xx_dev->irq_enabled = true;
+	sr1xx_dev->irq_received = false;
+
+	ret = request_irq(sr1xx_dev->spi->irq, sr1xx_dev_irq_handler, irq_flags,
+			  sr1xx_dev->sr1xx_device.name, sr1xx_dev);
+	if (ret) {
+		pr_err("request_irq failed\n");
+		goto err_irq_request;
+	}
+	sr1xx_disable_irq(sr1xx_dev);
+
+	return ret;
+err_irq_request:
+exit_free_dev:
+	if (sr1xx_dev != NULL) {
+		kfree(sr1xx_dev->tx_buffer);
+		kfree(sr1xx_dev->rx_buffer);
+		misc_deregister(&sr1xx_dev->sr1xx_device);
+	}
+err_setup:
+	if (sr1xx_dev != NULL)
+		mutex_destroy(&sr1xx_dev->sr1xx_access_lock);
+err_exit:
+	sr1xx_gpio_cleanup(platform_data);
+	kfree(sr1xx_dev);
+	pr_err("ERROR: Exit : %s ret %d\n", __func__, ret);
+	return ret;
+}
+
+/**
+ * Function    : sr1xx_remove
+ *
+ * Description : Will get called when the device is removed to release the
+ *                 resources.
+ *
+ * Parameters  : spi :  struct spi_device *
+ *
+ * Returns     : retval 0 always
+ */
+static int sr1xx_remove(struct spi_device *spi)
+{
+	struct sr1xx_dev *sr1xx_dev = sr1xx_get_data(spi);
+
+	gpio_free(sr1xx_dev->ce_gpio);
+	mutex_destroy(&sr1xx_dev->sr1xx_access_lock);
+	free_irq(sr1xx_dev->spi->irq, sr1xx_dev);
+	gpio_free(sr1xx_dev->irq_gpio);
+	gpio_free(sr1xx_dev->spi_handshake_gpio);
+	misc_deregister(&sr1xx_dev->sr1xx_device);
+	if (sr1xx_dev != NULL) {
+		kfree(sr1xx_dev->tx_buffer);
+		kfree(sr1xx_dev->rx_buffer);
+		kfree(sr1xx_dev);
+	}
+	return 0;
+}
+
+/**
+ * Function    : sr1xx_dev_suspend
+ *
+ * Description : Executed before putting the system into a sleep state
+ *
+ * Parameters  : struct device *dev
+ *
+ * Returns     : retval 0 always
+ */
+int sr1xx_dev_suspend(struct device *dev)
+{
+	struct sr1xx_dev *sr1xx_dev = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(sr1xx_dev->spi->irq);
+	return 0;
+}
+
+/**
+ * Function    : sr1xx_dev_resume
+ *
+ * Description : Executed after waking the system up from a sleep state
+ *
+ * Parameters  : struct device *dev
+ *
+ * Returns     : retval 0 always
+ */
+
+int sr1xx_dev_resume(struct device *dev)
+{
+	struct sr1xx_dev *sr1xx_dev = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(sr1xx_dev->spi->irq);
+
+	return 0;
+}
+
+static const struct of_device_id sr1xx_dt_match[] = {
+	{
+		.compatible = "nxp,sr1xx",
+	},
+	{}
+};
+
+static const struct dev_pm_ops sr1xx_dev_pm_ops = { SET_SYSTEM_SLEEP_PM_OPS(
+	sr1xx_dev_suspend, sr1xx_dev_resume) };
+
+static struct spi_driver sr1xx_driver = {
+	.driver = {
+		   .name = "sr1xx",
+		   .pm = &sr1xx_dev_pm_ops,
+		   .bus = &spi_bus_type,
+		   .owner = THIS_MODULE,
+		   .of_match_table = sr1xx_dt_match,
+		    },
+	.probe = sr1xx_probe,
+	.remove = (sr1xx_remove),
+};
+
+/**
+ * Function    : sr1xx_dev_init
+ *
+ * Description : Module init interface
+ *
+ * Parameters  : void
+ *
+ * Returns     : returns zero on success, else negative error code
+ */
+static int __init sr1xx_dev_init(void)
+{
+	return spi_register_driver(&sr1xx_driver);
+}
+
+module_init(sr1xx_dev_init);
+
+/**
+ * Function    : sr1xx_dev_exit
+ *
+ * Description : Module Exit interface
+ *
+ * Parameters  : void
+ *
+ * Returns     : Returns void
+ */
+static void __exit sr1xx_dev_exit(void)
+{
+	spi_unregister_driver(&sr1xx_driver);
+}
+
+module_exit(sr1xx_dev_exit);
+
+MODULE_AUTHOR("Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>");
+MODULE_DESCRIPTION("NXP SR1XX SPI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/uwb/nxp/sr1xx/sr1xx.h b/drivers/uwb/nxp/sr1xx/sr1xx.h
new file mode 100644
index 000000000000..bae8e948e55e
--- /dev/null
+++ b/drivers/uwb/nxp/sr1xx/sr1xx.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SPI driver for UWB SR1xx
+ * Copyright (C) 2018-2022 NXP.
+ *
+ * Author: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+
+#define SR1XX_MAGIC 0xEA
+#define SR1XX_SET_PWR _IOW(SR1XX_MAGIC, 0x01, long)
+#define SR1XX_SET_DBG _IOW(SR1XX_MAGIC, 0x02, long)
+#define SR1XX_SET_POLL _IOW(SR1XX_MAGIC, 0x03, long)
+#define SR1XX_SET_FWD _IOW(SR1XX_MAGIC, 0x04, long)
+#define SR1XX_GET_THROUGHPUT _IOW(SR1XX_MAGIC, 0x05, long)
+#define SR1XX_ESE_RESET _IOW(SR1XX_MAGIC, 0x06, long)
+
+#define UCI_HEADER_LEN 4
+#define HBCI_HEADER_LEN 4
+#define UCI_PAYLOAD_LEN_OFFSET 3
+
+#define UCI_EXT_PAYLOAD_LEN_IND_OFFSET 1
+#define UCI_EXT_PAYLOAD_LEN_IND_OFFSET_MASK 0x80
+#define UCI_EXT_PAYLOAD_LEN_OFFSET 2
+
+#define SR1XX_TXBUF_SIZE 4200
+#define SR1XX_RXBUF_SIZE 4200
+#define SR1XX_MAX_TX_BUF_SIZE 4200
+
+#define MAX_RETRY_COUNT_FOR_IRQ_CHECK 100
+#define MAX_RETRY_COUNT_FOR_HANDSHAKE 1000
+
+/* Macro to define SPI clock frequency */
+#define SR1XX_SPI_CLOCK 16000000L
+#define WAKEUP_SRC_TIMEOUT (2000)
+#define ENABLE_THROUGHPUT_MEASUREMENT 0
+
+/* Maximum UCI packet size supported from the driver */
+#define MAX_UCI_PKT_SIZE 4200
+
+struct sr1xx_spi_platform_data {
+	unsigned int irq_gpio;	/* SR1XX will interrupt host for any ntf */
+	unsigned int ce_gpio;	/* SW reset gpio */
+	unsigned int spi_handshake_gpio;	/* Host ready to read data */
+};
+
+/* Device specific macro and structure */
+struct sr1xx_dev {
+	wait_queue_head_t read_wq;	/* Wait queue for read interrupt */
+	struct spi_device *spi;	/* Spi device structure */
+	struct miscdevice sr1xx_device;	/* Char device as misc driver */
+	unsigned int ce_gpio;	/* SW reset gpio */
+	unsigned int irq_gpio;	/* SR1XX will interrupt host for any ntf */
+	unsigned int spi_handshake_gpio;	/* Host ready to read data */
+	bool irq_enabled;	/* Flag to indicate disable/enable irq sequence */
+	bool irq_received;	/* Flag to indicate that irq is received */
+	spinlock_t irq_enabled_lock;	/* Spin lock for read irq */
+	unsigned char *tx_buffer;	/* Transmit buffer */
+	unsigned char *rx_buffer;	/* Receive buffer */
+	unsigned int write_count;	/* Holds nubers of byte written */
+	unsigned int read_count;	/* Hold nubers of byte read */
+	struct mutex
+	 sr1xx_access_lock;	/* Lock used to synchronize read and write */
+	size_t total_bytes_to_read;	/* Total bytes read from the device */
+	bool is_extended_len_bit_set;	/* Variable to check ext payload Len */
+	bool read_abort_requested;	/* Used to indicate read abort request */
+	bool is_fw_dwnld_enabled;	/* Used to indicate fw download mode */
+	int mode;		/* Indicate write or read mode */
+	long timeout_in_ms;	/* Wait event interrupt timeout in ms */
+};
+
+/* Power enable/disable and read abort ioctl arguments */
+enum { PWR_DISABLE = 0, PWR_ENABLE, ABORT_READ_PENDING };
+
+enum spi_status_codes {
+	TRANSCEIVE_SUCCESS,
+	TRANSCEIVE_FAIL,
+	IRQ_WAIT_REQUEST,
+	IRQ_WAIT_TIMEOUT
+};
+
+/* Spi write/read operation mode */
+enum spi_operation_modes { SR1XX_WRITE_MODE, SR1XX_READ_MODE };
+
+/* Used for debug purpose */
+#if (ENABLE_THROUGHPUT_MEASUREMENT == 1)
+#define READ_THROUGHPUT 0x01
+#define WRITE_THROUGHPUT 0x02
+struct sr1xx_throughput {
+	struct timeval rstart_tv;
+	struct timeval wstart_tv;
+	struct timeval rstop_tv;
+	struct timeval wstop_tv;
+	unsigned long total_through_put_wbytes;
+	unsigned long total_through_put_rbytes;
+	unsigned long total_through_put_rtime;
+	unsigned long total_through_put_wtime;
+};
+struct sr1xx_throughput sr1xx_throughput_info;
+void sr1xx_start_throughput_measurement(unsigned int type);
+void sr1xx_stop_throughput_measurement(unsigned int type, int no_of_bytes);
+#endif
-- 
2.35.1

