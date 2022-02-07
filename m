Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB034AB339
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiBGBxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiBGBxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:53:39 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC131C043182;
        Sun,  6 Feb 2022 17:53:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+oG/Vdfnkxqf5WGZzAOp9K0I1bmzzGG59SLwMqSLztF9HbfayikaiSd8Y5RYIMT1Lunu5oidmCdzy7Brw9ZTQH+rGDlriPgTCzbiLHK3nYQaDk1troLyZkvh37AL4miGcSbQ8ujrxYTq8ZIBzpTRyKtqNBXRzPju0I5V8GOMYJ3SbTwTmiFP9kuBg3GM4VFiumdnE4gPEg33lJ9xEyL3kiZh2Sm9f/dFo74q4+fl+UrUbplIiT9xs65qJA+jG12fWv8UqPMF1kAAHgO+NPJWx798ZaNiqKJV/ukGABJ33QGa9/EWpL2ec/MCNOLuV9ZA93rAyMFg2SuXweTLx63Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySsx/LE/Po/G0LAozXRSIO6OhXxlmPuyVa+YCSo95BM=;
 b=C12Vl5/yKQ8E8ikf89TbnBamvJMNnJF4kQuHYqriDPecpeECkyXpyaZ7dJ4m83LL3JghW9N7QID0QAIbqxohuf9OATmbDsX2Sd//Uij+7ucLE3u1vAII9esqeGFXKDVRkzihMOIQ7/hmAnnjqntH75JYf1ELZFnTK8UqHDbQJr0ttJ7aYQAjHR/TW8gZC3vEWmCWr6Z/oYIuiWICQqoe3IsgMjG9oEzgNpXR8/P94Z93whaW8ojINoR+yqJW6lmK7RWIJ9i8+zBiUUFrUZA2ypKe0A84hG4hxv62pxPByDADM5ZpBqMX+w4+5forDKzwbvxPx0NF5RgUZkbMo4Jojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySsx/LE/Po/G0LAozXRSIO6OhXxlmPuyVa+YCSo95BM=;
 b=dItjrIma8QHTSIrTDI/gjkVrlo3JYjStFDetzJuzKj7H7X5Yoyl8X354pITy0CVoUOu7+kL6+87uh3MDHd3qZY4FIby1HJCqTWgvQzKmpJmWJc4ulDnChSr+O7RcyYMw5IsmvW7aLaAHq1BDxCA2jVWHINGWzUB5DdIfXxSRuok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2493.eurprd04.prod.outlook.com (2603:10a6:800:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 01:53:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 01:53:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robin Gong <yibin.gong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/6] mailbox: imx: fix crash in resume on i.mx8ulp
