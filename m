Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6B5968FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiHQFpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbiHQFoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:44:18 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187607B2BC;
        Tue, 16 Aug 2022 22:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660715042; x=1692251042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0AQXnw93t2lwDKh5bic/I1TgdsGF0kswV/Nq4data+4=;
  b=HEjc3XCqlj/xyJiyeik4DpN0PUfvi1B9+kbskiFZNJEs6iC2m5oh+9g7
   rM+zxFQ18vyVkT9xkHS6mtNsTgIkIT27K44SGsK98s4WeIKtBxSOQJ6ra
   YaSHejxIY6i82zLHF6qq1LExza4/ophDGYjieRQnsV5lhqMWZdXp2Isff
   g=;
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-5feb294a.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:43:40 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-5feb294a.us-west-2.amazon.com (Postfix) with ESMTPS id 1159A835D8;
        Wed, 17 Aug 2022 05:43:39 +0000 (UTC)
Received: from EX13D08UEE003.ant.amazon.com (10.43.62.118) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:23 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D08UEE003.ant.amazon.com (10.43.62.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:23 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 17 Aug 2022 05:43:22
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 793EF4C55; Wed, 17 Aug 2022 05:43:21 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH v2 05/16] hwmon: (mr75203) add option to skip reset controller
Date:   Wed, 17 Aug 2022 05:43:10 +0000
Message-ID: <20220817054321.6519-6-farbere@amazon.com>
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

Adding a "reset-control-skip" bool property to the mr75203 node will
avoid looking up and obtaining a reference to a reset controller.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/hwmon/mr75203.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index f89f7bb5d698..bec63b611eb4 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -525,14 +526,19 @@ static int mr75203_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pvt->rst = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(pvt->rst))
-		return dev_err_probe(dev, PTR_ERR(pvt->rst),
-				     "failed to get reset control\n");
+	if (of_property_read_bool(dev->of_node, "reset-control-skip")) {
+		dev_info(dev, "skipping reset-control\n");
+	} else {
+		pvt->rst = devm_reset_control_get_exclusive(dev, NULL);
+		if (IS_ERR(pvt->rst))
+			return dev_err_probe(dev, PTR_ERR(pvt->rst),
+					     "failed to get reset control\n");
 
-	ret = pvt_reset_control_deassert(dev, pvt);
-	if (ret)
-		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
+		ret = pvt_reset_control_deassert(dev, pvt);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "cannot deassert reset control\n");
+	}
 
 	ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
 	if(ret < 0)
-- 
2.37.1

