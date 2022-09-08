Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD6C5B229B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiIHPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIHPkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:40:45 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74F7E558B;
        Thu,  8 Sep 2022 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662651645; x=1694187645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gCBTDuZ06EJrpoaX6MMKmLoFk3Kp6uVeLNuqZ+aw8Uk=;
  b=IWVF18pE32jTNORnvQx+dNm9A+j+bLYoE3BLWMIdK1JCcrzhPHFMk2of
   Ow/YDHqaKYCDH/bom4LfCbj4KxDpIQ6MN/Z/pnywuzwVuBQz4aWOYy/Xr
   jkBN5IHHN99zwCV1sDyAmnx6u97TPldcNK6oN0HMoVb/tG/fJ7hXD2MZy
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="128019428"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:25:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com (Postfix) with ESMTPS id 831773C0023;
        Thu,  8 Sep 2022 15:25:09 +0000 (UTC)
Received: from EX19D013UWB001.ant.amazon.com (10.13.138.52) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 15:24:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB001.ant.amazon.com (10.13.138.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 8 Sep 2022 15:24:52 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 8 Sep 2022 15:24:52 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 8577B4BE6; Thu,  8 Sep 2022 15:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 09/21] hwmon: (mr75203) skip reset-control deassert for SOCs that don't support it
Date:   Thu, 8 Sep 2022 15:24:37 +0000
Message-ID: <20220908152449.35457-10-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908152449.35457-1-farbere@amazon.com>
References: <20220908152449.35457-1-farbere@amazon.com>
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

Don't fail the probe function and don't deassert the reset controller if
a "reset" property doesn't exist in the device tree.

Change is done for SOCs that don't support a reset controller.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
V3 -> v2:
- Change "reset" property to be optional instead of skipping it.

 drivers/hwmon/mr75203.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 41e3d3b54baf..19ec9fb91202 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -551,14 +551,17 @@ static int mr75203_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pvt->rst = devm_reset_control_get_exclusive(dev, NULL);
+	pvt->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(pvt->rst))
 		return dev_err_probe(dev, PTR_ERR(pvt->rst),
 				     "failed to get reset control\n");
 
-	ret = pvt_reset_control_deassert(dev, pvt);
-	if (ret)
-		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
+	if (pvt->rst) {
+		ret = pvt_reset_control_deassert(dev, pvt);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "cannot deassert reset control\n");
+	}
 
 	ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
 	if(ret < 0)
-- 
2.37.1

