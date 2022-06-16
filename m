Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C2854DC95
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359644AbiFPILU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359374AbiFPILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:11:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D3B5D5D7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655367079; x=1686903079;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jRcuF1uDD/XW4iPGapQV10Uvq9i/CiZCx2xNmbcpmls=;
  b=Op9eT/Tol0mBjIS1lK/Ri5Imp7I4kte5Mqwrqr/G6xv5LbvrkBsZfFaD
   3oSTJN8W3NXFnRtSwu6i8H+egvAfNdW+WDFXRL1u1sm3eK0CkK0DXypHU
   fe6Yz7xA+rvKe8b8AKjgwbam989HaJ+p1u7UW4gyjFMTYsgtBn5mKzzVF
   rMO9qZodmot5G2pxtCtRzFv0DX1oaer0CqwFQpniceWyUAWhEUTA+za4v
   qieVyGxypqyu243C2eksvLuJRCTz5Hu+Et8aRtFSW25d8C8Vk69yMZeL4
   4wGATW0cxv5V53m3Zdcn92kp00yT6q0oK2TsM59vBcsCoBq9MsbKxHycl
   w==;
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="160592810"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2022 01:11:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Jun 2022 01:11:17 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Jun 2022 01:11:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mihai.sain@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: at91: fix soc detection for SAM9X60 SiPs
Date:   Thu, 16 Jun 2022 11:13:44 +0300
Message-ID: <20220616081344.1978664-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mihai Sain <mihai.sain@microchip.com>

Fix SoC detection for SAM9X60 SiPs:
SAM9X60D5M
SAM9X60D1G
SAM9X60D6K

Fixes: af3a10513cd6 ("drivers: soc: atmel: add per soc id and version match masks")
Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/soc/atmel/soc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index b2d365ae0282..dae8a2e0f745 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -91,14 +91,14 @@ static const struct at91_soc socs[] __initconst = {
 	AT91_SOC(SAM9X60_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
 		 AT91_CIDR_VERSION_MASK, SAM9X60_EXID_MATCH,
 		 "sam9x60", "sam9x60"),
-	AT91_SOC(SAM9X60_CIDR_MATCH, SAM9X60_D5M_EXID_MATCH,
-		 AT91_CIDR_VERSION_MASK, SAM9X60_EXID_MATCH,
+	AT91_SOC(SAM9X60_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X60_D5M_EXID_MATCH,
 		 "sam9x60 64MiB DDR2 SiP", "sam9x60"),
-	AT91_SOC(SAM9X60_CIDR_MATCH, SAM9X60_D1G_EXID_MATCH,
-		 AT91_CIDR_VERSION_MASK, SAM9X60_EXID_MATCH,
+	AT91_SOC(SAM9X60_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X60_D1G_EXID_MATCH,
 		 "sam9x60 128MiB DDR2 SiP", "sam9x60"),
-	AT91_SOC(SAM9X60_CIDR_MATCH, SAM9X60_D6K_EXID_MATCH,
-		 AT91_CIDR_VERSION_MASK, SAM9X60_EXID_MATCH,
+	AT91_SOC(SAM9X60_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X60_D6K_EXID_MATCH,
 		 "sam9x60 8MiB SDRAM SiP", "sam9x60"),
 #endif
 #ifdef CONFIG_SOC_SAMA5
-- 
2.34.1

