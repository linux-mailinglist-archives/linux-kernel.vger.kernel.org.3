Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92193567776
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiGETLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiGETKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:10:53 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2136.outbound.protection.outlook.com [40.107.20.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A13B21824;
        Tue,  5 Jul 2022 12:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUW0fC8GznhUbWwygz6eEIEq983xIPuIekedxBzoNfSZwA12zaF6ZqpMVOW5YBXyUs//Q1HNDzUjfTHJDGtYR0aA7UW1/Dqli9irCVWjYDRZhmMkblzaz/2Gb4ukygcw/DW0lO0vsXztJgYhArFP8qrA584pqHlhMBwPnw6V5N0TajiC9q/fNWge1MFrHpHcXgeuOf3EnPIws0484hgTkL4akF0tE8Cy8bUCTay7yR5cU73/3sGnVo+Es0yRPHC4gscW0QEyhh3RPIoHwm6Ikr9IpljBUD+VhYLSx1RoSED3VS50XatUSMTlRwubn/TN/Chg1J8SCU9Ip7otlVvvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlfBjHDAy7eAFf6WqwTAlx17ua2wrpJ88V7rBCymx+Q=;
 b=mqJr/3b+mQds8kEUDgxLawrCVNzUDkUunfnMOoI27snanXIPr8R3PvWSEOQjAtBwYTAJDPfpJDQwKoBMz/LfM85q69oyE8QAbMQw/P0XParQfV8PpRcktDi8gh0qZGYqoEwxJM0h/JcKT2Zj0fWvwKSUXZOoM/jei0POx4KUUOvf+5KNbOLO62FEoi8ZT5CasikBt5O3Vm6pgqgnVMPQ58UnPk0OiLwovymm1U6rgoDAILlYzF+VLOVymdHLN8l55/Khdgo+coaMpVXl2KaJnQ24xupwQZ/Dp6p3OSdjwq4jwH7txd1pcujGtOuBN3hEGq8F55jnfkzx8CHsxcCmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlfBjHDAy7eAFf6WqwTAlx17ua2wrpJ88V7rBCymx+Q=;
 b=G049wLhu4VoRj7v23agP5YoyY10sEN/gbF9/5mGjTy/hPFno+x5C9gXgyRAlv+QIpVJ+l9yV1QVmEVgpYJ/89ExvyuD6ghL050NLqRoE+GzRzdhwrsEfCA4G8ILJOEb6KYn5ONRCiMlsNR/oOquiFKogVvmfb7CJTm/693pgmcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM9P190MB1426.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:3e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 19:10:49 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 19:10:42 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v10 1/3] dt-bindings: marvell: Document the AC5/AC5X compatibles
