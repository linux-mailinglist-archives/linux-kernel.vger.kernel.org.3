Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFB65A6D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiH3TYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiH3TXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:23:37 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6D77B7A6;
        Tue, 30 Aug 2022 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661887379; x=1693423379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o77vQ07d89glwBVV3yt+VAkiTa6XFTavUwgfAhgxg8E=;
  b=NerQXSoR3gsGvgRzhp5psBrMikXSmqYfnF/8umK2IhvKpwA6ZZEcn3Fc
   l2RfZtgjg9PYhOaTElmP0YQQy1ky03sHXKZb+5SbGReSKeq0nQ0Ilin9V
   znPna3N9597ZT2DVj2ymJ/WLRawN7ji/Mmn1PMcQZlX57sr1O0i7wjOUP
   g=;
X-IronPort-AV: E=Sophos;i="5.93,275,1654560000"; 
   d="scan'208";a="222136159"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 19:22:42 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com (Postfix) with ESMTPS id 44220811F5;
        Tue, 30 Aug 2022 19:22:39 +0000 (UTC)
Received: from EX19D013UWA002.ant.amazon.com (10.13.138.210) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 30 Aug 2022 19:22:16 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA002.ant.amazon.com (10.13.138.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 30 Aug 2022 19:22:15 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 30 Aug 2022 19:22:15
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 6C2ED4D4D; Tue, 30 Aug 2022 19:22:12 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dkl@amazon.com>,
        <rahul.tanwar@linux.intel.com>, <andriy.shevchenko@intel.com>
Subject: [PATCH v3 15/19] hwmon: (mr75203) add support for series 6 temperature equation
Date:   Tue, 30 Aug 2022 19:22:08 +0000
Message-ID: <20220830192212.28570-16-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830192212.28570-1-farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current equation used in code is aligned to series 5:
T = G + H * (n / cal5 - 0.5) + J * F
Where:
G = 60, H = 200, cal5 = 4094, J = -0.1, F = frequency clock in MHz

Series 6 has a slightly different equation:
T = G + H * (n / cal5 - 0.5)
and a different set of coefficients:
G = 57.4, H = 249.4, cal5 = 4096

This change supports equation and coefficients for both series.
(for series 6, J is set to 0).

The series is determined according to “ts-series” property in device
tree.
If absent, series 5 is assumed to be the default.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V3 -> V2:
- New patch to support temperature sensor series 6 instead of having to
  set all 4 coefficients.

 drivers/hwmon/mr75203.c | 69 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 5b8ca1ee4a54..6a035fd115ca 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -103,10 +103,6 @@
 
 #define PVT_POLL_DELAY_US	20
 #define PVT_POLL_TIMEOUT_US	20000
-#define PVT_H_CONST		200000
-#define PVT_G_CONST		60000
-#define PVT_J_CONST		-100
-#define PVT_CAL5_CONST		4094
 #define PVT_CONV_BITS		10
 #define PVT_N_CONST		90
 #define PVT_R_CONST		245805
@@ -114,9 +110,31 @@
 #define PVT_TEMP_MIN		-40000
 #define PVT_TEMP_MAX		125000
 
+/* Temperature coefficients for series 5 */
+#define PVT_SERIES5_H_CONST	200000
+#define PVT_SERIES5_G_CONST	60000
+#define PVT_SERIES5_J_CONST	-100
+#define PVT_SERIES5_CAL5_CONST	4094
+
+/* Temperature coefficients for series 6 */
+#define PVT_SERIES6_H_CONST	249400
+#define PVT_SERIES6_G_CONST	57400
+#define PVT_SERIES6_J_CONST	0
+#define PVT_SERIES6_CAL5_CONST	4096
+
+#define TEMPERATURE_SENSOR_SERIES_5	5
+#define TEMPERATURE_SENSOR_SERIES_6	6
+
 #define PRE_SCALER_X1	1
 #define PRE_SCALER_X2	2
 
+struct temp_coeff {
+	u32 h;
+	u32 g;
+	u32 cal5;
+	s32 j;
+};
+
 struct voltage_device {
 	u32 vm_map;	/* Map channel number to VM index */
 	u32 ch_map;	/* Map channel number to channel index */
@@ -137,6 +155,7 @@ struct pvt_device {
 	struct reset_control	*rst;
 	struct voltage_device	*vd;
 	struct voltage_channels	vm_channels;
+	struct temp_coeff	ts_coeff;
 	u32			t_num;
 	u32			p_num;
 	u32			v_num;
@@ -167,8 +186,9 @@ static long pvt_calc_temp(struct pvt_device *pvt, u32 nbs)
 	 * Convert the register value to degrees centigrade temperature:
 	 * T = G + H * (n / cal5 - 0.5) + J * F
 	 */
-	s64 tmp = PVT_G_CONST + PVT_H_CONST * (s64)nbs / PVT_CAL5_CONST -
-		PVT_H_CONST / 2 + PVT_J_CONST * (s64)pvt->ip_freq / HZ_PER_MHZ;
+	struct temp_coeff *ts_coeff = &pvt->ts_coeff;
+	s64 tmp = ts_coeff->g + ts_coeff->h * (s64)nbs / ts_coeff->cal5 -
+		ts_coeff->h / 2 + ts_coeff->j * (s64)pvt->ip_freq / HZ_PER_MHZ;
 
 	return clamp_val(tmp, PVT_TEMP_MIN, PVT_TEMP_MAX);
 }
@@ -652,6 +672,39 @@ static int pvt_get_pre_scaler(struct device *dev, struct pvt_device *pvt)
 	return ret;
 }
 
+static int pvt_set_temp_coeff(struct device *dev, struct pvt_device *pvt)
+{
+	struct temp_coeff *ts_coeff = &pvt->ts_coeff;
+	const struct device_node *np = dev->of_node;
+	u32 series;
+	int ret;
+
+	/* Incase ts-series property is not defined, use default 5. */
+	ret = of_property_read_u32(np, "moortec,ts-series", &series);
+	if (ret)
+		series = TEMPERATURE_SENSOR_SERIES_5;
+
+	if (series == TEMPERATURE_SENSOR_SERIES_5) {
+		ts_coeff->h = PVT_SERIES5_H_CONST;
+		ts_coeff->g = PVT_SERIES5_G_CONST;
+		ts_coeff->j = PVT_SERIES5_J_CONST;
+		ts_coeff->cal5 = PVT_SERIES5_CAL5_CONST;
+	} else if (series == TEMPERATURE_SENSOR_SERIES_6) {
+		ts_coeff->h = PVT_SERIES6_H_CONST;
+		ts_coeff->g = PVT_SERIES6_G_CONST;
+		ts_coeff->j = PVT_SERIES6_J_CONST;
+		ts_coeff->cal5 = PVT_SERIES6_CAL5_CONST;
+	} else {
+		dev_err(dev, "invalid temperature sensor series (%u)\n",
+			series);
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "temperature sensor series = %u\n", series);
+
+	return 0;
+}
+
 static int mr75203_probe(struct platform_device *pdev)
 {
 	const struct hwmon_channel_info **pvt_info;
@@ -722,6 +775,10 @@ static int mr75203_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
+		ret = pvt_set_temp_coeff(dev, pvt);
+		if (ret)
+			return ret;
+
 		temp_config = devm_kcalloc(dev, ts_num + 1,
 					   sizeof(*temp_config), GFP_KERNEL);
 		if (!temp_config)
-- 
2.37.1

