Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1E50729B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354317AbiDSQIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354338AbiDSQHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:07:30 -0400
X-Greylist: delayed 1076 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 09:04:36 PDT
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603D32FE57;
        Tue, 19 Apr 2022 09:04:35 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 836095FD05;
        Tue, 19 Apr 2022 18:46:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1650383199;
        bh=sGg8ycCFqB88Dc5rskb3Mknu/4LClGvTZjioamwpUlo=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=ENjWV8sBvo/rRrHqfPXKanOuu8cDewY+oAu7lxKm0p88khgBB/EcMxxLkDVDZwQSU
         qv3ChNu+Xq15biUdVGrafW1odEyc7byFf2VPW04Pqd43murEAYpujJwOVB9RNE9ug1
         ygguV0G0AtldDbyScRuJDE68bQYxZsuYs282Po5uHjvjbpyHnMX3vZwSHSBjVFqh9A
         E/HdsHs7n4oY+52yI8EW8Jm+5DXs8vk380HMvmZPSOzBOw0n+N7Ao1l1bVChe5JbmZ
         ve8d0jITHA17Nwg/YVb8ndNuOrKBO0Uz8HSihhUJ8OzM1YsBb2vrLyq4SQVwS4LFLY
         V3f9u50o+qh+A==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 19 Apr 2022 18:46:39 +0300 (MSK)
From:   Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
Subject: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer driver
Thread-Topic: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYVASOybrxT0DjfUWoYWuGUlWOXw==
Date:   Tue, 19 Apr 2022 15:45:55 +0000
Message-ID: <20220419154555.24191-3-ddrokosov@sberdevices.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/04/19 10:34:00 #19304456
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
sensitivity consumer applications. It has dynamical user selectable full
scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
with output data rates from 1Hz to 1000Hz.

This driver supports following MSA311 features:
    - IIO interface
    - Different power modes: NORMAL, SUSPEND and LOW (using pm_runtime)
    - ODR (Output Data Rate) selection
    - Scale and samp_freq selection
    - IIO triggered buffer, IIO reg access
    - NEW_DATA interrupt + trigger

Below features to be done:
    - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 MAINTAINERS                |    6 +
 drivers/iio/accel/Kconfig  |   13 +
 drivers/iio/accel/Makefile |    2 +
 drivers/iio/accel/msa311.c | 2068 ++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 2089 insertions(+)
 create mode 100644 drivers/iio/accel/msa311.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cd0f68d..c75be17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12478,6 +12478,12 @@ F:	drivers/mtd/
 F:	include/linux/mtd/
 F:	include/uapi/mtd/
=20
+MEMSENSING MICROSYSTEMS MSA311 ACCELEROMETER DRIVER
+M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/accel/msa311.c
+
 MEN A21 WATCHDOG DRIVER
 M:	Johannes Thumshirn <morbidrsa@gmail.com>
 L:	linux-watchdog@vger.kernel.org
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 49587c9..88a265b 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -508,6 +508,19 @@ config MMA9553
 	  To compile this driver as a module, choose M here: the module
 	  will be called mma9553.
=20
+config MSA311
+	tristate "MEMSensing Digital 3-Axis Accelerometer Driver"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for the MEMSensing MSA311
+	  accelerometer driver.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called msa311.
+
 config MXC4005
 	tristate "Memsic MXC4005XC 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index d03e2f6..b1ddcaa 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -55,6 +55,8 @@ obj-$(CONFIG_MMA9551_CORE)	+=3D mma9551_core.o
 obj-$(CONFIG_MMA9551)		+=3D mma9551.o
 obj-$(CONFIG_MMA9553)		+=3D mma9553.o
=20
+obj-$(CONFIG_MSA311)		+=3D msa311.o
+
 obj-$(CONFIG_MXC4005)		+=3D mxc4005.o
 obj-$(CONFIG_MXC6255)		+=3D mxc6255.o
