Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10FA49361C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352294AbiASITt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:19:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9436 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352259AbiASITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:19:42 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20J7c3df022804;
        Wed, 19 Jan 2022 03:19:32 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dnu6wn03s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 03:19:32 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20J8JU2w048117
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Jan 2022 03:19:30 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Jan 2022 03:19:29 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Jan 2022 03:19:29 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Jan 2022 03:19:29 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20J8JLn6004163;
        Wed, 19 Jan 2022 03:19:24 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 1/4] iio:frequency:admv1014: add support for ADMV1014
Date:   Wed, 19 Jan 2022 10:18:35 +0200
Message-ID: <20220119081838.70210-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 65-1pr8hmIjeVA_JdWfBwscogRAOxSV8
X-Proofpoint-GUID: 65-1pr8hmIjeVA_JdWfBwscogRAOxSV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_06,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADMV1014 is a silicon germanium (SiGe), wideband,
microwave downconverter optimized for point to point microwave
radio designs operating in the 24 GHz to 44 GHz frequency range.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1014.pdf
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - add line breaks where needed
 - expose IIO channels/attributes based on the input mode
 - remove comma after null terminator
 - make VCC_X regulators optional and remove value checks
 - use only unlocked versions of spi read/write inside init function
 - move powerdown action to init function
 drivers/iio/frequency/Kconfig    |  10 +
 drivers/iio/frequency/Makefile   |   1 +
 drivers/iio/frequency/admv1014.c | 950 +++++++++++++++++++++++++++++++
 3 files changed, 961 insertions(+)
 create mode 100644 drivers/iio/frequency/admv1014.c

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 2c9e0559e8a4..493221f42077 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -50,6 +50,16 @@ config ADF4371
 	  To compile this driver as a module, choose M here: the
 	  module will be called adf4371.
 
+config ADMV1014
+	tristate "Analog Devices ADMV1014 Microwave Downconverter"
+	depends on SPI && COMMON_CLK && 64BIT
+	help
+	  Say yes here to build support for Analog Devices ADMV1014
+	  24 GHz to 44 GHz, Wideband, Microwave Downconverter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called admv1014.
+
 config ADRF6780
         tristate "Analog Devices ADRF6780 Microwave Upconverter"
         depends on SPI
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index ae3136c79202..5f0348e5eb53 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -7,4 +7,5 @@
 obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_ADF4350) += adf4350.o
 obj-$(CONFIG_ADF4371) += adf4371.o
+obj-$(CONFIG_ADMV1014) += admv1014.o
 obj-$(CONFIG_ADRF6780) += adrf6780.o
diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
new file mode 100644
index 000000000000..667e5fade425
--- /dev/null
+++ b/drivers/iio/frequency/admv1014.c
@@ -0,0 +1,950 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADMV1014 driver
+ *
+ * Copyright 2022 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/notifier.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
+
+#include <asm/unaligned.h>
+
+/* ADMV1014 Register Map */
+#define ADMV1014_REG_SPI_CONTROL		0x00
+#define ADMV1014_REG_ALARM			0x01
+#define ADMV1014_REG_ALARM_MASKS		0x02
+#define ADMV1014_REG_ENABLE			0x03
+#define ADMV1014_REG_QUAD			0x04
+#define ADMV1014_REG_LO_AMP_PHASE_ADJUST1	0x05
+#define ADMV1014_REG_MIXER			0x07
+#define ADMV1014_REG_IF_AMP			0x08
+#define ADMV1014_REG_IF_AMP_BB_AMP		0x09
+#define ADMV1014_REG_BB_AMP_AGC			0x0A
+#define ADMV1014_REG_VVA_TEMP_COMP		0x0B
+
+/* ADMV1014_REG_SPI_CONTROL Map */
+#define ADMV1014_PARITY_EN_MSK			BIT(15)
+#define ADMV1014_SPI_SOFT_RESET_MSK		BIT(14)
+#define ADMV1014_CHIP_ID_MSK			GENMASK(11, 4)
+#define ADMV1014_CHIP_ID			0x9
+#define ADMV1014_REVISION_ID_MSK		GENMASK(3, 0)
+
+/* ADMV1014_REG_ALARM Map */
+#define ADMV1014_PARITY_ERROR_MSK		BIT(15)
+#define ADMV1014_TOO_FEW_ERRORS_MSK		BIT(14)
+#define ADMV1014_TOO_MANY_ERRORS_MSK		BIT(13)
+#define ADMV1014_ADDRESS_RANGE_ERROR_MSK	BIT(12)
+
+/* ADMV1014_REG_ENABLE Map */
+#define ADMV1014_IBIAS_PD_MSK			BIT(14)
+#define ADMV1014_P1DB_COMPENSATION_MSK		GENMASK(13, 12)
+#define ADMV1014_IF_AMP_PD_MSK			BIT(11)
+#define ADMV1014_QUAD_BG_PD_MSK			BIT(9)
+#define ADMV1014_BB_AMP_PD_MSK			BIT(8)
+#define ADMV1014_QUAD_IBIAS_PD_MSK		BIT(7)
+#define ADMV1014_DET_EN_MSK			BIT(6)
+#define ADMV1014_BG_PD_MSK			BIT(5)
+
+/* ADMV1014_REG_QUAD Map */
+#define ADMV1014_QUAD_SE_MODE_MSK		GENMASK(9, 6)
+#define ADMV1014_QUAD_FILTERS_MSK		GENMASK(3, 0)
+
+/* ADMV1014_REG_LO_AMP_PHASE_ADJUST1 Map */
+#define ADMV1014_LOAMP_PH_ADJ_I_FINE_MSK	GENMASK(15, 9)
+#define ADMV1014_LOAMP_PH_ADJ_Q_FINE_MSK	GENMASK(8, 2)
+
+/* ADMV1014_REG_MIXER Map */
+#define ADMV1014_MIXER_VGATE_MSK		GENMASK(15, 9)
+#define ADMV1014_DET_PROG_MSK			GENMASK(6, 0)
+
+/* ADMV1014_REG_IF_AMP Map */
+#define ADMV1014_IF_AMP_COARSE_GAIN_I_MSK	GENMASK(11, 8)
+#define ADMV1014_IF_AMP_FINE_GAIN_Q_MSK		GENMASK(7, 4)
+#define ADMV1014_IF_AMP_FINE_GAIN_I_MSK		GENMASK(3, 0)
+
+/* ADMV1014_REG_IF_AMP_BB_AMP Map */
+#define ADMV1014_IF_AMP_COARSE_GAIN_Q_MSK	GENMASK(15, 12)
+#define ADMV1014_BB_AMP_OFFSET_Q_MSK		GENMASK(9, 5)
+#define ADMV1014_BB_AMP_OFFSET_I_MSK		GENMASK(4, 0)
+
+/* ADMV1014_REG_BB_AMP_AGC Map */
+#define ADMV1014_BB_AMP_REF_GEN_MSK		GENMASK(6, 3)
+#define ADMV1014_BB_AMP_GAIN_CTRL_MSK		GENMASK(2, 1)
+#define ADMV1014_BB_SWITCH_HIGH_LOW_CM_MSK	BIT(0)
+
+/* ADMV1014_REG_VVA_TEMP_COMP Map */
+#define ADMV1014_VVA_TEMP_COMP_MSK		GENMASK(15, 0)
+
+/* ADMV1014 Miscellaneous Defines */
+#define ADMV1014_READ				BIT(7)
+#define ADMV1014_REG_ADDR_READ_MSK		GENMASK(6, 1)
+#define ADMV1014_REG_ADDR_WRITE_MSK		GENMASK(22, 17)
+#define ADMV1014_REG_DATA_MSK			GENMASK(16, 1)
+
+enum {
+	ADMV1014_IQ_MODE,
+	ADMV1014_IF_MODE
+};
+
+enum {
+	ADMV1014_SE_MODE_POS = 6,
+	ADMV1014_SE_MODE_NEG = 9,
+	ADMV1014_SE_MODE_DIFF = 12
+};
+
+enum {
+	ADMV1014_CALIBSCALE_COARSE,
+	ADMV1014_CALIBSCALE_FINE,
+};
+
+static const int detector_table[] = {0, 1, 2, 4, 8, 16, 32, 64};
+
+struct admv1014_state {
+	struct spi_device	*spi;
+	struct clk		*clkin;
+	struct notifier_block	nb;
+	/* Protect against concurrent accesses to the device and to data*/
+	struct mutex		lock;
+	struct regulator	*vcm_reg;
+	struct regulator	*vcc_if_bb_reg;
+	struct regulator	*vcc_vga_reg;
+	struct regulator	*vcc_vva_reg;
+	struct regulator	*vcc_lna_3p3_reg;
+	struct regulator	*vcc_lna_1p5_reg;
+	struct regulator	*vcc_bg_reg;
+	struct regulator	*vcc_quad_reg;
+	struct regulator	*vcc_mixer_reg;
+	unsigned int		input_mode;
+	unsigned int		quad_se_mode;
+	unsigned int		p1db_comp;
+	bool			det_en;
+	u8			data[3] ____cacheline_aligned;
+};
+
+static const int mixer_vgate_table[] = {106, 107, 108, 110, 111, 112, 113, 114,
+					117, 118, 119, 120, 122, 123, 44, 45};
+
+static int __admv1014_spi_read(struct admv1014_state *st, unsigned int reg,
+			       unsigned int *val)
+{
+	int ret;
+	struct spi_transfer t = {0};
+
+	st->data[0] = ADMV1014_READ | FIELD_PREP(ADMV1014_REG_ADDR_READ_MSK, reg);
+	st->data[1] = 0x0;
+	st->data[2] = 0x0;
+
+	t.rx_buf = &st->data[0];
+	t.tx_buf = &st->data[0];
+	t.len = 3;
+
+	ret = spi_sync_transfer(st->spi, &t, 1);
+	if (ret)
+		return ret;
+
+	*val = FIELD_GET(ADMV1014_REG_DATA_MSK, get_unaligned_be24(&st->data[0]));
+
+	return ret;
+}
+
+static int admv1014_spi_read(struct admv1014_state *st, unsigned int reg,
+			     unsigned int *val)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = __admv1014_spi_read(st, reg, val);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int __admv1014_spi_write(struct admv1014_state *st,
+				unsigned int reg,
+				unsigned int val)
+{
+	put_unaligned_be24(FIELD_PREP(ADMV1014_REG_DATA_MSK, val) |
+			   FIELD_PREP(ADMV1014_REG_ADDR_WRITE_MSK, reg), &st->data[0]);
+
+	return spi_write(st->spi, &st->data[0], 3);
+}
+
+static int admv1014_spi_write(struct admv1014_state *st, unsigned int reg,
+			      unsigned int val)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = __admv1014_spi_write(st, reg, val);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int __admv1014_spi_update_bits(struct admv1014_state *st, unsigned int reg,
+				      unsigned int mask, unsigned int val)
+{
+	int ret;
+	unsigned int data, temp;
+
+	ret = __admv1014_spi_read(st, reg, &data);
+	if (ret)
+		return ret;
+
+	temp = (data & ~mask) | (val & mask);
+
+	return __admv1014_spi_write(st, reg, temp);
+}
+
+static int admv1014_spi_update_bits(struct admv1014_state *st, unsigned int reg,
+				    unsigned int mask, unsigned int val)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = __admv1014_spi_update_bits(st, reg, mask, val);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int admv1014_update_quad_filters(struct admv1014_state *st)
+{
+	unsigned int filt_raw;
+	u64 rate = clk_get_rate(st->clkin);
+
+	if (rate >= (5400 * HZ_PER_MHZ) && rate <= (7000 * HZ_PER_MHZ))
+		filt_raw = 15;
+	else if (rate >= (5400 * HZ_PER_MHZ) && rate <= (8000 * HZ_PER_MHZ))
+		filt_raw = 10;
+	else if (rate >= (6600 * HZ_PER_MHZ) && rate <= (9200 * HZ_PER_MHZ))
+		filt_raw = 5;
+	else
+		filt_raw = 0;
+
+	return __admv1014_spi_update_bits(st, ADMV1014_REG_QUAD,
+					ADMV1014_QUAD_FILTERS_MSK,
+					FIELD_PREP(ADMV1014_QUAD_FILTERS_MSK, filt_raw));
+}
+
+static int admv1014_update_vcm_settings(struct admv1014_state *st)
+{
+	unsigned int i, vcm_mv, vcm_comp, bb_sw_hl_cm;
+	int ret;
+
+	vcm_mv = regulator_get_voltage(st->vcm_reg) / 1000;
+	for (i = 0; i < ARRAY_SIZE(mixer_vgate_table); i++) {
+		vcm_comp = 1050 + (i * 50) + (i / 8 * 50);
+		if (vcm_mv != vcm_comp)
+			continue;
+
+		ret = __admv1014_spi_update_bits(st, ADMV1014_REG_MIXER,
+						 ADMV1014_MIXER_VGATE_MSK,
+						 FIELD_PREP(ADMV1014_MIXER_VGATE_MSK,
+							    mixer_vgate_table[i]));
+		if (ret)
+			return ret;
+
+		bb_sw_hl_cm = ~(i / 8);
+		bb_sw_hl_cm = FIELD_PREP(ADMV1014_BB_SWITCH_HIGH_LOW_CM_MSK, bb_sw_hl_cm);
+
+		return __admv1014_spi_update_bits(st, ADMV1014_REG_BB_AMP_AGC,
+						  ADMV1014_BB_AMP_REF_GEN_MSK |
+						  ADMV1014_BB_SWITCH_HIGH_LOW_CM_MSK,
+						  FIELD_PREP(ADMV1014_BB_AMP_REF_GEN_MSK, i) |
+						  bb_sw_hl_cm);
+	}
+
+	return -EINVAL;
+}
+
+static int admv1014_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long info)
+{
+	struct admv1014_state *st = iio_priv(indio_dev);
+	unsigned int data;
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_OFFSET:
+		ret = admv1014_spi_read(st, ADMV1014_REG_IF_AMP_BB_AMP, &data);
+		if (ret)
+			return ret;
+
+		if (chan->channel2 == IIO_MOD_I)
+			*val = FIELD_GET(ADMV1014_BB_AMP_OFFSET_I_MSK, data);
+		else
+			*val = FIELD_GET(ADMV1014_BB_AMP_OFFSET_Q_MSK, data);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PHASE:
+		ret = admv1014_spi_read(st, ADMV1014_REG_LO_AMP_PHASE_ADJUST1, &data);
+		if (ret)
+			return ret;
+
+		if (chan->channel2 == IIO_MOD_I)
+			*val = FIELD_GET(ADMV1014_LOAMP_PH_ADJ_I_FINE_MSK, data);
+		else
+			*val = FIELD_GET(ADMV1014_LOAMP_PH_ADJ_Q_FINE_MSK, data);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		ret = admv1014_spi_read(st, ADMV1014_REG_MIXER, &data);
+		if (ret)
+			return ret;
+
+		*val = FIELD_GET(ADMV1014_DET_PROG_MSK, data);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		ret = admv1014_spi_read(st, ADMV1014_REG_BB_AMP_AGC, &data);
+		if (ret)
+			return ret;
+
+		*val = FIELD_GET(ADMV1014_BB_AMP_GAIN_CTRL_MSK, data);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int admv1014_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long info)
+{
+	int data;
+	unsigned int msk;
+	struct admv1014_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->channel2 == IIO_MOD_I) {
+			msk = ADMV1014_BB_AMP_OFFSET_I_MSK;
+			data = FIELD_PREP(ADMV1014_BB_AMP_OFFSET_I_MSK, val);
+		} else {
+			msk = ADMV1014_BB_AMP_OFFSET_Q_MSK;
+			data = FIELD_PREP(ADMV1014_BB_AMP_OFFSET_Q_MSK, val);
+		}
+
+		return admv1014_spi_update_bits(st, ADMV1014_REG_IF_AMP_BB_AMP, msk, data);
+	case IIO_CHAN_INFO_PHASE:
+		if (chan->channel2 == IIO_MOD_I) {
+			msk = ADMV1014_LOAMP_PH_ADJ_I_FINE_MSK;
+			data = FIELD_PREP(ADMV1014_LOAMP_PH_ADJ_I_FINE_MSK, val);
+		} else {
+			msk = ADMV1014_LOAMP_PH_ADJ_Q_FINE_MSK;
+			data = FIELD_PREP(ADMV1014_LOAMP_PH_ADJ_Q_FINE_MSK, val);
+		}
+
+		return admv1014_spi_update_bits(st, ADMV1014_REG_LO_AMP_PHASE_ADJUST1, msk, data);
+	case IIO_CHAN_INFO_SCALE:
+		return admv1014_spi_update_bits(st, ADMV1014_REG_MIXER,
+						ADMV1014_DET_PROG_MSK,
+						FIELD_PREP(ADMV1014_DET_PROG_MSK, val));
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return admv1014_spi_update_bits(st, ADMV1014_REG_BB_AMP_AGC,
+						ADMV1014_BB_AMP_GAIN_CTRL_MSK,
+						FIELD_PREP(ADMV1014_BB_AMP_GAIN_CTRL_MSK, val));
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t admv1014_read(struct iio_dev *indio_dev,
+			     uintptr_t private,
+			     const struct iio_chan_spec *chan,
+			     char *buf)
+{
+	struct admv1014_state *st = iio_priv(indio_dev);
+	unsigned int data;
+	int ret;
+
+	switch ((u32)private) {
+	case ADMV1014_CALIBSCALE_COARSE:
+		if (chan->channel2 == IIO_MOD_I) {
+			ret = admv1014_spi_read(st, ADMV1014_REG_IF_AMP, &data);
+			if (ret)
+				return ret;
+
+			data = FIELD_GET(ADMV1014_IF_AMP_COARSE_GAIN_I_MSK, data);
+		} else {
+			ret = admv1014_spi_read(st, ADMV1014_REG_IF_AMP_BB_AMP, &data);
+			if (ret)
+				return ret;
+
+			data = FIELD_GET(ADMV1014_IF_AMP_COARSE_GAIN_Q_MSK, data);
+		}
+		break;
+	case ADMV1014_CALIBSCALE_FINE:
+		ret = admv1014_spi_read(st, ADMV1014_REG_IF_AMP, &data);
+		if (ret)
+			return ret;
+
+		if (chan->channel2 == IIO_MOD_I)
+			data = FIELD_GET(ADMV1014_IF_AMP_FINE_GAIN_I_MSK, data);
+		else
+			data = FIELD_GET(ADMV1014_IF_AMP_FINE_GAIN_Q_MSK, data);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", data);
+}
+
+static ssize_t admv1014_write(struct iio_dev *indio_dev,
+			      uintptr_t private,
+			      const struct iio_chan_spec *chan,
+			      const char *buf, size_t len)
+{
+	struct admv1014_state *st = iio_priv(indio_dev);
+	unsigned int data, addr, msk;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &data);
+	if (ret)
+		return ret;
+
+	switch ((u32)private) {
+	case ADMV1014_CALIBSCALE_COARSE:
+		if (chan->channel2 == IIO_MOD_I) {
+			addr = ADMV1014_REG_IF_AMP;
+			msk = ADMV1014_IF_AMP_COARSE_GAIN_I_MSK;
+			data = FIELD_PREP(ADMV1014_IF_AMP_COARSE_GAIN_I_MSK, data);
+		} else {
+			addr = ADMV1014_REG_IF_AMP_BB_AMP;
+			msk = ADMV1014_IF_AMP_COARSE_GAIN_Q_MSK;
+			data = FIELD_PREP(ADMV1014_IF_AMP_COARSE_GAIN_Q_MSK, data);
+		}
+		break;
+	case ADMV1014_CALIBSCALE_FINE:
+		addr = ADMV1014_REG_IF_AMP;
+
+		if (chan->channel2 == IIO_MOD_I) {
+			msk = ADMV1014_IF_AMP_FINE_GAIN_I_MSK;
+			data = FIELD_PREP(ADMV1014_IF_AMP_FINE_GAIN_I_MSK, data);
+		} else {
+			msk = ADMV1014_IF_AMP_FINE_GAIN_Q_MSK;
+			data = FIELD_PREP(ADMV1014_IF_AMP_FINE_GAIN_Q_MSK, data);
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = admv1014_spi_update_bits(st, addr, msk, data);
+
+	return ret ? ret : len;
+}
+
+static int admv1014_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = detector_table;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(detector_table);
+
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int admv1014_reg_access(struct iio_dev *indio_dev,
+			       unsigned int reg,
+			       unsigned int write_val,
+			       unsigned int *read_val)
+{
+	struct admv1014_state *st = iio_priv(indio_dev);
+
+	if (read_val)
+		return admv1014_spi_read(st, reg, read_val);
+	else
+		return admv1014_spi_write(st, reg, write_val);
+}
+
+static const struct iio_info admv1014_info = {
+	.read_raw = admv1014_read_raw,
+	.write_raw = admv1014_write_raw,
+	.read_avail = &admv1014_read_avail,
+	.debugfs_reg_access = &admv1014_reg_access,
+};
+
+static int admv1014_freq_change(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct admv1014_state *st = container_of(nb, struct admv1014_state, nb);
+	int ret;
+
+	if (action == POST_RATE_CHANGE) {
+		mutex_lock(&st->lock);
+		ret = notifier_from_errno(admv1014_update_quad_filters(st));
+		mutex_unlock(&st->lock);
+		return ret;
+	}
+
+	return NOTIFY_OK;
+}
+
+#define _ADMV1014_EXT_INFO(_name, _shared, _ident) { \
+		.name = _name, \
+		.read = admv1014_read, \
+		.write = admv1014_write, \
+		.private = _ident, \
+		.shared = _shared, \
+}
+
+static const struct iio_chan_spec_ext_info admv1014_ext_info[] = {
+	_ADMV1014_EXT_INFO("calibscale_coarse", IIO_SEPARATE, ADMV1014_CALIBSCALE_COARSE),
+	_ADMV1014_EXT_INFO("calibscale_fine", IIO_SEPARATE, ADMV1014_CALIBSCALE_FINE),
+	{ }
+};
+
+#define ADMV1014_CHAN_IQ(_channel, rf_comp) {				\
+	.type = IIO_ALTVOLTAGE,						\
+	.modified = 1,							\
+	.output = 0,							\
+	.indexed = 1,							\
+	.channel2 = IIO_MOD_##rf_comp,					\
+	.channel = _channel,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE) |		\
+		BIT(IIO_CHAN_INFO_OFFSET),				\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBSCALE)	\
+	}
+
+#define ADMV1014_CHAN_IF(_channel, rf_comp) {				\
+	.type = IIO_ALTVOLTAGE,						\
+	.modified = 1,							\
+	.output = 0,							\
+	.indexed = 1,							\
+	.channel2 = IIO_MOD_##rf_comp,					\
+	.channel = _channel,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE) |		\
+		BIT(IIO_CHAN_INFO_OFFSET)				\
+	}
+
+#define ADMV1014_CHAN_POWER(_channel) {					\
+	.type = IIO_POWER,						\
+	.output = 0,							\
+	.indexed = 1,							\
+	.channel = _channel,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),			\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE)	\
+	}
+
+#define ADMV1014_CHAN_CALIBSCALE(_channel, rf_comp, _admv1014_ext_info) {	\
+	.type = IIO_ALTVOLTAGE,							\
+	.modified = 1,								\
+	.output = 0,								\
+	.indexed = 1,								\
+	.channel2 = IIO_MOD_##rf_comp,						\
+	.channel = _channel,							\
+	.ext_info = _admv1014_ext_info						\
+	}
+
+static const struct iio_chan_spec admv1014_channels_iq[] = {
+	ADMV1014_CHAN_IQ(0, I),
+	ADMV1014_CHAN_IQ(0, Q),
+	ADMV1014_CHAN_POWER(0)
+};
+
+static const struct iio_chan_spec admv1014_channels_if[] = {
+	ADMV1014_CHAN_IF(0, I),
+	ADMV1014_CHAN_IF(0, Q),
+	ADMV1014_CHAN_CALIBSCALE(0, I, admv1014_ext_info),
+	ADMV1014_CHAN_CALIBSCALE(0, Q, admv1014_ext_info),
+	ADMV1014_CHAN_POWER(0)
+};
+
+static void admv1014_clk_disable(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static void admv1014_reg_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static void admv1014_powerdown(void *data)
+{
+	unsigned int enable_reg, enable_reg_msk;
+
+	/* Disable all components in the Enable Register */
+	enable_reg_msk = ADMV1014_IBIAS_PD_MSK |
+			ADMV1014_IF_AMP_PD_MSK |
+			ADMV1014_QUAD_BG_PD_MSK |
+			ADMV1014_BB_AMP_PD_MSK |
+			ADMV1014_QUAD_IBIAS_PD_MSK |
+			ADMV1014_BG_PD_MSK;
+
+	enable_reg = FIELD_PREP(ADMV1014_IBIAS_PD_MSK, 1) |
+			FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, 1) |
+			FIELD_PREP(ADMV1014_QUAD_BG_PD_MSK, 1) |
+			FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, 1) |
+			FIELD_PREP(ADMV1014_QUAD_IBIAS_PD_MSK, 1) |
+			FIELD_PREP(ADMV1014_BG_PD_MSK, 1);
+
+	admv1014_spi_update_bits(data, ADMV1014_REG_ENABLE,
+				 enable_reg_msk, enable_reg);
+}
+
+static int admv1014_init(struct admv1014_state *st)
+{
+	int ret;
+	unsigned int chip_id, enable_reg, enable_reg_msk;
+	struct spi_device *spi = st->spi;
+
+	ret = regulator_enable(st->vcm_reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable Common-Mode Voltage!\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcm_reg);
+	if (ret)
+		return ret;
+
+	if (st->vcc_if_bb_reg) {
+		ret = regulator_enable(st->vcc_if_bb_reg);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable BB and IF Voltage!\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_if_bb_reg);
+		if (ret)
+			return ret;
+	}
+
+	if (st->vcc_vga_reg) {
+		ret = regulator_enable(st->vcc_vga_reg);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable RF Amplifier Voltage!\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_vga_reg);
+		if (ret)
+			return ret;
+	}
+
+	if (st->vcc_vva_reg) {
+		ret = regulator_enable(st->vcc_vva_reg);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable VVA Control Circuit Voltage!\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_vva_reg);
+		if (ret)
+			return ret;
+	}
+
+	if (st->vcc_lna_3p3_reg) {
+		ret = regulator_enable(st->vcc_lna_3p3_reg);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable Low Noise Amplifier 3.3V Voltage!\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_lna_3p3_reg);
+		if (ret)
+			return ret;
+	}
+
+	if (st->vcc_lna_1p5_reg) {
+		ret = regulator_enable(st->vcc_lna_1p5_reg);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable Low Noise Amplifier 1.5V Voltage!\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_lna_1p5_reg);
+		if (ret)
+			return ret;
+	}
+
+	if (st->vcc_bg_reg) {
+		ret = regulator_enable(st->vcc_bg_reg);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable Band Gap Circuit Voltage!\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_bg_reg);
+		if (ret)
+			return ret;
+	}
+
+	if (st->vcc_quad_reg) {
+		ret = regulator_enable(st->vcc_quad_reg);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable Quadruple Voltage!\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_quad_reg);
+		if (ret)
+			return ret;
+	}
+
+	if (st->vcc_mixer_reg) {
+		ret = regulator_enable(st->vcc_mixer_reg);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable Mixer Voltage!\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_mixer_reg);
+		if (ret)
+			return ret;
+	}
+
+	ret = clk_prepare_enable(st->clkin);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, admv1014_clk_disable, st->clkin);
+	if (ret)
+		return ret;
+
+	st->nb.notifier_call = admv1014_freq_change;
+	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, admv1014_powerdown, st);
+	if (ret)
+		return ret;
+
+	/* Perform a software reset */
+	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
+					 ADMV1014_SPI_SOFT_RESET_MSK,
+					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 1));
+	if (ret) {
+		dev_err(&spi->dev, "ADMV1014 SPI software reset failed.\n");
+		return ret;
+	}
+
+	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
+					 ADMV1014_SPI_SOFT_RESET_MSK,
+					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 0));
+	if (ret) {
+		dev_err(&spi->dev, "ADMV1014 SPI software reset disable failed.\n");
+		return ret;
+	}
+
+	ret = __admv1014_spi_write(st, ADMV1014_REG_VVA_TEMP_COMP, 0x727C);
+	if (ret) {
+		dev_err(&spi->dev, "Writing default Temperature Compensation value failed.\n");
+		return ret;
+	}
+
+	ret = __admv1014_spi_read(st, ADMV1014_REG_SPI_CONTROL, &chip_id);
+	if (ret)
+		return ret;
+
+	chip_id = (chip_id & ADMV1014_CHIP_ID_MSK) >> 4;
+	if (chip_id != ADMV1014_CHIP_ID) {
+		dev_err(&spi->dev, "Invalid Chip ID.\n");
+		return -EINVAL;
+	}
+
+	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_QUAD,
+					 ADMV1014_QUAD_SE_MODE_MSK,
+					 FIELD_PREP(ADMV1014_QUAD_SE_MODE_MSK,
+						    st->quad_se_mode));
+	if (ret) {
+		dev_err(&spi->dev, "Writing Quad SE Mode failed.\n");
+		return ret;
+	}
+
+	ret = admv1014_update_quad_filters(st);
+	if (ret) {
+		dev_err(&spi->dev, "Update Quad Filters failed.\n");
+		return ret;
+	}
+
+	ret = admv1014_update_vcm_settings(st);
+	if (ret) {
+		dev_err(&spi->dev, "Update VCM Settings failed.\n");
+		return ret;
+	}
+
+	enable_reg_msk = ADMV1014_P1DB_COMPENSATION_MSK |
+			 ADMV1014_IF_AMP_PD_MSK |
+			 ADMV1014_BB_AMP_PD_MSK |
+			 ADMV1014_DET_EN_MSK;
+
+	enable_reg = FIELD_PREP(ADMV1014_P1DB_COMPENSATION_MSK, st->p1db_comp ? 3 : 0) |
+		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, !(st->input_mode)) |
+		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, st->input_mode) |
+		     FIELD_PREP(ADMV1014_DET_EN_MSK, st->det_en);
+
+	return __admv1014_spi_update_bits(st, ADMV1014_REG_ENABLE, enable_reg_msk, enable_reg);
+}
+
+static int admv1014_properties_parse(struct admv1014_state *st)
+{
+	const char *str;
+	struct spi_device *spi = st->spi;
+
+	st->det_en = device_property_read_bool(&spi->dev, "adi,detector-enable");
+
+	st->p1db_comp = device_property_read_bool(&spi->dev, "adi,p1db-compensation-enable");
+
+	str = "iq";
+	device_property_read_string(&spi->dev, "adi,input-mode", &str);
+
+	if (!strcmp(str, "iq"))
+		st->input_mode = ADMV1014_IQ_MODE;
+	else if (!strcmp(str, "if"))
+		st->input_mode = ADMV1014_IF_MODE;
+	else
+		return -EINVAL;
+
+	str = "diff";
+	device_property_read_string(&spi->dev, "adi,quad-se-mode", &str);
+
+	if (!strcmp(str, "diff"))
+		st->quad_se_mode = ADMV1014_SE_MODE_DIFF;
+	else if (!strcmp(str, "se-pos"))
+		st->quad_se_mode = ADMV1014_SE_MODE_POS;
+	else if (!strcmp(str, "se-neg"))
+		st->quad_se_mode = ADMV1014_SE_MODE_NEG;
+	else
+		return -EINVAL;
+
+	st->vcm_reg = devm_regulator_get(&spi->dev, "vcm");
+	if (IS_ERR(st->vcm_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->vcm_reg),
+				     "failed to get the common-mode voltage\n");
+
+	st->vcc_if_bb_reg = devm_regulator_get_optional(&spi->dev, "vcc-if-bb");
+	if (IS_ERR(st->vcc_if_bb_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_if_bb_reg),
+				     "failed to get the BB and IF supply\n");
+
+	st->vcc_vga_reg = devm_regulator_get_optional(&spi->dev, "vcc-vga");
+	if (IS_ERR(st->vcc_vga_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_vga_reg),
+				     "failed to get the RF Amplifier supply\n");
+
+	st->vcc_vva_reg = devm_regulator_get_optional(&spi->dev, "vcc-vva");
+	if (IS_ERR(st->vcc_vva_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_vva_reg),
+				     "failed to get the VVA Control Circuit supply\n");
+
+	st->vcc_lna_3p3_reg = devm_regulator_get_optional(&spi->dev, "vcc-lna-3p3");
+	if (IS_ERR(st->vcc_lna_3p3_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_lna_3p3_reg),
+				     "failed to get the Low Noise Amplifier 3.3V supply\n");
+
+	st->vcc_lna_1p5_reg = devm_regulator_get_optional(&spi->dev, "vcc-lna-1p5");
+	if (IS_ERR(st->vcc_lna_1p5_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_lna_1p5_reg),
+				     "failed to get the Low Noise Amplifier 1.5V supply\n");
+
+	st->vcc_bg_reg = devm_regulator_get_optional(&spi->dev, "vcc-bg");
+	if (IS_ERR(st->vcc_lna_1p5_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_bg_reg),
+				     "failed to get the Band Gap Circuit supply\n");
+
+	st->vcc_quad_reg = devm_regulator_get_optional(&spi->dev, "vcc-quad");
+	if (IS_ERR(st->vcc_quad_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_quad_reg),
+				     "failed to get the Quadruple supply\n");
+
+	st->vcc_mixer_reg = devm_regulator_get_optional(&spi->dev, "vcc-mixer");
+	if (IS_ERR(st->vcc_quad_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_mixer_reg),
+				     "failed to get the Mixer supply\n");
+
+	st->clkin = devm_clk_get(&spi->dev, "lo_in");
+	if (IS_ERR(st->clkin))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+				     "failed to get the LO input clock\n");
+
+	return 0;
+}
+
+static int admv1014_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct admv1014_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	ret = admv1014_properties_parse(st);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &admv1014_info;
+	indio_dev->name = "admv1014";
+
+	if (st->input_mode == ADMV1014_IQ_MODE) {
+		indio_dev->channels = admv1014_channels_iq;
+		indio_dev->num_channels = ARRAY_SIZE(admv1014_channels_iq);
+	} else {
+		indio_dev->channels = admv1014_channels_if;
+		indio_dev->num_channels = ARRAY_SIZE(admv1014_channels_if);
+	}
+
+	st->spi = spi;
+
+	mutex_init(&st->lock);
+
+	ret = admv1014_init(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id admv1014_id[] = {
+	{ "admv1014", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, admv1014_id);
+
+static const struct of_device_id admv1014_of_match[] = {
+	{ .compatible = "adi,admv1014" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, admv1014_of_match);
+
+static struct spi_driver admv1014_driver = {
+	.driver = {
+		.name = "admv1014",
+		.of_match_table = admv1014_of_match,
+	},
+	.probe = admv1014_probe,
+	.id_table = admv1014_id,
+};
+module_spi_driver(admv1014_driver);
+
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_DESCRIPTION("Analog Devices ADMV1014");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

