Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3196E523D27
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346656AbiEKTI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346647AbiEKTI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:08:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8006EB0B;
        Wed, 11 May 2022 12:08:54 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BH2L0j027935;
        Wed, 11 May 2022 19:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=0IwahtKyO/pNW9H3Y7Rv8hb5iP853hvqV4TCm0Y4GzQ=;
 b=nCnrRK//ML0iynbf6X3j8KqaIzTUgt79AS1WzW6tbJ9v4r7VHrIDq+K0fnU3toLO4EF5
 Kt0nQAwFWzJ2kReLNuQQr1hoFKSLqZ6IcZRDguXIIqiFiYrtx2Ho+7JdvfqTAspvzKRb
 T0Smf33SNU3Qi4zZirqCkFYSNnyGEey1FOlqcI1H53nmuSHVF3Y2g1HlK0yX+nws/L06
 oCXXivXOUoMo0nFxk+aOAc6VMFUAMi5rXgY7IU9ANx7dG0xQwLHc3PJnTJsoLH2D5OtR
 UgRi7Pf22uASjU2xaf5r7+b2pY143y58MQe1XA9Dy4PRt/NoKJjtIwwP4825fDX76z2d 9g== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0etx5mr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 19:08:38 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BJ7Lp3006795;
        Wed, 11 May 2022 19:08:37 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 3fwgda6bdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 19:08:37 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BJ8aZ030277896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 19:08:36 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2C8E6A057;
        Wed, 11 May 2022 19:08:36 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C0BF6A04D;
        Wed, 11 May 2022 19:08:36 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.61.211])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 19:08:36 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dbarksdale@uplogix.com,
        eajames@linux.ibm.com
Subject: [PATCH 1/2] dt-bindings: iio: humidity: Add si7020 bindings
Date:   Wed, 11 May 2022 14:08:34 -0500
Message-Id: <20220511190835.51046-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220511190835.51046-1-eajames@linux.ibm.com>
References: <20220511190835.51046-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7BO8OIYoBvoxLe2zlmFJURplbRNnIiE0
X-Proofpoint-ORIG-GUID: 7BO8OIYoBvoxLe2zlmFJURplbRNnIiE0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=910 bulkscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205110083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the si7020 bindings with a new "silabs,skip-reset" property.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../bindings/iio/humidity/silabs,si7020.yaml  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml

diff --git a/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml b/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
new file mode 100644
index 000000000000..ab53bb8d9606
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
@@ -0,0 +1,42 @@
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
+    si7021-a20@40 {
+        silabs,skip-reset;
+        compatible = "silabs,si7020";
+        reg = <0x40>;
+    };
+...
-- 
2.27.0

