Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FDF5AAD38
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiIBLLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiIBLLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:11:13 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA15F22B;
        Fri,  2 Sep 2022 04:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6owkzMvv7d2sF0g/reX5qw9ZwtCOv3wyHlreG0+MZu84J2AbDX9rExNnzg0yH9n0UcZmcQsxIw86I7l/ibShW/tvTerw/0/FUUx3rt+v0i/FvP3zZ2CKv1bkoPYSmigShlKFjMIYMKhV8k5JngH5t6A3s/dp+ZDBxLk+PojvqJsJe8A0JI2lrSfFPrCU8p/KFpUKlqwLqhNsWRyw5SJy9dTPNRaWg8jicbBbSAB4FYxCzsRyiZuIUdKa/poLDEALNfiDNKAychCVaIF4OBCXy4c5Z9STOm1kqqSkiHtZ3cjzNTOdzBD6PwtH/CDqeXZmeX/irX3apDT6BOUiGhTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rxBtL+xtZtRD/p9ft9LHyWtH5CBa8E8IvAPZC2q+x4=;
 b=cA/ajd9B+PzjfnoVTMYlmxPoMXz2y+IxzRTARJVuaKzWIzms2yJo9JG4dK13jQkz93lg2/L7JuN3qUulgeK2M7LwzG1TkaM1vGoqU98P4UMO+uplrtaioZ9UPaHJ3bYHZ/5IeGf6YvXn2QJSmQ9hZu2XN8W/JFJYtbwzEzfyDDqbij0iE4J/pUK9Req2lwpvBFrCZFSWDBWUCMvv2z7Lh4CIGru7QmiNXMIROfGedVGCnuO1WIABVrKeXSynyafP2+pnIkQJm491fVR8h+8RdMoEoUQFT0sUHjWP6VqhLgdfF2BJZ5WznxamF9tDYH9Bq6iMQnSSFzkI7vUS+vyPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rxBtL+xtZtRD/p9ft9LHyWtH5CBa8E8IvAPZC2q+x4=;
 b=aQIQd89N+HGYeFrCrqgY8wU6sObPQJyWIUPOHq/d1Eb4nc/7LOGBUhanWnNM+SkBP1K3BurhbM3jkE5nWwDegGUeTjUASewROFGTHInCSYSTBcLzjjkwRZHYgneid0mBYKcylJlHy/QSBp8ows7cbCNrYPTdbeASw6mx9e+RjOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Fri, 2 Sep
 2022 11:10:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 11:10:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] clocksource/drivers/imx-sysctr: handle nxp,no-divider property
