Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24CE4B1C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347327AbiBKCaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:30:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbiBKCaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:30:12 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67A51167
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:30:11 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id v20-20020a1709028d9400b0014ca63d0f10so2597404plo.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=gpfpq9IyFVXyGaNhLILmSz1fSNzB9aAjbA/VJj5uFog=;
        b=DIWMmG+pR0jMVrLQwTrdyYEQ7LiiwPfZjBBHEcrZeR1mDV+FVVP5rSeyCYsxHfBbB7
         YSe1euFw2H52nGF7IPuRazjPyr8r05TzB+COZasqQfcDwJTlSZ/qUxb7V8kUHUOfkvFd
         J3YuFykSAw6j/jVaI2ZM/9EX7RzGrlj2v/xy/4tu91oS3TXZvNh//oVbEIADHHQGX0r1
         6lAocs0MB5W6KPIdLnonP3XVzs6SlWn9cAPu0pxLhi9LVQQO9jCaUtvo9jbrITw8b+9i
         ObgkSRxOxn3RQMv1gQHOYWVxX7Six6P2mNoNuRsh3NNJltTJH0UOAQsNunZxKFI1WRu7
         6+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=gpfpq9IyFVXyGaNhLILmSz1fSNzB9aAjbA/VJj5uFog=;
        b=05I0xAdkrq2+Q0AR/LWs/fH983WkEZGuEVGw79I7nUYu0p5uH9Q50HnizMGoiHoPLE
         lcrpUaiyKU6obZYHhvWpsDUdg2jDlcPDJLiUBejjch5pB+3nPLriOGdTfcXpp++i3SBI
         XK8ZLiJAVbMFt6LHLPEJVF7SnrA9N3Cwhm6qYwF/MtSB/go0A6OTSe22/1PvvBz2zkvu
         NqivCI8SfboGzrFhHz6WoanZ4YfcKh5jMcVPrMH6DL+4lABISWogOHLvZEHMgqWI8J+h
         EuP3ttFxI0vQUubejMJQnlzcRE0YTvvTTNUSusky7BV/RlM4uMnMlMEmS+1bWotQA6bv
         K8IQ==
X-Gm-Message-State: AOAM530LqH+tncdHvw3DBLm19DEPfUtckHxm66eln830BkSN0Qi8J16i
        xCyEnLFaIaAUZPRQo33XYYkWjk6J8ZfSyQ==
X-Google-Smtp-Source: ABdhPJyyXum2JTqlievkZ2AsU1lIIYKc+AhVDFpTqsJ+zRJQ8/XMfGzKS+Ac/Sg23ZlTtu9/JOEl9eSZxx+qeg==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:90b:4ac4:: with SMTP id
 mh4mr400797pjb.89.1644546611407; Thu, 10 Feb 2022 18:30:11 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:30:07 +0000
Message-Id: <20220211023008.3197397-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v6] ACPI: device_sysfs: Add sysfs support for _PLD
From:   Won Chung <wonchung@google.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ACPI table includes _PLD fields for a device, create a new
directory (pld) in sysfs to share _PLD fields.

Currently without PLD information, when there are multiple of same
devices, it is hard to distinguish which device corresponds to which
physical device in which location. For example, when there are two Type
C connectors, it is hard to find out which connector corresponds to the
Type C port on the left panel versus the Type C port on the right panel.
With PLD information provided, we can determine which specific device at
which location is doing what.

Since PLD information is to be used for finding where physical device is
located in user's perspective, pld sysfs directory will only be created
for ACPI_BUS_TYPE_DEVICE with user_visible field set as 1.

Signed-off-by: Won Chung <wonchung@google.com>
---
Changes in v6:
- Add pld to acpi_device only if it is a user visible device.

Changes in v5:
- Store pld to acpi_device in acpi_store_pld_crc() and rename it as
  acpi_store_pld().

Changes in v4:
- Create seperate files for each _PLD fields instead of having a single
  file with all fields included.
