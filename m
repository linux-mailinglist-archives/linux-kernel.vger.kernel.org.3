Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EF45882C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiHBTrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiHBTrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:47:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DDE4AD63;
        Tue,  2 Aug 2022 12:47:41 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272Jk1LZ010234;
        Tue, 2 Aug 2022 19:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=0TU5DLp61xDyAb6KBH+NW4/5l6RU7u/o/UOxwNx8Wek=;
 b=kGoVyer1Z8fx2kWHIygrZuUsTWNwaGZGHPPHjsZs9MXZ32+0ZuEyXNne5U7KhX5YtAus
 7njL0BaT3EASi0/7bwuA1R0WFGhYWFg+ThWP0bwwFM/NB3B7gYH7jqI3Gdc4UDJa/oB2
 JTXNHr/WV4ZrcK63yQhBt1/V0FpAPaS3+m4rxl9qQCQWHmtffYNMeuDhlVyyAW9TexUW
 pCuV6ZFauMYWGatmIo9z7O8eiuuGzZlGjlSPCDFuZMoNhvoLMeZ+Dk5YdBWp3FNk+Zkv
 omp2t6xquGP/quQsD56RFQgPSmEgvVwvcsh/g6I1cBmgi6RIZhFbwG0P8NfHQYmQUWAd ng== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hqac7r0f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 19:47:15 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 272JK4Zk030027;
        Tue, 2 Aug 2022 19:47:14 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 3hmv99gx8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 19:47:14 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 272JlD3157344452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Aug 2022 19:47:13 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75F90124054;
        Tue,  2 Aug 2022 19:47:13 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6310124052;
        Tue,  2 Aug 2022 19:47:12 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.144.23])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Aug 2022 19:47:12 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        devicetree@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/3] dt-bindings: hwmon: Add IBM OCC bindings
Date:   Tue,  2 Aug 2022 14:46:54 -0500
Message-Id: <20220802194656.240564-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220802194656.240564-1-eajames@linux.ibm.com>
References: <20220802194656.240564-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qJ9ewh5M9TPRC9a7zPaWUAGNa0BG__BH
X-Proofpoint-ORIG-GUID: qJ9ewh5M9TPRC9a7zPaWUAGNa0BG__BH
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These bindings describe the POWER processor On Chip Controller accessed
from a service processor or baseboard management controller (BMC).

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../bindings/hwmon/ibm,occ-hmwon.yaml         | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml b/Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml
new file mode 100644
index 000000000000..8f8c3b8d7129
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml
@@ -0,0 +1,40 @@
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
+  This binding describes a POWER processor On-Chip Controller (OCC)
+  accessed from a service processor or baseboard management controller
+  (BMC).
+
+properties:
+  compatible:
+    enum:
+      - ibm,p9-occ-hwmon
+      - ibm,p10-occ-hwmon
+
+  ibm,inactive-on-init:
+    description: This property describes whether or not the OCC should
+      be marked as active during device initialization. The alternative
+      is for user space to mark the device active based on higher level
+      communications between the BMC and the host processor.
+    type: boolean
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    occ-hmwon {
+        compatible = "ibm,p9-occ-hwmon";
+        ibm,inactive-on-init;
+    };
-- 
2.31.1

