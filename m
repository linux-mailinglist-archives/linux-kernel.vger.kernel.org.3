Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C7F46CF82
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhLHI5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:57:38 -0500
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:49359
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229489AbhLHI5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:57:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ProbgE2P/mLXuvP673sSOowqidODj0r7SL5+cTXUR+4RxV62efaD/EKslwd2w92ippT/i0/JKVzhxbtjYOg3rKgiN8YDjXOADEoXXZIr3G9iYbmNFMZD05vRxP4G88RFAH9Jhm3iQ3LwC/kMxA+2G4Kv+c6CVxOIzBO01t04DhAEX8yqDexTx94+nZ4IWU4tsuul6fjZ3RVULxRZabGxd4CJfrhyAZ0owJncdXPSM3oz7EJSplFyyZjU7QY9lJuNylDjqkqY+JFzfGVvQkOOo0I2/cyBVjo7zHn8pPKkhDkvNvx1c2EcsBy86AOink3lpwOtCYsCa0BggxKelC3/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FgWEcJ7r8vD8QGZJUZhUwoGuHG/xKlxUYO0lQs4Frs=;
 b=mzHFeE4G2HEBXedKFwsQBoz6gLIARnv96SoIxndgEZJ9k892fIVzhhrkZzfXkP9HkldZVnWv27B1xV2m193pNJm4sk73xkUj+Zdk1TEES1xxivcOYuEWZ/jh+5s/wUdu4o6rT9HfnUC8ZgZHip3587FfJAT3DGmd2faK5rTe+f42QThlp5k2ydECYirI4YWGeiACvdiJTvAwkZvCwLWiKUUjfX24KtppHgaGJ8kSVeLosTk9m4ZZeuJgNT+IJRljTTLoREtxudp7hVfAfn1UgWMVaKdtsA4cw9hfdLlgfvTmXkicpYVuucXbMvJp53aufPEvbnyxFqxTF6RtQKaaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FgWEcJ7r8vD8QGZJUZhUwoGuHG/xKlxUYO0lQs4Frs=;
 b=g4yqeX5p2vBh4jylccxxgYLETF+O6bADI4LGhwBriLKZKFIBS0+9uwuEGT8Wd825N/ChOmZ99rxE7OLvwLYrnXWDXFuO9nVjT52geicnLNGr8U+9Ah8FBB9pj5WKopOkHSO/8mdrDD6hZBWNodfw7s1EDIf+MLjmdDfyUFcuS1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR0402MB3543.eurprd04.prod.outlook.com (2603:10a6:209:6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 08:54:02 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::3501:ddf7:3e95:44d2]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::3501:ddf7:3e95:44d2%7]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 08:54:02 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: imx27: workaround of the pwm output bug when decrease the duty cycle
