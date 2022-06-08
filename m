Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82E5542E4C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbiFHKt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiFHKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:49:21 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0600843EE3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEndmwzVYu+N0FnkPVuNiXdW0h1eLMSc4qduE28RfXvg6hQexdcKMwbFzAzQZtxNPe6RajK0CdrZjUF8orZQxZUS58tDQlcH5MbIQSV8gSBHT2PLBTWqqiUrbVoQ3XKS0pbGOfuzfCh/9kZZbxfURgGRpdEfeoSotU7gC2vKIM17mf1BZPD5FSZ8cU9VmEt3hylaYAxjEgdKGmterOlySN6L5s+KG+75WThzvc7kzAB+nrtALOcE6RL2rD/EanNtkzyFVTvYIQGq9deVjBbo9TptIpi6DlMa8ZCLbPlSUtIcqSw+Ktlv0GYuLObOYXVCTWZVqbkFCjdfKNm9KxYVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsRXW7xtv1bAxTm0xBCzA5MSUAkJG+wbwzO+2VgbD2k=;
 b=YgXWLdgy/sfEbFnCichmlHHFHfBKGdD0zdQnapPyh2TPlOVmCFNLfYcWJbLiLClfwIKnJ5qIPvjwXfC/LGOr6AlNzohi3QRy+T96U52qmDuLJMCDBevpU2hAgbVPbQAMPZ1aduGg+QqDJZYARK1AGCdC/aVGYIIQPZ6TY4EeU9rKFSbCCTjSmwUE7DZDCMgOkaZL7OkaZundMhEAU5QQoQl1c7qbo+u3MLnKNDTkekMB/O4nghNoNmFLNkvMugNC7gCo3PFt24RuNTzaC65EiSIoiuDV8nOA///a+rY7ICbe99YMpphEB+OEyPdl4NEszoky2Ds0QhJ62/hb1kjZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsRXW7xtv1bAxTm0xBCzA5MSUAkJG+wbwzO+2VgbD2k=;
 b=X8I5G1B4ar95V1x1j/GoEo0iHKNDzXNBMgOZUs0rdiJLOTftOmAJmR309rNBxQXY9xskz02SgNMQtWDx2LgOoozABNywhLV7QZ6kwoOaxsTciJEByayl3dhsBzGOPcLKjd7XHs8vcvhfpwP022nc5LS5Z0ggoTDe/aGHhmhrUNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8977.eurprd04.prod.outlook.com (2603:10a6:20b:42c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 10:49:17 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 10:49:16 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] irqchip/irq-imx-irqsteer: Get/put PM runtime in ->irq_unmask()/irq_mask()
