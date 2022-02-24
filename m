Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943234C224D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiBXDLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiBXDLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:11:35 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30048.outbound.protection.outlook.com [40.107.3.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C6192E1E;
        Wed, 23 Feb 2022 19:11:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1mD4NPdZGIyQj6vJhJt2afYYSem7ucxeNfEfE1nZF19yDEUclbM9dgh9Y0S2ZQaU2UFYnN32cjwCeXVzK8Qd6lowRUpmiaPHqqdGtYJ0J0igIbgfxI+bJ41oCyrlVsRUNa7Gd9fvMpaSZTOsIM6niKSTNEIzpIkIWmbkpNPfQlIwvFmDoLK/LbQ/Sg5LMR8z5nq5LMttGBwZZ72Fsi8NCuo+1W4EajagVfoYl7sP3xh8NuqcGz17hYuCfn5Jq9O6G+Y8DKbS8q+LHx3aaFlOVgFJLIPFJccdZIpDue/SfA4bb4BKAhptb8mjhkxWjb0deMW7yRVuWY79I74+54iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DzDZ1m+5TSprnVyVo70RzkYswhkhaITAfXQruEBUyE=;
 b=CzS0246rl8ecmgkVRxOTdrsE8Vtp9/wqDyA+unRB7RNmGn4Q44ZHfPGxdbkNcqtAizVhrhFiGUGoqa7MR9GqTeMjZttodQ6qYFzrowcy8XBxA/PC50jlx0X/W+CYQ9M0lHs2b9KHxAbF/H2S4f0jXZgO02B8TGQa/u1fah+ACvr0m9EWU5zu2+lZv5PV1MxdXcnQxjkpvChHu4gfwF5idDIl+XjE4l+sZ0Td+K2GiliQV5YcdBpWDVkNCXfY5tm0O21vggY/2O3CQZmSossoCdv+AbyHEXqo3GOmDkD3Xwt9MadYU7Yjlhdln/XseO+1qOLpWzbLEn8lQEGCgkZ+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DzDZ1m+5TSprnVyVo70RzkYswhkhaITAfXQruEBUyE=;
 b=kSJJw2Gl90g29d05Yj7Q2JCoCR03ydwVWI9n/w/yOy2cg4oAk+7qaAulu6FXsuF0goo7fH7ldtMPKL95Yql+Y5mlYwhjT+CUB9yLbhtdszbzxydJYBNZACdQBdt78xAzUdmXCjJNByXVPX7tMzb0DJnODkckWZl3V3urwu0nOdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 03:11:02 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 03:11:02 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v18 00/15] amphion video decoder/encoder driver
