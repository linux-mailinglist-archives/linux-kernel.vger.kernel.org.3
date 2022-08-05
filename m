Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9D58A5A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 07:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiHEFbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 01:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbiHEFbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 01:31:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D323672ED5;
        Thu,  4 Aug 2022 22:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659677483; x=1691213483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vVDEwwIisrAGJAcixX8ELsyi9Q8IzHQ0ogkj1rP3Ut4=;
  b=mRcdKn2L48BUsGvzPtMWrBnMfB0jV+/let3hwoWI+OrdU08FPGYYrNvi
   tTlltyGL0Wo1MnZDjhX2WDYjllZamz4veQ5xQ0DEGh59phVm5MmyWkh9u
   pZK7swb8GpF0rGW7p3hD/xssxD3Lkl7+4PBsWhX8wXifHtrx0Fv4r5Ocq
   gD6vciwdezgL34MhtWTD08wC8YINJVFv3UN0a5Sq/FsjAZUzBzrca+YDf
   t1/lEKLIVnas0A6WgDmR9+thl4RaAuvQ270MQMn7dCGhZ3WiamZrU6YxP
   91Krsf0iw53UrjRkAzYHL6fa/Xok1/utRsRKL9j/z2roW8gnxFbwAqHl3
   g==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="107686271"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2022 22:31:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 4 Aug 2022 22:30:58 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 22:30:55 -0700
From:   Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor.dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <Valentina.FernandezAlanis@microchip.com>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: [PATCH v3 2/4] spi: dt-binding: add coreqspi as a fallback for mpfs-qspi
Date:   Fri, 5 Aug 2022 11:00:17 +0530
Message-ID: <20220805053019.996484-3-nagasuresh.relli@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip's PolarFire SoC QSPI IP core is based on coreQSPI,
so add coreqspi as a fallback to mpfs-qspi.

Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
---
 .../devicetree/bindings/spi/microchip,mpfs-spi.yaml    | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index a47d4923b51b..84d32c1a4d60 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -18,10 +18,12 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - microchip,mpfs-spi
-      - microchip,mpfs-qspi
-      - microchip,coreqspi-rtl-v2 # FPGA QSPI
+   oneOf:
+    - items:
+        - const: microchip,mpfs-qspi
+        - const: microchip,coreqspi-rtl-v2
+    - const: microchip,coreqspi-rtl-v2 #FPGA QSPI
+    - const: microchip,mpfs-spi
 
   reg:
     maxItems: 1
-- 
2.25.1

