Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EA046C00D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhLGP6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:58:55 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7040 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239203AbhLGP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:58:46 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B79SA7f016106;
        Tue, 7 Dec 2021 10:55:07 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ct50s1fd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 10:55:06 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1B7Ft5gs042485
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 10:55:05 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Dec 2021
 10:55:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Dec 2021 10:55:04 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1B7Ft0E5009082;
        Tue, 7 Dec 2021 10:55:02 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 2/4] iio:filter:admv8818: add support for ADMV8818
Date:   Tue, 7 Dec 2021 17:54:43 +0200
Message-ID: <20211207155445.247444-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207155445.247444-1-antoniu.miclaus@analog.com>
References: <20211207155445.247444-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ZdK0cxVhEo1yinCueoMWyjJeL3T0YaaO
X-Proofpoint-ORIG-GUID: ZdK0cxVhEo1yinCueoMWyjJeL3T0YaaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADMV8818-EP is a fully monolithic microwave integrated
circuit (MMIC) that features a digitally selectable frequency of
operation. The device features four independently controlled high-
pass filters (HPFs) and four independently controlled low-pass
filters (LPFs) that span the 2 GHz to 18 GHz frequency range.

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/admv8818-ep.pdf
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/filter/Kconfig    |  10 +
 drivers/iio/filter/Makefile   |   1 +
 drivers/iio/filter/admv8818.c | 668 ++++++++++++++++++++++++++++++++++
 3 files changed, 679 insertions(+)
 create mode 100644 drivers/iio/filter/admv8818.c

diff --git a/drivers/iio/filter/Kconfig b/drivers/iio/filter/Kconfig
index e268bba43852..3ae35817ad82 100644
--- a/drivers/iio/filter/Kconfig
+++ b/drivers/iio/filter/Kconfig
@@ -5,4 +5,14 @@
 
 menu "Filters"
 
+config ADMV8818
+	tristate "Analog Devices ADMV8818 High-Pass and Low-Pass Filter"
+	depends on SPI && COMMON_CLK && 64BIT
+	help
+	  Say yes here to build support for Analog Devices ADMV8818
+	  2 GHz to 18 GHz, Digitally Tunable, High-Pass and Low-Pass Filter.
+
+	  To compile this driver as a module, choose M here: the
+	  modiule will be called admv8818.
+
 endmenu
