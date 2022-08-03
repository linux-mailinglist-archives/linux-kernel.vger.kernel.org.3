Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007145885BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiHCC2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiHCC2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:28:38 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB98A19C1B;
        Tue,  2 Aug 2022 19:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9TVOfoRWaax3/3i/so/2nqfwIUNA4t9w4cXzg7bv/WxfCp12LNT4AiJZLoYu8N67mRoeS0k2y8TctHbAoldpWzDPiEnJpxS8yzscNG9SNPPvgbid42AZo2QjMfxN41/CP4lHC/oNkBf34CBNd67YadxIdX9sGE6VJkwwa/kTInn/xvCNmqIdyNEglQ5g9VlV0baaXt5X8hKUgE+wVr3D94WJ2SjzJlE4uDA1ioFvKyBAJPzVA/7GmtxfCUUSCOHfpNpRJqQ1mn3jVLHuZq7GKcgRY0beFMkvRwh9qcn6KeVtKIWOYPcTbH4lBBYeTpCGaR/S5VgPbB7b9KJtlo9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK/6a5WbebICGhod1fHATwPFNLfxUxyQZrh5Sq6b1+Q=;
 b=gidMs52uD3KjD4eqih48UAJ7zlOjgGJAbc79RMp8VkwYIyqxbyJny6tt4xOAx8aDF65USnKcAtY7lUYLYPVE/y4DFuY3QCZuavmQGrfGVxdMdZrxdSoy+Rxeqg0g4+JUr7aI2u4AcXx7/9fhcbzMLltW7Opmhr0BvgWtvwUS2XmLbTPkuQzDXcYW/tKo0YqGLmQLF/UzzuB7e1ZxSvgOty1OVrE//o+80nRnSnlOOOtzi9qaOlX1XxRy/hfQ+H1mam219IXjcMZ+m174z3H0WhwWuUrwQD3bFKTO+V9ccbNXH7CDxE6Lu1kvoOoj3yDYyB5cxZUsRLiEsTJQOnZX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK/6a5WbebICGhod1fHATwPFNLfxUxyQZrh5Sq6b1+Q=;
 b=cUSGpOKi0FTkmaZHGIaG4Uobw80uu3/cPonMlFhzF4ks9rBQMcGNHL6znUY+mwOr8iO1uqQO/WIIpNIzpdiZbzFJxQX9ZaCSo/qROq+YFmUq6+AtoufK55SNh+3hy0/YC06immfQJ8kev62/f9jB0KMzhQZqRDQ81KOhW+Uejjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB6PR04MB3077.eurprd04.prod.outlook.com (2603:10a6:6:8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.13; Wed, 3 Aug 2022 02:28:34 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 02:28:34 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] media: amphion: add support for contiguous format
