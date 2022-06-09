Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F66545687
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbiFIVhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiFIVhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:37:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1C2259108
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654810619;
        bh=NpBRpslxD/++bY7KsbgPKfFFfolooC7jGPZWYMDF/eM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=BLZmWH7oG2NjfId4cC/AwAZz6JF7woeyNFj9NLyeedoTLU7zPzoFGF6UH682IyhSU
         YkO/IGMOXtVahPOhJ0fNIWmH7VEGn08h+UeeuNDn4Y6hO6ydurk0ZSJX39wRkgYhcJ
         76kC6F5j3M7wfUaz1fZpI/MBBiKofC7LlDLDGRl4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([81.173.137.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGRK-1oHUNx0H02-00JMmv; Thu, 09
 Jun 2022 23:36:59 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Lubomir Rintel <lkundrak@v3.sk>, Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Hector Martin <marcan@marcan.st>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sven Peter <sven@svenpeter.dev>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] soc: nuvoton: Add SoC info driver for WPCM450
Date:   Thu,  9 Jun 2022 23:35:01 +0200
Message-Id: <20220609213513.88479-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1tW3Qj8Ii69QDiEgMU2agz0S47qZnx4X/LkVCg2x9J7IKNOe5f9
 o8X1tyqxGPLP1tWvA6aFdQ+tm8HJUM0Z6MPkvyepPi4pUlgnmFyobDHjWZ4nF6K+TRe1bin
 xAb5UTRp7E/EMMg0KBsmZhvE1yaMbgEQLmhHo4AYBO0t32UhBSHwoWThKOUgvwvW1qmOGtn
 RCG4Nzv38oa/MLVKaM9hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pkl1pUBg0dM=:CNJLPQpw+KPeoEwCyunPB6
 03YewKrH8sv+t5M6mXzQBet44HWk5HE/Mo2tQGDZEV/xd59Mxfz95i37P8JgCXxQLja6wNPdp
 pFYD20LUzIcftQ12WmBddhKQAO21cLAwxditJ/tEMH4Jl+sUn0Z28JISrTaDaIdrTW1lvnfPn
 s0yIR/KSOQr6na0rQp9nm/i0EGUZnv832y9VWPvkmE3CYZjJ1jiXgpBNZ9Vz3B1pBMXGUSeK7
 DOrT1aKSb/TMDLbI9+Y5DoyeoBWKlWQr+EEc3E2/6cEGacnEyxvAMISdl1YCyGk2D2rsAedte
 X3oEZ4F/HKxlbXcp+JfsDDkAM9MxF5gIhEyNdkazC36v6dgzrH3oU3enHFPir3fGD/GCWWGGi
 t5L848k/RHl+GplUzxfJXR0i/kpP405vf/AiCSgjWroMGPK8R3xHfAwbwseYNwf2fJ8R1jUb9
 gYISMx6OUmWZVSDY/fFilxSsnCPfKsIaovay7qsF/P204J8ZiXQ9z1+GGsY74/dKJrty6dQV5
 tUMmdU+ljHuT/ExgeEI/JnpOosmayb9QWVskwGsfZOdfsVFzq4ic4Ek252HXYMtieKq7Fyaye
 ez8gh9k//LOM/QW+We2nfeNK6MNpRABuymLRaA+7a6wy5hI7vcewjnYkfNkjYh1nhLJQ0pwnA
 e/TR46l3BklVXGFZaUomlZLPpIkv87JViIbHzga8Etjtf1gCRgsaho80hwI6snzn39OtQvGyJ
 kCOr9NLohL5xpiQ3Or9MrVRxLSchqHClb6LNUmudMElYIDplXc1c3lBQ0OhN3gxY5P62VOlDr
 RebnWzToXYDI5NKk2p6g68K+ViZYZUDcuJ2pkBuW6C2TeANlZibL4OEtNCxH8X2nWBlsrgjem
 h8fAy5Ki2bsG2Gugdc2GWmf+MBzZOG9nz1u+ujhI4AAo8XkuGY5nfDzuPBzZGFM57ucllGmOW
 1PhgQ+2KkeWWMW00rqG/H9tBR/12X7T+emh+ZN1kl15yWbZTcZhV98u4kAX0c9XPF4WhyRU5x
 s8ZpRDSj4cCezdml0cSCg+52UzfoM/PRFhLoFxvBZM+dSSZ4/gUE+ZrQFEPJWnkmxKsL1Q+U2
 K0+BHsahkmIIEE1Gf+DldIubuFSmACaTWjKfjJLp8xiRuFIhSKDULMDvw==
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
 drivers/soc/Kconfig               |  1 +
 drivers/soc/Makefile              |  1 +
 drivers/soc/nuvoton/Kconfig       | 11 ++++
 drivers/soc/nuvoton/Makefile      |  2 +
 drivers/soc/nuvoton/wpcm450-soc.c | 90 +++++++++++++++++++++++++++++++
 5 files changed, 105 insertions(+)
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
index 0000000000000..50166f37096b7
=2D-- /dev/null
+++ b/drivers/soc/nuvoton/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+menuconfig WPCM450_SOC
+	bool "Nuvoton WPCM450 SoC driver"
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
index 0000000000000..9ff876ea71361
=2D-- /dev/null
+++ b/drivers/soc/nuvoton/wpcm450-soc.c
@@ -0,0 +1,90 @@
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
+	return 0;
+}
+device_initcall(wpcm450_soc_init);
=2D-
2.35.1

