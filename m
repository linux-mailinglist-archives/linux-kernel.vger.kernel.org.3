Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE4156C3CD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbiGHTwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiGHTw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:52:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9812D88F0A;
        Fri,  8 Jul 2022 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657309946; x=1688845946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LG5eCJnhq7CNdWQfFoA7Fx4XHtKqkdJMjEPMFM/NCzQ=;
  b=X+QwyiME2dQneD45RdQDE6mFwOMqTfq+YVsNIQwcrwkpP9+jpDR/+JkG
   SKNb9bLngbqP4eU+zNAoqqpbEV/9UlRA7NKZTQzcVBuA3b7bAdIHswbSK
   tkxbOe8h6zmlqpuX2kTux284J1CnhjrS+qbgiCpugfUe9pCh4jSGGhDpe
   vnBZARfIvBiS3NS9XzHTaBRNYfKU84jPVXC++oEz/XbMKgLq4HK2ZFCRz
   tv6FsewQz2ipRvcKeT5Oz+pikVhTd14Tizaxx2D39PmTYnF0fUEzeHL1q
   KdT1HkxKdf6paIRg8xpjPi/IgBWGwqjNOrnHOED0uwJXV/KW/DIOEFgkO
   g==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="171654032"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 12:52:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 12:52:25 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 8 Jul 2022 12:52:23 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <kavyasree.kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>, <colin.foster@in-advantage.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        <michael@walle.cc>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 2/2] pinctrl: ocelot: Fix pincfg
Date:   Fri, 8 Jul 2022 21:55:10 +0200
Message-ID: <20220708195510.2951661-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220708195510.2951661-1-horatiu.vultur@microchip.com>
References: <20220708195510.2951661-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blamed commit changed to use regmaps instead of __iomem. But it
didn't update the register offsets to be at word offset, so it uses byte
offset.
Another issue with the same commit is that it a limit of 32 registers
which is incorrect. The sparx5 has 64 while lan966x has 77.

Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 10787056c5c7..d88d6af71e46 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1334,7 +1334,9 @@ static int ocelot_hw_get_value(struct ocelot_pinctrl *info,
 	if (info->pincfg) {
 		u32 regcfg;
 
-		ret = regmap_read(info->pincfg, pin, &regcfg);
+		ret = regmap_read(info->pincfg,
+				  pin * regmap_get_reg_stride(info->pincfg),
+				  &regcfg);
 		if (ret)
 			return ret;
 
@@ -1368,14 +1370,18 @@ static int ocelot_pincfg_clrsetbits(struct ocelot_pinctrl *info, u32 regaddr,
 	u32 val;
 	int ret;
 
-	ret = regmap_read(info->pincfg, regaddr, &val);
+	ret = regmap_read(info->pincfg,
+			  regaddr * regmap_get_reg_stride(info->pincfg),
+			  &val);
 	if (ret)
 		return ret;
 
 	val &= ~clrbits;
 	val |= setbits;
 
-	ret = regmap_write(info->pincfg, regaddr, val);
+	ret = regmap_write(info->pincfg,
+			   regaddr * regmap_get_reg_stride(info->pincfg),
+			   val);
 
 	return ret;
 }
@@ -1944,7 +1950,6 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
 		.reg_bits = 32,
 		.val_bits = 32,
 		.reg_stride = 4,
-		.max_register = 32,
 		.name = "pincfg",
 	};
 
-- 
2.33.0

