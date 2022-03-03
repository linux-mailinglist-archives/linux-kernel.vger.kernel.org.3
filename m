Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6694CB471
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiCCBiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiCCBiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:38:06 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AD3B10
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:37:21 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id u10-20020a63df0a000000b0037886b8707bso1931963pgg.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=n+9LvV28JXSkZmWo+/sKnuZErGg3b7YBEVoZqF+1KNE=;
        b=mmE+By+H3P65iCF400Hm7Hhnh4+v68SkxHtH5Bo6C3ywqjjFqyhhKUENz6otlwQ0rZ
         3L2v8uwjEyAYx9MtbJJRckXPiO4y+4YmaPDT1ozSLY+LR1uysD21y+2kE7SUF7RUwjkL
         kpYneJET0qy63u6B2Q14sbHT356UsFV1zc8BWo5vBj8jmo6QB7oMbuImOIdIFszsUyh2
         bQmcZWWh+ZCYqekEukWwDN/RBVOHAV2367EUI/6W6an8ni5Fb9u8hBGOMZeunYtBqcZx
         ti99BzsgeIdwuAciSqptFfyg/5VR4su+NGAV7uMW+Ayx+yHEbKuwG6MN8xYWXm6eFh4Q
         h9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=n+9LvV28JXSkZmWo+/sKnuZErGg3b7YBEVoZqF+1KNE=;
        b=bFeOC7slxQC14nS1E7YODAmp9JH59f/ecaVO98G/UoZ0nNdShCLiq4tAmELrRLivg6
         ckYfi+gNygEcekJ69oNhQqag0wSQm5JbbC3Xii0Qd3x2BytYWB0NMwSz3YzM5/krl0bc
         06s76N4k5ZHIrg5TyqkGULbixsJE4y/f3eLjgD5aRHPPuPksaVj367hVO6C1AmeEWU9H
         hwE4pImvI/75dnZi0UgcGCiMLcHkWZeTDMbiq3PdauqtzEmLgzzUG0MIEaoOfepQVIYx
         s+zSoAqxeZWZotmFZ51Z0KdNXHn2EgTvGmJ1OJHtnYc4mhCLiQpIxoJg/suCDHNl7DIN
         ep2g==
X-Gm-Message-State: AOAM533EZcxCdJnynz67b+EaDCggAllrRqdmVPg5hiI2eiKshxjX5/Vm
        1UtQ1dwm1wKJzxhJp3RpT545BaD9LI4gZw==
X-Google-Smtp-Source: ABdhPJx66cNPgmlRkq3uRYwqDX+I8xVun+z7P1ohEmbAMWJYq8CUc9FF+TPpFvdrHaCbI8ABLIcQhh8J6O7EtQ==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:903:2d0:b0:14d:8a8d:cb1 with SMTP id
 s16-20020a17090302d000b0014d8a8d0cb1mr33527437plk.50.1646271440987; Wed, 02
 Mar 2022 17:37:20 -0800 (PST)
Date:   Thu,  3 Mar 2022 01:37:16 +0000
Message-Id: <20220303013716.1739717-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] driver core: Add sysfs support for physical location of a device
From:   Won Chung <wonchung@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ACPI table includes _PLD fields for a device, create a new
directory (physical_location) in sysfs to share _PLD fields.

Currently without PLD information, when there are multiple of same
devices, it is hard to distinguish which device corresponds to which
physical device at which location. For example, when there are two Type
C connectors, it is hard to find out which connector corresponds to the
Type C port on the left panel versus the Type C port on the right panel.
With PLD information provided, we can determine which specific device at
which location is doing what.

_PLD output includes much more fields, but only generic fields are added
and exposed to sysfs, so that non-ACPI devices can also support it in
the future. The minimal generic fields needed for locating a device are
the following.
- panel
- vertical_position
- horizontal_position
- dock
- lid

Signed-off-by: Won Chung <wonchung@google.com>
---
 .../ABI/testing/sysfs-devices-location        |  42 ++++++
 drivers/base/core.c                           | 138 ++++++++++++++++++
 include/linux/device.h                        |  73 +++++++++
 3 files changed, 253 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-location

