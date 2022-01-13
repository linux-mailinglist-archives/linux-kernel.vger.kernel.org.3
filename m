Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E919F48DA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiAMOsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:48:18 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:19880 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiAMOsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642085294; x=1673621294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qzxL53+xCwUlzzE+c5h3xp0iY0GwHksZEGL+kIYmI/c=;
  b=tlJt+YYE5Nto4VakTfacNyrIfIR1bZMpO9bEG11al8bShyEOMY/YL2IJ
   Kb6P94o4Jwsx4Vjqylbk0Ngpt/hn92age4Xzr6g3kooYc7953lRgDYr5b
   1EKFeLhTqzEPvWP1iKo/a7/oAXaFfp7V1pdeVBClOKK05iK81167APFz6
   JYoL3tY5n4QljfAuSWE1+uSDlLELD0O7aRegqd5svqYiwUi2+WuLCHFgn
   BnIlSYVyQGC2cLM8kP3g3YB/TEPBhbNzEffzT8DYS1FcwxOTIn8NFund4
   KWUV5/ZwaXC0o8leE8ZA8D5YEidt7KruTzwUtYhbYjXwVz7ZKnA/NnUi5
   A==;
IronPort-SDR: BPtLW3vol1O10wBtDTdU/osMfjW67K7iAB5k1pKez50+5jPucwUS0EZrWSckGbBNjqy/jFfq2N
 2j5GaDyRCRyD9xRGlOvi+B4s1AHd3vERmEq+eS0mcZLGO+9SfkS6z5cKlAqwOGTjEDvsFAZ+AG
 P6d6gaoG9thkSHQXVo/NSWpvtiVEhoYt/CAC5xAKkwbvuZtFYK7szGF36s+AHrfOXu2C8IXgnc
 XUS5bnGaasttb+DJb+JMqoCnmupYmd94ZUDW8ufY1xW2d1WSX6Zp3wLGmmL/SrIpuxju90tKPk
 vrpC7eLj1FSanHBjxIuvEtV2
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="150108218"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2022 07:48:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 07:48:14 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 13 Jan 2022 07:48:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 06/10] ARM: dts: at91: fix low limit for CPU regulator
Date:   Thu, 13 Jan 2022 16:48:56 +0200
Message-ID: <20220113144900.906370-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220113144900.906370-1-claudiu.beznea@microchip.com>
References: <20220113144900.906370-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix low limit for CPU regulator. Otherwise setting voltages lower than
1.125V will not be allowed (CPUFreq will not be allowed to set proper
voltages on proper frequencies).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 0e1975c6812e..50f0fc3064cc 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -236,7 +236,7 @@ regulator-state-mem {
 
 				vddcpu: VDD_OTHER {
 					regulator-name = "VDD_OTHER";
-					regulator-min-microvolt = <1125000>;
+					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1850000>;
 					regulator-initial-mode = <2>;
 					regulator-allowed-modes = <2>, <4>;
-- 
2.32.0

