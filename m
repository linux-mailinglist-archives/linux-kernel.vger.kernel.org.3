Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048C94CC71A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbiCCUfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbiCCUfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:35:34 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E66EEA65;
        Thu,  3 Mar 2022 12:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646339688; x=1677875688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F1/s1mP5Lcx/uFwwtY6gQcRqc063q6v7LM6wZ1JFe00=;
  b=rIzeijlbh2MkY4P6UAJsoLuORvlDlEaC4mOULaESBdN5AKVQ7qbnq991
   uhAqzrBOXVNpul39YpXzviHyn285Io8EcLden9cpkB9k0RmF0DP9ViBCD
   X6LJqXij+29X1eQ3K5Vc+Ydju7hse8vUtbJ7RMBaZphM/jKxhGkSscbaR
   69lTa/mLyjKD/HjDM9nl218MoSCzxDcCJdyLKXmbFTncznQsPR/w4vSZj
   vwSCu+YIX9a73sgYkb1xYise8z1AZln3VfSIst5gAPqhIlQIBYRMQqNAi
   3FsPjX9WEXDeOAoiliBEy571u7gP2QxlaR70zrKgbuQETdKwSRSqLxeK1
   g==;
X-IronPort-AV: E=Sophos;i="5.90,153,1643698800"; 
   d="scan'208";a="155638920"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2022 13:34:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 3 Mar 2022 13:34:47 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 3 Mar 2022 13:34:46 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <colin.foster@in-advantage.com>,
        <andriy.shevchenko@linux.intel.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 2/2] pinctrl: ocelot: Fix interrupt parsing
Date:   Thu, 3 Mar 2022 21:37:16 +0100
Message-ID: <20220303203716.3012703-3-horatiu.vultur@microchip.com>
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

In the blamed commit, it removes the duplicate of_node assignment in the
driver. But the driver uses this before calling into of_gpio_dev_init to
determine if it needs to assign an IRQ chip to the GPIO. The fixes
consists in using of_node from dev.

Fixes: 8a8d6bbe1d3bc7 ("pinctrl: Get rid of duplicate of_node assignment in the drivers")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index a859fbcb09af..a0f00380e700 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1851,7 +1851,7 @@ static int ocelot_gpiochip_register(struct platform_device *pdev,
 	gc->base = -1;
 	gc->label = "ocelot-gpio";
 
-	irq = irq_of_parse_and_map(gc->of_node, 0);
+	irq = irq_of_parse_and_map(info->dev->of_node, 0);
 	if (irq) {
 		girq = &gc->irq;
 		girq->chip = &ocelot_irqchip;
-- 
2.33.0

