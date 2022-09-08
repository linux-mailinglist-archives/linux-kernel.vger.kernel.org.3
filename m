Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC65B1160
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiIHAhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIHAhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:37:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45905E029
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2Jvjb6k6gAEALjDIekCT4A0CDsDVhrbmdtmYVecT412MYKrRet69P3PVYxbb0/vD61RdQpmsCBLDEjgl3zaivNj/n0MGOw+9dF5LqXJrs85m4d5vWdMtgBfelrd0wx8zkmZi/6+NmUOn/GMQwarc0dwVErE14T7TVWNv6DNGDfh/NOR6hW7faVSy3RpS1i8uZ1+jojo4WJ/7GxhKLfAisTjQR1FCYISlUXz+TlL4XdaHZ2cm2qseQzEeGpMrEB6IrNxEd/s3XeLEUnOxwhqzYRNYGGq3Om8SXsuAcMTkuuxAjM5ID67zz/fDmYK8Iw4PwhGjEv/ja82l/IjvzF5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azOV/eOqrwZcuV97C0AF6s0a67QsoB4o+Ogz1cC+5w4=;
 b=BUKbIof0Vi6MJpxAvoaQheWVfrPO1Er/SW6Iyev9t7FGihSFYOHqHrvD6k2XoIRNPyMGTtNoetvgUyOVSNsjyw+Bq5/aaciIvS7Wjvyob7kuKcOiaEwmggYEkbPdoD7JTA4e+DQdzRdr21cnrMU4l/ntG/pJUwXFVb9l/nMwYjiONvZzJLmnYhXTNutBB8uWKtOjMa1nOIILI6663iAFq8lQUD9SAF0a8iWDb01/Hi4ap3GQPIJbTAfRCT4VNhihJHj64W6OvmICRYK0AOmysGahM9+ZDRMvK465f8aOKbbCpJFv5bL3pkfev5UduQIISGljnRVkDGCtEGkJud5fEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azOV/eOqrwZcuV97C0AF6s0a67QsoB4o+Ogz1cC+5w4=;
 b=BLhR903hceLpsPwmQI3Rr9btc/ScxmK+wmgiyM8A9rYtWGdsiGcxr/hfMENV5iZf0Tj/fkkjkTj2Sqsjq8fS2Msob/fzatB/wdTlbnkqmZF3qwh0R2ctfjXjDtxUWZ4hFisgHaqbQhrWAy57GAZuzgPNeI9DU3MnLST+THRObA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5283.eurprd04.prod.outlook.com (2603:10a6:208:c3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 00:37:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 00:37:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: defconfig: select ARCH_NXP
Date:   Thu,  8 Sep 2022 08:39:14 +0800
Message-Id: <20220908003914.2062126-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f6dbe6a-2ffc-42c3-d0e1-08da91325494
X-MS-TrafficTypeDiagnostic: AM0PR04MB5283:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2bJaQWm9vPYyk2H0eaRW/kzANTOhnPa7M/m61YXW4U+H74erOP5F5Wv4ShIBsMQI/+Ugm9PMYOpC/1SIp+AykHa01e9Pc0zLkwegosiEMh2a5wUCyuQl8Pc0i3QLqobI1R0fiB412KXxpa/WXfxtKjs9oDuZa7pUwpmJFKyF+v7vUCNBl0+AbZ3j5YUc/flnFDeaqkb5VHxCKDRfpbp+gGqXJP62s99pxSS52sXsEeqk5yHNLTnFBgWlBAQzTRgspCIibhm0ACPfWYGEBZ4AxMNuES/FSCSAxqrQhvguOS54EiThXsRapCSg97USJ19bGbRgsuz59JDwotRPGfJU8YN8n/dJWcPQFFOTzCivyi21MfotwWU3sHswA4iKB9OkDH+HZWx4KoUA2tSmHu9btqRH65tgY8SA1qIFmll+2SHZabNvA7JdqR439HObXckpt3yKKOtMQRPyE7pZA1/ZxvQyj0KJ9fPlzy+Q1P3FC9X5VpBXXfhsbjUlDr4yL7IMizFpL2BCCPP9V9LM4a3cu+u+Q9OC50Oqf4vU5hCoBxlsJhaYtULLpLAHhAwEmfNNduQsHMYuMxSQcHYTrxMaSGhk3RqKRZ6knWkz0FfdOXesFoyTNaHwbreBxDmEylgZ9Fxs8DGipQuTjpoh0Pp4qGuBdbQD4QbFuGF9tOAnInPw2SGJlASOcH/hzOKE6PO8GYGmjfXow9L0mpk/rRHfQ1dk1OB+6kxB9wQxsz0nQ5s/hGeUXG+CYL2UwB8KD3pPgCDc+3my8lGbfUZYsYfgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(6666004)(1076003)(41300700001)(26005)(52116002)(186003)(6512007)(6506007)(2616005)(5660300002)(4744005)(8936002)(8676002)(4326008)(478600001)(6486002)(66476007)(2906002)(66556008)(86362001)(66946007)(316002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4UKuS+5YKzVGIovFZejPEC/S26335siebzt6qijGCgMp6tOZZScijUf1wsJO?=
 =?us-ascii?Q?RCmS+aRW0aYmTLom3wowDqscqqoeg91BWBqq/4cxMDhAsbNF7e+/ljr+vo7T?=
 =?us-ascii?Q?LIWpHHAfCLNrGLf+NLcVe2LCLKUUDZs4X1Ke89srRLa1JkHWjS2qzylH6zRI?=
 =?us-ascii?Q?u+qffwEfv0v041QrzaFtCsdm2/bAbKq8aB40LvlHqfIkBmMSFTw4ERWJhJEg?=
 =?us-ascii?Q?SvI9b5+2l9pFD8W5GBR9YsvfOUefh8i0SujQmyqqOMOTVVMAL/ycbFqqz4yA?=
 =?us-ascii?Q?Kkb4DbwrlPCpZWb+3NAgrFlqUk3Spg0nog9i1PnSYtMwZ9Zbb+FGa2mD5xtV?=
 =?us-ascii?Q?fI/VDKX5BwNC8AjLJFiOxlNNbgNeooW2dMTLnrjDtxb7F6oDcdmRxp+SXd3H?=
 =?us-ascii?Q?SyMBZZXua2/ZalOmpIhoGw9wc8bVzQDpuj7m/2TOZmq5Bd4tmbX610AwWwN+?=
 =?us-ascii?Q?jfzwGxdD5QX0+sjkbBkPXn9FHeMxmI0obuE6ghxtWPq+Bo0b98Y5HTwPisGK?=
 =?us-ascii?Q?iUB4SKErIouDoK6MuSvc1xFS4QAQXA3pOlmnCrGESSjR9WcPQqh4FNxOJeQA?=
 =?us-ascii?Q?OBCMQrXbmlpTSOfmfFujoLZtY/sHASeAzLsj3ApmFodnzSOW3JXKOjxf3Srr?=
 =?us-ascii?Q?iDkeOpJ1jlGX/nQFY9TxD9QtFoJF3atwWRlGj5KgXztNNvSOatOZujfP8lQb?=
 =?us-ascii?Q?hq5VoR05sSZMQX+if13KIIM/nuHri6ihzcnCT8VjjHnEli6IPqhkNM57fcDG?=
 =?us-ascii?Q?FChaluLHK61ETHQzC2SOz88XSI+1iSG5mna4FmWabM9FB6utiL4g7THIrr1R?=
 =?us-ascii?Q?oTx9tTGiIvQAK09mhv2SGCogwg4H1m2xRod3A/mq/p7PlMSNuXTdAcW1+5NZ?=
 =?us-ascii?Q?di56Y7lg4mukwibfVE9mZnDM1Y/cDHv8k1oQEb0d3FvOCVDkPpB95s9ytp9/?=
 =?us-ascii?Q?8vQ9heWNq6RlfguYGj0QlXYe7kvt8THiwrAqcvQfja/efpz6s+blvV1yS2fP?=
 =?us-ascii?Q?ia/30tu8qI7Si3aJsjzbVUAn/fJAyj2oWKAYbRG9+4SezDZ4SmZt6JkS0PbH?=
 =?us-ascii?Q?MYjwbw/07GXBdqzA2NPfe0gsqHLPcCzhLkQOKzwbNohlCX6Yh8texWl89EOz?=
 =?us-ascii?Q?4zqcT0Pk38HOD5qUxwmLud7o1FCXMNip/N+MlrtqLaNkeAM5DY6bxCm2zvaS?=
 =?us-ascii?Q?DUiez2DOCSqIgThrdwzY+Wa/4mdmbyfZKQHo2sHyOEwcrBr+1QSZdxhFqd9B?=
 =?us-ascii?Q?VbUeXh9XA8Cd7r/+p9bWH/DuI/mZB9AMxSoqY1acBw1lnYxCnwHQwyP6qd2m?=
 =?us-ascii?Q?3b8BS96XNq4aEIUfBj1rLO9fAipd80eNB0WrgbEQsEAxZUGtv0pkeBApn7hY?=
 =?us-ascii?Q?ed9+UPF5MajsmTSr8CNwthRcWYyer7oTlIZHH07oVkGv0thePs0yO3XQ/+35?=
 =?us-ascii?Q?/tjdF3yUVusoTTtwdgQWrn0uHHA/vVv1D/9zRYI+k3EMAmL4ZGvnHHziSRIB?=
 =?us-ascii?Q?HMn8Sy+USjKaTGvkxnylWWCYRXExUkH4KxcjyHNu3Ltk5zivLFvc3O95o2De?=
 =?us-ascii?Q?usuLVkSqPEp+zL2nyJoNAP8rev8JUO6+DaLCbbsQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6dbe6a-2ffc-42c3-d0e1-08da91325494
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 00:37:38.2916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsRLJQXOyKGrXXqrVZZhvNSLzGXlb6tQk+3YLDspL/qqZ0gvjuL606E0wv8dGW7Azc3uevrjv8QNoJs00nk6yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5283
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 566e373fe047 ("arm64: Kconfig.platforms: Group NXP platforms
together") groups NXP platforms with ARCH_NXP, which cause the default
build not support i.MX with arm64 defconfig, so default enable ARCH_NXP
to resolve the issue.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 91e58cf59c99..07b9185f5937 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -47,6 +47,7 @@ CONFIG_ARCH_KEEMBAY=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MVEBU=y
+CONFIG_ARCH_NXP=y
 CONFIG_ARCH_MXC=y
 CONFIG_ARCH_NPCM=y
 CONFIG_ARCH_QCOM=y
-- 
2.37.1

