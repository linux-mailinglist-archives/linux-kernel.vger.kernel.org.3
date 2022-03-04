Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6264CD69B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbiCDOnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbiCDOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:43:11 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02921BD04B;
        Fri,  4 Mar 2022 06:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646404943; x=1677940943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zlHFHwW7mYn6Pe7YF0bXGzbThYPa0Mv9pWYRze3Df2w=;
  b=Xv5oN8eyDYn5f8wgrvzTV/97iWEgRQroKG6iQHdV3Ih6vJ8Wz+5qTj/7
   v578yop/1VJbjmXTrSKyL/eSpbfILX0jOqWyUWPOGtN0HE4vMTH5clD09
   VMZnBFy7+1EgMHRx94cvZNW4DeK2/QoH47FJtGcC80beWhn54BXdvZWVw
   STwoimyW1XE6DWq3Sqn2kjRqvgwyMsEjz+pGMOE6rwl6r9/Raef3PI361
   4IIiYPbaYzMJ3yN3yS7huNIxaz+h/KAzWOBI9919WMZp0y0TAKYUkOFVU
   Hw3jECSpBvAU5ioqGg+W4AEfh2sjblXErH7xUhNCvGwasH8/YYhgvnpvi
   g==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="150870204"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 07:42:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 07:42:23 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 07:42:20 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <colin.foster@in-advantage.com>,
        <andriy.shevchenko@linux.intel.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 1/2] pinctrl: ocelot: Fix the pincfg resource.
Date:   Fri, 4 Mar 2022 15:44:31 +0100
Message-ID: <20220304144432.3397621-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220304144432.3397621-1-horatiu.vultur@microchip.com>
References: <20220304144432.3397621-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pincfg resources are in the second memory resource. But the driver
still tries to access the first memory resource to get the pincfg. This
is wrong therefore fix to access the second memory resource.

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>
Fixes: ad96111e658a95 ("pinctrl: ocelot: combine get resource and ioremap into single call")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 685c79e08d40..a859fbcb09af 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1892,7 +1892,7 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
 		.max_register = 32,
 	};
 
-	base = devm_platform_ioremap_resource(pdev, 0);
+	base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(base)) {
 		dev_dbg(&pdev->dev, "Failed to ioremap config registers (no extended pinconf)\n");
 		return NULL;
-- 
2.33.0

