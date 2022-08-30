Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9689C5A6D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiH3TXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiH3TWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:22:53 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C0379A7E;
        Tue, 30 Aug 2022 12:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661887362; x=1693423362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U0VJcbOTM8ab3MiQEMGAYi1n6qUqXBDMxjPiRHK115k=;
  b=Lh0vawBdls/5T6rFmXcgDZCxiuJveGKDZrnaq3QOjJw5/aWwSHVdSx0/
   /SeMtWrg8GpvclrrtvEjwZVBiksnNt6uGvaM0CZfA9NCnbqKj5Z+jW/KW
   /P8BgWy/XrrYqeeUjjavp0J0rZsrLCqJd5Zu+vJ60R4aO8r6ELDc30fMc
   A=;
X-IronPort-AV: E=Sophos;i="5.93,275,1654560000"; 
   d="scan'208";a="125055929"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-f771ae83.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 19:22:40 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-f771ae83.us-east-1.amazon.com (Postfix) with ESMTPS id 2DD74120072;
        Tue, 30 Aug 2022 19:22:39 +0000 (UTC)
Received: from EX19D013UWA004.ant.amazon.com (10.13.138.207) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 30 Aug 2022 19:22:16 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA004.ant.amazon.com (10.13.138.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 30 Aug 2022 19:22:16 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 30 Aug 2022 19:22:15
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 6B5974D41; Tue, 30 Aug 2022 19:22:12 +0000 (UTC)
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
Subject: [PATCH v3 17/19] hwmon: (mr75203) parse temperature coefficients from device-tree
Date:   Tue, 30 Aug 2022 19:22:10 +0000
Message-ID: <20220830192212.28570-18-farbere@amazon.com>
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

Use thermal coefficients from the device tree if they exist.
Otherwise, use default values according to the series (5 or 6).
All coefficients can be used or only part of them.

The coefficients shall be used for fine tuning the default values since
coefficients can vary between product and product.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/hwmon/mr75203.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 6a035fd115ca..d9fc5d225868 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -676,7 +676,8 @@ static int pvt_set_temp_coeff(struct device *dev, struct pvt_device *pvt)
 {
 	struct temp_coeff *ts_coeff = &pvt->ts_coeff;
 	const struct device_node *np = dev->of_node;
-	u32 series;
+	u32 series, coeff_h, coeff_g, coeff_cal5;
+	s32 coeff_j;
 	int ret;
 
 	/* Incase ts-series property is not defined, use default 5. */
@@ -702,6 +703,32 @@ static int pvt_set_temp_coeff(struct device *dev, struct pvt_device *pvt)
 
 	dev_dbg(dev, "temperature sensor series = %u\n", series);
 
+	/* Override ts-coeff-h/g/j/cal5 if they are defined. */
+	ret = of_property_read_u32(np, "moortec,ts-coeff-h", &coeff_h);
+	if (!ret)
+		ts_coeff->h = coeff_h;
+
+	ret = of_property_read_u32(np, "moortec,ts-coeff-g", &coeff_g);
+	if (!ret)
+		ts_coeff->g = coeff_g;
+
+	ret = of_property_read_s32(np, "moortec,ts-coeff-j", &coeff_j);
+	if (!ret)
+		ts_coeff->j = coeff_j;
+
+	ret = of_property_read_u32(np, "moortec,ts-coeff-cal5", &coeff_cal5);
+	if (!ret) {
+		if (coeff_cal5 == 0) {
+			dev_err(dev, "moortec,ts-coeff-cal5 can't be 0\n");
+			return -EINVAL;
+		}
+
+		ts_coeff->cal5 = coeff_cal5;
+	}
+
+	dev_dbg(dev, "ts-coeff: h = %u, g = %u, j = %d, cal5 = %u\n",
+		ts_coeff->h, ts_coeff->g, ts_coeff->j, ts_coeff->cal5);
+
 	return 0;
 }
 
-- 
2.37.1

