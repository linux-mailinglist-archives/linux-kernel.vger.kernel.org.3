Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D78D49EEFC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243394AbiA0XpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239508AbiA0XpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:45:03 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE206C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:45:02 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id c19-20020a637253000000b0035e0ba5a1bfso2289294pgn.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=FeJS7xf34VelIfEIwGcvGlgB4HQ0+TQ7oDm/G0cg3j4=;
        b=ZOq4YdeHeJp+nBUwSZaiTie8j8HjrgMt7YjTbttkTx0EsBcRH05/3vSHOogqojwfNX
         e7VyR9V8RH8HWavxyji2WfKjSXD1kHT43TTJQwKP+IPLMI5oOo89q9oN7Giy7LKU/Bwu
         i49kkLtk+PkH7ImND9+X+pgdUVzXC7astzefA75x12SDBjVmZOUUHa+klAViaDcIdybS
         BEMYFiC3UrEk5wgsWsycp95l+lxu1HvqqM8Vl4veG/XhxQjcmbR5s/GISp1EtGPg2nw6
         +V+/PwNOwuMI8LvcLGyrAhcBfUQuI4lnWJjUTh61SSh2Zfn3UmFU31PnCbzHJpX+y709
         JAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=FeJS7xf34VelIfEIwGcvGlgB4HQ0+TQ7oDm/G0cg3j4=;
        b=sujZrkZYc38sMUx0jKLOQxpcHUD6lEw5QLHPw4m1cTomgLdmTLQKdCd/I8ybzFZXjW
         9zj3cJd5VpNZMIcyXBiq+kOjOzGyvM0VVaHYdpkm13tTp02TaaSGaxDWZoDFNP3uVIwO
         kPALEC/kJwoe2lroLMrD6No4KxBFkMWz9r7QNIwxGr0xPHFiE962oLuU2RNm1VHQBtgZ
         97UMNlEJs884hbfm2RNTmztG2YkL24wXm0ZVRV5gUHBKCLorBW20y7DVNkz/ikxgVzCb
         NhEnMMpTQliC8aHylCEDLT0lUpdJgI2t5W3a/tGgMSKE4kkF2Qs6Ft7NkaGBxUm8t3OE
         1xHg==
X-Gm-Message-State: AOAM530L+HDldrxMHdsf1Se7prCUSkb99wZi4Z4IF9IHXpYlHpbiCn/+
        8scApl5gFoKzyS/aFygPtVSRVTzcvXxadg==
X-Google-Smtp-Source: ABdhPJy0oHhxo6bK2nL/LJjHeg16TCCPU/5B3wvzJM4gADSdLyk3TCijwnkGzHKKyfPoZ5QOX8Iu4Bbs+jXZ7Q==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:90b:3841:: with SMTP id
 nl1mr6704792pjb.24.1643327101982; Thu, 27 Jan 2022 15:45:01 -0800 (PST)
Date:   Thu, 27 Jan 2022 23:44:50 +0000
Message-Id: <20220127234450.2218419-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v2] ACPI: device_sysfs: Add sysfs support for _PLD
From:   Won Chung <wonchung@google.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="utf-8"
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
index 58abacf59b2a..7f4544c9d563 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -96,3 +96,56 @@ Description:
 		hardware, if the _HRV control method is present.  It is mostly
 		useful for non-PCI devices because lspci can list the hardware
 		version for PCI devices.
+
+What:		/sys/bus/acpi/devices/.../pld
+Date:		Jan, 2022
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
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
2.35.0.rc0.227.g00780c9af4-goog