diff --git a/drivers/iio/filter/Makefile b/drivers/iio/filter/Makefile
index cc0892c01142..55e228c0dd20 100644
--- a/drivers/iio/filter/Makefile
+++ b/drivers/iio/filter/Makefile
@@ -4,3 +4,4 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_ADMV8818) += admv8818.o
diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
new file mode 100644
index 000000000000..52eaeed0209d
--- /dev/null
+++ b/drivers/iio/filter/admv8818.c
@@ -0,0 +1,668 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADMV8818 driver
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
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/sysfs.h>
+#include <linux/units.h>
+
+/* ADMV8818 Register Map */
+#define ADMV8818_REG_SPI_CONFIG_A		0x0
+#define ADMV8818_REG_SPI_CONFIG_B		0x1
+#define ADMV8818_REG_CHIPTYPE			0x3
+#define ADMV8818_REG_PRODUCT_ID_L		0x4
+#define ADMV8818_REG_PRODUCT_ID_H		0x5
+#define ADMV8818_REG_FAST_LATCH_POINTER		0x10
+#define ADMV8818_REG_FAST_LATCH_STOP		0x11
+#define ADMV8818_REG_FAST_LATCH_START		0x12
+#define ADMV8818_REG_FAST_LATCH_DIRECTION	0x13
+#define ADMV8818_REG_FAST_LATCH_STATE		0x14
+#define ADMV8818_REG_WR0_SW			0x20
+#define ADMV8818_REG_WR0_FILTER			0x21
+#define ADMV8818_REG_WR1_SW			0x22
+#define ADMV8818_REG_WR1_FILTER			0x23
+#define ADMV8818_REG_WR2_SW			0x24
+#define ADMV8818_REG_WR2_FILTER			0x25
+#define ADMV8818_REG_WR3_SW			0x26
+#define ADMV8818_REG_WR3_FILTER			0x27
+#define ADMV8818_REG_WR4_SW			0x28
+#define ADMV8818_REG_WR4_FILTER			0x29
+#define ADMV8818_REG_LUT0_SW			0x100
+#define ADMV8818_REG_LUT0_FILTER		0x101
+#define ADMV8818_REG_LUT127_SW			0x1FE
+#define ADMV8818_REG_LUT127_FILTER		0x1FF
+
+/* ADMV8818_REG_SPI_CONFIG_A Map */
+#define ADMV8818_SOFTRESET_N_MSK		BIT(7)
+#define ADMV8818_LSB_FIRST_N_MSK		BIT(6)
+#define ADMV8818_ENDIAN_N_MSK			BIT(5)
+#define ADMV8818_SDOACTIVE_N_MSK		BIT(4)
+#define ADMV8818_SDOACTIVE_MSK			BIT(3)
+#define ADMV8818_ENDIAN_MSK			BIT(2)
+#define ADMV8818_LSBFIRST_MSK			BIT(1)
+#define ADMV8818_SOFTRESET_MSK			BIT(0)
+
+/* ADMV8818_REG_SPI_CONFIG_B Map */
+#define ADMV8818_SINGLE_INSTRUCTION_MSK		BIT(7)
+#define ADMV8818_CSB_STALL_MSK			BIT(6)
+#define ADMV8818_MASTER_SLAVE_RB_MSK		BIT(5)
+#define ADMV8818_MASTER_SLAVE_TRANSFER_MSK	BIT(0)
+
+/* ADMV8818_REG_WR0_SW Map */
+#define ADMV8818_SW_IN_SET_WR0_MSK		BIT(7)
+#define ADMV8818_SW_OUT_SET_WR0_MSK		BIT(6)
+#define ADMV8818_SW_IN_WR0_MSK			GENMASK(5, 3)
+#define ADMV8818_SW_OUT_WR0_MSK			GENMASK(2, 0)
+
+/* ADMV8818_REG_WR0_FILTER Map */
+#define ADMV8818_HPF_WR0_MSK			GENMASK(7, 4)
+#define ADMV8818_LPF_WR0_MSK			GENMASK(3, 0)
+
+enum {
+	ADMV8818_BW_FREQ,
+	ADMV8818_CENTER_FREQ
+};
+
+enum {
+	ADMV8818_AUTO_MODE,
+	ADMV8818_MANUAL_MODE,
+};
+
+struct admv8818_state {
+	struct spi_device	*spi;
+	struct regmap		*regmap;
+	struct clk		*clkin;
+	struct notifier_block	nb;
+	/* Protect against concurrent accesses to the device and data content*/
+	struct mutex		lock;
+	unsigned int		filter_mode;
+	u64			cf_hz;
+};
+
+static const unsigned long long freq_range_hpf[4][2] = {
+	{1750000000ULL, 3550000000ULL},
+	{3400000000ULL, 7250000000ULL},
+	{6600000000, 12000000000},
+	{12500000000, 19900000000}
+};
+
+static const unsigned long long freq_range_lpf[4][2] = {
+	{2050000000ULL, 3850000000ULL},
+	{3350000000ULL, 7250000000ULL},
+	{7000000000, 13000000000},
+	{12550000000, 18500000000}
+};
+
+static const struct regmap_config admv8818_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.read_flag_mask = 0x80,
+	.max_register = 0x1FF,
+};
+
+static const char * const admv8818_modes[] = {
+	[0] = "auto",
+	[1] = "manual"
+};
+
+static int __admv8818_hpf_select(struct admv8818_state *st, u64 freq)
+{
+	unsigned int hpf_step = 0, hpf_band = 0, i, j;
+	u64 freq_step;
+	int ret;
+
+	if (freq < freq_range_hpf[0][0])
+		goto hpf_write;
+
+	if (freq > freq_range_hpf[3][1]) {
+		hpf_step = 15;
+		hpf_band = 4;
+
+		goto hpf_write;
+	}
+
+	for (i = 0; i < 4; i++) {
+		freq_step = div_u64((freq_range_hpf[i][1] -
+			freq_range_hpf[i][0]), 15);
+
+		if (freq > freq_range_hpf[i][0] &&
+		    (freq < freq_range_hpf[i][1] + freq_step)) {
+			hpf_band = i + 1;
+
+			for (j = 1; j <= 16; j++) {
+				if (freq < (freq_range_hpf[i][0] + (freq_step * j))) {
+					hpf_step = j - 1;
+					break;
+				}
+			}
+			break;
+		}
+	}
+
+	/* Close HPF frequency gap between 12 and 12.5 GHz */
+	if (freq >= 12000 * HZ_PER_MHZ && freq <= 12500 * HZ_PER_MHZ) {
+		hpf_band = 3;
+		hpf_step = 15;
+	}
+
+hpf_write:
+	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_SW,
+				 ADMV8818_SW_IN_SET_WR0_MSK |
+				 ADMV8818_SW_IN_WR0_MSK,
+				 FIELD_PREP(ADMV8818_SW_IN_SET_WR0_MSK, 1) |
+				 FIELD_PREP(ADMV8818_SW_IN_WR0_MSK, hpf_band));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
+				  ADMV8818_HPF_WR0_MSK,
+				  FIELD_PREP(ADMV8818_HPF_WR0_MSK, hpf_step));
+}
+
+static int admv8818_hpf_select(struct admv8818_state *st, u64 freq)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = __admv8818_hpf_select(st, freq);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
+{
+	unsigned int lpf_step = 0, lpf_band = 0, i, j;
+	u64 freq_step;
+	int ret;
+
+	if (freq > freq_range_lpf[3][1])
+		goto lpf_write;
+
+	if (freq < freq_range_lpf[0][0]) {
+		lpf_band = 1;
+
+		goto lpf_write;
+	}
+
+	for (i = 0; i < 4; i++) {
+		if (freq > freq_range_lpf[i][0] && freq < freq_range_lpf[i][1]) {
+			lpf_band = i + 1;
+			freq_step = div_u64((freq_range_lpf[i][1] - freq_range_lpf[i][0]), 15);
+
+			for (j = 0; j <= 15; j++) {
+				if (freq < (freq_range_lpf[i][0] + (freq_step * j))) {
+					lpf_step = j;
+					break;
+				}
+			}
+			break;
+		}
+	}
+
+lpf_write:
+	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_SW,
+				 ADMV8818_SW_OUT_SET_WR0_MSK |
+				 ADMV8818_SW_OUT_WR0_MSK,
+				 FIELD_PREP(ADMV8818_SW_OUT_SET_WR0_MSK, 1) |
+				 FIELD_PREP(ADMV8818_SW_OUT_WR0_MSK, lpf_band));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
+				  ADMV8818_LPF_WR0_MSK,
+				  FIELD_PREP(ADMV8818_LPF_WR0_MSK, lpf_step));
+}
+
+static int admv8818_lpf_select(struct admv8818_state *st, u64 freq)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = __admv8818_lpf_select(st, freq);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int admv8818_rfin_band_select(struct admv8818_state *st)
+{
+	int ret;
+
+	st->cf_hz = clk_get_rate(st->clkin);
+
+	mutex_lock(&st->lock);
+
+	ret = __admv8818_hpf_select(st, st->cf_hz);
+	if (ret)
+		goto exit;
+
+	ret = __admv8818_lpf_select(st, st->cf_hz);
+exit:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int __admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
+{
+	unsigned int data, hpf_band, hpf_state;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADMV8818_REG_WR0_SW, &data);
+	if (ret)
+		return ret;
+
+	hpf_band = FIELD_GET(ADMV8818_SW_IN_WR0_MSK, data);
+	if (!hpf_band) {
+		*hpf_freq = 0;
+		return ret;
+	}
+
+	ret = regmap_read(st->regmap, ADMV8818_REG_WR0_FILTER, &data);
+	if (ret)
+		return ret;
+
+	hpf_state = FIELD_GET(ADMV8818_HPF_WR0_MSK, data);
+
+	*hpf_freq = div_u64(freq_range_hpf[hpf_band - 1][1] - freq_range_hpf[hpf_band - 1][0], 15);
+	*hpf_freq = freq_range_hpf[hpf_band - 1][0] + (*hpf_freq * hpf_state);
+
+	return ret;
+}
+
+static int admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = __admv8818_read_hpf_freq(st, hpf_freq);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int __admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
+{
+	unsigned int data, lpf_band, lpf_state;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADMV8818_REG_WR0_SW, &data);
+	if (ret)
+		return ret;
+
+	lpf_band = FIELD_GET(ADMV8818_SW_OUT_WR0_MSK, data);
+	if (!lpf_band) {
+		*lpf_freq = 0;
+		return ret;
+	}
+
+	ret = regmap_read(st->regmap, ADMV8818_REG_WR0_FILTER, &data);
+	if (ret)
+		return ret;
+
+	lpf_state = FIELD_GET(ADMV8818_LPF_WR0_MSK, data);
+
+	*lpf_freq = div_u64(freq_range_lpf[lpf_band - 1][1] - freq_range_lpf[lpf_band - 1][0], 15);
+	*lpf_freq = freq_range_lpf[lpf_band - 1][0] + (*lpf_freq * lpf_state);
+
+	return ret;
+}
+
+static int admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = __admv8818_read_lpf_freq(st, lpf_freq);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int admv8818_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long info)
+{
+	struct admv8818_state *st = iio_priv(indio_dev);
+
+	u64 freq = ((u64)val2 << 32 | (u32)val);
+
+	switch (info) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return admv8818_lpf_select(st, freq);
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		return admv8818_hpf_select(st, freq);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int admv8818_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long info)
+{
+	struct admv8818_state *st = iio_priv(indio_dev);
+	int ret;
+	u64 freq;
+
+	switch (info) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = admv8818_read_lpf_freq(st, &freq);
+		if (ret)
+			return ret;
+
+		*val = (u32)freq;
+		*val2 = (u32)(freq >> 32);
+
+		return IIO_VAL_INT_64;
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		ret = admv8818_read_hpf_freq(st, &freq);
+		if (ret)
+			return ret;
+
+		*val = (u32)freq;
+		*val2 = (u32)(freq >> 32);
+
+		return IIO_VAL_INT_64;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int admv8818_reg_access(struct iio_dev *indio_dev,
+			       unsigned int reg,
+			       unsigned int write_val,
+			       unsigned int *read_val)
+{
+	struct admv8818_state *st = iio_priv(indio_dev);
+
+	if (read_val)
+		return regmap_read(st->regmap, reg, read_val);
+	else
+		return regmap_write(st->regmap, reg, write_val);
+}
+
+static int admv8818_get_mode(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan)
+{
+	struct admv8818_state *st = iio_priv(indio_dev);
+
+	return st->filter_mode;
+}
+
+static int admv8818_set_mode(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan,
+			     unsigned int mode)
+{
+	struct admv8818_state *st = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (!st->clkin) {
+		if (mode == ADMV8818_MANUAL_MODE)
+			return 0;
+
+		return -EINVAL;
+	}
+
+	switch (mode) {
+	case ADMV8818_AUTO_MODE:
+		if (!st->filter_mode)
+			return 0;
+
+		ret = clk_prepare_enable(st->clkin);
+		if (ret)
+			return ret;
+
+		ret = clk_notifier_register(st->clkin, &st->nb);
+		if (ret) {
+			clk_disable_unprepare(st->clkin);
+
+			return ret;
+		}
+
+		break;
+	case ADMV8818_MANUAL_MODE:
+		if (st->filter_mode)
+			return 0;
+
+		clk_disable_unprepare(st->clkin);
+
+		ret = clk_notifier_unregister(st->clkin, &st->nb);
+		if (ret)
+			return ret;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	st->filter_mode = mode;
+
+	return ret;
+}
+
+static const struct iio_info admv8818_info = {
+	.write_raw = admv8818_write_raw,
+	.read_raw = admv8818_read_raw,
+	.debugfs_reg_access = &admv8818_reg_access,
+};
+
+static const struct iio_enum admv8818_mode_enum = {
+	.items = admv8818_modes,
+	.num_items = ARRAY_SIZE(admv8818_modes),
+	.get = admv8818_get_mode,
+	.set = admv8818_set_mode,
+};
+
+static const struct iio_chan_spec_ext_info admv8818_ext_info[] = {
+	IIO_ENUM("filter_mode", IIO_SHARED_BY_ALL, &admv8818_mode_enum),
+	IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_ALL, &admv8818_mode_enum),
+	{ },
+};
+
+#define ADMV8818_CHAN(_channel) {				\
+	.type = IIO_ALTVOLTAGE,					\
+	.output = 1,						\
+	.indexed = 1,						\
+	.channel = _channel,					\
+	.info_mask_separate =					\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
+		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY) \
+}
+
+#define ADMV8818_CHAN_BW_CF(_channel, _admv8818_ext_info) {	\
+	.type = IIO_ALTVOLTAGE,					\
+	.output = 1,						\
+	.indexed = 1,						\
+	.channel = _channel,					\
+	.ext_info = _admv8818_ext_info,				\
+}
+
+static const struct iio_chan_spec admv8818_channels[] = {
+	ADMV8818_CHAN(0),
+	ADMV8818_CHAN_BW_CF(0, admv8818_ext_info),
+};
+
+static int admv8818_freq_change(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct admv8818_state *st = container_of(nb, struct admv8818_state, nb);
+
+	if (action == POST_RATE_CHANGE)
+		return notifier_from_errno(admv8818_rfin_band_select(st));
+
+	return NOTIFY_OK;
+}
+
+static void admv8818_clk_notifier_unreg(void *data)
+{
+	struct admv8818_state *st = data;
+
+	if (st->filter_mode == 0)
+		clk_notifier_unregister(st->clkin, &st->nb);
+}
+
+static void admv8818_clk_disable(void *data)
+{
+	struct admv8818_state *st = data;
+
+	if (st->filter_mode == 0)
+		clk_disable_unprepare(st->clkin);
+}
+
+static int admv8818_init(struct admv8818_state *st)
+{
+	int ret;
+	struct spi_device *spi = st->spi;
+	unsigned int chip_id;
+
+	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
+				 ADMV8818_SOFTRESET_N_MSK |
+				 ADMV8818_SOFTRESET_MSK,
+				 FIELD_PREP(ADMV8818_SOFTRESET_N_MSK, 1) |
+				 FIELD_PREP(ADMV8818_SOFTRESET_MSK, 1));
+	if (ret) {
+		dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
+				 ADMV8818_SDOACTIVE_N_MSK |
+				 ADMV8818_SDOACTIVE_MSK,
+				 FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK, 1) |
+				 FIELD_PREP(ADMV8818_SDOACTIVE_MSK, 1));
+	if (ret) {
+		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
+		return ret;
+	}
+
+	ret = regmap_read(st->regmap, ADMV8818_REG_CHIPTYPE, &chip_id);
+	if (ret) {
+		dev_err(&spi->dev, "ADMV8818 Chip ID read failed.\n");
+		return ret;
+	}
+
+	if (chip_id != 0x1) {
+		dev_err(&spi->dev, "ADMV8818 Invalid Chip ID.\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_B,
+				 ADMV8818_SINGLE_INSTRUCTION_MSK,
+				 FIELD_PREP(ADMV8818_SINGLE_INSTRUCTION_MSK, 1));
+	if (ret) {
+		dev_err(&spi->dev, "ADMV8818 Single Instruction failed.\n");
+		return ret;
+	}
+
+	if (st->clkin)
+		return admv8818_rfin_band_select(st);
+	else
+		return 0;
+}
+
+static int admv8818_clk_setup(struct admv8818_state *st)
+{
+	struct spi_device *spi = st->spi;
+	int ret;
+
+	st->clkin = devm_clk_get_optional(&spi->dev, "rf_in");
+	if (IS_ERR(st->clkin))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+				     "failed to get the input clock\n");
+	else if (!st->clkin)
+		return 0;
+
+	ret = clk_prepare_enable(st->clkin);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, admv8818_clk_disable, st);
+	if (ret)
+		return ret;
+
+	st->nb.notifier_call = admv8818_freq_change;
+	ret = clk_notifier_register(st->clkin, &st->nb);
+	if (ret < 0)
+		return ret;
+
+	return devm_add_action_or_reset(&spi->dev, admv8818_clk_notifier_unreg, st);
+}
+
+static int admv8818_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	struct admv8818_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_spi(spi, &admv8818_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	st = iio_priv(indio_dev);
+	st->regmap = regmap;
+
+	indio_dev->info = &admv8818_info;
+	indio_dev->name = "admv8818";
+	indio_dev->channels = admv8818_channels;
+	indio_dev->num_channels = ARRAY_SIZE(admv8818_channels);
+
+	st->spi = spi;
+
+	ret = admv8818_clk_setup(st);
+	if (ret)
+		return ret;
+
+	mutex_init(&st->lock);
+
+	ret = admv8818_init(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id admv8818_id[] = {
+	{ "admv8818", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, admv8818_id);
+
+static const struct of_device_id admv8818_of_match[] = {
+	{ .compatible = "adi,admv8818" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, admv8818_of_match);
+
+static struct spi_driver admv8818_driver = {
+	.driver = {
+		.name = "admv8818",
+		.of_match_table = admv8818_of_match,
+	},
+	.probe = admv8818_probe,
+	.id_table = admv8818_id,
+};
+module_spi_driver(admv8818_driver);
+
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_DESCRIPTION("Analog Devices ADMV8818");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

