Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6907550EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiFTDTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiFTDTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:19:04 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140087.outbound.protection.outlook.com [40.107.14.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F59C0A;
        Sun, 19 Jun 2022 20:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1jhYS1zVudkitv3ibJyLgqZZ3C3Is6r7eVTXhS2D/jj0gfvdJERxMm0XW0UVmLo8ZyDVgJcjIWUCPuuwN9X9x2r8UHg+D122Iz1zpESaM7rgqJL5CJOG1qNKZgZ3v0vjUfH9tsxhQUCRxm19rCqZ3OQF4EVt3OJzn62PH7sLhmJmx3H6W8nS7tck9n/cQSapGZgnpey1KUabcyEa9YPXwzzhxjkq+2R71SruFqLkWzbBonhEO1eAcHATiJtky2E8yDgf1aygFFenRHbk6SNWkX3NeSYDh4lBOV9YQbsFP3AwzLkmqEyeAzXQ6u0aKMoxyH6BA95AeGLUJebcpYhtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L36InQtMWVjY2nGEU46FkDG/ZXrNImSef+up8tKyAI=;
 b=YcCrZvf2U1vvhzyQJ29E+aCsGQ5JFp0tSLhQSKE9yNwLB6QbFlNeiRhzJdgmNf/xPfqg0SEntHYkj5YEduKe9ibDIBSg7apa9tWKUrPGxVoHydW4y/Wu42phef8vfI3J7ujxF8O2lgdShLhvKSxFKqRwWAsLjDcaM1/8AqTBjNfOHoZ3sKIoyZC4a6nTn/He03YLhwWJEFBepKWOw6ICX/87dE/hBHi1rIAI+lZV0wymCnwcLYzBx35T4/eeap3CDsdfvqqW4+oBEWdJSZ+Kjf3f5+O4X3Ex1tqY4ln+dk8IMX6zIs/xIyZ+ED2aUePgJ4qaE3flJqwbW8VmNVJ7Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L36InQtMWVjY2nGEU46FkDG/ZXrNImSef+up8tKyAI=;
 b=fJZn8I5SaHgp2j1kfdXSNHM8px/t0h9ZZXxTufCLZk4Bjt1E4k52KbEPnkoRd3d+5u0WP5HwiTKqww2CWQ5zDgTfyrk2HFw9HgZsveycrlAsOu+hHFq2Sa6gwU9zDkezy08n4vw9rlbqB9HpjGlabi5E6OyUWdj/uDxcmrcggwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6867.eurprd04.prod.outlook.com (2603:10a6:208:182::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21; Mon, 20 Jun
 2022 03:18:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5353.016; Mon, 20 Jun 2022
 03:18:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        marex@denx.de, aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mp: correct clock of pgc_ispdwp
Date:   Mon, 20 Jun 2022 11:20:44 +0800
Message-Id: <20220620032044.4093226-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 939759c9-805d-4414-23b4-08da526b9e07
X-MS-TrafficTypeDiagnostic: AM0PR04MB6867:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6867A533560F150C9E486A8CC9B09@AM0PR04MB6867.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDCLCTPDY3GtU98I7ZC7WLks+XoK/z8rxyG9Qpvq94Qgl/j5nlPEs7FKxBUTm3qFzAwHVrpZKCNa6gCBl/lxNGzoXBpphg4Tcugb8gi6hxVrKnGKY6jylz2fg0jmFZYdDPTQDTxkNujd9uOaSvH3EkRdyvvjsEAV/kcRpXAXaAL0Bn34SxdCUPrYb2/A45YSU/mIqeENQHAGCMOlsdA6dI7CawecnG9HMCicr4d0dzaY8cB1RExDVyImGYHMiUZlZfUJbqlVC1FyX2dynBex/pdGc6C14nr8TlWW+jaorlpFZKp6Md+ROjTjQmh55GYmd43sNQxpi4Rxp87feLY8j/es147B3LSOUEZvzd+1/PhgVT7rFa3BwuE9Uu47/uZg8lVrHQn6yJJP85B2XvS71wgPnyrT2R+6/BXGpOhgwxp2MkE+t/vB5CmPvWlBMCN6HktbfmctgcNW3c0ccNlA0XDdxHg1kscc05mHuPb/ycrqspZGcM2k0wrHdnwDPFdCHPuw3RTtQ1+sMEnyfDyM8gm1cvo2ePO4lcIn348j97XW39rmEfqG9jqo03DR7aOwcFod/6mvOnu764RnezYaOEDTi0bH4yXM0uERGPzCg2lIlqghP17a11piJXftc+m/nqXkV74BNsmwJ9eX9EsuVfQGvX02YKtQyoNz3ziAjcDeVWaArd0yGITipYTjTUrGhBSTxB81+aJqkAEe3lWREmjNHmQBb3ZHyUpFKZauR+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(2616005)(52116002)(6666004)(316002)(38100700002)(86362001)(6506007)(26005)(38350700002)(2906002)(8936002)(41300700001)(5660300002)(7416002)(6512007)(66556008)(8676002)(66476007)(4326008)(478600001)(186003)(1076003)(6486002)(66946007)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QNJCTCexG+5oP6TLCcb7hIiF5Gn38HSKPIz9pUAfFnks1PwYrDWR5Eqf+FqV?=
 =?us-ascii?Q?pjFcM0DQoIKNmC9H2VZDDn9viF1U6aXgspS7bamX9PZfH3WQbQmNCt7YKiry?=
 =?us-ascii?Q?+nam9zEpROxlRGIvBjb4Xiywg2oyY0u+OPvRRbj3gT9xOPvQIv99jVY6rW2F?=
 =?us-ascii?Q?bpwrBifg70cC8SKOqQnI4atsy/FSZu18jsp7RpMqlLqjApTJVQeVKb6qMpXc?=
 =?us-ascii?Q?rbOSTuPRpC4z9xJCs7fUs129ndGJl8hwBpDhhwt3dTk6mAxv4b6SHWJ/4uFM?=
 =?us-ascii?Q?bJbZHAAcLdG+/DitG4i6TI650yKjrhXbl6WGGTcm43TIe5vmuj3+PIGOs9qc?=
 =?us-ascii?Q?PWQnMs2MJb3nxqGQelt08KbDvhvoEkrwE0vMax0Al2SLQ7qVDocJMI7d2y+h?=
 =?us-ascii?Q?HUqE9nyCMJ3V9H86h7mnc/eU+Qad8chUktFAe+ZcrBLBtP+59M+jZgW5oCym?=
 =?us-ascii?Q?i246J0vjjgHwDXWXx4WmJy4jasvym4TPESY18obHl1vhoEjkIBsHx1IM3kwa?=
 =?us-ascii?Q?zeprwEZR6NX56Vs67rF/Zkf+7RZXhIIuBNQIX7SjclHOOfsq6N/euIh+DKCY?=
 =?us-ascii?Q?a6953akkuYVRWPmPFneWelNs3goXPH3MkxKRA6J1hFEXzlL2N4+wzZg+epGv?=
 =?us-ascii?Q?T/m+cDzMEvCGIxHOI9e8RE8uiDDBGFL2RBU/3e9agW7b6T92PYQhrgtdyqJ/?=
 =?us-ascii?Q?zHbZBhQncRcdMzrW7XO8JDKwnDaRgryJ/cVuGsfFj4iM4B7JMfEtuNUEG6BN?=
 =?us-ascii?Q?4ijs93hD0MSbSijQkmmui31Ia42thj+M1EHpk6m308/8rnPV6rb+xcAcEqQp?=
 =?us-ascii?Q?b2hvmEKJ2IhrWm9u5KK9uR87cV/K0fP8fSUaxvhWe4OsC+UOLeuWbT2ZRtyj?=
 =?us-ascii?Q?dinEvun8fCClgq9/XiuKSDWshWFgn5vcyXJ/Jm9Kw4JzoMUligq2QMPgch+H?=
 =?us-ascii?Q?Lmmk0OtILLN40/9KPUqY19D8dTd655/0p03C9CsquNFh4eQ909pIA/AzpA3h?=
 =?us-ascii?Q?6EhybT1MevkvL+BaExWw5d71uYiiGOcuUuX/7lv6qVzSd5OvTWGuSm31vqLh?=
 =?us-ascii?Q?bVOUP0t09AKYrr4fncsO6g9dBkcYFRXVEYIRK5gO8Jgc37PM2/UsmaqJC4rC?=
 =?us-ascii?Q?7aYWQhpYTY7NQyHr1k98wJiADz0dodQ7iYK7d5yJoJ736f1XMxyQLh9Q+I8P?=
 =?us-ascii?Q?GGb2OBNkFdKR1uF1ICMic66GIbVXicjrM730RJDiqkpRjg9g2nGRr4qyXp8O?=
 =?us-ascii?Q?jmOXh84NKavP4DrHCB0BtkKy9GTRyFpeaxVF13OrNBKnSuD9C61Gzk1o7/Wd?=
 =?us-ascii?Q?ujscQ5NKaqzbp8/e5VBUpRz6CoiBr5j0k/229jUZWMawCiFBmv3ZC0FKDve6?=
 =?us-ascii?Q?coKgic92qSCjK0V8YCRfSc/MBpD//lKAOx9bwgF0VIo6yKfCudOK2ttw1hNY?=
 =?us-ascii?Q?kqpJqfGIUTCitoZ9EbEkcIy4Vs99PcU0bZ8jWs6pTACf21lIsplZElv/ScI7?=
 =?us-ascii?Q?Czj3qD8qGq7EtnGlrFhs44V+5ZywEParG4T6jCDDSEzh4T4N+xEL2TFD4/Ej?=
 =?us-ascii?Q?emr5ei/qO+DBWbfEKTkohtgcWJM1gRBM0EaMKSw+WijyrLEwgC8AaXQ8DeCk?=
 =?us-ascii?Q?KEKuKdJiDi8SmJ30TqxNMhEHOrGG/L/Ez87Mi7PRnkzsSHZB4Ddsg9SjvDG8?=
 =?us-ascii?Q?2nAM8Tef78xRR/zFp0Z4llNLZJ7TzYY92A/5QBIrraVwZfJStvJcsiQ9N0F0?=
 =?us-ascii?Q?itxgtTlMFA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939759c9-805d-4414-23b4-08da526b9e07
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 03:18:59.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gC7rnlSRWHtc9Ad5DruNKTBR7767ubflZcYr6SeQJHLuXhftCyVMOP4sBr50VkCWMutq3Zaj6ebVrUGrci9OFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6867
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The deprecated DIV clk is previously part of the ISP composite clk, but
there is still one child clk(IMX8MP_CLK_MEDIA_ISP_ROOT) sourcing from
IMX8MP_CLK_MEDIA_ISP( previously IMX8MP_CLK_MEDIA_ISP_DIV)

So IMX8MP_CLK_MEDIA_ISP_ROOT should be used, not IMX8MP_CLK_MEDIA_ISP_DIV.

Fixes: 9d89189d5227 ("arm64: dts: imx8mp: Add MEDIAMIX power domains")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index b2f4a5f1f73c..2f970d458f80 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -595,7 +595,7 @@ pgc_hsiomix: power-domains@17 {
 					pgc_ispdwp: power-domain@18 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
-						clocks = <&clk IMX8MP_CLK_MEDIA_ISP_DIV>;
+						clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>;
 					};
 				};
 			};
-- 
2.25.1

