Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A35E50C6FE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiDWDuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiDWDtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:49:45 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2043.outbound.protection.outlook.com [40.92.47.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383BB17E18;
        Fri, 22 Apr 2022 20:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx/dffzEIK3vWKwOJxHF67D9F23Mdp2U2niDm4+VFEsUBPFI23d7/Vxf6WqClLWkBRiU/ETTntRQA87i1n9+wBKkGK2A6TeMPffMWcMB/aXqNa7PVRQwRCfgUx3S3vmYud2inPGUX28sif8pHuDjMwYGEjLu4W4NoifnRiYXZxemqq1rjojTbcl1jY0U/ztTxTBbXSiprBRImUm8bW8mqxzwzaHdwaGgL+0dyVlX4lFrcY4ff1Md59GHE0r+ZTuqgYi6vnpHSqbLfrd3wNdjmJ3mjlRAti8kU+CZKNXxovzqAkuoQV2Gg8X+2PPucCU6F8DtjA1Tb35Bv4WZCVQtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOCNBNpg8pj5X3kpg0xrEiadcxZZFicj1B2uUAE+IjM=;
 b=ezLPLWAlYDmpn3y5RwCdCOrn91OIMLr7Uaa/fJ5mQAESHD2SjXMdtgI4ivH05P7meIBo5/T+H43jBoJTEr4CB3ih4SUZ07nW+Rb984Va/k8/ihB3xVOEEEZoV449o4i2BllvZL87rL6oI1j5f5b4zWly1sNj6jD/4XhkgmrlSYbQN/U7CKxhq/ZaLQHhzAJNPYJGge8xiEpRX+dRS15QBWoxoc8RXr/npcYIiefozHztP9Bb1sz+dFvgSRO5CwkHXwwiSKZJ43BwzoYmKHiIJcIb9wOPqLgvGt++Gh/UgWlpiNbC31PTZnnSA2kyzfm06eagt5MykgtGa/9X5F+yNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by SN6PR04MB4205.namprd04.prod.outlook.com (2603:10b6:805:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Sat, 23 Apr
 2022 03:46:46 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::8e:6e22:f98c:29d5]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::8e:6e22:f98c:29d5%5]) with mapi id 15.20.5186.015; Sat, 23 Apr 2022
 03:46:46 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 3/5] mtd: onenand: samsung: Unify resource order for controller variants
Date:   Fri, 22 Apr 2022 20:46:20 -0700
Message-ID: <CY4PR04MB05679F5FFE8317D557933CB3CBF69@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423034622.366696-1-xc-racer2@live.ca>
References: <20220423034524.366612-1-xc-racer2@live.ca>
 <20220423034622.366696-1-xc-racer2@live.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [l2FdWO9S3Of0bxkli5/76lPwUFTdTVMeFfFO/wdP6TZtn5RBC1007aa2VLoXy9Gg]
X-ClientProxiedBy: MW4PR04CA0210.namprd04.prod.outlook.com
 (2603:10b6:303:86::35) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220423034622.366696-2-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea943821-93a8-4df7-d37f-08da24dbe3a1
