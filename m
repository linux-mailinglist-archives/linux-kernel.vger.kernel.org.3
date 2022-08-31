Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2402D5A8013
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiHaOYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiHaOYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:24:30 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47933B69D5;
        Wed, 31 Aug 2022 07:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3DmteIJV3AKXk3vy/ioeHhvMqKew3vUZJz4tzsWt6/Zfk9FFIMu1rxPU0vcEgK2E9kZ+86ngWvJ4BH9iUF4WIgm09vuX/dRZJwzcpvRyhpof9swCWmxr/lkrg7zvHTOtH2nCw7dswfiHmyb+orbLTQb9ieG5vqF39I4KNkMehf4lezK96SZ2OFbJD8nEvHIUhnsMeM12o0Dw6N6SMm6rWVE1ES/GxU+as5g9MBP8gImmD7mFeOY6hiE9w6Z22MdcmHKf2FbB700Jpmd9fxtsJ9G6x/js9VosQxxq0nfGJNQsFteW8xhNkD7pT1m4N5taJPVy58k0wICbtX1C31hxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh4cu+ewd+aVMhvDICL1Sz0c69YEAgEF8iwcoJq2wag=;
 b=HyES6s5fhnVCnkY7cmtca7xi5xyBB4XKTF44QHR4ru8M7CJCUsxMGQ3Rny8HC7dZf+aD28c0aOldY6v4H0QGCytsea9R8k2hRcPvetDBfdue/e8V7hxajmMEFI5bQoKL68IKh9+l5qdajOGnp8qzIQ3wftsZBoDZjq0L5TfuF0hMs0hDl16Pb3Iixan83D/erpIz8+dQ9a0kPLRa3oVHZZoCYvfX3QDUU0Kv6BwGIn40B4SrH/Le/0siSZRXOHCqZf84rZDCHd8BKBF/xb4fLfF8G8n5axC9QPPmAxGTvG5Nd6PbQPVs6RPxQBs1MQOxrk2BL0LcFh7JjnuaDXlUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh4cu+ewd+aVMhvDICL1Sz0c69YEAgEF8iwcoJq2wag=;
 b=PGuzN1QOvEpWHhyfqClJP6C3F+YkxV9pFTxS06bWzfasT19l7UY0/61vdxvZNwkSWJivAkqtXpthgcdPA9sV0x+ZxVwknIytDpBjB7I5d8gffvDbOz7eDBBZLQN2viqdPt1RUs5Da3eo3SVl0rO/vfXvRy0+oG4tsb6Wkh9cqyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7083.eurprd04.prod.outlook.com (2603:10a6:10:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Wed, 31 Aug
 2022 14:24:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:24:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/6] arm64: dts: imx8ulp: drop undocumented property in cgc