Date:   Wed,  8 Jun 2022 18:50:57 +0800
Message-Id: <20220608105057.2607812-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0179.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::35) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 720db5c4-f102-47da-6d68-08da493c8890
X-MS-TrafficTypeDiagnostic: AS8PR04MB8977:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB89776D9E0934C70D8136C77D98A49@AS8PR04MB8977.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDaVkMt0nMiCeNGxF1H+sgKi5MxsjB2ZPcYVM0txc0O4gdjemNxYMVeW1p9E4bbYlKAWBTmMpMB4moXTB6vZ+0dVrxBsiMV3OcuQw+1jHC/0IIbbM37XkIdFosZxA3V4u1TWH5vocStH2cUZ3aKlBcyDQREFHhIg6LkcubZO29brnrvTpwLmhAMAmARVNqtXFN8zt2mYnqI8oGhQ4QpfrEZAT0qXUsxbtePlkw8wwz5LcqeNmS2OkNxkHUE89SEFRwv24AgJesiEUwvqp3cQbGitsmxdBo1p7dLB/TSK0fZY9i2RLHl0lub3lUQsACnNdcPeQh+OQhFEsLavVLVb3Rw5emOCd6vqrglfUGWDEEn9qqKBHKP90SC7Xtc1KoBh0MnsDvoO44Ze5H9N61VxlZBzbcw1NDsj9sQYKJCp2GKS/R7/Kto4Eu/5Ufj/nyhjFcypy9Wb8OqwXDoGj/frmiFt/lav74khTuO5miW+A3zs/bD0mUtiGupoLCLZvhF5IskSReeCFN3an1AXA39IymmKKvxkz0GFPchlvq8e35iyakSknN/oh7PbVEw/Yyp3sJOSLwfsLkxzFwVpKeayIZVDCpHO1ohG8gYXhWNxJN8vAoQeKyR/xGWhbCq6DHtXCiZrddB6nyltO5jEFCq7oVz/+zLO/ul6X19DI5o7XuPlIN4+YE8geHdfo2+AzYmcSaDrz5ONwBbmKbahKVI3sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(36756003)(316002)(8676002)(66946007)(66476007)(66556008)(4326008)(6666004)(6506007)(52116002)(54906003)(508600001)(2906002)(6486002)(38100700002)(38350700002)(2616005)(86362001)(26005)(6512007)(1076003)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?63s5qDr64uwB4Y5GFws0GM6SOV5rLb4ZRsKkWZdkmJQzDFWi5ce8ooO7IDTP?=
 =?us-ascii?Q?5znIAf4Garguae30vzOhcdchZAqHvRlbP3Hh9FNGffyYaxttgTxlX7p6Tj4U?=
 =?us-ascii?Q?5wcxN8e0VR4o521LFs8pLYYv5IOQWsJd1JjAGNteP8jq7ALSqbf7xUkQgPqC?=
 =?us-ascii?Q?fSuiFjK0RklGlDhMvnrgEHx2gAyL0z/kCy/BOGYroukDJXOjy5xdl5rlsDEm?=
 =?us-ascii?Q?Xc/tSrITnrnPqfh2x8hNwvtukm5QbckhFbtYQ3jSQham0XgfbM9Z+PO07nC2?=
 =?us-ascii?Q?jw90NS76cFjFSW6C3r/K/wcQp5GUwCWamg8JUAoK///QEhGTtApVzf1315as?=
 =?us-ascii?Q?04T8n49VO1xwdf8rqE1QuTcgL3JpKXdL578iXXBhCRvxxl/9wlADQUlcjqAH?=
 =?us-ascii?Q?wLTJ2WNSe8zkuf75Hr4E8AVlpZQVS6l5td39FDiF5YcbOUW54+dorQ5eAWz4?=
 =?us-ascii?Q?ClVhiHYJI/Y07SNcFf68GIuN8HeADNEZtkKuGWnrrz3BSgUnYZMoNR9NeipN?=
 =?us-ascii?Q?1sFvbC4on3rbztkog8tRT0qkMD8zfMXzniO6+SyvrRo4guKAOyFjglBFXGBB?=
 =?us-ascii?Q?6L134HikrSXKaBdL6+0REUMLATF3RvV9yj4CmzOxFB+2UkRFOZE+1+qLxx+3?=
 =?us-ascii?Q?PSEsscvkkg7VSmwF5TZTmmv5TSMG39oRL1I3/bEQhBLV3fRm7le+2o5xDH4D?=
 =?us-ascii?Q?m8zLiXMwpVrfAA/XAwHAVQrzjqyZ/ZZWMCR67rfACwnJ6TAW13fDnvAIB+7u?=
 =?us-ascii?Q?X0hB4IBsBQeCZerZtvFtsncS2jvc8ul4cuhhY0JYliO/bSipqJJmzbMoKQKL?=
 =?us-ascii?Q?Ph9TkPkhV4n4jxJNSsPvcTkUU4+c63r8WGhJ5/HvA+XU4OZGZeOHsdHMLqOh?=
 =?us-ascii?Q?mAJAviSpYGAR8YHabNW84JmCtEy++48DDmnbT+OhTj9JqPqRQ+Km0AfcryOK?=
 =?us-ascii?Q?a+gLO4ftQBF0Q65Nz3j8COqDAv/9qal+rpPbrsxhKSB+fhPrrWbsv54C3Mu1?=
 =?us-ascii?Q?fhJLHt/jKXLDn9v262FF8JSPA6J4YqzXwEcqj258dXAATXTWLNdK7+rrAqvi?=
 =?us-ascii?Q?KD11wRal2cp+SDYCnchCEhyr5hTLMRix1MomuErsN40Q+g7o/PVtSSZ95MZm?=
 =?us-ascii?Q?lAZ2NZ2rMaxC6XC+b2wHhfDLTIkLYHFqLSR427/23ySu104gWDp4Uk56pstz?=
 =?us-ascii?Q?slf8jii3oV5/tsZPZSU/IGBhy+wAc++Gcn5kgs9Z4I96Kt8k4lTxpNFPvDs5?=
 =?us-ascii?Q?nZGnbVMLvvkvyhT/PC5RWY+KgyeGs8XN7ROiOeQj9vCZFVJ+IXcHHuOABSc1?=
 =?us-ascii?Q?7m12WihnY+0oh4pflmAgndaxvUj45uKvAentRp/FHd3MlReoEnbednLiFB9j?=
 =?us-ascii?Q?u2701XZy98IW/1zPaQcJ+voL5FMXaDo0zMwQJK71rT/+QRe+NQUQtDndwbSK?=
 =?us-ascii?Q?JRKeh7WV4YX46O89QaFj2WgYjF/pHBeLq607PaUTn3Gx0+aQ4jW7DYC39Yda?=
 =?us-ascii?Q?R6nUAEcI4gTaOo+Au+GGXZeMWZYCb+/KKY1yxp4xKcSSUjelwTuUOzk7sFiX?=
 =?us-ascii?Q?CdtLCEfb7QyGSMXGoSvIR5ivYylakXj2zDCdtUncSuBqta16CboAe6biLyX2?=
 =?us-ascii?Q?y58Ai+4FGEoWQW8Ru4nvkL4KS8VkaSoTmUsoOSZTN7oBg/NRpKxcmp4OG3G9?=
 =?us-ascii?Q?0JkxhbvHrRjb75t9q7HyU6XPp3K911RpRlE/mgz0q+axv3Vn5YUPP2mZE8zm?=
 =?us-ascii?Q?7qJ/ABlgPA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720db5c4-f102-47da-6d68-08da493c8890
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 10:49:16.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbIIKyGVf+Mtx8pxVH7anO2ELFlGVRaw2QrKQLoIckp6f8PSIDZ3qIu7+eTfhAxzWkTAsl5NJ/T+ofwGq13hOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8977
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that runtime PM support was added in this driver, we have
to enable power before accessing irqchip registers.  And, after
the access is done, we should disable power.  This patch calls
pm_runtime_get_sync() in ->irq_unmask() and pm_runtime_put() in
->irq_mask() to make sure power is managed for the register access.

