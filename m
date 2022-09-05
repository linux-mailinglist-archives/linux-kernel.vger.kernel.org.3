Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2D5ACF38
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbiIEJvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiIEJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:51:37 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05D0C29C85;
        Mon,  5 Sep 2022 02:51:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowAD361CZxhVjfAunAQ--.29035S2;
        Mon, 05 Sep 2022 17:51:22 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v4] USB: serial: ftdi_sio: Convert to use dev_groups
Date:   Mon,  5 Sep 2022 17:51:20 +0800
Message-Id: <20220905095120.343807-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD361CZxhVjfAunAQ--.29035S2
X-Coremail-Antispam: 1UD129KBjvJXoW3tw1fWrW7XF13try3Xr17GFg_yoWDCF4kpF
        4UWay3tFW8Jr47Wr4vka1DZr15uw48K3sxt3yUJw4Svr1xK3s3tFyxAas0vry3tFykKry3
        Krs0qF98urWUJrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core supports the ability to handle the creation and removal
of device-specific sysfs files in a race-free manner. Moreover, it can
guarantee the success of creation. Therefore, it should be better to
move the code and convert to use dev_groups.

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v3 -> v4:

1. Move the code and remove the pre-definitions.

v2 -> v3:

1. Add is_visible to filter the unneeded files.

v1 -> v2:

1. Change the title.
2. Switch to use an attribute group.
---
 drivers/usb/serial/ftdi_sio.c | 275 +++++++++++++++++-----------------
 1 file changed, 135 insertions(+), 140 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index d5a3986dfee7..c06ad75ba6d7 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1108,10 +1108,145 @@ static u32 ftdi_232bm_baud_to_divisor(int baud);
 static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
 static u32 ftdi_2232h_baud_to_divisor(int baud);
 
