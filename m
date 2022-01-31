Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3024A3F59
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbiAaJiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:38:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:41735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238447AbiAaJiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643621886;
        bh=JpB5EeGsjEKA7C7A6LOk7832eX0tDl/y70K+UIb+d8I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dyeSFNU+KVIJNeAFmpyPXwWOloE/m37epaKLjroHwmjExm2lZf4Ba8FwDlu+OqHOR
         88ByGkmFVRcFburtLAJmXBRjIGaEYrx3l6KvqqBGv/p6V6VnqUzd0St/bzG7PbbPxi
         ylF5IJU50qDE1pI9pLeYIQhXUmqhIDJWP0knV3DM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MORAU-1mt5xQ0WFy-00Pwk5; Mon, 31 Jan 2022 10:38:06 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/4] hwmon: (sch56xx) Autoload modules on platform device creation
Date:   Mon, 31 Jan 2022 10:37:53 +0100
Message-Id: <20220131093756.8075-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131093756.8075-1-W_Armin@gmx.de>
References: <20220131093756.8075-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2GV2X4NCRXiLexg2jyxgvm910cTocEb1CPSrzJMGpzhxol2tLru
 LX0yE8aKsatZRuYZHciEQ9IVkob97SuBUGw05fGa7UHRhGBEdwVnLejtd5eReac5VJtdVJc
 YA+ylpshPQZnmZGdYqf1t31VBOcij4KLJ2PxzPAjE4xu6/5ih5Q/uxS4oZwo+h+7kFAZCJw
 l9qxfxdgF+sPYv7Ra0npQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:85dxoojQqZg=:B9CFx7KUZ+Jret0awhOQuk
 e6CdTIRNkWcKwbVid3iaouJtBAon/Wnjm16Lx0+ksjPe6qWkscFCHr5i7vR2Fa/wBnU61V9BS
 WtB+PuE3HsHpZMg20J72df1xKUPC2Seu0oUO4vNHRUd9MUSW8tT2GXFyeIWYVVs3cy9AGCIuZ
 m9w43bgo2sy4FlydpQG6shqkszAtsSsvmixt6ka2WgQFHSkpi+KtvA7602Pv6GsgS7pKj5dHz
 8g5rY/V0gCiuYD7pTWIyOhVXgVnwvhcaYP1CP6rC+N2gDFmqjh8mdSczZv7NtyUZFOsFq8wJ7
 yCoDVnDZC0But3Wu04pcg+mSiamBZHGf2k4Ww0s9nKfX4LJfrCplfXHPhAdt2sOY3Eb+Sy3UM
 5JuOUeXNHsaxROL8IAPpN0Qj0wjqFc3m6FbwK+G9yXicL8yQANsectrjFsXwa6LmHSprlcyPv
 SIvmDSKSvjrgdEdVhoPXrSsnr/crUVcX1B69WXFyWw0hykDlcAkSmZHpYLn7gi9qlYYHJeGg1
 hzXRZx56UabeSxt63IUB4O3rFlDEsXZRpkWICxcKse6SYpfLYT3wtlvUJbkYFX7+cPKuJvU+5
 OtWdggTODEZCQ5Fm9w2ls4tpPZzGtwvO7BC9K6Wiw1Vqa+Y9G38j7QqtHQUifOXBH3vPBhTeM
 jKulV3beByDXfos+omhyedMXwIfqsTytm7VmrTFiDbFuGTe9iuPfZzucKz1qB3cfa+VoX397s
 r/oxzeloiTNy0b3VlFMzqM1Jo347CP1nmIyWveXPh4uIkSbTuOOUWscupUaXGWN/jRCKiBKM/
 kKvF+p3x2OXGv0S6c3PJNKtFHNu+5njCM1rlbmBy1rCeOFgIXg6S2fWOoMrSFUrKUMIsDj1if
 eR7gljV3uym5qYDWpntHlHsYaO99jbaevgnxDHUJcS5tSheQqmJj3fRjCS42UVm3itpAm8fSK
 XmbGwypg1+OEsYe8+SsB32g6j9d0OiscYnlG0GSFpgXa+4zqN5z8kriCOSMLy9aHAYp8q+x3l
 QRABRl5Jo1k2zGHYoFCwz1ZQtjd+9o35eTW0B5BPxx0nk63K+nRx7SDbfySAMReK3H1MLvRNU
 XpVbon4pGDG4mA=
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
 drivers/hwmon/sch5627.c | 9 +++++++++
 drivers/hwmon/sch5636.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 8f1b569c69e7..bfff27d6c736 100644
=2D-- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
@@ -456,6 +457,14 @@ static int sch5627_probe(struct platform_device *pdev=
)
 	return 0;
 }

+static const struct platform_device_id sch5627_device_ids[] __initconst =
=3D {
+	{
+		.name =3D "sch5627",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sch5627_device_ids);
+
 static struct platform_driver sch5627_driver =3D {
 	.driver =3D {
 		.name	=3D DRVNAME,
diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
index 39ff1c9b1df5..9ef43cbfc830 100644
=2D-- a/drivers/hwmon/sch5636.c
+++ b/drivers/hwmon/sch5636.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
@@ -501,6 +502,14 @@ static int sch5636_probe(struct platform_device *pdev=
)
 	return err;
 }

+static const struct platform_device_id sch5636_device_ids[] __initconst =
=3D {
+	{
+		.name =3D "sch5636",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sch5636_device_ids);
+
 static struct platform_driver sch5636_driver =3D {
 	.driver =3D {
 		.name	=3D DRVNAME,
=2D-
2.30.2

