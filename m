Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9C5B22A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIHPmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHPmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:42:21 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB3896FD6;
        Thu,  8 Sep 2022 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662651741; x=1694187741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VJrsP7eBiwsZa3h633BnaRorI22wsccpINaTQxBud9U=;
  b=kHRvfq1ABBQJ++2K0WkJDRaJa4J+vwUkgqFzATlMJvPs/YJS0wyZD7XQ
   +b5Bn8sjv8uHrIeLNRkAWNdYPDEwfr/3cy+vO/ZMOWekwhygij7u62GXe
   yA2+EH3cOJTpcIlej7sPVeKL6qzUpqLTt77VLnH4mHfN0jgkcWJcT2SX1
   U=;
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="128112171"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:25:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com (Postfix) with ESMTPS id 9AAE1C0974;
        Thu,  8 Sep 2022 15:25:09 +0000 (UTC)
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 15:24:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 8 Sep 2022 15:24:52 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 8 Sep 2022 15:24:52 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 86F504D85; Thu,  8 Sep 2022 15:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>
Subject: [PATCH v5 18/21] dt-bindings: hwmon: (mr75203) add coefficient properties for the thermal equation
Date:   Thu, 8 Sep 2022 15:24:46 +0000
Message-ID: <20220908152449.35457-19-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908152449.35457-1-farbere@amazon.com>
References: <20220908152449.35457-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
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
index df849517464e..d0d549749208 100644
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