Fixes: 4730d2233311 ("irqchip/imx-irqsteer: Add runtime PM support")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 drivers/irqchip/irq-imx-irqsteer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 96230a04ec23..a5eabe71e8ab 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -45,11 +45,14 @@ static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
 
 static void imx_irqsteer_irq_unmask(struct irq_data *d)
 {
+	struct device *dev = d->domain->dev;
 	struct irqsteer_data *data = d->chip_data;
 	int idx = imx_irqsteer_get_reg_index(data, d->hwirq);
 	unsigned long flags;
 	u32 val;
 
+	pm_runtime_get_sync(dev);
+
 	raw_spin_lock_irqsave(&data->lock, flags);
 	val = readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
 	val |= BIT(d->hwirq % 32);
@@ -59,6 +62,7 @@ static void imx_irqsteer_irq_unmask(struct irq_data *d)
 
 static void imx_irqsteer_irq_mask(struct irq_data *d)
 {
+	struct device *dev = d->domain->dev;
 	struct irqsteer_data *data = d->chip_data;
 	int idx = imx_irqsteer_get_reg_index(data, d->hwirq);
 	unsigned long flags;
@@ -69,6 +73,8 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
 	val &= ~BIT(d->hwirq % 32);
 	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
 	raw_spin_unlock_irqrestore(&data->lock, flags);
+
+	pm_runtime_put(dev);
 }
 
 static const struct irq_chip imx_irqsteer_irq_chip = {
-- 
2.25.1

