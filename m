Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19664A4F81
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376984AbiAaTcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:32:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:59703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376749AbiAaTcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643657514;
        bh=q1ugW5vj4OYyvuTgfzR5w8vCHi9Ca6RP1hz9efhCLfY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BfJ2dMQAyc8PQ/RinKT7i5+lIvt2nqNYtzCOrj2wwCvnSf5SWRtAEti7wcKwQ23LY
         Y4nFm9UTN6HO6HWGSxsfmpl9DwbjBRwG4Rv1mqk6T5wtdziYu2jWCIkUNTj1/BFVA5
         xCYvYQbrsqhwzMBnsnZVbl0nF2zUcKVBoa3KDeVQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MsHs0-1mMN9f3VIA-00tnRB; Mon, 31 Jan 2022 20:31:53 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] hwmon: (sch56xx-common) Add automatic module loading on supported devices
Date:   Mon, 31 Jan 2022 20:31:35 +0100
Message-Id: <20220131193137.3684-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131193137.3684-1-W_Armin@gmx.de>
References: <20220131193137.3684-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V6opI1FXWRrdoEYgQTXVumJBPzXghJbMSiAqn7m4qDmObX7oilD
 /I+PDD82Mt8f4ih4RCx36jdLR7yxnBvrhDWn09w2GEr4hj9BQJDqASxsj4nyB3B78VLJiHC
 VJJGBDFO7A9PDUUuEI5XG/rvUmB811RfB2O6iYZOVaJ0hgXfNyyakBkiy1YotJKOyhDS20Y
 L9+vt6JHaVVcXKqjNoamQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/rrepjD6Q3M=:ufdmnS5xcGIdZOlprNS+yG
 UWzc5xPr26Ji+6HrKCQyijAGPc9Lj2//+vNKaerACfUBrePabAklp9DUmnfLnKK7017zPgy0l
 83PuPH/GVAw5iYtI90GXeuY4sgwd11iNWGKnib5wnVbE54YmU1Prp8Nj7TxP2pIHkRgq0ga7h
 lVH8+TIl/l0xjB6ewGDdsxmHQpdnlWq5Jxd3iqv0eaUE2yyLql9MjgXE7OQ7c9lLbH/gd0ntv
 NWVI22+fcus+eIFqbeLBGtocdu5HDM5tFvmwO9wCCb7LbQzE0mcykKsCKj5GuxmbX/qiuguj8
 I92z8XygTMi68qckEQLbBOw5tb+eFow/fCewiFe52/ArrSqyszTleBr5aPeO7bhW0xrQq9GdO
 DN5aGc6faJsPtRWAEsnD2WDajrQFJd7p0V9BWMDBmy7pZhuTuOd+afPIZAl8Trg/+fL7FINAy
 T/ekeh1X/nJQifFGxmm2xZY7v5CPMEmZwZVcS5be6sAprCGoGWkeWAaTApfQhhDKddBcI8JSm
 r5ve/6QzH/2nmkcYXJ7WJ68GaTypw0mi2iChWkdV3tjnaTkil+mwqcwNlWFCSwCzqV1f1aUha
 lAuGptToBAz8AQJLaLoyRIcjFDiSdFRtMaVoe3OgAmtg+LNSdFd2ppn3Qu1svN/HuW6cQ/buW
 VCdBXU984Dn3CEY+Ns8ah8vVUAoabyTcWLdLqRKiXMZaT2G4sy1St3+uhS6D+DNcym/Lq1Ex9
 dkMP2DhsVgvQxGJa1XlWjMOh4YPxlRmryQNIpkTEvXWaP6aTsljaEcHv+dyng8LhrusFgGjB1
 j+n3BB6q5SxhKNT/NHdD7P+AompbYImiPIzbcR7/fWmIQJ5EoN+4kXxrvLwLw6Kwv1Aqg2lRu
 hF3peo9GUrn6ikvl2K3hl+VT76ifQmAijyzqnj3SRwexcptP/PTbZJHhUvuCYlRoNgoJnWdRs
 aVIV01E8VpszNkCCEs4gZMrwp3lmN7/luZJ69jNcZV20YzOG2iTg1Wa2cVO540o/jDfloFSRn
 GnEnNFIQrfMkzYJ8+gKwZ3m4YHlzoGcb7D0Mx71XDZY2WDtDuc+klOTZeeZ/cxqCehd/38F8R
 5YNiQdVtELshTo=
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

