Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ABF4D8D83
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244675AbiCNT4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbiCNT4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:56:22 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176F36327
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:55:10 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t6-20020a1709028c8600b001534eaec77bso1716208plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=p55UJEBgrAWfR8x+4PbGwZTXwn8IAOOWPCd6p5g2IiQ=;
        b=LW2Zid4tmBy5ddvrLKDpu7HTVD/890tjArZvnF2wbwMAxjsW34ZH7tOgm47pHZJtDw
         RiqPtEC5DbDbFoYkYR9U+mg0a894oWFXG8vnLjLZ6/KVO6SwW+lMocaejQmR+igZMgIr
         FIXqsrPq1ZBtgSDoI4+VI+lcq0YFFZDVth9yyQNDIykUXTDXiQGTkumxE98Tvil2LHl+
         34QrKJmmhZNRCaZW5RyMXhgFAwoMik8/c/TaQ/MqhtI0qfbnKTvTTxiTrTmGzMlVm5Nd
         3SMnTmjPwIptvCrS9PAJAgAmUIKwGNVCdZ6VRpzFCRDM7HPm4MbWv00wBMTn9tRTNsm5
         uOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=p55UJEBgrAWfR8x+4PbGwZTXwn8IAOOWPCd6p5g2IiQ=;
        b=5f+3IBhMaCqGWESEK02LFmX+i+Renh+zSukgSc1IU/doeJUb+vIBzO5+QiTx5u0xEn
         j9tkdB2HOzS5gfc6CsTeYZg58xc1JWGA593HLI3BLnXD59fv8TgaF04VeI6IuTrxUtvO
         3IpbdlH9ASnUMuxER0pec/tSdIVnmxKDTs8ngcipn4YQAinCetRfXtgbOLfjIIwAMahP
         NUaxt12Oi27+QiC8vFy9Quy4Ggkm6We3M20VanqrRscHVhxMbdEKmXRbHUUvV4vJ9gvs
         kDcBIphEJaCfmdC4oI5SlSXvFydIDKu84hOCrAAvSpfd9b3cLMBxNSqGgS1Eb5IQ4kFT
         PvpA==
X-Gm-Message-State: AOAM531cPooNvPoGhYkrqmQkUpdiB4s0k18DE8hPEqSbznsW234VBbmD
        slYb48u5Kfv1bBBv4ODe9QRzoBVA8X9Mlg==
X-Google-Smtp-Source: ABdhPJxQmPOomrKWDQ+kI8shgwViVtH7EJNDoWDxT+7zzSsZo15yc40Mszu8SRDKWv4LgvuS9YBIin7+smd9Wg==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a62:30c4:0:b0:4f7:2b29:984 with SMTP id
 w187-20020a6230c4000000b004f72b290984mr25894380pfw.11.1647287709500; Mon, 14
 Mar 2022 12:55:09 -0700 (PDT)
Date:   Mon, 14 Mar 2022 19:54:58 +0000
Message-Id: <20220314195458.271430-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v6] driver core: Add sysfs support for physical location of a device
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

Changes from v5
- Remove physical_location directory only if physical_location is present.
- Free memory for physical_location in device when device is removed.

Changes from v4
- Remove physical_location directory when device is deleted.
- Correctly handle error from adding physical_location in
  device_add_attrs().

Changes from v3
- Move dev_add_physical_location() and dev_attr_physical_location_group
  to driver/base/physical_location.h.
- Use pointer and reorder physical_location in struct device to pack its
  bytes. (checked using pahole)
- Unify naming to physical_location since the name location is used in
  some places like USB port for different information.

Changes from v2
- Use sysfs_emit to create files.
- Correct mix of spaces and tabs.

Changes from v1
- Correct directory names in Documentation.
- Clarify namings in core.c

 .../testing/sysfs-devices-physical_location   |  42 ++++++
 drivers/base/Makefile                         |   1 +
 drivers/base/core.c                           |  15 ++
 drivers/base/physical_location.c              | 137 ++++++++++++++++++
 drivers/base/physical_location.h              |  16 ++
 include/linux/device.h                        |  73 ++++++++++
 6 files changed, 284 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-physical_locati=
on
 create mode 100644 drivers/base/physical_location.c
 create mode 100644 drivers/base/physical_location.h