Date:   Wed,  3 Aug 2022 10:27:18 +0800
Message-Id: <cover.1659493105.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a21c795a-6bbc-42b8-fecd-08da74f7dce2
X-MS-TrafficTypeDiagnostic: DB6PR04MB3077:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GsXvkaH0K5xJeS4IpQgAF707AZFmsuAR25yZhdb63GQKAoBDGjWV6wxEVbrHzbhbq+VRlLT3/qZ9sE1ucZq5/6MsoMpMnH38bBBmQceausmCNOiFh08QVvYF7ou1ra73aahptahZXW/sl6QRpXarNcmx3vCrZpMpQbrZmRkFpx0v/+fv2Oc/nvA+dR1YT2aXs9A9/kAsJ+4zcRMfpAYIUvW+rpPPOMcE0Ptuygmn3Q57Xdf4P4GguMtJgc2PH9UPLf+dM71kmtvvcy9BqLST4li1KwZrqD5RVu0GrT+jSXa63U3I7DqypAHR21C2t9EpJzdKrD6HAdVrEy35WZR6WMBW72/YE2nifF/B54qNsu04pKLMfYR3o6AUcYk2YsL44sVb06RUHOy2K8g7AJ8jmpyN5dc9PLNHYMM98vdF4ANMOb3o8NIKEpJVbIhpaM7u4a11K1cubjxELa1cmqVPMCCxk4lKiTBiAUnf1UT9bWzEP9irwOTOZy5PE0m9XR+DBtrVhCSs1AaOP3GAOK7uv9QiDCns8H2vMk9ZF4HT0oGorVU7YqlJJOameqXVEMl5//t/QBbaCACBQuVmVnALpBUu1SqkDvyTcVuSTGwylcnralNas0wu0oY08UxfZ3AnP/HOWU+dVfckWaDpk3KOcBBF1+14MaNasI/obWlp+FopQsPeKn3zGSQXbULD30NDBY5DZT0zcBO5EHrKRInFXRfvTVQG5oyimqgE6bCC5RpxMenzCOHrMUx7kZmXeNgR/3owf8pz+/uT/ixCk6yKkQ/6ium2XBgoxoYh0BGzJPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(44832011)(5660300002)(8676002)(4326008)(66476007)(66556008)(66946007)(8936002)(7416002)(2906002)(83380400001)(36756003)(86362001)(38100700002)(6486002)(478600001)(41300700001)(38350700002)(316002)(186003)(2616005)(26005)(6666004)(6506007)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TDkyt8+7aVa2nols8lTmI2nZ2kavSW/NW9tl2YJfdoFjg09aFPiUcB8Gpxsu?=
 =?us-ascii?Q?WjDvjagcW1lkMmZhLW6x6tPcjhDFIwgTpH6QC7J0NKeWfkh++GIf2OR96tU1?=
 =?us-ascii?Q?gxG86ON7Qb0s0UPfAnxc0Or771isenGzVX9Cx2WuzNrHpc5mRBGAgoqI6QuW?=
 =?us-ascii?Q?R2j3zBw4RiT/T/83/G8rJCj27JRmbRTiDso5YpOqF2xafnbzDcO37ROlabdC?=
 =?us-ascii?Q?J0VI8XUwFx8HxGeXPWnnoSxBoqKpH5XkLIEK1GpZb+9ZEh2JYO0LpJeJStsP?=
 =?us-ascii?Q?i7Smk6R+sW7QU8H36mZntR7WsXQMn9wfeQ9wJmo6BbVWW+lTfo+BdGuhGvfc?=
 =?us-ascii?Q?8+lWhJgcpO+saaR8ifo7Dl23VMUJtzXEotxBQEbQ0tKsouT/9QhpQZH5Dqv6?=
 =?us-ascii?Q?oYBIr92u6j2Hcb/DYh6GadBl/x1LZWNyY6GD/Hc5denIfIf/5HEIisV1uzS7?=
 =?us-ascii?Q?9lNd44GXXSp+g51mZdaH1iku3xyW21nSmIq1S1l+9ZX1Xv/Bj8DIsDWVRIoL?=
 =?us-ascii?Q?So8mSkn6XsketkTR17+01KxbHXnTSPhgR0lXAsn5xwuNOIJiOKI6z5JC1HH5?=
 =?us-ascii?Q?IWzYKjk5Zh+SL7alRNdvUJI3BLKtiQBKCLkf+sVmFsXOcn/frKcvuJW8RkrE?=
 =?us-ascii?Q?//A7RsjHdu2BLf8TR5MBI55K1zAt9X9j9ZMoUsfJ2k20SZlHjnIoVWPOwi4R?=
 =?us-ascii?Q?J2xlYg1Y/JvjYCP30LVgxTR/iS5J6+NbSBz9841VWvnEoTWnSmOiI+zulbyD?=
 =?us-ascii?Q?bQ4D4pqpl5DoEHMwaxo5MAzVdvH93N3atNVVcUS+/wR+iOJohG4OsRAFqlxJ?=
 =?us-ascii?Q?CoHoaTH2rtYPQaYqyDKBXhL2dW6lhG76o7gY/K8A90VpjRF8C3SsfvlL0hOj?=
 =?us-ascii?Q?nA1hayf9gWjHcyzkVTy8HOtyZJSLgDK8YostjIM6TpyVdKw92EMnLup2yyVU?=
 =?us-ascii?Q?eO4ntGSaGA5dB0S95jwRHH3Tod2X9Uf5OEuUqKorcNtZsy7GTTJfZ6Y6fmWU?=
 =?us-ascii?Q?uSmCZ3nIUu729dOMCyStGwn9dFfeffq/qUCh/5yyw7GKMSp2RwnBWpT/DE5Q?=
 =?us-ascii?Q?jxQn18yNFsfmdtiUnJEK+rVeMSpDSGS5QTpm98V01PLFTa2Krp0sY9HywmYj?=
 =?us-ascii?Q?uY7KZ06sNYJZ5iIyYS+CA4E0q7hhFig78wQN46upE/x+GyN+ryEuHO/0d2uk?=
 =?us-ascii?Q?/yK5ae2zJqdaHR4YFbixihPfWitcWJlCZhnu2wqAnyL50tc9R6AHRAl5ONVc?=
 =?us-ascii?Q?xTJY6Cyo4czXO0zPjzkgZHfiYBMSjB5pK05FvX9gnTG1feKeVY+fTfjQWpdU?=
 =?us-ascii?Q?xW8ORXyyy/WZy90fS2IVVO6qJ9sjOs74kZfjK98YrygNRzSTQsIpA4A8M3eh?=
 =?us-ascii?Q?XiMWjm6rBzUAXC9VsTn8Xqy/qkBFqh5/ah8PhyFoI4oIOiWW9mQie1KJyord?=
 =?us-ascii?Q?SBkUH9Nt77mnubfQuxlZKPdI+PbUOVBermSGrQ6zXO6fKx037tCYPg7C/dw+?=
 =?us-ascii?Q?W6pzyuVge9qtwbRNIXcPZLZb8kdTy1M9tEHPjnVq4N9l6hroGcaUzDWh5d78?=
 =?us-ascii?Q?dfO14Sp4gDyHMsuq/Y2kslCfwWVBvBkTp84cs2ua?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21c795a-6bbc-42b8-fecd-08da74f7dce2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 02:28:33.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z53E7BBI0tAeEY7fhOdTwj4PnuE3UrRoOiLQYGvI8KcdmWUsy0Yrl7/ZGRednwnSc/LcCFUMSXKBBz1tqRPuDQ==
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
 drivers/media/platform/amphion/vpu_v4l2.c     | 157 ++++++++++----
 drivers/media/platform/amphion/vpu_v4l2.h     |   3 +-
 drivers/media/platform/amphion/vpu_windsor.c  |   8 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
 include/uapi/linux/videodev2.h                |   2 +
 13 files changed, 326 insertions(+), 163 deletions(-)

-- 
2.37.1

