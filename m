Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B341746D03A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhLHJny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:43:54 -0500
Received: from mail.loongson.cn ([114.242.206.163]:47184 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229446AbhLHJnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:43:53 -0500
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX8tqfbBh+68EAA--.10672S3;
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
Subject: [PATCH v1 2/2] usb: core: enable remote wakeup function for usb controller
Date:   Wed,  8 Dec 2021 17:39:51 +0800
Message-Id: <1638956391-20149-2-git-send-email-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
X-CM-TRANSID: AQAAf9DxX8tqfbBh+68EAA--.10672S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyrZryrXr1xuFW7GrW3Wrg_yoWrGr45pw
        48CayrKrWUJry8WanFyrWDAw13Jw4Iya4fCas7u3yDW3s7A34kJF9Yyr95taykJrZ5AF43
        J3WfKay5W3WUCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
        vjfU86wZUUUUU
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remote wake up function is a regular function on usb device and
I think keeping it enabled by default will make the usb application
more convenient and usb device remote wake up function keep enabled
that ask usb controller remote wake up was enabled at first.

This patch only enable wake up on usb root hub device, among which,
usb3.0 root hub doesn't be set wakeup node property but use command
USB_INTRF_FUNC_SUSPEND to enable remote wake up function.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 drivers/usb/core/hub.c | 20 ++++++++++++++++++--
 include/linux/usb.h    |  4 +++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 86658a8..cb4b956 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2509,6 +2509,8 @@ static void set_usb_port_removable(struct usb_device *udev)
  */
 int usb_new_device(struct usb_device *udev)
 {
+	struct usb_host_config *config;
+	int ncfg;
 	int err;
 
 	if (udev->parent) {
@@ -2540,6 +2542,18 @@ int usb_new_device(struct usb_device *udev)
 	udev->dev.devt = MKDEV(USB_DEVICE_MAJOR,
 			(((udev->bus->busnum-1) * 128) + (udev->devnum-1)));
 
+	for (ncfg = 0; ncfg < udev->descriptor.bNumConfigurations; ncfg++) {
+		config = &udev->config[ncfg];
+		if ((config->desc.bmAttributes & (1 << 5)) == 0)
+			break;
+		if (ncfg + 1 == udev->descriptor.bNumConfigurations) {
+			err = usb_enable_remote_wakeup(udev);
+			if (err)
+				dev_dbg(&udev->dev,
+				      "won't remote wakeup, err %d\n", err);
+		}
+	}
+
 	/* Tell the world! */
 	announce_device(udev);
 
@@ -3234,7 +3248,7 @@ void usb_enable_ltm(struct usb_device *udev)
  * enable remote wake for the first interface.  FIXME if the interface
  * association descriptor shows there's more than one function.
  */
-static int usb_enable_remote_wakeup(struct usb_device *udev)
+int usb_enable_remote_wakeup(struct usb_device *udev)
 {
 	if (udev->speed < USB_SPEED_SUPER)
 		return usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
@@ -3249,6 +3263,7 @@ static int usb_enable_remote_wakeup(struct usb_device *udev)
 					USB_INTRF_FUNC_SUSPEND_LP,
 				NULL, 0, USB_CTRL_SET_TIMEOUT);
 }
+EXPORT_SYMBOL_GPL(usb_enable_remote_wakeup);
 
 /*
  * usb_disable_remote_wakeup - disable remote wakeup for a device
@@ -3260,7 +3275,7 @@ static int usb_enable_remote_wakeup(struct usb_device *udev)
  * disable remote wake for the first interface.  FIXME if the interface
  * association descriptor shows there's more than one function.
  */
-static int usb_disable_remote_wakeup(struct usb_device *udev)
+int usb_disable_remote_wakeup(struct usb_device *udev)
 {
 	if (udev->speed < USB_SPEED_SUPER)
 		return usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
@@ -3273,6 +3288,7 @@ static int usb_disable_remote_wakeup(struct usb_device *udev)
 				USB_INTRF_FUNC_SUSPEND,	0, NULL, 0,
 				USB_CTRL_SET_TIMEOUT);
 }
+EXPORT_SYMBOL_GPL(usb_disable_remote_wakeup);
 
 /* Count of wakeup-enabled devices at or below udev */
 unsigned usb_wakeup_enabled_descendants(struct usb_device *udev)
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7ccaa76..8097eee 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -754,8 +754,10 @@ static inline bool usb_acpi_power_manageable(struct usb_device *hdev, int index)
 	{ return true; }
 #endif
 
-/* USB autosuspend and autoresume */
 #ifdef CONFIG_PM
+extern int usb_enable_remote_wakeup(struct usb_device *udev);
+extern int usb_disable_remote_wakeup(struct usb_device *udev);
+
 extern void usb_enable_autosuspend(struct usb_device *udev);
 extern void usb_disable_autosuspend(struct usb_device *udev);
 
-- 
1.8.3.1

