Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7301D4A4F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376735AbiAaTcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:32:09 -0500
Received: from mout.gmx.net ([212.227.15.15]:55337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376662AbiAaTcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643657511;
        bh=Z7EB/LO5aExgD4RlbbUSXw41BmiPeYS74GXPrPCXZdk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fpy1oEHFlgrP8Cm0syztqSUiScjWDhafl0LU+FeViCZ6eaClD5mkDXrWjMJ/DWn2H
         tJ1qW7zDkpajvwzNLIB9ndusGRcV2+62kcv5dZ8Co6M01zvFpNs07wjst5JF/OvLph
         vOrNDMR/dK9MCPw8W8RtYdkfj6IZ8pJN9unNg79Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Ma20k-1mkwSp31AS-00W02k; Mon, 31 Jan 2022 20:31:51 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] hwmon: (sch56xx) Autoload modules on platform device creation
Date:   Mon, 31 Jan 2022 20:31:34 +0100
Message-Id: <20220131193137.3684-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131193137.3684-1-W_Armin@gmx.de>
References: <20220131193137.3684-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jDNLt0CQuW8Yg6hSE70HVsvkH8FZpqZujeSA9sI7h11QHQsWySG
 wlXQ7lFnXRfeF8GxJhYkbdebXGq+u+bAztPbH3anB9PrMMBMi9C6Nljfceo0CxdIztg3UJo
 cI71vm7U/kIbb+fOeOKD1Vd8bpIdeqiDF/taLRZrBV6W0wEtanlQXL+qa52FpnFq4p1oGGe
 mARygq9tdQGPNDlX6/crw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SyUJb3vmce8=:xgQXxjevgPPU33MadHnhC7
 ja547I/UYPkNh+pdW2kvdXm0PDi7ZpaQ95eoxSrNQ0HdaQY8Re7VmYiB6RB3ZC+rT/l4PkP/t
 rjZsUa9B2GmxLn79eSd0Dy3fb6vhFgE+cJvN07jZcPDA3hwXA62Uzjx4vBspFQUCdEaalnc9l
 mlnxtnnQYHIHzlCokWMJNcfVwSYxdlPYI0gcmF8DJc0SysjSDGNksZP7ZnWSy8AnZ6rDFMEOz
 CntMS2AojgJ0dSKb9fddl6AR3/V3scRlgPbBaaPZaIuBonFusWvxjwI1HwZD39nury7/FWwHa
 Oa+ltna3uObh2s6x0kgvdoQr7p3i7t0a6bzfQ3UnKNuhHgeXxYU6Kp8LY4lGUqkRcbZzlZjzc
 7gsoR5uG4Yx0XddUVV38oh+j1yAuK8/abfC7D3RDYE0mkCtjK7Ze+sbg/5RLb2+T07jClbtpk
 VAz+lKCNfL353ZG0MWg9aeNmoBz7IV2pIAt2/gL5TN8ITvbJf6GT9jI1GxAT/vDxoJRZgfzDu
 xy984CEzmxW+pTtKzzjTbmFzR2jTNfUJNCQ0i3RpLlCjWarX00dHYxcxfVBYHY0EAhWhMeKCk
 qaHgWhjr6NEW41zGcKRHKbISkszZUiiSKMKp/83cxxhSXDEYM6bzbjw5QVKOmRvwqyYZrqADt
 zwqwqa6irXYFOZvp6ecp9+u4e0+ka9vaNEC0WOWfexw6/KkoS+hUdvm9TQA0DulHVVbaRoRVF
 kYrKyE6lQsWYupp4YNK7gXUFfRoeioO4i2y0bompd3vCie1HVUQ1QYdQZ3+FIsXx2c+f1xNw8
 AfuxYx6sAJH6b809IJ47C6M4+2GIFNQQCA1L1cN2QJZl6xRKYVYIdciU6c7XvpQHrX9s6l4Y/
 M5W4lmDq/rgJ6+GvBtsZlrFmvitkjhM+UIqm3o6dktR5/1E1zc3fwYx1qRmF+0MKmMTNW0Op8
 tV8LHI+DzFnu4e56nO55DAsm6L6YLwvoAlyroMf/EIDpLQNI59RNoosqB1SQwJAeZR698eRFP
 NTKR5IovYrVXapBSvVSOnYt9ai3WNwOzy4NAgMc50g0xTwCw1uY70oJSLwTz/oztJx8Hpdi8a
 PnGOCZFJi/5Mjo=
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

