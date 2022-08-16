Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1263B595712
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiHPJuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiHPJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:50:26 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2BF139D93;
        Tue, 16 Aug 2022 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660638501; x=1692174501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4O85Ywpsk0CWX8vVdYh3wJcHjYPaTGC/6XL8TPAGJOE=;
  b=oY6AdOURKu2wtaB8asLWGrTpXSq5hWNp7FQx+nWXbbMFCajnthtdnbbC
   rSHKiBHAW5Bu4YEzmk6SSAK+43mxqLH/QbITRF5Jtws6Lp+dWSVKlcthO
   mMXP2Ghi8t97y2uUwwqDt2zkmG0vQdfVJEJ/AQL1mV6ergZkfAdVBRj2v
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,240,1654560000"; 
   d="scan'208";a="230105355"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-b09ea7fa.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 08:28:20 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-b09ea7fa.us-west-2.amazon.com (Postfix) with ESMTPS id 46F4744ABC;
        Tue, 16 Aug 2022 08:28:18 +0000 (UTC)
Received: from EX13D08UEE002.ant.amazon.com (10.43.62.92) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 16 Aug 2022 08:27:59 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D08UEE002.ant.amazon.com (10.43.62.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 16 Aug 2022 08:27:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 16 Aug 2022 08:27:59
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 626CA4B60; Tue, 16 Aug 2022 08:27:57 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH 14/16] hwmon: (mr75203) parse thermal coefficients from device-tree
Date:   Tue, 16 Aug 2022 08:27:55 +0000
Message-ID: <20220816082757.11990-15-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220816082757.11990-1-farbere@amazon.com>
References: <20220816082757.11990-1-farbere@amazon.com>
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

Use thermal coefficients from the device tree if they exist.
Otherwise, use default values.

The equation used in the driver is:
  T = G + H * (n / cal5 - 0.5) + J * F

With this change we can support also Mode 1 Conversion, which
uses A instead of G, and B instead of H.

We can also support the series 6 equation that has different
coefficients and has a slightly different format:
  T = G + H * (n / cal5 - 0.5)
by setting J to 0.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/hwmon/mr75203.c | 44 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 59e2dc8fa333..79831a0d5dca 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -129,6 +129,10 @@ struct pvt_device {
 	u32			p_num;
 	u32			v_num;
 	u32			ip_freq;
+	u32			ts_coeff_h;
+	u32			ts_coeff_g;
+	s32			ts_coeff_j;
+	u32			ts_coeff_cal5;
 	u8			vm_ch_max;
 	u8			vm_ch_total;
 };
@@ -177,10 +181,10 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
 		 * Convert the register value to degrees centigrade temperature:
 		 * T = G + H * (n / cal5 - 0.5) + J * F
 		 */
-		*val = PVT_G_CONST;
-		*val += PVT_H_CONST * nbs / PVT_CAL5_CONST;
-		*val -= PVT_H_CONST / 2;
-		*val += PVT_J_CONST * pvt->ip_freq / HZ_PER_MHZ;
+		*val = pvt->ts_coeff_g;
+		*val += pvt->ts_coeff_h * nbs / pvt->ts_coeff_cal5;
+		*val -= pvt->ts_coeff_h / 2;
+		*val += pvt->ts_coeff_j * pvt->ip_freq / HZ_PER_MHZ;
 
 		return 0;
 	default:
@@ -617,6 +621,38 @@ static int mr75203_probe(struct platform_device *pdev)
 		memset32(temp_config, HWMON_T_INPUT, ts_num);
 		pvt_temp.config = temp_config;
 		pvt_info[index++] = &pvt_temp;
+
+		/*
+		 * Incase ts-coeff-h/g/j/cal5 property is not defined, use
+		 * default value.
+		 */
+		ret = of_property_read_u32(np, "ts-coeff-h", &pvt->ts_coeff_h);
+		if (ret)
+			pvt->ts_coeff_h = PVT_H_CONST;
+
+		ret = of_property_read_u32(np, "ts-coeff-g", &pvt->ts_coeff_g);
+		if (ret)
+			pvt->ts_coeff_g = PVT_G_CONST;
+
+		ret = of_property_read_s32(np, "ts-coeff-j", &pvt->ts_coeff_j);
+		if (ret)
+			pvt->ts_coeff_j = PVT_J_CONST;
+
+		ret = of_property_read_u32(np, "ts-coeff-cal5",
+					   &pvt->ts_coeff_cal5);
+		if (ret) {
+			pvt->ts_coeff_cal5 = PVT_CAL5_CONST;
+		} else {
+			if (pvt->ts_coeff_cal5 == 0) {
+				dev_err(dev, "invalid ts-coeff-cal5 (%u)\n",
+					pvt->ts_coeff_cal5);
+				return -EINVAL;
+			}
+		}
+
+		dev_dbg(dev, "ts-coeff: h = %u, g = %u, j = %d, cal5 = %u\n",
+			pvt->ts_coeff_h, pvt->ts_coeff_g, pvt->ts_coeff_j,
+			pvt->ts_coeff_cal5);
 	}
 
 	if (pd_num) {
-- 
2.37.1

