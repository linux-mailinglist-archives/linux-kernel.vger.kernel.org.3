Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD20543990
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbiFHQuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343604AbiFHQt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:49:58 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50053.outbound.protection.outlook.com [40.107.5.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5B0133927;
        Wed,  8 Jun 2022 09:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsbWlusQkkGH+L+EhkgQuQ1aLhZstNKGGlDk5F2ibkO2pua2R6vD2ka2CIqcEWQTfH129fIiK0W3M50DYNIYBIsU83al2WWxcDzrHuTqwR0Hf36/BehHGFp9yJWWkBUHV7Rr1FFJ6Nru5wklQIQ+aRuwvWi9MB7b7qgfUc1hXmwibML4mfxbNT4wCGJ3m72j5H3/98Fph3TxVsPaXNmI4KnFefXOCGgKU/c9KklsGulPTKoHkWfKsjqJ0l4d69u6zj4cBBCvUnb/O4UJ+eOh5LsC/tMoM5KLL/eQWw77+VP0qhhuVGYpHvJOiLcetnAqJ587vJKBrUvYT/2RkmHxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCUvYlutrwq3hiupF2Fco9Q5u2C1yatrQJOsPCtWWt0=;
 b=A5qcq3fs+S7OYCG0Xet6EMqylm3LS2Q2lHOmI/N5NGqbSLoqpu8aR22CO+FW2U+410ckRnNqts6Gk/sRzcQ2c2cypHHwRZkvZJuAOkj7rtoSR9t3+gfx2hLfay1DWOYqnB7SMzNdskMrLN+Heuxfem4+EW8Ra2Vcw0xwzeyx8VHF4FglqlSdEnHqT3RNM6mkLmE++hp73x2UQWUGIDHMqbhfcWiZyiGZiURqSRq+p8wZAi2A39rEmGjHqwfSBnJ9dApSiikIVtN51+0HX6Pz2GQoWA83EhmReghbhPHJisLjXjlQ0+cfiGeDj3vKqH32kp0zzC34Bvy8YCbuhFE/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCUvYlutrwq3hiupF2Fco9Q5u2C1yatrQJOsPCtWWt0=;
 b=sVRU3aX95BSoprEENG1lYZBP/+ilinmG6ejXO91gy2EcXIY15zGV8rwEisd1NvZGRmWfwRBze+PDbQPLSY5uHCxTLB04U2EbHylyJSxZsVTclpjuz85jHDF8BelHpkHDAFGEu9LVH0ShkyhULUfFKM9swv7B+acINHbFtZLfcvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 16:49:55 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 16:49:55 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 07/10] dt-bindings: rtc: Add fsl,scu-rtc yaml file
Date:   Wed,  8 Jun 2022 19:49:25 +0300
Message-Id: <20220608164928.2706697-8-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220608164928.2706697-1-abel.vesa@nxp.com>
References: <20220608164928.2706697-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0052.eurprd07.prod.outlook.com
 (2603:10a6:203:2::14) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0716e3ef-b926-4b52-9a8d-08da496eea31
