Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E73A54FEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356365AbiFQUr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiFQUrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:47:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A8C13CCF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655498805;
        bh=iaIFSLNn0yklCqLnafJqQ+I6bFLTwxIwEcdTu4zodc8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=CG+hyI8REyBqRwwW7ck0QIuBI3l4t5i/Gxf8wka6OgQSUAzTNUwnANBhnAoEFIbgA
         iebSTQTIcL/F0AMXL0EDeylY08KKrucUZGC6M4/tctjyEi6ZE7286CUh2fSqV0NaBu
         yfXrt9//8xUxYl1amaFWnYiGl1cv0SuoiUUX8O1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.79.145.145]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1o2Ird2FO4-0005pc; Fri, 17
 Jun 2022 22:46:45 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Hector Martin <marcan@marcan.st>,
        Conor Dooley <conor.dooley@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org
Subject: [PATCH v5] soc: nuvoton: Add SoC info driver for WPCM450
Date:   Fri, 17 Jun 2022 22:46:12 +0200
Message-Id: <20220617204621.2578264-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/YDohyDLGP2/N5mQ00CwOy8kbNwMFBlby8KtUS+me3sK9j1Vl00
 J2zQxd1ln5oGPYhnurIBMrGyuwQy03YL64yn/gM31QsyLNDSY4Zc+VRjC/5ze6HoTphQ+2d
 HBqOoMrXlTKDlWBDkE6qY5er7hL/UbLGSrR2+olScvwBaut4U6d68NTroC4qg2tt1qevp3i
 6HDF0rUu3plAZa8seGKsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XG4BIobbrnQ=:b8wRvxLBImRqxqgPZmvIAh
 9AkbkoIKyuPIUfN0+TQj5RkEo4kX64Iy7a2qMQmBKgjdCvlvta77JkKWY1eAf+ZsWjmPz03Ha
 xpXRqTpdz9qv4u8jTxqztxeyuNe0yA0OJzOqcLCKWlH0Xq32RK8UiYySw2gYJzDvNbTMRc1S8
 1c1PNG86ZG5UWObcZulKPbqY3nqz1Zdt7PDROqnxLrwywgfP5mmXIWW1f/Gq0PDTDg77tBf1S
 sX5urnq8QVAS/nR4rcbrc8eWhenA1thHahvR2eC47uiEirYzkrHic+Urg/ArlHk9onmVqNp+C
 zD9vMmA3snV23temSalpYmWr17b3x98QE6lQIr2uH3FRLsFKNVSCn7zK7KUcCDcWQUrX4DNn2
 3weHA372H9CmvwYXiwFPhaEZOik8Ky1mt580QfQb+ssAqug6jHxM+yk8+JoAjcCkcRdKoA6oW
 dC7xOyCSNYngmYTt2oWlV9krUE+O+MeoXQbLoJ8r5S3COt1sV7s1c9CNkXdawi4Zd8aTdYjJS
 GYkxydJWhhpbf6EnrcZIO2ReDjG5r1V9/lO6c4hB4djh15D/9FJi/5GexED3/pakvdFjLJ4yF
 oxtOPB7hWcTXC10yYZaX4i7kA0M+DgnP9i3A4WJAq52Sev6yYGp9gwlsEhBJunNw7bvDxxlAW
 TanlYwW+rAwC+EkixuuRZf5pLXblWvOCdJE1KCRJyGZsJZUCR7Ww40iF6lAcyEl+Bkb79cEmS
 bqIn5SVFNFZBPysXLLUdTFsuXLJqi5UEEN8A6H7JOZME5048LNVpvN2ffPXUMmezUnMnQSAW1
 zaAo51Vp/JuIVLVOb3PYjmAG1ncd5tRGVCVyaIz9rszeNnCcv+H/nhovTsbhEqg26V2lwn/wu
 RD+Mnc7dlNUkDsMTFPTFPWylFmgSyADSVrpe2wQOEsM50ou7X54ovmqPmur8RH+MaXhpFeHkK
 3ecm77Y37kbeRn4cm+Wml/fEcLKk08lUOhdYXBjsbxIElFnWQG1Ol6gBEOCku4JNTZlcw7nbs
 r4k71kXY7k/eG3hNQQqBDAdw+bleE+ai+y3g8RFU6ydAkLfYhrfs72UKz4X141iM1+lw8oGc5
 EbVs/Iwt/pWuIdTfH1r96xQ6060m3dzGfKTemK028QMF8lyx2qBAwQEvg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a SoC information driver for Nuvoton WPCM450 SoCs. It provides
information such as the SoC revision.

Usage example:

  # grep . /sys/devices/soc0/*
  /sys/devices/soc0/family:Nuvoton NPCM
  /sys/devices/soc0/revision:A3
  /sys/devices/soc0/soc_id:WPCM450

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
=2D--
v5:
- Change Kconfig option from bool to tristate

v4:
- rebase on 5.19-rc1

v3:
- Declare revisions array as static
- Change get_revision parameter to `unsigned int`
- Add Paul's R-b tag
- Add usage example
- Sort includes

v2:
- https://lore.kernel.org/lkml/20220409173319.2491196-1-j.neuschaefer@gmx.=
net/
- Add R-b tag
- rebase on 5.18-rc1

