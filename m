Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356C559C5B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiHVSFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiHVSFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:05:37 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9757B3D5B3;
        Mon, 22 Aug 2022 11:05:33 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0CEC61C0005; Mon, 22 Aug 2022 20:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1661191532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=4x8FTk92r5IzD3H/buqVA+fu/Gqh5ABcG2Cs8oExkQ8=;
        b=kpRQ6zKLSxr7WaDqovyVvF7+3kzxbPPIVj5BmRQbdJcyUWhSHXdAwT5qNVV/PXgVkzJsXI
        tZ14NsIQQFkCjePufTMeBl9zvMnv8V514MP7TN/ihHIptij1EJv8Q7ps8gzkzvWSvnCpak
        /MLyFyZcWpint/vIDhoEZjZtc1X0P1g=
Date:   Mon, 22 Aug 2022 20:05:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     icenowy@aosc.xyz, martijn@brixit.nl, megous@megous.com,
        kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, megi@xff.cz
Subject: gc2145 camera driver (front camera on PinePhone)
Message-ID: <20220822180531.GA27226@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'd like to mainline support for gc2145 camera on pinephone. So far I
did trivial cleanups over the Megi's driver. I started with 5.15
version from Mobian.  I guess yaml description of the binding needs to
be provided, too? (Would someone have a good starting point here?)

Any hints? Are there better starting points?

Best regards,
							Pavel

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 6157e73eef24..ead851b93e64 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -1390,6 +1390,15 @@ config VIDEO_S5C73M3
 	  This is a V4L2 sensor driver for Samsung S5C73M3
 	  8 Mpixel camera.
=20
+config VIDEO_GC2145
+	tristate "GalaxyCore GC2145 sensor support"
+	depends on I2C && VIDEO_V4L2
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a V4L2 sensor-level driver for GalaxyCore GC2145
+	  2 Mpixel camera.
+
 endmenu
=20
 menu "Lens drivers"
diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
index 83268f20aa3a..3916c2818522 100644
--- a/drivers/media/i2c/Makefile
+++ b/drivers/media/i2c/Makefile
@@ -133,4 +133,5 @@ obj-$(CONFIG_VIDEO_MAX9271_LIB)	+=3D max9271.o
 obj-$(CONFIG_VIDEO_RDACM20)	+=3D rdacm20.o
 obj-$(CONFIG_VIDEO_RDACM21)	+=3D rdacm21.o
 obj-$(CONFIG_VIDEO_ST_MIPID02) +=3D st-mipid02.o
+obj-$(CONFIG_VIDEO_GC2145)	+=3D gc2145.o
 obj-$(CONFIG_SDR_MAX2175) +=3D max2175.o