Date:   Thu, 24 Feb 2022 11:09:58 +0800
Message-Id: <cover.1645670589.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b673a607-7076-4f6c-7a99-08d9f743499e
X-MS-TrafficTypeDiagnostic: PA4PR04MB8013:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB80135E7EBD6CB5CD6854C2C6E73D9@PA4PR04MB8013.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N28HLxy1KR1teOEhO/r9ZD0F0EEkf9bl+7r4oylkrwwnUe71Q5qlrsBdmB7YmLBZ/rnBBeffn6LztLoR7LY7LsbLckVfEGhvPHjYZLy2eITvygyNEUJOCbvecmiIzVwfYl9Y5p0j5SRZvwjZS5U94nMegM1PiCyQTMamIOn4dI4C0riAMtF/EES/0KxadvNzMvdlLWp/bw3Ap1zC1enycz/6oC+owwyI/yBQzEWh14SZIpcSGUF0803moFXkVcxmgw0N/zo8bKQb+vfSKDU+SkjTNHAjyqaoSempWT+wttQ39BWmXSg3Aq4xSSxd6tTBeElHWPphooMMCQw/gC7vtArflOemjpXEBmg7cf1gpXux5uDJUZYmyV/vaGRNhD6MHxdb7FB9/Em5215dMKJOltHmZ0y9LYy07odc7PZinJAXHOwxi3HAQZRa0+ZvKD3EeMmBF1B28+ru1Xn2dToOIc8x0KZ2kejP/YPv/b90uGdjTqgg6sGWwC1x2/Rs+e3f5I1I6HDZ51jrhEi1cLR/1vfyMrPgbecZTq0Z2wQyYFJV68JB1aOs6VhtjUTYh/ntJnyf5vTeGZ6hRK99P8q0KLH2YDrx7xScOI+r4O46GhTyMSIz4HYtZ4x25i+DQzZ2JWs3ItkZtElKvSRvWb1BWulAEDPT4zmuFPsFc0IXnDdJ+hKQeWiRcQmaDx4kJb3nFA9JzvPNgbMrXZuzVKut1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2616005)(44832011)(6512007)(38100700002)(38350700002)(186003)(26005)(5660300002)(966005)(508600001)(6486002)(52116002)(6506007)(86362001)(6666004)(7416002)(66946007)(8936002)(30864003)(2906002)(8676002)(4326008)(83380400001)(66476007)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r9IISMrMIq1KqRf/aDaIbKUKQjpDFDix6zH6xrDJsPCPxFGwMYI4JB0iL7Jr?=
 =?us-ascii?Q?RJeTj1OW+E8uQSsJAm2dj5QfM1hXeRkv5+z8idXPRhRwmHSOHD7vZ7ijBYMG?=
 =?us-ascii?Q?o05GPihSNBZU+mZJJHFxG82fGJsqG7BRXmJPL2eCwtXQPXSIn8uhTrQjixte?=
 =?us-ascii?Q?3lcnSaEAqPyorIohKGHMNp67TRyNhunPprcLSU+dk9/hu7OLmgQNo5MnrrUp?=
 =?us-ascii?Q?lIQzV7VgRgRHG+k5t+HCbOQ3zgdP/t+T48PtCN19zNxQdtBbtTgZbJFEES7Q?=
 =?us-ascii?Q?hlF5ORjzG7kSC4VIejtjyE0Z7dvjL9t1J1p1xnwpiWhl9P3nzo9deHT2vpFt?=
 =?us-ascii?Q?j4VxWZcWnMsG32nwncf6ForxxCoQ1q2S9vEqFHL2+W35AWyxXz2vUyzemrJE?=
 =?us-ascii?Q?x2035vfC+fsxjQpXI1FLOdN72i+VB2j2CiCD4yaXqVXskV/yeubVPvfL9Kqa?=
 =?us-ascii?Q?TcDg+XOosiQgbHgFK37Nw+Jl2SWsxqX5Fda2srIgpIaRRTF53eK1cLZ//Y/v?=
 =?us-ascii?Q?rvBbskJkl3zb6Vusb2XMwrHcD1AVo/oQtB6W/bRCF/lKiOz4m73K9SLS60+3?=
 =?us-ascii?Q?7fs2au51fKHJfPp+57QgKxdtsr3QRxZOzaAgyRs6NJGRqIyiuxxfakSSfZyG?=
 =?us-ascii?Q?yhDa0f4qQcvhPpopwSw/8hFgrRpCokI5PrtFTb+xVfFG0YSj49L5UGFzYnnw?=
 =?us-ascii?Q?1cqrYsyiMrO8WeAM72llihXL6WFvXgpBuRLDIE8IkXv30dZeZ/BdB9bsOqM8?=
 =?us-ascii?Q?7O5rBp1Bd2A8IlT6gCq/IG/wiMy8BmgX2JNPsOJEsiHzJQfqtKhz90n9v9/N?=
 =?us-ascii?Q?AYXMJbb4a2Q8QR7M6Ck4PvXGti01GlvanxHj1TcvZuN6jYRy+ZrvBiFH22J4?=
 =?us-ascii?Q?OlyV9wmLT2YYdsyNCyY8VV1JDhuFK0CYSiO2U6NFJcTMRHvcv3TCtY2uqCd+?=
 =?us-ascii?Q?5CVufqnV/jKrjvJ1Hm3XVMvCARRTEP6jq+OIy3upf5cpEs+k28/I7BUMG8w8?=
 =?us-ascii?Q?6kxZL7r0tnmEXeNU0yPXDvF53yrucVWmGHptonhs37Bq0UlLexYlu5a4DkFC?=
 =?us-ascii?Q?mJyCTpMz7f5/UiimPHc5LLSg+CvrnqvRznslGm6k5hY+GrnjGHv3aiodtCs2?=
 =?us-ascii?Q?fYNl21yD3vnYj7I96sTaONIjcAdCNJTrUHOeVEUKgrBADyNMivMi2dwT8Uyc?=
 =?us-ascii?Q?KPC9OJe10dP0AqUHPZfRRVbMOn1JutRGy+RLl4Us6NpnNxz675Uh8ChQmA+V?=
 =?us-ascii?Q?Paeg591O532jMAEPFyt2fx77prCix0r+WdtutDvoYbm9Eho2Pqs/tyHwtbn2?=
 =?us-ascii?Q?bxJN205Zqx62NilvdhHdGrcVSC1V57CRwI5qb4iwe4jgnaVdGDvhWm5sfqxZ?=
 =?us-ascii?Q?5Y9fibuXwjSM+FBmdVlOWq3bJpUVINgdRBs8LNOML1YW51rSKRWoahKOvQ/p?=
 =?us-ascii?Q?0Cm7lN3TlKtuBro/SHq5OfbU5LL9sJF069SaGITa92znxmqdpovM7mur5xBi?=
 =?us-ascii?Q?NgT8NrKLKXLoBBsQolboX7gcWH/YLD+gP4mxfbtPVQqEEvyE7jE3+MWa6N61?=
 =?us-ascii?Q?urDgOsdDuEXpW6XVOHV6Uea+vKWuyvf/+FqGaxTE0h9Ul1puc0VIehcpRs/0?=
 =?us-ascii?Q?53Q+RZKiiq99Fl1Gc/rKP/w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b673a607-7076-4f6c-7a99-08d9f743499e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 03:11:02.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CHiEchHVgZFjUGdLSj/+ABZ6CS+rrdqcoZmvFIDHjlqg+OmyeP2RAKg1+czqN1AaNXneDpGoAc4yD9uC928Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series adds support for
