Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97DE4C08BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiBWCcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbiBWCcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:32:17 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50084.outbound.protection.outlook.com [40.107.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2FD583BD;
        Tue, 22 Feb 2022 18:30:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvM0706yoM1TudQ959xM6yDajiv7WqE7S1plqg9JDSgYAcB3WWv1boHKxa47vLbmWaoDESgPoT9QFTXke0TmzCqYgtAYUVeEAe/G69JeFYPXITQ4Bcl/aXp4htDz6OVfS/BMQXOlPDGRKVMzOewuU5uZ9Hv08VltX8BAWWculHlovaQY7xJRi7BqEVPVtlvjBNA/+2GAWvezSyPiXzzTG46ND4vB+POblnpgv9MBCIgWR9OYo3b51kibNNYbDSNs/SoNnrMXhNe+WZ1yP3p9TYZTD26GvoS/UQbwlQK2FL8sQgdX2o7nvIfBw0hy5UJpgauZw2bSDz6S9XmTt72wdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73SDP+aE6VE3YfBfWU/Uomijd5snCN+l4IiFxsHez/w=;
 b=PWecxT3uWr8CqXcjFDWoHrA1WE5gTIjpL2lrZn8UqtFonQ8DOjN7QUiC9iFM8M3w5fxwgVDM68v3cbrO6nB9gMES+zhfmMfFARV7Jt9o0XcZD/txOZIY8ULvtxHg54hPN2NjNlhZUjMaxfK60HTNEAO4biJ3tU/wvL52JGAwcLaVwRFrb6KHg7Tnf44jFn4reMFJ6gl+yTCK0WttO7j6DXYKmT6G1BJEnlcsqVOLMM4+mHQ0hZXwDbjRdIKIFIAgdKxIAjz6Wp6ewJfnYfOntrmQNopDZFMnYS5zgmAZqUazGS79RfPPCskWvTLUiOwYW78y6oOIwxMKsDctn6e8Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73SDP+aE6VE3YfBfWU/Uomijd5snCN+l4IiFxsHez/w=;
 b=KqeHcUeaqw+g6RCrmS4X/CuidSNJ1TojA30lbJg83ZrbLjqJnVVQabxahVPi234L0R23ThNHayKjIefEulSdyw0QmBKiZQj6adgyG2Pa6H2wnLKLmCisaJTYFnxmfXQSCpNq90zRPfojBRCqS1t8CZEelhpodxUsRWKf54YsQGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7311.eurprd04.prod.outlook.com (2603:10a6:800:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 02:30:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 02:30:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/5] mailbox: imx: support i.MX93
Date:   Wed, 23 Feb 2022 10:31:52 +0800
Message-Id: <20220223023157.3478540-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a8c7436-667a-4e91-1e98-08d9f67468dd
X-MS-TrafficTypeDiagnostic: VE1PR04MB7311:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7311A5A1E2EA1E0C7D0D8BC8C93C9@VE1PR04MB7311.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKtxUJLq25Y6Y07xVeUAIe58ulP/5PLPMtFepSuU2x6gyikYb2H+oY7Bf3Fz8KNMehDsBhgwXCoL9+QD2qsgncDQUACkVz1ulr4yBU9Ao0qDgKvyS9oSIJBmKbi3ks1qYUOXiSQ0q4xcVbN9TcSteiISK4KvOtPIE5g1kjwv+FyKovlSDyYarE3HXWuKtm/YZkbmuE/CXN/CLauVDMS452nKCv9kAZH/h47HoYZmgen6h/ZwNsgVXWAoN/8Z68TV7iw9LS3etXT2nM3rV0kr9N/LDe++JRffnlr5lwHznSWlugh/9gT2T4An0hjFLdIg5PEC4zq6BKai18Ls6JD6SBK9xCVqx4CJAHw+ddrkbK6zt/b390767Mh2uORcU3QzWx2H38ExKRQ9MyM7qnr7d58HxgyxRyR4wU5dZP7ngTQ2Pwx58tYXT8k1c1bnqzsDWuiwDNaH3GrG6QWEV/RnU4uhS+7prnAY67wuUFP1Lhwgf3q3CvEysiViLYQKL9XCsU3LjR4msFYoNQh1pUKayxbtEvKsF9/W/uTaX1SyE79F72Iybr4Guj/x52HwssLHeqLGrk94uYXfpfoz/a65qhxqYtGGYjNzAUBVdRXyFjf9YHyHyE67T0C2ekjY5Y4JgUbXCaZV0ON/8OUr1wR7gqA+ap+6AMcS1mhp7DmPOfY+tI797IokREFdnq+huXARXw6DJNmDM/7aKWi6HtK2xKOLthF5rwTLDbdwvTfW2YeqG+P4K76Gny2Sz5zEjqsH3hSg9CSLLLMksSBpqZZS7GRl7ZaFwvJwvcTjWeShBj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(966005)(316002)(86362001)(26005)(2616005)(186003)(1076003)(38100700002)(38350700002)(83380400001)(508600001)(52116002)(6666004)(6512007)(6506007)(8936002)(4744005)(5660300002)(8676002)(15650500001)(66476007)(4326008)(66556008)(2906002)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YBJHqOb7H7aeLXuItZdTt15i3KdNGx11868jozHV/SBw+PsrqaPtvM/4Ockp?=
 =?us-ascii?Q?s0C1PfG4yy+oV9YhGL2Hwk/HyO16Q0kWj4TFlG6j5EH8Rp9Xx0T/Q7FlRTZS?=
 =?us-ascii?Q?CYl48rP0nr4gqArJWKrUHrvfuMaZgfsnyLpq47BBASdk05pIqdLiAhz9JJCx?=
 =?us-ascii?Q?nwaOeklp3nZWQR0O9BLO4YgWpqi0Lig2w5gXzGt4XL3YH4Nz3ciACI4KS1GH?=
 =?us-ascii?Q?WCEd8HKMA9wkFxthbkNcrisyudYJbDmRMIUqfVtHWWOz3onoCaGirElNFboZ?=
 =?us-ascii?Q?fLxFi8DKoCIKjJzXL0qBfEvbqMSNqfgD0MkB4Ef5xcRnGadval8gPI+9eXrO?=
 =?us-ascii?Q?MUXr9DqyWtSWC1HJfumAz4APMk4J3nVGGwZaEvVyGGC8U3tzI8cuT31zan77?=
 =?us-ascii?Q?2ubcdGIkZd9QBF6pmPIXGt1T18zFPkiJHnW5a/eYQbP7CjNgSvEJJ5DrvXAH?=
 =?us-ascii?Q?UzpwzIC9GPqeBR83V+7BujvYfuTFvyBaT3ze/iHUkYE3NusHeRxWCMoe6D0B?=
 =?us-ascii?Q?3XwjE+z6KYPSYlkrC0aVGqiN6RNoG5nrkv5JNRLBhsK4MY8tZthYOjyZPWGk?=
 =?us-ascii?Q?TbvvDesAslJ5bHR4gDX/rnYJdo1bu6bs4UKRNreF809cREAQPLA36xjJYDLd?=
 =?us-ascii?Q?L6khAe7Lp6bR0aLCpey7L9NvESjS9JjyM2h4YlBVs/8xF3TgGt5k9r8e8s9F?=
 =?us-ascii?Q?0dsXo2ZvOPpBdrKSXSyoVVnM8FclqzXRaMlib8jRVWHiMOG1vScCusVCZ96T?=
 =?us-ascii?Q?62GssO+NpekiauagSoLAyt4NYIxt+b17AFkVWHonwPyq15aQ2g6kx4+XabAR?=
 =?us-ascii?Q?kut470ZvMB/I4hP1N9Ayn69EgzG5C9GvaToDz0sfa7Esy9dJ8gg15A4wjnM5?=
 =?us-ascii?Q?beYQ/++aX9b/INQNnx2qiPlrYMgO0bPkgD7DMZG7jElecnn/Nyjjs+aCSssP?=
 =?us-ascii?Q?ppDzzZd7t0ymoTql4p6C/fmpnqIKzM2dTs3dWO+QvC4+bJL3rfAEa3CZLS3R?=
 =?us-ascii?Q?C3Wo2bNk3ZYTnloYlnKYC3Tj7ilktlpUg2xxz5Ga8a1zp9aVh3Ov2S+npy09?=
 =?us-ascii?Q?oQ8e7aZTXqTh1xi3fm5A1p00FIyHibRJ67WgZhbQ44xT2C5fezbPPHjirNoY?=
 =?us-ascii?Q?Wu9czBYsEdESOjkMzPiJJnSq4P6mV5341qPWGM7yJrO3PfksFDzFLoonr8Ux?=
 =?us-ascii?Q?rdHg4AibTbiwi9XcQ4jJ5xO3iJn4DvxHXWl77ota/1ANljS1/gz4lDNc3fkF?=
 =?us-ascii?Q?l89JJ0E4z4kcPtXNllkctbrOULkmVu/9MebnOjY6UKAPzfpbdEFCjtZEZpyk?=
 =?us-ascii?Q?fAGTmjxYN7XnuRnSZTq3pEuz1sFxChI6px/kPXxpHdJksqAbwYzY0NeQ3zPN?=
 =?us-ascii?Q?vUmWT7z6mgxZoKpBa9Lze0AsNQIrZjMvSarIivCqc7DYFjBnlP6306G4unBQ?=
 =?us-ascii?Q?xYLtepip7D8vAnPB/MLVHxksrk5+cMYkC24C2qlB4jXFkcwzF+PtQmdqahCz?=
 =?us-ascii?Q?OUv0pT/e462xu8ihjoCwfNUAA3AoKRXlZphk7yr2LhVTYVVdIP5T2QUvGBIh?=
 =?us-ascii?Q?3lZI1743W630OcKGYGHmw3X+fgYmGATKjle62WlKreMVnkfRy8JXU0UtMcTG?=
 =?us-ascii?Q?og9/TrlpaL385oEku/vgxss=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8c7436-667a-4e91-1e98-08d9f67468dd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 02:30:09.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXC9FQuL0Z6lZQ1zR/F5XMzEzddugMh/7Xp4NlvKtDhEm5sOOorpfMZlB2/Lkg3/ZpnwKAs+0s8YeZVWejvPlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7311
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

Based on: https://lkml.org/lkml/2022/2/6/304
Add i.MX93 Generic MU and S4 MU support
i.MX93 S4 MU has some changes compared with i.MX8ULP S4 MU, it
has two interrupts, tx/rx, so also update dt binding doc.

Peng Fan (5):
  dt-bindings: mailbox: imx-mu: add i.MX93 MU
  dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
  mailbox: imx: extend irq to an array
  mailbox: imx: support dual interrupts
  mailbox: imx: support i.MX93 S401 MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 30 ++++++++++-
 drivers/mailbox/imx-mailbox.c                 | 53 +++++++++++++++----
 2 files changed, 71 insertions(+), 12 deletions(-)

-- 
2.25.1

