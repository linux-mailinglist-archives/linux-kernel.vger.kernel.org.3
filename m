Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809B952D296
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiESMfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiESMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:35:23 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0237ABA57A;
        Thu, 19 May 2022 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652963722; x=1684499722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ZEEEUy2ZjA3vhWCA2XPwXEGc6ZNIUOVQ9QWEMBg1pfE=;
  b=LGr4+LvF/B2KNaVEn6Uqanl2s2qMlhqMgqZbTJKFnMl1t2X8xw6qFDZr
   OvfqPwimLKCSBXnqGD9Vme1AuCzASwp/XwX85rCn76WZTtqF5JbuVh/FT
   xBPQon4I2LtAcd9zqWKNR9trBi1OXbtHYSygNJ2QTGftAvV/0r+/PCCMR
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 19 May 2022 05:35:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 05:35:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 05:35:21 -0700
Received: from hu-harshq-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 05:35:17 -0700
From:   Harsh Agarwal <quic_harshq@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, Harsh Agarwal <quic_harshq@quicinc.com>
Subject: [RFC 1/2] dt-bindings: usb: dwc3: Add support for multiport related properties
Date:   Thu, 19 May 2022 18:04:54 +0530
Message-ID: <1652963695-10109-2-git-send-email-quic_harshq@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
References: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for multiport, mport, num-ssphy and num-hsphy
properties. These properties are used to support devices having
a multiport controller.

Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
---
 .../devicetree/bindings/usb/snps,dwc3.yaml         | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index f4471f8..39c61483 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -341,6 +341,35 @@ properties:
       This port is used with the 'usb-role-switch' property  to connect the
       dwc3 to type C connector.
 
+  multiport:
+    description:
+      If a single USB controller supports multiple ports, then it's referred to as
+      a multiport controller. Each port of the multiport controller can support
+      either High Speed or Super Speed or both and have their own PHY phandles. Each
+      port is represented by "mport" node and all the "mport" nodes are grouped
+      together inside the "multiport" node where individual "mport" node defines the
+      PHYs supported by that port.
+    required:
+      - mport
+
+  num-hsphy:
+    description: Total number of HS-PHYs defined by the multiport controller.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  num-ssphy:
+    description: Total number of SS-PHYs defined by the multiport controller.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  mport:
+    description: Each mport node represents one port of the multiport controller.
+    patternProperties: "^mport@[0-9a-f]+$"
+    oneOf:
+       - required:
+         - usb-phy
+       - required:
+          - phys
+          - phy-names
+
 unevaluatedProperties: false
 
 required:
@@ -369,4 +398,30 @@ examples:
       snps,dis_u2_susphy_quirk;
       snps,dis_enblslpm_quirk;
     };
+  - |
+    usb@4a000000 {
+      compatible = "snps,dwc3";
+      reg = <0x4a000000 0xcfff>;
+      interrupts = <0 92 4>;
+
+      multiport {
+
+	MP_1: mport@1 {
+          usb-phy = <&usb2_phy0>, <&usb3_phy0>;
+	};
+
+	MP_2: mport@2 {
+          usb-phy = <&usb2_phy1>, <&usb3_phy1>;
+	};
+
+	MP_3: mport@3 {
+          usb-phy = <&usb2_phy2>, <&usb_nop_phy>;
+	};
+
+	MP_4: mport@4 {
+          usb-phy = <&usb2_phy3>, <&usb_nop_phy>;
+	};
+
+      };
+    };
 ...
-- 
2.7.4

