Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B9571450
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiGLIUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiGLIUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:20:11 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96B2A23A6;
        Tue, 12 Jul 2022 01:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYwI3Jg+29TzhT/r2htWL6XZP3lVqi2p8YUR1MkPHPT+QZR0qhadqJ4NGpRN0b1JFINKbCPXybKqQBuBuZHJmwQtzU7U64Ixy/GuflBUssc+jEpEkY5Anq8lmHttvPCwvs3XqFKPcENNYmErW5nHfVYZrVAkRVT64jbb++cvNhxPF5vuWGVBMdImEGrg0nh3bGnhxkAX/kGw2HtZyqCEiWnII+PqS2E+mnDZQLfJ9E96UbjeZlkDJrDWgAIEiNP83gPLQerrPIkq3cEd2CBw3hU4nCRSFismvOt0mkA81+ixGfguDvC35Q64+JMayQcGTF/E9beuyg49Zb8+ssmhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL58xInWrINjrGXmv1Ep8UqwLhMo/xDFczGk1t6aB5w=;
 b=Glwzf337l94qXtv6YAF3nOUxtEd70gC93OGDLcX3FnsNNleHBOnhyvuYjnKEaIycPRbxuLugU4L40Ge4sw+76EAHttmpGJHotBI44tSttRxp1q9Q7Q19tVflDEgbXKNifgX+2JbIJ0L9HnUc0zycTRGuEn1ebdcN4JArIRCZyIQe9uDicGcTtgXzPDmn0vPt1PSJIaY+Ocg6WgKttp5Xid6d0GQeJF16KXxuCu2EvN7U8OR67MAWKI599LM5sv6TbCRa+p2SWmPcN6kDmGz0vAwU9tzQ7/bedVkTQaaSpefyacYiATvGmOZKhSxBgyJOc0kbzifSny2y6EBM4Ya0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL58xInWrINjrGXmv1Ep8UqwLhMo/xDFczGk1t6aB5w=;
 b=cqSK7kToXtV0eGY5SRf3xTqvy7EA5O0wFcHC0k1uBKwMb9FOy/N+lu1blr9gyPyNnfattDBMG8ECDkf+hTkr1hL1Eid85TZ6R7kWqdv60ZDV300iu+EznIHDm+07f0HwsE/o+7jVTdvJrO/ozwYSnAkYRritMZrTsJXM1OhRbYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 08:20:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 08:20:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/6] imx: add i.MX8MP hdmi blk ctrl hdcp/hrv and vpu blk ctrl
