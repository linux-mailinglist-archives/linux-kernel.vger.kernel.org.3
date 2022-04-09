Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3714FA9F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbiDIRgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbiDIRgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:36:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A085664
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649525624;
        bh=+GAhbPxfW2Aqj/rt34ikPXdWtTV7OOaFom8Nfhzgoyk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=cZ0qM2fkhqlxFrTaWR8JONXMKHXoOwusfnWuTU86fMw4FbTHD6roJ1F/qyMGSHQvt
         RMVl/ESbu/tRdrcmbHzIRFx4RPCMHwsVf+mic5mtYY4RFvvtHOccas3szbd2n5zg76
         6IVRl95cK8TLrB+3Yyy9vdWNERfzA5eoJl2yk3bc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([78.35.207.192]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNpH-1oOAh32mKb-00ll5P; Sat, 09
 Apr 2022 19:33:44 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc: nuvoton: Add SoC info driver for WPCM450
Date:   Sat,  9 Apr 2022 19:33:11 +0200
Message-Id: <20220409173319.2491196-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Stl/Z8Ym+Qu+nNhKiC6mlRhOFmcxDG/eLHNcDsHGXOPdQUo5eOF
 M5LLIjkpUyk19lyoE46jOn4rNx3W8PqLz/yY8wVSGIoaDIF3mWfNiTCZi9IFoxhan8TTyoi
 qvr1u2zKOyN/vL9yAW3Es+r4fZ4zm+FhcF9qQPfBO4IeakYIa1JEmOxWeWFTfeppe4gBDD/
 H+aWzstAJ7WujA1RX9Juw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fk1wO4UE7sc=:+kVJM4EGswCLlDFJRozLAP
 mU7Urkc5/dM43l46/JnVSBDNMVAx44bUEw7NbBu3/N4PmPn3X2eVUPcIcFIIcldBD1nz3KuJ+
 WFCyemS7c03hXUbppv9beZ47CHPA7WtOuo/2nJj0G/ahvlDRo46VZdI50zmrDUfMpbcts0xRr
 dGync+OaH6WiUl39lUTYRCmT+5mPPgtGocpmhfX0NpOAsATn5S2YRUzEW8tcvqxQr5yazz9WJ
 TnWRcgo9ykVyHbmGoJpzJ7+uO8q2vWohsK+AoYLhfL5n6NxxKJf77IJDy4u6ViWgR89np2UYR
 qSHm6+w+y0CxhTHhMcipxAi116xitvJvoV2spZA3ui8KS/00h63JFg8fA/8NuD1oH1ji2rlPr
 nkaRR2I4MjEFf8yTaCKjxVsKoT/dWkihZIP+7hmWLpHYYleao1E4VjRQADnn3vwt9Qt+Q/klB
 oo/Yy47qxnjICeZw3t58SeyVNc1RMHNb0lWZrboAxA5xoCgICETcFP6eJ6df0FKsxBJ+UQtkb
 JFV20T6TDkuVYnTqBok7WSy1w+r3qqaJ42Q6iTeBiDAa2+F6orfy4pmqJyxue+XB1p4BInotO
 yatz1FNuVAU72Srt77ZFfAXBNrEkVauC5SIyZho/XePOyNXLMomy21saErv1YDrum00sO1fai
 0e108Dz0WSIk3i1wQHdCfGauzcMDoV2k5Vyiy3YgozM47X2RUoQfR85msUgRVzq/bUihDKfNK
 qnqks57H3Pg/weRd7Z6aT8aYssq25BkBL9lXScpZgz1EEXnlD+1+YsBq9DIRNbvqQRYVF9ZKD
 dg5Yb+tGtAAwwmNq3+yS5P3ssoyoKyGS2/ZjUpKq6jxptW+vKhu9ihRY276TteNSOMyaxGFhV
 1ig43P6Nt+jn19xSW12viwXKBfAo1cTmfS7hsX6maUgPgCXzGYiT2TeiAhE1ajIEqPSZX7RG0
 fkKhd6p2AkG9AE5FavBuX6F4LeFWHvz/Sd7bYwfNIl9QcmdP0ZL5OBOfVbmmtemRhPJTYrpdf
 AqxsDbywGLzzkXG57WPjwyDojf4NowcKA/OvP+UwLtVcENY0lfXBr2slPqwMqtLKRAi9XB9Hx
 4zWwuz1c1xOO7Y=
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

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Joel Stanley <joel@jms.id.au>
=2D--

v2:
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
index c5aae42673d3b..42a5e0be77f3d 100644
=2D-- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -14,6 +14,7 @@ source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/litex/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/microchip/Kconfig"
+source "drivers/soc/nuvoton/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 904eec2a78713..3239fc49eeb27 100644
=2D-- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_SOC_XWAY)		+=3D lantiq/
 obj-$(CONFIG_LITEX_SOC_CONTROLLER) +=3D litex/
 obj-y				+=3D mediatek/
 obj-y				+=3D microchip/
+obj-y				+=3D nuvoton/
 obj-y				+=3D amlogic/
 obj-y				+=3D qcom/
 obj-y				+=3D renesas/
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
index 0000000000000..8bad63e1f7a80
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
+#include <linux/sys_soc.h>
+#include <linux/slab.h>
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
+const struct revision revisions[] __initconst =3D {
+	{ 0x00, "Z1" },
+	{ 0x03, "Z2" },
+	{ 0x04, "Z21" },
+	{ 0x08, "A1" },
+	{ 0x09, "A2" },
+	{ 0x0a, "A3" },
+	{}
+};
+
+static const char * __init get_revision(u8 rev)
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

