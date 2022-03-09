Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627424D2CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiCIKDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiCIKCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:02:55 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DE616F970;
        Wed,  9 Mar 2022 02:01:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSgny7MuDNNFxo7oCJpiZcgEGW2qCUL4MJF6vcQmp6sJkckLnpZYhGZ7MsZGEl/mNchfoAQhVsPkY5+fMQjhwLa9eexw7O9WZ8HyIxpO7qUmkElXaEotriz6p6SydGvTjHA/G73ykv/uYaUm54kKfCENEgXNdzNiH4o0/uJD8WuMZNFPNh4IfhzwbbDXOE2lBO3tYK23ASlY33bS/h2v8s+IA62IvfIZFd3xbslwXystFRj3YadXaD8HnxG6vsn4wUdRd3Ev/vNW2nE1WeCCvLZ3wpJUO92ZIJEt4bJTosFyIdwD8DuzIS77iaGxda+i1j2vzPHujR/+brUjl2Fyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Df9Vm9fu9dyUhjtpBQWGbKt3QSRbHrSne5gXyOFYXU=;
 b=ccXSQNejHrbSd96gbuDf3SZ0iS9+h4XxOUcMgPp9URHkyBY+0lVXEnbrRRC2GZ+M1qEJ+7osGyJSRtXsEDTMRiggp+MD4TgUdyfaexktBnt4UBeK2OzXZU8BMVoTWT5RmrcW7L/0qyMvcriJ5eYQ1BDXFE75Prg58uXH3fW+ZfB1ev4uH5AEGTWe9zdXmP9obB56XZD+YHFrctP4ldCzNz6b7moBx5iywi7hpVxi330rnPflQ+x4i3kFtc3+nro+2NvQKV0IDzfkGkuJ/8m7TXOrxglYgCXiYzReh7XI24nARMbLxIsYcRnTj+frsHlYEY3ldfVufB1RGVx5pm9sQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Df9Vm9fu9dyUhjtpBQWGbKt3QSRbHrSne5gXyOFYXU=;
 b=N8q5xLhy+vvl0LTsy1VR85P5fGsJm97sstejaaYVlxu77FJau38jVg15LwjQpzE+Mll4NJmDLU2IpqaMoZsc4zzBJFIn75U1rlfM864ZSxW+BAjUjYx8UKwQ1fZHqoKTCOkgb5Zfb9bqRbr1zYL9xwpOAUgw9L8JndoCpsqFcts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7363.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 10:01:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 10:01:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        o.rempel@pengutronix.de, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 0/5] mailbox: imx: support i.MX93
