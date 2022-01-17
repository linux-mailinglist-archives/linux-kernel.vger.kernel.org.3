Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB46E490C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbiAQQlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:41:17 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32676 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241116AbiAQQlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:41:15 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20HE0KBi022546;
        Mon, 17 Jan 2022 11:41:06 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dn4wyhqnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 11:41:06 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20HGf5is064961
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Jan 2022 11:41:05 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 17 Jan
 2022 11:41:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 17 Jan 2022 11:41:04 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20HGes82012846;
        Mon, 17 Jan 2022 11:41:00 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v1 2/2] iio:frequency:admv4420.c: Add support for ADMV4420
Date:   Mon, 17 Jan 2022 18:52:47 +0200
Message-ID: <20220117165247.15718-2-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220117165247.15718-1-cristian.pop@analog.com>
References: <20220117165247.15718-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: zv44Kwb_gHKcMRZqy6Z6qCXG3vd6escY
X-Proofpoint-ORIG-GUID: zv44Kwb_gHKcMRZqy6Z6qCXG3vd6escY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_07,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for K Band Downconverter with Integrated
Fractional-N PLL and VCO.
More info:
https://www.analog.com/en/products/admv4420.html

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 drivers/iio/frequency/Kconfig    |  10 +
 drivers/iio/frequency/Makefile   |   1 +
 drivers/iio/frequency/admv4420.c | 412 +++++++++++++++++++++++++++++++
 3 files changed, 423 insertions(+)
 create mode 100644 drivers/iio/frequency/admv4420.c

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index b44036f843af..55aa63548c00 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -60,6 +60,16 @@ config ADMV1013
 	  To compile this driver as a module, choose M here: the
 	  module will be called admv1013.
 
+config ADMV4420
+	tristate "Analog Devices ADMV4420 K Band Downconverter"
+	depends on SPI && COMMON_CLK
+	help
+	  Say yes here to build support for Analog Devices K Band
+	  Downconverter with integrated Fractional-N PLL and VCO.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called admv4420.
+
 config ADRF6780
         tristate "Analog Devices ADRF6780 Microwave Upconverter"
         depends on SPI
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index ae6899856c99..782e5baa1630 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_ADF4350) += adf4350.o
 obj-$(CONFIG_ADF4371) += adf4371.o
 obj-$(CONFIG_ADMV1013) += admv1013.o
+obj-$(CONFIG_ADMV4420) += admv4420.o
 obj-$(CONFIG_ADRF6780) += adrf6780.o
