Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1CE4C787B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiB1THf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiB1THd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:07:33 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AEAB189C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:06:54 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id n63-20020a632742000000b00378b20298a2so1771117pgn.22
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=o/agACgJ9p2D2Sf7n3omy9IGAy/5Dg0bQ6zDKzz3oek=;
        b=sGiVz9m8sT5ze1LctY0q5FaRAOLS/76JAbjZVzYDCVh6r7z7j+l9scY7ZE1HDSoboD
         b9L7y3nC7hrhChSeGOcQ0V5rnQG+A2wPVqEAVjc9j4nX71CcdoMJWZ7YQV+pCcZB4jk1
         kaRireYFNfq4h5HvJ5jdlEIl9b5D7kWRlw0eEm31R10ZgSRbuIaCS4ErkYT4YNykfkyE
         wm3L73idQjP8J4O+63QT7LwdZpaT7SIg2cCW69L3ReZ8Xr6XfhggW9oX+dBQzhRs7zdt
         QNZXPaUoR5fdPceXWdhJSx098cJjO+rzEXY2XeIhu/qGiVJv4vSA3Qc6+fxNhjxeaJUy
         L7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=o/agACgJ9p2D2Sf7n3omy9IGAy/5Dg0bQ6zDKzz3oek=;
        b=JrzfjJ5gt9bpDXNRkGpsxpZ1SgwWfaEU/CjxQCTXbzfHHJV0kTE5RbKNg8YIG+1ymD
         Tliz+lRBW03ysnA8F2pGTrUvz6EN46CI3BEJjITIKX7b5dfOqbN3p8PGO9B1KYURMqj2
         kkhfv8GFMOpmxR+Xnz1SnETLfub4YRRN5RI+W80EUNZSNmpesyf/GBBgyi2CaeD+39nc
         9K37ekmYnx1ORuvHo9kiBIQi5Zsm2bRRzKasTWkUNpp6my7B2bQDcQDtBocpN64UYudp
         0n6l9Qjc8spaaFiSRLIMhgMOWiizVT3MKUE4NUjrUJDRBnFXqqjOy0zBWSqUK40o+tUZ
         Xbrg==
X-Gm-Message-State: AOAM532KD9JBH7LlpD729F/i/7uO3vQYVmrMTjneiT1AB0SAMchADlPq
        ID9sYYe58ZX/ktov9lgtr67b/x3kEtiyyA==
X-Google-Smtp-Source: ABdhPJzAe6JgYbk8fIQAb2HlfOncs7GdJ4J5652n7FhKH2N0YldJoYyV4WBCk57+aVuf9ttltxemR9Q1yoyssA==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:90a:2e04:b0:1bc:a5db:bcdb with SMTP
 id q4-20020a17090a2e0400b001bca5dbbcdbmr18258335pjd.116.1646075213654; Mon,
 28 Feb 2022 11:06:53 -0800 (PST)
Date:   Mon, 28 Feb 2022 19:06:49 +0000
Message-Id: <20220228190649.362070-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] usb:typec: Add sysfs support for Type C connector's physical location
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
- horizontal_position
- vertical_position
- dock
- lid

Signed-off-by: Won Chung <wonchung@google.com>
---
 Documentation/ABI/testing/sysfs-class-typec | 43 +++++++++++++++++
 drivers/usb/typec/class.c                   | 52 +++++++++++++++++++++
 drivers/usb/typec/class.h                   |  3 ++
 3 files changed, 98 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/AB=
I/testing/sysfs-class-typec
index 75088ecad202..2879bc6e6ad2 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -141,6 +141,49 @@ Description:
 		- "reverse": CC2 orientation
 		- "unknown": Orientation cannot be determined.
=20
+What:		/sys/class/typec/<port>/location/panel
+Date:		February 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		Describes which panel surface of the system=E2=80=99s housing the
+		Type C port resides on:
+		0 - Top
+		1 - Bottom
+		2 - Left
+		3 - Right
+		4 - Front
+		5 - Back
+		6 - Unknown (Vertical Position and Horizontal Position will be
+		ignored)
+
+What:		/sys/class/typec/<port>/location/vertical_position
+Date:		February 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		0 - Upper
+		1 - Center
+		2 - Lower
+
+What:		/sys/class/typec/<port>/location/horizontal_position
+Date:		Feb, 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		0 - Left
+		1 - Center
+		2 - Right
+
+What:		/sys/class/typec/<port>/location/dock
+Date:		Feb, 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		Set if the port resides in a docking station or a port replicator.
+
+What:		/sys/class/typec/<port>/location/lid
+Date:		Feb, 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		Set if the port resides on the lid of laptop system.
+
 USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
=20
 What:		/sys/class/typec/<port>-partner/accessory_mode
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 45a6f0c807cb..43b23c221f95 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1579,8 +1579,40 @@ static const struct attribute_group typec_group =3D =
{
 	.attrs =3D typec_attrs,
 };
=20
+#define DEV_ATTR_LOCATION_PROP(prop) \
+	static ssize_t prop##_show(struct device *dev, struct device_attribute *a=
ttr, \
+		char *buf) \
+	{ \
+		struct typec_port *port =3D to_typec_port(dev); \
+		if (port->pld) \
+			return sprintf(buf, "%u\n", port->pld->prop); \
+		return 0; \
+	}; \
+static DEVICE_ATTR_RO(prop)
+
+DEV_ATTR_LOCATION_PROP(panel);
+DEV_ATTR_LOCATION_PROP(vertical_position);
+DEV_ATTR_LOCATION_PROP(horizontal_position);
+DEV_ATTR_LOCATION_PROP(dock);
+DEV_ATTR_LOCATION_PROP(lid);
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
@@ -1614,6 +1646,24 @@ const struct device_type typec_port_dev_type =3D {
 	.release =3D typec_release,
 };
=20
+void *get_pld(struct device *dev)
+{
+#ifdef CONFIG_ACPI
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
@@ -2073,6 +2123,8 @@ struct typec_port *typec_register_port(struct device =
*parent,
 		return ERR_PTR(ret);
 	}
=20
+	port->pld =3D get_pld(&port->dev);
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

