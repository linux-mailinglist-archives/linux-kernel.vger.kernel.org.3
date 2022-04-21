Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497FA50A793
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391022AbiDUSAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391004AbiDUSAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:00:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32BE46B02;
        Thu, 21 Apr 2022 10:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGZntfj3cNUIYaMwIMebCEyGTyzNGo+OqQRwx14czxvZpnlB0Rl2HG8mPwdqMM11H3MEvuUKZ92ifhrrM4R6ZwuFo0PIHjoDrtFcfL30MoamaqXXaeFDQ8IHWaCy03T0xilT4nl0weNLq8bxqV05YV2zpzBazmilRlIjoGzIt3K1a9MUuQylCgiDUIhXUjgpCny3b0CfToJeVSbviohq32VMr/77pG8+EuznO5pVrve6l4lAEFeH7C4f1+PqO9fgNRb7HHYv/Vszb7K3OGNvXIeqB1/zccJEB4zLCZGzMnRUsTJAMc4d0sStW57kPjnX98sR3kzzevHVNmGGX0mFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY+yven0XwK3bWWr0hjl+F2ID+M/lvDQ1hr7rlVGZWI=;
 b=JvM2IPb7sHnGjZok/tWLGmzb88IcQHhrhP2hKnbbptyL8BidWLiS2ivj4/rUQugofV6yvDPEqVTMxiPRfbPspEb1dsG7fZnKIfy1bF5fQ1MEIuugiPFxPQ0JHVgRPN5fwEFFKl3kooKs092pmpJsB2dU0BAJQfTINeZx3VOLh5l2lW4ThhM/lsdMd+kag50aEvN3oqaJS9IvqfrYd7VXM1hDm5OdDAUMN8LltFXOHawhQrhoevnuwj6E2DDj36IzKPmZ+cDF+7SfG8/eGhvBsEiDj3aD5KQl41pNvrCaBx+cznmKUaATvZlDzKQIbdH9rXs4/T8tI13tNeL+5RgQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY+yven0XwK3bWWr0hjl+F2ID+M/lvDQ1hr7rlVGZWI=;
 b=n9BDEUNQoNCBOiQyujmu8tH5Mb4OONQeUidCcqW34/Z5nP1Wy8CNoXEY3y09hdFug6SdpU0fKWThbrwBseAWDadtOpUKERIuzqsV0rbEwCzNrTenNcDzCIhHF7TObmhbbMBqUUP6JARQPY28/isrvsbeDjbRRc1m+ElWlQ3iXMjBGsoXXS2Ycsf2QgAPw1oQ72Bvd6WdPpPfSX0C7pIp6MrEvBzEWoTd9kGJJ0AhkUW+40jeQALV9MZUrg7itmjmwWS12JiK3QrtmIt0xIARsoxhE/GePR/nmSWMNrA/V5UmWIxh/t9QhPtjY5XoAjOkIzs+KYVYwN4mytdl2DSXqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AM0PR03MB3490.eurprd03.prod.outlook.com (2603:10a6:208:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 17:57:09 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 17:57:09 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 0/8] nvmem: sfp: binding updates and additions
