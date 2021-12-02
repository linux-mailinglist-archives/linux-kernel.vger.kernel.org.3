Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF0466101
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357076AbhLBKAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:00:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356753AbhLBJ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638438826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6L8O/LZ085WYDY0envLI3JxUJvIUNSDN4ovcLm3NuY=;
        b=GnOMDF3o72KvZhNtGiUzaksCuk8IVpXNX4WRRnJmXPlNA0Oobf1OopFnP6d3mLGACuFtJr
        L5xFpFk9Id3EtQ4nd28DK3Fe1KAWlE2QOOu8ThxSUJBPsc+eV8xtET1qj54nozGZRPj6Yd
        CN2U1bxlwv+Tmsr9lKL4ZCok04ntKTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-xjWD61GZOra5Z1FV3R4uyg-1; Thu, 02 Dec 2021 04:53:44 -0500
X-MC-Unique: xjWD61GZOra5Z1FV3R4uyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DD5D10151E1;
        Thu,  2 Dec 2021 09:53:43 +0000 (UTC)
Received: from xps-13.redhat.com (unknown [10.39.195.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB4A019724;
        Thu,  2 Dec 2021 09:53:41 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/4] HID: add suspend/resume helpers
Date:   Thu,  2 Dec 2021 10:53:33 +0100
Message-Id: <20211202095334.14399-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20211202095334.14399-1-benjamin.tissoires@redhat.com>
References: <20211202095334.14399-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lot of duplication of code in the HID low level drivers.
Better have everything in one place so we can eventually extend it
in a generic way.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c                     | 29 ++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-core.c         | 15 +++--------
 drivers/hid/surface-hid/surface_hid_core.c | 25 ++++---------------
 drivers/hid/usbhid/hid-core.c              | 19 ++++++--------
 include/linux/hid.h                        | 10 ++++++++
 5 files changed, 56 insertions(+), 42 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index dbed2524fd47..5402329d6eca 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2126,6 +2126,35 @@ void hid_hw_close(struct hid_device *hdev)
 }
 EXPORT_SYMBOL_GPL(hid_hw_close);
 
