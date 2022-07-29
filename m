Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A76A584D76
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiG2IjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiG2IjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:39:12 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45F963C2;
        Fri, 29 Jul 2022 01:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGQKDHeTOtLwcGLoIgPmHheqLfzQ/RtN360KScva7qcWfVpb/ZEI2V0yAimaZFKdKAhrKN9Y7oyF3NuGE16nITc++8bsNPGpLH1IhpsxDwr3ju3QDodgar5cD02T0M9Sj56OL6dNB6tCFH4OVApafSebp6HiBwU/Gn+HNASPheAMYyTRFdfE/hcj5Lbvdwvjn1bzrxKuFsNWm9f8HJkYarKquGia9x5bFy8xsc8RqTTt8l12/FXoM1f+R8+Kn218xTMnVBFQjpNYFZCF3FEX7cMC5uf5DSiNpVFGj6mnWtS0DM1RvYn9+g+hxT3I8CFPrHMkYrmPqAerA8cmdqIO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdHOjpVrp+CCxUop9kLWNi73a4u2qMf2a2WIwn8ynP8=;
 b=TqSR+ZeuKD/SBPvZjsdS0VEC3K/8j1OH/MXhM+jaLOAtqwO3NPGDt5U26H8vSu+EXXqO0aM1nWR6qm4WKTHKM7gCb1Lalo+IoN0VkYfGiPjfOWVbOLoH+SDW3ZlB+diiv7Bvv2ex/GTFdYnxj+pzFTD2IwJ6Fzc6xO6l/bWeGyfpY03GHp/AvpbjStA63eiT3oUpIaiWCJ1d/yx40ocVfumb0K8RvBEqGeWPo8Ys4uJy8m2OD6OnAtcH8HCGN/zwbvz+NrboQLvkn672Zw9tPucMB1owle6r9X7RAfiUWzXT0Xtei66BKbJc60kmMYlCp6eMicF7cTtymP4Ga2A5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdHOjpVrp+CCxUop9kLWNi73a4u2qMf2a2WIwn8ynP8=;
 b=b/TXk6hngjVAM6J695qobZOX9JLPTGaLgarissNpWT6ENAaj6oprGLfGDGv7snymMO/ReUnmHs3xyRwtDn5/mDknkFM6MJYqpUPUYYuPdgHx1cGpOqG2fRNOFfzcbVKin+y9YlOlGuebQcN3EiOXaQp5Qq+AYfFoG+vFVXxtiFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB3039.eurprd04.prod.outlook.com (2603:10a6:802:b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Fri, 29 Jul
 2022 08:39:08 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5438.023; Fri, 29 Jul 2022
 08:39:08 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] media: amphion: add support for contiguous format
