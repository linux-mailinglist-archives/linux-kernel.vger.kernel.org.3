Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDB24BD605
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344919AbiBUGLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:11:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiBUGLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:11:50 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B286B90;
        Sun, 20 Feb 2022 22:11:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRUNWyINc47BdVx01RQ/oAklOpKBESA+pnqB6gcakC1HoijGQF6GktDLdLEInCM+h4AhCZfakMOoFxyFeNVB9KzaR6ApuOjvPhr/1sW5Z5hW+F3SwTWIhsQTseKoQLVr98fB+qAlZMDdhRVRxBRcWsXtA6j8jRNPcik3Z5UsclCrp9+Mq+t+/HPLiHyODecf4wxw9qQ/n1QCzxkvOeVlt9zkNvyX4R2XJjbuFBoPKQBgbmKV3/YC34HKVXJV3V7VNYHU9H34OIzdot2Bm+miHc6gcH523J/fV1YmPpVO3qQE/Eqihx8yRYSnp8XsjiAwI0LxOCT6eEH1rrxtHcJ3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVLGahD8XfNNjaBjUzushwuAoJCBmqjY4kkiNpoqRDA=;
 b=I9d52GuUrk2GKAArDuho/dglAzwGSVsYuMbcgKRVNU5EbijPhPxwWTmweQgGvlZzmr6Rljmf80kXMM4UAhuwhqUtQrg1imCOJ0LgqYK4lo6Vh/BUlYfS6OVoYIk6itvK6lhNK2oF3DWfufI/DUpNAZYOyY7R9Pq4TutyqND+qilHzY5es+La3GDbbmkzi3+qflF/ByDGPwLLX2Adom72HhZt8yb6gQgVqUE0AhLzCysRAZb8eYGzZYHQjtb61ZgWig/LnoaqCsMSVaMsgQEneXw90iHc+DKINoQ9ySSLWfKSYXDVlXaa9hthyizj52J7qlrRGBieyLxQbrP7/Gmeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVLGahD8XfNNjaBjUzushwuAoJCBmqjY4kkiNpoqRDA=;
 b=bSp+QDEW/gYSNFhZRfbEKfooPvnOvIobCICpqjbCxR6HjxmSkNnnH681ygQBvsV56rUd7YzaBcrfKahQJtj4YFwBcWoTdq6LSs/rZRyeptyntkX23qqa/YWSSFUOfrtXM178lZc5v03AflSpW9Tuk51TxNqXbwZq75RHL0a1KJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6064.eurprd04.prod.outlook.com (2603:10a6:803:f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 06:11:22 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.026; Mon, 21 Feb 2022
 06:11:22 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 00/13] amphion video decoder/encoder driver
