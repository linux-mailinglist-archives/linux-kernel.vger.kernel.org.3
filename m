Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA275A06A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 03:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiHYBoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 21:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiHYBnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:43:32 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731939A9C5;
        Wed, 24 Aug 2022 18:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb5h3xWGPO2Eq2FqGYWEItLwRGc/zzf2ti44bJg7tvXdPt2LRQF+g2DthUHTfOSSusMT8ZRx/N+/T+sMnHBiX8ZltH4zq+VjnDaVnfhzHv/dWwQCfKgEIYKp5s1ABXwasZjC+GnzvwKGAG7dzaQx70tAxHN1VYKOmIMY3UUHJLCm4GrUwXT8cv+u3uwwoBnnvDSEBGh1XHEM5ccROa1GmqHYPb9Vb/y0djXlu5qpao2iDesC+wYhRriUY1+ww/0WrBvltkD3mwVhEf7V+NNLXEYDRV073HrwrZ+o0herrhiiCeWMXED8XwTTTZlSp56XuFHCBPK5dj+pW3pwdjj2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN3jsVzVvLvGckwouc45t6vkHS6G2rvcjK6FXq9m9ZI=;
 b=WQhe/YHCTR8H6zI9MWXBW+EPkimmn8PGepBnLJ2n93Gj97saWoGDeTjv2/ZkUNt5PE1UAMhIRI0i78R88YyK9ybPjSoeWOa1LBynUp+G2SyCX3e7S/sC7dIqBWNSmAwWHMPb1uFOcI0ruHy34PjVOotmTc5J5ab1LtgBBJn3X+2E41EogauIDnehvfDH59ntkV2IzU0h6fARFf8fO6HKzz0aAwWwSemPNmFF0YS/hh43HFIEn+YPpf2YldXqYSFbF1uOA+wKT+A/0X+iwn5/oztdz/hCSl2gDVNYIZo5boRn2WcYtsFv4esM15wUubkWh/xn/qbr2DhAvPebg5PS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN3jsVzVvLvGckwouc45t6vkHS6G2rvcjK6FXq9m9ZI=;
 b=gJmVFBR8vQ0kyJllvlHZfiOlkCRpJTcFGANQpbAUN246JTmGFSN9WfSvxD+r76UvDtOnCxaAw0ePngJjCDwTHIqbCAKKicDxI1kC/Om2ciH8gUPcnZaSrN3Rh4JCTCwxYd3YlOKT0xMaeZtikbN1Hy9sc+ph6RaFRNTEGpptt6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB6162.eurprd04.prod.outlook.com (2603:10a6:208:147::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 01:39:13 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.027; Thu, 25 Aug 2022
 01:39:12 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/4] media: amphion: add support for contiguous format