diff --git a/Documentation/ABI/testing/sysfs-devices-location b/Documentati=
on/ABI/testing/sysfs-devices-location
new file mode 100644
index 000000000000..bde81ce97a61
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-location
@@ -0,0 +1,42 @@
+What:		/sys/devices/.../location
+Date:		March 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		This directory contains information on physical location of
+		the device connection point with respect to the system's
+		housing.
+
+What:           /sys/devices/.../location/panel
+Date:           March 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Describes which panel surface of the system=E2=80=99s housing the
+		device connection point resides on.
+
+What:           /sys/devices/.../location/vertical_position
+Date:           March 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Describes vertical position of the device connection point on
+		the panel surface.
+
+What:           /sys/devices/.../location/horizontal_position
+Date:           March 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Describes horizontal position of the device connection point on
+		the panel surface.
+
+What:           /sys/devices/.../location/dock
+Date:           March 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		"Yes" if the device connection point resides in a docking
+		station or a port replicator. "No" otherwise.
+
+What:           /sys/devices/.../location/lid
+Date:           March 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		"Yes" if the device connection point resides on the lid of
+		laptop system. "No" otherwise.
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7bb957b11861..6b30007a319a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2466,6 +2466,136 @@ static ssize_t removable_show(struct device *dev, s=
truct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(removable);
=20
+static int dev_get_and_add_location(struct device *dev)
+{
+#if defined(CONFIG_ACPI)
+	struct acpi_pld_info *pld;
+	acpi_status status;
+
+	if (!has_acpi_companion(dev))
+		return 0;
+
+	status =3D acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	dev->location =3D (struct device_location) {
+		.panel =3D pld->panel,
+		.vertical_position =3D pld->vertical_position,
+		.horizontal_position =3D pld->horizontal_position,
+		.dock =3D pld->dock,
+		.lid =3D pld->lid,
+	};
+
+	return 1;
+#else
+	return 0;
+#endif
+}
+
+static ssize_t panel_show(struct device *dev, struct device_attribute *att=
r,
+	char *buf)
+{
+	const char *panel;
+
+	switch (dev->location.panel) {
+	case DEVICE_PANEL_TOP:
+		panel =3D "top";
+		break;
+	case DEVICE_PANEL_BOTTOM:
+		panel =3D "bottom";
+		break;
+	case DEVICE_PANEL_LEFT:
+		panel =3D "left";
+		break;
+	case DEVICE_PANEL_RIGHT:
+		panel =3D "right";
+		break;
+	case DEVICE_PANEL_FRONT:
+		panel =3D "front";
+		break;
+	case DEVICE_PANEL_BACK:
+		panel =3D "back";
+		break;
+	default:
+		panel =3D "unknown";
+	}
+	return sprintf(buf, "%s\n", panel);
+}
+static DEVICE_ATTR_RO(panel);
+
+static ssize_t vertical_position_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	const char *vertical_position;
+
+	switch (dev->location.vertical_position) {
+	case DEVICE_VERT_POS_UPPER:
+		vertical_position =3D "upper";
+		break;
+	case DEVICE_VERT_POS_CENTER:
+		vertical_position =3D "center";
+		break;
+	case DEVICE_VERT_POS_LOWER:
+		vertical_position =3D "lower";
+		break;
+	default:
+		vertical_position =3D "unknown";
+	}
+	return sprintf(buf, "%s\n", vertical_position);
+}
+static DEVICE_ATTR_RO(vertical_position);
+
+static ssize_t horizontal_position_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	const char *horizontal_position;
+
+	switch (dev->location.horizontal_position) {
+	case DEVICE_HORI_POS_LEFT:
+		horizontal_position =3D "left";
+		break;
+	case DEVICE_HORI_POS_CENTER:
+		horizontal_position =3D "center";
+		break;
+	case DEVICE_HORI_POS_RIGHT:
+		horizontal_position =3D "right";
+		break;
+	default:
+		horizontal_position =3D "unknown";
+	}
+	return sprintf(buf, "%s\n", horizontal_position);
+}
+static DEVICE_ATTR_RO(horizontal_position);
+
+static ssize_t dock_show(struct device *dev, struct device_attribute *attr=
,
+	char *buf)
+{
+	return sprintf(buf, "%s\n", dev->location.dock ? "yes" : "no");
+}
+static DEVICE_ATTR_RO(dock);
+
+static ssize_t lid_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	return sprintf(buf, "%s\n", dev->location.lid ? "yes" : "no");
+}
+static DEVICE_ATTR_RO(lid);
+
+static struct attribute *dev_attr_location[] =3D {
+	&dev_attr_panel.attr,
+	&dev_attr_vertical_position.attr,
+	&dev_attr_horizontal_position.attr,
+	&dev_attr_dock.attr,
+	&dev_attr_lid.attr,
+	NULL,
+};
+
+static const struct attribute_group dev_attr_location_group =3D {
+	.name =3D "physical_location",
+	.attrs =3D dev_attr_location,
+};
+
 int device_add_groups(struct device *dev, const struct attribute_group **g=
roups)
 {
 	return sysfs_create_groups(&dev->kobj, groups);
@@ -2649,8 +2779,16 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_waiting_for_supplier;
 	}
