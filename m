Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB1359276D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiHOB3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiHOB3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:29:15 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA81277C;
        Sun, 14 Aug 2022 18:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrAJusjHPeC6XQOZn38D5WQmxW9k8HTr24s4nxyAWEThLD/xAYbTFODVc1fbD8J0LvNL5R8EiSOJryoHBaLoVdan5YrVqop5gkO6v+So6dfDXeeQ/FH5HNH3NBg41i0MVrO8Vnz/lzYMbhLgwKJRCZPkxL9Nw7EleYBUsIGDkeqjH8t0kC0OneoSQvrkr2xnh8R0gcf5SAuu6BRND/YN1cEjGEzlNeR18zQAhLi3MHJxqhEbek6aN9YHN3i4dsNAPc/i+LxdpbCYQZ7wZTvv2RiWtbyYTDPEoKl3bg66PSTJ8j0qOKv51nR6DYv8HNsJgqzi3PGWnFLe+oofUNNYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQdrXYbCpt2AIq5hLIrTY8Tv7M41vNXpp82+rvN1BlU=;
 b=nWv60MG7Bda+sPL8prch8LeblathTc2DLDCGbhv/2mVCxyknxO8CxnApqqxjtU8EWH1FY14G+VL6GcDhmZmIK54h/21J68dmpX3SuvZJnzWSb9O+y8q6sKlIBAJwZ8w0ElDW4OgAYPkz+2QBfE6QQ/Lm7aOQ0I8YmDzzr/H/ug2pMYsxutCawRcf+dm5Zt8xrdpmvL2ywcYvgtHnLlxyPGf3Y9mOqctqm9WdR45U1JN9bmrXNH6Ucu7cikTZ6H5UJ7T6MyUjgYUM17/F6AjO04jSjRQwrceiMh5KKZBBZBd592sCXRVFBCabxHysqVzE71XImYYMlkz5k9PESz65Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQdrXYbCpt2AIq5hLIrTY8Tv7M41vNXpp82+rvN1BlU=;
 b=FCpKCtJSxfcY6AoiieMctZaArpHOPB/bYYLyp/qrhO8bWYzee81TcBya9zLhdFQwfuwChw2fCnvBwzU+rkuHseF6d/04AsSYfX5yc+EoKYhLDB+iaRQd4Lar0ULA+GOmw/fx0jSFcjZnvCpDykHUvzSId1QZsVIEbPiAeOu01FE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3734.eurprd04.prod.outlook.com (2603:10a6:209:1b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 01:29:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:29:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V2 1/8] dt-bindings: clock: imx93-clock: add more MU/SAI clocks