the amphion video encoder and decoder
via the VPU block present in imx8q platforms.
Currently, support for IMX8QXP and IMX8QM is included.

It features decoding for the following formats:
- H.264
- HEVC
- MPEG4
- MPEG2
- VC1
- VP8

It features encoding for the following formats:
- H.264

The driver creates a separate device node for the encoder and decoder.

This driver is dependent on vpu firmwares.
The firmwares have been submitted to linux-firmware.
The commit is 6342082c115e76ab5efe3f93c4c1ac6d01a3c7d0:
linux-firmware: Amphion: Add VPU firmwares for NXP i.MX8Q SoCs
(Wed Jan 26 13:48:05 2022 +0800)

You can get the firmware from <linux-firmware>/amphion/vpu

encoder is tested with gstreamer
decoder is tested with gstreamer, but the following patches are required:
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1379
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1381


Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>


Changelog:
v18
- make a separate patch for add vpu driver entry in Kconfig and Makefile

v17
- fix warnings and errors reported by sparse and smatch
- move Kconfig entry to mem2mem section
- make a separate patch for enable amphion vpu driver in arm64 defconfig

v16
- fix some devicetree issues reported by shawnguo

v15.1
- include linux/vmalloc.h to avoid build warning by kernel test robot
- add entry in MAINTAINERS alphabetically

v15
- fix issues detected by "checkpatch.pl --strict"
- encoder add ctrl V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE

v14
- fix some errors according to Hans's comments

v13
- make a workaround that avoid firmware entering wfi wrongly

v12
- support reset decoder when starting a new stream
- don't append an empty last buffer, set last_buffer_dequeued
- improve the resolution change flow
- return all buffers if start_streaming fail
- fill encoder capture buffer's filed to none
- fix a bug in calculating bytesperline

v11
- fix dt_binding_check error after upgrade dtschema
- remove "default y"
- add media device

v10
- refine vpu log, remove custom logging infrastructure
- support non contiguous planes format nv12m instead of nv12
- rename V4L2_PIX_FMT_NV12_8L128 to V4L2_PIX_FMT_NV12MT_8L128
- rename V4L2_PIX_FMT_NV12_10BE_8L128 to V4L2_PIX_FMT_NV12MT_10BE_8L128
- merge two module into one
- fix kernel panic in rmmod

