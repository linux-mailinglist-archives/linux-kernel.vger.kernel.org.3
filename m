Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E9648D9FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbiAMOsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:48:03 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:19844 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiAMOsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642085281; x=1673621281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cn32FVsFXj7kfAuzJ2kdL23yH/APr88N4Syy5Ekn8OM=;
  b=zZRlmmwYzMH00kshQxD9Tb5uPnMV3qN92552dOqPr4ehw/mCzdg6I4j2
   rFgyCyE4o2T/HH2orVEARIdO33m4Bdb+wuE/XZvenDkpeBkBMZoSPAsI5
   g95Oj6Wbw3oLzU2qgAUMl2euCJgmJRvq/CcSRDNr1Nz8iCSlzBGKfwo72
   27wUehWQPTRKQgSJ2Rj4TGFQ5xP+QeRF/0Cg1zY8ZKQEKYHn3QvAZ1PQV
   kaZxxIHFFjxIR7yAzJrVaE44x+8ppKPY551Z78ojbQUC+0OIDRAZ0uW+9
   el6Av4neyJluM8ltvEaoz+BtO/dnmw2GyxNtRn5qVj/cc/nJ4Je08Mvo7
   w==;
IronPort-SDR: fhquOLUgqGAvIcJkV2498oPQ6QQ7zP3v7mekOLklhyq1LekwwggcAVs0+xjrfgZ6mukC52xtSf
 vSLQ5bY0A6mJnx7mcyHhrSTUllwlY1EYJJZ6FjHLyNEJCT1EBcv2/uSgX8RVBGO/dgdGeDXX96
 nHws1Rz7K0Ysj32+GLRHD7HkFOt08poGmDqCct+cmnyf+CcHaqL33a9jzcykTAiNm7uPsumKCQ
 EVplH+y2VqRHIWP8I0LsGMorosP3wJbF/FasQZ306vOxfG0EfYnMrJ7OXpNdSmC+5uVGNBxnsJ
 bJZhRVV61vMUFPcucJ2E8tPq
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="150108166"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2022 07:47:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 07:47:58 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 13 Jan 2022 07:47:55 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 01/10] ARM: at91: ddr: remove CONFIG_SOC_SAMA7 dependency
Date:   Thu, 13 Jan 2022 16:48:51 +0200
Message-ID: <20220113144900.906370-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220113144900.906370-1-claudiu.beznea@microchip.com>
References: <20220113144900.906370-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_SOC_SAMA7 dependency to avoid having #ifdef preprocessor
directives in driver code (arch/arm/mach-at91/pm.c). This prepares the
code for next commits.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/soc/at91/sama7-ddr.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/soc/at91/sama7-ddr.h b/include/soc/at91/sama7-ddr.h
index f6542584ca13..13b47e26cdbe 100644
--- a/include/soc/at91/sama7-ddr.h
+++ b/include/soc/at91/sama7-ddr.h
@@ -11,8 +11,6 @@
 #ifndef __SAMA7_DDR_H__
 #define __SAMA7_DDR_H__
 
-#ifdef CONFIG_SOC_SAMA7
-
 /* DDR3PHY */
 #define DDR3PHY_PIR				(0x04)		/* DDR3PHY PHY Initialization Register	*/
 #define	DDR3PHY_PIR_DLLBYP		(1 << 17)	/* DLL Bypass */
@@ -75,6 +73,4 @@
 #define UDDRC_PCTRL_3				(0x6A0)		/* UDDRC Port 3 Control Register */
 #define UDDRC_PCTRL_4				(0x750)		/* UDDRC Port 4 Control Register */
 
-#endif /* CONFIG_SOC_SAMA7 */
-
 #endif /* __SAMA7_DDR_H__ */
-- 
2.32.0

