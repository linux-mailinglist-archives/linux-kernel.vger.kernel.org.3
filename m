Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4165968E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiHQFof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiHQFoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:44:05 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0107C746;
        Tue, 16 Aug 2022 22:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660715033; x=1692251033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ULkqAHITNyNY+nb/F2KUcwZfWxaEdjYhDYRpVxQWyfI=;
  b=s5Y7+8+e8jDKsq5NJfba9n5GLRUpPWu7VYvjYB9fmH6RQTsgVIxtA2sL
   ncBkqSt8f2LckYya9zCettFii/E6Grv4qFNsNki9h2W+fwzh8ykXQtIa0
   Qgkhx/BjgDluGAOj8b+P3ZMsTRux0lk5mUg+Tf3EewlUoFzAvtODrNFbY
   M=;
X-IronPort-AV: E=Sophos;i="5.93,242,1654560000"; 
   d="scan'208";a="120136323"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-5feb294a.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:43:39 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-5feb294a.us-west-2.amazon.com (Postfix) with ESMTPS id A5FC7835D8;
        Wed, 17 Aug 2022 05:43:37 +0000 (UTC)
Received: from EX13D08UEE003.ant.amazon.com (10.43.62.118) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:22 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D08UEE003.ant.amazon.com (10.43.62.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:21 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 17 Aug 2022 05:43:21
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 6BB1F4C4B; Wed, 17 Aug 2022 05:43:21 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH v2 01/16] hwmon: (mr75203) fix VM sensor allocation when "intel,vm-map" not defined
Date:   Wed, 17 Aug 2022 05:43:06 +0000
Message-ID: <20220817054321.6519-2-farbere@amazon.com>
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

Fix a bug that in case "intel,vm-map" is missing 'num' is set to 0,
and no voltage channel infos are allocated.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/hwmon/mr75203.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 046523d47c29..0e29877a1a9c 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -580,8 +580,6 @@ static int mr75203_probe(struct platform_device *pdev)
 	}
 
 	if (vm_num) {
-		u32 num = vm_num;
-
 		ret = pvt_get_regmap(pdev, "vm", pvt);
 		if (ret)
 			return ret;
@@ -594,30 +592,28 @@ static int mr75203_probe(struct platform_device *pdev)
 		ret = device_property_read_u8_array(dev, "intel,vm-map",
 						    pvt->vm_idx, vm_num);
 		if (ret) {
-			num = 0;
+			/*
+			 * Incase intel,vm-map property is not defined, we
+			 * assume incremental channel numbers.
+			 */
+			for (i = 0; i < vm_num; i++)
+				pvt->vm_idx[i] = i;
 		} else {
 			for (i = 0; i < vm_num; i++)
 				if (pvt->vm_idx[i] >= vm_num ||
-				    pvt->vm_idx[i] == 0xff) {
-					num = i;
+				    pvt->vm_idx[i] == 0xff)
 					break;
-				}
-		}
 
-		/*
-		 * Incase intel,vm-map property is not defined, we assume
-		 * incremental channel numbers.
-		 */
-		for (i = num; i < vm_num; i++)
-			pvt->vm_idx[i] = i;
+			vm_num = i;
+		}
 
-		in_config = devm_kcalloc(dev, num + 1,
+		in_config = devm_kcalloc(dev, vm_num + 1,
 					 sizeof(*in_config), GFP_KERNEL);
 		if (!in_config)
 			return -ENOMEM;
 
-		memset32(in_config, HWMON_I_INPUT, num);
-		in_config[num] = 0;
+		memset32(in_config, HWMON_I_INPUT, vm_num);
+		in_config[vm_num] = 0;
 		pvt_in.config = in_config;
 
 		pvt_info[index++] = &pvt_in;
-- 
2.37.1