diff --git a/drivers/iio/frequency/admv4420.c b/drivers/iio/frequency/admv4420.c
new file mode 100644
index 000000000000..f32039ab2cd3
--- /dev/null
+++ b/drivers/iio/frequency/admv4420.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * ADMV4420
+ *
+ * Copyright 2021 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+/* ADMV4420 Register Map */
+#define ADMV4420_SPI_CONFIG_1			0x00
+#define ADMV4420_SPI_CONFIG_2			0x01
+#define ADMV4420_CHIPTYPE			0x03
+#define ADMV4420_PRODUCT_ID_L			0x04
+#define ADMV4420_PRODUCT_ID_H			0x05
+#define ADMV4420_SCRATCHPAD			0x0A
+#define ADMV4420_SPI_REV			0x0B
+#define ADMV4420_ENABLES			0x103
+#define ADMV4420_SDO_LEVEL			0x108
+#define ADMV4420_INT_L				0x200
+#define ADMV4420_INT_H				0x201
+#define ADMV4420_FRAC_L				0x202
+#define ADMV4420_FRAC_M				0x203
+#define ADMV4420_FRAC_H				0x204
+#define ADMV4420_MOD_L				0x208
+#define ADMV4420_MOD_M				0x209
+#define ADMV4420_MOD_H				0x20A
+#define ADMV4420_R_DIV_L			0x20C
+#define ADMV4420_R_DIV_H			0x20D
+#define ADMV4420_REFERENCE			0x20E
+#define ADMV4420_VCO_DATA_READBACK1		0x211
+#define ADMV4420_VCO_DATA_READBACK2		0x212
+#define ADMV4420_PLL_MUX_SEL			0x213
+#define ADMV4420_LOCK_DETECT			0x214
+#define ADMV4420_BAND_SELECT			0x215
+#define ADMV4420_VCO_ALC_TIMEOUT		0x216
+#define ADMV4420_VCO_MANUAL			0x217
+#define ADMV4420_ALC				0x219
+#define ADMV4420_VCO_TIMEOUT1			0x21C
+#define ADMV4420_VCO_TIMEOUT2			0x21D
+#define ADMV4420_VCO_BAND_DIV			0x21E
+#define ADMV4420_VCO_READBACK_SEL		0x21F
+#define ADMV4420_AUTOCAL			0x226
+#define ADMV4420_CP_STATE			0x22C
+#define ADMV4420_CP_BLEED_EN			0x22D
+#define ADMV4420_CP_CURRENT			0x22E
+#define ADMV4420_CP_BLEED			0x22F
+
+
+#define ADMV4420_SPI_CONFIG_1_SOFTRESET_	BIT(7)
+#define ADMV4420_SPI_CONFIG_1_SDOACTIVE_	BIT(4)
+#define ADMV4420_SPI_CONFIG_1_SDOACTIVE		BIT(3)
+#define ADMV4420_SPI_CONFIG_1_SOFTRESET		BIT(1)
+
+#define ADMV4420_REFERENCE_IN_MODE(x)		(x << 1)
+#define ADMV4420_REFERENCE_DOUBLER(x)		(x << 2)
+#define ADMV4420_REFERENCE_DIVIDE_BY_2_MASK	BIT(0)
+#define ADMV4420_REFERENCE_MODE_MASK		BIT(1)
+#define ADMV4420_REFERENCE_DOUBLER_MASK		BIT(2)
+#define ADMV4420_REF_DIVIDER_MAX_VAL		GENMASK(9, 0)
+#define ADMV4420_N_COUNTER_INT_MAX		GENMASK(15, 0)
+#define ADMV4420_N_COUNTER_FRAC_MAX		GENMASK(23, 0)
+#define ADMV4420_N_COUNTER_MOD_MAX		GENMASK(23, 0)
+
+#define ADMV4420_INT_L_MASK			GENMASK(7, 0)
+#define ADMV4420_INT_H_MASK			GENMASK(15, 8)
+#define ADMV4420_FRAC_L_MASK			GENMASK(7, 0)
+#define ADMV4420_FRAC_M_MASK			GENMASK(15, 8)
+#define ADMV4420_FRAC_H_MASK			GENMASK(23, 16)
+#define ADMV4420_MOD_L_MASK			GENMASK(7, 0)
+#define ADMV4420_MOD_M_MASK			GENMASK(15, 8)
+#define ADMV4420_MOD_H_MASK			GENMASK(23, 16)
+
+#define ENABLE_PLL				BIT(6)
+#define ENABLE_LO				BIT(5)
+#define ENABLE_VCO				BIT(3)
+#define ENABLE_IFAMP				BIT(2)
+#define ENABLE_MIXER				BIT(1)
+#define ENABLE_LNA				BIT(0)
+
+#define ADMV4420_SCRATCH_PAD_VAL_1              0xAD
+#define ADMV4420_SCRATCH_PAD_VAL_2              0xEA
+
+#define ADMV4420_REF_FREQ_HZ                    50000000
+#define MAX_N_COUNTER                           655360UL
+#define MAX_R_DIVIDER                           1024
+#define ADMV4420_DEFAULT_LO_FREQ_HZ		16750000000ULL
+
+enum admv4420_mux_sel {
+	ADMV4420_LOW = 0,
+	ADMV4420_LOCK_DTCT = 1,
+	ADMV4420_R_COUNTER_PER_2 = 4,
+	ADMV4420_N_CONUTER_PER_2 = 5,
+	ADMV4420_HIGH = 8,
+};
+
+struct admv4420_reference_block {
+	bool doubler_en;
+	bool divide_by_2_en;
+	bool ref_single_ended;
+	u32 divider;
+};
+
+struct admv4420_n_counter {
+	u32 int_val;
+	u32 frac_val;
+	u32 mod_val;
+	u32 n_counter;
+};
+
+struct admv4420_state {
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	u64				pfd_freq_hz;
+	u64				vco_freq_hz;
+	u64				lo_freq_hz;
+	struct admv4420_reference_block ref_block;
+	struct admv4420_n_counter	n_counter;
+	enum admv4420_mux_sel		mux_sel;
+	struct mutex			lock;
+};
+
+static const struct regmap_config admv4420_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+};
+
+static int admv4420_reg_access(struct iio_dev *indio_dev,
+			       u32 reg, u32 writeval,
+			       u32 *readval)
+{
+	struct admv4420_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	else
+		return regmap_write(st->regmap, reg, writeval);
+}
+
+static int admv4420_set_n_counter(struct admv4420_state *st, u32 int_val, u32 frac_val, u32 mod_val)
+{
+	int ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_FRAC_H, FIELD_GET(ADMV4420_FRAC_H_MASK, frac_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_FRAC_M, FIELD_GET(ADMV4420_FRAC_M_MASK, frac_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_FRAC_L, FIELD_GET(ADMV4420_FRAC_L_MASK, frac_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_MOD_H, FIELD_GET(ADMV4420_MOD_H_MASK, mod_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_MOD_M, FIELD_GET(ADMV4420_MOD_M_MASK, mod_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_MOD_L, FIELD_GET(ADMV4420_MOD_L_MASK, mod_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_INT_H, FIELD_GET(ADMV4420_INT_H_MASK, int_val));
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, ADMV4420_INT_L, FIELD_GET(ADMV4420_INT_L_MASK, int_val));
+}
+
+static int admv4420_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long info)
+{
+	struct admv4420_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		*val = div_u64(st->lo_freq_hz, 1000000);
+		div_u64_rem(st->lo_freq_hz, 1000000, val2);
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info admv4420_info = {
+	.read_raw = admv4420_read_raw,
+	.debugfs_reg_access = &admv4420_reg_access,
+};
+
+static const struct iio_chan_spec admv4420_channels[] = {
+	{
+		.type = IIO_ALTVOLTAGE,
+		.output = 0,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY),
+	},
+};
+
+static void admv4420_dt_parse(struct admv4420_state *st)
+{
+	struct spi_device *spi = st->spi;
+
+	device_property_read_u64(&spi->dev, "adi,lo_freq_hz", &st->lo_freq_hz);
+	st->ref_block.ref_single_ended = of_property_read_bool(spi->dev.of_node,
+							       "adi,ref_ext_single_ended_en");
+}
+
+static inline uint64_t admv4420_calc_pfd_vco(struct admv4420_state *st)
+{
+	return div_u64(st->vco_freq_hz * 10, st->n_counter.n_counter);
+}
+
+static inline uint64_t admv4420_calc_pfd_ref(struct admv4420_state *st)
+{
+	uint64_t tmp;
+
+	tmp = ADMV4420_REF_FREQ_HZ * (st->ref_block.doubler_en ? 2 : 1);
+	return div_u64(tmp, st->ref_block.divider * (st->ref_block.divide_by_2_en ? 2 : 1));
+}
+
+static int admv4420_calc_parameters(struct admv4420_state *st)
+{
+	u64 pfd_ref, pfd_vco;
+	bool sol_found = false;
+
+	st->ref_block.doubler_en = false;
+	st->ref_block.divide_by_2_en = false;
+	st->vco_freq_hz = div_u64(st->lo_freq_hz, 2);
+
+	for (st->ref_block.divider = 1; st->ref_block.divider < MAX_R_DIVIDER;
+	    st->ref_block.divider++) {
+		pfd_ref = admv4420_calc_pfd_ref(st);
+		for (st->n_counter.n_counter = 1; st->n_counter.n_counter < MAX_N_COUNTER;
+		    st->n_counter.n_counter++) {
+			pfd_vco = admv4420_calc_pfd_vco(st);
+			if (pfd_ref == pfd_vco) {
+				sol_found = true;
+				break;
+			}
+		}
+
+		if (sol_found)
+			break;
+
+		st->n_counter.n_counter = 1;
+	}
+	if (!sol_found)
+		return -1;
+
+	st->n_counter.int_val = div_u64_rem(st->n_counter.n_counter, 10, &st->n_counter.frac_val);
+	st->n_counter.mod_val = 1;
+
+	return 0;
+}
+
+static int admv4420_setup(struct iio_dev *indio_dev)
+{
+	struct admv4420_state *st = iio_priv(indio_dev);
+	u32 val = 0;
+	int ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_SPI_CONFIG_1,
+			   ADMV4420_SPI_CONFIG_1_SOFTRESET_ | ADMV4420_SPI_CONFIG_1_SOFTRESET);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_SPI_CONFIG_1,
+			   ADMV4420_SPI_CONFIG_1_SDOACTIVE_ | ADMV4420_SPI_CONFIG_1_SDOACTIVE);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_SCRATCHPAD, ADMV4420_SCRATCH_PAD_VAL_1);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, ADMV4420_SCRATCHPAD, &val);
+	if (ret)
+		return ret;
+
+	if (val != ADMV4420_SCRATCH_PAD_VAL_1) {
+		dev_err(indio_dev->dev.parent, "Failed ADMV4420 to read/write scratchpad %x ", val);
+		return -EIO;
+	}
+
+	ret = regmap_write(st->regmap, ADMV4420_SCRATCHPAD, ADMV4420_SCRATCH_PAD_VAL_2);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, ADMV4420_SCRATCHPAD, &val);
+	if (ret)
+		return ret;
+
+	if (val != ADMV4420_SCRATCH_PAD_VAL_2) {
+		dev_err(indio_dev->dev.parent, "Failed to read/write scratchpad %x ", val);
+		return -EIO;
+	}
+
+	st->mux_sel = ADMV4420_LOCK_DTCT;
+	st->lo_freq_hz = ADMV4420_DEFAULT_LO_FREQ_HZ;
+
+	admv4420_dt_parse(st);
+
+	ret = admv4420_calc_parameters(st);
+	if (ret) {
+		dev_err(indio_dev->dev.parent, "Failed calc parameters for %lld ", st->vco_freq_hz);
+		return ret;
+	}
+
+	ret = regmap_write(st->regmap, ADMV4420_R_DIV_L,
+			   FIELD_GET(0xFF, st->ref_block.divider));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_R_DIV_H,
+			   FIELD_GET(0xFF00, st->ref_block.divider));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_REFERENCE,
+			   st->ref_block.divide_by_2_en |
+			   ADMV4420_REFERENCE_IN_MODE(st->ref_block.ref_single_ended) |
+			   ADMV4420_REFERENCE_DOUBLER(st->ref_block.doubler_en));
+	if (ret)
+		return ret;
+
+	ret = admv4420_set_n_counter(st, st->n_counter.int_val, st->n_counter.frac_val, st->n_counter.mod_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_PLL_MUX_SEL, st->mux_sel);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_ENABLES, ENABLE_PLL | ENABLE_LO | ENABLE_VCO |
+			   ENABLE_IFAMP | ENABLE_MIXER | ENABLE_LNA);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int admv4420_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct admv4420_state *st;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_spi(spi, &admv4420_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Error  ADMV4420 initializing spi regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	st->regmap = regmap;
+	mutex_init(&st->lock);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = "admv4420";
+	indio_dev->info = &admv4420_info;
+	indio_dev->channels = admv4420_channels;
+	indio_dev->num_channels = ARRAY_SIZE(admv4420_channels);
+
+	ret = admv4420_setup(indio_dev);
+	if (ret) {
+		dev_err(&spi->dev, "Setup ADMV4420 failed (%d)\n", ret);
+		return ret;
+	}
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id admv4420_of_match[] = {
+	{ .compatible = "adi,admv4420" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, admv4420_of_match);
+
+static struct spi_driver admv4420_driver = {
+	.driver = {
+		.name	= "admv4420",
+		.of_match_table = admv4420_of_match,
+	},
+	.probe		= admv4420_probe,
+};
+module_spi_driver(admv4420_driver);
+
+MODULE_AUTHOR("Cristian Pop <cristian.pop@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADMV44200 K Band Downconverter");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.17.1