Date:   Fri,  2 Sep 2022 19:12:07 +0800
Message-Id: <20220902111207.2902493-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902111207.2902493-1-peng.fan@oss.nxp.com>
References: <20220902111207.2902493-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f7fde5d-9821-4087-5511-08da8cd3c640
X-MS-TrafficTypeDiagnostic: AS4PR04MB9409:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lO4UjW2HHt290cePwE6uBVUgSoS/xOz7gAIbqYj2j6E6FkxLOYFBJbgflFyAkU4mgMtds++tg/DO7tZOcsQt8gFLoP67b3GeEIcLt8UJlrSCxXlZFb3YVwosHPPDW/ARGUgeACy5DJUhlhNdO83cKBFHGN6sw7jU9lI65+Vydm/TiAE7oKtciweclz3dSxstKoXAU2PF9Q56fYU2UIkVp4bKuwqRjGOFexN+66e973UyovRmqEYR2/1Zp4dTrT2FV0NSfPJ3aelf5duXC6dzu7FhmeKhmdJi+WtCjsll7j4CwGyNokRUzUTNVhfgJCWLeOFCBo+9pJRHCk+yO+SGA2LTHGJCElU3KZjFtdnqZxokuVNDxbHqWjVzchIuaG/96Bzf09o32fgprRmIDArS9r3Uoi3JNmclfdG0VMdJ8Vwy7ln5r6rtluRivAG8dwWV8cAX4G/m9euv76eSCuyuYGS/KQ09K0t4MFLf/EtXTcTjojslXlUif04oHzW7U9cvh0DwcvDrixiRFQPaXNKpP/Ln8T2p7Vb5QAYSGr19GXCri9YBScR62H2eP722G72x4G9OfnEGrJz5vzFUron2emGcCzhefPkIjuYK2KqP0ctJrEZiWMiyw5u8gDvSDewlrhS3QOoL46W0w3bdHgGbVdXatXLTlPKwulLHk7egT5PUtc9OvFuasdRsP93Q3MLK/biZE6PVV77Amg8aDtcny4OfILeixiMTmm9iFVg0N/tpvjV42VSwCGbqsHYznocwRpAMsZMTI5XbCIjg7nb7Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(83380400001)(38350700002)(38100700002)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(2906002)(8936002)(5660300002)(52116002)(6506007)(6512007)(1076003)(186003)(2616005)(26005)(41300700001)(6666004)(478600001)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oU8KU+m82+sOxA/5h6g6fQO9UEoDl4IRTRrAEHBbYmWKf7aq1eslqNLlNNLj?=
 =?us-ascii?Q?Jopvk1/75AsVkA2+gYwYFdX+0jM2KZh9dmjzHsOaNtGI9lzCIRmzjTfcjM/0?=
 =?us-ascii?Q?+QgYC0N6UASU5Wka3KLSNTzO9/WrTc2mTl3TjN+vXDenFGftSgBB0DgCNiaa?=
 =?us-ascii?Q?YaT9ME6psFbotDp6oRWgEFDvs0PYtpr0UV3+OUopIKKAsAZ8v/2d7B1sL3Sq?=
 =?us-ascii?Q?Ig9hkfgnOPUchIR1+sXR2vFtXwYcB2zre6k3Gydl9WgQOriXMRtJUndly35J?=
 =?us-ascii?Q?MSartu02dbFbSIr3Hqxmd/OsVWeT6IGi8N+2yzVMvr7Bm7y8d2hDE6EVMMPv?=
 =?us-ascii?Q?bKjmWRNu3gfHtXTG1qKlOuDVFe2mZwrCmMuZJsd/3jN5tMbZ86wsthrT8wbQ?=
 =?us-ascii?Q?SnKm5XnA8Z6CmZxbKoO9uxiJEOvxz4zaxT6uhpfOt7aSuviz2eP0kCkSEUCG?=
 =?us-ascii?Q?UkbAiV99PGfH2Ew0Yu1Mlb7gG8+vzb8EIpV457Pti4hciuNajmWSkf0dVMmi?=
 =?us-ascii?Q?PHJXarCjzldELUOm3RgxjCnQbM5/KdRT9SZIZLnnGYzilnDaYx2eXmmhEsxN?=
 =?us-ascii?Q?1WgjK7vSBud+IDLi053f6+EReqtu4D1yiFFsl+QothwyfPD1G65DudqcV3ru?=
 =?us-ascii?Q?2ejAjZL8Bjx62nNSUV6MluqkBa1h0XqU1DKHpG8vukUqgYZ26D0lCvFGC8BV?=
 =?us-ascii?Q?kwGdwrDrYFrFh7XJWGozFYbM4ggcbUQPDV/a3aVoUHX1lNkurNo9iVh+rmhz?=
 =?us-ascii?Q?nXzhxkAkouSrl3g91OX22vJ2XAtKjDnVaCliZb8hrw+o13oz2UnbyROuiMmu?=
 =?us-ascii?Q?qBdD8p402plj2BgvwiwPjeJMpvwwmsdfS7j+DYetGTUmCWMC+F/5EkStVdRY?=
 =?us-ascii?Q?xRVYjv+xPfXLrROZGhr0TDL57iA3KvoQX0amhllYEcYbiZSMKY5TqiwVOiBu?=
 =?us-ascii?Q?FUQjoHAEMsTdzhw3f4Fenvpl+Cwr0JzvqPpO3KbKufCRLKRz+7ubdrk9T45r?=
 =?us-ascii?Q?HdWsgSJz7H8SJClLObtJF8CzJ7HTFUGWCqkK8cFNejcLVHjlqGt8PA2q0XJQ?=
 =?us-ascii?Q?SVaxIhCMgLCt2bBl//Zbfl29LvEmuLIZK1QMgEInOxRvo0oXnhLimedsjpZb?=
 =?us-ascii?Q?noleYvycSh3fa3wjibJ1ApCLvWuZrIVNLoTblupGUuQGDQYOvw+6TVWGK+SV?=
 =?us-ascii?Q?xSoDNYZ6sCDp6fCtgeV1uT1IgescV/DfBxhRCPpFJNqaZF2ZJ2AiXkFHSfMa?=
 =?us-ascii?Q?M5kp+LYgKe/JiXAplvd+gFGxJfjgxlteirAPHQb4W9vT+4hk3OyNFM1TCeR9?=
 =?us-ascii?Q?V64CEYuvIa4vscRAKeY0M85UUiDFj2WGXTl/QZeLZDYxN3QDtYBe/U5iCLVw?=
 =?us-ascii?Q?ZOToPGjYibj0gS4oh6DrRUQ8a0ItxrburdPxKd2+bSlWuyYaE2ZFSqQcBKKL?=
 =?us-ascii?Q?CzKRYDKoUGq79w43EYRRtj5DGR+XgAfhBYLTS4uW0jj3yLp2asuaqIH3b2UB?=
 =?us-ascii?Q?5or/eYzlBxpq0BAJp6hHx+UxL/ptAFZkJ9iR0zkCq7WgXoLQqg0uPWR2QESl?=
 =?us-ascii?Q?6OaC24GcBgmCx1x5lmeZm6KO+E1gF+Iybwl/n4A9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7fde5d-9821-4087-5511-08da8cd3c640
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 11:10:42.1889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SyI5XcGP87epZrzy/TchjItp4FL+oEi16nGs0pEchVhlKIN+lsL1axKKsQYVKsRL9mQGe3BJVAbDna3+afSMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The previous hardware design embedds a internal divider for base clock.
New design not has that divider, so check the nxp,no-divider property,
if true, directly use base clock input, otherwise divide by 3 as before.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-sysctr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 523e37662a6e..5a7a951c4efc 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -134,8 +134,10 @@ static int __init sysctr_timer_init(struct device_node *np)
 	if (ret)
 		return ret;
 
-	/* system counter clock is divided by 3 internally */
-	to_sysctr.of_clk.rate /= SYS_CTR_CLK_DIV;
+	if (!of_property_read_bool(np, "nxp,no-divider")) {
+		/* system counter clock is divided by 3 internally */
+		to_sysctr.of_clk.rate /= SYS_CTR_CLK_DIV;
+	}
 
 	sys_ctr_base = timer_of_base(&to_sysctr);
 	cmpcr = readl(sys_ctr_base + CMPCR);
-- 
2.37.1

