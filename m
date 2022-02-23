Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E473A4C1192
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiBWLl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240086AbiBWLlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:41:18 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B5396827;
        Wed, 23 Feb 2022 03:40:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDCA3nIP4qMSRZNgrdvtojmmNqJlSnjSzlJiSMi5Pfku63ODv2OT92Qde501KFc6zVvrbYBXADYrLlCfzVKkyFdPGmIVtwcjRtrPnpYFOBztpY+PbOwSn86VxEY7SUHg8GR4AgToswQxOOvAPa1/Z8t4aoavvw+HFE1eTOeDh33mOQN71vnD3zotvJExUnEnKTwfrbGESOPONCeOYRi2aDh0CiK81XPZoOoM/4//19MPC9ucEkEQCLHYlK5cbDZF4OnfPy2TKo/JReKqa5Bs3st270TVxYuiT88+N12rfxMCbbQki6bLJAPuoDJkqDYrN//s9GUERtN+ti1CzeZNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xU1Vb5o2bKltW81K5hyMoBJrzc/W2aFZg9DvcWaLZ0g=;
 b=dfOtjIxvj7PtZ/3oH21mjUXGcVKaJV4XX3Fe35wbsqYLAf0vGwLLeuDgQFG++11u89uWcPV/p3wBRXusK2F2u7971wwDlvURkVQQ/oOdG7vzuoK2dWtPYqxjFCHX/excmZHiQRouuh6ravGOZcTFgVA17UWUhSaf9P5StDYjuHJR7vXXAUcyNUv5++w5sdb7TC/FTKabw5Pjn7Oupt/7AcdpjzfGbPAASp3EYFD0clTweFdvGGDTRgltod8oaGrdpgwNfr6ry3DaDwtxZZ9mykeZGQAybfsv7DXsOtlTcN7xxIsDvOi98waHxcHpQKkAjIAvFmu46D8RkWwIO+m75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU1Vb5o2bKltW81K5hyMoBJrzc/W2aFZg9DvcWaLZ0g=;
 b=ZGpr9JumYW9rEgahmz6LjJ2l8WvXCiXteyvnvJk2fBCx/bgxTQ3STSBii9PSHqA4U6E38oSYBCDmVhXRhlRdvnVT3/Bk85whGrU7Bvmp6jhR+FwUkmWajlnRM+hJL2lxwBJGefanYPUs0WCAwZkKbkebn1NeS0P1hyxAXUVh+sM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 11:40:45 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 11:40:45 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v17 00/14] amphion video decoder/encoder driver
