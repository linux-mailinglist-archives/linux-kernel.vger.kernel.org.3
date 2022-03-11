Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A424D5C06
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbiCKHIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242688AbiCKHIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:08:46 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50044.outbound.protection.outlook.com [40.107.5.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A66BF7B;
        Thu, 10 Mar 2022 23:07:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuALtsidQL6Zd7Q6r/rza3MoqFe8o3AvKmmOtcSo87gBGs8DjU/WwUN1NXoCAxR7fAk04RQK+eL+7jX79VWl7Xb0ztcbIeQVtnhmrTREPjkqsYsqhUMiiQCEIKF+qt/dWIrrI6XTN5eCZ/8T1OaGSDYVXoHcdRD9zje1eFiwAJI0u5Rc1WJIayPqZl9LpWoBYm8MSZXPwtpHVzSCKYPI5zJ9Zcczei2z6MkImKPsCBeOLNTNPZTj+EOvdAwax5dv0fRnC3i8waiVfGIGtpag0I7THi7WCOfZOFDINGnPwQX9it430wVmxrEctSHenF/MfyCJFEStsmyut8awBbnbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrme8dXP4rIUOKfz4VPsohcClE78DN0xpfspCkrVgys=;
 b=ipGc51GcLH9gQY5s8GdtYDO2kCsYk7UjOUS5bBK0xpTQn2FG30u3wtTdYCBOxnKpVsA9V4pyM3+AmyeMmqfH4z3h8EQGbJVJkJ16VjkCRxW3v2LulfSaLSRKTFLswRvq3Vzcreo2hunI7cbPObr5lEPsi2auht0qKC4UJTfHMCFD2fHQh3+WY5K4nh38xbMbdK2MNf2faLIZfV88LOJNng4MfHaQWOIoFH6xdLz7sDnDa7KYNS2eSNBkTgY05q+xdvnn5g4aQftt3Z7QxuuzEqKEUKKsCvqHhJwRwhc9h8VepKd+i9I/pZsiJ/QGNKgC3tC4+VyyZcO0GzTkdBdxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrme8dXP4rIUOKfz4VPsohcClE78DN0xpfspCkrVgys=;
 b=Z9+VKt97SHbmTM3cyhw3t9q8G7yZB2TPLp2dfNyv8oK5d9dNhOm30DlCdVx6oz7ord00yW9Cyrke0ac7jnKDL7eQrRXg19Pdu2JxKcUwjMjfHln9vphxIEkZT3yvBh9n3iDTjDnO9kiPZRWuticrUhnaeKIdjIsY+GCi/4PlMcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 07:07:40 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 07:07:40 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] media: amphion: copy timestamp from output to capture
