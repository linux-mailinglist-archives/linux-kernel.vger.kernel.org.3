Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A031F5B2216
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiIHPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiIHPZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:25:21 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E896482F90;
        Thu,  8 Sep 2022 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662650721; x=1694186721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qi3hYHU7Z6wJj5EUZ6Qqipb7lz7TJ99AeMFyc6d1MGc=;
  b=i+mIvkmAab6WHVvxDDMrfBW7NS2WbXa0aWU8tg2qOnXNS4WrEH74FGod
   4zpasYeI7L5fCNVaIq28JyZSrWhiOR+yO0EoGd1Stgj/qEOuog+J2fQYL
   +/0Cz2JQfVQa1+KG4sgZWiqpqDYMZampZu2+ICov9+n2/uFQm3rB057n0
   g=;
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="239041917"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-b48bc93b.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:25:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-b48bc93b.us-east-1.amazon.com (Postfix) with ESMTPS id 7F413C08B6;
        Thu,  8 Sep 2022 15:25:08 +0000 (UTC)
Received: from EX19D013UWA001.ant.amazon.com (10.13.138.253) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 15:24:51 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D013UWA001.ant.amazon.com (10.13.138.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 8 Sep 2022 15:24:51 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 8 Sep 2022 15:24:50 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 79B834D60; Thu,  8 Sep 2022 15:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 15/21] hwmon: (mr75203) modify the temperature equation according to series 5 datasheet
Date:   Thu, 8 Sep 2022 15:24:43 +0000
Message-ID: <20220908152449.35457-16-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908152449.35457-1-farbere@amazon.com>
References: <20220908152449.35457-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the equation and coefficients used to convert the digital output
to temperature according to series 5 of the Moortec Embedded Temperature
Sensor (METS) datasheet:
T = G + H * (n / cal5 - 0.5) + J * F

Where:
*) G = 60, H = 200, cal5 = 4094, J = -0.1.
*) F = frequency clock in MHz.
*) n is the digital output.

In code, the G, H and J coefficients are multiplied by a factor of 1000
to get the temperature in milli-Celsius.
Final result is clamped in case it exceeds min/max thresholds.

Change is done since it is unclear where the current equation and
coefficients came from.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
V4 -> V3:
- Change 'not clear' to 'unclear' in commit message.
- Add _mC prefix to temperature mix/max defines.
- Add SERIES5 to coefficient defines.

V3 -> V2:
- Protect from overflow.
- Add temperature clamping.
- Add better documentation.

 drivers/hwmon/mr75203.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 8a6ae72fed20..0de64642cc42 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -102,13 +102,19 @@
 
 #define PVT_POLL_DELAY_US	20
 #define PVT_POLL_TIMEOUT_US	20000
-#define PVT_H_CONST		100000
-#define PVT_CAL5_CONST		2047
-#define PVT_G_CONST		40000
 #define PVT_CONV_BITS		10
 #define PVT_N_CONST		90
 #define PVT_R_CONST		245805
 
+#define PVT_TEMP_MIN_mC		-40000
+#define PVT_TEMP_MAX_mC		125000
+
+/* Temperature coefficients for series 5 */
+#define PVT_SERIES5_H_CONST	200000
+#define PVT_SERIES5_G_CONST	60000
+#define PVT_SERIES5_J_CONST	-100
+#define PVT_SERIES5_CAL5_CONST	4094
+
 #define PRE_SCALER_X1	1
 #define PRE_SCALER_X2	2
 
@@ -174,13 +180,26 @@ static umode_t pvt_is_visible(const void *data, enum hwmon_sensor_types type,
 	return 0;
 }
 
+static long pvt_calc_temp(struct pvt_device *pvt, u32 nbs)
+{
+	/*
+	 * Convert the register value to degrees centigrade temperature:
+	 * T = G + H * (n / cal5 - 0.5) + J * F
+	 */
+	s64 tmp = PVT_SERIES5_G_CONST +
+		PVT_SERIES5_H_CONST * (s64)nbs / PVT_SERIES5_CAL5_CONST -
+		PVT_SERIES5_H_CONST / 2 +
+		PVT_SERIES5_J_CONST * (s64)pvt->ip_freq / HZ_PER_MHZ;
+
+	return clamp_val(tmp, PVT_TEMP_MIN_mC, PVT_TEMP_MAX_mC);
+}
+
 static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
 {
 	struct pvt_device *pvt = dev_get_drvdata(dev);
 	struct regmap *t_map = pvt->t_map;
 	u32 stat, nbs;
 	int ret;
-	u64 tmp;
 
 	switch (attr) {
 	case hwmon_temp_input:
@@ -201,9 +220,7 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
 		 * Convert the register value to
 		 * degrees centigrade temperature
 		 */
-		tmp = nbs * PVT_H_CONST;
-		do_div(tmp, PVT_CAL5_CONST);
-		*val = tmp - PVT_G_CONST - pvt->ip_freq;
+		*val = pvt_calc_temp(pvt, nbs);
 
 		return 0;
 	default:
@@ -337,7 +354,7 @@ static int pvt_init(struct pvt_device *pvt)
 		    (key >> 1) << CLK_SYNTH_HI_SFT |
 		    (key >> 1) << CLK_SYNTH_HOLD_SFT | CLK_SYNTH_EN;
 
-	pvt->ip_freq = sys_freq * 100 / (key + 2);
+	pvt->ip_freq = clk_get_rate(pvt->clk) / (key + 2);
 
 	if (t_num) {
 		ret = regmap_write(t_map, SDIF_SMPL_CTRL, 0x0);
-- 
2.37.1