diff --git a/Documentation/ABI/testing/sysfs-devices-physical_location b/Do=
cumentation/ABI/testing/sysfs-devices-physical_location
new file mode 100644
index 000000000000..202324b87083
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-physical_location
@@ -0,0 +1,42 @@
+What:		/sys/devices/.../physical_location
+Date:		March 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		This directory contains information on physical location of
+		the device connection point with respect to the system's
+		housing.
+
+What:		/sys/devices/.../physical_location/panel
+Date:		March 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		Describes which panel surface of the system=E2=80=99s housing the
+		device connection point resides on.
+
+What:		/sys/devices/.../physical_location/vertical_position
+Date:		March 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		Describes vertical position of the device connection point on
+		the panel surface.
+
+What:		/sys/devices/.../physical_location/horizontal_position
+Date:		March 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		Describes horizontal position of the device connection point on
+		the panel surface.
+
+What:		/sys/devices/.../physical_location/dock
+Date:		March 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		"Yes" if the device connection point resides in a docking
+		station or a port replicator. "No" otherwise.
+
+What:		/sys/devices/.../physical_location/lid
+Date:		March 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		"Yes" if the device connection point resides on the lid of
+		laptop system. "No" otherwise.
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 02f7f1358e86..83217d243c25 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_DEV_COREDUMP) +=3D devcoredump.o
 obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) +=3D platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) +=3D arch_topology.o
 obj-$(CONFIG_GENERIC_ARCH_NUMA) +=3D arch_numa.o
+obj-$(CONFIG_ACPI) +=3D physical_location.o
=20
 obj-y			+=3D test/
=20
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7bb957b11861..64d4d8646c12 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -32,6 +32,7 @@
 #include <linux/dma-map-ops.h> /* for dma_default_coherent */
=20
 #include "base.h"
+#include "physical_location.h"
 #include "power/power.h"
=20
 #ifdef CONFIG_SYSFS_DEPRECATED
@@ -2649,8 +2650,17 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_waiting_for_supplier;
 	}
=20
+	if (dev_add_physical_location(dev)) {
+		error =3D device_add_group(dev,
+			&dev_attr_physical_location_group);
+		if (error)
+			goto err_remove_dev_removable;
+	}
+
 	return 0;
=20
+ err_remove_dev_removable:
+	device_remove_file(dev, &dev_attr_removable);
  err_remove_dev_waiting_for_supplier:
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
  err_remove_dev_online:
@@ -2672,6 +2682,11 @@ static void device_remove_attrs(struct device *dev)
 	struct class *class =3D dev->class;
 	const struct device_type *type =3D dev->type;
=20
+	if (dev->physical_location) {
+		device_remove_group(dev, &dev_attr_physical_location_group);
+		kfree(dev->physical_location);
+	}
+
 	device_remove_file(dev, &dev_attr_removable);
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 	device_remove_file(dev, &dev_attr_online);
diff --git a/drivers/base/physical_location.c b/drivers/base/physical_locat=
ion.c
new file mode 100644
index 000000000000..4c1a52ecd7f6
--- /dev/null
+++ b/drivers/base/physical_location.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device physical location support
+ *
+ * Author: Won Chung <wonchung@google.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/sysfs.h>
+
+#include "physical_location.h"
+
+bool dev_add_physical_location(struct device *dev)
+{
+	struct acpi_pld_info *pld;
+	acpi_status status;
+
+	if (!has_acpi_companion(dev))
+		return false;
+
+	status =3D acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	dev->physical_location =3D
+		kzalloc(sizeof(*dev->physical_location), GFP_KERNEL);
+	dev->physical_location->panel =3D pld->panel;
+	dev->physical_location->vertical_position =3D pld->vertical_position;
+	dev->physical_location->horizontal_position =3D pld->horizontal_position;
+	dev->physical_location->dock =3D pld->dock;
+	dev->physical_location->lid =3D pld->lid;
+
+	return true;
+}
+
+static ssize_t panel_show(struct device *dev, struct device_attribute *att=
r,
+	char *buf)
+{
+	const char *panel;
+
+	switch (dev->physical_location->panel) {
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
+	default:
+		panel =3D "unknown";
+	}
+	return sysfs_emit(buf, "%s\n", panel);
+}
+static DEVICE_ATTR_RO(panel);
+
+static ssize_t vertical_position_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	const char *vertical_position;
+
+	switch (dev->physical_location->vertical_position) {
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
+	return sysfs_emit(buf, "%s\n", vertical_position);
+}
+static DEVICE_ATTR_RO(vertical_position);
+
+static ssize_t horizontal_position_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	const char *horizontal_position;
+
+	switch (dev->physical_location->horizontal_position) {
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
+	return sysfs_emit(buf, "%s\n", horizontal_position);
+}
+static DEVICE_ATTR_RO(horizontal_position);
+
+static ssize_t dock_show(struct device *dev, struct device_attribute *attr=
,
+	char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+		dev->physical_location->dock ? "yes" : "no");
+}
+static DEVICE_ATTR_RO(dock);
+
+static ssize_t lid_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+		dev->physical_location->lid ? "yes" : "no");
+}
+static DEVICE_ATTR_RO(lid);
+
+static struct attribute *dev_attr_physical_location[] =3D {
+	&dev_attr_panel.attr,
+	&dev_attr_vertical_position.attr,
+	&dev_attr_horizontal_position.attr,
+	&dev_attr_dock.attr,
+	&dev_attr_lid.attr,
+	NULL,
+};
+
+const struct attribute_group dev_attr_physical_location_group =3D {
+	.name =3D "physical_location",
+	.attrs =3D dev_attr_physical_location,
+};
+
diff --git a/drivers/base/physical_location.h b/drivers/base/physical_locat=
ion.h
new file mode 100644
index 000000000000..82cde9f1b161
--- /dev/null
+++ b/drivers/base/physical_location.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Device physical location support
+ *
+ * Author: Won Chung <wonchung@google.com>
+ */
+
+#include <linux/device.h>
+
+#ifdef CONFIG_ACPI
+extern bool dev_add_physical_location(struct device *dev);
+extern const struct attribute_group dev_attr_physical_location_group;
+#else
+static inline bool dev_add_physical_location(struct device *dev) { return =
false; };
+static const struct attribute_group dev_attr_physical_location_group =3D {=
};
+#endif
diff --git a/include/linux/device.h b/include/linux/device.h
index 93459724dcde..766fbea6ca83 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -386,6 +386,75 @@ struct dev_msi_info {
 #endif
 };
