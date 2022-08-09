Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8496158E0B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245699AbiHIUIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242787AbiHIUHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:07:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F87C26575;
        Tue,  9 Aug 2022 13:07:42 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JWG8X018241;
        Tue, 9 Aug 2022 20:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=+C0Y8sq25Ro5tBVq4MqT7YDvMjjHzpauTFIi9npYkFc=;
 b=io6TkisSYZpv8QO0wKvcJkQGE3vMMg1/VOOTzR4xYrGuQ6oLX3N7riCVrxoQQGCZlEfI
 SV2R8zbWXlJmtX5vAxmkglwt9IrcmEwH/G4REXVZTbZ3m5tS+meGHvpPoqbHhm8XR2+c
 z1OE4Mys6PPCwloSW1YgnBQaGSGoNA01L17BBIhD34ExXeLWE798fTs2G9DG1xPP1LME
 XxqSgK7IDS0zqbRYR7zb2edZcnmXOUDLqLAje30kT9qfPsF6vW3+lxjWyKiBy8f0iXHk
 bOQP+bULWhG6/j+CDN4fxqmj2n+4w9jZBeyW0ooSutccIlUzI/grLF+q3twLy5/rXbem EA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3huwty91a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:07:14 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 279JoMUI021454;
        Tue, 9 Aug 2022 20:07:13 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 3huww3r6k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:07:13 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 279K7DZg10093220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 20:07:13 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C50DAC060;
        Tue,  9 Aug 2022 20:07:13 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AB20AC059;
        Tue,  9 Aug 2022 20:07:12 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.17.179])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 20:07:12 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 1/3] dt-bindings: hwmon: Add IBM OCC bindings
Date:   Tue,  9 Aug 2022 15:06:59 -0500
Message-Id: <20220809200701.218059-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220809200701.218059-1-eajames@linux.ibm.com>
References: <20220809200701.218059-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7k7xmxygFo53fE2t1fKSqeuleecCKN6Q
X-Proofpoint-GUID: 7k7xmxygFo53fE2t1fKSqeuleecCKN6Q
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208090074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These bindings describe the POWER processor On Chip Controller accessed
from a service processor or baseboard management controller (BMC).

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../bindings/hwmon/ibm,occ-hwmon.yaml         | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ibm,occ-hwmon.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ibm,occ-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/ibm,occ-hwmon.yaml
new file mode 100644
index 000000000000..3dbdc5af2804
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ibm,occ-hwmon.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ibm,occ-hwmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM On-Chip Controller (OCC) accessed from a service processor
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description: |
+  The POWER processor On-Chip Controller (OCC) helps manage power and
+  thermals for the system. A service processor or baseboard management
+  controller can query the OCC for it's power and thermal data to report
+  through hwmon.
+
+properties:
+  compatible:
+    enum:
+      - ibm,p9-occ-hwmon
+      - ibm,p10-occ-hwmon
+
+  ibm,no-poll-on-init:
+    description: This property describes whether or not the OCC should
+      be polled during driver initialization.
+    type: boolean
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    hwmon {
+        compatible = "ibm,p10-occ-hwmon";
+        ibm,no-poll-on-init;
+    };
-- 
2.31.1

