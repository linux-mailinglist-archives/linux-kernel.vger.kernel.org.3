Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54085508B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379963AbiDTPDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379904AbiDTPDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:03:01 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3981E14013;
        Wed, 20 Apr 2022 08:00:13 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KERNLq001481;
        Wed, 20 Apr 2022 14:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=zBrTf6Qo31CzintAEZ1ZV+ruktO4W9tsAWx5OVdR+dM=;
 b=KupYLTLCRJ816BY6MxTsA3kTlXLHqoCQ2eUbX+X5vMz4Lfl7wuRFAtQDNh9pwLVYBK+L
 flou89e0Ap6sIPUsP0vsiPbtoH9Hi32NGOjw28iIXJC11ZFCx9y4QyWUNYXMWTWaJeHY
 kE6qRi+FhCZLAvWhgiCKamiZCd+NhFQZfBmd9klOg4DH2raB+FaBHbhQilVOn+VqfNPP
 zw+oQmahUD/lq3u7nG5TFO2nYHOVwLthGN/NZKSlr7k1B1WzlOh+d5lisAwJpZsMLseB
 FFykq86XkIPSON0xL2mIR2Sl1kpO6aghZJly6kMTAwit+vffU0bW+64jMGut9dFyClSq Lw== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fjky1g9va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:59:54 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 8708465;
        Wed, 20 Apr 2022 14:59:53 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 2C7C03A;
        Wed, 20 Apr 2022 14:59:53 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick@hpe.com, joel@jms.id.au, arnd@arndb.de
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog timer binding
Date:   Wed, 20 Apr 2022 10:01:50 -0500
Message-Id: <20220420150156.47405-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420150156.47405-1-nick.hawkins@hpe.com>
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: ybzwJOOO4EBSPXrdjN8Ue_p6Yr-YjTJq
X-Proofpoint-GUID: ybzwJOOO4EBSPXrdjN8Ue_p6Yr-YjTJq
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxlogscore=923
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204200089
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add the hpe gxp watchdog timer binding hpe,gxp-wdt.
This will enable support for the HPE GXP Watchdog

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v2:
*Made watchdog a child of timer because of same register
area based on review feedback
*Simplified the watchdog yaml as it will get information
from parent device
---
 .../bindings/watchdog/hpe,gxp-wdt.yaml        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml b/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
new file mode 100644
index 000000000000..c20da146352f
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/hpe,gxp-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP Controlled Watchdog
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+  - Jean-Marie Verdun <verdun@hpe.com>
+
+properties:
+  compatible:
+    const: hpe,gxp-wdt
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog0:  watchdog {
+      compatible = "hpe,gxp-wdt";
+    };
+
-- 
2.17.1