=20
diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
new file mode 100644
index 00000000..9f81b60
--- /dev/null
+++ b/drivers/iio/accel/msa311.c
@@ -0,0 +1,2068 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * msa311.c - MEMSensing digital 3-Axis accelerometer
+ *
+ * MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
+ * sensitivity consumer applications. It has dynamical user selectable ful=
l
+ * scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measuremen=
ts
+ * with output data rates from 1Hz to 1000Hz.
+ *
+ * MSA311 is available in an ultra small (2mm x 2mm, height 0.95mm) LGA pa=
ckage
+ * and is guaranteed to operate over -40C to +85C.
+ *
+ * This driver supports following MSA311 features:
+ *     - IIO interface
+ *     - Different power modes: NORMAL, SUSPEND and LOW
+ *     - ODR (Output Data Rate) selection
+ *     - Scale selection
+ *     - IIO triggered buffer
+ *     - NEW_DATA interrupt + trigger
+ *
+ * Below features to be done:
+ *     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
+ *
+ * Copyright (c) 2022, SberDevices. All Rights Reserved.
+ *
+ * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
+ */
+
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#define MSA311_DRV_NAME "msa311"
+
+/* Register map */
+
+enum msa311_regs {
+	MSA311_SOFT_RESET =3D 0x00,
+	MSA311_PARTID,
+	MSA311_ACC_X_LSB,
+	MSA311_ACC_X_MSB,
+	MSA311_ACC_Y_LSB,
+	MSA311_ACC_Y_MSB,
+	MSA311_ACC_Z_LSB,
+	MSA311_ACC_Z_MSB,
+
+	MSA311_MOTION_INT =3D 0x09,
+	MSA311_DATA_INT,
+	MSA311_TAP_ACTIVE_STS,
+	MSA311_ORIENT_STS,
+
+	MSA311_RANGE =3D 0x0F,
+	MSA311_ODR,
+	MSA311_PWR_MODE,
+	MSA311_SWAP_POLARITY,
+
+	MSA311_INT_SET_0 =3D 0x16,
+	MSA311_INT_SET_1,
+
+	MSA311_INT_MAP_0 =3D 0x19,
+	MSA311_INT_MAP_1,
+
+	MSA311_INT_CONFIG =3D 0x20,
+	MSA311_INT_LATCH,
+	MSA311_FREEFALL_DUR,
+	MSA311_FREEFALL_TH,
+	MSA311_FREEFALL_HY,
+
+	MSA311_ACTIVE_DUR =3D 0x27,
+	MSA311_ACTIVE_TH,
+
+	MSA311_TAP_DUR =3D 0x2A,
+	MSA311_TAP_TH,
+	MSA311_ORIENT_HY,
+	MSA311_Z_BLOCK,
+
+	MSA311_OFFSET_X =3D 0x38,
+	MSA311_OFFSET_Y,
+	MSA311_OFFSET_Z,
+
+	MSA311_MAX_REGS,
+};
+
+enum msa311_fields {
+	F_SOFT_RESET_I2C, F_SOFT_RESET_SPI,
+
+	F_PARTID,
+
+	F_ACC_X_LSB, F_ACC_X_MSB,
+
+	F_ACC_Y_LSB, F_ACC_Y_MSB,
+
+	F_ACC_Z_LSB, F_ACC_Z_MSB,
+
+	F_ORIENT_INT, F_S_TAP_INT, F_D_TAP_INT, F_ACTIVE_INT, F_FREEFALL_INT,
+
+	F_NEW_DATA_INT,
+
+	F_TAP_SIGN, F_TAP_FIRST_X, F_TAP_FIRST_Y, F_TAP_FIRST_Z, F_ACTV_SIGN,
+	F_ACTV_FIRST_X, F_ACTV_FIRST_Y, F_ACTV_FIRST_Z,
+
+	F_ORIENT_Z, F_ORIENT_X_Y,
+
+	F_FS,
+
+	F_X_AXIS_DIS, F_Y_AXIS_DIS, F_Z_AXIS_DIS, F_ODR,
+
+	F_PWR_MODE, F_LOW_POWER_BW,
+
+	F_X_POLARITY, F_Y_POLARITY, F_Z_POLARITY, F_X_Y_SWAP,
+
+	F_ORIENT_INT_EN, F_S_TAP_INT_EN, F_D_TAP_INT_EN, F_ACTIVE_INT_EN_Z,
+	F_ACTIVE_INT_EN_Y, F_ACTIVE_INT_EN_X,
+
+	F_NEW_DATA_INT_EN, F_FREEFALL_INT_EN,
+
+	F_INT1_ORIENT, F_INT1_S_TAP, F_INT1_D_TAP, F_INT1_ACTIVE,
+	F_INT1_FREEFALL,
+
+	F_INT1_NEW_DATA,
+
+	F_INT1_OD, F_INT1_LVL,
+
+	F_RESET_INT, F_LATCH_INT,
+
+	F_FREEFALL_DUR,
+
+	F_FREEFALL_TH,
+
+	F_FREEFALL_MODE, F_FREEFALL_HY,
+
+	F_ACTIVE_DUR,
+
+	F_ACTIVE_TH,
+
+	F_TAP_QUIET, F_TAP_SHOCK, F_TAP_DUR,
+
+	F_TAP_TH,
+
+	F_ORIENT_HYST, F_ORIENT_BLOCKING, F_ORIENT_MODE,
+
+	F_Z_BLOCKING,
+
+	F_OFFSET_X, F_OFFSET_Y, F_OFFSET_Z,
+
+	F_MAX_FIELDS,
+};
+
+static const struct reg_field msa311_reg_fields[] =3D {
+	/*
+	 * Soft Reset
+	 *
+	 * 0:soft reset disable, 1:soft reset enable
+	 */
+	[F_SOFT_RESET_I2C] =3D REG_FIELD(MSA311_SOFT_RESET, 2, 2),
+	[F_SOFT_RESET_SPI] =3D REG_FIELD(MSA311_SOFT_RESET, 5, 5),
+
+	/*
+	 * Part ID
+	 *
+	 * Default: 0x13
+	 */
+	[F_PARTID] =3D REG_FIELD(MSA311_PARTID, 0, 7),
+
+	/*
+	 * X_axis Data LSB/MSB
+	 *
+	 * ACC_X =3D (ACC_X_MSB[7:0] << 4) | ACC_X_LSB[7:4]
+	 */
+	[F_ACC_X_LSB] =3D REG_FIELD(MSA311_ACC_X_LSB, 4, 7),
+	[F_ACC_X_MSB] =3D REG_FIELD(MSA311_ACC_X_MSB, 0, 7),
+
+	/*
+	 * Y_axis Data LSB/MSB
+	 * ACC_Y =3D (ACC_Y_MSB[7:0] << 4) | ACC_Y_LSB[7:4]
+	 */
+	[F_ACC_Y_LSB] =3D REG_FIELD(MSA311_ACC_Y_LSB, 4, 7),
+	[F_ACC_Y_MSB] =3D REG_FIELD(MSA311_ACC_Y_MSB, 0, 7),
+
+	/*
+	 * Z_axis Data LSB/MSB
+	 *
+	 * ACC_Z =3D (ACC_Z_MSB[7:0] << 4) | ACC_Z_LSB[7:4]
+	 */
+	[F_ACC_Z_LSB] =3D REG_FIELD(MSA311_ACC_Z_LSB, 4, 7),
+	[F_ACC_Z_MSB] =3D REG_FIELD(MSA311_ACC_Z_MSB, 0, 7),
+
+	/*
+	 * Motion Interrupt
+	 *
+	 * ORIENT_INT: orientation interrupt status, 0: inactive, 1: active
+	 * S_TAP_INT: single tap interrupt status, 0: inactive, 1: active
+	 * D_TAP_INT: double tap interrupt status, 0: inactive, 1: active
+	 * ACTIVE_INT: active interrupt status, 0: inactive, 1: active
+	 * FREEFALL_INT: freefall interrupt status, 0: inactive, 1: active
+	 */
+	[F_ORIENT_INT] =3D REG_FIELD(MSA311_MOTION_INT, 6, 6),
+	[F_S_TAP_INT] =3D REG_FIELD(MSA311_MOTION_INT, 5, 5),
+	[F_D_TAP_INT] =3D REG_FIELD(MSA311_MOTION_INT, 4, 4),
+	[F_ACTIVE_INT] =3D REG_FIELD(MSA311_MOTION_INT, 2, 2),
+	[F_FREEFALL_INT] =3D REG_FIELD(MSA311_MOTION_INT, 0, 0),
+
+	/*
+	 * Data Interrupt
+	 *
+	 * NEW_DATA_INT: new data interrupt status, 0: inactive,1: active
+	 */
+	[F_NEW_DATA_INT] =3D REG_FIELD(MSA311_DATA_INT, 0, 0),
+
+	/*
+	 * Tap Active Status
+	 *
+	 * TAP_SIGN: sign of tap triggering signal, 0 : positive, 1: negative
+	 * TAP_FIRST_X: tap interrupt triggered by x axis,
+	 *              1:positive, 0:negative
+	 * TAP_FIRST_Y: tap interrupt triggered by y axis,
+	 *              1:positive, 0:negative
+	 * TAP_FIRST_Z: tap interrupt triggered by z axis,
+	 *              1:positive, 0:negative
+	 * ACTIVE_SIGN: sign of active interrupt, 0: positive, 1: negative
+	 * ACTIVE_FIRST_X: active interrupt triggered by x axis,
+	 *                 1:positive, 0:negative
+	 * ACTIVE_FIRST_Y: active interrupt triggered by y axis,
+	 *                 1:positive, 0:negative
+	 * ACTIVE_FIRST_Z: active interrupt triggered by z axis,
+	 *                 1:positive, 0:negative
+	 */
+	[F_TAP_SIGN] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 7, 7),
+	[F_TAP_FIRST_X] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 6, 6),
+	[F_TAP_FIRST_Y] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 5, 5),
+	[F_TAP_FIRST_Z] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 4, 4),
+	[F_ACTV_SIGN] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 3, 3),
+	[F_ACTV_FIRST_X] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 2, 2),
+	[F_ACTV_FIRST_Y] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 1, 1),
+	[F_ACTV_FIRST_Z] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 0, 0),
+
+	/*
+	 * Orientation Status
+	 *
+	 * ORIENT[2]: orientation value of z axis,
+	 *            0:upward looking, 1:downward looking
+	 * ORIENT[1:0]: orientation value of x/y axes
+	 *              00: portrait upright
+	 *              01: portrait upside down
+	 *              10: landscape left,
+	 *              11: landscape right
+	 */
+	[F_ORIENT_Z] =3D REG_FIELD(MSA311_ORIENT_STS, 6, 6),
+	[F_ORIENT_X_Y] =3D REG_FIELD(MSA311_ORIENT_STS, 4, 5),
+
+	/*
+	 * Acceleration Range
+	 *
+	 * FS[1:0]: acceleration range of x/y/z axes,
+	 *          00:+/-2g, 01:+/-4g, 10:+/-8g, 11:+/-16g
+	 *
+	 * Axis data is 12-bit signed value, so
+	 *
+	 * fs0 =3D (2 + 2) * 9.81 / (2<<11) =3D 0.009580
+	 * fs1 =3D (4 + 4) * 9.81 / (2<<11) =3D 0.019160
+	 * fs2 =3D (8 + 8) * 9.81 / (2<<11) =3D 0.038320
+	 * fs3 =3D (16 + 16) * 9.81 / (2<<11) =3D 0.076641
+	 */
+	[F_FS] =3D REG_FIELD(MSA311_RANGE, 0, 1),
+
+	/*
+	 * Output Data Rate
+	 *
+	 * X_AXIS_DIS: 0: enable, 1: disable
+	 * Y_AXIS_DIS: 0: enable, 1: disable
+	 * Z_AXIS_DIS: 0: enable, 1: disable
+	 * ODR[3:0]: 0000: 1Hz (not available in normal mode)
+	 *           0001: 1.95Hz (not available in normal mode)
+	 *           0010: 3.9Hz
+	 *           0011: 7.81Hz
+	 *           0100: 15.63Hz
+	 *           0101: 31.25Hz
+	 *           0110: 62.5Hz
+	 *           0111: 125Hz
+	 *           1000: 250Hz
+	 *           1001: 500Hz (not available in low power mode)
+	 *           1010-1111:1000hz (not available in low power mode)
+	 */
+	[F_X_AXIS_DIS] =3D REG_FIELD(MSA311_ODR, 7, 7),
+	[F_Y_AXIS_DIS] =3D REG_FIELD(MSA311_ODR, 6, 6),
+	[F_Z_AXIS_DIS] =3D REG_FIELD(MSA311_ODR, 5, 5),
+	[F_ODR] =3D REG_FIELD(MSA311_ODR, 0, 3),
+
+	/*
+	 * Power Mode/Bandwidth
+	 *
+	 * PWR_MODE: 00: normal mode, 01: low power mode, 11: suspend mode
+	 * LOW_POWER_BW[3:0]: 0000-0010: 1.95Hz
+	 *                    0011: 3.9Hz
+	 *                    0100: 7.81Hz
+	 *                    0101: 15.63Hz
+	 *                    0110: 31.25Hz
+	 *                    0111: 62.5Hz
+	 *                    1000: 125Hz
+	 *                    1001: 250Hz
+	 *                    1010-1111: 500Hz
+	 */
+	[F_PWR_MODE] =3D REG_FIELD(MSA311_PWR_MODE, 6, 7),
+	[F_LOW_POWER_BW] =3D REG_FIELD(MSA311_PWR_MODE, 1, 4),
+
+	/*
+	 * Swap Polarity
+	 *
+	 * X_POLARITY: the polarity of X axis, 0: not reverse, 1: reverse
+	 * Y_POLARITY: the polarity of Y axis, 0: not reverse, 1: reverse
+	 * Z_POLARITY: the polarity of Z axis, 0: not reverse, 1: reverse
+	 * X_Y_SWAP: output of X/Y axis, 0: not swap, 1: swap
+	 */
+	[F_X_POLARITY] =3D REG_FIELD(MSA311_SWAP_POLARITY, 3, 3),
+	[F_Y_POLARITY] =3D REG_FIELD(MSA311_SWAP_POLARITY, 2, 2),
+	[F_Z_POLARITY] =3D REG_FIELD(MSA311_SWAP_POLARITY, 1, 1),
+	[F_X_Y_SWAP] =3D REG_FIELD(MSA311_SWAP_POLARITY, 0, 0),
+
+	/*
+	 * Interrupt Set 0
+	 *
+	 * ORIENT_INT_EN: orient interrupt, 0: disable, 1: enable
+	 * S_TAP_INT_EN: single tap interrupt, 0: disable, 1: enable
+	 * D_TAP_INT_EN: double tap interrupt, 0: disable, 1: enable
+	 * ACTIVE_INT_EN_Z: active interrupt for the z axis,
+	 *                  0: disable, 1: enable
+	 * ACTIVE_INT_EN_Y: active interrupt for the y axis,
+	 *                  0: disable, 1: enable
+	 * ACTIVE_INT_EN_X: active interrupt for the x axis,
+	 *                  0: disable, 1: enable
+	 */
+	[F_ORIENT_INT_EN] =3D REG_FIELD(MSA311_INT_SET_0, 6, 6),
+	[F_S_TAP_INT_EN] =3D REG_FIELD(MSA311_INT_SET_0, 5, 5),
+	[F_D_TAP_INT_EN] =3D REG_FIELD(MSA311_INT_SET_0, 4, 4),
+	[F_ACTIVE_INT_EN_Z] =3D REG_FIELD(MSA311_INT_SET_0, 2, 2),
+	[F_ACTIVE_INT_EN_Y] =3D REG_FIELD(MSA311_INT_SET_0, 1, 1),
+	[F_ACTIVE_INT_EN_X] =3D REG_FIELD(MSA311_INT_SET_0, 0, 0),
+
+	/*
+	 * Interrupt Set 1
+	 *
+	 * NEW_DATA_INT_EN: new data interrupt, 0: disable, 1: enable
+	 * FREEFALL_INT_EN: freefall interrupt, 0: disable, 1: enable
+	 */
+	[F_NEW_DATA_INT_EN] =3D REG_FIELD(MSA311_INT_SET_1, 4, 4),
+	[F_FREEFALL_INT_EN] =3D REG_FIELD(MSA311_INT_SET_1, 3, 3),
+
+	/*
+	 * Interrupt Map 0
+	 *
+	 * INT1_ORIENT: map orientation interrupt to INT1, 0: disable, 1: enable
+	 * INT1_S_TAP: map single tap interrupt to INT1, 0: disable, 1: enable
+	 * INT1_D_TAP: map double tap interrupt to INT1, 0: disable, 1: enable
+	 * INT1_ACTIVE: map active interrupt to INT1, 0: disable, 1: enable
+	 * INT1_FREEFALL: map freefall interrupt to INT1, 0: disable, 1: enable
+	 */
+	[F_INT1_ORIENT] =3D REG_FIELD(MSA311_INT_MAP_0, 6, 6),
+	[F_INT1_S_TAP] =3D REG_FIELD(MSA311_INT_MAP_0, 5, 5),
+	[F_INT1_D_TAP] =3D REG_FIELD(MSA311_INT_MAP_0, 4, 4),
+	[F_INT1_ACTIVE] =3D REG_FIELD(MSA311_INT_MAP_0, 2, 2),
+	[F_INT1_FREEFALL] =3D REG_FIELD(MSA311_INT_MAP_0, 0, 0),
+
+	/*
+	 * Interrupt Map 1
+	 *
+	 * INT1_NEW_DATA: map new data interrupt to INT1, 0: disable, 1: enable
+	 */
+	[F_INT1_NEW_DATA] =3D REG_FIELD(MSA311_INT_MAP_1, 0, 0),
+
+	/*
+	 * Interrupt Config
+	 *
+	 * INT1_OD: select output for INT1, 0: push-pull, 1: open-drain
+	 * INT1_LVL: select active level for INT1, 0: low, 1: high
+	 */
+	[F_INT1_OD] =3D REG_FIELD(MSA311_INT_CONFIG, 1, 1),
+	[F_INT1_LVL] =3D REG_FIELD(MSA311_INT_CONFIG, 0, 0),
+
+	/*
+	 * Interrupt Latch
+	 *
+	 * RESET_INT: reset or not,
+	 *            1: reset all latched interrupt,
+	 *            0: not reset all latched interrupt
+	 * LATCH_INT[3:0]: 0000: non-latched
+	 *                 0001: temporary latched 250ms
+	 *                 0010: temporary latched 500ms
+	 *                 0011: temporary latched 1s
+	 *                 0100: temporary latched 2s
+	 *                 0101: temporary latched 4s
+	 *                 0110: temporary latched 8s
+	 *                 0111: latched
+	 *                 1000: non-latched
+	 *                 1001: temporary latched 1ms
+	 *                 1010: temporary latched 1ms
+	 *                 1011: temporary latched 2ms
+	 *                 1100: temporary latched 25ms
+	 *                 1101: temporary latched 50ms
+	 *                 1110: temporary latched 100ms
+	 *                 1111: latched
+	 */
+	[F_RESET_INT] =3D REG_FIELD(MSA311_INT_LATCH, 7, 7),
+	[F_LATCH_INT] =3D REG_FIELD(MSA311_INT_LATCH, 0, 3),
+
+	/*
+	 * Freefall Duration
+	 *
+	 * FREEFALL_DUR[7:0]: delay_time is (FREEFALL_DUR[7:0] + 1) * 2ms,
+	 *                    range from 2ms to 512ms,
+	 *                    the default delay time is 20ms
+	 */
+	[F_FREEFALL_DUR] =3D REG_FIELD(MSA311_FREEFALL_DUR, 0, 7),
+
+	/*
+	 * Freefall Threshold
+	 *
+	 * FREEFALL_TH[7:0]: threshold value is freefall_th[7:0] * 7.81mg,
+	 *                   default value is 375mg
+	 */
+	[F_FREEFALL_TH] =3D REG_FIELD(MSA311_FREEFALL_TH, 0, 7),
+
+	/*
+	 * Freefall Hysteresis
+	 *
+	 * FREEFALL_MODE: 0: single mode, 1: sum_mode
+	 * FREEFALL_HY[1:0]: freefall hysteresis time is
+	 *                   FREEFALL_HY[1:0] * 125mg
+	 */
+	[F_FREEFALL_MODE] =3D REG_FIELD(MSA311_FREEFALL_HY, 2, 2),
+	[F_FREEFALL_HY] =3D REG_FIELD(MSA311_FREEFALL_HY, 0, 1),
+
+	/*
+	 * Active Duration Time
+	 *
+	 * ACTIVE_DUR[1:0]: active duration time is (ACTIVE_DUR[1:0] + 1)ms
+	 */
+	[F_ACTIVE_DUR] =3D REG_FIELD(MSA311_ACTIVE_DUR, 0, 1),
+
+	/*
+	 * Active Interrupt Threshold
+	 *
+	 * ACTIVE_TH[7:0]: threshold of active interrupt
+	 *                 3.91mg/LSB (2g range)
+	 *                 7.81mg/LSB (4g range)
+	 *                 15.625mg/LSB (8g range)
+	 *                 31.25mg/LSB (16g range)
+	 */
+	[F_ACTIVE_TH] =3D REG_FIELD(MSA311_ACTIVE_TH, 0, 7),
+
+	/*
+	 * Tap Duration
+	 *
+	 * TAP_QUIET: 0: tap quiet duration 30ms, 1: tap quiet duration 20ms
+	 * TAP_SHOCK: 0: tap shock duration 50ms, 1: tap shock duration 70ms
+	 * TAP_DUR[2:0]: selects the length of the time window for the
+	 *               second shock
+	 *               000: 50ms
+	 *               001:100ms
+	 *               010:150ms
+	 *               011:200ms
+	 *               100:250ms
+	 *               101:375ms
+	 *               110:500ms
+	 *               111:700ms
+	 */
+	[F_TAP_QUIET] =3D REG_FIELD(MSA311_TAP_DUR, 7, 7),
+	[F_TAP_SHOCK] =3D REG_FIELD(MSA311_TAP_DUR, 6, 6),
+	[F_TAP_DUR] =3D REG_FIELD(MSA311_TAP_DUR, 0, 2),
+
+	/*
+	 * Tap Interrupt Threshold
+	 *
+	 * TAP_TH[4:0]: threshold of tap interrupt.
+	 *              62.5mg/LSB(2g range)
+	 *              125mg/LSB(4g range)
+	 *              250mg/LSB(8g range)
+	 *              500mg/LSB(16g range)
+	 */
+	[F_TAP_TH] =3D REG_FIELD(MSA311_TAP_TH, 0, 4),
+
+	/*
+	 * Orientation Hysteresis
+	 *
+	 * ORIENT_HYST[2:0]: set the hysteresis of the orientation interrupt,
+	 *                   1LSB is 62.5mg.
+	 * ORIENT_BLOCKING[1:0]: select the block mode
+	 *                       00: no blocking
+	 *                       01: z_axis blocking
+	 *                       10: z_axis blocking or slope in any axis > 0.2g
+	 *                       11: no blocking
+	 * ORIENT_MODE[1:0]: set the thresholds
+	 *                   00: symmetrical
+	 *                   01: high-asymmetrical
+	 *                   10: low-asymmetrical
+	 *                   11: symmetrical
+	 */
+	[F_ORIENT_HYST] =3D REG_FIELD(MSA311_ORIENT_HY, 4, 6),
+	[F_ORIENT_BLOCKING] =3D REG_FIELD(MSA311_ORIENT_HY, 2, 3),
+	[F_ORIENT_MODE] =3D REG_FIELD(MSA311_ORIENT_HY, 0, 1),
+
+	/*
+	 * ACC_Z block
+	 *
+	 * Z_BLOCKING[3:0]: defines the block acc_z between 0g to 0.9375g
+	 */
+	[F_Z_BLOCKING] =3D REG_FIELD(MSA311_Z_BLOCK, 0, 3),
+
+	/*
+	 * Offset Compensation
+	 *
+	 * OFFSET_X[7:0]: the offset compensation value for X axis,
+	 *                1LSB is 3.9mg
+	 * OFFSET_Y[7:0]: the offset compensation value for Y axis,
+	 *                1LSB is 3.9mg
+	 * OFFSET_Z[7:0]: the offset compensation value for Z axis,
+	 *                1LSB is 3.9mg
+	 */
+	[F_OFFSET_X] =3D REG_FIELD(MSA311_OFFSET_X, 0, 7),
+	[F_OFFSET_Y] =3D REG_FIELD(MSA311_OFFSET_Y, 0, 7),
+	[F_OFFSET_Z] =3D REG_FIELD(MSA311_OFFSET_Z, 0, 7),
+};
+
+#define MSA311_WHO_AM_I 0x13
+
+/* Possible Full Scale ranges */
+enum {
+	MSA311_FS_2G,
+	MSA311_FS_4G,
+	MSA311_FS_8G,
+	MSA311_FS_16G,
+};
+
+#define msa311_fs_available "0.009580 0.019160 0.038320 0.076641"
+static const int msa311_fs_table[] =3D { 9580, 19160, 38320, 76641 };
+
+/* Possible Output Data Rate values */
+enum {
+	MSA311_ODR_1_HZ,
+	MSA311_ODR_1_95_HZ,
+	MSA311_ODR_3_9_HZ,
+	MSA311_ODR_7_81_HZ,
+	MSA311_ODR_15_63_HZ,
+	MSA311_ODR_31_25_HZ,
+	MSA311_ODR_62_5_HZ,
+	MSA311_ODR_125_HZ,
+	MSA311_ODR_250_HZ,
+	MSA311_ODR_500_HZ,
+	MSA311_ODR_1000_HZ,
+};
+
+#define msa311_odr_available "1 1.95 3.9 7.81 15.63 31.25 62.5 125 250 500=
 1000"
