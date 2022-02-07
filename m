Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C544AB86C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353391AbiBGKJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351094AbiBGJ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:59:29 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063D1C043181;
        Mon,  7 Feb 2022 01:59:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew91qcxBZiNAy+VAa/+3XwrUfEcOK53JvpMuECw+Nmq0qohmpX5A3jTFSLQdVTtINpmmDEV0TUaVGQ5HaNmuxm0jKC+f47WHvjDy/39B1gGxfzfiIhMPHAtFFzQ3uDjrw1UVWOkz68yfxBOVuYTNdbWD7VtUvxvvYcO0WHKWtptGj1Pb4S90sxv4BJFStK+uUc2GE0Tiae/BIu3+Fh5HNgmcH2BOblpL1JkdHeKyHq43RRqDaIaxzMqHqiDUpVhPcDACBk0kAnvNM8CsF7RZW7HGm1gvKy3YAAUnufzl//YkZbNZzf8pG7rhTWT3MLWmpkJDgb/Xaqy5aZ9NIvLO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=951WhHjGYG1Zyxie4/RumTW1GCam3T+irx4jp9XzTFE=;
 b=W58Q2MQ5inJWTlhV0xfX+0k8MjdsLqY+mJHsZTqsx/tKRKHYok40oJ1w/r8fUnpLm6XwGrm10ekHp5272A2ZloKqHw6HQF1Ahg3R2wcJTLx16HgjRstesIgAAoZLP/iwdAO3EyqOrr8iutTlA5Fhu4ptENJF9vbzSLdP/CHV0bXwMii/KdbBhNtTE0PDbQh89asZt1LA4X3AcLwNuiHcHJWwLvfbueUZPJoV+FRvZFBloICxy16tQwNIFJAlQUqb9zkUGeqESNxt7Lnf1jrCCOHK0DesDLBQqe38qbxxU3TuMfkR7Q6w4Ur50w5HQfIlKaUh42ZoUQYrMKsdCvhZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=951WhHjGYG1Zyxie4/RumTW1GCam3T+irx4jp9XzTFE=;
 b=PVI0uwXfrk/Tk9/UzSOL6BHJsseZMpzfMi38GM2vVJouLEPNnS50hdmY0+F9iIPvZYk33bP7b9uxXg+2WwhkatUs9J/erSynOcUQyWJXHasjp02gzrCvqXrMz1JDkKNcxzQvzJt+hkWfjACRjYh7w9heec3lvqLWx6jY4hIh48s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5163.eurprd04.prod.outlook.com (2603:10a6:10:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 09:59:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 09:59:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/5] mailbox: imx: support i.MX93
