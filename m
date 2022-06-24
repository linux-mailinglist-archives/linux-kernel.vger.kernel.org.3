Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79AA559943
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiFXMNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiFXMNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:13:22 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06B3711A3E;
        Fri, 24 Jun 2022 05:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dCVAF
        g1Xwg/853LvCY7lDE9T1kV3cBGaSYxpoP9Md5c=; b=aqyWEmfA6v816r0dWOXz+
        HuwWeifkl3s29/+AmA0zkT27UZpV8Xw1T+mzrooTnIDigB2WGU8oD85P1qKy1c8O
        wGYp9NFC4FO2uGLPhcQ0locVcd3I4J69h1YmyPB4y0mHaoYvaGHBhLSGjCvtX0nl
        JyirhIopXTlW7C37JZDNwQ=
Received: from carlis-virtual-machine (unknown [218.17.89.92])
        by smtp7 (Coremail) with SMTP id C8CowAAHB446qrViCNh7Jw--.27709S2;
        Fri, 24 Jun 2022 20:12:42 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     gregkh@linuxfoundation.org, zhangxuezhi1@coolpad.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: core: sysfs: convert sysfs snprintf to sysfs_emit
Date:   Fri, 24 Jun 2022 20:12:38 +0800
Message-Id: <20220624121238.134256-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAAHB446qrViCNh7Jw--.27709S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3urWDury7WFWxWw47ur1rWFg_yoW8JF17uo
        W7WFs3Xw1rGr4UKr4kXF4xta9xXayUCan8urn5Wr4qga9ayrnYyw43tFn3Jw1DWr1FgF4U
        AF1fta1SqF4rGr4rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUacTmUUUUU
X-Originating-IP: [218.17.89.92]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/1tbiQwwqhVc7aPNT5AAAsg
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up all sysfs show entries to use sysfs_emit

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
v3: fix up all sysfs show entries and modify comment.
v2: add correct public mailing list.
---
 drivers/usb/core/sysfs.c | 79 ++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index fa2e49d432ff..631574718d8a 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -35,7 +35,7 @@ static ssize_t field##_show(struct device *dev,				\
 		return -EINTR;						\
 	actconfig = udev->actconfig;					\
 	if (actconfig)							\
-		rc = sprintf(buf, format_string,			\
+		rc = sysfs_emit(buf, format_string,			\
 				actconfig->desc.field);			\
 	usb_unlock_device(udev);					\
 	return rc;							\
@@ -61,7 +61,7 @@ static ssize_t bMaxPower_show(struct device *dev,
 		return -EINTR;
 	actconfig = udev->actconfig;
 	if (actconfig)
-		rc = sprintf(buf, "%dmA\n", usb_get_max_power(udev, actconfig));
+		rc = sysfs_emit(buf, "%dmA\n", usb_get_max_power(udev, actconfig));
 	usb_unlock_device(udev);
 	return rc;
 }
@@ -80,7 +80,7 @@ static ssize_t configuration_show(struct device *dev,
 		return -EINTR;
 	actconfig = udev->actconfig;
 	if (actconfig && actconfig->string)
-		rc = sprintf(buf, "%s\n", actconfig->string);
+		rc = sysfs_emit(buf, "%s\n", actconfig->string);
 	usb_unlock_device(udev);
 	return rc;
 }
@@ -114,7 +114,7 @@ static ssize_t devspec_show(struct device *dev, struct device_attribute *attr,
 {
 	struct device_node *of_node = dev->of_node;
 
-	return sprintf(buf, "%pOF\n", of_node);
+	return sysfs_emit(buf, "%pOF\n", of_node);
 }
 static DEVICE_ATTR_RO(devspec);
 #endif
@@ -131,7 +131,7 @@ static ssize_t  name##_show(struct device *dev,				\
 	retval = usb_lock_device_interruptible(udev);			\
 	if (retval < 0)							\
 		return -EINTR;						\
-	retval = sprintf(buf, "%s\n", udev->name);			\
+	retval = sysfs_emit(buf, "%s\n", udev->name);			\
 	usb_unlock_device(udev);					\
 	return retval;							\
 }									\
@@ -175,7 +175,7 @@ static ssize_t speed_show(struct device *dev, struct device_attribute *attr,
 	default:
 		speed = "unknown";
 	}
-	return sprintf(buf, "%s\n", speed);
+	return sysfs_emit(buf, "%s\n", speed);
 }
 static DEVICE_ATTR_RO(speed);
 