Date:   Tue, 12 Jul 2022 16:21:40 +0800
Message-Id: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d659081b-a9b3-4f0c-cd5a-08da63df5475
X-MS-TrafficTypeDiagnostic: DB8PR04MB6890:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syBBCXRU+Rst5Tn8Hn6TJKPrSycJT0bfZUFxIL80E/o7ehyV3cQnMoch5e1/61o47bT3vJiQpIfT3T22FjZS1E6/PEWJ/y3Ws0v2c6ggQOwD2JKuyubwcBZB1nhwsvro8Ml+vHqAX4JjV+bDOOrjn2Zdj7eqs/TTR0yde7IXzEzvaK7PtCIMXvtKSG83F6GwxG1hH6R0yesD+zw0tEig3Wz6a6JOlovlo4xSgk1hloF7jYYCGHYhqjrAMZjEOAKOqYPCz8kVMtumQKi7nuGvfV9O7cFHPnQtypGoc+2WuIyFGtRKluSv+KaJxHYwvHC2Sxmj16BxPKUrB+RC2JkcPZe+iiV++rDoJvIJW/SUSBPvvtA6JigPEyd38EVK4D1/xW3G/hcRGcA3wNgolyQfcGdSxO4H/QVV5oSemffbmIC6YdLiBOFF6K7XhrPciHd+86Nh8pulg/x+ng0Dms6Mm3Psa8NZ0TqwvCABXYxu2OSH/aCxW4Fo6dvYnO22FmXWnJdcIpcnuKTBaC+44SGCo8ybqeRIlpg86PxKPTazQOMQEwyJmz3ybxVAGFX8zcJdiuQJpJCSIOqHbHACUSusdaCY4ACec9b5ZC+2v2meF6XLWu5mK78g2gHE6vHgNhRAbMl9xxLu1Kd7N+uS86VsM1vLnfwhaloSlek0SUylroJ4iYs1QSj0wpaqPW7kue8ml1e8SWeL13VHWoNhqy8Z7UQED7nyZZB5VrYqj7tJYCsqxuvwdnzPouAkVY/LFkGr9v1MQjx1+8d8yXNONN2K3GFAPUAUvJqVJiuitTlMcpJsaXFFpLUzloVxdlw2DndpYFdYVkEtoUqTcpNaRecyTz5n+AR6+dNCMn34QHJqO3u+ZblbCSoTo5KQSvX6Cn8+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(83380400001)(186003)(1076003)(2616005)(2906002)(38100700002)(38350700002)(7416002)(4326008)(66556008)(316002)(66946007)(6512007)(86362001)(5660300002)(26005)(6506007)(966005)(6486002)(478600001)(66476007)(8936002)(6666004)(8676002)(41300700001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hDhnoG1YnZrVTzCLu/YwyN1qjyfgfLBmddVrtLyrwwHdVd/3JInku/5W58tz?=
 =?us-ascii?Q?qYU+pPYn6/JJ8kWa/HJI2CYjw/J8q65+NN7QhtgTHx9R/wkwO2nqoAb4NL75?=
 =?us-ascii?Q?IXeTK62LUpBk+O8TSTTSvBXgexan4tW7l4FxAGvrA0orW0+gWUEynJHhI5/A?=
 =?us-ascii?Q?qcLsS4WR6nTTBCBV/qFTVlznfzrLgQIn5Zllr+SNUxMJ/bKc7W1HPc1CvPo9?=
 =?us-ascii?Q?cVo3Ih4llUAxumX2+4oKiYhD6FlrLycPgv+1WFiSqgonwOUjwAATZxdRf08E?=
 =?us-ascii?Q?oaIrZV5bwhESPJ67rlsB70BujeeElMl3qDj6uBg23zzwx4SaYub37rYKAEDS?=
 =?us-ascii?Q?9fzDurQRb7EVlb0I53innsjtkkLUQJf+SvAQNW4/zyrZn/vB0oRpghU3JYMW?=
 =?us-ascii?Q?Xx10fsFzy6KxZGo2V+G4H/sQl+8IgIO0u124GsE7QDWc3uAPLkZ86HcaxyvT?=
 =?us-ascii?Q?OkCn7ihuFkOtWv39tTIm6tQlrZNtpDF4PP7xSTsbKAUhuQrVDqJnToOaHMpF?=
 =?us-ascii?Q?zlH/Kh1G/SH3VV/gWDBooKD4gPjYD3Akyfvdwy83jb5pECtC81PqgWj8AFl2?=
 =?us-ascii?Q?FI1QgNIMmhENNaNG+yEIdqA66sI0502oABot9aj+eAEZsuhq/Vf3FLxL1QqQ?=
 =?us-ascii?Q?1uQltepROGV+bYuBABBw6uoXUQxPMRlS49xV8VoZl95Mi9pDMbvPb5UFCW4S?=
 =?us-ascii?Q?9c3Ov6nqxhMgPmRRbnslWj/B7tJ+i7nNVdPAVJP9QEktvTh5eqwje/Iqho0j?=
 =?us-ascii?Q?k0D23mPCZsD5SM/2zPP0GoWqz24pwxKfZkXNRgEVVXSiWgVF9WcuQU+GHxgp?=
 =?us-ascii?Q?1lMLjjLfIEqGzuKXFbpGjs4UxYUEErVt0eFGVqyuySnDRTA4RANvMQd2jzS2?=
 =?us-ascii?Q?VmRibr6PmYX/wh0ubGrHo1Y7qk8FBCaoEAgErQDReES5+3HMg3m0v6QQ+Ia2?=
 =?us-ascii?Q?7cZV7Rp7K4ODO68oJ432qN2r8QDJigN1hGIPmMzIPFKJvTMUiIlObIYCyExc?=
 =?us-ascii?Q?RyXoNgiOsixjrALA/7KWsXep2hjo1qox4TCMSMJZNTZjEL9o7qL/6oNkDsaI?=
 =?us-ascii?Q?q34GSgxiGTreEOq5kLd8yo7HIId/9Y9adoSUsoNfSEbC8eCVGtNgG/2kOejB?=
 =?us-ascii?Q?PGFSg79+DO/VFg/4THBGnwe0I5dUWx3BPrnJJHrT/J+usKtPg7q5Lt3JSHWw?=
 =?us-ascii?Q?fUWdVtO24mj1AQQagWf4E19cJgEurZ/6Bghk8CTtoFMtYbxluPkYM3OO+jNZ?=
 =?us-ascii?Q?bCyzuXPKPWaCZlThndOe0vXRfmUdqh9JT+zgN6CC35wbGp1Svs7hZ5ybrGMs?=
 =?us-ascii?Q?sULqznWZoNLmldbdiiAp9OJ5ZXuVti2CVD9WeJH5ko1HifrR1W1bbWNHU01Z?=
 =?us-ascii?Q?3phntOy0L4ciT8yX68OG9A6SFFI+WgpK7fdge8cBcdLWSHW5LF3BdG3v76Rt?=
 =?us-ascii?Q?XyZyB+oLpt+ToBcoWgVyy3VV66vvCv7Q3XL/xG3z6J3xa4b92/NsqOjwxoem?=
 =?us-ascii?Q?PsLWfXf1KhYXrDQTh/RFJmuqo0y4mTSiz8LpjUWqr+JFG78Cd0mhU4Vui7xY?=
 =?us-ascii?Q?xiEGKz8AZP4MiQhmK7RHya9hkKkhjo+LqJJRHYOE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d659081b-a9b3-4f0c-cd5a-08da63df5475
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 08:20:07.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7s5c1Uq5mNL9L47XWKxcYYHT8j5Fj0xePiumv8Kh02n4H7CIcY1OMpncJQEmXhiEd9QZgPRkjscS0GmAtpAaXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset is to add more blk ctrl support for i.MX8MP
 - Add HDMI HDCP/HRV BLK CTRL support
 - Add VPU BLK CTRL support
 - Add PGC VPU node which supplies power domain for VPU BLK
This patchset is based on:
https://lore.kernel.org/all/20220708085632.1918323-1-peng.fan@oss.nxp.com/

repo: https://github.com/MrVan/linux/tree/imx8mp-blk-ctrl

Peng Fan (6):
  dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
  dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
  soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
  soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
  arm64: dts: imx8mp: add vpu pgc nodes
  arm64: dts: imx8mp: add VPU blk ctrl node

 .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 17 +++++--
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 45 ++++++++++++++++++
 drivers/soc/imx/imx8m-blk-ctrl.c              | 47 +++++++++++++++++++
 drivers/soc/imx/imx8mp-blk-ctrl.c             | 30 ++++++++++++
 include/dt-bindings/power/imx8mp-power.h      |  6 +++
 5 files changed, 142 insertions(+), 3 deletions(-)

-- 
2.25.1

