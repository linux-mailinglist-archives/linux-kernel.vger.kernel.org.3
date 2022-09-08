Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4595B1A3B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiIHKlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiIHKkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:40:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573A99BB7B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 03:40:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f3-20020a056902038300b00696588a0e87so13160689ybs.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 03:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=4Isgkuea9p0Arz+WvNNRlBz5xkeTJ+kAkTQabzxUrw0=;
        b=syzJXntYI5F+CwDlx8P2LUzhxgadSnNa7z31ZO+PPe4KTJUbPA7jSXOHdCT1HbdrYV
         xeE9T9iDT5T47+CLHVUbAzAZ5VRxQC9/eKRTkbp+FMQrH4e4QmA3C2Cf76aJ+r5f/gIO
         azMkEEEjYixjmFxh6WWfpaqkS/PbSM82vvQzwau70OTnI6AMIudsQGt6/hDJzaoPfMiz
         HhkxE+jYoLu5aIxq290M+b+mCCUnEQx8VvVV+wyRY7fCWGZyKxEdwd64ngrS7RfRTQms
         jHbjep4s3GNy1fyibYlJsdUbL5uaVmTosOYgOVLARyl3rwbkhlO15oZPabETUNDDwtUn
         U48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=4Isgkuea9p0Arz+WvNNRlBz5xkeTJ+kAkTQabzxUrw0=;
        b=dNpDPQBy7FmZx0b89eLqOvQu4K4X6/f6rdQ2HN9EJSopJWLB9eCQ5NLQYht4GVN0rK
         q3he1duCKQ4UXIsiYOR8BkPL68yuWdXqk5q5XEJY04Ev2qbGJzMOKefFLEVUoLNxLIE4
         N70L9wvkfk0aYIVbiIoH5XoHY6bjA9DR5A2kP2lV6ZSLMs4YQTXm0T7ki0AnFc2PQDT3
         ygkAQeS4iPnXk4oYRs4vMrrif/NqsH7zedKS7pcCsLEif45rBYTfKwxWXaSy1l6XRqv7
         y+aQM+N8iZEXfDSKSXnMMLZUGf8UaMjz4xP6wlc21J1VE4ygIxrn55rwti0RQv+AF+Re
         mxHw==
X-Gm-Message-State: ACgBeo2OYrYWO93Y84+JEJmyMpkMRkYz7IwRTGaeNH0g9I+O/+Gp+/yJ
        sIBPTQ1pLCyM8x32o8dD8e7aArSKuys=
X-Google-Smtp-Source: AA6agR5xCKRj7XtJs+eibi6g49PcdjCpjupmCgC8d8UbBXpu8Z2cRkrM7vlM5R52PLtZFubhNYHII2TcN14=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:20dd:9a84:5a59:3c44])
 (user=raychi job=sendgmr) by 2002:a25:9803:0:b0:696:489e:b84d with SMTP id
 a3-20020a259803000000b00696489eb84dmr6590489ybo.317.1662633624609; Thu, 08
 Sep 2022 03:40:24 -0700 (PDT)
Date:   Thu,  8 Sep 2022 18:40:19 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220908104019.3080989-1-raychi@google.com>
Subject: [Patch v3] usb: core: stop USB enumeration if too many retries
From:   Ray Chi <raychi@google.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        mchehab+huawei@kernel.org
Cc:     albertccwang@google.com, badhri@google.com, pumahsu@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Ray Chi <raychi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a broken USB accessory connects to a USB host, usbcore might
keep doing enumeration retries. If the host has a watchdog mechanism,
the kernel panic will happen on the host.

The patch provide a attribute to limit the numbers of retries and
timeout lengths. In addition, it also adds a function to stop the
port initialization and ignore events on the port if the broken
accessory is still connected.

Signed-off-by: Ray Chi <raychi@google.com>
---
Changes since v2:
 - replace the quirk with the attribute
 - Document the attribute
 - modify hub_port_stop_enumerate() position in port_event()
 - modify the changelog

Changes since v1:
 - remove usb_hub_set_port_power()
 - add a variable ignore_connect into struct port_dev
 - modify hub_port_stop_enumerate() and set ignore_connect in
   this function
 - avoid calling hub_port_connect_change() in port_event()
---
 Documentation/ABI/testing/sysfs-bus-usb |  9 ++++++
 drivers/usb/core/hub.c                  | 39 +++++++++++++++++++++++++
 drivers/usb/core/hub.h                  |  4 +++
 drivers/usb/core/port.c                 | 23 +++++++++++++++
 4 files changed, 75 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 568103d3376e..d44c8aaef929 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -264,6 +264,15 @@ Description:
 		attached to the port will not be detected, initialized,
 		or enumerated.
 