Date:   Mon, 15 Aug 2022 09:30:32 +0800
Message-Id: <20220815013039.474970-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815013039.474970-1-peng.fan@oss.nxp.com>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e0c32e2-59b4-4717-0018-08da7e5d8e39
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QShw4fafGbjpXItV3bPG7ohZdnrAkhdthKaM9eb6vFeIGVs8HkRmSm5FC3KilTIC4DNsEYbSutZRz1DbzCZGhNzRuzDNIw681bo8kkDyjl/P5HVmWlmMkhmFazJJ1V3nCIDbli8PLkTHYB7qRnafAuRLnBLv4wkQsJArn07Jh+sudVkF75arsyW4F5vfTDv8DPzRy/5s2DrdJZ4KpNfNNuF4T5iTOQLj+fZt6mNIUMonCznzPAPmL1ODGO4wE6/XESfU5abuioB+AA4lgb5yh8b0vfgF1b1uGneDoxp1k7aeCGiTmeqOfW6eTRJscBcIczYhNVewnNTkrYhPPKyC04U/BbjJyod4aAsUgb3lT7lfg7LLYRNY5ihhzRxcRrin0XNzrXWxJfZNQgLwXp/ouodSlhegQmlt9OvOoKajQHyhkoj1k6AmJEo/FwumWBQJpzzlvn89DdTRvkgxnEzY9LOUqysZ6UKnmTh8TpXotyut5NbKGGj4FOWKtEaVe0xT9NPXzIaX+hkHHwPSxouor60mOZV3As4BwV7GqzKYQhXlB3OZ8EeN4vSQrxbZwc+R2ACDPA52GbjtMT+8cqMgkSDKcac+vsD3ugtTqLT9mMw/GY5VKljVO+zEUGySomQHbIPkjm2C3p3qM8wMrM9iE4ko5d6JsYq67feKjd9KekC90yvygQ21ZI26PzSWUhxDH+XBq8mNyedgljEB0UTl/YEOmGYR2c48HSoNDz+A2tize6rZ9oJ8vYcBOiWfxk6zsGyjUaPxnp8xtJ9lftDcG5sklO64kOYww3+iWjfebMzgVs8SLRnEy5PySDU4rLGk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(38350700002)(86362001)(52116002)(186003)(2616005)(26005)(83380400001)(6506007)(6512007)(1076003)(6666004)(6486002)(54906003)(41300700001)(478600001)(316002)(8936002)(5660300002)(7416002)(8676002)(66946007)(38100700002)(66556008)(66476007)(4326008)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9VdR+3YXFWjj2rVLN7lb2suSGZUNm3lr5nmyoOJZa47uYXAjgtudYPpY7Fxf?=
 =?us-ascii?Q?1nZNazpF27+abSV1c77A6SzZiW8ldITZplBTgeAs2r1kShJajGeIKNA66dEQ?=
 =?us-ascii?Q?TNsv+qh7gwK0d13eejaa++Y7CxsVUymf0DP2oEtIn6G/xeD14Q29NesZx2xO?=
 =?us-ascii?Q?oSZ26uMDv7sggwb9iKmHk9TubRIQw4XY/VV3tpKePqCqAnSKZVPwvMx03u0f?=
 =?us-ascii?Q?N5cs0a37HB9qwn+nNI7Y3zMTWMsfT6CbICEUNsFRgliXqBJiIOIwgmQjz8Ea?=
 =?us-ascii?Q?8tvpyGj4AUIlDI/AYyxcUVowHD6ZF7fnShDmQMa8HZvgwcMWjWu6EqINMxtY?=
 =?us-ascii?Q?k2fcDk0Jd0v/xdKm4uT4U2Tdos0NvB0NkOzS8BfNJZE2bA5SkKmoachegNW+?=
 =?us-ascii?Q?26Wrf2nBUtM8M5NUImwrJthgG+no6PkMxAQpZn+2mzCXreAUtwkDNCj8mnWj?=
 =?us-ascii?Q?6HlntHVX0QM3JD3vSwvb8ScMz4ZqdIb5E6Lfw5d45DUekrVhmX3cOgEv/ycp?=
 =?us-ascii?Q?eI3BNS5rH0SXocQszjeULQLLP4vokNRFYNVWBsfn0FLVbG1xXflAU8aurL46?=
 =?us-ascii?Q?hPVWYuWJF424+3K1+twS+19HCixdY9WCNQn1iFyIvvrPPxpWFwtnY6sx3FSY?=
 =?us-ascii?Q?ztgjSzDmX1ZjTJmpTn/VfDiht3Q3kaQyL3RUFEfwZBuEcT2+/7fAxHy970rU?=
 =?us-ascii?Q?2K+TU+jryeMfA37YjFg+oW9lYnEPl/CsGr9zIUWQaulHI9gTxDPuvqGclhrp?=
 =?us-ascii?Q?wDTHZVAJXSYg3gv0m8rIFixDClvggDWQVO+wbztZEIUY8MwpXy2yrnl24VBx?=
 =?us-ascii?Q?2+xmtxCmB1zl2uA1TkvN9rax+ii+lEd6z6EvngaL33+eoaXPhSPSTYcDP1+9?=
 =?us-ascii?Q?iiWB6eu1FhH3cmgzBGyinspcncPVva7hUOB4HYJs+HMCN+ZIRoLC2hlxNiF6?=
 =?us-ascii?Q?EgB/nPgMI3ChQATL03xetsnYjcm33a8prXuU8/HNfba5kwwUNx+ndrnw6ScD?=
 =?us-ascii?Q?esTLgnc0DXKn4aRQCb5KcIJcPScDw4fFnzX0QGpFnXAXq59014SPTxp+OyT3?=
 =?us-ascii?Q?F0ZmX9dY25TTeE2dKS4HDswbv9FhE40DHsaKqWoccz56t+xR/5u04IY1M9IZ?=
 =?us-ascii?Q?ryd5KdKoU4DYz8Qc6smeAx8vgDL2Shpasp4a4To/TCFeZ7sKlhzEPwFegURR?=
 =?us-ascii?Q?dYr+5kQZK/OlfId3YRovWue37MYiT2/LoawqU64DXaYVmcdHzm38OyBScilc?=
 =?us-ascii?Q?j0MsZ+XMxTHGyjzxAIixWBhhTlsYG53kVShVNHYUUpifXn0DxFtTrTB88utK?=
 =?us-ascii?Q?z7cCvgw7BePEUU4Q/dyBXxs8Hv3BH72vx/cx1gkCYmlEfwyikGtTc+xlPJeS?=
 =?us-ascii?Q?NL6ODp+/c8z+2fc20GZgTcAwzHOnYXjvMi29UxibXaGtJ/Xs6HIWr7axJ038?=
 =?us-ascii?Q?18+Ccfzy7T1qdKANFTnBxTzL4YwKTw1sMal3ymvC1fscebRHuiLYu1g2gEO5?=
 =?us-ascii?Q?T5GMyHq0TNbmCjd7l3G0wSN9YdQ8xZ2RameU/wIfAo1b5JzpPAjUGj8dpViN?=
 =?us-ascii?Q?Y04T2y1gpR77ccN4wZdGseHNFtmRysi95AstZYg1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0c32e2-59b4-4717-0018-08da7e5d8e39
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:29:11.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7nc5K0ZIEE0k2aWbPRqtC5BAoGj95v1iJz7Br3jZZSnlJXqiikCz4sK8Q84MXtRA5JqiT+bIW+ltPgY3WzFsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3734
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add MU[1,2]_[A,B] clock entries.
Add SAI IPG clock entries.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 21fda9c5cb5e..19bc32788d81 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -196,6 +196,13 @@
 #define IMX93_CLK_TMC_GATE		187
 #define IMX93_CLK_PMRO_GATE		188
 #define IMX93_CLK_32K			189
-#define IMX93_CLK_END			190
+#define IMX93_CLK_SAI1_IPG		190
+#define IMX93_CLK_SAI2_IPG		191
+#define IMX93_CLK_SAI3_IPG		192
+#define IMX93_CLK_MU1_A_GATE		193
+#define IMX93_CLK_MU1_B_GATE		194
+#define IMX93_CLK_MU2_A_GATE		195
+#define IMX93_CLK_MU2_B_GATE		196
+#define IMX93_CLK_END			197
 
 #endif
-- 
2.37.1

