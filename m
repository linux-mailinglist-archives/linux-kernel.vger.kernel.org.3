Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59632586626
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiHAIS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiHAISz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:18:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897D53A4A2;
        Mon,  1 Aug 2022 01:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+pPn35vwDx7DsOCFBA61xn7+75Z6Lq931PJFar+LFu7AkDPlQGB0Xvsos7aCrqMiybA8uqAAE5t+pfaZraWGME4wliDI+7+hmDUqJ8L7WIlrf1dzlKvJVzzK+V9Lgc8WU0OpovgP6pvG9hwuw8PLXwYiDGo3t1gUXueFMhcQLN8dw01zXxMPkQt+dbDcWeagRPAJhBJqbJzv/7PyaCINsjGPlmv1ci4eX5pGEFzM7bLoRS7zg/Wg15reV0WA3v/5wlP3Zc/SBUTG4cd+08ggf1X25fpc7yo7VSSL93Ke2Pd5TaNVVfqWEJWn5cmKdM0l+qd5gFCmca7qDaDVTfYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WRWkwxVz0KsUp5T//s3RChgbJk5OaYFW0ByucVJsog=;
 b=TWtLCEW8jvvaCPKryM5PliABWS36i1UqZ92JLZdzWtJm5GJjAtii0V5v1wH7rhk00D3rNbZqnWu9DM74nYsZ5P4ga1aIoyGEQyRGVELj7Wfdy/IB3KkXAGdug3yuVO/YLzLKinAu0pCt2TZ3S3TSYpteRTGLfP2HWT7LQiOZ6oh050zR+ZvF0UVZewM8abT3vtSb9eMvGmGzxa1kIovIAkIy8GK8yOet/f6myjaHTtWsLonV+LWeqUpJV8lAYe6JzIoFoSsAahoEwKy+47/9jitZEoejAqjp0dA53AscXYqaT1L7/fozKilD6KCkP/4rMBHyhrDaQuyNKn1r0jtEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WRWkwxVz0KsUp5T//s3RChgbJk5OaYFW0ByucVJsog=;
 b=V0/WNiA9/bwxFUdLPTS/rRmT5yg0YVzHLdEtIOTbdDHCaViq4QNMqA0IgmbVbiJSwZ8ZYO7NrgZ3/whmt6nUTuR2b2Nd32RXlLlcOZSWSL3Bewgo+PyjN2ISZ3sVmrG2uNctuOGEOkR9hSCdMCUOnDyQ4e4+J9o2Vq2c3YSAB1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9334.eurprd04.prod.outlook.com (2603:10a6:20b:4de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 08:18:51 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5482.014; Mon, 1 Aug 2022
 08:18:51 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] media: amphion: add support for contiguous format
