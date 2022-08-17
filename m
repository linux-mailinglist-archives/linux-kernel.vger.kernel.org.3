Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23805968D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbiHQFon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbiHQFoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:44:07 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4747726BB;
        Tue, 16 Aug 2022 22:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660715032; x=1692251032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NUVwpERCm95Kj0g+5lmwIVfkVMiD6QAcR9x2CsyUtlc=;
  b=uH+YR2csXv8akWiaJnFO2+QqMmLFvO9KflE0S0GFLc2CmKSeyjdpG3r0
   9XmHGKqZyjaw+jOPCijTMKZEfI2T0U6SmcUFnjnqQulEVBKctCpMzQby0
   p+b1kKfe49rEwXErSpHiar2A9VjmxmiO0Nr8Wd+AMmcoKK2PvutgwjDpu
   o=;
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-90419278.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:43:39 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-90419278.us-west-2.amazon.com (Postfix) with ESMTPS id 6D5A544E5D;
        Wed, 17 Aug 2022 05:43:38 +0000 (UTC)
Received: from EX13D08UEE003.ant.amazon.com (10.43.62.118) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:22 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEE003.ant.amazon.com (10.43.62.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:22 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 17 Aug 2022 05:43:22
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 97D864CA6; Wed, 17 Aug 2022 05:43:21 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH v2 14/16] hwmon: (mr75203) parse thermal coefficients from device-tree
Date:   Wed, 17 Aug 2022 05:43:19 +0000
Message-ID: <20220817054321.6519-15-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817054321.6519-1-farbere@amazon.com>
References: <20220817054321.6519-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index e500897585e4..e54a4d1803e4 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -131,6 +131,10 @@ struct pvt_device {
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
@@ -179,10 +183,10 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
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
@@ -619,6 +623,38 @@ static int mr75203_probe(struct platform_device *pdev)
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

