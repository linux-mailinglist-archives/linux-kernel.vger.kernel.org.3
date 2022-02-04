Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1CD4A94EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345815AbiBDIOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:14:55 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:60781 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiBDIOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643962494; x=1675498494;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d9f3GFkaKFB71YVcwc4XieUwMuyJ6sEOuUQW3CWdTsY=;
  b=Y4iX4FlCfGwX6lM01rreSOfTJQsZkZzhkDdUzzlaa1Su4jtqzTF9VLrp
   ZylMj6OHY1R4b1YsGwYdeVi/rMprnDDtj5qfdquBBv5AcJRiyx3dckfO9
   VQjqhaFIRR8mRhY3F6uxIk1FHy1Ko9Uun3gURYqRX+FZuFiO8EMo1AlmS
   lfU/ccFBAOrThiYUwZ93R6dYa4PKCb2m5vVpy9CHmPkSPqc/GyRU7Y4a/
   Z4G2xotlP0wrkVDkDMEpPRGB+lG+WsARqb5g0FWZLgJh4+OCz4+DgEyCX
   8CI8xCLt9IPGdLyrWKhi8Ww1VjILEx14ctu0O8k+1AYk7W5L2fP4RPVUN
   Q==;
IronPort-SDR: GY4B3ulM2gPzlDTNldA/PEsAwu00SO9kPEyw2pAi0IMKXEoVtq+w1S4c6BREiZUWPQqvNLY+UR
 /95E/MdAyxnJxrWQoFWz6ELIMd8t1xSUUgEsD5/v//ti4zzJBXyWnB93raJ2gB6VX1kJGiZMPz
 QVIjJEwIMm7v4wQzHFJNEuXLg9nmaTsCFV5rB6n27tsKpb/VPNxircGlcHaVcZM9KbAMSBwDbK
 edxEiQEj6IZdPsB4KtE0OZQQrOt+HBE2/HdXrQ89rv5ya66kcp2Iyb5jwen+A/XO+/yEraQBhA
 JII1iB/zoqdRzNX3WLvXnfmi
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="147621812"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2022 01:14:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Feb 2022 01:14:52 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Feb 2022 01:14:50 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <clement.leger@bootlin.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] dt-bindings: microchip: atmel,at91rm9200-tcb: remove mandatory interrupts property
Date:   Fri, 4 Feb 2022 10:14:46 +0200
Message-ID: <20220204081446.474991-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer block can be used only to be read and to measure time in a polling
fashion. This can be used by Linux like this for example, or it can be used
by different projects which do not have interrupt controllers, or do not
wish to enable them (e.g. U-boot).
As DT is ABI, the binding should relate to all possible use cases and describe
the hardware and the requirements.
The interrupt is not a hard requirement for the timer to function in a
specific way.
Thus, choose to remove the interrupts property from the mandatory list of
properties.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 .../devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml  | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
index 597d67fba92f..27f78459b892 100644
--- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
@@ -134,7 +134,6 @@ allOf:
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
   - clock-names
   - '#address-cells'
-- 
2.25.1