Date:   Mon, 21 Feb 2022 14:10:19 +0800
Message-Id: <cover.1645422822.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6de9e502-7970-4ff1-3f3a-08d9f500fbf5
X-MS-TrafficTypeDiagnostic: VI1PR04MB6064:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB60641DF1B17A42F9DAF4602AE73A9@VI1PR04MB6064.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvcJnjdOCB+3P0XtamhHPXtzEs7czyyfY5Emeszrdogo4ssj2vp4Ye8BT6kxdBuAwruhHCxX0pVxeP5OYezMTs8ZS0EPDgbkF2B8IJXKjWd6zuLfPLeIhu9Tq2L8i8vVOW9dwfV9jA7Jfj6UmxGYAGI6werxOCs/M+WrNOPKXCHaloQxEsO89QjXLnaFumOHozSkifcpHjzz7PbhM9cUMM4ldfaUqF3eIweY14bIpktwbSGxoMBHWATaxV5ct643U1V1Up+5/KWKO3kvXlja9paXh5SD0Xq28Ud0vEeIoaSdMYFuHU831+760jpDUhV2t6d6/pEp3++FzMRiFc579eJkwyy0YFxmkB3MfgochCHo3/Sjdg97LBr6/cz/bO3R/F4fWbarXh49v02omctqS2HqLjKuAl2mcePXLmvjJQmCZd9DQY3AUEL2+lKCmjS+LKfdyXQtU0wJjGnYSTJPvUUa3jckqdDM4KLSEqXQ7WfgUSs4WiElpoADUmnluqUAAV0I7cToeh55Y3a/WRJBXzHJO2qYMELdJ06RZorVd1Igh3YCZz03dimBkj7k4wF7tkWpTYmBIhWSGQGoqn+CthJaJhBBl0eYkeuC4Rl3oWsAxM7G2oLrTMPS/jU30gqNeqf8vCf6tcpuLg54l9nq/WRI1TGektJIBvY+LxdjDg2hZVyX+KZYb5IUd1K/QL76/as0KlMvCcBX6cUHih+21Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(36756003)(966005)(86362001)(30864003)(26005)(44832011)(316002)(6512007)(508600001)(38100700002)(83380400001)(2906002)(2616005)(38350700002)(66946007)(66476007)(66556008)(8676002)(4326008)(6506007)(6666004)(52116002)(186003)(5660300002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R2CxYGZt+/LmSEz/NVvz5MiYVxqWp5+AlESS8tzAF0XnoncBgh3aRxxAhlty?=
 =?us-ascii?Q?xVqtrr8+5n0+wjn6M3+/aRaNpWrYUrsShCbhuQiBFEVWpFgbmlCuJUuTM6md?=
 =?us-ascii?Q?NO09kdmVRm2AcW5ZbD8FiHLHBpNZ1f7ig+GeJDGYW/XaXFd8wEglhQo046yd?=
 =?us-ascii?Q?N7obmC2f6Gfg3+X47El/h8P2qOERRMIHXnhDDA+LqrOtvf3dHbTH9qZOrddG?=
 =?us-ascii?Q?OdiZXjK8FGiH4NhjYgjukNl6/ULilFwvj/J38oAMVGY7CqqRMUFuMbhmbI9e?=
 =?us-ascii?Q?/hBrOL7S1wxM804n8gr9TK2Zzf9jo7fXD8hbwzXrhGjqAU9bSbL17N6jXMMf?=
 =?us-ascii?Q?bSqYQ1T3gTLtdS3FFGWUncRziF77mwDzv4fGR7bH3ZjI5zFE0ZCKaBzWFGem?=
 =?us-ascii?Q?0NCMM2rxnEebCoUkszijiKJtYLn0YKNhD4mGl5mYT152niewwJaWVSjVbW8a?=
 =?us-ascii?Q?lrp+Jrd1/kUX808mNHwXBC455qDASKlWpMtWIZblMyPPEnuEwbNIOjgRYp61?=
 =?us-ascii?Q?/FE35VVenxT4hz5NYq2Q43qIsT8IsbPXjoSs3z1ewbivmX8bY0QPOVILOvLf?=
 =?us-ascii?Q?71YDn5TJN7qFNbLr6DdYk9otPObJrG7XkcWv36416WT9J/FacxeRZKyj4BmQ?=
 =?us-ascii?Q?XF4AFmyc2WjBHBE+IZyPGnsA+qCX4gSDaDChKRiTDzFIS0Bh0X1MwTvlsARl?=
 =?us-ascii?Q?I9vgKvzH0g8ROVJSvERxcl7/q9mP2fTERN0eFIzCIxlFGJD+acqmA7JBbHM7?=
 =?us-ascii?Q?yc13RtUY+R1Qz+HVbfHdVoJHlhEdyJKDM7+Y4JhQoQq2PDFdg3LR/dp7FhgM?=
 =?us-ascii?Q?xHV8DZDxkLJUsQb3HI79BMBDkZa3kNxB6n/As8oJds/bSG/LrlRYs0bruPpm?=
 =?us-ascii?Q?jAJ3H/8dFrVPF+UhbtJ2DC9uQFsU5fUSCb9vcovbS4sHQQichs8/ZuUD9c31?=
 =?us-ascii?Q?YbG4vFrBiuuRWAVcCkTZDeYZzD6Kt1ATCWEVn8TV+gPHzxWA3IP/gZdmIw4s?=
 =?us-ascii?Q?bexTV2n+tpy6wMS8lDad/ZYywQD2g3RXSRaeII6/6CEi2qrPf4HY75l9heHr?=
 =?us-ascii?Q?5a3Tvpu6VFM0ykJ9tw5qWewLzucDATeCZR48bPALzi8RSR8eIRGHj9p5pi8C?=
 =?us-ascii?Q?m1pPADIsMCc1uVmYvrNqDVus+CebK0IsCBYkLs46Glk6sAFoJY9Z+zZvPCh8?=
 =?us-ascii?Q?BO2LPJu+lLzSYyHGQcXuXq8C/8xetro3KlTA0lirBQQlyCAzSdsim/QyVEQ0?=
 =?us-ascii?Q?YXWvpeE+FWluMoQVWHL6PGnqkR5knZeWPsqOEBli3g458A2cl+IM7bG+qpf6?=
 =?us-ascii?Q?fNGQWw1qbJFp1JXQw5i9B7mFsjW9pSNwYweXmOqr3N43znMVZ2Ec6UQt4HzV?=
 =?us-ascii?Q?HEK01xi/JpbdzKsIGVletcbHbbnGzZ6en4O1zb3gxIrwbkjQ0Xx7fbZ8Bfk2?=
 =?us-ascii?Q?bCq6n4k3ZlYZhuw9AW6e+CIfFzOEnYdZ9mHjS6+SpctO2fzPKcaTPz4F3iF7?=
 =?us-ascii?Q?hMUzrFLug7zDtSL1wUJBY5PJJzurc4NsGgg3aMDeU98zhczo3b6zISREYzwl?=
 =?us-ascii?Q?Tgq4ky696L2MjLqnFDqLrmtA3ZBRnkKYCjXW1mW5WYzq+BHOmQulueYvFDXI?=
 =?us-ascii?Q?YLsMjzmZoJmWuAEyRQgXnTg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de9e502-7970-4ff1-3f3a-08d9f500fbf5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 06:11:22.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydGTC7GwBJSDhDdOohU3j67gHa9IjuQ+r05vME1aguzvpDWWQUV0ziZGHdxyfc9frrRfSVXSg9scRhUpMS1rOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6064
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
  arm64: dts: freescale: imx8q: add imx vpu codec entries
  firmware: imx: scu-pd: imx8q: add vpu mu resources
  MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry

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
 drivers/media/platform/amphion/vdec.c         | 1695 +++++++++++++++++
 drivers/media/platform/amphion/venc.c         | 1365 +++++++++++++
 drivers/media/platform/amphion/vpu.h          |  356 ++++
 drivers/media/platform/amphion/vpu_cmds.c     |  436 +++++
 drivers/media/platform/amphion/vpu_cmds.h     |   25 +
 drivers/media/platform/amphion/vpu_codec.h    |   68 +
 drivers/media/platform/amphion/vpu_color.c    |  183 ++
 drivers/media/platform/amphion/vpu_core.c     |  871 +++++++++
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
 41 files changed, 12111 insertions(+), 3 deletions(-)
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