=20
+/**
+ * enum device_physical_location_panel - Describes which panel surface of =
the
+ * system's housing the device connection point resides on.
+ * @DEVICE_PANEL_TOP: Device connection point is on the top panel.
+ * @DEVICE_PANEL_BOTTOM: Device connection point is on the bottom panel.
+ * @DEVICE_PANEL_LEFT: Device connection point is on the left panel.
+ * @DEVICE_PANEL_RIGHT: Device connection point is on the right panel.
+ * @DEVICE_PANEL_FRONT: Device connection point is on the front panel.
+ * @DEVICE_PANEL_BACK: Device connection point is on the back panel.
+ * @DEVICE_PANEL_UNKNOWN: The panel with device connection point is unknow=
n.
+ */
+enum device_physical_location_panel {
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
+ * enum device_physical_location_vertical_position - Describes vertical
+ * position of the device connection point on the panel surface.
+ * @DEVICE_VERT_POS_UPPER: Device connection point is at upper part of pan=
el.
+ * @DEVICE_VERT_POS_CENTER: Device connection point is at center part of p=
anel.
+ * @DEVICE_VERT_POS_LOWER: Device connection point is at lower part of pan=
el.
+ */
+enum device_physical_location_vertical_position {
+	DEVICE_VERT_POS_UPPER,
+	DEVICE_VERT_POS_CENTER,
+	DEVICE_VERT_POS_LOWER,
+};
+
+/**
+ * enum device_physical_location_horizontal_position - Describes horizonta=
l
+ * position of the device connection point on the panel surface.
+ * @DEVICE_HORI_POS_LEFT: Device connection point is at left part of panel=
.
+ * @DEVICE_HORI_POS_CENTER: Device connection point is at center part of p=
anel.
+ * @DEVICE_HORI_POS_RIGHT: Device connection point is at right part of pan=
el.
+ */
+enum device_physical_location_horizontal_position {
+	DEVICE_HORI_POS_LEFT,
+	DEVICE_HORI_POS_CENTER,
+	DEVICE_HORI_POS_RIGHT,
+};
+
+/**
+ * struct device_physical_location - Device data related to physical locat=
ion
+ * of the device connection point.
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
+struct device_physical_location {
+	enum device_physical_location_panel panel;
+	enum device_physical_location_vertical_position vertical_position;
+	enum device_physical_location_horizontal_position horizontal_position;
+	bool dock;
+	bool lid;
+};
+
 /**
  * struct device - The basic device structure
  * @parent:	The device's "parent" device, the device to which it is attach=
ed.
@@ -453,6 +522,8 @@ struct dev_msi_info {
  * 		device (i.e. the bus driver that discovered the device).
  * @iommu_group: IOMMU group the device belongs to.
  * @iommu:	Per device generic IOMMU runtime data
+ * @physical_location: Describes physical location of the device connectio=
n
+ *		point in the system housing.
  * @removable:  Whether the device can be removed from the system. This
  *              should be set by the subsystem / bus driver that discovere=
d
  *              the device.
@@ -567,6 +638,8 @@ struct device {
 	struct iommu_group	*iommu_group;
 	struct dev_iommu	*iommu;
=20
+	struct device_physical_location *physical_location;
+
 	enum device_removable	removable;
=20
 	bool			offline_disabled:1;
--=20
2.35.1.723.g4982287a31-goog