Date:   Tue,  5 Jul 2022 22:09:19 +0300
Message-Id: <20220705190934.6168-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220705190934.6168-1-vadym.kochan@plvision.eu>
References: <20220705190934.6168-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37a2d4fb-9f35-4fd4-6933-08da5eba0e90
X-MS-TrafficTypeDiagnostic: AM9P190MB1426:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oa7zPGgDFDm5HCVt6DNUMsjxpsH8hUU3k1bBAQSyZmSf8WXWjEunY2oTWYTUIAny5kz4+kHGFRdZkYqKMRJQ6Cav1XcUcxbLwTGtiNwAe8M/N2s7QoNKDRlZBjgm0ZXjn00VZDDtHZ47IufQYEUP7vJuilqgThdNn6Et/7ufrZEVUOFUl+wjrJjljjvBu0Y5DWD8qDav+p6S7HYfr7QKOQitycRfnUfiWprJjqy/DN0r1Tr43OWijjbi/pTT5j6GvcWYxcvlrgGz9VCUW/x/S8OzRCsFKb1AqM8PA/et6f7Et1+Tw494wrbt8KqepfZ9w0DuYCxR1Hb78XX/yGgHUs4wpmU3DvohxqrixDWjr7UdBr4F3lWozT54POTkyiFLWf/6AuPd61pnUP1idf6UtOyfoO9gYKQy8VC7zmXVmmoFDcJAaIEnzVCx5Vb2Xfp3nEHn62eA4JmmFYvCJehj8BATXt0/2Zyu+HP+EphsoToIoaqEqiNbFPRXktxS0Ocu//08lmSEeDw3lMtlIFZXZtRk+4RGprZ+bveg2Nu33uKAtEkoXyEhr2iHNRADt+KH16vIkRKsjhaxdqugWGc7W5eBQrNqr464xU/9baATp/x7thRA5/UE4rmRw1Du4/S+MvY16TUZpGXqBzt0a2B+9hjDj2qi9wxBnn6JwhtGeKHlDkmvHQ3CBDE/DvHBXLupvAS+NETIcIniDk+JOurq2/vIh0um99enu70WdamTCVOOKvrVm6UdUt9FLgB0kSeLbjF510bZRQK3+aHu3i/8bQfftPGYq6339MyS5yUzWzgqM/e4idCye49DdQqw8XShlsH6bOefThEBLwyMB9zWimk7R74yEKMzQE8nvznML2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39830400003)(376002)(346002)(136003)(366004)(396003)(110136005)(6512007)(316002)(26005)(41300700001)(6666004)(6506007)(52116002)(478600001)(966005)(6486002)(66556008)(66476007)(66946007)(2906002)(44832011)(4326008)(8676002)(5660300002)(38100700002)(38350700002)(86362001)(36756003)(921005)(186003)(1076003)(2616005)(8936002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JUTh2Jmv7kihGysB5+nV/RFtjBXTHRdtVl28bwySY9AnxIUpmSUdTp4CJjcX?=
 =?us-ascii?Q?a9tD93h+PJa5rSnWIiNomzshFSrdYJnHozgdPDy1M+BTiOwnW+ofW1Fu9KzU?=
 =?us-ascii?Q?BWRZ4Qf211GnItCrx6ap/5D08DZiFDFt7S9107oLGcEEKLZtq7uV8PM1QAID?=
 =?us-ascii?Q?CF9SRBR+1bJFOQAwgrdlKgNq6DnFiLJp0XTM6/GjJOvibZ8SPenJSHB8CPyg?=
 =?us-ascii?Q?hJ8oVTglv7s5AfCxusjtz7cIgU+dAKBspquVb9BayaDEdA+g/cN3VE7qAoQG?=
 =?us-ascii?Q?jPLS2vgz2+6fDY7MUrEd9l+wiRgr5kgiJRWesUacaeW7ZcYBxfk2vIbBmxMv?=
 =?us-ascii?Q?XRkzdtMhuC1PNSJoy2I6MrkruVCOyhLhgIbgn2tUwJhAI47kxGyvBWQa0dLJ?=
 =?us-ascii?Q?DevXWg3x+GMOnycFwh5tiYPp81/hcYpF1S0meXyxTD+SdNXtajneYplnpsp6?=
 =?us-ascii?Q?ydgg7tSwPbHbZbte26pPXDAMc7MZw9XHTQWZJMJs13Y2yPE2Vc03FwY0UWBT?=
 =?us-ascii?Q?5KzUZen3b+q8mVOJebANSwInNJJW+TxglTEVYOsTUnV1s7bv/5zjNT3i4eTR?=
 =?us-ascii?Q?8Zxs4ZtqqBIhL5LslAZzJgSoveilBu3ehqYJ5Xu5bOqYoLfnBv+/KQJ0SsOp?=
 =?us-ascii?Q?MF8kQPddwdYk5yDJn/Iy56b+876FEBeXIK8SFalLDGQad2JPM6KgaS3LQ7Xu?=
 =?us-ascii?Q?0iaKCxlwnX2GD61TbvnJf2xnaF2O1rrXkq7wHatzeB0DxfcTErn/x3Z1Vq35?=
 =?us-ascii?Q?n8pINd0NaN6kM25UtnSu+Ld9v4K4ML1/0ZrGSbUcbY6QaGS3C5Zsp8GlFqdI?=
 =?us-ascii?Q?QcBaMGkGRotACUCZ2uVi4DmvhKBBbhrfLimKGaieIdZfnVE6F5BgNZopuV3+?=
 =?us-ascii?Q?t850457ArE6K4Z8KJolq9hmulzptjmfpDHBveK40A+mdUUPPZHYBx3ajxnW9?=
 =?us-ascii?Q?ubtqmYpuw2GtsoPUyLGeSEUzHWHXrNVA7jeHiaXTGUbTaZAwNF/rFn/uvggV?=
 =?us-ascii?Q?pFdwK+fRitCdXiiFT/lberok0gTuZwcGzAqcl3lkxAn9qYFd4Q8G1oEUnXet?=
 =?us-ascii?Q?i/rQeo7/awnDnV2pBTbFqh+gNvRubPOlSgaK8M0vatcJmMHPqGk01G7X91n6?=
 =?us-ascii?Q?EEWgT7sDfbwPHylGIDfVeNur/ga5qvBX0zj5l+iKbA1fmxkFQjcWp2hctxpD?=
 =?us-ascii?Q?ks86KiG2I9rQJiMsEM/2iBxXXdX8ILF218pNwSi58ToaWCliJwOCw8XrN/pd?=
 =?us-ascii?Q?qVJib+f1D/w2y/G3Uy8lz0nYnXKg7/JsgyyNK7IPWc85ePinLQweCZsrNE7P?=
 =?us-ascii?Q?6OGC17ODFyWLFTqFSG0Tqz2d0pqstzqTD+Z7GNlMHrJnXmJ0A8f9RoeMjH6Z?=
 =?us-ascii?Q?sa0jwV8XGQHU8jEZbz5OElHSKcHYYZMlYcQbMzvOJSoOkA+8E+v8UPT2eDTc?=
 =?us-ascii?Q?wl2qs1T2gRagczhzhgofPh/C10DUxm6dgz6FzJvPNlAku4SML+0x77dPNTTb?=
 =?us-ascii?Q?GsVXV9Ned46HN79IRx0ijxWst764f7MJsq9fTEoS1CscHN7Nf0YlIHIn8APU?=
 =?us-ascii?Q?NoE90GbQY2ehCIGDj93rLoADjUawQYu5kyOMjGZP7qGqtst3Pu8U2ueaMkPF?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a2d4fb-9f35-4fd4-6933-08da5eba0e90
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 19:10:42.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZ6kMM0IEwlK7n42oScq//wq9Gg9PtsOJ1LGQYZVJ2bKjHB83Dp+jZ2qileXBUBjcWVyDweaM65lypRCiuBkQAsKhFIxcncPmQYwcOlf8B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1426
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

