Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14975AE2B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiIFIeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiIFIeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:34:21 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBA117AB5;
        Tue,  6 Sep 2022 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662453261; x=1693989261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x+33rYav/AsPibYhxCbc0w3qFQuDbRm8ElL2qDQwvlI=;
  b=JRjx7eVhyM3vV7KjqGXDq/cPmPcHQm6H/gnnZPdYcwyl/Gk2fkVmGzs1
   +dpCnfBWh/WQbebn6/k3kc79daJaeZoX9qrU+F+IS+uFwEGHy+HKe2Go2
   oulUkTzsSUzezJnWyhsZAXYdYwMoNuL/ve5owUzK9jKLqmYOC5nFuea0o
   U=;
X-IronPort-AV: E=Sophos;i="5.93,293,1654560000"; 
   d="scan'208";a="223661265"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-b48bc93b.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:34:03 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-b48bc93b.us-east-1.amazon.com (Postfix) with ESMTPS id 304F3C022E;
        Tue,  6 Sep 2022 08:33:58 +0000 (UTC)
Received: from EX19D013UWB004.ant.amazon.com (10.13.138.62) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 6 Sep 2022 08:33:58 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB004.ant.amazon.com (10.13.138.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Tue, 6 Sep 2022 08:33:58 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 6 Sep 2022 08:33:58 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id C74184D70; Tue,  6 Sep 2022 08:33:57 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 16/21] hwmon: (mr75203) modify the temperature equation according to series 5 datasheet
Date:   Tue, 6 Sep 2022 08:33:51 +0000
Message-ID: <20220906083356.21067-17-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906083356.21067-1-farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
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
index 66f151082c11..f98fb0f3d2fd 100644
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
@@ -327,7 +344,7 @@ static int pvt_init(struct pvt_device *pvt)
 		    (key >> 1) << CLK_SYNTH_HI_SFT |
 		    (key >> 1) << CLK_SYNTH_HOLD_SFT | CLK_SYNTH_EN;
 
-	pvt->ip_freq = sys_freq * 100 / (key + 2);
+	pvt->ip_freq = clk_get_rate(pvt->clk) / (key + 2);
 
 	if (t_num) {
 		ret = regmap_write(t_map, SDIF_SMPL_CTRL, 0x0);
-- 
2.37.1

