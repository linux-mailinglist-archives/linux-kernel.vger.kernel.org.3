Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504A158DB32
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbiHIPgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbiHIPfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:35:44 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5191F17
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:35:43 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a19-20020aa780d3000000b0052bccd363f8so5316247pfn.22
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=f7QNBZGNnK5yYhhuUlGnKKkabxvWElh1Ug+FZ9u2MZY=;
        b=a+U4jExmeiVGPDVS/VtZgtsM5CgcPE/IppJwGzKXGunG6gLctOgbV/HwHLJiW4LqOn
         SkduGFbSnHJrnM0+2DTSS8ITe+UcjruXx4Bf7cg3Or/nalbfUZWrjcLZd1K1j2mZN0qj
         s/W+N9qND8wus4pLak1UdI6s+hBykKIFt5+MAq24nd5cpca/trMgJrihO0Gt94saBY36
         ZRck6GFsg/r6zzlpvVGmXBBlxDAVwjj4A7iEKZs5HihhcXkISZu+lTvgTzrRcu1HLZyv
         V7Wgr65qpvLexzl4CF9YKaczOcHVai9aNfI/agbYm9X+0KtrGKm1F4Y2MQsQSLWeeJuR
         X0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=f7QNBZGNnK5yYhhuUlGnKKkabxvWElh1Ug+FZ9u2MZY=;
        b=GMxO92TgejTB2uIXpWLx9beKRf4i0Ah3P2Mi+KXHM9NOtfCeH/5/aYGiAdZzg9Jtt/
         CctGOinj5c1BAq/EDktaRqSXYzw9P7hG4IZJ/BrHIVzK0dYOZ5I+4udlqruTcssPx0iN
         vSkYhL6KrcWG/27gwCvp3Y0L1ZTD49c5HTmt6+/ft+U6FxuTEfEzCP2jMeApOhmm9beV
         HHI3/nBSs6IZIjLjdP2FhjrHvz3qo/RZQ+RhOsmMv35k5fP79pQN7Wsd7JzQyXs1TvOk
         xOW1r/Knddc8p5l2YQj7trrXd4jF3Avsvkct/6ug9oZVX+e5rrNimCMiOEyVVOjsWCLb
         +kDg==
X-Gm-Message-State: ACgBeo3wgvzT6Cpa8ZW8fmzcyW8t2HWgEDn4gQTRwkWvQNKHxRP2Fldb
        XGxDltKwHQkzzOUQng4fMW7YrTcYBx/zRQ==
X-Google-Smtp-Source: AA6agR7TfjwH/GCmWvBBxw6G0/8wn4UVwrMJS5YLYSlniLXnKBsOpoBoqFMv0wVWEh8/dxTI14GFq1UlYV7LKA==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:91a6:8007:96f6:3fb3])
 (user=mmandlik job=sendgmr) by 2002:a17:90b:394:b0:1f5:90a1:acf0 with SMTP id
 ga20-20020a17090b039400b001f590a1acf0mr21065299pjb.40.1660059343098; Tue, 09
 Aug 2022 08:35:43 -0700 (PDT)
Date:   Tue,  9 Aug 2022 08:35:24 -0700
In-Reply-To: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Message-Id: <20220809083112.v4.2.Ief1110784c6c1c3ac0ee5677c2d28d785af8686d@changeid>
Mime-Version: 1.0
References: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 2/5] devcoredump: Add per device sysfs entry to
 enable/disable coredump
From:   Manish Mandlik <mmandlik@google.com>
To:     Arend van Spriel <aspriel@gmail.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Won Chung <wonchung@google.com>, linux-kernel@vger.kernel.org
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

The /sys/class/devcoredump/disabled provides only one-way disable
functionality. Also, disabling devcoredump using it disables the
devcoredump functionality for everyone who is using it.

Provide a way to selectively enable/disable devcoredump for the device
which is bound to a driver that implements the '.coredump()' callback.

This adds the 'coredump_disabled' driver attribute. When the driver
implements the '.coredump()' callback, 'coredump_disabled' file is added
along with the 'coredump' file in the sysfs folder of the device upon
driver binding. The file is removed when the driver is unbound.

Drivers can use this attribute to enable/disable devcoredump and the
userspace can write 0 or 1 to /sys/devices/.../coredump_disabled sysfs
entry to control enabling/disabling of devcoredump for that device.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v4:
- New patch in the series

 drivers/base/dd.c          | 43 +++++++++++++++++++++++++++++++++++---
 drivers/base/devcoredump.c |  2 +-
 include/linux/device.h     |  4 ++++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 11b0fb6414d3..c76d1145c6d9 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -426,6 +426,31 @@ static ssize_t coredump_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(coredump);
 
+static ssize_t coredump_disabled_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	return scnprintf(buf, 3, "%d\n", dev->coredump_disabled);
+}
+
+static ssize_t coredump_disabled_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	long coredump_disabled;
+
+	if (!kstrtol(buf, 10, &coredump_disabled)) {
+		/* Consider any non-zero value as true */
+		if (coredump_disabled)
+			dev->coredump_disabled = true;
+		else
+			dev->coredump_disabled = false;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(coredump_disabled);
+
 static int driver_sysfs_add(struct device *dev)
 {
 	int ret;
@@ -448,9 +473,19 @@ static int driver_sysfs_add(struct device *dev)
 		return 0;
 
 	ret = device_create_file(dev, &dev_attr_coredump);
-	if (!ret)
-		return 0;
+	if (ret)
+		goto rm_driver;
+
+	ret = device_create_file(dev, &dev_attr_coredump_disabled);
+	if (ret)
+		goto rm_coredump;
 
+	return 0;
+
+rm_coredump:
+	device_remove_file(dev, &dev_attr_coredump);
+
+rm_driver:
 	sysfs_remove_link(&dev->kobj, "driver");
 
 rm_dev:
@@ -466,8 +501,10 @@ static void driver_sysfs_remove(struct device *dev)
 	struct device_driver *drv = dev->driver;
 
 	if (drv) {
-		if (drv->coredump)
+		if (drv->coredump) {
+			device_remove_file(dev, &dev_attr_coredump_disabled);
 			device_remove_file(dev, &dev_attr_coredump);
+		}
 		sysfs_remove_link(&drv->p->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
 	}
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f4d794d6bb85..c5e9af9f3181 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -255,7 +255,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	struct devcd_entry *devcd;
 	struct device *existing;
 
-	if (devcd_disabled)
+	if (devcd_disabled || dev->coredump_disabled)
 		goto free;
 
 	existing = class_find_device(&devcd_class, NULL, dev,
diff --git a/include/linux/device.h b/include/linux/device.h
index dc941997795c..120dd656f99d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -469,6 +469,8 @@ struct device_physical_location {
  * 		This identifies the device type and carries type-specific
  * 		information.
  * @mutex:	Mutex to synchronize calls to its driver.
+ * @coredump_disabled: Can be used by drivers to selectively enable/disable the
+ *		coredump for a particular device via sysfs entry.
  * @bus:	Type of bus device is on.
  * @driver:	Which driver has allocated this
  * @platform_data: Platform data specific to the device.
@@ -561,6 +563,8 @@ struct device {
 	const char		*init_name; /* initial name of the device */
 	const struct device_type *type;
 
+	bool			coredump_disabled;
+
 	struct bus_type	*bus;		/* type of bus device is on */
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */
-- 
2.37.1.559.g78731f0fdb-goog

