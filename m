Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2125957AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiHPKK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiHPKJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:09:40 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA112309F;
        Tue, 16 Aug 2022 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660638504; x=1692174504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FNHPX12Pit1WxIpHyPTouV10hppwOlS2zHdFi1vLKSQ=;
  b=anChMr3piLQwLFYGojdKtN7uUC+VQMcms+54NFx+LPI6TNxoxw+lYnsc
   rz+4LkSI+f46QlnTyIerS/UjDAbOS9d7NaHNDUh1rnjVUGDK+oQD+aDzD
   LnVv2IWrk75Ka09y8ETlYQc2HyfYQ6zlFmX/koDV+f1cqLp3XCC+OhOkL
   g=;
X-IronPort-AV: E=Sophos;i="5.93,240,1654560000"; 
   d="scan'208";a="1044708753"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-10222bbc.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 08:28:22 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-10222bbc.us-east-1.amazon.com (Postfix) with ESMTPS id 792FD1A17C2;
        Tue, 16 Aug 2022 08:28:20 +0000 (UTC)
Received: from EX19D013UWA002.ant.amazon.com (10.13.138.210) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 16 Aug 2022 08:28:00 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA002.ant.amazon.com (10.13.138.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 16 Aug 2022 08:27:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 16 Aug 2022 08:27:59
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 5E7E84C1C; Tue, 16 Aug 2022 08:27:57 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH 13/16] hwmon: (mr75203) add thermal coefficient properties for Moortec PVT controller
Date:   Tue, 16 Aug 2022 08:27:54 +0000
Message-ID: <20220816082757.11990-14-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220816082757.11990-1-farbere@amazon.com>
References: <20220816082757.11990-1-farbere@amazon.com>
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

