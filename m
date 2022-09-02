Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838F05AABB6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiIBJoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbiIBJob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:44:31 -0400
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AC5ACE313;
        Fri,  2 Sep 2022 02:44:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowAD3_8d40BFjmVGMAA--.46700S2;
        Fri, 02 Sep 2022 17:44:24 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v3] USB: serial: ftdi_sio: Convert to use dev_groups
Date:   Fri,  2 Sep 2022 17:44:23 +0800
Message-Id: <20220902094423.4028673-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3_8d40BFjmVGMAA--.46700S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWkXw1xXw1rCw15Zr17trb_yoW7Ar1DpF
        WUXFWSyFWUJF4agrsYkw4DWw15Cw4kKrZxK3yUGw4SkF1xA34IqFyIyas0vr13JFykKFya
        qrs3tryDCr4xJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFWl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUOo7ZUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core supports the ability to handle the creation and removal
of device-specific sysfs files in a race-free manner. Moreover, it can
guarantee the success of creation. Therefore, it should be better to
convert to use dev_groups.

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v2 -> v3:

1. Add is_visible to filter the unneeded files.

v1 -> v2:

1. Change the title.
2. Switch to use an attribute group.
---
 drivers/usb/serial/ftdi_sio.c | 101 +++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index d5a3986dfee7..479c3a5caaf8 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1107,11 +1107,40 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base);
 static u32 ftdi_232bm_baud_to_divisor(int baud);
 static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
 static u32 ftdi_2232h_baud_to_divisor(int baud);
+static umode_t ftdi_sio_attr_is_visible(struct kobject *kobj,
+					 struct attribute *attr, int idx);
+static ssize_t latency_timer_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *valbuf, size_t count);
+static ssize_t event_char_store(struct device *dev,
+	struct device_attribute *attr, const char *valbuf, size_t count);
+static ssize_t latency_timer_show(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+
+static DEVICE_ATTR_RW(latency_timer);
+static DEVICE_ATTR_WO(event_char);
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
 
 static struct usb_serial_driver ftdi_sio_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
 		.name =		"ftdi_sio",
+		.dev_groups =	ftdi_sio_groups,
 	},
 	.description =		"FTDI USB Serial Device",
 	.id_table =		id_table_combined,
@@ -1696,7 +1725,6 @@ static ssize_t latency_timer_store(struct device *dev,
 		return -EIO;
 	return count;
 }
-static DEVICE_ATTR_RW(latency_timer);
 
 /* Write an event character directly to the FTDI register.  The ASCII
    value is in the low 8 bits, with the enable bit in the 9th bit. */
@@ -1727,52 +1755,6 @@ static ssize_t event_char_store(struct device *dev,
 
 	return count;
 }
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
 
 #ifdef CONFIG_GPIOLIB
 
@@ -2251,7 +2233,6 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 	if (read_latency_timer(port) < 0)
 		priv->latency = 16;
 	write_latency_timer(port);
-	create_sysfs_attrs(port);
 
 	result = ftdi_gpio_init(port);
 	if (result < 0) {
@@ -2377,8 +2358,6 @@ static void ftdi_sio_port_remove(struct usb_serial_port *port)
 
 	ftdi_gpio_remove(port);
 
-	remove_sysfs_attrs(port);
-
 	kfree(priv);
 }
 
@@ -2915,6 +2894,28 @@ static int ftdi_ioctl(struct tty_struct *tty,
 	return -ENOIOCTLCMD;
 }
 
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
 module_usb_serial_driver(serial_drivers, id_table_combined);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
-- 
2.25.1