+What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/quick_init
+Date:		Sep 2022
+Contact:	Ray Chi <raychi@google.com>
+Description:
+		Some USB hosts have some watchdog mechanisms so that the device
+		may enter ramdump if it takes a long time during port initialization.
+		This attribute limits the numbers of retries and timeout lengths once
+		an initialization of the port meets failures.
+
 What:		/sys/bus/usb/devices/.../power/usb2_lpm_l1_timeout
 Date:		May 2013
 Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index d4b1e70d1498..f22caa133274 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3081,6 +3081,29 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
 	return status;
 }
 
+/* Check whether a hub would stop enumeration or ignore events on the port. */
+static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
+{
+	struct usb_port *port_dev = hub->ports[port1 - 1];
+
+	if (port_dev->quick_init) {
+		if (port_dev->ignore_connect)
+			return true;
+
+		/*
+		 * Since some normal devices will be timeout in the first attempt,
+		 * set the condition to half of the retries
+		 */
+		if (retries < (PORT_INIT_TRIES - 1) / 2)
+			return false;
+
+		port_dev->ignore_connect = true;
+	} else
+		port_dev->ignore_connect = false;
+
+	return port_dev->ignore_connect;
+}
+
 /* Check if a port is power on */
 int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
 {
@@ -4855,6 +4878,11 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 					buf->bMaxPacketSize0;
 			kfree(buf);
 
+			if (r < 0 && port_dev->quick_init) {
+				retval = r;
+				goto fail;
+			}
+
 			retval = hub_port_reset(hub, port1, udev, delay, false);
 			if (retval < 0)		/* error or disconnect */
 				goto fail;
@@ -5387,6 +5415,9 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if ((status == -ENOTCONN) || (status == -ENOTSUPP))
 			break;
 
+		if (hub_port_stop_enumerate(hub, port1, i))
+			break;
+
 		/* When halfway through our retry count, power-cycle the port */
 		if (i == (PORT_INIT_TRIES - 1) / 2) {
 			dev_info(&port_dev->dev, "attempt power cycle\n");
@@ -5614,6 +5645,9 @@ static void port_event(struct usb_hub *hub, int port1)
 	if (!pm_runtime_active(&port_dev->dev))
 		return;
 
+	if (hub_port_stop_enumerate(hub, port1, 0))
+		return;
+
 	if (hub_handle_remote_wakeup(hub, port1, portstatus, portchange))
 		connect_change = 1;
 
@@ -5934,6 +5968,9 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 		ret = hub_port_init(parent_hub, udev, port1, i);
 		if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV)
 			break;
+
+		if (hub_port_stop_enumerate(parent_hub, port1, i))
+			goto stop_enumerate;
 	}
 	mutex_unlock(hcd->address0_mutex);
 
@@ -6022,6 +6059,8 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	udev->bos = bos;
 	return 0;
 
+stop_enumerate:
+	mutex_unlock(hcd->address0_mutex);
 re_enumerate:
 	usb_release_bos_descriptor(udev);
 	udev->bos = bos;
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index b2925856b4cb..57995ec3af58 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -90,6 +90,8 @@ struct usb_hub {
  * @is_superspeed cache super-speed status
  * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
  * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
+ * @ignore_connect: ignore the connection or not.
+ * @quick_init: limit the numbers of retries for port initialization
  */
 struct usb_port {
 	struct usb_device *child;
@@ -103,6 +105,8 @@ struct usb_port {
 	u32 over_current_count;
 	u8 portnum;
 	u32 quirks;
+	bool ignore_connect;
+	bool quick_init;
 	unsigned int is_superspeed:1;
 	unsigned int usb3_lpm_u1_permit:1;
 	unsigned int usb3_lpm_u2_permit:1;
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 38c1a4f4fdea..7d5acd3ff353 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -17,6 +17,28 @@ static int usb_port_block_power_off;
 
 static const struct attribute_group *port_dev_group[];
 
+static ssize_t quick_init_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+
+	return sysfs_emit(buf, "%s\n", port_dev->quick_init ? "yes" : "no");
+}
+
+static ssize_t quick_init_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+	bool value;
+
+	if (kstrtobool(buf, &value))
+		return -EINVAL;
+
+	port_dev->quick_init = value;
+	return count;
+}
+static DEVICE_ATTR_RW(quick_init);
+
 static ssize_t disable_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -236,6 +258,7 @@ static struct attribute *port_dev_attrs[] = {
 	&dev_attr_quirks.attr,
 	&dev_attr_over_current_count.attr,
 	&dev_attr_disable.attr,
+	&dev_attr_quick_init.attr,
 	NULL,
 };
 
-- 
2.37.2.789.g6183377224-goog

