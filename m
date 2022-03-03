Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9F54CC719
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbiCCUfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiCCUfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:35:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903A6EEA57;
        Thu,  3 Mar 2022 12:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646339686; x=1677875686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tM8jBlIUkxhKyQ0W8V73UEcthIfQ+McOciGDrTycFHk=;
  b=m4Y6f2Lv0QuKpjxncX68+gAbbgATbgbSSchsGQmp+egOUTteqSG+oL5U
   sysgPocoIziiD8WGB3T5otS31UykdqeGl9AznxYObsWbkFQqS8dtTGh1F
   9UpZhM7KtC0e/8+p4JKOPqXB4dsqVmcQ+8ruDDBh7cvKJUaMHB5pSaPxU
   EylMVK1tkbLag+FpLb3XRvFO3uWulBfqb3yfUW2GEYiXN8KfKnXnYDOPo
   Af/gOEVWndwEbs6I50TeayjCaWicO2JS5eSkD9eT0iEahk/gPixHCS/Ev
   OrgQ24cXUNfVeBObaea+ClF4zscfUVxqqwqfrFjXx8rF31kzwBsV/Q5tC
   g==;
X-IronPort-AV: E=Sophos;i="5.90,153,1643698800"; 
   d="scan'208";a="150780458"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2022 13:34:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 3 Mar 2022 13:34:45 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 3 Mar 2022 13:34:44 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <colin.foster@in-advantage.com>,
        <andriy.shevchenko@linux.intel.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 1/2] pinctrl: ocelot: Fix the pincfg resource.
Date:   Thu, 3 Mar 2022 21:37:15 +0100
Message-ID: <20220303203716.3012703-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220303203716.3012703-1-horatiu.vultur@microchip.com>
References: <20220303203716.3012703-1-horatiu.vultur@microchip.com>
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