Date:   Wed,  8 Dec 2021 16:54:07 +0800
Message-Id: <20211208085407.780844-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SI2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::22) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 08:53:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d0d982e-ef33-4855-72a7-08d9ba284805
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3543:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3543B7B608AD2DC888291925F36F9@AM6PR0402MB3543.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTCGCPQflOIVkJ4sf+o5+3XnfLUI8EdEGIp9ZOtQHCphUYK+DPBTABDn2RgtyMtaEKwNcGf4WMpDjP8nxx7b88eEYl1PyfA50l+buXDVnkMFmhGj2hn/rD2QIqNe2h6pE//A0m9iP+GHkCXJaHpcKX8k+Hep4B64OKkE+CtsNPe7mT2WlL12U0XFxeik1BpJuUBbtGB855o5CqxV1YK++3itiTxwJejW+e1QZ6sFb3KCgH42oSd/ns78L3ZJZnjLDCs/2qNQXVs/G7lPKffUfKqqRFOAkRz7sNEB1H/4IRouYunBdIxW+Tg0yab3TO7zC5kfpWOiC4OfX146eZe+HfdKvbhTY1DT2i9sOmnlKAlA27XpU+NjFoa63goX7wVUJ/GECB6BenA1Sa45TmAOh/o2GirmHotJVZJz9WIWJ4gRo+URu51h8aQ4h2aOJIKsxtMAUeEguggVWLlblygiaWbBA0S41pnJeddbYL7O/uZigk/eNpljn6ZgACTiX1IFjjAZhwj+RJSYc7SN2LbV34OMT3lcL2t1qk/Z2tPJTbHtaVO7Lj0vyl4zHU3yVdGZ8xiEzDx2n1JWkoCrWLzn98mOcfqLPGlQQbHXAKSztcPZsg4JbP7/UFh6A3IL85m1EpoBR+z2JyUlYfjPzfXVkWapKysdfP/jgPhfeqxkIE5Zcc0VrjYg+xdgS90HPOkxJw840845N79oLf05I9c4cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(86362001)(4326008)(8936002)(508600001)(186003)(2906002)(26005)(52116002)(6506007)(83380400001)(316002)(6486002)(66556008)(1076003)(2616005)(6666004)(956004)(66476007)(66946007)(38100700002)(38350700002)(6512007)(5660300002)(7416002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JpVC4Ah3a+gvsVfC0TaOVRP2cCpudu9DkROtdnDdPy1nBBvYHe/Xka5AiheK?=
 =?us-ascii?Q?DSexucKPj76rHUYiQ7aognvOZq4h+rvFPGZwITbskv/G1u/nc4LLPVgnpBbU?=
 =?us-ascii?Q?O9OJZn9+gPjlEEm60Nenf2i/NYR9uMKGvBqhAj15KywDWv/yEbdXnFuWiX6b?=
 =?us-ascii?Q?b4iZ+XE0nH8qgvHEfXlWLlREjpfTWcft3uFAN/BkrJtl00XAwwRC0CGWaDSB?=
 =?us-ascii?Q?fqPxsPmDHs3BSkfwqbVs461kIldf9D5jqz7Z1N5GoUYS5ia5OacQovHQSN+r?=
 =?us-ascii?Q?VkptplCDQoqHMoOWMndQzm3ZDhNI++O6qLWps/ATM42P3CbQHfbv+pu/9xx+?=
 =?us-ascii?Q?jCKvT1OzuwynFzwx8j2F94Pw4m0dUyZU9V+5uXPgYbxQoIIILWkDCosvgU3f?=
 =?us-ascii?Q?N1WqgN4Rm/+liDbF+vSXAx8n8MSf8GWsfviyaUkrWL4ZqqHVhAb2XOouyLm7?=
 =?us-ascii?Q?H7clR4XkwHJiXhUEB2wuZ/YzsX1z5AvntGD3gKXFQGnG095ROb4GeaQ2BAVa?=
 =?us-ascii?Q?pSaD5EKo2H133+LjHvM/EJkYt3ENUP119v5MCOp0c7LEVzOYPjfFKrUdC209?=
 =?us-ascii?Q?G0PVyhOiADOj54/4rr/W9tX7e+Iz8cHY/xgXRX337lNtORA+vbhuIigTXjLd?=
 =?us-ascii?Q?9BwnuEdD+ZCecm+wQKehiZ0J2nHTZcKkFeFhnab2rtFfiIl150XLgQRHxOu9?=
 =?us-ascii?Q?2rJG0dG+eIMjXnbuKbTT7fbXj6w+0ZJumS5OQIZsV4kEDF8d/UfJ2eQ5pQrg?=
 =?us-ascii?Q?fbb491M8B78xJ4UZiAqpYRxdwmJvTmnrwMiseXXhk+C6+K1vOzpruXICO88n?=
 =?us-ascii?Q?CZe551fx+AySyeaKzpqFYnMpc/cZr58ET92fUCFh8W9ApwHqHHzep5uRG3ar?=
 =?us-ascii?Q?zyn05zloqSEkm9wdxZ5cPEGSCXOfk6QSykEAtIiKfNFUbGvPmX6OtkIgS7c6?=
 =?us-ascii?Q?Hm9xjDGvXoCAhY6QUEK3WZ3nf9egON45NJ9fSFeqnmBNhRWaT464PXHvWsrc?=
 =?us-ascii?Q?ugomeMUc48MdhUDBsgAE2ps/LUrbrGNYNd2GM8j6vEUYhpfFWYLmrH+kTVts?=
 =?us-ascii?Q?/3ufWaF0mrYV2l+DF4VY9ZjJ2N61TTKWisDPo6ldPRJfW2SY7hIx08ZAzAPo?=
 =?us-ascii?Q?leuQC0n6J/YuX9FfbOM7wMRJeMgfl0m5AYgv13PunjKqM3hNK3w6+YZ47JIE?=
 =?us-ascii?Q?xd0Yevb0sYzdQZ1UTCFUHNIWE7aj48UXQvErLbnkigFOiHX0rrBPrOCGpKiX?=
 =?us-ascii?Q?Y5bVuSBAXQmZjfNRlqoPhUdEwBZGxh18NfiODXX+shfP0mFjXlusrh+o30r8?=
 =?us-ascii?Q?GhCr9xnPsgfT1OWISMyMnFgjn+nW3DToIk8NVWF3xIEu3ZVYTjqxfXFmdD9i?=
 =?us-ascii?Q?7CND+sIJv+IA2B1ALiae4ly8LiDfOEcWtmjj4+8IVGZ5F4kLVX0mA0C/BVLv?=
 =?us-ascii?Q?QbjlrGt+mf/gT1EmsoRrkNJOUINu51N9bVX8g4BKM1t8+ifq5PUgJcf3KyZI?=
 =?us-ascii?Q?oCPgxnPOn2S8G3/Kh/d1cAOlfWZFWpQaMWsWgYxEfGrGWfmKVOltos6ibEex?=
 =?us-ascii?Q?vw7iY3/mqQpOw2ZxAu1IaWlZebcKUDA1zBma7erla+VhU66BfP9sHn8LCBXd?=
 =?us-ascii?Q?CacgK7lrsudq5j089XYxznE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0d982e-ef33-4855-72a7-08d9ba284805
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:54:02.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+03/VN8kq6umKbyLRbUNoYrgIdCM5iM0RBlGizn68V1Euq0XJMrhN92ZtnuFfpf9/K+iOkaCpj9v4KXPhywFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3543
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a limited workaround for the PWM IP issue.

