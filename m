Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CED4A5159
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380569AbiAaVUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:20:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:56961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380301AbiAaVTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643663979;
        bh=Z7EB/LO5aExgD4RlbbUSXw41BmiPeYS74GXPrPCXZdk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QC+wfJU4qjqHRuvDazSwiYgF5APgW9bbG+W8iIC4pySOiBwHIeYGb7dP6nrlkzIqu
         L/UtNQmUUR2FKLYdmdrAKjJR+8BFDA6yVcQmqXGACqx6K8RUUFWLH4jpT4AO/DF1+r
         VgZYjuVHKqywfKV3avfbdfCtnyClCXloyynDX/wI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N17YY-1mDVdR2egk-012c84; Mon, 31 Jan 2022 22:19:39 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] hwmon: (sch56xx) Autoload modules on platform device creation
Date:   Mon, 31 Jan 2022 22:19:32 +0100
Message-Id: <20220131211935.3656-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131211935.3656-1-W_Armin@gmx.de>
References: <20220131211935.3656-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b5h6cUklFJKhhWZmbqI5nfUVfx+qiMkpOdrR3liD1zytHY/t0Mg
 /xTxDBja3+rTzKHCwta/5R2NnUncdNXfD5XTRgQzrbgTu9gDRgEMkeOavje/eDf2NunqNh1
 3kL5q/0rmBxrMMVaTp93KJ4tSvZrk6JG4haM17Ud9+7UZ7igBCHXagx0DWSPPInRyCpB4Vw
 A2qQj6BmgMi+3y5l+fyYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:La6NYU4Y3gs=:aOqxFJuWMA02mb9OxaW5bl
 eENMfOad47anGbzmgmT/ynjq9bBRSfuu1Ke1cQrIQoUxUJUDibEjbEGU7hpum7YfkTizobi8+
 EcuOAgqdS6KY76be15D3ooqej1tIZOZeU/9bQ88Q2KpzfpgqYgAZ1SocvCmjHGHWEKPAnl8jx
 eo4v52KEvIMFzi278LliNKoquG3+P9hJKbD1yFBwY4vu/2tgSxlC60WmxgcqLADgJgu4lLmoH
 xsBVlI0QQa6WKhWIpTnKZ3sp49w60qz5xptO+3OIEKk7vCa1m0bgRBWdnT8GC0bZeviq9pm19
 676Gk2B88rijlcChrVLObLVisAmqH/tUekCq91bHCbFaGpxcPZLH8IZNKqDpDmbyp+Tq3Q4II
 Ohfmw8ViwBiQ6Ji8vrsDe6jwp/IT4tug7sc7yQItiX353RjTsmwiD9Is+0cOIVyIf10gYWqGc
 0IcvAR2YNmLxjp0wfqiUYu36jI+HXBZezTztrGGNWe9FwgxnaCYn5Y+sXlTPuHE89XT+fuejD
 8R11FDwxeWigE/6zRSvBDZHAkW+iyKGxshFeaYY/DfahwJ5rn8tOIg0NMWbmMeSTmJoztxnwp
 sSH7Gf69oxjh8/gImFPQh5v/+miLepe00if1XRuZg6d+c7zV6aKxzH/7A74wQkFVpyAzAw3fc
 wb3D68WuI1fL/byaHGcmZUrdkttUha2irVJmwX3I7DgXICfaIbT4ZlDVQN2NKIpMTMX9WrcGr
 QGingY+japmH0QE4TmWAhWYKEl2VTEz26BUJhyNJczLNrK3daDjES9GzZDtGEvf84PnH0278h
 Oh8fQEWU9t7EPRyxJLB5OFXP5o9upGdH3PQE1jN0Ro1uGCu9zAvi7hf1946vb4hiNjD7wQej1
 NwSM2UDv7yEX8URWzUU4YsMmQ1IzYOZjeSFL9ePhtAOKTNWWkL6D7DKE7L4f6GncTTPLbEPSN
 Jojm3W3GExoBCYGvMb40FU6iuhUFihuX4MpC1AvIByYuxVL0qD7tX1Uv3Ihqbscb0HilDifvZ
 RL/+Oq2mGTwECGmYYHPIPzZVhWTxmn3Fr4sawAe17FKpikaXV8PqLDe2dVcSmi2cPjtS4JG45
 GGFiatwybqn++s=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, when sch56xx-common has detected a SCH5627/SCH5636
superio chip, the corresponding module is not automatically
loaded.
Fix that by adding the necessary device tables to both modules.

Tested on a Fujitsu Esprimo P720.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch5627.c | 10 ++++++++++
 drivers/hwmon/sch5636.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 8f1b569c69e7..72c3f6757e34 100644
=2D-- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
@@ -456,11 +457,20 @@ static int sch5627_probe(struct platform_device *pde=
v)
 	return 0;
 }

+static const struct platform_device_id sch5627_device_id[] =3D {
+	{
+		.name =3D "sch5627",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sch5627_device_id);
+
 static struct platform_driver sch5627_driver =3D {
 	.driver =3D {
 		.name	=3D DRVNAME,
 	},
 	.probe		=3D sch5627_probe,
+	.id_table	=3D sch5627_device_id,
 };

 module_platform_driver(sch5627_driver);
diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
index 39ff1c9b1df5..269757bc3a9e 100644
=2D-- a/drivers/hwmon/sch5636.c
+++ b/drivers/hwmon/sch5636.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
@@ -501,12 +502,21 @@ static int sch5636_probe(struct platform_device *pde=
v)
 	return err;
 }

+static const struct platform_device_id sch5636_device_id[] =3D {
+	{
+		.name =3D "sch5636",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sch5636_device_id);
+
 static struct platform_driver sch5636_driver =3D {
 	.driver =3D {
 		.name	=3D DRVNAME,
 	},
 	.probe		=3D sch5636_probe,
 	.remove		=3D sch5636_remove,
+	.id_table	=3D sch5636_device_id,
 };

 module_platform_driver(sch5636_driver);
=2D-
2.30.2

