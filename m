Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB94B4BA5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243230AbiBQQ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:28:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243170AbiBQQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B59D4FD;
        Thu, 17 Feb 2022 08:27:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x5so10580488edd.11;
        Thu, 17 Feb 2022 08:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mas+9N7L524k9yXfyt7IyKEXpOJzWr7GYmcRF4hgJzc=;
        b=IVCA5D8V2+8CayOhBu389rDso1vxrJg8u/MGy0poz/F6x3tocG6VZnVaduzigHWOQQ
         HDnWaM6FCgqETFrI/x7xvIeh5yBTzXa3hy+kvXkJBkfeHdxxp3F7bG0PcClMN7An2SqB
         BCbGAr0gAhh3DcE2QhN5GFldjRTl49w6J+loly4gYPNobeegmgoG0XE0OaEdUxYkHmJm
         3mz8GeB1smO2emKEbcdw1Rtwn+ItiCbIxrL0XvITGqfofQ49IVBm/q/cs/GNnxEVJ3HN
         osDMBUn5scBfezUNi4hW1OZcl44V0SEd3Of4kWOd5G4NefSyDT0/A2M0JR7/B9iO3crk
         hs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mas+9N7L524k9yXfyt7IyKEXpOJzWr7GYmcRF4hgJzc=;
        b=2fvoDlBCkKiMxdflmyK81YwfwAv7aGFGAFnIpqUNX5aYFVKeuPkkjwgnChAq5GU2FT
         +54/neSKXGEEQXjGKdu1pKgxxvVXN8XzS7imqXE6XvTrSq3yQYxDk45kVjnxcdKlxHtH
         AEiLbVlKNap7cX/b32oJzHd3ACrWQxb4LaISipz7r2/x5DkXrYF27+AoAkOfSBkH3pXh
         DTiHGtSvcYFkRxKSPTtE/hTwFCB1GLaLNB8wt2JVGfeV1n6Y7Soi690I8Hy4/XpLRnef
         JuUL8NbD2/a6DHr/q6pnrAeeut+9TUM5mZcOLBouapno8zSJUme2e3TFOTBNvjt7exYM
         DBzQ==
X-Gm-Message-State: AOAM532F0QKYQX0lMpHMYSYsEnm07gl9CuCYxQQac4UBaNsdaKAJvjAD
        f9nmSpsxEs+9B5YP6wrsvLVBG9PToMn1fGBu
X-Google-Smtp-Source: ABdhPJwpsko3GtJeaQhU1A4dkh7xdLUQyTLul720dd6CMz7UBZ/1sjCG4yxc6VgLL8Yw8IAC3ly1GA==
X-Received: by 2002:a05:6402:348b:b0:412:b020:ec83 with SMTP id v11-20020a056402348b00b00412b020ec83mr1906645edc.355.1645115253698;
        Thu, 17 Feb 2022 08:27:33 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:33 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v3 11/13] iio: imu: add BNO055 serdev driver
Date:   Thu, 17 Feb 2022 17:27:08 +0100
Message-Id: <20220217162710.33615-12-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217162710.33615-1-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
MIME-Version: 1.0
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

This path adds a serdev driver for communicating to a BNO055 IMU via
serial bus, and it enables the BNO055 core driver to work in this
scenario.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/imu/bno055/Kconfig     |  10 +
 drivers/iio/imu/bno055/Makefile    |   1 +
 drivers/iio/imu/bno055/bno055_sl.c | 557 +++++++++++++++++++++++++++++
 3 files changed, 568 insertions(+)
 create mode 100644 drivers/iio/imu/bno055/bno055_sl.c

diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
index d0ab3221fba5..8a83639ad2a9 100644
--- a/drivers/iio/imu/bno055/Kconfig
+++ b/drivers/iio/imu/bno055/Kconfig
@@ -2,3 +2,13 @@
 
 config BOSCH_BNO055_IIO
 	tristate
