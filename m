Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035F34E1F46
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 04:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbiCUDQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 23:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344292AbiCUDQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 23:16:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330EA2315F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 20:14:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g19so14339252pfc.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 20:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1LhpNql/EG65+DljnHK1uovM5GM2GTINp41hb/pqBs=;
        b=Y0GUEivdiWc80V5JeORlCwwis4ZKkfexTkS4SjiXnhZOWs/keprhow4oiyPruLoAdO
         MEJVKZfumy2aX/6XWVCnmLkQtrjalOANBUWL5tN63SnbK8qHcqQFhfdyZzJMsVibSC1M
         BPvG8KDShpjfPaefm4ZVdhYLAqwEF66OBOhqig5oDIGy+K4Vo3e5San+6BBaY/kRELK7
         pQpnuiUIfzLeeeTSiC84w+pqPatNqqkrSnCbHNidcTduNRIdlGRDBWzgdMkW7O88Tm/r
         vaFsHozJKrsl+4wwP0JpI6HLOLWuNwDJ+ULzaP75EWcO5tJ7259wwJSYrC7hklZoZs1+
         d/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1LhpNql/EG65+DljnHK1uovM5GM2GTINp41hb/pqBs=;
        b=iSuM53UIc3dHmF9Y//21T0gqShxmu7Roda64RH+sZnLA+2oC5ior/zHqaLxv4KVX3Q
         7yumkiaZzrDRaj53+dDd8N/gE9V5E3chey1nWi+GLbeywpu45niZh8dR9s9IdIU6wK/i
         J/14+n1y7h4cnlvzQr9nSKdU3J6ehveB9Ir8nnPGSOAmT05gKPHF5JHgYRBhqs3fCX5S
         7T2iBqrga2seP1SZsM7QbSOY+Ap08m4g4QNmCuOmB/QW0yLFXhcq7Xo8gFtk0UQ+eohS
         vWBaqpKXeHwoiDMHHcOoV9Jq6AIvhQPSmS4+7fCuhR2fKFJypzNHij28V46IpTlLZG1W
         J2Iw==
X-Gm-Message-State: AOAM531BIRD1qEq+3Rt8SK8ARQw2YUX6vWwHMBHwWVQ5VpES/7NY/LSJ
        7K2mwOUnyx6pBfG4YvjSNCYcUndMATi56w==
X-Google-Smtp-Source: ABdhPJwalp4ThJR/m4CJsR19PMZPOunJg4wEFqLUU0UsyTFTm1tCDB9gUkmVc5MWNLrVSd3lDREXQQ==
X-Received: by 2002:a63:8842:0:b0:37c:6baf:2168 with SMTP id l63-20020a638842000000b0037c6baf2168mr16643352pgd.499.1647832482050;
        Sun, 20 Mar 2022 20:14:42 -0700 (PDT)
Received: from yusufkhan-MS-7B17.lan ([24.17.200.29])
        by smtp.gmail.com with ESMTPSA id p128-20020a625b86000000b004fa666a1327sm10087548pfb.102.2022.03.20.20.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 20:14:41 -0700 (PDT)
From:   Yusuf Khan <yusisamerican@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        gregkh@linuxfoundation.org, javier@javigon.com, arnd@arndb.de,
        will@kernel.org, axboe@kernel.dk,
        Yusuf Khan <yusisamerican@gmail.com>,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>
Subject: [PATCH v8 1/2] drivers: ddcci: upstream DDCCI driver
Date:   Sun, 20 Mar 2022 20:14:37 -0700
Message-Id: <20220321031438.14762-1-yusisamerican@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch upstreams the DDCCI driver by Christoph Grenz into
the kernel. The original gitlab page is loacted at https://gitlab
.com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.

DDC/CI is a control protocol for monitor settings supported by most
monitors since about 2005. A chardev and sysfs interface is provided.
The seccond patch in this series provides a backlight driver using
DDC/CI.

Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
Signed-off-by: Christoph Grenz <christophg+lkml@grenz-bonn.de>
---
v2: Fix typos.

v3: Add documentation, move files around, replace semaphores with
mutexes, and replaced <asm-generic/fcntl.h> with <linux/fcntl.h>.
"imirkin"(which due to his involvement in the dri-devel irc channel
I cant help but assume to be a DRM developer) said that the DDC/CI
bus does not intefere with the buses that DRM is involved with.

v4: Move some documentation, fix grammer mistakes, remove usages of
likely(), and clarify some documentation.

v5: Fix grammer mistakes, remove usages of likely(), and clarify
some documentation.

v6: Change contact information to reference Christoph Grenz.

v7: Remove all instances of the unlikely() macro.

v8: Modify documentation to provide updated date and kernel
documentation, fix SPDX lines, use isalpha instead of redefining
logic, change maximum amount of bytes that can be written to be
conformant with DDC/CI specification, prevent userspace from holding
locks with the open file descriptor, remove ddcci_cdev_seek, dont
refine sysfs_emit() logic, use EXPORT_SYMBOL_GPL instead of
EXPORT_SYMBOL, remove ddcci_device_remove_void, remove module
paramaters and version, and split into 2 patches.
---
 Documentation/ABI/testing/sysfs-driver-ddcci |   57 +
 Documentation/driver-api/ddcci.rst           |  122 ++
 drivers/char/Kconfig                         |   13 +-
 drivers/char/Makefile                        |    1 +
 drivers/char/ddcci.c                         | 1805 ++++++++++++++++++
 include/linux/ddcci.h                        |  163 ++
 6 files changed, 2160 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ddcci
 create mode 100644 Documentation/driver-api/ddcci.rst
 create mode 100644 drivers/char/ddcci.c
 create mode 100644 include/linux/ddcci.h

diff --git a/Documentation/ABI/testing/sysfs-driver-ddcci b/Documentation/ABI/testing/sysfs-driver-ddcci
new file mode 100644
index 000000000000..19f77ccf3ed0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-ddcci
@@ -0,0 +1,57 @@
+What:		/sys/bus/ddcci/ddcci<I²C bus number>i<hex address>
+Date:		March 2022
+KernelVersion:	5.18
+Contact:	Christoph Grenz <christophg+lkml@grenz-bonn.de>
+Description:	This file is a user interface for an internal
+		dependent device on the I2C bus, it exports the same
+		information as the master device(/sys/bus/ddcci/
+		ddcci<I²C bus number>) that is referenced in this
+		document.
+
+What:		/sys/bus/ddcci/ddcci<I²C bus number>e<hex address>
+Date:		March 2022
+KernelVersion:	5.18
+Contact:	Christoph Grenz <christophg+lkml@grenz-bonn.de>
+Description:	This file is a user interface for an external
+		dependent device on the I2C bus, it exports the same
+		information as the master device(/sys/bus/ddcci/
+		ddcci<I²C bus number>) that is referenced in this
+		document.
+
+What:		/sys/bus/ddcci/ddcci<I²C bus number>
+Date:		March 2022
+KernelVersion:	5.18
+Contact:	Christoph Grenz <christophg+lkml@grenz-bonn.de>
+Description:	This file provides the user interface for the
+		master device on the I2C bus. It exports the following
+		peices of information:
+		- idProt
+		ACCESS.bus protocol supported by the device. Usually
+		"monitor".
+
+		- idType
+		ACCESS.bus device subtype. Usually "LCD" or "CRT".
+
+		- idModel
+		ACCESS.bus device model identifier. Usually a
+		shortened form of the device model name.
+
+		- idVendor
+		ACCESS.bus device vendor identifier. Empty if the
+		Identification command is not supported.
+
+		- idModule
+		ACCESS.bus device module identifier. Empty if the
+		Identification command is not supported.
+
+		- idSerial
+		32 bit device number. A fixed serial number if it's
+		positive, a temporary serial number if negative and zero
+		if the Identification command is not supported.
+
+		- modalias
+		A combined identifier for driver selection. It has the form:
+		ddcci:<idProt>-<idType>-<idModel>-<idVendor>-<idModule>.
+		All non-alphanumeric characters (including whitespace)
+		in the model, vendor or module parts are replaced by
+		underscores to prevent issues with software like systemd-udevd.
diff --git a/Documentation/driver-api/ddcci.rst b/Documentation/driver-api/ddcci.rst
new file mode 100644
index 000000000000..2b7de1ac2656
--- /dev/null
+++ b/Documentation/driver-api/ddcci.rst
@@ -0,0 +1,122 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==============
+DDC/CI
+==============
+
+1. Introduction
+===============
+DDC/CI is a control protocol for monitor settings supported by most
+monitors since about 2005. It is based on ACCESS.bus (an early USB predecessor).
+This could be used to create drivers that communicate with the DDCCI component,
+see ddcci-backlight for an example.
+
+2. sysfs interface
+==================
+Each detected DDC/CI device gets a directory in /sys/bus/ddcci/devices.
+The main device on a bus is named ddcci[I²C bus number].
+Internal dependent devices are named ddcci[I²C bus number]i[hex address]
+External dependent devices are named ddcci[I²C bus number]e[hex address]
+There the following files export information about the device:
+
+capabilities
+The full ACCESS.bus capabilities string. It contains the protocol,
+type and model of the device, a list of all supported command
+codes, etc. See the ACCESS.bus spec for more information.
+
+- idProt
+ACCESS.bus protocol supported by the device. Usually "monitor".
+
+- idType
+ACCESS.bus device subtype. Usually "LCD" or "CRT".
+
+- idModel
+ACCESS.bus device model identifier. Usually a shortened form of the
+device model name.
+
+- idVendor
+ACCESS.bus device vendor identifier. Empty if the Identification command
+is not supported.
+
+- idModule
+ACCESS.bus device module identifier. Empty if the Identification command
+is not supported.
+
+- idSerial
+32 bit device number. A fixed serial number if it's positive, a temporary
+serial number if negative and zero if the
+Identification command is not supported.
+
+- modalias
+A combined identifier for driver selection. It has the form:
+ddcci:<idProt>-<idType>-<idModel>-<idVendor>-<idModule>.
+All non-alphanumeric characters (including whitespace) in the model,
+vendor or module parts are replaced by underscores to prevent issues
+with software like systemd-udevd.
+
+3. Character device interface
+=============================
+For each DDC/CI device a character device in
+/dev/bus/ddcci/[I²C bus number]/ is created,
+127 devices are assigned in total.
+
+The main device on the bus is named display.
+
+Internal dependent devices are named i[hex address]
+
+External dependent devices are named e[hex address]
+
+These character devices can be used to issue commands to a DDC/CI device
+more easily than over i2c-dev devices. They should be opened unbuffered.
+To send a command just write the command byte and the arguments with a
+single write() operation. The length byte and checksum are automatically
+calculated.
+
+To read a response use read() with a buffer big enough for the expected answer.
+
+NOTE: The maximum length of a DDC/CI message is 32 bytes.
+
+4. ddcci-backlight (monitor backlight driver)
+=============================================
+[This is not specific to the DDC/CI backlight driver, if you already dealt with
+backlight drivers, skip over this.]
+
+For each monitor that supports accessing the Backlight Level White
+or the Luminance property, a backlight device of type "raw" named like the
+corresponding ddcci device is created. You can find them in /sys/class/backlight/.
+For convenience a symlink "ddcci_backlight" on the device associated with the
+display connector in /sys/class/drm/ to the backlight device is created, as
+long as the graphics driver allows to make this association.
+
+5. Limitations
+==============
+
+-Dependent devices (sub devices using DDC/CI directly wired to the monitor,
+like  Calibration devices, IR remotes, etc.) aren't automatically detected.
+You can force detection of external dependent devices by writing
+"ddcci-dependent [address]" into /sys/bus/i2c/i2c-?/new_device.
+
+There is no direct synchronization if you manually change the luminance
+with the buttons on your monitor, as this can only be realized through polling
+and some monitors close their OSD every time a DDC/CI command is received.
+
+Monitor hotplugging is not detected. You need to detach/reattach the I²C driver
+or reload the module.
+
+6. Debugging
+============
+Both drivers use the dynamic debugging feature of the Linux kernel.
+To get detailed debugging messages, set the dyndbg module parameter.
+If you want to enable debugging permanently across reboots, create a file
+/etc/modprobe.d/ddcci.conf containing lines like the following before loading the modules:
+
+options ddcci dyndbg
+options ddcci-backlight dyndbg
+
+7. Origin
+============
+This driver originally came from Christoph Grenz in DKMS form here:
+https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux
+with multiple backups available on the wayback machine. It also
+inlcudes a example program for the usage of this driver in
+userland.
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 740811893c57..92a75be5c353 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Character device configuration
 #
