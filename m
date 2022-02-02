Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582394A79BC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiBBUs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiBBUs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:48:56 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13D5C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 12:48:56 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id p16-20020aa78610000000b004c7cf2724beso188675pfn.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 12:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=VOBAjyq2b7LS5jk1DWGIjLa8y/ewON831kKBJMT12z0=;
        b=RoV5IlpJcKyKQBHMxkNCgPeHNr0R+CgfoI9xJWjT6iZ5iBtLsOdi4QDKanESjOac/R
         S9re3QNsOho0EDogqxwHAfbzY4gPEjWE4t6LACnvD3EN9Wftwo6JXpBlcKXtlFDkChyg
         mE5FwwV7PW9swXYu/aEnCv8JhiE8aJGe1BTfLToWOo/aH9YdZwrP2fE85WsZPrHKwjWJ
         rDXT834dZKCQDX5q6cvGlF0ZagKSHd/2WmG/1RvihETlGWCjGnyJcZOpMByZpv4m8ant
         3pOFYA5ODa1AJ6rC0cEmgc0XubZaB4Pqw/hHlEg+9j1fAdaTaB1VbyZTS6PK+7KBX3pE
         InOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=VOBAjyq2b7LS5jk1DWGIjLa8y/ewON831kKBJMT12z0=;
        b=GgtJQHzd1aXu+OrjFLshSktm9DkpCoOpwKFti8BvJ4rnIcjO+7VNILB77F5nO31t1t
         oKGqJ76DwSAZzc0usO8JOzujsra/Fo1DZcgDrb8SoOgzr1zzmPKFjgtCXAK7j01pFZEY
         MakYYiExzXxvvaH1epoMzE+66L1zYsLb3PUgtc7+07NO61YKKouHbezzMxDEfwGr8zja
         WkyDQ72fzM7biIwqr+88AYD59E+IeA93AAAvBwJ1dQTfHEiLsWwJvjOV+5GsPiI+tav0
         hkxPOPcean4nsLtMx02wgGqh3RXtZPkwC9wpafykSiwtLEe34F56tdnq9Zp8VSbQy570
         YD7g==
X-Gm-Message-State: AOAM531ldfKeHqE/FMwre9itralPKVQuXCrQCROK8ZJIUQ4ceYOSuPAs
        vW9kmRtlAZ949/g1fHIr2LMVihGN7nRZNA==
X-Google-Smtp-Source: ABdhPJyC04jIm//5LR+IsUSOKrFbPoHKNQW9axcaKLh9YvJuxNJveo0LnIxiLeXKZTcSiRR7JFqLfJAwyLKFrw==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:902:9a01:: with SMTP id
 v1mr14933012plp.56.1643834935674; Wed, 02 Feb 2022 12:48:55 -0800 (PST)
Date:   Wed,  2 Feb 2022 20:48:51 +0000
Message-Id: <20220202204851.3619145-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v5] ACPI: device_sysfs: Add sysfs support for _PLD
From:   Won Chung <wonchung@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ACPI table includes _PLD fields for a device, create a new
directory (pld) in sysfs to share _PLD fields.

Currently without PLD information, when there are multiple of same
devices, it is hard to distinguish which device corresponds to which
location. For example, when there are two Type C connectors, it is hard
to find out which connector corresponds to the Type C port on the left
panel versus the Type C port on the right panel. With PLD information
provided, we can determine which specific device is doing what.

Signed-off-by: Won Chung <wonchung@google.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi | 107 +++++++++++++++++++++++
 drivers/acpi/device_sysfs.c              |  51 +++++++++++
 drivers/acpi/scan.c                      |  10 +--
 include/acpi/acpi_bus.h                  |   1 +
 4 files changed, 163 insertions(+), 6 deletions(-)

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
index d5d6403ba07b..00dc30a93550 100644
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
+	if (acpi_has_method(dev->handle, "_PLD")) {
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
+	if (acpi_has_method(dev->handle, "_PLD"))
+		device_remove_group(&dev->dev, &dev_attr_pld_group);
 }
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1331756d4cfc..92c40de36ca8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -668,17 +668,15 @@ static int acpi_tie_acpi_dev(struct acpi_device *adev=
)
 	return 0;
 }
=20
-static void acpi_store_pld_crc(struct acpi_device *adev)
+static void acpi_store_pld(struct acpi_device *adev)
 {
-	struct acpi_pld_info *pld;
 	acpi_status status;
=20
-	status =3D acpi_get_physical_device_location(adev->handle, &pld);
+	status =3D acpi_get_physical_device_location(adev->handle, &adev->pld);
 	if (ACPI_FAILURE(status))
 		return;
=20
-	adev->pld_crc =3D crc32(~0, pld, sizeof(*pld));
-	ACPI_FREE(pld);
+	adev->pld_crc =3D crc32(~0, adev->pld, sizeof(*adev->pld));
 }
=20
 static int __acpi_device_add(struct acpi_device *device,
@@ -739,7 +737,7 @@ static int __acpi_device_add(struct acpi_device *device=
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
2.35.0.263.gb82422642f-goog

