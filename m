Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A78D525261
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356407AbiELQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356390AbiELQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:20:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C764254732;
        Thu, 12 May 2022 09:20:38 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CGC61O008071;
        Thu, 12 May 2022 16:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=2jz53zthz4riL7SwYyM1GSk2TOzYdf8KCQzjblK3rIY=;
 b=gwpRhLgyhS0BPG2MKfusCPpNdEaZNzEtmC9YiPlQ5sM5VGc3a68RmMzkK3Spqi7dNpq9
 lmVN/Z3+DtvIFux5XvovOnL4dszY8GtoB1K9GHxp6qzseCbRSA+D/4lPVSXT9iGwo6II
 QatetWcznE6Zfcch/goJGQUnx5G77wJQLBbvs5ebwDN61J84cE7wYnwfDEae72QGz5Gj
 5qlOthlZUibZUa/IlSrSn4hOcjerDxwZTfE+bM9J9VUQS6ZhM6U4WWdL2uUWkxBg4LcR
 UjoBWak2EZqy8bcMqsjk4gocpCGvQdW9H/dEoPU58lUOm+CKoNgah+DBzm0uTGLehylX Vw== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g11nf78b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 16:20:24 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CGHKM0026377;
        Thu, 12 May 2022 16:20:24 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02wdc.us.ibm.com with ESMTP id 3fwgda4h76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 16:20:24 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CGKNbo34341348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 16:20:23 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33218112061;
        Thu, 12 May 2022 16:20:23 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A616112064;
        Thu, 12 May 2022 16:20:22 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.56.168])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 16:20:22 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, jic23@kernel.org, miltonm@us.ibm.com,
        eajames@linux.ibm.com
Subject: [PATCH v2 1/2] dt-bindings: iio: humidity: Add si7020 bindings
Date:   Thu, 12 May 2022 11:20:19 -0500
Message-Id: <20220512162020.33450-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220512162020.33450-1-eajames@linux.ibm.com>
References: <20220512162020.33450-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NBB9pv63xhUhZ3p0qkv9hn9CkLfFWiGO
X-Proofpoint-GUID: NBB9pv63xhUhZ3p0qkv9hn9CkLfFWiGO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_12,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205120076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the si7020 bindings with a new "silabs,skip-reset" property.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../bindings/iio/humidity/silabs,si7020.yaml  | 47 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml

diff --git a/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml b/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
new file mode 100644
index 000000000000..9bee010f8d56
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/silabs,si7020.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SI7020 humidity + temperature sensor
+
+maintainers:
+  - David Barksdale <dbarksdale@uplogix.com>
+
+description: |
+   The Silicon Labs Si7013/20/21 Relative Humidity and Temperature Sensors
+   are i2c devices which have an identical programming interface for
+   measuring relative humidity and temperature.
+
+properties:
+  compatible:
+    const: silabs,si7020
+
+  reg:
+    maxItems: 1
+
+  siliabs,skip-reset:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Disables resetting of the device during probe
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      si7021-a20@40 {
+        silabs,skip-reset;
+        compatible = "silabs,si7020";
+        reg = <0x40>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index e5295faef52f..47a00b478867 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -317,8 +317,6 @@ properties:
           - sensortek,stk8ba50
             # SGX Sensortech VZ89X Sensors
           - sgx,vz89x
-            # Relative Humidity and Temperature Sensors
-          - silabs,si7020
             # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
           - skyworks,sky81452
             # Socionext SynQuacer TPM MMIO module
-- 
2.27.0