Date:   Fri, 11 Mar 2022 15:06:49 +0800
Message-Id: <cover.1646981934.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f16090a5-1480-45a7-a19c-08da032dd44a
X-MS-TrafficTypeDiagnostic: DB8PR04MB6714:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB671467330682EECDAFFBFC7BE70C9@DB8PR04MB6714.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SkBlMhgm2Z0kFz/K0dCY6V4wdh3Ke1jLi/LJ4qmMYUWZy7rR01R/1qDoJ8HAkpNPeKOUfU4cs7z727dOyNrJHcBGkVoCGz9eiiIDzDE8AlwWhqvmJbh9uGAGPT4sPvQP6NPcawGtSzx+izqIUQ8h9fgvU+Kb+E59U5vea0k0kN/E37146zYC1wvMciT1xBz2a/A1Xn4fXh5sBdWUbiW4mIYDR6OihVd0nbZeNBtO1vuy869atv/TMwmOk97Il0mt0nsCQcKxvvapqEoaUQKhXnXHsVkT3AR13ltYMnofDVIMwIt4kbGsmOY35WDBV/1I8qksA+2VOyAi4wghZVwHv8NWBVKMHkuTg6oGvqPXK56yKBcyZ/JBrV1IKulXDrKG2+F0cATyDlV979CuEwgAqU9aSjnBeHPmJIp3lQH5JfTTL92XgLoC2/yPWDCPzJb4xkzpq7iOigaxMSzCi7QIadLTdRQpPL0R1x69FqBQJXQS4yCLfWG6vSdF6IeBxGwsJ0oNN8pyxkqCqXxY+yDyYY1Fs3Ej13JVUncZ05wu1KTT51pVTUXKwgZv0aD26WIgmDaZMCVKNk4/wVtGrcCBOW3CozVAQGOZ+jU+nF++Zca5g9qOAcm9Ugcdwz2WQ8Ch7QBf5JHqEIx0kzg96+pYiEVmkMarrOCaHwn0F8uvo7D/nDAVrfwUiWUIIb57RM2vtqdXEHd9X2mRkm2BhW/jaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(83380400001)(4326008)(66556008)(66946007)(5660300002)(66476007)(44832011)(8936002)(2906002)(316002)(36756003)(7416002)(52116002)(6506007)(6512007)(6486002)(2616005)(26005)(508600001)(186003)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GhdC/MqJeQfMaDjTZvgRJFL06NNLF/uYu7WCbdy+chj4eCOa+2Bp9xa6oBIg?=
 =?us-ascii?Q?7MyWIZ2AmV+aRWRjbd7hgDVbzANWGK/zpgzR7FD6dATxyCRHbWi4ctahmKdl?=
 =?us-ascii?Q?GTBxzUQlkYZo1RXWXgVxHnEK5/H9kpkMo/xbQndEWT2rF5kGxJ8EiWEspLl1?=
 =?us-ascii?Q?4WvdLytccnAZVQwQo5vKe3+KcBjSyuhfcTmC8l6BUHsegumi40kzxP1QxAaM?=
 =?us-ascii?Q?yl1UriX736+lCVrTpCUYX7AJlN1Htfw2DfLrXve+SZODIY3oV4vy8k7KLB0A?=
 =?us-ascii?Q?T69s9Oo7882kNFURk+t8FiPCOOYsgArtHtOeuxy5t/xsj8DE0vj5/qpi7N2R?=
 =?us-ascii?Q?u5zIwWA3d1rsijVIsVid28sBUtMAOTVnUAr0P6e4r+nhkt2fb4AdwjuDST74?=
 =?us-ascii?Q?QgQ5nx98q6h1RwGv7ROzO7d5MhWABISVwRMhHE39HWchj6f5ElNuI15ioJjH?=
 =?us-ascii?Q?Uv41KECRzi/dJ0bdP1QMIAK3applRDFNSQnNVvnRzQdRAWz6MpK1QjlOHt6k?=
 =?us-ascii?Q?Uyk0S088flnRqN7qXBVhYWOfat5Tlr36izZg6pFIYoE0k+llpc3I+ggYfqQj?=
 =?us-ascii?Q?mWijJ1GDvbrXTjr07YMz1CZo/Fz2lGBEF88pc3wZjHGe4NDrpAxS8h0m4GoM?=
 =?us-ascii?Q?8Uflyv3xMperpe5x2yQ3KXsaDRlMJckfcv8JaUKcIEvKFckgKPhB0+gxxsVZ?=
 =?us-ascii?Q?ChL0b74/xLJDqzqM1GaV9QAkx7EHhbj568E7ilQFxYUu7w24KhLQS5jiZj+R?=
 =?us-ascii?Q?18eJSip5WSK2zgj6UwyFOi7Rx0GcpTrD0kUHyPz3PDNplyo9VVOf+EQO+jEh?=
 =?us-ascii?Q?ORg63PcIYNEMb6m5mGOupJuXoqM8PMjAqqYR5YEHbLGt+cQZZ/3qoxwSDxB2?=
 =?us-ascii?Q?AUqfjAHm1vjx68kGktzhmM3+cAdkzdtiSp1D9iJ+IhnU5PVh1HSkRHwyTjKj?=
 =?us-ascii?Q?netSY3i9MCAvBWTonV0g3MuQmHluyL2IeHxPY51W6qdSiI6gQVBHYQyKJi32?=
 =?us-ascii?Q?xR+QNnkKwOko26WOEYp8zUh4ItZTVyhmPvIe4uS6aillMCzb1DR8GGKddY9+?=
 =?us-ascii?Q?sralw7Cn09NygcNSAhr8wCzgf8GVtU+UCdc6GtM0j8JHKxatA6srlomVwovn?=
 =?us-ascii?Q?uYYV4g1Dr8FpuJHtSaPcSJg/0qBNfOz3t/6G4QspxKSoCJCJbA1CGGjApfhK?=
 =?us-ascii?Q?yz029wXkOMYkzzE3vjjf35oQ6yhStpxBTDwQygya7DW5KfsKQU8G1Qfo12h8?=
 =?us-ascii?Q?+wm+jbOrUjNI+o4MzECUvIoqCGdce5LZa59OfdjnTXHKstjfekDV9mNxKRp3?=
 =?us-ascii?Q?Dv+Dd5KaD8LBF/ecohh4BWQ6F/RSNrohehFjIYBu1XhIW0WZsSNyhsL3A91w?=
 =?us-ascii?Q?EzYE/ULNbWxuaFK0ka3tJ2F++2V29ohTNFluoj2iIPyLlIqqm3t+kmTc1/54?=
 =?us-ascii?Q?KYASYP2PXMwvcjf1gpblm75QCM2AIdzu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16090a5-1480-45a7-a19c-08da032dd44a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 07:07:39.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drWXrCs1IV+NTpeM1Aficx+bEzgeA4/22FBNcJ0zm6gs+mFrydfvcQMwcACz2IJDuy5e3eEEvMFXYWpcCbSY+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a timestamp manager in firmware,
so in previous, driver will pass the timestamp to firmware,
and when a frame is decoded or encoded,
firmware will pass the timestamp to driver,
then driver set the timestamp to the capture vb2_buffer.

But there is problem that the timestamp manager will ensure that the
timestamps are monotonically increasing.
So if there are reorder frames, the capture buffer's timestamp is
inconsistent with the timestamp of the corresponding output buffer.

It goes against the description of V4L2_BUF_FLAG_TIMESTAMP_COPY in the
specification

In order to comply with the specification, driver should copy timestamp
from output buffer to capture buffer, and there is an helper function
v4l2_m2m_buf_copy_metadata to handle it.

Ming Qian (2):
  media: amphion: decoder copy timestamp from output to capture
  media: amphion: encoder copy timestamp from output to capture

 drivers/media/platform/amphion/vdec.c     | 89 ++++++++++-------------
 drivers/media/platform/amphion/venc.c     | 47 ++++--------
 drivers/media/platform/amphion/vpu_v4l2.c | 13 ++++
 drivers/media/platform/amphion/vpu_v4l2.h |  1 +
 4 files changed, 70 insertions(+), 80 deletions(-)

-- 
2.33.0

