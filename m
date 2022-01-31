Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4044A515A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380682AbiAaVUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:20:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:34189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380369AbiAaVT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643663981;
        bh=q1ugW5vj4OYyvuTgfzR5w8vCHi9Ca6RP1hz9efhCLfY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ik/+xU1+MdpEVMHHCRflF6H7q0mAt6mNPyfkAGbBJuP5RIRhjuU/CoWnSMlxT9K4Y
         +oO0Uaku7XH+U7MKBEcqSAP+jq/oGTyRvVBHf43cGRN0q8CZhgqeS+e0QWf5AiZ7xI
         /434A1M1YrYvPV0l0k+vDd4W8LGB4EYeuS2SVRuk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2wGi-1nDYga3JzI-003QXG; Mon, 31 Jan 2022 22:19:40 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] hwmon: (sch56xx-common) Add automatic module loading on supported devices
Date:   Mon, 31 Jan 2022 22:19:33 +0100
Message-Id: <20220131211935.3656-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131211935.3656-1-W_Armin@gmx.de>
References: <20220131211935.3656-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:82WFjN7VINhCE2s5WpqADCg9uhIkpzAYVYVznlgZ15UE2mHAWu8
 QEp08FXJIotP/2dQq9OGgOw62wMTYlHvY9dvRfhSXNtuEZEQRepS63C58YvhuU/kYT9Ee5/
 9febMv5M66sK72iiIsC3cOv2+lc8t427E+Nm5W/dgDeWJMBqowb5FE3bLzjMpWfrjaYao8Z
 t30m32qrgOMSRoDEuQTcA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9PYPnszt44c=:y8DJg1mU+1kqaq+jrzMdXp
 ZaEN5g1qk/8tda3GNAv9LIBK0ByM9h09emd5t2jD5UTt7Xnc3+V14mnSM83uW1D3Snku5PNQe
 Ls+XhWPFQUpAMHrp55ZX0891pgXnpJQvRRZ8f4bJrn6txNHcaUt5f3dlIJqRmo8ron5mRxt9n
 wEQd6QlrPZI/xDm5nlAE6m9LgUr85d48et4gzZGW5bAKEdvatRMYYGlPhelvj042dIwkyfcbA
 fDS4XNrKpWlN873SP+2jssRU9PvDx6v23oxjxYmU+qGNauf2eoq5wwRZ4XFKVPY5VlnrA3YX1
 4WcSJRZCuvLhWDYQC4lmUMZ2T9lr4zmkMPBS0+ERHVkO6WA1WjKSmsWvEHC+kiXvxEmVJBL8L
 sbUjFMpes14mCKxVAo+qj7PAgLx6JgaKLghgPc/fczU19ZdBYADNOm3AZKyCri33EKjHNx/iO
 pAvhJJP+DMefw32ECNUqjPciA1sHsuB/Q0st6RkInyTugvrIGZqAN/vkXeVQbGXAJOHHWTkaA
 D3NnoJigLLxL06XXfzR66TkvnnAwJ70FR2rbC0q2QBXATTkYoaTk4g9ZZlbzCBY83WbGGGbnu
 5IFtWWvS0mM5YpkM0n8rHQaV1HDXDKFPdoQSDiCuzuRagkQyS7xCykAf3xXQDLYAmndD6FJGS
 ibI+5AY8/RiJuJxk4GWdaDvFA8jv8ndhrPaj+v9SbjZ+rBYOvJ0DHilTzFYMc2hL4yywMltMt
 ky5imzgdpIN7NkSR+NIbt2xjJae7FGSSTGzHnJAWAJArPC8BhZ5BLATSmf5wGU78M34nqr9vh
 /e5eNJJhjkLMURdDeguV/+ste9jWh0R++LZUbPgbOzl1FpN5Qz2B54s1ezJR07ihbHLOGSd+r
 G4bopAxGfcmkr9FVwda+779RghIabl6W4WxPDouKUQebzRrrn2wACFShlzHqSzobyfpRwED6Q
 pDIRfZNcNvMxuMhr8cpmvyuFGJQIfcL4ADQh97SfTEeDPhkrc3cHMGP/YA6+KpjiCEkF2Tjt7
 cTbsXFJGW7cUGhpUAg6ZmqVi39HjiUH92lkJbokaYs6ftTdJ+6mP7g1o9KAbda5MbiC1f4/du
 TOSAhVL0Bt51Yg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the sch56xx-common module to get automatically
loaded on supported machines.
If a machine supports Fujitsu's SCH56XX-based hardware monitoring
solutions, it contains a "Antiope"/" Antiope" dmi onboard device
in case of the sch5627 or a "Theseus"/" Theseus" dmi onboard device
in case of the sch5636.
Since some machines like the Esprimo C700 have a seemingly faulty
DMI table containing both onboard devices, the driver still needs
to probe for the individual superio chip, which in presence of at
least one DMI onboard device however can be considered safe.
Also add a module parameter allowing for bypassing the
DMI check.

Tested on a Fujitsu Esprimo P720.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch56xx-common.c | 40 ++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common=
.c
index 40cdadad35e5..0172aa16dc0c 100644
=2D-- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -7,8 +7,10 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
@@ -19,7 +21,10 @@
 #include <linux/slab.h>
 #include "sch56xx-common.h"

-/* Insmod parameters */
+static bool ignore_dmi;
+module_param(ignore_dmi, bool, 0);
+MODULE_PARM_DESC(ignore_dmi, "Omit DMI check for supported devices (defau=
lt=3D0)");
+
 static bool nowayout =3D WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (defa=
ult=3D"
@@ -518,11 +523,42 @@ static int __init sch56xx_device_add(int address, co=
nst char *name)
 	return PTR_ERR_OR_ZERO(sch56xx_pdev);
 }

+/* For autoloading only */
+static const struct dmi_system_id sch56xx_dmi_table[] __initconst =3D {
+	{
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+		},
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(dmi, sch56xx_dmi_table);
+
 static int __init sch56xx_init(void)
 {
-	int address;
 	const char *name =3D NULL;
+	int address;

+	if (!ignore_dmi) {
+		if (!dmi_check_system(sch56xx_dmi_table))
+			return -ENODEV;
+
+		/*
+		 * Some machines like the Esprimo P720 and Esprimo C700 have
+		 * onboard devices named " Antiope"/" Theseus" instead of
+		 * "Antiope"/"Theseus", so we need to check for both.
+		 */
+		if (!dmi_find_device(DMI_DEV_TYPE_OTHER, "Antiope", NULL) &&
+		    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Antiope", NULL) &&
+		    !dmi_find_device(DMI_DEV_TYPE_OTHER, "Theseus", NULL) &&
+		    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Theseus", NULL))
+			return -ENODEV;
+	}
+
+	/*
+	 * Some devices like the Esprimo C700 have both onboard devices,
+	 * so we still have to check manually
+	 */
 	address =3D sch56xx_find(0x4e, &name);
 	if (address < 0)
 		address =3D sch56xx_find(0x2e, &name);
=2D-
2.30.2

