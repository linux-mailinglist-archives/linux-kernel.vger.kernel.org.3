Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65424E3CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiCVKmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiCVKmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:42:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F718118D;
        Tue, 22 Mar 2022 03:41:07 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22M9gi81009968;
        Tue, 22 Mar 2022 06:41:00 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ewc34vsva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 06:40:59 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 22MAewVe036330
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Mar 2022 06:40:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 22 Mar
 2022 06:40:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Mar 2022 06:40:57 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 22MAelCB008328;
        Tue, 22 Mar 2022 06:40:54 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 2/6] iio: adc: ad7124: Add update_scan_mode
Date:   Tue, 22 Mar 2022 12:50:25 +0200
Message-ID: <20220322105029.86389-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220322105029.86389-1-alexandru.tachici@analog.com>
References: <20220322105029.86389-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ntblY5BkN_GRPZcTbJzpdpeyXQxnOq6c
X-Proofpoint-ORIG-GUID: ntblY5BkN_GRPZcTbJzpdpeyXQxnOq6c
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

The callback .set_channel cannot be used to enable and
disable multiple channels at once as they are presented
in the active_scan_mask.

By adding an update_scan_mode callback, every time the
continuous mode is activated, channels will be
enabled/disabled accordingly.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7124.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 7249db2c4422..428ec3e257d7 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -669,11 +669,32 @@ static const struct attribute_group ad7124_attrs_group = {
 	.attrs = ad7124_attributes,
 };
 
+static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+	bool bit_set;
+	int ret;
+	int i;
+
+	for (i = 0; i < st->num_channels; i++) {
+		bit_set = test_bit(i, scan_mask);
+		ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i),
+					    AD7124_CHANNEL_EN_MSK,
+					    AD7124_CHANNEL_EN(bit_set),
+					    2);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
 static const struct iio_info ad7124_info = {
 	.read_raw = ad7124_read_raw,
 	.write_raw = ad7124_write_raw,
 	.debugfs_reg_access = &ad7124_reg_access,
 	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7124_update_scan_mode,
 	.attrs = &ad7124_attrs_group,
 };
 
-- 
2.25.1