Date:   Mon,  7 Feb 2022 17:58:27 +0800
Message-Id: <20220207095832.1590225-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73ff1eb0-8a7c-4357-2ea2-08d9ea20854e
X-MS-TrafficTypeDiagnostic: DB7PR04MB5163:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB516324CD85BD3BE55E9E677CC92C9@DB7PR04MB5163.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svuYXrNEW/6cwdTCwxC44MuhEntbDg/zUTvAXVU0fF7eH0BTyGL+c8GprU5KJKd+ewQEz++jg/7DO+YImgMZ8i84qvaQRzOyRcJ6xSxSMnkki04pyQzENhegnsBDWM5NQinUSSxULpcJ5cUOgfURSJT6e88UacT6Q4PBoiJOFZmZ3FOc7Gg/pC8/55Q0qoJioswu/QHIbWzpjVrYxdPOPlhCKYpcIkw0hT7W93oVTJE4AaF6YCB9kXKgOxjBnY6qaQEmA85vVCC3MKTO8PhgnGRDKvXbOct3Ccz+m5YqtxXrUYMpR4b9gfmfvWDAIwhhnxx/QgpqgOhuxQHwiovtu9CI7KmzY7f3wcJ5E3zDtQpB2mG3ftoelKN+if+pb+SSSUq1IC3pnAB6+uA0d6uLTzhEAYdKpkrgmbIEGuvArUpA8z1qSuu4KP8v9t2jw/4f8itpQuug4+KdPad9MyIgIdfaTaa/dSIlSyipKOhh30mpxv4H1Te/aGc24HNAFhLChoh2Lu6s3gCNCR+jNah0JrMDVn9VEUtWecxGa4r51ZQjp0X7rnzSDjLr0XpN6L0riNo2JT8GT+vW+gPRW2tiCN/vH81DFhfxghIBdWwFYN+Q5ZIFweXXmVHvaBeWidiJiuM6++hP5Awl7o7k6QqkwDUhShzKHJf6rLRxx/bWHXgdf6c3Owpsdrd8f8jaNzekE/3ND1QruxCacI68TtmJnzd1i6RpwClqw5aeJPyh0sMyQTUz9G+9i8kDFqXbBr27UvBSc/hjlzs2aUwmAOD0WvaUOCT2DMsY0/V1T75/IPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66476007)(966005)(38100700002)(38350700002)(8936002)(8676002)(66556008)(66946007)(316002)(4326008)(83380400001)(2906002)(15650500001)(4744005)(6486002)(5660300002)(508600001)(6506007)(2616005)(6512007)(1076003)(26005)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wbepbNQrmj7aOHR2rU6dfYv5wxlPXLBuI+zffdE13p+FxwsE+06cLuMppk6E?=
 =?us-ascii?Q?FxTmGw3exq+K325/jG7/MFiTz+2qj6p+YsMbOCyDxoI4pC8CjOTCeeN3djEU?=
 =?us-ascii?Q?HrommB6O1DGhav8NIid+hNPN90ZryEZNhmDqrqFyNn0NEqgYngGetLXdYG1w?=
 =?us-ascii?Q?6abZHBHIaI5EvwLYyOt0zvlRVhCSHBDrB4gEoHje2dTSfOpe6gkPUcMTzVkq?=
 =?us-ascii?Q?VYKN8wQRI1yUapI4UVZW+cQ0hdyXTGNn05hszNMw992duRR0+2OXnWiHydOw?=
 =?us-ascii?Q?9Kz0htsgnIeOfoMLmm/QdwsLqOqtLNoVtMs60b7m7JPNKLJLz47drxUc0yz9?=
 =?us-ascii?Q?bdGj70uT1SDB0KSOzMvErH1g8W6fpgS1sUrzR17uPU6gbFfQPSjM5sDi1cQS?=
 =?us-ascii?Q?GeXfyV6+ixsgRnbW9E2RACg/j8EGQHw3ttYzVlJWKyjq81tx+PgnyTrPeSUX?=
 =?us-ascii?Q?/FChbm5pmZ8xvAf5iRTPfYKOBp52++Lfszh5wPfgW5O9MD2ddh7ck1wjaFIO?=
 =?us-ascii?Q?++1pn5RSbWbl4vAjxp5NonjmoCAF5kHWIu287jRjjk7lCy1KFx90h/Ysn3G3?=
 =?us-ascii?Q?O8SIB4uepWaArjiXiY1fALkW+eW9zvmXaH9C2SpNRpTjiWLYwBP9KiUNyppm?=
 =?us-ascii?Q?x4mlxN2b+BQgpvsUWJ/kA85Xxv7nRgM9qveft1PYL7x8BVnDyDAXpmVH/bu0?=
 =?us-ascii?Q?CebNQ7eMP6STZobNarO/m6ijh248wXQy/nfXPaQYW99BaQVvTdwCKHjD9MU4?=
 =?us-ascii?Q?Qr2vMTcFQnJ0iOKkMVI7haATLWu7TWWD4htp3aPM/lT4dGXml7/37sNsgAiC?=
 =?us-ascii?Q?qu9VTtgT1ljhavQfVLpaBXmMIUJRNU5nEQXaRdSgLFiqkMyssdJ7niVzNNA/?=
 =?us-ascii?Q?eIUZHnlqzwcuFLOGPrBC95FXxy/hRCMNITHuwmpQj7WEnOmb8J47vou1MClP?=
 =?us-ascii?Q?lYLWQmNwzFXaFt0UGwZrDC7Hb5FuNb0HH95IaKKQg7CS2TP6Yz09UJ05jgNo?=
 =?us-ascii?Q?zyalRlyaYEkDfyYxnTMlwWWsbXBmSq5YO2r1pWRdV/Wmd2RjaI4cNbRi7lia?=
 =?us-ascii?Q?riRnXqzyIzSJ+0sHPetT6Cx/OtxXTwSUForzAWgRmeuvIp7ixn85KXARxNke?=
 =?us-ascii?Q?JqgHa2/UwkOGOHZXgKTQlCqe+afaubm2J56dXS+t42/6EnnTfn/0N0Cbwo1N?=
 =?us-ascii?Q?nGaVd5xeBM1EY/26fBrLZKP61WKX14iypUzz0fLUVQFxDeWT0L/Zf3j8O4jo?=
 =?us-ascii?Q?k5a28EE/NQzaOe7GQBDIDNFhnJPNKjomn+wTX9Z/70FVm+z2CIxZym/K0P+b?=
 =?us-ascii?Q?7CL2ba5T+ojoRxQaF7XgWGxTANvbig8R08QvwSd1NX1JqZUvRaIr9U5lutMH?=
 =?us-ascii?Q?uCSXn3T1FS67amiO6Idi1qw6XNgd6totFsHrgcSk110N8S8+V6VBTaOX9/AU?=
 =?us-ascii?Q?/E2SGPpOED9fDJjivmNpa3OIZRXt+f6l1ipitSTQvgOKEvexoIc0U92Tm1sI?=
 =?us-ascii?Q?LuJdwsstR4EpDok1f0D0+2karXUSNwijY8H+TwRAVWzT3aUMLvuNAbYW4HyJ?=
 =?us-ascii?Q?QsXsg7XJde8f1LkBXRZ7ahr0llL2HIn3fxGW85cn/tLyn62ky4a/+0Jt/Isg?=
 =?us-ascii?Q?8V+UZ/7Dm97jHn6UJLWRMWs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ff1eb0-8a7c-4357-2ea2-08d9ea20854e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 09:59:25.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Nhf9KVRikmdbRO45sD5LE7DpKT0ol26R7+eIPMOAUvsiz1VfwHzLSR0p9QU3JeEAerp7V5UYP9g9P1vxkgkpg==
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

Based on: https://lkml.org/lkml/2022/2/6/304
Add i.MX93 Generic MU and S4 MU support
i.MX93 S4 MU has some changes compared with i.MX8ULP S4 MU, it
has two interrupts, tx/rx, so also update dt binding doc.

Peng Fan (5):
  dt-bindings: mailbox: imx-mu: add i.MX93 MU
  dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
  mailbox: imx: extend irq to an array
  mailbox: imx: support i.MX93 S401 MU
  mailbox: imx: update author and Copyright

 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 13 ++++-
 drivers/mailbox/imx-mailbox.c                 | 53 +++++++++++++++----
 2 files changed, 54 insertions(+), 12 deletions(-)

-- 
2.25.1

