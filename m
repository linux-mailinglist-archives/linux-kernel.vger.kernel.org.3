Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA855AE2DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239319AbiIFIfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbiIFIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:34:51 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3782C38449;
        Tue,  6 Sep 2022 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662453291; x=1693989291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dnkseYOVS2+62yTSvl1N8YJytSzjRQ7C8g339XuXXHM=;
  b=VbDhiNSm5ryJxGp5zwA3CH5wOG6YoStDxQglbcLocfhv6Ys3/5W74ZIn
   F+RaQKBjTbG52CxeQfZ7o6R13p4JSGfkKeZTxAvSI27D3I0U1/9yDi66v
   fEiyQlVIpDrIcFhuYFJagbdnyRBHHVUrMoDidqrn4FzA/vNZm6xik8kgG
   A=;
X-IronPort-AV: E=Sophos;i="5.93,293,1654560000"; 
   d="scan'208";a="237979500"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-7dac3c4d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:34:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-7dac3c4d.us-east-1.amazon.com (Postfix) with ESMTPS id DF4A7818CF;
        Tue,  6 Sep 2022 08:34:35 +0000 (UTC)
Received: from EX19D013UWA003.ant.amazon.com (10.13.138.202) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 6 Sep 2022 08:33:59 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D013UWA003.ant.amazon.com (10.13.138.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 6 Sep 2022 08:33:58 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 6 Sep 2022 08:33:57 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id C5E144AD5; Tue,  6 Sep 2022 08:33:57 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 19/21] dt-bindings: hwmon: (mr75203) add coefficient properties for the thermal equation
Date:   Tue, 6 Sep 2022 08:33:54 +0000
Message-ID: <20220906083356.21067-20-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906083356.21067-1-farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional temperature coefficient properties:
 *) moortec,ts-coeff-g
 *) moortec,ts-coeff-h
 *) moortec,ts-coeff-cal5
 *) moortec,ts-coeff-j
If defined they shall be used instead of defaults.

The coefficients were added to device tree on top of the series property
(which can be used to select between series 5 and series 6), because
coefficients can vary between product and product, and code defaults might
not be accurate enough.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V4 -> V3:
- Add 'multipleOf: 1000' instead of plain text.
- Add minimum/maximum for some of the new properties.

V3 -> V2:
- Add "moortec" prefix to property name.

 .../bindings/hwmon/moortec,mr75203.yaml       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
index 28656e9d9059..5e3d060290a9 100644
--- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -100,6 +100,41 @@ properties:
     default: 5
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  moortec,ts-coeff-g:
+    description:
+      G coefficient for temperature equation.
+      Default for series 5 = 60000
+      Default for series 6 = 57400
+    multipleOf: 1000
+    minimum: 1000
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  moortec,ts-coeff-h:
+    description:
+      H coefficient for temperature equation.
+      Default for series 5 = 200000
+      Default for series 6 = 249400
+    multipleOf: 1000
+    minimum: 1000
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  moortec,ts-coeff-cal5:
+    description:
+      cal5 coefficient for temperature equation.
+      Default for series 5 = 4094
+      Default for series 6 = 4096
+    minimum: 1
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  moortec,ts-coeff-j:
+    description:
+      J coefficient for temperature equation.
+      Default for series 5 = -100
+      Default for series 6 = 0
+    multipleOf: 1000
+    maximum: 0
+    $ref: /schemas/types.yaml#/definitions/int32
+
 required:
   - compatible
   - reg
@@ -123,5 +158,7 @@ examples:
         resets = <&rcu0 0x40 7>;
         moortec,vm-active-channels = /bits/ 8 <0x10 0x05>;
         moortec,vm-pre-scaler-x2 = /bits/ 8 <5 6 20>;
+        moortec,ts-coeff-g = <61400>;
+        moortec,ts-coeff-h = <253700>;
         #thermal-sensor-cells = <1>;
     };
-- 
2.37.1