+static const struct {
+	int val;
+	int val2;
+} msa311_odr_table[] =3D {
+	{1, 0}, {1, 950000}, {3, 900000}, {7, 810000}, {15, 630000},
+	{31, 250000}, {62, 500000}, {125, 0}, {250, 0}, {500, 0}, {1000, 0}
+};
+
+/* All Power Modes */
+enum {
+	MSA311_PWR_MODE_NORMAL,
+	MSA311_PWR_MODE_LOW,
+	MSA311_PWR_MODE_SUSPEND =3D 0x3,
+};
+
+#define MSA311_PWR_SLEEP_DELAY_MS 2000 /* Autosuspend delay */
+
+/* Possible INT1 types and levels */
+enum {
+	MSA311_INT1_OD_PUSH_PULL,
+	MSA311_INT1_OD_OPEN_DRAIN,
+};
+
+enum {
+	MSA311_INT1_LVL_LOW,
+	MSA311_INT1_LVL_HIGH,
+};
+
+/* Latch INT modes */
+enum {
+	MSA311_LATCH_INT_NOT_LATCHED,
+	MSA311_LATCH_INT_250MS,
+	MSA311_LATCH_INT_500MS,
+	MSA311_LATCH_INT_1S,
+	MSA311_LATCH_INT_2S,
+	MSA311_LATCH_INT_4S,
+	MSA311_LATCH_INT_8S,
+	MSA311_LATCH_INT_1MS =3D 0xA,
+	MSA311_LATCH_INT_2MS,
+	MSA311_LATCH_INT_25MS,
+	MSA311_LATCH_INT_50MS,
+	MSA311_LATCH_INT_100MS,
+	MSA311_LATCH_INT_LATCHED,
+};
+
+/* Readonly MSA311 registers */
+static const struct regmap_range msa311_readonly_registers[] =3D {
+	regmap_reg_range(MSA311_PARTID, MSA311_ORIENT_STS),
+};
+
+static const struct regmap_access_table msa311_writeable_table =3D {
+	.no_ranges =3D msa311_readonly_registers,
+	.n_no_ranges =3D ARRAY_SIZE(msa311_readonly_registers),
+};
+
+/* Writeonly MSA311 registers */
+static const struct regmap_range msa311_writeonly_registers[] =3D {
+	regmap_reg_range(MSA311_SOFT_RESET, MSA311_SOFT_RESET),
+};
+
+static const struct regmap_access_table msa311_readable_table =3D {
+	.no_ranges =3D msa311_writeonly_registers,
+	.n_no_ranges =3D ARRAY_SIZE(msa311_writeonly_registers),
+};
+
+/* Volatile MSA311 registers, they will not be cached in the regmap rbtree=
 */
