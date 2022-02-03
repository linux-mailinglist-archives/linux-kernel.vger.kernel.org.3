Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F272E4A835F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350334AbiBCLyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350332AbiBCLyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:54:00 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2146CC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:54:00 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id u130so2044645pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 03:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAqSf/tyCwdsZHkiyWbb3eiNXltTa0d1QVuYusLc2f0=;
        b=lEefzxPqPP58T2ta4bd1mVNE9Swkps/YStQ5ytP+dHpxeWeIBqbiai52u5LlNp6LLi
         kJIZlf1iyqU6qogMnjxpX3nC87Y4QK2DimNOtC69jLWO/jAsAG9R6LnmAbIperFt2bhh
         zLAq1VhpMJmNh2OLyjrZEKku+BKuzmdISuiOXPNOs1yxUi6hv24dKotuEP1YiG3MlKWP
         d04B05m34XKNPG3hP+WhUOYLsVegFC7kKD+kvh0L3z3k31B7HTaM6QTf8UPtyY4x9yvz
         rIGAOxh+MotKoCfiw8quYHOMCk2arbIcZnIXYpVm173U4puSr4c8GUllSO4F1uFx+m/2
         bL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dAqSf/tyCwdsZHkiyWbb3eiNXltTa0d1QVuYusLc2f0=;
        b=FItwTbMBMzm8E5RGqn5fcrCYkJQX52RawtbEEZP2vBXBcSU448kmN7H19FUUq5u0p6
         Ggpw9fsVRwMBYFYSPHfH/aB9OvZgB5Mkc/tXBrQHvDu1lV9Lu7iA2fPTko6NTsHhpQh2
         sTd9mCacs+XoRFRUbUbpH9TOakid3tTKCvc8z1FdGc6arzqUJFkfgijUy3RU5m62dTA6
         0DDEgCkYluTFPRApqao1RfS8G9+ZYI/f/L7+q93ZwrsQiFnD6T39KQoxTPypYIeDLuwa
         gt8yJ/6M2QaJSd6rcs+8/dF20jr3HFIqN6U109X9WjyGnopUtV/P+iqU+0bfkwtc+Oox
         TXTQ==
X-Gm-Message-State: AOAM5320wo2vONORK6s0nFQGtdkftP+yP0Gz6wgEx1slLV36lDpp1pr9
        xRAg7cXyr7kddNVDKqWX7Tc=
X-Google-Smtp-Source: ABdhPJxFEVOWHb3iWJqOFPjq9HC5m+R+EmkHDyHp9hzqEiU5T/OeGD1iK/5rq7whyILLd9P3KudZ8Q==
X-Received: by 2002:a05:6a00:24c8:: with SMTP id d8mr33627605pfv.60.1643889239499;
        Thu, 03 Feb 2022 03:53:59 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id mp22sm9586389pjb.28.2022.02.03.03.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 03:53:58 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 1/3] firmware: Add boot information to sysfs
Date:   Thu,  3 Feb 2022 22:23:42 +1030
Message-Id: <20220203115344.267159-2-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203115344.267159-1-joel@jms.id.au>
References: <20220203115344.267159-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Machines often have firmware that perform some action before Linux is
loaded. It's useful to know how this firmware is configured, so create a
sysfs directory and some properties that a system can choose to expose
to describe how the system was started.

Currently the intended use describes five files, relating to hardware
root of trust configuration.

These properties are populated by platform code at startup. Using fixed
values is suitable as the state that the system booted in will not
change after firmware has handed over.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 - Rewrite so properties are present in common code and are exposed based
   on the is_visible callback.
 - Use sysfs_emit
---
 .../ABI/testing/sysfs-firmware-bootinfo       | 43 +++++++++
 drivers/base/firmware.c                       | 90 +++++++++++++++++++
 include/linux/firmware_bootinfo.h             | 22 +++++
 3 files changed, 155 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-bootinfo
 create mode 100644 include/linux/firmware_bootinfo.h

