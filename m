Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58C571259
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiGLGlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiGLGlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:41:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2115.outbound.protection.outlook.com [40.107.220.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2C959253;
        Mon, 11 Jul 2022 23:41:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy+h2sx5wIM/X62FxyayQKI5Agqs4EAeNjXZGpd6ZiPqEckhCiYrvFUoISg4JEjHcgOt7fw/m91PH22II2NaNFJrCFW+qFo59Ng4F4mHtHuI6AI+Jr/RJqjFxTuHVoA7KgD0YYENyfnK2mtBApHm5fCtEPFSDE439hnO08oMFNEjG53N1X1L2I8RxSQsFae6VSU4zQ0/popDXCa0+8MRuZnNt+LrrEOTVBQTeceAuQN/i2kNnsaVRVR99y1oaA9y5aCvZHZG9FYi/w4qBHnwYUMAo85DiSbFgBjWWquWsXBh97DghufWkPcMLSyatAU4gprUANw7JXTQs3BSn1wYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNt7iIU9Y/Ty25n/uAU1tIwBPqXeI5YIvYg+W7IPePY=;
 b=SjO19Emr4hamuVnBimu4qyupRQAtyH7jAlG1+nId6UvRHIPlGMBetwpe9F4WpUXRITNAXchmz5BT2IF4x/fL12H6wiHABUs5bzlzQupX+vBkVR/A1YBEveNq0x0hTFchTpb36W7x4NKJNnb9xmbuIyBAQ8002q8O739VsN6aTQOI8qmZnqk6RVv3R9JLA9+PKrJP3EsJ4QStzLrHw0G7ZXPgdqiaStzAtiTvaUn4W7wHz4+gMXaXwEiWHN+tNTXC7Ql+sJXv3Y7W+Z3WfvNpK+t75awM/AiCEbSd0HNwQpUQIMFxUU2rVMiDHECHYeIyRp55BmxwQUC8TrrKayCCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNt7iIU9Y/Ty25n/uAU1tIwBPqXeI5YIvYg+W7IPePY=;
 b=f24G+Whc2qqhdcrPGDNWb4YlrrZKvseDqgxQGnHPXwaSEcntXzVpECQL1luDKlJ9KbFWgMxrr5/wgTwthJHqpoUcoPBcFUJ7i2Pi6ObDYfRvMl2MNLgfvKD9Yv5/1AHcCGvMzckhMzwlSlWxFwf9YBZVHWUz5sGZ9/JAKPOmcNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by CH2PR04MB7095.namprd04.prod.outlook.com (2603:10b6:610:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 06:41:33 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 06:41:33 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v15 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Tue, 12 Jul 2022 14:41:10 +0800
Message-Id: <20220712064111.2782861-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712064111.2782861-1-xji@analogixsemi.com>
References: <20220712064111.2782861-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:404:a6::19) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d555cc7c-69ff-4211-9911-08da63d18f84
X-MS-TrafficTypeDiagnostic: CH2PR04MB7095:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBLhqRy7OVgjM8fqFXrpUdBtfN25W69WDufEMocPDJPBXgdd7Xsmn4sOzWhqHYryBnL5hZ6CLY/N2rXEcbOiIWduZwDbiODmTHbsOB/CBmPXHCGPingtLgW7IY7Zc4vAhTDtjr+GiZFb5lhh38UsfQhh6qXVUfPQm7SJT4FC5/cFRvYsA6nA2k5kePdXDQEUPpmzwhPgXUmz6ujUfgVP/jclqzWV/um7nIzc8qP/ykiv6996PZscobqQjq30IkXUGMq8QxizMA2ZwMHRkjbPOFLdsPEsc9NXniYVqlsuLSv1ZbBAMZopUYD5kb8Njtgd4lZWWwVinxG/faUkWFvH6uCydagFnAxD9HHShN/tpNYir1/rjOYNz5DgZFcEmT9UoQ7psGdmJVzerjdvwkVMcMV0na7R01vvLBZoNaydU0vdb3R8Y5SzXRRhC0rd5WtwJEFKODHUgWSYkG2Mlu7UhGt4slLcSHMcFrWMoN1Zp2x+UCDefy2+FiGTPSgIism7zUyJdrt6+Po1ZXp32eLUyIPijUTaJJuOMRZpiYsrzZ5uZ5R7HzKKDUf8HIenzrJBsTZ9YjY5EybhWMQiEJydakNeMlGzW9W83OEu2fKBdl/Dv+b6MtoIjzbtrY1/X6C/IKsqt8Hkqs9ZIrcV+sZJUm9qPQJFD2/EkOPuKwtDVXz24CqTTlzdHia+tlXBsKdXRk0b/xLdJW7Dqinj8QNF55mxTGi4B9geikOs8eQL7Yf4riO0gjVZjwHpDN81GdEZ3odCBB7ZWSzDPqObtnEA05yHk+EVV7pq2GRzakRxqZegxfqec5HrIwOBMTiEAaOddq1+KziukbAi2JHChTNlCuFPtw/CUo/eaxoB7gLYda4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39850400004)(396003)(376002)(136003)(186003)(1076003)(6512007)(52116002)(55236004)(2616005)(2906002)(36756003)(6666004)(38100700002)(38350700002)(6506007)(110136005)(478600001)(8936002)(5660300002)(4326008)(6486002)(966005)(8676002)(26005)(66556008)(66946007)(66476007)(41300700001)(316002)(86362001)(7049001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w9DNYeZS3BX62EqLXmFUGpVJh5rZ2JdWk9zHZ7G0j+x47jmx72ukexzuC35g?=
 =?us-ascii?Q?sDzAHlSC6fkUHIwKNGJuCLLUoBlmKsHKjG18bu0HbYzAjLmXEVP1rLp6a+4e?=
 =?us-ascii?Q?kibeNE0sSFfAFHudBlVzmJGIr/nX7Pfu7UA2jgymVi5XWXs3T0CW6tLrj+Pk?=
 =?us-ascii?Q?vDAaJLMP3Pvyz0ta44tnAUBrYUidziU8+8v2muN26yHv45VW9xhyXylAUAsE?=
 =?us-ascii?Q?6cyH+egIXxRRfXvd/oFclvpQYVtQ3CKRx6MTtMTUkzJPWBs/QnbfCVdSe1JY?=
 =?us-ascii?Q?fF3LTL1DgVbGKShG8fXWPSv7FhJaxL8LsrOn0u77CAQPbLq2saYaF9HDhYqw?=
 =?us-ascii?Q?7ychONEfgLjIxiAt8p2QbT6pml//9/mCRVJcN+pPauqYQlPRrnVCsr3UZBsq?=
 =?us-ascii?Q?oAHWU4aNqQlncXE8XrRQsyU1f1OIq3D+aR58rJwlyNAt2f/8B2Vq+POi3Rh8?=
 =?us-ascii?Q?WrdIsz4pAHUHn1mlxQFHWDXjtXIkPxLgCUDETendask/ULARYKIqZ/UGYFk9?=
 =?us-ascii?Q?Nqb5SBWIG8lfUCES4t2if44gAr1MLJOwID5RhknOwQlVYQE1W3OSgiaPxclE?=
 =?us-ascii?Q?btesZJYvqn6mkOufrjxXw53PtBK48FmB5MB/m0FFlZxEBfqu59UVLfFpNcuN?=
 =?us-ascii?Q?U7Nw1iorUw+KgdECwn7AqQ+ns7m5vpxH+Y1XHJbeZDt3Jy5SG+L1PzD6Jqn+?=
 =?us-ascii?Q?0dOipETvndG1m5ZWuFauIUGT/PH50TBvAEJlZF5YLo7VjWzaDQS1IiUmdMrl?=
 =?us-ascii?Q?lzChd2bOFHnIYwXjSqesOMWYkWTNWbClw/+KaXNv4ODG9IVZVhyx1ChomUAx?=
 =?us-ascii?Q?2IA8ZvmCcr6bPyZYARhf9SIqdkK8XeQoP0p2KVbYL6d+ORg5D2pR3KsfHVyc?=
 =?us-ascii?Q?fsjdV+hOFCiI72ounlV6IhVhaMF4Lf8NWGIZdMdhdF0guqahuMkdUIE2r3Ie?=
 =?us-ascii?Q?Xs65bbfDMH4+nF1FnxW7RhzZmk3oW8TbQAHfko8kyzs0XJinWMg1PzYZrk2L?=
 =?us-ascii?Q?ouMhOB3FTX8Q4vGjnXxP+/XDd9j4wHARJa8NJBHi48LJj5BQbNZa2RMaAUld?=
 =?us-ascii?Q?Wsyce0AMfEI52TpPKKYt/lRrnnwKNdPR+liBFNxHbUIZAXAofLkfQorsF9Dj?=
 =?us-ascii?Q?stX1f3RkkBvtfGHZ+fWFZJa1uQvF1wYlnNXvJP9KbCCb+SNi6csRlnP22s1B?=
 =?us-ascii?Q?C6+br3tKugV0aaAQCyG46EIx7ZX3rp6Df9+3pUBJYDv050WUaIXErAN8pJaO?=
 =?us-ascii?Q?s01tizNfYqv2CQXXe/4K6dGXI59gWedsnH9wu6pzba351paNUCVA6mFTgMtC?=
 =?us-ascii?Q?ZqVQyXmIHXnEztFsawLN7yVtfOqpo6/RHAeS1NBSUkV5oHdKvHO6Nc8awh2X?=
 =?us-ascii?Q?1lAvfx4EW0DrOcc83xDNpsjGTkPDV/aU+iRyooWmGBUSNQIIYb32J9GBgIB0?=
 =?us-ascii?Q?DPW75ygdctfGfyOwyMOmiAx1WEZSDUYfAOfAya7ArWCB891mLtORjveTB9u3?=
 =?us-ascii?Q?sZdf8dGcokN7MZIU+hw1lrjVWVNNTeRUufc+n5R5yXZJWbCbrnSOzsJ3kLw6?=
 =?us-ascii?Q?UHBjCtP9iIKftTTHNO2CBGOM7jxpUIT2XSXEh89C?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d555cc7c-69ff-4211-9911-08da63d18f84
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 06:41:33.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puivPk+9LPAZhPM0SHqUKrIaJxoGCoAFpxeQCKFeQzdVgSuaFyU+P90TiTFKjJBRGKtgNsTeodN3VdDnIyCkKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7095
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
v13 -> v14 :
    1. Fix Robot compile error. Fix node name not correct.
    2. Change HEX to lowercase.
    3. Use "ports" property.
v12 -> v13 :
    1. Drop the quotes for "$id" and "$schema"
    2. Remove "allOf" label
    3. Change node name from "i2c1" to "i2c"
    4. Change node name from "typec" to "usb-typec"

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 .../bindings/usb/analogix,anx7411.yaml        | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml

diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
new file mode 100644
index 000000000000..bbd071ba338f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/analogix,anx7411.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
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
+    $ref: ../connector/usb-connector.yaml
+    description:
+      Properties for usb c connector.
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        anx7411@2c {
+            compatible = "analogix,anx7411";
+            reg = <0x2c>;
+            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio0>;
+
+            typec_con: connector {
+                compatible = "usb-c-connector";
+                power-role = "dual";
+                data-role = "dual";
+                try-power-role = "source";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    port@0 {
+                        reg = <0>;
+                        typec_con_ep: endpoint {
+                            remote-endpoint = <&usbotg_hs_ep>;
+                        };
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.25.1

