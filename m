Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C51478F09
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbhLQPHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:07:51 -0500
Received: from mail-db8eur05on2057.outbound.protection.outlook.com ([40.107.20.57]:1504
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237845AbhLQPHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:07:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htbpklQ0T/ziGB0DZkPLZDiNKwM+owTGDp8BJQW9u++BGHMJhqdMA6m09OedeFENYkP0hJjqKjHpRMz9zldE2I1ZQayyebkVa1ElhqfuMG3BwXODqdgmghD9C7vC00X/bKgUqA48BcJj8ucK8PtgDqiZHt+CZ4X4WsslemfxQtaN9XYOOddAdo9tExjX2tSwihKPTuc7mIVeg7bgylPayVxh1EGK2wqVu16G3c6VCdGeAXqBJcyU0NUyv26ZvxFampYEmuWbFg3pB4n+Du/ZwPouFZ08M1wFGG5MI5xtwTx5CX73Nx+eYisAobmWHPOJKeVZIVoDp/YABufOAIpidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNzsy8EtfauikCb8eQe74n3wz7ngV5GAfbclbHZSOyU=;
 b=Bs1cB0XMrLPjmJTlaic62RAeRfPbMuiV1+mXpqHzkedZ0HPZcll7nEjGjs0aFcgWGYDmQlHoYya8nMPKuKMLRiKz2V07Spw7pFt77FI6IWmxkth2ypBsyWyXnIoHi7BKikTV0/ehZtoOZ5Q+Z0uVuAZmx11M1UlHopk/vtIDb4bKKTi3KZJiaUlwL2lHzn2/XaMpAKkmLh0aIFHKYrTx6tRLVRacT3nyO1zZDG32ZHuO9OlNqlN+hbBCWMTHgl8hL/50lZIt6zXBKs9iB67wsF3nwnZ9ZLcg7/w33S5RlOKqVtrx2Uu6KLqOliVjUrvLcR9q84c7cJM3xei6HYrfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tbs-biometrics.com; dmarc=pass action=none
 header.from=tbs-biometrics.com; dkim=pass header.d=tbs-biometrics.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tbsportal.onmicrosoft.com; s=selector2-tbsportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNzsy8EtfauikCb8eQe74n3wz7ngV5GAfbclbHZSOyU=;
 b=kOLbimaNeNpYJbbq15HtcqiASfTRhttp48SdMOZ17dBb2cm265TN13ZNAFle6MARP8YzDjNjbz2Nuyxpyrk/Z0s4m41kGnTo0w16vwgGW4GZJ5e3fWhevlijkwldJb5VwmG/rWcy8YkVSZ9i8c00wk4JpOVEu6Vmc/WApT5NJhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tbs-biometrics.com;
Received: from PAXPR06MB7534.eurprd06.prod.outlook.com (2603:10a6:102:153::11)
 by PAXPR06MB7600.eurprd06.prod.outlook.com (2603:10a6:102:156::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Fri, 17 Dec
 2021 15:07:46 +0000
Received: from PAXPR06MB7534.eurprd06.prod.outlook.com
 ([fe80::9016:ebaf:8070:8f44]) by PAXPR06MB7534.eurprd06.prod.outlook.com
 ([fe80::9016:ebaf:8070:8f44%3]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 15:07:46 +0000
From:   Radim Pavlik <radim.pavlik@tbs-biometrics.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Radim Pavlik <radim.pavlik@tbs-biometrics.com>
Subject: [PATCH] sc16is7xx: Prevent dereferencing invalid data when gpio_hog used
Date:   Fri, 17 Dec 2021 16:06:48 +0100
Message-Id: <20211217150648.18119-1-radim.pavlik@tbs-biometrics.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0101CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::18) To PAXPR06MB7534.eurprd06.prod.outlook.com
 (2603:10a6:102:153::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07f4a523-9f4f-4d2f-1605-08d9c16efb14
X-MS-TrafficTypeDiagnostic: PAXPR06MB7600:EE_
X-Microsoft-Antispam-PRVS: <PAXPR06MB7600FE666867EF5CDF0B25E6BA789@PAXPR06MB7600.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urdR9LOpF2C4Z24HQ2LMh9J6d/qJVlNnWEsetZS1SARIwNXXLw+obuY813de/U7KJiBAI/Ij3pv3iUEsrev/MMmIYXe2JoDPHrbyL30hSBX2rPCspIX3jt1gOETIgcAk24uFzHFBumu7WfFzsqww0zxSICVfISTrltOo49e3Pd9cjS3V7CLJdYBUaNxZodDcVtf+iyC5vuhSbFzAGYIopprMCrkVHxIlYCcR6JLjy2H87Kth5dji8SQ320Iw4eJgWOA0AszhHdu80RLHoI5ch2wq2X0V4CW8Ebn8hNMr+bYFW5IxZreBKTIG6VEehVxKSwBnSBtzVqp1+IZ13itCp+sZpDu+xfmA0RvfFQ9RPmLxmKGGmzuc0JpNPvnCfuv/rdNtayM1E3pZ+8JZDIW/24YZ9VsiPUaPspYOnub+jMpDmBwPxx4aMQePUJq24bi6YfgBDHyvnVCuKWWqO65Dv18V9c657mdgxy1rpHTbPH4WdzrG/g9zlj8NJlNQDVqTiSwhvB7il/+6F1K+t11JFJ+mTVEwP0rFZ383bzlwpLTngmj9BSwDVL63IZC8zrRglW0iF1I11tVLUXZY0670HBKxXY/Di72cOZhTUYKYmMqTo1wm7k5eQ61PwPtgrEx2v/b+8rWPZnnzwiT052oBepboo01I1HTWshgbB8AG0JFzwz1NR4V00M9KlxwoaQ6/jv644bYprcypsewF/nbKmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR06MB7534.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39830400003)(366004)(8936002)(66556008)(38350700002)(36756003)(107886003)(316002)(2616005)(52116002)(186003)(38100700002)(1076003)(44832011)(26005)(6486002)(83380400001)(86362001)(5660300002)(2906002)(8676002)(66946007)(110136005)(6506007)(508600001)(4326008)(66476007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+bIFGS+1K6mVudEcptBDC8FWDgZKIVqAwe7xi0KsRt00g/8xJvKXmz+CqvBu?=
 =?us-ascii?Q?OlspRsYMhutgEqjOni7XoTeEgkNwiHkkGDV3nhu306YMqlaia9mI/XUxkJx6?=
 =?us-ascii?Q?5f1e7gThEkCvHhS31mD1xwzH5Tqhhn27Lvoa0IYxw/SVvA5vk33gGS7g5rrv?=
 =?us-ascii?Q?EJDW3rXo7gtVsU1xEoOm+Qc0ZXp+XQo1oe3ApvZmB86mLEkHe+c6NHX7a+jA?=
 =?us-ascii?Q?x2ze1XymssdPhFTheLlW3wtzaRz1tdTEcqpBCdxp71X2p8dKfq6SyWCW30BU?=
 =?us-ascii?Q?EbfSP+IbdNqqjY0QmiS3yRu3ka1Aq326BWpTZYo8Ln24eGNdIBYVsks4dfnj?=
 =?us-ascii?Q?VYRyr5GXixyxLeKl7dQ7kYiG5wITJv7Wm3LAbP80GotUdM82DOnBEYspSFp6?=
 =?us-ascii?Q?BDsozf905tpcUnp8m8pqUnwZ0tS8OFMADXKlzFBd22YoPSA+CDRA7KD9sj9O?=
 =?us-ascii?Q?iAppOFyRvnJ97pjbgsi9MOO6MSoKPJM0ilG4ijbRnu6xTrHst8jLGNHu2PFx?=
 =?us-ascii?Q?t4eUistZIYVHCpHD2YSAKSCVfLz54ReP5KjRHC/0VQS6qrI8E8dk50+N+lVP?=
 =?us-ascii?Q?buJ9wS3AeJ0hxlXkCdgZk/hZ5u7E9GK4y2tVtKaxMexkwXAEJzVCZXLjrzGi?=
 =?us-ascii?Q?vBNQ7kpNuBM3rSa5Bb7gbfL2sbJr4nwfD5wnq9lzsg3u4LP134+FVAnVmxGQ?=
 =?us-ascii?Q?4YcdphEXVwSWwFHE3RSmBKLRN2T5cEqRYDW9hRpwzJFi3lItvYxbdlVMwliU?=
 =?us-ascii?Q?awEcDp94D5BdirHBS9kmVNmp0flRUh5M8hI5XXO6jq9vySEOqnbrpXDnv4oW?=
 =?us-ascii?Q?y4avGpvmsRQmypnq2R0KOJLhOezWEhnXb0SZcSc7Si8664wtto3aEO6Ht+r/?=
 =?us-ascii?Q?Uz3G+HY4St0XEE9FuF3n5qqe1oASm5eILyaqEesjKSfo5Fpqg5gRXhqbsnjO?=
 =?us-ascii?Q?DVdoraKH61YQuLwZIvGuPSDl49n12lgJXW2nnztosYR8FnKnh4W/ndis05B3?=
 =?us-ascii?Q?qKe68lumLSJ2sXfbmRp/nvWImbKXTG2Hm7j4D3tOP8RIPm8pS7UP3hWuh0lH?=
 =?us-ascii?Q?iCCDWi+qxQ5JuHB0FDERD7yfVAOBGaHiIoDlX1ZtLm6glxNM8yiop+UkNMaR?=
 =?us-ascii?Q?N68QJf/cV4Yslti/OHOqCAwoBz2pF3p7FF+HpdcjXCbNv/fhqr6RFLp5z5v4?=
 =?us-ascii?Q?dIlIf6W10SjsU9qc5iIXEjp2tzimJ4FLvEo0GqxMh1GcnAgBxKbhz8Rq4PFG?=
 =?us-ascii?Q?4DFwUMqdrYSATb1JfKoMOJ6YT/MZOHqe1wvuQoFNXwXa7JBIOKTJGtdynaSk?=
 =?us-ascii?Q?xt6NsopkfgnoAT3Ep54LVLiDuUQrHcLQQKvoLf/MHLYXzO94THFL+ZWAIRKC?=
 =?us-ascii?Q?F+fncw0Z6mOLlOrhiy9SDrKdmXJbDKibmTIrnpG0eB/DpU93lzt74PAPmzar?=
 =?us-ascii?Q?7wGSFVLuJy/14QZFsB3R9WbhHg8CQifWo1Ax+TnyUiRk/UUyl+mVOVMV/5eF?=
 =?us-ascii?Q?MeSxLRaYQaJw0JIYoFAQicRnbmI7fHclqg9Vz8sFDqHA4tgVy9zW61ZWWEJG?=
 =?us-ascii?Q?2NcAsa2pg/AI8smkI78Gko8M5ZMHoguUV2zwDgUHW3TJ09nkrhSJP1yS511r?=
 =?us-ascii?Q?TyBmBbaxbaUvHSzVoPnEWbtMIiZnFZNcO/+uAU8vgUhpbpmdj58N5tML6/lB?=
 =?us-ascii?Q?mwypuA=3D=3D?=
X-OriginatorOrg: tbs-biometrics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f4a523-9f4f-4d2f-1605-08d9c16efb14
X-MS-Exchange-CrossTenant-AuthSource: PAXPR06MB7534.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:07:46.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03c5283b-bdcc-41a6-b827-b66aa8b838e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1m48Ke1DCduDCEzmOentZbPrlD0lB6fvSMZSIcJtShpNIC3ccaVzGA0agQMQYb4qYD9ZwpfmMlTm8oCYjQgbhBGIi70IQunIIKFsm4SD9PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7600
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio_hog is trying to use gpio functions during probe call.
At that time we dont have initialized port data which are dereferenced
via assigned gpio.direction_input/output functions.
This results in unable to handle kernel NULL pointer dereference
followed by Kernel panic.
This patch prevents that.

Signed-off-by: Radim Pavlik <radim.pavlik@tbs-biometrics.com>
---
 drivers/tty/serial/sc16is7xx.c | 38 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 64e7e6c8145f..9f4c5d64fb10 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1242,25 +1242,6 @@ static int sc16is7xx_probe(struct device *dev,
 	}
 	sched_set_fifo(s->kworker_task);

-#ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio) {
-		/* Setup GPIO cotroller */
-		s->gpio.owner		 = THIS_MODULE;
-		s->gpio.parent		 = dev;
-		s->gpio.label		 = dev_name(dev);
-		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
-		s->gpio.get		 = sc16is7xx_gpio_get;
-		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
-		s->gpio.set		 = sc16is7xx_gpio_set;
-		s->gpio.base		 = -1;
-		s->gpio.ngpio		 = devtype->nr_gpio;
-		s->gpio.can_sleep	 = 1;
-		ret = gpiochip_add_data(&s->gpio, s);
-		if (ret)
-			goto out_thread;
-	}
-#endif
-
 	/* reset device, purging any pending irq / data */
 	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
 			SC16IS7XX_IOCONTROL_SRESET_BIT);
@@ -1315,6 +1296,25 @@ static int sc16is7xx_probe(struct device *dev,
 		sc16is7xx_power(&s->p[i].port, 0);
 	}

+#ifdef CONFIG_GPIOLIB
+	if (devtype->nr_gpio) {
+		/* Setup GPIO cotroller */
+		s->gpio.owner		 = THIS_MODULE;
+		s->gpio.parent		 = dev;
+		s->gpio.label		 = dev_name(dev);
+		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
+		s->gpio.get		 = sc16is7xx_gpio_get;
+		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
+		s->gpio.set		 = sc16is7xx_gpio_set;
+		s->gpio.base		 = -1;
+		s->gpio.ngpio		 = devtype->nr_gpio;
+		s->gpio.can_sleep	 = 1;
+		ret = gpiochip_add_data(&s->gpio, s);
+		if (ret)
+			goto out_thread;
+	}
+#endif
+
 	if (dev->of_node) {
 		struct property *prop;
 		const __be32 *p;
--
2.32.0

