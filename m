Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382D150BA9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448922AbiDVOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiDVOy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:54:57 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232BA5BE73;
        Fri, 22 Apr 2022 07:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld5cJjSp38MF2IY8yQz1wAw4lLFUl8fK2Js+a+wPtc64Up/Fbm/70zcomHMZTwxX4GvG8If5zm2SfJpHRXbsBRd+U5xlf6KqBYFgSMjMJ/FfQ/FiHHhlMn+X53uzf89JJdO8FiOrLQQwkBGCwMXyooBbA8ZGoXvxEKE76gHJ40cXot+MGJY393WgAPxjX/UEB4TwrONbVLeCH04RS81c+ci+Hh6UejWIaFCxN1IbeUTIKtah/UH40SkPbIi1GnPkPw15OolGwaEyM7hI1QLzTFjriyDfryBZ4skSpFaTYqDGEX3d6JnjMCCkKqbc4PJfaVxx48pA0H2XRzoeK0RxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5acmMh8E/k9GIyQ/ip6zzof7eVVQ/fSIPeYsb5C6vY=;
 b=XeSDMyf6uhd/7BmNNt6nN65G2OJZN0EA8WpZd9fQzn1BUX9QFQM9SVMDhJvCr/3b4AGjWK87MUpEIm+5wVUkTWJJGhOnZ2c+iUxOUJmvIpV9McdLbS4hAmVvICdHln8qS0nq7VnCVgUReXsxROTZgGoZu08LS4DuqAvjHo0zNIwhMbN3sAR/3+ZUmByMW52eqJFPqGjKsFn2FydmCzj2KFFok3ED77aMFoZZLMXNrJz2CRPo6ZiJ/ydDO2d/Nyv61qCOgoRZwiVno/ZYAJaAld4QC+XBsNQe1zungK1wYEVmOzwi8hmiOzZqgVJTaDy/K/xllibNMG1xppvWZYn/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5acmMh8E/k9GIyQ/ip6zzof7eVVQ/fSIPeYsb5C6vY=;
 b=p9f1rdkIavN/xToq1O8XQpX4PKFNxoWdRp97RQufG7LaZRs72ITTrFxxwW382+T2sZ/S5rmamKIxH8i2x5jILo7KrKJp3hsLBypxqDn3+yyCCSiwIGzLePwJWdtcBrOM5cggGi38nujtJtnAzjSicYmwxZ092WgfX9vDrCRoBtP2BqLvS6DApxH/fV3lgVywNI6VcOa+FxuYOIewuxvYCr0T+qm7A5vuovEukYPYnXvBMi/FmP4kBIE10uN3pwxoa8NSKRUwFs6TfpkOb1YJm7F6a/gZXc60VDRs0AkcxYU4skmU8KHgp7Vq3US60uHjaM6a/J1++/RAYmSm0Sr9Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB6PR0302MB2792.eurprd03.prod.outlook.com (2603:10a6:4:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:51:58 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:51:58 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 0/9] nvmem: sfp: binding updates and additions
