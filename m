Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CF74A54C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiBABsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiBABsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:48:06 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E1C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:48:05 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 62-20020a17090a09c400b001b80b0742b0so1281358pjo.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=26fuvaER4d3o3+CCq4wIldSwQFOjL4djRnP08g9wyQI=;
        b=M0xYR5mBcaBe9GXmdN9ZH3iR0ewUivVKevfQIyV1PPaGyTj6GEI+AhcyUvXffl0v2H
         Kc1/YGobdqPtfTVdbNfbMqJXK/ha840RvVLq15j4aCpDSUjuqL7sZCR2jDzuV0TTYtb3
         t6OTwr5T61iyvrms5s196M0fzlaNG1tT1pOPJFEhEa9KXGbcxolKytdpBCfBUV8AaUC0
         1pIcJOUgAS4xl/sj4+ImwazbE8ju+9nf2vqAeVpfnKQvVVAnTQQykPU5BJdO4+xwT6MO
         Hg2BPkJWC7mNRWQWVaigo6T8x5et2pZmqL+1nYs/a4HadXU6fZ4BK1sC9gv5IzPcHSXq
         wb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=26fuvaER4d3o3+CCq4wIldSwQFOjL4djRnP08g9wyQI=;
        b=ZbIX+O7UMiH120Ntx4oXnqtpMU+6uMQ1AUCj8Dlk2LDs/yhKOgcTs/eBRsXfIlPc4l
         LN3/IYOaSjsHdB08eGOI5WhjCPb0ts1NzuIdtO7KRHBWLYyL+82CxzFxzF9wioshQfcX
         C0Hy7MfG1IDjj2cdmCkzV5mZMt//GnbR3fyD4dyyzwhNGe8rz0yf3CZ146ByPKX39qKE
         hyH1H7TSqDkelauTaiFFbgUOmrkytkbac7v+ZZ9+nSVtsLI9rvGtSjUpw3Wmiet5thEB
         oM/P4n8nN8yqkZ/IlNeo2sdwNukNUUMCoAiVlfgbRmYUdzVff7Zw9XryDtXisqO3Cd2d
         zUSw==
X-Gm-Message-State: AOAM533rYMzpIozOlonJnBP7+YeZ0yDoUK1uUc2KAu5BlD7Kjw5h+Ol4
        NC5Ok+UWKcdYWWID0uC2AULRP/RzlrKKdw==
X-Google-Smtp-Source: ABdhPJzEKFV05q62Zp8BXEtvihVdNVoSYcx/3UUDUEW+oTSg0+3j78cD0SNqqSbry8QQhijv1kehd77ie8Px0Q==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a62:15c3:: with SMTP id
 186mr22623342pfv.59.1643680085154; Mon, 31 Jan 2022 17:48:05 -0800 (PST)
Date:   Tue,  1 Feb 2022 01:48:00 +0000
Message-Id: <20220201014800.3109059-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v4] ACPI: device_sysfs: Add sysfs support for _PLD
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

Signed-off-by: Won Chung <wonchung@google.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi | 101 +++++++++++++++++++++++
 drivers/acpi/device_sysfs.c              |  55 ++++++++++++
 include/acpi/acpi_bus.h                  |   1 +
 3 files changed, 157 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/t=
esting/sysfs-bus-acpi
index 58abacf59b2a..a47fa861dec5 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -96,3 +96,104 @@ Description:
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
+		0 - Leftmost
+		Higher numbers going toward the right.
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
index d5d6403ba07b..610be93635a0 100644
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
@@ -595,6 +638,16 @@ int acpi_device_setup_files(struct acpi_device *dev)
 						    &dev_attr_real_power_state);
 	}
=20
+	if (acpi_has_method(dev->handle, "_PLD")) {
+		status =3D acpi_get_physical_device_location(dev->handle,
+			&dev->pld);
+		if (ACPI_FAILURE(status))
+			goto end;
+		result =3D device_add_group(&dev->dev, &dev_attr_pld_group);
+		if (result)
+			goto end;
+	}
+
 	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
=20
 end:
@@ -645,4 +698,6 @@ void acpi_device_remove_files(struct acpi_device *dev)
 		device_remove_file(&dev->dev, &dev_attr_status);
 	if (dev->handle)
 		device_remove_file(&dev->dev, &dev_attr_path);
+	if (acpi_has_method(dev->handle, "_PLD"))
+		device_remove_group(&dev->dev, &dev_attr_pld_group);
 }
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
2.35.0.rc2.247.g8bbb082509-goog

