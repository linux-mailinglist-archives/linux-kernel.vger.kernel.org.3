Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D9050BC4A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385032AbiDVQAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359249AbiDVQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:00:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2028.outbound.protection.outlook.com [40.92.18.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7611B5DA5D;
        Fri, 22 Apr 2022 08:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj6dk/6e8tJTLTuJpUv+v+u9ziUHHkf1quvGEJ0fyNFfWmqOffAVB9ajf1ZKe+xIkgMSZ+8zchuDNJ7Zw0RIYftwWVqj1jpMa3hLtvNwt//J5SLTppPnYXMe+xmbzdeVW73lbia5kVxtYsoWF8hzvVDqleTjd3GFIUbKQLugsumDx7kmRiHW5T/fmwTdTA1D+Q6K+woY14xL72+1i4I9OAr9TU3OyTtfH/tVkxluxM2ii0dhckzM0y1FVFBJT/cIZ0b8ZGsfOHbAbxXjvbDPDG3UtDK7nlApdozxw2uSTyMS2AyqIv+3IN/jbodaNFJz8HyFp87apFw/miE6+uOcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjRNcOCHoT1F5l8EmfV/s3vTk7Ju2Ua83b9CsTNmlmU=;
 b=kb5GW1A2rUzo2qAhn4qLLbJk71aIbVhlBBzWQJ1B6NkDekG8AuIer4M5KGCeyu/Q94XT0Ph4uAnBcIhzmSmQfCa3f5GKQsqUr3mSqrCS/O9/y8GzQFGeUl26wA7gtq692p58I3XJUh3iJjtis3XktwmwjEIxHc4Xqj974TEyRDcJ6fNJmGtA9uqa0CmNjt0L0wXxLZ6wC9nixasF0KNxVMGqrtL+47R6iLLHtsx/MQfdTrTosE4ixHrx017M31UcN+mx2MHH7uQtR1L2+WOC163hXKdTCJzSOtBYhL4ABbUvgxSsjsCOomVR5Xj/+FnVNtZBJZKg4hK2TshpDThtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjRNcOCHoT1F5l8EmfV/s3vTk7Ju2Ua83b9CsTNmlmU=;
 b=snu5cYif3qakAkrzTT2jNv6HcikDkAbBlNaHuXXLnxTfzsmobcsnG/RyQZU6RDrgl5GXKhuK2HhfDpLrGzhrJ2KjuNy8gT37W0eKqYpp3tD4YPXwPxaY7B1oqn11DG7NaEa/WJiK55YKphxxjU1gDPngcXfKhpr7J/LHISAAX43BsQT1uHKM66wp+D+7yNcY7wI1ZFuCbqAGvpvflscbBpTW5o5RMhl0CDszwa9/Wo1Wnr8OI80O0W2yPZEaQTZ4v9UzjYkdxJD8vS+iwA+Ieh3Da+8yNNR4njm9xhl8FEfl+FOyHPEuXi5oSKIIwuxE4OTpqCVGjmqaa3rynYnd2Q==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by CY4PR2001MB0917.namprd20.prod.outlook.com (2603:10b6:903:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:57:12 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:57:12 +0000
From:   icenowy@outlook.com
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/4] spi: sun6i: change OF match data to a struct
Date:   Fri, 22 Apr 2022 23:56:37 +0800
Message-ID: <BYAPR20MB24722F3BAFB536A8BFEC733ABCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422155639.1071645-1-icenowy@outlook.com>
References: <20220422155639.1071645-1-icenowy@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [95mPJRFU1+sKHSIYKr6vgvSKnRYHd7PO]
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422155639.1071645-3-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b71b5c9-55b0-4f0b-9155-08da2478c36d
X-MS-TrafficTypeDiagnostic: CY4PR2001MB0917:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+xO6qxUrMnV4+69dmTSQbrYxIIUrwFeylMOjZOflTAEyO7q+cGK7ZoSmP1WUWFgZ4TPI27PRGu5qGqZMk3n4wEryjSO+L17PhT7zYYSJnPJziDIDi+ZjUBpdTochUUWm7Ta9kANH7EpTJMVLqhyFHZelF78tuHYyJ+/zSJ+C48kDJ2o+d9SIYsELKVjyJ+/j+D2twYDkM+Imoruwc6WcUQ8SiponibhxINoQDqkr9rbm6rPQkexMRy4rrmU+1LD8wmCuBrGENnUOXWuYptNkYx5CJ/ofDUEOifFtlXRNNI+upliA3hG4HuTHAQ5pTsYqh7tdEi+cD2tto2336Fv64hwvSK3FAsZWH/0c/SZBPofHnxlQztYG4RhNrNVTh40i86fkIgZ0hUdUww9Mo1nygvU8/ygfyRui4Ou3S8nJHvveS+ehFGE0rBMFEK7644O8SqhKguBBtSuK0HhX40fOrs+Fo+EdZtgNa+Yfl5NGmu2yQAG1xJIRQPrBHQDqcbhjp0ScokaKYymwfokmK1/WalLsLkp4ev9Siv6BmyI9loUxy8uUdjQh0KVyk+qrU6OQ+yU16MH2FD5XjynGJoyPw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ja3LttUEMgKU90YSwAJw9FbEp+kznTCPhcOOhSVkfygP4X0usTyOWU9yl8VF?=
 =?us-ascii?Q?uZDd+luJjDOeCW5HZeS2k7OSSPcaf5TI83qtpRrCBGpfV2/Q0unlSuobXG5n?=
 =?us-ascii?Q?X6lBZ+7dbYUZloskRntW7RSq914m6Ze7E/WEsarQZYSMjTLn7IHZi57EdHH+?=
 =?us-ascii?Q?8yyDn4vKZu4J1YwLfjeqRmHQFlvalbUFWMf8sh3Ww/NlFH3w9AgQyx/gasYE?=
 =?us-ascii?Q?anE8lcV28P/KdmAOjcEgoqO2o95//EYi3GnKm1RUdiavWGfNrrSPyuD1rXuj?=
 =?us-ascii?Q?7AgbbogEHcIjYNLCX3flVHKP77XaUYfKZKG1yUq+Upu6cMq1rDExZyR3QzUy?=
 =?us-ascii?Q?9twmaOzJVs9sp41ECyuz7oaz4fDXW+BZ4G6F0/6bmkZTRcpfwW1nXKZcw8FB?=
 =?us-ascii?Q?NtVPpUm+kp6XcHyU2q+CiYyE5NSvS20RZofEDtsC9YRMyELoj7zyD3ECd1H6?=
 =?us-ascii?Q?a2ko0tFF3yD+gI2UjQd1GoZqsr9SW/sfZMF6xN1Gq6tJ5ZQqOcbUG4HCBBBo?=
 =?us-ascii?Q?3Sdt22fZWcaQUlvv4artu0XdYBtxYg8MT+Mdk1uIx3f5z1TGttou+91q+7we?=
 =?us-ascii?Q?RzY6f42fa/pgnVPNthfW9Axw8FmwkJ8W4vHcHKd7iWNXnmjrRE3QdyrZZN21?=
 =?us-ascii?Q?y6dB1Y8/5LNijSB8qYI0R9rKxat008iHd+hzEEi6DGwkNrDSfseUgWxsntRi?=
 =?us-ascii?Q?xXKZIhfABtPI49KT4/HXGjY8s4/wVjmWaVig+z0QUzRTxYbLT8IcfUojFbjx?=
 =?us-ascii?Q?+CqbZhZ9mOQvt1hy/nwJY053+k8TlESk/CXfD07CpEHlNATyR1+JUHzIrLRx?=
 =?us-ascii?Q?E3WFigp3DpSmKO7UMuTlUfiT9THrkXHVhxS5XTbAG6Jrr6doJIqPBCSB0HwY?=
 =?us-ascii?Q?Uovwrp58IPFWX1NEsM2Di6khCBh3zTspAaxhx8lgluJv3aZrONrNrLIOwfuc?=
 =?us-ascii?Q?Cbj0wcKXp3XYT5UBwIitv1gkz3X8PHmG34zCrxYQmD6CILwLJD2Awpk8fUEZ?=
 =?us-ascii?Q?NVFadpBhWJnxt5w9HxCrvdKZAYH1MPJIyi03tQmIkVpRUqNpABK/MJzdMlLK?=
 =?us-ascii?Q?Pjb4qAWaGNo9DcQ2+qCIftkZgQm3y71MyXS7Onxa/0n7ajjF/3yrLFG5TPBY?=
 =?us-ascii?Q?mMdOZ0hk4cDY/NTBAs5GOnbFFW3SxSiwNh4AGFCrf8Ar5E8BfK5d8YH3nFgs?=
 =?us-ascii?Q?GQdATbtfhU11y8YnOgE2BwNU0g2h0DmgNDf9VGp3kOnWez+SWVfY8V+LI2hj?=
 =?us-ascii?Q?07EbYdh83hjFCDesZB4qT540uGxbBg4A9d+wIJZiCyo7GH9fqKkzCoAobN1I?=
 =?us-ascii?Q?u2ANUbmxLGlbReSdSFMaVKVc2PcWiBdw0t6a0UpEyom3NqzNOGY0W6zdLRFt?=
 =?us-ascii?Q?V+MglMMLSzjvFTHv5kHMyMKeYF1QbKx76s1wuEds0x0uJ6On3JwKXQgE+qDY?=
 =?us-ascii?Q?m8BFqWASl3c=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b71b5c9-55b0-4f0b-9155-08da2478c36d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:57:12.2259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2001MB0917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

As we're adding more properties to the OF match data, convert it to a
struct now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/spi/spi-sun6i.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 23ad052528db..84c525b08ad0 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -85,6 +85,10 @@
 #define SUN6I_TXDATA_REG		0x200
 #define SUN6I_RXDATA_REG		0x300
 
+struct sun6i_spi_cfg {
+	unsigned long		fifo_depth;
+};
+
 struct sun6i_spi {
 	struct spi_master	*master;
 	void __iomem		*base_addr;
@@ -99,7 +103,7 @@ struct sun6i_spi {
 	const u8		*tx_buf;
 	u8			*rx_buf;
 	int			len;
-	unsigned long		fifo_depth;
+	const struct sun6i_spi_cfg *cfg;
 };
 
 static inline u32 sun6i_spi_read(struct sun6i_spi *sspi, u32 reg)
@@ -156,7 +160,7 @@ static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi)
 	u8 byte;
 
 	/* See how much data we can fit */
-	cnt = sspi->fifo_depth - sun6i_spi_get_tx_fifo_count(sspi);
+	cnt = sspi->cfg->fifo_depth - sun6i_spi_get_tx_fifo_count(sspi);
 
 	len = min((int)cnt, sspi->len);
 
@@ -289,14 +293,14 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 		 * the hardcoded value used in old generation of Allwinner
 		 * SPI controller. (See spi-sun4i.c)
 		 */
-		trig_level = sspi->fifo_depth / 4 * 3;
+		trig_level = sspi->cfg->fifo_depth / 4 * 3;
 	} else {
 		/*
 		 * Setup FIFO DMA request trigger level
 		 * We choose 1/2 of the full fifo depth, that value will
 		 * be used as DMA burst length.
 		 */
-		trig_level = sspi->fifo_depth / 2;
+		trig_level = sspi->cfg->fifo_depth / 2;
 
 		if (tfr->tx_buf)
 			reg |= SUN6I_FIFO_CTL_TF_DRQ_EN;
@@ -410,9 +414,9 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	reg = SUN6I_INT_CTL_TC;
 
 	if (!use_dma) {
-		if (rx_len > sspi->fifo_depth)
+		if (rx_len > sspi->cfg->fifo_depth)
 			reg |= SUN6I_INT_CTL_RF_RDY;
-		if (tx_len > sspi->fifo_depth)
+		if (tx_len > sspi->cfg->fifo_depth)
 			reg |= SUN6I_INT_CTL_TF_ERQ;
 	}
 
@@ -543,7 +547,7 @@ static bool sun6i_spi_can_dma(struct spi_master *master,
 	 * the fifo length we can just fill the fifo and wait for a single
 	 * irq, so don't bother setting up dma
 	 */
-	return xfer->len > sspi->fifo_depth;
+	return xfer->len > sspi->cfg->fifo_depth;
 }
 
 static int sun6i_spi_probe(struct platform_device *pdev)
@@ -582,7 +586,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	}
 
 	sspi->master = master;
-	sspi->fifo_depth = (unsigned long)of_device_get_match_data(&pdev->dev);
+	sspi->cfg = of_device_get_match_data(&pdev->dev);
 
 	master->max_speed_hz = 100 * 1000 * 1000;
 	master->min_speed_hz = 3 * 1000;
@@ -696,9 +700,17 @@ static int sun6i_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sun6i_spi_cfg sun6i_a31_spi_cfg = {
+	.fifo_depth	= SUN6I_FIFO_DEPTH,
+};
+
+static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
+	.fifo_depth	= SUN8I_FIFO_DEPTH,
+};
+
 static const struct of_device_id sun6i_spi_match[] = {
-	{ .compatible = "allwinner,sun6i-a31-spi", .data = (void *)SUN6I_FIFO_DEPTH },
-	{ .compatible = "allwinner,sun8i-h3-spi",  .data = (void *)SUN8I_FIFO_DEPTH },
+	{ .compatible = "allwinner,sun6i-a31-spi", .data = &sun6i_a31_spi_cfg },
+	{ .compatible = "allwinner,sun8i-h3-spi",  .data = &sun8i_h3_spi_cfg },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun6i_spi_match);
-- 
2.35.1

