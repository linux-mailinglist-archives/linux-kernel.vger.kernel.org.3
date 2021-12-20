Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E686047A568
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 08:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbhLTHbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 02:31:36 -0500
Received: from mail-vi1eur05on2057.outbound.protection.outlook.com ([40.107.21.57]:29025
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232273AbhLTHba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 02:31:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+U92GFgDZN7UYwJLq0pzRrwSnzc/idLdV2sRaUc/pQQ6ffRNqGquOGwua9l77ZpjbCKjRrQ0ARBH7nksyp0rm0lLmeswMxGdosAIEyxiLwgl2F4Dqlx5GWiL0uSJiqmu9s83YVnOAWlZ+TGE0pm187h298s+CkcTcaHHCCZaruqSbrQnburJ448WnmIHKEJ8jJjropZw/Cbc7tK429DIoSLjc4hu+vlZm9A4HUvUW3Gr2mHfncluOQbDMcRt16nY/b49vt8uDN4glNACc//Fq8Rt28SMVSWpz4zFlTQbN7q876mjLho/cjYUzhxSVuz0n/VL9wTAxDHCsmD4vRcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNIjUfZYiQXlwyz6NkbeqhC5eXSvMmUTC0atW4fiKHU=;
 b=eZW7++WNeZbaqWYiGQDvlAIvFaqYIMJJkfISdxBz7Q+zb85HRkNOTWb7y2Yw/hcL47gdXsA+kfYdjB1x791vbeJfDMLclH2OKTlN1Z7UiKD3cIDplfQCm4EEeXAKdAwpiUwu6kD2TW8NXll0uekb5wI7/YxVJZqqI4FozkSs/Wfr/XN+l3miq8/fOdzuc/70HyD51L/wLp8jEro0VoENUnGfJ6RCB6mZ5uYV8ldQYaKOGug4ReGZH0jJMV7Epar2uRUPnxHa01P/tiTIFbriDy67YckQKm8AC12CPZ2sc9b/4xEKPQ1SAU5i6iENcQozavdFc/qJHcHJW46EwrVRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNIjUfZYiQXlwyz6NkbeqhC5eXSvMmUTC0atW4fiKHU=;
 b=q/7D2/ts0Sj7HW4X8CcociF0DAlTM3gZ/Or02hHDswj41RmQ6onW0mT50tFSQTRYLjQBDO9gabS7Y10ShG7yRjGm27Z23WLwMC4I/MK1/unRf6FnV5BdGO11NcbXnOVs3WxLCEYQHScz3CPx3GhRA6Z2iD5cVRllw2tC92WK3+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR0402MB3544.eurprd04.prod.outlook.com (2603:10a6:209:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 07:31:27 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::3de3:eaba:ee6:c061]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::3de3:eaba:ee6:c061%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 07:31:26 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] pwm: imx27: workaround of the pwm output bug when decrease the duty cycle