+
+#define WDR_TIMEOUT 5000 /* default urb timeout */
+#define WDR_SHORT_TIMEOUT 1000	/* shorter urb timeout */
+
+static int write_latency_timer(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_device *udev = port->serial->dev;
+	int rv;
+	int l = priv->latency;
+
+	if (priv->chip_type == SIO || priv->chip_type == FT8U232AM)
+		return -EINVAL;
+
+	if (priv->flags & ASYNC_LOW_LATENCY)
+		l = 1;
+
+	dev_dbg(&port->dev, "%s: setting latency timer = %i\n", __func__, l);
+
+	rv = usb_control_msg(udev,
+			     usb_sndctrlpipe(udev, 0),
+			     FTDI_SIO_SET_LATENCY_TIMER_REQUEST,
+			     FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE,
+			     l, priv->interface,
+			     NULL, 0, WDR_TIMEOUT);
+	if (rv < 0)
+		dev_err(&port->dev, "Unable to write latency timer: %i\n", rv);
+	return rv;
+}
+
+static ssize_t latency_timer_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct usb_serial_port *port = to_usb_serial_port(dev);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
+	if (priv->flags & ASYNC_LOW_LATENCY)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "%u\n", priv->latency);
+}
+
+/* Write a new value of the latency timer, in units of milliseconds. */
+static ssize_t latency_timer_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *valbuf, size_t count)
+{
+	struct usb_serial_port *port = to_usb_serial_port(dev);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	u8 v;
+	int rv;
+
+	if (kstrtou8(valbuf, 10, &v))
+		return -EINVAL;
+
+	priv->latency = v;
+	rv = write_latency_timer(port);
+	if (rv < 0)
+		return -EIO;
+	return count;
+}
+static DEVICE_ATTR_RW(latency_timer);
+
+/*
+ * Write an event character directly to the FTDI register.  The ASCII
+ * value is in the low 8 bits, with the enable bit in the 9th bit.
+ */
+static ssize_t event_char_store(struct device *dev,
+	struct device_attribute *attr, const char *valbuf, size_t count)
+{
+	struct usb_serial_port *port = to_usb_serial_port(dev);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_device *udev = port->serial->dev;
+	unsigned int v;
+	int rv;
+
+	if (kstrtouint(valbuf, 0, &v) || v >= 0x200)
+		return -EINVAL;
+
+	dev_dbg(&port->dev, "%s: setting event char = 0x%03x\n", __func__, v);
+
+	rv = usb_control_msg(udev,
+			     usb_sndctrlpipe(udev, 0),
+			     FTDI_SIO_SET_EVENT_CHAR_REQUEST,
+			     FTDI_SIO_SET_EVENT_CHAR_REQUEST_TYPE,
+			     v, priv->interface,
+			     NULL, 0, WDR_TIMEOUT);
+	if (rv < 0) {
+		dev_dbg(&port->dev, "Unable to write event character: %i\n", rv);
+		return -EIO;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(event_char);
+
+static umode_t ftdi_sio_attr_is_visible(struct kobject *kobj,
+					 struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct usb_serial_port *port = container_of(dev, struct usb_serial_port, dev);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	umode_t mode = attr->mode;
+
+	if (attr == &dev_attr_latency_timer.attr) {
+		if (priv->chip_type == FT232BM ||
+		    priv->chip_type == FT2232C ||
+		    priv->chip_type == FT232RL ||
+		    priv->chip_type == FT2232H ||
+		    priv->chip_type == FT4232H ||
+		    priv->chip_type == FT232H ||
+		    priv->chip_type == FTX) {
+			return mode;
+		}
+	}
+	return 0;
+}
+
+static struct attribute *ftdi_sio_attrs[] = {
+	&dev_attr_event_char.attr,
+	&dev_attr_latency_timer.attr,
+	NULL,
+};
+
+static const struct attribute_group ftdi_sio_group = {
+	.attrs = ftdi_sio_attrs,
+	.is_visible = ftdi_sio_attr_is_visible,
+};
+
+static const struct attribute_group *ftdi_sio_groups[] = {
+	&ftdi_sio_group,
+	NULL
+};
+
 static struct usb_serial_driver ftdi_sio_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
 		.name =		"ftdi_sio",
+		.dev_groups =	ftdi_sio_groups,
 	},
 	.description =		"FTDI USB Serial Device",
 	.id_table =		id_table_combined,
@@ -1144,9 +1279,6 @@ static struct usb_serial_driver * const serial_drivers[] = {
 };
 
 
-#define WDR_TIMEOUT 5000 /* default urb timeout */
-#define WDR_SHORT_TIMEOUT 1000	/* shorter urb timeout */
-
 /*
  * ***************************************************************************
  * Utility functions
@@ -1413,32 +1545,6 @@ static int change_speed(struct tty_struct *tty, struct usb_serial_port *port)
 	return rv;
 }
 
-static int write_latency_timer(struct usb_serial_port *port)
-{
-	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	struct usb_device *udev = port->serial->dev;
-	int rv;
-	int l = priv->latency;
-
-	if (priv->chip_type == SIO || priv->chip_type == FT8U232AM)
-		return -EINVAL;
-
-	if (priv->flags & ASYNC_LOW_LATENCY)
-		l = 1;
-
-	dev_dbg(&port->dev, "%s: setting latency timer = %i\n", __func__, l);
-
-	rv = usb_control_msg(udev,
-			     usb_sndctrlpipe(udev, 0),
-			     FTDI_SIO_SET_LATENCY_TIMER_REQUEST,
-			     FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE,
-			     l, priv->interface,
-			     NULL, 0, WDR_TIMEOUT);
-	if (rv < 0)
-		dev_err(&port->dev, "Unable to write latency timer: %i\n", rv);
-	return rv;
-}
-
 static int _read_latency_timer(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
@@ -1666,114 +1772,6 @@ static void ftdi_set_max_packet_size(struct usb_serial_port *port)
  * ***************************************************************************
  */
 
-static ssize_t latency_timer_show(struct device *dev,
-				  struct device_attribute *attr, char *buf)
-{
-	struct usb_serial_port *port = to_usb_serial_port(dev);
-	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	if (priv->flags & ASYNC_LOW_LATENCY)
-		return sprintf(buf, "1\n");
-	else
-		return sprintf(buf, "%u\n", priv->latency);
-}
-
-/* Write a new value of the latency timer, in units of milliseconds. */
-static ssize_t latency_timer_store(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *valbuf, size_t count)
-{
-	struct usb_serial_port *port = to_usb_serial_port(dev);
-	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	u8 v;
-	int rv;
-
-	if (kstrtou8(valbuf, 10, &v))
-		return -EINVAL;
-
-	priv->latency = v;
-	rv = write_latency_timer(port);
-	if (rv < 0)
-		return -EIO;
-	return count;
-}
-static DEVICE_ATTR_RW(latency_timer);
-
-/* Write an event character directly to the FTDI register.  The ASCII
-   value is in the low 8 bits, with the enable bit in the 9th bit. */
-static ssize_t event_char_store(struct device *dev,
-	struct device_attribute *attr, const char *valbuf, size_t count)
-{
-	struct usb_serial_port *port = to_usb_serial_port(dev);
-	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	struct usb_device *udev = port->serial->dev;
-	unsigned int v;
-	int rv;
-
-	if (kstrtouint(valbuf, 0, &v) || v >= 0x200)
-		return -EINVAL;
-
-	dev_dbg(&port->dev, "%s: setting event char = 0x%03x\n", __func__, v);
-
-	rv = usb_control_msg(udev,
-			     usb_sndctrlpipe(udev, 0),
-			     FTDI_SIO_SET_EVENT_CHAR_REQUEST,
-			     FTDI_SIO_SET_EVENT_CHAR_REQUEST_TYPE,
-			     v, priv->interface,
-			     NULL, 0, WDR_TIMEOUT);
-	if (rv < 0) {
-		dev_dbg(&port->dev, "Unable to write event character: %i\n", rv);
-		return -EIO;
-	}
-
-	return count;
-}
-static DEVICE_ATTR_WO(event_char);
-
-static int create_sysfs_attrs(struct usb_serial_port *port)
-{
-	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	int retval = 0;
-
-	/* XXX I've no idea if the original SIO supports the event_char
-	 * sysfs parameter, so I'm playing it safe.  */
-	if (priv->chip_type != SIO) {
-		dev_dbg(&port->dev, "sysfs attributes for %s\n", ftdi_chip_name[priv->chip_type]);
-		retval = device_create_file(&port->dev, &dev_attr_event_char);
-		if ((!retval) &&
-		    (priv->chip_type == FT232BM ||
-		     priv->chip_type == FT2232C ||
-		     priv->chip_type == FT232RL ||
-		     priv->chip_type == FT2232H ||
-		     priv->chip_type == FT4232H ||
-		     priv->chip_type == FT232H ||
-		     priv->chip_type == FTX)) {
-			retval = device_create_file(&port->dev,
-						    &dev_attr_latency_timer);
-		}
-	}
-	return retval;
-}
-
-static void remove_sysfs_attrs(struct usb_serial_port *port)
-{
-	struct ftdi_private *priv = usb_get_serial_port_data(port);
-
-	/* XXX see create_sysfs_attrs */
-	if (priv->chip_type != SIO) {
-		device_remove_file(&port->dev, &dev_attr_event_char);
-		if (priv->chip_type == FT232BM ||
-		    priv->chip_type == FT2232C ||
-		    priv->chip_type == FT232RL ||
-		    priv->chip_type == FT2232H ||
-		    priv->chip_type == FT4232H ||
-		    priv->chip_type == FT232H ||
-		    priv->chip_type == FTX) {
-			device_remove_file(&port->dev, &dev_attr_latency_timer);
-		}
-	}
-
-}
-
 #ifdef CONFIG_GPIOLIB
 
 static int ftdi_set_bitmode(struct usb_serial_port *port, u8 mode)
@@ -2251,7 +2249,6 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 	if (read_latency_timer(port) < 0)
 		priv->latency = 16;
 	write_latency_timer(port);
-	create_sysfs_attrs(port);
 
 	result = ftdi_gpio_init(port);
 	if (result < 0) {
@@ -2377,8 +2374,6 @@ static void ftdi_sio_port_remove(struct usb_serial_port *port)
 
 	ftdi_gpio_remove(port);
 
-	remove_sysfs_attrs(port);
-
 	kfree(priv);
 }
 
-- 
2.25.1

