Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526FD5AE2E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbiIFIfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbiIFIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:34:51 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28192356DC;
        Tue,  6 Sep 2022 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662453290; x=1693989290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ov9+xe+S3g3vEVFOZU63DXVf9WabXZIfj3osYnfDF8M=;
  b=PGTenc6AuIThj3RebUMk8jtgCs9mADnyT37TPqqetmZUIj/AgwbkS+NI
   ujHmOfx5n2pNS5Ln+AOQikizVHygyRy0a/CF+E9YQyOu7l4n36EwMvyiZ
   Q64HcHvBQOIXR3Q3WXLJF5isdeFYFaC+sksLsvn+eR3WS1fs4xT916+GF
   c=;
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:34:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com (Postfix) with ESMTPS id 315F5E0145;
        Tue,  6 Sep 2022 08:34:38 +0000 (UTC)
Received: from EX19D013UWA002.ant.amazon.com (10.13.138.210) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 6 Sep 2022 08:34:00 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA002.ant.amazon.com (10.13.138.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 6 Sep 2022 08:33:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 6 Sep 2022 08:33:59 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id D0F094D8A; Tue,  6 Sep 2022 08:33:57 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 18/21] hwmon: (mr75203) add support for series 6 temperature equation
Date:   Tue, 6 Sep 2022 08:33:53 +0000
Message-ID: <20220906083356.21067-19-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906083356.21067-1-farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

The series is determined according to “moortec,ts-series” property in
the device tree.
If absent, series 5 is assumed to be the default.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V4 -> V3:
- Replace of_property_read_u32() with device_property_read_u32().
- Use switch-case instead of if-else.

V3 -> V2:
- New patch to support temperature sensor series 6 instead of having to
  set all 4 coefficients.

 drivers/hwmon/mr75203.c | 66 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index f98fb0f3d2fd..ba5abd4065b3 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -115,6 +115,15 @@
 #define PVT_SERIES5_J_CONST	-100
 #define PVT_SERIES5_CAL5_CONST	4094
 
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
 
@@ -147,6 +156,13 @@ struct voltage_channels {
 	u8 max;
 };
 
+struct temp_coeff {
+	u32 h;
+	u32 g;
+	u32 cal5;
+	s32 j;
+};
+
 struct pvt_device {
 	struct regmap		*c_map;
 	struct regmap		*t_map;
@@ -156,6 +172,7 @@ struct pvt_device {
 	struct reset_control	*rst;
 	struct voltage_device	*vd;
 	struct voltage_channels	vm_channels;
+	struct temp_coeff	ts_coeff;
 	u32			t_num;
 	u32			p_num;
 	u32			v_num;
@@ -186,10 +203,12 @@ static long pvt_calc_temp(struct pvt_device *pvt, u32 nbs)
 	 * Convert the register value to degrees centigrade temperature:
 	 * T = G + H * (n / cal5 - 0.5) + J * F
 	 */
-	s64 tmp = PVT_SERIES5_G_CONST +
-		PVT_SERIES5_H_CONST * (s64)nbs / PVT_SERIES5_CAL5_CONST -
-		PVT_SERIES5_H_CONST / 2 +
-		PVT_SERIES5_J_CONST * (s64)pvt->ip_freq / HZ_PER_MHZ;
+	struct temp_coeff *ts_coeff = &pvt->ts_coeff;
+
+	s64 tmp = ts_coeff->g +
+		ts_coeff->h * (s64)nbs / ts_coeff->cal5 -
+		ts_coeff->h / 2 +
+		ts_coeff->j * (s64)pvt->ip_freq / HZ_PER_MHZ;
 
 	return clamp_val(tmp, PVT_TEMP_MIN_mC, PVT_TEMP_MAX_mC);
 }
@@ -658,6 +677,41 @@ static int pvt_get_pre_scaler(struct device *dev, struct pvt_device *pvt)
 	return ret;
 }
 
+static int pvt_set_temp_coeff(struct device *dev, struct pvt_device *pvt)
+{
+	struct temp_coeff *ts_coeff = &pvt->ts_coeff;
+	u32 series;
+	int ret;
+
+	/* Incase ts-series property is not defined, use default 5. */
+	ret = device_property_read_u32(dev, "moortec,ts-series", &series);
+	if (ret)
+		series = TEMPERATURE_SENSOR_SERIES_5;
+
+	switch (series) {
+	case TEMPERATURE_SENSOR_SERIES_5:
+		ts_coeff->h = PVT_SERIES5_H_CONST;
+		ts_coeff->g = PVT_SERIES5_G_CONST;
+		ts_coeff->j = PVT_SERIES5_J_CONST;
+		ts_coeff->cal5 = PVT_SERIES5_CAL5_CONST;
+		break;
+	case TEMPERATURE_SENSOR_SERIES_6:
+		ts_coeff->h = PVT_SERIES6_H_CONST;
+		ts_coeff->g = PVT_SERIES6_G_CONST;
+		ts_coeff->j = PVT_SERIES6_J_CONST;
+		ts_coeff->cal5 = PVT_SERIES6_CAL5_CONST;
+		break;
+	default:
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
 	u32 ts_num, vm_num, pd_num, ch_num, val, index, i;
@@ -728,6 +782,10 @@ static int mr75203_probe(struct platform_device *pdev)
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

