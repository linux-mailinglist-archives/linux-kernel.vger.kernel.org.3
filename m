Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098C649AD41
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442961AbiAYHOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:14:51 -0500
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:58918
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1442887AbiAYHL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:11:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4yfKkC12R05KZ1XrBC42rwUK7EVerAUBCu/PAAgUiWriOnqr07ClMUnCnwWQlkTlElsKe7L47MnOaavUNeqJtA4IGqvpiN7eMzF6o9irA2XYGAgw8v7F+9KxjdsE5pePM7q9IAhlRNqDOKO/2+TYIrtRTr9LNVGeo9TG11fe5TkSTo9wqJC4yh/zOwW8InmMubNYBWowEkUHi6oqFd1or8vmQKmF+fJ+kvjfXLJ/uYYajktsHKGNJEdsYfmOQgiJs9ofTgdrfhhbWeWeqeKQJX9pNIkoARpV4XNNJGRa6UhMFgRU63xhjrWW0Si1tqMHgD/b0Sc9Cqqchb5S/R8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umBxcvAGc4ALQBnHKqP/yygrgrBYzWxzY+tn4fg+K5s=;
 b=UUgpGiN2MmnhDtU+iso1RLwR5DXFzZat+AxHpUPyLdzj3OdZ6ahz/9S+KnC7O9MzmzNjQek7n9oIPw3eRc38IBelegXyiOMAnekyiGESqU5L0vgQ/ZEM3RrTQ+Xf5hThVENTEihsVke/kJ9pocGjyW1wne3SlZe9xu9CfJ/pumLQ0rTzOwgDKh/jcrRWlaPMZvvR7EqgKu8BaQNm3gZV58qIx59a7536mpsvlDX/jIZDZjkE+xApSyXxozBg24O86oELbqdzIsSsv+rcr3D3Q1Sd7lcsN81e8vYta3PGTpYDQyxSZrBZ8uStuFgiQcg9lqquNi+8m8wmBuF4itBYtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umBxcvAGc4ALQBnHKqP/yygrgrBYzWxzY+tn4fg+K5s=;
 b=X7Q2ZeUdyIg2yExL6Zc2FKdjjPeXWOPUbcNa65ZZRspm+PrgGeOXvCUjAglMbIkpDRBcf7qY9OeR0fMsui0khgIck+fM1DnX9zU6HfoG8nrrTZaSVqwjCeMTKk9XMekwUaxfaMw+Ysfxfay2qfRd4/0zzq6W6M7E0CKe11HdGJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB4094.eurprd04.prod.outlook.com (2603:10a6:803:43::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 07:11:51 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%4]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 07:11:51 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 00/13] amphion video decoder/encoder driver