diff --git a/drivers/media/i2c/gc2145.c b/drivers/media/i2c/gc2145.c
new file mode 100644
index 000000000000..b110bb42da37
--- /dev/null
+++ b/drivers/media/i2c/gc2145.c
@@ -0,0 +1,1821 @@
+/*
+ * Galaxycore GC2145 driver.
+ * Copyright (C) 2018 Ond=C5=99ej Jirman <megi@xff.cz>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#define DEBUG
+
+#include <asm/div64.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/ctype.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-subdev.h>
+
+/*
+ * GC2145
+ * - 2M pixel
+ * - 1600 x 1200, max frame rate: 720P, 30fps@96MHz
+ * - Bayer RGB, RGB565, YCbCr 4:2:2
+ * - AE, AWB
+ * - PLL
+ * - AVDD 2.7-3V, DVDD 1.7-1.9V, IOVDD 1.7-3V
+ * - Power 180mW / 200uA standby
+ * - Interpolation, denoise, gamma, edge enhance
+ * I2C:
+ * - write reg8
+ * - read reg8
+ * - write reg8 multi
+ *
+ * Power on:
+ * MCLK on
+ * PWDN, RESET low
+ * IOVDD, AVDD, DVDD on in sequence
+ * RESET high
+ *
+ * Power off:
+ * PWDN, RESET low
+ * RESET high
+ * delay
+ * PWDN high
+ * RESET low
+ * IOVDD, AVDD, DVDD off
+ * PWDN low?
+ * MCLK off
+ *
+ * Init:
+ * - check chip id
+ * - setup pll
+ * - setup CSI interface / PAD drive strength
+ * - setup resolution/fps
+ * - enable postprocessing
+ *   (ISP related chapter)
+ *
+ * Stream on:
+ * - ???
+ */
+
+#define GC2145_FIRMWARE_PARAMETERS	"gc2145-init.bin"
+
+#define GC2145_SENSOR_WIDTH_MIN		88u
+#define GC2145_SENSOR_HEIGHT_MIN	72u
+
+/* 1616x1232 8H/16V dummy pixels on each side */
+#define GC2145_SENSOR_WIDTH_MAX		1600u
+#define GC2145_SENSOR_HEIGHT_MAX	1200u
+
+/* {{{ Register definitions */
+
+/* system registers */
+#define GC2145_REG_CHIP_ID			0xf0
+#define GC2145_REG_CHIP_ID_VALUE		0x2145
+
+#define GC2145_REG_PAD_IO		0xf2
+#define GC2145_REG_PLL_MODE1		0xf7
+#define GC2145_REG_PLL_MODE2		0xf8
+#define GC2145_REG_CM_MODE		0xf9
+#define GC2145_REG_CLK_DIV_MODE		0xfa
+#define GC2145_REG_ANALOG_PWC		0xfc
+#define GC2145_REG_SCALER_MODE		0xfd
+#define GC2145_REG_RESET		0xfe
+
+#define GC2145_P0_EXPOSURE_HI		0x03
+#define GC2145_P0_EXPOSURE_LO		0x04
+#define GC2145_P0_HBLANK_DELAY_HI	0x05
+#define GC2145_P0_HBLANK_DELAY_LO	0x06
+#define GC2145_P0_VBLANK_DELAY_HI	0x07
+#define GC2145_P0_VBLANK_DELAY_LO	0x08
+#define GC2145_P0_ROW_START_HI		0x09
+#define GC2145_P0_ROW_START_LO		0x0a
+#define GC2145_P0_COL_START_HI		0x0b
+#define GC2145_P0_COL_START_LO		0x0c
+#define GC2145_P0_WIN_HEIGHT_HI		0x0d
+#define GC2145_P0_WIN_HEIGHT_LO		0x0e
+#define GC2145_P0_WIN_WIDTH_HI		0x0f
+#define GC2145_P0_WIN_WIDTH_LO		0x10
+#define GC2145_P0_SH_DELAY_HI		0x11
+#define GC2145_P0_SH_DELAY_LO		0x12
+#define GC2145_P0_START_TIME		0x13
+#define GC2145_P0_END_TIME		0x14
+
+#define GC2145_P0_ISP_BLK_ENABLE1	0x80
+#define GC2145_P0_ISP_BLK_ENABLE2	0x81
+#define GC2145_P0_ISP_BLK_ENABLE3	0x82
+#define GC2145_P0_ISP_SPECIAL_EFFECT	0x83
+#define GC2145_P0_ISP_OUT_FORMAT	0x84
+#define GC2145_P0_FRAME_START		0x85
+#define GC2145_P0_SYNC_MODE		0x86
+#define GC2145_P0_ISP_BLK_ENABLE4	0x87
+#define GC2145_P0_ISP_MODULE_GATING	0x88
+#define GC2145_P0_ISP_BYPASS_MODE	0x89
+#define GC2145_P0_DEBUG_MODE2		0x8c
+#define GC2145_P0_DEBUG_MODE3		0x8d
+
+#define GC2145_P0_CROP_ENABLE		0x90
+#define GC2145_P0_CROP_Y1_HI		0x91
+#define GC2145_P0_CROP_Y1_LO		0x92
+#define GC2145_P0_CROP_X1_HI		0x93
+#define GC2145_P0_CROP_X1_LO		0x94
+#define GC2145_P0_CROP_WIN_HEIGHT_HI	0x95
+#define GC2145_P0_CROP_WIN_HEIGHT_LO	0x96
+#define GC2145_P0_CROP_WIN_WIDTH_HI	0x97
+#define GC2145_P0_CROP_WIN_WIDTH_LO	0x98
+
+#define GC2145_P0_SUBSAMPLE_RATIO	0x99
+#define GC2145_P0_SUBSAMPLE_MODE	0x9a
+#define GC2145_P0_SUB_ROW_N1		0x9b
+#define GC2145_P0_SUB_ROW_N2		0x9c
+#define GC2145_P0_SUB_ROW_N3		0x9d
+#define GC2145_P0_SUB_ROW_N4		0x9e
+#define GC2145_P0_SUB_COL_N1		0x9f
+#define GC2145_P0_SUB_COL_N2		0xa0
+#define GC2145_P0_SUB_COL_N3		0xa1
+#define GC2145_P0_SUB_COL_N4		0xa2
+#define GC2145_P0_OUT_BUF_ENABLE	0xc2
+
+/* }}} */
+
+struct gc2145_pixfmt {
+	u32 code;
+	u32 colorspace;
+	u8 fmt_setup;
+};
+
+static const struct gc2145_pixfmt gc2145_formats[] =3D {
+	{
+		.code              =3D MEDIA_BUS_FMT_UYVY8_2X8,
+		.colorspace        =3D V4L2_COLORSPACE_SRGB,
+		.fmt_setup         =3D 0x00,
+	},
+	{
+		.code              =3D MEDIA_BUS_FMT_VYUY8_2X8,
+		.colorspace        =3D V4L2_COLORSPACE_SRGB,
+		.fmt_setup         =3D 0x01,
+	},
+	{
+		.code              =3D MEDIA_BUS_FMT_YUYV8_2X8,
+		.colorspace        =3D V4L2_COLORSPACE_SRGB,
+		.fmt_setup         =3D 0x02,
+	},
+	{
+		.code              =3D MEDIA_BUS_FMT_YVYU8_2X8,
+		.colorspace        =3D V4L2_COLORSPACE_SRGB,
+		.fmt_setup         =3D 0x03,
+	},
+	{
+		.code              =3D MEDIA_BUS_FMT_RGB565_2X8_LE,
+		.colorspace        =3D V4L2_COLORSPACE_SRGB,
+		.fmt_setup         =3D 0x06,
+	},
+	{
+		.code              =3D MEDIA_BUS_FMT_SBGGR8_1X8,
+		.colorspace        =3D V4L2_COLORSPACE_RAW,
+		.fmt_setup         =3D 0x17,
+	},
+};
+
+static const struct gc2145_pixfmt *gc2145_find_format(u32 code)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(gc2145_formats); i++)
+		if (gc2145_formats[i].code =3D=3D code)
+			return &gc2145_formats[i];
+
+	return NULL;
+}
+
+/* regulator supplies */
+static const char * const gc2145_supply_name[] =3D {
+	"IOVDD", /* Digital I/O (1.7-3V) suppply */
+	"AVDD",  /* Analog (2.7-3V) supply */
+	"DVDD",  /* Digital Core (1.7-1.9V) supply */
+};
+
+#define GC2145_NUM_SUPPLIES ARRAY_SIZE(gc2145_supply_name)
+
+struct gc2145_ctrls {
+	struct v4l2_ctrl_handler handler;
+	struct {
+		struct v4l2_ctrl *auto_exposure;
+		struct v4l2_ctrl *exposure;
+		struct v4l2_ctrl *d_gain;
+		struct v4l2_ctrl *a_gain;
+	};
+	struct v4l2_ctrl *metering;
+	struct v4l2_ctrl *exposure_bias;
+	struct {
+		struct v4l2_ctrl *wb;
+		struct v4l2_ctrl *blue_balance;
+		struct v4l2_ctrl *red_balance;
+	};
+	struct v4l2_ctrl *aaa_lock;
+	struct v4l2_ctrl *hflip;
+	struct v4l2_ctrl *vflip;
+	struct v4l2_ctrl *pl_freq;
+	struct v4l2_ctrl *colorfx;
+	struct v4l2_ctrl *brightness;
+	struct v4l2_ctrl *saturation;
+	struct v4l2_ctrl *contrast;
+	struct v4l2_ctrl *gamma;
+	struct v4l2_ctrl *test_pattern;
+	struct v4l2_ctrl *test_data[4];
+};
+
+enum {
+	TX_WRITE =3D 1,
+	TX_WRITE16,
+	TX_UPDATE_BITS,
+};
+
+#define GC2145_MAX_OPS 64
+
+struct gc2145_tx_op {
+	int op;
+	u16 reg;
+	u16 val;
+	u16 mask;
+};
+
+struct gc2145_dev {
+	struct i2c_client *i2c_client;
+	struct v4l2_subdev sd;
+	struct media_pad pad;
+	struct v4l2_fwnode_endpoint ep; /* the parsed DT endpoint info */
+	struct clk *xclk; /* external clock for GC2145 */
+
+	struct regulator_bulk_data supplies[GC2145_NUM_SUPPLIES];
+	struct gpio_desc *reset_gpio; /* nrst pin */
+	struct gpio_desc *enable_gpio; /* ce pin */
+
+	/* lock to protect all members below */
+	struct mutex lock;
+
+	struct v4l2_mbus_framefmt fmt;
+	struct v4l2_fract frame_interval;
+	struct gc2145_ctrls ctrls;
+
+	bool pending_mode_change;
+	bool powered;
+	bool streaming;
+
+	u8 current_bank;
+
+	struct gc2145_tx_op ops[GC2145_MAX_OPS];
+	int n_ops;
+	int tx_started;
+};
+
+static inline struct gc2145_dev *to_gc2145_dev(struct v4l2_subdev *sd)
+{
+	return container_of(sd, struct gc2145_dev, sd);
+}
+
+/* {{{ Register access helpers */
+
+static int gc2145_write_regs(struct gc2145_dev *sensor, u8 addr,
+			     u8 *data, int data_size)
+{
+	struct i2c_client *client =3D sensor->i2c_client;
+	struct i2c_msg msg;
+	u8 buf[128 + 1];
+	int ret;
+
+	if (data_size > sizeof(buf) - 1) {
+		v4l2_err(&sensor->sd, "%s: oversized transfer (size=3D%d)\n",
+			 __func__, data_size);
+		return -EINVAL;
+	}
+
+	buf[0] =3D addr;
+	memcpy(buf + 1, data, data_size);
+
+	msg.addr =3D client->addr;
+	msg.flags =3D client->flags;
+	msg.buf =3D buf;
+	msg.len =3D data_size + 1;
+
+	dev_dbg(&sensor->i2c_client->dev, "[wr %02x] <=3D %*ph\n",
+		(u32)addr, data_size, data);
+
+	ret =3D i2c_transfer(client->adapter, &msg, 1);
+	if (ret < 0) {
+		v4l2_err(&sensor->sd,
+			 "%s: error %d: addr=3D%x, data=3D%*ph\n",
+			 __func__, ret, (u32)addr, data_size, data);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int gc2145_read_regs(struct gc2145_dev *sensor, u8 addr,
+			    u8 *data, int data_size)
+{
+	struct i2c_client *client =3D sensor->i2c_client;
+	struct i2c_msg msg[2];
+	int ret;
+
+	msg[0].addr =3D client->addr;
+	msg[0].flags =3D client->flags;
+	msg[0].buf =3D &addr;
+	msg[0].len =3D 1;
+
+	msg[1].addr =3D client->addr;
+	msg[1].flags =3D client->flags | I2C_M_RD;
+	msg[1].buf =3D data;
+	msg[1].len =3D data_size;
+
+	ret =3D i2c_transfer(client->adapter, msg, 2);
+	if (ret < 0) {
+		v4l2_err(&sensor->sd,
+			 "%s: error %d: start_index=3D%x, data_size=3D%d\n",
+			 __func__, ret, (u32)addr, data_size);
+		return ret;
+	}
+
+	dev_dbg(&sensor->i2c_client->dev, "[rd %02x] =3D> %*ph\n",
+		(u32)addr, data_size, data);
+
+	return 0;
+}
+
+static int gc2145_switch_bank(struct gc2145_dev *sensor, u16 reg)
+{
+	int ret;
+	u8 bank =3D reg >> 8;
+
+	if (bank & ~3u)
+		return -ERANGE;
+
+	if (sensor->current_bank !=3D bank) {
+		ret =3D gc2145_write_regs(sensor, GC2145_REG_RESET, &bank, 1);
+		if (ret)
+			return ret;
+
+		sensor->current_bank =3D bank;
+		dev_info(&sensor->i2c_client->dev, "bank switch: 0x%02x\n",
+				(unsigned int)sensor->current_bank);
+	}
+
+	return 0;
+}
+
+static int gc2145_read(struct gc2145_dev *sensor, u16 reg, u8 *val)
+{
+	int ret;
+
+	ret =3D gc2145_switch_bank(sensor, reg);
+	if (ret)
+		return ret;
+
+	return gc2145_read_regs(sensor, reg, val, 1);
+}
+
+static int gc2145_write(struct gc2145_dev *sensor, u16 reg, u8 val)
+{
+	int ret;
+
+	ret =3D gc2145_switch_bank(sensor, reg);
+	if (ret)
+		return ret;
+
+	if ((reg & 0xffu) =3D=3D GC2145_REG_RESET)
+		sensor->current_bank =3D val & 3;
+
+	return gc2145_write_regs(sensor, reg, &val, 1);
+}
+
+static int gc2145_update_bits(struct gc2145_dev *sensor, u16 reg, u8 mask,=
 u8 val)
+{
+	int ret;
+	u8 tmp;
+
+	ret =3D gc2145_read(sensor, reg, &tmp);
+	if (ret)
+		return ret;
+
+	tmp &=3D ~mask;
+	tmp |=3D val & mask;
+
+	return gc2145_write(sensor, reg, tmp);
+}
+
+static int gc2145_read16(struct gc2145_dev *sensor, u16 reg, u16 *val)
+{
+	int ret;
+
+	ret =3D gc2145_switch_bank(sensor, reg);
+	if (ret)
+		return ret;
+
+	ret =3D gc2145_read_regs(sensor, reg, (u8 *)val, sizeof(*val));
+	if (ret)
+		return ret;
+
+	*val =3D be16_to_cpu(*val);
+	return 0;
+}
+
+static int gc2145_write16(struct gc2145_dev *sensor, u16 reg, u16 val)
+{
+	u16 tmp =3D cpu_to_be16(val);
+	int ret;
+
+	ret =3D gc2145_switch_bank(sensor, reg);
+	if (ret)
+		return ret;
+
+	return gc2145_write_regs(sensor, reg, (u8 *)&tmp, sizeof(tmp));
+}
+
+static void gc2145_tx_start(struct gc2145_dev *sensor)
+{
+	if (sensor->tx_started++)
+		dev_err(&sensor->i2c_client->dev,
+				"tx_start called multiple times\n");
+
+	sensor->n_ops =3D 0;
+}
+
+static void gc2145_tx_add(struct gc2145_dev *sensor, int kind,
+			  u16 reg, u16 val, u16 mask)
+{
+	struct gc2145_tx_op *op;
+
+	if (!sensor->tx_started) {
+		dev_err(&sensor->i2c_client->dev,
+				"op added without calling tx_start\n");
+		return;
+	}
+
+	if (sensor->n_ops >=3D ARRAY_SIZE(sensor->ops)) {
+		dev_err(&sensor->i2c_client->dev,
+				"ops overflow, increase GC2145_MAX_OPS\n");
+		return;
+	}
+
+	op =3D &sensor->ops[sensor->n_ops++];
+	op->op =3D kind;
+	op->reg =3D reg;
+	op->val =3D val;
+	op->mask =3D mask;
+}
+
+static void gc2145_tx_write8(struct gc2145_dev *sensor, u16 reg, u8 val)
+{
+	return gc2145_tx_add(sensor, TX_WRITE, reg, val, 0);
+}
+
+static void gc2145_tx_write16(struct gc2145_dev *sensor, u16 reg, u16 val)
+{
+	return gc2145_tx_add(sensor, TX_WRITE16, reg, val, 0);
+}
+
+static void gc2145_tx_update_bits(struct gc2145_dev *sensor, u16 reg,
+				  u8 mask, u8 val)
+{
+	return gc2145_tx_add(sensor, TX_UPDATE_BITS, reg, val, mask);
+}
+
+static int gc2145_tx_commit(struct gc2145_dev *sensor)
+{
+	struct gc2145_tx_op* op;
+	int i, ret, n_ops;
+
+	if (!sensor->tx_started) {
+		dev_err(&sensor->i2c_client->dev,
+				"tx_commit called without tx_start\n");
+		return 0;
+	}
+
+	n_ops =3D sensor->n_ops;
+	sensor->tx_started =3D 0;
+	sensor->n_ops =3D 0;
+
+	for (i =3D 0; i < n_ops; i++) {
+		op =3D &sensor->ops[i];
+
+		switch (op->op) {
+		case TX_WRITE:
+			ret =3D gc2145_write(sensor, op->reg, op->val);
+			break;
+		case TX_WRITE16:
+			ret =3D gc2145_write16(sensor, op->reg, op->val);
+			break;
+		case TX_UPDATE_BITS:
+			ret =3D gc2145_update_bits(sensor, op->reg, op->mask, op->val);
+			break;
+		default:
+			dev_err(&sensor->i2c_client->dev, "invalid op at %d\n", i);
+			ret =3D -EINVAL;
+		}
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Efficiently write to a set of registers, using auto-increment
+ * when possible. User must not use address 0xff. To switch banks,
+ * use sequence: 0xfe, bank_no.
+ */
+static int gc2145_set_registers(struct gc2145_dev *sensor,
+				const uint8_t* data, size_t data_len)
+{
+	int ret =3D 0, i =3D 0;
+	u16 start, len;
+	u8 buf[128];
+
+	if (data_len % 2 !=3D 0) {
+		v4l2_err(&sensor->sd, "Register map has invalid size\n");
+		return -EINVAL;
+	}
+
+	/* we speed up communication by using auto-increment functionality */
+	while (i < data_len) {
+		start =3D data[i];
+		len =3D 0;
+
+		while (i < data_len && data[i] =3D=3D (start + len) &&
+		       len < sizeof(buf)) {
+			buf[len++] =3D data[i + 1];
+			i +=3D 2;
+		}
+
+		ret =3D gc2145_write_regs(sensor, start, buf, len);
+		if (ret)
+			return ret;
+	}
+
+	sensor->current_bank =3D 0xff;
+	return 0;
+}
+
+/*
+ * The firmware format:
+ * <record 0>, ..., <record N - 1>
+ * "record" is a 1-byte register address followed by 1-byte data
+ */
+static int gc2145_load_firmware(struct gc2145_dev *sensor, const char *nam=
e)
+{
+	const struct firmware *fw;
+	int ret;
+
+	ret =3D request_firmware(&fw, name, sensor->sd.v4l2_dev->dev);
+	if (ret) {
+		v4l2_warn(&sensor->sd,
+			  "Failed to read firmware %s, continuing anyway...\n",
+			  name);
+		return 1;
+	}
+
+	if (fw->size =3D=3D 0)
+		return 1;
+
+	ret =3D gc2145_set_registers(sensor, fw->data, fw->size);
+
+	release_firmware(fw);
+	return ret;
+}
+
+/* }}} */
+/* {{{ Controls */
+
+static inline struct v4l2_subdev *ctrl_to_sd(struct v4l2_ctrl *ctrl)
+{
+	return &container_of(ctrl->handler, struct gc2145_dev,
+			     ctrls.handler)->sd;
+}
+
+/* Exposure */
+
+static int gc2145_get_exposure(struct gc2145_dev *sensor)
+{
+	struct gc2145_ctrls *ctrls =3D &sensor->ctrls;
+	u8 again, dgain;
+	u16 exp;
+	int ret;
+
+	ret =3D gc2145_read(sensor, 0xb1, &again);
+	if (ret)
+		return ret;
+
+	ret =3D gc2145_read(sensor, 0xb2, &dgain);
+	if (ret)
+		return ret;
+
+	ret =3D gc2145_read16(sensor, 0x03, &exp);
+	if (ret)
+		return ret;
+
+	ctrls->exposure->val =3D exp;
+	ctrls->d_gain->val =3D dgain;
+	ctrls->a_gain->val =3D again;
+
+	return 0;
+}
+
+#define AE_BIAS_MENU_DEFAULT_VALUE_INDEX 4
+static const s64 ae_bias_menu_values[] =3D {
+	-4000, -3000, -2000, -1000, 0, 1000, 2000, 3000, 4000
+};
+
+static const s8 ae_bias_menu_reg_values[] =3D {
+	0x55, 0x60, 0x65, 0x70, 0x7b, 0x85, 0x90, 0x95, 0xa0
+};
+
+static int gc2145_set_exposure(struct gc2145_dev *sensor)
+{
+	struct gc2145_ctrls *ctrls =3D &sensor->ctrls;
+	bool is_auto =3D (ctrls->auto_exposure->val !=3D V4L2_EXPOSURE_MANUAL);
+
+	gc2145_tx_start(sensor);
+
+	if (ctrls->auto_exposure->is_new) {
+		gc2145_tx_write8(sensor, 0xb6, is_auto ? 1 : 0);
+	}
+
+	if (!is_auto && ctrls->exposure->is_new)
+		gc2145_tx_write16(sensor, 0x03, ctrls->exposure->val);
+
+	if (!is_auto && ctrls->d_gain->is_new)
+		gc2145_tx_write8(sensor, 0xb2, ctrls->d_gain->val);
+
+	if (!is_auto && ctrls->a_gain->is_new)
+		gc2145_tx_write8(sensor, 0xb1, ctrls->a_gain->val);
+
+	return gc2145_tx_commit(sensor);;
+}
+
+/* Test patterns */
+
+enum {
+	GC2145_TEST_PATTERN_DISABLED,
+	GC2145_TEST_PATTERN_VGA_COLOR_BARS,
+	GC2145_TEST_PATTERN_UXGA_COLOR_BARS,
+	GC2145_TEST_PATTERN_SKIN_MAP,
+	GC2145_TEST_PATTERN_SOLID_COLOR,
+};
+
+static const char * const test_pattern_menu[] =3D {
+	"Disabled",
+	"VGA color bars",
+	"UXGA color bars",
+	"Skin map",
+	"Solid black color",
+	"Solid light gray color",
+	"Solid gray color",
+	"Solid dark gray color",
+	"Solid white color",
+	"Solid red color",
+	"Solid green color",
+	"Solid blue color",
+	"Solid yellow color",
+	"Solid cyan color",
+	"Solid magenta color",
+};
+
+static int gc2145_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct v4l2_subdev *sd =3D ctrl_to_sd(ctrl);
+	struct gc2145_dev *sensor =3D to_gc2145_dev(sd);
+	int ret;
+
+	/* v4l2_ctrl_lock() locks our own mutex */
+
+	if (!sensor->powered)
+		return -EIO;
+
+	switch (ctrl->id) {
+	case V4L2_CID_EXPOSURE_AUTO:
+		ret =3D gc2145_get_exposure(sensor);
+		if (ret)
+			return ret;
+		break;
+	default:
+		dev_err(&sensor->i2c_client->dev, "getting unknown control %d\n", ctrl->=
id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gc2145_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct v4l2_subdev *sd =3D ctrl_to_sd(ctrl);
+	struct gc2145_dev *sensor =3D to_gc2145_dev(sd);
+	struct gc2145_ctrls *ctrls =3D &sensor->ctrls;
+	s32 val =3D ctrl->val;
+	unsigned int i;
+	int ret;
+	u8 test1, test2;
+
+	/* v4l2_ctrl_lock() locks our own mutex */
+
+	/*
+	 * If the device is not powered up by the host driver do
+	 * not apply any controls to H/W at this time. Instead
+	 * the controls will be restored right after power-up.
+	 */
+	if (!sensor->powered)
+		return 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_EXPOSURE_AUTO:
+		return gc2145_set_exposure(sensor);
+
+	case V4L2_CID_AUTO_EXPOSURE_BIAS:
+		if (val < 0 || val >=3D ARRAY_SIZE(ae_bias_menu_reg_values)) {
+			dev_err(&sensor->i2c_client->dev, "ae bias out of range\n");
+			return -EINVAL;
+		}
+
+		return gc2145_write(sensor, 0x113,
+				    (u8)ae_bias_menu_reg_values[val]);
+
+	case V4L2_CID_VFLIP:
+		return gc2145_update_bits(sensor, 0x17, BIT(1), val ? BIT(1) : 0);
+
+	case V4L2_CID_HFLIP:
+		return gc2145_update_bits(sensor, 0x17, BIT(0), val ? BIT(0) : 0);
+
+	case V4L2_CID_TEST_PATTERN:
+		for (i =3D 0; i < ARRAY_SIZE(ctrls->test_data); i++)
+			v4l2_ctrl_activate(ctrls->test_data[i],
+					   val =3D=3D 6); /* solid color */
+
+		test1 =3D 0;
+		test2 =3D 0x01;
+
+		if (val =3D=3D GC2145_TEST_PATTERN_VGA_COLOR_BARS)
+			test1 =3D 0x04;
+		else if (val =3D=3D GC2145_TEST_PATTERN_UXGA_COLOR_BARS)
+			test1 =3D 0x44;
+		else if (val =3D=3D GC2145_TEST_PATTERN_SKIN_MAP)
+			test1 =3D 0x10;
+		else if (val >=3D GC2145_TEST_PATTERN_SOLID_COLOR) {
+			test1 =3D 0x04;
+			test2 =3D ((val - GC2145_TEST_PATTERN_SOLID_COLOR) << 4) | 0x8;
+		} else if (val !=3D GC2145_TEST_PATTERN_DISABLED) {
+			dev_err(&sensor->i2c_client->dev, "test pattern out of range\n");
+			return -EINVAL;
+		}
+
+		ret =3D gc2145_write(sensor, 0x8c, test1);
+		if (ret)
+			return ret;
+
+		return gc2145_write(sensor, 0x8d, test2);
+
+	default:
+		dev_err(&sensor->i2c_client->dev, "setting unknown control %d\n", ctrl->=
id);
+		return -EINVAL;
+	}
+}
+
+static const struct v4l2_ctrl_ops gc2145_ctrl_ops =3D {
+	.g_volatile_ctrl =3D gc2145_g_volatile_ctrl,
+	.s_ctrl =3D gc2145_s_ctrl,
+};
+
+static int gc2145_init_controls(struct gc2145_dev *sensor)
+{
+	const struct v4l2_ctrl_ops *ops =3D &gc2145_ctrl_ops;
+	struct gc2145_ctrls *ctrls =3D &sensor->ctrls;
+	struct v4l2_ctrl_handler *hdl =3D &ctrls->handler;
+	int ret;
+
+	v4l2_ctrl_handler_init(hdl, 32);
+
+	/* we can use our own mutex for the ctrl lock */
+	hdl->lock =3D &sensor->lock;
+
+	/* Exposure controls */
+	ctrls->auto_exposure =3D v4l2_ctrl_new_std_menu(hdl, ops,
+						      V4L2_CID_EXPOSURE_AUTO,
+						      V4L2_EXPOSURE_MANUAL, 0,
+						      V4L2_EXPOSURE_AUTO);
+	ctrls->exposure =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_EXPOSURE,
+					    1, 0x1fff, 1, 0x80);
+	ctrls->a_gain =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_ANALOGUE_GAIN,
+					  0, 255, 1, 0x20);
+	ctrls->d_gain =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_DIGITAL_GAIN,
+					  0, 255, 1, 0x40);
+	ctrls->exposure_bias =3D
+		v4l2_ctrl_new_int_menu(hdl, ops, V4L2_CID_AUTO_EXPOSURE_BIAS,
+				       ARRAY_SIZE(ae_bias_menu_values) - 1,
+				       AE_BIAS_MENU_DEFAULT_VALUE_INDEX,
+				       ae_bias_menu_values);
+
+	/* V/H flips */
+	ctrls->hflip =3D v4l2_ctrl_new_std(hdl, ops,
+					 V4L2_CID_HFLIP, 0, 1, 1, 0);
+	ctrls->vflip =3D v4l2_ctrl_new_std(hdl, ops,
+					 V4L2_CID_VFLIP, 0, 1, 1, 0);
+
+
+	/* Test patterns */
+	ctrls->test_pattern =3D
+		v4l2_ctrl_new_std_menu_items(hdl, ops, V4L2_CID_TEST_PATTERN,
+					     ARRAY_SIZE(test_pattern_menu) - 1,
+					     0, 0, test_pattern_menu);
+
+	v4l2_ctrl_auto_cluster(4, &ctrls->auto_exposure, V4L2_EXPOSURE_MANUAL,
+			       true);
+
+	if (hdl->error) {
+		ret =3D hdl->error;
+		goto free_ctrls;
+	}
+
+	sensor->sd.ctrl_handler =3D hdl;
+	return 0;
+
+free_ctrls:
+	v4l2_ctrl_handler_free(hdl);
+	return ret;
+}
+
+/* }}} */
+/* {{{ Video ops */
+
+static int gc2145_g_frame_interval(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_frame_interval *fi)
+{
+	struct gc2145_dev *sensor =3D to_gc2145_dev(sd);
+
+	if (fi->pad !=3D 0)
+		return -EINVAL;
+
+	mutex_lock(&sensor->lock);
+	fi->interval =3D sensor->frame_interval;
+	mutex_unlock(&sensor->lock);
+
+	return 0;
+}
+
+static int gc2145_s_frame_interval(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_frame_interval *fi)
+{
+	struct gc2145_dev *sensor =3D to_gc2145_dev(sd);
+	int ret =3D 0, fps;
+
+	if (fi->pad !=3D 0)
+		return -EINVAL;
+
+	mutex_lock(&sensor->lock);
+
+	/* user requested infinite frame rate */
+	if (fi->interval.numerator =3D=3D 0)
+		fps =3D 60;
+	else
+		fps =3D DIV_ROUND_CLOSEST(fi->interval.denominator,
+					fi->interval.numerator);
+
+	fps =3D clamp(fps, 1, 60);
+
+	sensor->frame_interval.numerator =3D 1;
+	sensor->frame_interval.denominator =3D fps;
+	fi->interval =3D sensor->frame_interval;
+
+	mutex_unlock(&sensor->lock);
+	return ret;
+}
+
+static int gc2145_set_2pclk(struct gc2145_dev *sensor,
+			    unsigned long *freq, bool apply)
+{
+	unsigned long pll_mult, pll_mult_max, pclk_div, pclk2,
+		      mclk;
+	unsigned long pll_mult_best =3D 0, pclk_div_best =3D 0, diff_best =3D ULO=
NG_MAX, diff,
+		      pclk2_best =3D 0;
+	int mclk_div2_en;
+	int mclk_div2_en_best =3D 0;
+
+	mclk =3D clk_get_rate(sensor->xclk);
+	if (mclk =3D=3D 0)
+		return -EINVAL;
+
+        for (mclk_div2_en =3D 0; mclk_div2_en <=3D 1; mclk_div2_en++) {
+		pll_mult_max =3D 768000000 / 4 / (mclk / (mclk_div2_en ? 2 : 1));
+		if (pll_mult_max > 32)
+			pll_mult_max =3D 32;
+
+		for (pll_mult =3D 2; pll_mult <=3D pll_mult_max; pll_mult++) {
+			for (pclk_div =3D 1; pclk_div <=3D 8; pclk_div++) {
+				pclk2 =3D mclk / (mclk_div2_en ? 2 : 1) * pll_mult / pclk_div;
+
+				if (pclk2 > *freq)
+					continue;
+
+				diff =3D *freq - pclk2;
+
+				if (diff < diff_best) {
+					diff_best =3D diff;
+					pclk2_best =3D pclk2;
+
+					pll_mult_best =3D pll_mult;
+					pclk_div_best =3D pclk_div;
+					mclk_div2_en_best =3D mclk_div2_en;
+				}
+
+				if (diff =3D=3D 0)
+					goto found;
+			}
+		}
+	}
+
+	if (diff_best =3D=3D ULONG_MAX)
+		return -1;
+
+found:
+	*freq =3D pclk2_best;
+	if (!apply)
+		return 0;
+
+	gc2145_tx_start(sensor);
+
+	gc2145_tx_write8(sensor, 0xf7,
+			 ((pclk_div_best - 1)) << 4 |
+			 (mclk_div2_en_best << 1) | BIT(0) /* pll_en */);
+	gc2145_tx_write8(sensor, 0xf8, BIT(7) | (pll_mult_best - 1));
+	gc2145_tx_write8(sensor, 0xfa,
+			 (pclk_div_best - 1) << 4 |
+			 (((pclk_div_best - 1) / 2) & 0xf));
+
+	return gc2145_tx_commit(sensor);
+}
+
+static int gc2145_setup_awb(struct gc2145_dev *sensor,
+			     u16 x1, u16 y1, u16 x2, u16 y2)
+{
+	int ratio =3D 8;
+
+	gc2145_tx_start(sensor);
+
+	/* disable awb */
+	gc2145_tx_update_bits(sensor, 0x82, BIT(1), 0);
+
+	/* reset white balance RGB gains */
+	gc2145_tx_write8(sensor, 0xb3, 0x40);
+	gc2145_tx_write8(sensor, 0xb4, 0x40);
+	gc2145_tx_write8(sensor, 0xb5, 0x40);
+
+	/* awb window */
+	gc2145_tx_write8(sensor, 0x1ec, x1 / ratio);
+	gc2145_tx_write8(sensor, 0x1ed, y1 / ratio);
+	gc2145_tx_write8(sensor, 0x1ee, x2 / ratio);
+	gc2145_tx_write8(sensor, 0x1ef, y2 / ratio);
+
+	/* eanble awb */
+	gc2145_tx_update_bits(sensor, 0x82, BIT(1), BIT(1));
+
+	return gc2145_tx_commit(sensor);
+}
+
+static int gc2145_setup_aec(struct gc2145_dev *sensor,
+			     u16 x1, u16 y1, u16 x2, u16 y2,
+			     u16 cx1, u16 cy1, u16 cx2, u16 cy2)
+{
+        u16 x_ratio =3D 8;
+
+	gc2145_tx_start(sensor);
+
+	/* disable AEC */
+	gc2145_tx_write8(sensor, 0xb6, 0);
+
+	/* set reasonable initial exposure and gains */
+	gc2145_tx_write16(sensor, 0x03, 1200);
+	gc2145_tx_write8(sensor, 0xb1, 0x20);
+	gc2145_tx_write8(sensor, 0xb2, 0xe0);
+
+	/* setup measure window */
+	gc2145_tx_write8(sensor, 0x101, x1 / x_ratio);
+	gc2145_tx_write8(sensor, 0x102, x2 / x_ratio);
+	gc2145_tx_write8(sensor, 0x103, y1 / 8);
+	gc2145_tx_write8(sensor, 0x104, y2 / 8);
+
+	/* setup center */
+	gc2145_tx_write8(sensor, 0x105, cx1 / x_ratio);
+	gc2145_tx_write8(sensor, 0x106, cx2 / x_ratio);
+	gc2145_tx_write8(sensor, 0x107, cy1 / 8);
+	gc2145_tx_write8(sensor, 0x108, cy2 / 8);
+
+	/* enable AEC again */
+	gc2145_tx_write8(sensor, 0xb6, 1);
+
+	return gc2145_tx_commit(sensor);
+}
+
+struct gc2145_sensor_params {
+	unsigned int enable_scaler;
+	unsigned int col_scaler_only;
+	unsigned int row_skip;
+	unsigned int col_skip;
+	unsigned long sh_delay;
+	unsigned long hb;
+	unsigned long vb;
+	unsigned long st;
+	unsigned long et;
+	unsigned long win_width;
+	unsigned long win_height;
+	unsigned long width;
+	unsigned long height;
+};
+
+static void gc2145_sensor_params_init(struct gc2145_sensor_params* p, int =
width, int height)
+{
+	p->win_height =3D height + 32;
+	p->win_width =3D (width + 16);
+	p->width =3D width;
+	p->height =3D height;
+	p->st =3D 2;
+	p->et =3D 2;
+	p->vb =3D 8;
+	p->hb =3D 0x1f0;
+	p->sh_delay =3D 30;
+}
+
+/* unit is PCLK periods */
+static unsigned long
+gc2145_sensor_params_get_row_period(struct gc2145_sensor_params* p)
+{
+	return 2 * (p->win_width / 2 / (p->col_skip + 1) + p->sh_delay + p->hb + =
4);
+}
+
+static unsigned long
+gc2145_sensor_params_get_frame_period(struct gc2145_sensor_params* p)
+{
+	unsigned long rt =3D gc2145_sensor_params_get_row_period(p);
+
+	return rt * (p->vb + p->win_height) / (p->row_skip + 1);
+}
+
+static void
+gc2145_sensor_params_fit_hb_to_power_line_period(struct gc2145_sensor_para=
ms* p,
+					  unsigned long power_line_freq,
+					  unsigned long pclk)
+{
+	unsigned long rt, power_line_ratio;
+
+        for (p->hb =3D 0x1f0; p->hb < 2047; p->hb++) {
+		rt =3D gc2145_sensor_params_get_row_period(p);
+
+		/* power_line_ratio is row_freq / power_line_freq * 1000 */
+                power_line_ratio =3D pclk / power_line_freq * 1000 / rt;
+
+		/* if we're close enough, stop the search */
+                if (power_line_ratio % 1000 < 50)
+                        break;
+        }
+
+	/* finding the optimal Hb is not critical */
+	if (p->hb =3D=3D 2047)
+		p->hb =3D 0x1f0;
+}
+
+static void
+gc2145_sensor_params_fit_vb_to_frame_period(struct gc2145_sensor_params* p,
+				     unsigned long frame_period)
+{
+	unsigned long rt, fp;
+
+	p->vb =3D 8;
+	rt =3D gc2145_sensor_params_get_row_period(p);
+	fp =3D gc2145_sensor_params_get_frame_period(p);
+
+	if (frame_period > fp)
+		p->vb =3D frame_period * (p->row_skip + 1) / rt - p->win_height;
+
+	if (p->vb > 4095)
+		p->vb =3D 4095;
+}
+
+static int gc2145_sensor_params_apply(struct gc2145_dev *sensor,
+				      struct gc2145_sensor_params* p)
+{
+	u32 off_x =3D (GC2145_SENSOR_WIDTH_MAX - p->width) / 2;
+	u32 off_y =3D (GC2145_SENSOR_HEIGHT_MAX - p->height) / 2;
+
+	gc2145_tx_start(sensor);
+
+	gc2145_tx_write8(sensor, 0xfd, (p->enable_scaler ? BIT(0) : 0)
+			| (p->col_scaler_only ? BIT(1) : 0));
+
+	gc2145_tx_write8(sensor, 0x18, 0x0a
+		       | (p->col_skip ? BIT(7) : 0)
+		       | (p->row_skip ? BIT(6) : 0));
+
+	gc2145_tx_write16(sensor, 0x09, off_y);
+	gc2145_tx_write16(sensor, 0x0b, off_x);
+	gc2145_tx_write16(sensor, 0x0d, p->win_height);
+	gc2145_tx_write16(sensor, 0x0f, p->win_width);
+	gc2145_tx_write16(sensor, 0x05, p->hb);
+	gc2145_tx_write16(sensor, 0x07, p->vb);
+	gc2145_tx_write16(sensor, 0x11, p->sh_delay);
+
+	gc2145_tx_write8(sensor, 0x13, p->st);
+	gc2145_tx_write8(sensor, 0x14, p->et);
+
+	return gc2145_tx_commit(sensor);
+}
+
+static int gc2145_setup_mode(struct gc2145_dev *sensor)
+{
+	int scaling_desired, ret, pad, i;
+	struct gc2145_sensor_params params =3D {0};
+	unsigned long pclk2, frame_period;
+	unsigned long power_line_freq =3D 50;
+	unsigned long width =3D sensor->fmt.width;
+	unsigned long height =3D sensor->fmt.height;
+	unsigned long framerate =3D sensor->frame_interval.denominator;
+	const struct gc2145_pixfmt *pix_fmt;
+	unsigned long rt, ft, ft_rt;
+
+	pix_fmt =3D gc2145_find_format(sensor->fmt.code);
+	if (!pix_fmt) {
+		dev_err(&sensor->i2c_client->dev,
+			"pixel format not supported %u\n", sensor->fmt.code);
+		return -EINVAL;
+	}
+
+        /*
+	 * Equations for calculating framerate are:
+	 *
+	 *    ww =3D width + 16
+	 *    wh =3D height + 32
+	 *    Rt =3D (ww / 2 / (col_skip + 1) + sh_delay + Hb + 4)
+	 *    Ft =3D Rt * (Vb + wh) / (row_skip + 1)
+	 *    framerate =3D 2pclk / 4 / Ft
+	 *
+	 * Based on these equations:
+	 *
+	 * 1) First we need to determine what 2PCLK frequency to use. The 2PCLK
+	 *    frequency is not arbitrarily precise, so we need to calculate the
+	 *    actual frequency used, after setting our target frequency.
+	 *
+	 *    We use a simple heuristic:
+	 *
+	 *      If pixel_count * 2 * framerate * 1.15 is > 40MHz, we use 60MHz,
+	 *      otherwise we use 40MHz.
+	 *
+	 * 2) We want to determine lowest Hb that we can use to extend row
+	 *    period so that row time takes an integer fraction of the power
+	 *    line frequency period. Minimum Hb is 0x1f0.
+	 *
+	 * 3) If the requested resolution is less than half the sensor's size,
+	 *    we'll use scaling, or row skipping + column scaling, or row and
+	 *    column skiping, depending on what allows us to achieve the
+	 *    requested framerate.
+         *
+	 * 4) We use the selected Hb to calculate Vb value that will give
+	 *    us the desired framerate, given the scaling/skipping option
+	 *    selected in 3).
+	 */
+
+	scaling_desired =3D width <=3D GC2145_SENSOR_WIDTH_MAX / 2
+			&& height <=3D GC2145_SENSOR_HEIGHT_MAX / 2;
+
+	pclk2 =3D 60000000;
+
+	ret =3D gc2145_set_2pclk(sensor, &pclk2, false);
+	if (ret < 0)
+		return ret;
+
+	gc2145_sensor_params_init(&params, width, height);
+
+	/*
+	 * if the resolution is < half the sensor size, enable the scaler
+	 * to cover more area of the chip
+	 */
+	if (scaling_desired) {
+		params.enable_scaler =3D 1;
+		pclk2 *=3D 2;
+		gc2145_sensor_params_init(&params, width * 2, height * 2);
+	}
+
+	/* we need to call this each time pclk or power_line_freq is changed */
+	gc2145_sensor_params_fit_hb_to_power_line_period(&params,
+							 power_line_freq,
+							 pclk2 / 2);
+
+	frame_period =3D gc2145_sensor_params_get_frame_period(&params);
+	if (framerate <=3D pclk2 / 2 / frame_period)
+		goto apply;
+
+	if (scaling_desired) {
+		/* try using just the column scaler + row skip */
+		params.col_scaler_only =3D 1;
+		params.row_skip =3D 1;
+		gc2145_sensor_params_fit_hb_to_power_line_period(&params,
+								 power_line_freq,
+								 pclk2 / 2);
+
+		frame_period =3D gc2145_sensor_params_get_frame_period(&params);
+		if (framerate <=3D pclk2 / 2 / frame_period)
+			goto apply;
+	}
+
+apply:
+        /* adjust vb to fit the target framerate */
+	gc2145_sensor_params_fit_vb_to_frame_period(&params,
+						    pclk2 / 2 / framerate);
+
+	gc2145_sensor_params_apply(sensor, &params);
+
+	ret =3D gc2145_set_2pclk(sensor, &pclk2, true);
+	if (ret < 0)
+		return ret;
+
+	pad =3D (width > 256 && height > 256) ? 32 : 16;
+
+	ret =3D gc2145_setup_awb(sensor, pad, pad, width - pad * 2, height - pad =
* 2);
+	if (ret)
+		return ret;
+
+	ret =3D gc2145_setup_aec(sensor,
+				pad, pad, width - pad * 2, height - pad * 2,
+				2 * pad, 2 * pad, width - pad * 4, height - pad * 4);
+	if (ret)
+		return ret;
+
+	gc2145_tx_start(sensor);
+
+	rt =3D gc2145_sensor_params_get_row_period(&params);
+	ft =3D gc2145_sensor_params_get_frame_period(&params);
+	ft_rt =3D ft / rt / 4;
+
+	for (i =3D 0; i < 7; i++) {
+		/* exposure settings for exposure levels */
+		gc2145_tx_write16(sensor, 0x127 + 2 * i, ft_rt * (i + 1));
+		/* max dg gains */
+		gc2145_tx_write8(sensor, 0x135 + i, 0x50);
+	}
+
+	/*  max analog gain */
+	gc2145_tx_write8(sensor, 0x11f, 0x50);
+	/*  max digital gain */
+	gc2145_tx_write8(sensor, 0x120, 0xe0);
+
+	gc2145_tx_write8(sensor, GC2145_P0_ISP_OUT_FORMAT, pix_fmt->fmt_setup);
+
+	/*  set gamma curve */
+	gc2145_tx_update_bits(sensor, 0x80, BIT(6), BIT(6));
+
+	/*  disable denoising */
+	gc2145_tx_update_bits(sensor, 0x80, BIT(2), 0);
+
+	/*  drive strength */
+	gc2145_tx_write8(sensor, 0x24,
+			 (pclk2 / (params.enable_scaler + 1)) > 40000000 ?
+				0xff : 0x55);
+
+	return gc2145_tx_commit(sensor);
+}
+
+static int gc2145_set_stream(struct gc2145_dev *sensor, int enable)
+{
+	gc2145_tx_start(sensor);
+	gc2145_tx_write8(sensor, GC2145_REG_PAD_IO, enable ? 0x0f : 0);
+
+	return gc2145_tx_commit(sensor);
+}
+
+static int gc2145_s_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct gc2145_dev *sensor =3D to_gc2145_dev(sd);
+	int ret =3D 0;
+
+	mutex_lock(&sensor->lock);
+
+	if (sensor->streaming =3D=3D !enable) {
+		if (enable && sensor->pending_mode_change) {
+			ret =3D gc2145_setup_mode(sensor);
+			if (ret)
+				goto out;
+		}
+
+		ret =3D gc2145_set_stream(sensor, enable);
+		if (ret)
+			goto out;
+
+		sensor->streaming =3D !!enable;
+	}
+
+out:
+	mutex_unlock(&sensor->lock);
+	return ret;
+}
+
+/* }}} */
+/* {{{ Pad ops */
+
+static int gc2145_enum_mbus_code(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *sd_state,
+				 struct v4l2_subdev_mbus_code_enum *code)
+{
+	if (code->pad !=3D 0 || code->index >=3D ARRAY_SIZE(gc2145_formats))
+		return -EINVAL;
+
+	code->code =3D gc2145_formats[code->index].code;
+
+	return 0;
+}
+
+static int gc2145_enum_frame_size(struct v4l2_subdev *sd,
+				  struct v4l2_subdev_state *sd_state,
+				  struct v4l2_subdev_frame_size_enum *fse)
+{
+	if (fse->pad !=3D 0 || fse->index > 0)
+		return -EINVAL;
+
+	fse->min_width =3D GC2145_SENSOR_WIDTH_MIN;
+	fse->max_width =3D GC2145_SENSOR_WIDTH_MAX;
+
+	fse->min_height =3D GC2145_SENSOR_HEIGHT_MIN;
+	fse->max_height =3D GC2145_SENSOR_HEIGHT_MAX;
+
+	return 0;
+}
+
+static int gc2145_enum_frame_interval(
+	struct v4l2_subdev *sd,
+	struct v4l2_subdev_state *sd_state,
+	struct v4l2_subdev_frame_interval_enum *fie)
+{
+	if (fie->pad !=3D 0 || fie->index > 0)
+		return -EINVAL;
+
+	fie->interval.numerator =3D 1;
+	fie->interval.denominator =3D 30;
+
+	return 0;
+}
+
+static int gc2145_get_fmt(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *sd_state,
+			  struct v4l2_subdev_format *format)
+{
+	struct gc2145_dev *sensor =3D to_gc2145_dev(sd);
+	struct v4l2_mbus_framefmt *mf;
+
+	if (format->pad !=3D 0)
+		return -EINVAL;
+
+	if (format->which =3D=3D V4L2_SUBDEV_FORMAT_TRY) {
+		mf =3D v4l2_subdev_get_try_format(sd, sd_state, format->pad);
+		format->format =3D *mf;
+		return 0;
+	}
+
+	mutex_lock(&sensor->lock);
+	format->format =3D sensor->fmt;
+	mutex_unlock(&sensor->lock);
+
+	return 0;
+}
+
+static int gc2145_set_fmt(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *sd_state,
+			  struct v4l2_subdev_format *format)
+{
+	struct gc2145_dev *sensor =3D to_gc2145_dev(sd);
+	struct v4l2_mbus_framefmt *mf =3D &format->format;
+	const struct gc2145_pixfmt *pixfmt;
+	int ret =3D 0;
+
+	if (format->pad !=3D 0)
+		return -EINVAL;
+
+	/* check if we support requested mbus fmt */
+	pixfmt =3D gc2145_find_format(mf->code);
+	if (!pixfmt)
+		pixfmt =3D &gc2145_formats[0];
+
+	mf->code =3D pixfmt->code;
+	mf->colorspace =3D pixfmt->colorspace;
+	mf->xfer_func =3D V4L2_XFER_FUNC_DEFAULT;
+	mf->ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT;
+	mf->quantization =3D V4L2_QUANTIZATION_DEFAULT;
+	mf->field =3D V4L2_FIELD_NONE;
+
+	mutex_lock(&sensor->lock);
+
+	mf->width =3D clamp(mf->width, GC2145_SENSOR_WIDTH_MIN,
+		      GC2145_SENSOR_WIDTH_MAX);
+	mf->height =3D clamp(mf->height, GC2145_SENSOR_HEIGHT_MIN,
+		       GC2145_SENSOR_HEIGHT_MAX);
+
+	if (format->which =3D=3D V4L2_SUBDEV_FORMAT_TRY) {
+		struct v4l2_mbus_framefmt *try_mf;
+
+		try_mf =3D v4l2_subdev_get_try_format(sd, sd_state, format->pad);
+		*try_mf =3D *mf;
+		goto out;
+	}
+
+	if (sensor->streaming) {
+		ret =3D -EBUSY;
+		goto out;
+	}
+
+	sensor->fmt =3D *mf;
+	sensor->pending_mode_change =3D true;
+out:
+	mutex_unlock(&sensor->lock);
+	return ret;
+}
+
+/* }}} */
+/* {{{ Core Ops */
+
+static int gc2145_configure(struct gc2145_dev *sensor)
+{
+	struct v4l2_fwnode_bus_parallel *bus =3D &sensor->ep.bus.parallel;
+	u8 sync_mode =3D 0;
+	u16 chip_id;
+	int ret;
+
+	ret =3D gc2145_read16(sensor, GC2145_REG_CHIP_ID, &chip_id);
+	if (ret)
+		return ret;
+
+	dev_info(&sensor->i2c_client->dev, "device id: 0x%04x\n",
+		 (unsigned int)chip_id);
+
+	if (chip_id !=3D GC2145_REG_CHIP_ID_VALUE) {
+		dev_err(&sensor->i2c_client->dev,
+			"unsupported device id: 0x%04x\n",
+			(unsigned int)chip_id);
+		return -EINVAL;
+	}
+
+        /*  setup parallel bus */
+
+	if (bus->flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
+		sync_mode |=3D 0x01;
+
+	if (bus->flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
+		sync_mode |=3D 0x02;
+
+	if (bus->flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
+		sync_mode |=3D 0x04;
+
+	gc2145_tx_start(sensor);
+
+	/* soft reset */
+	gc2145_tx_write8(sensor, GC2145_REG_RESET, 0xf0);
+
+	/* enable analog/digital parts */
+	gc2145_tx_write8(sensor, GC2145_REG_ANALOG_PWC, 0x06);
+
+	/* safe initial PLL setting */
+	gc2145_tx_write8(sensor, GC2145_REG_PLL_MODE1, 0x1d);
+	gc2145_tx_write8(sensor, GC2145_REG_PLL_MODE2, 0x84);
+	gc2145_tx_write8(sensor, GC2145_REG_CLK_DIV_MODE, 0x00);
+
+	gc2145_tx_write8(sensor, GC2145_REG_CM_MODE, 0xfe);
+
+	/* disable pads */
+	gc2145_tx_write8(sensor, GC2145_REG_PAD_IO, 0);
+
+	gc2145_tx_write8(sensor, 0x19, 0x0c); /* set AD pipe number */
+	gc2145_tx_write8(sensor, 0x20, 0x01); /* AD clk mode */
+
+	/* enable defect correction, etc. */
+	gc2145_tx_write8(sensor, 0x80, 0x0b);
+
+	gc2145_tx_write8(sensor, GC2145_P0_SYNC_MODE, sync_mode);
+
+	ret =3D gc2145_tx_commit(sensor);
+	if (ret)
+		return ret;
+
+	/* load default register values from the firmware file */
+	ret =3D gc2145_load_firmware(sensor, GC2145_FIRMWARE_PARAMETERS);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int gc2145_set_power(struct gc2145_dev *sensor, bool on)
+{
+	int ret =3D 0;
+
+	if (on) {
+		ret =3D regulator_bulk_enable(GC2145_NUM_SUPPLIES,
+					    sensor->supplies);
+		if (ret)
+			return ret;
+
+		ret =3D clk_set_rate(sensor->xclk, 24000000);
+		if (ret)
+			goto xclk_off;
+
+		ret =3D clk_prepare_enable(sensor->xclk);
+		if (ret)
+			goto power_off;
+
+		usleep_range(10000, 12000);
+		gpiod_direction_output(sensor->reset_gpio, 1);
+		usleep_range(10000, 12000);
+		gpiod_direction_output(sensor->enable_gpio, 1);
+		usleep_range(10000, 12000);
+		gpiod_direction_output(sensor->reset_gpio, 0);
+		usleep_range(40000, 50000);
+
+		ret =3D gc2145_configure(sensor);
+		if (ret)
+			goto power_off;
+
+		ret =3D gc2145_setup_mode(sensor);
+		if (ret)
+			goto power_off;
+
+		return 0;
+	}
+
+xclk_off:
+	clk_disable_unprepare(sensor->xclk);
+power_off:
+	gpiod_direction_input(sensor->reset_gpio);
+	gpiod_direction_input(sensor->enable_gpio);
+	regulator_bulk_disable(GC2145_NUM_SUPPLIES, sensor->supplies);
+	msleep(100);
+	return ret;
+}
+
+static int gc2145_s_power(struct v4l2_subdev *sd, int on)
+{
+	struct gc2145_dev *sensor =3D to_gc2145_dev(sd);
+	bool power_up, power_down;
+	int ret =3D 0;
+
+	mutex_lock(&sensor->lock);
+
+	power_up =3D on && !sensor->powered;
+	power_down =3D !on && sensor->powered;
+
+	if (power_up || power_down) {
+		ret =3D gc2145_set_power(sensor, power_up);
+		if (!ret)
+			sensor->powered =3D on;
+	}
+
+	mutex_unlock(&sensor->lock);
+
+	if (!ret && power_up) {
+		/* restore controls */
+		ret =3D v4l2_ctrl_handler_setup(&sensor->ctrls.handler);
+		if (ret)
+			gc2145_s_power(sd, 0);
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_VIDEO_ADV_DEBUG
+static int gc2145_g_register(struct v4l2_subdev *sd,
+			     struct v4l2_dbg_register *reg)
+{
+	struct gc2145_dev *sensor =3D to_gc2145_dev(sd);
+	int ret;
+	u8 val =3D 0;
+
+	if (reg->reg > 0xffff)
+		return -EINVAL;
+
+	reg->size =3D 1;
+
+	mutex_lock(&sensor->lock);
+	ret =3D gc2145_read(sensor, reg->reg, &val);
+	mutex_unlock(&sensor->lock);
+	if (ret)
+		return -EIO;
+
+	reg->val =3D val;
+	return 0;
+}
+
+static int gc2145_s_register(struct v4l2_subdev *sd,
+			     const struct v4l2_dbg_register *reg)
+{
+	struct gc2145_dev *sensor =3D to_gc2145_dev(sd);
+	int ret;
+
+	if (reg->reg > 0xffff || reg->val > 0xff)
+		return -EINVAL;
+
+	mutex_lock(&sensor->lock);
+	ret =3D gc2145_write(sensor, reg->reg, reg->val);
+	mutex_unlock(&sensor->lock);
+
+	return ret;
+}
+#endif
+
+/* }}} */
+
+static const struct v4l2_subdev_core_ops gc2145_core_ops =3D {
+	.s_power =3D gc2145_s_power,
+#ifdef CONFIG_VIDEO_ADV_DEBUG
+	.g_register =3D gc2145_g_register,
+	.s_register =3D gc2145_s_register,
+#endif
+};
+
+static const struct v4l2_subdev_pad_ops gc2145_pad_ops =3D {
+	.enum_mbus_code =3D gc2145_enum_mbus_code,
+	.enum_frame_size =3D gc2145_enum_frame_size,
+	.enum_frame_interval =3D gc2145_enum_frame_interval,
+	.get_fmt =3D gc2145_get_fmt,
+	.set_fmt =3D gc2145_set_fmt,
+};
+
+static const struct v4l2_subdev_video_ops gc2145_video_ops =3D {
+	.g_frame_interval =3D gc2145_g_frame_interval,
+	.s_frame_interval =3D gc2145_s_frame_interval,
+	.s_stream =3D gc2145_s_stream,
+};
+
+static const struct v4l2_subdev_ops gc2145_subdev_ops =3D {
+	.core =3D &gc2145_core_ops,
+	.pad =3D &gc2145_pad_ops,
+	.video =3D &gc2145_video_ops,
+};
+
+static int gc2145_get_regulators(struct gc2145_dev *sensor)
+{
+	int i;
+
+	for (i =3D 0; i < GC2145_NUM_SUPPLIES; i++)
+		sensor->supplies[i].supply =3D gc2145_supply_name[i];
+
+	return devm_regulator_bulk_get(&sensor->i2c_client->dev,
+				       GC2145_NUM_SUPPLIES,
+				       sensor->supplies);
+}
+
+static int gc2145_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct device *dev =3D &client->dev;
+	struct fwnode_handle *endpoint;
+	struct gc2145_dev *sensor;
+	int ret;
+
+	sensor =3D devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
+	if (!sensor)
+		return -ENOMEM;
+
+	sensor->i2c_client =3D client;
+
+	sensor->fmt.code =3D gc2145_formats[0].code;
+	sensor->fmt.width =3D 1600;
+	sensor->fmt.height =3D 1200;
+	sensor->fmt.field =3D V4L2_FIELD_NONE;
+	sensor->frame_interval.numerator =3D 1;
+	sensor->frame_interval.denominator =3D 10;
+	sensor->pending_mode_change =3D true;
+	sensor->current_bank =3D 0xff;
+
+	endpoint =3D fwnode_graph_get_next_endpoint(
+		of_fwnode_handle(client->dev.of_node), NULL);
+	if (!endpoint) {
+		dev_err(dev, "endpoint node not found\n");
+		return -EINVAL;
+	}
+
+	ret =3D v4l2_fwnode_endpoint_parse(endpoint, &sensor->ep);
+	fwnode_handle_put(endpoint);
+	if (ret) {
+		dev_err(dev, "could not parse endpoint\n");
+		return ret;
+	}
+
+	if (sensor->ep.bus_type !=3D V4L2_MBUS_PARALLEL) {
+		dev_err(dev, "unsupported bus type %d\n", sensor->ep.bus_type);
+		return -EINVAL;
+	}
+
+	sensor->xclk =3D devm_clk_get(dev, "xclk");
+	if (IS_ERR(sensor->xclk)) {
+		dev_err(dev, "failed to get xclk\n");
+		return PTR_ERR(sensor->xclk);
+	}
+
+	sensor->enable_gpio =3D devm_gpiod_get_optional(dev, "enable", GPIOD_IN);
+	if (IS_ERR(sensor->enable_gpio)) {
+		dev_err(dev, "failed to get enable gpio\n");
+		return PTR_ERR(sensor->enable_gpio);
+	}
+
+	sensor->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_IN);
+	if (IS_ERR(sensor->reset_gpio)) {
+		dev_err(dev, "failed to get reset gpio\n");
+		return PTR_ERR(sensor->reset_gpio);
+	}
+
+	if (!sensor->enable_gpio || !sensor->reset_gpio) {
+		dev_err(dev, "enable and reset pins must be configured\n");
+		return ret;
+	}
+
+	v4l2_i2c_subdev_init(&sensor->sd, client, &gc2145_subdev_ops);
+
+	sensor->sd.flags =3D V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sensor->pad.flags =3D MEDIA_PAD_FL_SOURCE;
+	sensor->sd.entity.function =3D MEDIA_ENT_F_CAM_SENSOR;
+	ret =3D media_entity_pads_init(&sensor->sd.entity, 1, &sensor->pad);
+	if (ret)
+		return ret;
+
+	mutex_init(&sensor->lock);
+
+	ret =3D gc2145_get_regulators(sensor);
+	if (ret)
+		goto entity_cleanup;
+
+	ret =3D gc2145_init_controls(sensor);
+	if (ret)
+		goto entity_cleanup;
+
+	ret =3D v4l2_async_register_subdev(&sensor->sd);
+	if (ret)
+		goto free_ctrls;
+
+	return 0;
+
+free_ctrls:
+	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
+entity_cleanup:
+	mutex_destroy(&sensor->lock);
+	media_entity_cleanup(&sensor->sd.entity);
+	return ret;
+}
+
+static int gc2145_remove(struct i2c_client *client)
+{
+	struct v4l2_subdev *sd =3D i2c_get_clientdata(client);
+	struct gc2145_dev *sensor =3D to_gc2145_dev(sd);
+
+	v4l2_async_unregister_subdev(&sensor->sd);
+	mutex_destroy(&sensor->lock);
+	media_entity_cleanup(&sensor->sd.entity);
+	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
+
+	return 0;
+}
+
+static const struct i2c_device_id gc2145_id[] =3D {
+	{"gc2145", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, gc2145_id);
+
+static const struct of_device_id gc2145_dt_ids[] =3D {
+	{ .compatible =3D "galaxycore,gc2145" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, gc2145_dt_ids);
+
+static struct i2c_driver gc2145_i2c_driver =3D {
+	.driver =3D {
+		.name  =3D "gc2145",
+		.of_match_table	=3D gc2145_dt_ids,
+	},
+	.id_table =3D gc2145_id,
+	.probe    =3D gc2145_probe,
+	.remove   =3D gc2145_remove,
+};
+
+module_i2c_driver(gc2145_i2c_driver);
+
+MODULE_AUTHOR("Ondrej Jirman <megi@xff.cz>");
+MODULE_DESCRIPTION("GC2145 Camera Subdev Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index db5a19babe67..79630d25106c 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -9,6 +9,7 @@
 #include <linux/clkdev.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
+#include <linux/firmware.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -31,7 +32,11 @@
=20
 #define OV5640_DEFAULT_SLAVE_ID 0x3c
=20
+#define OV5640_REG_SYS_RESET00		0x3000
+#define OV5640_REG_SYS_RESET01		0x3001
 #define OV5640_REG_SYS_RESET02		0x3002
+#define OV5640_REG_SYS_CLOCK_ENABLE00	0x3004
+#define OV5640_REG_SYS_CLOCK_ENABLE01	0x3005
 #define OV5640_REG_SYS_CLOCK_ENABLE02	0x3006
 #define OV5640_REG_SYS_CTRL0		0x3008
 #define OV5640_REG_SYS_CTRL0_SW_PWDN	0x42
@@ -41,6 +46,14 @@
 #define OV5640_REG_PAD_OUTPUT_ENABLE01	0x3017
 #define OV5640_REG_PAD_OUTPUT_ENABLE02	0x3018
 #define OV5640_REG_PAD_OUTPUT00		0x3019
+#define OV5640_REG_FW_CMD_MAIN		0x3022
+#define OV5640_REG_FW_CMD_ACK		0x3023
+#define OV5640_REG_FW_CMD_PARA0		0x3024
+#define OV5640_REG_FW_CMD_PARA1		0x3025
+#define OV5640_REG_FW_CMD_PARA2		0x3026
+#define OV5640_REG_FW_CMD_PARA3		0x3027
+#define OV5640_REG_FW_CMD_PARA4		0x3028
+#define OV5640_REG_FW_STATUS		0x3029
 #define OV5640_REG_SYSTEM_CONTROL1	0x302e
 #define OV5640_REG_SC_PLL_CTRL0		0x3034
 #define OV5640_REG_SC_PLL_CTRL1		0x3035
@@ -59,6 +72,7 @@
 #define OV5640_REG_AEC_PK_MANUAL	0x3503
 #define OV5640_REG_AEC_PK_REAL_GAIN	0x350a
 #define OV5640_REG_AEC_PK_VTS		0x350c
+#define OV5640_REG_VCM_CONTROL4		0x3606
 #define OV5640_REG_TIMING_DVPHO		0x3808
 #define OV5640_REG_TIMING_DVPVO		0x380a
 #define OV5640_REG_TIMING_HTS		0x380c
@@ -96,6 +110,20 @@
 #define OV5640_REG_SDE_CTRL4		0x5584
 #define OV5640_REG_SDE_CTRL5		0x5585
 #define OV5640_REG_AVG_READOUT		0x56a1
+#define OV5640_REG_FIRMWARE_BASE	0x8000
+
+#define OV5640_FW_STATUS_S_FIRMWARE	0x7f
+#define OV5640_FW_STATUS_S_STARTUP	0x7e
+#define OV5640_FW_STATUS_S_IDLE		0x70
+#define OV5640_FW_STATUS_S_FOCUSING	0x00
+#define OV5640_FW_STATUS_S_FOCUSED	0x10
+
+#define OV5640_FW_CMD_TRIGGER_FOCUS	0x03
+#define OV5640_FW_CMD_CONTINUOUS_FOCUS	0x04
+#define OV5640_FW_CMD_GET_FOCUS_RESULT	0x07
+#define OV5640_FW_CMD_RELEASE_FOCUS	0x08
+#define OV5640_FW_CMD_ZONE_CONFIG	0x12
+#define OV5640_FW_CMD_DEFAULT_ZONES	0x80
=20
 enum ov5640_mode_id {
 	OV5640_MODE_QQVGA_160_120 =3D 0,
@@ -112,7 +140,11 @@ enum ov5640_mode_id {
 };
=20
 enum ov5640_frame_rate {
-	OV5640_15_FPS =3D 0,
+	OV5640_2_FPS =3D 0,
+	OV5640_3_FPS,
+	OV5640_5_FPS,
+	OV5640_7_FPS,
+	OV5640_15_FPS,
 	OV5640_30_FPS,
 	OV5640_60_FPS,
 	OV5640_NUM_FRAMERATES,
@@ -156,6 +188,10 @@ MODULE_PARM_DESC(virtual_channel,
 		 "MIPI CSI-2 virtual channel (0..3), default 0");
=20
 static const int ov5640_framerates[] =3D {
+	[OV5640_2_FPS] =3D 2,
+	[OV5640_3_FPS] =3D 3,
+	[OV5640_5_FPS] =3D 5,
+	[OV5640_7_FPS] =3D 7,
 	[OV5640_15_FPS] =3D 15,
 	[OV5640_30_FPS] =3D 30,
 	[OV5640_60_FPS] =3D 60,
@@ -214,6 +250,12 @@ struct ov5640_ctrls {
 		struct v4l2_ctrl *auto_gain;
 		struct v4l2_ctrl *gain;
 	};
+	struct {
+		struct v4l2_ctrl *focus_auto;
+		struct v4l2_ctrl *af_start;
+		struct v4l2_ctrl *af_stop;
+		struct v4l2_ctrl *af_status;
+	};
 	struct v4l2_ctrl *brightness;
 	struct v4l2_ctrl *light_freq;
 	struct v4l2_ctrl *saturation;
@@ -257,6 +299,8 @@ struct ov5640_dev {
=20
 	bool pending_mode_change;
 	bool streaming;
+
+	bool af_initialized;
 };
=20
 static inline struct ov5640_dev *to_ov5640_dev(struct v4l2_subdev *sd)
@@ -1764,6 +1808,7 @@ static int ov5640_set_mode(struct ov5640_dev *sensor)
 	bool auto_exp =3D  sensor->ctrls.auto_exp->val =3D=3D V4L2_EXPOSURE_AUTO;
 	unsigned long rate;
 	int ret;
+	u8 tmp;
=20
 	dn_mode =3D mode->dn_mode;
 	orig_dn_mode =3D orig_mode->dn_mode;
@@ -1836,6 +1881,22 @@ static int ov5640_set_mode(struct ov5640_dev *sensor)
 	if (ret < 0)
 		return ret;
=20
+	ret =3D ov5640_read_reg(sensor, 0x5308, &tmp);
+	if (ret)
+		return ret;
+
+	ret =3D ov5640_write_reg(sensor, 0x5308, tmp | 0x10 | 0x40);
+	if (ret)
+		return ret;
+
+	ret =3D ov5640_write_reg(sensor, 0x5306, 0);
+	if (ret)
+		return ret;
+
+	ret =3D ov5640_write_reg(sensor, 0x5302, 0);
+	if (ret)
+		return ret;
+
 	sensor->pending_mode_change =3D false;
 	sensor->last_mode =3D mode;
=20
@@ -1904,9 +1965,122 @@ static void ov5640_reset(struct ov5640_dev *sensor)
 	usleep_range(20000, 25000);
 }
=20
+static int ov5640_copy_fw_to_device(struct ov5640_dev *sensor,
+					const struct firmware *fw)
+{
+	struct i2c_client *client =3D sensor->i2c_client;
+	const u8 *data =3D (const u8 *)fw->data;
+	u8 fw_status;
+	int i;
+	int ret;
+
+	// Putting MCU in reset state
+	ret =3D ov5640_write_reg(sensor, OV5640_REG_SYS_RESET00, 0x20);
+	if (ret)
+		return ret;
+
+	// Write firmware
+	for (i =3D 0; i < fw->size / sizeof(u8); i++)
+		ov5640_write_reg(sensor,
+				OV5640_REG_FIRMWARE_BASE + i,=20
+				data[i]);
+
+	// Reset MCU state
+	ov5640_write_reg(sensor, OV5640_REG_FW_CMD_MAIN, 0x00);
+	ov5640_write_reg(sensor, OV5640_REG_FW_CMD_ACK, 0x00);
+	ov5640_write_reg(sensor, OV5640_REG_FW_CMD_PARA0, 0x00);
+	ov5640_write_reg(sensor, OV5640_REG_FW_CMD_PARA1, 0x00);
+	ov5640_write_reg(sensor, OV5640_REG_FW_CMD_PARA2, 0x00);
+	ov5640_write_reg(sensor, OV5640_REG_FW_CMD_PARA3, 0x00);
+	ov5640_write_reg(sensor, OV5640_REG_FW_CMD_PARA4, 0x00);
+	ov5640_write_reg(sensor, OV5640_REG_FW_STATUS, 0x7f);
+
+	// Start AF MCU
+	ret =3D ov5640_write_reg(sensor, OV5640_REG_SYS_RESET00, 0x00);
+	if (ret)
+		return ret;
+
+	dev_info(&client->dev, "firmware upload success\n");
+
+	// Wait for firmware to be ready
+	for (i =3D 0; i < 5; i++) {
+		ret =3D ov5640_read_reg(sensor, OV5640_REG_FW_STATUS, &fw_status);
+		if (fw_status =3D=3D OV5640_FW_STATUS_S_IDLE) {
+			dev_info(&client->dev, "fw started after %d ms\n", i * 50);
+			return ret;
+		}
+		msleep(50);
+	}
+	dev_err(&client->dev, "uploaded firmware didn't start, got to 0x%x, retry=
ing...\n", fw_status);
+
+	// Putting MCU in reset state
+	ret =3D ov5640_write_reg(sensor, OV5640_REG_SYS_RESET00, 0x20);
+	if (ret)
+		return ret;
+	// Start AF MCU
+	ret =3D ov5640_write_reg(sensor, OV5640_REG_SYS_RESET00, 0x00);
+	if (ret)
+		return ret;
+	// Wait for firmware to be ready
+	for (i =3D 0; i < 5; i++) {
+		ret =3D ov5640_read_reg(sensor, OV5640_REG_FW_STATUS, &fw_status);
+		if (fw_status =3D=3D OV5640_FW_STATUS_S_IDLE) {
+			dev_info(&client->dev, "fw started after %d ms\n", i * 50);
+			return ret;
+		}
+		msleep(50);
+	}
+	dev_err(&client->dev, "uploaded firmware didn't start, got to 0x%x\n", fw=
_status);
+	return -ETIMEDOUT;
+}
+
+static int ov5640_af_init(struct ov5640_dev *sensor)
+{
+	struct i2c_client *client =3D sensor->i2c_client;
+	const char* fwname =3D "ov5640_af.bin";
+	const struct firmware *fw;
+	int ret;
+
+	if (sensor->af_initialized) {
+		return 0;
+	}
+
+	if (firmware_request_nowarn(&fw, fwname, &client->dev) =3D=3D 0) {
+		ret =3D ov5640_copy_fw_to_device(sensor, fw);
+		if (ret =3D=3D 0)
+			sensor->af_initialized =3D 1;
+	} else {
+		dev_warn(&client->dev, "%s: no autofocus firmware available (%s)\n",
+			__func__, fwname);
+		ret =3D -1;
+	}
+	release_firmware(fw);
+
+	if (ret)
+		return ret;
+
+	// Enable AF systems
+	ret =3D ov5640_mod_reg(sensor, OV5640_REG_SYS_CLOCK_ENABLE00,
+			     (BIT(6) | BIT(5)), (BIT(6) | BIT(5)));
+	if (ret)
+		return ret;
+	ret =3D ov5640_mod_reg(sensor, OV5640_REG_SYS_CLOCK_ENABLE01,
+			     BIT(6), BIT(6));
+	if (ret)
+		return ret;
+
+	// Set lens focus driver on
+	ov5640_write_reg(sensor, OV5640_REG_VCM_CONTROL4, 0x3f);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
 static int ov5640_set_power_on(struct ov5640_dev *sensor)
 {
 	struct i2c_client *client =3D sensor->i2c_client;
+	u16 chip_id;
 	int ret;
=20
 	ret =3D clk_prepare_enable(sensor->xclk);
@@ -1924,6 +2098,8 @@ static int ov5640_set_power_on(struct ov5640_dev *sen=
sor)
 		goto xclk_off;
 	}
=20
+	sensor->af_initialized =3D 0;
+
 	ov5640_reset(sensor);
 	ov5640_power(sensor, true);
=20
@@ -1931,6 +2107,13 @@ static int ov5640_set_power_on(struct ov5640_dev *se=
nsor)
 	if (ret)
 		goto power_off;
=20
+	ret =3D ov5640_read_reg16(sensor, OV5640_REG_CHIP_ID, &chip_id);
+	if (ret) {
+		dev_err(&client->dev, "%s: failed to read chip identifier\n",
+			__func__);
+		goto power_off;
+	}
+
 	return 0;
=20
 power_off:
@@ -1946,6 +2129,7 @@ static void ov5640_set_power_off(struct ov5640_dev *s=
ensor)
 	ov5640_power(sensor, false);
 	regulator_bulk_disable(OV5640_NUM_SUPPLIES, sensor->supplies);
 	clk_disable_unprepare(sensor->xclk);
+	msleep(100);
 }
=20
 static int ov5640_set_power_mipi(struct ov5640_dev *sensor, bool on)
@@ -2193,11 +2377,11 @@ static int ov5640_try_frame_interval(struct ov5640_=
dev *sensor,
 				     u32 width, u32 height)
 {
 	const struct ov5640_mode_info *mode;
-	enum ov5640_frame_rate rate =3D OV5640_15_FPS;
+	enum ov5640_frame_rate rate =3D OV5640_2_FPS;
 	int minfps, maxfps, best_fps, fps;
 	int i;
=20
-	minfps =3D ov5640_framerates[OV5640_15_FPS];
+	minfps =3D ov5640_framerates[OV5640_2_FPS];
 	maxfps =3D ov5640_framerates[OV5640_60_FPS];
=20
 	if (fi->numerator =3D=3D 0) {
@@ -2433,6 +2617,35 @@ static int ov5640_set_framefmt(struct ov5640_dev *se=
nsor,
 			      is_jpeg ? (BIT(5) | BIT(3)) : 0);
 }
=20
+static int ov5640_fw_command(struct ov5640_dev *sensor, int command)
+{
+	u8 fw_ack;
+	int i;
+	int ret;
+
+	ret =3D ov5640_write_reg(sensor, OV5640_REG_FW_CMD_ACK, 0x01);
+	if(ret)
+		return ret;
+=09
+	ret =3D ov5640_write_reg(sensor, OV5640_REG_FW_CMD_MAIN, command);
+	if(ret)
+		return ret;
+
+	for (i =3D 0; i < 100; i++) {
+		ret =3D ov5640_read_reg(sensor, OV5640_REG_FW_CMD_ACK, &fw_ack);
+		if (ret)
+			return ret;
+
+		if (fw_ack =3D=3D 0){
+			return ret;
+		}
+
+		msleep(50);
+	}
+	return -ETIMEDOUT;
+}
+
+
 /*
  * Sensor Controls.
  */
@@ -2549,6 +2762,41 @@ static int ov5640_set_ctrl_exposure(struct ov5640_de=
v *sensor,
 	return ret;
 }
=20
+static int ov5640_set_ctrl_focus(struct ov5640_dev *sensor, int command)
+{
+	struct i2c_client *client =3D sensor->i2c_client;
+	int ret;
+
+	ret =3D ov5640_af_init(sensor);
+	if (ret) {
+		dev_err(&client->dev, "%s: no autofocus firmware loaded\n",
+			__func__);
+		return 0;
+	}
+
+	if (command =3D=3D OV5640_FW_CMD_RELEASE_FOCUS) {
+		dev_dbg(&client->dev, "%s: Releasing autofocus\n",
+			__func__);
+		return ov5640_fw_command(sensor, OV5640_FW_CMD_RELEASE_FOCUS);
+	}
+=09
+	// Restart zone config
+	ret =3D ov5640_fw_command(sensor, OV5640_FW_CMD_ZONE_CONFIG);
+	if (ret)
+		return ret;
+
+	// Set default focus zones
+	ret =3D ov5640_fw_command(sensor, OV5640_FW_CMD_DEFAULT_ZONES);
+	if (ret)
+		return ret;
+
+	dev_dbg(&client->dev, "%s: Triggering autofocus\n",
+		__func__);
+
+	// Start focussing
+	return ov5640_fw_command(sensor, command);
+}
+
 static int ov5640_set_ctrl_gain(struct ov5640_dev *sensor, bool auto_gain)
 {
 	struct ov5640_ctrls *ctrls =3D &sensor->ctrls;
@@ -2655,6 +2903,32 @@ static int ov5640_set_ctrl_vflip(struct ov5640_dev *=
sensor, int value)
 			      (BIT(2) | BIT(1)) : 0);
 }
=20
+static int ov5640_get_af_status(struct ov5640_dev *sensor)
+{
+	u8 fw_status;
+	int ret;
+
+	ret =3D ov5640_read_reg(sensor, OV5640_REG_FW_STATUS, &fw_status);
+	if (ret)
+		return ret;
+
+	switch (fw_status) {
+		case OV5640_FW_STATUS_S_FIRMWARE:
+		case OV5640_FW_STATUS_S_STARTUP:
+			return V4L2_AUTO_FOCUS_STATUS_FAILED;
+			break;
+		case OV5640_FW_STATUS_S_IDLE:
+			return V4L2_AUTO_FOCUS_STATUS_IDLE;
+			break;
+		case OV5640_FW_STATUS_S_FOCUSED:
+			return V4L2_AUTO_FOCUS_STATUS_REACHED;
+			break;
+		default:
+			return V4L2_AUTO_FOCUS_STATUS_BUSY;
+			break;
+	}
+}
+
 static int ov5640_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct v4l2_subdev *sd =3D ctrl_to_sd(ctrl);
@@ -2676,6 +2950,12 @@ static int ov5640_g_volatile_ctrl(struct v4l2_ctrl *=
ctrl)
 			return val;
 		sensor->ctrls.exposure->val =3D val;
 		break;
+	case V4L2_CID_FOCUS_AUTO:
+		val =3D ov5640_get_af_status(sensor);
+		if (val < 0)
+			return val;
+		sensor->ctrls.af_status->val =3D val;
+		break;
 	}
=20
 	return 0;
@@ -2707,6 +2987,18 @@ static int ov5640_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_AUTO_WHITE_BALANCE:
 		ret =3D ov5640_set_ctrl_white_balance(sensor, ctrl->val);
 		break;
+	case V4L2_CID_FOCUS_AUTO:
+		if (ctrl->val)
+			ret =3D ov5640_set_ctrl_focus(sensor, OV5640_FW_CMD_CONTINUOUS_FOCUS);
+		else
+			ret =3D ov5640_set_ctrl_focus(sensor, OV5640_FW_CMD_RELEASE_FOCUS);
+		break;
+	case V4L2_CID_AUTO_FOCUS_START:
+		ret =3D ov5640_set_ctrl_focus(sensor, OV5640_FW_CMD_TRIGGER_FOCUS);
+		break;
+	case V4L2_CID_AUTO_FOCUS_STOP:
+		ret =3D ov5640_set_ctrl_focus(sensor, OV5640_FW_CMD_RELEASE_FOCUS);
+		break;
 	case V4L2_CID_HUE:
 		ret =3D ov5640_set_ctrl_hue(sensor, ctrl->val);
 		break;
@@ -2779,6 +3071,20 @@ static int ov5640_init_controls(struct ov5640_dev *s=
ensor)
 	ctrls->gain =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_GAIN,
 					0, 1023, 1, 0);
=20
+	/* Autofocus */
+	ctrls->focus_auto =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_FOCUS_AUTO,
+					    0, 1, 1, 0);
+	ctrls->af_start =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_AUTO_FOCUS_START,
+					    0, 1, 1, 0);
+	ctrls->af_stop =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_AUTO_FOCUS_STOP,
+					   0, 1, 1, 0);
+	ctrls->af_status =3D v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_AUTO_FOCUS_STATUS, 0,
+					     (V4L2_AUTO_FOCUS_STATUS_BUSY |
+					      V4L2_AUTO_FOCUS_STATUS_REACHED |
+					      V4L2_AUTO_FOCUS_STATUS_FAILED),
+					     0, V4L2_AUTO_FOCUS_STATUS_IDLE);
+
 	ctrls->saturation =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_SATURATION,
 					      0, 255, 1, 64);
 	ctrls->hue =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_HUE,
@@ -2812,6 +3118,7 @@ static int ov5640_init_controls(struct ov5640_dev *se=
nsor)
 	v4l2_ctrl_auto_cluster(3, &ctrls->auto_wb, 0, false);
 	v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
 	v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp, 1, true);
+	v4l2_ctrl_cluster(4, &ctrls->focus_auto);
=20
 	sensor->sd.ctrl_handler =3D hdl;
 	return 0;
@@ -3013,34 +3320,6 @@ static int ov5640_get_regulators(struct ov5640_dev *=
sensor)
 				       sensor->supplies);
 }
