Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113904C103C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbiBWKYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiBWKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:24:44 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263DC8BF71;
        Wed, 23 Feb 2022 02:24:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYaKUtrRNJTUW9X3aFIdPTPSz+O0CDPgBodB5r5Rv61YimM/Lb48Ufs/r+zoC/btSKfO11lJJ4k8+Z5mhmENk8jAhlX77qEXmSRwvcSkbdWeVQSVEmLFvXk/3S1EKu/46x7hFh/r16UPNy20ug7w/jJbsoTjHE2bQUTGBP0FwNZagPy7X1vljpY9PIADQG4HuIXljOk/+92qhhrOA//nxvbhUidqXsiOvMi90TaEsb1sfiSrlSnjh4ULX8oXy+Ql2waqKibd58LvM4l9k42moTawhip3vEys0gTR2HqbM4svMxyxOQ5uucqDdBsDsc37qcTAJzhvNzyOlhWV4WI6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=MSgoSfbbMXGIWVH4r89hBLYaMTebQFIViS1VzMtv9jfDBY6Ks5InZ9vbO95GAOpJjrum+81mzQCuTjT1jx6aPwsE43doEHU7altruXNjeSOKarGNz7qg25HnQsPWt6yRn6iT7RXJ4mrCxHTN8VOdGQkO/Q+Q8FbG3Vvuw/whDD9IwyFf/zdNo5vTBgPqwO+3P0SSN36eS+Z3HrDVZscf/ndQ/AI7+KGE/4sFUe5RILEE4Y8Xr6Ra2k+67IihUkO6qbcxvgRqD5b0TYohz3ylwcYdVQfk9LVy5S4WxoXx3FjqDT3eGrUQCqy0OHliwLLRXs1zpUwwZiir7YPwvH+Xvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=vwrYfIlRvITqusEh3jk1y+ZmduC4kHGVC8fvLgmYnfyYQlHkBfJhgpXA5UVDkft0lkTE9fmkYRMHFuQTnh1sI7LeN0gPEBinxKK+UQ9EjGRrwPAfuNPUA0hj2LmxgvsClxmV2CTykCBMoiKgWcwwIB696LYG+T0iiMJoOdCk2mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM6PR04MB5898.namprd04.prod.outlook.com (2603:10b6:5:161::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 10:24:15 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%8]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 10:24:15 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Wed, 23 Feb 2022 18:23:51 +0800
Message-Id: <20220223102353.3833578-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0048.apcprd04.prod.outlook.com
 (2603:1096:202:14::16) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c33593b7-80a2-4b47-ec22-08d9f6b6a45a
