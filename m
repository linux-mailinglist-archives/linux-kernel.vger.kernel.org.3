Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD1B4AB856
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245201AbiBGKJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351160AbiBGJ7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:59:33 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE6C043181;
        Mon,  7 Feb 2022 01:59:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJqpe0cQpjK/Mx1z7ioMeZkxwrKvqStn2Kj1omK5d7hvOSZVVAPMdPCUzu3Twyq9e+mtqCR1+MJCRj3cmiQGyQxFkAp/HkQu7IrzOR6ilq2Dzj1q08JmfrsGi3Q3eaA5iOKTFtGyeQV64ZgFnyvWuLPjwfpDfRdmAIpmCW1hhpORgnvdZ7qAPQAH43uD70BxstXqOwlgR3EsbStyM32ryTKiim2OlUwbBirLer3f9nv0E2MV7xy1HK17nNfxh1mEb48zf8r4bWDSuOah0Wv2nX8g7UxtHNf1FOQxylnJqVNoWv/aTT0fT2xhcbUrWqWROz9nL4ravW/ARkbPLH1f4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPeqJvQOYV3b4e+cGFon/AmBUZP5k6+7ySJGh2giLz0=;
 b=ONRa1vanupz29lL6/6L+bbJWj71BoIk4VoIZgj9pRRXNpzJG08Hg5dJ015qwggzlb+7NG+NZGixoTGRottRMa/1ZXPdKxnMV/gJn3FaSivx6Zwwvacu/8BVbKhd7LP4T/PMaLoaLLz56SKk846DJUngWg7GQvxyxuvrV/uKMCgWzfIgfm9Dwj8L2DzNjBbiQX26gmDZNt3zyTXtMH1rWA9mre4kBDl1GYJxmfPjf0Fzvr4wtayvDWTV7cgxbPpM/x81PAB9Y+y3ejTl1tr3VebRWFDRSZtlGs0p/cei7ey9KtQwjCUwO34odo4frmMvh78QpORvFKZj8qSWd110D0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPeqJvQOYV3b4e+cGFon/AmBUZP5k6+7ySJGh2giLz0=;
 b=EiKNKjZkHBBO+9KwtSWg3+0gaHRmEiYxtwGhQqasfRmISnA/V2MFFgqyANwkO1GCJ1SfWDccdsivyRMAMXyEIK0BAXEjMx8DgY6O072NslFzT5zGM9PWpp8i3OS3Z0KiuLz1EAO1rZmMaxYis8Sbt+0bLD2NlIluCxYMUH+UEZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5163.eurprd04.prod.outlook.com (2603:10a6:10:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 09:59:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 09:59:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/5] dt-bindings: mailbox: imx-mu: add i.MX93 MU