X-MS-TrafficTypeDiagnostic: SN6PR04MB4205:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+bJautiTjtFkFFL6Cr5Iaf+oQLj9D718x20bWKhdGH94wuA6A1gz82f7ltmiCS0/6RXb2/wO9n1l6hWZ0fOz9aWZwvk4twIKdFTzkjsiEPZz2DPyoIPvj5QZz/mhTGgPXzvZQz2uNSDWQeWlNQzgK16P6sZc+sf5oDerHbaTLzubO03rEF+H2Alb0BvsYI6inroaPio1uPV1vFHPtgMgucZ6TQg2ShCc15YwHJ9Mbg3Bo7f3u0z7+sD0xYX0MsUwRMjnJONumthtXnNSS3eG4KppIWyrNkq5HSl84sHMWBoO+a/h7AaqZpxuPq39C2rA9bjCzfPMEHrqOxR5xsphtRSWbPP97Kp480GuXus5lO/5wEP2QnCk5DlNN+kEosC8u2zlWZwSdamz8KJp1uONwG9ESC8+Hw14IVZrg11mAUSoEKmdNIGHLZU3YgFzdtCvl5ZeiAx+tyvfvy7lELl85QwQy9V3va/qBmRDFu1wS0QgM8bkczTva+OnE4IX2dDX5JewYCcZLGLU5+jlyqKIuWSsAyfRduJan6JohgCgSDmrrTbyLW2SkqH4J+tAQJhu/O5kH+6BmjohFFc0GOl8Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXNrdS9lKzhFdlFqQ0dmY0FUYURkY0pnUWcxNm5ZMlZ1aHNHcHJZVVhyc3hV?=
 =?utf-8?B?cjYvdzhvWmJaQ2hUaDlXWUpIZkgzZnJyNUxsc1hrVGFSWFVoTjJFQzJ6Wndj?=
 =?utf-8?B?M3JIY0JldjdUQjZSUUNvbm1kSVh6aWlEcDFlYXh0U2N2Q2tNMUo3RDNobFpN?=
 =?utf-8?B?YnM5UVBrZXlYLzZyV2E2c0lGODRJYmRodEtuRjFhanQ2R1Izc1NTSVRsdjlm?=
 =?utf-8?B?ZjJRRm1hQ2ljWENETmNWYkt0RjlUYUhNWDQwNmF2aU1EUG14eEhSa0ZUN1F3?=
 =?utf-8?B?aldKM3psd3g0bGdJSlIxRTd2dVp3cXdEWTdrdG9BdlpFRE9zUjBXUnRHS3VN?=
 =?utf-8?B?VWpROXl6OXlTVjIyRmdVZUt4ZVFzS1dxcnJNTkdtTEJLMEkyYnNZZDZwUU5y?=
 =?utf-8?B?RTltZTZMRTNyNmcrQWY3T3k0RCtFekJocyt1ZzFuaU1TZ0tWNWtaRWxDMnBr?=
 =?utf-8?B?dlFqMFNOYVl4cmZoaXIzMWprOEdzcktRTDN0UDMvRVlXWkV3cnl4N00zVXhF?=
 =?utf-8?B?ejR5cHJSVWdxMjFROW50N05leFZEb1VGNjVydHh2RjlYdThqL1IwU0Ezd0F1?=
 =?utf-8?B?Uk1TQXF2bjhONWhDY2JGZVJNcEhYcUwvMXh0VUo5Y1FVTTVrZThPaHJsY3lp?=
 =?utf-8?B?YzE0R3NJK1pIL0hwTmhEcHAyaUozR2MvaFpLZjI2ZGNXOGJmNEo3T1J4NWh1?=
 =?utf-8?B?RVlYOFl6NG90SmhTTVB2eER2bnVZak9odXI4dTU3TFczblFQNzlvMmlzOUZF?=
 =?utf-8?B?eHRZSVBBK0hLOXJVUTBGZWllcDlSakEvdVN5SjIxYWczWkJFSzV4UUJOSmRX?=
 =?utf-8?B?OEZTRjBES0MwMlE2WDlVUFgrTHFqL0RndGdRb3VkYTJQeDYwb0ZxeFQxWWIz?=
 =?utf-8?B?YnMvTzFRQ0JPQUdERFVpV1JTU3F0ekJpOTA5SzVLaWpIUDliUTN5S3FlR1J2?=
 =?utf-8?B?Z2lZWjRKZ1QwcS81cmRCU3BCNUtIdW0vRWhrZ2hZTEdSL3VjYVBHeUV5THBo?=
 =?utf-8?B?OU5nVjJYUzQ2VHBJcWJ3RWRQbUplMTV0dG0rd0VvM1p1bTJ1REh2ZEZ1N2NH?=
 =?utf-8?B?OGVXbno3U0RwQ3lNb0x1SlVYQVhRYkZtTm5YUFhDZnh5MjRTdWtxQ2dZeW52?=
 =?utf-8?B?eVlndWJHa0ZHU1kwaVNKUkNzZldOVlhjZU5zOVlmVE1ZYnpyU3VDZThUbHdJ?=
 =?utf-8?B?L3hUVFdJSmlwV3k2UGFBZkxwK21aZmw5NC9HNjJWYStKOUk2QWltck8xU3FM?=
 =?utf-8?B?ZURoTlhZZWpma2hLR1BYUDhvNFVPcGlyeGdMU05walpqMEdLZDFlc2g5Q0Uw?=
 =?utf-8?B?Rk1YQi9DVUR1bUxuN2M1VnNzMlp1S2dZUkVzSGRJQWRDK3ZpNzVNdjJHL2lY?=
 =?utf-8?B?Z01KMjAwbHpvU3I3TlQwNDMzNVFmQXBnYVduSHhQNVd3RFZXendLYmI1UUR3?=
 =?utf-8?B?U3JLNmp1bFJUYUQxbXVkeHhaakIvUS9pS3ZrOWNpTlpBM01YUDBlU0hQYm5H?=
 =?utf-8?B?aGhUU1lQaWhaV0lyUzRuWVZETm0vK2Z0MEFncm0yL2ZtU3NRV2VpWGVHNDZH?=
 =?utf-8?B?UmNCcFNUSG55Y1RQNTJVUkFaM0w1S2VGOHlGRFBXQ0ovam55MmZDZFJIUjBH?=
 =?utf-8?B?aEFhc3c2UDNLdWtiTHduRGNNRWNFaThGR2Q5aHhWUWtQaE5TanYvZit5VTE4?=
 =?utf-8?B?aTJlY08xVGg0T0ZvTDFtcEZBVnNZWHU1WERYNGkyTDAxdVBoKzcrVDg0UGRI?=
 =?utf-8?B?VVVUZEtJUkdrakZPWUhCcG10bytsemd3RWI1czRvQjRSd3F0bk1lc1hKZDdq?=
 =?utf-8?B?UnJNT2ZBMktGVHNXcWs5d1kxOGRsZ1VZMWRlclhwTnhRRFM4UFkwRnV4alZz?=
 =?utf-8?B?QUxoVWhtOVliQkNveVZNNjdvckx1VmV3MzdhUG9JRTF1Y1NQWkQwd0JScGxs?=
 =?utf-8?B?QkJZTFg2SFl3SXFHcDVVbzU0YlhsZGE0RWI2QW4ycExWWUpyeEhrRSt6NCtY?=
 =?utf-8?Q?dibYfoy7oDnWN8rXPGcJ85vcDaN0kw=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ea943821-93a8-4df7-d37f-08da24dbe3a1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 03:46:46.5723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4205
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

