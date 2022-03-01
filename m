Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4364C8103
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiCAC1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiCAC1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:27:08 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE45610FDE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:26:28 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id e7-20020a17090a4a0700b001bc5a8c533eso650044pjh.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=IyH14F+agd7W5xUCOqF8MHhvzX444waYtpTecHVWge8=;
        b=E4T6jfR2vKlUdEvn/QMIBFysWTfRWfiW0LpBXD08E1oAZR2ETPFwty2DkXh52NXwHJ
         xdZomPm6cmuuT0ovcrNdyGNQ7RdbmpJ8rdbYZ2dcFWVIdNiLbRKYx+DncjScSGbmW//6
         N5bakFgZW0sQ4rvFzst7Q504kAQ3pXs+tBJT2bH6STSkmyCKvlfzLkrDZxfhwIqcOfOG
         SWwWatKwTXK6zpA4ne95wqyIOVby7CV5Ayv30NwyxQKoBVxnyYzhL3WBnf+Ef4mh4dXR
         LX6nBHpDGezRnO7pmfgtUgB0B7R/AWCFLhqkFMj5ssVF4em3Mx9NZmgpGZDxHikhs42U
         911A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=IyH14F+agd7W5xUCOqF8MHhvzX444waYtpTecHVWge8=;
        b=5kBCFO8uPGvebnE5XDRmZrBk422M3stXG07RvH+jxZPDxlW065NGVXl1WYanFmRJe6
         ruv33hQQjaU6S6GXQhTzbTmCb5b/snam3BCPzd/wx9gqKgdmzg3cuZswWmwTTc5xTVeT
         akpSfb2qnIt42lNBC/YFNqUMWy0AFG33XmAmH3ZYERmtOQYD41OhUsfIjwop9xeyRRnW
         5CwxxAuyNpw+hRtURWLwiShQSiKqWGU8FXg2QcKubzvRR0HyvXQGiZZ9mMzPS2U5KoKk
         3QeplSOLpd09yV2Ej/sTOvg2FvKbQ7BtM7/HQke8qST+XkN/t8oQx8JWvOB5ryTcQQ5Q
         EHYQ==
X-Gm-Message-State: AOAM530B6EH5CENsDjRpXAEHlAkhkiXBzmwDRXvClt7m8wsXDkTfi37e
        e3bPscf1TxhXngPCiGAyYmt51FFFGJX7nA==
X-Google-Smtp-Source: ABdhPJxypJtr3ImAqxt0f0FeKm62AoisNyF+dqf+XW3ByIZHDHbGiBRt897FAZj3q+84CftFuObbB1WeseuHdQ==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:902:860a:b0:14b:341e:5ffb with SMTP
 id f10-20020a170902860a00b0014b341e5ffbmr23087343plo.6.1646101588165; Mon, 28
 Feb 2022 18:26:28 -0800 (PST)
Date:   Tue,  1 Mar 2022 02:26:25 +0000
Message-Id: <20220301022625.469446-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2] usb:typec: Add sysfs support for Type C connector's
 physical location
From:   Won Chung <wonchung@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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

When ACPI table includes _PLD field for a Type C connector, share _PLD
values in its sysfs. _PLD stands for physical location of device.

Currently without connector's location information, when there are
multiple Type C ports, it is hard to distinguish which connector
corresponds to which physical port at which location. For example, when
there are two Type C connectors, it is hard to find out which connector
corresponds to the Type C port on the left panel versus the Type C port
on the right panel. With location information provided, we can determine
which specific device at which location is doing what.

_PLD output includes much more fields, but only generic fields are added
and exposed to sysfs, so that non-ACPI devices can also support it in
the future. The minimal generic fields needed for locating a port are
the following.
- panel
- vertical_position
- horizontal_position
- dock
- lid

Signed-off-by: Won Chung <wonchung@google.com>
---

Changes in v2:
- Use string for location.
- Clarify get_pld() with naming and return type.

 Documentation/ABI/testing/sysfs-class-typec |  35 ++++++
 drivers/usb/typec/class.c                   | 113 ++++++++++++++++++++
 drivers/usb/typec/class.h                   |   3 +
 3 files changed, 151 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/AB=
I/testing/sysfs-class-typec
index 75088ecad202..4497a5aeb063 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -141,6 +141,41 @@ Description:
 		- "reverse": CC2 orientation
 		- "unknown": Orientation cannot be determined.
=20
+What:		/sys/class/typec/<port>/location/panel
+Date:		March 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		Describes which panel surface of the system=E2=80=99s housing the
+		port resides on.
+
+What:		/sys/class/typec/<port>/location/vertical_position
+Date:		March 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		Describes vertical position of the port on the panel surface.
+		Valid values: upper, center, lower
+
+What:		/sys/class/typec/<port>/location/horizontal_position
+Date:		March 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		Describes horizontal position of the port on the panel surface.
+		Valid values: left, center, right
+
+What:		/sys/class/typec/<port>/location/dock
+Date:		March 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		Set as "yes" if the port resides in a docking station or a port
+		replicator, otherwise set as "no".
+
+What:		/sys/class/typec/<port>/location/lid
+Date:		March 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		Set as "yes" if the port resides on the lid of laptop system,
+		otherwise set as "no".
+
 USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
