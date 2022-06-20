Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B402551EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbiFTOca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344175AbiFTOcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:32:06 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30055.outbound.protection.outlook.com [40.107.3.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134F44E38D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDovKVtMUEPG0aQHNa9gT5FvL8M6IB7tq6dAfwLA+l59++T9rq7I/4g89zLfNAWaqJ4dDQaOgTLxby9qGIiZQIcdAH+GL/sBBW4zE2S3JDuurTNIzMW5ergy9qZ5Lm9jRUchePTwe3XfGu8CGEL/fWnCF+eAh/cs/a9E4i36cfM/NGxkVjuH34ySGHN/mnJbIPLyreRurUqkuiqiIW+eVRGySx1uFlFg0aZMcipLuBu8BwEcNKNd/S/+8fzd9dtgbIqcuCVMqHPJkaNR5uNx35ZClaNYb9YGolaM0sKE7QbfhLQHdXMkrpfDTsjFEMUrxHYS7dgMRaTHt7dGDBG5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwRl/zwLCTSG+DrVadiP5h9Z2y93lJD/z/VrQtLjyxE=;
 b=IAoJ3YUAMzselnM1hF+b+sQMR8GJMSFM34G95ip/cifkbzpwA/svFgkRJx863BmkvSOrfTQWhroDzJlUYgU9gCRhX74t5222PfJaLkwobXqCVNCQguET6384OaKjIdhNQJo6nZh66V9M3U5wCJN66oBJTHbRoWM4+NOejGtCr5XnRPDGSZHxA5F44DGOvj24O4ePJCOnfCb+luWzSqwmZU9OoEOT6pnpWbEK1yR0X/4C2bu3WtuSk/o5k9kuBZ3wp365WzAoo7eNzKfZ3PGn2TEnuL/pTfKaydtlmC+X5zjonkynChx9msAyt57T7LuSAvBGZ82md1PoSjk0n1TM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwRl/zwLCTSG+DrVadiP5h9Z2y93lJD/z/VrQtLjyxE=;
 b=shhqz7Nf1M+hzSl9lJin/79NConlVtN7Mb1n+/MAQmCjjIW2oDB9ofi7xLHxGYFMZEEFSeY8LgysRma5NZcEnqlR5X/RAfpvVXYyv0Ds1oBTmLTMLM59zZa496rGxCwj06Tf0XFm6lRU45drUc7EQUAajDHyhEIXCpuZlvSauzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by VI1PR04MB6190.eurprd04.prod.outlook.com (2603:10a6:803:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21; Mon, 20 Jun
 2022 13:46:27 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72%7]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 13:46:27 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        l.stach@pengutronix.de, peng.fan@nxp.com, shawnguo@kernel.org,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RFC 2/2] soc: imx8m-blk-ctrl: do not export debugfs
