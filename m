Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D55049FFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350499AbiA1SIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343786AbiA1SIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:08:36 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02D2C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:08:36 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a12-20020a056a001d0c00b004cc283b2e30so3894169pfx.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Bkh14uDfsUEA7TaMl1B9+mcSAPEw6C1dcoCn17WX2mk=;
        b=htaCe6/Ry2WEninDH8j56q3piuFRWMolFY+yTFOaAvPfztfZh/Jb1AZsVtEFeOH8kB
         HTgF/YsUNo0Zkke4Q0vNEw/caFYVPCDFYZaBEY7XCtwrSHQOZ/SiUg0dEAh4UqmxoLEe
         qjtQD842ouu/DNZ7pBAKPH3fJ4Z5JNzZZ6NF0CPPkS+vsEfbVqIV88CTnROKYOHfj9Lc
         o/cYaAHoSAzaetXGpWVk+bEOBprZa0+wtm+No/x4RU7Pir9gHC+XdwZItK3xChERMcFN
         3I6fCGgVa99Buc7Hm2+IISuusAz6zjRX1EyTRrJ+DVABb82jlsHwWbo2eQ5La0XB67cu
         H8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Bkh14uDfsUEA7TaMl1B9+mcSAPEw6C1dcoCn17WX2mk=;
        b=xyTY/6e+X/sFkUbvkomjbk9Fyu0WppBj3cPddt4HdicaPHARfHLt/1cdm6BUq4j8Pl
         g3WiduLHJm8+ZjEiHrH2J+wzBdsQqnj5TH0mvkdnm/6yti/cS+pnib8NOJZ+OVUP9agw
         TlWCiM1eVBEdgrEnZAAzVgL0Gc+ijuL1POWjyaNDkmsNzwrDhS7Sz8yaORXDExNU2ZED
         uv95KgaGkDCPc8yMWCyZhGwjDddVr6RVYLbWtFFbahgXn00kAdTShZ9hAU+eRSMLjhtH
         VjBBRKrMqBXvD7eaIR6fiuPNdPMeB3bl77sNbVGlP7S6msRDgb/S7oChQ6xZIdJR/YxQ
         hAUg==
X-Gm-Message-State: AOAM533Har4Anfz5rBwX9urPFcqG3fOMNuiKncqUblpH1H7ZklFf8EE5
        n8mjdCup7pXmxGnryEMt86qsGxTWNTlxTQ==
X-Google-Smtp-Source: ABdhPJxozWl/q130pZf0vssYeO8OQ+Hn/gc+8p+rHkGK1UNAuYRK4d6XPubCE9NMK00kLqp8AoyJs/JKE0FElQ==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:902:c40c:: with SMTP id
 k12mr8724245plk.93.1643393316094; Fri, 28 Jan 2022 10:08:36 -0800 (PST)
Date:   Fri, 28 Jan 2022 18:08:32 +0000
Message-Id: <20220128180832.2329149-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v3] ACPI: device_sysfs: Add sysfs support for _PLD
From:   Won Chung <wonchung@google.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
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

When ACPI table includes _PLD fields for a device, create a new file
(pld) in sysfs to share _PLD fields.

Signed-off-by: Won Chung <wonchung@google.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi | 53 ++++++++++++++++++++++++
 drivers/acpi/device_sysfs.c              | 42 +++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/t=
esting/sysfs-bus-acpi
index 58abacf59b2a..3a9c6a4f4603 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -96,3 +96,56 @@ Description:
 		hardware, if the _HRV control method is present.  It is mostly
 		useful for non-PCI devices because lspci can list the hardware
 		version for PCI devices.
+
+What:		/sys/bus/acpi/devices/.../pld
+Date:		Jan, 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		This attribute contains the output of the device object's
+		_PLD control method, if present. This information provides
+		details on physical location of a port.
+
+		Description on each _PLD field from ACPI specification:
+
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+		GROUP_TOKEN	Unique numerical value identifying a group.
+		GROUP_POSITION	Identifies this device connection point=E2=80=99s
+				position in the group.
+		USER_VISIBLE	Set if the device connection point can be
+				seen by the user without disassembly.
+		DOCK		Set if the device connection point resides
+				in a docking station or port replicator.
+		BAY		Set if describing a device in a bay or if
+				device connection point is a bay.
+		LID		Set if this device connection point resides
+				on the lid of laptop system.
+		PANEL		Describes which panel surface of the system=E2=80=99s
+				housing the device connection point resides on:
+				0 - Top
+				1 - Bottom
+				2 - Left
+				3 - Right
+				4 - Front
+				5 - Back
+				6 - Unknown (Vertical Position and Horizontal
+				Position will be ignored)
+		HORIZONTAL_	0 - Left
+		POSITION	1 - Center
+				2 - Right
+		VERTICAL_	0 - Upper
+		POSITION	1 - Center
+				2 - Lower
+		SHAPE		Describes the shape of the device connection
+				point.
+				0 - Round
+				1 - Oval
+				2 - Square
+				3 - Vertical Rectangle
+				4 - Horizontal Rectangle
+				5 - Vertical Trapezoid
+				6 - Horizontal Trapezoid
+				7 - Unknown - Shape rendered as a Rectangle
+				with dotted lines
+				8 - Chamfered
+				15:9 - Reserved
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index d5d6403ba07b..8d4df5fb1c45 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -509,6 +509,40 @@ static ssize_t status_show(struct device *dev, struct =
device_attribute *attr,
 }
 static DEVICE_ATTR_RO(status);
=20
+static ssize_t pld_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct acpi_device *acpi_dev =3D to_acpi_device(dev);
+	acpi_status status;
+	struct acpi_pld_info *pld;
+
+	status =3D acpi_get_physical_device_location(acpi_dev->handle, &pld);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return sprintf(buf, "GROUP_TOKEN=3D%u\n"
+		"GROUP_POSITION=3D%u\n"
+		"USER_VISIBLE=3D%u\n"
+		"DOCK=3D%u\n"
+		"BAY=3D%u\n"
+		"LID=3D%u\n"
+		"PANEL=3D%u\n"
+		"HORIZONTAL_POSITION=3D%u\n"
+		"VERTICAL_POSITION=3D%u\n"
+		"SHAPE=3D%u\n",
+		pld->group_token,
+		pld->group_position,
+		pld->user_visible,
+		pld->dock,
+		pld->bay,
+		pld->lid,
+		pld->panel,
+		pld->horizontal_position,
+		pld->vertical_position,
+		pld->shape);
+}
+static DEVICE_ATTR_RO(pld);
+
 /**
  * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
  * @dev: ACPI device object.
@@ -595,6 +629,12 @@ int acpi_device_setup_files(struct acpi_device *dev)
 						    &dev_attr_real_power_state);
 	}
=20
+	if (acpi_has_method(dev->handle, "_PLD")) {
+		result =3D device_create_file(&dev->dev, &dev_attr_pld);
+		if (result)
+			goto end;
+	}
+
 	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
=20
 end:
@@ -645,4 +685,6 @@ void acpi_device_remove_files(struct acpi_device *dev)
 		device_remove_file(&dev->dev, &dev_attr_status);
 	if (dev->handle)
 		device_remove_file(&dev->dev, &dev_attr_path);
+	if (acpi_has_method(dev->handle, "_PLD"))
+		device_remove_file(&dev->dev, &dev_attr_pld);
 }
--=20
2.35.0.rc2.247.g8bbb082509-goog

