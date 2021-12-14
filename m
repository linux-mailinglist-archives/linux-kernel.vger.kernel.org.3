Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE0C474214
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhLNMIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:08:37 -0500
Received: from mail-am6eur05on2057.outbound.protection.outlook.com ([40.107.22.57]:49505
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229673AbhLNMIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:08:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D52pbCBbK9FiZBVFEY5EiIERTcHTMbkas4MEXGmO4occgGoMtwNQKtW3UVy/6qJDjQ14RVyWt/9BUuSjRY+Txu6eY1FAO6GxHgxGxLfgyW0HTtovEtMEe6gIDt5wqfUVOPJaJBoGHe9bUT4bK1bA1GmeEppHkr1TYWa6h7D5r9j+FpE3lH6hQKDTae5xOs1cbO4d9szMd7NpFGA+AyvouqohXtBtY5pcKW8LaGJ5faQYEGc3QWBqLWWlpwYauoPlGwZdG+SwHowIrWryovNjN0cogok/V9kkUgXKwcEuxUM0+smBSQum08vWU5pL87xgxzuTwfQmc4W9Nykor6rSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73YA0HGyz3pyZcnqOJAzjDmkrWgnSQ0MeuuLiYQcTso=;
 b=T0+3Rlf9PWcMzHIPSlrlaVxuKmFb89Gk7Ingvp9RZorEMyyQcgT+3iwhBhikwzouSWo63if/9HVdxcByH2QY60Qu6gdZ8Oyw75W3L616My4obTgkdeHWUdCXL1JvugZQgwxu7ZuCilsi8WlNHpH6OT1fuyt6YunanUjvInzJZYl8p4PYdrDJ/4nwQ7oKSpkQyBrFzj9J2E6LRW5toEoxNPLcuLkjhAynX8yVGazO0A0HXgPLvRoJPLWNBCIrVcuL25nZZVC2MEVqh95RCi24xyWhg0CSOJ7BlGBTr/Qd6mUaXvZiiF0UouzOFgZZR+oNq03MtqpBRX/QFIo+2L3Ikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73YA0HGyz3pyZcnqOJAzjDmkrWgnSQ0MeuuLiYQcTso=;
 b=hUQ0QNQIDrQynOIbR8b2gCinyb8eg8B+VtucAbfdX9uIvJeTmaxl91GSTJrhvkOe3S9lK1d2IN/FVhqbOuIMVw/cCw8Z/dYTndApe7G7S3Kfni2l7qznk3OeDOokgpv7Y/4OEpKBLrgfEKLd95RLZrITKoQOWoWX9fhwk6DqlDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8447.eurprd04.prod.outlook.com (2603:10a6:10:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 12:08:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Tue, 14 Dec 2021
 12:08:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/5] clocksource/drivers/imx-sysctr: drop IRQF_IRQPOLL
Date:   Tue, 14 Dec 2021 20:07:33 +0800
Message-Id: <20211214120737.1611955-2-peng.fan@oss.nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0249.apcprd06.prod.outlook.com (2603:1096:4:ac::33) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 12:08:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 739e445c-6522-4de3-cdfd-08d9befa72aa
X-MS-TrafficTypeDiagnostic: DB9PR04MB8447:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB84470DAA6927E3A8C5503F77C9759@DB9PR04MB8447.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1RAjceiDZgsRLVOUQP24L8N/gFE49LWVNeKpGmvFS18FMo3mK11oy/XTNu1xTmkB4mhXktfDOmTt1q1lxt0EWwRObT5Cc+maPjakiDeuHM+T92nmX3M5JaQz8cifEr0EsEq6WYwt8IzdkkL1OuZRmpxt43BHKWIHU+8zqig9ZQBVmTRK1eIPO9bITBMwdjja79rOBPGXBLabi4KyL3WyUsN3Pd4X8FRrmJgXptUdcB3PQcAYg2cJKF6Iur8KzmmMIGaby1V/nozwW0gejwLVh6o8SVLklV2orf1o/1Sz0dUuWWVffGCy8DUN+sW7fpst/OjHVUIVZWHJZCKClG2vWWqkSO24UQbYkcImskJzEWBPj3me09mgPPel2RpY2p013J3VrgXRSylPNVJCBx1NnxKjMTC2zUmF+gIJZHXKIi6EEVOn99kV+hXs06oK0WSbK7U+TgSaci9YNnST8y0kPWqCtoJcJXIb/tKSfYDvR4687ciPG/k6F/8iTVmmTXsQNVAwBFWMrM0pnkso3fL8EagclvxIsFRqojygg8ipeA634ywHefqfXJQ4RUF/JJbeMx2avIVeG6+W0BXONArdrw2ncs+Z4poO/KmW7kyHe9GVvOHG5zqu+nahJD9HObDVIEgAK1/sZm+ImUaj95pp3ujEhIJHcm7toN2TdQ4rCN11pN8WmfXg8jWB/wnPiJBEv0DnOtmcJWy3L7al3eqJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(66946007)(66556008)(8676002)(508600001)(66476007)(956004)(316002)(186003)(2616005)(38100700002)(83380400001)(86362001)(6512007)(2906002)(6486002)(5660300002)(26005)(1076003)(8936002)(52116002)(6666004)(4744005)(38350700002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SR2Jyj0nwrpQWYt/GA1Uq7V7l19p3Bck4NOGZTv+n33aewSQS68nCaFE0Rd4?=
 =?us-ascii?Q?cRaRlghCLPKeWIiZxNOe5iGMAP3+HDmGF9sA4NB+8lFdhqayXPeTBVUBzYDb?=
 =?us-ascii?Q?mz5hCo4xYIEj9gW8GHDHjtf5HjHaUjKZSklJpk+J6M2a0//OQ2VPj0L3Psg5?=
 =?us-ascii?Q?RNgIgfYMdwbWN4dOVhwPoKuXhMg0x0dWqHVDnfxarcUArzMf8Y5ZAGD31+Y3?=
 =?us-ascii?Q?GlqBxxMJ3WNDF50hV+KtEYI26va6aLSsECF5JOSZTvNGZ+OOC90GfLBHw/5v?=
 =?us-ascii?Q?nLx6D8UehvAzQbM5lK04HoHHMzzVduMP/rosvp/lj2eTWIsMlMQNWOtoAPUU?=
 =?us-ascii?Q?QsSu2fvB4zbu0fyTkd+2RpjGb5wlCx8XcSVhyo8kH4cnJFJDQcNP2QgI0vtH?=
 =?us-ascii?Q?In/3UDhJXhVMD07hpySRTZ9M6L56ztvVLrFaqsobdP+zDFRMdMQAhttqmbDz?=
 =?us-ascii?Q?M+oUnWFmdjzJWTyrHripZkynvBW15i9Q1ykphGWJysyLsRsCa36jD1MBDVNb?=
 =?us-ascii?Q?idIR7mzpr29/f+K8RTlhintJWQ/POt7RMwceubF6hhIl/S8yA5sSLr1pXTpa?=
 =?us-ascii?Q?P1BN67uKFfVkwBl9Byx2NAbrCbg6OyOXJndSknWkK/dVLb5wBjjpmR2ONZU0?=
 =?us-ascii?Q?LLUTNSR3G/dTs0mMY5HaCbkBoqqvVuWuQd/coI1Bmf7kRfNIoEEOOMTkEqri?=
 =?us-ascii?Q?8zHud/viduo//lDqQfXFJWZTw0AsWTfFfHgVJbTlpjmO4VY6jSYt4eYo86Vy?=
 =?us-ascii?Q?gTj8Vtt5psDGyu5u0pXsG9nC3HhXdxVCoACDNbf1DVmM205vNfNXivoZGR3e?=
 =?us-ascii?Q?iKmhWVA5Fc/r/hkKe8HHSJ2+qePTAHtN3v26631jRyjz3KN7Ug4i0/0TqS45?=
 =?us-ascii?Q?o9t56C+ObXD0AUCARwZO/3FQP/aNJNL9b+SKwWuJszU+KLqbzpTrnvsz/TYA?=
 =?us-ascii?Q?2lUkq4OXAufpy47wjGG1qgIYWNSMzAU3/9MaKEyNoKdJa6XUPOQ1jql7vVrM?=
 =?us-ascii?Q?ao4WzXR6VvIHShT28gZXooXFrDKyDB/Vg2oZbfRM/TfJJibxBCVzf/uKcuE1?=
 =?us-ascii?Q?lRmm1s0VBgt9YH5OC78gHUw7FaUtpTdRWHRTBkkX1PNYwm0R47bfiK6r/Oik?=
 =?us-ascii?Q?XZQc4OQFrQdwvcRAsAVdC2P29hfwNb7b0J9fzzaUjv3pfIzeLc7fCCj/u4PI?=
 =?us-ascii?Q?hb00+wh8BJjAWPulZHMX9FAjLMxBZiwc5fra7Ji22tqkRXZD4J/13r7kaoBM?=
 =?us-ascii?Q?oPbtI+OHMJVWo6iHyzCZoMiWAcWZ2rQriTwHKbc7kseUmkjst84g+EjAQg+E?=
 =?us-ascii?Q?5LGOQCFQ9ZbtuZHD+N/dB5Se03I9iWY8a8tV32YuQk9wQMBe+3rUAPK5KOnK?=
 =?us-ascii?Q?dW5ri5FVvpL+PIg3/xDdbxLO+9db2cs8rUUNrIKzHDaYF5LxBBVeg9TRX2xI?=
 =?us-ascii?Q?Wp6EprhoVZ9KmgMOhD/Cwplqh9hypkR5SfWxQvKnUHUCQ4TPOLmSkQ2ERQiv?=
 =?us-ascii?Q?0p0aLo1OOyBk36uSCFeoxgFY7+fz8VH1GSK9GAIhPyvFz14pyqpYCC6S2YCd?=
 =?us-ascii?Q?seUX1rurSvkauQ2pZHcyTfjq0EPxFmniZuLxdYWg7kt+SCsGqGJxOCGwwT3x?=
 =?us-ascii?Q?o/28Vg/AzE1d01KhZNeMTy4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739e445c-6522-4de3-cdfd-08d9befa72aa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:08:32.5688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DosYdA2nVI9WFOWIJHrwRGHKQForXsTkin6o13KbJPagVTBx6PeFkbboRDXeny6u+qNxcVbHatj8ocC4X0tbPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8447
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per the Documentation,
IRQF_IRQPOLL is used for polling (only the interrupt that is registered
first in a shared interrupt is considered for performance reasons)
But this timer is not sharing interrupt line with others, and
actually irqpoll not work with this timer with IRQF_IRQPOLL set, so
drop the flag.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-sysctr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 18b90fc56bfc..31ff8e06c9d1 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -110,7 +110,7 @@ static struct timer_of to_sysctr = {
 	},
 	.of_irq = {
 		.handler		= sysctr_timer_interrupt,
-		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
+		.flags			= IRQF_TIMER,
 	},
 	.of_clk = {
 		.name = "per",
-- 
2.25.1