Before this patch, the order of memory resources requested by the driver
was controller base as first and OneNAND chip base as second for
S3C64xx/S5PC100 variant and the opposite for S5PC110/S5PV210 variant.

To make this more consistent, this patch swaps the order of resources
for the latter and updates platform code accordingly. As a nice side
effect there is a slight reduction in line count of probe function.

This will make the transition to DT-based probing much easier.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/mtd/nand/onenand/onenand_samsung.c | 48 ++++++++++------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/mtd/nand/onenand/onenand_samsung.c b/drivers/mtd/nand/onenand/onenand_samsung.c
index 924f5ddc9505..a3ef4add865a 100644
--- a/drivers/mtd/nand/onenand/onenand_samsung.c
+++ b/drivers/mtd/nand/onenand/onenand_samsung.c
@@ -123,14 +123,13 @@ struct s3c_onenand {
 	struct mtd_info	*mtd;
 	struct platform_device	*pdev;
 	enum soc_type	type;
-	void __iomem	*base;
-	void __iomem	*ahb_addr;
+	void __iomem	*ctrl_base;
+	void __iomem	*chip_base;
 	int		bootram_command;
 	void		*page_buf;
 	void		*oob_buf;
 	unsigned int	(*mem_addr)(int fba, int fpa, int fsa);
 	unsigned int	(*cmd_map)(unsigned int type, unsigned int val);
-	void __iomem	*dma_addr;
 	unsigned long	phys_base;
 	struct completion	complete;
 };
