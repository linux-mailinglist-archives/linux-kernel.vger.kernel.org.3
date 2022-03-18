Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5684DDE92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbiCRQVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbiCRQTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:19:51 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE9A16F06A;
        Fri, 18 Mar 2022 09:18:03 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22IE1IR1013812;
        Fri, 18 Mar 2022 12:17:50 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3evfqqmx5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 12:17:49 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 22IGHmiF009332
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Mar 2022 12:17:48 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 18 Mar
 2022 12:17:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 18 Mar 2022 12:17:47 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 22IGHWUj024583;
        Fri, 18 Mar 2022 12:17:41 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 4/8] iio: adc: ad_sigma_delta: Add sequencer support
Date:   Fri, 18 Mar 2022 18:27:18 +0200
Message-ID: <20220318162722.51215-5-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220318162722.51215-1-alexandru.tachici@analog.com>
References: <20220318162722.51215-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 3tK2mfU2pzOv8geleyCMPjU2JrEZieEP
X-Proofpoint-ORIG-GUID: 3tK2mfU2pzOv8geleyCMPjU2JrEZieEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_11,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180088
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Some sigma-delta chips support sampling of multiple
channels in continuous mode.

When the operating with more than one channel enabled,
the channel sequencer cycles through the enabled channels
in sequential order, from first channel to the last one.
If a channel is disabled, it is skipped by the sequencer.

If more than one channel is used in continuous mode,
instruct the device to append the status to the SPI transfer
(1 extra byte) every time we receive a sample.
All sigma-delta chips possessing a sampling sequencer have
this ability. Inside the status register there will be
the number of the converted channel. In this way, even
if the CPU won't keep up with the sampling rate, it won't
send to userspace wrong channel samples.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 134 +++++++++++++++++++++++--
 include/linux/iio/adc/ad_sigma_delta.h |  33 ++++++
 2 files changed, 157 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index ebcd52526cac..5d1932ad2a22 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -342,15 +342,47 @@ EXPORT_SYMBOL_NS_GPL(ad_sigma_delta_single_conversion, IIO_AD_SIGMA_DELTA);
 static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+	unsigned int i, slot, samples_buf_size;
 	unsigned int channel;
+	uint8_t *samples_buf;
 	int ret;
 
-	channel = find_first_bit(indio_dev->active_scan_mask,
-				 indio_dev->masklength);
-	ret = ad_sigma_delta_set_channel(sigma_delta,
-		indio_dev->channels[channel].address);
-	if (ret)
-		return ret;
+	if (sigma_delta->num_slots == 1) {
+		channel = find_first_bit(indio_dev->active_scan_mask,
+					 indio_dev->masklength);
+		ret = ad_sigma_delta_set_channel(sigma_delta,
+						 indio_dev->channels[channel].address);
+		if (ret)
+			return ret;
+		slot = 1;
+	} else {
+		/*
+		 * At this point update_scan_mode already enabled the required channels.
+		 * For sigma-delta sequencer drivers with multiple slots, an update_scan_mode
+		 * implementation is mandatory.
+		 */
+		slot = 0;
+		for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
+			sigma_delta->slots[slot] = indio_dev->channels[i].address;
+			slot++;
+		}
+	}
+
+	sigma_delta->active_slots = slot;
+	sigma_delta->current_slot = 0;
+
+	if (sigma_delta->active_slots > 1) {
+		ret = ad_sigma_delta_append_status(sigma_delta, true);
+		if (ret)
+			return ret;
+	}
+
+	samples_buf_size = slot * indio_dev->channels[0].scan_type.storagebits + sizeof(int64_t);
+	samples_buf = krealloc(sigma_delta->samples_buf, samples_buf_size, GFP_KERNEL);
+	if (!samples_buf)
+		return -ENOMEM;
+
+	sigma_delta->samples_buf = samples_buf;
 
 	spi_bus_lock(sigma_delta->spi->master);
 	sigma_delta->bus_locked = true;
@@ -386,6 +418,10 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
 
+	if (sigma_delta->status_appended)
+		ad_sigma_delta_append_status(sigma_delta, false);
+
+	ad_sigma_delta_disable_all(sigma_delta);
 	sigma_delta->bus_locked = false;
 	return spi_bus_unlock(sigma_delta->spi->master);
 }
@@ -396,6 +432,10 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	uint8_t *data = sigma_delta->rx_buf;
+	unsigned int transfer_size;
+	unsigned int sample_size;
+	unsigned int sample_pos;
+	unsigned int status_pos;
 	unsigned int reg_size;
 	unsigned int data_reg;
 
@@ -408,21 +448,63 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	else
 		data_reg = AD_SD_REG_DATA;
 
+	/* Status word will be appended to the sample during transfer */
+	if (sigma_delta->status_appended)
+		transfer_size = reg_size + 1;
+	else
+		transfer_size = reg_size;
+
 	switch (reg_size) {
 	case 4:
 	case 2:
 	case 1:
-		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[0]);
+		status_pos = reg_size;
+		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[0]);
 		break;
 	case 3:
+		status_pos = reg_size + 1;
 		/* We store 24 bit samples in a 32 bit word. Keep the upper
 		 * byte set to zero. */
-		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[1]);
+		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
 		break;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
+	/*
+	 * For devices sampling only one channel at
+	 * once, there is no need for sample number tracking.
+	 */
+	if (sigma_delta->active_slots == 1) {
+		iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
+		goto irq_handled;
+	}
+
+	if (sigma_delta->status_appended) {
+		u8 converted_channel;
 
+		converted_channel = data[status_pos] & sigma_delta->info->status_ch_mask;
+		if (converted_channel != sigma_delta->slots[sigma_delta->current_slot]) {
+			/*
+			 * Desync occurred during continuous sampling of multiple channels.
+			 * Drop this incomplete sample and start from first channel again.
+			 */
+
+			sigma_delta->current_slot = 0;
+			goto irq_handled;
+		}
+	}
+
+	sample_size = indio_dev->channels[0].scan_type.storagebits / 8;
+	sample_pos = sample_size * sigma_delta->current_slot;
+	memcpy(&sigma_delta->samples_buf[sample_pos], data, sample_size);
+	sigma_delta->current_slot++;
+
+	if (sigma_delta->current_slot == sigma_delta->active_slots) {
+		sigma_delta->current_slot = 0;
+		iio_push_to_buffers_with_timestamp(indio_dev, sigma_delta->samples_buf,
+						   pf->timestamp);
+	}
+
+irq_handled:
 	iio_trigger_notify_done(indio_dev->trig);
 	sigma_delta->irq_dis = false;
 	enable_irq(sigma_delta->spi->irq);
@@ -430,10 +512,17 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static bool ad_sd_validate_scan_mask(struct iio_dev *indio_dev, const unsigned long *mask)
+{
+	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+
+	return bitmap_weight(mask, indio_dev->masklength) <= sigma_delta->num_slots;
+}
+
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
 	.postenable = &ad_sd_buffer_postenable,
 	.postdisable = &ad_sd_buffer_postdisable,
-	.validate_scan_mask = &iio_validate_scan_mask_onehot,
+	.validate_scan_mask = &ad_sd_validate_scan_mask,
 };
 
 static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
@@ -513,8 +602,14 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
  */
 int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
+	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	int ret;
 
+	sigma_delta->slots = devm_kcalloc(dev, sigma_delta->num_slots,
+					  sizeof(*sigma_delta->slots), GFP_KERNEL);
+	if (!sigma_delta->slots)
+		return -ENOMEM;
+
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
 					      &ad_sd_trigger_handler,
@@ -541,6 +636,25 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 {
 	sigma_delta->spi = spi;
 	sigma_delta->info = info;
+
+	/* If the field is unset in ad_sigma_delta_info, asume there can only be 1 slot. */
+	if (!info->num_slots)
+		sigma_delta->num_slots = 1;
+	else
+		sigma_delta->num_slots = info->num_slots;
+
+	if (sigma_delta->num_slots > 1) {
+		if (!indio_dev->info->update_scan_mode) {
+			dev_err(&spi->dev, "iio_dev lacks update_scan_mode().\n");
+			return -EINVAL;
+		}
+
+		if (!info->disable_all) {
+			dev_err(&spi->dev, "ad_sigma_delta_info lacks disable_all().\n");
+			return -EINVAL;
+		}
+	}
+
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
 	return 0;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index c525fd51652f..b921ceb8adfd 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -32,26 +32,34 @@ struct iio_dev;
 /**
  * struct ad_sigma_delta_info - Sigma Delta driver specific callbacks and options
  * @set_channel: Will be called to select the current channel, may be NULL.
+ * @append_status: Will be called to enable status append at the end of the sample, may be NULL.
  * @set_mode: Will be called to select the current mode, may be NULL.
+ * @disable_all: Will be called to disable all channels, may be NULL.
  * @postprocess_sample: Is called for each sampled data word, can be used to
  *		modify or drop the sample data, it, may be NULL.
  * @has_registers: true if the device has writable and readable registers, false
  *		if there is just one read-only sample data shift register.
  * @addr_shift: Shift of the register address in the communications register.
  * @read_mask: Mask for the communications register having the read bit set.
+ * @status_ch_mask: Mask for the channel number stored in status register.
  * @data_reg: Address of the data register, if 0 the default address of 0x3 will
  *   be used.
  * @irq_flags: flags for the interrupt used by the triggered buffer
+ * @num_slots: Number of sequencer slots
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
+	int (*append_status)(struct ad_sigma_delta *, bool append);
+	int (*disable_all)(struct ad_sigma_delta *);
 	int (*set_mode)(struct ad_sigma_delta *, enum ad_sigma_delta_mode mode);
 	int (*postprocess_sample)(struct ad_sigma_delta *, unsigned int raw_sample);
 	bool has_registers;
 	unsigned int addr_shift;
 	unsigned int read_mask;
+	unsigned int status_ch_mask;
 	unsigned int data_reg;
 	unsigned long irq_flags;
+	unsigned int num_slots;
 };
 
 /**
@@ -76,6 +84,13 @@ struct ad_sigma_delta {
 	uint8_t			comm;
 
 	const struct ad_sigma_delta_info *info;
+	unsigned int		active_slots;
+	unsigned int		current_slot;
+	unsigned int		num_slots;
+	bool			status_appended;
+	/* map slots to channels in order to know what to expect from devices */
+	unsigned int		*slots;
+	uint8_t			*samples_buf;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -97,6 +112,24 @@ static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
 	return 0;
 }
 
+static inline int ad_sigma_delta_append_status(struct ad_sigma_delta *sd, bool append)
+{
+	if (sd->info->append_status) {
+		sd->status_appended = append;
+		return sd->info->append_status(sd, append);
+	}
+
+	return 0;
+}
+
+static inline int ad_sigma_delta_disable_all(struct ad_sigma_delta *sd)
+{
+	if (sd->info->disable_all)
+		return sd->info->disable_all(sd);
+
+	return 0;
+}
+
 static inline int ad_sigma_delta_set_mode(struct ad_sigma_delta *sd,
 	unsigned int mode)
 {
-- 
2.25.1