Date:   Wed, 31 Aug 2022 22:25:47 +0800
Message-Id: <20220831142552.43393-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831142552.43393-1-peng.fan@oss.nxp.com>
References: <20220831142552.43393-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a16eab13-6019-48a3-0340-08da8b5c7eac
X-MS-TrafficTypeDiagnostic: DB8PR04MB7083:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqIEmRO1vWBU88xx67ATdTro/E45YhXtYy0l+OX0IH9SmgAmmwuWJkFjfA1ucPa5M2vxIeewc7AGFf1qPUclySOMZSEOQLMRFyA6WQEuTaEnn6fNI9ahvt7/QxMxmm62sFqwCBwvkpbQDvSOGxjUfoln7rEln1B5kww0lQgyGHAEkQZYNribrKz0fBTZuEn1eNcBqqeMd6KN6fSS4rhc81yzNb8Gz1JHA+/XA3vXbZ07mYDUse18mQRwXJ5f8iL7dKxwr/EuzkiJICzYDqOwliCofUMBzem/COyU6OrRD1rAmPwOawR4h4TwhSNsMj84ca+szWlR9Nc6Ojbe2Do9wbPUVaXJDR4TmmMkj3i5AfV6WsedpwsnMUvhYP8+eZe2sdqyUV4qr1LK7PrqNkDK1uEpqTgdOS+BFRsrfMX1F+/4Cdmvt0JydrQaiQIMWlm5wk0fVIaQuPImkz+ezP6hiINm2IpzXdsI1x1X+Nge6p96U+0FP/BTR2uLQmVsDwbCIJO1s0iKqm7YgCiqO5Ub7J03TqdxbmVDqf5C32/IdvBeytG9uq1A21+R+fnvuGOxH3rgYQuA4GiK0n2DtVjEl6vZFLNBkJPjQvrT5mhqJqsgz8U8xIN32BTDZDr1KhRKsGwyW2x8803fox1tEI/IRmixev1t3D7UU1/IP++hWn7SCz9jUhi6RaB+jzaoax5rN9WbYS7aFMKqiJVGhR12CU823f3fMDmkuOsdDVNYXBoA+lvcL5jL75dX72fMUbJKoZNklVrkonmvJRtgD+k7nSFca5wzNiOva5cOKyKqusY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(86362001)(5660300002)(2906002)(66946007)(66556008)(66476007)(38100700002)(38350700002)(8936002)(316002)(8676002)(4326008)(83380400001)(26005)(52116002)(1076003)(6512007)(2616005)(6666004)(6486002)(186003)(478600001)(41300700001)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NnUhaIR7kSpNv5ytzhlI33Ly8WTztIs6g8eKFUJ7m0xYb3L5xNp1/soO6P7H?=
 =?us-ascii?Q?fT/wBLC9vvGRD+7xtrvCAbJeQiv4iAqxZQTqGk4pO45G+b5yl8uWlnQVirCi?=
 =?us-ascii?Q?BXdMEVUa+5arxcnwjgZDloCrYqo+6oN6fmUUHYkF7a5OaGYJnw5DtSgkfpS7?=
 =?us-ascii?Q?8uSq4f1Tzk0W3nuaNeBl4k8ucOM3Dv8PQVmoYhwYJoKPqlFFJOUUYcO0LVhk?=
 =?us-ascii?Q?bPTaa4rmTyHSbwcDfNqFY5YIY6UVF5hL0Hna7XI4E3iDG3Ioy4GwW1mr54J+?=
 =?us-ascii?Q?wzSmabjYdWrPDVrfFYxNCYqC73chNkKKCEJm+ze0j+oHvMAII3pPzCF5AfLy?=
 =?us-ascii?Q?c+5PtqdlwUwyXeXfW8Wz3DbGN+Ja+o2pCr7XUoAFsB66pDmKGq9Aq8R3J54d?=
 =?us-ascii?Q?qMjIbt3nIlo4i9CrGv4VzGVOHPljdjuo7qGtM75GMqfu71dZ37ckrlZfd6K7?=
 =?us-ascii?Q?xXRLBblnePGJZbUzKl/RHRX/84nyB6BwfZ2DSIEaAdWuBMiPpwUP9ECqAwvi?=
 =?us-ascii?Q?Od8eY8DHwsOXno3b1FeHUTHCEJ0ucYhI2xDle/EKUYxKW0urhX95rzfKZpoj?=
 =?us-ascii?Q?fUg31Zf0hccr4uXNjA5w9YyuARzLvdmNY+KSQYUPA+xc0mcholE5QHHcxTXD?=
 =?us-ascii?Q?nGjy2Mgw7MFY0ixC9Ye7r86/Mh/d1DK1ivKA8Xkx6MTwS9MucbZnmwjzqJSD?=
 =?us-ascii?Q?FtBSt748pdGoHmKm/yYXr7CRTAvNhDkJLlt5qT0UBkyepgi8t+b2Y7PxXQYd?=
 =?us-ascii?Q?8k9tkTS67jngPPuLz3Nx0H5aFop1BtrxKRU0Bgr2W4rolOEL1h2Zi3Ot/LxW?=
 =?us-ascii?Q?zFQmaso1EaNKOeZBLVHt6gy7KTI1aUlgxtjeczbaKNxPYAcn+DnP/bKT+qc/?=
 =?us-ascii?Q?r28XaIE3vi3bMhbsJJS0NZOvycfU0u1JfXJp/JiQNkNNbkbNVxi3+QELEpoX?=
 =?us-ascii?Q?c+Yunyhi5LcXmwF5cYMKkiTUTsdkoxPW1IoEoqlOJnu1Gafwd9LcBKH96jlq?=
 =?us-ascii?Q?v5z/KjWYEL/4zBnsDWz5vgSxnqVqNlSXG38kzgeSz2ZsGqL1x1GdoBqxlXbN?=
 =?us-ascii?Q?x8TSAvNdewwR1PIaGL495fbhuEk3kojHB3LwX0pO+J5HVtFyZgCvqNZSb3VC?=
 =?us-ascii?Q?2GmBE2VRYXxobIeuHathCV+/nI3cJw58bX2dJN+mV2dri+NssvQoDE12KvRM?=
 =?us-ascii?Q?c4Wn8iE7Yf2AdbZLWFpi6Qf0HPvSRCqkB7NMCQvROKWuEBWgCn9WQ8zpLFqU?=
 =?us-ascii?Q?d4C1NC1imBVUk5FXc7bvfD7QIBIFp7nWsNM6m1iti9R/irIXF0JPaWHgnUaB?=
 =?us-ascii?Q?9kasKLBzqy4DsR/R7OzHH/ru/n0BEr6ZacsVw/C12eSlAo4O+uwzkvQZN1HM?=
 =?us-ascii?Q?39AiAeOr1soTx8fETekco1wXi+HEXqQ4mLTpLqv7cFVs18MtOnnva8RsMN/Q?=
 =?us-ascii?Q?xWcxspYYy5brvApUxswU+LSzjKlNCLNxRMBY+gpzV5hkD030o6yO+gOwpj1V?=
 =?us-ascii?Q?GKnOAImuiEatvX0qs90Vr5uCE+ym5C9ncpXKatiAASAKhxe1t7bHY0ZGd9cQ?=
 =?us-ascii?Q?Gd31tzo1zssxxpViOQ1ghw0BE3qriNzeE57XhZn3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16eab13-6019-48a3-0340-08da8b5c7eac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:24:20.8237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjCKrjYZ/Dpz6IZ3rzCf97P+xlsGIadcjILkJmygErO4xz7JB3IT1gKFPk0WsWUeNkfz6nGjB/XJelHuWxzQsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7083
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The clocks and clocks-names are not documented in binding doc,
and the clk-imx8ulp driver not use the undocumented property,
so drop them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 3e8a1e4f0fc2..8460a3cba107 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -164,8 +164,6 @@ wdog3: watchdog@292a0000 {
 			cgc1: clock-controller@292c0000 {
 				compatible = "fsl,imx8ulp-cgc1";
 				reg = <0x292c0000 0x10000>;
-				clocks = <&rosc>, <&sosc>, <&frosc>, <&lposc>;
-				clock-names = "rosc", "sosc", "frosc", "lposc";
 				#clock-cells = <1>;
 			};
 
@@ -416,8 +414,6 @@ per_bridge5: bus@2d800000 {
 			cgc2: clock-controller@2da60000 {
 				compatible = "fsl,imx8ulp-cgc2";
 				reg = <0x2da60000 0x10000>;
-				clocks = <&sosc>, <&frosc>;
-				clock-names = "sosc", "frosc";
 				#clock-cells = <1>;
 			};
 
-- 
2.37.1

