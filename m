Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA0948A668
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347184AbiAKDgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:36:05 -0500
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:15405
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347216AbiAKDej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:34:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEBY/NIqo4FM7KHGrmc2GytrY1aaRCmAPXG4yN4y2mTXyv1swI87jdDsTQI36W057dG8BHDg+FCS58fFMGLsgbN8mKXMrpPeAzn5TEcjDM1Ntjehkj08C+3Us7QUfihQ/lVwd/6J9z4iu0oECDwQkhZ9iH7SP+RiidEz+JQEtvYaxWcOU5Uj/rEZr8OzmZ1xZSEtYotMM2vKoCF8kEztdyHa8HCBxVjd1EcuoTS2s5EqFzc0bW7RluuQrgJo38zrGb5mPMLNgLdrH22pn7VqXGNvVSQZ9jtc78KRbxg/7UT5k5wuUYFIeKVVLiAbGUI0waAAZEbk9/kH2SCgb57ULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IFzPUSSyYYgh9VI4SlcL5UE8mUKGANzRbBq1H0nxCc=;
 b=TJ7NgM1FbsFlKJ3EsV00Dm0zXE/I4R38OSo/oej7KIBBSy/j/c63ogW6QXLARu2dJ9ewBq4I+4T7lByaf52moRZ2A0DIZ+VaigKfOO36haKuz0WcZ9fbh2CA+V+9eY7cF2dhIMwKby3w/1gy7ZX7B40piaTjIK42YajfqssSMERF+ckq5WJRcaolusNbP96Cu7QV+Akg3OGkidrZQUqaLqDT84SUWacggPkh2Sui+z6mBFkSzri1tx2xJH+sDqoxuJ3DEf9Fr/tbDBs0q33gPAHosx6Q7VHa52e4GLpPMqHKYh61flfHGTp7cfKjPDKKTVU8elkOLw/iPpRYKhbp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IFzPUSSyYYgh9VI4SlcL5UE8mUKGANzRbBq1H0nxCc=;
 b=FJJcDytryadpU5z2TyAdUZwIniOMSiODgOKMTYTyVoh/VwZIgAg4Ur0jAg2F1ON4GLoHnZx+QBfToGJWu/GhshAKy0b0BY0TkgAIrUXdVgda88LocdrxU2N8oZfvJ37I6jj7dYZdSHG9zpnFoUP0aLjSsMiNUj9nFFiTvp/awdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 03:34:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:34:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/9] remoteproc: imx_rproc: support i.MX8QXP/QM and self recovery
