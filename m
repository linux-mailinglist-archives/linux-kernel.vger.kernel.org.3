Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDA54BF754
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiBVLkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiBVLkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:40:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6037136ED8;
        Tue, 22 Feb 2022 03:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645529974; x=1677065974;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=wXHTBZ92PZCysruxwhPT9aZU/PmkGIz0L/maxcsvFX8=;
  b=SAub0H04ZN7g+mZ/EHofGuO3BFo/gfsZ2plSy0VNVIMuGbnG/3zYWPpj
   p3iS4CF9x78HLc/nnDYOKYIMVYFaw6SZdner9/RquedTDfuEH19rPnrDh
   VA3dMWmSTfw34ouzyX1bojXaFpnwXLF70uKijgE0nj1rnu8NiuQme7DeI
   /winZuWCcdzyq+3DEOor/kwRU1mVkbwjl8+in/6lwhmAbVZnQ15yiG5tu
   N4JlQ3iROt/wQsuxFYSHyjuKogv1nIKuYpoaPrn7DCC/7y6ShJ/+rbt6h
   E8tVLBOxK50RzbwBwd3roJ3jeWR5Em00hGbBNIrZ0x1kWdG5NJkHkJa8h
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="149554549"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2022 04:39:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 22 Feb 2022 04:39:33 -0700
Received: from hari-laptop.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 22 Feb 2022 04:39:28 -0700
From:   Hari Prasath <Hari.PrasathGE@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <davem@davemloft.net>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>
CC:     <Hari.PrasathGE@microchip.com>
Subject: [PATCH] 1/3] ARM: dts: at91: sama7g5: Restrict ns_sram
Date:   Tue, 22 Feb 2022 17:09:22 +0530
Message-ID: <20220222113924.25799-1-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limit the size of SRAM available for the rest of kernel via genalloc API's to
13k. The rest of the SRAM is used by CAN controllers and hence this restriction.

Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index eddcfbf4d223..6c7012f74b10 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -65,7 +65,7 @@
 		compatible = "mmio-sram";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x100000 0x20000>;
+		reg = <0x100000 0x3400>;
 		ranges;
 	};
 
-- 
2.17.1

