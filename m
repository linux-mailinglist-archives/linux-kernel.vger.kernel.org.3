Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F7748ACEA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbiAKLr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:47:29 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45688 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238505AbiAKLr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:47:28 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20B8ckfK009826;
        Tue, 11 Jan 2022 06:47:26 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dggyquq9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 06:47:26 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20BBlPjW032575
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jan 2022 06:47:25 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 11 Jan
 2022 06:47:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Jan 2022 06:47:23 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20BBlFJq029369;
        Tue, 11 Jan 2022 06:47:18 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: addac: one-bit-adc-dac yaml documentation
Date:   Tue, 11 Jan 2022 13:59:18 +0200
Message-ID: <20220111115919.14645-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: VuZIzhY65L52ED6t4w0flfq1xcoqoOvp
X-Proofpoint-GUID: VuZIzhY65L52ED6t4w0flfq1xcoqoOvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds device tree bindings for the one-bit-adc-dac.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
V1->V2                                                                     
 - I am aware of the recommendation of rename/move this driver. Should we  
   consider "drivers/io/gpio.c"?                                           
 - Add .yaml file                                                          
 - Remove blank lines, remove unnecessary coma                             
 - Remove macros for channels                                              
 - Check if channel is input for write_raw                                 
 - Use labels instead of extend_name                                       
 - Fix channel indexing                                                    
 - Use "sizeof(*channels)" in devm_kcalloc()                               
 - Remove assignment: " indio_dev->dev.parent = &pdev->dev;"               
 - Remove "platform_set_drvdata"                                           
 - Remove "adi" from compatible string since is not ADI specific driver.
---
 .../bindings/iio/addac/one-bit-adc-dac.yaml   | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml

diff --git a/Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml b/Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml
new file mode 100644
index 000000000000..dbed0f3b1ca4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/addac/one-bit-adc-dac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices one bit ADC DAC driver
+
+maintainers:
+  - Cristian Pop <cristian.pop@analog.com>
+
+description: |
+  One bit ADC DAC driver
+
+properties:
+  compatible:
+    enum:
+      - adi,one-bit-adc-dac
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  in-gpios:
+    description: Input GPIOs
+
+  out-gpios:
+    description: Output GPIOs
+
+required:
+  - compatible
+  - in-gpios
+  - out-gpios
+
+patternProperties:
+  "^channel@([0-9]|1[0-5])$":
+    type: object
+    description: |
+      Represents the external channels which are connected to the ADDAC.
+
+    properties:
+      reg:
+        maxItems: 1
+        description: |
+          The channel number.
+
+      label:
+        description: |
+          Unique name to identify which channel this is.
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    one-bit-adc-dac@0 {
+        compatible = "one-bit-adc-dac";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        in-gpios = <&gpio 17 0>, <&gpio 27 0>;
+        out-gpios = <&gpio 23 0>, <&gpio 24 0>;
+
+        channel@0 {
+          reg = <0>;
+          label = "i_17";
+        };
+
+        channel@1 {
+          reg = <1>;
+          label = "i_27";
+        };
+
+        channel@2 {
+          reg = <2>;
+          label = "o_23";
+        };
+
+        channel@3 {
+          reg = <3>;
+          label = "o_24";
+        };
+    };
-- 
2.17.1