=20
-static int ov5640_check_chip_id(struct ov5640_dev *sensor)
-{
-	struct i2c_client *client =3D sensor->i2c_client;
-	int ret =3D 0;
-	u16 chip_id;
-
-	ret =3D ov5640_set_power_on(sensor);
-	if (ret)
-		return ret;
-
-	ret =3D ov5640_read_reg16(sensor, OV5640_REG_CHIP_ID, &chip_id);
-	if (ret) {
-		dev_err(&client->dev, "%s: failed to read chip identifier\n",
-			__func__);
-		goto power_off;
-	}
-
-	if (chip_id !=3D 0x5640) {
-		dev_err(&client->dev, "%s: wrong chip identifier, expected 0x5640, got 0=
x%x\n",
-			__func__, chip_id);
-		ret =3D -ENXIO;
-	}
-
-power_off:
-	ov5640_set_power_off(sensor);
-	return ret;
-}
-
 static int ov5640_probe(struct i2c_client *client)
 {
 	struct device *dev =3D &client->dev;
@@ -3076,7 +3355,7 @@ static int ov5640_probe(struct i2c_client *client)
 		&ov5640_mode_data[OV5640_MODE_VGA_640_480];
 	sensor->last_mode =3D sensor->current_mode;
=20
-	sensor->ae_target =3D 52;
+	sensor->ae_target =3D 28;
=20
 	/* optional indication of physical rotation of sensor */
 	ret =3D fwnode_property_read_u32(dev_fwnode(&client->dev), "rotation",
@@ -3158,10 +3437,6 @@ static int ov5640_probe(struct i2c_client *client)
=20
 	mutex_init(&sensor->lock);
=20
-	ret =3D ov5640_check_chip_id(sensor);
-	if (ret)
-		goto entity_cleanup;
-
 	ret =3D ov5640_init_controls(sensor);
 	if (ret)
 		goto entity_cleanup;

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYwPFawAKCRAw5/Bqldv6
8rBxAKCuMTHXYrh4v5uR710dkDSbsVAnTACfVWZI/bwAz5BbjKm+gWUbHinHaA0=
=i4BP
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
