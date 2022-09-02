Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139405AA94D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbiIBH7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiIBH7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:59:07 -0400
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09143BD4D8;
        Fri,  2 Sep 2022 00:58:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowAC3v8e+txFjFSWEAA--.4811S2;
        Fri, 02 Sep 2022 15:58:54 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] USB: serial: ftdi_sio: Convert to use dev_groups
Date:   Fri,  2 Sep 2022 15:58:53 +0800
Message-Id: <20220902075853.3931834-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAC3v8e+txFjFSWEAA--.4811S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1xCr48Kr48ur1xGr1xKrg_yoW7uF4UpF
        WrtrZ7trWDJF43Jr4FkFs8Jrn8CwsYyrZIg39rXw4Fga15Aw1SqFyxA3Z5try3JFykKFyS
        qws2grZ0kF47JFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4UDLUUUUU=
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
move the definition of ftdi_sio_device to the end, remove
create_sysfs_attrs and remove_sysfs_attrs, and convert to use dev_groups.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Change the title.
2. Switch to use an attribute group.
---
 drivers/usb/serial/ftdi_sio.c | 124 ++++++++++++----------------------
 1 file changed, 42 insertions(+), 82 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index d5a3986dfee7..41d8bfb02322 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1108,41 +1108,6 @@ static u32 ftdi_232bm_baud_to_divisor(int baud);
 static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
 static u32 ftdi_2232h_baud_to_divisor(int baud);
 
-static struct usb_serial_driver ftdi_sio_device = {
-	.driver = {
-		.owner =	THIS_MODULE,
-		.name =		"ftdi_sio",
-	},
-	.description =		"FTDI USB Serial Device",
-	.id_table =		id_table_combined,
-	.num_ports =		1,
-	.bulk_in_size =		512,
-	.bulk_out_size =	256,
-	.probe =		ftdi_sio_probe,
-	.port_probe =		ftdi_sio_port_probe,
-	.port_remove =		ftdi_sio_port_remove,
-	.open =			ftdi_open,
-	.dtr_rts =		ftdi_dtr_rts,
-	.throttle =		usb_serial_generic_throttle,
-	.unthrottle =		usb_serial_generic_unthrottle,
-	.process_read_urb =	ftdi_process_read_urb,
-	.prepare_write_buffer =	ftdi_prepare_write_buffer,
-	.tiocmget =		ftdi_tiocmget,
-	.tiocmset =		ftdi_tiocmset,
-	.tiocmiwait =		usb_serial_generic_tiocmiwait,
-	.get_icount =           usb_serial_generic_get_icount,
-	.ioctl =		ftdi_ioctl,
-	.get_serial =		get_serial_info,
-	.set_serial =		set_serial_info,
-	.set_termios =		ftdi_set_termios,
-	.break_ctl =		ftdi_break_ctl,
-	.tx_empty =		ftdi_tx_empty,
-};
-
-static struct usb_serial_driver * const serial_drivers[] = {
-	&ftdi_sio_device, NULL
-};
-
 
 #define WDR_TIMEOUT 5000 /* default urb timeout */
 #define WDR_SHORT_TIMEOUT 1000	/* shorter urb timeout */
@@ -1729,50 +1694,12 @@ static ssize_t event_char_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(event_char);
 
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
+static struct attribute *ftdi_sio_attrs[] = {
+	&dev_attr_event_char.attr,
+	&dev_attr_latency_timer.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ftdi_sio);
 
 #ifdef CONFIG_GPIOLIB
 
@@ -2251,7 +2178,6 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 	if (read_latency_timer(port) < 0)
 		priv->latency = 16;
 	write_latency_timer(port);
-	create_sysfs_attrs(port);
 
 	result = ftdi_gpio_init(port);
 	if (result < 0) {
@@ -2377,8 +2303,6 @@ static void ftdi_sio_port_remove(struct usb_serial_port *port)
 
 	ftdi_gpio_remove(port);
 
-	remove_sysfs_attrs(port);
-
 	kfree(priv);
 }
 
@@ -2915,6 +2839,42 @@ static int ftdi_ioctl(struct tty_struct *tty,
 	return -ENOIOCTLCMD;
 }
 
+static struct usb_serial_driver ftdi_sio_device = {
+	.driver = {
+		.owner =	THIS_MODULE,
+		.name =		"ftdi_sio",
+		.dev_groups =	ftdi_sio_groups,
+	},
+	.description =		"FTDI USB Serial Device",
+	.id_table =		id_table_combined,
+	.num_ports =		1,
+	.bulk_in_size =		512,
+	.bulk_out_size =	256,
+	.probe =		ftdi_sio_probe,
+	.port_probe =		ftdi_sio_port_probe,
+	.port_remove =		ftdi_sio_port_remove,
+	.open =			ftdi_open,
+	.dtr_rts =		ftdi_dtr_rts,
+	.throttle =		usb_serial_generic_throttle,
+	.unthrottle =		usb_serial_generic_unthrottle,
+	.process_read_urb =	ftdi_process_read_urb,
+	.prepare_write_buffer =	ftdi_prepare_write_buffer,
+	.tiocmget =		ftdi_tiocmget,
+	.tiocmset =		ftdi_tiocmset,
+	.tiocmiwait =		usb_serial_generic_tiocmiwait,
+	.get_icount =           usb_serial_generic_get_icount,
+	.ioctl =		ftdi_ioctl,
+	.get_serial =		get_serial_info,
+	.set_serial =		set_serial_info,
+	.set_termios =		ftdi_set_termios,
+	.break_ctl =		ftdi_break_ctl,
+	.tx_empty =		ftdi_tx_empty,
+};
+
+static struct usb_serial_driver * const serial_drivers[] = {
+	&ftdi_sio_device, NULL
+};
+
 module_usb_serial_driver(serial_drivers, id_table_combined);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
-- 
2.25.1

