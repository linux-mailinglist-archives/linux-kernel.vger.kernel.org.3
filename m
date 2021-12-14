Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC26474218
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhLNMIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:08:52 -0500
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:57569
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233847AbhLNMIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:08:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFiSX+AvdUf/bKAdNbUPsmzMdgDz4Ir6hce8LJOMtSu4HjcAZ15HhpRs9HTigCM2EMIAHceKaiajImybhxj7uEuy9zMbqbt0FgtCg1JiyxDmA124PuSx2ANfibBQEfeVUTF14jw7rONxKAC/YIxsJcZmQS/F6lqjTscPkGIknc7ZSkXo5RenAIik2IIHPhsxZuZ/CS4MKTk7aHJUInxGjgDXcsijDuCmssao9yqHHTRzEWKUDfFzU/r1/ykfVwWV3zI7vseK/fJx5FOi4i5o2w7YlB3SAif4DZPXRkwqKljP/MRVzb4rKWVij29I5Vpo9OodlXCcWOzS9P01vtoCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yS4xsdcbEzKSsQD0rTigls1VhCiYbSZh96CsoY2/id0=;
 b=eMELaoIuS/Z5AQFlgulzgj0Xy0AuQC7p98LrX88f8vP6TOZWEiE+9q2QHWs96q8mR1E1EPAeWSeLbD1PDmgRw1+MK98Hi454Q5jbum3qXwzc02xsQ0W6f6r1ATWhIBAT0BA0YqzUCclxJHJ7/W2DWeykycMtWMPNB/4eKD1EUxsvGVqCp+whapFZUkxXObOFywIKvxydDS68D9qxDtyvvVqYrZae0cX9C7f4QNqtoYflkjE/lMGjeXWGDUcX/B+lBXqhUJYz1fsvCaItbzu/YuLMUqs2fviYS5tbtNEIRPmAhsgP07mccny6qg7JkIDZMzrinieFgToHOO1A0YWzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS4xsdcbEzKSsQD0rTigls1VhCiYbSZh96CsoY2/id0=;
 b=X1EYJABSb0y+saCDvBQy8lJGHhJQKufqGpnoPPRPU0fD0xCXvRUJWf/Dzxblydj/ny+2ZPRy/8faH5lnQNfneiIFF3s/ys4kNLQyKiLIfgLnXdyYJjN/ckCaB210mdaFVHS68Xe7BtFpVtZJSeu4KZ41t2MdFxaaKF2M54OYi8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9115.eurprd04.prod.outlook.com (2603:10a6:10:2f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Tue, 14 Dec
 2021 12:08:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Tue, 14 Dec 2021
 12:08:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/5] clocksource/drivers/imx-tpm: update name of clkevt