@@ -451,4 +451,15 @@ config RANDOM_TRUST_BOOTLOADER
 	pool. Otherwise, say N here so it will be regarded as device input that
 	only mixes the entropy pool.
 
+config DDCCI
+	tristate "DDCCI display protocol support"
+	depends on I2C
+	help
+	  Display Data Channel Command Interface is an
+	  interface that allows the kernel to "talk"
+	  to most displays made after 2005. Check your
+	  display's specification to see if it has
+	  support for this. This depends on I2C to
+	  compile.
+
 endmenu
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 264eb398fdd4..eaa2d58d50df 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the kernel character device drivers.
 #
 
+obj-$(CONFIG_DDCCI)				+= ddcci.o
 obj-y				+= mem.o random.o
 obj-$(CONFIG_TTY_PRINTK)	+= ttyprintk.o
 obj-y				+= misc.o
diff --git a/drivers/char/ddcci.c b/drivers/char/ddcci.c
new file mode 100644
index 000000000000..b1c3add5d465
--- /dev/null
+++ b/drivers/char/ddcci.c
@@ -0,0 +1,1805 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  DDC/CI sub-bus driver
+ *
+ *  Copyright (c) 2015 Christoph Grenz
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/fcntl.h>
+#include <linux/cdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/version.h>
+
+#include <linux/ddcci.h>
+
+#define DDCCI_RECV_BUFFER_SIZE 130
+#define DEVICE_NAME "ddcci"
+#define DDCCI_MAX_CAP_CHUNKS 200
+
+static unsigned int delay = 60;
+static unsigned short autoprobe_addrs[127] = {0xF0, 0xF2, 0xF4, 0xF6, 0xF8};
+static int autoprobe_addr_count = 5;
+
+static dev_t ddcci_cdev_first;
+static dev_t ddcci_cdev_next;
+static dev_t ddcci_cdev_end;
+static DEFINE_MUTEX(core_lock);
+
+struct bus_type ddcci_bus_type;
+EXPORT_SYMBOL_GPL(ddcci_bus_type);
+
+/* Assert neccessary string array sizes  */
+#ifndef sizeof_field
+# define sizeof_field(t, m) FIELD_SIZEOF(t, m)
+#endif
+static_assert(sizeof_field(struct ddcci_device, prot) > 8);
+static_assert(sizeof_field(struct ddcci_device, type) > 8);
+static_assert(sizeof_field(struct ddcci_device, model) > 8);
+static_assert(sizeof_field(struct ddcci_device, vendor) > 8);
+static_assert(sizeof_field(struct ddcci_device, module) > 8);
+
+/* Internal per-i2c-client driver data */
+struct ddcci_bus_drv_data {
+	unsigned long quirks;
+	struct i2c_client *i2c_dev;
+	struct mutex mut;
+	unsigned char recv_buffer[DDCCI_RECV_BUFFER_SIZE];
+};
+
+/* Replace non-alphanumeric characters in a string (used for modalias) */
+static void ddcci_modalias_clean(char *string, size_t n, char replacement)
+{
+	int i;
+
+	for (i = 0; i < n; ++i) {
+		char c = string[i];
+
+		if (c == 0)
+			return;
+		else if (isalpha(c))
+			string[i] = replacement;
+	}
+}
+
+/* Write a message to the DDC/CI bus using i2c_smbus_write_byte() */
+static int __ddcci_write_bytewise(struct i2c_client *client, unsigned char addr,
+				  bool p_flag, const unsigned char *__restrict buf,
+				  unsigned char len)
+{
+	int ret = 0;
+	unsigned char outer_addr = (unsigned char) (client->addr << 1);
+	unsigned int xor = outer_addr; /* initial xor value */
+
+	/* Consistency checks, maximum allowed by DDCCI spec */
+	if (len > 32)
+		return -EINVAL;
+
+	/* Special case: reply to 0x6E is always 0x51 */
+	if (addr == DDCCI_DEFAULT_DEVICE_ADDR) {
+		addr = DDCCI_HOST_ADDR_ODD;
+	} else {
+		/* When sending the odd address is used */
+		addr = addr | 1;
+	}
+
+	/* first byte: sender address */
+	xor ^= addr;
+	ret = i2c_smbus_write_byte(client, addr);
+	if (ret < 0)
+		return ret;
+
+	/* second byte: protocol flag and message size */
+	xor ^= ((p_flag << 7) | len);
+	ret = i2c_smbus_write_byte(client, (p_flag << 7) | len);
+	if (ret < 0)
+		return ret;
+
+	/* send payload */
+	while (len--) {
+		xor ^= (*buf);
+		ret = i2c_smbus_write_byte(client, (*buf));
+		if (ret < 0)
+			return ret;
+		buf++;
+	}
+
+	/* send checksum */
+	ret = i2c_smbus_write_byte(client, xor);
+	return ret;
+}
+
+/* Write a message to the DDC/CI bus using i2c_master_send() */
+static int __ddcci_write_block(struct i2c_client *client, unsigned char addr,
+			       unsigned char *sendbuf, bool p_flag,
+			       const unsigned char *data, unsigned char len)
+{
+	unsigned char outer_addr = (unsigned char) (client->addr << 1);
+	unsigned int xor = outer_addr;	/* initial xor value */
+	unsigned char *ptr = sendbuf;
+
+	/* Consistency checks, maximum allowed by DDCCI spec */
+	if (len > 32)
+		return -EINVAL;
+
+	/* Special case: sender to 0x6E is always 0x51 */
+	if (addr == DDCCI_DEFAULT_DEVICE_ADDR) {
+		addr = DDCCI_HOST_ADDR_ODD;
+	} else {
+		/* When sending the odd address is used */
+		addr = addr | 1;
+	}
+
+	/* first byte: sender address */
+	xor ^= addr;
+	*(ptr++) = addr;
+	/* second byte: protocol flag and message size */
+	xor ^= ((p_flag << 7) | len);
+	*(ptr++) = (p_flag << 7) | len;
+	/* payload */
+	while (len--) {
+		xor ^= (*data);
+		*(ptr++) = (*data);
+		data++;
+	}
+	/* checksum */
+	(*ptr) = xor;
+
+	/* Send it */
+	return i2c_master_send(client, sendbuf, ptr - sendbuf + 1);
+}
+
+/*
+ * Write a message to the DDC/CI bus.
+ *
+ * You must hold the bus mutex when calling this function.
+ */
+static int ddcci_write(struct i2c_client *client, unsigned char addr,
+		       bool p_flag, const unsigned char *data,
+		       unsigned char len)
+{
+	struct ddcci_bus_drv_data *drv_data;
+	unsigned char *sendbuf;
+	int ret;
+
+	drv_data = i2c_get_clientdata(client);
+
+
+	pr_debug("sending to %d:%02x:%02x: %*ph\n", client->adapter->nr,
+		 client->addr << 1, addr, len, data);
+	if (drv_data->quirks & DDCCI_QUIRK_WRITE_BYTEWISE) {
+		ret = __ddcci_write_bytewise(client, addr, p_flag, data, len);
+	} else {
+		sendbuf = drv_data->recv_buffer;
+		ret = __ddcci_write_block(client, addr, sendbuf, p_flag, data, len);
+	}
+
+	return ret;
+}
+
+/*
+ * Read a response from the DDC/CI bus with headers directly into a buffer.
+ * Always check for DDCCI_QUIRK_SKIP_FIRST_BYTE when using this function.
+ * The returned length contains the whole unmodified response.
+ * If -EMSGSIZE is returned, the buffer contains the response up to `len`.
+ * If any other negative error code is returned, the buffer content is
+ * unspecified.
+ */
+static int __ddcci_read(struct i2c_client *client, unsigned char addr,
+			bool p_flag, unsigned long quirks, unsigned char *buf,
+			unsigned char len)
+{
+	int i, payload_len, packet_length, ret;
+	unsigned char xor = DDCCI_HOST_ADDR_EVEN;
+
+	/* Consistency checks */
+	if (len < 3)
+		return -EINVAL;
+
+	/* Read frame */
+	ret = i2c_master_recv(client, buf, len);
+	if (ret < 0)
+		goto out_err;
+	packet_length = ret;
+
+	/* Skip first byte if quirk active */
+	if ((quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE) && ret > 0 && len > 0) {
+		ret--;
+		len--;
+		buf++;
+	}
+
+	/* If answer too short (= incomplete) break out */
+	if (ret < 3) {
+		ret = -EIO;
+		goto out_err;
+	}
+
+	/* validate first byte */
+	if (buf[0] != addr) {
+		ret = (buf[0] == '\0') ? -EAGAIN : -EIO;
+		goto out_err;
+	}
+
+	/* validate second byte (protocol flag) */
+	if ((buf[1] & 0x80) != (p_flag << 7)) {
+		if (!p_flag || !(quirks & DDCCI_QUIRK_NO_PFLAG)) {
+			ret = -EIO;
+			goto out_err;
+		}
+	}
+
+	/* get and check payload length */
+	payload_len = buf[1] & 0x7F;
+	if (3 + payload_len > packet_length)
+		return -EBADMSG;
+	if (3 + payload_len > len)
+		return -EMSGSIZE;
+
+	/* calculate checksum */
+	for (i = 0; i < 3 + payload_len; i++)
+		xor ^= buf[i];
+
+	/* verify checksum */
+	if (xor != 0) {
+		dev_err(&client->dev, "invalid DDC/CI response, corrupted data - xor is 0x%02x, length 0x%02x\n",
+			xor, payload_len);
+		ret = -EBADMSG;
+		goto out_err;
+	}
+
+	/* return result */
+	ret = payload_len + 3 + ((quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE) ? 1:0);
+
+out_err:
+	return ret;
+}
+
+/*
+ * Read a response from the DDC/CI bus
+ *
+ * You must hold the bus mutex when calling this function.
+ */
+static int ddcci_read(struct i2c_client *client, unsigned char addr,
+		      bool p_flag, unsigned char *buf, unsigned char len)
+{
+	struct ddcci_bus_drv_data *drv_data;
+	unsigned char *recvbuf;
+	int ret;
+
+	drv_data = i2c_get_clientdata(client);
+	recvbuf = drv_data->recv_buffer;
+
+	/* Read frame */
+	ret = __ddcci_read(client, addr, p_flag,
+		drv_data->quirks, recvbuf, DDCCI_RECV_BUFFER_SIZE);
+	if (ret < 0)
+		return ret;
+
+	if (drv_data->quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE)
+		recvbuf++;
+
+	/* return result */
+	if (buf) {
+		if (ret > 3) {
+			ret = ret-3;
+			/* copy to caller buffer */
+			memcpy(buf, &recvbuf[2], (ret < len) ? ret : len);
+
+			if (ret > len) {
+				/* if message was truncated, return -EMSGSIZE */
+				pr_debug("received from %d:%02x:%02x: [%u/%u] %*ph ...\n",
+					 client->adapter->nr, client->addr << 1,
+					 addr, ret, len, len, buf);
+				ret = -EMSGSIZE;
+			} else {
+				pr_debug("received from %d:%02x:%02x: [%u/%u] %*ph\n",
+					 client->adapter->nr, client->addr << 1,
+					 addr, ret, len, ret, buf);
+			}
+		}
+	}
+	if (!(drv_data->quirks & DDCCI_QUIRK_WRITE_BYTEWISE)) {
+		/* second read to clear buffers, needed on some devices */
+		__ddcci_read(client, addr, true, drv_data->quirks, recvbuf, 1);
+	}
+	return ret;
+}
+
+/* Request the capability string for a device and put it into buf */
+static int ddcci_get_caps(struct i2c_client *client, unsigned char addr,
+			  unsigned char *buf, unsigned int len)
+{
+	int result = 0, counter = 0, offset = 0;
+	unsigned char cmd[3] = { DDCCI_COMMAND_CAPS, 0x00, 0x00 };
+	unsigned char *chunkbuf = kzalloc(35, GFP_KERNEL);
+
+	if (!chunkbuf)
+		return -ENOMEM;
+
+	do {
+		/* Send command */
+		result = ddcci_write(client, addr, true, cmd, sizeof(cmd));
+		if (result < 0)
+			goto err_free;
+		msleep(delay);
+		/* read result chunk */
+		result = ddcci_read(client, addr, true, chunkbuf,
+				    (len > 32) ? 35 : len + 3);
+		if (result < 0)
+			goto err_free;
+
+		if (result > 0) {
+			/* check chunk header */
+			if (chunkbuf[0] != DDCCI_REPLY_CAPS) {
+				result = -EIO;
+				goto err_free;
+			}
+			if (chunkbuf[1] != cmd[1] || chunkbuf[2] != cmd[2]) {
+				result = -EIO;
+				goto err_free;
+			}
+			if (result < 3) {
+				result = -EIO;
+				goto err_free;
+			}
+			memcpy(buf, chunkbuf + 3, min((unsigned int)result - 3, len));
+
+			counter++;
+			/* adjust offset, etc. */
+			offset += result-3;
+			len -= result-3;
+			buf += result-3;
+			cmd[1] = offset >> 8;
+			cmd[2] = offset & 0xFF;
+			/* Another superfluous read to make some devices happy... */
+			ddcci_read(client, addr, true, NULL, 2);
+		}
+	} while (result > 3 && counter < DDCCI_MAX_CAP_CHUNKS);
+
+	kfree(chunkbuf);
+	return offset + result-3;
+err_free:
+	kfree(chunkbuf);
+	return result;
+}
+
+/*
+ * Request the device identification and put it into buf.
+ *
+ * Also detects all communication quirks and sets the corresponding flags
+ * in the ddcci_bus_drv_data structure associated with client.
+ *
+ * The identification command will fail on most DDC devices, as it is optional
+ * to support, but even the "failed" response suffices to detect quirks.
+ */
+static int ddcci_identify_device(struct i2c_client *client, unsigned char addr,
+				 unsigned char *buf, unsigned char len)
+{
+	int i, payload_len, ret = -ENODEV;
+	unsigned long quirks;
+	unsigned char cmd[1] = { DDCCI_COMMAND_ID };
+	unsigned char *buffer;
+	unsigned char xor = DDCCI_HOST_ADDR_EVEN;
+	struct ddcci_bus_drv_data *bus_drv_data;
+
+	bus_drv_data = i2c_get_clientdata(client);
+	quirks = bus_drv_data->quirks;
+	buffer = bus_drv_data->recv_buffer;
+
+	/* Send Identification command */
+	if (!(quirks & DDCCI_QUIRK_WRITE_BYTEWISE)) {
+		ret = __ddcci_write_block(client, addr, buffer, true, cmd, sizeof(cmd));
+		dev_dbg(&client->dev,
+			"[%02x:%02x] writing identification command in block mode: %d\n",
+			client->addr << 1, addr, ret);
+		if ((ret == -ENXIO)
+		    && i2c_check_functionality(client->adapter,
+					       I2C_FUNC_SMBUS_WRITE_BYTE)) {
+			quirks |= DDCCI_QUIRK_WRITE_BYTEWISE;
+			dev_info(&client->dev,
+				"DDC/CI bus quirk detected: writes must be done bytewise\n");
+			/* Some devices need writing twice after a failed blockwise write */
+			__ddcci_write_bytewise(client, addr, true, cmd, sizeof(cmd));
+			msleep(delay);
+		}
+	}
+	if (ret < 0 && (quirks & DDCCI_QUIRK_WRITE_BYTEWISE)) {
+		ret = __ddcci_write_bytewise(client, addr, true, cmd, sizeof(cmd));
+		dev_dbg(&client->dev,
+			"[%02x:%02x] writing identification command in bytewise mode: %d\n",
+			client->addr << 1, addr, ret);
+	}
+	if (ret < 0)
+		return -ENODEV;
+
+	/* Wait */
+	msleep(delay);
+
+	/* Receive response */
+	ret = i2c_master_recv(client, buffer, DDCCI_RECV_BUFFER_SIZE);
+	if (ret < 0) {
+		dev_dbg(&client->dev,
+			"[%02x:%02x] receiving identification response resulted in errno %d\n",
+			client->addr << 1, addr, ret);
+		return ret;
+	}
+
+	if (ret == 0) {
+		dev_dbg(&client->dev,
+			"[%02x:%02x] no identification response received\n",
+			client->addr << 1, addr);
+		return ret;
+	}
+
+	/* Skip first byte if quirk already active */
+	if (quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE && ret > 1) {
+		dev_dbg(&client->dev,
+			"[%02x:%02x] doubled first byte quirk in effect\n",
+			client->addr << 1, addr);
+		ret--;
+		buffer++;
+	}
+
+	/* If answer too short (= incomplete) break out */
+	if (ret < 3) {
+		dev_dbg(&client->dev,
+			"[%02x:%02x] identification response is too short (%d bytes)\n",
+			client->addr << 1, addr, ret);
+		return -EIO;
+	}
+
+	/* validate first byte */
+	if (buffer[0] != addr) {
+		dev_dbg(&client->dev,
+			"[%02x:%02x] identification response: %*ph\n",
+			client->addr << 1, addr, (ret > 32 ? 32 : ret), buffer);
+
+		dev_dbg(&client->dev,
+			"[%02x:%02x] identification response invalid (expected first byte %02x, got %02x)\n",
+			client->addr << 1, addr, addr, buffer[0]);
+		return -ENODEV;
+	}
+
+	/* Check if first byte is doubled (QUIRK_SKIP_FIRST_BYTE) */
+	if (!(quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE)) {
+		if (buffer[0] == buffer[1]) {
+			quirks |= DDCCI_QUIRK_SKIP_FIRST_BYTE;
+			dev_info(&client->dev,
+				"DDC/CI bus quirk detected: doubled first byte on read\n");
+			ret--;
+			buffer++;
+			if (ret < 3)
+				return -EIO;
+		}
+	}
+
+	/* validate second byte (protocol flag) */
+	if ((buffer[1] & 0x80) != 0x80 && !(quirks & DDCCI_QUIRK_NO_PFLAG)) {
+		dev_info(&client->dev,
+			"DDC/CI bus quirk detected: device omits protocol flag on responses\n");
+		quirks |= DDCCI_QUIRK_NO_PFLAG;
+	}
+
+	/* get and check payload length */
+	payload_len = buffer[1] & 0x7F;
+	if (3 + payload_len > ret) {
+		dev_dbg(&client->dev,
+			"[%02x:%02x] identification response: %*ph ...\n",
+			client->addr << 1, addr, ret, buffer);
+		dev_dbg(&client->dev,
+			"[%02x:%02x] identification response was truncated (expected %d bytes, got %d)\n",
+			client->addr << 1, addr, 3+payload_len, ret);
+		return -EBADMSG;
+	}
+
+	dev_dbg(&client->dev,
+		"[%02x:%02x] identification response: %*ph\n",
+		client->addr << 1, addr, 3+payload_len, buffer);
+
+	/* calculate checksum */
+	for (i = 0; i < 3 + payload_len; i++)
+		xor ^= buffer[i];
+
+	/* verify checksum */
+	if (xor != 0) {
+		dev_err(&client->dev,
+			"[%02x:%02x] invalid DDC/CI response, corrupted data - xor is 0x%02x, length 0x%02x\n",
+			client->addr << 1, addr, xor, payload_len);
+		return -EBADMSG;
+	}
+
+	/* save quirks */
+	bus_drv_data->quirks = quirks;
+
+	/* return result */
+	if (payload_len <= len) {
+		ret = payload_len;
+		memcpy(buf, &buffer[2], payload_len);
+	} else {
+		ret = -EMSGSIZE;
+		memcpy(buf, &buffer[2], len);
+	}
+	return ret;
+}
+
+/* Character device */
+
+/* Data structure for an open file handle */
+struct ddcci_fp_data {
+	struct ddcci_device *dev;
+	unsigned char buffer[129];
+};
+
+/* Called when the character device is opened */
+static int ddcci_cdev_open(struct inode *inode, struct file *filp)
+{
+	struct ddcci_device *dev = container_of(inode->i_cdev,
+						struct ddcci_device, cdev);
+	struct ddcci_fp_data *fp_data = NULL;
+
+	fp_data = kzalloc(sizeof(struct ddcci_fp_data), GFP_KERNEL);
+
+	if (!fp_data)
+		return -ENOMEM;
+
+	fp_data->dev = dev;
+	filp->private_data = fp_data;
+
+	return 0;
+}
+
+/* Called when reading from the character device */
+static ssize_t ddcci_cdev_read(struct file *filp, char __user *buffer,
+			       size_t length, loff_t *offset)
+{
+	struct ddcci_fp_data *fp_data = filp->private_data;
+	struct ddcci_device *dev = fp_data->dev;
+	unsigned char *buf = fp_data->buffer;
+	const bool nonblocking = (filp->f_flags & O_NONBLOCK) != 0;
+	int ret = 0;
+
+	if ((filp->f_mode & FMODE_READ) == 0)
+		return -EBADF;
+
+	/* Lock mutex */
+	if (nonblocking) {
+		if (mutex_trylock(&dev->bus_drv_data->mut))
+			return -EAGAIN;
+	} else {
+		if (mutex_lock_interruptible(&dev->bus_drv_data->mut))
+			return -ERESTARTSYS;
+	}
+
+	/* Execute read */
+	ret = ddcci_read(dev->bus_drv_data->i2c_dev, dev->inner_addr, true, buf,
+			 length);
+
+	if (ret > 0) {
+		/* Copy data from user space */
+		if (copy_to_user(buffer, buf, ret)) {
+			ret = -EFAULT;
+			goto out;
+		}
+	}
+
+out:
+	mutex_unlock(&dev->bus_drv_data->mut);
+	return ret;
+}
+
+/* Called when writing to the character device */
+static ssize_t ddcci_cdev_write(struct file *filp, const char __user *buffer,
+				size_t count, loff_t *offset)
+{
+	struct ddcci_fp_data *fp_data = filp->private_data;
+	struct ddcci_device *dev = fp_data->dev;
+	unsigned char *buf = fp_data->buffer;
+	const bool nonblocking = (filp->f_flags & O_NONBLOCK) != 0;
+	int ret = 0;
+
+	if ((filp->f_mode & FMODE_WRITE) == 0)
+		return -EBADF;
+
+	if (count > 127)
+		return -EINVAL;
+
+	/* Lock mutex */
+	if (nonblocking) {
+		if (mutex_trylock(&dev->bus_drv_data->mut))
+			return -EAGAIN;
+	} else {
+		if (mutex_lock_interruptible(&dev->bus_drv_data->mut))
+			return -ERESTARTSYS;
+	}
+
+	if (count > 0) {
+		/* Copy data from user space */
+		if (copy_from_user(buf, buffer, count)) {
+			ret = -EFAULT;
+			goto err_out;
+		}
+
+		/* Execute write */
+		ret = ddcci_write(dev->bus_drv_data->i2c_dev, dev->inner_addr,
+				  true, buf, count);
+	}
+
+	if (ret >= 0) {
+		msleep(delay);
+		mutex_unlock(&dev->bus_drv_data->mut);
+		return count;
+	}
+
+err_out:
+	mutex_unlock(&dev->bus_drv_data->mut);
+	return ret;
+}
+
+static const struct file_operations ddcci_fops = {
+	.owner = THIS_MODULE,
+	.read = ddcci_cdev_read,
+	.write = ddcci_cdev_write,
+	.open = ddcci_cdev_open,
+	.llseek = no_llseek
+};
+
+/* Set up the character device for a DDC/CI device */
+static int ddcci_setup_char_device(struct ddcci_device *device)
+{
+	int ret = -EINVAL;
+
+	/* Check if free minor exists */
+	if (ddcci_cdev_next == ddcci_cdev_end) {
+		dev_err(&device->dev, "no free major/minor\n");
+		ret = -ENFILE;
+		goto out;
+	}
+
+	/* Initialize character device node */
+	cdev_init(&device->cdev, &ddcci_fops);
+	device->cdev.owner = THIS_MODULE;
+
+	/* Publish char device */
+	device->dev.devt = ddcci_cdev_next;
+	ret = cdev_add(&device->cdev, ddcci_cdev_next, 1);
+	if (ret) {
+		device->dev.devt = 0;
+		goto out;
+	}
+
+	ddcci_cdev_next++;
+out:
+	return ret;
+}
+
+/* sysfs attributes */
+
+static ssize_t ddcci_attr_capabilities_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct ddcci_device *device = ddcci_verify_device(dev);
+	ssize_t ret = -ENOENT;
+	size_t len;
+
+	if (device != NULL) {
+		len = device->capabilities_len;
+		if (len > PAGE_SIZE)
+			len = PAGE_SIZE;
+		if (len == 0) {
+			ret = len;
+		} else {
+			memcpy(buf, device->capabilities, len);
+			if (len < PAGE_SIZE) {
+				buf[len] = '\n';
+				ret = len + 1;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static ssize_t ddcci_attr_prot_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct ddcci_device *device = ddcci_verify_device(dev);
+	ssize_t ret = -ENOENT;
+	size_t len;
+
+	if (device != NULL) {
+		len = strnlen(device->prot, sizeof(device->prot));
+		strncpy(buf, device->prot, PAGE_SIZE);
+		if (len == 0) {
+			ret = len;
+		} else if (len < PAGE_SIZE) {
+			buf[len] = '\n';
+			ret = len + 1;
+		} else {
+			ret = PAGE_SIZE;
+		}
+	}
+	return ret;
+}
+
+static ssize_t ddcci_attr_type_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct ddcci_device *device = ddcci_verify_device(dev);
+	ssize_t ret = -ENOENT;
+	size_t len;
+
+	if (device != NULL) {
+		len = strnlen(device->type, sizeof(device->type));
+		strncpy(buf, device->type, PAGE_SIZE);
+		if (len == 0) {
+			ret = len;
+		} else if (len < PAGE_SIZE) {
+			buf[len] = '\n';
+			ret = len + 1;
+		} else {
+			ret = PAGE_SIZE;
+		}
+	}
+	return ret;
+}
+
+static ssize_t ddcci_attr_model_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct ddcci_device *device = ddcci_verify_device(dev);
+	ssize_t ret = -ENOENT;
+	size_t len;
+
+	if (device != NULL) {
+		len = strnlen(device->model, sizeof(device->model));
+		strncpy(buf, device->model, PAGE_SIZE);
+		if (len == 0) {
+			ret = len;
+		} else if (len < PAGE_SIZE) {
+			buf[len] = '\n';
+			ret = len + 1;
+		} else {
+			ret = PAGE_SIZE;
+		}
+	}
+	return ret;
+}
+
+static ssize_t ddcci_attr_vendor_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct ddcci_device *device = ddcci_verify_device(dev);
+	ssize_t ret = -ENOENT;
+
+	if (device != NULL)
+		ret = sysfs_emit(buf, "%s\n", device->vendor);
+
+	return ret;
+}
+
+static ssize_t ddcci_attr_module_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct ddcci_device *device = ddcci_verify_device(dev);
+	ssize_t ret = -ENOENT;
+
+	if (device != NULL)
+		ret = sysfs_emit(buf, "%s\n", device->module);
+
+	return ret;
+}
+
+static ssize_t ddcci_attr_serial_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct ddcci_device *device = ddcci_verify_device(dev);
+	ssize_t ret = -ENOENT;
+
+	if (device != NULL)
+		ret = scnprintf(buf, PAGE_SIZE, "%d\n", device->device_number);
+
+	return ret;
+}
+
+static ssize_t ddcci_attr_modalias_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct ddcci_device *device = ddcci_verify_device(dev);
+	ssize_t ret = -ENOENT;
+	char model[ARRAY_SIZE(device->model)];
+	char vendor[ARRAY_SIZE(device->model)];
+	char module[ARRAY_SIZE(device->model)];
+
+	if (device != NULL) {
+		memcpy(model, device->model, sizeof(model));
+		memcpy(vendor, device->vendor, sizeof(vendor));
+		memcpy(module, device->module, sizeof(module));
+		ddcci_modalias_clean(model, sizeof(model), '_');
+		ddcci_modalias_clean(vendor, sizeof(vendor), '_');
+		ddcci_modalias_clean(module, sizeof(module), '_');
+
+		ret = scnprintf(buf, PAGE_SIZE, "%s%s-%s-%s-%s-%s\n",
+			DDCCI_MODULE_PREFIX,
+			device->prot,
+			device->type,
+			model,
+			vendor,
+			module
+		);
+	}
+	return ret;
+}
+
+static DEVICE_ATTR(capabilities, 0444, ddcci_attr_capabilities_show, NULL);
+static DEVICE_ATTR(idProt, 0444, ddcci_attr_prot_show, NULL);
+static DEVICE_ATTR(idType, 0444, ddcci_attr_type_show, NULL);
+static DEVICE_ATTR(idModel, 0444, ddcci_attr_model_show, NULL);
+static DEVICE_ATTR(idVendor, 0444, ddcci_attr_vendor_show, NULL);
+static DEVICE_ATTR(idModule, 0444, ddcci_attr_module_show, NULL);
+static DEVICE_ATTR(idSerial, 0444, ddcci_attr_serial_show, NULL);
+static DEVICE_ATTR(modalias, 0444, ddcci_attr_modalias_show, NULL);
+
+static struct attribute *ddcci_char_device_attrs[] = {
+	&dev_attr_capabilities.attr,
+	&dev_attr_idProt.attr,
+	&dev_attr_idType.attr,
+	&dev_attr_idModel.attr,
+	&dev_attr_idVendor.attr,
+	&dev_attr_idModule.attr,
+	&dev_attr_idSerial.attr,
+	&dev_attr_modalias.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ddcci_char_device);
+
+/* DDC/CI bus */
+
+static int ddcci_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct ddcci_device	*device = to_ddcci_device(dev);
+	char model[ARRAY_SIZE(device->model)];
+	char vendor[ARRAY_SIZE(device->vendor)];
+	char module[ARRAY_SIZE(device->module)];
+
+	memcpy(model, device->model, sizeof(model));
+	memcpy(vendor, device->vendor, sizeof(vendor));
+	memcpy(module, device->module, sizeof(module));
+	ddcci_modalias_clean(model, sizeof(model), '_');
+	ddcci_modalias_clean(vendor, sizeof(vendor), '_');
+	ddcci_modalias_clean(module, sizeof(module), '_');
+
+	if (add_uevent_var(env, "MODALIAS=%s%s-%s-%s-%s-%s",
+			   DDCCI_MODULE_PREFIX,
+			   device->prot,
+			   device->type,
+			   model,
+			   vendor,
+			   module
+		))
+		return -ENOMEM;
+
+	if (device->prot[0])
+		if (add_uevent_var(env, "DDCCI_PROT=%s", device->prot))
+			return -ENOMEM;
+
+	if (device->type[0])
+		if (add_uevent_var(env, "DDCCI_TYPE=%s", device->type))
+			return -ENOMEM;
+
+	if (device->model[0])
+		if (add_uevent_var(env, "DDCCI_MODEL=%s", device->model))
+			return -ENOMEM;
+
+	if (device->vendor[0]) {
+		if (add_uevent_var(env, "DDCCI_VENDOR=%s", device->vendor))
+			return -ENOMEM;
+
+		if (add_uevent_var(env, "DDCCI_MODULE=%s", device->module))
+			return -ENOMEM;
+
+		if (add_uevent_var(env, "DDCCI_UNIQ=%d", device->device_number))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void ddcci_device_release(struct device *dev)
+{
+	struct ddcci_device *device = to_ddcci_device(dev);
+	struct ddcci_driver *driver;
+
+	/* Notify driver */
+	if (dev->driver) {
+		driver = to_ddcci_driver(dev->driver);
+		if (driver->remove)
+			driver->remove(device);
+	}
+
+	/* Teardown chardev */
+	if (dev->devt) {
+		mutex_lock(&core_lock);
+		if (device->cdev.dev == ddcci_cdev_next-1)
+			ddcci_cdev_next--;
+		cdev_del(&device->cdev);
+		mutex_unlock(&core_lock);
+	}
+
+	/* Free capability string */
+	if (device->capabilities) {
+		device->capabilities_len = 0;
+		kfree(device->capabilities);
+	}
+	/* Free device */
+	kfree(device);
+}
+
+static char *ddcci_devnode(struct device *dev,
+			 umode_t *mode, kuid_t *uid, kgid_t *gid)
+{
+	struct ddcci_device *device;
+
+	device = to_ddcci_device(dev);
+	return kasprintf(GFP_KERNEL, "bus/ddcci/%d/display",
+			 device->i2c_client->adapter->nr);
+}
+
+static char *ddcci_dependent_devnode(struct device *dev,
+			 umode_t *mode, kuid_t *uid, kgid_t *gid)
+{
+	struct ddcci_device *device;
+
+	device = to_ddcci_device(dev);
+	if (device->flags & DDCCI_FLAG_EXTERNAL) {
+		if (device->outer_addr == device->inner_addr)
+			return kasprintf(GFP_KERNEL, "bus/ddcci/%d/e%02x",
+					 device->i2c_client->adapter->nr,
+					 device->outer_addr);
+		else
+			return kasprintf(GFP_KERNEL, "bus/ddcci/%d/e%02x%02x",
+					 device->i2c_client->adapter->nr,
+					 device->outer_addr, device->inner_addr);
+	} else {
+		return kasprintf(GFP_KERNEL, "bus/ddcci/%d/i%02x",
+				 device->i2c_client->adapter->nr,
+				 device->inner_addr);
+	}
+}
+
+/* Device type for main DDC/CI devices*/
+static struct device_type ddcci_device_type = {
+	.name	= "ddcci-device",
+	.uevent		= ddcci_device_uevent,
+	.groups		= ddcci_char_device_groups,
+	.release	= ddcci_device_release,
+	.devnode	= ddcci_devnode
+};
+
+/* Device type for dependent DDC/CI devices*/
+static struct device_type ddcci_dependent_type = {
+	.name	= "ddcci-dependent-device",
+	.uevent		= ddcci_device_uevent,
+	.groups		= ddcci_char_device_groups,
+	.release	= ddcci_device_release,
+	.devnode	= ddcci_dependent_devnode
+};
+
+/**
+ * ddcci_verify_device - return parameter as ddcci_device, or NULL
+ * @dev: device, probably from some driver model iterator
+ */
+struct ddcci_device *ddcci_verify_device(struct device *dev)
+{
+	if (!dev)
+		return NULL;
+	return (dev->type == &ddcci_device_type
+		|| dev->type == &ddcci_dependent_type)
+			? to_ddcci_device(dev)
+			: NULL;
+}
+EXPORT_SYMBOL_GPL(ddcci_verify_device);
+
+/**
+ * ddcci_quirks - Get quirks for DDC/CI device
+ * @dev: Target DDC/CI device
+ */
+unsigned long ddcci_quirks(struct ddcci_device *dev)
+{
+	if (WARN_ON(!dev))
+		return ~0L;
+	if (WARN_ON(!dev->bus_drv_data))
+		return ~0L;
+	return dev->bus_drv_data->quirks;
+}
+EXPORT_SYMBOL_GPL(ddcci_quirks);
+
+/**
+ * ddcci_register_driver - register DDC/CI driver
+ * @owner: the owning module
+ * @driver: the driver to register
+ */
+int ddcci_register_driver(struct module *owner, struct ddcci_driver *driver)
+{
+	int ret;
+
+	pr_debug("registering driver [%s]\n", driver->driver.name);
+
+	/* add the driver to the list of ddcci drivers in the driver core */
+	driver->driver.owner = owner;
+	driver->driver.bus = &ddcci_bus_type;
+
+	/* When registration returns, the driver core
+	 * will have called probe() for all matching-but-unbound devices.
+	 */
+	ret = driver_register(&driver->driver);
+	if (ret)
+		return ret;
+
+	pr_debug("driver [%s] registered\n", driver->driver.name);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ddcci_register_driver);
+
+/**
+ * ddcci_del_driver - unregister DDC/CI driver
+ * @driver: the driver being unregistered
+ */
+void ddcci_del_driver(struct ddcci_driver *driver)
+{
+	driver_unregister(&driver->driver);
+	pr_debug("driver [%s] unregistered\n", driver->driver.name);
+}
+EXPORT_SYMBOL_GPL(ddcci_del_driver);
+
+/**
+ * ddcci_device_write - Write a message to a DDC/CI device
+ * @dev: Target DDC/CI device
+ * @p_flag: Protocol flag, true for standard control messages
+ * @data: Data that will be written to the device
+ * @length: How many bytes to write
+ *
+ * Writes the message to the device and sleeps for 'delay' milliseconds
+ */
+int ddcci_device_write(struct ddcci_device *dev, bool p_flag,
+		       unsigned char *data, unsigned char length)
+{
+	int ret;
+
+	if (mutex_lock_interruptible(&dev->bus_drv_data->mut))
+		return -EAGAIN;
+
+	ret = ddcci_write(dev->bus_drv_data->i2c_dev, dev->inner_addr, p_flag, data, length);
+	msleep(delay);
+	mutex_unlock(&dev->bus_drv_data->mut);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ddcci_device_write);
+
+/**
+ * ddcci_device_read - Read a response from a DDC/CI device
+ * @dev: Target DDC/CI device
+ * @p_flag: Protocol flag, must match the corresponding write
+ * @buffer: Where to store data read from the device
+ * @length: Buffer size
+ */
+int ddcci_device_read(struct ddcci_device *dev, bool p_flag,
+		      unsigned char *buffer, unsigned char length)
+{
+	int ret;
+
+	if (mutex_lock_interruptible(&dev->bus_drv_data->mut))
+		return -EAGAIN;
+
+	ret = ddcci_read(dev->bus_drv_data->i2c_dev, dev->inner_addr, p_flag, buffer, length);
+	mutex_unlock(&dev->bus_drv_data->mut);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ddcci_device_read);
+
+/**
+ * ddcci_device_writeread - Write a message to a device and read the response
+ * @dev: Target DDC/CI device
+ * @p_flag: Protocol flag, true for standard control messages
+ * @buffer: Buffer used for write and read
+ * @length: How many bytes to write
+ * @maxlength: Buffer size on read
+ *
+ * Writing, sleeping and reading are done without releasing the DDC/CI bus.
+ * This provides atomicity in respect to other DDC/CI accesses on the same bus.
+ */
+int ddcci_device_writeread(struct ddcci_device *dev, bool p_flag,
+			   unsigned char *buffer, unsigned char length,
+			   unsigned char maxlength)
+{
+	int ret;
+
+	if (mutex_lock_interruptible(&dev->bus_drv_data->mut))
+		return -EAGAIN;
+
+	ret = ddcci_write(dev->bus_drv_data->i2c_dev, dev->inner_addr, p_flag, buffer, length);
+	if (ret < 0)
+		goto err;
+	msleep(delay);
+	ret = ddcci_read(dev->bus_drv_data->i2c_dev, dev->inner_addr, p_flag, buffer, maxlength);
+err:
+	mutex_unlock(&dev->bus_drv_data->mut);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ddcci_device_writeread);
+
+#define IS_ANY_ID(x) (((x)[0] == -1) && ((x)[7] == -1))
+
+/* Check if any device id in the array matches the device and return the matching id */
+static const struct ddcci_device_id *ddcci_match_id(const struct ddcci_device_id *id,
+						    const struct ddcci_device *device)
+{
+	while (id->prot[0] || id->type[0] || id->model[0] || id->vendor[0] || id->module[0]) {
+		if ((IS_ANY_ID(id->prot) || (strcmp(device->prot, id->prot) == 0))
+		 && (IS_ANY_ID(id->type) || (strcmp(device->type, id->type) == 0))
+		 && (IS_ANY_ID(id->model) || (strcmp(device->model, id->model) == 0))
+		 && (IS_ANY_ID(id->vendor) || (strcmp(device->vendor, id->vendor) == 0))
+		 && (IS_ANY_ID(id->module) || (strcmp(device->module, id->module) == 0))) {
+			return id;
+		}
+		id++;
+	}
+	return NULL;
+}
+
+static int ddcci_device_match(struct device *dev, struct device_driver *drv)
+{
+	struct ddcci_device	*device = ddcci_verify_device(dev);
+	struct ddcci_driver	*driver;
+
+	if (!device)
+		return 0;
+
+	driver = to_ddcci_driver(drv);
+	/* match on an id table if there is one */
+	if (driver->id_table)
+		return ddcci_match_id(driver->id_table, device) != NULL;
+
+	return 0;
+}
+
+static int ddcci_device_probe(struct device *dev)
+{
+	struct ddcci_device	*device = ddcci_verify_device(dev);
+	struct ddcci_driver	*driver;
+	const struct ddcci_device_id *id;
+	int ret = 0;
+
+	if (!device)
+		return -EINVAL;
+	driver = to_ddcci_driver(dev->driver);
+
+	id = ddcci_match_id(driver->id_table, device);
+	if (!id)
+		return -ENODEV;
+
+	if (driver->probe)
+		ret = driver->probe(device, id);
+
+	return ret;
+}
+
+static void ddcci_device_remove(struct device *dev)
+{
+	struct ddcci_device	*device = ddcci_verify_device(dev);
+	struct ddcci_driver	*driver;
+	int ret = 0;
+
+	if (!device)
+		return;
+	driver = to_ddcci_driver(dev->driver);
+
+	if (driver->remove)
+		ret = driver->remove(device);
+}
+
+/**
+ * DDCCI bus type structure
+ */
+struct bus_type ddcci_bus_type = {
+	.name		= "ddcci",
+	.match		= ddcci_device_match,
+	.probe		= ddcci_device_probe,
+	.remove		= ddcci_device_remove
+};
+
+/* Main I2C driver */
+
+/* Get a pointer to the closing parenthesis */
+static char *ddcci_capstr_tok(const char *s, int depth)
+{
+	const char *ptr = s;
+	char *end;
+
+	if (s == NULL || s[0] == '\0')
+		return NULL;
+
+	while ((end = strpbrk(ptr, "()"))) {
+		if (!end || depth == INT_MAX)
+			return NULL;
+		if (*end == '(')
+			depth++;
+		else if (depth > 0)
+			depth--;
+		else
+			break;
+		ptr = end + 1;
+	}
+	return end;
+}
+
+/**
+ * ddcci_find_capstr_item - Search capability string for a tag
+ * @capabilities: Capability string to search
+ * @tag: Tag to find
+ * @length: Buffer for the length of the found tag value (optional)
+ *
+ * Return a pointer to the start of the tag value (directly after the '(') on
+ * success and write the length of the value (excluding the ')') into `length`.
+ *
+ * If the tag is not found or another error occurs, an ERR_PTR is returned
+ * and `length` stays untouched.
+ */
+const char *ddcci_find_capstr_item(const char *capabilities,
+				   const char *__restrict tag,
+				   size_t *length)
+{
+	const char *src = capabilities, *ptr;
+	ptrdiff_t len;
+	int taglen = strnlen(tag, 1024);
+
+	/* Check length of requested tag */
+	if (taglen <= 0 || taglen > 1023)
+		return ERR_PTR(-EINVAL);
+
+	/* Find tag */
+	while (src && (strncmp(src + 1, tag, taglen) != 0 || src[1 + taglen] != '('))
+		src = ddcci_capstr_tok(src + 1, -1);
+	if (!src || src[0] == '\0')
+		return ERR_PTR(-ENOENT);
+
+	/* Locate end of value */
+	src += taglen + 2;
+	ptr = ddcci_capstr_tok(src, 0);
+	if (!ptr)
+		return ERR_PTR(-EOVERFLOW);
+
+	/* Check length of tag data */
+	len = ptr-src;
+	if (len < 0 || len > 65535)
+		return ERR_PTR(-EMSGSIZE);
+
+	/* Return pointer and length */
+	if (length != NULL)
+		*length = (size_t)len;
+	return src;
+}
+EXPORT_SYMBOL_GPL(ddcci_find_capstr_item);
+
+/* Search the capability string for a tag and copy the value to dest */
+static int ddcci_cpy_capstr_item(char *dest, const char *src,
+				  const char *__restrict tag, size_t maxlen)
+{
+	const char *ptr;
+	size_t len;
+
+	/* Find tag */
+	ptr = ddcci_find_capstr_item(src, tag, &len);
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+
+	/* Copy value */
+	memcpy(dest, ptr, min(len, maxlen));
+	return 0;
+}
+
+/* Fill fields in device by parsing the capability string */
+static int ddcci_parse_capstring(struct ddcci_device *device)
+{
+	const char *capstr = device->capabilities;
+	int ret = 0;
+
+	if (!capstr)
+		return -EINVAL;
+
+	/* capability string start with a paren */
+	if (capstr[0] != '(')
+		return -EINVAL;
+
+	/* get prot(...) */
+	ret = ddcci_cpy_capstr_item(device->prot, capstr, "prot", sizeof(device->prot)-1);
+	if (ret) {
+		if (ret == -ENOENT) {
+			dev_warn(&device->dev, "malformed capability string: no protocol tag");
+			memset(device->prot, 0, sizeof(device->prot)-1);
+		} else {
+			return ret;
+		}
+	}
+
+	/* get type(...) */
+	ret = ddcci_cpy_capstr_item(device->type, capstr, "type", sizeof(device->type)-1);
+	if (ret) {
+		if (ret == -ENOENT) {
+			dev_warn(&device->dev, "malformed capability string: no type tag");
+			memset(device->type, 0, sizeof(device->type)-1);
+		} else {
+			return ret;
+		}
+	}
+
+	/* and then model(...) */
+	ret = ddcci_cpy_capstr_item(device->model, capstr, "model", sizeof(device->model)-1);
+	if (ret) {
+		if (ret == -ENOENT) {
+			dev_warn(&device->dev, "malformed capability string: no model tag");
+			memset(device->model, 0, sizeof(device->model)-1);
+		} else {
+			return ret;
+		}
+	}
+
+	/* if there is no protocol tag */
+	if (!device->prot[0]) {
+		/* and no type tag: give up. */
+		if (!device->type[0])
+			return -ENOENT;
+
+		/* Assume protocol "monitor" if type is "LCD" or "CRT" */
+		if (strncasecmp(device->type, "LCD", sizeof(device->type)-1) == 0
+		 || strncasecmp(device->type, "CRT", sizeof(device->type)-1) == 0) {
+			memcpy(device->prot, "monitor", 7);
+		}
+	}
+
+	/* skip the rest for now */
+
+	return 0;
+}
+
+/* Probe for a device on an inner address and create a ddcci_device for it */
+static int ddcci_detect_device(struct i2c_client *client, unsigned char addr,
+			       int dependent)
+{
+	int ret;
+	unsigned char outer_addr = client->addr << 1;
+	unsigned char *buffer = NULL;
+	struct ddcci_bus_drv_data *drv_data = i2c_get_clientdata(client);
+	struct ddcci_device *device = NULL;
+
+	mutex_lock(&drv_data->mut);
+
+	/* Allocate buffer big enough for any capability string */
+	buffer = kmalloc(16384, GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto err_end;
+	}
+
+	/* Allocate device struct */
+	device = kzalloc(sizeof(struct ddcci_device), GFP_KERNEL);
+	if (!device) {
+		ret = -ENOMEM;
+		goto err_end;
+	}
+
+	/* Initialize device */
+	device_initialize(&device->dev);
+	device->dev.parent = &client->dev;
+	device->dev.bus = &ddcci_bus_type;
+	device->outer_addr = outer_addr;
+	device->inner_addr = addr;
+	device->bus_drv_data = drv_data;
+	device->i2c_client = client;
+
+	if (!dependent) {
+		device->dev.type = &ddcci_device_type;
+		ret = dev_set_name(&device->dev, "ddcci%d", client->adapter->nr);
+	} else if (outer_addr == dependent) {
+		/* Internal dependent device */
+		device->dev.type = &ddcci_dependent_type;
+		device->flags = DDCCI_FLAG_DEPENDENT;
+		ret = dev_set_name(&device->dev, "ddcci%di%02x", client->adapter->nr, addr);
+	} else if (outer_addr == addr) {
+		/* External dependent device */
+		device->dev.type = &ddcci_dependent_type;
+		device->flags = DDCCI_FLAG_DEPENDENT | DDCCI_FLAG_EXTERNAL;
+		ret = dev_set_name(&device->dev, "ddcci%de%02x", client->adapter->nr, addr);
+	} else {
+		/* Dependent device of external dependent device Just in case something like this exists */
+		device->dev.type = &ddcci_dependent_type;
+		device->flags = DDCCI_FLAG_DEPENDENT | DDCCI_FLAG_EXTERNAL;
+		ret = dev_set_name(&device->dev, "ddcci%de%02x%02x", client->adapter->nr, outer_addr, addr);
+	}
+
+	if (ret)
+		goto err_free;
+
+	/* Read identification and check for quirks */
+	ret = ddcci_identify_device(client, addr, buffer, 29);
+	if (ret < 0) {
+		if (!dependent && (ret == -EBADMSG || ret == -EMSGSIZE))
+			dev_warn(&device->dev, "DDC/CI main device sent broken response on identification. Trying to detect solely based on capability information.\n");
+		else
+			goto err_free;
+	}
+
+	if (ret == 29 && buffer[0] == DDCCI_REPLY_ID) {
+		memcpy(device->vendor, &buffer[7], 8);
+		memcpy(device->module, &buffer[17], 8);
+		device->device_number = be32_to_cpu(*(__force __be32 *)&buffer[18]);
+	}
+
+	/* Read capabilities */
+	ret = ddcci_get_caps(client, addr, buffer, 16384);
+	if (ret > 0) {
+		/*
+		 *	Fixup unparenthesized capability strings, but only if the first
+		 *	character is an ascii lower case letter.
+		 *	This should still allow an early exit for completely garbled
+		 *	data but helps detecting devices where only the parentheses are
+		 *	missing, as the second char must be the first character of a
+		 *	keyword.
+		 */
+		if (ret > 2 && buffer[0] >= 'a' && buffer[0] <= 'z') {
+			dev_err(&device->dev, "DDC/CI device quirk detected: unparenthesized capability string\n");
+			device->capabilities = kzalloc(ret + 3, GFP_KERNEL);
+			if (!device->capabilities) {
+				ret = -ENOMEM;
+				goto err_free;
+			}
+			device->capabilities_len = ret + 2;
+			memcpy(&(device->capabilities[1]), buffer, ret);
+			device->capabilities[0] = '(';
+			device->capabilities[ret + 1] = ')';
+		} else {
+			/* Standard case: simply copy the received string */
+			device->capabilities = kzalloc(ret + 1, GFP_KERNEL);
+			if (!device->capabilities) {
+				ret = -ENOMEM;
+				goto err_free;
+			}
+			device->capabilities_len = ret;
+			memcpy(device->capabilities, buffer, ret);
+		}
+
+		ret = ddcci_parse_capstring(device);
+		if (ret) {
+			dev_err(&device->dev, "malformed capability string: \"%s\" errno %d\n", device->capabilities, ret);
+			ret = -EINVAL;
+			goto err_free;
+		}
+	}
+
+	/* Found a device if either identification or capabilities succeeded */
+	if (!device->capabilities && device->vendor[0] == '\0') {
+		dev_dbg(&client->dev,
+			"[%02x:%02x] got neither valid identification nor capability data\n",
+			client->addr << 1, addr);
+		ret = -ENODEV;
+		goto err_free;
+	}
+
+	/* Setup chardev */
+	mutex_lock(&core_lock);
+	ret = ddcci_setup_char_device(device);
+	mutex_unlock(&core_lock);
+	if (ret)
+		goto err_free;
+
+	/* Release mutex and add device to the tree */
+	mutex_unlock(&drv_data->mut);
+	pr_debug("found device at %d:%02x:%02x\n", client->adapter->nr, outer_addr, addr);
+	ret = device_add(&device->dev);
+	if (ret)
+		goto err_free;
+
+	goto end;
+err_free:
+	put_device(&device->dev);
+err_end:
+	mutex_unlock(&drv_data->mut);
+end:
+	kfree(buffer);
+	return ret;
+}
+
+/* I2C detect function: check if a main or external dependent device exists */
+static int ddcci_detect(struct i2c_client *client, struct i2c_board_info *info)
+{
+	int ret;
+	unsigned char outer_addr;
+	unsigned char inner_addr;
+	unsigned char buf[32];
+	unsigned char cmd_id[1] = { DDCCI_COMMAND_ID };
+	unsigned char cmd_caps[3] = { DDCCI_COMMAND_CAPS, 0x00, 0x00};
+	unsigned char *cmd;
+	unsigned int cmd_len;
+
+	/* Check for i2c_master_* functionality */
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		pr_debug("i2c adapter %d unsuitable: no i2c_master functionality\n", client->adapter->nr);
+		return -ENODEV;
+	}
+
+	/* send Capabilities Request (for main) or Identification Request command (for dependent devices) */
+	outer_addr = client->addr << 1;
+	inner_addr = (outer_addr == DDCCI_DEFAULT_DEVICE_ADDR) ? DDCCI_HOST_ADDR_ODD : outer_addr | 1;
+	cmd = (outer_addr == DDCCI_DEFAULT_DEVICE_ADDR) ? cmd_caps : cmd_id;
+	cmd_len = (outer_addr == DDCCI_DEFAULT_DEVICE_ADDR) ? sizeof(cmd_caps) : sizeof(cmd_id);
+	pr_debug("detecting %d:%02x\n", client->adapter->nr, outer_addr);
+
+	ret = __ddcci_write_block(client, inner_addr, buf, true, cmd, cmd_len);
+
+	if (ret == -ENXIO || ret == -EIO) {
+		if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WRITE_BYTE)) {
+			pr_debug("i2c write failed with ENXIO or EIO but bytewise writing is not supported\n");
+			return -ENODEV;
+		}
+		pr_debug("i2c write failed with ENXIO or EIO, trying bytewise writing\n");
+		ret = __ddcci_write_bytewise(client, inner_addr, true, cmd, cmd_len);
+		if (ret == 0) {
+			msleep(delay);
+			ret = __ddcci_write_bytewise(client, inner_addr, true, cmd, cmd_len);
+		}
+	}
+
+	if (ret < 0)
+		return -ENODEV;
+
+	/* wait for device */
+	msleep(delay);
+	/* receive answer */
+	ret = i2c_master_recv(client, buf, 32);
+	if (ret < 3) {
+		pr_debug("detection failed: no answer\n");
+		return -ENODEV;
+	}
+
+	/* check response starts with outer addr */
+	if (buf[0] != outer_addr) {
+		pr_debug("detection failed: invalid %s response (%02x != %02x)\n", (cmd == cmd_id) ? "identification" : "capabilities", buf[0], outer_addr);
+		pr_debug("received message was %*ph \n", ret, buf);
+		return -ENODEV;
+	}
+
+	pr_debug("detected %d:%02x\n", client->adapter->nr, outer_addr);
+
+	/* set device type */
+	strlcpy(info->type, (outer_addr == DDCCI_DEFAULT_DEVICE_ADDR) ? "ddcci" : "ddcci-dependent", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+/* I2C probe function */
+static int ddcci_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	int i, ret = -ENODEV, tmp;
+	unsigned char main_addr, addr;
+	struct ddcci_bus_drv_data *drv_data;
+
+	/* Initialize driver data structure */
+	drv_data = devm_kzalloc(&client->dev, sizeof(struct ddcci_bus_drv_data), GFP_KERNEL);
+	if (!drv_data)
+		return -ENOMEM;
+	drv_data->i2c_dev = client;
+	mutex_init(&drv_data->mut);
+
+	/* Set i2c client data */
+	i2c_set_clientdata(client, drv_data);
+
+	if (id->driver_data == 0) {
+		/* Core device, probe at 0x6E */
+		main_addr = DDCCI_DEFAULT_DEVICE_ADDR;
+		dev_dbg(&client->dev, "probing core device [%02x]\n",
+			client->addr << 1);
+		ret = ddcci_detect_device(client, main_addr, 0);
+		if (ret) {
+			dev_info(&client->dev, "core device [%02x] probe failed: %d\n",
+				 client->addr << 1, ret);
+			if (ret == -EIO)
+				ret = -ENODEV;
+			goto err_free;
+		}
+
+		/* Detect internal dependent devices */
+		dev_dbg(&client->dev, "probing internal dependent devices\n");
+		for (i = 0; i < autoprobe_addr_count; ++i) {
+			addr = (unsigned short)autoprobe_addrs[i];
+			if ((addr & 1) == 0 && addr != main_addr) {
+				tmp = ddcci_detect_device(client, addr, main_addr);
+				if (tmp < 0 && tmp != -ENODEV) {
+					dev_info(&client->dev, "internal dependent device [%02x:%02x] probe failed: %d\n",
+						 client->addr << 1, addr, ret);
+				}
+			}
+		}
+	} else if (id->driver_data == 1) {
+		/* External dependent device */
+		main_addr = client->addr << 1;
+		dev_dbg(&client->dev, "probing external dependent device [%02x]\n", main_addr);
+		ret = ddcci_detect_device(client, main_addr, -1);
+		if (ret) {
+			dev_info(&client->dev, "external dependent device [%02x] probe failed: %d\n",
+				 main_addr, ret);
+			if (ret == -EIO)
+				ret = -ENODEV;
+			goto err_free;
+		}
+	} else {
+		dev_warn(&client->dev,
+			 "probe() called with invalid i2c device id\n");
+		ret = -EINVAL;
+	}
+
+	goto end;
+err_free:
+	devm_kfree(&client->dev, drv_data);
+end:
+	return ret;
+}
+
+/*
+ * Callback for bus_find_device() used in ddcci_remove()
+ *
+ * Find next device on i2c_client not flagged with
+ * DDCCI_FLAG_REMOVED and flag it.
+ */
+static int ddcci_remove_helper(struct device *dev, const void *p)
+{
+	struct ddcci_device *device;
+
+	device = ddcci_verify_device(dev);
+	if (!device || device->flags & DDCCI_FLAG_REMOVED)
+		return 0;
+
+	if (!p || (dev->parent == p)) {
+		device->flags |= DDCCI_FLAG_REMOVED;
+		/* Memory Barrier */
+		wmb();
+		return 1;
+	}
+
+	return 0;
+}
+
+/* I2C driver remove callback: unregister all subdevices */
+static int ddcci_remove(struct i2c_client *client)
+{
+	struct ddcci_bus_drv_data *drv_data = i2c_get_clientdata(client);
+	struct device *dev;
+
+	mutex_lock(&drv_data->mut);
+	while (1) {
+		dev = bus_find_device(&ddcci_bus_type, NULL, client,
+				      ddcci_remove_helper);
+		if (!dev)
+			break;
+		device_unregister(dev);
+		put_device(dev);
+	}
+	mutex_unlock(&drv_data->mut);
+	return 0;
+}
+
+/*
+ * I2C driver device identification table.
+ */
+static const struct i2c_device_id ddcci_idtable[] = {
+	{ "ddcci", 0 },
+	{ "ddcci-dependent", 1 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ddcci_idtable);
+
+/*
+ * I2C driver description structure
+ */
+static struct i2c_driver ddcci_driver = {
+	.driver = {
+		.name	= "ddcci",
+		.owner	= THIS_MODULE,
+	},
+
+	.id_table	= ddcci_idtable,
+	.probe		= ddcci_probe,
+	.remove		= ddcci_remove,
+	.class		= I2C_CLASS_DDC,
+	.detect		= ddcci_detect,
+	.address_list	= I2C_ADDRS(
+		DDCCI_DEFAULT_DEVICE_ADDR>>1
+	),
+};
+
+/*
+ * Module initialization function. Called when the module is inserted or
+ * (if builtin) at boot time.
+ */
+static int __init ddcci_module_init(void)
+{
+	int ret;
+
+	pr_debug("initializing ddcci driver\n");
+	/* Allocate a device number region for the character devices */
+	ret = alloc_chrdev_region(&ddcci_cdev_first, 0, 128, DEVICE_NAME);
+	if (ret < 0) {
+		pr_err("failed to register device region: error %d\n", ret);
+		goto err_chrdevreg;
+	}
+	ddcci_cdev_next = ddcci_cdev_first;
+	ddcci_cdev_end = MKDEV(MAJOR(ddcci_cdev_first), MINOR(ddcci_cdev_first) + 128);
+
+	/* Register bus */
+	ret = bus_register(&ddcci_bus_type);
+	if (ret) {
+		pr_err("failed to register bus 'ddcci'\n");
+		goto err_busreg;
+	}
+
+	/* Register I2C driver */
+	ret = i2c_add_driver(&ddcci_driver);
+	if (ret) {
+		pr_err("failed to register i2c driver\n");
+		goto err_drvreg;
+	}
+
+	pr_debug("ddcci driver initialized\n");
+
+	return 0;
+
+err_drvreg:
+	bus_unregister(&ddcci_bus_type);
+err_busreg:
+	unregister_chrdev_region(ddcci_cdev_first, 128);
+err_chrdevreg:
+	return ret;
+}
+
+/*
+ * Module clean-up function. Called when the module is removed.
+ */
+static void __exit ddcci_module_exit(void)
+{
+	struct device *dev;
+
+	while (1) {
+		dev = bus_find_device(&ddcci_bus_type, NULL, NULL, ddcci_remove_helper);
+		if (!dev)
+			break;
+		device_unregister(dev);
+		put_device(dev);
+	}
+
+	i2c_del_driver(&ddcci_driver);
+	bus_unregister(&ddcci_bus_type);
+	unregister_chrdev_region(ddcci_cdev_first, 128);
+}
+
+/* Let the kernel know the calls for module init and exit */
+module_init(ddcci_module_init);
+module_exit(ddcci_module_exit);
+
+/* Module description */
+MODULE_AUTHOR("Christoph Grenz <christophg+lkml@grenz-bonn.de>");
+MODULE_DESCRIPTION("DDC/CI bus driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/ddcci.h b/include/linux/ddcci.h
new file mode 100644
index 000000000000..690a9ff85d43
--- /dev/null
+++ b/include/linux/ddcci.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  DDC/CI bus driver
+ *
+ *  Copyright (c) 2015 Christoph Grenz
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#ifndef _DDCCI_H
+#define _DDCCI_H
+
+#include <linux/mod_devicetable.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
+
+#define DDCCI_MODULE_PREFIX "ddcci:"
+
+/* Special addresses */
+
+/* default device address (even) */
+#define DDCCI_DEFAULT_DEVICE_ADDR	0x6E
+/* receiving host address for communication with default device address */
+#define DDCCI_HOST_ADDR_EVEN	0x50
+/* sending host address for communication with default device address */
+#define DDCCI_HOST_ADDR_ODD	0x51
+
+/* Command codes */
+
+/* Identification Request */
+#define DDCCI_COMMAND_ID	0xf1
+/* Identification Reply */
+#define DDCCI_REPLY_ID	0xe1
+/* Capabilities Request */
+#define DDCCI_COMMAND_CAPS	0xf3
+/* Capabilities Reply */
+#define DDCCI_REPLY_CAPS	0xe3
+
+/* Quirks */
+
+/* Device always responds with unset protocol flag */
+#define DDCCI_QUIRK_NO_PFLAG BIT(1)
+/* Device needs writing one byte at a time  */
+#define DDCCI_QUIRK_WRITE_BYTEWISE BIT(2)
+/* Device repeats first byte on read */
+#define DDCCI_QUIRK_SKIP_FIRST_BYTE BIT(3)
+
+/* Flags */
+
+#define DDCCI_FLAG_REMOVED BIT(1)
+#define DDCCI_FLAG_DEPENDENT BIT(2)
+#define DDCCI_FLAG_EXTERNAL BIT(3)
+
+extern struct bus_type ddcci_bus_type;
+
+struct ddcci_bus_drv_data;
+
+/* struct ddcci_device_id - identifies DDC/CI devices for probing */
+struct ddcci_device_id {
+	char prot[9];
+	char type[9];
+	char model[9];
+	char vendor[9];
+	char module[9];
+	kernel_ulong_t driver_data;	/* Data private to the driver */
+};
+#define DDCCI_ANY_ID "\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF"
+
+/**
+ * struct ddcci_device - represent an DDC/CI device
+ * @outer_addr: Outer device address (I2C address << 1).
+ * @inner_addr: Inner device address.
+ * @flags: Device flags.
+ * @capabilities: Device capability string.
+ * @capabilities_len: Length of capability string.
+ * @i2c_client: Parent I2C device.
+ * @bus_drv_data: Driver internal data structure.
+ * @dev: Driver model device node for the slave.
+ * @cdev: Character device structure
+ * @prot: Device class ("protocol", from capability string)
+ * @type: Device subclass ("type", from capability string)
+ * @model: Device model (from capability string)
+ * @vendor: Device vendor (from identification command response)
+ * @module: Device module (from identification command response)
+ * @device_number: Device serial (from identification command response)
+ */
+struct ddcci_device {
+	unsigned short outer_addr;
+	unsigned short inner_addr;
+	int flags;
+	char *capabilities;
+	size_t capabilities_len;
+	struct i2c_client *i2c_client;
+	struct ddcci_bus_drv_data *bus_drv_data;
+	struct device dev;
+	struct cdev cdev;
+	char prot[9];
+	char type[9];
+	char model[9];
+	char vendor[9];
+	char module[9];
+	int device_number;
+};
+#define to_ddcci_device(d) container_of(d, struct ddcci_device, dev)
+
+/**
+ * struct ddcci_driver - represent an DDC/CI device driver
+ * @probe: Callback for device binding
+ * @remove: Callback for device unbinding
+ * @driver: Device driver model driver
+ * @id_table: List of DDC/CI devices supported by this driver
+ *
+ * The driver.owner field should be set to the module owner of this driver.
+ * The driver.name field should be set to the name of this driver.
+ */
+struct ddcci_driver {
+	int (*probe)(struct ddcci_device *, const struct ddcci_device_id *);
+	int (*remove)(struct ddcci_device *);
+	struct device_driver driver;
+	struct ddcci_device_id *id_table;
+};
+#define to_ddcci_driver(d) container_of(d, struct ddcci_driver, driver)
+
+int ddcci_register_driver(struct module *owner, struct ddcci_driver *driver);
+#define ddcci_add_driver(driver) \
+	ddcci_register_driver(THIS_MODULE, driver)
+void ddcci_del_driver(struct ddcci_driver *driver);
+
+struct ddcci_device *ddcci_verify_device(struct device *dev);
+
+#define module_ddcci_driver(__ddcci_driver) \
+	module_driver(__ddcci_driver, ddcci_add_driver, \
+			ddcci_del_driver)
+
+int ddcci_device_write(struct ddcci_device *, bool p_flag, unsigned char *data,
+		       unsigned char length);
+int ddcci_device_read(struct ddcci_device *, bool p_flag, unsigned char *buffer,
+		      unsigned char length);
+int ddcci_device_writeread(struct ddcci_device *, bool p_flag,
+			   unsigned char *buffer, unsigned char length,
+			   unsigned char maxlength);
+
+static inline void *ddcci_get_drvdata(const struct ddcci_device *dev)
+{
+	return dev_get_drvdata(&dev->dev);
+}
+
+static inline void ddcci_set_drvdata(struct ddcci_device *dev, void *data)
+{
+	dev_set_drvdata(&dev->dev, data);
+}
+
+unsigned long ddcci_quirks(struct ddcci_device *dev);
+
+const char *ddcci_find_capstr_item(const char *capabilities, const char *tag,
+				   size_t *length);
+
+#endif
-- 
2.25.1