Date:   Tue, 11 Jan 2022 11:33:24 +0800
Message-Id: <20220111033333.403448-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111033333.403448-1-peng.fan@oss.nxp.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dabc58f5-6ac5-4793-2b0e-08d9d4b34af9
X-MS-TrafficTypeDiagnostic: DU2PR04MB8725:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB87257AD9B85844EFD43D0600C9519@DU2PR04MB8725.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQBXmbo/+pGPmN2TES8Wupo1tcLEz3KLW6gi1thyCiKpv41Q12SXX6cSE/8YRcgtVgSlSOObn0Qs31l9U359jtxJJtzjErvIcH6YZdLemNDk9yU4CGJdM4ZyeL/UKFOUySgXfHfUO/Fu94u48TCON3HJcPfd4lX8DC0+ZD8l7ldQfYkVGS+xJOBuIzmmtzBCtowLKD9m46RG6pa7Aknt2srSISK9lQjcT5q3LLTjh+iHRp92d46P6Wf7BGM4uaufpjE99kM0WAsuhPEFEgemuCFsJxdVowm0iLnmWN9PL0fjACWth5amTsgpS6Ulbori/IEwIv/XvylUli6pS3FC6x3cdplIACG7sMtQumiYQjEnVNYUDQ58ncbokeb9WtiyT/srD7NmNJR292P+4za3ztNdqYVDYynGLcZSySaHO4st1w5vIV9mhm8dUlvHsQSWUFulaqi3R6HpeQPfMCPhPEqI+MOhHTnsa6zMaqOH2WJSPN1HdcJnFMp7huMtqz6QFl7gQ8GHkHzUH8qOtm6ivttDGz+BnvYqLs4gqS+z/GXHBCSGrarx7tMWxRcY5zkqgS7qpqzQbbofu6Z7idPwpW0an34PjpUe+kUAYzdYZh8LIxa+BxqYR5NfkB3Sfx8OZcgma4IXb64fa+2/EXA+u+SH+j6wia9dEAUbkFG6Px1tqaqXqUo7AEvg5SQ5nmkVg1fz8hboftcSjdJw92Re4iSKHGcFWHXX/2A66IZHCFW0+d3fuQaMi1srHSP+2+CiczZ6ilMEBh0Fuu6PDmOMVG8U3Xr/cvGl2YTfK3EQRBn0gkLNtnaMA9AmcJk5zPeg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6506007)(38100700002)(38350700002)(186003)(508600001)(921005)(2906002)(966005)(8936002)(26005)(8676002)(6486002)(5660300002)(6512007)(1076003)(316002)(6666004)(2616005)(66946007)(66556008)(66476007)(86362001)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LSUaA52U4wJ7rje4iaRBt+FEGKqK1MAnV3tlP+2ZUV/agpiHFbVWV0rVDQaO?=
 =?us-ascii?Q?ccj14DbdYAzp/h57U21DeHFiWqzMs+LBG/lwwm8SPpC6YI/mfYSMtAijXanp?=
 =?us-ascii?Q?vr9QtUK6vUWa0UyziTe/jn7LjSBrWqYD39tBOJ3pSOVvdAoTWqu0bHQLTrXf?=
 =?us-ascii?Q?aCGJo8lfEVpnIP4dhomceI2/MYm1QoQtE9ZzstXm+QeGZHvvd9lyG7KiGH6c?=
 =?us-ascii?Q?Lm65EUG9Zo2n6Djowd+y1gu8tfA7U9vHP8FPqeqFo/XHATmvROd6LChB/VNe?=
 =?us-ascii?Q?INgXjBL8Z9yXxS9Xdnq7pGnU76AV06nFETitTPk+vfTVWbtc0arRlVT/pExb?=
 =?us-ascii?Q?2IAcz0/7wnGxcdxUvOoqEjiInUEjjKDilqTM+9bg8y4NGIDJqsESW6GKJleY?=
 =?us-ascii?Q?xSHb7ktZRlFQmCTNn8gA53sgdzTh66s0IQr5XOhMBoQNmjOP3R5i8sI3brvO?=
 =?us-ascii?Q?LQAbjLb3Av61R10wxCjgyXQnKnqhNRoD85x8FtEK1dDFRQan4ADSOGuzUtK/?=
 =?us-ascii?Q?w14UcE6WoowBlXa6V8ZSpVNYTSvTK4peXyT3zb6/L8f3x8nv6M7OAi17/Zui?=
 =?us-ascii?Q?4zhq5wy+AfuDXMSgTg+N2uyTEvWtbjjXm6cigRzr2ft59WDQUJ8ei/wnQZnP?=
 =?us-ascii?Q?6uCBt2w1g/Xn9R0Uq2ZPcDDXlAuhaqn2z8qis9y3VBGmteTbQT27vgsiPmai?=
 =?us-ascii?Q?R9Jq9kf6SICZ1/eGAC6cf8Ki0FKaJOdf0213rpfkCKZrQBkBlRirK6sZpS3m?=
 =?us-ascii?Q?3nCez9yuX+rNqeh9sgBA1m8WogocaDcevtcWSyZTeLWjyhoAX4GcBOWY4J+F?=
 =?us-ascii?Q?eLTLmHp0wRK4E8b3Chie6PV08outRu/tmBIbB3aqp7wxlzqsjwzVgrwSn/OZ?=
 =?us-ascii?Q?JNb8o/z8AM8q4f8hbRcK3dk7CT0PhcFWkZBfCXQWpyqYapqHkojXX5r7OBRg?=
 =?us-ascii?Q?G4ntyKEuujs9oVdnho4uenfIoMHVHSsVAYVrg2aeVVUNtosiv9mw4iDn6Vgs?=
 =?us-ascii?Q?B9mZ0qT+V/cJ0Gd6TXKwGBGw4q9w5MjplpjssdywVonabPhVcFye/R04bE4y?=
 =?us-ascii?Q?ZPb45lBQapiLFk8WkTUSvlEmeFmd8xV2QsPzFZVAaumAmpD61/edZfBFk/Za?=
 =?us-ascii?Q?SyvQfBdHegI8njveaHp+epOsaMN97LJv2J117trDF8bnqFMwNx0AdyZfFedS?=
 =?us-ascii?Q?hfpavkRFjRMEZzvhZ/k8HYEl8Q0dzYGfvteOTzboEQ3aY//BqlFZMtJAyXnM?=
 =?us-ascii?Q?ztM1Rkj4Jw9NJC+ebKKs87k845YSpTuO7AMDODvEILmmh2WSC67ADIenLNdN?=
 =?us-ascii?Q?/QkxrnFzrJ244QIE3GmzbJZ+cwV8QaAQqxvQvEhBpRywoqC6mSzC9sluImnP?=
 =?us-ascii?Q?Xtduc90bt3iszJPgxZ2zXhJK13l5gyioPDVGUzvGCLLyaVtZdSqdPozFiCP6?=
 =?us-ascii?Q?IRif2iAmb3cCYXNbtoPOfpbqcc75bLiu92+M2mDnqbx2X4FTnPPVnyXhJ4bw?=
 =?us-ascii?Q?QBQnaFm82rmdTJMeyNRvUk+eEERasELUqBXSYOKmNhUsW3wyTRjyXnLPwRSZ?=
 =?us-ascii?Q?weWjjkZYOc1Ek7RMuT1SnqfDtEYyUCEuOMNk1xdW7aPpThxbEpPvZcXd5YtL?=
 =?us-ascii?Q?sRF8ZR2cZ7BZScpgZTR7Pqo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabc58f5-6ac5-4793-2b0e-08d9d4b34af9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:34:37.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XKS55ZF3+UF7raLv9qD/NfMJDw4piNabO7WV7C0mYG+K3dQDe6hU4R67j9BxWTJ3BBlsjcWOAmMiIpBMuK+2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset is to add i.MX8QM/QXP support.

i.MX8QM/QXP general purpose M4 core has self recovery capability if M4
is configured not in the same hardware partition. patch 3 is to support
self recovery case, when doing self recovery, only do detach and attach,
not using stop/start.

This patchset depends on: https://lkml.org/lkml/2022/1/10/1577

Peng Fan (9):
  dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
  dt-bindings: remoteproc: imx_rproc: support i.MX8QM
  remoteproc: support self recovery after rproc crash
  remoteproc: imx_rproc: ignore create mem entry for resource table
  remoteproc: imx_rproc: make clk optional
  remoteproc: imx_rproc: support attaching to i.MX8QXP M4
  remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
  remoteproc: imx_rproc: support i.MX8QM
  remoteproc: imx_rproc: request mbox channel later

 .../bindings/remoteproc/fsl,imx-rproc.yaml    |  14 +
 drivers/remoteproc/imx_rproc.c                | 245 +++++++++++++++++-
 drivers/remoteproc/remoteproc_core.c          |  66 +++--
 include/linux/remoteproc.h                    |   2 +
 4 files changed, 296 insertions(+), 31 deletions(-)

-- 
2.25.1

