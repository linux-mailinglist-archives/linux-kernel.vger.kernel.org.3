Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596985A6D23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiH3TXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiH3TWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:22:37 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AA479A77;
        Tue, 30 Aug 2022 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661887355; x=1693423355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uZ5Kav3Eb8Y3l4mIN9Xlarp03YVDMTfsrhtTfsYkWOw=;
  b=lA4a/YtY5ndOijPL/rrcqb0ysn8KbF4lNbaIue1Jt1zVAqUymM8dzHRy
   y2l1DBqjq/GlO909cQIio8JDeTcUzK7Oapf0cqnL7Jb76xatB9ew7QVRc
   TKfpZKBgXKpWBjsoRBzEX9Rzj8mlK8YCO40PwwpTjvzuKQGYb+0c037Wu
   c=;
X-IronPort-AV: E=Sophos;i="5.93,275,1654560000"; 
   d="scan'208";a="1049654954"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 19:22:19 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com (Postfix) with ESMTPS id F09DE4531D;
        Tue, 30 Aug 2022 19:22:18 +0000 (UTC)
Received: from EX19D013UWB004.ant.amazon.com (10.13.138.62) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 30 Aug 2022 19:22:15 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB004.ant.amazon.com (10.13.138.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Tue, 30 Aug 2022 19:22:15 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 30 Aug 2022 19:22:15
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 69C594D40; Tue, 30 Aug 2022 19:22:12 +0000 (UTC)
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
Subject: [PATCH v3 10/19] dt-bindings: hwmon: (mr75203) add "moortec,vm-pre-scaler" property
Date:   Tue, 30 Aug 2022 19:22:03 +0000
Message-ID: <20220830192212.28570-11-farbere@amazon.com>
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

Add support for mr76006 pre-scaler which provides divide-by-2 scaling of
input voltage, which can then be presented for VM for measurement within
its range (the VM input range is limited to -0.1V to 1V).

The new "moortec,vm-pre-scaler" property lists the channels that use a
pre-scaler.

The driver will use this list to multiply the voltage result by 2, to
present to the user the actual voltage input source.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V3 -> V2:
- Add "moortec" prefix to property name.
- Change property format to be a single u8 array.
- Fix typo: scalar --> scaler.

 .../devicetree/bindings/hwmon/moortec,mr75203.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
index 69cc6caceb2c..4c983d8f8fe7 100644
--- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -54,6 +54,16 @@ properties:
     default: 16
     $ref: /schemas/types.yaml#definitions/uint8-array
 
+  moortec,vm-pre-scaler:
+    description:
+      moortec,vm-pre-scaler property is an array of channels that use a mr76006
+      pre-scaler to divides the input source by 2.
+      The pre-scaler is used for input sources that exceed the VM input range.
+      The driver uses this information to present to the user the actual value
+      of the voltage source.
+    default: 1
+    $ref: /schemas/types.yaml#definitions/uint8-array
+
 required:
   - compatible
   - reg
@@ -76,5 +86,6 @@ examples:
         clocks = <&osc0>;
         resets = <&rcu0 0x40 7>;
         moortec,vm-active-channels = <0x10 0x05>;
+        moortec,vm-pre-scaler = <5 6>;
         #thermal-sensor-cells = <1>;
     };
-- 
2.37.1

