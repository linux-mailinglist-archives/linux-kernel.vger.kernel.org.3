Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DAC54DBEF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359590AbiFPHit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359596AbiFPHi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:38:26 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30045.outbound.protection.outlook.com [40.107.3.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4846356767;
        Thu, 16 Jun 2022 00:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWUf8xNY6zvGrVmQqkcFNA+aOdhW9uWJT15ASuPGhsYKE4gu8LD+Oxy23olUyKfDohcjHLRlbNEZVrwQRxirKi+VHsNJD+F7tAWmeygSbtcYwEfqsvcmH5gSamLR21yAAUB/wcYv8WrmoAWWEghLB6P8vgI1icuNKrVv8BvF22cqVhfoZfOVB/a4pAU7hhJm/l6ZgnhTElPrWJJ6at9DyYWonyjXOEiV+qM1/l+HXs/jJ699E9J2b4P3e8VwD+q1XTsyUZvPSKHRTQ7ENSMnQPe7BwbvSAStwcfq4KT/YwRPjNy/6ENMw6DCv8wMFYw95BnD///5uBhUb/Cuf1CDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33o/Y/ohCYZp4xzeDP1SPYbZC/8TudY+xtcUlfmjVhA=;
 b=guT7OVctVpga/opvVizfgqIhcSo9ThMMWJ9XkVdx/RxqdTAPYS3GYpro7phHcHuOj06Oy8aX07TfGDU0biDO54y7SroUvme/a583RYOIQ4q0UR3ytNI1dZ+w/1IjmdGLokGi4hEBPcU+U2Po9C1aBercs07YcIYdkWN/O8hQXu+RdijrD8l9lqyRYw2wzVgkhogNZarY3MpAb28SX8OvH0xZAdTGNx6Edwpv0fzny1kCd1ssKmJUeI0wYHc5XT2kYHapJ2ZIBTajXWxyevonf/jf8rp9jB219dJuQKTuW54KI8dQb3re03Q5xl/2M216DKl6dHvn0XLfDBjaionBUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33o/Y/ohCYZp4xzeDP1SPYbZC/8TudY+xtcUlfmjVhA=;
 b=CHTHJcigixZeWtJ1jCkmuxHBnnpzQlzhee4p7wzGN82Fp3nJNe4lJw2mOgZAEr26Dm78mzsBmAd4pg7JWJnckmSUKVQ6MlQjBIGPTGfpHwV4n74haWUKTrN42paEEqVnfdtzhDMLlzf4lg67UDgtBuIsC+ScUomghxbCn1/i7t8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Thu, 16 Jun
 2022 07:38:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:38:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        marex@denx.de, aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 3/8] dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk ctrl