Date:   Mon,  1 Aug 2022 16:18:01 +0800
Message-Id: <cover.1659340974.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 276f7975-c820-41aa-8b96-08da73967742
X-MS-TrafficTypeDiagnostic: AS1PR04MB9334:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKjs5PlcnNkOYUoPJAkN2467vatbCXAOgqq8uw+oGXizkhZ+zehY7V6XM6b5m9tlOonW7iv5mVa2Y21ioS1XxpM/V31OmfJqX1NwHKssjpp1/PFTSmwSTySfxWEQK4XDsb28oSG9KHOnkdYVINRJtyqGwPNm5qzcXK5omUKdWFMJvy94UY3J44VMUHloihQSc9oMc3RTmn3QobjtKWqIuSGEsxrs6fM/pI6vKrJDYohCLiVICkfSJrxEbU6Q0IXD9CvATSnzyheZn+oxswOCFxdJ1UtB2dUEtFguH3bOZd8KQZ4HrhDPBbUoivlYTWSRDnIQbsTT5av7M/wAOwE0yIbk0TRDh9954JAh7Z1M9qZwbzeyk/WchWm44ZjEl/hB7GA+IU1cvPvE4pT5d2vND4S1Bvx+dMMjGR6jrEkDC45wJdthdwWtZy0jkLf7s/6Smx8xwolwPXNI4bvXP4cEfNA5+9Q66TeGFPmKBoSVBi80hIoAmwSWwG2AFqksuT/51cyW0/YEHEJr3PconvKr6kSXj0V1J/ETXsubhtbdJgXZDy+X2qELuNBNfPkjXMk1XmnuVGi756hk7Bry3uh/YGv+Rb/b+dJhBCGGdOa+8kEuFRxT3phZo0C1vpsF0frR3orkuwuDL9KkGbMW4WKPZlTwxbdOaJXk3UYffATbAmtoTVwKCyXk0QsovZEn7i6lNodWi8Ay8Jc2Vx2+t1pqPashsZc9MAFWALysoEMJ/NDHladW0p3k436q6K4LH8RaXti1piMMTR9moUgBPLs+uL/4bxyCd4D4EMF2rqoo55k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(66946007)(6666004)(316002)(6506007)(6512007)(52116002)(26005)(6486002)(86362001)(2616005)(41300700001)(38350700002)(478600001)(83380400001)(5660300002)(7416002)(44832011)(36756003)(38100700002)(66476007)(66556008)(4326008)(8676002)(8936002)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?URNl62aCOlzEe77IGR6N6Dz9FcaLyKoFT5XMbR+gF/ipCxUEzQBc2dRIPc0I?=
 =?us-ascii?Q?dEeeryy848XnD16wI+OY7WJY8b8vlEoP4iwnY3zlt3FJTb/wtBeZl0Qh6Sev?=
 =?us-ascii?Q?r+vzOTmyiYDFM99+2h7Ff827scvqWeIZrTwAVb8MhQfZpFCNVAbDV5KoJA3Y?=
 =?us-ascii?Q?+FdNmUlxkWLVkrCJG2cihC316yImGN7UFsY8glJ6oZW7FLOA0tik6qYQIQG3?=
 =?us-ascii?Q?7AkDbDPcpOmFDzWutxS1xrvjx3OpC+RrpLcwmcwOQiCgo6/CT6xwZzlfSPXZ?=
 =?us-ascii?Q?NDbXAahLrcRWBnrFvZfP0gpSpDtOpk6KsVBGKuXP+/GLlfFTfkyVqvxUjO6X?=
 =?us-ascii?Q?UuKFTVLood/bd7e0EaJR3ahl5755CGjTrNPbSIJVKYEszsVzjMauW0ID1A1N?=
 =?us-ascii?Q?qnV+M1+BWSngZqfF5MWtpIEQ/u25dyVJgo3CQRT6cw4L8ePKbYgIMRkLkN8v?=
 =?us-ascii?Q?iC9+q0Pt/nDAuvlotFuY5KC6bOGcHqrfzECzMInbTgXs+/IuucZwJ6R3Mkc2?=
 =?us-ascii?Q?ynd0RSwi33sa0NiyDMRJm/HvHfcWcTmq70fxCx7h7e1SWgAMdX4yXLe5RL7e?=
 =?us-ascii?Q?E7HCDVIB1SNAKPcxa6uyoGtjsXiqGn0AdQH68QW2SkEzjVXDSuVGU4VCWkj8?=
 =?us-ascii?Q?pTkZtNdz8Vby7Ct3IWZUR1KgfXF+5WLj7ccqVxAQp7NgrKr/ICSZ1V8S+kyX?=
 =?us-ascii?Q?zrjmVptygFxgAiGSjK3rrhfXqqizE2nMoolyNBivGu3dOKE7+mmsoh4tt0G1?=
 =?us-ascii?Q?XaaoNGTR51G6svDp6I7WNeXoqfKjvLAXEzggZYHVU4S7fKSlzDXP9GluYqDI?=
 =?us-ascii?Q?FcDSgjQMb5BceskVvTH10IToueSHB4sSYIaWrEBPxZZjVKze8KiFBMODFElU?=
 =?us-ascii?Q?fCHgfu1Ckn3AmiN7zpq/sGyv7uNble5hjtBOQSr5qDzgoG3TBV9wgMNAL4Xh?=
 =?us-ascii?Q?SMNWnLgm7YsDOQ89W5b02SoIXUESC/u113WODrH29+0TgPLZa4xbSaAhnYwI?=
 =?us-ascii?Q?u7vZFvbvrOI1FkYPcH5OL1xHgbbffx9TkFsnHxzK+F/Afs88znCj+sWpkh8u?=
 =?us-ascii?Q?L7IeihbmJoCC1KPwro7jH3kqM3NxUQNsvafgnAWlAsciXdB6y5icorvQsMdW?=
 =?us-ascii?Q?Bte53a3y6bxMnE6DZyv5CGzbKwFX/zn2JGVV/V2ChP2HwXKkYBaLJZI7AOe2?=
 =?us-ascii?Q?dbttxpnrFfkrMQvKUscSWB6cbQztCtDobVXjEWkw2P7XMrzTIdsAzZ06qyGv?=
 =?us-ascii?Q?DonNOvlZNkxNdFrTsKcVu4Y+mzRMyAdgkAFnBaI+mhBKewQMs2qCKPVAevnv?=
 =?us-ascii?Q?uECfhUNK+p1YIde2lrXXn5xfVyrCUQyNqheD7trnwp7Xvs+TBo3hobUS9B1r?=
 =?us-ascii?Q?qrg5nrBbeAx6tDvXEokPxM2Ej4LkHr7FGwyGb4qFkha7asQW8hfn/cnl+Cad?=
 =?us-ascii?Q?4WGJRvNl3LZqQZVHF5fiXwQ+uZPSMjDztmrhUtjvKcSkWfdQ8A90eduaqATV?=
 =?us-ascii?Q?lkwn24YhI017+ngdlL0ANT1kQ2Tu5skR/ZOfD/dnIVK+xumhpUS/Y4Yf4gT3?=
 =?us-ascii?Q?40slM9bevXon1ZtXVOs+6JWz6De3tGVSJcXDOduC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276f7975-c820-41aa-8b96-08da73967742
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 08:18:51.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hgn+ZsW8uphlCwU49w9HjPEPeHOInIGE1Pjnojp9Zf+Q9qQEc5jF2uguQWkp2NNzBIY/1Oqb+rIb76AnuyTndA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9334
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
 drivers/media/platform/amphion/vpu_helpers.c  |  38 +++-
 drivers/media/platform/amphion/vpu_helpers.h  |   2 +
 drivers/media/platform/amphion/vpu_malone.c   |   3 +-
 drivers/media/platform/amphion/vpu_v4l2.c     | 134 ++++++++----
 drivers/media/platform/amphion/vpu_v4l2.h     |   3 +-
 drivers/media/platform/amphion/vpu_windsor.c  |   8 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
 include/uapi/linux/videodev2.h                |   2 +
 13 files changed, 296 insertions(+), 160 deletions(-)

-- 
2.37.1

