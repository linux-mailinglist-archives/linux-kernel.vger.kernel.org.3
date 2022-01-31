Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0CA4A3F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiAaJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:38:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:50055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238819AbiAaJiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643621888;
        bh=q1ugW5vj4OYyvuTgfzR5w8vCHi9Ca6RP1hz9efhCLfY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GRSolaKoj6JFJmn5IRm6k6EC3/2uKfoe25QVA0FacfB6LWBH+B7bvEsAKDJ3CuYQf
         ArEtgvM7rR2I3aMSsrDQ9k/5ElRtwFVORJhizfyDaMRAIDk+fUIR2cbJ2IduJqWToL
         iG/msOWVMw2Mpy1pwBT1Mxr9Pu8hvoNN1BCCYhZI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MAfYm-1n7pJA0kA4-00B4AN; Mon, 31 Jan 2022 10:38:08 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/4] hwmon: (sch56xx-common) Add automatic module loading on supported devices
Date:   Mon, 31 Jan 2022 10:37:54 +0100
Message-Id: <20220131093756.8075-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131093756.8075-1-W_Armin@gmx.de>
References: <20220131093756.8075-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3e5EiL9EGTf6S2faKx/hZPtaZ/r3OwWmc73OVgGE1RfyLkUgWGH
 0XoABBRHSbHmYV/XxcIkqBfQYzjWwlhv3s7ZSS8HLRATzKVK3gIM+Nw6Laf2iCPJGwSvVzx
 hecVFOpeLcPbI6sb2uTh9O6PgYsSMZ87svgzW9uUgMjZvmjYKPgs4EDzlR7CDj2SdjCLHJr
 id2XTYowH6btdw7YW8+IQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1aR8S5uN9nk=:68kuFq2kxuXzVWmlTwTx1f
 Q50Yrsb+WI1OWVAGOVXipqybfZ6rqiyYsHtpQNKi1vw0wEv4EmWYgWvB5NV76K5OIBhXUS774
 Hs0merK2ILPrj9CxLV/fSYAC0QbJH0ga0Hup48dPqOkgVcT+ggEyurPdydKdr0x1cSsoCZbGI
 NENbZJjjxkbsyLxRvGr6Q4FcUkrCIzvUeh4BbgN7jSRJhwgkyGtqLI522MPapPMLRD6AsEpcf
 zEPnH9ItI69AL/JKJcj5sETvpCoC5uxppjG/FLe4u6miHQgCHZU/nudFzhfFSlRvZvc5xvw97
 zLRB29uV9KWdiU4BvSAfd54t8qsuYbOOKNyyv14zCAyadeC6VxKiz6ThbGsHBmdhrI/olAwAD
 uqv5iVqTQSdwvsAWHot4M3ulNt/togpijpZm0RfB06h+5AaSYxNttDI/+CD+Rp4TxrQD8Y8dO
 sR6oSwUA+xWFesDPzI0xMlnv+L7FDbS4Q6Rc5W210lsmpBrl4z2qsbjS81/eAafRHZHJK1dYo
 6P67Ui3VM4es6Sc9L8em9wT2WW5D2WCnf0A51FfCz0oAITOkGZyvCcXvhfUmMz/vcT7BGlnTA
 PBXW6oi+ApKwapPfpWIdDH5i+mXqi6Zp+HnAxtJTuVhqq1sG+ISq8BA8ACetKWWJo4F2p3UEG
 85yI6vfiCS77vjT2mp+XgUlX1I2Ewsz1ejj1YapAxbxTTEl/jNGoRwT7xaDcGdiV/zI/ApG3Y
 x31EMC1ycyh73CLltodBsTQym+R9yz/DeruyS+sFx7hwVlDNaG69hspo3SgsAp9k9OQ/snQWY
 rMiwxiRNs+yg6HAng1KmzxNq2TwCyvsdTwAH1ESOQY+/Ati9JJsXNTR9vhJQ+87r2yVOmvS/0
 kctBZJmqPWAy+fhh42N2+B5Z3EaUGzfSyXxGXsJHxudvQ23XWNEKPqIG6UexFL3GtWKjxN1uW
 rNbEK5a/Jzh/zlkfHwfLtVwhQlT0YNxnJWyD8bV9VQFjjc0kXm1uqEBm5Ti+VabRXYw3AEP92
 UbkXUreTZ7D10kVMA1HApre7v5Av0wLzFbKDVYjVueATPheIXEx8DJz6GQ84I1zBLIcrN5Q4B
 NCv1DEL9MlDjbg=
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

