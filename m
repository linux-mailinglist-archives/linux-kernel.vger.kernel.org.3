Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2A950DE65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiDYLFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiDYLE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:04:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D6BAFAD7;
        Mon, 25 Apr 2022 04:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj9ksix2Kf5mblTZCkQKEsgfjCxeFNaLmSZZUCfwc+9WIvnEOLYjheD0dfuKxP5cd5+XFzPvPePDTTkkWM0OeR2llx6nInvIg1rtypdLrf9n1yEJGSxDxmK/o9shiJ6+4tFHHLO3B9vHioiHlKFsXSY5D6qIdCOtlrh87x8/EbFZugxhqH844EQX0HSlkQ5hCxUTQa4eb7qcLaSz3/0x8tVT/28CUR1lTerH2ArmvCIoh4l1doNT8l9BX+jJaCX1/Dh1+m9gdayB5Fm8Cf0sbY8O2ve4Hd1pfGKjwzxI+WLeEIE+LZWG3RbX6CZS6WgJXxR9m1rNpIPU4c2X9YFQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5Aq1xI1dKvN0359nRpnfLHtsOSqegTgSvk+0Ak+nt8=;
 b=KhvEb40sVYis+HGUEoav79iIDbE6OjkulTaxq9YnVTQ3AoswzNOAU3nyDtcgiE/WovtUPG5X8Nk0tkehxpOvYWrHob9jj1Usr1oKs9ks+q09ASjRcOA8J+t9jWZdT8MfOGezPRLPLbOWzkcE/eb9AFBxP7VlUGo3LeVJp1Vbji4lFCy2zJEKtVvdaSWjRDmnM78IKHwe+o328vHnSuUEguBYCTpGiInuHlpVSlcsiw5FIwLnqeMu/aKzwa8mOygC+gt4cBX/vKd063rue945pd23PNScNIucSZm5qxScU24tJ/CJ1I2hl352wZvmxZLTlWAix8hIh0Nf+VKSvCodUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5Aq1xI1dKvN0359nRpnfLHtsOSqegTgSvk+0Ak+nt8=;
 b=aBA4KQaSEOU1Knof+vDbDIGv1EIWK2U6REkr574CrHpUeHKZ8FlaTNYXuEz8sEayazRgYw96ljAga03qvfU4nab/Qob/TbPRAibtVio28EgybeEgtdVJO4jBxL3LmIfB/YcMb4jjyrmksWiQiogOcot5z/1veXWrUyAFG1qt0ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8420.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 11:01:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%8]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 11:01:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] arm64: add i.MX93 support
Date:   Mon, 25 Apr 2022 19:03:27 +0800
Message-Id: <20220425110330.1630984-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c4bea70-1c3d-4f7e-2a72-08da26aafdc0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8420:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB8420FC160D384ED2FC822749C9F89@AS8PR04MB8420.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBNjWVmGA6lLlURH+NkxbWTw47avZxnZJKfe74q3FTV2VN/2ZhSS5s05GKNehfUzj/ZYumETHLuOp9/NCZhtC0JN98NPIlnK9fAgHsWHA/hB4D1N6hfK2+u0sD/Z0PEXCezDNmyUvRiGruEWOKWSvL0n1SpQAopKGfUt/zaBUEiHmCcCxm2InA7l38VFXLyRLcbReUJkBng+yAmnOePByJ6X2Y/czt3W3K1/CYlgDrMVH02PK/yTPPSt9YWakDm6kBBSf8pm23naM0o6WRkgZricgrt10o5+ZjKgnr7aBybtJpVQ3i4LlfANOtRSmO5SeRGghHMHvDRQWstc39kl+74xEfF4Lay0m2MxBdgwwAzrJ8uaVX5wZ1YEr4h3TBfb1xn7Wbbrj3uc/8KcbIPbZ77igCa3vtqoQhhec1xV3aO+we0iA1tfIBIPBeHQXeCJwFKdgh1bO3m1W57KxW/Te4FK8hyQEJhxaPs2cEAHCKdo5lVWPfs0xEpRCwFqFQSqN4NgOG/Ad961F6jV6pzDhAceMMkN8TnhSDIDYfiyZB0ZBbBmdSYrZPhwSniH1tmGO31tMri1aJr68289qc/sqoROJtKLf83QOOBFsX8uk1FuvQXRTbKRIDc4lGxMpQ6DVVpixju4XZNXdZE+AjtdALL/Oa6Netdztqpt9QJ5qwnB44biW/B9Ruv5lKSpks0x+c5AU6/j1mWQx+TTm0YyPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(5660300002)(2906002)(316002)(38100700002)(86362001)(8936002)(66476007)(4326008)(4744005)(66946007)(8676002)(66556008)(6666004)(52116002)(2616005)(6506007)(26005)(186003)(6512007)(1076003)(6486002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M6YhtuBILbaI7/6mcSYnGekqiGx7/ivaeVYqmyjZw/8oABySq51w9HLLZJa5?=
 =?us-ascii?Q?CLnk9mp6SxMyVQA1XQkXLO9f0OVDGw/EvOeNiW8uv4KAzBNMFeYalAtFZKke?=
 =?us-ascii?Q?dYtmn7LcncuHA9QK03lN9BpHcXRTg404qn+v9qX6hORSzVvVR9hru5LPtd5Y?=
 =?us-ascii?Q?r9ySD/k/rtR89fHj+6V7RAbYT6tso/qsOIJQUOfXqx0doNrn5c4ZyVABK1AL?=
 =?us-ascii?Q?6/rBtSrNloDfu/wzvGpkO4k756jtl3sqPsePOyRgkKH6wDJMtAtUpHHzxmw/?=
 =?us-ascii?Q?m0vYTzUCWZ/3xszP0hGb5YPZpjl7kRshJBQGwOO6Th9PfbmHlrVvoRSS5pYa?=
 =?us-ascii?Q?IFFaZ+qh/DfwSZto5BOu+SgnIBFYBJn69z4//0uRW0RKlswXMYVI1+bZgOw4?=
 =?us-ascii?Q?CTUi7Hr5pVlgNBPCALQNTj4pQi3dsktm4FqzW8pT0ORc0RMv+MYG2hmL/b5I?=
 =?us-ascii?Q?8pmqWHtlbKeaBjZMhwFIsrZs2jGcl2Fg3wQelvR0R8+OYBeE5PGho0cay9Rc?=
 =?us-ascii?Q?O1f0S60+Gz6B5IYXK7KjNxz+OC7ve7Sq/gR9TLkyCaq8ZsaXAwiJYwzbeoSW?=
 =?us-ascii?Q?jgyUK8dzqaVstxkfLUjoAoi+8NNGtAk8NKlbxWslWnA+on/T4jB3iQCUOp7K?=
 =?us-ascii?Q?5L2f6XlkC626wqKUncVbm2aQfu1qyuQobvUrGVQxqu6IS0ol1SGdIgojgcDT?=
 =?us-ascii?Q?dEVrYf6AYsNom+/QLGZfcZDqEiQQZfv+6LIdMXS+GngpgiTqdbvZwfOc/HM/?=
 =?us-ascii?Q?qkjsAdWzVWmso9YWSyhTKTHDANtB8qzrcLRshLpshA/ojCd1f7sbCzexG6R8?=
 =?us-ascii?Q?/lXhWWuYZMYAldY3XQ9iKFA7fBgabVJkP+ChTPViclhMbrLV1owNSR/3N02e?=
 =?us-ascii?Q?c+EOEqohBmN9+27jO5XKTDK8mecSpWYi5fjvjWwVtUElKfdIakFVgyCwwHC8?=
 =?us-ascii?Q?y5c2UT1Q+1Ba/2hYnwaNRry4CRWiwP8HK0+C2/t3EF5gPiosC2RvLEZAy8ZY?=
 =?us-ascii?Q?QZ0tcVRA/Pi13RaGv4gkuxp4NDPZAQywds4AS0CsBu/96g53WgDcLOV+OLgv?=
 =?us-ascii?Q?ay6yHIfZFrBTBw/YcdQRxDcbJyHL42gqnxktmnnvLfAKIwN382TVe8jFjaqT?=
 =?us-ascii?Q?YEWaJHkKETf4E/NAe58/WvZz07DcsAfB/6kCv+eQMA9SBdJWi0nWIGPbBWyw?=
 =?us-ascii?Q?1bGgwCrLolwTuqhDXXrfvR7S6JgPRJPevGfLYHIzp2DpVIIb/9E4fYX42rNu?=
 =?us-ascii?Q?LMCFo6zt7NrmnXF2nmNSgy9SoWIAoJBv99Fz77ui3O21YsP4K4YW+bnPi+Mo?=
 =?us-ascii?Q?3XbJkmxm+liGflInWwDcRidlOXIN628jzkEqNARf2WbhJ0jZWnxJROFEZIKQ?=
 =?us-ascii?Q?0HOBzqv+lKHRFJbqHUB0KD10ceGY2xn6WjiQJfK0FKzeZtD47ziCbUYU7U7u?=
 =?us-ascii?Q?d1crZgTW79fFR2m8DdSp2mwcA7QwwqwBMQj4QoCx80s0/YtN8WfLgTuu00fW?=
 =?us-ascii?Q?U2Pa6SwmejlYsfr+iFx363tss6E7LdbBU7pNjeOD7xqPJNC2ekZ1dtbkU6oR?=
 =?us-ascii?Q?kv/VkFiPAmF6K4azBkYt9Xd4vJtJ4O9E2nnBUugQGVryaIHiNV9HKYQwUDzj?=
 =?us-ascii?Q?SXtpNWVrxPgCqZ61+T41tNpkGHceic0sNNeEoI0nXc2jEEbgd1HgzMrhk6/u?=
 =?us-ascii?Q?p2FhX6Yl2nCc8TJnNJVma8ykmSdj7vi3OOWrwpCDVSsULeu7Z9iniVokJXQt?=
 =?us-ascii?Q?usadRI1SEA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4bea70-1c3d-4f7e-2a72-08da26aafdc0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:01:47.3945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZr1gnnyvsi8riF/A4AMLrOC97SIxUPhkcys4A4lS7jlnkr8vb10E8XzraQ+ZWYiQO8Ziohx+VgQ4ug2Ulrd3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8420
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 dtsi and 11x11 evk board support

The required bindings and drivers has already been in tree.
There arem checkpatch error for the pin header files as other i.MX pin
pin header files.

Peng Fan (3):
  arm64: dts: freescale: Add i.MX93 dtsi support
  arm64: dts: freescale: add i.MX93 11x11 EVK basic support
  arm64: defconfig: enable i.MX93 clk & pinctrl

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 130 ++++
 arch/arm64/boot/dts/freescale/imx93-pinfunc.h | 623 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 337 ++++++++++
 arch/arm64/configs/defconfig                  |   2 +
 5 files changed, 1093 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
 create mode 100755 arch/arm64/boot/dts/freescale/imx93-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx93.dtsi

-- 
2.25.1

