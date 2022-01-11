Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EED48ACEE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbiAKLrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:47:31 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47422 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238505AbiAKLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:47:30 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20B8B6EA009803;
        Tue, 11 Jan 2022 06:47:28 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dggyquq9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 06:47:28 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20BBlRSR032578
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jan 2022 06:47:27 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 11 Jan
 2022 06:47:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Jan 2022 06:47:26 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20BBlFJr029369;
        Tue, 11 Jan 2022 06:47:21 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v2 2/2] one-bit-adc-dac: Add initial version of one bit ADC-DAC
Date:   Tue, 11 Jan 2022 13:59:19 +0200
Message-ID: <20220111115919.14645-2-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111115919.14645-1-cristian.pop@analog.com>
References: <20220111115919.14645-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: dQLPrU3GIVfF0baYim7KR547hXodBC8_
X-Proofpoint-GUID: dQLPrU3GIVfF0baYim7KR547hXodBC8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows remote reading and writing of the GPIOs. This is useful in
application that run on another PC, at system level, where multiple iio
devices and GPIO devices are integrated together.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 drivers/iio/addac/Kconfig           |   8 +
 drivers/iio/addac/Makefile          |   1 +
 drivers/iio/addac/one-bit-adc-dac.c | 229 ++++++++++++++++++++++++++++
 3 files changed, 238 insertions(+)
 create mode 100644 drivers/iio/addac/one-bit-adc-dac.c

diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
index 138492362f20..5f311f4a747e 100644
--- a/drivers/iio/addac/Kconfig
+++ b/drivers/iio/addac/Kconfig
@@ -17,4 +17,12 @@ config AD74413R
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad74413r.
 
+config ONE_BIT_ADC_DAC
+	tristate "ONE_BIT_ADC_DAC driver"
+	help
+	  Say yes here to build support for ONE_BIT_ADC_DAC driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called one-bit-adc-dac.
+
 endmenu
diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
index cfd4bbe64ad3..0a33f0706b55 100644
--- a/drivers/iio/addac/Makefile
+++ b/drivers/iio/addac/Makefile
@@ -5,3 +5,4 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD74413R) += ad74413r.o
+obj-$(CONFIG_ONE_BIT_ADC_DAC) += one-bit-adc-dac.o
diff --git a/drivers/iio/addac/one-bit-adc-dac.c b/drivers/iio/addac/one-bit-adc-dac.c
new file mode 100644
index 000000000000..5680de594429
--- /dev/null
+++ b/drivers/iio/addac/one-bit-adc-dac.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * one-bit-adc-dac
+ *
+ * Copyright 2022 Analog Devices Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/iio/iio.h>
+#include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
+
+enum ch_direction {
+	CH_IN,
+	CH_OUT,
+};
+
+struct one_bit_adc_dac_state {
+	int			in_num_ch;
+	int			out_num_ch;
+	struct platform_device  *pdev;
+	struct gpio_descs       *in_gpio_descs;
+	struct gpio_descs       *out_gpio_descs;
+	const char		**labels;
+};
+
+static int one_bit_adc_dac_read_raw(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, int *val, int *val2, long info)
+{
+	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
+	struct gpio_descs *descs;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->output)
+			descs = st->out_gpio_descs;
+		else
+			descs = st->in_gpio_descs;
+		*val = gpiod_get_value_cansleep(descs->desc[chan->channel]);
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int one_bit_adc_dac_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long info)
+{
+	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
+	int channel = chan->channel;
+
+	if (!chan->output)
+		return 0;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		gpiod_set_value_cansleep(st->out_gpio_descs->desc[channel], val);
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int one_bit_adc_dac_read_label(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, char *label)
+{
+	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
+	int ch;
+
+	if (chan->output)
+		ch = chan->channel + st->in_num_ch;
+	else
+		ch = chan->channel;
+
+	return sprintf(label, "%s\n", st->labels[ch]);
+}
+
+static const struct iio_info one_bit_adc_dac_info = {
+	.read_raw = &one_bit_adc_dac_read_raw,
+	.write_raw = &one_bit_adc_dac_write_raw,
+	.read_label = &one_bit_adc_dac_read_label,
+};
+
+static int one_bit_adc_dac_set_ch(struct iio_chan_spec *channels,
+					int num_ch,
+					enum ch_direction direction)
+{
+	int i;
+
+	for (i = 0; i < num_ch; i++) {
+		channels[i].type = IIO_VOLTAGE;
+		channels[i].indexed = 1;
+		channels[i].channel = i;
+		channels[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+		channels[i].output = direction;
+	}
+
+	return 0;
+}
+
+static int one_bit_adc_dac_set_channel_label(struct iio_dev *indio_dev,
+						struct iio_chan_spec *channels,
+						int num_channels)
+{
+	struct device *device = indio_dev->dev.parent;
+	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
+	struct fwnode_handle *fwnode;
+	struct fwnode_handle *child;
+	struct iio_chan_spec *chan;
+	const char *label;
+	int crt_ch = 0, child_num, i = 0;
+
+	fwnode = dev_fwnode(device);
+	child_num = device_get_child_node_count(device);
+
+	st->labels = devm_kzalloc(device, sizeof(*st->labels) * child_num, GFP_KERNEL);
+	if (!st->labels)
+		return -ENOMEM;
+
+	i = child_num;
+	fwnode_for_each_child_node(fwnode, child) {
+		if (fwnode_property_read_u32(child, "reg", &crt_ch))
+			continue;
+
+		if (crt_ch >= num_channels)
+			continue;
+
+		if (fwnode_property_read_string(child, "label", &label))
+			continue;
+
+		chan = &channels[crt_ch];
+		st->labels[--i] = label;
+	}
+
+	return 0;
+}
+
+static int one_bit_adc_dac_parse_dt(struct iio_dev *indio_dev)
+{
+	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
+	struct iio_chan_spec *channels;
+	int ret, in_num_ch = 0, out_num_ch = 0;
+
+	st->in_gpio_descs = devm_gpiod_get_array_optional(&st->pdev->dev, "in", GPIOD_IN);
+	if (IS_ERR(st->in_gpio_descs))
+		return PTR_ERR(st->in_gpio_descs);
+
+	if (st->in_gpio_descs)
+		in_num_ch = st->in_gpio_descs->ndescs;
+
+	st->out_gpio_descs = devm_gpiod_get_array_optional(&st->pdev->dev, "out", GPIOD_OUT_LOW);
+	if (IS_ERR(st->out_gpio_descs))
+		return PTR_ERR(st->out_gpio_descs);
+
+	if (st->out_gpio_descs)
+		out_num_ch = st->out_gpio_descs->ndescs;
+	st->in_num_ch = in_num_ch;
+	st->out_num_ch = out_num_ch;
+
+	channels = devm_kcalloc(indio_dev->dev.parent, in_num_ch + out_num_ch,
+				sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	ret = one_bit_adc_dac_set_ch(&channels[0], in_num_ch, CH_IN);
+	if (ret)
+		return ret;
+
+	ret = one_bit_adc_dac_set_ch(&channels[in_num_ch], out_num_ch, CH_OUT);
+	if (ret)
+		return ret;
+
+	ret = one_bit_adc_dac_set_channel_label(indio_dev, channels, in_num_ch + out_num_ch);
+	if (ret)
+		return ret;
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = in_num_ch + out_num_ch;
+
+	return 0;
+}
+
+static int one_bit_adc_dac_probe(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev;
+	struct one_bit_adc_dac_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->pdev = pdev;
+	indio_dev->name = "one-bit-adc-dac";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &one_bit_adc_dac_info;
+
+	ret = one_bit_adc_dac_parse_dt(indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
+}
+
+static const struct of_device_id one_bit_adc_dac_dt_match[] = {
+	{ .compatible = "one-bit-adc-dac" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, one_bit_adc_dac_dt_match);
+
+static struct platform_driver one_bit_adc_dac_driver = {
+	.driver = {
+		.name = "one-bit-adc-dac",
+		.of_match_table = one_bit_adc_dac_dt_match,
+	},
+	.probe = one_bit_adc_dac_probe,
+};
+module_platform_driver(one_bit_adc_dac_driver);
+
+MODULE_AUTHOR("Cristian Pop <cristian.pop@analog.com>");
+MODULE_DESCRIPTION("One bit ADC DAC converter");
+MODULE_LICENSE("Dual BSD/GPL");
\ No newline at end of file
-- 
2.17.1