+
+config BOSCH_BNO055_SERIAL
+	tristate "Bosch BNO055 attached via serial bus"
+	depends on SERIAL_DEV_BUS
+	select BOSCH_BNO055_IIO
+	help
+	  Enable this to support Bosch BNO055 IMUs attached via serial bus.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called bno055_sl.
diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
index 56cc4de60a7e..416f0ff96de5 100644
--- a/drivers/iio/imu/bno055/Makefile
+++ b/drivers/iio/imu/bno055/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_BOSCH_BNO055_IIO) += bno055.o
+obj-$(CONFIG_BOSCH_BNO055_SERIAL) += bno055_sl.o
diff --git a/drivers/iio/imu/bno055/bno055_sl.c b/drivers/iio/imu/bno055/bno055_sl.c
new file mode 100644
index 000000000000..5af44f151389
--- /dev/null
+++ b/drivers/iio/imu/bno055/bno055_sl.c
@@ -0,0 +1,557 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Serial line interface for Bosh BNO055 IMU (via serdev).
+ * This file implements serial communication up to the register read/write
+ * level.
+ *
+ * Copyright (C) 2021 Istituto Italiano di Tecnologia
+ * Electronic Design Laboratory
+ * Written by Andrea Merello <andrea.merello@iit.it>
+ *
+ * This driver is besed on
+ *	Plantower PMS7003 particulate matter sensor driver
+ *	Which is
+ *	Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
+ */
+
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/serdev.h>
+
+#include "bno055.h"
+
+/*
+ * Register writes cmd have the following format
+ * +------+------+-----+-----+----- ... ----+
+ * | 0xAA | 0xOO | REG | LEN | payload[LEN] |
+ * +------+------+-----+-----+----- ... ----+
+ *
+ * Register write responses have the following format
+ * +------+----------+
+ * | 0xEE | ERROCODE |
+ * +------+----------+
+ *
+ * .. except when writing the SYS_RST bit (i.e. triggering a system reset); in
+ * case the IMU accepts the command, then it resets without responding. We don't
+ * handle this (yet) here (so we inform the common bno055 code not to perform
+ * sw resets - bno055 on serial bus basically requires the hw reset pin).
+ *
+ * Register read have the following format
+ * +------+------+-----+-----+
+ * | 0xAA | 0xO1 | REG | LEN |
+ * +------+------+-----+-----+
+ *
+ * Successful register read response have the following format
+ * +------+-----+----- ... ----+
+ * | 0xBB | LEN | payload[LEN] |
+ * +------+-----+----- ... ----+
+ *
+ * Failed register read response have the following format
+ * +------+--------+
+ * | 0xEE | ERRCODE|  (ERRCODE always > 1)
+ * +------+--------+
+ *
+ * Error codes are
+ * 01: OK
+ * 02: read/write FAIL
+ * 04: invalid address
+ * 05: write on RO
+ * 06: wrong start byte
+ * 07: bus overrun
+ * 08: len too high
+ * 09: len too low
+ * 10: bus RX byte timeout (timeout is 30mS)
+ *
+ *
+ * **WORKAROUND ALERT**
+ *
+ * Serial communication seems very fragile: the BNO055 buffer seems to overflow
+ * very easy; BNO055 seems able to sink few bytes, then it needs a brief pause.
+ * On the other hand, it is also picky on timeout: if there is a pause > 30mS in
+ * between two bytes then the transaction fails (IMU internal RX FSM resets).
+ *
+ * BNO055 has been seen also failing to process commands in case we send them
+ * too close each other (or if it is somehow busy?)
+ *
+ * In particular I saw these scenarios:
+ * 1) If we send 2 bytes per time, then the IMU never(?) overflows.
+ * 2) If we send 4 bytes per time (i.e. the full header), then the IMU could
+ *    overflow, but it seem to sink all 4 bytes, then it returns error.
+ * 3) If we send more than 4 bytes, the IMU could overflow, and I saw it sending
+ *    error after 4 bytes are sent; we have troubles in synchronizing again,
+ *    because we are still sending data, and the IMU interprets it as the 1st
+ *    byte of a new command.
+ *
+ * While we must avoid case 3, we could send 4 bytes per time and eventually
+ * retry in case of failure; this seemed convenient for reads (which requires
+ * TXing exactly 4 bytes), however it has been seen that, depending by the IMU
+ * settings (e.g. LPF), failures became less or more frequent; in certain IMU
+ * configurations they are very rare, but in certain others we keeps failing
+ * even after like 30 retries.
+ *
+ * So, we just split TXes in [2-bytes + delay] steps, and still keep an eye on
+ * the IMU response; in case it overflows (which is now unlikely), we retry.
+ */
+
+/*
+ * Read operation overhead:
+ *  4 bytes req + 2byte resp hdr.
+ *  6 bytes = 60 bit (considering 1start + 1stop bits).
+ *  60/115200 = ~520uS + about 2500mS dealay -> ~3mS
+ * In 3mS we could read back about 34 bytes that means 17 samples, this means
+ * that in case of scattered read in which the gap is 17 samples or less it is
+ * still convenient to go for a burst.
+ * We have to take into account also IMU response time - IMU seems to be often
+ * reasonably quick to respond, but sometimes it seems to be in some "critical
+ * section" in which it delays handling of serial protocol. Because of this we
+ * round-up to 22, which is the max number of samples, always bursting indeed.
+ */
+#define BNO055_SL_XFER_BURST_BREAK_THRESHOLD 22
+
+struct bno055_sl_priv {
+	struct serdev_device *serdev;
+	struct completion cmd_complete;
+	enum {
+		CMD_NONE,
+		CMD_READ,
+		CMD_WRITE,
+	} expect_response;
+	int expected_data_len;
+	u8 *response_buf;
+
+	/**
+	 * enum cmd_status - represent the status of a command sent to the HW.
+	 * @STATUS_OK:   The command executed successfully.
+	 * @STATUS_FAIL: The command failed: HW responded with an error.
+	 * @STATUS_CRIT: The command failed: the serial communication failed.
+	 */
+	enum {
+		STATUS_OK = 0,
+		STATUS_FAIL = 1,
+		STATUS_CRIT = -1
+	} cmd_status;
+	struct mutex lock;
+
+	/* Only accessed in RX callback context. No lock needed. */
+	struct {
+		enum {
+			RX_IDLE,
+			RX_START,
+			RX_DATA
+		} state;
+		int databuf_count;
+		int expected_len;
+		int type;
+	} rx;
+
+	/* Never accessed in behalf of RX callback context. No lock needed */
+	bool cmd_stale;
+};
+
+static int bno055_sl_send_chunk(struct bno055_sl_priv *priv, u8 *data, int len)
+{
+	int ret;
+
+	dev_dbg(&priv->serdev->dev, "send (len: %d): %*ph", len, len, data);
+	ret = serdev_device_write(priv->serdev, data, len,
+				  msecs_to_jiffies(25));
+	if (ret < 0)
+		return ret;
+
+	if (ret < len)
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * Sends a read or write command.
+ * 'data' can be NULL (used in read case). 'len' parameter is always valid; in
+ * case 'data' is non-NULL then it must match 'data' size.
+ */
+static int bno055_sl_do_send_cmd(struct bno055_sl_priv *priv,
+				 bool read, int addr, int len, u8 *data)
+{
+	u8 hdr[] = {0xAA, read, addr, len};
+	int chunk_len;
+	int i = 0;
+	int ret;
+
+	while (1) {
+		ret = bno055_sl_send_chunk(priv, hdr + i * 2, 2);
+		if (ret)
+			goto fail;
+
+		if (i++ == 1)
+			break;
+		usleep_range(2000, 3000);
+	}
+
+	if (read)
+		return 0;
+
+	while (len) {
+		chunk_len = min(len, 2);
+		usleep_range(2000, 3000);
+		ret = bno055_sl_send_chunk(priv, data, chunk_len);
+		if (ret)
+			goto fail;
+		data += chunk_len;
+		len -= chunk_len;
+	}
+
+	return 0;
+fail:
+	/* waiting more than 30mS should clear the BNO055 internal state */
+	usleep_range(40000, 50000);
+	return ret;
+}
+
+static int bno_sl_send_cmd(struct bno055_sl_priv *priv,
+			   bool read, int addr, int len, u8 *data)
+{
+	const int retry_max = 5;
+	int retry = retry_max;
+	int ret = 0;
+
+	/*
+	 * In case previous command was interrupted we still neet to wait it to
+	 * complete before we can issue new commands
+	 */
+	if (priv->cmd_stale) {
+		ret = wait_for_completion_interruptible_timeout(&priv->cmd_complete,
+								msecs_to_jiffies(100));
+		if (ret == -ERESTARTSYS)
+			return -ERESTARTSYS;
+
+		priv->cmd_stale = false;
+		/* if serial protocol broke, bail out */
+		if (priv->cmd_status == STATUS_CRIT)
+			return -EIO;
+	}
+
+	/*
+	 * Try to convince the IMU to cooperate.. as explained in the comments
+	 * at the top of this file, the IMU could also refuse the command (i.e.
+	 * it is not ready yet); retry in this case.
+	 */
+	while (retry--) {
+		mutex_lock(&priv->lock);
+		priv->expect_response = read ? CMD_READ : CMD_WRITE;
+		reinit_completion(&priv->cmd_complete);
+		mutex_unlock(&priv->lock);
+
+		if (retry != (retry_max - 1))
+			dev_dbg(&priv->serdev->dev, "cmd retry: %d",
+				retry_max - retry);
+		ret = bno055_sl_do_send_cmd(priv, read, addr, len, data);
+		if (ret)
+			continue;
+
+		ret = wait_for_completion_interruptible_timeout(&priv->cmd_complete,
+								msecs_to_jiffies(100));
+		if (ret == -ERESTARTSYS) {
+			priv->cmd_stale = true;
+			return -ERESTARTSYS;
+		} else if (!ret) {
+			return -ETIMEDOUT;
+		}
+
+		if (priv->cmd_status == STATUS_OK)
+			return 0;
+		else if (priv->cmd_status == STATUS_CRIT)
+			return -EIO;
+
+		/* loop in case priv->cmd_status == STATUS_FAIL */
+	}
+
+	if (ret < 0)
+		return ret;
+	if (priv->cmd_status == STATUS_FAIL)
+		return -EINVAL;
+	return 0;
+}
+
+static int bno055_sl_write_reg(void *context, const void *_data, size_t count)
+{
+	u8 *data = (u8 *)_data;
+	struct bno055_sl_priv *priv = context;
+
+	if (count < 2) {
+		dev_err(&priv->serdev->dev, "Invalid write count %zu", count);
+		return -EINVAL;
+	}
+
+	dev_dbg(&priv->serdev->dev, "wr reg 0x%x = 0x%x", data[0], data[1]);
+	return bno_sl_send_cmd(priv, 0, data[0], count - 1, data + 1);
+}
+
+static int bno055_sl_read_reg(void *context,
+			      const void *reg, size_t reg_size,
+			      void *val, size_t val_size)
+{
+	int ret;
+	int reg_addr;
+	struct bno055_sl_priv *priv = context;
+
+	if (val_size > 128) {
+		dev_err(&priv->serdev->dev, "Invalid read valsize %d",
+			val_size);
+		return -EINVAL;
+	}
+
+	reg_addr = ((u8 *)reg)[0];
+	dev_dbg(&priv->serdev->dev, "rd reg 0x%x (len %d)", reg_addr, val_size);
+	mutex_lock(&priv->lock);
+	priv->expected_data_len = val_size;
+	priv->response_buf = val;
+	mutex_unlock(&priv->lock);
+
+	ret = bno_sl_send_cmd(priv, 1, reg_addr, val_size, NULL);
+
+	mutex_lock(&priv->lock);
+	priv->response_buf = NULL;
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+/*
+ * Handler for received data; this is called from the reicever callback whenever
+ * it got some packet from the serial bus. The status tell us whether the
+ * packet is valid (i.e. header ok && received payload len consistent wrt the
+ * header). It's now our responsability to check whether this is what we
+ * expected, of whether we got some unexpected, yet valid, packet.
+ */
+static void bno055_sl_handle_rx(struct bno055_sl_priv *priv, int status)
+{
+	mutex_lock(&priv->lock);
+	switch (priv->expect_response) {
+	case CMD_NONE:
+		dev_warn(&priv->serdev->dev, "received unexpected, yet valid, data from sensor");
+		mutex_unlock(&priv->lock);
+		return;
+
+	case CMD_READ:
+		priv->cmd_status = status;
+		if (status == STATUS_OK &&
+		    priv->rx.databuf_count != priv->expected_data_len) {
+			/*
+			 * If we got here, then the lower layer serial protocol
+			 * seems consistent with itself; if we got an unexpected
+			 * amount of data then signal it as a non critical error
+			 */
+			priv->cmd_status = STATUS_FAIL;
+			dev_warn(&priv->serdev->dev, "received an unexpected amount of, yet valid, data from sensor");
+		}
+		break;
+
+	case CMD_WRITE:
+		priv->cmd_status = status;
+		break;
+	}
+
+	priv->expect_response = CMD_NONE;
+	complete(&priv->cmd_complete);
+	mutex_unlock(&priv->lock);
+}
+
+/*
+ * Serdev receiver FSM. This tracks the serial communication and parse the
+ * header. It pushes packets to bno055_sl_handle_rx(), eventually communicating
+ * failures (i.e. malformed packets).
+ * Ideally it doesn't know anything about upper layer (i.e. if this is the
+ * packet we were really expecting), but since we copies the payload into the
+ * receiver buffer (that is not valid when i.e. we don't expect data), we
+ * snoop a bit in the upper layer..
+ * Also, we assume to RX one pkt per time (i.e. the HW doesn't send anything
+ * unless we require to AND we don't queue more than one request per time).
+ */
+static int bno055_sl_receive_buf(struct serdev_device *serdev,
+				 const unsigned char *buf, size_t size)
+{
+	int status;
+	struct bno055_sl_priv *priv = serdev_device_get_drvdata(serdev);
+	int remaining = size;
+
+	if (size == 0)
+		return 0;
+
+	dev_dbg(&priv->serdev->dev, "recv (len %zu): %*ph ", size, size, buf);
+	switch (priv->rx.state) {
+	case RX_IDLE:
+		/*
+		 * New packet.
+		 * Check for its 1st byte, that identifies the pkt type.
+		 */
+		if (buf[0] != 0xEE && buf[0] != 0xBB) {
+			dev_err(&priv->serdev->dev,
+				"Invalid packet start %x", buf[0]);
+			bno055_sl_handle_rx(priv, STATUS_CRIT);
+			break;
+		}
+		priv->rx.type = buf[0];
+		priv->rx.state = RX_START;
+		remaining--;
+		buf++;
+		priv->rx.databuf_count = 0;
+		fallthrough;
+
+	case RX_START:
+		/*
+		 * Packet RX in progress, we expect either 1-byte len or 1-byte
+		 * status depending by the packet type.
+		 */
+		if (remaining == 0)
+			break;
+
+		if (priv->rx.type == 0xEE) {
+			if (remaining > 1) {
+				dev_err(&priv->serdev->dev, "EE pkt. Extra data received");
+				status = STATUS_CRIT;
+
+			} else {
+				status = (buf[0] == 1) ? STATUS_OK : STATUS_FAIL;
+			}
+			bno055_sl_handle_rx(priv, status);
+			priv->rx.state = RX_IDLE;
+			break;
+
+		} else {
+			/*priv->rx.type == 0xBB */
+			priv->rx.state = RX_DATA;
+			priv->rx.expected_len = buf[0];
+			remaining--;
+			buf++;
+		}
+		fallthrough;
+
+	case RX_DATA:
+		/* Header parsed; now receiving packet data payload */
+		if (remaining == 0)
+			break;
+
+		if (priv->rx.databuf_count + remaining > priv->rx.expected_len) {
+			/*
+			 * This is a inconsistency in serial protocol, we lost
+			 * sync and we don't know how to handle further data
+			 */
+			dev_err(&priv->serdev->dev, "BB pkt. Extra data received");
+			bno055_sl_handle_rx(priv, STATUS_CRIT);
+			priv->rx.state = RX_IDLE;
+			break;
+		}
+
+		mutex_lock(&priv->lock);
+		/*
+		 * NULL e.g. when read cmd is stale or when no read cmd is
+		 * actually pending.
+		 */
+		if (priv->response_buf &&
+		    /*
+		     * Snoop on the upper layer protocol stuff to make sure not
+		     * to write to an invalid memory. Apart for this, let's the
+		     * upper layer manage any inconsistency wrt expected data
+		     * len (as long as the serial protocol is consistent wrt
+		     * itself (i.e. response header is consistent with received
+		     * response len.
+		     */
+		    (priv->rx.databuf_count + remaining <= priv->expected_data_len))
+			memcpy(priv->response_buf + priv->rx.databuf_count,
+			       buf, remaining);
+		mutex_unlock(&priv->lock);
+
+		priv->rx.databuf_count += remaining;
+
+		/*
+		 * Reached expected len advertised by the IMU for the current
+		 * packet. Pass it to the upper layer (for us it is just valid).
+		 */
+		if (priv->rx.databuf_count == priv->rx.expected_len) {
+			bno055_sl_handle_rx(priv, STATUS_OK);
+			priv->rx.state = RX_IDLE;
+		}
+		break;
+	}
+
+	return size;
+}
+
+static const struct serdev_device_ops bno055_sl_serdev_ops = {
+	.receive_buf = bno055_sl_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+static struct regmap_bus bno055_sl_regmap_bus = {
+	.write = bno055_sl_write_reg,
+	.read = bno055_sl_read_reg,
+};
+
+static int bno055_sl_probe(struct serdev_device *serdev)
+{
+	struct bno055_sl_priv *priv;
+	struct regmap *regmap;
+	int ret;
+
+	priv = devm_kzalloc(&serdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	serdev_device_set_drvdata(serdev, priv);
+	priv->serdev = serdev;
+	mutex_init(&priv->lock);
+	init_completion(&priv->cmd_complete);
+
+	serdev_device_set_client_ops(serdev, &bno055_sl_serdev_ops);
+	ret = devm_serdev_device_open(&serdev->dev, serdev);
+	if (ret)
+		return ret;
+
+	if (serdev_device_set_baudrate(serdev, 115200) != 115200) {
+		dev_err(&serdev->dev, "Cannot set required baud rate");
+		return -EIO;
+	}
+
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret) {
+		dev_err(&serdev->dev, "Cannot set required parity setting");
+		return ret;
+	}
+	serdev_device_set_flow_control(serdev, false);
+
+	regmap = devm_regmap_init(&serdev->dev, &bno055_sl_regmap_bus,
+				  priv, &bno055_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&serdev->dev, "Unable to init register map");
+		return PTR_ERR(regmap);
+	}
+
+	return bno055_probe(&serdev->dev, regmap,
+			    BNO055_SL_XFER_BURST_BREAK_THRESHOLD, false);
+}
+
+static const struct of_device_id bno055_sl_of_match[] = {
+	{ .compatible = "bosch,bno055" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bno055_sl_of_match);
+
+static struct serdev_device_driver bno055_sl_driver = {
+	.driver = {
+		.name = "bno055-sl",
+		.of_match_table = bno055_sl_of_match,
+	},
+	.probe = bno055_sl_probe,
+};
+module_serdev_device_driver(bno055_sl_driver);
+
+MODULE_AUTHOR("Andrea Merello <andrea.merello@iit.it>");
+MODULE_DESCRIPTION("Bosch BNO055 serdev interface");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

