Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DF7496047
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380907AbiAUOCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:02:23 -0500
Received: from mxout70.expurgate.net ([194.37.255.70]:54725 "EHLO
        mxout70.expurgate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380888AbiAUOCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:02:06 -0500
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1nAuUG-0007fz-J8; Fri, 21 Jan 2022 15:01:56 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1nAuUF-0001nb-Ow; Fri, 21 Jan 2022 15:01:55 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 609A224004B;
        Fri, 21 Jan 2022 15:01:55 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id D4E73240040;
        Fri, 21 Jan 2022 15:01:54 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id B98FA247F9;
        Fri, 21 Jan 2022 15:01:53 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     pavel@ucw.cz, robh+dt@kernel.org, andy.shevchenko@gmail.com
Cc:     Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] leds: ktd20xx: Extension of the KTD20xx family of LED drivers from Kinetic
Date:   Fri, 21 Jan 2022 15:01:49 +0100
Message-ID: <20220121140150.1729-2-fe@dev.tdt.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121140150.1729-1-fe@dev.tdt.de>
References: <20220121140150.1729-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,URIBL_BLOCKED,
        URIBL_DBL_BLOCKED_OPENDNS,URIBL_ZEN_BLOCKED_OPENDNS autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1642773716-000044EC-66783DF6/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing the KTD2061/58/59/60 RGB LED drivers. The difference in
these are the address numbers on the I2C bus that the device listens to.

All KT20xx units can drive up to 12 LEDs.

Due to the hardware limitation, we can only set 7 colors and the color
black (LED off) for each LED independently and not the full RGB range.
This is because the chip only has two color registers.

To control the LEDs independently, the chip has to be configured in a
special way.

Color register 0 must be loaded with the current value 0mA, and color
register 1 must be loaded with the value 'kinetic,led-current' from the
device tree node. If the property is omitted, the register is loaded
with the default value (0x28 =3D 5mA).

To select a color for an LED, a combination must be written to the color
selection register of that LED. This range for selecting the value is 3
bits wide (RGB). A '0' in any of the bits uses color register '0' and a
'1' uses color register '1'.

So we could choose the following combination for each LED:
R G B
0 0 0 =3D Black (off)
0 0 1 =3D Blue
0 1 0 =3D green
0 1 1 =3D Cyan
1 0 0 =3D Red
1 0 1 =3D Magenta
1 1 0 =3D Yellow
1 1 1 =3D White

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 MAINTAINERS                 |   6 +
 drivers/leds/Kconfig        |  12 +
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-ktd20xx.c | 582 ++++++++++++++++++++++++++++++++++++
 4 files changed, 601 insertions(+)
 create mode 100644 drivers/leds/leds-ktd20xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a58544f7b699..04d68985d348 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10739,6 +10739,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd253.yaml
 F:	drivers/video/backlight/ktd253-backlight.c
=20
+KTD20XX LED CONTROLLER DRIVER
+M:	Florian Eckert <fe@dev.tdt.de>
+L:	linux-leds@vger.kernel.org
+S:	Maintained
+F:	drivers/leds/leds-ktd20xx.c
+
 KTEST
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	John Hawley <warthog9@eaglescrag.net>
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6090e647daee..a96e6bf7918b 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -157,6 +157,18 @@ config LEDS_EL15203000
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-el15203000.
=20
+config LEDS_KTD20XX
+	tristate "LED Support for KTD2061/58/59/60 LED driver chip"
+	depends on LEDS_CLASS && I2C
+	depends on LEDS_CLASS_MULTICOLOR
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the Kinetic
+	  KTD2061, KTD2058, KTD2059 and KTD2060 LED driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called leds-ktd20xx.
+
 config LEDS_TURRIS_OMNIA
 	tristate "LED support for CZ.NIC's Turris Omnia"
 	depends on LEDS_CLASS_MULTICOLOR
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index e58ecb36360f..5a86e72ea722 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_LEDS_IP30)			+=3D leds-ip30.o
 obj-$(CONFIG_LEDS_IPAQ_MICRO)		+=3D leds-ipaq-micro.o
 obj-$(CONFIG_LEDS_IS31FL319X)		+=3D leds-is31fl319x.o
 obj-$(CONFIG_LEDS_IS31FL32XX)		+=3D leds-is31fl32xx.o
