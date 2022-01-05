Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA694852F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiAEMoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:44:00 -0500
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:7495
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234151AbiAEMn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:43:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dz4im564Ufl4h5tqk4FlfDNtlGEZDV/2fEXo9D6ddK5+xi7eTIYQtPkNud8Kga2+pTWVyo4KimBsHWdiOzK3JeSZku9HzO/9yyHBBCcjpwxTuXMYzHkh6dt+vX3ClCHAPXifN0LfEip/XnxO0rkProBK1dn2xWmS7s18R5t7hpXIBX+J2MEGvipcCnObkAyR2Z3jg2glZzWnjY4DZBgFK006yIc2EUdAKmMJtRhfnoZZkOCxNowsoJh4maU8I39vR2qsU+SXGe1CnIiNwHiube4u9VHZfeXh/bnb6BjwVVqsqticNHQkmSqgDezGOLH4tgSrAsPcHNcDZ0VUPD0uRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN+58AhILKS6ioR4TocAcVenr+lj/e8oodYT9k7S+ng=;
 b=PKt1wvo4X9kmQPd4AzoIFsqN5G/L2gPiqj0cFTWC3SR2ivg63p8g/n/iOWESXd8L5kvEOKvTm2irozgmpK3piTllYGtC6SReHrFwtVBR6UeBF0gIeD8srZ8NSa8qvGyZKdBkDjQZ1RVlGyLbJ219l/CbmYiT5i12LQXWCB2LQnez77vD5OMmf1bvdx5Eosf3uYUBRICh6DffBsrHlHsR6jsR8TUBJ6HMss7w8ARdqUlrDKa05Rjf01KOGJZGIgS2/8+bizk44JbdYE7PEjXa639N9uTO+vNS6k5Q5/ZfY4Nq/SBpW4Fu+gBq31CLclAOV7PMsWISka2shMtMl8rpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN+58AhILKS6ioR4TocAcVenr+lj/e8oodYT9k7S+ng=;
 b=NM5IEupNuUcIrL6OU9NWu1PIeLgphe7zEcYY/mZNY3GmHCDxcT34J7uc0oYy1WECVu5Hvjr71kCtPuCJuyxjqIjYwOgIfvF+F59jI6YFJp8j9Ewt3v4HRoX8p7WmcOYV/65HcoZsoglG4ZKwpCalpIEdCqYNNWP4e+YNNmjcE8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8494.eurprd04.prod.outlook.com (2603:10a6:10:2c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 12:43:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4844.015; Wed, 5 Jan 2022
 12:43:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clocksource/drivers/imx-tpm: exclude sched clock for ARM64
Date:   Wed,  5 Jan 2022 20:43:04 +0800
Message-Id: <20220105124304.3567629-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ab6a07d-6a4a-4dc9-eef4-08d9d04908bf
X-MS-TrafficTypeDiagnostic: DB9PR04MB8494:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB849451D059ABB35336EA9E9EC94B9@DB9PR04MB8494.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: be9y+4CVXnLwnooSBByq/EbcDP/z+/vDRY2cGdZGHjke2a5gKPZCIA8RGZjyZ9Ey/E9VJASuO1C1Vp7iu/lSJ4bZOYa447RgJDmRRIYsmu/wqe56gQ7dkkPHh0NvrFnm01rgshMaLxflzwZP/HFygf2OpH4+aQUEHifHStROOZapMKgkaPig1ASw+YxHHy3euKgvevaw8S0jIApSVmp7mYaRrE3zfxuf3ymfQ1IHNJMxEL69OB+4oYTFwDIn+PYVwws2Irh5/VAd4uzPTx1vvbBuMY4mJEiwt/xPvhaeH5PRlkF8T7rF5R4/zOh4yBbumKI/ypOpakNu63c3gniyNpeov/0G4GXZ/lHbtmDr/zi0SkUBfafXx6bhMEMyHGDz+8pWLMP94UKngz+bMfHmtQZZkTTQWmt3KNjBb96h/ER2BJ+OQGbHyFIn92lNbzUpQOfAqQJvJobMabVNl8N2T3OIAPrL1w/9PbR98fcSu26QL0yuJGGos7a3TSf3ucgR4N0ps577TIjORGjJ1IDTtGpNb89n2avhnYMPVlI4T3t66y76UnvglvxgENLlna2cNhPp8i4y51F/Y11e3U1zzcajpMozxBdWL6ivd3RbnYEK6g+/ijo03voO4+EEiy5hC7oeh5MEegJclnuDoQyueNcfCg1aqUA8JGx/GdryTq1m9rB3BPv6MlNTNgEkPrGUhv4Ms7Gq0mII+tEu+AuSZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(8676002)(5660300002)(2616005)(38350700002)(1076003)(86362001)(4326008)(186003)(6512007)(66476007)(66556008)(316002)(8936002)(508600001)(2906002)(52116002)(83380400001)(6506007)(6666004)(26005)(66946007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x8hEc8PRdziD92TeEFOfMAxE/v/OnT9YBnzwM8XVsgbHOhOm0UXopB9SK73K?=
 =?us-ascii?Q?RQz4xSOpY3FrGpXLy4xDP5GjfpJdiR/+eTNFd3Xy0Lt6FECe8ndrOc+qGktQ?=
 =?us-ascii?Q?3ujdBrgyiSVwrFzCGR5cWlEr9zgwTZt46LAXxR7rfnUQd3xSzYhXZBgwrtQS?=
 =?us-ascii?Q?3SmUiUj119i6rSfwpEI9J/gqaF226bRJn/I79ZYJkhh20PVMLKsAgEiMTuj/?=
 =?us-ascii?Q?PT2f6cZUQllR7GfdDyeSLwU7OP6/k2Lk5Zp+e2tl7lWI/H9F/+KLqj9W/p7k?=
 =?us-ascii?Q?q3iUxV0Hf0viziGppPx9ANwg2XUg7lhW9uTLloubTuPLtFVAK3kteheY1Cjw?=
 =?us-ascii?Q?K10nNb3YoLr9wObMCdRx1HRh7D9/OyN0sY8TM40uInGj+Sh9cskaqCg14YVX?=
 =?us-ascii?Q?Gt3RIO87hYg6KGbGCoLkHrsVIY1yjCpohcUzsEIkO5TQYp31ETMaK35dh9CY?=
 =?us-ascii?Q?vqtnekAi3R2XyUD9i3PyV7nUPFvA7jcZM5p6WkwF/mfrQlc6udkTbHjCDy5A?=
 =?us-ascii?Q?E8TNXOlo4pbA3tGONL3udvxIsPVlpDrEqdrj+zzPvAZ8yzev7dRir9lpglRV?=
 =?us-ascii?Q?YTqySx5BMprOKNQkmC1BcE9a5K3+2SkV1InYVqxZ82U5SYviu/R7khwhFiP5?=
 =?us-ascii?Q?PV1tf5EQEXG0NnEmPJgm/sUeXbfisCWjW3/Q7uLpynV5TnVcn5GK1rhb47XN?=
 =?us-ascii?Q?uhSLlvGmPOKmBYlpL2tiQ82O9zAO3NJa9+aZ268Mi4kMtscgeAe87iZYJJ8V?=
 =?us-ascii?Q?0aASxbk4dmGWySRDS/PylIv4Uk+ci5btg3CYIPymu6ZGGTT5OwdGNmbqwL22?=
 =?us-ascii?Q?bGJbzLELizPJcfnZ65C8zQbbrG3ny/FMfLfPsGunnUqQZ9tyCvV+YQWCHKrt?=
 =?us-ascii?Q?N/GdwFF4xFCzYd0l/cxZjIVHqpjLe8FM7yb83I4uMpvIeodjHQmxBrjSCRPT?=
 =?us-ascii?Q?K6C9/t/vH9fQi0PmwBuJf9qWFaKTbdQxj48LGZ7alipvnmx6mKmx3mHjnhkV?=
 =?us-ascii?Q?lN9vaDpAPBVIDKbJasOYKdo9WJIuSmqrgzofQDR+wDF42uMCyc9eq/B3COJy?=
 =?us-ascii?Q?vE/MqTrg0xDuk+iUp4a3dz8ZhJOjAcEltGPFry0pTsxkcKGC9Iw7pzw40dQU?=
 =?us-ascii?Q?/J1g9tHCLNAq17nWxWEuhiDfjjzY5mzG+XfDcjcyTlpazRUZ8ZPvi1FNK9Jq?=
 =?us-ascii?Q?GoHqXmFEU2hH3RNsDLUo79H76fxiYkobNUTG/L46F9N9rNU8dgP4Oqm1etQ3?=
 =?us-ascii?Q?hQTly45hb0qErSOVeOY0rmJAQUMc/h7MwGHwk4GSSTVdTMj9itUv47bdZsmN?=
 =?us-ascii?Q?v3uUrQo/AV6Us+iJNBSlV+Yua3qAjyOD7cckHVQ5CoMLKLyXAfJVwjL4ZK8L?=
 =?us-ascii?Q?W4USsfTmLf/OwncfdZYEOZFIbNvZn0isJcEY7sN94MkGkoCOfcXpxc5Evahc?=
 =?us-ascii?Q?eV6aRBpN9pKZqOi1eMrz4VIq5H00FaTcV9dJpgcgNBh5iR9Y5mQBUZtzZqlm?=
 =?us-ascii?Q?uGqC82P7apr9vhrGHfFidfLZ1Fws6/bmfnZo9Erq4Pjrie/DWBdSaQkWwn4r?=
 =?us-ascii?Q?/5QS2SvGt9diJfLDBITNs9v8X5ucTsCosFDB7UWDdaxmedYWoSKhYdU5P6yx?=
 =?us-ascii?Q?lg/wIzy/szjEPzIPdB9fAKU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab6a07d-6a4a-4dc9-eef4-08d9d04908bf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 12:43:55.1527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEP1+Skqfyf8X5kGq/PU0iNA924aiK4elCiiZo8ZiIN7ZuCKULbXYDzUlCO02L0ElUQzAbVelFiELexBLXcbJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8494
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

For ARM64 platform such as i.MX8ULP which has ARMv8 generic timer as sched
clock, which is much faster compared with tpm sched clock. Reading the
tpm count register in i.MX8ULP requires about 290ns, this is slow and
introduce scheduler latency. So exclude tpm sched clock for ARM64
platform.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 2cdc077a39f5..2bd530b9adc4 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -150,10 +150,10 @@ static int __init tpm_clocksource_init(void)
 	tpm_delay_timer.read_current_timer = &tpm_read_current_timer;
 	tpm_delay_timer.freq = timer_of_rate(&to_tpm) >> 3;
 	register_current_timer_delay(&tpm_delay_timer);
-#endif
 
 	sched_clock_register(tpm_read_sched_clock, counter_width,
 			     timer_of_rate(&to_tpm) >> 3);
+#endif
 
 	return clocksource_mmio_init(timer_base + TPM_CNT,
 				     "imx-tpm",
-- 
2.25.1

