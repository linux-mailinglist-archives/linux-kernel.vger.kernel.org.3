Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858E046A06C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376977AbhLFQEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:04:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9148 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352065AbhLFPwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:52:39 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B6CA5jj032573;
        Mon, 6 Dec 2021 10:49:08 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3csj9d8vcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 10:49:07 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1B6Fn6Dn016083
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 10:49:06 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 6 Dec 2021 10:49:05 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 6 Dec 2021 10:49:05 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 6 Dec 2021 10:49:05 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1B6Fn3pK002802;
        Mon, 6 Dec 2021 10:49:03 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 1/3] iio: frequency: admv1013: add support for ADMV1013
Date:   Mon, 6 Dec 2021 17:48:43 +0200
Message-ID: <20211206154845.268445-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ak2fKontKWXXnlxSeTEbH9lGsFCSMi_e
X-Proofpoint-ORIG-GUID: ak2fKontKWXXnlxSeTEbH9lGsFCSMi_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_05,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADMV1013 is a wideband, microwave upconverter optimized
for point to point microwave radio designs operating in the
24 GHz to 44 GHz radio frequency (RF) range.

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1013.pdf

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/Kconfig    |  11 +
 drivers/iio/frequency/Makefile   |   1 +
 drivers/iio/frequency/admv1013.c | 628 +++++++++++++++++++++++++++++++
 3 files changed, 640 insertions(+)
 create mode 100644 drivers/iio/frequency/admv1013.c

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 240b81502512..411b3b961e46 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -49,5 +49,16 @@ config ADF4371
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called adf4371.
+
+config ADMV1013
+	tristate "Analog Devices ADMV1013 Microwave Upconverter"
+	depends on SPI && COMMON_CLK
+	help
+	  Say yes here to build support for Analog Devices ADMV1013
+	  24 GHz to 44 GHz, Wideband, Microwave Upconverter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called admv1013.
+
 endmenu
 endmenu
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index 518b1e50caef..559922a8196e 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -7,3 +7,4 @@
 obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_ADF4350) += adf4350.o
 obj-$(CONFIG_ADF4371) += adf4371.o