+obj-${CONFIG_LEDS_KTD20XX}		+=3D leds-ktd20xx.o
 obj-$(CONFIG_LEDS_LM3530)		+=3D leds-lm3530.o
 obj-$(CONFIG_LEDS_LM3532)		+=3D leds-lm3532.o
 obj-$(CONFIG_LEDS_LM3533)		+=3D leds-lm3533.o
diff --git a/drivers/leds/leds-ktd20xx.c b/drivers/leds/leds-ktd20xx.c
new file mode 100644
index 000000000000..7e2a1a603b50
--- /dev/null
+++ b/drivers/leds/leds-ktd20xx.c
@@ -0,0 +1,582 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  LEDs driver for the Kinetic KDT20xx device
+ *
+ *  Copyright (C) 2021 TDT AG Florian Eckert <fe@dev.tdt.de>
+ *
+ */
+
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/leds.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+/* I2C Register Map */
+#define KTD20XX_ID		0x00
+#define KTD20XX_MONITOR		0x01
+#define KTD20XX_CONTROL		0x02
+
+/* Color0 Configuration Registers */
+#define KTD20XX_IRED0		0x03
+#define KTD20XX_IGRN0		0x04
+#define KTD20XX_IBLU0		0x05
+
+/* Color1 Configuration Registers */
+#define KTD20XX_IRED1		0x06
+#define KTD20XX_IGRN1		0x07
+#define KTD20XX_IBLU1		0x08
+
+/* Selection Configuration Register */
+#define KTD20XX_ISELA12		0x09
+#define KTD20XX_ISELA34		0x0A
+#define KTD20XX_ISELB12		0x0B
+#define KTD20XX_ISELB34		0x0C
+#define KTD20XX_ISELC12		0x0D
+#define KTD20XX_ISELC34		0x0E
+
+#define KTD20XX_MAX_LEDS	12
+#define KTD20XX_LED_CHANNELS	3
+
+enum ktd20xx_led_number {
+	/* ISELA12 */
+	RGB_A1,
+	RGB_A2,
+	/* ISELA34 */
+	RGB_A3,
+	RGB_A4,
+	/* ISELB12 */
+	RGB_B1,
+	RGB_B2,
+	/* ISELB34 */
+	RGB_B3,
+	RGB_B4,
+	/* ISELC12 */
+	RGB_C1,
+	RGB_C2,
+	/* ISELC34 */
+	RGB_C3,
+	RGB_C4,
+};
+
+enum ktd20xx_control_mode {
+	CONTROL_MODE_OFF,
+	CONTROL_MODE_NIGHT,
+	CONTROL_MODE_NORMAL,
+	CONTROL_MODE_RESET,
+};
+
+static const struct reg_default ktd20xx_reg_defs[] =3D {
+	/* Color0 Configuration Registers */
+	{KTD20XX_IRED0, 0x28},
+	{KTD20XX_IGRN0, 0x28},
+	{KTD20XX_IBLU0, 0x28},
+	/* Color1 Configuration Registers */
+	{KTD20XX_IRED1, 0x60},
+	{KTD20XX_IGRN1, 0x60},
+	{KTD20XX_IBLU1, 0x60},
+	/* Selection Configuration Register */
+	{KTD20XX_ISELA12, 0x00},
+	{KTD20XX_ISELA34, 0x00},
+	{KTD20XX_ISELB12, 0x00},
+	{KTD20XX_ISELB34, 0x00},
+	{KTD20XX_ISELC12, 0x00},
+	{KTD20XX_ISELC34, 0x00}
+};
+
+/* Chip values */
+static const struct reg_field kt20xx_control_mode =3D REG_FIELD(KTD20XX_=
CONTROL, 6, 7);
+static const struct reg_field kt20xx_faderate =3D REG_FIELD(KTD20XX_CONT=
ROL, 0, 2);
+static const struct reg_field kt20xx_vendor =3D REG_FIELD(KTD20XX_ID, 5,=
 7);
