Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925E74E3C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiCVKmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiCVKmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:42:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB4481192;
        Tue, 22 Mar 2022 03:41:08 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22M8iiFL009909;
        Tue, 22 Mar 2022 06:41:01 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ew9165jef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 06:41:01 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 22MAf0Yi036334
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Mar 2022 06:41:00 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 22 Mar 2022 06:40:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 22 Mar 2022 06:40:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Mar 2022 06:40:59 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 22MAelCC008328;
        Tue, 22 Mar 2022 06:40:55 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 3/6] iio: adc: ad7192: Add update_scan_mode
Date:   Tue, 22 Mar 2022 12:50:26 +0200
Message-ID: <20220322105029.86389-4-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220322105029.86389-1-alexandru.tachici@analog.com>
References: <20220322105029.86389-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: UL_2Q6skDZyRoMZitoPPtM6eNX8V4Cow
X-Proofpoint-ORIG-GUID: UL_2Q6skDZyRoMZitoPPtM6eNX8V4Cow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_03,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220062
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

The callback .set_channel cannot be used to enable multiple
channels at once, only one is allowed simultaneously.

By adding an update_scan_mode callback, every time the
continuous mode is activated, channels will be enabled/disabled
accordingly.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7192.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 770b4e59238f..4c004af4749f 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -783,6 +783,26 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad7192_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+	u32 conf = st->conf;
+	int ret;
+	int i;
+
+	conf &= ~AD7192_CONF_CHAN_MASK;
+	for_each_set_bit(i, scan_mask, 8)
+		conf |= AD7192_CONF_CHAN(i);
+
+	ret = ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, conf);
+	if (ret < 0)
+		return ret;
+
+	st->conf = conf;
+
+	return 0;
+}
+
 static const struct iio_info ad7192_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
@@ -790,6 +810,7 @@ static const struct iio_info ad7192_info = {
 	.read_avail = ad7192_read_avail,
 	.attrs = &ad7192_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
 };
 
 static const struct iio_info ad7195_info = {
@@ -799,6 +820,7 @@ static const struct iio_info ad7195_info = {
 	.read_avail = ad7192_read_avail,
 	.attrs = &ad7195_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
 };
 
 #define __AD719x_CHANNEL(_si, _channel1, _channel2, _address, _extend_name, \
-- 
2.25.1