X-MS-TrafficTypeDiagnostic: DBAPR04MB7431:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB7431FA4E763F17C0F3FAB941F6A49@DBAPR04MB7431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jSHeoKZwsaF1k+b+z7qZIkQ/K4dbhbQLsb2q9RD5wVFtdW+TyNjBJSicfyKT9akuVjxpPbF7PGH/KZEWiyioZpF0smxPNZDT44vVcfENd1jyOYG0n7a2FxaScEXgpUxIeGnuDFBtjcOxiteq6mVy7ojSs4xYbxawh0YnIXQouStIv60sqHPhM1ZMLf6TaIlmjpTOGhCmmgpzvZYEIyaDg++xTk9rpVucVVd6ArdtgmsSXv13v0Emv+2BL9CWKLtjQaoBiXwzMEOc9myQTvoQVZ9TO0lxInYyfZ9Fhz0iySGNBsuuDd78xRw0FPm4OR9rr4zHQKq36c2Xekw5mCo86JCYD9Udd+cm8PtaNxg2SW56VzHicfSwnPuy1m4ezxYqNi2eKKugrIK0Cx7t1hQjKlZgHRmEO8F+3MaMGLqOo9GmTDrH49FIgirb4faleEKneBmsRfvV61jQyItu++ii1kDqKL4tFvfR9BGy19iNQB2T2hdNpAs5FCGfZaIc4j1ptkPUpA6BVbPgAWSuvNHqcHPmrImvFWZINFDWfhGO6KbpJffmuD1pVx9HwD+pthf40d1CmEW3+gBtiXHBf2LrrwT08Aj/To+Lo9SiMU3XwcGCORT9uNS2rqdW20kllxnl3bpRwUdpO3zcxZg8C9ORj2uy8zU1PY/2SQ97EwyUuTn9XjhCdVnz6e/ezrqoCngFX2YdZG4mwbg9IZOhKzvthXcNvjDiHibYgEomc6d6E+9FQYZ/roPFav+WGbZlUGt8VwqzFlooU0FbCxdhMmSgMM9f+joQ2l0vmfk7wWyLCwdhUdLBYqIT3Dwi6Qu6eLh4NeDECvmjWW1d4q6ebtkKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(83380400001)(66556008)(52116002)(38350700002)(44832011)(4326008)(110136005)(1076003)(508600001)(8676002)(86362001)(6486002)(966005)(186003)(2616005)(6666004)(66476007)(38100700002)(2906002)(8936002)(7416002)(54906003)(26005)(921005)(6512007)(316002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJOmR6OjLZXr5fKulZ+V80s2zN6aL/NK56zYYRyVMSb9sEgMqKsrELW+xvFr?=
 =?us-ascii?Q?kjuTM2dbxewoE9jZj4SFOAar8xzQawJiJCDkUSNMncykD7yJGMpZ8Aoh7Fcz?=
 =?us-ascii?Q?iGuowXqTNVyTE+dBVPBX/q3q/sn6bHHRCsKum2ePOXn/bKoSMAIFNbCmVDvG?=
 =?us-ascii?Q?odyNhFo4LGv+b+Pr114ZLKHCEZo8YHqjwkOz8fG0ws+GiYgkkZIYkGVi9Pj4?=
 =?us-ascii?Q?cD9pPZo5Rqx6Uq7+XHpjKrLIyBH42s1GvMVgZ2DRJ9ARj2qI7rh8kKRI1Oxk?=
 =?us-ascii?Q?mzPf80cen38+AedaJ5aubAiHNRg4VIyLApNLmvuhRuvfNxVaav1ZNlc8rw66?=
 =?us-ascii?Q?3tLg0hBhX7AaVzI/7XMVyF8RrIUXaYwn5FZOrSOpBu6S+chiygmAsRG+dnwd?=
 =?us-ascii?Q?TNhL9Gvr3z5E5d9kLR+8UhRlJQUheqM06Hi8m/tJFMZtHR+ZR8fVwUesaDlg?=
 =?us-ascii?Q?CQKHLRIQauVBruF0wgXnn+zcYLBJcORkUyUCKtEuGwhzOU4EJjeOx4qYGHTw?=
 =?us-ascii?Q?6WDzAH/+ACBBI48zLuNaYH+gXWi904kkYL4RgoTZIPtw+77OdHmKF5tSSOB0?=
 =?us-ascii?Q?Vd1Sa1zqjjR2cMRzbrcEYa689YnxfvCdxIxqlfnX47fKeLwKO0rREMhWNBLc?=
 =?us-ascii?Q?h+zRWMsr0cNVzzLnzX1pAn/jROWSCwNpQqaVuY3ug8HlpNnhHFnUFLgER2qW?=
 =?us-ascii?Q?BV4Ztqs5lDcVkQiBjBJRWcGRDixxcpxRUfPjeUWS68jLGYG8Fmgt/JhSCtWi?=
 =?us-ascii?Q?xIIuU79n/b2yaejRdWED9szwdt80z2iCPi1QSEIgdic/eHu7CARbYmcagLzZ?=
 =?us-ascii?Q?bHznHMHsHmiaRMDnnzOClAkFlGbsi9QqClVgUBCU+Aie0n8ALwKitrfqRcZH?=
 =?us-ascii?Q?KOc1JixwpEkyrvYY022MZWOLyAWc4KzdN3XLqcapkmtv4Lfv4JilwlxokF7G?=
 =?us-ascii?Q?l54pjgzH22IGxOnmJ0jUL82HNpA4wSmVd1IfqC6QCevGshl9QyI5kuGNBzWl?=
 =?us-ascii?Q?5Q+0MjCSI4J9m8Hzdk/olt4GbK6dZn6dIUFx23bTHVZemKPvht27R3o6vn/w?=
 =?us-ascii?Q?jmSKl9t2clZOdUbKBc0Q0yHCHruIAQAcKlGBp7FNN1XsZwU3FpNKmubrhFdj?=
 =?us-ascii?Q?kkUK+3iYlN5Zf8R32FCpJWqi3xlVBBOxR3R1hACXqv2mGqlaPNndjiDgCVJt?=
 =?us-ascii?Q?LRfGxAetdCULB1dBsXrLP2gVIhgo4jo7Qhd9uByxG3NRAgkf06jJDLsYW8jQ?=
 =?us-ascii?Q?tBZspfFPni6+D6+JfUHt1vCJiFZAvGULHDw2bqk5oCdTjWtcDr/XsbXgu0l+?=
 =?us-ascii?Q?nUwHU9HRk9oV1ihbAQEwfRSB7Iat1l0ALx0sfUb4QvC3u19ikias80CPoBI+?=
 =?us-ascii?Q?M85u/pyot9CCU8aFgwuXJI/GmUndt/1HjK3gsccei9rw6P1RHA9iFYollBDp?=
 =?us-ascii?Q?cpUfq4oSTbTb9+i2QAp1bsjVf9Yl0p0BwDMch9ojISPT46XgEanpOJjNNzCf?=
 =?us-ascii?Q?JVmpr5GSX+9FF8t35HIFS7G9unLPhls78iupgEWm2p4VAV3XYhtdrhHfGVZp?=
 =?us-ascii?Q?xhon6NrG+RAo9MXop8jmlQR3nr9ZNteipA7bmcr5RxWm5QqYnM4kD2MSOcss?=
 =?us-ascii?Q?VKkeF7fvPSYQW/wQC2efXkb3Ly9/WXFooiV7lfq132DaSeWKMYlfYRDboVPh?=
 =?us-ascii?Q?J8mWlSPHDSMKsHL0keO11F4QIusMwSHMHE08Vtxm720V3DumYAIPbzP0p/KC?=
 =?us-ascii?Q?oBz+LHf7gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0716e3ef-b926-4b52-9a8d-08da496eea31
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:49:55.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrDjNa442A1oVRHocMHkG71o6aXINPnXchZQzqvBWvJaf0/TaueaGjxN9MrsbK/yktJddRT2HJBVQt8Yx8YW+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'rtc' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
new file mode 100644
index 000000000000..bd8c3cf365ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/fsl,scu-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - RTC bindings based on SCU Message Protocol
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+properties:
+  compatible:
+    const: fsl,imx8qxp-sc-rtc
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.34.3