@@ -144,22 +143,22 @@ static struct s3c_onenand *onenand;
 
 static inline int s3c_read_reg(int offset)
 {
-	return readl(onenand->base + offset);
+	return readl(onenand->ctrl_base + offset);
 }
 
 static inline void s3c_write_reg(int value, int offset)
 {
-	writel(value, onenand->base + offset);
+	writel(value, onenand->ctrl_base + offset);
 }
 
 static inline int s3c_read_cmd(unsigned int cmd)
 {
-	return readl(onenand->ahb_addr + cmd);
+	return readl(onenand->chip_base + cmd);
 }
 
 static inline void s3c_write_cmd(int value, unsigned int cmd)
 {
-	writel(value, onenand->ahb_addr + cmd);
+	writel(value, onenand->chip_base + cmd);
 }
 
 #ifdef SAMSUNG_DEBUG
@@ -517,7 +516,7 @@ static int (*s5pc110_dma_ops)(dma_addr_t dst, dma_addr_t src, size_t count, int
 
 static int s5pc110_dma_poll(dma_addr_t dst, dma_addr_t src, size_t count, int direction)
 {
-	void __iomem *base = onenand->dma_addr;
+	void __iomem *base = onenand->ctrl_base;
 	int status;
 	unsigned long timeout;
 
@@ -561,7 +560,7 @@ static int s5pc110_dma_poll(dma_addr_t dst, dma_addr_t src, size_t count, int di
 
 static irqreturn_t s5pc110_onenand_irq(int irq, void *data)
 {
-	void __iomem *base = onenand->dma_addr;
+	void __iomem *base = onenand->ctrl_base;
 	int status, cmd = 0;
 
 	status = readl(base + S5PC110_INTC_DMA_STATUS);
@@ -583,7 +582,7 @@ static irqreturn_t s5pc110_onenand_irq(int irq, void *data)
 
 static int s5pc110_dma_irq(dma_addr_t dst, dma_addr_t src, size_t count, int direction)
 {
-	void __iomem *base = onenand->dma_addr;
+	void __iomem *base = onenand->ctrl_base;
 	int status;
 
 	status = readl(base + S5PC110_INTC_DMA_MASK);
@@ -632,7 +631,7 @@ static int s5pc110_read_bufferram(struct mtd_info *mtd, int area,
 	}
 
 	if (offset & 3 || (size_t) buf & 3 ||
-		!onenand->dma_addr || count != mtd->writesize)
+		!onenand->ctrl_base || count != mtd->writesize)
 		goto normal;
 
 	/* Handle vmalloc address */
@@ -862,23 +861,22 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 	s3c_onenand_setup(mtd);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	onenand->base = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(onenand->base))
-		return PTR_ERR(onenand->base);
-
+	onenand->ctrl_base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(onenand->ctrl_base))
+		return PTR_ERR(onenand->ctrl_base);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	onenand->chip_base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(onenand->chip_base))
+		return PTR_ERR(onenand->chip_base);
 	onenand->phys_base = r->start;
 
-	/* Set onenand_chip also */
-	this->base = onenand->base;
-
 	/* Use runtime badblock check */
 	this->options |= ONENAND_SKIP_UNLOCK_CHECK;
 
 	if (onenand->type != TYPE_S5PC110) {
-		r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		onenand->ahb_addr = devm_ioremap_resource(&pdev->dev, r);
-		if (IS_ERR(onenand->ahb_addr))
-			return PTR_ERR(onenand->ahb_addr);
+		/* Set onenand_chip also */
+		this->base = onenand->ctrl_base;
 
 		/* Allocate 4KiB BufferRAM */
 		onenand->page_buf = devm_kzalloc(&pdev->dev, SZ_4K,
@@ -896,10 +894,8 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 		this->subpagesize = mtd->writesize;
 
 	} else { /* S5PC110 */
-		r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		onenand->dma_addr = devm_ioremap_resource(&pdev->dev, r);
-		if (IS_ERR(onenand->dma_addr))
-			return PTR_ERR(onenand->dma_addr);
+		/* Set onenand_chip also */
+		this->base = onenand->chip_base;
 
 		s5pc110_dma_ops = s5pc110_dma_poll;
 		/* Interrupt support */
-- 
2.30.2

