Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569584CA9B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiCBPy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiCBPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:54:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421B249FB1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646236423; x=1677772423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qbujCBUUgtRWzXMjdt3ZZyu7YDdq0pA0BSSFCMRt2B4=;
  b=SptAXb2QSiMgSqOdrLD71UIqof7qp9AjfSwjH1DxgkAw/mernDOzxuXM
   2nhNfkC2jeiAxldCrJofHW5yo6GWwdKEqDpNiF2tcyr1Gt52rWEIRt/dQ
   uFNyhnkRT87Gbjr91VbV9xdoJuq+BmlUMS3njTD2W9Ko6QvoG3t82kNPm
   tt9xY0AaFbG0KMyv3eSpKO1SYquhSa+9EeMiBo4UF93SwbTjC3pYFeZ7E
   gMDMXyO71CZf49SAJEU9iAugZQCTdps4OM7wNBwV/3GyVNBvL4aA0FV9C
   xkA4/5eZ1e6oZAKtbEwg/HcBGPVnZMg/wn2IbG/sjKjCUUgsBZYFxuFoi
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,149,1643698800"; 
   d="scan'208";a="147819436"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2022 08:53:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 2 Mar 2022 08:53:41 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 2 Mar 2022 08:53:40 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] ARM: at91: add support in soc driver for new SAMA5D29
Date:   Wed, 2 Mar 2022 16:53:29 +0100
Message-ID: <20220302155329.27668-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
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

From: Mihai Sain <mihai.sain@microchip.com>

Add detection of new SAMA5D29 by the SoC driver.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/soc/atmel/soc.c | 3 +++
 drivers/soc/atmel/soc.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index a490ad7e090f..b2d365ae0282 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -156,6 +156,9 @@ static const struct at91_soc socs[] __initconst = {
 	AT91_SOC(SAMA5D2_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
 		 AT91_CIDR_VERSION_MASK, SAMA5D28C_LD2G_EXID_MATCH,
 		 "sama5d28c 256MiB LPDDR2 SiP", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAMA5D29CN_EXID_MATCH,
+		 "sama5d29", "sama5d2"),
 	AT91_SOC(SAMA5D3_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
 		 AT91_CIDR_VERSION_MASK, SAMA5D31_EXID_MATCH,
 		 "sama5d31", "sama5d3"),
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index c3eb3c8f0834..2ecaa75b00f0 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -95,6 +95,7 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAMA5D28C_LD2G_EXID_MATCH	0x00000072
 #define SAMA5D28CU_EXID_MATCH		0x00000010
 #define SAMA5D28CN_EXID_MATCH		0x00000020
+#define SAMA5D29CN_EXID_MATCH		0x00000023
 
 #define SAMA5D3_CIDR_MATCH		0x0a5c07c0
 #define SAMA5D31_EXID_MATCH		0x00444300
-- 
2.32.0

