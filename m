Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7468B48ADF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbiAKMxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:53:18 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:50956 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiAKMxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641905597; x=1673441597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GPP2NwXKguVvQqgSRdC4tryu6NqbYiCAp/eYy5ky3f4=;
  b=kGDhSY0icPySHXB59YmTZBjjy9wBBvLk6U2ywfSWkBM+w1RNIBU/h3mR
   G54DROBJPl4XgH8fwC+bTyHR/65beRUJNzLDNR44QulDyZ29/LHrGjHi6
   xOkfQ7EYkodCdd6WH5rGqWiPBU772Ex7ANHb22eNV15gtVn1JsZRpRxDi
   kkVJRq5y4wsZh7uA7qr35/ueCw239OjUlsZucTQ5nl7+Yi2Ffi5hrNNtV
   6XZhprX4d0kZuh0GMxJ3M2BcBpMUBpTGEmaqoW+wdZwm+VNE85y/WikfA
   X4hsQV6u1e71AIiZTOPBRGVWT+5yDBimvP+UQKmI1uqlGnBzdV7gPZ0SL
   w==;
IronPort-SDR: SQxFJ4aFg5UtQOLBuS2YHAJgSeBvTIon2ycxzjn1Ukw+3k6NDK/SHZ2ezG+FPILV93VB5hZaOa
 aeQcYYtwjBgO8HC6act/hAipfDK8cuYRT8FBntQHcjQgpHniHVDzWxjERPr9G4sZMZlJKYpRdA
 gGHpSsOzgrKEIiPJYeMPDV0cudZwZuX7URF8VNaQrk93JNOoeLfHT5yAgoqcslyYI724Ppz2ZU
 mWyZJ0hV44QfoXAY0I7/tmW4VGSajhQkKXD1MTr8lK/KIN1Fh+DewaU8sBo+cGcJzPrpIdD48y
 xrAK+5zBwLTvif54I8Lap8F/
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="142326214"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2022 05:53:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 11 Jan 2022 05:53:16 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 11 Jan 2022 05:53:12 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <claudiu.beznea@microchip.com>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <rdunlap@infradead.org>, <unixbhaskar@gmail.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] clk: at91: sama7g5: Allow MCK1 to be exported and referenced in DT
Date:   Tue, 11 Jan 2022 14:53:10 +0200
Message-ID: <20220111125310.902856-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCK1 feeds the External Bus Interface (EBI). EBI's clock rate is used
to translate EBI's timmings to SMC timings, thus we need to handle MCK1
in the EBI driver. Allow MCK1 to be referenced as a PMC_TYPE_CORE clock
from phandle in DT.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/clk/at91/sama7g5.c       | 8 +++++++-
 include/dt-bindings/clock/at91.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 369dfafabbca..e43458673afb 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -302,6 +302,7 @@ static const struct {
  * @ep_count:		extra parents count
  * @ep_mux_table:	mux table for extra parents
  * @id:			clock id
+ * @eid:		export index in sama7g5->chws[] array
  * @c:			true if clock is critical and cannot be disabled
  */
 static const struct {
@@ -311,6 +312,7 @@ static const struct {
 	u8 ep_count;
 	u8 ep_mux_table[4];
 	u8 id;
+	u8 eid;
 	u8 c;
 } sama7g5_mckx[] = {
 	{ .n = "mck1",
@@ -319,6 +321,7 @@ static const struct {
 	  .ep_mux_table = { 5, },
 	  .ep_count = 1,
 	  .ep_chg_id = INT_MIN,
+	  .eid = PMC_MCK1,
 	  .c = 1, },
 
 	{ .n = "mck2",
@@ -913,7 +916,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	sama7g5_pmc = pmc_data_allocate(PMC_CPU + 1,
+	sama7g5_pmc = pmc_data_allocate(PMC_MCK1 + 1,
 					nck(sama7g5_systemck),
 					nck(sama7g5_periphck),
 					nck(sama7g5_gck), 8);
@@ -1027,6 +1030,9 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 			goto err_free;
 
 		alloc_mem[alloc_mem_size++] = mux_table;
+
+		if (sama7g5_mckx[i].eid)
+			sama7g5_pmc->chws[sama7g5_mckx[i].eid] = hw;
 	}
 
 	hw = at91_clk_sama7g5_register_utmi(regmap, "utmick", "main_xtal");
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index 98e1b2ab6403..8498c0cd95fe 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -35,6 +35,7 @@
 #define PMC_AUDIOIOPLL		(PMC_MAIN + 7)
 #define PMC_ETHPLL		(PMC_MAIN + 8)
 #define PMC_CPU			(PMC_MAIN + 9)
+#define PMC_MCK1		(PMC_MAIN + 10)
 
 #ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
-- 
2.25.1