Date:   Tue, 14 Dec 2021 20:07:37 +0800
Message-Id: <20211214120737.1611955-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214120737.1611955-1-peng.fan@oss.nxp.com>
References: <20211214120737.1611955-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0249.apcprd06.prod.outlook.com (2603:1096:4:ac::33) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 12:08:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fe31e8f-8cad-41a5-e8ae-08d9befa7aee
X-MS-TrafficTypeDiagnostic: DU2PR04MB9115:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB9115EE936AAC6320C253E2B7C9759@DU2PR04MB9115.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmTkwA1sViuP+pXaRBbpEoPyxDBH/rzpRhyXAdxErfytfHP1GOln4TG1s6TC8FcrtiamDV9+IQUOhE9rz5cWy9rb9EAFDfORTlBwb7Gdts8TqTJoBYndAiEthxh/raQu44gmyxUiuV/AqgTwQuEfE48PJH059ic8c18dBUVi9eMdndr/az0J3GrWNyeyLMQV78STrcEOrG5EUgQcgI0yVEZQtlUh2gv6lkcW3QSdJDG+9Ij9r8soRgWzoYnVm+oTIwuckCxpna34PbMoTcUkF5ZldBc88calmb+IFyShN+rabgOeUpZltLOlEB+BDkIzA6x175TPDiWwUIVBOKxFyRfDvTgGJIVxUPYouwKq50mzMHHssaFLu197U9uuAzE2FLcyVPQKSXsnxm6pXx0hybPYOQ3IJrRFa13jMq0ZOqTkqI6jO8gETaAGReL5WF+pWnPiiiwHKHMCcyP0tiJtgbBjjXrmT62G87EL3i6mSj4vBNkO4vG+tHlxmBED5LNDo1aLD8J6nrMoqhvBhyP1fCVyFAsvmeMXuNIDDknHeuT7PNL7xS6350B6XOLJAFtbUEu9p07FNxdimUV8OjoqXgXO2of2iXhZboFYVqo0EhM/+w2hrf/KOuz5HLErHZFdxZfFXFQgTNGQPadQmhzG/z6wGE8kK+5/vJHPESBify6Utpmwu/8GCHhu18Ho1iOQ++dKYtF9Z/gXMoam0c8B1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(15650500001)(86362001)(8676002)(5660300002)(316002)(6512007)(26005)(2906002)(6486002)(508600001)(66476007)(66556008)(52116002)(83380400001)(4744005)(66946007)(6666004)(6506007)(4326008)(8936002)(38350700002)(38100700002)(2616005)(1076003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZmZPGXqCxu8YIGQdKovb7DPbGYP1Tq7PJXW1/7d86zjAfF+qhyhZJlAmx+L?=
 =?us-ascii?Q?fChxrQfWQJGRi8svyZDcDk6nb4F9xF/JVm4UK0yD1J0X7bQmpN5daVWpA9jL?=
 =?us-ascii?Q?fsyVytBoCL+PixJiWcOfSKRby35MmdNKMdrG/fqgvGWcV/mSt5ofBKR87hCw?=
 =?us-ascii?Q?hXsxjnOAmECpcFU4ACNjwfzw7eIi87t+PuM3mifrgWrb3fZ1Sj7xyor1KpE8?=
 =?us-ascii?Q?lGIl8dwoAEXizjq4goHrg5xqC6YAuDVFC/BJNb2VkmbrEfN1mf04c/hQwbBq?=
 =?us-ascii?Q?av2bvPl+WhELRcoFupkkvqSvDcvBplt3hh40hMKx2WLL8QGzPIA9UlRz7vMp?=
 =?us-ascii?Q?ZSp/sOIL01Ql6H6yVzb+8Phoud7zT8cxIoOqBMED4/TqFWFkXqvXg6wOprKQ?=
 =?us-ascii?Q?Mb8UUMbDepiWaDs3o1IYyrFgGZY8vsgfRxrJJZhNuVo0Gjmwk8HY38EajsUV?=
 =?us-ascii?Q?MyoMUHRz7iBytjoTqRgQ/8EbHZoCIibRm1WPe+qCRG9br36PyTerrkDC/A76?=
 =?us-ascii?Q?DXWH7U+PBUIvU3GG6uieeJHuHegcb4mibZXwMQ5nnzL5G8F//8WusYXFceG/?=
 =?us-ascii?Q?59L5gruJn3WloCxHdmzVU7k7pFSacgeP5Dc8dsOQGhFujt5gLLCoB9ctk7zS?=
 =?us-ascii?Q?3ObD5Mv109wat/+CIn719BLiZ1WPHENWRu1xq9zbSmuocAXPD9yW1aXmqi+Z?=
 =?us-ascii?Q?i+vOCLsb+jYFTk4qK/jf158byVEydk8BSl8GJKAcCTQ35ueMbyRei65eOuw5?=
 =?us-ascii?Q?RMSHfKEC1Ni4mI2oVO0ucMxPsY34JAyFfrjz26wllg0XTDS4Awe5hXze8zP0?=
 =?us-ascii?Q?dSxZIqzrlVlkfmTkZ3zcpEMhaZOYA60iT9O1OQyjOsQhlHMNNx1YN8hS1/9P?=
 =?us-ascii?Q?kD29YL7+Cx9qzyvUBmc/tdqC4ECc2UP3arlJmqwRD/1XAfqGS8MNYuCc/nKt?=
 =?us-ascii?Q?WfVgLcndHofDyVdRuz/iP+nUgawZ0u7Fjl8zuRPwudNI+yPKP1qem2l6CX0h?=
 =?us-ascii?Q?dw+IE+2gH6LdMxFo2Pbfamhyv0GG9k/j32Cs5AdGkf+nW9EelFKv70Igbisn?=
 =?us-ascii?Q?Ctwb3sc4iIs2rycDjLGPi1JCB3Dv2rMIYAjM9Btl0LYFmvREvfTVMcaGZTQ7?=
 =?us-ascii?Q?CUT35xR6Av4GQDVXMMGVoABZzMs730/VBDidv29qTMfMGcnS7UJwChyLdVyF?=
 =?us-ascii?Q?LbdIbRPJGTFT+vfLfOtTVMg2TU42kfXwgQGF+kaskIZ5jREPGVBq/d9TUTla?=
 =?us-ascii?Q?oBwMZacLDp4HhLxhtRvlcA3d9q27bqH5t7yfABid/rrquNit3aT+jMssbJI1?=
 =?us-ascii?Q?oC7GYvtPWJ9hKfnz2MoB/vrWeK+8YfdntMVXFZh4UOGnH/Do370eep3Vi7j0?=
 =?us-ascii?Q?YaOCIiytL4mYG5HsJXAVEAdOS+EcpVLcLkBtavGcRohacEzvXAWDDxdwPTfa?=
 =?us-ascii?Q?d0eRjzYacfJWs29lA9N14ChXqLsxMc4edsFCshAws2xpn2KylAd/+IYxy05P?=
 =?us-ascii?Q?N7LkfLd2FlNf27/EbyDz75hzp7x5g/7lwF11pSPkTWfaEEGQTIJu1Kv0+ZZc?=
 =?us-ascii?Q?rn/HEI1K5+7lneihwnAZveqJSEQVtyc61OYm0XobwgXsPT038rTi1b8rgT9O?=
 =?us-ascii?Q?XmjynvFAQVAGN6Sjf6K4vwU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe31e8f-8cad-41a5-e8ae-08d9befa7aee
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:08:46.6321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSprC0zTrg7LmKjMZ1NbFm5+iP3o5JlqoFo+yhbGKki/GZHpVY+nCgKeE19fbSaOPcJhscH4sUEFOIz7AkYoyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The tpm driver is not only for i.MX7ULP now, i.MX8ULP also use it. It
maybe also used by other i.MX variants, so update name to reflect it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 578fe162fd99..df8064122b10 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -127,7 +127,7 @@ static irqreturn_t tpm_timer_interrupt(int irq, void *dev_id)
 static struct timer_of to_tpm = {
 	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
 	.clkevt = {
-		.name			= "i.MX7ULP TPM Timer",
+		.name			= "i.MX TPM Timer",
 		.rating			= 200,
 		.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ,
 		.set_state_shutdown	= tpm_set_state_shutdown,
-- 
2.25.1