Date:   Fri, 29 Jul 2022 16:38:11 +0800
Message-Id: <cover.1659082839.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8207c54-332b-4c7b-0a66-08da713dcd55
X-MS-TrafficTypeDiagnostic: VI1PR04MB3039:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhHtjyEgfG/CcADhyrameLrNcGZtDeRDmGsULucnNG1bBVQbwLnjNt5gn1bZtN1e9sySpvBkrM3NItHije3ASjGNr/lTiAJKLKb2+quSODaIgj/XVq1un9n62GHTEQEH9XXCZW5sYALPt/oKudLs54fOxGr0xowBamrqD1Au9BCdxU/XNVOrofYl0WhS49/NN4ifJLGXSFzVOIbzKTBwb1ZMXbvTbXrIF9H7F+WPtsObrAwfnpGYy4Dz+sOWxYiqwD7DnpPnYTCvKS3EW8fRxjimKHKwJgHMBu9W5bnIfWx+o6aA5OqvjrFPMRToe4tHB05XdwZP53fPytAbBkIDSfLYB7W1o+I4dwCqEEL1nwnBXlrdtdyaA7p8svUFMOszZqdWbFsyVrDYidpz8vrFJtMHjur6THj4ZzTBPph0Ggsv/6QFEOKRZ3odfD1N9WwOGB1tOO4EJymQhvIIGqLPvWoDZ5ieyG9QvhS76443rDjg7BKoNqjzFNy3R8l6l7J+1I7tdnZHp5aduGeP6v+DBJWND0Bw7g5GjpRyTkIZPL/Wv/ILgO6KLtvNOm8/C0CUglG1OROWVhbH28EPDRrYGcBklAGc450ZB55hngJazWwRtnZz0pIk8Xn7gyUki4vo5cSRopNmGzXHyrZPbRd98kKMoQasjCRHapqUQDQutN4zMKlZCJGpjVcHNexvqBhwf9DaX6fxXlAMadXa/Mw+4GwinPSlMFiKFosjX3jRYzyUYJtBgqJTt7VEpVvLImmXXhUFuuOPDxfhfSNGiAU2GCCVtF2+LRUsWk3mkNkvLf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(8676002)(5660300002)(52116002)(316002)(83380400001)(26005)(44832011)(8936002)(2906002)(7416002)(66556008)(4326008)(66946007)(36756003)(66476007)(86362001)(6512007)(6506007)(6666004)(186003)(41300700001)(2616005)(6486002)(38350700002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0sPzJTffmms0wvu+oKI769Xcj/d5YwA5JwW932jpQGaqbuZOvltAJrZYQwUV?=
 =?us-ascii?Q?sArvSlXerftARJPsGhB1CwEnzafrQUvdQt9wcP/N5euXc+3Aw7Xqq90oeZ8T?=
 =?us-ascii?Q?8LhHgbmsPwKrC3mNJey7NEOBjARX40VkMIUukGmF9t8jP5vOEV2wU8RYQbUV?=
 =?us-ascii?Q?JvrnAcbcmcpzRXfEaEUwKa6Po+hGDBNihwIlDtC/HOVdrc0RpyalDqwMYn08?=
 =?us-ascii?Q?92jAjj5NLaqyPoeQO6jrgVDeOcs+Cf70b8nFidZJPFzztP5HPCTtxJswoCUo?=
 =?us-ascii?Q?wPKy0bOkwyxCVohBWNrtPEu/Ov71Gw1T4M7GaPvt8elvTuWmvgbIpbNfWJ5O?=
 =?us-ascii?Q?b9oXKog1U5vWKRGoJ2NsrgdBrjddFRlVlpRZzoO5AZgFYHJCkTQcpZBwv13h?=
 =?us-ascii?Q?0W0GbD1cc3mZTK8Dj+7nkaOdA2EVDVmY2Tni3qw0kC0YCD6mUR4P2xf58GTh?=
 =?us-ascii?Q?5kdYEMI7/Xud/SrA2j0XF2LLtipRAwjPqfZ2sL1c2SvCPhFdbY0/Y7ZJTUYY?=
 =?us-ascii?Q?0tfKQ9nixF4aBwY+s0QkqRuKpYINaWojUzXilUZe9UrCL1bUq9m/miSgNsoz?=
 =?us-ascii?Q?8UQEmq1Ae82aq3YZwfEtvDGtBmZ5mkgqUWKX0SlB5HAUvH78M6BQ9DL9cctm?=
 =?us-ascii?Q?oca7dNAAmHkvQ57ug4e2dht14G8RpS+ImN4Pvajnu13G2gch3QZiubJAzEHl?=
 =?us-ascii?Q?AnHKt4QXmS3WNiQV0PiIUomUDWjJ3slNsupQNA9NTXC7byKfk8CBGPqXxdqs?=
 =?us-ascii?Q?j8ECBWMQ2lmccV3BZPPGKoPcgV0IfI5Fx6T+GYwybzX7Xi8WJe7+fgyeIzfR?=
 =?us-ascii?Q?mxHos88I6CIuj/dWDpwn186lcCwjCIGjFg31OpD6jfxcqchDruIldb8xKvoE?=
 =?us-ascii?Q?+djjCMAsi5Qp4H4F32D7qNK9VPDVlG1y8wOeX3bOJwGj485VRCSgX+IAuEra?=
 =?us-ascii?Q?pBJkebFe4Jx/CeO8DJ11ecJX9TAx5lLKSokM5TcbnAeFY8WwAblXYIfmpCTv?=
 =?us-ascii?Q?P8qKG82YzLWAMDDr19ypEoWLwnpUj4Elbpwc8LxT5F8AF4+8W2I33MMUl404?=
 =?us-ascii?Q?aTEXN2LBbgQule3QfoWCipv6CM9zzVDYt3ifKd5vDDPPQTnfDSRzQwsL+LWX?=
 =?us-ascii?Q?ykocRjPx+ndiqs4HjRf2uQBe2BLl7OYFnFMYxHkwyaiW3i3GA1T+80oGgVwm?=
 =?us-ascii?Q?RKTzsl9gdmpI82FpbWYsOnR7aKJl00haGW3zDWyfhxwxQQhHWxxG2wVRXcCn?=
 =?us-ascii?Q?6CL6Yjq6KsGWPVR6krnHzE0YZ2LI8mLRmZ/EOrYxZ0yhkUgxevY+/jiwz/+y?=
 =?us-ascii?Q?pWIMuYFfxvNG3PMUulxPUg0iwt8PrcdwfRW4r1f4cjV1mrQ1x9Gtw6p1IBqL?=
 =?us-ascii?Q?qQ6Lw+u53ark5g4MKyQc1f7+rQo8GSjm5UN3wcK/V/GfYNJKD5WAC5Z4U2gH?=
 =?us-ascii?Q?EvrUMTL8u1Gm4fTKW04S9pGsWG3ZkBhJboOc34cjlat5G5gnixKOtRv0WutB?=
 =?us-ascii?Q?3oxB44RI76kVJUWuXGfM//nEURvMHT0sCNn7Ivy06E9DE4/7IHM5mCk0vCzg?=
 =?us-ascii?Q?qk907dh2lG6FGPNgDfEjxQQT7rA2iBAciJXIEinF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8207c54-332b-4c7b-0a66-08da713dcd55
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 08:39:07.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjfzyIY9BL1RP9lyI82EaFSYgSopyF6fKt94RQ/xuLJcas9R/8NQe+OHc+wGqf6q0MFK9w+mu0JF9FHDdESEGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/media/platform/amphion/vpu_helpers.c  |  40 +++-
 drivers/media/platform/amphion/vpu_helpers.h  |   2 +
 drivers/media/platform/amphion/vpu_malone.c   |   3 +-
 drivers/media/platform/amphion/vpu_v4l2.c     | 134 ++++++++----
 drivers/media/platform/amphion/vpu_v4l2.h     |   3 +-
 drivers/media/platform/amphion/vpu_windsor.c  |   8 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
 include/uapi/linux/videodev2.h                |   2 +
 13 files changed, 298 insertions(+), 160 deletions(-)

-- 
2.36.1

