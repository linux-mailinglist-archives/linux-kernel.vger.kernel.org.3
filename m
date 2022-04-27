Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA29F511512
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiD0KoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiD0KoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:44:04 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150050.outbound.protection.outlook.com [40.107.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98205496D79;
        Wed, 27 Apr 2022 03:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/UX2QfCwOrkP2gGqaHfe9ThjkZmdeW4LEOetSh/0O2/rVekGOecxCz9CJ7C3nZXqYb7dukcz7ASPrdmVcsLvEcMgV/m00KYBIa8VEVeoG0CT56CqQLueh2Ckg0okVdEDu/ktd69mPV51LUh9+YxLznDllNzI+8RFyEWV56vOYsif15xtF3ng8Fe8wbezwZBuiDiRv8V8d3tCButWy24TOwn8U1LmUJTFxxZfHh2WT15QAtyWR1uNhTEusfIcsvkePsvYlwSVjoIxyk+jTzEGfDtbSah0LEtG2nDto4Jir90JRgbE1+euLvgIf56C2gDZ6JmZWIx+hxnecnAz1WF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp0FTaZH9hnb589ga0E1VoHfM/vjPT3caA8LiNs3OT0=;
 b=HaICJMdd53pi+NrtJ2SwlwAKA0D+vv8wMlpQMc1oaRfis2YkS5kG9rFcIFZ0CTwbcecq+yKctyLoO6n302QcmeaowwVQdx4d/cOta1ztavupBy9+f62PyMIaKZAH96OvhZm6Yqwv24JobA34eWw6o+ZSU5Czg722cS2UYCSSWBs+fg0Y8oGuogddzzsTGZFQyKH/LbzHci1PXh3DDdqkZE5NtgBgNTgSQyd3ivWV0W3LnFSVtVT59NwcyQM54CkvNxCXizrnREEmXn+ATmjkXRDQx3xtrAtok+v9VkFBI6DyXdkKZvLu5eh1IobteVj3kwQexDm/+4I22dHWIx3yHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp0FTaZH9hnb589ga0E1VoHfM/vjPT3caA8LiNs3OT0=;
 b=Xp4SQllnSxuTQDZ0agzA8QqOOem1nJxr9cOpTqW83PIuso8sn6d97DsAPj2WJ7NICv3wUL2xPxuK/jKYobvPeTM09ElH8Xch0syhN91jlCrpeSpzafPM+Ol5KeSUFiXzbl0IWAnPAaVor76dd8GosaOvt9cBNoAjVQCbPmhS+B4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBBPR04MB6218.eurprd04.prod.outlook.com (2603:10a6:10:d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 09:26:21 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::ed87:b085:802d:2390]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::ed87:b085:802d:2390%6]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 09:26:21 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Don't fill the description field in struct v4l2_fmtdesc