=20
+	if (dev_get_and_add_location(dev)) {
+		error =3D device_add_group(dev, &dev_attr_location_group);
+		if (error)
+			goto err_remove_dev_location;
+	}
+
 	return 0;
=20
+ err_remove_dev_location:
+	device_remove_group(dev, &dev_attr_location_group);
  err_remove_dev_waiting_for_supplier:
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
  err_remove_dev_online:
diff --git a/include/linux/device.h b/include/linux/device.h
index 93459724dcde..424be9cb735e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -386,6 +386,75 @@ struct dev_msi_info {
 #endif
 };
=20
+/**
+ * enum device_location_panel - Describes which panel surface of the syste=
m's
+ * housing the device connection point resides on.
+ * @DEVICE_PANEL_TOP: Device connection point is on the top panel.
+ * @DEVICE_PANEL_BOTTOM: Device connection point is on the bottom panel.
+ * @DEVICE_PANEL_LEFT: Device connection point is on the left panel.
+ * @DEVICE_PANEL_RIGHT: Device connection point is on the right panel.
+ * @DEVICE_PANEL_FRONT: Device connection point is on the front panel.
+ * @DEVICE_PANEL_BACK: Device connection point is on the back panel.
+ * @DEVICE_PANEL_UNKNOWN: The panel with device connection point is unknow=
n.
+ */
+enum device_location_panel {
+	DEVICE_PANEL_TOP,
+	DEVICE_PANEL_BOTTOM,
+	DEVICE_PANEL_LEFT,
+	DEVICE_PANEL_RIGHT,
+	DEVICE_PANEL_FRONT,
+	DEVICE_PANEL_BACK,
+	DEVICE_PANEL_UNKNOWN,
+};
+
+/**
+ * enum device_location_vertical_position - Describes vertical position of=
 the
+ * device connection point on the panel surface.
+ * @DEVICE_VERT_POS_UPPER: Device connection point is at upper part of pan=
el.
+ * @DEVICE_VERT_POS_CENTER: Device connection point is at center part of p=
anel.
+ * @DEVICE_VERT_POS_LOWER: Device connection point is at lower part of pan=
el.
+ */
+enum device_location_vertical_position {
+	DEVICE_VERT_POS_UPPER,
+	DEVICE_VERT_POS_CENTER,
+	DEVICE_VERT_POS_LOWER,
+};
+
+/**
+ * enum device_location_horizontal_position - Describes horizontal positio=
n of
+ * the device connection point on the panel surface.
+ * @DEVICE_HORI_POS_LEFT: Device connection point is at left part of panel=
.
+ * @DEVICE_HORI_POS_CENTER: Device connection point is at center part of p=
anel.
+ * @DEVICE_HORI_POS_RIGHT: Device connection point is at right part of pan=
el.
+ */
+enum device_location_horizontal_position {
+	DEVICE_HORI_POS_LEFT,
+	DEVICE_HORI_POS_CENTER,
+	DEVICE_HORI_POS_RIGHT,
+};
+
+/**
+ * struct device_location - Device data related to physical location of th=
e
+ * device connection point.
+ * @panel: Panel surface of the system's housing that the device connectio=
n
+ *         point resides on.
+ * @vertical_position: Vertical position of the device connection point wi=
thin
+ *                     the panel.
+ * @horizontal_position: Horizontal position of the device connection poin=
t
+ *                       within the panel.
+ * @dock: Set if the device connection point resides in a docking station =
or
+ *        port replicator.
+ * @lid: Set if this device connection point resides on the lid of laptop
+ *       system.
+ */
+struct device_location {
+	enum device_location_panel panel;
+	enum device_location_vertical_position vertical_position;
+	enum device_location_horizontal_position horizontal_position;
+	bool dock;
+	bool lid;
+};
+
 /**
  * struct device - The basic device structure
  * @parent:	The device's "parent" device, the device to which it is attach=
ed.
@@ -456,6 +525,8 @@ struct dev_msi_info {
  * @removable:  Whether the device can be removed from the system. This
  *              should be set by the subsystem / bus driver that discovere=
d
  *              the device.
+ * @location:	Describes physical location of the device connection point i=
n
+ *		the system housing.
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
@@ -569,6 +640,8 @@ struct device {
=20
 	enum device_removable	removable;
=20
+	struct device_location	location;
+
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
--=20
2.35.1.574.g5d30c73bfb-goog