v9
- drop V4L2_BUF_FLAG_CODECCONFIG
- drop V4L2_EVENT_CODEC_ERROR
- drop V4L2_EVENT_SKIP - use the v4l2_buffer.sequence counter
- fix some build warnings with W=1 reported by kernel test robot

v8
- move driver from driver/media/platform/imx/vpu-8q to
  driver/media/platform/amphion
- rename driver name to amphion
- remove imx_vpu.h
- move the definition of V4L2_EVENT_CODEC_ERROR to videodev2.h
- move the definition of V4L2_EVENT_SKIP to videodev2.h

v7
- fix build warnings with W=1 reported by kernel test robot

v6:
- rename V4L2_PIX_FMT_NT8 to V4L2_PIX_FMT_NV12_8L128
- rename V4L2_PIX_FMT_NT10 to V4L2_PIX_FMT_NV12_10BE_8L128

v5:
- move some definition from imx_vph.h to videodev2.h
- remove some unnecessary content
- add some documentation descriptions
- pass the lateset v4l2-compliance test

v4:
- redefine the memory-region in devicetree bindings documentation
- use v4l2's mechanism to implement synchronize queuing ioctl
- remove the unnecessary mutex ioctl_sync
- don't notify source change event if the parameters are same as previously established
- add flag V4L2_FMT_FLAG_DYN_RESOLUTION to decoder's capture format

v3:
- don't make vpu device node a simple-bus
- trigger probing vpu core in the driver
- remove unnecessary vpu core index property

v2:
- fix dt bindings build error
- split driver patch into several parts to avoid exceeding bytes limit

Compliance
==========
# v4l2-compliance -d /dev/video0
v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t
v4l2-compliance SHA: 493af03f3c57 2021-10-08 17:23:11

Compliance test for amphion-vpu device /dev/video0:

Driver Info:
	Driver name      : amphion-vpu
	Card type        : amphion vpu decoder
	Bus info         : platform: amphion-vpu
	Driver version   : 5.15.0
	Capabilities     : 0x84204000
		Video Memory-to-Memory Multiplanar
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04204000
		Video Memory-to-Memory Multiplanar
		Streaming
		Extended Pix Format
	Detected Stateful Decoder
Media Driver Info:
	Driver name      : amphion-vpu
	Model            : amphion-vpu
	Serial           :
	Bus info         : platform: amphion-vpu
	Media version    : 5.15.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 5.15.0
Interface Info:
	ID               : 0x0300000c
	Type             : V4L Video
Entity Info:
	ID               : 0x00000001 (1)
	Name             : amphion-vpu-decoder-source
	Function         : V4L2 I/O
	Pad 0x01000002   : 0: Source
	  Link 0x02000008: to remote pad 0x1000004 of entity 'amphion-vpu-decoder-proc' (Video Decoder): Data, Enabled, Immutable

Required ioctls:
	test MC information (see 'Media Driver Info' above): OK
	test VIDIOC_QUERYCAP: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/video0 open: OK
	test VIDIOC_QUERYCAP: OK
	test VIDIOC_G/S_PRIORITY: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
	test VIDIOC_QUERYCTRL: OK
	test VIDIOC_G/S_CTRL: OK
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 3 Private Controls: 0

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
	test VIDIOC_G/S_PARM: OK (Not Supported)
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK
	test VIDIOC_TRY_FMT: OK
	test VIDIOC_S_FMT: OK
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK
	test Scaling: OK (Not Supported)

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test VIDIOC_EXPBUF: OK
	test Requests: OK (Not Supported)

Total for amphion-vpu device /dev/video0: 46, Succeeded: 46, Failed: 0, Warnings: 0

# v4l2-compliance -d /dev/video1
v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t
v4l2-compliance SHA: 493af03f3c57 2021-10-08 17:23:11

Compliance test for amphion-vpu device /dev/video1:

Driver Info:
	Driver name      : amphion-vpu
	Card type        : amphion vpu encoder
	Bus info         : platform: amphion-vpu
	Driver version   : 5.15.0
	Capabilities     : 0x84204000
		Video Memory-to-Memory Multiplanar
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04204000
		Video Memory-to-Memory Multiplanar
		Streaming
		Extended Pix Format
	Detected Stateful Encoder
