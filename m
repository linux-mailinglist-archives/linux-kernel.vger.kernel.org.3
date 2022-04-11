Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6524FB5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343682AbiDKIWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343706AbiDKIWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:22:37 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67593DDD5;
        Mon, 11 Apr 2022 01:20:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoN65JpiP2FgjojkoMVxT6Olna4JxjDmDpPsdXR92kL4d8wZ5/nhXhVlo8EacDJVNNjcNe4SItoFr1D/MSHXGMLOziEDfHgr5pY86v4gnnqZXo9LUpme0e1H8U8o2FYK4yZByd1RxHn58XDFUO3nBCLOW6edZX5hXGh7OvLg+3neIdQ+oJvBHptc3UZvcUsJP/HDoMXFYYMJlwKMp+7cEHkLo8F4ZYSkaxjgF+RaPSlj3rIRr4P8MXyQPlwDlcnVzrvRedo+uZFSCqKVXz+yR/4GOn6J/kPmqjxk4h14S0Xd7N+3dzHaUpAoSQNKoDcXRrqUNezy16YSjR8lDAmMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W13edjOYsUWO4npRw3m0INekIfhcfO+9ruYVSYh+ob0=;
 b=h46Ay899VB7jL/iaKaxKnchmSJw2Ie7vlCIJelGZrv10koBnc15gyvp84K0/P/7QLtUbvoemhHiXD6ZpCxaORMq/9K9KY5kqcY4GX9JL5/PJk1Usak/RtdxUMA9nsFdX49EnSPDmPZJDWWrHzJjwVWSlDRnu07RnYugxhXIG1tww64SavNt4AE5HRf1y33vypWsjY6ee9n3x9UXmjDWF2XXTNyqWrmJCm0bF3Bq1mL3lBdBqyFFR65BCalkzw7Bzh35ad82nEjJ4u+7Csir45kvgsfZKTOwqr4V6Bk30hNxkgtQ1/+71THtxbSJDRK7EQOgP1x2kdxG7s01OiZlqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W13edjOYsUWO4npRw3m0INekIfhcfO+9ruYVSYh+ob0=;
 b=EQ1TOq5MBUoOt/OXfX2a3gYosZqZDIKd1IdUJzWqqXkdjOVxtP9dLRXCf1ieY7ncXfzcG5bNgHvpoD2Jtz9Hu27g9UdIXKtFf0Qc2/qUda0I3mlzLe1lGgh7hUlhBGz1AhQF373ymI406adoizD5hImSTZQqh16E9OapNHT0SkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB4585.eurprd04.prod.outlook.com (2603:10a6:5:36::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 08:20:17 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 08:20:17 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: don't change byteused of queued buffer
Date:   Mon, 11 Apr 2022 16:19:53 +0800
Message-Id: <20220411081953.9021-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 783ca054-3fe5-4a41-a2f2-08da1b941c77
X-MS-TrafficTypeDiagnostic: DB7PR04MB4585:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB458546EA8749583E28DE85CCE7EA9@DB7PR04MB4585.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57pWprcP+LUZVddHqLBs30QA0ZhyU92mCVkgn/mQtGmxmd3GsnhpenXxA+oiBezX4/3pzoyDNUSekhMMgub5Zs9RED7vBA0TxoNmwfqdI47CElnR+pUD1dMV0neaOBIU55IZDRTYtbepLqzKhwUX1bKDelkFkBtAwYIIY1Gaoeo+JpzOxspAYJnlWA/LFwh25Y4/Qr9kvB5bsPITjLVg99xJgpliKAJJSm5XU2nLPsuUc1I9gHYGuhR6vWNFF5GN86dUVuVYnceIsfZsq/FZz/zrFvx0x3xj56J3zaJ0QgqT4uUibpW7H8X1Em1PLaqz5ztFZeghODbDnvjsayUXipy1HYx4chtUFbdXlTNFeC8pIBDDl5yEior61JDlHS9nAcXxsoujzIziKWZ/IpmRe3/3cvcWIvq2UFmr4sN7UGhuOces4tpXGEDkWyZozK3K87pj8RMbBurg6J3gQCp/Y+R9oxolqRSgSOcwh8smws+wXZVPpyNp8Ro4WgHrnijVgO6goSn9tEV7Ws5HTFXL8BAPNqco6tk8XWcXaF+Y1MUXzAyTz9523R9kZHK07AGH73dsqfAfprzh5+s+hPOGqFTynRipcTBQfzKz+LZ8a3E20BLgzQwwpz0E8xH1zfwAT+PQrQa2Td9+VqcBzutTqivn1c+FkWDYxrpv/3JkNdgU+3D9jo1mEQ6fh5WTq7/r8jlv3TGyNrluedpZ2gbiiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6512007)(26005)(5660300002)(7416002)(36756003)(8676002)(52116002)(38350700002)(38100700002)(1076003)(2616005)(66946007)(6486002)(66476007)(6666004)(8936002)(66556008)(508600001)(83380400001)(86362001)(44832011)(316002)(6506007)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9JetpnWxfp63ZWfLCdm4sy4PTxD/+MA/FX9dIQGWeHPL6NmqznT7biGPScUk?=
 =?us-ascii?Q?+4sxN6OV9H/1wAzL/DYnh6G6CcJo4XPTIKavbEISuITnuq9oDYWvxmU12dxW?=
 =?us-ascii?Q?QwTZxqLlsAF5YQhIJBhzapfvHP3+XoYjnHaySUFOz0J79lBAhhLMNdKFhGqn?=
 =?us-ascii?Q?isJL21PNCQTBm8zs95LVN0oaxBiScy8XTw7kjBbcjeJoTxo6QcuOwUseZUOP?=
 =?us-ascii?Q?+ygAbaGtSANnyA0H8JF9o4NDN04C9vdhyGmeWVF4V1iJxS32CStn7/0tM82C?=
 =?us-ascii?Q?KkNgMBqicUNf55m6OffgrXJwO7O3z+ysDwAnmAForN4q8Bjey2Oe+UEQKeLd?=
 =?us-ascii?Q?eaAJCN8i3Wt9s/ylBmHohaBJcRMBrw95FmQoDicS2TFTa17sxup/8E0Ikbd3?=
 =?us-ascii?Q?Cq5E1pbD/tNu1ea4ymWLXS3zwjtdGEfrJQCFutbRIAyg+ErrwHkxbN/rUK5k?=
 =?us-ascii?Q?pwjxD+bz8rEcjVw4/IA3WHS+ls0wr4lmfMjh73VV8IJlGFEbUyzMLmyOZWrx?=
 =?us-ascii?Q?/tBZWnUUyidu0fqaTslepR2Hzzv2rzs5TBmeYW6q9XdffzG91nAXMwcX3IH6?=
 =?us-ascii?Q?a2Gyl9/Jvg2XqvrPQQEPYWecQWdaM+ZfnYfHuLhOcQ5gj/doQ3s8UXnI1O3n?=
 =?us-ascii?Q?u6Fzxnq1WrwrMuZG4q8yNIM/BEGrvtTIywv7B3Lmec2tI92T5NalEWNjejDf?=
 =?us-ascii?Q?KZPyIriyxTwjfs2XgBRGZvIha18XXJWp6YTuJo39Ix8H2e3xB8HOJB5gtgg1?=
 =?us-ascii?Q?5EBszRkJg5JDuMeBIdaPR0CJPcf6AhG8O8lDEKkFpdzQq6u3Me/bPPfpp6m3?=
 =?us-ascii?Q?b56pPAagc1aznWU5wQvV9zXsFKU9JJjfcrHSsK3mDr9s85OBeTS+Ee1Frjls?=
 =?us-ascii?Q?IFVS1wPK4aSEM6Y4NEvcH8ZPbJy1dW8H52OgQBdpxgwhNXZIdk7JDO47VF9b?=
 =?us-ascii?Q?+J3Efe9mjsRMEj8aA71sDSj0zbeaPFmW1cxgoFLvRKRgy7q6oteqqAodppep?=
 =?us-ascii?Q?eA5qmrDj17i6q1ukP9ydmMqv/oBZUGuSq/fru1MHj40UaQXwop8UoUkGNAFD?=
 =?us-ascii?Q?HL4XmcY4H4q5RYQGZizpB0/970aAzTwx/YDLCBQi26Y9eVluXlGlsrgBH4oA?=
 =?us-ascii?Q?r+waVdfoW/OPE6UL2sGPB13vRKa+4UPDPBpdAjfxhYyNfYBmDUBYF+ukogVx?=
 =?us-ascii?Q?ncjKR2W3MbH36XZqf7/ZzyKiqCCk7AmbiSYyOvlDFpNH/3Fuwx/p+KxwOcr2?=
 =?us-ascii?Q?rubeCmD7UfCj/Tu5N8etY9Ov6Y2G8XFjo+SNW9Z1CM2YrXismDTP+yP6UIfh?=
 =?us-ascii?Q?J7PmZIxDkhsFpArpxkpmzz8XrlQl/rIhnhiMHJ0b89HebE/JK/jelg+lEXe9?=
 =?us-ascii?Q?B/QiSE8h9AUJ5DvGwmevPCOQ5rKY/5ROdSY07zvLHDorwJyDy7sOhmZhbLfQ?=
 =?us-ascii?Q?SUUQ8fxUIgxikqwY+Qttb5mEiyq8TWV2xYYvKrGGB8BUSPRI75KJYkX9awLN?=
 =?us-ascii?Q?CeSQgqBIjZzwOT8x2a1eIWJUbrnR2tMzk+OoFiu/etGGQXRZc/B0wtKEZmim?=
 =?us-ascii?Q?WCxNQOQ8IEqvFX1kK6qdcYgL0YCnrEQW2URwtQtE3eihA/71IDX/IFF9LsAG?=
 =?us-ascii?Q?ZjiTRG+2VYeDIUGPpDGbwHUOM8EJujXgXPwRNsKAh+3y/xRmcuhxIbbwxn9A?=
 =?us-ascii?Q?jzt9DPuoxSIpYymPavtSd7S/AcFMEm8OptmWzfOEHoS7sBQGfi7ZMEjfgQux?=
 =?us-ascii?Q?4nVURq9vgQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783ca054-3fe5-4a41-a2f2-08da1b941c77
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 08:20:17.6027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZ88Cab7kd0zthMBeX9Wm2nwIYz6azEKNng1amGg9/6kSupE7H3aMquX9eaA9ebBrmetmCFa2UTMOEzTJJk1vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't change the output buffer's bytesused set by user.
Drop allow_zero_bytesused, since it's deprecated.
This should also guarantee it's the application's responsibility
to set bytesused for the output buffer.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 8bee179c5cec..930cea05c40a 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1470,7 +1470,6 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
 				i, vb2_plane_size(vb, i), sizeimage);
 			return -EINVAL;
 		}
-		vb2_set_plane_payload(vb, i, sizeimage);
 	}
 	return 0;
 }
@@ -1519,7 +1518,6 @@ static int mxc_jpeg_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
 	src_vq->lock = &ctx->mxc_jpeg->lock;
 	src_vq->dev = ctx->mxc_jpeg->dev;
-	src_vq->allow_zero_bytesused = 1; /* keep old userspace apps working */
 
 	ret = vb2_queue_init(src_vq);
 	if (ret)
-- 
2.35.1

