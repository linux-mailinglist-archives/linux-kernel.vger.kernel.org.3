Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E56158E13E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbiHIUmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiHIUmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:42:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762971EEDB;
        Tue,  9 Aug 2022 13:42:00 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279KDhgK029196;
        Tue, 9 Aug 2022 20:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=dFMiCv9PUXxR6n4eWFApj1813JVLvNM4pjtISK2eASE=;
 b=KLD1pKlmfju6SUYVenHH0WKxztxyQVKoEzTWKaPNoSvhdr1OTdzmyppsuPew8pc38gpC
 5muSGNY6MXVfhTDfgoePS+ba1Do9pA32e3Xg03x7rEeFOGZztG8ocGZSoNJZxBs/woH7
 P1Bvf/Rf9ll7bW+E27NoqtheXQgBfjmU/os0m5MmUBXFSWkDMQLxgWuzNOwuX3yBz15n
 PWDDVTlaoUdo505+ytfuUcsURmvlmvIVmWcGkRx5bEU+NfByRpr7uDlbd6UVEWAF0Lap
 HGvMDDs/Cmq0Zdf1QRCrSC5HjsNTJnDkjcZH9/YNtDLy0EFggIbf7go3Z4064bED1itu vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3huxe8rt12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:41:50 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 279KE5fw029897;
        Tue, 9 Aug 2022 20:41:50 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3huxe8rt0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:41:50 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 279KL2b2023544;
        Tue, 9 Aug 2022 20:41:49 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 3huwvf0b7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:41:49 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 279KfnGP6029924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 20:41:49 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11DF22805A;
        Tue,  9 Aug 2022 20:41:49 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B26028058;
        Tue,  9 Aug 2022 20:41:48 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.17.179])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 20:41:48 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au,
        wsa+renesas@sang-engineering.com, eajames@linux.ibm.com
Subject: [PATCH v5 1/2] dt-bindings: input: Add documentation for IBM Operation Panel
Date:   Tue,  9 Aug 2022 15:41:46 -0500
Message-Id: <20220809204147.238132-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220809204147.238132-1-eajames@linux.ibm.com>
References: <20220809204147.238132-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S-yvVwakBHoBQSbcKLhImYMPJ7TTVzSK
X-Proofpoint-ORIG-GUID: ytOc00Tjx3BEiDDYjOIRA18DNO2eBzMP
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208090076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for the IBM Operation Panel, which provides
a simple interface to control a server. It has a display and three
buttons.
Also update MAINTAINERS for the new file.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Joel Stanley <joel@jms.id.au>
---
 .../bindings/input/ibm,op-panel.yaml          | 50 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ibm,op-panel.yaml

diff --git a/Documentation/devicetree/bindings/input/ibm,op-panel.yaml b/Documentation/devicetree/bindings/input/ibm,op-panel.yaml
new file mode 100644
index 000000000000..29a1879e356d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ibm,op-panel.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ibm,op-panel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM Operation Panel
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+allOf:
+  - $ref: input.yaml#
+
+description: |
+  The IBM Operation Panel provides a simple interface to control the connected
+  server. It has a display and three buttons: two directional arrows and one
+  'Enter' button.
+
+properties:
+  compatible:
+    const: ibm,op-panel
+
+  reg:
+    maxItems: 1
+
+  linux,keycodes:
+    minItems: 1
+    maxItems: 3
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/i2c/i2c.h>
+    #include <dt-bindings/input/input.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ibm-op-panel@62 {
+            compatible = "ibm,op-panel";
+            reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
+            linux,keycodes = <KEY_UP>, <KEY_DOWN>, <KEY_ENTER>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2180312fe0a4..4dc90f22eb54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9642,6 +9642,12 @@ S:	Orphan
 F:	Documentation/ia64/
 F:	arch/ia64/
 
+IBM Operation Panel Input Driver
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/ibm,op-panel.yaml
+
 IBM Power 842 compression accelerator
 M:	Haren Myneni <haren@us.ibm.com>
 S:	Supported
-- 
2.31.1

