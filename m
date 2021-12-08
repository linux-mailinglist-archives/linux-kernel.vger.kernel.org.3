Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668D446D03C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhLHJnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:43:55 -0500
Received: from mail.loongson.cn ([114.242.206.163]:47182 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229475AbhLHJnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:43:53 -0500
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX8tqfbBh+68EAA--.10672S2;
        Wed, 08 Dec 2021 17:40:00 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v1 1/2] HID: usbhid: enable remote wakeup function for usbhid device
Date:   Wed,  8 Dec 2021 17:39:50 +0800
Message-Id: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9DxX8tqfbBh+68EAA--.10672S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryxWrW5JF1UJr1UKry3urg_yoW8CrW3pw
        4kGFZ8trWDJryvkw43WF4kWFy5Jan2ka4rCrW7Aa4qgrn0yas3JryrtFyaya1UurWkAFnI
        gr40g3yUWa4j9r7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remote wake-up function is a regular function on usb hid device
and I think keeping it enabled by default will make usb application
more convenient. This patch is to enable remote wakeup function for
usb hid device.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 drivers/hid/usbhid/hid-core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 2dcaf31..3619b95 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1063,7 +1063,9 @@ static int usbhid_start(struct hid_device *hid)
 	struct usb_host_interface *interface = intf->cur_altsetting;
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct usbhid_device *usbhid = hid->driver_data;
+	struct usb_host_config *config;
 	unsigned int n, insize = 0;
+	int ncfg;
 	int ret;
 
 	mutex_lock(&usbhid->mutex);
@@ -1179,14 +1181,19 @@ static int usbhid_start(struct hid_device *hid)
 	/* Some keyboards don't work until their LEDs have been set.
 	 * Since BIOSes do set the LEDs, it must be safe for any device
 	 * that supports the keyboard boot protocol.
-	 * In addition, enable remote wakeup by default for all keyboard
-	 * devices supporting the boot protocol.
 	 */
 	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
 			interface->desc.bInterfaceProtocol ==
 				USB_INTERFACE_PROTOCOL_KEYBOARD) {
 		usbhid_set_leds(hid);
-		device_set_wakeup_enable(&dev->dev, 1);
+	}
+
+	for (ncfg = 0; ncfg < dev->descriptor.bNumConfigurations; ncfg++) {
+		config = &dev->config[ncfg];
+		if ((config->desc.bmAttributes & (1 << 5)) == 0)
+			break;
+		if (ncfg + 1 == dev->descriptor.bNumConfigurations)
+			device_set_wakeup_enable(&dev->dev, 1);
 	}
 
 	mutex_unlock(&usbhid->mutex);
-- 
1.8.3.1