Root cause:
When the SAR FIFO is empty, the new write value will be directly applied
to SAR even the current period is not over.
If the new SAR value is less than the old one, and the counter is
greater than the new SAR value, the current period will not filp the
level. This will result in a pulse with a duty cycle of 100%.

Workaround:
Add an old value SAR write before updating the new duty cycle to SAR.
This will keep the new value is always in a not empty fifo, and can be wait
to update after a period finished.

Limitation:
This workaround can only solve this issue when the PWM period is longer than
2us(or <500KHz).

Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/pwm/pwm-imx27.c | 67 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index ea91a2f81a9f..bd97382622dd 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -21,11 +21,13 @@
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #define MX3_PWMCR			0x00    /* PWM Control Register */
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
+#define MX3_PWMCNR			0x14    /* PWM Counter Register */
 
 #define MX3_PWMCR_FWM			GENMASK(27, 26)
 #define MX3_PWMCR_STOPEN		BIT(25)
@@ -91,6 +93,7 @@ struct pwm_imx27_chip {
 	 * value to return in that case.
 	 */
 	unsigned int duty_cycle;
+	spinlock_t lock;
 };
 
 #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
@@ -201,10 +204,10 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 
 	sr = readl(imx->mmio_base + MX3_PWMSR);
 	fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
-	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
+	if (fifoav >= MX3_PWMSR_FIFOAV_3WORDS) {
 		period_ms = DIV_ROUND_UP_ULL(pwm_get_period(pwm),
 					 NSEC_PER_MSEC);
-		msleep(period_ms);
+		msleep(period_ms * (fifoav - 2));
 
 		sr = readl(imx->mmio_base + MX3_PWMSR);
 		if (fifoav == FIELD_GET(MX3_PWMSR_FIFOAV, sr))
@@ -215,13 +218,15 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
-	unsigned long period_cycles, duty_cycles, prescale;
+	unsigned long period_cycles, duty_cycles, prescale, counter_check, flags;
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
+	void __iomem *reg_sar = imx->mmio_base + MX3_PWMSAR;
+	__force u32 sar_last, sar_current;
 	struct pwm_state cstate;
 	unsigned long long c;
 	unsigned long long clkrate;
 	int ret;
-	u32 cr;
+	u32 cr, timeout = 1000;
 
 	pwm_get_state(pwm, &cstate);
 
@@ -262,7 +267,57 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		pwm_imx27_sw_reset(chip);
 	}
 
-	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	/*
+	 * This is a limited workaround. When the SAR FIFO is empty, the new
+	 * write value will be directly applied to SAR even the current period
+	 * is not over.
+	 * If the new SAR value is less than the old one, and the counter is
+	 * greater than the new SAR value, the current period will not filp
+	 * the level. This will result in a pulse with a duty cycle of 100%.
+	 * So, writing the current value of the SAR to SAR here before updating
+	 * the new SAR value can avoid this issue.
+	 *
+	 * Add a spin lock and turn off the interrupt to ensure that the
+	 * real-time performance can be guaranteed as much as possible when
+	 * operating the following operations.
+	 *
+	 * 1. Add a threshold of 1.5us. If the time T between the read current
+	 * count value CNR and the end of the cycle is less than 1.5us, wait
+	 * for T to be longer than 1.5us before updating the SAR register.
+	 * This is to avoid the situation that when the first SAR is written,
+	 * the current cycle just ends and the SAR FIFO that just be written
+	 * is emptied again.
+	 *
+	 * 2. Use __raw_writel() to minimize the interval between two writes to
+	 * the SAR register to increase the fastest pwm frequency supported.
+	 *
+	 * When the PWM period is longer than 2us(or <500KHz), this workaround
+	 * can solve this problem.
+	 */
+	if (duty_cycles < imx->duty_cycle) {
+		c = clkrate * 1500;
+		do_div(c, NSEC_PER_SEC);
+		counter_check = c;
+		sar_last = cpu_to_le32(imx->duty_cycle);
+		sar_current = cpu_to_le32(duty_cycles);
+
+		spin_lock_irqsave(&imx->lock, flags);
+		if (state->period >= 2000) {
+			while ((period_cycles -
+				readl_relaxed(imx->mmio_base + MX3_PWMCNR))
+				< counter_check) {
+				if (!--timeout)
+					break;
+			};
+		}
+		if (!(MX3_PWMSR_FIFOAV &
+		      readl_relaxed(imx->mmio_base + MX3_PWMSR)))
+			__raw_writel(sar_last, reg_sar);
+		__raw_writel(sar_current, reg_sar);
+		spin_unlock_irqrestore(&imx->lock, flags);
+	} else
+		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 	/*
@@ -323,6 +378,8 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
+	spin_lock_init(&imx->lock);
+	imx->duty_cycle = 0;
 	imx->chip.ops = &pwm_imx27_ops;
 	imx->chip.dev = &pdev->dev;
 	imx->chip.npwm = 1;
-- 
2.25.1