@@ -185,7 +185,7 @@ static ssize_t rx_lanes_show(struct device *dev, struct device_attribute *attr,
 	struct usb_device *udev;
 
 	udev = to_usb_device(dev);
-	return sprintf(buf, "%d\n", udev->rx_lanes);
+	return sysfs_emit(buf, "%d\n", udev->rx_lanes);
 }
 static DEVICE_ATTR_RO(rx_lanes);
 
@@ -195,7 +195,7 @@ static ssize_t tx_lanes_show(struct device *dev, struct device_attribute *attr,
 	struct usb_device *udev;
 
 	udev = to_usb_device(dev);
-	return sprintf(buf, "%d\n", udev->tx_lanes);
+	return sysfs_emit(buf, "%d\n", udev->tx_lanes);
 }
 static DEVICE_ATTR_RO(tx_lanes);
 
@@ -205,7 +205,7 @@ static ssize_t busnum_show(struct device *dev, struct device_attribute *attr,
 	struct usb_device *udev;
 
 	udev = to_usb_device(dev);
-	return sprintf(buf, "%d\n", udev->bus->busnum);
+	return sysfs_emit(buf, "%d\n", udev->bus->busnum);
 }
 static DEVICE_ATTR_RO(busnum);
 
@@ -215,7 +215,7 @@ static ssize_t devnum_show(struct device *dev, struct device_attribute *attr,
 	struct usb_device *udev;
 
 	udev = to_usb_device(dev);
-	return sprintf(buf, "%d\n", udev->devnum);
+	return sysfs_emit(buf, "%d\n", udev->devnum);
 }
 static DEVICE_ATTR_RO(devnum);
 
@@ -225,7 +225,7 @@ static ssize_t devpath_show(struct device *dev, struct device_attribute *attr,
 	struct usb_device *udev;
 
 	udev = to_usb_device(dev);
-	return sprintf(buf, "%s\n", udev->devpath);
+	return sysfs_emit(buf, "%s\n", udev->devpath);
 }
 static DEVICE_ATTR_RO(devpath);
 
@@ -237,7 +237,7 @@ static ssize_t version_show(struct device *dev, struct device_attribute *attr,
 
 	udev = to_usb_device(dev);
 	bcdUSB = le16_to_cpu(udev->descriptor.bcdUSB);
-	return sprintf(buf, "%2x.%02x\n", bcdUSB >> 8, bcdUSB & 0xff);
+	return sysfs_emit(buf, "%2x.%02x\n", bcdUSB >> 8, bcdUSB & 0xff);
 }
 static DEVICE_ATTR_RO(version);
 
@@ -247,7 +247,7 @@ static ssize_t maxchild_show(struct device *dev, struct device_attribute *attr,
 	struct usb_device *udev;
 
 	udev = to_usb_device(dev);
-	return sprintf(buf, "%d\n", udev->maxchild);
+	return sysfs_emit(buf, "%d\n", udev->maxchild);
 }
 static DEVICE_ATTR_RO(maxchild);
 
@@ -257,7 +257,7 @@ static ssize_t quirks_show(struct device *dev, struct device_attribute *attr,
 	struct usb_device *udev;
 
 	udev = to_usb_device(dev);
-	return sprintf(buf, "0x%x\n", udev->quirks);
+	return sysfs_emit(buf, "0x%x\n", udev->quirks);
 }
 static DEVICE_ATTR_RO(quirks);
 
@@ -267,7 +267,7 @@ static ssize_t avoid_reset_quirk_show(struct device *dev,
 	struct usb_device *udev;
 
 	udev = to_usb_device(dev);
-	return sprintf(buf, "%d\n", !!(udev->quirks & USB_QUIRK_RESET));
+	return sysfs_emit(buf, "%d\n", !!(udev->quirks & USB_QUIRK_RESET));
 }
 
 static ssize_t avoid_reset_quirk_store(struct device *dev,
@@ -297,7 +297,7 @@ static ssize_t urbnum_show(struct device *dev, struct device_attribute *attr,
 	struct usb_device *udev;
 
 	udev = to_usb_device(dev);
-	return sprintf(buf, "%d\n", atomic_read(&udev->urbnum));
+	return sysfs_emit(buf, "%d\n", atomic_read(&udev->urbnum));
 }
 static DEVICE_ATTR_RO(urbnum);
 
@@ -305,8 +305,8 @@ static ssize_t ltm_capable_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	if (usb_device_supports_ltm(to_usb_device(dev)))
-		return sprintf(buf, "%s\n", "yes");
-	return sprintf(buf, "%s\n", "no");
+		return sysfs_emit(buf, "%s\n", "yes");
+	return sysfs_emit(buf, "%s\n", "no");
 }
 static DEVICE_ATTR_RO(ltm_capable);
 