+static const struct regmap_range msa311_volatile_registers[] =3D {
+	regmap_reg_range(MSA311_ACC_X_LSB, MSA311_ORIENT_STS),
+};
+
+static const struct regmap_access_table msa311_volatile_table =3D {
+	.yes_ranges =3D msa311_volatile_registers,
+	.n_yes_ranges =3D ARRAY_SIZE(msa311_volatile_registers),
+};
+
+/*
+ * MSA311 regmap definition, supports readonly, writeonly registers,
+ * rbtree cache with certain volatile registers
+ */
+static const struct regmap_config msa311_regmap_config =3D {
+	.name =3D MSA311_DRV_NAME,
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.max_register =3D MSA311_OFFSET_Z,
+	.wr_table =3D &msa311_writeable_table,
+	.rd_table =3D &msa311_readable_table,
+	.volatile_table =3D &msa311_volatile_table,
+	.cache_type =3D REGCACHE_RBTREE,
+};
+
+/**
+ * MSA311_GENMASK() - MSA311 reg_field mask generator
+ *
+ * @field: requested regfield from msa311_reg_fields table
+ *
+ * @return: This helper returns reg_field mask to be applied.
+ */
+#define MSA311_GENMASK(field) ({                \
+	typeof(field) _field =3D (field);       \
+	GENMASK(msa311_reg_fields[_field].msb,  \
+		msa311_reg_fields[_field].lsb); \
+})
+
+/**
+ * struct msa311_priv - MSA311 internal private state
+ * @i2c: I2C client object
+ * @lock: State guard
+ * @new_data_trig: Optional NEW_DATA interrupt driven trigger used
+ *                 to notify external consumers a new sample is ready
+ * @new_data_trig_enabled: NEW_DATA interrupt driver trigger state,
+ *                         can be changed by trigger->ops->set_trigger_sta=
te()
+ * @regs: Underlying I2C bus adapter used to abstract slave
+ *        register accesses
+ * @fields: Abstract objects for each registers fields access
+ */
+struct msa311_priv {
+	struct i2c_client *i2c;
+	struct mutex lock; /* state guard */
+
+	struct iio_trigger *new_data_trig;
+	bool new_data_trig_enabled;
+
+	struct regmap *regs;
+	struct regmap_field *fields[F_MAX_FIELDS];
+};
+
+/**
+ * struct msa311_axis - MSA311 axis decriptor
+ * @lsb: LSB regmap_field object
+ * @msb: MSB regmap_field object
+ */
+struct msa311_axis {
+	struct regmap_field *lsb;
+	struct regmap_field *msb;
+};
+
+/* Channels */
+
+enum msa311_si {
+	MSA311_SI_X,
+	MSA311_SI_Y,
+	MSA311_SI_Z,
+	MSA311_SI_TIMESTAMP,
+	MSA311_SI_NONE =3D -1,
+};
+
+/**
+ * MSA311_ACCEL_CHANNEL() - Construct MSA311 accelerometer channel descrip=
tor
+ *
+ * @axis: axis name in uppercase
+ */
+#define MSA311_ACCEL_CHANNEL(axis) {                           \
+	.type =3D IIO_ACCEL,                                     \
+	.modified =3D 1,                                         \
+	.channel2 =3D IIO_MOD_##axis,                            \
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),          \
+	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) | \
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),  \
+	.scan_index =3D MSA311_SI_##axis,                        \
+	.scan_type =3D {                                         \
+		.sign =3D 's',                                   \
+		.realbits =3D 12,                                \
+		.storagebits =3D 16,                             \
+		.shift =3D 4,                                    \
+		.endianness =3D IIO_LE,                          \
+	},                                                     \
+	.datasheet_name =3D "ACC_"#axis                          \
+}
+
+/**
+ * MSA311_TIMESTAMP_CHANNEL() - Construct MSA311 timestamp channel descrip=
tor
+ */
+#define MSA311_TIMESTAMP_CHANNEL() IIO_CHAN_SOFT_TIMESTAMP(MSA311_SI_TIMES=
TAMP)
+
+static const struct iio_chan_spec msa311_channels[] =3D {
+	MSA311_ACCEL_CHANNEL(X),
+	MSA311_ACCEL_CHANNEL(Y),
+	MSA311_ACCEL_CHANNEL(Z),
+	MSA311_TIMESTAMP_CHANNEL(),
+};
+
+/* Attributes */
+
+/* Full Scale Range */
+static IIO_CONST_ATTR(in_accel_scale_available, msa311_fs_available);
+
+/* Output Data Rate */
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(msa311_odr_available);
+
+static struct attribute *msa311_attrs[] =3D {
+	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group msa311_attr_group =3D {
+	.attrs =3D msa311_attrs,
+};
+
+/**
+ * msa311_get_odr() - Read Output Data Rate (ODR) value from MSA311 accel
+ *
+ * @msa311: MSA311 internal private state
+ * @odr: output ODR value
+ *
+ * This function should be called under msa311->lock.
+ * It filters the same 1000Hz ODR register values based on datasheet info.
+ * ODR can be equal to 1010-1111 for 1000Hz, but function returns 1010
+ * all the time.
+ *
+ * @return: 0 on success, -ERRNO in other failures
+ */
+static inline int msa311_get_odr(struct msa311_priv *msa311, unsigned int =
*odr)
+{
+	int err;
+
+	err =3D regmap_field_read(msa311->fields[F_ODR], odr);
+	if (err) {
+		dev_err(&msa311->i2c->dev, "failed to read odr value (%d)\n",
+			err);
+		return err;
+	}
+
+	/* Filter same ODR values */
+	if (*odr > MSA311_ODR_1000_HZ)
+		*odr =3D MSA311_ODR_1000_HZ;
+
+	return err;
+}
+
+/**
+ * msa311_set_odr() - Setup Output Data Rate (ODR) value for MSA311 accel
+ *
+ * @msa311: MSA311 internal private state
+ * @odr: requested ODR value
+ *
+ * This function should be called under msa311->lock. Possible ODR values:
+ *     - 1Hz (not available in normal mode)
+ *     - 1.95Hz (not available in normal mode)
+ *     - 3.9Hz
+ *     - 7.81Hz
+ *     - 15.63Hz
+ *     - 31.25Hz
+ *     - 62.5Hz
+ *     - 125Hz
+ *     - 250Hz
+ *     - 500Hz (not available in low power mode)
+ *     - 1000Hz (not available in low power mode)
+ *
+ * @return: 0 on success, -EINVAL for bad ODR value in the certain power m=
ode,
+ *          -ERRNO in other failures
+ */
+static inline int msa311_set_odr(struct msa311_priv *msa311, unsigned int =
odr)
+{
+	const char *mode =3D NULL;
+	unsigned int pwr_mode;
+	bool good_odr =3D false;
+	int err;
+
+	err =3D regmap_field_read(msa311->fields[F_PWR_MODE], &pwr_mode);
+	if (err) {
+		dev_err(&msa311->i2c->dev, "failed to read pwr_mode (%d)\n",
+			err);
+		return err;
+	}
+
+	/* Filter bad ODR values */
+	switch (pwr_mode) {
+	case MSA311_PWR_MODE_LOW:
+		mode =3D "low";
+		good_odr =3D (odr < MSA311_ODR_500_HZ);
+		break;
+	case MSA311_PWR_MODE_NORMAL:
+		mode =3D "normal";
+		good_odr =3D (odr > MSA311_ODR_1_95_HZ);
+		break;
+	case MSA311_PWR_MODE_SUSPEND:
+		mode =3D "suspend";
+		break;
+	default:
+		mode =3D "unknown";
+		break;
+	}
+
+	if (!good_odr) {
+		dev_err(&msa311->i2c->dev,
+			"failed to set odr %u.%uHz, not available in %s mode\n",
+			msa311_odr_table[odr].val,
+			msa311_odr_table[odr].val2 / 1000, mode);
+		return -EINVAL;
+	}
+
+	err =3D regmap_field_write(msa311->fields[F_ODR], odr);
+	if (err)
+		dev_err(&msa311->i2c->dev, "failed to set odr value (%d)\n",
+			err);
+
+	return err;
+}
+
+/**
+ * msa311_wait_for_next_data() - Wait next accel data available after resu=
me
+ *
+ * @msa311: MSA311 internal private state
+ *
+ * @return: 0 on success, -EINTR if msleep() was interrupted,
+ *          -ERRNO in other failures
+ */
+static int msa311_wait_for_next_data(struct msa311_priv *msa311)
+{
+	static const int unintr_thresh_ms =3D 20;
+	unsigned int odr;
+	unsigned long wait_ms;
+	unsigned long freq_uhz;
+	int err;
+
+	err =3D msa311_get_odr(msa311, &odr);
+	if (err) {
+		dev_warn(&msa311->i2c->dev,
+			 "cannot get actual freq (%d)\n", err);
+		/* Use lowest Output Data Rate, this is not fatal error */
+		odr =3D MSA311_ODR_1_HZ;
+		err =3D 0;
+	}
+
+	freq_uhz =3D msa311_odr_table[odr].val * USEC_PER_SEC +
+		   msa311_odr_table[odr].val2;
+	wait_ms =3D (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;
+
+	if (wait_ms < unintr_thresh_ms)
+		usleep_range(wait_ms * USEC_PER_MSEC,
+			     unintr_thresh_ms * USEC_PER_MSEC);
+	else
+		err =3D msleep_interruptible(wait_ms) ? -EINTR : 0;
+
+	return err;
+}
+
+/**
+ * msa311_set_pwr_mode() - Install certain MSA311 power mode
+ *
+ * @msa311: MSA311 internal private state
+ * @mode: Power mode can be equal to NORMAL, SUSPEND and LOW
+ *
+ * This function should be called under msa311->lock.
+ *
+ * @return: 0 on success, -ERRNO on failure
+ */
+static int msa311_set_pwr_mode(struct msa311_priv *msa311, unsigned int mo=
de)
+{
+	unsigned int prev_mode;
+	int err;
+
+	dev_dbg(&msa311->i2c->dev, "transition to %s mode\n",
+		(mode =3D=3D MSA311_PWR_MODE_LOW) ? "low" :
+		(mode =3D=3D MSA311_PWR_MODE_NORMAL) ? "normal" :
+		"suspend");
+
+	err =3D regmap_field_read(msa311->fields[F_PWR_MODE], &prev_mode);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"cannot read previous pwr mode (%d)\n", err);
+		return err;
+	}
+
+	err =3D regmap_field_write(msa311->fields[F_PWR_MODE], mode);
+	if (err) {
+		dev_err(&msa311->i2c->dev, "bad pwr mode transition (%d)\n",
+			err);
+		return err;
+	}
+
+	/* Wait actual data if we wakeup */
+	if (prev_mode =3D=3D MSA311_PWR_MODE_SUSPEND &&
+	    mode =3D=3D MSA311_PWR_MODE_NORMAL)
+		err =3D msa311_wait_for_next_data(msa311);
+
+	return err;
+}
+
+/**
+ * msa311_normal_mode() - Transit MSA311 power state to NORMAL mode
+ *
+ * @msa311: MSA311 internal private state
+ *
+ * This function should be called under msa311->lock.
+ *
+ * @return: 0 on success, -ERRNO on failure
+ */
+static inline int msa311_normal_mode(struct msa311_priv *msa311)
+{
+	return msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_NORMAL);
+}
+
+/**
+ * msa311_suspend_mode() - Transit MSA311 power state to SUSPEND mode
+ *
+ * @msa311: MSA311 internal private state
+ *
+ * This function should be called under msa311->lock.
+ *
+ * @return: 0 on success, -ERRNO on failure
+ */
+static inline int msa311_suspend_mode(struct msa311_priv *msa311)
+{
+	return msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_SUSPEND);
+}
+
+/**
+ * msa311_powerup() - MSA311 resume power state using pm_runtime system
+ *
+ * @msa311: MSA311 internal private state
+ *
+ * @return: 0 on success, -ERRNO if cannot resume and get pm counter
+ */
+static inline int msa311_powerup(struct msa311_priv *msa311)
+{
+	return pm_runtime_resume_and_get(&msa311->i2c->dev);
+}
+
+/**
+ * msa311_powerdown() - MSA311 suspend power state using pm_runtime system
+ *
+ * @msa311: MSA311 internal private state
+ */
+static inline void msa311_powerdown(struct msa311_priv *msa311)
+{
+	pm_runtime_mark_last_busy(&msa311->i2c->dev);
+	pm_runtime_put_autosuspend(&msa311->i2c->dev);
+}
+
+/**
+ * msa311_chan_to_axis() - Translate IIO channel spec to MSA311 axis descr=
iptor
+ *
+ * @msa311: MSA311 internal private state
+ * @chan: IIO channel specification
+ *
+ * @return: appropriate msa311_axis object or NULL msa311_axis for unknown
+ *          IIO channel spec
+ */
+static inline
+struct msa311_axis msa311_chan_to_axis(struct msa311_priv *msa311,
+				       const struct iio_chan_spec * const chan)
+{
+	struct msa311_axis axis =3D { NULL, NULL };
+
+	switch (chan->scan_index) {
+	case MSA311_SI_X:
+		axis.lsb =3D msa311->fields[F_ACC_X_LSB];
+		axis.msb =3D msa311->fields[F_ACC_X_MSB];
+		break;
+
+	case MSA311_SI_Y:
+		axis.lsb =3D msa311->fields[F_ACC_Y_LSB];
+		axis.msb =3D msa311->fields[F_ACC_Y_MSB];
+		break;
+
+	case MSA311_SI_Z:
+		axis.lsb =3D msa311->fields[F_ACC_Z_LSB];
+		axis.msb =3D msa311->fields[F_ACC_Z_MSB];
+		break;
+	}
+
+	return axis;
+}
+
+/**
+ * msa311_get_axis() - Read MSA311 accel data for certain IIO channel spec
+ *
+ * @msa311: MSA311 internal private state
+ * @chan: IIO channel specification
+ * @data: Output accel data for requested IIO channel spec
+ *
+ * This function should be called under msa311->lock.
+ *
+ * @return: 0 on success, -EINVAL for unknown IIO channel specification,
+ *          -ERRNO in other failures
+ */
+static int msa311_get_axis(struct msa311_priv *msa311,
+			   const struct iio_chan_spec * const chan,
+			   unsigned int *data)
+{
+	struct msa311_axis axis;
+	unsigned int lsb, msb;
+	int err;
+
+	axis =3D msa311_chan_to_axis(msa311, chan);
+	if (!axis.lsb)
+		return -EINVAL;
+
+	err =3D regmap_field_read(axis.lsb, &lsb);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"failed to read lsb value of axis %s (%d)\n",
+			chan->datasheet_name, err);
+		return err;
+	}
+
+	err =3D regmap_field_read(axis.msb, &msb);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"failed to read msb value of axis %s (%d)\n",
+			chan->datasheet_name, err);
+		return err;
+	}
+
+	*data =3D (msb << chan->scan_type.shift) | lsb;
+
+	return err;
+}
+
+static int msa311_read_raw_data(struct msa311_priv *msa311,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2)
+{
+	unsigned int axis;
+	int err;
+
+	err =3D msa311_powerup(msa311);
+	if (err) {
+		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
+		return err;
+	}
+
+	mutex_lock(&msa311->lock);
+	err =3D msa311_get_axis(msa311, chan, &axis);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"cannot get axis %s (%d)\n",
+			chan->datasheet_name, err);
+		mutex_unlock(&msa311->lock);
+		return err;
+	}
+	mutex_unlock(&msa311->lock);
+
+	msa311_powerdown(msa311);
+
+	*val =3D sign_extend32(axis, chan->scan_type.realbits - 1);
+	*val2 =3D 0;
+
+	return IIO_VAL_INT;
+}
+
+static int msa311_read_scale(struct msa311_priv *msa311, int *val, int *va=
l2)
+{
+	unsigned int fs;
+	int err;
+
+	mutex_lock(&msa311->lock);
+	err =3D regmap_field_read(msa311->fields[F_FS], &fs);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"cannot get actual scale (%d)\n", err);
+		mutex_unlock(&msa311->lock);
+		return err;
+	}
+	mutex_unlock(&msa311->lock);
+
+	*val =3D 0;
+	*val2 =3D msa311_fs_table[fs];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int msa311_read_samp_freq(struct msa311_priv *msa311,
+				 int *val, int *val2)
+{
+	unsigned int odr;
+	int err;
+
+	mutex_lock(&msa311->lock);
+	err =3D msa311_get_odr(msa311, &odr);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"cannot get actual freq (%d)\n", err);
+		mutex_unlock(&msa311->lock);
+		return err;
+	}
+	mutex_unlock(&msa311->lock);
+
+	*val =3D msa311_odr_table[odr].val;
+	*val2 =3D msa311_odr_table[odr].val2;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+/**
+ * msa311_read_raw() - IIO interface function to request attr/accel data
+ *
+ * @indio_dev: The IIO device associated with MSA311
+ * @chan: IIO channel specification
+ * @val: Output data value, first part
+ * @val2: Output data value, second part
+ * @mask: Value type selector
+ *
+ * @return: IIO_VAL_* type on success,
+ *          -EINVAL for unknown value type (bad mask),
+ *          -EBUSY if IIO buffer enabled,
+ *          -ERRNO in other failures
+ */
+static int msa311_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	int err =3D -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+
+		err =3D msa311_read_raw_data(msa311, chan, val, val2);
+		break;
+
+	case IIO_CHAN_INFO_SCALE:
+		err =3D msa311_read_scale(msa311, val, val2);
+		break;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		err =3D msa311_read_samp_freq(msa311, val, val2);
+		break;
+	}
+
+	return err;
+}
+
+static int msa311_write_scale(struct msa311_priv *msa311, int val, int val=
2)
+{
+	unsigned int fs;
+	int err =3D -EINVAL;
+
+	/* Skip such values */
+	if (val !=3D 0)
+		return 0;
+
+	err =3D msa311_powerup(msa311);
+	if (err) {
+		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
+		return err;
+	}
+
+	mutex_lock(&msa311->lock);
+	for (fs =3D 0; fs < ARRAY_SIZE(msa311_fs_table); ++fs)
+		if (val2 =3D=3D msa311_fs_table[fs]) {
+			err =3D regmap_field_write(msa311->fields[F_FS], fs);
+			if (err) {
+				dev_err(&msa311->i2c->dev,
+					"cannot update scale (%d)\n", err);
+				goto failed;
+			}
+
+			break;
+		}
+
+failed:
+	mutex_unlock(&msa311->lock);
+
+	msa311_powerdown(msa311);
+
+	return err;
+}
+
+static int msa311_write_samp_freq(struct msa311_priv *msa311, int val, int=
 val2)
