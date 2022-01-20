Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1FA494ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346283AbiATJgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:36:42 -0500
Received: from mail-mw2nam10on2121.outbound.protection.outlook.com ([40.107.94.121]:29281
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241681AbiATJgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:36:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBtYaAXLEEqd3aTVTGAzikbp995tb7Fr6w4nhN1JwuBdAu3Y3MJKOmiVbTj8atCR6pBttp4RikLWlSDf7qWLya69+zKmNJowU+6thNrSjDJyLg2ffZqvmlQFGqbtQH8LTTs0yJn3zflOgf83jjaxLpeD32Bt4fwSKa4C/M9wFrmC9qD/GiN1f4LOnvFRjdSeqTr2aOsRlz+WvM/hzbDG9lnv74OvUZzf+8nQ8Ji4iVfsT4fczLDtcJpNUyZcBvHcsLC0bREOE/WB5ng7AA4xUTKkYu4VpBA4Q1O3YvmkmF02e4ghhwJZvZMkN0HRyiZwfAVvs/fNgm49OQUoR90DEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9MW4bqoImvx+fxKvPf3M10JcKtmBGlmTCpQUF2ucyg=;
 b=OovYn4zQ6JWH/EkiKhQN+cE4/RHEfJ/u/Xpc2vM6r18QOBoGdEXWsGyMirtNa3hRWuDlhZEfNqAASAPkWblof2qF3C9369VgHIGVPBKr5qEZpsd591hg3F+Le3SedA70/4wjEdO+O47aLPMQUfHfdnaUT+vhVGc+h1sXs9KmBwDa9RvKI5YnpuboeszfYMIuZtNhygCaE6RtnKsYneT+LyWY13daT5n4J9urRqbzDsUETjSuBwtrLOMQrimuGFgzoN5JXhLpXV4kIWmgxyP3WfX9PXQuvygv+ty8jv9SQ05UZbL3Gu8RMECQRFj52J+IlcSsl9mkZmQ90mTZXyVA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9MW4bqoImvx+fxKvPf3M10JcKtmBGlmTCpQUF2ucyg=;
 b=SOGwSAbn1JB11PLKDL10zueUwYvbW0TrnjsdI2HO8tRzvoh9pt8V54MqEkYSKSU/0wezl2ARg0xzAej7pprPcTVRcRS5buIkKPuDM8oljO2TN3Q907J4yYJfNEU7Z+ozW7t9e3K7G8ZkMTxdTUBTfiSJb5v3EQid/96g82Ocwm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by SN6PR04MB5374.namprd04.prod.outlook.com (2603:10b6:805:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 20 Jan
 2022 09:36:38 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941%7]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 09:36:38 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Thu, 20 Jan 2022 17:36:14 +0800
Message-Id: <20220120093615.2026590-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0121.apcprd03.prod.outlook.com
 (2603:1096:4:91::25) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a1e50bc-233f-4d02-e4ba-08d9dbf85b26
X-MS-TrafficTypeDiagnostic: SN6PR04MB5374:EE_
X-Microsoft-Antispam-PRVS: <SN6PR04MB537475FB20FB4658031C6CF7C75A9@SN6PR04MB5374.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mp6z4tRN5Tpbk7obuLN/QRB59U6kEh9CjSET5jyE6pDKYIBD5tCNOY08Inl5ZU/soS3T6dXn7Onpx4CrFhz7L9oeqIGFRQXOchMnQcGLIV7zCNuOPCyJIdrSJxOI9J/QabltHZNL/aWFh5/znaeqepGDMHMIDqY3gWJfC92LDPHzH1KM6Pc7MNjg70PJjoq4jAS8N+7ahYErrYljx2Cz9vRB/1wrmdoQoJl+VocRQfhZOImWz0ogQ3WelHMuK4r2MU14SoU2TaSDA88dkwrcibxnnXMtiYBzzVXhwZUf81qv4JYaiLWcvDQY9Wn9FKk0q4ZhOuk409l3A52hoQq/cDIdIvi1eRW+qWzzBJ2LA0WAXACSZza0Y3dmJADy93lumO45hrlHmPt0GxE/TCDprxbb6ZYLAT/8Ync4jWuzgTym3FGCdUwH5TjsSUlKLwxKLYghq349SCrdOTuIlAI0G/e6pGkBnzfH/ecXPtBvv3mQQ7kh5L6l0rghT4M++wu39JYDYXaXAozpbaNDHKBWdDXeJvWjQW6Vvb20D6hyp2cghg4tJgjrkqlTrXEldX/IUJ6ikI0pq246bNt30XM6Xvvnvu30PfWoMQ7mShW7R9FSewvKXBkgQ4f0+tS+yIhqUVtE6feNCoYO1DcxWiVmmh/7idL3BviFokuRiwU4l+TUtA8FA19QqUusAnSqzNk40XrkFro5elFecDKIUxqIuHLKuGgaatHC4q55h4XgXqv1o+bFoFRKYg5ic7/IpdxSyUrDUbBV81uEBsSLybASgefIo7yS0bX4PRBWlFleU/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(110136005)(2616005)(6506007)(66556008)(66476007)(66946007)(38350700002)(8676002)(55236004)(86362001)(508600001)(6486002)(4326008)(36756003)(5660300002)(8936002)(186003)(6512007)(6666004)(2906002)(1076003)(38100700002)(52116002)(26005)(7049001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+CLXDsyq2u/eJ7IunN9PcCm8biYmokudUH4NW2AOrwu4IzzScJbUPCpZtFwt?=
 =?us-ascii?Q?b6rtCOXIjiJjPSo5NJt5/WcvGRiKb2Ocaj2w3Bqs6VNQlH43t7Xgnk7hFaHP?=
 =?us-ascii?Q?e/xPCD1dn1ycMXP70jBHetGCeGZge0YLh3+EqTObt5MLK1ROkZnyIcf2t1C8?=
 =?us-ascii?Q?lqy8TaLxEIfu/YzgPPo8pbBHk3EOoYgqSqBmjQxFWJmcFA9M38Od7EJvGS8b?=
 =?us-ascii?Q?qoo875AIHW8tPfCWJOQb4mK6ON0AKgdVBTMwMdAyVOc09izqtwyl6K975OTY?=
 =?us-ascii?Q?XcvsGFsMFHd5Yltnv8VSsYazsCViNaEJ57W8BT3BfadTXphIs/ge21T0sDE2?=
 =?us-ascii?Q?Fb2LtnLUqt/WeG9XBzHjCeHy361W1JS8PNLrmliUALu/ouIiMk0POdi6aYE0?=
 =?us-ascii?Q?Qvv15llyvoRfxAX9Fz59M8wh7DlAo4kKVtm2WRw0r9eQ/ShqGK3BVpUQrJ2o?=
 =?us-ascii?Q?xKuTNxU1TLu+RiAs85H+nx1/JSNi817yc8yOF97/bPQLUj6RO28qfsdVh3tN?=
 =?us-ascii?Q?d7NQ/+z4VfRbttP46WYQoviDiV3onmirlxqchyczRmZYEc4HboONQGV2LHc8?=
 =?us-ascii?Q?sYa56rCrdP5RhRKm5VQDDSjrKSRzYk2k9gEGYkoVvn2aU4+wKkkEUd++rwS2?=
 =?us-ascii?Q?xca1EBb3ziRAxzs5BenLi8O8B9jHrudFAzd7/0aedaG89Wr/EEApa1H+bUS0?=
 =?us-ascii?Q?29OZFhfSMF61N+E5o9b539Tpl08XpdUSMd+9r/yURox0J+kFXmVkCojziSVz?=
 =?us-ascii?Q?tOzAyLuNjTkFo4gd6DSYYnGB2zRKnptxoAy1FX2hTYHDCRUNfkLCaBShTcwP?=
 =?us-ascii?Q?4V/N7HL+Bq+R9pDS9vFoUUIOUm02dhQz823249WTRM2DxAIBVMUkYBWjl4hr?=
 =?us-ascii?Q?RlJFU3UGaOs3vUr/uQwHOmYvKUWJ6tpbKaSe/i1TZ6P/zWTJGkLhfj+MjBqN?=
 =?us-ascii?Q?1/wqMnvNrLTVjpzFwlvzV3skmXfTQ/Uov+mNW9laAEFb/HMbAefesedsvbAs?=
 =?us-ascii?Q?pjAb6j8TvniCe2vKVW2SetwUgLXLRdP1HpzzMU8RmykwlAb5dknLkSrN4i3m?=
 =?us-ascii?Q?KQ2fTONTrDxfhpbd+u4Zz8ZkEPDpu7JXekwvJ23rBBJcuwQKGa9AQyklGZF/?=
 =?us-ascii?Q?usE3YvTggvGievCSl5ARm+Fuyl2VpM9rKPo8WMjbYj8z62atvS0Kd+ZOLkX/?=
 =?us-ascii?Q?Qs1wE9CPPTjHeGpo/mU2DuZaYkDMKVFdsra4gnhuEfDxu2PYuh0hK/+ugZFe?=
 =?us-ascii?Q?cbDydrxLeuVq+U2KCcEfzniMt0MZuGHhx5b4ZVWrGKFxdOWHd370EsPeBLWS?=
 =?us-ascii?Q?6Ep9FQBortE/KGC5P6zOOoR64V63yZ0GSIafmbyAegGTxlLc2b9ZNNuMVhSM?=
 =?us-ascii?Q?/tg28yz27+4yfZuSYz48fweeewE/EqNaOlt1FMlu7j51/SuMq/PWCF0jVr1E?=
 =?us-ascii?Q?EPRGigzmXzYwVlgPulXO7tbU6s40E6Ts22/04Ue6OB3qZPORXZedxa0ont5x?=
 =?us-ascii?Q?lLB2YmiwUgMs8vruzeQ625fg1+fL2i/oopDIhiCLMXiETHb+DwtI8ehfObHD?=
 =?us-ascii?Q?mwB2q+5aGbGWW5qdO8V46J+BCPZx8ou/7u5Ym4UZwvjyW/oBqaCBUFD5EVxJ?=
 =?us-ascii?Q?YY7opY29HnwN9J830DV/aOw=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1e50bc-233f-4d02-e4ba-08d9dbf85b26
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 09:36:38.1033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +c9/JrdKyI4lLm1q95xfaFPVnz+k1Zbn6kThmRHPHTzB5+xIiuhg93OnWCFyp5OiyHTv1I0vK1r6dPjvSeiY8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5374
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add analogix PD chip anx7411 device binding

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