Date:   Tue, 25 Jan 2022 15:11:16 +0800
Message-Id: <cover.1643077283.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce9f6ccf-d14b-41c0-7dd0-08d9dfd1f55d
X-MS-TrafficTypeDiagnostic: VI1PR04MB4094:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4094189BC1BCC43F4AA9C81DE75F9@VI1PR04MB4094.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLHUu03aidIyY6w1ipNjwYj/Ri0uGWmR0W0QRXoMj3vDS8F3pc1letBq3UX8e5qQg90J2R663qvUdbzk7L+sWD4Q+fTjZUc4pO99ra1BrQ1wpHH13s2QbgPMKAZEh847aenmyBd0FHNfHuAnH2P8kW0H8OddsV7lmHJvc54sdIb6VVYTioNmpQbl8h6HzM176UvQJCSj9CEqVb8hKFOlbIbxrYLMafmkK/vHZy4J1AhggvZp9w1EPHex4X4JKghiD6+zgeA5kvd6cB76UcKOalY6OV8YtJpwLnDxHXd93cZyGLOSWCeV7eM6g4dpApArxPXoS+7HhIHuaSPDPeikye6x9W9ewwjmre2FKUIfSlKGL5fOyQBZanquLyHF2tRqt7PPkqq/UHSebhooXG/3M9swlYuV/lM9KZPz66O0awh++RER07OjQp59/kvd3WvCY927G0UQ4JKvbkNG0CgPr0W0feE7ootg7EWNFQPAgquFT166qizrb/NDNdEOjmjKMZedDbtr+fv4lIo4CYxYjTt4Yvf0+XiuQQjCMszyXEApadpthArb9vL/lRjYfN3zDTmI6QqLREWHzJeUbuvplbT7ZrNnF6wex+xTP3cmwJK+INKRZOYX2O1Pjt04jND4+UKmA5WWtFwj7KN/LBsU8jg9ugLTLixmzQN+dtqdxI8TbQhNETOi+39zEvcBfYrcS6Wo1ft9hicro0Kq5FvCuVR0kaBJh4ALsCbphRnlLBjk2X4R+a9V99mv5PVxjzn3ZPS6qu+Xq1s0pY0tWKUDCPmBCG7y20j4ylHzbmCoYjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(966005)(6666004)(5660300002)(2616005)(7416002)(8676002)(36756003)(44832011)(86362001)(316002)(4326008)(38350700002)(6512007)(38100700002)(66476007)(66556008)(83380400001)(52116002)(6486002)(66946007)(6506007)(2906002)(186003)(26005)(30864003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XDP/4Y3ngN2wv1oaTXlXiNLh8QfA+q0jFOcP1FYlrqmgm9r/QKy31M0ITbqn?=
 =?us-ascii?Q?sCbTzJhoazsjZu3l52w372jmjGDmhK2YrMGvesJnCju6+Not89NRyguvWuGu?=
 =?us-ascii?Q?+Kc6i3+0h9vSgAqGC71I00N9BfSo4o/tkxQtERDa5wAfPZa/MYcI5QSinZCj?=
 =?us-ascii?Q?OQAgK9EMR6nfP/uCk+0Tf7xCr5bBO6vJYXl/6cwSGFHNwl92KyLM/2ZZozA5?=
 =?us-ascii?Q?yjS1pb3GMQ56ifKVTSnlFHL5wHMeNBUmQnOvqXPo8VN5Nu/K77/H4V3wl5q9?=
 =?us-ascii?Q?/1InApAbNlc39a8YOxlxiIbSTRmum6JlPmu5E+Tn9kNf0Q/gh5CYMbd676hY?=
 =?us-ascii?Q?EM2oAqiZt/IMeABKqJv//6edvIGxAdkKX3AaCxkuTCK+s5/GeJhjnRf9FWxr?=
 =?us-ascii?Q?H+vuw5mT5faY6GVuRLed+u5FRkC/eSF8kBAFsNuhYfbGEsGbT8iDqgaYcFWO?=
 =?us-ascii?Q?FCXxDZ5aP9F+tnYApmLRDPrqeaHJuV26kOF44fHTxJUmyamnPAUUAV9MjbJA?=
 =?us-ascii?Q?TUt99/JfYmwxJHjyMq1ROTrdufRra+Zzab/uRO4S8Tmrd9vGcFucTK2hbFaT?=
 =?us-ascii?Q?dz/i+SaTAA+lnP5gVDpfsOThr9Bjo4Norj/nNXIiCj1fvOwlzGpbFfJACBOw?=
 =?us-ascii?Q?AZZcH5WiQIaaztPe6adyZSSM7w7wCHk4Rr3zygSFHKva4fjttnY12PuhXCaV?=
 =?us-ascii?Q?Wzx19ap1vsuq/BWjd2eNjEdoCSeNE8Zw0Ko4kcIcAxjdd+PXIQhxVbHk2Eca?=
 =?us-ascii?Q?BrRr1XmQCbUBff5y16evGrg2q0qyLqITfTk0MGzTpmqQrs1yI+4YcCQIhS3V?=
 =?us-ascii?Q?u53RX4oyI+ReKHPLIB9Wb9mAFppYxtnnMqhllBUiosbkUhQM4/66tzdGQ3LD?=
 =?us-ascii?Q?/lQlbKrqa7I0eB+Y96xGPHwZUpiQArdageglVocp7xtbxRNNwQZgpx2hg3Bl?=
 =?us-ascii?Q?bOb52R15eA3rZfHZER+n/BHBFkD1Z90yuSSKAvc72B8ehtEqmP6aNutByPml?=
 =?us-ascii?Q?++/ouumH3Z70BrRLW9jMINCmEMCZg8dS4F2KuZcwd1YEc8JHGqMGWvC6luYu?=
 =?us-ascii?Q?K1VvGjCvhKovg61jrxBmh0+Qw0p8MtdPfy1tXpecvCScKTAaquPkMDWlkx33?=
 =?us-ascii?Q?oigkufhe6tjJ94E9q6t/kxCK7HMo7OZA3oBjywvpr7L0tKl5v8ZXP0dob6cY?=
 =?us-ascii?Q?g5rKK/weQDCzms9ZlFame+jw6Lu0+Yr+vfZ7AA1wtfMof5ROmS/A/wyoMV7W?=
 =?us-ascii?Q?YMZWGYMgoweDYXnxbY+QGvNh7fO6DHCH2fo0ov0L/3q9/WyshjFmCQ7FuCR9?=
 =?us-ascii?Q?eIMmF8IcsiVdOLNzZ4jjlCOSiaKsT+s3w339Zyn0WdQddNEkXO+hdcBGH7Jv?=
 =?us-ascii?Q?Vu7DfXl8wOvnhLEgqf5oe7q2HSqgUIywhA9u1Zhf4mDE0CWJ2is8Qf0/LVpB?=
 =?us-ascii?Q?LxH7/hJ7ipA7mSrGMgfRhdWSMeeksc4DLlfpZNI6HJ/M5Bo7CDzgp6wm6n0M?=
 =?us-ascii?Q?cWdz16QZ2sxTD3BdSioGfbrIk7kB3eYAq7Dk2tCBE59pOqVC1R4pPMfbbhBb?=
 =?us-ascii?Q?PDqXjte718arRvFWUdPOk0KIMYGQFsNp8x91Nv4mi131Rin94tCOdiubmmph?=
 =?us-ascii?Q?ubNgQ2OEejYH1AClSS6W+J8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9f6ccf-d14b-41c0-7dd0-08d9dfd1f55d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 07:11:51.0308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4p2x6fgABDSPP7y/lPy8B9YgH/4eXB/jludj1d1KG68P3NlzyPtQ5ZK/9U8jC/dbhX635K3BSKDMGlxhLbBzyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4094
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
The firmware patch is since commit
b563148fd28623f6b6ce68bb06c3dd3bd138b058:
linux-firmware: Update firmware file for Intel Bluetooth 9462
(Fri Oct 8 16:30:14 2021 +0530)

and it's available in the git repository at:
    https://github.com/mingqian-0/linux-firmware.git

for you to fetch changes up to bb3eee4f99589d4910dee4c053a3a685546b5dbb:
amphion: add VPU firmwares for NXP i.MX8Q SoCs
(Tue Oct 12 15:09:57 2021 +0800)

encoder is tested with gstreamer
decoder is tested with gstreamer, but the following patches are required:
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1379
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1381


Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>


Changelog:

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

Ming Qian (13):
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
  ARM64: dts: freescale: imx8q: add imx vpu codec entries
  firmware: imx: scu-pd: imx8q: add vpu mu resources
  MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry

 .../bindings/media/amphion,vpu.yaml           |  180 ++
 .../media/v4l/pixfmt-yuv-planar.rst           |   28 +-
 MAINTAINERS                                   |    9 +
 .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi |   72 +
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   17 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   24 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/firmware/imx/scu-pd.c                 |    4 +
 drivers/media/platform/Kconfig                |   19 +
 drivers/media/platform/Makefile               |    2 +
 drivers/media/platform/amphion/Makefile       |   20 +
 drivers/media/platform/amphion/vdec.c         | 1694 +++++++++++++++++
 drivers/media/platform/amphion/venc.c         | 1364 +++++++++++++
 drivers/media/platform/amphion/vpu.h          |  356 ++++
 drivers/media/platform/amphion/vpu_cmds.c     |  436 +++++
 drivers/media/platform/amphion/vpu_cmds.h     |   25 +
 drivers/media/platform/amphion/vpu_codec.h    |   68 +
 drivers/media/platform/amphion/vpu_color.c    |  183 ++
 drivers/media/platform/amphion/vpu_core.c     |  870 +++++++++
 drivers/media/platform/amphion/vpu_core.h     |   15 +
 drivers/media/platform/amphion/vpu_dbg.c      |  495 +++++
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
 drivers/media/platform/amphion/vpu_v4l2.c     |  720 +++++++
 drivers/media/platform/amphion/vpu_v4l2.h     |   55 +
 drivers/media/platform/amphion/vpu_windsor.c  | 1169 ++++++++++++
 drivers/media/platform/amphion/vpu_windsor.h  |   37 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |    2 +
 include/uapi/linux/videodev2.h                |    2 +
 41 files changed, 12099 insertions(+), 3 deletions(-)
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


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.33.0