@@ -317,7 +317,7 @@ static ssize_t persist_show(struct device *dev, struct device_attribute *attr,
 {
 	struct usb_device *udev = to_usb_device(dev);
 
-	return sprintf(buf, "%d\n", udev->persist_enabled);
+	return sysfs_emit(buf, "%d\n", udev->persist_enabled);
 }
 
 static ssize_t persist_store(struct device *dev, struct device_attribute *attr,
@@ -372,7 +372,7 @@ static ssize_t connected_duration_show(struct device *dev,
 {
 	struct usb_device *udev = to_usb_device(dev);
 
-	return sprintf(buf, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			jiffies_to_msecs(jiffies - udev->connect_time));
 }
 static DEVICE_ATTR_RO(connected_duration);
@@ -394,14 +394,14 @@ static ssize_t active_duration_show(struct device *dev,
 		duration = jiffies_to_msecs(jiffies + udev->active_duration);
 	else
 		duration = jiffies_to_msecs(udev->active_duration);
-	return sprintf(buf, "%u\n", duration);
+	return sysfs_emit(buf, "%u\n", duration);
 }
 static DEVICE_ATTR_RO(active_duration);
 
 static ssize_t autosuspend_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", dev->power.autosuspend_delay / 1000);
+	return sysfs_emit(buf, "%d\n", dev->power.autosuspend_delay / 1000);
 }
 
 static ssize_t autosuspend_store(struct device *dev,
@@ -442,7 +442,7 @@ static ssize_t level_show(struct device *dev, struct device_attribute *attr,
 	warn_level();
 	if (udev->state != USB_STATE_SUSPENDED && !udev->dev.power.runtime_auto)
 		p = on_string;
-	return sprintf(buf, "%s\n", p);
+	return sysfs_emit(buf, "%s\n", p);
 }
 
 static ssize_t level_store(struct device *dev, struct device_attribute *attr,
@@ -490,7 +490,7 @@ static ssize_t usb2_hardware_lpm_show(struct device *dev,
 	else
 		p = "disabled";
 
-	return sprintf(buf, "%s\n", p);
+	return sysfs_emit(buf, "%s\n", p);
 }
 
 static ssize_t usb2_hardware_lpm_store(struct device *dev,
@@ -529,7 +529,7 @@ static ssize_t usb2_lpm_l1_timeout_show(struct device *dev,
 					char *buf)
 {
 	struct usb_device *udev = to_usb_device(dev);
-	return sprintf(buf, "%d\n", udev->l1_params.timeout);
+	return sysfs_emit(buf, "%d\n", udev->l1_params.timeout);
 }
 
 static ssize_t usb2_lpm_l1_timeout_store(struct device *dev,
@@ -552,7 +552,7 @@ static ssize_t usb2_lpm_besl_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct usb_device *udev = to_usb_device(dev);
-	return sprintf(buf, "%d\n", udev->l1_params.besl);
+	return sysfs_emit(buf, "%d\n", udev->l1_params.besl);
 }
 
 static ssize_t usb2_lpm_besl_store(struct device *dev,
@@ -589,7 +589,7 @@ static ssize_t usb3_hardware_lpm_u1_show(struct device *dev,
 
 	usb_unlock_device(udev);
 
-	return sprintf(buf, "%s\n", p);
+	return sysfs_emit(buf, "%s\n", p);
 }
 static DEVICE_ATTR_RO(usb3_hardware_lpm_u1);
 
@@ -611,7 +611,7 @@ static ssize_t usb3_hardware_lpm_u2_show(struct device *dev,
 
 	usb_unlock_device(udev);
 
-	return sprintf(buf, "%s\n", p);
+	return sysfs_emit(buf, "%s\n", p);
 }
 static DEVICE_ATTR_RO(usb3_hardware_lpm_u2);
 
@@ -694,7 +694,7 @@ field##_show(struct device *dev, struct device_attribute *attr,	\
 	struct usb_device *udev;					\
 									\
 	udev = to_usb_device(dev);					\
-	return sprintf(buf, format_string, 				\
+	return sysfs_emit(buf, format_string,				\
 			le16_to_cpu(udev->descriptor.field));		\
 }									\
 static DEVICE_ATTR_RO(field)
@@ -711,7 +711,7 @@ field##_show(struct device *dev, struct device_attribute *attr,	\
 	struct usb_device *udev;					\
 									\
 	udev = to_usb_device(dev);					\
-	return sprintf(buf, format_string, udev->descriptor.field);	\
+	return sysfs_emit(buf, format_string, udev->descriptor.field);	\
 }									\
 static DEVICE_ATTR_RO(field)
 
@@ -727,7 +727,7 @@ static ssize_t authorized_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct usb_device *usb_dev = to_usb_device(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", usb_dev->authorized);
+	return sysfs_emit(buf, "%u\n", usb_dev->authorized);
 }
 
 /*
@@ -918,7 +918,7 @@ static ssize_t authorized_default_show(struct device *dev,
 	struct usb_hcd *hcd;
 
 	hcd = bus_to_hcd(usb_bus);
-	return snprintf(buf, PAGE_SIZE, "%u\n", hcd->dev_policy);
+	return sysfs_emit(buf, "%u\n", hcd->dev_policy);
 }
 
 static ssize_t authorized_default_store(struct device *dev,
@@ -957,7 +957,7 @@ static ssize_t interface_authorized_default_show(struct device *dev,
 	struct usb_device *usb_dev = to_usb_device(dev);
 	struct usb_hcd *hcd = bus_to_hcd(usb_dev->bus);
 
-	return sprintf(buf, "%u\n", !!HCD_INTF_AUTHORIZED(hcd));
+	return sysfs_emit(buf, "%u\n", !!HCD_INTF_AUTHORIZED(hcd));
 }
 
 /*
@@ -1066,7 +1066,7 @@ iad_##field##_show(struct device *dev, struct device_attribute *attr,	\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 									\
-	return sprintf(buf, format_string,				\
+	return sysfs_emit(buf, format_string,				\
 			intf->intf_assoc->field); 			\
 }									\
 static DEVICE_ATTR_RO(iad_##field)
@@ -1085,7 +1085,7 @@ field##_show(struct device *dev, struct device_attribute *attr,		\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 									\
-	return sprintf(buf, format_string,				\
+	return sysfs_emit(buf, format_string,				\
 			intf->cur_altsetting->desc.field); 		\
 }									\
 static DEVICE_ATTR_RO(field)
@@ -1107,7 +1107,7 @@ static ssize_t interface_show(struct device *dev, struct device_attribute *attr,
 	string = READ_ONCE(intf->cur_altsetting->string);
 	if (!string)
 		return 0;
-	return sprintf(buf, "%s\n", string);
+	return sysfs_emit(buf, "%s\n", string);
 }
 static DEVICE_ATTR_RO(interface);
 
@@ -1122,7 +1122,8 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 	udev = interface_to_usbdev(intf);
 	alt = READ_ONCE(intf->cur_altsetting);
 
-	return sprintf(buf, "usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02X"
+	return sysfs_emit(buf,
+			"usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02X"
 			"ic%02Xisc%02Xip%02Xin%02X\n",
 			le16_to_cpu(udev->descriptor.idVendor),
 			le16_to_cpu(udev->descriptor.idProduct),
@@ -1150,7 +1151,7 @@ static ssize_t supports_autosuspend_show(struct device *dev,
 	s = (!dev->driver || to_usb_driver(dev->driver)->supports_autosuspend);
 	device_unlock(dev);
 
-	return sprintf(buf, "%u\n", s);
+	return sysfs_emit(buf, "%u\n", s);
 }
 static DEVICE_ATTR_RO(supports_autosuspend);
 
@@ -1163,7 +1164,7 @@ static ssize_t interface_authorized_show(struct device *dev,
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 
-	return sprintf(buf, "%u\n", intf->authorized);
+	return sysfs_emit(buf, "%u\n", intf->authorized);
 }
 
 /*
-- 
2.34.1

