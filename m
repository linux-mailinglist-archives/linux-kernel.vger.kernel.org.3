Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D09E50BBF0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449596AbiDVPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449540AbiDVPpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:45:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2077.outbound.protection.outlook.com [40.92.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574EF5D676;
        Fri, 22 Apr 2022 08:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPfBEBkSqGoTy+T1Pfbx/OUhFxI8PK3dYuxcKrbdG8dTL5gjUMc2ARPQJ98KRu/lvlbMp9kTEOfaBeLXNFNO0lb/7VZkLz8T655iuGkI06Zt0fGEWMrj3kZzXGrjUYgw/HM6BmOLFcnG6f6FpUx9q422NcGdmnO8EKtbUjKbTa4vNG0xGkl12SHNu/GMWvOHCaeOq27MUukwJxOgeN7zAdDnd9WCPSlv3mBAhHFxjnMYD+pBtq0tW4kERbGFQ94XkoZ1qkJWWlUtNTWGKJVcPVUKhxy422e6L34IWStMgv722MPxP+2Yfa8mFpi9ddeQiK7OnZy9j9X5r5/0G6OwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzsnBRl1kO4JKVKbaIC5wMKWdaRVYwYb152iNzGXuOw=;
 b=kW4Ac8sFVKgo0JTjGh3iICACmsammiqA/+5mXv4OHp8GZlU3NYr6vYk13mCtO/ecpShkzBmSk6y0cdjOt2TQOlfiGtIIxVEwxk3G5o+wBTSyYCsLZoophHHnki65F/4XHz7x/qgirx+ef446vcTgJvX3FF6IQrJpGX1BTZOFWm8HZMpmjMc6sY308NPpCae78/L8Dt3lUYZxTchHrH9BrpTPvlyiEfFnzwN3x8w3kR38M7aUIRn35rEHXHjtOFKf0wQPqvJ2cNBOBuf8+Wk9Oab+3K66yvYvgVxbBFk6pAqetSdEvpmI+55B6YAycM9qPOm0/ncasOcJgXpTLdDvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzsnBRl1kO4JKVKbaIC5wMKWdaRVYwYb152iNzGXuOw=;
 b=g3RP7ND696buziAhetPGGcp1KP/8eNyS8FvFnGX4xHd6yrtpOdQVC6gVsTf47+MvVgy0IeNdnnTPlt5KMSN3JtbLl/pvmcMfxNA3ZiCbdoYiNFH+1Vqp9PpO0XmRda6h2MiwGTaIXgw7cYMk54sQyjAmZTEKXCeyFZhsLb8TQdANWx0n2nlWFToKhFtBKOduPzo6YMDGIzfgwXfB2NCiCoaqAhsmBwlVgE1FPdV6NFrWCi2yBkqSdn8mHbjAJLcP2GUnnPD8+yF27v/DT1KmB5IMP976wCo6f8IAKP8sFgEWvOLMzMChCOJg5/UvfWPbLF27zP1GWxR3DB+qApf3jQ==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by SJ0PR20MB3642.namprd20.prod.outlook.com (2603:10b6:a03:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:42:44 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:42:44 +0000
From:   icenowy@outlook.com
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 08/12] mmc: sunxi: add support for R329 MMC controllers
Date:   Fri, 22 Apr 2022 23:41:11 +0800
Message-ID: <BYAPR20MB2472BAA6CFEA5BD4B18D7D4EBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422140902.1058101-1-icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [oSw8wRHTSxNMDQeBhamboNRKmzQ7x45A]
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422154115.1068642-6-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 489edf50-d672-41f6-de65-08da2476be39
X-MS-TrafficTypeDiagnostic: SJ0PR20MB3642:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHYB3p1mlqlL7on0bOWXGDR10KBDVDVh3XQQOfzeDTVmpUmHILTOc5J91SmehyKifPP4p2A/dfjNUUIhOu54IhpiFk6n5z6IaK6Ix5o781b4Z7uYik/64+5Mg7vhm3wIYXaJeQlZ/5eAHTmOlDBrEz4CDooarpfaCYKuIYpdn9ukmjorIq6+aRZcXkp4IZFHUM37t/fNKC27Q6rV9kkAk3WAr4IwUq+j92l/oP2ptlLaoeJho1AqsZcH2nAXs7+ibJDST6KkmuWNwwXTdSdxqBz43t2M8AfvcSObKTHUBSKzFdLuLiSU/HLXAqKrqg7AbK3sYCVxlT+G6Ik2XNa+rlAqWOxXUZCnLQBPNQlh35cj5f/i3rDC/TvcIDjcsmIAK+ZzgSozPLGedaoA/5QmoN6BXA0t2D2wv0HVhC1CaBagjCIpu+S0UE3aFMmeyPEAPDExLj/+TSXf/Jz1w+fAEpboNpNAr1KRX7wX0Ma3+jTfCvSnJS90Iu1F/P5DynoU92iKaCYziurVLYybXVd9Mvyzbjei78YOxvZuCc1wPtIJ9bXucIbLWVvZTj+5+hZwMGWwpQmC1FIZCmYIIwL5vw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/jI58MgggHf0sZwsDvVHv3gXhG6OtTo3Pwqcnp/5FhGxUrK1y9huocapo6ON?=
 =?us-ascii?Q?MdIDZnccX0Hb6+OMStIYW3YHN7J1CIpgUZjwM0Wu+n2CDsZm6EmMi+ech6Ni?=
 =?us-ascii?Q?4YASL9samRFJmxQdAa0hPyZzGnh/1n6n7JKHjZ3XJlyTyEt11TTioNl8TLqd?=
 =?us-ascii?Q?+jAH0tA/ImJHoRRSPcehMCdSzkqDhfPk8J+vp2vBYSjD8c2SPU+UYhnyeicy?=
 =?us-ascii?Q?YUnglJSqNwL5qLC6qNWm0zBvXQeeS1gHMpqYdrw0n8eXdWZOIsF092V6L8nM?=
 =?us-ascii?Q?Gloea50L6MBKpB28TkvsTDwy3eCTBqTY7tch6sA5yv4F1uXR4DSnEq8G6ce9?=
 =?us-ascii?Q?SL1fPwPPYs8bgoNIO/yTR0H12a+7dACpTHC4qSkXTrA2W7xj9k/FDnE7wGkv?=
 =?us-ascii?Q?tzq19frU/9pJQjIonNh4pJmAxe8zauvHZAGHoepNIZlO6SYNMYKIM6zwoBuG?=
 =?us-ascii?Q?tVXzvKMDr2irZA1avVhLomolXCkZuUzg4zCxA9QeTOyl8JVnTAA5ZBnOo/1d?=
 =?us-ascii?Q?M2A64fnxPoahDBiwMnb1JKAXclnON9Nm0RhJglublHSBfi8fBnGpzUasC7K/?=
 =?us-ascii?Q?r9c2nm6dvNZyagl5jFyobYi2F85ir5mmC6Qv3NJ2cBxtQEzI+VA72ARXkEBN?=
 =?us-ascii?Q?G7E95YqHF8AW9ORlmZeTIkRDFAsj6ILWLJxJ8lXRHv5UF4mseWvefu8hP6Y0?=
 =?us-ascii?Q?7B3lF5ysf68w9ZY3K1R74xm9FRMqbjKLJp9ilSI1O7Djq2UD+dtT5EVRqC5Q?=
 =?us-ascii?Q?3Wzm0nS99LOL2v1d6RwNwjNx9+HCyFihte/kDby+mm2vJdUWjDgb9wpApmhq?=
 =?us-ascii?Q?gyL/28MNRuWkdJi51ndbIfDFUUsxujYHXPmvzDMOAxeZzsKbYvaxU388yqN0?=
 =?us-ascii?Q?7216nw7Mncw1lWwZb64y9RYEzVB3ZaV8fpbG90Xr8ILEO7dSqvx2y/4rxmnx?=
 =?us-ascii?Q?mshXeaIdgLiwfifLQqmuHgsPyBsWt3Kf0Yt4bx2SNeWGR/QkZWNTJg9A+DUo?=
 =?us-ascii?Q?6sC2E1ExeapJ9/kD8xyB97Y6rpl5j9nEkYpSBHVU4cV2FIHYpiwzhvE/gCou?=
 =?us-ascii?Q?E2U/TZhEJ7DHq0YPOCphADq7D3zunMU4RPQLAKAhAfE97s66YfaflZMWtRrJ?=
 =?us-ascii?Q?C8TGw11D6BIKso79uvKFqltJfHq9CbitQ2mBDpLAS71F/fBOItfVuIzN1qAz?=
 =?us-ascii?Q?DzLS5d1XxXwG/QH35ciblV/UCRiOS3ws3CgPDS69KBjmK/Xn2RrU9RTZqnj1?=
 =?us-ascii?Q?ss2qa0BdAzUtAcgLr+fUklTQKWV4h2ROfQhFID3lm0Qr4WQGuBaBtbfROcv4?=
 =?us-ascii?Q?UZT165f7aZmT4aTWGPLXBkFCuCmrypigG+yJ6LrXC3l5cVyBriKO7KJeXB6K?=
 =?us-ascii?Q?a7KB/pNoSE/YvGsigqo3IGsZAlqzlwWd4b/jb5mcW5R9QTjETdx+3wuxTzrx?=
 =?us-ascii?Q?ZlPx+rAF39I=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489edf50-d672-41f6-de65-08da2476be39
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:42:44.5206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB3642
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

The two MMC controllers in Allwinner R329 have a mixed feature set
comparing to the previous SoCs' ordinary MMC and eMMC controllers.

Add support for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/mmc/host/sunxi-mmc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 0e8fbf4957d8..06934eef8be5 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1207,6 +1207,15 @@ static const struct sunxi_mmc_cfg sun50i_a100_emmc_cfg = {
 	.needs_new_timings = true,
 };
 
+static const struct sunxi_mmc_cfg sun50i_r329_cfg = {
+	.idma_des_size_bits = 13,
+	.idma_des_shift = 2,
+	.clk_delays = NULL,
+	.can_calibrate = true,
+	.mask_data0 = true,
+	.needs_new_timings = true,
+};
+
 static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
@@ -1218,6 +1227,7 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
 	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
 	{ .compatible = "allwinner,sun50i-a100-emmc", .data = &sun50i_a100_emmc_cfg },
+	{ .compatible = "allwinner,sun50i-r329-mmc", .data = &sun50i_r329_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
-- 
2.35.1