+{
+	unsigned int odr;
+	int err =3D -EINVAL;
+
+	err =3D msa311_powerup(msa311);
+	if (err) {
+		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
+		return err;
+	}
+
+	mutex_lock(&msa311->lock);
+	for (odr =3D 0; odr < ARRAY_SIZE(msa311_odr_table); ++odr)
+		if (val =3D=3D msa311_odr_table[odr].val &&
+		    val2 =3D=3D msa311_odr_table[odr].val2) {
+			err =3D msa311_set_odr(msa311, odr);
+			if (err) {
+				dev_err(&msa311->i2c->dev,
+					"cannot update freq (%d)\n", err);
+				goto failed;
+			}
+
+			break;
+		}
+
+failed:
+	mutex_unlock(&msa311->lock);
+
+	msa311_powerdown(msa311);
+
+	return err;
+}
+
+/**
+ * msa311_write_raw() - IIO interface function to write attr/accel data
+ *
+ * @indio_dev: The IIO device associated with MSA311
+ * @chan: IIO channel specification
+ * @val: Input data value, first part
+ * @val2: Input data value, second part
+ * @mask: Value type selector
+ *
+ * @return: 0 on success,
+ *          -EINVAL for unknown value type (bad mask),
+ *          -ERRNO in other failures
+ */
+static int msa311_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	int err =3D -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+
+		err =3D msa311_write_scale(msa311, val, val2);
+		break;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+
+		err =3D msa311_write_samp_freq(msa311, val, val2);
+		break;
+	}
+
+	return err;
+}
+
+/**
+ * msa311_debugfs_reg_access() - IIO interface function to read/write regi=
sters
+ *
+ * @indio_dev: The IIO device associated with MSA311
+ * @reg: Register offset
+ * @writeval: Input value to be written (applicable if readval =3D=3D NULL=
)
+ * @readval: Output value to be read, should be not NULL, if it's read ope=
ration
+ *
+ * @return: 0 on success,
+ *          -EINVAL for wrong register offset
+ *          -ERRNO in other failures
+ */
+static int msa311_debugfs_reg_access(struct iio_dev *indio_dev,
+				     unsigned int reg, unsigned int writeval,
+				     unsigned int *readval)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	int err;
+
+	if (reg > regmap_get_max_register(msa311->regs))
+		return -EINVAL;
+
+	err =3D msa311_powerup(msa311);
+	if (err) {
+		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
+		return err;
+	}
+
+	mutex_lock(&msa311->lock);
+
+	if (!readval)
+		err =3D regmap_write(msa311->regs, reg, writeval);
+	else
+		err =3D regmap_read(msa311->regs, reg, readval);
+
+	mutex_unlock(&msa311->lock);
+
+	msa311_powerdown(msa311);
+
+	if (err)
+		dev_err(&msa311->i2c->dev,
+			"cannot %s register %u from debugfs (%d)\n",
+			(!readval) ? "write" : "read", reg, err);
+
+	return err;
+}
+
+/**
+ * msa311_buffer_preenable() - IIO buffer interface preenable actions
+ *
+ * @indio_dev: The IIO device associated with MSA311
+ *
+ * @return: 0 on success,
+ *          -ERRNO in other failures
+ */
+static int msa311_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	int err;
+
+	err =3D msa311_powerup(msa311);
+	if (err)
+		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
+
+	return err;
+}
+
+/**
+ * msa311_buffer_postdisable() - IIO buffer interface postdisable actions
+ *
+ * @indio_dev: The IIO device associated with MSA311
+ *
+ * @return: 0 on success,
+ *          -ERRNO in other failures
+ */
+static int msa311_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+
+	msa311_powerdown(msa311);
+
+	return 0;
+}
+
+/**
+ * msa311_set_new_data_trig_state() - IIO trigger interface to change trig=
 state
+ *
+ * @trig: The IIO device trigger for new data event
+ * @state: New state (enabled or disabled)
+ *
+ * This function changes NEW_DATA interrupt driver trigger state to enable=
d or
+ * disabled.
+ *
+ * @return: 0 on success,
+ *          -ERRNO in other failures
+ */
+static int msa311_set_new_data_trig_state(struct iio_trigger *trig, bool s=
tate)
+{
+	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	int err =3D 0;
+
+	if (state)
+		err =3D msa311_powerup(msa311);
+	else
+		msa311_powerdown(msa311);
+
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"failed %s (%d)\n",
+			state ? "powerup" : "powerdown", err);
+		return err;
+	}
+
+	mutex_lock(&msa311->lock);
+
+	WRITE_ONCE(msa311->new_data_trig_enabled, state);
+
+	err =3D regmap_field_write(msa311->fields[F_NEW_DATA_INT_EN], state);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"cannot %s buffer due to new_data_int failure (%d)\n",
+			state ? "enable" : "disable", err);
+		if (state) {
+			mutex_unlock(&msa311->lock);
+			msa311_powerdown(msa311);
+			return err;
+		}
+	}
+
+	mutex_unlock(&msa311->lock);
+
+	return err;
+}
+
+/**
+ * msa311_reenable() - IIO trigger interface to reenable trigger interrupt
+ *
+ * @trig: The IIO device trigger wanted to reenable
+ */
+static void msa311_reenable(struct iio_trigger *trig)
+{
+	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	int err;
+
+	mutex_lock(&msa311->lock);
+
+	/* Reset all latched interrupts */
+	err =3D regmap_field_write(msa311->fields[F_RESET_INT], 1);
+
+	mutex_unlock(&msa311->lock);
+
+	if (err)
+		dev_err(&msa311->i2c->dev,
+			"cannot reset all latched interrupts (%d)\n", err);
+}
+
+/**
+ * msa311_validate_device() - IIO trigger interface to validate requested =
device
+ *
+ * @trig: Appropriate IIO trigger
+ * @indio_dev: Requested IIO device
+ *
+ * @return: 0 on success,
+ *         -EINVAL when indio_dev isn't linked with appropriate trigger
+ */
+static int msa311_validate_device(struct iio_trigger *trig,
+				  struct iio_dev *indio_dev)
+{
+	struct iio_dev *indio =3D iio_trigger_get_drvdata(trig);
+
+	if (indio !=3D indio_dev)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * msa311_buffer_thread() - IIO buffer thread to push channels actual data
+ *
+ * @irq:  The software interrupt assigned to @p
+ * @p: The IIO poll function dispatched by external trigger our device is
+ *     attached to.
+ *
+ * @return: IRQ_HANDLED all the time
+ */
+static irqreturn_t msa311_buffer_thread(int irq, void *p)
+{
+	struct iio_poll_func *pf =3D p;
+	struct iio_dev *indio_dev =3D pf->indio_dev;
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	const struct iio_chan_spec *chan;
+	unsigned int axis;
+	int bit =3D 0, err, i =3D 0;
+
+	/* Ensure correct alignment of time stamp when present */
+	struct {
+		s16 channels[MSA311_SI_Z + 1];
+		s64 ts;
+	} __aligned(8) buf =3D {0};
+
+	mutex_lock(&msa311->lock);
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		chan =3D &msa311_channels[bit];
+		err =3D msa311_get_axis(msa311, chan, &axis);
+		if (err) {
+			dev_err(&msa311->i2c->dev,
+				"cannot get axis %s (%d)\n",
+				chan->datasheet_name, err);
+			mutex_unlock(&msa311->lock);
+			goto err;
+		}
+		buf.channels[i++] =3D sign_extend32(axis,
+						  chan->scan_type.realbits - 1);
+	}
+
+	mutex_unlock(&msa311->lock);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &buf, pf->timestamp);
+
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * msa311_irq_handler() - Process MSA311 hardware interrupts (INT1 line)
+ *
+ * @irq:  Interrupt line the hardware uses to notify new data has arrived.
+ * @p: The IIO device associated with the sampling hardware.
+ *
+ * @return: IRQ_WAKE_THREAD all the time
+ */
+static irqreturn_t msa311_irq_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev =3D p;
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+
+	/* TODO: notify motion triggers */
+
+	if (READ_ONCE(msa311->new_data_trig_enabled))
+		iio_trigger_poll(msa311->new_data_trig);
+
+	return IRQ_WAKE_THREAD;
+}
+
+/**
+ * msa311_irq_thread() - Interrupt bottom-half handler.
+ *
+ * @irq:  Interrupt line the hardware uses to notify new data has arrived.
+ * @p: The IIO device associated with the sampling hardware.
+ *
+ * @return: IRQ_HANDLED all the time
+ */
+static irqreturn_t msa311_irq_thread(int irq, void *p)
+{
+	struct iio_dev *indio_dev =3D p;
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	unsigned int new_data_int_status;
+	int err;
+
+	mutex_lock(&msa311->lock);
+
+	/* TODO: push motion events */
+
+	/* Ack NEW_DATA interrupt */
+	err =3D regmap_field_read(msa311->fields[F_NEW_DATA_INT],
+				&new_data_int_status);
+
+	mutex_unlock(&msa311->lock);
+
+	if (err)
+		dev_err(&msa311->i2c->dev,
+			"cannot retrieve new_data interrupt status (%d)\n",
+			err);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * msa311_check_partid() - Check MSA311 WHO_AM_I identifier.
+ *
+ * @msa311: MSA311 internal private state
+ *
+ * @return: 0 on success (MSA311 device was found on the I2C bus)
+ *          -ENODEV when MSA311 device is not presented on the I2C bus
+ *          -ERRNO in other failures
+ */
+static int msa311_check_partid(struct msa311_priv *msa311)
+{
+	unsigned int partid;
+	int err;
+
+	err =3D regmap_field_read(msa311->fields[F_PARTID], &partid);
+	if (err) {
+		dev_err(&msa311->i2c->dev, "failed to read partid (%d)\n", err);
+		return err;
+	}
+
+	if (partid !=3D MSA311_WHO_AM_I) {
+		dev_err(&msa311->i2c->dev, "invalid partid (%#x)\n", partid);
+		return -ENODEV;
+	}
+
+	dev_info(&msa311->i2c->dev, "Found MSA311 chip[%#x]\n", partid);
+
+	return err;
+}
+
+/**
+ * msa311_soft_reset() - Make soft reset operation for MSA311 device.
+ *
+ * @msa311: MSA311 internal private state
+ *
+ * @return: 0 on success, -ERRNO in other failures
+ */
+static int msa311_soft_reset(struct msa311_priv *msa311)
+{
+	int err;
+
+	err =3D regmap_write(msa311->regs, MSA311_SOFT_RESET,
+			   MSA311_GENMASK(F_SOFT_RESET_I2C) |
+			   MSA311_GENMASK(F_SOFT_RESET_SPI));
+	if (err)
+		return err;
+
+	usleep_range(5000, 10000);
+
+	return err;
+}
+
+/**
+ * msa311_chip_init() - MSA311 chip initialization sequence
+ *
+ * @msa311: MSA311 internal private state
+ *
+ * We do not need to hold msa311->lock here, because this function is used
+ * during I2C driver probing process only.
+ *
+ * @return: 0 on success, -ERRNO in other failures
+ */
+static int msa311_chip_init(struct msa311_priv *msa311)
+{
+	int err;
+
+	err =3D msa311_check_partid(msa311);
+	if (err)
+		return err;
+
+	err =3D msa311_soft_reset(msa311);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"cannot soft reset all logic (%d)\n", err);
+		return err;
+	}
+
+	err =3D msa311_normal_mode(msa311);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"bad normal pwr mode transition (%d)\n", err);
+		return err;
+	}
+
+	err =3D regmap_write(msa311->regs, MSA311_RANGE, MSA311_FS_16G);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"failed to setup accel range (%d)\n", err);
+		return err;
+	}
+
+	/* Disable all interrupts by default */
+	err =3D regmap_write(msa311->regs, MSA311_INT_SET_0, 0);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"cannot disable set0 interrupts (%d)\n", err);
+		return err;
+	}
+	err =3D regmap_write(msa311->regs, MSA311_INT_SET_1, 0);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"cannot disable set1 interrupts (%d)\n", err);
+		return err;
+	}
+
+	/* Unmap all INT1 interrupts by default */
+	err =3D regmap_write(msa311->regs, MSA311_INT_MAP_0, 0);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"failed to unmap map0 interrupts (%d)\n", err);
+		return err;
+	}
+	err =3D regmap_write(msa311->regs, MSA311_INT_MAP_1, 0);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"failed to unmap map1 interrupts (%d)\n", err);
+		return err;
+	}
+
+	/* Disable all axis by default */
+	err =3D regmap_update_bits(msa311->regs, MSA311_ODR,
+				 MSA311_GENMASK(F_X_AXIS_DIS) |
+				 MSA311_GENMASK(F_Y_AXIS_DIS) |
+				 MSA311_GENMASK(F_Z_AXIS_DIS), 0);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"cannot enable all axes (%d)\n", err);
+		return err;
+	}
+
+	err =3D msa311_set_odr(msa311, MSA311_ODR_125_HZ);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"failed to set accel frequency (%d)\n", err);
+		return err;
+	}
+
+	usleep_range(10000, 15000);
+
+	return err;
+}
+
+/**
+ * msa311_setup_interrupts() - MSA311 interrupts initialization sequence
+ *
+ * @msa311: MSA311 internal private state
+ *
+ * We do not need to hold msa311->lock here, because this function is used
+ * during I2C driver probing process only.
+ *
+ * @return: 0 on success, -ERRNO in other failures
+ */
+static int msa311_setup_interrupts(struct msa311_priv *msa311)
+{
+	int err;
+
+	err =3D regmap_field_write(msa311->fields[F_INT1_OD],
+				 MSA311_INT1_OD_PUSH_PULL);
+	if (err)
+		return err;
+
+	err =3D regmap_field_write(msa311->fields[F_INT1_LVL],
+				 MSA311_INT1_LVL_HIGH);
+	if (err)
+		return err;
+
+	err =3D regmap_field_write(msa311->fields[F_LATCH_INT],
+				 MSA311_LATCH_INT_LATCHED);
+	if (err)
+		return err;
+
+	err =3D regmap_field_write(msa311->fields[F_INT1_NEW_DATA], 1);
+
+	return err;
+}
+
+/**
+ * msa311_regmap_init() - MSA311 registers mapping initialization
+ *
+ * @msa311: MSA311 internal private state
+ *
+ * We do not need to hold msa311->lock here, because this function is used
+ * during I2C driver probing process only.
+ *
+ * @return: 0 on success, -ERRNO in other failures
+ */
+static int msa311_regmap_init(struct msa311_priv *msa311)
+{
+	struct regmap *regmap;
+	struct regmap_field **fields =3D msa311->fields;
+	int i;
+
+	regmap =3D devm_regmap_init_i2c(msa311->i2c, &msa311_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&msa311->i2c->dev, "failed to register i2c regmap\n");
+		return PTR_ERR(regmap);
+	}
+	msa311->regs =3D regmap;
+
+	for (i =3D 0; i < F_MAX_FIELDS; ++i) {
+		fields[i] =3D devm_regmap_field_alloc(&msa311->i2c->dev,
+						    msa311->regs,
+						    msa311_reg_fields[i]);
+		if (IS_ERR(msa311->fields[i])) {
+			dev_err(&msa311->i2c->dev,
+				"failed to allocate reg field[%d]\n", i);
+			return PTR_ERR(msa311->fields[i]);
+		}
+	}
+
+	return 0;
+}
+
+static const struct iio_info msa311_info =3D {
+	.attrs =3D &msa311_attr_group,
+	.read_raw =3D msa311_read_raw,
+	.write_raw =3D msa311_write_raw,
+	.debugfs_reg_access =3D msa311_debugfs_reg_access,
+};
+
+static const struct iio_buffer_setup_ops msa311_buffer_setup_ops =3D {
+	.preenable =3D msa311_buffer_preenable,
+	.postdisable =3D msa311_buffer_postdisable,
+};
+
+static const struct iio_trigger_ops msa311_new_data_trig_ops =3D {
+	.set_trigger_state =3D msa311_set_new_data_trig_state,
+	.reenable =3D msa311_reenable,
+	.validate_device =3D msa311_validate_device,
+};
+
+/**
+ * msa311_probe() - MSA311 main I2C driver probe function
+ *
+ * @i2c: I2C client associated with MSA311 device
+ * @id: Matching device id
+ *
+ * @return: 0 on success
+ *          -ENOMEM due to memory allocation failures
+ *          -ERRNO in other failures
+ */
+static int msa311_probe(struct i2c_client *i2c,
+			const struct i2c_device_id *id)
+{
+	struct msa311_priv *msa311;
+	struct iio_dev *indio_dev;
+	int err;
+
+	indio_dev =3D devm_iio_device_alloc(&i2c->dev, sizeof(*msa311));
+	if (!indio_dev) {
+		dev_err(&i2c->dev, "iio device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	msa311 =3D iio_priv(indio_dev);
+	msa311->i2c =3D i2c;
+	i2c_set_clientdata(i2c, indio_dev);
+
+	indio_dev->dev.parent =3D &i2c->dev;
+
+	err =3D msa311_regmap_init(msa311);
+	if (err) {
+		dev_err(&i2c->dev, "cannot initialize regmap (%d)\n", err);
+		return err;
+	}
+
+	err =3D msa311_chip_init(msa311);
+	if (err)
+		return err;
+
+	mutex_init(&msa311->lock);
+
+	indio_dev->modes =3D INDIO_DIRECT_MODE; /* setup buffered mode later */
+	indio_dev->channels =3D msa311_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(msa311_channels);
+	indio_dev->name =3D i2c->name;
+	indio_dev->info =3D &msa311_info;
+
+	if (i2c->irq > 0) {
+		err =3D devm_request_threaded_irq(&i2c->dev, i2c->irq,
+						msa311_irq_handler,
+						msa311_irq_thread,
+						IRQF_TRIGGER_RISING,
+						i2c->name,
+						indio_dev);
+		if (err) {
+			dev_err(&i2c->dev, "failed to request irq (%d)\n", err);
+			goto err_lock_destroy;
+		}
+
+		msa311->new_data_trig =3D devm_iio_trigger_alloc(&i2c->dev,
+							       "%s-new-data",
+							       indio_dev->name);
+		if (!msa311->new_data_trig) {
+			dev_err(&i2c->dev, "cannot allocate new data trig\n");
+			err =3D -ENOMEM;
+			goto err_lock_destroy;
+		}
+
+		msa311->new_data_trig->dev.parent =3D &i2c->dev;
+		msa311->new_data_trig->ops =3D &msa311_new_data_trig_ops;
+		iio_trigger_set_drvdata(msa311->new_data_trig, indio_dev);
+		indio_dev->trig =3D msa311->new_data_trig;
+		err =3D devm_iio_trigger_register(&i2c->dev,
+						msa311->new_data_trig);
+		if (err) {
+			dev_err(&i2c->dev,
+				"failed to register new data trig (%d)\n", err);
+			goto err_lock_destroy;
+		}
+
+		err =3D devm_iio_triggered_buffer_setup(&i2c->dev,
+						      indio_dev,
+						      iio_pollfunc_store_time,
+						      msa311_buffer_thread,
+						      &msa311_buffer_setup_ops);
+		if (err) {
+			dev_err(&i2c->dev,
+				"failed to setup iio triggered buffer (%d)\n",
+				err);
+			goto err_lock_destroy;
+		}
+
+		err =3D msa311_setup_interrupts(msa311);
+		if (err) {
+			dev_err(&i2c->dev, "failed to setup interrupts (%d)\n",
+				err);
+			goto err_lock_destroy;
+		}
+	}
+
+	err =3D msa311_suspend_mode(msa311);
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"bad suspend pwr mode transition (%d)\n", err);
+		goto err_lock_destroy;
+	}
+
+	err =3D pm_runtime_set_active(&i2c->dev);
+	if (err) {
+		dev_err(&i2c->dev,
+			"failed to active runtime pm (%d)\n", err);
+		goto err_lock_destroy;
+	}
+
+	pm_runtime_enable(&i2c->dev);
+	pm_runtime_set_autosuspend_delay(&i2c->dev, MSA311_PWR_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(&i2c->dev);
+
+	err =3D devm_iio_device_register(&i2c->dev, indio_dev);
+	if (err) {
+		dev_err(&i2c->dev, "iio device register failed (%d)\n", err);
+		goto err_poweroff_msa311;
+	}
+
+	return err;
+
+err_poweroff_msa311:
+	pm_runtime_get_sync(&i2c->dev);
+	pm_runtime_disable(&i2c->dev);
+	pm_runtime_set_suspended(&i2c->dev);
+	pm_runtime_put_noidle(&i2c->dev);
+
+err_lock_destroy:
+	mutex_destroy(&msa311->lock);
+
+	return err;
+}
+
+/**
+ * msa311_remove() - MSA311 main I2C driver remove function
+ *
+ * @i2c: I2C client associated with MSA311 device
+ *
+ * @return: 0 all the time
+ */
+static int msa311_remove(struct i2c_client *i2c)
+{
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(i2c);
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+
+	pm_runtime_get_sync(&i2c->dev);
+	pm_runtime_disable(&i2c->dev);
+	pm_runtime_set_suspended(&i2c->dev);
+	pm_runtime_put_noidle(&i2c->dev);
+
+	mutex_lock(&msa311->lock);
+	msa311_suspend_mode(msa311);
+	mutex_unlock(&msa311->lock);
+
+	mutex_destroy(&msa311->lock);
+
+	return 0;
+}
+
+/**
+ * msa311_runtime_suspend() - MSA311 pm runtime suspend callback
+ *
+ * @dev: Device object associated with MSA311
+ *
+ * @return: 0 on success, -EAGAIN due to MSA311 pm errors, please try late=
r
+ */
+static int __maybe_unused msa311_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	int err;
+
+	dev_info(&msa311->i2c->dev, "suspending %s\n", dev->driver->name);
+
+	mutex_lock(&msa311->lock);
+	err =3D msa311_suspend_mode(msa311);
+	mutex_unlock(&msa311->lock);
+
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"failed to power off device (%d)\n", err);
+		err =3D -EAGAIN;
+	}
+
+	return err;
+}
+
+/**
+ * msa311_runtime_resume() - MSA311 pm runtime resume callback
+ *
+ * @dev: Device object associated with MSA311
+ *
+ * @return: 0 on success, -EAGAIN due to MSA311 pm errors, please try late=
r
+ */
+static int __maybe_unused msa311_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	int err;
+
+	dev_info(&msa311->i2c->dev, "resuming %s\n", dev->driver->name);
+
+	mutex_lock(&msa311->lock);
+	err =3D msa311_normal_mode(msa311);
+	mutex_unlock(&msa311->lock);
+
+	if (err) {
+		dev_err(&msa311->i2c->dev,
+			"failed to power on device (%d)\n", err);
+		err =3D -EAGAIN;
+	}
+
+	return err;
+}
+
+static const struct dev_pm_ops msa311_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(msa311_runtime_suspend,
+			   msa311_runtime_resume, NULL)
+};
+
+static const struct i2c_device_id msa311_i2c_id[] =3D {
+	{ .name =3D MSA311_DRV_NAME },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, msa311_i2c_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id msa311_of_match[] =3D {
+	{ .compatible =3D "memsensing,msa311" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, msa311_of_match);
+#else
+#define msa311_of_match NULL
+#endif
+
+static struct i2c_driver msa311_driver =3D {
+	.driver =3D {
+		.name =3D MSA311_DRV_NAME,
+		.owner =3D THIS_MODULE,
+		.of_match_table =3D of_match_ptr(msa311_of_match),
+		.pm =3D &msa311_pm_ops,
+	},
+	.probe		=3D msa311_probe,
+	.remove		=3D msa311_remove,
+	.id_table	=3D msa311_i2c_id,
+};
+
+module_i2c_driver(msa311_driver);
+
+MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
+MODULE_DESCRIPTION("MEMSensing MSA311 3-axis accelerometer driver");
+MODULE_LICENSE("GPL v2");
--=20
2.9.5