=20
 What:		/sys/class/typec/<port>-partner/accessory_mode
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 45a6f0c807cb..5a52cb6728ec 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1579,8 +1579,101 @@ static const struct attribute_group typec_group =3D=
 {
 	.attrs =3D typec_attrs,
 };
=20
+static const char * const typec_location_panel[] =3D {
+	"top",
+	"bottom",
+	"left",
+	"right",
+	"front",
+	"back",
+	"unknown",
+};
+
+static const char * const typec_location_vertical_position[] =3D {
+	"upper", "center", "lower"
+};
+
+static const char * const typec_location_horizontal_position[] =3D {
+	"left", "center", "right"
+};
+
+static ssize_t panel_show(struct device *dev, struct device_attribute *att=
r,
+	char *buf)
+{
+	struct typec_port *port =3D to_typec_port(dev);
+
+	if (port->pld)
+		return sprintf(buf, "%s\n",
+			typec_location_panel[port->pld->panel]);
+	return 0;
+};
+static DEVICE_ATTR_RO(panel);
+
+static ssize_t vertical_position_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct typec_port *port =3D to_typec_port(dev);
+
+	if (port->pld)
+		return sprintf(buf, "%s\n",
+			typec_location_vertical_position[
+				port->pld->vertical_position]);
+	return 0;
+};
+static DEVICE_ATTR_RO(vertical_position);
+
+static ssize_t horizontal_position_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct typec_port *port =3D to_typec_port(dev);
+
+	if (port->pld)
+		return sprintf(buf, "%s\n",
+			typec_location_horizontal_position[
+				port->pld->horizontal_position]);
+	return 0;
+};
+static DEVICE_ATTR_RO(horizontal_position);
+
+static ssize_t dock_show(struct device *dev, struct device_attribute *attr=
,
+	char *buf)
+{
+	struct typec_port *port =3D to_typec_port(dev);
+
+	if (port->pld)
+		return sprintf(buf, "%s\n", port->pld->dock ? "yes" : "no");
+	return 0;
+};
+static DEVICE_ATTR_RO(dock);
+
+static ssize_t lid_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct typec_port *port =3D to_typec_port(dev);
+
+	if (port->pld)
+		return sprintf(buf, "%s\n", port->pld->lid ? "yes" : "no");
+	return 0;
+};
+static DEVICE_ATTR_RO(lid);
+
+static struct attribute *typec_location_attrs[] =3D {
+	&dev_attr_panel.attr,
+	&dev_attr_vertical_position.attr,
+	&dev_attr_horizontal_position.attr,
+	&dev_attr_dock.attr,
+	&dev_attr_lid.attr,
+	NULL,
+};
+
+static const struct attribute_group typec_location_group =3D {
+	.name =3D "location",
+	.attrs =3D typec_location_attrs,
+};
+
 static const struct attribute_group *typec_groups[] =3D {
 	&typec_group,
+	&typec_location_group,
 	NULL
 };
=20
@@ -1614,6 +1707,24 @@ const struct device_type typec_port_dev_type =3D {
 	.release =3D typec_release,
 };
=20
+static struct acpi_pld_info *get_acpi_pld_info(struct device *dev)
+{
+#if defined(CONFIG_ACPI)
+	struct acpi_pld_info *pld;
+	acpi_status status;
+
+	if (!has_acpi_companion(dev))
+		return NULL;
+
+	status =3D acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld);
+	if (ACPI_FAILURE(status))
+		return NULL;
+	return pld;
+#else
+	return NULL;
+#endif
+}
+
 /* --------------------------------------- */
 /* Driver callbacks to report role updates */
=20
@@ -2073,6 +2184,8 @@ struct typec_port *typec_register_port(struct device =
*parent,
 		return ERR_PTR(ret);
 	}
=20
+	port->pld =3D get_acpi_pld_info(&port->dev);
+
 	ret =3D device_add(&port->dev);
 	if (ret) {
 		dev_err(parent, "failed to register port (%d)\n", ret);
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index 0f1bd6d19d67..1b52633400c8 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -3,6 +3,7 @@
 #ifndef __USB_TYPEC_CLASS__
 #define __USB_TYPEC_CLASS__
=20
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/usb/typec.h>
=20
@@ -54,6 +55,8 @@ struct typec_port {
=20
 	const struct typec_capability	*cap;
 	const struct typec_operations   *ops;
+
+	struct acpi_pld_info		*pld;
 };
=20
 #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
--=20
2.35.1.574.g5d30c73bfb-goog