X-MS-TrafficTypeDiagnostic: DM6PR04MB5898:EE_
X-Microsoft-Antispam-PRVS: <DM6PR04MB5898BB4DC232E6B9624A09E0C73C9@DM6PR04MB5898.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tW/rwlAoMxZytpbCnZJ3lw4n7QK/yZ+VY1OWBxF3WT096wnt9OLriZVW1hUD8efxUxX8RHxnjUA8nP0JUksZhHYqfNUZ7kOW/V092Jt+5JNQvsVrUtykgmjEVazHmBUjq1wJqQ09WIa/I2WVlCCoHambpiwOOhRHWhX36YYCUv30NYqwO6riwBvDKFO204kqoLzpBXZQtLgn2CSm+ctntgf1ajHkThkHPAzeuyRHo1BMvheP9m5SVuKzNSgGh0u6wnh5fHSXVR8YFz7oMcltqJg+mkeC4fiwxbH9Mmid5x8zCqSOnJOXKDujJqRdM84XOVZgNVhwmjtzcED0oCSZdZ1AA+XnGwlRs5SzROxi05Pe1tEKGtFKztVK7GGmQiFs/ayl5DPK+r2rPh5XaB9G748pb5ktCzR28J7JVdx899L45047WMw4R28wJqEH0yZnThk2fDmuEXJpZGhrmkiK2S50rZY7EfRQbw/shfCB+qpI7Y+DKwPGHhfKiqoQPYupPVtPyFXDxG8sgpzhywmh5++IA/3EfL+fdo3MmIXMs5WSAPwaT8SYEOFGyzKae0wprO0EAFf09G4pQAG71bj89dgZ2m3YDgRqMX5GQDBjvcgm9tnkYjBXLTPawGxf+JdRdQHGGgjTWWHZpt85WSYkxkF6AcbKkubbLLvZIUQH22/yAA4Y3ZSk9Wl21/6JVEG/JhOuXfSeCoP1lXt0gYt+/0bjjSLNZTQ0I4U/GNS52zJyt4ZlyH8d+HLPw7JL5I4NP3QmtriktDM1YAVA7nRib59JuYMrdFDzzuIDHJAGFLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(186003)(26005)(55236004)(66476007)(66556008)(6512007)(66946007)(6506007)(6666004)(6486002)(316002)(1076003)(110136005)(86362001)(508600001)(2616005)(7049001)(8676002)(4326008)(38100700002)(38350700002)(5660300002)(8936002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WmGTdCSKcK9Og+wq3C9Jrm6jPTjHoc36VBPNfOkdmp0zJGKT0/5hjnKwVfKR?=
 =?us-ascii?Q?g1eWMDHgubBssy52evWY/sgie0nA2pSU9GHt7l6v+e8wuFvf1Iwhh5rVL6xg?=
 =?us-ascii?Q?CfZ0YcCnisn1g4TgjfVs2cz4DBuBwJdbLF0uUz8hmPLYH0484PplsDG0iKYr?=
 =?us-ascii?Q?heAdvDtX9gsu2Vrz5OxpZFycBH3nVjds/sZNuphzVMA1VmsU5w1/8GjdBKBy?=
 =?us-ascii?Q?7rQ3SI/qKsaPjP7zjeD6o3z60qP/SU9v3V1lhvCSVA3Pm7OlRi5Bws9ezAd0?=
 =?us-ascii?Q?SeHaRJ1PQrnnNCxZiwObDCA9AxIQQhkRdHc7eHMC5ptu+9fczHXsKHaTOF1Z?=
 =?us-ascii?Q?DKroS13tRmGTaMdtSXMo88rO69QML2gV8YtKVEfmrWeu0hcMrj7BY0tBDvuX?=
 =?us-ascii?Q?fTzpIoXQBo4LhCG/8NcgTBlWSyWOaJZ4J9xqWCOB+z5IozcIbII2FU8JCvKb?=
 =?us-ascii?Q?skH3iLsqbmbc9ClOLT2rY9epjiZIanUSk+5FQHNbr3nx+muvO9VVWlHJgRqH?=
 =?us-ascii?Q?ZPzfqVa82uJBEcOyFQXtMvamc8xXwJKrbd9Hj+BTaQP5OCxuVHI48M7kQU77?=
 =?us-ascii?Q?griomk7p18hQd8YnlIMAuDUY5NeodK47c1IT3Xv4PjYAxsOe5i1cu1lCTmgV?=
 =?us-ascii?Q?ygMCIHtCo0U1UIG0KLAvTTlUptAheWb8lMRUoNiCSvXfgYo36ITgvO2QmLKw?=
 =?us-ascii?Q?gPB9aPMFD30lJQueih2Mo5qjaJU4tTUHwH5wHV7OGH6EFTjNI9TIGd4tN4Lz?=
 =?us-ascii?Q?vTo0e/QVsnwKA41RV3Pjr6/scoKc8dgz1lBUSw34i4ZlAlTWdQwjxzQctV40?=
 =?us-ascii?Q?15EZv3TbaqnonkXW9Fjhx2hfe05f2bZN8Z12hW6ElduPae6XJrUjbm7EnfYX?=
 =?us-ascii?Q?aZ88a8F/wGPMnZHq+gq/JTd40DcbC07RRyzMMSq14pwYhqi6cV23gi/dShon?=
 =?us-ascii?Q?I4CYGKk90Xi0n0dIOPEAe2dh8DnNqDbokv4Iv0j4gcWas5dWn+NBDD7sAeKr?=
 =?us-ascii?Q?60yWqWcn0AYqaBxia8cmcQ+Oxa062OdEguZn7UHSIdJnye5n/STPCmC+W/+o?=
 =?us-ascii?Q?GB1Q6AjROgS0NvaVZmx0W/YQ6BklPY8yvDXINXGYzX8je3Z1fm6oDnajaBdM?=
 =?us-ascii?Q?ox4Y7y3+enrjQP0AiwOqwRRa4Tozuia4mYsdvDu0LJoxxXaX8SpmrdReMNFU?=
 =?us-ascii?Q?bzY23dc5K7L9j3BUvEdS24yZ5pxAEKQXFeMSwD/4y4FhbNjCb7p5D2joGP4L?=
 =?us-ascii?Q?CQW4v7DBwMIRqx2FIFkbi9Kc3wgmK7Ihcvcd8T88YRhkpERKe5Z622tlnJEP?=
 =?us-ascii?Q?ltRhFyI2g4FidCa8/DR6z8YRmRttBLI+8NFoI+/XiBzMz0WB9DcH+qxk79Nq?=
 =?us-ascii?Q?ZilORkRZ52tvlJn5hicjeaAtI40Lij9Fp/TnJ5i+I97Cn8LFchijJIzxwTds?=
 =?us-ascii?Q?81WWd6dPBCUuJ7S38qhNaTVJgO+7yTG+lxFauc3AYo+ozyhPwef2DgU7Qdhx?=
 =?us-ascii?Q?XeX1pj5fQy4EcGYo25KamOz+vrS/aySoL4LJUJBz0xB0WKBcwNiGyWYIu70a?=
 =?us-ascii?Q?wgYtBEFfHpNFnwB8p3f5OJGsvNzscFgFOTMW+Q0rkmoSxy3v4kXg5K9eewR9?=
 =?us-ascii?Q?XNy18Aq0O89iVT0RHhtSWtY=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33593b7-80a2-4b47-ec22-08d9f6b6a45a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:24:15.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fB5+bs0AvfKL0gtm2JSoaum5BmFSfKPvEoVG2GwxFDIMlfXm+Iu3m2xbvh0Sc9vqfVMOTfyIebKS035fS0Lt3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5898
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