Date:   Wed,  9 Mar 2022 18:03:40 +0800
Message-Id: <20220309100345.2633862-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f79d317f-7efc-4707-ba14-08da01b3d69d
X-MS-TrafficTypeDiagnostic: AM8PR04MB7363:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7363FF603EB18919F94D62C5C90A9@AM8PR04MB7363.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vMn/YaKju5OfcyzAm1+rOjr6REt+gqkXysM96NWGaUkfjsTn8ctXtdRRH6PfMjFM5XAO3ImG+ukBFN6p/Qku7hWJBZogms3j9ZxJ4Y1nxBEcsRawng7aBnksJBtyYL42X8Vu9klzNZDlEE6U3OxcqLVu8BFsVuXSP4du7r1FsdHSIjN1KzZeV9pv1jpbRJi7Q0nJRZoDNBLh8AkOKb2PHfVLW3fW+aRZP9VgNXIEiT19ww3VIFi7OznAE9lira6uGNHOe85BLpmKg4IA7mrMFadizquKWAqW869MIApo8tz9YZvdFe9p3j8qo4iBC0J/hQl3aeML2Cl24BtpSj4RtHDpUFx8z4W7KqbiPno22GAgsK1PhWeYZdjwe3nKM5tyQuTbIwotyJxUc0b6LLVshrLWUT4LITUlw+jAcg+3EulgTkxvQU4aY2DV8rcuZ42BJV/uezuofIVM1WZ4rSQhJj5/zSX+hwI2+H3B9lE/zALoscK3KKUq1MiqfZ/qgzEJWVNJGwq8vqYcQH4jHAAS8PXAtXKQV40QqQUl6u5A2jcqFE69cQx3HfhoIH5CT9x9nOe7W6x1IFqYp+If1NWrhWBVlP2E5LBiOaPVgQa3+haTaD5BmlLVeHut/IloBnPtd14d/hennEOrL7yVVk35sYZ70OFdjPldopHqaTPyBLtNq0DE7KBy21lQxop7QFDyI5sTcTDWbYe+Ndl5nMU+wxBuPYjFdUitdb6a2VvQI1b4znZYyOX+f+OItj6BwdTqHTYoo/y/SNaX8jmdx0gscn9T6EkIuLGW+RuUzq3wn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6486002)(966005)(66476007)(66556008)(1076003)(6506007)(8936002)(5660300002)(83380400001)(498600001)(6666004)(7416002)(15650500001)(26005)(86362001)(2906002)(186003)(38100700002)(38350700002)(4326008)(2616005)(52116002)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1XBFc9Qz2vLuC9KRAh0ziPieVnlKjhzLhFn6vyNMGHIYv5gU628IwvMJcO1o?=
 =?us-ascii?Q?3JPt8fLEAYtnMCbfJIf2MYfDljVXjlb676pUwiAYgHo62BdYf8rOEg01EYHE?=
 =?us-ascii?Q?Jkv/2fllXS8at1fhaa6woZG+w808/dy3I8DvFUow+p2R0WR0JFtl7CX0T+6+?=
 =?us-ascii?Q?kE4QzJAwA4PQUq3z76E0yTZpv9jG2bVP32WBFGxDfc7hXM9hZXNOfcUw+f0l?=
 =?us-ascii?Q?v5LOCXPebWq02ca8rbHiV/bBYdsvnnuj41+fxca1+XqjdZTNc11Qe15i06E0?=
 =?us-ascii?Q?9BsozlvxuWeqvqFgx52wMyhzPKqFNFhhohS6wMbYFXxGKjJhplcsoKssGTLH?=
 =?us-ascii?Q?cfPdXJHonRyLjBta6BGSvubrEdbYbG+peIpk47VKwvnhl2bgiyXamGc45/m+?=
 =?us-ascii?Q?R7xgDyPbFBnSipz8fRygWwWj/Yt/fprboiJvHwuaZMmzAUSP2ASmKXAp4fNz?=
 =?us-ascii?Q?hzupepwNTAfACLelZzDhgpRkqhZAZ31+U5mf6KNGpiMg6U782PC+i9l9ZHca?=
 =?us-ascii?Q?v7+jx6kJ+qshg4Uzp6oRGJf6yMHPgL4guUFL3LwhjrjLJVI9PwFNo+ygDMKa?=
 =?us-ascii?Q?XuHNiCFDQjnx/vNnS4oZx9oM4uhi4W+BXGVAupcdclAf8FLlrFPPY+KjtXhM?=
 =?us-ascii?Q?7OF6oJEPlChVcsE5Je4+RjOWY4YYqvtOOCWJSCCsGjiwv0MHaZAuFsUa80hz?=
 =?us-ascii?Q?GflcUAzouYQTuk07nXWclqHikmYNUi3gZMtxRxyTj3egv/kvK3yjZHvphDgX?=
 =?us-ascii?Q?aHRxxQuW64gNZ77sjQpf2LBRhj3/uFQWxj4ViuTJ8qD3t3wdmxi5fGOwPfLi?=
 =?us-ascii?Q?JSEyPxgdAvq6M3ijJwbQfX+BwlbsdYuwhQYGJuX6hS7eFfZFtBdsug/Rsh1l?=
 =?us-ascii?Q?lOkr3MMCVCJhIJANU1Vx0lMd9AcrKTc/y7U5cfMBP54S0do0Ch3LIalVMjgM?=
 =?us-ascii?Q?P0+2I429vot7iNMZ1iCIbMoqYhuacKK2TAzN0Im/hJLndoWzmLMt+FmfEdSD?=
 =?us-ascii?Q?CR8SxhP0Fdm7l10gRQaMV/jbrat9Xc26CklyuSA0P4W+lNV0fN0L8ZIvSCzD?=
 =?us-ascii?Q?gjA+9ueu2VnofjRFkeWf3R8jHL6wiH1iZIt4fL2fyBpIf0vRMArp28IAnveu?=
 =?us-ascii?Q?Wt6iClaxjOW3lXGCY/bg4a8/MOJkFcV+ezvqpkLB9GU6mO7Vb+4eycDplnZt?=
 =?us-ascii?Q?UnZkxlV92rX16d65HdALPN+IzVT4NwAFFLQlafcydMuUkYQvuVaNBShKvjbR?=
 =?us-ascii?Q?Tfqp53SgCu9lvTsdDjnuNE06H+j3dNf7wTUHNltcUN4wNCU/YtZBmjF9rvgr?=
 =?us-ascii?Q?khZVFEX1UmYgx6dh9gphsxRAJ/YkVXc6t0RvB/mlYJvQ+CmWKFaCZyBVwGFX?=
 =?us-ascii?Q?BDXTE/r6DdUFskJUOZi+offD1C01srQhd0s/xk5Wi1sRowvzd4G4NJnM8aQv?=
 =?us-ascii?Q?g8OcAbx6LP307oB5EkiGNbjBvA2JfabD6xmVOFKnGMm5JRsfobQF7nSmxZCf?=
 =?us-ascii?Q?bVTT8t7aNYNJtRtksuC9Tp0qcU+2b5pWrR8tV1TEdZv3wYfptmDvxWr3o98Y?=
 =?us-ascii?Q?U2e9A20WF84udMoe3tNFd3OzoianVRF1DH2v1GGgAmYE/lnyU5efQu2n75Os?=
 =?us-ascii?Q?POZ1FUPWzyFIUWT08Egqsx4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79d317f-7efc-4707-ba14-08da01b3d69d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 10:01:54.1485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6pzx8rDrQseOomvQgzHVUszczGagJoVn650OXrowSIdHkwuXK1+AxQCMl7oFOQnVj5pKpNx62RXNy6slj+78w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Based on: https://lkml.org/lkml/2022/2/6/304