Date:   Wed, 27 Apr 2022 17:25:58 +0800
Message-Id: <20220427092558.25607-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e86810f-f25f-4ec2-8a1e-08da282ffddd
X-MS-TrafficTypeDiagnostic: DBBPR04MB6218:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB6218B8C347421467B1F51BEDE7FA9@DBBPR04MB6218.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1j7RCVn7mnLFzfPqfMrU3gWmHUxL+GErtpG6+y1tHw1Zsx+fBJbkyrQbtaj6RImGPD/caYUuxETNq4ytqykKMmHDy6iX0IEibNGmpFnd+qL06kDZ7VXK6/TsFg35kskiW2nFlQcKHLM08WAF1UESQ3CzoKpEWb8ysIYkt3ufSXjkBLm0Pw8O3rYgcQSfJ/duxzJ+x1BW+X23lsNTtFpDE6z/kdfvx82Gd5zU7zhGAS0I4vCSFO71bABhsgQMB48uhhkux+EvVTIkHEWCbrKVn587kdlyIBWPC1+tOERcIN+/1EQTSmtsKXe2T3ZFIuWT9yi+EXJne/em9YUhbb6dVrWxV7dXMRNaVyjwYiT+FJMw2WB52Ehtw5CEZXUDN22Q1ako5HbywxSY1zwcUITgw4Jfq9K681f2LftZE3hPPWbvzsQn8Rvs6Vql0/OQhpDwtQnQarhn0Bj3ygbQBSgQYD4QRXR3wWVktlCFPqGm+J7/nTPstU8G8In0VakWaJwqxho/dmX813UF3hcVU4i4uOceVfWeMuiTr8fv99kQmAVRjBw2OEE55zFvt/z+ajfpCfi7r0IKnMt1nlmpoTjbg2jyRllPlylZxNdcGfVhg+di7/WS/WrrYU9JbzUjZ7utU8w690KDgnQWvydGmi6cAyGHzWv2aC5sY1r17o2R6ubWWr3tiaZN4ABn8FsLvR20MkfSk7UEmnB6Oa+vcfB7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(6506007)(8936002)(36756003)(83380400001)(5660300002)(4326008)(186003)(2906002)(44832011)(4744005)(1076003)(8676002)(2616005)(26005)(38350700002)(86362001)(508600001)(52116002)(316002)(6486002)(38100700002)(66556008)(66946007)(6666004)(6512007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8J6Nael8F+0kGnTzMnlWzjrStPIEONMLIvgav8W9y0VIKeSmzufmtf80DHf?=
 =?us-ascii?Q?eQJnc+2oOH2uHpED5m4W1dRZ/Gv9HKGBUk03oTgaYa/GB4W7nzoQjKlCXFFI?=
 =?us-ascii?Q?rUvRFNIvQX7AurC7LPWtdeKiFVU+1E0r+3iWGPmCbIWog9spg60rWXO0/wbC?=
 =?us-ascii?Q?k8yV0knMfQjrhs8hysVfgIpWHov2I98OQ5sI8/hEqUfN8zxNQR4jqQDZDok+?=
 =?us-ascii?Q?b5ySQWtSzx3fs1Qz/sRz3lmbX3mYktSydBfnhMd5UiNoDxr/Mk6PGGoklwdZ?=
 =?us-ascii?Q?OZn1a332uTP/aaElsOA58rKXE1ApOqgr4xMbWcya+btKdZ9nDBP2R1fOaway?=
 =?us-ascii?Q?3SioWWP3NyaWnEeND0lMIL1JoXoLcDF0ivf2GebAAY8cZbqJ4Vpo4YPZmcmd?=
 =?us-ascii?Q?QKsIfMhP9bCQLvS56JJpBlgGymdVw7MLrgtRF/ypHZEqxKzK5Brut3+LLSty?=
 =?us-ascii?Q?sSygbYyrfS+xsDEdL7okg6JVN71tWARBm+oJ5sveEsO8ayayrMCGNiodgScI?=
 =?us-ascii?Q?YkUo3cy1AfoQ3ug5QcQG+IzBg0RpF3a5XxqjZ3ny6MyAU/DyuiQSIBCL5Rml?=
 =?us-ascii?Q?RZAY0nHE9GtBi4ytNghTe6YIuZ02InHey+KFhdX6/fO7xakM8r+/ER6RGXiE?=
 =?us-ascii?Q?nAVcDZctR6Fiw6Y2BnhmRGE6GrNYGW5+cz1xuEvVrKIWQBDokKIBQhL0iJq0?=
 =?us-ascii?Q?wcfxWHHtakgma2VhkxGeAEZ6pQFVii4+1CRLjten/uySoY+iiEOilnGMcp9k?=
 =?us-ascii?Q?F04wrSFIYlzdesSC9zRsIdwvL11rLcHY+6x/NbcaGq3qkoDvCGnasxN+g7kA?=
 =?us-ascii?Q?YJEszn4qMCMiCS8Hi70oHwwAoK0QKUZ3jluOnUKkTKswO6QNx5CX1CMfOuEJ?=
 =?us-ascii?Q?NeW3wgemTGGkvUZxuGIsaEU7/TMumPJb7vbeuN0YsPF3EPB9LZQ+DYZ2qgB0?=
 =?us-ascii?Q?W9m8FbOr/WPAPqYIpWioQ/r6Uac/qfhkpFKN9eXZotsoRaaN69W0ZvIefRCg?=
 =?us-ascii?Q?oVLwze0LyWCLYziXTWpn2engDZ0a+czUNj80szkezi6btgW/8/820+B27T9/?=
 =?us-ascii?Q?UGgVzgH8VdhLGEHr2xwf9ZAvgDXRdaUiMp4uQkfZ+9ACgrhiATN09+7YQdZa?=
 =?us-ascii?Q?Jqo8nn+o8MeXrOnQZWLduoEXzdL0qv/SZm9eQkIc9ixYTrPFjWK+w4U1rWqU?=
 =?us-ascii?Q?YULhUconBcq9ds55o/g4acSzWbpzLy4xyzpH/2HiUeRd5awe3Huh+2iEUAEM?=
 =?us-ascii?Q?qU71UQG9SrmH1DkisJtpChbumBWvqB23PkFHlkffEJsddE8fylTfVG9TQXnd?=
 =?us-ascii?Q?LFEfVZSWYi1n/NcLl6SN1+gH4wcs30uZjDnYkXrz9aMf51HIUBFWEl6OWrPd?=
 =?us-ascii?Q?x95Ltrr9u/Hv55LcOY7MWWFkq9V0zeXJ7kP6CZ/12TTdpE06dUnbYths6nS0?=
 =?us-ascii?Q?MFtfi2KQ2UAIgiuda5bqpUFHsTA/IrK5INLEek/niLgXpAV6cWlRuJ5YS7fO?=
 =?us-ascii?Q?lPQxBXZW+O3WrFgPsPqbtnl7aEwOgOxENwZ5kL756YC35c0i/m0z6fAWtcU1?=
 =?us-ascii?Q?w7f467Hyjdbl8GkLMMEg1gbX+2v7kwwmq1B9ctvwgA8Jn6BUAy1FxlygCRhS?=
 =?us-ascii?Q?dshGBbRNeZVr3pqft+KxCgpqGYnTe2L6xMUqgnFYZnmt79pbmZqWCcp5XPz4?=
 =?us-ascii?Q?jOClukMgwUv2JwvJZsWkQmT6OhiFkDrZw/o6i4KXxrc7WF0qrQh5Eib4HPiT?=
 =?us-ascii?Q?3F32Q9SlBQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e86810f-f25f-4ec2-8a1e-08da282ffddd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 09:26:21.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l8MdnTxDSPJBaf+ZJxziI4Zp254LHLeLkU4sHqPc6qTDkTJYlyrnkH97F/LHs6xMYOtZLwnY2Jx9qCZkX1o5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core will fill this in v4l_fill_fmtdesc(),
ensuring consistent format description names.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 869d2c388122..c916cb08b275 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -389,7 +389,6 @@ static int enum_fmt(const struct mxc_jpeg_fmt *mxc_formats, int n,
 	if (i >= n)
 		return -EINVAL;
 
-	strscpy(f->description, mxc_formats[i].name, sizeof(f->description));
 	f->pixelformat = mxc_formats[i].fourcc;
 
 	return 0;
@@ -1702,7 +1701,6 @@ static int mxc_jpeg_enum_fmt_vid_cap(struct file *file, void *priv,
 		if (f->index)
 			return -EINVAL;
 		f->pixelformat = q_data->fmt->fourcc;
-		strscpy(f->description, q_data->fmt->name, sizeof(f->description));
 		return 0;
 	}
 }
-- 
2.36.0

