Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B455E256
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiF1EtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243952AbiF1EtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:49:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2093.outbound.protection.outlook.com [40.107.244.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326D6DF27;
        Mon, 27 Jun 2022 21:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZcSkJdGC0K/2mYdKJidteAxfUzV6+A/NKUlEeLTiqGvKrr/OYxU74ZpJfyRydZrHI8gl1ZiDX1XhpZds0ZmFa/D+k+1fPKnDDKSR++3HWYGfaKP+GxxHbbQu/v4jjyOOit0IsbaTYf6l8LT6OXBnwyQJIgUlHAoL9gWrNO2zrC8YMYc/EHhJ5GTIe7NuQlbcIYMyymM7PatgkFmo8xYtQxMA86Nk9WzkeLcvJC1JuQlrEHq1NYt6YDmMl9xz5UCCTkQLE2Xboha1ZKao2LnsT0r0Q8PlVaKkC1wI8H2SWwz/xsLuOyDFPcreu8Cw3NtXMUaCrr7/GUTi4TLmc8MVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=EUpyI+qtv9dZBIDHZxhux4wmxwh/8fI5MnqhRh6uC7/fkpYByBcU8uP57z3f//jHs9dsBMcCiJ9Gt74rgwz0Iu9lgupud3XrhHjJ0jryftgpj7R6eIM/yP7fG0b0hDF5m7/GFJdYeBI/fW8GGyZYeaD5bdbhD34F6otSqFsf3nUeJaOutT+hdDwlxneQT7F3Yy9ib653/5/46pUQAG8Px2/V5/Ag03CptjHbxy+Eao9jZ2sZpiJYPj5AO6zpNleZecGMzB01MOcXMaoFhYtQyWo8euxnwk8MHOs67EWNHNb47RVat5hQVXs5wIfKSJM73iS5L4NsYYUbDeLfoJak5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=FoABGHQMjVfWqoeyiteGucn2cOnzMLQ6Hs/v1orfCI46BY0OwlEys2GZ4argCsblKVs1abyHmHJmjQsDKoN9W7uWLbzdrpmO/pON9jS+O3uMTZ2h6WbY2lpIeUMFJR8IASDZZvSQf+1qoogDbFgGcWx3QnTxGdZXK4hwafwixcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM6PR04MB5724.namprd04.prod.outlook.com (2603:10b6:5:163::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 04:49:14 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 04:49:14 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Tue, 28 Jun 2022 12:48:41 +0800
Message-Id: <20220628044843.2257885-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628044843.2257885-1-xji@analogixsemi.com>
References: <20220628044843.2257885-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0020.jpnprd01.prod.outlook.com (2603:1096:405::32)
 To BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 718e378b-cb21-45e1-3cf6-08da58c18ccb
X-MS-TrafficTypeDiagnostic: DM6PR04MB5724:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axX8QMpjG9V9yrO5eMvomVfAfHwkhGa58grDR+5CSH2CUTevT12RwK5548esqbKF0xMZO+gY5vTWplkxm8Hx74AtaT0Mqb1eFG7lLpwR5a5ZYwwm9PIH0Fjo8jQXV5eG+cDhy6yRM7bFxUmFVUf0ZuXV39yuYnYnWmZkcDSjfolGGwWma0XuqkWAeEXCjfAYJrWIV+AZ2HnKbolL9dqEGdmAfpwOmVAVUWxoiOgpy1qsCduaWXt/gr+cea9L6JqGBQ0tnMqE1Vsn3ujXdGpKr8Gyfd0TVp/PtSnRQ/r/AkJSxH4B3oSDyPD4fsE1FpIvnmIeQI3n1w2qXI1+DH31YGjifS5/kxuJPd39IgfymfLkSFNbiTb4TZu5ZP6pOAimQT4IjNeQ7vaA+yOQ7/YCOtFS+0VVpjY7kjah2GwlR1rysTs9pw2m5XgDGVtsNR/3gYqmQP33rbzlxlF/PpBT4tkod7KrDIVB7j4nTEWLWEmjFtYYjqeNa/tYAZZaT32p6tXpMMWi3jiaw9aq40nowmwV1ymiFR1oSh8PvUlGweHpDIHRn7JghorDpGp+ahsPFfUmaRjPkyI9AP/iG5TtxKHeVeqIt0hBDLYU5kwLAkrr8NWsNjbJeqO0wDOLM9MCf8i30NoJK6EdN41BPtxqdpJaxSvsP29VF9KZA9Ibb+rmuQ0+Km2xGIbidxH32T0S4gD4+8Mi0QF9+qkZmSLYTZk/x3EIQ4hoKq09spqQViO5MD1793JNd77aOADzzahrz1wx0Ohf6Lpr5SxsuhkFSkVhgOQBNYZIPBP+Ujn8Jnsm6ahWmewVQlsnEu04SE+Wj7cl+66qg/7XZZSQuR4jhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39840400004)(376002)(346002)(7049001)(6512007)(66556008)(52116002)(66946007)(316002)(66476007)(110136005)(8676002)(4326008)(26005)(6486002)(5660300002)(55236004)(38350700002)(8936002)(86362001)(2616005)(6506007)(38100700002)(2906002)(1076003)(6666004)(186003)(478600001)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O4cAHgvXNcwpLkD8e4It1PQZ4iS1EDCGoI09t1PF5FFuDxKF/4zEJuHoxXUe?=
 =?us-ascii?Q?cpf2BKufN78VmRGmsrGH0aSwLu7hhENDcgOLzNCGrQU36LrTX9NM5wU0nEbA?=
 =?us-ascii?Q?36EDJK5OxjqzAN90Dygg/sAZho3xkXDgT0Ry9Qpn830a7/PbvZC6/O3cV4Nv?=
 =?us-ascii?Q?/fRMU5ElEaW83WyTHQgBMUr/jZ4oym7qwj/YiywJ63owpNeNAQgLxLdOgoup?=
 =?us-ascii?Q?NmsZeJDn7Y0wSZFtrVuSwJJ4lXkRdUQ+2H0R+vvW0YpCm+m/z8KgU7Ryx5jB?=
 =?us-ascii?Q?Aw3FQtEYf9hliOv3G93V7L0zI8BrLBHcRLmhzzat2MqgmavlD/LN8YWhhjak?=
 =?us-ascii?Q?Ji6Q7esPpFVkIFfQXsPQNUqFMOHouxEYgbRaZussT6WgWOoRRqGT73f1MMzw?=
 =?us-ascii?Q?3oDN+oLlU2ai9NmQR+njkFqV5+0vxrg7YpqnPw44xvhVt6tVVWlT5nYt/Wml?=
 =?us-ascii?Q?kummp/bhD1RPxjebgPApnqxOoZIW0W5c96JGKwdxtDUlk2dSjpoRfikQxHEF?=
 =?us-ascii?Q?85WHqM7MAIso2y7emz3n8qbX8VC71g7kWm1mveHk73frbTeX8Un6KOms6n6U?=
 =?us-ascii?Q?Rcvm+c8PoI08i54x9csYdqExzWtMbWMFCs82WAlUxNcU1bYmY/ty2TNp5J04?=
 =?us-ascii?Q?gSXS70XdMET6ASw1xr0xKPR2gj4qMYuxw8VUGmrPeUrfpsMJRoPc/1TsGfpz?=
 =?us-ascii?Q?iasrl/DkLnx6ndXZUTV/siFiy08l/wRaUG33hGO/EZlhp71nSFaqa7TtEPdv?=
 =?us-ascii?Q?atjXo0s1nCb2S6RWgMcA5oeMkSEdA+nC8CNKGb7XKxhfFVmU/vlrT1hFMQb9?=
 =?us-ascii?Q?clhIgPvURcFo4K2k3DD3m14jTdIz/0aSJJiEyZkiCBrSsHzcakwxXtx3KcqX?=
 =?us-ascii?Q?4RxrdMRtTehsC+JMVevfzFcv10w7HR8AijcFNyZO0CgPsjfhPonLVGGo0FUm?=
 =?us-ascii?Q?6S41oGZ+qtVpaYMmxANSB8XLq2ZO99jwF9XwQxZGjYU7DtsetVn8wTsSaB6D?=
 =?us-ascii?Q?DnPik+P+4AbOJLKief+OlL2IckrAeZZGhFb8NjawMS+UcWF4JJ9jIwnLJE8X?=
 =?us-ascii?Q?Cg8faK99U5ZMAMUQLA8o3oQ7QtM1Cd0jEznmR3mJ+O2qlSXOpGXgFgvwI2jL?=
 =?us-ascii?Q?NV68SODEAoFAT9Gg6b1mZQ5c2i3A4xqkgWAqnGlzIeKDEZCtBxycwgziUihP?=
 =?us-ascii?Q?8gRxnv0+PTrug1Ev1x3XktSORr3xFVeZmQ/fJtE4VYIMhi3vPAV4H7tf9vGy?=
 =?us-ascii?Q?mk3K32GMuV1OkKGeqsG6GDcwzugJ6HBt1y4EA3f3AA5GAtODaLvq77h5Sm8N?=
 =?us-ascii?Q?G3JGgvlvjbVgmImvCx4CakQZTYZxVudaPlO7V3v0EdcImD6IbBurkevWDkub?=
 =?us-ascii?Q?GlaAzAtCvhVtj8G3BTCd9npou3vkQjQhajzeXl5tfQqERUcSe5fRd5+2t2qT?=
 =?us-ascii?Q?Md1oXOhyY/4iIeQrpVmttFGJRIhw+sP7gLJIJlWE5yyh21Vz4vGK3A0Twe82?=
 =?us-ascii?Q?gLP4B0u4O45RJ7dW63nb3fAzNa4v8pXbvu6zExDViYiyY+JCAZRURXKdsHZ3?=
 =?us-ascii?Q?PCK0bJs3BKHl4IPk8IbkK1fjBf5sNhcI0basSsLW?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718e378b-cb21-45e1-3cf6-08da58c18ccb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 04:49:14.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olWFXjHSc+khPlR76TFod8OSKiGfuYKAeMkdRtBzz6lnjg9uoo9H3oq5iIbg1e9MzofbA1BO9Js9YJonn750zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5724
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