Date:   Wed, 23 Feb 2022 19:39:53 +0800
Message-Id: <cover.1645615976.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:3::25)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78f2282b-f1cf-4b7f-311c-08d9f6c153fc
X-MS-TrafficTypeDiagnostic: VI1PR04MB7055:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB7055D309C4AF9118E24CFDFDE73C9@VI1PR04MB7055.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1V0JYtOFCX9+vgIuJIF4a/O3JgmrjVQdi2Rqqqy2lMJfb6OjIzdZBM35L74WJ6wmhqz8xDnO5kA/eHdqhnQQcxuYlNcwGE3ahQvD2Bms+b5MfeEyBnoBvI9+4FX0wjb4NYjbJLMZwaIBQY8J89z7IXKFl/9r8qF4ZWigKITLS+anEdGMcPsc/h/hudhBs7VfkpZEfRtYx0gOIW1CcEy2NywU2FEG/3tB7GIMDb4GiNJAud0yfw4N+fJXbzyFi9QEe0WxWs/v7DeLgyfmYuzbQsAaKc1MR9JbL54w4XzwlBPINAE29QSQMXljPoNmcTc5lWTG+/Dk6f86frNRo1U/XU7lmtJFYtQya2EDdaNBmprBaefHVMKIuygUSrOKWB7L+jds5wgxRNxeud1zGBHwYB7A5q8CQDI2IEhlAr/9eRQMZfeIYf4sHo/CPGQRCiMVYaRcqs+rG1KqXoNCjLoECVLSWgih6kD7Yeoj8vehITuNjp/ir9cwNifK262ggMsbcIEDwtdyk2+nI2oaCj/WEPw0DuNRfe+HdW8ZSJCsJpvDdr0zSfpXBivwjUKD0uxhoraZBO3XgQ8F05JNftk41ntwYwei4BvobBzLo2LX4wyFgj+RUC7kxuApr/sWn0gLCZzyQu1xOmBj7cjnwPSaDeQUsgiHl0NEHYTfm6NznZn50EGi3UJWoBl1TsGIYmavQfcA1jDck/5rrmsc7/alg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(30864003)(508600001)(86362001)(966005)(6486002)(8936002)(44832011)(5660300002)(7416002)(6506007)(66946007)(2906002)(66556008)(66476007)(186003)(83380400001)(52116002)(6512007)(2616005)(8676002)(4326008)(38100700002)(38350700002)(316002)(6666004)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aNAQlf5yKEzOWyGm9Jn76nAKqXjoLK013NBQm5xx3qyNr1nE1IsJCrNoHqLC?=
 =?us-ascii?Q?kiRjkzDle5ZOaKUOf9WsrdvXw6snQ9RjHt44dhRRDKLolxkWh6QwW1eNOiY3?=
 =?us-ascii?Q?Qm0gN7EvBLje3Pl/aeTXPN3Xd8D7d7CsCLIcxbUpjfXH8PsZ/DzSN89hRn2o?=
 =?us-ascii?Q?re1f6n+X7t5cLUW5Ko7nFYaXMNnJ76ItV2x+TyUomleu84V8/D6Cfyxg41wl?=
 =?us-ascii?Q?KYyr5/Njk9LRRBhzinWkFSStSwTKnb6m+uczCVxhzNy0E+LSDOO14lc0fTfa?=
 =?us-ascii?Q?5W7kiWIr/VrUZCIjkfdmInGfQ8V2lozvt688pngDiEvX0S5fbyimCg6f+lqU?=
 =?us-ascii?Q?m/DjIzAyPfALJ2IRhP3dNCNLFZnjIhlrFRRTt1W27NatGy9jxHVps+uXlXP+?=
 =?us-ascii?Q?sfFhYt73SwTOnWvyJnLOvifG/6tMKdAonFb8LAUM8GVmhBVGxJ1uYbnbhhgv?=
 =?us-ascii?Q?4feooSUJt8N1sXvAYPk+wfeVOcvoxwlSDuQYCBvUFZwxrLTd5c4fHqzV9Y+H?=
 =?us-ascii?Q?VtGSzln3tikpUQfjLpxi9kSXRRQDFh26H+/+RgwXs/XK6NGJZkVfVyae6Ilj?=
 =?us-ascii?Q?5IidWCLB1YTJR4hZyHQARjnyR1p1Uyntoexr6KvH7TSCkeBu9igbIhtRgngQ?=
 =?us-ascii?Q?aY/DrRogOi4trH3DfdZ4H14c5fJ6A8b/2a+ZzCvfVP4IZ9R2ZQ0KxfOZzOah?=
 =?us-ascii?Q?s83/6pAi5JryZ4DQXYbfMYDx+SsVmc3JDYlCsbEjr5rxfmo0O8inw/3e5Nvc?=
 =?us-ascii?Q?P/HK80nh+eQpJCvDTAh3FgJ9TUaA644PoOnP+d6mByt7ulYPuTD2oNy//H2c?=
 =?us-ascii?Q?udo07kcTQy9M6duNR7FGN+OZbAJklTnPlU1qb9zWo2kMlt7Tu7ilBODWpfsj?=
 =?us-ascii?Q?KuaABym5I8wZoXiF3FCB7y30wjJqEbvhgglRhFe2TFp4d97qffwQc3L4jldR?=
 =?us-ascii?Q?i/nf460XlDoy1PX5l3RKPkTLd+lI5R6mmTNtgZzMJfpJHRhbtsPn08AYoHQO?=
 =?us-ascii?Q?YrNdtx8Zos399Yyd7yaeKuk5TPoaBQQBSNPWdq+C8lXN4j4x8kE4fDX2Js5H?=
 =?us-ascii?Q?FvcmH7zOe4rbqgwS2lu7ba57AKhGdRpTo+et4Qyc1LW0zF6fKHanSqjFNmnC?=
 =?us-ascii?Q?uV5SBwOya9L1a4QiiOn3/u7McMQjVJmihbFlxlqWqyBjM3FwRR8z+MY9aIf6?=
 =?us-ascii?Q?InF6VFn83Tf1SpbS8dALmil5LcAY+GsZYycTCi6HNdub8vFKoWr3L6BpJBSQ?=
 =?us-ascii?Q?57j0V01tX+R7zI8RY0oPPQz91lkuAsMMKuDQzEzl0aYPKVPgp+tfy1wwM1QQ?=
 =?us-ascii?Q?5e6kbbdwCltP5cSDimuF77KXRbNp410YmzUtGquqG4GIG2lq2QPsOaaqCAuw?=
 =?us-ascii?Q?eMnkXx3WlfimX3SD2mzbOa4ghBZYmq6U0VCRFpEJnp5DUCfxL4qfc7pZfZHO?=
 =?us-ascii?Q?mEUfUPvHFM9MvrxrxBWwlSh5MtO01VQuN+e1HWhuMFiDynPHpCxeNAu17gvv?=
 =?us-ascii?Q?8ntmYJZo4p6t/kMeiGgIw0H4ETo2VkuL1vV/cdUeoUDMf0aZk7NUeWLkEf7I?=
 =?us-ascii?Q?en9SNiF+kV61ji2yY4+CuWS0EXCcajSXtZEhi6Qne8Fk6eS/LcEJ2KAsB99I?=
 =?us-ascii?Q?Cg3gFhO88lPadV9lpRnhqBo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f2282b-f1cf-4b7f-311c-08d9f6c153fc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:40:45.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRNuLN3CyQCahsHd+t3QPbGF6YvXvUtr/t1zRvwRx2F/rxzy2o5g5TULxSpiEckk0LyHtWxkJ7w9EkdVRE+Qzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7055
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

Ming Qian (14):
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

