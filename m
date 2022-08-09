Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D083558D408
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiHIGv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIGv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:51:26 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F398519C18;
        Mon,  8 Aug 2022 23:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVucz5FVWS5it579IPxglEpZAIu0jtR3yEBmFhAhyB9/xfnSLiVRIpBbNvjjk3FAzMDP93PTw3I0S+yONl9w19YU/Y2qFMgNfC5aXemnAfGazT7zOU9ROerfRCYtwhGu+sCNbxBYXj18siwrIkHEp7lSJdLHejsLoqXDS1I2HwaNeXDr2zne4d71tc/d+TbbnWdQU/j167UPAOtKUxW+ZTZpnEvwTBN4gbbVbKX0f0dwnvkQtNwS1K6ys7PDSweYfLwu2+9DsBT6ngAVNRSCxonTcBTQkjXIb8QaTLZ3QfHKZyqQ+KAtbqRa4FBqwDwpk9x8GPM6pmTbix2ylORwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nunFY6PB+suxzJNJpqaow7igM+cXdrpCdt8TqkjXzr8=;
 b=PjNv+zFN+WVFYPyX45aYi1gH7zY3BDOsdZNfxzJFexChDBRWruHwxntEnIFSxguCSInH2nAjcxn53SpNdYc9rLfEo60cw17zC0G1WZqYMXjY30IAABIP4xvtGV4PTJl+/t2WmRE3gAepWLknvA4dq7SunNLKhz6yA/TFb1zcAcjjW30DKfTd8AVrAqWfJrIGNMx+lOQ+5dTSgiuQPZEk+REi1UCyR7rsgfr1or9TinWgXg+62NoU5OZ1uVvFyMTf5IUt9QTIAi5xrWvOUShjL0egX6USq+seDcs1TuxncJX18liGUDfsCWo9bJVWEjfc2GnsbujUQsWp5AGF9JGmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nunFY6PB+suxzJNJpqaow7igM+cXdrpCdt8TqkjXzr8=;
 b=rSBNwWAfXPDYP1okh5ABCBexo5hOnOb/nMm8TYgDVSUCYlbGIm+Y1jYhjMSiY8OD11Qpz+G1AFzKe8uOiEo74qmUsOvDvrrQr/9I/MFhiH2mTM8hx2gIRltXx+v8mGOS9BMEC3+mjIdCGZuRR4x2ZR3izq/lz+PzXf8NId/fMR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Tue, 9 Aug
 2022 06:51:22 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.017; Tue, 9 Aug 2022
 06:51:21 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/4] media: amphion: add support for contiguous format
