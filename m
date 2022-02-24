Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD28D4C394B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiBXW6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiBXW5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:57:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D0E70916;
        Thu, 24 Feb 2022 14:57:13 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OMJwD9016301;
        Thu, 24 Feb 2022 22:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=19Ecz5gSpEzGrNN2WDDM5/QTZ/C0y3ubAGL7YY/ilHo=;
 b=C8Wf1IDyMxxsFJ/ogNaejJ1KSfazHA37/gFIEkIrgadmdX0LHHJMphn7cJaudQYNhnhb
 C//VPDABiV+jfM30BgqehzPy/cD/qdiHuwbZHISf9S/X9O5zb4+8cUO7E5Q5VuAxg5S6
 4spfPSUta9QdjXUZd0GRII2g4+grI0D+AxsI/hVBo2Fu2ZrfL5O8g4atFGSfuz4oXPh5
 /svVzPpge5kpM20WJgrS4s4SJJIjfeKPqporHnZNdLnLRijqZrvEfKBIo7/M2BcXeMKs
 tgwllAMi1jvUaRrl6cXKsnC1+OeQ9Se4xf4SmU9aYKbYEfELTTcLy3xn1EdpaHUWGHZK SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edxf7b5a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 22:57:09 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21OMK2mE017076;
        Thu, 24 Feb 2022 22:57:08 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edxf7b59q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 22:57:08 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21OMqZvM024551;
        Thu, 24 Feb 2022 22:57:08 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3ear6c8xag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 22:57:07 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21OMv6E932112926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 22:57:06 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 935B778064;
        Thu, 24 Feb 2022 22:57:06 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38D6478060;
        Thu, 24 Feb 2022 22:57:06 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.20.50])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 24 Feb 2022 22:57:06 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org, joel@jms.id.au,
        Eddie James <eajames@linux.ibm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: input: Add documentation for IBM Operation Panel
Date:   Thu, 24 Feb 2022 16:56:34 -0600
Message-Id: <20220224225635.40538-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220224225635.40538-1-eajames@linux.ibm.com>
References: <20220224225635.40538-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: reK2leHEjU0nBg26bRS3oz-N4NZXS_AQ
X-Proofpoint-ORIG-GUID: M1hRCdpJvx_4jfE2K1ANqckvAupFbC6-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-24_05,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202240123
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../bindings/input/ibm,op-panel.yaml          | 49 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ibm,op-panel.yaml

diff --git a/Documentation/devicetree/bindings/input/ibm,op-panel.yaml b/Documentation/devicetree/bindings/input/ibm,op-panel.yaml
new file mode 100644
index 000000000000..08d8f194f0db
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ibm,op-panel.yaml
@@ -0,0 +1,49 @@
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ibm-op-panel@62 {
+            compatible = "ibm,op-panel";
+            reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
+            linux,keycodes = <KEY_UP KEY_DOWN KEY_ENTER>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d2eef29691e7..f4c9db336223 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9233,6 +9233,12 @@ S:	Orphan
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
2.27.0