Date:   Mon,  7 Feb 2022 09:52:07 +0800
Message-Id: <20220207015211.394297-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207015211.394297-1-peng.fan@oss.nxp.com>
References: <20220207015211.394297-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7081f05-9e73-415f-dafe-08d9e9dca6ce
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2493:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2493190E81A17CF2CB7EEE4DC92C9@VI1PR0401MB2493.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: op2Y9NJLPuXosFU+wDqfBOZ2iZDHJOOh9T53slQ0OjM4/w0wVuwmjDfzMeu2ucv7q2+6sH80eDCRXkP1eXM9nFL2pOIGWyM6tOJcKJ844q+WB+ubHkfl/O3rPFyLCDIQJ62C8Hq5Ywsu3mBPBWa9jB3REqdZSoevOXPCQH9PrDIkmxqu+/CH4s56p6D8LWdEAxNSweh3yTE8FqLHhGauHcqcOvfsP3X3AF/zgtIj3XWKjHnvT9j/pr2hzksNN0GGR5t6VohJ43DquaoEOsRbzIy4Jw6Ird8fWiNsjkKK6PStlX9hTNuaxXYm/3msd3yN1lG4N1IhGpEmLY65/GiQDbeLGBGjBNwi7Kjo9RVoY2WRSbWOYFXy+w/Fbqabsd2aFfIidFoCrjklGV8/pxlfZFLTeuoFXk5R71FbLsbxMSoPiJR68XBg1YG9WZMprYbfsHzi+NKeQp2/63VsOfSQp/EqQFgC7IXueIudUJsaRNAR4pP1lyNlZWR2hCT36CTh5tmXCIdt2X81dZ4DQyOqq7d1OTYv/HmaUGpL1BAvTIF/T3qgbkyF1X++SCOaB/J6i/h4+vlNRWRW5df06w4DRAIGHGNIhaSK9wPKqYTB2rTG1B0isGne+o1CpY2punuvA28LBVVpjERM2MWN/RhCsInwZFz3uSXL44wdn8+saQ7YCV8JyENhsEuNZaciyO2A30LicdotkfzHzeoi1+CYPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(52116002)(1076003)(6512007)(6506007)(6666004)(8676002)(8936002)(66946007)(508600001)(2616005)(66556008)(66476007)(26005)(186003)(38350700002)(54906003)(38100700002)(2906002)(316002)(6486002)(5660300002)(15650500001)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Y3y9miZhrfoCMON+EGkwgNbpRzt9vLKQbQe0XtGUgTccniilZvuVsSzyTsN?=
 =?us-ascii?Q?TdEQn/GM/GukrK9RfR6rdBtUBVx//9yahVeQYg057YnJ3c4iP4YRcB5j9OD8?=
 =?us-ascii?Q?BaxzgSEiamfR/Ch0k7QXgM6pyp8J6K4xUVmuy6kEtC4eHsGRV0mOqoatGSMy?=
 =?us-ascii?Q?yL5XnIK1EuxktFj0XEmhdWpqWSQG914yOtzl4la2G39B5p/0x6PhX32C/dSX?=
 =?us-ascii?Q?vOsa8DEaxO55DvmPuEJzmhuZsjsqjuIdQc4kiSdCGxIQ7ogxruj/5QkKc/XG?=
 =?us-ascii?Q?FWWDbyYayPMXW8O21/yruUTg3y6gNqIT2/VYSTis50XC6MZ+dYqQD8WADe5i?=
 =?us-ascii?Q?+OrfrRFb0bL3pnENU/tbiE1A0XxGGbBynHIaSwenLQGWVpRRREJH8v9Dh+0W?=
 =?us-ascii?Q?daicqGgnHWno1mVa66/HczJFVFkUUN/BcFvqgOsnmd5MHqVA7wcWkpy26r0D?=
 =?us-ascii?Q?EDzRiHGpW3L+YQWQcCBPdEoOtMgoUZ3FJ0eu/u9/JtkXIrZdu5NAmUKHGcb0?=
 =?us-ascii?Q?sFjeYimol6ZYkroNJVnad65xPwMwPUnSTDskd9OEbjRyZ1vhA+OyWYSp+0Ei?=
 =?us-ascii?Q?Ui7voBHdQRTYXQaetefW4Z5jIlG2SN9mheKBJujH9TFzHK9/d7iTfjeHPcw8?=
 =?us-ascii?Q?NcHuMn4QKBVhHWSWsxUcWxQwdRIfF6mqfGLi5qmNR1qJ9avxhidApr4OGJOE?=
 =?us-ascii?Q?ZLAn+XQJeeNTftkQJzaJQ03HRrDUZntrUFCCwDA/ukDI0MMdr0tbZUAaitRf?=
 =?us-ascii?Q?R5GimfbeZ2UIDqs5s0YCFT0QVnKc+JJkbuYBRS2DoFJ22KePXjlhCZCJyaC+?=
 =?us-ascii?Q?OllaqrIAzf+oO8bAqdNEN6niXNImdzhCewOmgJP9VnTu9Oyd0ZoXB4JdjKKL?=
 =?us-ascii?Q?y6wNWtrNorFC/XYrR+PD2hE8FBVNEjIUrPnObwSDeWIf755Yh9d3yfWZ3Afy?=
 =?us-ascii?Q?LOoXaFM7pmgAsNbd9HBP3zwhRPk0VRHTE5t9fDrWgUIGh049vE5pp3nJgLmL?=
 =?us-ascii?Q?2fmehIo5DyuoCtoIY2BJIVlA7vJ6BysGHZpQOTbxZEzkzM02Ods2F8jGW8wp?=
 =?us-ascii?Q?FAvSt7tcfKuQEuW1+gsmwRo5FlBesZz+k443faQsUP8Dpuh1tRf5hBQQtaKz?=
 =?us-ascii?Q?tm/a32PiW/cUV9sNjmQE11sWPXFtUgK1qHxgiHZnCbitS3PiZchKyjxV2AyT?=
 =?us-ascii?Q?GdUfSYiRxSjpSkfeyoX1J4SaNFwq1WRAFKABU2nX5SskDkHAaC1jOXo5IHdo?=
 =?us-ascii?Q?ebGaho+S8h2KzHOiDtfLss6O9ITMWmQN4C5ZaCTzpGQ8GZXhfhkcG5CP0ZzY?=
 =?us-ascii?Q?uJh9YqUl2YPrq7C8M2zyrDynWvYgj/bfJGePpeR19YrLuv28KW8VGNMWk015?=
 =?us-ascii?Q?jShVzxb6e5bNv2RAvmzC1GG/h3M5iTEPqDkLiDDNfknNAUdwR9+7UjDPMrSW?=
 =?us-ascii?Q?lBG8rxTCF17cb6+6YLYbxhqaacFCeQwu2bSDDAO25FIMhIqBMrV2R/yDKPbB?=
 =?us-ascii?Q?JEn0eUqhTMMuYJxXEUS+Ea+j1WO9OFVon6FgIQKDP9b6f1M95yIUSQb4gUmC?=
 =?us-ascii?Q?waaf5Zo1i85OCf/E+WV7WtDlzwRchknIxkoRug8V1lpfd2YPp3VIg0eWVuRE?=
 =?us-ascii?Q?v9hCS4DfnqHf7VllXU4XVbU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7081f05-9e73-415f-dafe-08d9e9dca6ce
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 01:53:35.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgjgiZqxPSF6IrmdV6s24K61OOTuB+o1LUCJpzoNB12T0egui8RBPOYTy03CtOsoNG332CHvanL1hbEfM2Zzug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2493
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

check 'priv->clk' before 'imx_mu_read()' otherwise crash happens on
i.mx8ulp, since clock not enabled.

Fixes: 4f0b776ef5831 ("mailbox: imx-mailbox: support i.MX8ULP MU")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 8b1399e5d7bf..a0c252415c86 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -725,7 +725,7 @@ static int __maybe_unused imx_mu_resume_noirq(struct device *dev)
 	 * send failed, may lead to system freeze. This issue
 	 * is observed by testing freeze mode suspend.
 	 */
-	if (!imx_mu_read(priv, priv->dcfg->xCR[0]) && !priv->clk) {
+	if (!priv->clk && !imx_mu_read(priv, priv->dcfg->xCR[0])) {
 		for (i = 0; i < IMX_MU_xCR_MAX; i++)
 			imx_mu_write(priv, priv->xcr[i], priv->dcfg->xCR[i]);
 	}
-- 
2.25.1