Date:   Thu, 21 Apr 2022 13:56:49 -0400
Message-Id: <20220421175657.1259024-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb98fa5-5f7b-48fb-a22c-08da23c05afc
X-MS-TrafficTypeDiagnostic: AM0PR03MB3490:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB34900885BF14E58EA2912D5396F49@AM0PR03MB3490.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2qsLQfHGKSxeTRykCSPEu/4/BzpiVjHktUDDqXFeynMG8HfauCGlNC5YXs4eVKg/r6iY9SXGTj7VYHDN1vJgW+0ZNj5vkg5slV+h51OYUiSQL2fFar4N3iYffI3DOlxPPvPFpV0FB1fJLni5l19oxHziXc7Mv1Tgst8KQaMlu8c91wTcLnItbvkqwLwfUwXaMny7OP02rvtrSS8eV2/poafr0aeL/amk33Y6Jbm+t5iMN8BUfk7vlDub31Wtsm7ZzpjgPyfs0Hh7PnZjGsmdS4NT8eYlf3pAepcId1QiDChDYd3cOcZwzsJK+2oUdu1VcEpDRDwxUV7J951ytetPoOoIC2XqzfUWY95MQx9i3gcmJPPs8GTXKNpT4sZZkWBV17y6t1T60/U7JIqIySqrHNL3m4WGLEg2tcYOacMWxf6jcIIzht9tNeLkLociLsxmLnaYE0wN4xZA8VuWWWeT7H/yKNiVH6LDGw+oB8yydHP2GElwqkR6F77gbe3eD2Yf4RgsMEfSAffNUyh87YloSOgQySXR6rTepW90sy3LbYRCFHVUJz+OckfPUFfHfWro0qpuf0yZPIxuoD5m9t4KxgNCSMmBkcJL7s+Le1igPAjTDCsVx1DTi3+tutC5IxrgBg7IPvt4k7B9IUAAxkz9CNxiqTTTTskfXymchrL7yHRmYbkCpU1r4lUix8E4Oxz+kqsHK8EAl6xiR+HqfrvCEU6q9yHjFHlvK3USC2GGxeGF+L/yn5aFbdoFNCRXXCng749D04NcwRGYa6Lmsx7/Pk/shnwQYsqmtaKr6+cZeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(52116002)(6512007)(66476007)(26005)(4326008)(66946007)(508600001)(6666004)(8676002)(2616005)(6486002)(316002)(83380400001)(54906003)(86362001)(107886003)(38350700002)(186003)(6506007)(38100700002)(44832011)(966005)(8936002)(5660300002)(2906002)(1076003)(15650500001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CnRBxsLebuIqGho5nIgi30weHYFSXPpM3o3J4YZbN7u/JOnrDei3xvTenrvx?=
 =?us-ascii?Q?ft38nCGH7BeSAI+snCplAszm36RzhYRddHjuwPpz/NaULGiPcywx71g5z2E9?=
 =?us-ascii?Q?aWriZxMaU1GYCURVNAlnHdz2pAAaG0hLMgcpd2wBUua9uZPl6BCw15/UIwZt?=
 =?us-ascii?Q?FJv7MKcrzy8fGczaB4FbYhoN62fvrVT7sqXZHMk4grtQyKigqwV0nWvxqT/M?=
 =?us-ascii?Q?g2f8TuwuB/9z6Uxxe2/unkQwB8T8xI+iCrcQvV/mQGjxx9qcLusL5JQOCcuM?=
 =?us-ascii?Q?7oCYUalvKkLAdMeIQzvGEtJNU0rrwUOBqoUqH6TJ1QE28v1iOSy229h38v3E?=
 =?us-ascii?Q?SyGtYIotm39PtBGBFG3iWn/o6PpVsElqhBA7vjL8F6aZBD2Sqo7i87dfwMkA?=
 =?us-ascii?Q?z5h5z4mclsqyhwjwFOOrf5jVzWQh/GeVij7kawb8fRQUt+CivgLuN4t/9TyX?=
 =?us-ascii?Q?sG7N0eipv0O8iYZKW0bGpQ4XE91ChAUM6R+4/TP1ZXnsi466GhXYKQ633c5S?=
 =?us-ascii?Q?/1tvZKHCYhDnLIQ81gtFZe/tSB/1o7NR7UCHWlXpRMzAFQNIKSMoEESRc72V?=
 =?us-ascii?Q?1B4uZpsy0O6JgXEHNalLGNA6FISJE3bve845NES+Mxyewja1lYtGZv6rMC+b?=
 =?us-ascii?Q?P2cLM06hitzaj+18SEO809ObNKZgORgxH4RKmeWGZiV27b0D0usfh0Wssq63?=
 =?us-ascii?Q?PfLl4uJHxPyfzeSJp8TE3HmxQbB/4RknmrwmGMxjB8LeNUCSfha59gM+I+th?=
 =?us-ascii?Q?yUJbifqpY/FaIRf4X5pFdc63ofyS1LZEWK4G00z6amM/HT/2UvKz+tG4Ygel?=
 =?us-ascii?Q?MOXk6uBqtKEzaxKWwlbSp1SkbHhHbpQ407goW71gmPWTo+DNObb/iEEsXosD?=
 =?us-ascii?Q?FrV2U2oqpV3Ypcv9Im/vqn5kt04bxWWuQ0merdM3ytKW51WCvsOm4poykR92?=
 =?us-ascii?Q?FAny2cixC85xkjV5L+7fIdcT8712pdEOI6zqr/m4JuxHK3CxSdXYPp8grJko?=
 =?us-ascii?Q?lm0aUr8fLegDGhKqkPbdb5IPr2iaVtdZ3BtwmgXU3+nRgGTmD7TeONSJJvR7?=
 =?us-ascii?Q?zNwJg98mTxhiEIX7ELEBBqMeBPbFRGGlwL7uZA+jDC69QwTBvG2jqcdp+wQy?=
 =?us-ascii?Q?vmmIJZHIbvuYb38Xb/+qg5c08G11MgM9KGRqQlS7uT7EwA7cA27Ps6wnU5rE?=
 =?us-ascii?Q?9fY2BWHrVEtf4Q+9wK836rh5OF2GGUvNk3RTaLdTPjyfQm06UAgwmjiTBuAk?=
 =?us-ascii?Q?JcJIE/gKaja9lB2HWbB/HqBwrMgWmBIhKaB/rGbvN+6o4wV8n0RwYc5Fu/w/?=
 =?us-ascii?Q?odpJZ79ACTnjQc+MDuNzIAgLHFlTuGEokp4ZlA+UB+JGfqm1fQmQcdt9ILf9?=
 =?us-ascii?Q?WD/jVmur65nul0m7AKQ4lRgm0hlFzX0RcO6tmb/hozAXBmGtwdsFYgc05HbF?=
 =?us-ascii?Q?JXqpwxzAvEPBZy9gGIW9wghsnVjZMbs1OqujUTgblpO0GLt07VpenC2gNR/E?=
 =?us-ascii?Q?hhU+WRQDWxiwgBpw5piuwW5Ok2hWRtKwU+lYLHhRIP/dx2rNCCyCcapMv7Uu?=
 =?us-ascii?Q?nRc1YXRqmllmURQ6hCcTK+DhLTecQeMhfvcXlU6Zqn1fzwiNEwku5FagF11s?=
 =?us-ascii?Q?AAxcXCsRD+ZOy0FuVobMVdRAhhWe7YTeO9NoXQK+ZZfNU7VtEpoSMIuwRS50?=
 =?us-ascii?Q?k7QhJIrEaOFGX6DxF2nwOTIn+vCL6U/fOPy4qfgaWstDw/x1xnjb77kuHs52?=
 =?us-ascii?Q?iTUZwCQq6ukm1mhPOFPrtLbCyTO3leI=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb98fa5-5f7b-48fb-a22c-08da23c05afc
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 17:57:09.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lN4JJaTVtcKZui5KOAEj+apsL4UVEgwnZ3/fvPc/+1WKzApQGL/5u/ntnIHtxObHxVdnBDgwWdoXWLTC5iKdBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3490
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


Sean Anderson (8):
  dt-bindings: nvmem: sfp: Fix typo
  dt-bindings: nvmem: sfp: Add clock properties
  dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
  dt-bindings: nvmem: sfp: Add compatible binding for TA 2.1 SFPs
  arm64: dts: ls1028a: Update SFP binding to include clock
  ARM: dts: layerscape: Add SFP binding for TA 2.1 devices
  ARM: dts: Add SFP binding for TA 3.0 devices
  nvmem: sfp: Add support for TA 2.1 devices

 .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 30 +++++++++++++++++--
 arch/arm/boot/dts/ls1021a.dtsi                |  7 +++++
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  5 +++-
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  8 +++++
 drivers/nvmem/layerscape-sfp.c                |  1 +
 10 files changed, 87 insertions(+), 4 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty

