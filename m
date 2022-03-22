Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD13F4E3CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiCVKmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiCVKmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:42:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773181196;
        Tue, 22 Mar 2022 03:41:08 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22M9gi83009968;
        Tue, 22 Mar 2022 06:41:06 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ewc34vsvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 06:41:06 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 22MAf5XS031550
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Mar 2022 06:41:05 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 22 Mar 2022 06:41:04 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 22 Mar 2022 06:41:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Mar 2022 06:41:04 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 22MAelCF008328;
        Tue, 22 Mar 2022 06:40:58 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 6/6] iio: adc: ad7192: add sequencer support
Date:   Tue, 22 Mar 2022 12:50:29 +0200
Message-ID: <20220322105029.86389-7-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220322105029.86389-1-alexandru.tachici@analog.com>
References: <20220322105029.86389-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 3OYt1sdGeXDmq8zafdqaed3aptLYxB4R
X-Proofpoint-ORIG-GUID: 3OYt1sdGeXDmq8zafdqaed3aptLYxB4R
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

Add sequencer support for AD7192.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7192.c | 42 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 4c004af4749f..ba3c82f33d74 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -58,7 +58,8 @@
 /* Mode Register Bit Designations (AD7192_REG_MODE) */
 #define AD7192_MODE_SEL(x)	(((x) & 0x7) << 21) /* Operation Mode Select */
 #define AD7192_MODE_SEL_MASK	(0x7 << 21) /* Operation Mode Select Mask */
-#define AD7192_MODE_DAT_STA	BIT(20) /* Status Register transmission */
+#define AD7192_MODE_STA(x)	(((x) & 0x1) << 20) /* Status Register transmission */
+#define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
 #define AD7192_MODE_CLKSRC(x)	(((x) & 0x3) << 18) /* Clock Source Select */
 #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
 #define AD7192_MODE_ACX		BIT(14) /* AC excitation enable(AD7195 only)*/
@@ -288,12 +289,51 @@ static int ad7192_set_mode(struct ad_sigma_delta *sd,
 	return ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
 }
 
+static int ad7192_append_status(struct ad_sigma_delta *sd, bool append)
+{
+	struct ad7192_state *st = ad_sigma_delta_to_ad7192(sd);
+	unsigned int mode = st->mode;
+	int ret;
+
+	mode &= ~AD7192_MODE_STA_MASK;
+	mode |= AD7192_MODE_STA(append);
+
+	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, mode);
+	if (ret < 0)
+		return ret;
+
+	st->mode = mode;
+
+	return 0;
+}
+
+static int ad7192_disable_all(struct ad_sigma_delta *sd)
+{
+	struct ad7192_state *st = ad_sigma_delta_to_ad7192(sd);
+	u32 conf = st->conf;
+	int ret;
+
+	conf &= ~AD7192_CONF_CHAN_MASK;
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
 static const struct ad_sigma_delta_info ad7192_sigma_delta_info = {
 	.set_channel = ad7192_set_channel,
+	.append_status = ad7192_append_status,
+	.disable_all = ad7192_disable_all,
 	.set_mode = ad7192_set_mode,
 	.has_registers = true,
 	.addr_shift = 3,
 	.read_mask = BIT(6),
+	.status_ch_mask = GENMASK(3, 0),
+	.num_slots = 4,
 	.irq_flags = IRQF_TRIGGER_FALLING,
 };
 
-- 
2.25.1