Add i.MX93 Generic MU and S4 MU support
i.MX93 S4 MU has some changes compared with i.MX8ULP S4 MU, it
has two interrupts, tx/rx, so also update dt binding doc.

V7:
 Per Jassi's comments in patch 4/5,
   drop authorship
   use hard-code for enum
   drop magic num

V6:
 Follow Rob's suggestion for patch 2/5 and add his R-b

V5:
 Per Rob's comments to patch 2/5, add minItems/maxItems for interrupts,
 Use minItems for imx93-mu-s4 interrupts

V4:
 Add A-b for 1/5
 Address Rob's comments in 2/5, passed dt_binding_check and dtbs_check
 Use tx/rx instead txirq/rxirq in 4/5

V3:
 Add R-b for 1/5 2/5
 Split V2 patch 4/4 into two patch 4/5, patch 5/5

V2:
 Fix dt bindings in patch 1/4 2/4
 Squash author/copyright patch into patch 4/4

Peng Fan (5):
  dt-bindings: mailbox: imx-mu: add i.MX93 MU
  dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
  mailbox: imx: extend irq to an array
  mailbox: imx: support dual interrupts
  mailbox: imx: support i.MX93 S401 MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 34 ++++++++++-
 drivers/mailbox/imx-mailbox.c                 | 59 ++++++++++++++-----
 2 files changed, 76 insertions(+), 17 deletions(-)

-- 
2.25.1

