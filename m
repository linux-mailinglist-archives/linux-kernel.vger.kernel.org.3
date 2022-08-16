Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A05B5957E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiHPKRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiHPKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:16:36 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3548DF0B3;
        Tue, 16 Aug 2022 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660638501; x=1692174501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ULkqAHITNyNY+nb/F2KUcwZfWxaEdjYhDYRpVxQWyfI=;
  b=vZF3rZuQuo4YNJXjDkVRkT9o0m6qo8vDPkO3XxIGS/qT3SAelrx6VY8k
   1gVd89lxvtmr2KxQ+r+Ll8HtSPn7jvSngY/rJOHNkEzp4jegBvZzBZR3S
   +e5v+XBZXhAvPB0Xkk0Mcs+l/WE6HiXbUhtEfUWnLcp9W7NJy4TTvg4TK
   Q=;
X-IronPort-AV: E=Sophos;i="5.93,240,1654560000"; 
   d="scan'208";a="233486642"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-2d7489a4.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 08:28:20 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-2d7489a4.us-east-1.amazon.com (Postfix) with ESMTPS id 9A42C8705F;
        Tue, 16 Aug 2022 08:28:20 +0000 (UTC)
Received: from EX19D013UWA004.ant.amazon.com (10.13.138.207) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 16 Aug 2022 08:28:00 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA004.ant.amazon.com (10.13.138.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 16 Aug 2022 08:27:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 16 Aug 2022 08:27:59
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 61ACF4C09; Tue, 16 Aug 2022 08:27:57 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH 01/16] hwmon: (mr75203) fix VM sensor allocation when "intel,vm-map" not defined
Date:   Tue, 16 Aug 2022 08:27:42 +0000
Message-ID: <20220816082757.11990-2-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220816082757.11990-1-farbere@amazon.com>
References: <20220816082757.11990-1-farbere@amazon.com>
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