Date:   Thu, 25 Aug 2022 09:38:28 +0800
Message-Id: <cover.1661390673.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e219a408-95cf-46d3-03be-08da863a9cf2
X-MS-TrafficTypeDiagnostic: AM0PR04MB6162:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fO7l68Rs87fsl4QKIiAwqKYs1NOOmLwxOGmCdNcCKZsex7iReOAraicdT29NAJ5WDhHmhw1MxXtmGbLQFoBW2ajosIRrGWgEjsGgQx16tf8wHb58c4Ag4TkLFKeiyerlIrv1QCGH4h/2mHFWEUFKq9bDs6M5+txkf84iQiLOaU70pI6fZX42b7NQvPp3QCWhO8GzpAvVxKrb2GAazvV+2BUv/jR6VE71jhZzgz5AA8UEgkHcJhJYVHurwtZsxjO6Q++viJFvrLgyVRXxJ15KFkZIiK4k9/UGQ0JL2r6PEEhrSQRRKMxFqOcLAiY16O3sMZvYbWR6RBBpSmZVRBJVFce7OJ8nDJv0vWmm/cHrmArL5rE++Iey7xgOCDxh9zxF32dJgy2II4KZrs5eXAVbOOLUHYiCpf4mW8du/tvmBiXzWdZ1u8cV0OGyrEcmSVCtG7Rt+Fp4vW55XasA9cBsXKb7usLQ12HVvjrxqbASQdO6t3wXKvYPq9OwWj9ARNbsABZ7mpJcUvrZVFzhgHtvmwrfxFc46xJHn43LsBKsXc5F/pKbc80Nj1rdBLztTkJF6PbToG8+ujpIvUcH8r+laSJcW5bkD76azGfjK3gu2O+H3U253lkX0BKNrk9GoupRtaoOXuAlwN6aAMaFijcZTm7pGz3cApm0NQVSfibqgI6PDhnBBG5RifpY/gAdD9rU1KuuWF7wc+pAjsUGGJWG1lyAoTit8T+2I6K5Ps53UpwYFCHk37lJE7yOeYUYr6FPIx0PDH849l2Zkx11CGdATg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(6512007)(66946007)(38350700002)(38100700002)(6486002)(86362001)(6666004)(26005)(478600001)(6506007)(2616005)(52116002)(83380400001)(41300700001)(186003)(7416002)(8676002)(2906002)(4326008)(66476007)(66556008)(36756003)(44832011)(5660300002)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z+n7urfkleUVBUWeD3qbmrVjqVqIomPE/E3O+pczeHXMbBvB1/OgjHAgg5tP?=
 =?us-ascii?Q?V+72sJO2wTXiTNI09rpcSmnsLWJ1Y7inbl4z56KapZqrK251HZa1rIqY3nCt?=
 =?us-ascii?Q?MWdBkZyVsz9KNJecOG7OzigH3LR98BQlGBud9RU3u7HLZXIqQrPHoaGnzJSw?=
 =?us-ascii?Q?AdxIFFAZSVZ32TLZTtjxYt8KTDXKGX/0xo4M8N9g+TKOz+bCDQ1a2xYWz3Uo?=
 =?us-ascii?Q?DRQfVqaXGi5Uwh8kchBaFsg1/aVXSeA60iLxG3xyUonKPQlgwyils1nhKo4a?=
 =?us-ascii?Q?zPFIcWJwAQroPEIaDbFFwFB7o080JWtkZQVUr6rnwVHw+JWwn01YlOHskSMy?=
 =?us-ascii?Q?93Aci2e7eji/IkV8++/YqLd4VKGQF5M1vbfLXGlUz9H9LOyaQ0Tmct5kmbCY?=
 =?us-ascii?Q?7d3OAByIfsklhxbbE7pG0Igi/KtjNd98hbNFKv7sV1xwBHTnC0mM1wOLysBI?=
 =?us-ascii?Q?M3OET/YMIMupT8VhA6cnWyvUjdZOLVi9AP9YRiGyKH0OK7WLypgIlG0T+msj?=
 =?us-ascii?Q?TwwEAIGH/jsswm8MQIP2h1e23m1Qh13t4t6EJUPJa/GqcsXuxAgFJNectFOp?=
 =?us-ascii?Q?O7FSP0v6WVeSUlzIzF4ivKiIkNsO6YPUeSFgrkZnq4qDcIMIBth6mi6nCGg7?=
 =?us-ascii?Q?WcA5VlxwRvaR5QWeb1hwnQxohiuCH1Ag4b1GcPUdONvHdGBRAosKIZxPg8+d?=
 =?us-ascii?Q?fOhSI7wwkIL2AfhBwFb4kmkw3dDpeHtrI8THkdwZygIhHNIQYarj1ZulFW63?=
 =?us-ascii?Q?3fW4OpmrLhlnZfPeUsMoF0gXIdY83Do0shFjwTbvJl2nosEjqVM+P+FPW30W?=
 =?us-ascii?Q?oOmJOMLjw26yrM6aMCNJeDlmAFDyvzaVMhnoyAKDBPWKNgCLynFfM+SlBMfQ?=
 =?us-ascii?Q?Yw+taNSQwElsqLGk7gpgtC83JwCeXFLIr03l/ZFddAO5trybpNWuHSHdKHTD?=
 =?us-ascii?Q?37n2xauPDEY0gyzWjxtsoPa3Z72FRyc49uz9eMp4jU+RYwJ9NCfWttntxeoc?=
 =?us-ascii?Q?AzKf/Ol1wk8qGfbRNz6gUPkjA5CcSAC/i8Q3a2nGsoXELl8enkRql4ONccd0?=
 =?us-ascii?Q?3xlVbPAh4onGaH7kScZY/hCF4zS907gAGfUivM8EdezNpMsckDPOlgNhcRnQ?=
 =?us-ascii?Q?waej15ewcfMp16CQKhPuDAWmU/c1UQMwNdJ189hGIO5el649m3PEpvExTzwK?=
 =?us-ascii?Q?lMIrH492nLAzOE5yX8ISGO4eOAooxEw5hbw4FcSpgdozDw+h7RmznF8rpLae?=
 =?us-ascii?Q?8BjVYyh7dLjB3Z0AdB7xpBGQQ4OGux026+8t/Bs0pltLHLi1QDPhY8F0B0fw?=
 =?us-ascii?Q?zU/s8W6sRImw/cj4WHc/hoMP2hkAJOpqSTxnqzAqM3mEkeQ/Ymm8+b/IREO1?=
 =?us-ascii?Q?xng7vADHNkV9EO18OR8Rug8QnneABMvzsp9KCYBEchVPOs7dm5NLBtXOYO1p?=
 =?us-ascii?Q?PRWwPDbr8aVhhkFLEPrRPzQBJbngAuNnebhlJJaZMHDJ4SXzNYA3Ef5aM0xA?=
 =?us-ascii?Q?sPSrdobS/7nePPJSkXNQpbLC4dGhxUl1kJYQI3kD1NwJph7LCZCe8zdFjO9U?=
 =?us-ascii?Q?Z/h2IMiYUaOYEyrtO6UV4tkFrkWswMiyVFEhXwRD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e219a408-95cf-46d3-03be-08da863a9cf2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 01:39:12.7552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brmYSxtXr7cMlgXO22KGGM4yrwd9KW9ar7pNQd7CBbzx2qxyc5i+K2+BsxyDpJMAXynty1NHRY90Ct7BKpIj3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amphion vpu support non contiguous planes yuv format,