Date:   Fri, 22 Apr 2022 10:51:38 -0400
Message-Id: <20220422145147.2210587-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb0591c1-b634-4445-587e-08da246fa6c7
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2792:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0302MB2792FB911E44CE05EBB5260E96F79@DB6PR0302MB2792.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcwSF57eNxg3rBWCE1Nh0K9+OruggYDmal9CELw/y3233p3yjuAG8fyRYMHg+IBDkJtwVKPGV/bNR7c2n5hfx5AoH5EkRBGCXkIAeqhszT7yLPB/38N4vzNr8NarxLpwPgzNwmgiw7xCdmPpCLSZY6FJV3uR3otOBXPojpTg0U32pzLCRO4B8CKCB7jZalSWwjKRsootVPLH8tww2AlaM3oiuvWW2K+aP/NlIr3B5E1BnIIBz6iVkByp94bBcspWa1r+wqY3E+Vxo8rQLwoq9U+TatGVmkhCi5o/GdeRhJsc6dzxjEAnvvGqxhO7lRWahQ415xd27dSkojivDw0oU+yk2OjQ9/af8dAZ241nEqmBIBMlDsZwKtg8vz2uZSgWMMEw6eLuKOHgZnyLhqAKb1r5e40etjLMFhRpU02NiRMCjmR+rH8zZ6q4b1u5VwSHlTKlr//fiAhSs8QjKDj5OIRgitjzdRNH8ooJdBofUNZlKaV3nf503Cf4siuSTnADZuX8f5gD19RAfPprw1n5nypAaiMji2LCer4va3a6q2WOEIORVbsYIKLv/JRkTi/zrBMPBulAbPpGQzN8ACZrJ4mv8A4zuoLBFr8xlGvH7ty+GmaAz5TjpmwT+Tb4swLO7Ac0nIomz0/6cG8lGhqrrLvACls0rYZofFF/Shp/BnqCEYxjTSSkkasbG1B0d0w/67u7BdUeHgDwaFNFPXx3w2dsAZqNw2uxhJeir3OdwMZvwRMOngZ25oxNnJst+Im3mIc8ej1qX1ZcEsgGE5kThmVMRjUQ9dam0N/eUDjC9N8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(36756003)(966005)(6486002)(508600001)(186003)(38100700002)(52116002)(83380400001)(8676002)(4326008)(66556008)(66946007)(66476007)(6512007)(86362001)(6506007)(316002)(2616005)(8936002)(26005)(1076003)(107886003)(15650500001)(54906003)(44832011)(7416002)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0N8XtmvG5brIvCrpT1aS2PsKrbztRyXr+N+33utao4M5uQ5YsLp5O/fYZr2g?=
 =?us-ascii?Q?v3kEwocSQ3tc1U09flkaGRlczbXn+q22S5fupP/eZ+ChK8JfjRdwOv9KAYHE?=
 =?us-ascii?Q?OlEr6OPDR9w4vvdcpzvuQ60/dNBQRIkqie5y8imeOxP4le4brYkfQkvtrbQ2?=
 =?us-ascii?Q?xr3d7wPquaLuQcZrnEInkDp3tmQeG+9JO3BoH9sFx+JjwWLvf048ezR5gVHi?=
 =?us-ascii?Q?5qbUeoesHi65Soq7MnpDo1pkMHga87FWqMfXlZsaWynxze77u94NYePv56QM?=
 =?us-ascii?Q?ba8CcSigYoOu8VjRumEhZoAhjFFJtDNinMC0kmYMgSIMnEYLqI1EbciLXjiv?=
 =?us-ascii?Q?iVGiszvQIS7tgBMctsfogq1hxwZHUoHlZJWJRjKpY4fBDackbw7NNWC1udm3?=
 =?us-ascii?Q?djFzugvmdm/UYeVuPCtuo6Wbp9yfXTTpxjQ35liDy56CmLecGpL4i7YvK6OS?=
 =?us-ascii?Q?OD8eftAt/hecwmD7esAkq6jmPc0ol/p07gBzTfMiBDv+3GGPnh2Brwo/8AkB?=
 =?us-ascii?Q?HmDWPNr+MlyI+ow7ARc+tjFMkWS6/mwUsO8vq6RHKxqq2TVdWltEaptLQdLx?=
 =?us-ascii?Q?IiN9SxIQ+c+kGMK5VZG76+iqeSI1qkirp2uCtq2xzt/4OfsHnc1Sx4qpS4vP?=
 =?us-ascii?Q?oFo2KNl64P2559LTSDw10qypYovzCtlVGjC7YUwq4Dv6r8Jf2WNKm+f+01uZ?=
 =?us-ascii?Q?txfSEL7rP1P9tNYl10guxfzN9lJKZVOe72m5mtF1U27Eb0ngZWjGuAj60AaN?=
 =?us-ascii?Q?ghq326yZ07mHwmkQQrsmgG+tVVPkxl87NICeu3EzJqda8Vuwy7iH5zC72Bx5?=
 =?us-ascii?Q?Q7ICep9vPFp5npNusdVQ8tMk3qFn6iLctphQPtO/o3HFrOH2zC9bSPE2+hGJ?=
 =?us-ascii?Q?RIaL1LKxf8RVtGPUAd/rNuNer0DzrBRI6mFVNCCXmxGcSAwKATFSsAr5k0Et?=
 =?us-ascii?Q?rREHUeYEIsA7/2yEooUb1W0LGPMgH3jBF1+OWd2i1R47EkEn5OIkWkOR/aY+?=
 =?us-ascii?Q?52sIdb4e1cHNi3u6lgzO5YU32Rhs8luNvJUh+0T9pQGpE/D2OJ3Bi4wBMRY5?=
 =?us-ascii?Q?wNoC3eM2DqA1vDybzNYhFzFY1/4L7Mp8E1qPZ8Cp+xGQWsojpCFcz7+hVxHt?=
 =?us-ascii?Q?cb0mTSDMUxbzzMUe28vSq8Qjo9x8VKwBCrv/K2U7hBr+LxJqoPBRzvv8bl2v?=
 =?us-ascii?Q?yiuU7+0JF5YwtDl9Saw7pE/KdUiVJgzEM6DuCKPz+DgAJH8GFgWP2oQmIerZ?=
 =?us-ascii?Q?EB2w/k4UK6l6U5O4L86C8PwBiEAYz+KhVB+hTgd3g9uLRxexP8k2pAZCNDaG?=
 =?us-ascii?Q?WTPGUxoluqSzFTpiMKNxxZ6axS6tJWJQILQPsWZQR5esr0UI+h4XLYsikdGT?=
 =?us-ascii?Q?a5QAi+KCbE18naYmjU5LGSeu7xxM+z5JPYBsjPeTeaPYClY8Oh8wP/e6Nq7x?=
 =?us-ascii?Q?bnQEM5OumDsNqCVQsX7raaXK7+KS1GagPKc9tEWp8UynUtR05uRjk+tSNOzh?=
 =?us-ascii?Q?0F9mXAZ6Tyz0Iy3fRYerH9x/Zyzb98i5nL//MPtGyDeqDHiljylwBmyhINa7?=
 =?us-ascii?Q?ydf7ntsCU2r1k/ovdljfc9wvG8hDbuN5yMXyewduPmql/gVdDUBwgP9pXSe2?=
 =?us-ascii?Q?s2q4ssQgKPW72kHZZn8WH14dpR/yqwy0JmqF0kJVlgtaJusUr+NmYtmU7kTH?=
 =?us-ascii?Q?ksrjxXHa8SrKCetqRIvjpqciNwb2m6mPjv1vP1XHEVs41OnMmybnqBdzzKSa?=
 =?us-ascii?Q?3YJLR1Sw0cULjVDl4Y4qrxDqcWRxM30=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0591c1-b634-4445-587e-08da246fa6c7
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:51:58.6273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psDzt+jQ+7/ZK+EAFcBjHx1bB0SYmK7rDPGnziFCGmUsshD/z548Pttfr5jPfmKo1EsmNzp5T5bPLrMRWHWgMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds several properties to the Layerscape Security Fuse Processor
(SFP) necessary for writing. Although the Linux driver does not use
these bindings, I plan to use them in U-Boot [1]. It also adds a new
compatibles for Trust Architecture (TA) 2.1 devices. In addition, it
also adds an SFP binding for all TA 2.1 and 3.0 devices.

