Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765F0464E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349420AbhLAMy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:54:58 -0500
Received: from mail-db8eur05on2066.outbound.protection.outlook.com ([40.107.20.66]:29536
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349411AbhLAMyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:54:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/O8gArMY4souMov2fsQ5wgVkby4gRA5wfSzy1JBhFnol/syEWWSw1U0EfZYnV5SCHbAW/ixiBuUIEkTEHm/KFxdBktZKcmI2zhPRV7cLQ7xmYJMxu50+7tJ3Xa417U+MpvDaTw055zQ5xRiT+BrcG0hQ7ZsLcbMpuQgncNu2E+Ws4lmkVoYQI+J0CTvyNrtfcFagd8U0teFtPVS6TABXzCJgtpbCJIq2AIeSHa16b6iYeUaLeahKRNFxjN2IpSztTSEjbKu2uIxOVnvyrRwR8JMLtUnYl21rHC5rFa8MM92TibY4wOiQFg4X79coTNNfHX8JJ9IbLv4EjvVhV0GCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y69XqWnxbnuNUNp75sWgk/TmksfQY3+PSA/CZE+v7nk=;
 b=SEDchiUhjo0yXF3N12ExSwTs40CcbK9gpzk65MvI1alwcpAd6R9iJn4NRvW5MsVVaTXHZJCRZUZms7mZalvryl6P45k+PyHURtmmhNS6AJEn61lLxezN05CRFVU0wO5P2SsyUJmIrKK2qH4sYbuQLteXuTAh9iXD7EKIMiSBgBJzuDiGy0+g5c2HSmNafzr0Rj01D39P0zScs+KbOrYEnPCz4mxTuZ0ePbLy438nAPErtPHiEi3YooGvxaJYdECK0EmXr/kx/Ju1LZkweYozb58OhSeeFmSkO6QIww215ihdOIBQG0YLof5NWbCrqQLdOF5KM8mQqFBOyi3mm959jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y69XqWnxbnuNUNp75sWgk/TmksfQY3+PSA/CZE+v7nk=;
 b=jJvx25KzLvMlS4afiKOmmRnwxxKCG1mXk4ojSTyQAe6mESL842DG4DsvLY7nuGLWtoqPkSTFHfYiFZkwpEoKvo63wL0pLWR603s4DQ0h1TsFkrcaD7oiED3JR6luL1fcFasCbhUiMM7wLXw86aScpbRBEW1eye8/S/Yk6wVjUwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 12:51:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4713.027; Wed, 1 Dec 2021
 12:51:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        van.freenix@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] clocksource: timer-imx-sysctr: set cpumask to cpu_possible_mask
