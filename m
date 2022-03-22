Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DAA4E3C98
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiCVKmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiCVKmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:42:36 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EC98118B;
        Tue, 22 Mar 2022 03:41:06 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22M8IdtO009834;
        Tue, 22 Mar 2022 06:41:05 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ewc34vsvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 06:41:04 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 22MAf3mJ036340
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Mar 2022 06:41:03 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 22 Mar 2022 06:41:02 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 22 Mar 2022 06:41:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Mar 2022 06:41:02 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 22MAelCE008328;
        Tue, 22 Mar 2022 06:40:57 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 5/6] iio: adc: ad7124: add sequencer support
Date:   Tue, 22 Mar 2022 12:50:28 +0200
Message-ID: <20220322105029.86389-6-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220322105029.86389-1-alexandru.tachici@analog.com>
References: <20220322105029.86389-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Fe3U2TDOO30SCiOvmykRVIbx4nViH5eV
X-Proofpoint-ORIG-GUID: Fe3U2TDOO30SCiOvmykRVIbx4nViH5eV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_03,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203220062
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add sequencer support for AD7124.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7124.c | 74 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 428ec3e257d7..e900e34e959a 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -43,6 +43,8 @@
 #define AD7124_STATUS_POR_FLAG_MSK	BIT(4)
 
 /* AD7124_ADC_CONTROL */
+#define AD7124_ADC_STATUS_EN_MSK	BIT(10)
+#define AD7124_ADC_STATUS_EN(x)		FIELD_PREP(AD7124_ADC_STATUS_EN_MSK, x)
 #define AD7124_ADC_CTRL_REF_EN_MSK	BIT(8)
 #define AD7124_ADC_CTRL_REF_EN(x)	FIELD_PREP(AD7124_ADC_CTRL_REF_EN_MSK, x)
 #define AD7124_ADC_CTRL_PWR_MSK	GENMASK(7, 6)
@@ -500,26 +502,70 @@ static int ad7124_prepare_read(struct ad7124_state *st, int address)
 	return ad7124_enable_channel(st, &st->channels[address]);
 }
 
+static int __ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
+{
+	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
+
+	return ad7124_prepare_read(st, channel);
+}
+
 static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
 {
 	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
 	int ret;
 
 	mutex_lock(&st->cfgs_lock);
-	ret = ad7124_prepare_read(st, channel);
+	ret = __ad7124_set_channel(sd, channel);
 	mutex_unlock(&st->cfgs_lock);
 
 	return ret;
 }
 
+static int ad7124_append_status(struct ad_sigma_delta *sd, bool append)
+{
+	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
+	unsigned int adc_control = st->adc_control;
+	int ret;
+
+	adc_control &= ~AD7124_ADC_STATUS_EN_MSK;
+	adc_control |= AD7124_ADC_STATUS_EN(append);
+
+	ret = ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, adc_control);
+	if (ret < 0)
+		return ret;
+
+	st->adc_control = adc_control;
+
+	return 0;
+}
+
+static int ad7124_disable_all(struct ad_sigma_delta *sd)
+{
+	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
+	int ret;
+	int i;
+
+	for (i = 0; i < st->num_channels; i++) {
+		ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i), AD7124_CHANNEL_EN_MSK, 0, 2);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
 	.set_channel = ad7124_set_channel,
+	.append_status = ad7124_append_status,
+	.disable_all = ad7124_disable_all,
 	.set_mode = ad7124_set_mode,
 	.has_registers = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
+	.status_ch_mask = GENMASK(3, 0),
 	.data_reg = AD7124_DATA,
-	.irq_flags = IRQF_TRIGGER_FALLING
+	.num_slots = 8,
+	.irq_flags = IRQF_TRIGGER_FALLING,
 };
 
 static int ad7124_read_raw(struct iio_dev *indio_dev,
@@ -677,15 +723,23 @@ static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
 	int ret;
 	int i;
 
+	mutex_lock(&st->cfgs_lock);
 	for (i = 0; i < st->num_channels; i++) {
 		bit_set = test_bit(i, scan_mask);
-		ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i),
-					    AD7124_CHANNEL_EN_MSK,
-					    AD7124_CHANNEL_EN(bit_set),
-					    2);
-		if (ret < 0)
+		if (bit_set)
+			ret = __ad7124_set_channel(&st->sd, i);
+		else
+			ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i), AD7124_CHANNEL_EN_MSK,
+						    0, 2);
+		if (ret < 0) {
+			mutex_unlock(&st->cfgs_lock);
+
 			return ret;
+		}
 	}
+
+	mutex_unlock(&st->cfgs_lock);
+
 	return 0;
 }
 
@@ -906,12 +960,14 @@ static int ad7124_probe(struct spi_device *spi)
 
 	st->chip_info = info;
 
-	ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
-
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7124_info;
 
+	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
+	if (ret < 0)
+		return ret;
+
 	ret = ad7124_of_parse_channel_config(indio_dev, spi->dev.of_node);
 	if (ret < 0)
 		return ret;
-- 
2.25.1

