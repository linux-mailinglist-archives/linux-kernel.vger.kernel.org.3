Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2D4A3F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbiAaJem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:34:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:47037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237158AbiAaJel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643621664;
        bh=q1ugW5vj4OYyvuTgfzR5w8vCHi9Ca6RP1hz9efhCLfY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Qq2XyU5quH2Q0nKeLaO+Qod9bI8o/nER4mLHe1l3wxMhtre6rtV7tSKzNNhrS/uyx
         TtsRtjp5ysx9AKlwaUaa1N+/p4bW3w5LnRrXgrUL/8J/U6pXPPlWATuiqXaKzNwuEy
         5dgVNb1PGlGtyS4m8djB9fjyG1S+JGBHls5uINzQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MKsnF-1mxkVG3Ffx-00LEO5; Mon, 31 Jan 2022 10:34:23 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] hwmon: sch56xx-common: Add automatic module loading on supported devices
Date:   Mon, 31 Jan 2022 10:33:53 +0100
Message-Id: <20220131093355.4151-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131093355.4151-1-W_Armin@gmx.de>
References: <20220131093355.4151-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mVazlSPVK2m4wLCRleXR3nyUTO4qisCiTeNqCAr5x1fpRN+US9a
 QoQJlN7xyWdHhj0DTsIU5VbF3LPeSNR0QdfiX5hjyXlWBcvPrEaZiLU96FIzBiZ9L8Su3Z0
 YTm67LA3fn0mzC59zq5/RSJ1k0v9XYv2gDrPA585n7SfgyxwuAJBleNByHohQ/2pxbSlMBL
 tpvdEfkPG+0Qjp0OMpTWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BCE2fFlhSCU=:KGsXIcdheotSwPr2Cb4pw3
 A3GCVjCEiMDstEY3meXjUkQt7LGPL1qxQvTQ7dlLzUxygc8e2dWd4CKjI8Tfbk/f0sEx3LDE0
 U+CrqBt8CFmbgeMmxwBTeWCKBEyDRHe+/nNfk/rGu9tdbLgQO/TIHMKCt/b17BIuibGqLci6A
 v5//KuOmXHFZ4POj7L+/APYVEyF5rEvjj0oFsns7izv8PLvkmwpaTypsoQAGpm/pg+Y9nRu9P
 kd+pyzksmkNel48LYsrKIQZtMsFUM0XEEC+hlT//x03wg3Qr7S/DuXb/45txtlT0tP32VXZEA
 UxnW3Ntszr+wDp8t7YLS4wKoRUrRyWLK4FLMRxayxuYa5OH9EGrhKfDYLnoXyBSSKFaKHp3R5
 ATsZKceRYJIKowi8WdZYnD0rTbRKnO7s6LWD81+Oqa0kaKNVGu7Yxrv7O4zl+RXY23lz+nScJ
 88Az58svlrrVNgtqZAeAe7hnmOd+djegSEqzV4hBYJ4eyVKWMizI1spz2y5OOKiACQBrkYZrY
 Fo+GAKfSIW96uPe+R4QEyf2vmhl01jEWjFv+gl3NEBAXROoN0MOrPSTpZWmJVrG05wFXh/yIN
 wiBfpclup54Pbod1W2YvDSLd7Ym8xuo2nvOmxW0U28RWWKF7SzjFF6N/FmUjvO3YlsOjIzDY9
 H6CdGs7RxOt+XeO/NrUw41pI3i6lDw1vs8AyiJ1cAyEU3V/Uyu1O+S0zTuBsUkgW9U4/8k1WO
 TKiZ5d0WCcRcgeS5x7PeyfamCP05+h7ENQTNu0IYKT6CB9U4Hw24KFJlgQP8iXnejsP7YB0+k
 fy60wlVBEcHDEcjL69pKNJHuaxOusok0D+JMJNuWbg9ga/0da3SOdMDn8kIqUQB/rbBuqztHs
 y1W/dzRBXD3QC13ZgxMyhYSuLZQhS8Mv9gpB3Ti877DdRhPEaD6UbUd/BSaUej2r3U6yhlRHZ
 seM+WfTEvr4tw59o+2Jss3oguXH7n6Nofqx2ZvZi5swW4THYItnqMC582RcQML/j+6KVwSFZ6
 r3bBzepKAOZ+0vFRPmHyFK0c7FSd+FkaG/5defQJdF8rd22oDqHmtW2Q1I2CDunUkKcnuzGIq
 6Ci7owVopW6rDg=
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

