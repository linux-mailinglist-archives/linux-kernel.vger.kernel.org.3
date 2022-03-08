Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA34D1117
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344609AbiCHHga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbiCHHgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:36:24 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2102.outbound.protection.outlook.com [40.107.223.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D373DA7E;
        Mon,  7 Mar 2022 23:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuegMAh9Oif1g2XgZ6iW/7lnhaRpifSF021yqvXO14sZBlYpkRbfOQD9dLIkSELnKx5tbxQlb+AEvJr5tt57DQIQKjTQDrHwXLcCnpt2Fxaw7VakJknBhMN/Kbc3lHobT9haMV7/58uWhVLBP7L0mSvHfpVf1qUnbuc3VEZpJzLJa9Pj5ZntwIlb1iMbxlecnDAnEUjzKOP6oIk6VEVGm5e9snFNKSULht90Y6zSLYRAL2gkrGxEchipoXcjaReZRsA0uFvHwIIueG0B+Rk/9JJCutqdjD4HRUapw2hvmeJ1t8cVbdxJnxrHIM1grKm9zSkiVT0Hitl9t6GgUo6v0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=XInvlrWb8XrhkmeuzCBOveMKr95sc/3DmHp7pHmEdwihIK7z+nJnzzjjv4Fpz+iqSZLkwB2PyYqrtcLNol6yN3Holrmfc11vzzOavlhy6mNhXOakQti2AaWsEkV5FCHIb4ZhjY8bSneHEG/y/96+UOnsWVfFkoVUwON7Zu+nuL2/yRhpPQpFZ58cFqZFF3oiVVKxaL0+ii7BUS0H9Lcr/PGNFDU0PSuPHvZFZI0DryGhIwRN15e86w1Aks91B5WXrR9poYEx/YCEyY/LOTKB/xA4hV9Ys0FsG7ogmqP6UJb7gWE47A/PkKwjqXvLBqPxAPxeMIF44CpIiBAFm+R98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=tvlkaoH6ZH/mAE+Zs0E6krS8izDArFjtetbbOUJS50v3ScOvQNAyLWBfTr9t3SOx4sJuywnyGCdEDJCbYQAJRhQGgLyP47+inkyhG3wwYNibD9TGXsGZcVN+THQuY8Vupi8cndvfBxPU1NYLuRaToEEtDekLSMONItWpiOV4zRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by MWHPR04MB1152.namprd04.prod.outlook.com (2603:10b6:300:79::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 07:35:25 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%9]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 07:35:24 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Tue,  8 Mar 2022 15:34:29 +0800
Message-Id: <20220308073431.1217890-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308073431.1217890-1-xji@analogixsemi.com>
References: <20220308073431.1217890-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44afb967-ae6e-49aa-ed80-08da00d63560
X-MS-TrafficTypeDiagnostic: MWHPR04MB1152:EE_
X-Microsoft-Antispam-PRVS: <MWHPR04MB1152C05FF6CED552285882D4C7099@MWHPR04MB1152.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPcSVdQwo/AtopYUzGwQ9lbtlHrLot2oVlpXFMQs4umAJ3MHMcS5IlHNOuUWyMIX+VRs9ghqR8GuqKTBJdFbqBMVSTaFXfW2uWDxGtmV9pPH+l0ZwuhE7mBglyVZWXqvZmslsqBK6FAiXLlElA776hinlBU66D+Njk5cqoaB315SjcBVfnukHN+S7/IvJxR1QakZJQC0d1EAxByQHujcpHNlPpzsOK165ls06Uq6K6tl61TC2OY3tjT9+VHb4U36ePP2qb6VW4U3hbJcxTNL7Rith70mV9zI5cBKWiVo8Jwkqj4bzIq6x+mS1vcKzKlO88rAe1HUQ30Q3moWhZVOcXq3RnMFuSIQvkIbm31VDyf4l34Ov88DtwQsA7b5xDbC3tQmsBek1vdExZIY8SnNFgLE35dvyQhHYpQwUh7PxzZlJaGmbfl/7aUQNTDbYelHMlIC/StgV/o3l2cZVN37sM6Qosjc8dzbAZyPUvHcYwRPxbfArsGjRh9MKyvb2MdG6HzrTcOzDdt+sU7X9QCrhbKIDHyP/nKpxs4WL0dn8dVyrOQFnDvl84CfiiLJifu7VpvHadNmIqTIEL4AdtalsEDOjehuPo5aLWAwXpzYGWxFGwuVFqQbF+Jeu7JuTJjKZjFW98GB1JAjozdVAiS3jS2eMMCe28+WaAVkiRGFZMZlhqu5C50YzGfEu/UjZHsSO/UAlg71Ltd38MEWvwjQhz4GgbZDr/CCUvR14NXUuT/x6Yp0YnQ3AqDNM9kadVfw5wLjhWcS0xwfXBphT7uUCkiznaPX6bsxdk4D3Fi5Wcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6506007)(498600001)(55236004)(52116002)(86362001)(8936002)(2616005)(66556008)(6486002)(7049001)(2906002)(1076003)(6512007)(186003)(26005)(4326008)(66476007)(8676002)(66946007)(38100700002)(38350700002)(110136005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XWvxk1ZA0buACPRA38uptJ/FfAvJP9m5787PzkZ9Xrf68kqdaAPaRgDdUBCT?=
 =?us-ascii?Q?odaQ7Q1FYRV0TnaxwAfOxJ+u58xm9k4dku3S+Jr+gmHAUFH+KIaB9Eu2R6rg?=
 =?us-ascii?Q?MIrrjxcqzF7R0UqJkDI2uTGFjuV3PxVDYuXCWrrycbcmoJXIQfpqjU34cwhf?=
 =?us-ascii?Q?kuffTX8SICAyczunAuiMGWTJYkgUPTWyBcSIq18UQ3MRVrJ4ivgMbrOk+QTS?=
 =?us-ascii?Q?nWmcE8FPORrNjfo/cYJVD9Ya12aKa+gR+QNSNF5aaIC5IcmqvlVvq/Fe6VVP?=
 =?us-ascii?Q?bDRkq2FBQmDxAXkiGTfXtg8dtNZztAYSqOK0M7GzjQxLAyeZG0VwzIdr5ucI?=
 =?us-ascii?Q?2QV8GspbUw8zR/xTjF0FKdACPzskkab6fBP4N+obfXNRGvqRhrjY6rXMTejs?=
 =?us-ascii?Q?A04LqeVTJ6HKF8feHUJv9qjhkyGotbY8TPIxm4dZhMeN9RjC4Vxf3oxWbhmG?=
 =?us-ascii?Q?pl0SA9JHtGHqyspASZVHiowcWAjwa+DqiFGW3oUU1E7esOc5KlOS0qZtCVT1?=
 =?us-ascii?Q?L+9MOJ6jsg27BVXx1SW0RRldcPC8hIrz1C7gaqnB9xQPAHPr+S5h9qWtmHP8?=
 =?us-ascii?Q?3zlOphSHbGXzVFf2wSm17qQvw4SVFwPzv0blMQdR/uOU2rhgxSbcCjmNawEL?=
 =?us-ascii?Q?EXBKaSAljWgNDgcwVNTAByg7ko5dcTxUH86rPFvdCHMnTC6DOu4KJJ4F1rUD?=
 =?us-ascii?Q?LLIdSKuaRUOhssKw8vZ9q7n/8n4D8vFWN/HNZzoK8bnj2OsvekFdWJwHT66k?=
 =?us-ascii?Q?t1vn+zOMvan9nAppW/vMNaw68wV08W1p1LbWSdSIExgoLWnvbDPvbaCOEF6X?=
 =?us-ascii?Q?NQQGIN7KE7Ldll+q95lUqcdw+U+zlwISO5GcFZ5uDJEW0BD96pPN9zcboIQq?=
 =?us-ascii?Q?2F19HUfoyR0GwwJ1nVywxBFKNoh4WNCSI8FDaDQspuWCle5VNeYoPjcVw0xI?=
 =?us-ascii?Q?hG2DFYU++6g/e/rjmRsMDE1IXWxL5gCmnlvOlY4TaYenFoUkL5LGLP5Wh2mT?=
 =?us-ascii?Q?qrZXybGKnfZsqO5PhqOuSViHBtr/pP9m2YiXMdxzCLm9QBlV++bgATqoCkO9?=
 =?us-ascii?Q?4XeCARwYlRfvO9vAZtLzq3ef9q9pOyb46MdD5vtbTvd15YsuD3tQhEpigZtM?=
 =?us-ascii?Q?yv2nz+oDU5JwWp+5uwHNRW9nfuWf6/qiikCciSSLpf+IrnLgQ6iSaNew/ulo?=
 =?us-ascii?Q?CUY83vBF1d/nYAR8dXBh+qUZS+5QjVke8rAMjZAtqCDOMW3uq2F/Ez+C8yGi?=
 =?us-ascii?Q?pRNPaTiJGcW1imgKi4X38PW0a22Qsdb1uhG8QLHlRQjlCyw4kkhbFGUVKmL4?=
 =?us-ascii?Q?7cy2DAVg9X/Po0qU+DMBu5BSUEdbkcBH2+p6PYRQC+W56IrpwfvZYb+h4xEY?=
 =?us-ascii?Q?1k07Kb53Fk6Yux/8q1cz48AI4GBj5TBTktEf5FYCr4SxUcWObmtsinp+egq9?=
 =?us-ascii?Q?OCveRNF7ERanwyGe6h470/WNHiHr61FVcuKpVJHQZEAH3AUPEl2ObPAxSktY?=
 =?us-ascii?Q?GgMWEAf5dqUVoPLtFBebVUSkW7q0D8dMPCGpiP36PylhCJ+L4C8DQg6tUHd0?=
 =?us-ascii?Q?RBJG6sM4GC+Ph96am2GrME+uXtKSjuSb2Ck/+kdD9q4wiWDb6AGvpk0IIzvq?=
 =?us-ascii?Q?pxjvJKLx2smarsTmcMGXQu8=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44afb967-ae6e-49aa-ed80-08da00d63560
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 07:35:24.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Klz0cdiKZSbP2TRzDaRE8on7vhSO5aZEDsHZ2+zxhkosGpKGuKOBCbdC2STEm6B4Fwe7zNy8pI/Yd31Yjkx+AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1152
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add analogix PD chip anx7411 device binding

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 .../bindings/usb/analogix,anx7411.yaml        | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml

diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
new file mode 100644
index 000000000000..c5c6d5a9dc17
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/analogix,anx7411.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Analogix ANX7411 Type-C controller bindings
+
+maintainers:
+  - Xin Ji <xji@analogixsemi.com>
+
+properties:
+  compatible:
+    enum:
+      - analogix,anx7411
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+
+    allOf:
+      - $ref: ../connector/usb-connector.yaml
+
+    properties:
+      compatible:
+        const: usb-c-connector
+
+      power-role: true
+
+      data-role: true
+
+      try-power-role: true
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - connector
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        typec: anx7411@2C {
+            compatible = "analogix,anx7411";
+            reg = <0x2C>;
+            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio0>;
+
+            typec_con: connector {
+                compatible = "usb-c-connector";
+                power-role = "dual";
+                data-role = "dual";
+                try-power-role = "source";
+
+                port {
+                    typec_con_ep: endpoint {
+                        remote-endpoint = <&usbotg_hs_ep>;
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.25.1