Media Driver Info:
	Driver name      : amphion-vpu
	Model            : amphion-vpu
	Serial           :
	Bus info         : platform: amphion-vpu
	Media version    : 5.15.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 5.15.0
Interface Info:
	ID               : 0x0300001a
	Type             : V4L Video
Entity Info:
	ID               : 0x0000000f (15)
	Name             : amphion-vpu-encoder-source
	Function         : V4L2 I/O
	Pad 0x01000010   : 0: Source
	  Link 0x02000016: to remote pad 0x1000012 of entity 'amphion-vpu-encoder-proc' (Video Encoder): Data, Enabled, Immutable

Required ioctls:
	test MC information (see 'Media Driver Info' above): OK
	test VIDIOC_QUERYCAP: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/video1 open: OK
	test VIDIOC_QUERYCAP: OK
	test VIDIOC_G/S_PRIORITY: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
	test VIDIOC_QUERYCTRL: OK
	test VIDIOC_G/S_CTRL: OK
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 20 Private Controls: 0

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
	test VIDIOC_G/S_PARM: OK
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK
	test VIDIOC_TRY_FMT: OK
	test VIDIOC_S_FMT: OK
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK
	test Composing: OK (Not Supported)
	test Scaling: OK (Not Supported)

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test VIDIOC_EXPBUF: OK
	test Requests: OK (Not Supported)

Total for amphion-vpu device /dev/video1: 46, Succeeded: 46, Failed: 0, Warnings: 0

# v4l2-compliance -d /dev/media0
v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t
v4l2-compliance SHA: 493af03f3c57 2021-10-08 17:23:11

Compliance test for amphion-vpu device /dev/media0:

Media Driver Info:
	Driver name      : amphion-vpu
	Model            : amphion-vpu
	Serial           :
	Bus info         : platform: amphion-vpu
	Media version    : 5.15.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 5.15.0

Required ioctls:
	test MEDIA_IOC_DEVICE_INFO: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/media0 open: OK
	test MEDIA_IOC_DEVICE_INFO: OK
	test for unlimited opens: OK

Media Controller ioctls:
	test MEDIA_IOC_G_TOPOLOGY: OK
	Entities: 6 Interfaces: 2 Pads: 8 Links: 8
	test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
	test MEDIA_IOC_SETUP_LINK: OK

Total for amphion-vpu device /dev/media0: 8, Succeeded: 8, Failed: 0, Warnings: 0