- Create a new directory pld that contains _PLD fields

 Documentation/ABI/testing/sysfs-bus-acpi | 107 +++++++++++++++++++++++
 drivers/acpi/device_sysfs.c              |  51 +++++++++++
 drivers/acpi/scan.c                      |  12 ++-
 include/acpi/acpi_bus.h                  |   1 +
 4 files changed, 168 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/t=
esting/sysfs-bus-acpi
index 58abacf59b2a..b8b71c8f3cfd 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -96,3 +96,110 @@ Description:
 		hardware, if the _HRV control method is present.  It is mostly
 		useful for non-PCI devices because lspci can list the hardware
 		version for PCI devices.
+
+What:		/sys/bus/acpi/devices/.../pld/
+Date:		Feb, 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		This directory contains the output of the device object's _PLD
+		control method, if present. This information provides details
+		on physical location of a device.
+
+What:		/sys/bus/acpi/devices/.../pld/revision
+Date:		Feb, 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		The current revision is 0x2.
+
+What:           /sys/bus/acpi/devices/.../pld/group_token
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Unique numerical value identifying a group.
+
+What:           /sys/bus/acpi/devices/.../pld/group_position
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Identifies this device connection point=E2=80=99s position in the group.
+
+What:           /sys/bus/acpi/devices/.../pld/user_visible
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Set if the device connection point can be seen by the user
+		without disassembly.
+
+What:           /sys/bus/acpi/devices/.../pld/dock
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Set if the device connection point resides in a docking station
+		or port replicator.
+
+What:           /sys/bus/acpi/devices/.../pld/bay
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Set if describing a device in a bay or if device connection
+		point is a bay.
+
+What:           /sys/bus/acpi/devices/.../pld/lid
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Set if this device connection point resides on the lid of
+		laptop system.
+
+What:           /sys/bus/acpi/devices/.../pld/panel
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Describes which panel surface of the system=E2=80=99s housing the
+		device connection point resides on:
+		0 - Top
+		1 - Bottom
+		2 - Left
+		3 - Right
+		4 - Front
+		5 - Back
+		6 - Unknown (Vertical Position and Horizontal Position will be
+		ignored)
+
+What:           /sys/bus/acpi/devices/.../pld/vertical_position
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		0 - Upper
+		1 - Center
+		2 - Lower
+
+What:           /sys/bus/acpi/devices/.../pld/horizontal_position
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		ACPI specification does not define horizontal position field.
+		Can be used as either
+		0 - Left
+		1 - Center
+		2 - Right
+		or
+		0 - Leftmost
+		and higher numbers going toward the right.
+
+What:           /sys/bus/acpi/devices/.../pld/shape
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Describes the shape of the device connection point.
+		0 - Round
+		1 - Oval
+		2 - Square
+		3 - Vertical Rectangle
+		4 - Horizontal Rectangle
+		5 - Vertical Trapezoid
+		6 - Horizontal Trapezoid
+		7 - Unknown - Shape rendered as a Rectangle with dotted lines
+		8 - Chamfered
+		15:9 - Reserved
+
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index d5d6403ba07b..2702f78a2503 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -509,6 +509,49 @@ static ssize_t status_show(struct device *dev, struct =
device_attribute *attr,
 }
 static DEVICE_ATTR_RO(status);
