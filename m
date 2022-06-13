Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F754B0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbiFNMfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244579AbiFNMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:35:13 -0400
Received: from es400ra01.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976694D62E;
        Tue, 14 Jun 2022 05:32:08 -0700 (PDT)
Received: from es400ra01.iit.it (127.0.0.1) id hl1vse0171sj; Mon, 13 Jun 2022 14:05:56 +0200 (envelope-from <prvs=1163b4114e=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=qAPpIESYKcY5uzew33mfd
        ISwTIM8C9InxZpBCnTs+LA=; b=a/rNSM4S0PkCfgehjvmDhrC/h1PxP1lKucFqc
        9btSGupTQWdgb9pvPIhk5UaTpF2SJgGd8LucyPNrHMxXqXHXp1SLGK3QF0SmILBQ
        +rwHoEqg+X+7t7XqZE/QLGCNA0lp1pOArAPcAXuAeYHOdkpZl7liRiDTN0RS8p8q
        uOdzxc=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra01.iit.it ([172.31.0.241]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202206131205560155824-11; Mon, 13 Jun 2022 14:05:56 +0200
Received: from poker.lan (90.147.26.235) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.17; Mon, 13 Jun
 2022 14:05:55 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v6 12/14] iio: imu: add BNO055 serdev driver
Date:   Mon, 13 Jun 2022 14:05:32 +0200
Message-ID: <20220613120534.36991-13-andrea.merello@iit.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613120534.36991-1-andrea.merello@iit.it>
References: <20220613120534.36991-1-andrea.merello@iit.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [90.147.26.235]
X-ClientProxiedBy: IITMXWGE021.iit.local (10.255.8.187) To
 iitmxwge020.iit.local (10.255.8.186)
X-Mlf-DSE-Version: 6873
X-Mlf-Rules-Version: s20220519150137; ds20200715013501;
        di20220610180234; ri20160318003319; fs20220610211824
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: Andrea.Merello@iit.it
X-Mlf-Version: 10.0.16.7295
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202206131205560155824
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Add a serdev driver for communicating to a BNO055 IMU via serial bus, and
enable the BNO055 core driver to work in this scenario.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/imu/bno055/Kconfig            |  10 +
 drivers/iio/imu/bno055/Makefile           |   5 +
 drivers/iio/imu/bno055/bno055_ser_core.c  | 560 ++++++++++++++++++++++
 drivers/iio/imu/bno055/bno055_ser_trace.c |  13 +
 drivers/iio/imu/bno055/bno055_ser_trace.h | 104 ++++
 5 files changed, 692 insertions(+)
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_core.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_trace.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_trace.h

diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
index d0ab3221fba5..d014b68cd43d 100644
--- a/drivers/iio/imu/bno055/Kconfig
+++ b/drivers/iio/imu/bno055/Kconfig
@@ -2,3 +2,13 @@
 
 config BOSCH_BNO055_IIO
 	tristate
+
+config BOSCH_BNO055_SERIAL
+	tristate "Bosch BNO055 attached via UART"
+	depends on SERIAL_DEV_BUS
+	select BOSCH_BNO055_IIO
+	help
+	  Enable this to support Bosch BNO055 IMUs attached via UART.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called bno055_sl.
diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
index 56cc4de60a7e..212307ce9c08 100644
--- a/drivers/iio/imu/bno055/Makefile
+++ b/drivers/iio/imu/bno055/Makefile
@@ -1,3 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_BOSCH_BNO055_IIO) += bno055.o
+obj-$(CONFIG_BOSCH_BNO055_SERIAL) += bno055_ser.o
+bno055_ser-y := bno055_ser_core.o
+# define_trace.h needs to know how to find our header
+CFLAGS_bno055_ser_trace.o := -I$(src)
+bno055_ser-$(CONFIG_TRACING) += bno055_ser_trace.o
diff --git a/drivers/iio/imu/bno055/bno055_ser_core.c b/drivers/iio/imu/bno055/bno055_ser_core.c
new file mode 100644
index 000000000000..235131900260
--- /dev/null
+++ b/drivers/iio/imu/bno055/bno055_ser_core.c
@@ -0,0 +1,560 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Serial line interface for Bosh BNO055 IMU (via serdev).
+ * This file implements serial communication up to the register read/write
+ * level.
+ *
+ * Copyright (C) 2021-2022 Istituto Italiano di Tecnologia
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
+#include "bno055_ser_trace.h"
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
+#define BNO055_SER_XFER_BURST_BREAK_THRESHOLD 22
+
+struct bno055_ser_priv {
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
+	 * @STATUS_CRIT: The command failed: the serial communication failed.
+	 * @STATUS_OK:   The command executed successfully.
+	 * @STATUS_FAIL: The command failed: HW responded with an error.
+	 */
+	enum {
+		STATUS_CRIT = -1,
+		STATUS_OK = 0,
+		STATUS_FAIL = 1,
+	} cmd_status;
+
+	/*
+	 * Protects all the above fields, which are accessed in behalf of both
+	 * the serdev RX callback and the regmap side
+	 */
+	struct mutex lock;
+
+	/* Only accessed in serdev RX callback context*/
+	struct {
+		enum {
+			RX_IDLE,
+			RX_START,
+			RX_DATA,
+		} state;
+		int databuf_count;
+		int expected_len;
+		int type;
+	} rx;
+
+	/* Never accessed in behalf of serdev RX callback context */
+	bool cmd_stale;
+
+	struct completion cmd_complete;
+	struct serdev_device *serdev;
+};
+
+static int bno055_ser_send_chunk(struct bno055_ser_priv *priv, const u8 *data, int len)
+{
+	int ret;
+
+	trace_send_chunk(len, data);
+	ret = serdev_device_write(priv->serdev, data, len, msecs_to_jiffies(25));
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
+static int bno055_ser_do_send_cmd(struct bno055_ser_priv *priv,
+				  bool read, int addr, int len, const u8 *data)
+{
+	u8 hdr[] = {0xAA, read, addr, len};
+	int chunk_len;
+	int ret;
+
+	ret = bno055_ser_send_chunk(priv, hdr, 2);
+	if (ret)
+		goto fail;
+	usleep_range(2000, 3000);
+	ret = bno055_ser_send_chunk(priv, hdr + 2, 2);
+	if (ret)
+		goto fail;
+
+	if (read)
+		return 0;
+
+	while (len) {
+		chunk_len = min(len, 2);
+		usleep_range(2000, 3000);
+		ret = bno055_ser_send_chunk(priv, data, chunk_len);
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
+static int bno055_ser_send_cmd(struct bno055_ser_priv *priv,
+			       bool read, int addr, int len, const u8 *data)
+{
+	const int retry_max = 5;
+	int retry = retry_max;
+	int ret = 0;
+
+	/*
+	 * In case previous command was interrupted we still need to wait it to
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
+	do {
+		mutex_lock(&priv->lock);
+		priv->expect_response = read ? CMD_READ : CMD_WRITE;
+		reinit_completion(&priv->cmd_complete);
+		mutex_unlock(&priv->lock);
+
+		if (retry != retry_max)
+			trace_cmd_retry(read, addr, retry_max - retry);
+		ret = bno055_ser_do_send_cmd(priv, read, addr, len, data);
+		if (ret)
+			continue;
+
+		ret = wait_for_completion_interruptible_timeout(&priv->cmd_complete,
+								msecs_to_jiffies(100));
+		if (ret == -ERESTARTSYS) {
+			priv->cmd_stale = true;
+			return -ERESTARTSYS;
+		}
+
+		if (!ret)
+			return -ETIMEDOUT;
+
+		if (priv->cmd_status == STATUS_OK)
+			return 0;
+		if (priv->cmd_status == STATUS_CRIT)
+			return -EIO;
+
+		/* loop in case priv->cmd_status == STATUS_FAIL */
+	} while (--retry);
+
+	if (ret < 0)
+		return ret;
+	if (priv->cmd_status == STATUS_FAIL)
+		return -EINVAL;
+	return 0;
+}
+
+static int bno055_ser_write_reg(void *context, const void *_data, size_t count)
+{
+	const u8 *data = _data;
+	struct bno055_ser_priv *priv = context;
+
+	if (count < 2) {
+		dev_err(&priv->serdev->dev, "Invalid write count %zu", count);
+		return -EINVAL;
+	}
+
+	trace_write_reg(data[0], data[1]);
+	return bno055_ser_send_cmd(priv, 0, data[0], count - 1, data + 1);
+}
+
+static int bno055_ser_read_reg(void *context,
+			       const void *_reg, size_t reg_size,
+			       void *val, size_t val_size)
+{
+	int ret;
+	int reg_addr;
+	const u8 *reg = _reg;
+	struct bno055_ser_priv *priv = context;
+
+	if (val_size > 128) {
+		dev_err(&priv->serdev->dev, "Invalid read valsize %zu", val_size);
+		return -EINVAL;
+	}
+
+	reg_addr = *reg;
+	trace_read_reg(reg_addr, val_size);
+	mutex_lock(&priv->lock);
+	priv->expected_data_len = val_size;
+	priv->response_buf = val;
+	mutex_unlock(&priv->lock);
+
+	ret = bno055_ser_send_cmd(priv, 1, reg_addr, val_size, NULL);
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
+static void bno055_ser_handle_rx(struct bno055_ser_priv *priv, int status)
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
+			dev_warn(&priv->serdev->dev,
+				 "received an unexpected amount of, yet valid, data from sensor");
+		}
+		break;
+
+	case CMD_WRITE:
+		priv->cmd_status = status;
+		break;
+	}
+
+	priv->expect_response = CMD_NONE;
+	mutex_unlock(&priv->lock);
+	complete(&priv->cmd_complete);
+}
+
+/*
+ * Serdev receiver FSM. This tracks the serial communication and parse the
+ * header. It pushes packets to bno055_ser_handle_rx(), eventually communicating
+ * failures (i.e. malformed packets).
+ * Ideally it doesn't know anything about upper layer (i.e. if this is the
+ * packet we were really expecting), but since we copies the payload into the
+ * receiver buffer (that is not valid when i.e. we don't expect data), we
+ * snoop a bit in the upper layer..
+ * Also, we assume to RX one pkt per time (i.e. the HW doesn't send anything
+ * unless we require to AND we don't queue more than one request per time).
+ */
+static int bno055_ser_receive_buf(struct serdev_device *serdev,
+				  const unsigned char *buf, size_t size)
+{
+	int status;
+	struct bno055_ser_priv *priv = serdev_device_get_drvdata(serdev);
+	int remaining = size;
+
+	if (size == 0)
+		return 0;
+
+	trace_recv(size, buf);
+	switch (priv->rx.state) {
+	case RX_IDLE:
+		/*
+		 * New packet.
+		 * Check for its 1st byte, that identifies the pkt type.
+		 */
+		if (buf[0] != 0xEE && buf[0] != 0xBB) {
+			dev_err(&priv->serdev->dev,
+				"Invalid packet start %x", buf[0]);
+			bno055_ser_handle_rx(priv, STATUS_CRIT);
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
+			} else {
+				status = (buf[0] == 1) ? STATUS_OK : STATUS_FAIL;
+			}
+			bno055_ser_handle_rx(priv, status);
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
+			 * This is an inconsistency in serial protocol, we lost
+			 * sync and we don't know how to handle further data
+			 */
+			dev_err(&priv->serdev->dev, "BB pkt. Extra data received");
+			bno055_ser_handle_rx(priv, STATUS_CRIT);
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
+			bno055_ser_handle_rx(priv, STATUS_OK);
+			priv->rx.state = RX_IDLE;
+		}
+		break;
+	}
+
+	return size;
+}
+
+static const struct serdev_device_ops bno055_ser_serdev_ops = {
+	.receive_buf = bno055_ser_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+static struct regmap_bus bno055_ser_regmap_bus = {
+	.write = bno055_ser_write_reg,
+	.read = bno055_ser_read_reg,
+};
+
+static int bno055_ser_probe(struct serdev_device *serdev)
+{
+	struct bno055_ser_priv *priv;
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
+	serdev_device_set_client_ops(serdev, &bno055_ser_serdev_ops);
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
+	regmap = devm_regmap_init(&serdev->dev, &bno055_ser_regmap_bus,
+				  priv, &bno055_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&serdev->dev, PTR_ERR(regmap),
+				     "Unable to init register map");
+
+	return bno055_probe(&serdev->dev, regmap,
+			    BNO055_SER_XFER_BURST_BREAK_THRESHOLD, false);
+}
+
+static const struct of_device_id bno055_ser_of_match[] = {
+	{ .compatible = "bosch,bno055" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bno055_ser_of_match);
+
+static struct serdev_device_driver bno055_ser_driver = {
+	.driver = {
+		.name = "bno055-ser",
+		.of_match_table = bno055_ser_of_match,
+	},
+	.probe = bno055_ser_probe,
+};
+module_serdev_device_driver(bno055_ser_driver);
+
+MODULE_AUTHOR("Andrea Merello <andrea.merello@iit.it>");
+MODULE_DESCRIPTION("Bosch BNO055 serdev interface");
+MODULE_IMPORT_NS(IIO_BNO055);
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/bno055/bno055_ser_trace.c b/drivers/iio/imu/bno055/bno055_ser_trace.c
new file mode 100644
index 000000000000..9e5c65c70fd8
--- /dev/null
+++ b/drivers/iio/imu/bno055/bno055_ser_trace.c
@@ -0,0 +1,13 @@
+//SPDX-License-Identifier: GPL-2.0
+/*
+ * bno055_ser Trace Support
+ * Copyright (C) 2022 Istituto Italiano di Tecnologia
+ * Electronic Design Laboratory
+ *
+ * Based on:
+ *   Device core Trace Support
+ *   Copyright (C) 2021, Intel Corporation
+ */
+
+#define CREATE_TRACE_POINTS
+#include "bno055_ser_trace.h"
diff --git a/drivers/iio/imu/bno055/bno055_ser_trace.h b/drivers/iio/imu/bno055/bno055_ser_trace.h
new file mode 100644
index 000000000000..51d079b91f63
--- /dev/null
+++ b/drivers/iio/imu/bno055/bno055_ser_trace.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#if !defined(__BNO055_SERDEV_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
+#define __BNO055_SERDEV_TRACE_H__
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM bno055_ser
+
+TRACE_EVENT(send_chunk,
+	    TP_PROTO(int len, const u8 *data),
+	    TP_ARGS(len, data),
+	    TP_STRUCT__entry(
+		    __field(int, len)
+		    __dynamic_array(u8, chunk, len)
+	    ),
+	    TP_fast_assign(
+		    __entry->len = len;
+		    memcpy(__get_dynamic_array(chunk),
+			   data, __entry->len);
+	    ),
+	    TP_printk("len: %d, data: = %*ph",
+		      __entry->len, __entry->len, __get_dynamic_array(chunk)
+	    )
+);
+
+TRACE_EVENT(cmd_retry,
+	    TP_PROTO(bool read, int addr, int retry),
+	    TP_ARGS(read, addr, retry),
+	    TP_STRUCT__entry(
+		    __field(bool, read)
+		    __field(int, addr)
+		    __field(int, retry)
+	    ),
+	    TP_fast_assign(
+		    __entry->read = read;
+		    __entry->addr = addr;
+		    __entry->retry = retry;
+	    ),
+	    TP_printk("%s addr 0x%x retry #%d",
+		      __entry->read ? "read" : "write",
+		      __entry->addr, __entry->retry
+	    )
+);
+
+TRACE_EVENT(write_reg,
+	    TP_PROTO(u8 addr, u8 value),
+	    TP_ARGS(addr, value),
+	    TP_STRUCT__entry(
+		    __field(u8, addr)
+		    __field(u8, value)
+	    ),
+	    TP_fast_assign(
+		    __entry->addr = addr;
+		    __entry->value = value;
+	    ),
+	    TP_printk("reg 0x%x = 0x%x",
+		      __entry->addr, __entry->value
+	    )
+);
+
+TRACE_EVENT(read_reg,
+	    TP_PROTO(int addr, size_t len),
+	    TP_ARGS(addr, len),
+	    TP_STRUCT__entry(
+		    __field(int, addr)
+		    __field(size_t, len)
+	    ),
+	    TP_fast_assign(
+		    __entry->addr = addr;
+		    __entry->len = len;
+	    ),
+	    TP_printk("reg 0x%x (len %zu)",
+		      __entry->addr, __entry->len
+	    )
+);
+
+TRACE_EVENT(recv,
+	    TP_PROTO(size_t len, const unsigned char *buf),
+	    TP_ARGS(len, buf),
+	    TP_STRUCT__entry(
+		    __field(size_t, len)
+		    __dynamic_array(unsigned char, buf, len)
+	    ),
+	    TP_fast_assign(
+		    __entry->len = len;
+		    memcpy(__get_dynamic_array(buf),
+			   buf, __entry->len);
+	    ),
+	    TP_printk("len: %d, data: = %*ph",
+		      __entry->len, __entry->len, __get_dynamic_array(buf)
+	    )
+);
+
+#endif /* __BNO055_SERDEV_TRACE_H__ || TRACE_HEADER_MULTI_READ */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE bno055_ser_trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