Date:   Mon, 20 Dec 2021 15:31:30 +0800
Message-Id: <20211220073130.1429723-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 247a7ef7-d53b-4070-993f-08d9c38abb41
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3544:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3544948EB795D8A57C64FD36F37B9@AM6PR0402MB3544.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5m4YvfzseJP/wRldclF3OR2zseX5DERarjSsqnYsWpCyBxZhfn6IisXyBagrfWPAbIAWg3fzVTnKanDqaBIvLkxhzLbzLivMKf1fcRmBeSMt+nY7zg0gAIEbkwZjn5aTeJVZe7tELf2jJQXvpmY4Q+BcgfIHMrhNwmdF69o2gQvoj56e6xxuIhmD0Gyt4WIOj1G1ezI270ZEaReX3vXVDVPQbiHizXOMPdLBLesAgUjHgJWYyrQ5jkX1K7hCDk1yRFvREM4euhvd5H2GmTZanJCyiThbbSAgFqxvItOQCqSdDhOsih2h6IF5zVehdKe/WGdQjHTMrW1kQGzU1PsiH9AUiwX4OeEed3wKflqr6YfBfIrlley1qB+j7YIgMrSEohda9X/H/zJZLQXl/O+uF4Eqf2yOLEL3i63AzP8O9usjI8zDJo7rubkt/PsT3nc9ALFLVi1Cb4oY4x2Ar/yl7fN7KKPrZd+R1wo9CEjbs29OShWIrt4qSAB63dQo75G2W4tyWj3pr+1GwacLiEJQ+4Ok5nBA4XFFpxafDjBhSw04TRL5PEE4LSw9WF3V97GcYyZjKeAL38bQCOw5PNut8C83f/VjBOvjuc0t7NZwigtSvjf8cHQTyQQrrNefBqdYrvJSWax5E34MWwzFJEaJEPY8v1eePCNW3hLvV2wImVJMhRrywR+P9iOWiEziBwImR1V+b8XzE+aJx0YKHalcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(52116002)(2906002)(4326008)(7416002)(66556008)(316002)(186003)(83380400001)(6666004)(8676002)(66946007)(26005)(36756003)(6486002)(508600001)(66476007)(6512007)(38350700002)(5660300002)(6506007)(8936002)(2616005)(38100700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GsOgpxnqDhyp2p834uUI8UHd7RTVi3+46CNXfubNUJZfoMGCc56jhZdZae13?=
 =?us-ascii?Q?xRk5vuXTkYeJ/hnBtaZTPRBsTGoI9y0bVW505Fa7RIMYVsodKOayA+HPRF1L?=
 =?us-ascii?Q?+OMKIjZ5HhwaYhOGBu9WKNlT2Lp7ZsiP05/S7UVa12cguuvdBA2uW1eyee/4?=
 =?us-ascii?Q?RQYAenuxwLSuKtFKW5KxXD/BzSfYzXZx/7acqg5taWrh2FdSJvURz72VC45F?=
 =?us-ascii?Q?3lk/4jOAgO0rK17270BBtY/Csg7qSDcle1BuZJHYklmRKEuKkGmrzJ4LKMkm?=
 =?us-ascii?Q?JdH5ymHO+ZwubbajCROug51XV56HssTgmPfD12TLN1v2DkbyRtFXqZrtwRTk?=
 =?us-ascii?Q?o/q18lc0qque4m4+MUivKkONIPLao8mmEAgnbFGz/vxQ5Azpyp0+FuzTZIEz?=
 =?us-ascii?Q?b19qhCR8AbMVMSmR0UyOaEwa5dEqmqdOBZLsNUjhxYGdX65Kvxx43Vq3a3dS?=
 =?us-ascii?Q?0ecfQs4B4wPn8UR2sr/cb405t4zV/trW7htKyYwpp4QoU8DUli7CRCYkaB8H?=
 =?us-ascii?Q?MO+LG55zV+NSEz7VW0u7F3knQZzEPDLUu2VKPvOOHShQqrRPOU4TlIx93Qfv?=
 =?us-ascii?Q?wri2CQjjKDvtu2HqXyWNS7STnm6ADTbc3gA7TuGIVvnEyP8jhLrdBV02eZkN?=
 =?us-ascii?Q?Buy3mQl9F7wwsuD0jD0DFvEopdOd3HRSxGNzfstFGjb4R345h/esgInXtxwZ?=
 =?us-ascii?Q?1PE77DdD5nLTgtK4mTmxjkF6vDiNy2d0iM/Rvto5+jEHQFC82crZTkKfXgjE?=
 =?us-ascii?Q?g6KXL2MaryoXwwRhzsHIpmchwOldCr6TR0i4S7VfTVD9Mc0T2ft2e1yxJ2+y?=
 =?us-ascii?Q?PrzNXhVmHwd7O0P+zUbK9UozkZdDzkOa0qbL1x5Aw7w3F79oL0xMGO+1uRbc?=
 =?us-ascii?Q?t7sraecKQLGWzzKvjQ0MvFVaoaEF99HB0MkbAx6Fzw0AYRLmMq/8g2G+hMw5?=
 =?us-ascii?Q?zqbwPSPpiFRIOy9wypfJDyIhaooDLzuldV+U/iCzrnsXBxwUVHJN3lb6Y0k8?=
 =?us-ascii?Q?5wi9EGATdjaBSjPJheq4pFiLvY39s+GufCjkL1hwQEwAP4aKpTJB8JQZRaFt?=
 =?us-ascii?Q?rGWDXKSHzG3wNCMvdlMNgJ/n0GmUNfxT4NFOwlXDt/48HYdYUbmz6pqia5w/?=
 =?us-ascii?Q?tF4x3DXKBJJKcJx9OU1AZXowMdnPsg/9gkxvD2Twlni/WcEeilHBnaM7VTfJ?=
 =?us-ascii?Q?wmDCtW7iXXrTDcFHu6CAzHB+sSnVL2oGjaNSjg/XiOIc5GiVIS2h/Z1sbaVx?=
 =?us-ascii?Q?+4s5FlH4hhVsNVpUBX6FHHM9iizHzgYsKCaEbx65KWDn3xBLdUMALUG64Azj?=
 =?us-ascii?Q?4RqBVTY8HY9CxqEyJYtbspsyCkRp1px9fTtfl7EPSO3XZGvCRh4e9MaMmcnP?=
 =?us-ascii?Q?5da9xVEsxy51L5EIPUnEnb5SnqC1W7VnenY4DGjFJAYQtrWbWwHE0ajp2c3x?=
 =?us-ascii?Q?I9p6+URrnMPp3bZxzphXh4MrPil9L2VIMQlDkIhjkjdybfu44Ia2dvncbT3G?=
 =?us-ascii?Q?lU3caCezJ1phvidME4nunOgLtsiq4SbXmaVHos317ZPFabI6H/jmd9fEsmt6?=
 =?us-ascii?Q?O/P7tHJzLh+KD7bmdmgf3bhQMQKK+/j8teWeAeQyzvuqo3K9ksO0R0Ewgv1O?=
 =?us-ascii?Q?/QY6diPPjIlwiLL2nV2uMMo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247a7ef7-d53b-4070-993f-08d9c38abb41
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 07:31:26.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3g7ZgPso+iJWtpeKmgMAY7yhfla3Lw3U1TEiV2D1hevoew6y4YDEyrLgff3FY/jYgoicDbWnNAatyhwksr6j2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3544
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
V2:
 Fix the warnings when built in riscv-gcc, which is reported by kernel test robot <lkp@intel.com>
---
 drivers/pwm/pwm-imx27.c | 67 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index ea91a2f81a9f..3d9ca60e2baa 100644
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
+		sar_last = (__force u32) cpu_to_le32(imx->duty_cycle);
+		sar_current = (__force u32) cpu_to_le32(duty_cycles);
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

