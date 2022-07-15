Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394B3575C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiGOHib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiGOHi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:38:27 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728267BE3F;
        Fri, 15 Jul 2022 00:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qvcq1f45d8YmFyKZNr6zi4u+XRqmaUjv3erYkJ5kly34C8l7bP7nhF9H+ibutG/VAlu3XVWg4rENolq15mDcvoGJhJVBeYiB6D8MO8aYmlrg7r0FpfvNIvZx1t99y9GONvcEXVkgyRvWWpaauoZyImIxIjejcQRbylAVOAvOTNOkKsyNIkgxLNOzqZ7gjUEwW999XYKiqUjCa8+0bJ0iMYnZphP0qp4a4TX1vPKHb7ZzksNRmaHzBbvNgd8y3/g3HXomZY7qg1DQNP4ryjAjPq0yjhlW5Xb6MCt+pgc3lE6DXGDIMlMy1YScjIZ+0DwqEuz1d6XqD2vZEHqM4USzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mk1HscuILBLIFPDz1yyxhRcAiq5JCH84m49FGkbG2SM=;
 b=cwH5rZnDhksaQY08Vd9t5AwqJrT7siKgRvAjgSk1NyzKPt0sVe/Mlet9dI1gH5QckZxElXA80p+HxNVSOEe9TOmWaLwtzKYuGIO/zc+ZRBsmZGGbAZ8jL/oAyqtjSQGf+Nelkv3a6jH9pEB1WVZQhgMT7XeVHQTC9gYkgZ9Ky4wIHeCY6PU/tOVy0uUBZf2y7+WhRiL36DYx9eBYjRtq4oaqtjBA+tveQi+ExkhlHSrgISG686mANEBVdvxyf9aVVJBlc6nzI1Cefd17OkhxbheAXFlYNmcsdHjY6S15C0ugDlVQ+4JfYpYWkUphi/fOiwpaO9Au6Nd5nv0H3k/WkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk1HscuILBLIFPDz1yyxhRcAiq5JCH84m49FGkbG2SM=;
 b=sVH+m9HRjpethjre6jxsuxbtycjJUw+GhfsT2/5zWcbHbnSJtjkdwzRdY/a0RqejoEbPYGQvBKJ+lPROuxEqKWGnZpf0tsqdXaE2YHQ3C3wRmTGxbDapIlCFQAuqf9goJoa+3k+gAUGY2ztc5DSrJTaoZQQ8+VaYEUuNs5Fp6eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB6615.eurprd04.prod.outlook.com (2603:10a6:20b:fd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.16; Fri, 15 Jul
 2022 07:38:22 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5ed:ec65:3631:aca8]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5ed:ec65:3631:aca8%4]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 07:38:22 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: adjust the encoder's value range of gop size
