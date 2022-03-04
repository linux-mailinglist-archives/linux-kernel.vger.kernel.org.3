Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBD94CDC4A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbiCDSWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241596AbiCDSWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:22:47 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4501D3050
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:21:55 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z13-20020a1709027e8d00b001518de7a06cso5088753pla.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=ahaL2dP2bZkoJj+gEDVYwPqi0qSBfQNaQNWk62u5wf8=;
        b=b+yFJAiJz7erSr7C+4U3ydT9F225o171aYSFJp68TrMDQmlMfEVvc5ep+RUyOXG7Q3
         IdP9lNYl/YExLLAwJoDiE9GuK0DteSUre/kVPsUfkFYs2kU2enZi8wiwrasYhcCj3xpw
         +0FYGWXmH4W+D/BejaEk7P/f4Stf2i4jptaqM5GznytPo3BT9nSvkoslyegnTznviw6M
         juy/zOUl4T/z0tP7bpiEl6hjkYDd0bGhnlUlizRSexzyWmA1mQQNcR29rcgZ5IZWTlkQ
         FrC57Yp1jwIVz91bZTOAx4WOImf18V7fmbpGrWSVKH8/teXoMuQaoZuBn8fvAUTU7os3
         ix3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=ahaL2dP2bZkoJj+gEDVYwPqi0qSBfQNaQNWk62u5wf8=;
        b=t1Q6H9ppt5zsZ9dphpXveI74F9TICh54Rad1oFVwai97bDU0SWuYqsH9T2eOtmRJ5p
         PrGdGgmHYc6elw/DkPKokGkEM4l74mvFAsRzO628pbqHK6Zr/1GeJMOvBtfVLPsHk1eF
         KqvNf1RkDLhcAj4/ZvH5v+0PX3TeWqf+ES7Jhi9oaSDqnSQfgoHHLuTRpsz87JhpzhHa
         sXTZCDU+bpuV7wtQcCqUj8wxGxIq52ZQCeTC5/nW44i9WU3DRbVU1LyhPtq1dMzZms04
         5nCprgbgKnHw0PcZMLAjy+ss6/NS+m0oAWXOranKze7fmlCOVmlPng6kCH3JyQdGd9Rr
         +ukg==
X-Gm-Message-State: AOAM5300cY+jtpYidEN3jTBBr12Ce//ZX79d0h3139p9uuBKxXkFNvTT
        N+TIzHTB9XmqHwLFAxjdv80p6cwSkStKEA==
X-Google-Smtp-Source: ABdhPJwqnJwT9gWCLObcQN7lR5QEjB7TDTasHOIJTK3ya7Eg2wdgryqq4tNXTOTmydZJCRQYhl67XRG+yPEuqQ==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:90a:4411:b0:1bc:99b0:acad with SMTP
 id s17-20020a17090a441100b001bc99b0acadmr12127129pjg.25.1646418115256; Fri,
 04 Mar 2022 10:21:55 -0800 (PST)
Date:   Fri,  4 Mar 2022 18:21:52 +0000
Message-Id: <20220304182152.2038961-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v2] driver core: Add sysfs support for physical location of a device
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
 .../testing/sysfs-devices-physical_location   |  42 ++++++
 drivers/base/core.c                           | 139 ++++++++++++++++++
 include/linux/device.h                        |  73 +++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-physical_locati=
on

diff --git a/Documentation/ABI/testing/sysfs-devices-physical_location b/Do=
cumentation/ABI/testing/sysfs-devices-physical_location
new file mode 100644
index 000000000000..1b2c6edb791b
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
+What:           /sys/devices/.../physical_location/panel
+Date:           March 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Describes which panel surface of the system=E2=80=99s housing the
+		device connection point resides on.
+
+What:           /sys/devices/.../physical_location/vertical_position
+Date:           March 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Describes vertical position of the device connection point on
+		the panel surface.
+
+What:           /sys/devices/.../physical_location/horizontal_position
+Date:           March 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Describes horizontal position of the device connection point on
+		the panel surface.
+
+What:           /sys/devices/.../physical_location/dock
+Date:           March 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		"Yes" if the device connection point resides in a docking
+		station or a port replicator. "No" otherwise.
+
+What:           /sys/devices/.../physical_location/lid
+Date:           March 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		"Yes" if the device connection point resides on the lid of
+		laptop system. "No" otherwise.
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7bb957b11861..96147e5951f4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2466,6 +2466,136 @@ static ssize_t removable_show(struct device *dev, s=
truct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(removable);
=20
+static int dev_add_physical_location(struct device *dev)
+{
+#if defined(CONFIG_ACPI)
+	struct acpi_pld_info *pld;
+	acpi_status status;
+
+	if (!has_acpi_companion(dev))
+		return 0;
+
+	status =3D acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld);
+	if (ACPI_FAILURE(status) || !pld)
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
+static struct attribute *dev_attr_physical_location[] =3D {
+	&dev_attr_panel.attr,
+	&dev_attr_vertical_position.attr,
+	&dev_attr_horizontal_position.attr,
+	&dev_attr_dock.attr,
+	&dev_attr_lid.attr,
+	NULL,
+};
+
+static const struct attribute_group dev_attr_physical_location_group =3D {
+	.name =3D "physical_location",
+	.attrs =3D dev_attr_physical_location,
+};
+
 int device_add_groups(struct device *dev, const struct attribute_group **g=
roups)
 {
 	return sysfs_create_groups(&dev->kobj, groups);
@@ -2649,8 +2779,17 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_waiting_for_supplier;
 	}
=20
+	if (dev_add_physical_location(dev)) {
+		error =3D device_add_group(dev,
+			&dev_attr_physical_location_group);
+		if (error)
+			goto err_remove_dev_physical_location;
+	}
+
 	return 0;
=20
+ err_remove_dev_physical_location:
+	device_remove_group(dev, &dev_attr_physical_location_group);
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
2.35.1.616.g0bdcbb4464-goog