[1] https://lore.kernel.org/u-boot/7c8e206a-cd40-2a77-6282-7f4bead2b13a@seco.com/T/#m591f8425b6f096ab3d54e6f7bd258e41cfa4c43b

Changes in v2:
- Mention "regulator" in the description for ta-prog-sfp-supply
- Convert sfp driver to use regmap
- Fix various typos in commit messages

Sean Anderson (9):
  dt-bindings: nvmem: sfp: Fix typo
  dt-bindings: nvmem: sfp: Add clock properties
  dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
  dt-bindings: nvmem: sfp: Add compatible binding for TA 2.1 SFPs
  arm64: dts: ls1028a: Update SFP binding to include clock
  ARM: dts: layerscape: Add SFP binding for TA 2.1 devices
  ARM: dts: Add SFP binding for TA 3.0 devices
  nvmem: sfp: Use regmap
  nvmem: sfp: Add support for TA 2.1 devices

 .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 30 ++++++++++++++--
 arch/arm/boot/dts/ls1021a.dtsi                |  7 ++++
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  5 ++-
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  8 +++++
 drivers/nvmem/Kconfig                         |  1 +
 drivers/nvmem/layerscape-sfp.c                | 36 ++++++++++++++-----
 11 files changed, 115 insertions(+), 12 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty

