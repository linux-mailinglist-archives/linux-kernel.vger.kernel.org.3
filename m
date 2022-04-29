Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCE1513FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 02:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353349AbiD2Azc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 20:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbiD2Az3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:55:29 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10084.outbound.protection.outlook.com [40.107.1.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB98BBB928;
        Thu, 28 Apr 2022 17:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLmBQKgn7qVIrip+3WZHh3ekPXUf2YJbZVPxBwcWF3146O3/xVkRSx5ZJY+fqw5rUBK3Yknck5N+Ngh0yWd2Q3hgXKQDg6zjGvO4g4jvqmHKVKv4aK3UXw9jSxZ8fXMDWFN12CUGiwBFn6CALhVvAKuNKpOPmkloCVA/xFxryu+J/RwgsV5z/5uLgBXvPHQcVzGIgBG+aDgPhQUOMl6Jd95INhpLYdlj65HkydEdXsUPdz6Xpgb9u4+TdFLH5yUqt/Ijy8Rs2LRNUWNFFWb2wKb7O0mQVoe1vqRT+gxXGSjho+ghIZvbHDy/eJULcgRYkz3ctwwp0ZhMfH0hIXwG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoDdzcGg2LBSHO5DoIeVww3gVqxZIYrtydNICycIwM0=;
 b=oSIN0f5TQgbRqV9uQ4Oc6Wedv5iC7z1/Y5TxLdY6XCoZ02GvHyYgHoJz5QRPisN4hEKF0yBPP2XwkPx1ocFQTYYxppBcH/58C4XVvRh2IftTFskmiltzFNfGT4EAqxlgfsHE5BeeFgnJT/hiRPgqIBFM/bWqQcfBO79dgbfmWr0a0aZUoXYV+34ZaidN2iiM+dli9sXMSPBiJBKRWMyZEXaFxLP39WX/wn+9z3ZqRUdgTOmeWClZyx4NyjObo2i+Wea0+L/8dkGlBU6MnM4Fnf0B06Kl3DXQ9n3IB0uuQYxunWCHpmK1TelxMPXbFIWwPJ6KZ8L72J04pLst4bCLvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoDdzcGg2LBSHO5DoIeVww3gVqxZIYrtydNICycIwM0=;
 b=COTvCkET8S7Kk9v3449QZS4BBYtf/tRKGC8ofmqtfs1biR76vV/KYA9lIX5PBdIRokQBZ65GW3SBMCf+uLwfqcJlR+wok1azV89IgoTRQAX/8ocT4NFh+8q9sz1hDxGmFVwwqGbQ9T5gls4UN//p3oeMZqML+KRwDXkkIHXXOho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6619.eurprd04.prod.outlook.com (2603:10a6:10:108::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Fri, 29 Apr
 2022 00:52:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%5]) with mapi id 15.20.5206.014; Fri, 29 Apr 2022
 00:52:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/2] remoteproc: add i.MX93 support
Date:   Fri, 29 Apr 2022 08:53:44 +0800
Message-Id: <20220429005346.2108279-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb215e97-2171-44dc-c2c4-08da297a7caa
X-MS-TrafficTypeDiagnostic: DB8PR04MB6619:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB661932BA21CA84AA75E1C7D2C9FC9@DB8PR04MB6619.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /WHVkmIhmTGwz72/DUU6aLKZqR+6Lygv0i2wcknPCWVcv47KBPBpYAsaof9IqR5X/VwmfmUWYNALegtD2EhfK1Du4OBzVj4G1fYjb5dELgcYepWvZ5tYkTDBPSVNyzyIBZICv0AM6WG7MBHQiIfb2IHuy0gvwS0wLldVoKzKCuQSfTT8s0WAYy5meOTV+scz/xXG0HetgR+Owdlbs1OxYGK/wwDwvieB10zb7GntImieSpV2GNfGeoMqQa0lVs5/1fXi85s5KkTBWoVPVG+gfVk2xBAb+KPeLDLRWM/5HAHOEnQZ1+8sX4yL6nXnlO8n0RQO0gZjDR15fGL8i3g4vYMofPBlN2BKrqy73gYKxkUKfTWXFTndBXqYZyMzzD8KmVLdk00ngByXosoBz9C+Ae9aoVmFNJoONuqDfWQEF+KtfKYZEksjY6YMW/KHqAQ+33ahsFG4cSfGYWSpwW0t6a/1hn+xlF52ZmtPU8OyAckgPs8EwHXuJVd+PheXkiFG9Bb9eOkdwAZucfVmSpFy13IrzArE2f778841oJrbTzy9uWVzL7NcgoDVaFPdz6jzs0Eid4ert6Y4t5A4c+Y6sZoTjhXEIlDkjGbUhrXfu6WXuDs2hT47G8F5avfo2tmHWWsHEbzQkR5INeSohTYi3ogQwMJzQjkivW1R2dMHNdt73b51GPsrqbVJgJZ6nMXq8PcXjJqCFNz/8yggyJmx/Qtrtye367xr5QjaaElWplc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(1076003)(4744005)(6512007)(2616005)(5660300002)(86362001)(316002)(6486002)(7416002)(508600001)(38100700002)(38350700002)(8936002)(4326008)(6506007)(52116002)(6666004)(186003)(66946007)(66556008)(66476007)(83380400001)(8676002)(2906002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t2tuLST27jwt/iJK3IpjvSF+PEjmCneD4mjYBNveq5X5NDZk0seXwfwJTaed?=
 =?us-ascii?Q?D0RH1zybu7A6kqs+9Ozhv0B2nI/Dgq/FPRjDQ7vtyhw/4ZYPQL079YR6cYVM?=
 =?us-ascii?Q?tpr5qqyTCQnCjwTmWY9mNtMW3H19Pk/7ELWc2zHIfdnD5UqRfSsus9+A/GuQ?=
 =?us-ascii?Q?eNoi7+LF4scEOr0yVRhlcAndBtaReDlFs1HC4CBGZ/9FM60pvF8xO/PXLnJg?=
 =?us-ascii?Q?txNtdOAG9fxarbuvHB11ELlgPTOJk2FTYrkcrx3dyHEzzUZxKVTtvgEAOIW6?=
 =?us-ascii?Q?CiLp28Ji4dFWEXanM/EFd9FUlWYYIexVHVy/wmt8sbAczZbhxh7JvRkjXhtY?=
 =?us-ascii?Q?e6if/gN4XZwKenAPj6UeSJ9ay+ypoXBqVd5nOV3dmW3RubtryEZWI9knX7Et?=
 =?us-ascii?Q?5vW59XlBq5Wya2Um/2MUOVQZgxBZe4ofOjRJ7tq+VzusktJu96coQUUa9mbi?=
 =?us-ascii?Q?IZBGHQZkA4bGMe8ckoICHwqy6VTuHk1fgQWSV+yVl/aKDJVJRE3y82GTGuqK?=
 =?us-ascii?Q?if2E5v0meXMnXxP7euIvdnp34Mp6uHuQaps3hWCjOIazZmQk0ZDBD0yGs7/8?=
 =?us-ascii?Q?ydxBgPH0T9VPMz+RKhEBvITBvhOycAlEkfeiGbEd6HhmT7D4bAFbByjkuFgm?=
 =?us-ascii?Q?uvZ0OKMe7YC5yzwuWo4SmAGTn5tgIHX8fvmhzrsD6cSojaiFJDwXLHgU2UWY?=
 =?us-ascii?Q?5irr7DZVB18qVkZWqY1Cv65pXec3thnAUrG53kMRaL7zPI3ABv71+DB6L6Kz?=
 =?us-ascii?Q?F71BQ+KrpxsbvyieQ3bDfx2M5rZYN5EdstK2X6q83mBMYi4bvIfb4y6GNEu7?=
 =?us-ascii?Q?vus0wNg/PgMtLwzVsgDnH/2ydDE72kYjhhTPUNEY1KCuuCYEpnBMRqOJX6Ss?=
 =?us-ascii?Q?mg6y4sqgCJdGsQ2hHgaL/uDcRZMr9FUOTNttgs6W2F1IoecfGaUxGBzRZpbu?=
 =?us-ascii?Q?zb17BiWvYjyRVdUxHzEelE1jl3+YXCz0xXUQIIaTkN9WNdSXgyQ+MtgX089k?=
 =?us-ascii?Q?Wg47VL9L6c9z6sUqaf/ONuqsOxoe2oj8Fy/NGwC8e2JMeQYTZjvCTYSly8Qn?=
 =?us-ascii?Q?OfYT+r1gAks2reZxuXWtTgC6o5p18CQrKGlJOGVx2AJ3IjGm5lzByHiBax95?=
 =?us-ascii?Q?ffFcbSpxv0zclb16X6J7f9/ZnbTPWNimABkLJFFTtfGJOZh/5QHoWQ9VUDcK?=
 =?us-ascii?Q?pbI+ZBkiQqjdV9DGmhy4Mjsn9JHPuzMUBF+clvTwItZ2hdFfz64sdWCcYemK?=
 =?us-ascii?Q?t6DDUas/RyEh+DHpz46098xWqTPIVDGxI70d1JaM3VgkbK/JY+RWU4R7QwBI?=
 =?us-ascii?Q?WRFCtgDcfe7rCHsTzeCGgNxm/+/Loynaujia4zHiblcuZRt9aU7xFbwKVCQU?=
 =?us-ascii?Q?JYEyNBCvBjE0jEeS6sSpWWCxfOKndxa2K32G/3OJ/8PFAlGBZk9tpfVdz3QJ?=
 =?us-ascii?Q?/AV9R8EUyauS09t9Uc716eL96bF896FuRucQCesx1c3LxOv/Bx9AwPj6ac78?=
 =?us-ascii?Q?bFmgxCB2fBqU3ImIVe0/FukuXhk2UjLTsz9a+a9GcfDMKxMyYoEH8Yl+2JgZ?=
 =?us-ascii?Q?2SVtLljXMcnTMpmFxtgnD6ePbf3HqqyHyweA+TKHrhBcVPODuh1qd5tB0u55?=
 =?us-ascii?Q?hS2lC3R+fXjV6lH2Z6h7PUMnftnrKV4PQnkU3fTkL/Jh5CbcP6U7kxWR/oj8?=
 =?us-ascii?Q?onqinGbbzFD2FGT5XZkjlNJwHSb53iY8WgsWbGe7uTF1YWXNzwiIRzP2b+92?=
 =?us-ascii?Q?V8Swu8F3fQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb215e97-2171-44dc-c2c4-08da297a7caa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 00:52:08.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dg7NvSHNIqaSAS/T33lc/XGZ+PlZ6bt0crMLZmXtPVckOwgAinx5kQpToXYHKcT+FjmQafzNl/KlsVcb24apRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6619
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 CC dt maintainers
 Reorder compatible strings in alphabetical order in patch 1

i.MX93 features a general purpose M33 core, support in with this patchset.

Peng Fan (2):
  dt-bindings: remoteproc: imx_rproc: support i.MX93
  remoteproc: imx_rproc: support i.MX93

 .../bindings/remoteproc/fsl,imx-rproc.yaml    |  9 ++---
 drivers/remoteproc/imx_rproc.c                | 33 +++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.25.1

