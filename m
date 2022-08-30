Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31A25A6D31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiH3TX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH3TXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:23:01 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958FA7A77F;
        Tue, 30 Aug 2022 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661887364; x=1693423364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H+Q3pIefoo5VmiPth3Y5fvRbYEtr+wi/MT5kM6bWw7A=;
  b=X3tSpAP9FxpZQZgw4vzh5D+bINAzfC3DY5lejeJVFsiZqzvfIKlWI/fZ
   a4Teuu+ChvoDOHQ/X5nzyNCPCUQbe6fDrPA0tg3S81zGKID+pLqqp7G27
   g+6hjcbZt8iw+duMe5QIhvY8ZcDt4+yL+2TTGw3F/bfLW7dSkBnNp5Q3K
   o=;
X-IronPort-AV: E=Sophos;i="5.93,275,1654560000"; 
   d="scan'208";a="125055935"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-8be8ed69.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 19:22:42 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-8be8ed69.us-east-1.amazon.com (Postfix) with ESMTPS id C81DCC084B;
        Tue, 30 Aug 2022 19:22:38 +0000 (UTC)
Received: from EX19D013UWA003.ant.amazon.com (10.13.138.202) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 30 Aug 2022 19:22:15 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA003.ant.amazon.com (10.13.138.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 30 Aug 2022 19:22:15 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 30 Aug 2022 19:22:15
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 666674D3E; Tue, 30 Aug 2022 19:22:12 +0000 (UTC)
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
Subject: [PATCH v3 08/19] dt-bindings: hwmon: (mr75203) add "moortec,vm-active-channels" property
Date:   Tue, 30 Aug 2022 19:22:01 +0000
Message-ID: <20220830192212.28570-9-farbere@amazon.com>
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

Add optional "moortec,vm-active-channels" property to define the number
of active channels per VM.

This shall be useful to avoid exposing sysfs for reading inputs that are
not connected to any voltage source.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V3 -> V2:
- Add "moortec" prefix to property name.
- Add explanation why this change is needed.

 .../devicetree/bindings/hwmon/moortec,mr75203.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
index 2ec4b9da4b92..69cc6caceb2c 100644
--- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -44,6 +44,16 @@ properties:
   "#thermal-sensor-cells":
     const: 1
 
+  moortec,vm-active-channels:
+    description:
+      moortec,vm-active-channels defines the number of channels per VM that are
+      actually used and are connected to some source.
+      Number of values in the array should be the number of VMs.
+      A value of 0 means that the entire VM sensor is nou used.
+    maximum: 16
+    default: 16
+    $ref: /schemas/types.yaml#definitions/uint8-array
+
 required:
   - compatible
   - reg
@@ -65,5 +75,6 @@ examples:
         intel,vm-map = [03 01 04 ff ff];
         clocks = <&osc0>;
         resets = <&rcu0 0x40 7>;
+        moortec,vm-active-channels = <0x10 0x05>;
         #thermal-sensor-cells = <1>;
     };
-- 
2.37.1