Date:   Tue,  9 Aug 2022 14:50:37 +0800
Message-Id: <cover.1660027440.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33876da0-4c41-477e-f1a5-08da79d391a4
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2438:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbjkPJ9n+bKFgKwNU9ZlOShn5tYrmd+/Ek2l5cWVj3M9dSTLRiNrn3YlerBFLT2jmJEwLMPt9Oe3esbJj6upl9zN2fQKpr28R93TVdg3/bCUsGfYzbDtshTaXQSPF0v847DWBC5TmZGDZdzDLsnQp/Fz9TAJD2fV/KT+Y3eY8Q3C5AIFoMELFz8FuWNoK3YmdVXHaXly2wihQE6UBKKlywzfmlGLlrRg6tR5WLq0V2cdVmTgwzQGAPvuDw/Mspbi0pBU5tyQr2YKPHpyyu8Obr64nNf9ZDj75XwLcySCJdM8keH4WtdHI8P9aHCR4Gz4m8B848t6OWKlLzbd3hMMMjGkIXNZuHS000XIiwMC1MxkvnjCFZPrApq2SWgpH3J5wx9Ca+jkmU7O6au87UXFlzInkDKoyo+jnU3LXm6VrLqjxMXhK4aX2DGFdSUID32+GzX5VUZ1JJdQN1KgqhTNCENiVZ5glPfJnPYmeOhxbi8hvKcBtItDD/N7PlNvOuqyl/+479wmd3/5TB0Hf/bxjEGIV1uhCSeYtGjvl+RGiU4CJyp58TysJ2YpycImr9O/SBY4sNaeJ6KwkL7aL7qYYa8Khwl+wdlGNkNxGzzboe32XkuW+TWnU+8uZ1YI5wSdqM1ff3TASwH8LOx5hpm/Vd8s28A2AbrkVodMvxZz7cpPmcRhZxJ3zpj3l4mhL3Ci5egWPQ2arCU7an1dxuamzyPEI9bWkRrwuggC81YNFOXj0IMonTZg7UES6+D6nROxGPkzm3GRGTdWYe/KcgbQgk32izhPRgo+naN2vVsW/qSBxofZjuNQImnZ3Q1zYz1K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(6486002)(478600001)(52116002)(6666004)(6506007)(41300700001)(36756003)(86362001)(2906002)(6512007)(2616005)(186003)(26005)(83380400001)(8936002)(44832011)(316002)(4326008)(8676002)(66556008)(66946007)(66476007)(5660300002)(7416002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dVDRsdrX5JrHv15y94vwliUisGLDt+7Rb/kuJEvSM0o9RM+QNeE15Q/cCggq?=
 =?us-ascii?Q?E8VLXXNVqd6hfnwlwr0VS7Xd98DJ8dqyqUERBCHyFA5W3DGNR2M37t+QU3ob?=
 =?us-ascii?Q?HovWw+w4bCybivkP5iPUp6axIQ1GshlritaR1IddTNoChMM3RSY+fBChVq34?=
 =?us-ascii?Q?sVKDHkmqzK0yiHEymD7HZdJhXUNE3TXcK4r6YJZMmfNDNtcisWbqjeoJ3swj?=
 =?us-ascii?Q?4Egy8ig+RPXhyLTyDhtF0mdf9sp55IeZY3rFhbug4cmjAAqOSmdYIHAsfD2R?=
 =?us-ascii?Q?lR9E0Q4qRW89dpqCoHkvSug6yewZdlqLO4/0IjyIcqfJRmGSzozYT6VTtBsX?=
 =?us-ascii?Q?r15PYKWsYHVZey+dNpWCR+6Mhp8GMIxh7dp0+U2GHo0mMeB/pm1fQn2Yqoce?=
 =?us-ascii?Q?jzN/L6A+LXpWGmnQqFb+PGFhXSSaDidG+hgqMt/icVfLgzj0u31XWMYGnCWq?=
 =?us-ascii?Q?5Xa3uwL8cEMljXEd3pzqpbwxLmVd1gFEiht+0G8RcxEa4GJCps7TcDOUvYcm?=
 =?us-ascii?Q?o5ANFQa6DnsYcwangkM5uZAuui4mXvdkq6bnG+SnOjXeBZmH0PfGHTgWivEy?=
 =?us-ascii?Q?2YZOzfzW15XcUVdr7M9zWvY/NvFMQCtt4pXToH1IMNJW0Ypri/a4GLGF2Nxl?=
 =?us-ascii?Q?JlTZsAhel7x8cN/9J7/XeSjD8jVF3rRGsFSyagJQwWTclhjp3MDgvh/OIBYQ?=
 =?us-ascii?Q?imZC/lSUQzPKxrzL1lDb90exKecLzvG+/Pe1LVSRYQjdbDhi78bSWFIoHedT?=
 =?us-ascii?Q?IRCOCSB08HS/gkGVNhJxxfPTK7TsbvDmpG0Afj6ttRPMcOcNdZc1j/hSqWqG?=
 =?us-ascii?Q?2KObWUihzt+0qfwmIknhfayJHvMuT+iDhvs35KblnYLCAdzr3oOnUQcHEo2o?=
 =?us-ascii?Q?4SiwVZhdwrIWvXEGGVMc7nWc5EyFXgWgp27cXyXoMr8BAwkIPA0tD7mGyG6Z?=
 =?us-ascii?Q?rJrOPsV4xXa9J3GSTmWliRV3H6Ay+Kmkhd8x5t0cwXmVEeanGpgIfL7UWcaD?=
 =?us-ascii?Q?i4qTGJirfccyhc8/10W8GaM6r3OoVdMHiQsWaAmcphWa4wlHl8R6IOM3T8Tj?=
 =?us-ascii?Q?VdPvwau+PdTNMY2L33HtzncqWjVbPKvffDkqMv9fzKKILhdJfeXsRYgWQSCT?=
 =?us-ascii?Q?7XDr09RTTaVlD5ltSYlkz5P7LLOVRpIWO2JRnUiXy2q/+ZZunKztOAq2I6xw?=
 =?us-ascii?Q?bl2dr5YYo1ighlSIE44pRWqaIGBHdB5C6pS1l1ZcxKJnxaHHxf0wz3sdzqCg?=
 =?us-ascii?Q?1/5AGlOOYflnI2b+Z8J7wdKUw9n8Oowi21HclcPGhqI/eetVAcETkuid3MSv?=
 =?us-ascii?Q?lRUQdZ0KTBti38z9xwSzA2x/COeyf8L9cgWumDSeBzKzVOKwgIpHlnwePEjE?=
 =?us-ascii?Q?Wu3kDEa/xKFCyNPBRilgrXR6JboNjCtqk1LnniqMkUD4LU0fGrKWBp0BvQ/w?=
 =?us-ascii?Q?UiOpK206oNdRFyg//8cjwtSx1CepiT78+2zrd7nlEaeWIYn2cdroIUZPSZ+O?=
 =?us-ascii?Q?mndxOh9y/2Wkowe5ymDS6ThuGle9wj0uRL76xISYusglxOkaJqLaCgOFA8At?=
 =?us-ascii?Q?X/hSrfg/TNaRwuf7iHqaKAdIMGFPguQbyhqWJxyA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33876da0-4c41-477e-f1a5-08da79d391a4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 06:51:21.6475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzogVsEcW1FWGe7Sr5iG7+3Yz5L+Sk72dvzVs/7zobQ1cQH7qJd5luSRiYXCyWBeQ2T1NWBYPJiRFqJrxuG6pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2438
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/media/platform/amphion/vpu_helpers.c  |  48 ++++-
 drivers/media/platform/amphion/vpu_helpers.h  |   2 +
 drivers/media/platform/amphion/vpu_malone.c   |   3 +-
 drivers/media/platform/amphion/vpu_v4l2.c     | 168 +++++++++++----
 drivers/media/platform/amphion/vpu_v4l2.h     |   3 +-
 drivers/media/platform/amphion/vpu_windsor.c  |   8 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
 include/uapi/linux/videodev2.h                |   2 +
 13 files changed, 335 insertions(+), 165 deletions(-)

-- 
2.37.1

