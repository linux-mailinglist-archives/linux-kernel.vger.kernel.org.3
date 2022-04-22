Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3638050BC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442228AbiDVQAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381209AbiDVQAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:00:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2051.outbound.protection.outlook.com [40.92.18.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3295DA5E;
        Fri, 22 Apr 2022 08:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3mPCAcYAUBDc2YKR+tQ21mixuCGB3sBySkLcCAdQBRjmooamvqLZO0YvZ9r7yFO4IHL6+aD5rF+dBE3C5IzLRaw5sD8Z4W6QKiFCPdko/l4QVGWmV4VSKGp9zeBCBOe3Tkk0o6/avyA+8RqMhgOFFO0kJ7MEqX8lgg6sVNeuAci20/+uShNzfl27tD1d9Arzdgg7Jl7Lf2Y+MK5aete/cfJmZo6PQ1AB5e0U9m6i3BQ1ZqUOKm90PFc5xcrb6bMqN/odoZf0N4MBvh5kaLhUtGJyl2zdnq1LzM/Rz0RN75JBJA/+UGvLGdY02jHmKg7YpTXVorbuKCMUC0eBfvGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/nkuKY6fOKGmnQLLGSq3ReQr9gJ5aTylkHMaLhGwyY=;
 b=ECysYfKRHMUOG0HuOgg7S2gaAJt9w2pbG736dToFnVyTBvGLo7vm35ZJO60j+CBKDwF6JFfZWYY6kr1LnCQbwxbENLUSrWKeQ+8ETHVeqJBmED3Gi+raLpji6wAvpM/UHWkFEeipyc/16F+o35GCK1o9uElMk/faIp4x3vOvyAxNH3C0tHYUEwt3yDlvZ5xKFc+10AZk6CCt+/fgsQ5vVxog53Itn5dmTCD1rWrdzkwTrjBD3xouL3IRCpxJ6xUkHCA6i18JTpyCY4fU61mGV+BrpRr6Wve5Dzru/JjZyVEEMvSnI+mY/ruc4eV8VnMxKylYyWD3d7xoKcJhAU4urg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/nkuKY6fOKGmnQLLGSq3ReQr9gJ5aTylkHMaLhGwyY=;
 b=sY7TDSZ9aJ7ZkjsN0b0AT/3qwO2BUIiAfH7mUrD+rssH52m2DgowFZVTI5wk9pkeOUaxjpc6TFNB1NzZs+MGHiUgAyhuhdS7Z8HaPbjPaq5LWekysAGjs2rs5obWwNB4v3gYdZsXmv7lq6Ji+rXp1kHQqv78vDVs27waz5Ln0+o+dV127z+WQhuAgFR7tQKO3nbcKJFvOL/KfiGGTAcovc7qA1h24Gzq0y7hAyVmPOpeSUG6QwFDxkbxB1OR5BICRf0+s8N00/H2uEMO437rCHWVldVomSmmYYoaPA1nOtZ6YEqPPNZivxhskxLpEjGRHmELKaN9fvOSwrjB/cjl1Q==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by CY4PR2001MB0917.namprd20.prod.outlook.com (2603:10b6:903:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:57:25 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:57:25 +0000
From:   icenowy@outlook.com
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 4/4] spi: sun6i: add support for R329 SPI controllers
Date:   Fri, 22 Apr 2022 23:56:39 +0800
Message-ID: <BYAPR20MB2472717D5AC20E7702329996BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422155639.1071645-1-icenowy@outlook.com>
References: <20220422155639.1071645-1-icenowy@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [MGFqH9QJANVe0BzP0KPvht+S9gJKbyRg]
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422155639.1071645-5-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfea3a30-45df-4fad-b1bf-08da2478cb0b
X-MS-TrafficTypeDiagnostic: CY4PR2001MB0917:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Md5mcrh3B8WOSwFTddObXMg27FbduhwK8YlquuBIhVoJCOwRFegAwd6fSkOZv9j8rLHdq5DAMcL5ILerLMeyQmAntm1S3XvJp/rbZytNs8552Zx9OjpH97iQ5cwiApuno7t6Iztv9TgKqzUT04e/vG95ySXu+3L8KXzST6G+qgGfipAd0isnZ2uDXFwg4Ecw9Vu0GV9D19GOLY3ClGAYF6G1RX/B8d8vmFvIc6NgIzbqrEhAC8x+5S7rTdQ4lC3Oq7NtVaT9DjBFMtYQKIVNjCg9isF24cy5DFm8zTxp0j7eySE+3yXzgI7PisFtdTvkA+SeIoTvB5AGcmZTlz/xg6u8guNENHfw23E49RwNrOPBNmhgZm2N2fIi/U3QiMWAFLHegtGha3bdCCnG4PNagcUetOtThiJ6uC1dSSkQa3J0fRsYUh3hdQ/AwwQCY+8zxT0A039XpvNezIgc0ckSH9c0YvwVXAOFrlyKlERN5sxv5oGlXxQaRis0TI55IkRuYEupLpSZv4igUt3PSL1R1Qf4dtXvN7VC3AbPZ072zZ1YiXG8/QuJ17N3gUIR++FVahG4BZLC2cECtXQ2MB6xQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XVN7wxGmEM+/QD/C6r1JWjXvcLHF9LPH+j4Eax4bZC2FHpsoJ4/WMdkVeton?=
 =?us-ascii?Q?mGsdYlf0D8DjYm/XUH2v9VpBY18oybi4f5JVGtPB6YPCrcY/p4EYEOi0Ctjg?=
 =?us-ascii?Q?SiTleVCAaPXgnTMLC8Ti1GicPrLmhqdDgK2gELl+XBOgT7WjyuQuoLIuN1Mu?=
 =?us-ascii?Q?fuj8M5l6uU9IXQyD92SO/10NJXA00jBmN6/fJuT/4NSX61mfNBKfrnl8UXXE?=
 =?us-ascii?Q?M8+Ssu7vgK6wZPn8BYFbtGpLScJAe65+b9yyXVABW6S/DOoQk5SxKIoNbs3H?=
 =?us-ascii?Q?FV2mqV55eFt8gUyhdLZgIXWi5OZQtVkkp2AvHMlCEc/S9gCF00h3LiaYBH4F?=
 =?us-ascii?Q?aQz1c691f6/cFF4xKpDNjqFjd7VE6rKAsmu1nnyjGEy8V8IJM9H4fYlCFGUd?=
 =?us-ascii?Q?8yEXRx22WnzRUne9CDY8pAevCPKuRYXWoVnMGbbD4H9NUAkR/KA2HBer/kH/?=
 =?us-ascii?Q?RlmZJZd+rGNUsZbYYQmRDcXypuCsZ8+DZvNJxEgbJwODU5UdfyhE710v8f5b?=
 =?us-ascii?Q?3HM4jYRsis+KNm4r8fUMxMNISVoMY1MqD2PrySBlKyGv+Aa7jA2RDdDoCgvE?=
 =?us-ascii?Q?anplB/Rz3NVkmAzqmLYq+TaSLX+2fvlOQ7dJnH0YLukgKsC/qyS/9pcGh9A0?=
 =?us-ascii?Q?rseZ46+eyzh6fNRoP5hORSrTYoZFEI6wcfkFcQ/6yvvEH/8KjEQo5mFJ6DB5?=
 =?us-ascii?Q?PIkvNqY8ncuPUcVJpmZZc9LaHOAnRPBfjKUKNcDAjox7BOudRUtevjnPfntG?=
 =?us-ascii?Q?v+WpkcePwuBJ6T44tgLEQiR68CsxdJiUD6iSeBVAmcUYgNTZs4z64QY3nxxk?=
 =?us-ascii?Q?SIX68rNRZz5KbYRN8ezfwSks+6dOc9pOhoGy4cVrZ6rcpQA1pZfg0NrUxj9s?=
 =?us-ascii?Q?Xv/FBTpZ1W559W064rASk5iLcUZqM3pohJYYgBYism8j+YtkxppcCQNY9bFX?=
 =?us-ascii?Q?E5TOtcu8dW4BT1u4Lmfhgl4m5Yr9JiRmKD85lOhGnzxc+hlN66w0J7WIKWyI?=
 =?us-ascii?Q?VFiAcitQBtLY4DOdPBEDUkS7Sw1vcec1S6mISuvmXBidzNd9qyUbHOIxRR+c?=
 =?us-ascii?Q?cEWi/SFLGWjt+juIlYPKd9P9ieK59r+p7akRV4ZiR5YCIUwXbqHQpDkO+TK5?=
 =?us-ascii?Q?eL/5bmGLfCtlYcL1jhQ2RnFTY5Ji7C2jAi1yqMuxDXNlg++O0BiB7dgmyDHz?=
 =?us-ascii?Q?KGzo2RyIXQWODuvZ1xzXR1f/aCydO1UmpZ/YswsSKdA/B4NzXRni+xYOL+af?=
 =?us-ascii?Q?5B5oK1A8VQsjjyYbJ0mz5oA9clG9O3Ys1rRODLxXrvUjTYC1pjpoKkMuEN2X?=
 =?us-ascii?Q?FM+7xYkgoAiATewS5PjQG7EdMvTWSPsUsKdSwunO+Nuu62ZWDl9nMeRa/pCc?=
 =?us-ascii?Q?21znSVxT6TT7BOhTwymgfiSBcQyzYx6vkJOF8UHbTb9MosmtnI/hE0wbb7A/?=
 =?us-ascii?Q?MKjlLxhwQDg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfea3a30-45df-4fad-b1bf-08da2478cb0b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:57:25.1625
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

R329 has two SPI controllers. One of it is quite similar to previous
ones, but with internal clock divider removed; the other added MIPI DBI
Type-C offload based on the first one.

Add basical support for these controllers. As we're not going to
support the DBI functionality now, just implement the two kinds of
controllers as the same.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/spi/spi-sun6i.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index fc81afc3a963..c4bd8ea31b43 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -716,9 +716,21 @@ static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
 	.has_clk_ctl	= true,
 };
 
+static const struct sun6i_spi_cfg sun50i_r329_spi_cfg = {
+	.fifo_depth	= SUN8I_FIFO_DEPTH,
+};
+
 static const struct of_device_id sun6i_spi_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-spi", .data = &sun6i_a31_spi_cfg },
 	{ .compatible = "allwinner,sun8i-h3-spi",  .data = &sun8i_h3_spi_cfg },
+	{
+		.compatible = "allwinner,sun50i-r329-spi",
+		.data = &sun50i_r329_spi_cfg
+	},
+	{
+		.compatible = "allwinner,sun50i-r329-spi-dbi",
+		.data = &sun50i_r329_spi_cfg
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun6i_spi_match);
-- 
2.35.1

