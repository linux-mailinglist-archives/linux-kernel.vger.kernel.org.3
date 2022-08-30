Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670785A6D40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiH3TYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiH3TXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:23:48 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61BD7C1C7;
        Tue, 30 Aug 2022 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661887389; x=1693423389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D6zTFiLCs38Qd3fgLhl+xoNoittGTp7vL7ilYx1GgRc=;
  b=PRkeegemkUS6UX0Xa9fb9S36ebzzIfJkBu6sA+p5t55cyumoD4uBr2os
   Yk44NoxsAKODrBlCLs/HHDafOYEwZ5jdKLaNZnzSRsSiTxSNkqb4N/r2W
   ugtiMaG9gc7YAGxMO6BrVV957YxxmliVRpOyV3RJHdvEGkt1NC7DDt6bs
   4=;
X-IronPort-AV: E=Sophos;i="5.93,275,1654560000"; 
   d="scan'208";a="222136156"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-c92fe759.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 19:22:41 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-c92fe759.us-east-1.amazon.com (Postfix) with ESMTPS id 79FDEC0925;
        Tue, 30 Aug 2022 19:22:38 +0000 (UTC)
Received: from EX19D013UWA004.ant.amazon.com (10.13.138.207) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 30 Aug 2022 19:22:15 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX19D013UWA004.ant.amazon.com (10.13.138.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 30 Aug 2022 19:22:14 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 30 Aug 2022 19:22:13
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 5DA524D09; Tue, 30 Aug 2022 19:22:12 +0000 (UTC)
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
Subject: [PATCH v3 13/19] hwmon: (mr75203) modify the temperature equation according to series 5 datasheet
Date:   Tue, 30 Aug 2022 19:22:06 +0000
Message-ID: <20220830192212.28570-14-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830192212.28570-1-farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
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

Change is done since it is not clear where the current equation and
coefficients came from.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V3 -> V2:
- Protect from overflow.
- Add temperature clamping.
- Add better documentation.

 drivers/hwmon/mr75203.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index d1f090a9baac..5b8ca1ee4a54 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -103,13 +103,17 @@
 
 #define PVT_POLL_DELAY_US	20
 #define PVT_POLL_TIMEOUT_US	20000
-#define PVT_H_CONST		100000
-#define PVT_CAL5_CONST		2047
-#define PVT_G_CONST		40000
+#define PVT_H_CONST		200000
+#define PVT_G_CONST		60000
+#define PVT_J_CONST		-100
+#define PVT_CAL5_CONST		4094
 #define PVT_CONV_BITS		10
 #define PVT_N_CONST		90
 #define PVT_R_CONST		245805
 
+#define PVT_TEMP_MIN		-40000
+#define PVT_TEMP_MAX		125000
+
 #define PRE_SCALER_X1	1
 #define PRE_SCALER_X2	2
 
@@ -157,13 +161,24 @@ static umode_t pvt_is_visible(const void *data, enum hwmon_sensor_types type,
 	return 0;
 }
 
+static long pvt_calc_temp(struct pvt_device *pvt, u32 nbs)
+{
+	/*
+	 * Convert the register value to degrees centigrade temperature:
+	 * T = G + H * (n / cal5 - 0.5) + J * F
+	 */
+	s64 tmp = PVT_G_CONST + PVT_H_CONST * (s64)nbs / PVT_CAL5_CONST -
+		PVT_H_CONST / 2 + PVT_J_CONST * (s64)pvt->ip_freq / HZ_PER_MHZ;
+
+	return clamp_val(tmp, PVT_TEMP_MIN, PVT_TEMP_MAX);
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
@@ -184,9 +199,7 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
 		 * Convert the register value to
 		 * degrees centigrade temperature
 		 */
-		tmp = nbs * PVT_H_CONST;
-		do_div(tmp, PVT_CAL5_CONST);
-		*val = tmp - PVT_G_CONST - pvt->ip_freq;
+		*val = pvt_calc_temp(pvt, nbs);
 
 		return 0;
 	default:
@@ -311,7 +324,7 @@ static int pvt_init(struct pvt_device *pvt)
 		    (key >> 1) << CLK_SYNTH_HI_SFT |
 		    (key >> 1) << CLK_SYNTH_HOLD_SFT | CLK_SYNTH_EN;
 
-	pvt->ip_freq = sys_freq * 100 / (key + 2);
+	pvt->ip_freq = clk_get_rate(pvt->clk) / (key + 2);
 
 	if (t_num) {
 		ret = regmap_write(t_map, SDIF_SMPL_CTRL, 0x0);
-- 
2.37.1

