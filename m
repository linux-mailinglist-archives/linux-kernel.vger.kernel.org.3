Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F098B5AE338
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiIFIkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiIFIjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:39:21 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603A77755B;
        Tue,  6 Sep 2022 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662453450; x=1693989450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AiNS3dExIcIQA64HvH7x+bCq1JO8YLTysTnJ3srzlQc=;
  b=KY84TLKoSJVPgP/8i+ZfgBGrimqWbRv7o8XcQzoKAJ8sp3yZI9mFz+en
   04JwHSb0WfhqMubIpPwfaAWaArcPNZPAPBHskc38IqSCXiVfYtHWvhR/X
   8wxDsVF9bf82RJ7yWOj+B9STTIvW0y8o7wJn15PGaDBy+3xL1t4Jj1Y/w
   k=;
X-IronPort-AV: E=Sophos;i="5.93,293,1654560000"; 
   d="scan'208";a="127050122"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:34:39 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com (Postfix) with ESMTPS id 9DCFDE05B6;
        Tue,  6 Sep 2022 08:34:37 +0000 (UTC)
Received: from EX19D013UWA003.ant.amazon.com (10.13.138.202) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 6 Sep 2022 08:33:59 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA003.ant.amazon.com (10.13.138.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 6 Sep 2022 08:33:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 6 Sep 2022 08:33:59 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id D022E4D7E; Tue,  6 Sep 2022 08:33:57 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 20/21] hwmon: (mr75203) parse temperature coefficients from device-tree
Date:   Tue, 6 Sep 2022 08:33:55 +0000
Message-ID: <20220906083356.21067-21-farbere@amazon.com>
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

Use thermal coefficients from the device tree if they exist.
Otherwise, use default values according to the series (5 or 6).
All coefficients can be used or only part of them.

The coefficients shall be used for fine tuning the default values since
coefficients can vary between product and product.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V4 -> V3:
- Replace of_property_read_u32() with device_property_read_u32().
- Fix "Code shouldn't be a YAML validator".
- Read directly to ts_coeff-> parameter to avoid conditional if.

 drivers/hwmon/mr75203.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index ba5abd4065b3..8baa99a9ea83 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -709,6 +709,15 @@ static int pvt_set_temp_coeff(struct device *dev, struct pvt_device *pvt)
 
 	dev_dbg(dev, "temperature sensor series = %u\n", series);
 
+	/* Override ts-coeff-h/g/j/cal5 if they are defined. */
+	device_property_read_u32(dev, "moortec,ts-coeff-h", &ts_coeff->h);
+	device_property_read_u32(dev, "moortec,ts-coeff-g", &ts_coeff->g);
+	device_property_read_u32(dev, "moortec,ts-coeff-j", &ts_coeff->j);
+	device_property_read_u32(dev, "moortec,ts-coeff-cal5", &ts_coeff->cal5);
+
+	dev_dbg(dev, "ts-coeff: h = %u, g = %u, j = %d, cal5 = %u\n",
+		ts_coeff->h, ts_coeff->g, ts_coeff->j, ts_coeff->cal5);
+
 	return 0;
 }
 
-- 
2.37.1