Date:   Mon,  7 Feb 2022 17:58:28 +0800
Message-Id: <20220207095832.1590225-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207095832.1590225-1-peng.fan@oss.nxp.com>
References: <20220207095832.1590225-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd98568c-12ed-4555-5547-08d9ea208844
X-MS-TrafficTypeDiagnostic: DB7PR04MB5163:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5163F61857A1E5A37AD03ABCC92C9@DB7PR04MB5163.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yV0VV/pYDByUM0srGRB8eeO3GW6PinNL7PljA1SuRrtBlYD5g6r2kyQXLg/+zoifKWWaLobH9rzoyWpvRKMMl0qzxUthB3c0PPji9vaC7j/26zSlfjGWb73SzD3qz0q0paoob328BHUxvhSufeght6Vzo/xBZOFnNm91+WIHl4FI02SH0L5wxKDGYai//lVdkvggmhDT284JxAbwP9+fKnhsR7wAxhLR6RbfMwZwHuD4xg7tR9qg6UqileA3XFU58E81b28QAKxR37AZD6bmppB9Hjcuocz9AK8U5D20VwStmTcd084iQWxRi5dZDwoNzSaf43A/Gui4tmAs72lX86ErPDlDUC4KxVpqfXxGnbbpyCeb9i7HGePWG482VfR4jrs7VyUQpzLiMqNHUOHh5qhfEStA9WxARIWfYtMBkIW7HdypG5pc6nrk9KiV20OCFSWT5OgXImsjZRNACP5EBwax4ZmrWsJmR353y7mQ1RhIUcArwDKGHdWmRJ7fBQiG1hNGflEU7wQjYtZ5MHoEVcQ8IVmmW8XJGiieNy3Gqyoh/RwtENTvy4NNhaThNS2T/UoE/pgenN4JOCu+KahEqyabyi/8RCSSqDvR81TtqnpUIby2xjZ2lXuVmJfjAMX1VdRWAKvldAXhwRGkIYXrLIbmKwLEc122gOBuyro/Sq+eqdueaBHF3qlgj7ooA3G6G2clGJsUihBFLhUlHlwV3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66476007)(38100700002)(38350700002)(8936002)(8676002)(66556008)(66946007)(316002)(4326008)(83380400001)(2906002)(15650500001)(4744005)(6486002)(5660300002)(508600001)(6506007)(2616005)(6512007)(1076003)(26005)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bbSvsT2FGxeoXUc36+cnAX5RMMzAYKCbBbQ3ooZFx/XbxZ/bsvYX4/WnIzju?=
 =?us-ascii?Q?G7YJDGyPLDmybiczKo0d2jLbmMUz7d9b1ah/KJw2hxuLKN2G3tdsEuSK9UVg?=
 =?us-ascii?Q?w9bwY8t5mi6lSjABuaAKVYRF3TWNbfbm0VOdcaOBoMTkEalI4V7UPhCgr74K?=
 =?us-ascii?Q?0Q8Q9aEtTlIrWdd18pHOPA+m1+TUIgv/fsoX6ObzKozpBbqAYqKSPofpXGXT?=
 =?us-ascii?Q?DLpr3SuHhjs65a2eNTMqn8FoIgHin52tdSu+ncerf4hTt3Jxab5ltbfNbliv?=
 =?us-ascii?Q?EXLGBXepZUfyg8m0aEwzQgboWaSV5MH9PEC51zlDEoL/W1diLI4QXvg5xSSs?=
 =?us-ascii?Q?u8QhU04wvQ6Ixo+XLWXV3OYfxLW6NhHO3jCsvgplm+9Z4v0/KXIFFuj7VGVu?=
 =?us-ascii?Q?6YpyP/C1muByAw5IoGira1MGEu8TsynMkVfKVOn0jDcAP4l69uSedNw4KjJy?=
 =?us-ascii?Q?RaCLiDz0KzYcUjKVwsBNI82yh86XxjizZbErmnZXZa/YWF9Be1nsmbFX7QXr?=
 =?us-ascii?Q?/EmsMQenx6P0BmbN1MwKHsa9OEe7F1q++7KnB9PeegDkG9TDvRk3yptf6kTW?=
 =?us-ascii?Q?TqrLKNDNQBLVA4EcPooHcA5/InXlFnUotk9ud2/Ua2D5f3y6zRB/cShn3SbQ?=
 =?us-ascii?Q?H9P9tY8iNOgNPR72nOibvPbL/0qnoXsXrOqScO44f/jbZmacmpi3AFNvwVfo?=
 =?us-ascii?Q?gGB5+5fxWkPJ3U7pcvx+nrG3Fce6E40+Fkn9AEUIFGJhpG5yMEpoje7mJ52W?=
 =?us-ascii?Q?Fo7NbgozgyOj9dFhpXzbgrFmQL9NYvxSah2QTmfscpixh4+WsL8KwdGae+tj?=
 =?us-ascii?Q?XadkhsdjVqUjXgSpwl4+D46fHSV0avm+kp3g7DiNye5mBMygxHxoS5TFdwXM?=
 =?us-ascii?Q?hR1tFEtGfYu1eqlACwFWp4+qd1r0K2DPiZI1IGUOzgGgBUytH6d1Ogwjaocs?=
 =?us-ascii?Q?9jWDucHcDb859b5GyPMPs8/Rn/RzNL7+bpTapdLGQdO0E4lFalEUyecI38yt?=
 =?us-ascii?Q?KYWso7zHyNuAszWhYJIcKclt6bNWPmBV8pLcIUbHuk73eXOpnIb7hAyo1tFY?=
 =?us-ascii?Q?Iji+cKkZX32lWwihz2c/Ul5DEsPY9KrxcgOd9xMNhNIiJWCQtXUgJGgM5uS4?=
 =?us-ascii?Q?O+m4TNpfAaKm2SdHVlBQpbGJWog9ry7ZTaPR4oYdtyIZwp9/k5sCaxUeMJIy?=
 =?us-ascii?Q?HwMfwVGKdkyEan/zXshj6ZzB4u1io9Ka+R5YJSfYS0mTVih5i3F0LuoYTRvQ?=
 =?us-ascii?Q?V4Wh1KV0o4jIUVB/0+eBwwd7XAAov1QIcX8fscmIo/l1eciIaDcjEs/2WEqp?=
 =?us-ascii?Q?a18RF58TelHCeAdqlgXrFUVlBiPr7mQxoBPexC6S6NWzIHmlA6zTByFNEiYD?=
 =?us-ascii?Q?5YWvS/WbiDXCRlphTmHcifKy8SRWSChHNQFy9fkF5CQj7NCDE+J8M8ofomrg?=
 =?us-ascii?Q?ybYFMy2fG2u5BBNCOBxzMABeRdQVNheo2hOVXdib4FGKYK4XMD5TYYPThgmk?=
 =?us-ascii?Q?qKAzJ/5y67Pp+UseSDgqH2cOGgaWUD51LuxB1isHOxS0xj66TpVx0PhcW18h?=
 =?us-ascii?Q?AowMjm9Vk83OrS6O6d3P7yn56/TRBkiqLlMIxMsEfnnMiltcjgGZ25uua1+i?=
 =?us-ascii?Q?onBTXqloU/Vct7uuy/weEXk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd98568c-12ed-4555-5547-08d9ea208844
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 09:59:29.8792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+y+7U2SQwH73MUptJWsZPJGjoPsPC9yO0F+FEHChzl793AceuKxQWF0GQyY/3QcDuMydrAlYpHUgOi/8Qo4Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5163
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add bindings for i.MX93 MU which derived from i.MX8ULP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index f865b806ae6a..713cb847cd8c 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -30,6 +30,9 @@ properties:
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
       - const: fsl,imx8ulp-mu-s4
+      - items:
+          const: fsl,imx93-mu
+          const: fsl,imx8ulp-mu
       - items:
           - enum:
               - fsl,imx7s-mu
-- 
2.25.1