Date:   Thu, 16 Jun 2022 15:39:48 +0800
Message-Id: <20220616073953.2204978-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
References: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e93700dc-0c4d-4e8d-e030-08da4f6b2fd4
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB42933F293DE66CBB1360F87FC9AC9@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCDGO/6geS8wRvzfxJ054IxFlVdzKOgHLG2jMRcCAzb0hYFqIILnpZ03HE2tkhwnGaDs2MDCBokp5pGcwKErJj2ZXG+BSQzyuMqkIRbukckZKmp3qo6RS49bsAmELGbdfViTp5jaJ/RG0AMf9mVhooHjR6X/l8OfoefI9pO1IbT6fPf+hm8zSz4RNoRytcPE6tXRbdh0qxccLPCcFuw+mLDizDwbyxyCLN1F3hpTk8JtMXewqjoJdL50j1rRJBiiejnFApKrjtpapwGhKFSk3ZLpMDj7QgIyVE2Dzr15Xu8TOHoxENkj4+9bMZrwt64Xvn9LATaU/ZoIHVRFZkM1m/OQcCyYsw4ian/PbIhRkKcFKiOohCU7nsgLtYaO2G4tZRGo1EuxFEY5lyT5IMt8MGEx7vnTH+E9Mmt/PGSO4wI1CQxtKoyr/o8gG+F4EXY0/zJj/sO/KFYBtZOCYen2ICOkAbNFIoeEz96qWlZkhm2awdCaoj/PbvhVsFIWwQkqwS3kqsg/jrrrkkqgx79Jb7dIrk0rK7wKv5HFxRmg4RRIkNxRuc6ARrN0j9glc4KVYBoiAByIh+OAzf6NqbtyaUMY5cMHzDwWuep4nF2rwuTcVv8rHNM0hBdJKms+IrvRJ7lGso2nZHyRiVzA0H/FS1t69F9wkrv1hBZF9kXXywlcXxp8wbtTU+2PvaNUQmPwoOb1a/enJOfVovTT0rCyJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(6512007)(4326008)(2616005)(5660300002)(66946007)(8676002)(2906002)(7416002)(86362001)(6506007)(66556008)(508600001)(6486002)(8936002)(66476007)(52116002)(26005)(4744005)(316002)(6666004)(54906003)(38350700002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xM5Ts7Fm/eMngukH3MshKU1ou+ate1qC5hF0THDetkFQNsfoRixW/1SOG8YB?=
 =?us-ascii?Q?3rPMWqBX3TTCP3v6QOnWdpPTv55DNUqWshFifl0TwTmz37WuLBkUN61IX3qU?=
 =?us-ascii?Q?0L7KA2LT0oxOLo248AwDrJqPV6Oxdf+BP8qC2GI/ljEfv48UkZN9/fxVp8Hb?=
 =?us-ascii?Q?XdbKZ79A2IzZUCTYKuk2MXAXkl4mAORMBJ1SNkDOOz64NW/Jf0jXAp76Vexv?=
 =?us-ascii?Q?Ifj/oYMQa9t4DosrjjIdul65RR6V1nZlWif45eTw0rkU9m23MT/lm+DYqcWd?=
 =?us-ascii?Q?X+vYkVmBtMhbS3tOS3dFGO8YJVhO5lNhrr3/hekeMxSOpLk0Ya7hqDQPEVSD?=
 =?us-ascii?Q?ih6Q5y0FzOG/TDbgGkOziSQ/tJOEswAjYgJU25fuVfArEDf2rQ5nE91hI5Ln?=
 =?us-ascii?Q?CTVme0aQuAEtr7GMeeidtCXPLH8ZpVYQDLx7EP6zjrJp9YTYnbPQtgDOCNbb?=
 =?us-ascii?Q?gxUrBWNSTRUfXik38DSLHDEfipVz/ARk/yryenm658Gyzne7Db63jyFdcdL1?=
 =?us-ascii?Q?zALdztdAlavLxkCYEjfceVEu1IM5tQMT8nKPe3lVmir5mYLYd+lmDnHCmdEq?=
 =?us-ascii?Q?kcUocJt3ZhC4V5oDg/2QYTyD3iKTH2bkwa9opI2bKqKrKexTDmNawuhFvDcG?=
 =?us-ascii?Q?zN51L7DJuNJOF5d5XQyWiFYXqBdWRKOU8Zu6/IhJClxqlikGXE2yP0B3Aywu?=
 =?us-ascii?Q?rSvHatKMtotBDFbNgLOwQdXsMch+9o+zyFx0RjAv7U5ll3jiBWEljJLWa9R1?=
 =?us-ascii?Q?GQsCyPeEaiZHQbYJL1LeDjsU2XsLZ9hnLbM3uwVePzTZC0pbafUJYazda0rn?=
 =?us-ascii?Q?eWtFOYLpsQBclk0qfOFZBICp9shG4vNH1cwezIJ2A8FFeXo00HNOPq69XwDx?=
 =?us-ascii?Q?6ik/thS2rYj2H6duRGSMIg1juYEXl7VXCwzyRg5r4nPi1jXnTh6x9g3T5u1s?=
 =?us-ascii?Q?a9jRV72EouZiKBNQX9prJvszMRxWqAUPzSIOwCInSg8eLcSelCBR7wfuISqh?=
 =?us-ascii?Q?k1Ys81OlUkmR9h3BD7RNAlWay01wsKN5hs2nRnVIkF6mhwt/hnRNj3yZdWeQ?=
 =?us-ascii?Q?u0H2tJ2HfFolyZDtZuUMzOamKFsf1u7HMSdMCjUdAVOYYuVwCpl3BnyttEi2?=
 =?us-ascii?Q?1w/wLfD8Ok0/ZGd/7osE+Bg0pypAaA3Quhbs+QQfHH3+2ZLow1q9vRYj1F2U?=
 =?us-ascii?Q?WufMuZt0oZZDS2hp4GzlCIB5wq9Xc0X807OeNGF0u6P6sE21NgDs3xa7dJDM?=
 =?us-ascii?Q?SjNtUdyQVf5d1deNGnvyPScKxoQmlpvzAOwnWp/1yaKDGfVvxAfSY0f64gHe?=
 =?us-ascii?Q?tYI24AtGYol/rmu592z3ReA4bPJa8as8Pjx07FKSa1GRDuLhMLn3nCzpgkgO?=
 =?us-ascii?Q?J269DCMSeRBiK0vqOAEZ/37oUhUHpXDb7KDh1haIUwSsHNU/EALqmBpIt4il?=
 =?us-ascii?Q?nWOOl1Yeb/PX6ot5MFuksSp6EGiVxrEHJkXAuI3YrbPkBODc5c6LWo7rX/kU?=
 =?us-ascii?Q?lE4FIM5AN1Q9Zil7hfGtxLXH0vkzNwJowp4oO6VRIgij3XGis8b/HhlZ3EwC?=
 =?us-ascii?Q?7X2tbfMTbEwY1KFPRTOkO5lPt/rtqYAm/mcT/fx5Jc6/GE2BrDUPK2HO5UKh?=
 =?us-ascii?Q?Ka626FDTe5YSN7WR44bw4p5uvm6MJ5Vo7LPuCUZ7QcrmUwagpprDjTsN//iF?=
 =?us-ascii?Q?6q8qIvqqrUk7XX2YIp/QjzfWAmcBHf7vzqd+aY9P2hyeZ/DApssmAyWqQuxf?=
 =?us-ascii?Q?ldd/PpfRhg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93700dc-0c4d-4e8d-e030-08da4f6b2fd4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:38:21.2202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6oXnI6cHZN9m7gdEw+kCbnzRAb5Y7vWYT++5Ew8DFFP8qA8BbtpiKcW4WIWuSlw58r0f6R05/GRsj4BAknTWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for i.MX8MP hsio blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml
index c1e29d94f40e..c29181a9745b 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml
@@ -48,6 +48,16 @@ properties:
       - const: usb
       - const: pcie
 
+  interconnects:
+    maxItems: 4
+
+  interconnect-names:
+    items:
+      - const: noc-pcie
+      - const: usb1
+      - const: usb2
+      - const: pcie
+
 required:
   - compatible
   - reg
-- 
2.25.1