Ming Qian (15):
  dt-bindings: media: amphion: add amphion video codec bindings
  media: add nv12m_8l128 and nv12m_10be_8l128 video format.
  media: amphion: add amphion vpu device driver
  media: amphion: add vpu core driver
  media: amphion: implement vpu core communication based on mailbox
  media: amphion: add vpu v4l2 m2m support
  media: amphion: add v4l2 m2m vpu encoder stateful driver
  media: amphion: add v4l2 m2m vpu decoder stateful driver
  media: amphion: implement windsor encoder rpc interface
  media: amphion: implement malone decoder rpc interface
  arm64: dts: freescale: imx8q: add imx vpu codec entries
  firmware: imx: scu-pd: imx8q: add vpu mu resources
  MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
  arm64: defconfig: amphion: enable vpu driver
  media: amphion: add amphion vpu entry in Kconfig and Makefile

 .../bindings/media/amphion,vpu.yaml           |  180 ++
 .../media/v4l/pixfmt-yuv-planar.rst           |   28 +-
 MAINTAINERS                                   |    9 +
 .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi |   73 +
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   25 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   24 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/firmware/imx/scu-pd.c                 |    4 +
 drivers/media/platform/Kconfig                |   19 +
 drivers/media/platform/Makefile               |    2 +
 drivers/media/platform/amphion/Makefile       |   20 +
 drivers/media/platform/amphion/vdec.c         | 1691 +++++++++++++++++
 drivers/media/platform/amphion/venc.c         | 1358 +++++++++++++
 drivers/media/platform/amphion/vpu.h          |  362 ++++
 drivers/media/platform/amphion/vpu_cmds.c     |  433 +++++
 drivers/media/platform/amphion/vpu_cmds.h     |   25 +
 drivers/media/platform/amphion/vpu_codec.h    |   68 +
 drivers/media/platform/amphion/vpu_color.c    |  183 ++
 drivers/media/platform/amphion/vpu_core.c     |  871 +++++++++
 drivers/media/platform/amphion/vpu_core.h     |   15 +
 drivers/media/platform/amphion/vpu_dbg.c      |  494 +++++
 drivers/media/platform/amphion/vpu_defs.h     |  187 ++
 drivers/media/platform/amphion/vpu_drv.c      |  260 +++
 drivers/media/platform/amphion/vpu_helpers.c  |  413 ++++
 drivers/media/platform/amphion/vpu_helpers.h  |   74 +
 drivers/media/platform/amphion/vpu_imx8q.c    |  271 +++
 drivers/media/platform/amphion/vpu_imx8q.h    |  115 ++
 drivers/media/platform/amphion/vpu_malone.c   | 1625 ++++++++++++++++
 drivers/media/platform/amphion/vpu_malone.h   |   44 +
 drivers/media/platform/amphion/vpu_mbox.c     |  118 ++
 drivers/media/platform/amphion/vpu_mbox.h     |   16 +
 drivers/media/platform/amphion/vpu_msgs.c     |  385 ++++
 drivers/media/platform/amphion/vpu_msgs.h     |   14 +
 drivers/media/platform/amphion/vpu_rpc.c      |  257 +++
 drivers/media/platform/amphion/vpu_rpc.h      |  456 +++++
 drivers/media/platform/amphion/vpu_v4l2.c     |  712 +++++++
 drivers/media/platform/amphion/vpu_v4l2.h     |   55 +
 drivers/media/platform/amphion/vpu_windsor.c  | 1169 ++++++++++++
 drivers/media/platform/amphion/vpu_windsor.h  |   37 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |    2 +
 include/uapi/linux/videodev2.h                |    2 +
 41 files changed, 12094 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/amphion,vpu.yaml
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
 create mode 100644 drivers/media/platform/amphion/Makefile
 create mode 100644 drivers/media/platform/amphion/vdec.c
 create mode 100644 drivers/media/platform/amphion/venc.c
 create mode 100644 drivers/media/platform/amphion/vpu.h
 create mode 100644 drivers/media/platform/amphion/vpu_cmds.c
 create mode 100644 drivers/media/platform/amphion/vpu_cmds.h
 create mode 100644 drivers/media/platform/amphion/vpu_codec.h
 create mode 100644 drivers/media/platform/amphion/vpu_color.c
 create mode 100644 drivers/media/platform/amphion/vpu_core.c
 create mode 100644 drivers/media/platform/amphion/vpu_core.h
 create mode 100644 drivers/media/platform/amphion/vpu_dbg.c
 create mode 100644 drivers/media/platform/amphion/vpu_defs.h
 create mode 100644 drivers/media/platform/amphion/vpu_drv.c
 create mode 100644 drivers/media/platform/amphion/vpu_helpers.c
 create mode 100644 drivers/media/platform/amphion/vpu_helpers.h
 create mode 100644 drivers/media/platform/amphion/vpu_imx8q.c
 create mode 100644 drivers/media/platform/amphion/vpu_imx8q.h
 create mode 100644 drivers/media/platform/amphion/vpu_malone.c
 create mode 100644 drivers/media/platform/amphion/vpu_malone.h
 create mode 100644 drivers/media/platform/amphion/vpu_mbox.c
 create mode 100644 drivers/media/platform/amphion/vpu_mbox.h
 create mode 100644 drivers/media/platform/amphion/vpu_msgs.c
 create mode 100644 drivers/media/platform/amphion/vpu_msgs.h
 create mode 100644 drivers/media/platform/amphion/vpu_rpc.c
 create mode 100644 drivers/media/platform/amphion/vpu_rpc.h
 create mode 100644 drivers/media/platform/amphion/vpu_v4l2.c
 create mode 100644 drivers/media/platform/amphion/vpu_v4l2.h
 create mode 100644 drivers/media/platform/amphion/vpu_windsor.c
 create mode 100644 drivers/media/platform/amphion/vpu_windsor.h


base-commit: 127efdbc51fe6064336c0452ce9c910b3e107cf0
-- 
2.33.0