v1:
- https://lore.kernel.org/lkml/20220129143316.2321460-1-j.neuschaefer@gmx.=
net/
=2D--
 drivers/soc/Kconfig               |   1 +
 drivers/soc/Makefile              |   1 +
 drivers/soc/nuvoton/Kconfig       |  11 +++
 drivers/soc/nuvoton/Makefile      |   2 +
 drivers/soc/nuvoton/wpcm450-soc.c | 109 ++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+)
 create mode 100644 drivers/soc/nuvoton/Kconfig
 create mode 100644 drivers/soc/nuvoton/Makefile
 create mode 100644 drivers/soc/nuvoton/wpcm450-soc.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 86ccf5970bc1b..cca3dfa5c6aea 100644
=2D-- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -14,6 +14,7 @@ source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/litex/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/microchip/Kconfig"
+source "drivers/soc/nuvoton/Kconfig"
 source "drivers/soc/pxa/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 919716e0e7001..b9eb3c75e551a 100644
=2D-- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_SOC_XWAY)		+=3D lantiq/
 obj-$(CONFIG_LITEX_SOC_CONTROLLER) +=3D litex/
 obj-y				+=3D mediatek/
 obj-y				+=3D microchip/
+obj-y				+=3D nuvoton/
 obj-y				+=3D pxa/
 obj-y				+=3D amlogic/
 obj-y				+=3D qcom/
diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
new file mode 100644
index 0000000000000..df46182088ec2
=2D-- /dev/null
+++ b/drivers/soc/nuvoton/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+menuconfig WPCM450_SOC
+	tristate "Nuvoton WPCM450 SoC driver"
+	default y if ARCH_WPCM450
+	select SOC_BUS
+	help
+	  Say Y here to compile the SoC information driver for Nuvoton
+	  WPCM450 SoCs.
+
+	  This driver provides information such as the SoC model and
+	  revision.
diff --git a/drivers/soc/nuvoton/Makefile b/drivers/soc/nuvoton/Makefile
new file mode 100644
index 0000000000000..e30317b4e8290
=2D-- /dev/null
+++ b/drivers/soc/nuvoton/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_WPCM450_SOC)	+=3D wpcm450-soc.o
diff --git a/drivers/soc/nuvoton/wpcm450-soc.c b/drivers/soc/nuvoton/wpcm4=
50-soc.c
new file mode 100644
index 0000000000000..c5e0d11c383b1
=2D-- /dev/null
+++ b/drivers/soc/nuvoton/wpcm450-soc.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Nuvoton WPCM450 SoC Identification
+ *
+ * Copyright (C) 2022 Jonathan Neusch=C3=A4fer
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define GCR_PDID	0
+#define PDID_CHIP(x)	((x) & 0x00ffffff)
+#define CHIP_WPCM450	0x926450
+#define PDID_REV(x)	((x) >> 24)
+
+struct revision {
+	u8 number;
+	const char *name;
+};
+
+static const struct revision revisions[] __initconst =3D {
+	{ 0x00, "Z1" },
+	{ 0x03, "Z2" },
+	{ 0x04, "Z21" },
+	{ 0x08, "A1" },
+	{ 0x09, "A2" },
+	{ 0x0a, "A3" },
+	{}
+};
+
+static const char * __init get_revision(unsigned int rev)
+{
+	int i;
+
+	for (i =3D 0; revisions[i].name; i++)
+		if (revisions[i].number =3D=3D rev)
+			return revisions[i].name;
+	return NULL;
+}
+
+static struct soc_device_attribute *wpcm450_attr;
+static struct soc_device *wpcm450_soc;
+
+static int __init wpcm450_soc_init(void)
+{
+	struct soc_device_attribute *attr;
+	struct soc_device *soc;
+	const char *revision;
+	struct regmap *gcr;
+	u32 pdid;
+	int ret;
+
+	if (!of_machine_is_compatible("nuvoton,wpcm450"))
+		return 0;
+
+	gcr =3D syscon_regmap_lookup_by_compatible("nuvoton,wpcm450-gcr");
+	if (IS_ERR(gcr))
+		return PTR_ERR(gcr);
+	ret =3D regmap_read(gcr, GCR_PDID, &pdid);
+	if (ret)
+		return ret;
+
+	if (PDID_CHIP(pdid) !=3D CHIP_WPCM450) {
+		pr_warn("Unknown chip ID in GCR.PDID: 0x%06x\n", PDID_CHIP(pdid));
+		return -ENODEV;
+	}
+
+	revision =3D get_revision(PDID_REV(pdid));
+	if (!revision) {
+		pr_warn("Unknown chip revision in GCR.PDID: 0x%02x\n", PDID_REV(pdid));
+		return -ENODEV;
+	}
+
+	attr =3D kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	attr->family =3D "Nuvoton NPCM";
+	attr->soc_id =3D "WPCM450";
+	attr->revision =3D revision;
+	soc =3D soc_device_register(attr);
+	if (IS_ERR(soc)) {
+		kfree(attr);
+		pr_warn("Could not register SoC device\n");
+		return PTR_ERR(soc);
+	}
+
+	wpcm450_soc =3D soc;
+	wpcm450_attr =3D attr;
+	return 0;
+}
+module_init(wpcm450_soc_init);
+
+static void __exit wpcm450_soc_exit(void)
+{
+	if (wpcm450_soc) {
+		soc_device_unregister(wpcm450_soc);
+		wpcm450_soc =3D NULL;
+		kfree(wpcm450_attr);
+	}
+}
+module_exit(wpcm450_soc_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jonathan Neusch=C3=A4fer");
+MODULE_DESCRIPTION("Nuvoton WPCM450 SoC Identification driver");
=2D-
2.35.1