+static const struct reg_field kt20xx_chip_id =3D REG_FIELD(KTD20XX_ID, 0=
, 4);
+static const struct reg_field kt20xx_chip_rev =3D REG_FIELD(KTD20XX_MONI=
TOR, 4, 7);
+
+/* ISELA1 and ISELA2 */
+static const struct reg_field kt20xx_a1_select =3D REG_FIELD(KTD20XX_ISE=
LA12, 4, 6);
+static const struct reg_field kt20xx_a1_enable =3D REG_FIELD(KTD20XX_ISE=
LA12, 7, 7);
+static const struct reg_field kt20xx_a2_select =3D REG_FIELD(KTD20XX_ISE=
LA12, 0, 2);
+static const struct reg_field kt20xx_a2_enable =3D REG_FIELD(KTD20XX_ISE=
LA12, 3, 3);
+
+/* ISELA3 and ISELA4 */
+static const struct reg_field kt20xx_a3_select =3D REG_FIELD(KTD20XX_ISE=
LA34, 4, 6);
+static const struct reg_field kt20xx_a3_enable =3D REG_FIELD(KTD20XX_ISE=
LA34, 7, 7);
+static const struct reg_field kt20xx_a4_select =3D REG_FIELD(KTD20XX_ISE=
LA34, 0, 2);
+static const struct reg_field kt20xx_a4_enable =3D REG_FIELD(KTD20XX_ISE=
LA34, 3, 3);
+
+/* ISELB1 and ISELB2 */
+static const struct reg_field kt20xx_b1_select =3D REG_FIELD(KTD20XX_ISE=
LB12, 4, 6);
+static const struct reg_field kt20xx_b1_enable =3D REG_FIELD(KTD20XX_ISE=
LB12, 7, 7);
+static const struct reg_field kt20xx_b2_select =3D REG_FIELD(KTD20XX_ISE=
LB12, 0, 2);
+static const struct reg_field kt20xx_b2_enable =3D REG_FIELD(KTD20XX_ISE=
LB12, 3, 3);
+
+/* ISELB3 and ISELB4 */
+static const struct reg_field kt20xx_b3_select =3D REG_FIELD(KTD20XX_ISE=
LB34, 4, 6);
+static const struct reg_field kt20xx_b3_enable =3D REG_FIELD(KTD20XX_ISE=
LB34, 7, 7);
+static const struct reg_field kt20xx_b4_select =3D REG_FIELD(KTD20XX_ISE=
LB34, 0, 2);
+static const struct reg_field kt20xx_b4_enable =3D REG_FIELD(KTD20XX_ISE=
LB34, 3, 3);
+
+/* ISELC1 and ISELC2 */
+static const struct reg_field kt20xx_c1_select =3D REG_FIELD(KTD20XX_ISE=
LC12, 4, 6);
+static const struct reg_field kt20xx_c1_enable =3D REG_FIELD(KTD20XX_ISE=
LC12, 7, 7);
+static const struct reg_field kt20xx_c2_select =3D REG_FIELD(KTD20XX_ISE=
LC12, 0, 2);
+static const struct reg_field kt20xx_c2_enable =3D REG_FIELD(KTD20XX_ISE=
LC12, 3, 3);
+
+/* ISELC3 and ISELC4 */
+static const struct reg_field kt20xx_c3_select =3D REG_FIELD(KTD20XX_ISE=
LC34, 4, 6);
+static const struct reg_field kt20xx_c3_enable =3D REG_FIELD(KTD20XX_ISE=
LC34, 7, 7);
+static const struct reg_field kt20xx_c4_select =3D REG_FIELD(KTD20XX_ISE=
LC34, 0, 2);
+static const struct reg_field kt20xx_c4_enable =3D REG_FIELD(KTD20XX_ISE=
LC34, 3, 3);
+
+static const struct regmap_range ktd20xx_volatile_ranges =3D {
+	.range_min =3D KTD20XX_ID,
+	.range_max =3D KTD20XX_CONTROL,
+};
+
+static const struct regmap_access_table ktd20xx_volatile_table =3D {
+	.yes_ranges =3D &ktd20xx_volatile_ranges,
+	.n_yes_ranges =3D 1,
+};
+
+static const struct regmap_range ktd20xx_readable_ranges =3D {
+	.range_min =3D KTD20XX_ID,
+	.range_max =3D KTD20XX_MONITOR,
+};
+
+static const struct regmap_access_table ktd20xx_readable_table =3D {
+	.yes_ranges =3D &ktd20xx_readable_ranges,
+	.n_yes_ranges =3D 1,
+};
+
+static const struct regmap_config ktd20xx_regmap_config =3D {
+	.name =3D "ktd20xx_regmap",
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+
+	.max_register =3D KTD20XX_ISELC34,
+
+	.volatile_table =3D &ktd20xx_volatile_table,
+	.rd_table =3D &ktd20xx_readable_table,
+
+	.reg_defaults =3D ktd20xx_reg_defs,
+	.num_reg_defaults =3D ARRAY_SIZE(ktd20xx_reg_defs),
+	.cache_type =3D REGCACHE_FLAT,
+};
+
+struct ktd20xx_led {
+	struct led_classdev_mc mc_cdev;
+	struct mc_subled subled_info[KTD20XX_LED_CHANNELS];
+	int index;
+	struct regmap_field *enable;
+	struct regmap_field *select;
+	struct ktd20xx *chip;
+};
+
+struct ktd20xx {
+	struct mutex lock;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct regmap_field *control_mode;
+	struct regmap_field *faderate;
+	struct regmap_field *vendor;
+	struct regmap_field *chip_id;
+	struct regmap_field *chip_rev;
+	struct ktd20xx_led leds[KTD20XX_MAX_LEDS];
+};
+
+static int ktd20xx_hwinit(struct ktd20xx *chip)
+{
+	struct device *dev =3D &chip->client->dev;
+	int ret;
+	unsigned int value;
+
+	/*
+	 * If the device tree property 'kinetc,led-current' is found
+	 * then set this value into the color0 register as the max current
+	 * for all color channel LEDs. If this poperty is not set then
+	 * use the default value 0x28 set by the chip after a hardware reset.
+	 * The hardware default value 0x28 corresponds to 5mA.
+	 */
+	/* Set color1 register current value to 0x00 and therefor 0mA */
+	regmap_write(chip->regmap, KTD20XX_IRED1, 0);
+	regmap_write(chip->regmap, KTD20XX_IGRN1, 0);
+	regmap_write(chip->regmap, KTD20XX_IBLU1, 0);
+
+	ret =3D device_property_read_u32(dev, "kinetic,led-current", &value);
+	if (ret) {
+		dev_warn(dev, "property 'kinetic,led-current' not found. Using default=
 hardware value 0x28 (5mA).\n");
+	} else {
+		dev_dbg(dev, "property 'kinetic,led-current' found. Using value 0x%02x=
.\n",
+				value);
+		regmap_write(chip->regmap, KTD20XX_IRED0, value);
+		regmap_write(chip->regmap, KTD20XX_IGRN0, value);
+		regmap_write(chip->regmap, KTD20XX_IBLU0, value);
+	}
+
+	/* Enable chip to run in 'normal mode' */
+	regmap_field_write(chip->control_mode, CONTROL_MODE_NORMAL);
+
+	return 0;
+}
+
+static struct ktd20xx_led *mcled_cdev_to_led(struct led_classdev_mc *mc_=
cdev)
+{
+	return container_of(mc_cdev, struct ktd20xx_led, mc_cdev);
+}
+
+static int ktd20xx_brightness_set(struct led_classdev *cdev,
+		enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_dev =3D lcdev_to_mccdev(cdev);
+	struct ktd20xx_led *led =3D mcled_cdev_to_led(mc_dev);
+	struct device *dev =3D &led->chip->client->dev;
+	int ret;
+	int i;
+	unsigned long rgb =3D 0;
+
+	mutex_lock(&led->chip->lock);
+	ret =3D regmap_field_write(led->enable, brightness ? 1 : 0);
+	if (ret) {
+		dev_err(dev, "Cannot set enable flag of LED %d error: %d\n",
+				led->index, ret);
+		goto unlock_out;
+	}
+
+	for (i =3D 0; i < led->mc_cdev.num_colors; i++) {
+		unsigned int intensity =3D mc_dev->subled_info[i].intensity;
+		unsigned int channel =3D mc_dev->subled_info[i].channel;
+
+		if (intensity > 0)
+			set_bit(channel, &rgb);
+	}
+
+	/*
+	 * To use the color0 registers default value after an hadware reset,
+	 * if the device tree property 'kinetc,led-current' is not set,
+	 * we have to 'invert' the rgb channel!
+	 */
+	ret =3D regmap_field_write(led->select, ~rgb);
+	if (ret) {
+		dev_err(dev, "Can not set RGB for LED %d error: %d\n",
+				led->index, ret);
+		goto unlock_out;
+	}
+
+unlock_out:
+	mutex_unlock(&led->chip->lock);
+	return ret;
+}
+
+static int ktd20xx_probe_dt(struct ktd20xx *chip)
+{
+	struct fwnode_handle *child =3D NULL;
+	struct led_init_data init_data =3D {};
+	struct led_classdev *led_cdev;
+	struct ktd20xx_led *led;
+	struct device *dev =3D &chip->client->dev;
+	int color;
+	int ret;
+	int i =3D 0;
+
+	device_for_each_child_node(dev, child) {
+		led =3D &chip->leds[i];
+
+		ret =3D fwnode_property_read_u32(child, "reg", &led->index);
+		if (ret) {
+			dev_err(dev, "missing property 'reg'\n");
+			goto child_out;
+		}
+		if (led->index >=3D KTD20XX_MAX_LEDS) {
+			dev_warn(dev, "property 'reg' is greater then '%i'\n",
+					KTD20XX_MAX_LEDS);
+			ret =3D -EINVAL;
+			goto child_out;
+		}
+
+		ret =3D fwnode_property_read_u32(child, "color", &color);
+		if (ret) {
+			dev_err(dev, "missing property 'color'\n");
+			goto child_out;
+		}
+		if (color !=3D LED_COLOR_ID_MULTI) {
+			dev_warn(dev, "property 'color' is not equal to the value 'LED_COLOR_=
ID_MULTI'\n");
+			ret =3D -EINVAL;
+			goto child_out;
+		}
+
+		led->subled_info[0].color_index =3D LED_COLOR_ID_RED;
+		led->subled_info[0].channel =3D 2;
+		led->subled_info[0].intensity =3D 1;
+		led->subled_info[1].color_index =3D LED_COLOR_ID_GREEN;
+		led->subled_info[1].channel =3D 1;
+		led->subled_info[1].intensity =3D 1;
+		led->subled_info[2].color_index =3D LED_COLOR_ID_BLUE;
+		led->subled_info[2].channel =3D 0;
+		led->subled_info[2].intensity =3D 1;
+
+		led->mc_cdev.subled_info =3D led->subled_info;
+		led->mc_cdev.num_colors =3D KTD20XX_LED_CHANNELS;
+
+		init_data.fwnode =3D child;
+
+		led->chip =3D chip;
+		led_cdev =3D &led->mc_cdev.led_cdev;
+		led_cdev->brightness_set_blocking =3D ktd20xx_brightness_set;
+
+		switch (led->index) {
+		case RGB_A1:
+			led->select =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_a1_select);
+			led->enable =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_a1_enable);
+			break;
+		case RGB_A2:
+			led->select =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_a2_select);
+			led->enable =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_a2_enable);
+			break;
+		case RGB_A3:
+			led->select =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_a3_select);
+			led->enable =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_a3_enable);
+			break;
+		case RGB_A4:
+			led->select =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_a4_select);
+			led->enable =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_a4_enable);
+			break;
+		case RGB_B1:
+			led->select =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_b1_select);
+			led->enable =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_b1_enable);
+			break;
+		case RGB_B2:
+			led->select =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_b2_select);
+			led->enable =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_b2_enable);
+			break;
+		case RGB_B3:
+			led->select =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_b3_select);
+			led->enable =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_b3_enable);
+			break;
+		case RGB_B4:
+			led->select =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_b4_select);
+			led->enable =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_b4_enable);
+			break;
+		case RGB_C1:
+			led->select =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_c1_select);
+			led->enable =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_c1_enable);
+			break;
+		case RGB_C2:
+			led->select =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_c2_select);
+			led->enable =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_c2_enable);
+			break;
+		case RGB_C3:
+			led->select =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_c3_select);
+			led->enable =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_c3_enable);
+			break;
+		case RGB_C4:
+			led->select =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_c4_select);
+			led->enable =3D devm_regmap_field_alloc(dev,
+					chip->regmap, kt20xx_c4_enable);
+			break;
+		}
+
+		ret =3D devm_led_classdev_multicolor_register_ext(dev,
+			&led->mc_cdev,
+			&init_data);
+
+		if (ret) {
+			dev_err(dev, "led register err: %d\n", ret);
+			goto child_out;
+		}
+
+		i++;
+	}
+
+	return 0;
+
+child_out:
+	fwnode_handle_put(child);
+	return ret;
+}
+
+/*
+ * The chip also offers the option "Night Mode".
+ * All LED current settings are divided by 16 for a 0 to 1.5mA current
+ * setting range.
+ */
+static ssize_t nightmode_show(struct device *dev, struct device_attribut=
e *a,
+		char *buf)
+{
+	struct ktd20xx *chip =3D dev_get_drvdata(dev);
+	unsigned int value;
+
+	mutex_lock(&chip->lock);
+	regmap_field_read(chip->control_mode, &value);
+	mutex_unlock(&chip->lock);
+
+	return sysfs_emit(buf, "%d\n", value =3D=3D CONTROL_MODE_NIGHT ? 1 : 0)=
;
+}
+
+static ssize_t nightmode_store(struct device *dev, struct device_attribu=
te *a,
+		const char *buf, size_t count)
+{
+	struct ktd20xx *chip =3D dev_get_drvdata(dev);
+	bool value;
+	int ret;
+
+	ret =3D kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+
+	mutex_lock(&chip->lock);
+	ret =3D regmap_field_write(chip->control_mode,
+			value =3D=3D 1 ? CONTROL_MODE_NIGHT : CONTROL_MODE_NORMAL);
+	mutex_unlock(&chip->lock);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(nightmode);
+
+static struct attribute *ktd20xx_led_controller_attrs[] =3D {
+	&dev_attr_nightmode.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(ktd20xx_led_controller);
+
+static int ktd20xx_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct ktd20xx *chip;
+	unsigned int vendor;
+	unsigned int chip_id;
+	unsigned int chip_rev;
+	struct device *dev;
+	int ret;
+
+	chip =3D devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	mutex_init(&chip->lock);
+	chip->client =3D client;
+	dev =3D &client->dev;
+	i2c_set_clientdata(client, chip);
+
+	chip->regmap =3D devm_regmap_init_i2c(client, &ktd20xx_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		dev_err_probe(dev, PTR_ERR(chip->regmap),
+			"Failed to allocate register map\n");
+		goto error;
+	}
+
+	chip->control_mode =3D devm_regmap_field_alloc(dev, chip->regmap,
+			kt20xx_control_mode);
+	chip->faderate =3D devm_regmap_field_alloc(dev, chip->regmap,
+			kt20xx_faderate);
+	chip->vendor =3D devm_regmap_field_alloc(dev, chip->regmap,
+			kt20xx_vendor);
+	chip->chip_id =3D devm_regmap_field_alloc(dev, chip->regmap,
+			kt20xx_chip_id);
+	chip->chip_rev =3D devm_regmap_field_alloc(dev, chip->regmap,
+			kt20xx_chip_rev);
+
+	/* Reset all registers to hardware device default settings */
+	regmap_field_write(chip->control_mode, CONTROL_MODE_RESET);
+
+	ret =3D regmap_field_read(chip->vendor, &vendor);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to read vendor\n");
+		goto error;
+	}
+
+	ret =3D regmap_field_read(chip->chip_id, &chip_id);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to read chip id\n");
+		goto error;
+	}
+
+	ret =3D regmap_field_read(chip->chip_rev, &chip_rev);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to read chip rev\n");
+		goto error;
+	}
+
+	dev_info(dev, "vendor: 0x%02x chip-id: 0x%02x chip-rev: 0x%02x\n",
+			vendor, chip_id, chip_rev);
+
+	ret =3D ktd20xx_probe_dt(chip);
+	if (ret)
+		goto error;
+
+	ret =3D ktd20xx_hwinit(chip);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	return ret;
+}
+
+static int ktd20xx_remove(struct i2c_client *client)
+{
+	struct ktd20xx *chip =3D i2c_get_clientdata(client);
+
+	mutex_lock(&chip->lock);
+	regmap_field_write(chip->control_mode, CONTROL_MODE_OFF);
+	mutex_unlock(&chip->lock);
+
+	return 0;
+}
+
+static const struct i2c_device_id ktd20xx_id[] =3D {
+	{ "ktd20xx", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ktd20xx_id);
+
+static const struct of_device_id of_ktd20xx_leds_match[] =3D {
+	{ .compatible =3D "kinetic,ktd20xx", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_ktd20xx_leds_match);
+
+static struct i2c_driver ktd20xx_driver =3D {
+	.driver =3D {
+		.name =3D "ktd20xx",
+		.dev_groups =3D ktd20xx_led_controller_groups,
+		.of_match_table =3D of_ktd20xx_leds_match,
+	},
+	.probe =3D ktd20xx_probe,
+	.remove =3D ktd20xx_remove,
+	.id_table =3D ktd20xx_id
+};
+module_i2c_driver(ktd20xx_driver);
+
+MODULE_DESCRIPTION("Kinetic KTD20xx LED driver");
+MODULE_AUTHOR("Florian Eckert <fe@dev.tdt.de>");
+MODULE_LICENSE("GPL v2");
--=20
2.20.1

