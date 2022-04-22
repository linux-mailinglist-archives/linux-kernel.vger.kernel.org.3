Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B557E50BC47
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382774AbiDVQAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359635AbiDVQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:00:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2018.outbound.protection.outlook.com [40.92.18.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1365DA63;
        Fri, 22 Apr 2022 08:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1FNmpN9DOyQo0575y/T2TyykMB4Z156FzWVeWwEcex+QpEmrgjduVmPL1obXuWrQF8P3RDC2Ep0X87TU6FgTI5uKWp2WCQJ65MdmKLc7nDjsUfDt9iGSLfFwPZyEmMTv39296y0+IyN1NYkYb9J/7gNGtRU1lFm8aHS1+JVY5ffznCd3PNkE8FkH0GEVVoDrPNA+PVzxJKAIk1FVagNiyeOLLCMKYMX13sm3zAPTF5aBjdwuXYSOtxk9ioSwCHOLU7ZsDzNFLkOTMIqQEnlW55gneNPB/zmddYsYlc85/BBTrglOazlmrfEXpvEluSBY6/cItTzcYBYyYNsr4B03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w214JjkWxts/kZdYSYyJbA2zAoSYiPb6tUrTOsI486A=;
 b=CF1PiUzUNMeQ9+ZqLMBf7/RVzk4t1jibhLnMqVhB2WMpEHsE+tjOcr6kP4vamGc0Hak4dESHnwoGq3pn0pEHnUP89Fo8Td2blgGOs+uFJ07kWCgIZSfCIQl5g9FAEZkwKz8QwgTrxqy3CHGUkEQcYgS4w+3r3nv/7rMudGRW1rVaVvnGVYAcSQsqkbCEu8mUJvaaeM016ugh8QNb8TMWV7Dw07A3uQapOtNEXzZ/HtpBydESlTBSQ5SpWKeVJ+Igqi0Zbk4VyOanNevruc4bfwTkbiXXwXQWDuF82jjBbMNKsNAc2HwrlBszNrnhGDXYPWwHiZor1GyHV9uCSa+Nyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w214JjkWxts/kZdYSYyJbA2zAoSYiPb6tUrTOsI486A=;
 b=avIl6xb9ivtcLGSSB2c593ZJpAGneeVYLnxiVtHTcDy2915NSfu6Q6+9hsDVTetrt/0MemLtcSm6sJywl+6Khhz7Dt4TVkNJKN3k/HH4KMCZaNRx/PK55vcrXIUlyahFjobrA3ToDL1MuBVHdX+JHSWa986WYZ5z/ThjC1wxIgIJlTW4nZixhAyKYfKmZTQQuz9NKgnNXUtdaJiHMqqgWKJKxgYK8MdhXDkgg+31tLO2leBRBGUC0A0pNd8fkHxXDAAzBzdW9ZgH/boZPl2JjJep5Pjn9Dq25ngxNaMSTBZcfVOzvSLydO5sxstzRfdW4cJhJEsVEfBYNFn3kHEAZw==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by CY4PR2001MB0917.namprd20.prod.outlook.com (2603:10b6:903:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:57:16 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:57:16 +0000
From:   icenowy@outlook.com
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 3/4] spi: sun6i: add quirk for in-controller clock divider
Date:   Fri, 22 Apr 2022 23:56:38 +0800
Message-ID: <BYAPR20MB24728A99C2F7505873A091B5BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422155639.1071645-1-icenowy@outlook.com>
References: <20220422155639.1071645-1-icenowy@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [6on+UoLO1ATpsFxi0pyPJsItMb+i9p/A]
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422155639.1071645-4-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e00b0f-5279-4cf3-da4c-08da2478c62c
X-MS-TrafficTypeDiagnostic: CY4PR2001MB0917:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPKginjMP6LZfTjk1VtW8Pv4RLWarsXenZrYwgtH0SNDfyjwQptrmY2qopUzZ4W0i0drObBPzNaiSm9BdHYwDMhaArHpxPYSyXnO9qSpPYfYgMgjvzBBGtGWqKunBgGX42/2MyeFXdjYPQ26XWbWKJ3uXan7PXVGEChTr2PVezOJgUZFsG+KXiFt45IhIF1nSAsSp+CnO/ehpRHLm0528FccF+Hj2VAGkriXnChKbrbxoalRERv96Al7rR0fM1+FHK2rFqlH6kf3GWhEziFJwrIa6URe/DTgFRAU/V5b7R97+Boe8bZpq2GUfCaMMQde1r+PZO5cMrDD8mSr2c7U0sOmDAYvB574ZKzgNMXaexO4+6lF5nrLtB+XdHX8QGOjgwpvBXrrw8HGmCAefESrHY8cfN/0Dats/wwA48swne4ijiCQE5apZnsP6ckiqX/nqOo2YfzBCcnGeowhD3+rQiP8ON/bpLyOExM1Y0wVlnqghVzgv0bY0kAuJVmFeDu/rJomqoflMppijHIqA++IJxEmHg4gQGPffiVhhNNfcWxFI23/qkw5N7UTeNtP8YtWDIvpPokrtqDQa29COy5nqw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P+vnShno19Ic9CduPeN6aaWaPDycWAQUGaRx9kLEovgbIyi57Iy91yGVizZC?=
 =?us-ascii?Q?ShxPzqNr2kS2ZLjkeH2BsA+dYzp3PEjsJcZdiuB0ihul5oKu75Mo2dOJe4Q7?=
 =?us-ascii?Q?JwIQDTwbEOtFwDuCEbYiR8PSrHa+oZP5XTFWHMy0xRQ8Y7C+DxCWK+yxXxeC?=
 =?us-ascii?Q?jUqKQxweytzLkzin+EdfxOpZKnrAvJrfR+QiUL2HHyv1pGOfjjHgPg/DVwW9?=
 =?us-ascii?Q?Lp/xrU4bieQI2LwGwRGVOTR9xDgTON+14Ys/QWf1KzNz2JbipE0WvyjLVois?=
 =?us-ascii?Q?y27ToqGNfo/cNDQKtZ6DeKk3nYyDi3rC0gp4omhK6UmyPRpEbjN2s2SsGYWu?=
 =?us-ascii?Q?x3hbHk8Sk7WnLogZzMxgkZES13Q6I3rEMtmVW/nOa+K0Exg7oHJR20jPyigy?=
 =?us-ascii?Q?fc4uuY4LMtDrRratGBA3cDgdAW976rvGfl5D9/H5PaR5x+9/UT+cqZdJ3ZN9?=
 =?us-ascii?Q?7aBqPCUVF8eBuQLFhX3Sy3/DjzQVdZx3nsg9Q705StiVbLUJ4psPkOTJMD9q?=
 =?us-ascii?Q?tPqv30l2zc71oOrJTBW0sd4vu6ltbyKaLThqWW7wo5mqphOZMz8GPSXk/tRE?=
 =?us-ascii?Q?ZjK3lT8Gv5z75+uldf60ZmHMfsqy6fJpB/Zq65ja7Xos1CshJNL2qs8SdYkb?=
 =?us-ascii?Q?SMYhVMqXl4/zGIEGHSl8brWXHLUOEbyGd1Dugv+KxhX/929xYZFn6/OBBM2y?=
 =?us-ascii?Q?6r2U+Xiqzl0QUMtfD0hU9/Eh7418vlEtGfMq6qIasKQAUsqDfLdKVSxV3TnK?=
 =?us-ascii?Q?S3yrz71wPKEksMTQvPbWrIHhv8jBMuUN+9eYZVoFR0pMG0s4x4n9LLgjTXsY?=
 =?us-ascii?Q?dKRdp0hyCV+ErKB06plL5LetQMuNuLMV14auzH6P3XTV+NjKJfV8OV460uAB?=
 =?us-ascii?Q?uagzsr0a1AM3GH1HW2VLRzoW6uAj7WVe+aH1f/qrWyfoKS+G+XhWmE9gyMhx?=
 =?us-ascii?Q?30VnK4nDHKJxS3yoTHunFsEiZKwXLvxWb1qRyf0RKbZcuyHsSlRawb2YoaVa?=
 =?us-ascii?Q?QQUsQmpuKjcvuuoElHw6H3BVOt5+dTSfcgvV8DFNrcWeaszpDrdrmXJKHhYI?=
 =?us-ascii?Q?SK1Hawb28eLA40Ry9eo/IhYzxumbHmV0ZvV44e8Y4Ib2KJfCM4ECQoe0ekYm?=
 =?us-ascii?Q?olz+tUg6BhWhkAMebLV8vPC50ScNbd/N3gNKpyejFgjRwCsnu7uwj1yO1IvQ?=
 =?us-ascii?Q?oKZ5LrMGdo9If7YhAETkXuaDoybhA1ACU6RmprzsicvZ18LBPg7ED8XzHTkk?=
 =?us-ascii?Q?UNBdfoB/hl/8UgPvwvZFOi4d35xbY43JycFRJL6T0aDYe5w8nFsi9cGaM0AU?=
 =?us-ascii?Q?xQlnUSvEaWCcSWADsn0DIL4xTToEFcTrmnB1o3RQXvVTXfJPjtqV5aIIrWy9?=
 =?us-ascii?Q?yFFcVfo5kIAiXGpCt9EhYK0Yv8Zkq/MUb+9/aOLFFJnhYwlbPrhF1KR+qY7B?=
 =?us-ascii?Q?C8cwL3QgqmA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e00b0f-5279-4cf3-da4c-08da2478c62c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:57:16.8506
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

Previously SPI controllers in Allwinner SoCs has a clock divider inside.
However now the clock divider is removed and to set the transfer clock
rate it's only needed to set the SPI module clock to the target value.

Add a quirk for this kind of SPI controllers.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/spi/spi-sun6i.c | 68 +++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 84c525b08ad0..fc81afc3a963 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -87,6 +87,7 @@
 
 struct sun6i_spi_cfg {
 	unsigned long		fifo_depth;
+	bool			has_clk_ctl;
 };
 
 struct sun6i_spi {
@@ -260,7 +261,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_transfer *tfr)
 {
 	struct sun6i_spi *sspi = spi_master_get_devdata(master);
-	unsigned int mclk_rate, div, div_cdr1, div_cdr2, timeout;
+	unsigned int div, div_cdr1, div_cdr2, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int trig_level;
 	unsigned int tx_len = 0, rx_len = 0;
@@ -350,39 +351,44 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
 
-	/* Ensure that we have a parent clock fast enough */
-	mclk_rate = clk_get_rate(sspi->mclk);
-	if (mclk_rate < (2 * tfr->speed_hz)) {
-		clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
-		mclk_rate = clk_get_rate(sspi->mclk);
-	}
+	if (sspi->cfg->has_clk_ctl) {
+		unsigned int mclk_rate = clk_get_rate(sspi->mclk);
+		/* Ensure that we have a parent clock fast enough */
+		if (mclk_rate < (2 * tfr->speed_hz)) {
+			clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
+			mclk_rate = clk_get_rate(sspi->mclk);
+		}
 
-	/*
-	 * Setup clock divider.
-	 *
-	 * We have two choices there. Either we can use the clock
-	 * divide rate 1, which is calculated thanks to this formula:
-	 * SPI_CLK = MOD_CLK / (2 ^ cdr)
-	 * Or we can use CDR2, which is calculated with the formula:
-	 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
-	 * Wether we use the former or the latter is set through the
-	 * DRS bit.
-	 *
-	 * First try CDR2, and if we can't reach the expected
-	 * frequency, fall back to CDR1.
-	 */
-	div_cdr1 = DIV_ROUND_UP(mclk_rate, tfr->speed_hz);
-	div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
-	if (div_cdr2 <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
-		reg = SUN6I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN6I_CLK_CTL_DRS;
-		tfr->effective_speed_hz = mclk_rate / (2 * div_cdr2);
+		/*
+		 * Setup clock divider.
+		 *
+		 * We have two choices there. Either we can use the clock
+		 * divide rate 1, which is calculated thanks to this formula:
+		 * SPI_CLK = MOD_CLK / (2 ^ cdr)
+		 * Or we can use CDR2, which is calculated with the formula:
+		 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
+		 * Wether we use the former or the latter is set through the
+		 * DRS bit.
+		 *
+		 * First try CDR2, and if we can't reach the expected
+		 * frequency, fall back to CDR1.
+		 */
+		div_cdr1 = DIV_ROUND_UP(mclk_rate, tfr->speed_hz);
+		div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
+		if (div_cdr2 <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
+			reg = SUN6I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN6I_CLK_CTL_DRS;
+			tfr->effective_speed_hz = mclk_rate / (2 * div_cdr2);
+		} else {
+			div = min(SUN6I_CLK_CTL_CDR1_MASK, order_base_2(div_cdr1));
+			reg = SUN6I_CLK_CTL_CDR1(div);
+			tfr->effective_speed_hz = mclk_rate / (1 << div);
+		}
+
+		sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
 	} else {
-		div = min(SUN6I_CLK_CTL_CDR1_MASK, order_base_2(div_cdr1));
-		reg = SUN6I_CLK_CTL_CDR1(div);
-		tfr->effective_speed_hz = mclk_rate / (1 << div);
+		clk_set_rate(sspi->mclk, tfr->speed_hz);
 	}
 
-	sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
 	/* Finally enable the bus - doing so before might raise SCK to HIGH */
 	reg = sun6i_spi_read(sspi, SUN6I_GBL_CTL_REG);
 	reg |= SUN6I_GBL_CTL_BUS_ENABLE;
@@ -702,10 +708,12 @@ static int sun6i_spi_remove(struct platform_device *pdev)
 
 static const struct sun6i_spi_cfg sun6i_a31_spi_cfg = {
 	.fifo_depth	= SUN6I_FIFO_DEPTH,
+	.has_clk_ctl	= true,
 };
 
 static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
 	.fifo_depth	= SUN8I_FIFO_DEPTH,
+	.has_clk_ctl	= true,
 };
 
 static const struct of_device_id sun6i_spi_match[] = {
-- 
2.35.1

