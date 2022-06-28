Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE155E7BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348096AbiF1PPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347400AbiF1POu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:14:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92312E0A9;
        Tue, 28 Jun 2022 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429281; x=1687965281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgGvk89Bc+42ZUiXvrFHgLkYiCceXITtHh8Rf1Vwam0=;
  b=QaCFKa5V0LRgGfcLDVlcHN801qop42E1nakRxRx8Sy8S+EMW8alF98Ws
   GzOCEFDRM5zrb13K95mt3JIhbvU7bgLx8PJ2l9v/KtnFUxzUFjoROadVZ
   NN/CeklqAdyVxXbBdQyFnsMyA49rQ2wt+ILWeLxKiTH/SIQK/helUesc1
   gwr/Tq2jD+Jrwm3znnmEavrg7IK8/7D/G2m2dALD0mzcYCD5AdaZ4qtfn
   LZW8Nc0AM//B9EIK87VrAEDWJnntM9l3J2SjgRejgQTn7s61eiibckTQ9
   K1VQpXgAkfMWYok7+lttVJAm1z1c0ZdGlfj7Sb2Qu1s1tTQIgUtaFBCac
   g==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="162420824"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:14:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:14:15 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:14:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 01/19] iio: adc: at91-sama5d2_adc: fix AT91_SAMA5D2_MR_TRACKTIM_MAX
Date:   Tue, 28 Jun 2022 18:16:13 +0300
Message-ID: <20220628151631.3116454-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All ADC HW versions handled by this driver (SAMA5D2, SAM9X60, SAMA7G5)
have MR.TRACKTIM on 4 bits. Fix AT91_SAMA5D2_MR_TRACKTIM_MAX to reflect
this.

Fixes: 27e177190891 ("iio:adc:at91_adc8xx: introduce new atmel adc driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index b764823ce57e..32b6f157b803 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -77,7 +77,7 @@ struct at91_adc_reg_layout {
 #define	AT91_SAMA5D2_MR_ANACH		BIT(23)
 /* Tracking Time */
 #define	AT91_SAMA5D2_MR_TRACKTIM(v)	((v) << 24)
-#define	AT91_SAMA5D2_MR_TRACKTIM_MAX	0xff
+#define	AT91_SAMA5D2_MR_TRACKTIM_MAX	0xf
 /* Transfer Time */
 #define	AT91_SAMA5D2_MR_TRANSFER(v)	((v) << 28)
 #define	AT91_SAMA5D2_MR_TRANSFER_MAX	0x3
-- 
2.34.1

