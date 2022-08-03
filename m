Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3405885C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiHCC27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiHCC2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:28:51 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130057.outbound.protection.outlook.com [40.107.13.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5504525C76;
        Tue,  2 Aug 2022 19:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKSKhnKxC7zl2+6Sg+GrnNyn7ovAXDeOpw103bjTIs1Qc3CfsG8BfPveNm2NfU9TJ5ux4Evh+WVeC0DXbXzVEMCbRdyYgTF02WZawAWT+BEr5vxZfcLpcIZ6KMQsTN/3bU9UvLKCkRW64onFRq1zXfuMZeLCUP3rlfgEBzlNoUY8SCLBI1cj1CjMC/QbTSXCxTKQ9KdZFBoJo8UK4ddK8d6rynfHOyCpvOE4VgnqeCu6NcYpMw15pQ/rVDwJhoOydag8JmzGyAXYOllyLzjsI9xksIsTpDT4Hv78aXCr6pktkyec9m0gqjtDeRmPLPWG0WrWN7qy50VyEseXRduToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDkTfxNOWCMwgkEiHCmfKKRGxwS7MQ9xxBjraUxchBk=;
 b=N/1HIJPJvbmTEFusxcrlsBoLWGt7EkvUjvG6GoupRiSeUouCbwXl8e3uJaXEyjYwPrhhBpr19LtLzn+L8iUav3oVCPQlWBTeseZeh13Bo6MyAGyH6fqirY+520t7HGwhjqAMabnUmMMxVRnn5z37TGWOBuUH/6Uzap+nZTYSDofKvXavSqWuYXCiCAz/fs7pfI/lz+dlE3bKuYjV1BA+8gi/8EYXMs3SZldJOC7i6QX03Fnd9l1qX0NmODW2UDdDCmHl3Od9JuJAvFIL+3ISNcicHG48SFgqykL60C67t3+nkL46dSygv4+7XXlbHAmJIdTbh2JT+goMO4LGTOXLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDkTfxNOWCMwgkEiHCmfKKRGxwS7MQ9xxBjraUxchBk=;
 b=aVIz6JfCyAY4Qge+GipsQO8Igu+7yJ2Q24eA0YK/jTG3rr+coOtlN2QvIAAPnRub3LSPkW4C9RIwPk7oYZJuycIs9anDm6QHnd+ZrwunPudGuEsd/AFpcPwFRNV6ig8tH0x7jOt0HcmxbB8VclttIKHeS4Hla+JmG4XPuZG4eIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB6PR04MB3077.eurprd04.prod.outlook.com (2603:10a6:6:8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.13; Wed, 3 Aug 2022 02:28:45 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 02:28:45 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/4] media: amphion: decoder add support for contiguous planes
Date:   Wed,  3 Aug 2022 10:27:21 +0800
Message-Id: <61100d063b37d3f8aace352d2cb272ed8dd321c2.1659493105.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659493105.git.ming.qian@nxp.com>
References: <cover.1659493105.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00044e0f-3a37-4b3e-a1c6-08da74f7e38b
X-MS-TrafficTypeDiagnostic: DB6PR04MB3077:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xg9eZ2wmL30JE9neHZLONPxlPp49IMhR7HifJzeQKg7C/P9ZkfY0EnoSF/6tLPyE0VtwOaf12JaBP2Alr5Q/NrbNKFIOE4+4TwI9c0HTM2hDWWWwomVI3PNRUR1rmI0PoQQL0nZmUiTiCYKg7UAcywbYWMEMzFfdskk+C+PNRpVOiXmaoq72FAeLvox3yV9KQquV6XczrdwaW564XMXLjR81gi85IfoZ91ZJ7WiPwQaokrZh578inYZpAa4/e/ngOCZUTiTMb1UHIAPG6oc8LXFNq8pxdl4gBeNXnO5tjtMJL2I73bEoVoi6doQeZbm4Ai651ys+13tb07ByM+II+CgyeCd3V2VreEBKbHsIXagP528MgVxou1i6x2uIYX9V58sJnBAiE1+Hozng1ETlZteBH5fS64/vhHYuh+12cPx2BVyqTXn8mcA/oZFHfAA0gQZUf+hxtmxu/cDOx/RAfh25HfO9lCliZt/cF3rVr86XSuU3WmUcQ0Uuh5pxYyecDwXlxGSq7K8vlFoaHxEGoU+39fadmYAAQJTo8LnA/qe+iSMj51xd0m3pBglIQ39rqcSBPfkCj+douZOX5hkSq3m1BW/leDg89o5N8sUndXfqZJjeWAauLoX7MuYPfo8FmdPJBOyGzN3t9p2an4qRr3gPiIvz6Ww5n/EDDR5IPu726q1ATThzVe64Gr3IZsPpiof6S1PpOjvi7NwswcLjbCQFZY7KqELHeIQGGNf07sSVV62kFNUZvS9FLIrUk58T973y1KqYynEP+2VgE/CY1RPEZyD/2wHg1ZQghFQqVM/EV9WgJKs42JVoW6PQMD0h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(44832011)(5660300002)(8676002)(4326008)(66476007)(66556008)(66946007)(8936002)(7416002)(2906002)(36756003)(86362001)(38100700002)(6486002)(478600001)(41300700001)(38350700002)(316002)(186003)(2616005)(26005)(6666004)(6506007)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PU8Fp4sj2DJXkDWEsosfLSm0IebrQTQjAsRe/J/2QIc4ERq5EChu0W4SIC/j?=
 =?us-ascii?Q?GoB3Qs85624SDwDSTJxKOd9ANWteWildnyWiTl0P/aQ5i/j4Nh7YfoG8uADi?=
 =?us-ascii?Q?380U6bBsLI/W8Wv0RfX4MeC7jlzHE4vNB1kKMcktjUR6ZKegUtFoCt7gxLig?=
 =?us-ascii?Q?T2lWwwChBS6ePfFmdtnXDlT2QdYlCRkrH8/Ch/4udMMdKXRoO1gNk+Y4DFcY?=
 =?us-ascii?Q?oMTEOjFaEfecy92pOEx8mpeJESFX3cDzQpCPLNaYwiaGjLDhck2DiEAVN4BO?=
 =?us-ascii?Q?oi39SSuJ//Ms9vL5NCr0782pqU4KcCHcwpFx13HI0i1zCd+f6aLJ6wWtktTC?=
 =?us-ascii?Q?BFAABSqYsilwzgxGiAuwp5evfqdOhzaFpkaC5KvCKXmrZ8vPtgx9wSbsbRs/?=
 =?us-ascii?Q?kD/UWZb/KW+GVfYPS/uFGk7QCWoXewesVELyxpmT3yphgBZ/AQe8Lj6KGQ3M?=
 =?us-ascii?Q?aSfprG+N4oA6a3T/0hFS+igomrn6Hdd26mapPHxbUZINSKI2gC3aBksD9rUR?=
 =?us-ascii?Q?ftKNLBRgKPRqRvXdUdewxRifM1OR8d0svkCGLPuCF176qBwjk3+Fp98jFgTb?=
 =?us-ascii?Q?xkRzigFdhDXdQwWrVXjfIM0n5W2lOtvhK6fFsPyC4Cxea0XHPe4wKkCA8vy/?=
 =?us-ascii?Q?dr+J4nI7a3wEDs5Pc51FiVB87Wi0SyfOubi0JzEdEZjjwKY4PEng1ZzS+VgU?=
 =?us-ascii?Q?kZ5rAHa+VDhcubDaI2tqjV2qecGFRObAzwAir1ZSbKN4rPftkgNp4u8XKEH+?=
 =?us-ascii?Q?/6eNqP7MRPoalBBx0UwpQZiOcfQBrqbFuoatZTCBOIiDMiDs5MLC3GGAXis4?=
 =?us-ascii?Q?9r1T4UvOLemAhwKPKQbMkr/J8Uola52z9Z+eV8dPRRoZu+OiwDIQs6hfhDKo?=
 =?us-ascii?Q?QimElLsR5CFjAU2+RPiwMzMPGR7e2xOWpd7gG702/3YkM3Xpol5YxGXUNZ5h?=
 =?us-ascii?Q?g/HLv8FIO4kyqnUzfEdUjZD+a12FANYHPri098eDLFpEDDx1t2Jjq6aXGZAw?=
 =?us-ascii?Q?gY1nMnLVdetkKkinBdFBVkYFlgylEjYiiXnt0MSKzJpSF0AJZbOCB7UECIpl?=
 =?us-ascii?Q?Y9I6auuhADVg2eSlRzZ0kGrHauHvkm3CIpujAES63UWpLI7ieWfc+uJcPiu5?=
 =?us-ascii?Q?1Yxbk2TxacuURoVRu1tIf6QtQxXdlV9rds45Y25K6e/ezw5GhnbpXHyl3he0?=
 =?us-ascii?Q?6+GTJUL/99TTMpBM52vzst3E1jqmvVsyNhvX/AhI7FDDFB5SDQNhkjHvLpJG?=
 =?us-ascii?Q?ldkuZDtk1fY6CHcXJFu15IeX/fpGwbUywvKMmPLMo7t/OQZ5G31rLU6u6jCP?=
 =?us-ascii?Q?BJouHF/uSbUEiiWGtnl8Cv20MuGuEGS3RBgRee/Xw4BC9kHRY78dC9DIB4IK?=
 =?us-ascii?Q?6bsxyf74Ajx/+iw+sISX7PkqGAGzJ7Fw1Rflsbj/G8E4RNp0UJczglUgx1xv?=
 =?us-ascii?Q?XDQa6q9XmwxBjDhFjEkJct5UnvsPvUQtdDfdHLMtwd4R97DMZ945u4k5NQhL?=
 =?us-ascii?Q?xsslgf0fj7EzzhEmGdnVpt/Z/5V5sFCRXPA6VWxTrTZreSbfnmB8MCGdrvUb?=
 =?us-ascii?Q?fOnMLS+B84rdyRsvImpoTOkuDzobG1OUob9HeiEr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00044e0f-3a37-4b3e-a1c6-08da74f7e38b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 02:28:45.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIn35qM3+CknkGKf1evZhQUCwt0MUR0ju43HPOIQ8bGl184NI1nNC4xJkOGPnMGIUW1iG6cPKE1xfK/stPinSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

decoder add support for contiguous formats
V4L2_PIX_FMT_NV12_8L128 and V4L2_PIX_FMT_NV12_10BE_8L128

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 48ab664fa7ef..9c3324717cbc 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -72,12 +72,28 @@ static const struct vpu_format vdec_formats[] = {
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12_8L128,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12_8L128,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M_8L128,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_NV12M_10BE_8L128,
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12_10BE_8L128,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12_10BE_8L128,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M_10BE_8L128
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-- 
2.37.1

