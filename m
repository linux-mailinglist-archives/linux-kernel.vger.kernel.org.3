Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438A0544C1B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245271AbiFIMdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbiFIMdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:33:21 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60064.outbound.protection.outlook.com [40.107.6.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6161E3EE;
        Thu,  9 Jun 2022 05:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Apv3cmgN2jVEyC617eOEYjA0/4N4afrEiAuRA3p4aT2CYtBLWx9SVreY78sHGRQ4GBsbS7WVQJHthknwBfr3SuV/4Cjku1UZ1jGisAzCNevUSHU0m78UFHrL8CjuhXUlE5keiYpd7WoYHL2qaXi17yViK2pSie+R5PePpAEvdcCmk7unWyg/+GqYGPdwP0DyWGaBnMph53MUxACvLrJO+fV8/KPoOntcIVX1ky/F713T2RFQBpAZ3NI+Dli6/++h88f70beIEOkQoK2h6/MdVNRSy6dBRkymJe49efiJbKDvL6oJYMYRtFaOcfXzWMcLi3SAGsS9RUzIDplfH+wCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldln/h0uKHl15S179QhyHDShwEI0bRE1CEmEiMojvBU=;
 b=N1t3zTtFpTbYWr8UBmqw6KVn11QR1vF13Pos8uBSjVE5c7GHVs3q1ejmMr91NEfUTDcKT4c/5lF2FPcJOgWfaiPwFIvaUGeV0onXB9ZDVkuGP75ET2DEfXmsfghP9LEaJS2THlAWUwz35VahooxJ+OaL2r0wwHGz+F0+1sOVG5xHv7ZKyHG5iI99PuO3c1e1U1JcI2Dp6jIM8eu9tEWO9DxIzbucm08neayczLjYavVPxyoew5S04nFgS8yiyHRW3ce1PgRHh4JnNPuXt1rRt4Ww1qSOrq07Zucz1XR0qn/sD6Kq8PaILv578sdPmFF9jdlEuEKGIfrrBkPTznXsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldln/h0uKHl15S179QhyHDShwEI0bRE1CEmEiMojvBU=;
 b=fdDbabP+QXnNzKUu6ZNRlLsmi2qzR98+RGWMbsoVCTXKFJNL1iMq2qZMX58xzDTPaeEC1GL1yXnSDKzmQY6yXoJGGZVxCwN91Zm7LHvhDXFeTZ+4DmHSIIiddVRuIVrAmxwt+M0qWGS6G39/eKlhSd14MiZoHJIkMmHc0g7/Npc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4475.eurprd04.prod.outlook.com (2603:10a6:5:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 12:33:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 12:33:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] remoteproc: imx: add start up delay
Date:   Thu,  9 Jun 2022 20:34:58 +0800
Message-Id: <20220609123500.3492475-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee983f07-e371-40e0-2b28-08da4a143a58
X-MS-TrafficTypeDiagnostic: DB7PR04MB4475:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4475A5484FB6FC5E33688C64C9A79@DB7PR04MB4475.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvx/pXRHjUxQRu502YYWUpHIiXmhLVEhJJBsJJQPBgXI4CUU97nYZIpwObJt8MWfmPEhPB2dFHDl2fzxzYcSIK1OOZNxkt2zXQkChFl6J5Qfe1xmHOT0m/NNSjnvPMTNA/JiSDh4j/nYRY5Q12PVf//Z7c1URPElzxhlnmnMphPFhSC3YYt3mS9UGhDo1zjawUCzNkkunrZlMNTwdu8Y73QiTlyNL9XiGTnlsdq9qkgnjVpHoWD4rsxHA2EgBC4ghzpkmpk0YZJQ0EtiZsIGbc0VEDcQ3M9Sc04Bk2Ii74oq/f42x+/TCLsSkZVfWG9Nnu2ew6Vr0/q1EHD5jZ0aZ9tYBHNbYp9I4iM1ZNGivWobGiJHjseiidkLtO9eTDViE6tt3iWIz6rJxsDA3Q6u4MC56yyhaZf9SkosB7qaUhH2J0vWezivbV5Xwt3JkElu+BABg1bUNZkLsoT1qpuusrkqrvh33ZmlOfByECvMsWG3rA4IitBwpxIqL+u/GWZBAAHcjjLw67OTjxufwVOsAT2xGaMN5jsAJu7Sye40V3EmmwhlZ5dYGh7BY5KuZkN8wsh7k1rI3HuomWrmLT9eSQ/fGveOwfJwCYfzbLb03Wh86+GfcnupXaPadK/lBI3oHDZ1G/8TRhHmYi9noh19xHHa9cikntm1rWtFF4dQfgaqyJKU4xW1HbS5EINOPpdKcNAU9R8U5NIg8m9LzNtEAFs1pppSXVSZF3UMMswYerc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(26005)(6512007)(4326008)(186003)(52116002)(316002)(6506007)(1076003)(8936002)(86362001)(8676002)(66946007)(6486002)(66476007)(66556008)(83380400001)(508600001)(6666004)(38350700002)(38100700002)(7416002)(5660300002)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?afOS8XyYiGfUClFS+0tuqh2V/JqhsTT9vjzic+OoGIOwgaL29QGAHcX5sYlZ?=
 =?us-ascii?Q?OueRbo9pzvdIFXh2Ru/G/dJ+m+1uvXTbUFGU43lnqD5hJ5oTTfy+ryDpManr?=
 =?us-ascii?Q?4rHGqF3DcGQ7xe9caZhIsRv37nw9VBWn/eUBV87wD2HmQNXGwALX5vb1dcpg?=
 =?us-ascii?Q?/QsxWRd8sKT4AiTy1530p1fsHCPnc+JAqx52YVDv8qBBA70pVd46ZpIVxNBu?=
 =?us-ascii?Q?ayPGIjrnVSJtBvPNIFinvGr5FsXUK0jinFbJ77zL4N5G58vNH3LnJZS5aFTx?=
 =?us-ascii?Q?8OxI+5CySqi6V16jXwOozqX1OPCGNZc8KePAiIGt6DZoxzyp9RBQj2w+EinA?=
 =?us-ascii?Q?IKoDT1CIZ0coNw+FWRzTXuLWpwQOZAd5lovM6pZ9VjRX/DEjKibquwxGsp5m?=
 =?us-ascii?Q?I1+c3lldyJdhQc1TbfBCvfW9l0dj3jx7HQoUtSELp7oj8xbVnw0K1RLWXPUK?=
 =?us-ascii?Q?hkrKbs3TEr/y0udMiN0R56lBiE1Gru6n3BTX72tesTXeVwq6zEYTPztNny/G?=
 =?us-ascii?Q?+HTt63QpiYU8IWm7saG5Lf80yN2yiPcWavcCqAyNNoUaJNyE677upGBpar+O?=
 =?us-ascii?Q?zE6Y9bx7MDdcBnsIvUTSc2BN4wpaINGBWrRBsYW7oa/0aB5hf4npovrNp6lU?=
 =?us-ascii?Q?8oX5LOC7DZRHPpl8kgxU2cQxK8jXZijAHgmBUKPf43+ejnVQt5aBqmIlLErt?=
 =?us-ascii?Q?yT7d1o77JUDaR9g+yr8KZ83oL8gAmBlSz1/cmTW2vYicRZdogcsymwQqoOlP?=
 =?us-ascii?Q?eY/bOFcKLe4AiDSKrleb11eu56BvuaylN3yogw/EGxepyibcJdZxrvv6lS1v?=
 =?us-ascii?Q?0AuGcj4An6UCAucNG1ptQgkWSVaiwmba86lGH/ZhrPr4RgL0xGUbGkeM5PoS?=
 =?us-ascii?Q?49H/ha2MYBJear2MKLqrYpbjPreKkro6F3NqAdhemd+xmmFovHAclPPKYegw?=
 =?us-ascii?Q?qaebTTbufOz3hrKu7Z11Nvo9sNzu0n8d9f7in7QGBlpWTCYmIer6katMbMOg?=
 =?us-ascii?Q?zEfQlzIU10egRgRvverEaQNJ2w0+lN3EhT848lRNTmJTIdO0BCVau3dSYlhG?=
 =?us-ascii?Q?uzn5G2FzFMeg1lt5s7VCEkwWQ2AtuM4ERCI2pYoMWarBH3kp+s5Gu20lIVsq?=
 =?us-ascii?Q?Y9ZbRWb28gWPJ4wg+CCLjKfKSUb6h90TmgiEmpu2yNoYAyc5fIpXegkr257L?=
 =?us-ascii?Q?bWvJ6a8BAHvQAaYQBEnvy81KEegz5iNqC+eEjtyO1ADmRCZ3XLQBzkLEr8JP?=
 =?us-ascii?Q?r1okRO2lXVitJYXGnFfiXa4O/9+4C7TB2HRtK/8ons4iolxs6pIATaqHW4b1?=
 =?us-ascii?Q?P2fX+jhspy86T27tF1aNkmPuA+J0ckE5qXYCpMZ2pS8RRWi7AXBUrICYxl55?=
 =?us-ascii?Q?/+WGZAbp59gjT6T+fslq2v/5poe/vuKtPzxyDA+XWBwmxEt27e4PwSAD0xlV?=
 =?us-ascii?Q?ymt0BGsM0RamHDT9Q7PTtE4IORdWU8eANPf+lJCPVLJoaLYWCEYnopARBpmX?=
 =?us-ascii?Q?rPbiOqUqHkLlheiSuMQDCyVxSj1QBFOeogrAu7l6AikQRD4DizhHLmALn+eh?=
 =?us-ascii?Q?YOc+C/qjoItZchoQ/q8z+VtiIxrReJ9cLJEsK7CZ0zJTN3oJR8jLu8Ux0s0/?=
 =?us-ascii?Q?FkcMSqg/qel0HgizEglvjv9peBCry+Gxks5b2jIE86KIR9AwsY6171IEw2kY?=
 =?us-ascii?Q?zYyHvFcF22t2Op4JgINC7jEjcuUEUo9dUZXrnyyCUa8bEONAQbrfZ6G6lm0F?=
 =?us-ascii?Q?URq6GnFnGw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee983f07-e371-40e0-2b28-08da4a143a58
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:33:17.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oho4wuhF2/kLa66YxysApUkAramPSEkOU3qG68CQaZ0VfD5zwoKtDUet5fR+oNAEk+66p3muM9Dc+eXKeYiA6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4475
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is case that after remoteproc start remote processor[M4], the M4
runs slow and before M4 finish its own rpmsg framework initialization,
linux sends out vring kick message, then M4 firmware drops the kick
message. Some NXP released Cortex-M[x] images has such limitation that
it requires linux sends out vring kick message after M4 firmware finish
its rpmsg framework initialization.

The best case is to use a method to let M4 notify Linux that M4 has
finished initialization, but we could not patch released firmware,
then update driver to detect notification. 

So add delay before linux send out vring kick message. It is not good to
use a fixed time delay in driver, so I choose to get that from device
tree.

Peng Fan (2):
  dt-bindings: remoteproc: imx_rproc: add fsl,startup-delay-ms
  remoteproc: imx_rproc: delay after kick remote processor

 .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml    | 4 ++++
 drivers/remoteproc/imx_rproc.c                           | 9 +++++++++
 2 files changed, 13 insertions(+)

-- 
2.25.1

