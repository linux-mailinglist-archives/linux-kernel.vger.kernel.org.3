Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1488A4C61AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiB1DQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiB1DQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:16:28 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300114.outbound.protection.outlook.com [40.107.130.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2488251308
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 19:15:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fx15ghco3ZQZec7fwmM3pAgc7i10wsvRiviQygHF/J/waq3rj78fXc6fmbuCrWVDPyV8sHmLr0ULRGGco7AyfrSj/s+x3y1LoW0E8H8ZfKmMEVjTwoCf9rMAB1LXWHmoSX/8NKIEgDLdEewAnz7mT/G4cIGXOsgl9e1OE0Aj585PVN14asLfRigVAIHHMS4qmVLMCryquXBD42bBw7iONqzcXUAOp/hz6z0aypjfevxxgJwsW9zM9//E3rzOeB9i38dV4wsKajb2Z3yG9zv3dIGEpgnlNO8I8RfGsh86ppWZvEfjc080o9JYYvbCKUIlrqvlCkqKVP3NoA0b9HL/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc3BQQ0XmPeXhs7OLDhPzHea4Jtjjx7HsDLUjEfUE5k=;
 b=WGfKPKN8plQQWNTpFjRJ2Cs9ni9N+Wwg2yjFzOVyBGl8NnKe/jbHmHAfhw3PfG2rUI4GMJpMlOw31GwhlqjJGY2Dc9eqDNZA4gDgY5sMg7soddF4AaP7IAPMVknnLh5nLXb5agwcf0QUMZFri5+2ZHBGknDnMZmVY5/2QFHKeek/6qXksoWsYx93kz5igzcWycO3XifBn1re05noa7MWJlOMYmHqINpJTLm2QAV1jDEs1YJT4BPVJOm/Dq+n7i2drOYwt9kFhlDIPEcGvEMp2gEcMvWv4WfWOyTGLaw/wOGuupL8btl2jMvvbv111tG1eLanPeogCtxgP3lcHwYHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc3BQQ0XmPeXhs7OLDhPzHea4Jtjjx7HsDLUjEfUE5k=;
 b=RU1hhZx2zeSAVNsH8Fv454BWLi9t6DRR2cHVudI/YZmyUHyebimhni/Xx+ewEgV9NYCzLM101P2ZBWujNj4BV5u5olR3MZKjPl4xISvcVjUAN1msizp8uwLb2LuMugcNnpLCR/Z6WIAdqG5T2R5DG5OLsLnesyonQewMlHYn4vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB2454.apcprd06.prod.outlook.com (2603:1096:300:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Mon, 28 Feb
 2022 03:15:47 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 03:15:47 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] timekeeping: use time_is_before_jiffies() instead of open coding it
Date:   Sun, 27 Feb 2022 19:15:39 -0800
Message-Id: <1646018139-61508-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:203:b0::20) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e325222-9b83-4f89-a406-08d9fa689d71
X-MS-TrafficTypeDiagnostic: PS2PR06MB2454:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB245491F2FEEA94212311592EBD019@PS2PR06MB2454.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfLif4fY2dbtRhaUE84RU91vTur0D6GGuTqSgEEWgqHHDBZpfzQrqpYNmVhUiBg6IRHBYkKtIG1D+naqsyM1/ptfScQ2TPxmmN4wfrZXWIMi6iua20BoOcEqFqzzuI8IvqtgapvFQ0w6o/8qFr1RefNsi6sVSeJjzCJf9SszGoQuxgCmrg/dae3LMYAKTdGD85zmbduImHbX0ynyyty9CQZkgBAeljsdbWPDoJ7vlrPzc+mZK0RUx+Kde7GP5ZuizSynQtnSamOwtr7qMOD1G88N/qamv1wDV+O+BwlUbT0hU3JysL4yawEdPpR7VUz+QIT0Xt9Hqk9uP0Kc0DG/dgm659yEn5p/2/6wIty0UUA6sjunx73q3dX3z5Ih5hXh8C7uNj7v8dhMZB+e2NfDrZaqlGUWJDb8W6DcbXH1cFLvoOBFHIMvfBqgdJ0WY6V7lwkedeNKhqcx1PbqEnxRMRS8ww60HQkZH17654abCULiZUnU2kSTZa3CIQ2bwdLDr9EOCTcbiafJt2qU0SVKQYd2eiNZeWELzhJTlcV8Ek9dnvI5rP1yCML+zLMxqEX3901bAamGuvao4E6MVTeosCE8Bsf06vPFOgfEJCZ/nWjukNfIWo4gZXG79lphzggGQvKndR2x5nuw95hT7oDHWsd66qI3j3mrsNvnGFIM/eJyyWb9znFl0dpORq17AobOp1/QfwJLWoPjHky3Kk3Kyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(66556008)(66476007)(66946007)(316002)(4326008)(2906002)(86362001)(38100700002)(38350700002)(8936002)(52116002)(6506007)(6512007)(8676002)(186003)(26005)(107886003)(2616005)(83380400001)(6666004)(110136005)(6486002)(508600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ej+NKyhpSMfetd+JqyWX5JGPjOQv7zR+t3TgRmBBlkCLZi+5kIAfZRuYXP9?=
 =?us-ascii?Q?rimssgC+ctmbOH2ob3RRPzStzRz3vMZS6LxpksXxm42aEjyolRO+tyfrEFjm?=
 =?us-ascii?Q?vrMQ67ANNLHeQv2pvq+/LY23t1GMUX7856s1qNMuzTCnN9g4AGhlAs5NqDJp?=
 =?us-ascii?Q?BRxtu8lc49f0MjslJrhePAvbjDV+8S5Z39jW+YABczE8RDaVff/Q/mMgECU8?=
 =?us-ascii?Q?oZmKZ+e8yCeKDJ+n0H8Mrtu5E0Nkg1/1CWFzxCwCMINFETe098xQhZMT8x8Y?=
 =?us-ascii?Q?Dj4xJudRS0Y0NWV1uU+c2wDj14BpS7x1WyrrpyHfxJ5Tr22230pkMBt7zvsY?=
 =?us-ascii?Q?PyIdSwX29OrstYT3KNuL3P9pdnFbDs1eF1JiRkzOBmt2b7cq70pjuW/eJSaX?=
 =?us-ascii?Q?t384s98cbWoQHgq/e8m388KGT2yOtkiYCimEXZaLBwa3UQPMzbck1wROIpkB?=
 =?us-ascii?Q?LAg99y9B63fRQOyNEvUjOXoCngv0gNHePeScqLHg2WMirc7gKsV14JJP7so7?=
 =?us-ascii?Q?JwyJuEXgRtOFtqCExsI1crG0MJEckn4YEaW5V58eQKPWZajcxp7jbpDF9k01?=
 =?us-ascii?Q?gGpypU8v6nqvLc+RvpxjboAcYUcqJsrdCy8pFaXjzza9ae2kohrHpdww14tD?=
 =?us-ascii?Q?6K4EkZSm7Voybwd0V3bZbh9BWpvW3pPc/N96C5qtWCNEqZa7NF5dmm4k8mYO?=
 =?us-ascii?Q?K+CQb3gHmbKVV0lbqqOq6ErSsu+xSRipaSinOpgzRmq8MT9EDcoJIAIyg9al?=
 =?us-ascii?Q?kW4TCR7d5OnZEFFawmVc1EAahcOgCYHEdxqzUqqtwWVOFeWy4BHASbm2Xd/o?=
 =?us-ascii?Q?L+ey7C9v/Qkj8AT17YKv6b6+fS74Th5OOJowbsEGvVr4Ei1MQV8lPH7AQyjU?=
 =?us-ascii?Q?XX/JkKQIReiCuN3QEYyLqXtQrtcwOke87VgAhmjgiyKhL1XEOg8uwJRXM6A1?=
 =?us-ascii?Q?E3IHtP/LmcTEwrRwF1qDP1MPygxA3o3y58AjxhcTfayEg2g6Zvg0qldE2A4T?=
 =?us-ascii?Q?p18Gl7cOcwQ2dNu14LFUsfluFY0hDLXjq/oN+/LJY2L10AvFFJuaWD9AXICL?=
 =?us-ascii?Q?sW3jwEd938EhWsxiF3r8j1sZobfDC5j75QRafvSfVTioNZxZh967LJKxyaf4?=
 =?us-ascii?Q?IUsKoZmUZDxXSVC/r1z/dW76jtU/iTJ3AtPedBE1sEFD/CRkuaPV6auraEor?=
 =?us-ascii?Q?LEnGnSFG/exefgv64KZCQ0jNt+iv53DPRCEETJQJxlaVzJcm62D4mD2JaswN?=
 =?us-ascii?Q?/4IK8JIAGwIskp3zgISgyD/akcXNUZMCxZTWN+Dwq9xy6JZOJ7/U0+S0hKqZ?=
 =?us-ascii?Q?FkaDmtE16Seaxeu29/CxcrgqPl2RwoAOLQWizSVnaNzT4SYkKfJP8s9aJZUF?=
 =?us-ascii?Q?50zb0DnXTygSEvKS+2t0GuZdSYxt3alozyJbeCOjrQr4I6oCgxSB1RbSfmOs?=
 =?us-ascii?Q?qcBK0q5ZQl4sZk60MJ2tA5OZjJh7y7tEKMfBjWWlndnU27cxtuG3GzUgRFnD?=
 =?us-ascii?Q?tevfKLd4tuNKWW3HgTXVZD8QKOju0x1/Xu36Bj/uxASTq+Bu3nGLkmfuO7dd?=
 =?us-ascii?Q?Mrtx7HYaDZ6rfo3JQOzskdWs4fW6FAEPHXa0U+8VPb3RhjSyc04CrK5xatHZ?=
 =?us-ascii?Q?xNwjoBFPgNUf1oSwhN+sGl8=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e325222-9b83-4f89-a406-08d9fa689d71
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 03:15:47.5586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xB/vg0vFcNziRPTxclA2bErp/KIt/QG3GACCfB7uJdsTeRqhspmLnjwy1IhXiXD2CH5Jho+iUyo5sI7Rzso6vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB2454
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Use the helper function time_is_{before,after}_jiffies() to improve
code readability.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/time/timekeeping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index dcdcb85..6f32ac6
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -215,7 +215,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->underflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
+		if (time_is_before_jiffies(tk->last_warning + WARNING_FREQ)) {
 			printk_deferred("WARNING: Underflow in clocksource '%s' observed, time update ignored.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");
@@ -225,7 +225,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->overflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
+		if (time_is_before_jiffies(tk->last_warning + WARNING_FREQ)) {
 			printk_deferred("WARNING: Overflow in clocksource '%s' observed, time update capped.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");
-- 
2.7.4