but when we make pipeline with other device,
the device may only support contiguous format,
for example, amphion encoder support NV12M,
but the capture device may only support NV12.
we can't connect them directly.

So to improve compatibility, driver can add support for contiguous
format in the same time.

Then encoder can support NV12 and NV12M,
decoder can support NV12_8L128 and NV12M_8L128.

v5
- make some change according to Tommaso's comments
v4
- set bytesperline of compressed formats to 0
v3
- negotiate bytesperline with user
- zero the reserved of v4l2_format
v2
-- fix an uninitialized array index read error
-- remove an used variable

Ming Qian (4):
  media: add nv12_8l128 and nv12_10be_8l128 video format.
  media: amphion: tell and handle contiguous and non contiguous format
  media: amphion: decoder add support for contiguous planes
  media: amphion: encoder add support for contiguous planes

 .../media/v4l/pixfmt-yuv-planar.rst           |   8 +
 drivers/media/platform/amphion/vdec.c         | 203 ++++++++++--------
 drivers/media/platform/amphion/venc.c         |  41 ++--
 drivers/media/platform/amphion/vpu.h          |   4 +-
 drivers/media/platform/amphion/vpu_dbg.c      |   8 +-
 drivers/media/platform/amphion/vpu_helpers.c  |  45 +++-
 drivers/media/platform/amphion/vpu_helpers.h  |   2 +
 drivers/media/platform/amphion/vpu_malone.c   |   3 +-
 drivers/media/platform/amphion/vpu_v4l2.c     | 169 +++++++++++----
 drivers/media/platform/amphion/vpu_v4l2.h     |   3 +-
 drivers/media/platform/amphion/vpu_windsor.c  |   8 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
 include/uapi/linux/videodev2.h                |   2 +
 13 files changed, 333 insertions(+), 165 deletions(-)

-- 
2.37.1

