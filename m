Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B897A5AE2DB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiIFIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbiIFIfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:35:01 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A647169F7E;
        Tue,  6 Sep 2022 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662453299; x=1693989299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s1EK0oUudRQ1hUnUB5MnNWs/t3MkWH0czu1v7nps9BY=;
  b=oE3c8mOXvYoo37Sj9iK2J0nHSTe3lzCcKtRo7b9Z98CbLmnUEUr68tYk
   S6GU7ijyhFTTAt+iezQ15tXeaMulmO7XvuOYm8CmADtP6fc4y08DSZvfD
   qX+Kk2WA3wiH0ncFgoaIO5B4L2We6V4jDU5iDGv5ffCBuaj4MsVumzT/g
   w=;
X-IronPort-AV: E=Sophos;i="5.93,293,1654560000"; 
   d="scan'208";a="256505583"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-0bfdb89e.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:34:39 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-0bfdb89e.us-east-1.amazon.com (Postfix) with ESMTPS id 5A8D9E0E6A;
        Tue,  6 Sep 2022 08:34:38 +0000 (UTC)
Received: from EX19D013UWB004.ant.amazon.com (10.13.138.62) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 6 Sep 2022 08:34:00 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D013UWB004.ant.amazon.com (10.13.138.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Tue, 6 Sep 2022 08:34:00 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 6 Sep 2022 08:33:59 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id CDD054D7B; Tue,  6 Sep 2022 08:33:57 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 12/21] dt-bindings: hwmon: (mr75203) add "moortec,vm-active-channels" property
Date:   Tue, 6 Sep 2022 08:33:47 +0000
Message-ID: <20220906083356.21067-13-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906083356.21067-1-farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
V4 -> V3:
- Fix DT checker errors.

V3 -> V2:
- Add "moortec" prefix to property name.
- Add explanation why this change is needed.

 .../devicetree/bindings/hwmon/moortec,mr75203.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
index 9454576ebb73..2aa4c3618596 100644
--- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -70,6 +70,15 @@ properties:
   "#thermal-sensor-cells":
     const: 1
 
+  moortec,vm-active-channels:
+    description:
+      Defines the number of channels per VM that are actually used and are
+      connected to some input source.
+      Maximum number of items - number of VMs.
+      Maximum value of each item - number of channels.
+      Minimum value of each item - 0 (which means entire VM sensor is nou used).
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+
 required:
   - compatible
   - reg
@@ -91,5 +100,6 @@ examples:
         intel,vm-map = [03 01 04 ff ff];
         clocks = <&osc0>;
         resets = <&rcu0 0x40 7>;
+        moortec,vm-active-channels = /bits/ 8 <0x10 0x05>;
         #thermal-sensor-cells = <1>;
     };
-- 
2.37.1