Describe the compatible properties for the Marvell Alleycat5/5X switches
with integrated CPUs.

Alleycat5:
* 98DX2538: 24x1G + 2x10G + 2x10G Stack
* 98DX2535: 24x1G + 4x1G Stack
* 98DX2532: 8x1G + 2x10G + 2x1G Stack
* 98DX2531: 8x1G + 4x1G Stack
* 98DX2528: 24x1G + 2x10G + 2x10G Stack
* 98DX2525: 24x1G + 4x1G Stack
* 98DX2522: 8x1G + 2x10G + 2x1G Stack
* 98DX2521: 8x1G + 4x1G Stack
* 98DX2518: 24x1G + 2x10G + 2x10G Stack
* 98DX2515: 24x1G + 4x1G Stack
* 98DX2512: 8x1G + 2x10G + 2x1G Stack
* 98DX2511: 8x1G + 4x1G Stack

Alleycat5X:
* 98DX3500: 24x1G + 6x25G
* 98DX3501: 16x1G + 6x10G
* 98DX3510: 48x1G + 6x25G
* 98DX3520: 24x2.5G + 6x25G
* 98DX3530: 48x2.5G + 6x25G
* 98DX3540: 12x5G/6x10G + 6x25G
* 98DX3550: 24x5G/12x10G + 6x25G

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---

Notes:
    Changes in v10:
    - Renamed yaml binding file to match the $id
    Changes in v9:
    - Renamed $id with "ac5" prefix
    Changes in v8:
    - Add review from Krzysztof
    Changes in v7:
    - Add rd-ac5 and rd-ac5x boards to binding.
    - Rename to armada-98dx25xx.yaml
    Changes in v6:
    - New

 .../bindings/arm/marvell/marvell,ac5.yaml     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml
new file mode 100644
index 000000000000..8960fb8b2b2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/marvell,ac5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Alleycat5/5X Platforms
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Alleycat5 (98DX25xx) Reference Design
+        items:
+          - enum:
+              - marvell,rd-ac5
+          - const: marvell,ac5
+
+      - description: Alleycat5X (98DX35xx) Reference Design
+        items:
+          - enum:
+              - marvell,rd-ac5x
+          - const: marvell,ac5x
+          - const: marvell,ac5
+
+additionalProperties: true
+
+...
-- 
2.17.1

