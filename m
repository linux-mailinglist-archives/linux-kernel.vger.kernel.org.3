Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5FB50A904
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380318AbiDUTXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388315AbiDUTWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:22:40 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62CD4C7B2;
        Thu, 21 Apr 2022 12:19:49 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23LF1wKm019392;
        Thu, 21 Apr 2022 19:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=3A5f9Suhha+0eDJ0zyTZanOaOqT5liWrdwGnwjRGCOc=;
 b=gpW0zA++9UpAsGJMgAjEll8OLh+bDYkW1SfSP525fOw+2izHDUsyM2lgofF1E3HRNJJS
 Dw4vQ8xA9APUfB5G0ftTgMcyx5U0xnkNZLYyLe1C0fsGVH8Xv4QfU5+XG8X7t0RbUs7y
 AAnaiZfRZJjWcL3w/pW/hizeTrTu7U1BwW45OYC7EFVbVHjNtGlx0rhvEdJpq4GrNKgk
 HY+ncReI/KyQoU0fpEEV/esRzptyOervpLEInMP3YGtg5yVybpe5cxgK1TyFrymMHw8G
 +koCB9Rs3D67zq7x6e2pvNLpDCq89TJTpacoqdYC6s4jx9UjKPe2Q+qNnpmwDgP1o4FG 6g== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fk8q2aqh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 19:19:39 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id ED54966;
        Thu, 21 Apr 2022 19:19:38 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id A7D914A;
        Thu, 21 Apr 2022 19:19:38 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 05/11] dt-bindings: timer: Add HPE GXP Timer Binding
Date:   Thu, 21 Apr 2022 14:21:26 -0500
Message-Id: <20220421192132.109954-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421192132.109954-1-nick.hawkins@hpe.com>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: UsC7FtRHpRjhf58fbGvVb1lTLPLihuKx
X-Proofpoint-ORIG-GUID: UsC7FtRHpRjhf58fbGvVb1lTLPLihuKx
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_04,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=765 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210102
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Creating binding for gxp timer in device tree hpe,gxp-timer
Although there are multiple timers on the SoC we are only
enabling one at this time.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v5:
* Fix versioning
* Fixed typo time -> timer
v4:
* Made watchdog a child of timer
* Added reference clock
v3:
* Removed maintainer change from patch
* Verified there was no compilation errors
* Added reference code in separate patch of patchset
v2:
* Converted from txt to yaml
---
 .../bindings/timer/hpe,gxp-timer.yaml         | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
new file mode 100644
index 000000000000..a4572be8d89a
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/hpe,gxp-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP TIMER
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+  - Jean-Marie Verdun <verdun@hpe.com>
+
+properties:
+  compatible:
+    items:
+      - const: hpe,gxp-timer
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: iopclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: true
+
+examples:
+  - |
+    timer0: timer@c0000000 {
+        compatible = "hpe,gxp-timer","simple-mfd";
+        reg = <0x80 0x16>;
+        interrupts = <0>;
+        interrupt-parent = <&vic0>;
+        clocks = <&iopclk>;
+        clock-names = "iopclk";
+    };
-- 
2.17.1

