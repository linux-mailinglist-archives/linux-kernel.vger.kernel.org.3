Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8438B5968F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiHQFpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238635AbiHQFoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:44:17 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18D7CB6E;
        Tue, 16 Aug 2022 22:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660715041; x=1692251041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FNHPX12Pit1WxIpHyPTouV10hppwOlS2zHdFi1vLKSQ=;
  b=VmJoJFgdIwLTO0zuOSjjU/SchKcGjg5HpTrReGeAvLxcdsg8xF3Voxbu
   u9cIxem2AwCpr71rj62GIfNliIXV+htc0ASZFYlJVDQwRFba7rAZe97qY
   PKMb5Sk+KAol/T0/F2qV3vBUgsbjMsHAAErprWsTFgzyvSUT6TRsk1phR
   s=;
X-IronPort-AV: E=Sophos;i="5.93,242,1654560000"; 
   d="scan'208";a="120136327"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-5feb294a.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:43:39 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-5feb294a.us-west-2.amazon.com (Postfix) with ESMTPS id 73EAE835D8;
        Wed, 17 Aug 2022 05:43:38 +0000 (UTC)
Received: from EX13D08UEE002.ant.amazon.com (10.43.62.92) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:22 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D08UEE002.ant.amazon.com (10.43.62.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:22 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 17 Aug 2022 05:43:22
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 948004C90; Wed, 17 Aug 2022 05:43:21 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH v2 13/16] hwmon: (mr75203) add thermal coefficient properties for Moortec PVT controller
Date:   Wed, 17 Aug 2022 05:43:18 +0000
Message-ID: <20220817054321.6519-14-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817054321.6519-1-farbere@amazon.com>
References: <20220817054321.6519-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional "ts-coeff-g", "ts-coeff-h", "ts-coeff-cal5" and
"ts-coeff-j" properties to be used instead of defaults for the
thermal equasion.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 .../bindings/hwmon/moortec,mr75203.yaml       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
index e2a55001eefc..867664bd937f 100644
--- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -62,6 +62,30 @@ properties:
       used to normalzie the voltage output results.
     $ref: /schemas/types.yaml#definitions/uint32
 
+  ts-coeff-g:
+    description:
+      G coefficient for thermal equation.
+    maxItems: 1
+    $ref: /schemas/types.yaml#definitions/uint32
+
+  ts-coeff-h:
+    description:
+      H coefficient for thermal equation.
+    maxItems: 1
+    $ref: /schemas/types.yaml#definitions/uint32
+
+  ts-coeff-cal5:
+    description:
+      cal5 coefficient for thermal equation (can't be 0).
+    maxItems: 1
+    $ref: /schemas/types.yaml#definitions/uint32
+
+  ts-coeff-j:
+    description:
+      J coefficient for thermal equation.
+    maxItems: 1
+    $ref: /schemas/types.yaml#definitions/int32
+
 required:
   - compatible
   - reg
@@ -75,6 +99,10 @@ additionalProperties:
   - reset-control-skip
   - vm-active-channels
   - vm-pre-scalar-ch#
+  - ts-coeff-g
+  - ts-coeff-h
+  - ts-coeff-cal5
+  - ts-coeff-j
 
 examples:
   - |
@@ -90,5 +118,10 @@ examples:
         resets = <&rcu0 0x40 7>;
         vm-active-channels = [08 10 02];
         vm-pre-scalar-ch5 = <2>;
+        ts-coeff-g = <57400>;
+        ts-coeff-h = <249400>;
+        ts-coeff-cal5 = <4096>;
+        ts-coeff-j = <0>;
+
         #thermal-sensor-cells = <1>;
     };
-- 
2.37.1

