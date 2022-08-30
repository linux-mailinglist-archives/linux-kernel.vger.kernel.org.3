Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B045E5A6D43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiH3TYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiH3TYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:24:07 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2297C311;
        Tue, 30 Aug 2022 12:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661887395; x=1693423395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=843kBT2eo8fZBeKaiWYGVSNFPK3qHfLWFvr35ISO3DM=;
  b=PzXUUC855NsrLuKCVsCDt7/2niPV73pc3cYtCcjO6ol2LCPxRmtBGosN
   h1vnM9hV1pBcRcMWlRfNYmrTAmBdHQ/7iexPCNYxqy07DEp1OcxyiAVlM
   M/fPymgcbjdIK4nk6MWSeFTpiiY9BwUnDP5zVsSIVv6vN+A4/Q48Jog+s
   E=;
X-IronPort-AV: E=Sophos;i="5.93,275,1654560000"; 
   d="scan'208";a="222136157"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-7dac3c4d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 19:22:41 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-7dac3c4d.us-east-1.amazon.com (Postfix) with ESMTPS id 84690819D8;
        Tue, 30 Aug 2022 19:22:38 +0000 (UTC)
Received: from EX19D013UWA001.ant.amazon.com (10.13.138.253) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 30 Aug 2022 19:22:15 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWA001.ant.amazon.com (10.13.138.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 30 Aug 2022 19:22:14 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 30 Aug 2022 19:22:14
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 634754D4E; Tue, 30 Aug 2022 19:22:12 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dkl@amazon.com>,
        <rahul.tanwar@linux.intel.com>, <andriy.shevchenko@intel.com>
Subject: [PATCH v3 16/19] dt-bindings: hwmon: (mr75203) add coefficient properties for the thermal equation
Date:   Tue, 30 Aug 2022 19:22:09 +0000
Message-ID: <20220830192212.28570-17-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830192212.28570-1-farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
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
V3 -> V2:
- Add "moortec" prefix to property name.

 .../bindings/hwmon/moortec,mr75203.yaml       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
index ec2dbe7da9c2..a92da6064285 100644
--- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -74,6 +74,37 @@ properties:
     default: 5
     $ref: /schemas/types.yaml#definitions/uint32
 
+  moortec,ts-coeff-g:
+    description:
+      G coefficient for temperature equation.
+      Value should be multiplied by factor 1000.
+      Default for series 5 = 60000
+      Default for series 6 = 57400
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  moortec,ts-coeff-h:
+    description:
+      H coefficient for temperature equation.
+      Value should be multiplied by factor 1000.
+      Default for series 5 = 200000
+      Default for series 6 = 249400
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  moortec,ts-coeff-cal5:
+    description:
+      cal5 coefficient for temperature equation (can't be 0).
+      Default for series 5 = 4094
+      Default for series 6 = 4096
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  moortec,ts-coeff-j:
+    description:
+      J coefficient for temperature equation.
+      Value should be multiplied by factor 1000.
+      Default for series 5 = -100
+      Default for series 6 = 0
+    $ref: /schemas/types.yaml#/definitions/int32
+
 required:
   - compatible
   - reg
@@ -97,5 +128,7 @@ examples:
         resets = <&rcu0 0x40 7>;
         moortec,vm-active-channels = <0x10 0x05>;
         moortec,vm-pre-scaler = <5 6>;
+        moortec,ts-coeff-g = <61400>;
+        moortec,ts-coeff-h = <253700>;
         #thermal-sensor-cells = <1>;
     };
-- 
2.37.1