+obj-$(CONFIG_ADMV1013) += admv1013.o
diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
new file mode 100644
index 000000000000..ccefd79603fe
--- /dev/null
+++ b/drivers/iio/frequency/admv1013.c
@@ -0,0 +1,628 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADMV1013 driver
+ *
+ * Copyright 2021 Analog Devices Inc.
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
+/* ADMV1013 Register Map */
+#define ADMV1013_REG_SPI_CONTROL		0x00
+#define ADMV1013_REG_ALARM			0x01
+#define ADMV1013_REG_ALARM_MASKS		0x02
+#define ADMV1013_REG_ENABLE			0x03
+#define ADMV1013_REG_LO_AMP_I			0x05
+#define ADMV1013_REG_LO_AMP_Q			0x06
+#define ADMV1013_REG_OFFSET_ADJUST_I		0x07
+#define ADMV1013_REG_OFFSET_ADJUST_Q		0x08
+#define ADMV1013_REG_QUAD			0x09
+#define ADMV1013_REG_VVA_TEMP_COMP		0x0A
+
+/* ADMV1013_REG_SPI_CONTROL Map */
+#define ADMV1013_PARITY_EN_MSK			BIT(15)
+#define ADMV1013_SPI_SOFT_RESET_MSK		BIT(14)
+#define ADMV1013_CHIP_ID_MSK			GENMASK(11, 4)
+#define ADMV1013_CHIP_ID			0xA
+#define ADMV1013_REVISION_ID_MSK		GENMASK(3, 0)
+
+/* ADMV1013_REG_ALARM Map */
+#define ADMV1013_PARITY_ERROR_MSK		BIT(15)
+#define ADMV1013_TOO_FEW_ERRORS_MSK		BIT(14)
+#define ADMV1013_TOO_MANY_ERRORS_MSK		BIT(13)
+#define ADMV1013_ADDRESS_RANGE_ERROR_MSK	BIT(12)
+
+/* ADMV1013_REG_ENABLE Map */
+#define ADMV1013_VGA_PD_MSK			BIT(15)
+#define ADMV1013_MIXER_PD_MSK			BIT(14)
+#define ADMV1013_QUAD_PD_MSK			GENMASK(13, 11)
+#define ADMV1013_BG_PD_MSK			BIT(10)
+#define ADMV1013_MIXER_IF_EN_MSK		BIT(7)
+#define ADMV1013_DET_EN_MSK			BIT(5)
+
+/* ADMV1013_REG_LO_AMP Map */
+#define ADMV1013_LOAMP_PH_ADJ_FINE_MSK		GENMASK(13, 7)
+#define ADMV1013_MIXER_VGATE_MSK		GENMASK(6, 0)
+
+/* ADMV1013_REG_OFFSET_ADJUST Map */
+#define ADMV1013_MIXER_OFF_ADJ_P_MSK		GENMASK(15, 9)
+#define ADMV1013_MIXER_OFF_ADJ_N_MSK		GENMASK(8, 2)
+
+/* ADMV1013_REG_QUAD Map */
+#define ADMV1013_QUAD_SE_MODE_MSK		GENMASK(9, 6)
+#define ADMV1013_QUAD_FILTERS_MSK		GENMASK(3, 0)
+
+/* ADMV1013_REG_VVA_TEMP_COMP Map */
+#define ADMV1013_VVA_TEMP_COMP_MSK		GENMASK(15, 0)
+
+/* ADMV1013 Miscellaneous Defines */
+#define ADMV1013_READ				BIT(7)
+#define ADMV1013_REG_ADDR_READ_MSK		GENMASK(6, 1)
+#define ADMV1013_REG_ADDR_WRITE_MSK		GENMASK(22, 17)
+#define ADMV1013_REG_DATA_MSK			GENMASK(16, 1)
+
+enum {
+	ADMV1013_IQ_MODE,
+	ADMV1013_IF_MODE
+};
+
+enum {
+	ADMV1013_RFMOD_I_PHASE,
+	ADMV1013_RFMOD_Q_PHASE,
+};
+
+enum {
+	ADMV1013_SE_MODE_POS = 6,
+	ADMV1013_SE_MODE_NEG = 9,
+	ADMV1013_SE_MODE_DIFF = 12
+};
+
+struct admv1013_state {
+	struct spi_device	*spi;
+	struct clk		*clkin;
+	/* Protect against concurrent accesses to the device and to data */
+	struct mutex		lock;
+	struct regulator	*reg;
+	struct notifier_block	nb;
+	unsigned int		input_mode;
+	unsigned int		quad_se_mode;
+	bool			det_en;
+	u8			data[3] ____cacheline_aligned;
+};
+
+static int __admv1013_spi_read(struct admv1013_state *st, unsigned int reg,
+			       unsigned int *val)
+{
+	int ret;
+	struct spi_transfer t = {0};
+
+	st->data[0] = ADMV1013_READ | FIELD_PREP(ADMV1013_REG_ADDR_READ_MSK, reg);
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
+	*val = FIELD_GET(ADMV1013_REG_DATA_MSK, get_unaligned_be24(&st->data[0]));
+
+	return ret;
+}
+
+static int admv1013_spi_read(struct admv1013_state *st, unsigned int reg,
+			     unsigned int *val)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = __admv1013_spi_read(st, reg, val);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int __admv1013_spi_write(struct admv1013_state *st,
+				unsigned int reg,
+				unsigned int val)
+{
+	put_unaligned_be24(FIELD_PREP(ADMV1013_REG_DATA_MSK, val) |
+			   FIELD_PREP(ADMV1013_REG_ADDR_WRITE_MSK, reg), &st->data[0]);
+
+	return spi_write(st->spi, &st->data[0], 3);
+}
+
+static int admv1013_spi_write(struct admv1013_state *st, unsigned int reg,
+			      unsigned int val)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = __admv1013_spi_write(st, reg, val);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int __admv1013_spi_update_bits(struct admv1013_state *st, unsigned int reg,
+				      unsigned int mask, unsigned int val)
+{
+	int ret;
+	unsigned int data, temp;
+
+	ret = __admv1013_spi_read(st, reg, &data);
+	if (ret)
+		return ret;
+
+	temp = (data & ~mask) | (val & mask);
+
+	return __admv1013_spi_write(st, reg, temp);
+}
+
+static int admv1013_spi_update_bits(struct admv1013_state *st, unsigned int reg,
+				    unsigned int mask, unsigned int val)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = __admv1013_spi_update_bits(st, reg, mask, val);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static ssize_t admv1013_read(struct iio_dev *indio_dev,
+			     uintptr_t private,
+			     const struct iio_chan_spec *chan,
+			     char *buf)
+{
+	struct admv1013_state *st = iio_priv(indio_dev);
+	unsigned int data, addr;
+	int ret;
+
+	if (chan->differential) {
+		switch ((u32)private) {
+		case ADMV1013_RFMOD_I_PHASE:
+			addr = ADMV1013_REG_LO_AMP_I;
+			break;
+		case ADMV1013_RFMOD_Q_PHASE:
+			addr = ADMV1013_REG_LO_AMP_Q;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = admv1013_spi_read(st, addr, &data);
+		if (ret)
+			return ret;
+
+		data = FIELD_GET(ADMV1013_LOAMP_PH_ADJ_FINE_MSK, data);
+	} else {
+		switch (chan->channel) {
+		case IIO_MOD_I:
+			addr = ADMV1013_REG_OFFSET_ADJUST_I;
+			break;
+		case IIO_MOD_Q:
+			addr = ADMV1013_REG_OFFSET_ADJUST_Q;
+			break;
+		default:
+			return -EINVAL;
+		}
+		ret = admv1013_spi_read(st, addr, &data);
+
+		if (!chan->channel)
+			data = FIELD_GET(ADMV1013_MIXER_OFF_ADJ_P_MSK, data);
+		else
+			data = FIELD_GET(ADMV1013_MIXER_OFF_ADJ_N_MSK, data);
+	}
+
+	return sysfs_emit(buf, "%u\n", data);
+}
+
+static ssize_t admv1013_write(struct iio_dev *indio_dev,
+			      uintptr_t private,
+			      const struct iio_chan_spec *chan,
+			      const char *buf, size_t len)
+{
+	struct admv1013_state *st = iio_priv(indio_dev);
+	unsigned int data, addr, msk;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &data);
+	if (ret)
+		return ret;
+
+	if (chan->differential) {
+		data = FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_FINE_MSK, data);
+
+		switch ((u32)private) {
+		case ADMV1013_RFMOD_I_PHASE:
+			ret = admv1013_spi_update_bits(st, ADMV1013_REG_LO_AMP_I,
+						       ADMV1013_LOAMP_PH_ADJ_FINE_MSK,
+						       data);
+			if (ret)
+				return ret;
+			break;
+		case ADMV1013_RFMOD_Q_PHASE:
+			ret = admv1013_spi_update_bits(st, ADMV1013_REG_LO_AMP_Q,
+						       ADMV1013_LOAMP_PH_ADJ_FINE_MSK,
+						       data);
+			if (ret)
+				return ret;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		switch (chan->channel2) {
+		case IIO_MOD_I:
+			addr = ADMV1013_REG_OFFSET_ADJUST_I;
+			break;
+		case IIO_MOD_Q:
+			addr = ADMV1013_REG_OFFSET_ADJUST_Q;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (!chan->channel) {
+			msk = ADMV1013_MIXER_OFF_ADJ_P_MSK;
+			data = FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_P_MSK, data);
+		} else {
+			msk = ADMV1013_MIXER_OFF_ADJ_N_MSK;
+			data = FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_N_MSK, data);
+		}
+
+		ret = admv1013_spi_update_bits(st, addr, msk, data);
+	}
+
+	return ret ? ret : len;
+}
+
+static int admv1013_update_quad_filters(struct admv1013_state *st)
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
+	return __admv1013_spi_update_bits(st, ADMV1013_REG_QUAD,
+					ADMV1013_QUAD_FILTERS_MSK,
+					FIELD_PREP(ADMV1013_QUAD_FILTERS_MSK, filt_raw));
+}
+
+static int admv1013_update_mixer_vgate(struct admv1013_state *st)
+{
+	unsigned int vcm, mixer_vgate;
+
+	vcm = regulator_get_voltage(st->reg);
+
+	if (vcm >= 0 && vcm < 1800000)
+		mixer_vgate = (2389 * vcm / 1000000 + 8100) / 100;
+	else if (vcm > 1800000 && vcm < 2600000)
+		mixer_vgate = (2375 * vcm / 1000000 + 125) / 100;
+	else
+		return -EINVAL;
+
+	return __admv1013_spi_update_bits(st, ADMV1013_REG_LO_AMP_I,
+				 ADMV1013_MIXER_VGATE_MSK,
+				 FIELD_PREP(ADMV1013_MIXER_VGATE_MSK, mixer_vgate));
+}
+
+static int admv1013_reg_access(struct iio_dev *indio_dev,
+			       unsigned int reg,
+			       unsigned int write_val,
+			       unsigned int *read_val)
+{
+	struct admv1013_state *st = iio_priv(indio_dev);
+
+	if (read_val)
+		return admv1013_spi_read(st, reg, read_val);
+	else
+		return admv1013_spi_write(st, reg, write_val);
+}
+
+static const struct iio_info admv1013_info = {
+	.debugfs_reg_access = &admv1013_reg_access,
+};
+
+static int admv1013_freq_change(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct admv1013_state *st = container_of(nb, struct admv1013_state, nb);
+	int ret;
+
+	if (action == POST_RATE_CHANGE) {
+		mutex_lock(&st->lock);
+		ret = notifier_from_errno(admv1013_update_quad_filters(st));
+		mutex_unlock(&st->lock);
+		return ret;
+	}
+
+	return NOTIFY_OK;
+}
+
+#define _ADMV1013_EXT_INFO(_name, _shared, _ident) { \
+		.name = _name, \
+		.read = admv1013_read, \
+		.write = admv1013_write, \
+		.private = _ident, \
+		.shared = _shared, \
+}
+
+static const struct iio_chan_spec_ext_info admv1013_ext_info[] = {
+	_ADMV1013_EXT_INFO("i_phase", IIO_SEPARATE, ADMV1013_RFMOD_I_PHASE),
+	_ADMV1013_EXT_INFO("q_phase", IIO_SEPARATE, ADMV1013_RFMOD_Q_PHASE),
+	{ },
+};
+
+#define ADMV1013_CHAN_PHASE(_channel, _channel2, _admv1013_ext_info) {		\
+	.type = IIO_ALTVOLTAGE,					\
+	.output = 0,						\
+	.indexed = 1,						\
+	.channel2 = _channel2,					\
+	.channel = _channel,					\
+	.differential = 1,					\
+	.ext_info = _admv1013_ext_info,				\
+	}
+
+#define ADMV1013_CHAN_CALIB(_channel, rf_comp) {	\
+	.type = IIO_ALTVOLTAGE,					\
+	.output = 0,						\
+	.indexed = 1,						\
+	.channel = _channel,					\
+	.channel2 = IIO_MOD_##rf_comp,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS),	\
+	}
+
+static const struct iio_chan_spec admv1013_channels[] = {
+	ADMV1013_CHAN_PHASE(0, 1, admv1013_ext_info),
+	ADMV1013_CHAN_CALIB(0, I),
+	ADMV1013_CHAN_CALIB(0, Q),
+	ADMV1013_CHAN_CALIB(1, I),
+	ADMV1013_CHAN_CALIB(1, Q),
+};
+
+static int admv1013_init(struct admv1013_state *st)
+{
+	int ret;
+	unsigned int data;
+	struct spi_device *spi = st->spi;
+
+	/* Perform a software reset */
+	ret = __admv1013_spi_update_bits(st, ADMV1013_REG_SPI_CONTROL,
+					 ADMV1013_SPI_SOFT_RESET_MSK,
+					 FIELD_PREP(ADMV1013_SPI_SOFT_RESET_MSK, 1));
+	if (ret)
+		return ret;
+
+	ret = __admv1013_spi_update_bits(st, ADMV1013_REG_SPI_CONTROL,
+					 ADMV1013_SPI_SOFT_RESET_MSK,
+					 FIELD_PREP(ADMV1013_SPI_SOFT_RESET_MSK, 0));
+	if (ret)
+		return ret;
+
+	ret = __admv1013_spi_read(st, ADMV1013_REG_SPI_CONTROL, &data);
+	if (ret)
+		return ret;
+
+	data = FIELD_GET(ADMV1013_CHIP_ID_MSK, data);
+	if (data != ADMV1013_CHIP_ID) {
+		dev_err(&spi->dev, "Invalid Chip ID.\n");
+		return -EINVAL;
+	}
+
+	ret = __admv1013_spi_write(st, ADMV1013_REG_VVA_TEMP_COMP, 0xE700);
+	if (ret)
+		return ret;
+
+	data = FIELD_PREP(ADMV1013_QUAD_SE_MODE_MSK, st->quad_se_mode);
+
+	ret = __admv1013_spi_update_bits(st, ADMV1013_REG_QUAD,
+					 ADMV1013_QUAD_SE_MODE_MSK, data);
+	if (ret)
+		return ret;
+
+	ret = admv1013_update_mixer_vgate(st);
+	if (ret)
+		return ret;
+
+	ret = admv1013_update_quad_filters(st);
+	if (ret)
+		return ret;
+
+	return __admv1013_spi_update_bits(st, ADMV1013_REG_ENABLE,
+					  ADMV1013_DET_EN_MSK |
+					  ADMV1013_MIXER_IF_EN_MSK,
+					  st->det_en |
+					  st->input_mode);
+}
+
+static void admv1013_clk_disable(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static void admv1013_reg_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static void admv1013_powerdown(void *data)
+{
+	unsigned int enable_reg, enable_reg_msk;
+
+	/* Disable all components in the Enable Register */
+	enable_reg_msk = ADMV1013_VGA_PD_MSK |
+			ADMV1013_MIXER_PD_MSK |
+			ADMV1013_QUAD_PD_MSK |
+			ADMV1013_BG_PD_MSK |
+			ADMV1013_MIXER_IF_EN_MSK |
+			ADMV1013_DET_EN_MSK;
+
+	enable_reg = FIELD_PREP(ADMV1013_VGA_PD_MSK, 1) |
+			FIELD_PREP(ADMV1013_MIXER_PD_MSK, 1) |
+			FIELD_PREP(ADMV1013_QUAD_PD_MSK, 7) |
+			FIELD_PREP(ADMV1013_BG_PD_MSK, 1) |
+			FIELD_PREP(ADMV1013_MIXER_IF_EN_MSK, 0) |
+			FIELD_PREP(ADMV1013_DET_EN_MSK, 0);
+
+	admv1013_spi_update_bits(data, ADMV1013_REG_ENABLE, enable_reg_msk, enable_reg);
+}
+
+static int admv1013_properties_parse(struct admv1013_state *st)
+{
+	int ret;
+	const char *str;
+	struct spi_device *spi = st->spi;
+
+	st->det_en = device_property_read_bool(&spi->dev, "adi,detector-enable");
+
+	ret = device_property_read_string(&spi->dev, "adi,input-mode", &str);
+	if (ret)
+		st->input_mode = ADMV1013_IQ_MODE;
+
+	if (!strcmp(str, "iq"))
+		st->input_mode = ADMV1013_IQ_MODE;
+	else if (!strcmp(str, "if"))
+		st->input_mode = ADMV1013_IF_MODE;
+	else
+		return -EINVAL;
+
+	ret = device_property_read_string(&spi->dev, "adi,quad-se-mode", &str);
+	if (ret)
+		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
+
+	if (!strcmp(str, "diff"))
+		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
+	else if (!strcmp(str, "se-pos"))
+		st->quad_se_mode = ADMV1013_SE_MODE_POS;
+	else if (!strcmp(str, "se-neg"))
+		st->quad_se_mode = ADMV1013_SE_MODE_NEG;
+	else
+		return -EINVAL;
+
+	st->reg = devm_regulator_get(&spi->dev, "vcm");
+	if (IS_ERR(st->reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
+				     "failed to get the common-mode voltage\n");
+
+	st->clkin = devm_clk_get(&spi->dev, "lo_in");
+	if (IS_ERR(st->clkin))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+				     "failed to get the LO input clock\n");
+
+	return 0;
+}
+
+static int admv1013_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct admv1013_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	indio_dev->info = &admv1013_info;
+	indio_dev->name = "admv1013";
+	indio_dev->channels = admv1013_channels;
+	indio_dev->num_channels = ARRAY_SIZE(admv1013_channels);
+
+	st->spi = spi;
+
+	ret = admv1013_properties_parse(st);
+	if (ret)
+		return ret;
+
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified Common-Mode Voltage!\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&spi->dev, admv1013_reg_disable,
+				       st->reg);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(st->clkin);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, admv1013_clk_disable, st->clkin);
+	if (ret)
+		return ret;
+
+	st->nb.notifier_call = admv1013_freq_change;
+	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
+	if (ret)
+		return ret;
+
+	mutex_init(&st->lock);
+
+	ret = admv1013_init(st);
+	if (ret) {
+		dev_err(&spi->dev, "admv1013 init failed\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&spi->dev, admv1013_powerdown, st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id admv1013_id[] = {
+	{ "admv1013", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, admv1013_id);
+
+static const struct of_device_id admv1013_of_match[] = {
+	{ .compatible = "adi,admv1013" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, admv1013_of_match);
+
+static struct spi_driver admv1013_driver = {
+	.driver = {
+		.name = "admv1013",
+		.of_match_table = admv1013_of_match,
+	},
+	.probe = admv1013_probe,
+	.id_table = admv1013_id,
+};
+module_spi_driver(admv1013_driver);
+
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_DESCRIPTION("Analog Devices ADMV1013");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