=20
+#define DEV_ATTR_PLD_PROP(prop) \
+	static ssize_t prop##_show(struct device *dev, struct device_attribute *a=
ttr, \
+		char *buf) \
+{ \
+	struct acpi_device *acpi_dev =3D to_acpi_device(dev); \
+	if (acpi_dev->pld =3D=3D NULL) \
+		return -EIO; \
+	return sprintf(buf, "%u\n", acpi_dev->pld->prop); \
+}; \
+static DEVICE_ATTR_RO(prop)
+
+DEV_ATTR_PLD_PROP(revision);
+DEV_ATTR_PLD_PROP(group_token);
+DEV_ATTR_PLD_PROP(group_position);
+DEV_ATTR_PLD_PROP(user_visible);
+DEV_ATTR_PLD_PROP(dock);
+DEV_ATTR_PLD_PROP(bay);
+DEV_ATTR_PLD_PROP(lid);
+DEV_ATTR_PLD_PROP(panel);
+DEV_ATTR_PLD_PROP(vertical_position);
+DEV_ATTR_PLD_PROP(horizontal_position);
+DEV_ATTR_PLD_PROP(shape);
+
+static struct attribute *dev_attr_pld[] =3D {
+	&dev_attr_revision.attr,
+	&dev_attr_group_token.attr,
+	&dev_attr_group_position.attr,
+	&dev_attr_user_visible.attr,
+	&dev_attr_dock.attr,
+	&dev_attr_bay.attr,
+	&dev_attr_lid.attr,
+	&dev_attr_panel.attr,
+	&dev_attr_vertical_position.attr,
+	&dev_attr_horizontal_position.attr,
+	&dev_attr_shape.attr,
+	NULL,
+};
+
+static struct attribute_group dev_attr_pld_group =3D {
+	.name =3D "pld",
+	.attrs =3D dev_attr_pld,
+};
+
 /**
  * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
  * @dev: ACPI device object.
@@ -595,6 +638,12 @@ int acpi_device_setup_files(struct acpi_device *dev)
 						    &dev_attr_real_power_state);
 	}
=20
+	if (acpi_has_method(dev->handle, "_PLD") && dev->pld !=3D NULL) {
+		result =3D device_add_group(&dev->dev, &dev_attr_pld_group);
+		if (result)
+			goto end;
+	}
+
 	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
=20
 end:
@@ -645,4 +694,6 @@ void acpi_device_remove_files(struct acpi_device *dev)
 		device_remove_file(&dev->dev, &dev_attr_status);
 	if (dev->handle)
 		device_remove_file(&dev->dev, &dev_attr_path);
+	if (acpi_has_method(dev->handle, "_PLD") && dev->pld !=3D NULL)
+		device_remove_group(&dev->dev, &dev_attr_pld_group);
 }
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1331756d4cfc..35ac7bcc05ed 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -668,7 +668,7 @@ static int acpi_tie_acpi_dev(struct acpi_device *adev)
 	return 0;
 }
=20
-static void acpi_store_pld_crc(struct acpi_device *adev)
+static void acpi_store_pld(struct acpi_device *adev)
 {
 	struct acpi_pld_info *pld;
 	acpi_status status;
@@ -678,7 +678,13 @@ static void acpi_store_pld_crc(struct acpi_device *ade=
v)
 		return;
=20
 	adev->pld_crc =3D crc32(~0, pld, sizeof(*pld));
-	ACPI_FREE(pld);
+
+	if (adev->device_type =3D=3D ACPI_BUS_TYPE_DEVICE && pld->user_visible) {
+		adev->pld =3D pld;
+	} else {
+		adev->pld =3D NULL;
+		ACPI_FREE(pld);
+	}
 }
=20
 static int __acpi_device_add(struct acpi_device *device,
@@ -739,7 +745,7 @@ static int __acpi_device_add(struct acpi_device *device=
,
 	if (device->wakeup.flags.valid)
 		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
=20
-	acpi_store_pld_crc(device);
+	acpi_store_pld(device);
=20
 	mutex_unlock(&acpi_device_lock);
=20
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index ca88c4706f2b..929e726a666b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -381,6 +381,7 @@ struct acpi_device {
 	struct acpi_hotplug_context *hp;
 	struct acpi_driver *driver;
 	const struct acpi_gpio_mapping *driver_gpios;
+	struct acpi_pld_info *pld;
 	void *driver_data;
 	struct device dev;
 	unsigned int physical_node_count;
--=20
2.35.1.265.g69c8d7142f-goog

