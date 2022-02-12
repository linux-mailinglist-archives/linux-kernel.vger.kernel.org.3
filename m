Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAD44B345A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiBLKwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:52:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiBLKwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:52:47 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFA026543;
        Sat, 12 Feb 2022 02:52:43 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21C9tIne020529;
        Sat, 12 Feb 2022 05:52:35 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3e6ap9g3sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Feb 2022 05:52:34 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 21CAqX5w064712
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 12 Feb 2022 05:52:33 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sat, 12 Feb
 2022 05:52:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 12 Feb 2022 05:52:32 -0500
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.37.22])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 21CAqONd001965;
        Sat, 12 Feb 2022 05:52:26 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 1/3] iio:amplifiers:ada4250: add support for ADA4250
Date:   Sat, 12 Feb 2022 12:51:51 +0200
Message-ID: <20220212105153.19748-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: -nliTb7429ciKlUMZlo9WGqGQhw4N6j1
X-Proofpoint-GUID: -nliTb7429ciKlUMZlo9WGqGQhw4N6j1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-12_03,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202120065
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADA4250 is an instrumentation amplifier with SPI/pin-strap
progammable gains that is optimized for ultra-low power systems.
With a minimum supply voltage of 1.7V, 26uA of quiescent current,
a shutdown mode, a sleep mode, and a fast wake up settling time,
ADA4250 can be power cycled on a battery powered system for even
futher savings.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - move all IIO attributes under a single channel
 - use DMA safe buffers + endian conversion
 - fix odd spacing in Kconfig
 drivers/iio/amplifiers/Kconfig   |  11 +
 drivers/iio/amplifiers/Makefile  |   1 +
 drivers/iio/amplifiers/ada4250.c | 384 +++++++++++++++++++++++++++++++
 3 files changed, 396 insertions(+)
 create mode 100644 drivers/iio/amplifiers/ada4250.c

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index 5eb1357a9c78..0099fd26fa89 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -23,6 +23,17 @@ config AD8366
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad8366.
 
+config ADA4250
+	tristate "Analog Devices ADA4250 Instrumentation Amplifier"
+	depends on SPI
+	help
+          Say yes here to build support for Analog Devices ADA4250
+          SPI Amplifier's support. The driver provides direct access via
+          sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ada4250.
+
 config HMC425
 	tristate "Analog Devices HMC425A and similar GPIO Gain Amplifiers"
 	depends on GPIOLIB
diff --git a/drivers/iio/amplifiers/Makefile b/drivers/iio/amplifiers/Makefile
index cb551d82f56b..2126331129cf 100644
--- a/drivers/iio/amplifiers/Makefile
+++ b/drivers/iio/amplifiers/Makefile
@@ -5,4 +5,5 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD8366) += ad8366.o
+obj-$(CONFIG_ADA4250) += ada4250.o
 obj-$(CONFIG_HMC425) += hmc425a.o
diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
new file mode 100644
index 000000000000..c8b2c3382e33
--- /dev/null
+++ b/drivers/iio/amplifiers/ada4250.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADA4250 driver
+ *
+ * Copyright 2022 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <asm/unaligned.h>
+
+/* ADA4250 Register Map */
+#define ADA4250_REG_GAIN_MUX        0x00
+#define ADA4250_REG_REFBUF_EN       0x01
+#define ADA4250_REG_RESET           0x02
+#define ADA4250_REG_SNSR_CAL_VAL    0x04
+#define ADA4250_REG_SNSR_CAL_CNFG   0x05
+#define ADA4250_REG_DIE_REV         0x18
+#define ADA4250_REG_CHIP_ID         0x19
+
+/* ADA4250_REG_GAIN_MUX Map */
+#define ADA4250_GAIN_MUX_MSK        GENMASK(2, 0)
+
+/* ADA4250_REG_REFBUF Map */
+#define ADA4250_REFBUF_MSK          BIT(0)
+
+/* ADA4250_REG_RESET Map */
+#define ADA4250_RESET_MSK           BIT(0)
+
+/* ADA4250_REG_SNSR_CAL_VAL Map */
+#define ADA4250_SNSR_CAL_VAL_MSK    GENMASK(7, 0)
+
+/* ADA4250_REG_SNSR_CAL_CNFG Bit Definition */
+#define ADA4250_BIAS_SET_MSK        GENMASK(3, 2)
+#define ADA4250_RANGE_SET_MSK       GENMASK(1, 0)
+
+/* Miscellaneous definitions */
+#define ADA4250_CHIP_ID             0x4250
+#define ADA4250_RANGE1              0
+#define	ADA4250_RANGE4              3
+
+/* ADA4250 current bias set */
+enum ada4250_current_bias {
+	ADA4250_BIAS_DISABLED,
+	ADA4250_BIAS_BANDGAP,
+	ADA4250_BIAS_AVDD,
+};
+
+struct ada4250_state {
+	struct spi_device	*spi;
+	struct regmap		*regmap;
+	struct regulator	*reg;
+	/* Protect against concurrent accesses to the device and data content */
+	struct mutex		lock;
+	u8			bias;
+	u8			gain;
+	int			offset_uv;
+	bool			refbuf_en;
+};
+
+/* ADA4250 Current Bias Source Settings: Disabled, Bandgap Reference, AVDD */
+static const int calibbias_table[] = {0, 1, 2};
+
+/* ADA4250 Gain (V/V) values: 1, 2, 4, 8, 16, 32, 64, 128 */
+static const int hwgain_table[] = {0, 1, 2, 3, 4, 5, 6, 7};
+
+static const struct regmap_config ada4250_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+	.max_register = 0x1A,
+};
+
+static int ada4250_set_offset_uv(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 int offset_uv)
+{
+	struct ada4250_state *st = iio_priv(indio_dev);
+
+	int i, ret, x[8], max_vos, min_vos, voltage_v, vlsb = 0;
+	u8 offset_raw, range = ADA4250_RANGE1;
+	u32 lsb_coeff[6] = {1333, 2301, 4283, 8289, 16311, 31599};
+
+	if (st->bias == 0 || st->bias == 3)
+		return -EINVAL;
+
+	voltage_v = regulator_get_voltage(st->reg);
+	voltage_v = DIV_ROUND_CLOSEST(voltage_v, 1000000);
+
+	if (st->bias == ADA4250_BIAS_AVDD)
+		x[0] = voltage_v;
+	else
+		x[0] = 5;
+
+	x[1] = 126 * (x[0] - 1);
+
+	for (i = 0; i < 6; i++)
+		x[i + 2] = DIV_ROUND_CLOSEST(x[1] * 1000, lsb_coeff[i]);
+
+	if (st->gain == 0)
+		return -EINVAL;
+
+	/* Compute Range and VLSB for the Sensor Offset Calibration */
+	for (i = ADA4250_RANGE1; i <= ADA4250_RANGE4; i++) {
+		max_vos = x[st->gain] *  127 * ((1 << (i + 1)) - 1);
+		min_vos = -1 * max_vos;
+		if (offset_uv > min_vos && offset_uv < max_vos) {
+			range = i;
+			vlsb = x[st->gain] * ((1 << (i + 1)) - 1);
+			break;
+		}
+	}
+
+	if (vlsb <= 0)
+		return -EINVAL;
+
+	offset_raw = DIV_ROUND_CLOSEST(abs(offset_uv), vlsb);
+
+	mutex_lock(&st->lock);
+	ret = regmap_update_bits(st->regmap, ADA4250_REG_SNSR_CAL_CNFG,
+				 ADA4250_RANGE_SET_MSK,
+				 FIELD_PREP(ADA4250_RANGE_SET_MSK, range));
+	if (ret)
+		goto exit;
+
+	st->offset_uv = offset_raw * vlsb;
+
+	if (offset_uv < 0) {
+		offset_raw |= 1 << 8;
+		st->offset_uv *= (-1);
+	}
+
+	ret = regmap_write(st->regmap, ADA4250_REG_SNSR_CAL_VAL, offset_raw);
+
+exit:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ada4250_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct ada4250_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		ret = regmap_read(st->regmap, ADA4250_REG_GAIN_MUX, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = st->offset_uv;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = regmap_read(st->regmap, ADA4250_REG_SNSR_CAL_CNFG, val);
+		if (ret)
+			return ret;
+
+		*val = FIELD_GET(ADA4250_BIAS_SET_MSK, *val);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1;
+		*val2 = 1000000;
+
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ada4250_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct ada4250_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		ret = regmap_write(st->regmap, ADA4250_REG_GAIN_MUX,
+				   FIELD_PREP(ADA4250_GAIN_MUX_MSK, val));
+		if (ret)
+			return ret;
+
+		st->gain = val;
+
+		return ret;
+	case IIO_CHAN_INFO_OFFSET:
+		return ada4250_set_offset_uv(indio_dev, chan, val);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = regmap_update_bits(st->regmap, ADA4250_REG_SNSR_CAL_CNFG,
+					 ADA4250_BIAS_SET_MSK,
+					 FIELD_PREP(ADA4250_BIAS_SET_MSK, val));
+		if (ret)
+			return ret;
+
+		st->bias = val;
+
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ada4250_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = calibbias_table;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(calibbias_table);
+
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*vals = hwgain_table;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(hwgain_table);
+
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ada4250_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int write_val,
+			      unsigned int *read_val)
+{
+	struct ada4250_state *st = iio_priv(indio_dev);
+
+	if (read_val)
+		return regmap_read(st->regmap, reg, read_val);
+	else
+		return regmap_write(st->regmap, reg, write_val);
+}
+
+static const struct iio_info ada4250_info = {
+	.read_raw = ada4250_read_raw,
+	.write_raw = ada4250_write_raw,
+	.read_avail = &ada4250_read_avail,
+	.debugfs_reg_access = &ada4250_reg_access,
+};
+
+static const struct iio_chan_spec ada4250_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.output = 1,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
+				BIT(IIO_CHAN_INFO_OFFSET) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS) |
+				BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBBIAS) |
+						BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+	}
+};
+
+static void ada4250_reg_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static int ada4250_init(struct ada4250_state *st)
+{
+	int ret;
+	u16 chip_id;
+	u8 data[2] ____cacheline_aligned;
+	struct spi_device *spi = st->spi;
+
+	st->refbuf_en = device_property_read_bool(&spi->dev, "adi,refbuf-enable");
+
+	st->reg = devm_regulator_get(&spi->dev, "avdd");
+	if (IS_ERR(st->reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
+				     "failed to get the AVDD voltage\n");
+
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&spi->dev, ada4250_reg_disable, st->reg);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADA4250_REG_RESET,
+			   FIELD_PREP(ADA4250_RESET_MSK, 1));
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(st->regmap, ADA4250_REG_CHIP_ID, data, 2);
+	if (ret)
+		return ret;
+
+	chip_id = get_unaligned_le16(data);
+
+	if (chip_id != ADA4250_CHIP_ID) {
+		dev_err(&spi->dev, "Invalid chip ID.\n");
+		return -EINVAL;
+	}
+
+	return regmap_write(st->regmap, ADA4250_REG_REFBUF_EN,
+			    FIELD_PREP(ADA4250_REFBUF_MSK, st->refbuf_en));
+}
+
+static int ada4250_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	struct ada4250_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_spi(spi, &ada4250_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	st = iio_priv(indio_dev);
+	st->regmap = regmap;
+	st->spi = spi;
+
+	indio_dev->info = &ada4250_info;
+	indio_dev->name = "ada4250";
+	indio_dev->channels = ada4250_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ada4250_channels);
+
+	mutex_init(&st->lock);
+
+	ret = ada4250_init(st);
+	if (ret) {
+		dev_err(&spi->dev, "ADA4250 init failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ada4250_id[] = {
+	{ "ada4250", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ada4250_id);
+
+static const struct of_device_id ada4250_of_match[] = {
+	{ .compatible = "adi,ada4250" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ada4250_of_match);
+
+static struct spi_driver ada4250_driver = {
+	.driver = {
+			.name = "ada4250",
+			.of_match_table = ada4250_of_match,
+		},
+	.probe = ada4250_probe,
+	.id_table = ada4250_id,
+};
+module_spi_driver(ada4250_driver);
+
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_DESCRIPTION("Analog Devices ADA4250");
+MODULE_LICENSE("GPL v2");
-- 
2.35.1