Date:   Mon, 20 Jun 2022 21:47:58 +0800
Message-Id: <20220620134758.1286480-3-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620134758.1286480-1-aisheng.dong@nxp.com>
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To DB9PR04MB8477.eurprd04.prod.outlook.com
 (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68cba87f-7cd4-4cd7-f197-08da52c3460a
X-MS-TrafficTypeDiagnostic: VI1PR04MB6190:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB61909C034E4E210BB5C67B6D80B09@VI1PR04MB6190.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmuZLZFaNICkaGGbK19x4ywAtahlKeloA9T5T4xmAd5TE26J1jcnMByw+Fjkh/ap+VoX5sIpuVISQmT+GtdGs+L8bGVeVHzTPhBQkt7b8m6PP/F1KFhgBhA/XepDJH3YKV2BtGUKs1MDRzWeDAhegAqeMYRcg3UKDwd2uFP3t46n73sBeN4m1fCpgDX1uZ3KVR7T8Ne9OYUhtoTX6DqlbYOBggtiihgAfqeyO2WsC2xiFat33Nfp7DPJy8T2PesGUk9X1uEjVk8CY2DUkYGcqIL3o8o2tWDCKqF4DGtCLkU8bQXn2fHd7ELYUrzk8NCx3hcDe6ivjB7xjpK2v2oQk7ak5y0ITUduO6AfO5DvxNp0q3COvnDHGyavgbqfaddmCI7pIFq9fNnwoTAS3VQUWwT9mOjFFsOtJtyLwoONguHUlHDIvLleKIU2ov8VGx6q6f+ApaTMPnJICGRrEzuHKkp5GG08FYbCUFNrgSbQBuYK4ri4wC5o4FeM7kCRJ0kakx2kw/Q169j99nw/7qQweYw/Boq8DZo3u3MvZhJxQn5GVKCYv9gHiZO/yJySH2dzBtxeGWLcxeoeMhCeX2AdhX1vBkVK5Gx1TrtpiaqIu6tBB1WhKy134yi8zEEEhMFvn3H0lIGSafwjNhPRoU7G/z4Hul/Du4qvQAmzccyp63Lxlxkt1n39srv9nRK9rCt2WK1/JwQuZKsfdpoIoBxAucGK6KTQrfYsb64B0CUTyWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(66556008)(36756003)(66946007)(8676002)(66476007)(4326008)(6506007)(8936002)(186003)(478600001)(316002)(1076003)(6486002)(2906002)(41300700001)(38100700002)(4744005)(6916009)(6512007)(2616005)(5660300002)(52116002)(26005)(86362001)(38350700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TvshN8CaO7NTOTSV6GvPaG1/ZP3O7AoGnSgA+kCeNIHOUQ/fqWrVyDwszzMS?=
 =?us-ascii?Q?u+GEvsX820wSZLA+unAwF/PNR1/vq8BCFLaEqwH7vL7CwFgZMe03Mlg0ZmTZ?=
 =?us-ascii?Q?pamo2+inyR24BtQm+GWFk6y87tI44wQIJOD39oBQbU+iDeWIFbq65Nq++BTY?=
 =?us-ascii?Q?qR4yAPsmZIZ+pZg+jZokVk/Db4UIY36o+Kabf0EoiNQ7oyt6oQBhICfb8uHf?=
 =?us-ascii?Q?lD8ejPRWv45Mf+qNivwp0bbaUMyOi6LI9Kw6W0irJqTTT7WhRLMTH07TPVK4?=
 =?us-ascii?Q?aqPm3NXttYArUEdpsEDxdP695T8c3zg/iyao1T/XKM9PuZ+kITyw1883Ijaa?=
 =?us-ascii?Q?MpByaxDZUe2eQOvRCHA4YgSc+WR1aAqyBFw5Btxn1F87nQYYhovPs7ZuymnS?=
 =?us-ascii?Q?47iHxlg9f9LuePWuyXVjLdTPKyGbaeIxEcru1WktXRcoAUsVJNjMT75IDbLz?=
 =?us-ascii?Q?oX6Zbr2/x9BaBW46ZqbUCRoNCvNvGuKeZ20C5FII0b6jiMrQTWuGrP9rYDCA?=
 =?us-ascii?Q?um0wNMoy3ktJG/li54bch5RwPvPTymn6VbZaIfVAIu7me9kyx0rYAdJpOcPc?=
 =?us-ascii?Q?+ULYwZ08eCFaf5EwfzkdFOpHwjqqCnJtzGAKYWi/XWnYAyFOLPLebO3YJP2L?=
 =?us-ascii?Q?+qn1Wv9Z3kdV7++YluV45ffft5tq+ZPE0cVwXFPNU1SMOWFbunEoNSCXjRm9?=
 =?us-ascii?Q?mwaziyHGdDVZ2fqH3UXjOGtO2bRJXJCXQxwUjx2tQ0piTj1UZo/6JUvWs/DD?=
 =?us-ascii?Q?Pbg2G/AB0iVBZzgRtJ6WV0uctFn7DHNpVD6HDuZcsX+WHkRzyn7FHqSyXMRj?=
 =?us-ascii?Q?6cM50CDqt2M4YOiEHnpgxwSGP1pjp7tQvCut5AVjMlEqKpWmIVczIKuXXnA2?=
 =?us-ascii?Q?Y3TcNkrDpUTDJPrXL/ilVGi756mHV56wnVBAegYVgmB++GToQZeP5uHfnSyW?=
 =?us-ascii?Q?byukblouZtAWkJZ8L76wG5gzMfEuMSixX5AkTiBmxRzDndGBQEobZ9X0SNtS?=
 =?us-ascii?Q?GBkjqJQxM2QmPakitdcziYRRQZOyTFD/LP5zHv40VEQb4iu7+9eKfUMNoSiw?=
 =?us-ascii?Q?HOQM9kjw32jXZ7JyYHyizGtdVaIUo2Jwft2wbgRmNWsfl01wB+F6WYEeWvs0?=
 =?us-ascii?Q?OZ6CK14WEEcjwiRAMI7P1OXYdbCSZh8JdZvO+nLo7KuilVtkIb6H1R2HjCmf?=
 =?us-ascii?Q?ceDoZRmdeGo9j6YAp3HRkCLo9p/1FDCymXl6OtjjbjoifxvxMAmOJhnV7yeT?=
 =?us-ascii?Q?/n8ZP0GGWmg560dssoeqpkPuL5HrwLHPZDnkS+Vj6VL5mo6J2YCLjuQtM2Hm?=
 =?us-ascii?Q?HUb2hdMj60l8KdlXZgxS2DugfBh1zBGCkFX3rkwzF84dMElrKJPHoNAZgAcu?=
 =?us-ascii?Q?iH6FFCFj7oX0PnlMf2pmrgLLCKayWtZISBU15uwbQZqCdvj0dJxHVuBWet+F?=
 =?us-ascii?Q?YFG+Mpi35cEeJKDJLDNAUe3DjqEczfhdkyTtiA7o3CzAFsnnb8mlHBS7MIZ6?=
 =?us-ascii?Q?M3Do71JDn7xKV7VP4Soi4cN1UT/VQz2YdPRRia0tYGnjhf8ZBa4c8Yo6KpM9?=
 =?us-ascii?Q?YPD/N3ynKrbxoVJWCredAwsjBCrX0iu/N6N6MJfsTgEH4LrzhRCj1g815FM1?=
 =?us-ascii?Q?nNXgsZB8TkJ+V0ky8YCx0yR1K4t7GFm/wjL8VfTbQ9LSssaySY3J/7fhkfl1?=
 =?us-ascii?Q?5GiLBAObn2/T4Kkz5sXciZ12siYsyOEnqcpSz1wZpdeXayaIAt7YnjEa5mKC?=
 =?us-ascii?Q?FpNtJx+18w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cba87f-7cd4-4cd7-f197-08da52c3460a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 13:46:27.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jhP0uw7j1sQl8PkXoZtr3FQyNEnZPpO1NHvsjiThIFJLm0FvgkHEoJRWTzCLcz87NsmkFeCNm/av47FMi82rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx8m blkctl does not support registers dumping via regmap debugfs
due to power domain required which is not supported by current regmap
core. So let's claim no debugfs support, otherwise the system may
hang when dumping registers through regmap debugfs.

Cc: Mark Brown <broonie@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 7ebc28709e94..a064670576e8 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -179,6 +179,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		.reg_bits	= 32,
 		.val_bits	= 32,
 		.reg_stride	= 4,
+		.disable_debugfs = true,
 	};
 
 	bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
-- 
2.25.1