+#ifdef CONFIG_PM
+int hid_driver_suspend(struct hid_device *hdev, pm_message_t state)
+{
+	if (hdev->driver && hdev->driver->suspend)
+		return hdev->driver->suspend(hdev, state);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hid_driver_suspend);
+
+int hid_driver_reset_resume(struct hid_device *hdev)
+{
+	if (hdev->driver && hdev->driver->reset_resume)
+		return hdev->driver->reset_resume(hdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hid_driver_reset_resume);
+
+int hid_driver_resume(struct hid_device *hdev)
+{
+	if (hdev->driver && hdev->driver->resume)
+		return hdev->driver->resume(hdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hid_driver_resume);
+#endif /* CONFIG_PM */
+
 struct hid_dynid {
 	struct list_head list;
 	struct hid_device_id id;
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 68d9a089e3e8..656004919562 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1066,11 +1066,9 @@ static int i2c_hid_core_suspend(struct device *dev)
 	int ret;
 	int wake_status;
 
-	if (hid->driver && hid->driver->suspend) {
-		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
-		if (ret < 0)
-			return ret;
-	}
+	ret = hid_driver_suspend(hid, PMSG_SUSPEND);
+	if (ret < 0)
+		return ret;
 
 	/* Save some power */
 	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
@@ -1128,12 +1126,7 @@ static int i2c_hid_core_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (hid->driver && hid->driver->reset_resume) {
-		ret = hid->driver->reset_resume(hid);
-		return ret;
-	}
-
-	return 0;
+	return hid_driver_reset_resume(hid);
 }
 #endif
 
diff --git a/drivers/hid/surface-hid/surface_hid_core.c b/drivers/hid/surface-hid/surface_hid_core.c
index 5571e74abe91..e46330b2e561 100644
--- a/drivers/hid/surface-hid/surface_hid_core.c
+++ b/drivers/hid/surface-hid/surface_hid_core.c
@@ -204,50 +204,35 @@ static int surface_hid_suspend(struct device *dev)
 {
 	struct surface_hid_device *d = dev_get_drvdata(dev);
 
-	if (d->hid->driver && d->hid->driver->suspend)
-		return d->hid->driver->suspend(d->hid, PMSG_SUSPEND);
-
-	return 0;
+	return hid_driver_suspend(d->hid, PMSG_SUSPEND);
 }
 
 static int surface_hid_resume(struct device *dev)
 {
 	struct surface_hid_device *d = dev_get_drvdata(dev);
 
-	if (d->hid->driver && d->hid->driver->resume)
-		return d->hid->driver->resume(d->hid);
-
-	return 0;
+	return hid_driver_resume(d->hid);
 }
 
 static int surface_hid_freeze(struct device *dev)
 {
 	struct surface_hid_device *d = dev_get_drvdata(dev);
 
-	if (d->hid->driver && d->hid->driver->suspend)
-		return d->hid->driver->suspend(d->hid, PMSG_FREEZE);
-
-	return 0;
+	return hid_driver_suspend(d->hid, PMSG_FREEZE);
 }
 
 static int surface_hid_poweroff(struct device *dev)
 {
 	struct surface_hid_device *d = dev_get_drvdata(dev);
 
-	if (d->hid->driver && d->hid->driver->suspend)
-		return d->hid->driver->suspend(d->hid, PMSG_HIBERNATE);
-
-	return 0;
+	return hid_driver_suspend(d->hid, PMSG_HIBERNATE);
 }
 
 static int surface_hid_restore(struct device *dev)
 {
 	struct surface_hid_device *d = dev_get_drvdata(dev);
 
-	if (d->hid->driver && d->hid->driver->reset_resume)
-		return d->hid->driver->reset_resume(d->hid);
-
-	return 0;
+	return hid_driver_reset_resume(d->hid);
 }
 
 const struct dev_pm_ops surface_hid_pm_ops = {
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 2dcaf31eb9cd..54752c85604b 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1563,8 +1563,8 @@ static int hid_resume_common(struct hid_device *hid, bool driver_suspended)
 	int status = 0;
 
 	hid_restart_io(hid);
-	if (driver_suspended && hid->driver && hid->driver->resume)
-		status = hid->driver->resume(hid);
+	if (driver_suspended)
+		status = hid_driver_resume(hid);
 	return status;
 }
 
@@ -1588,11 +1588,9 @@ static int hid_suspend(struct usb_interface *intf, pm_message_t message)
 		{
 			set_bit(HID_SUSPENDED, &usbhid->iofl);
 			spin_unlock_irq(&usbhid->lock);
-			if (hid->driver && hid->driver->suspend) {
-				status = hid->driver->suspend(hid, message);
-				if (status < 0)
-					goto failed;
-			}
+			status = hid_driver_suspend(hid, message);
+			if (status < 0)
+				goto failed;
 			driver_suspended = true;
 		} else {
 			usbhid_mark_busy(usbhid);
@@ -1602,8 +1600,7 @@ static int hid_suspend(struct usb_interface *intf, pm_message_t message)
 
 	} else {
 		/* TODO: resume() might need to handle suspend failure */
-		if (hid->driver && hid->driver->suspend)
-			status = hid->driver->suspend(hid, message);
+		status = hid_driver_suspend(hid, message);
 		driver_suspended = true;
 		spin_lock_irq(&usbhid->lock);
 		set_bit(HID_SUSPENDED, &usbhid->iofl);
@@ -1644,8 +1641,8 @@ static int hid_reset_resume(struct usb_interface *intf)
 	int status;
 
 	status = hid_post_reset(intf);
-	if (status >= 0 && hid->driver && hid->driver->reset_resume) {
-		int ret = hid->driver->reset_resume(hid);
+	if (status >= 0) {
+		int ret = hid_driver_reset_resume(hid);
 		if (ret < 0)
 			status = ret;
 	}
diff --git a/include/linux/hid.h b/include/linux/hid.h
index f453be385bd4..cce1b01b3055 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -928,6 +928,16 @@ s32 hid_snto32(__u32 value, unsigned n);
 __u32 hid_field_extract(const struct hid_device *hid, __u8 *report,
 		     unsigned offset, unsigned n);
 
+#ifdef CONFIG_PM
+int hid_driver_suspend(struct hid_device *hdev, pm_message_t state);
+int hid_driver_reset_resume(struct hid_device *hdev);
+int hid_driver_resume(struct hid_device *hdev);
+#else
+static inline int hid_driver_suspend(struct hid_device *hdev, pm_message_t state) { return 0; }
+static inline int hid_driver_reset_resume(struct hid_device *hdev) { return 0; }
+static inline int hid_driver_resume(struct hid_device *hdev) { return 0; }
+#endif
+
 /**
  * hid_device_io_start - enable HID input during probe, remove
  *
-- 
2.33.1