diff --git a/Documentation/ABI/testing/sysfs-firmware-bootinfo b/Documentation/ABI/testing/sysfs-firmware-bootinfo
new file mode 100644
index 000000000000..cd6c42316345
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-bootinfo
@@ -0,0 +1,43 @@
+What:		/sys/firmware/bootinfo/*
+Date:		Jan 2022
+Description:
+		A system can expose information about how it was started in
+		this directory.
+
+		This information is agnostic as to the firmware implementation.
+
+		A system may expose a subset of these properties as applicable.
+
+
+What:		/sys/firmware/bootinfo/secure_boot
+Date:		Jan 2022
+Description:
+		Indicates the system was started with secure boot enabled in
+		the firmware.
+
+
+What:		/sys/firmware/bootinfo/abr_image
+Date:		Jan 2022
+Description:
+		Indicates the system was started from the alternate image
+		loaded from an Alternate Boot Region. Often this is a result of
+		the primary firmware image failing to start the system.
+
+
+What:		/sys/firmware/bootinfo/low_security_key
+Date:		Jan 2022
+Description:
+		Indicates the system's secure boot was verified with a low
+		security or development key.
+
+What:		/sys/firmware/bootinfo/otp_protected
+Date:		Jan 2022
+Description:
+		Indicates the system's boot configuration region is write
+		protected and cannot be modified.
+
+What:		/sys/firmware/bootinfo/uart_boot
+Date:		Jan 2022
+Description:
+		Indicates the system firmware was loaded from a UART instead of
+		an internal boot device.
diff --git a/drivers/base/firmware.c b/drivers/base/firmware.c
index 8dff940e0db9..24b931232eb2 100644
--- a/drivers/base/firmware.c
+++ b/drivers/base/firmware.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/firmware_bootinfo.h>
 
 #include "base.h"
 
@@ -24,3 +25,92 @@ int __init firmware_init(void)
 		return -ENOMEM;
 	return 0;
 }
+
+/*
+ * Exposes attributes documented in Documentation/ABI/testing/sysfs-firmware-bootinfo
+ */
+static struct bootinfo bootinfo;
+
+static ssize_t abr_image_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", bootinfo.abr_image.val);
+}
+static DEVICE_ATTR_RO(abr_image);
+
+static ssize_t low_security_key_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", bootinfo.low_security_key.val);
+}
+static DEVICE_ATTR_RO(low_security_key);
+
+static ssize_t otp_protected_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", bootinfo.otp_protected.val);
+}
+static DEVICE_ATTR_RO(otp_protected);
+
+static ssize_t secure_boot_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", bootinfo.secure_boot.val);
+}
+static DEVICE_ATTR_RO(secure_boot);
+
+static ssize_t uart_boot_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", bootinfo.uart_boot.val);
+}
+static DEVICE_ATTR_RO(uart_boot);
+
+#define ATTR_ENABLED(a) ((attr == &dev_attr_##a.attr) && bootinfo.a.en)
+
+static umode_t bootinfo_attr_mode(struct kobject *kobj, struct attribute *attr, int index)
+{
+	if (ATTR_ENABLED(abr_image))
+		return 0444;
+
+	if (ATTR_ENABLED(otp_protected))
+		return 0444;
+
+	if (ATTR_ENABLED(low_security_key))
+		return 0444;
+
+	if (ATTR_ENABLED(otp_protected))
+		return 0444;
+
+	if (ATTR_ENABLED(low_security_key))
+		return 0444;
+
+	if (ATTR_ENABLED(secure_boot))
+		return 0444;
+
+	if (ATTR_ENABLED(uart_boot))
+		return 0444;
+
+	return 0;
+}
+
+static struct attribute *bootinfo_attrs[] = {
+	&dev_attr_abr_image.attr,
+	&dev_attr_low_security_key.attr,
+	&dev_attr_otp_protected.attr,
+	&dev_attr_secure_boot.attr,
+	&dev_attr_uart_boot.attr,
+	NULL,
+};
+
+static const struct attribute_group bootinfo_attr_group = {
+	.attrs = bootinfo_attrs,
+	.is_visible = bootinfo_attr_mode,
+};
+
+int __init firmware_bootinfo_init(struct bootinfo *bootinfo_init)
+{
+	struct kobject *kobj = kobject_create_and_add("bootinfo", firmware_kobj);
+	if (!kobj)
+		return -ENOMEM;
+
+	memcpy(&bootinfo, bootinfo_init, sizeof(bootinfo));
+
+	return sysfs_create_group(kobj, &bootinfo_attr_group);
+}
+EXPORT_SYMBOL_GPL(firmware_bootinfo_init);
diff --git a/include/linux/firmware_bootinfo.h b/include/linux/firmware_bootinfo.h
new file mode 100644
index 000000000000..3fe630b061b9
--- /dev/null
+++ b/include/linux/firmware_bootinfo.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2022 IBM Corp. */
+
+#include <linux/sysfs.h>
+#include <linux/init.h>
+
+#define BOOTINFO_SET(b, n, v) b.n.en = true; b.n.val = v
+
+struct bootinfo_entry {
+	bool en;
+	bool val;
+};
+
+struct bootinfo {
+	struct bootinfo_entry abr_image;
+	struct bootinfo_entry low_security_key;
+	struct bootinfo_entry otp_protected;
+	struct bootinfo_entry secure_boot;
+	struct bootinfo_entry uart_boot;
+};
+
+int __init firmware_bootinfo_init(struct bootinfo *bootinfo_init);
-- 
2.34.1