Date:   Wed,  1 Dec 2021 20:50:30 +0800
Message-Id: <20211201125030.2307746-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
References: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 12:51:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91c76a1b-0f0e-43b0-2ad8-08d9b4c94b92
X-MS-TrafficTypeDiagnostic: DU2PR04MB9018:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB9018BD9EEF38EEDD42C5CD5FC9689@DU2PR04MB9018.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dh3eJbdm70RlyI52G0r5tIkC48LgUGy2Q73BDz5VSBBCjArNDHeKclijlMTjFeeOgmnvRo9PAZ3uL06urvX9O3KmS2/gTexyDHkBbCkB7x2p0ItwX9pD9NExP7610ms9oJOLMeyn0gMYrDcuf8ut1EBl6yD4rNBUkFchifeEIXogFGqIu0Qn3Boac42mM4ukO0tLqJkSUPcRVB2+WOKHtEURxy1sPFAAtIAOCRm/BWGChPjgMrTEMgpixDqiH53o2gzjdjF33AaPLb4TiydKJA02MPFJO3LQtdN9kaOywcfSGHOsBDcrqXLpW9Z8At/PRwj+D8NgAt/3025dsKSqabMJmHGAjXdD/unFJZ93pIGFeSIVrypR+wWu2k/FDDepagA9F7Y/7vmDgIOyJQM8L3c/c9XVC58fDPcijTdIRhaxv/ruUUq42XAi22QKa3BMzoCxk+8b1fhybZPuEM6CjXpmuPD8iqgHBmjyce5NeDsWwzHWbR1bVY9kTfBkHerI3SVNL3MYxZRsnpWxlF2x7nIlkhAp1NSoMBTzYPoygR1gjZV4AflsB5lywIDXRDfwcOO/Fqc7Xp293a8rijTqj7mxM6NzKRs962jCqp52alBDQQeA5bJPG6w2HmgxL8FLLXQdbtc9tjClHyPsm0b6Sc6HbmE2IEcDOqWMp1FbuWv09+GaUC9tNnIWuTHNJKKJYH60lf+jQ/+M6QrWvnj5+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(26005)(508600001)(38350700002)(316002)(2616005)(38100700002)(2906002)(4326008)(186003)(6666004)(66946007)(86362001)(8676002)(66556008)(6486002)(52116002)(1076003)(66476007)(6506007)(6512007)(956004)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?89bOnlQ1cUuPYXuI6ASRFrmt+FMlecTXJJ7CV3sLBvfVPRrOrvj7ZzS54KEg?=
 =?us-ascii?Q?iPp4kzguiO0IIAgYzPwq4omRT1E2nWNzNnKepNSpujroiF6oQJMDbhytVyXR?=
 =?us-ascii?Q?CTEhek6TLoUPyk+Lue7JmABbymdqZQhps/78DOU6VpJXImkSpKCbXl/vWARU?=
 =?us-ascii?Q?8yE68pe30l0pG3XxpiYdBtInor5xPnzSZMN8xf8rtfCYhG0gpIakif5ZeIbh?=
 =?us-ascii?Q?mWXzHhrQr9bETCbjQrotC9jjFspisX50Rcvvi4VWvyfy/ijwhDEsoHSsprN6?=
 =?us-ascii?Q?TlEJOcEJJ8h+hBEzJfdbf6vCAVnuh+mHJVcKJ/E1irzx715djfdN1Z/Uc642?=
 =?us-ascii?Q?d6HtMhR9OZzKWF0pStpBvD0Re4MyweT0LynEOJpVYWp5YAZIW2MNDzSCs6tU?=
 =?us-ascii?Q?gmWo76cW1cS0gvtoMxQoj4oDXrY2Rp3C7f565BVNadFr94TYEiWgSMz3U5EM?=
 =?us-ascii?Q?/yME8+Kvnk4LeC4A2RfkWEond9t0zEk+0BNHhw1tj7/qnBAvBfPgWoOTXsXv?=
 =?us-ascii?Q?2ms5dj4kzv3DNoEWI598VpQbsGktphLoRVpfFUErPMBeEzL2ygxB7rsLVJnH?=
 =?us-ascii?Q?V3wxUaFon0UpQ1HyCpAg4kSuGamLvaVKPaqSCHF/vvPyqlHaMTj7feGjEY7I?=
 =?us-ascii?Q?4P5StnbpyQXPTFtZjPa+dRLbBm+mNoUypKaMXPHum1QZXr4flQ7MM6j8H690?=
 =?us-ascii?Q?gOCFblwZOu3cN3rhHI8bkx+olo/di77PanPaI+B6N06VyvyiRa10lqF+wnQ6?=
 =?us-ascii?Q?0GAIF4sJ5yWVl9ZJ/FnILdo7rSprLMmHefeRqkY8XdKnF+6GzIQKGyza/rLR?=
 =?us-ascii?Q?YLArCwuu+5gd30ispdOBFdt+sPPOWY1bWFjL/SoMqrnicd8XysZGgn8jSgMb?=
 =?us-ascii?Q?2ZKM1gUckW3jLLTAV0dEgBAE5YtubArukAzunnYTY9YpxcJuF6xAUiygrs8R?=
 =?us-ascii?Q?akZ8l6DOVqb0vbZSZR3lk90ndFaRBjhUmLJNoiaY4kHBP+8NmT9pcjnufX7o?=
 =?us-ascii?Q?BZaIiM0mWXJV5/+aWnaPzh8gv2/0Nau6/lzyTosgBWknuMs+Ktz+F0lsptr4?=
 =?us-ascii?Q?HZsdPyGlU/MEZPQwpS2Dce/nRNmFTZCTjJvFNckmYQjQEfZkEmGL/igytB/c?=
 =?us-ascii?Q?8pg3TMumgzGM32Geno5n5jPaYVuOrxBV3UWJnnvlsuG56YiuUAG2T4wyJSHk?=
 =?us-ascii?Q?2srNBojiG8s7roXDYXXntU/CO/RGuhVFR/UU2iXHt8hwbNOM9dNFxxh/3PRo?=
 =?us-ascii?Q?Ec5JQYK56szQPPukoBBaD5+ZvjToVlnEd7jYCb5wIizeFB+Cnl4gBLK5yOjJ?=
 =?us-ascii?Q?OTXb2E2MEa+jEQLj+EDi8WbDRpJXGmg0Ib2PJTOnargndxzd+el/e0qNOcBL?=
 =?us-ascii?Q?vwnGm8K031d8QmBZt/AEh48Ue8+Rr4P68ZOFWcV3s0SgBCaLaeMZ+jpcKt7r?=
 =?us-ascii?Q?u1wnysST2ZJjCvqKSUh1iLtlOAYoQRQCW3KsoC7r3C+7vpE/pIkpki3Uzmpa?=
 =?us-ascii?Q?pGb8kScrYmZScTf554yQ+JF7zh2TkkvdPtrMeAbyXTaZKrNLurKGR5CiHqwA?=
 =?us-ascii?Q?aAFkUVB7jhg8kMkIloE25XnwIvfGGs4pv8rxxoqW8M1H5ajDjAWRaojeOtVh?=
 =?us-ascii?Q?w3p0ZylZ4gbxv4PkqXPwb7U=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c76a1b-0f0e-43b0-2ad8-08d9b4c94b92
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 12:51:30.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1bbAIW9jdPVxSGRFfnk+3edubV/aVQSavwK0P5o+cpheUqfv+ezBCLyqVwWIU2L1Zyik65zNKt/eKJLat5bhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Actually we have CLOCK_EVT_FEAT_DYNIRQ, the irq affinity will be runtime
changed and no issue. But the system counter timer is not tied to CPU0,
so use cpu_possible_mask here.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-sysctr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 2b309af11266..55a8e198d2a1 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -119,7 +119,7 @@ static struct timer_of to_sysctr = {
 
 static void __init sysctr_clockevent_init(void)
 {
-	to_sysctr.clkevt.cpumask = cpumask_of(0);
+	to_sysctr.clkevt.cpumask = cpu_possible_mask;
 
 	clockevents_config_and_register(&to_sysctr.clkevt,
 					timer_of_rate(&to_sysctr),
-- 
2.25.1