Date:   Fri, 15 Jul 2022 15:38:00 +0800
Message-Id: <20220715073800.11321-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9507227-a1d2-4f9e-e8a7-08da6634fe0f
X-MS-TrafficTypeDiagnostic: AM6PR04MB6615:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3PgQHL+0pihVJU+K5Xia2HcMBcN2+82D+qCoCa6DpOhPX4mpdktjxOtCX/oQMoZB96YfmDxjPG2aYi05o6EpX1jnRpcDHSCYrzIMn4GWrwlZgIdg3mzrnyF/GvEJ5X8Lht3TvTMgj8joYNXPh0xdI9uuN/Ry2wYa0xICMyBOzzqVjoxHxEkkjeeyaWVlrbjSny0ddGtVB7Aa6W3my80IyBjWY/an5TK99nhg8qvvjJsDZD9a9MtPbEMu2DKhgMGTKfqS57UauwFJ3NOLUbNEjdNcR5MRjN4cJ3aE0+VYj9Bq+wO0HELKFliJNjncJEeMfBtOtjJ3lqbU/95omaA7KZDrslOxDbHG8GQdTdP2hBUi6q32G3Z6kDBxIz/7nHM/Qdrxkj+UMi4JM6Qg/2psdKo6/aKaatdtGROcEhY9v6X7A749xw69wTpYQG2/EJPJHcZtEwm4SOtwQCqPk1sXMwIkz1gIn9VjFmsyW4FVQmTeoDWG1Kq8RjAToSs5hIW2ZHy7hLfSoxPgdwRAOCi/Hp91mglM5MfqTUle94WJHOHgxtpyNJYTZfdtd7u1aompqI5ZjYwemOIrcEHJ6aD3sX9bXV1mhKKPYCunGJ+SSEGxkhAffS8FPdg9w+FT41cmuk0G+Z7NXDEKubnJoEDn3sd7+u+JHBP+BotH51uczHR4NtMwWU6DxRbM/oBStHqyJPysw6/upbd192Tktf0RZgmcftAeLyfI4hjioVKpaODjznKJZql5w5tIR9ckWht0Ff3atFVYuLlEtzFXbgyjiGJyyjX0bLY1dpDP2pQO3kMkonJdKAHNKY5ovU4WafGy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(44832011)(4744005)(2906002)(7416002)(5660300002)(316002)(66476007)(8676002)(66556008)(66946007)(6512007)(52116002)(26005)(6486002)(6506007)(478600001)(6666004)(41300700001)(8936002)(186003)(2616005)(38350700002)(38100700002)(86362001)(83380400001)(4326008)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iJMb8+y+VZBHVe995BPS2z958LThxN3qfd3VgmxYh3K/BaXCg2EvvWPs+w5V?=
 =?us-ascii?Q?jsmdyHALiTLvE4lCSHFiQgFSqSTd/ZXbLBq4wDgSKuUq1H0Wr8C27dK2B3lT?=
 =?us-ascii?Q?cKPdm3W573OyctRltjsNr6DHfVH8TWYp9E/f+IgnbClJKr40BwswlX3PYR9r?=
 =?us-ascii?Q?F07Icnk/Y/NnHBwCrxlz7fkE8V2S85Y9N/sGUgY+XKSRC8r7BEyjVpVrUDRM?=
 =?us-ascii?Q?MGLnHs0CfCh+vJVvVcZoQXzCaKVVIcw6R3Xo9jKYZ2uaDR4lsct/WtAVXBMi?=
 =?us-ascii?Q?Axf8XnYlJNuOKNO0p7tx2aDI1wAGYg1FlEgBocMcnKZmq9He6P+UyIpWYZbd?=
 =?us-ascii?Q?S+Jw1KDVvfuCbHQJY8oki6bu3lGQHsPpqcml5btsgLwBcEZmn11KoKNy5eUm?=
 =?us-ascii?Q?AM/IceKLSYa9TLlhR7XnOpBmXG/n/JHiqoTcL8alWMKtLWa1THu5KY3xC44X?=
 =?us-ascii?Q?XNdNNyYfeNZw1MuBNHvFF9p03dUmful5weMif/pFUWJ8GXDsdvWJLpVpX3mB?=
 =?us-ascii?Q?mHTo8nsVjqfDKKn1XdzMUUOBANY84qPMGShjiQcUAvj4v4SF7qJIBA1gtwjb?=
 =?us-ascii?Q?zKY536UwDtdznPsy/KzWLHJe3aY8yWd3otsdPb6XtLzu8NYjmftI/afXujxu?=
 =?us-ascii?Q?Gtw4njPfqweI3XYKwYEAhphS4y0BMoAAb50QjlGFX0JT/Rt3pjIEFtGWFXoL?=
 =?us-ascii?Q?B8a5HlRql3pOwka57jhNTbtxz9i8zJtP0gpuVNqk3EnUZPZaHjHOnUdi5dXP?=
 =?us-ascii?Q?R7EcmtP5QbjkwnYO7hkmMNxAAX2mwqkKshFD9kO6Ri4BFb7BTKCEIvHOBYqv?=
 =?us-ascii?Q?aEfM6dCu6bzLlZdC2r6jrIkCKvzXA3XLpRRXmiaMPxMhSGo/RcO4xc6lFYnf?=
 =?us-ascii?Q?RrVERZa2mWP9GWMsORd/Z2cHZk9VsmsBK+GRHujJaQ/nDG50gjAAvcQfgBlv?=
 =?us-ascii?Q?I4vTTsW/7PKqgBEhKnauq17wO9XTulRwOZ2BUU3aeK0FVkMVF7Aav32/8bm3?=
 =?us-ascii?Q?VSdG0FJbmPZcdyZVNXv5EEe5K7WDQPli82zq/YYMLaBquyWQqTbPnIYHgChC?=
 =?us-ascii?Q?lEAbni/38Obqi4vWFbGmUZZkru6bmAJ1n7CPfw4teriJ5vKm/QsJO2mUHA+b?=
 =?us-ascii?Q?+KSxG7yS06Km+Ulsp8tI5iVhNgWumJJFKfiwqrSC3tgq6xAvWVaMtZGYPVMR?=
 =?us-ascii?Q?/72GIf/Y5nKBDiCoYWUfpXiyEcQ3RxyThzVuwsBxe+5WqriuphxAk30fbBJu?=
 =?us-ascii?Q?83vE5B2NLi34C+rH0P1VuoXlkwENekrfnNxypnvX0O4Oe7Kfv5WcVr0mU5ie?=
 =?us-ascii?Q?Kdu2wzVXWJ7Nw8aYTA0PKViQEZA8hTjMLHSzpmtatepv3Fh+e/tPjvwRLDIL?=
 =?us-ascii?Q?GkX9MfgVQc/dCWdGBCmUIzTXMozLu2Djggu9iUlCrSOXpkZ1MLOLwK+yLFvO?=
 =?us-ascii?Q?vEbWJltIzzZ8DJs1tLPiqfSkEyRH6FI/jMYqhHhBqfyua3s040dsx4CF/hSZ?=
 =?us-ascii?Q?cWLcjobeNHzN9mXClUMgPjSdKqZDU7Ocufu+G8x+8truDGmTknuImGz8y+Ni?=
 =?us-ascii?Q?/dLoXwJq8Z5zICXjuGj2RXA2nmaQOBehQiQX7J0I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9507227-a1d2-4f9e-e8a7-08da6634fe0f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 07:38:22.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnMzM53jHt4r0QRv5fyykIu0Py/KJ1urbY9bYMMMFWI1gagqoANEawoy54vYYf48NAxXqbnsUdKJ0rcxrd5ohA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adjust the value range of gop size from [0, 65535] to [1, 8000].
when the gop size is set to a too large value,
it may affect the encoded picture quality.
so constrain it to a reasonable range.

Fixes: 0401e659c1f92 ("media: amphion: add v4l2 m2m vpu encoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/venc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 461524dd1e44..37212f087fdd 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -644,7 +644,7 @@ static int venc_ctrl_init(struct vpu_inst *inst)
 			  BITRATE_DEFAULT_PEAK);
 
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
-			  V4L2_CID_MPEG_VIDEO_GOP_SIZE, 0, (1 << 16) - 1, 1, 30);
+			  V4L2_CID_MPEG_VIDEO_GOP_SIZE, 1, 8000, 1, 30);
 
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_B_FRAMES, 0, 4, 1, 0);
-- 
2.36.1

