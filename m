Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F5246300E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbhK3JwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:52:00 -0500
Received: from mail-am6eur05on2080.outbound.protection.outlook.com ([40.107.22.80]:18752
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235870AbhK3Jv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:51:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLXgkMDN5T2E6XxSknyre+dH/U5Bow+y4ya2jKPBoXCxrEogcfqLObpzeDnsASMoDz7c2RNp9uc9exqjt0vSZQay88rmNmPJYmr+AUZlSNMaSRHHKypcN3qYEKQ6FB6tN8NMiUSDS3Rl6LqIa0HAZ3EWviLoKs4YdWQPvvjlY2Qn2s05yisQ4OxZaxMqG9Z5SlrmcrGRi55AbPLntOY4zm6Ep2oLCaYjTTfsPD/6Lp/pTSmlFPl0gUif+vnllco2/2kRhuHWmRKUhIf0Mj6aZrF0yT9kl7X225INq8o1kQlXyByDKudFZtANOCqdC93tIGA0gc3GONtpnx7NLhJwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty2QW/+sRFpdOqVl58OhUXSOi7BfAVkj5HeGHEBtZZQ=;
 b=khzG6lzrhfhoc00kBbJlqaoO9BKMrprQOkm5nWff5XFATRAHnYCUWaa6OiBn1aGJ7CuYUxJA6OB8zou3l7d4Gb+mctsNYCGyBZBCg+7szkbOvTsFfAtOI/0oMsmsk8R9mwqe2n6AuW1fS2wUflChxGAYE1c6RizuX/dNQ4hZLq5t7oldYUJedt+zVb9stMAY/qg/WhCIg3/5kCahOkOd4mq99Ijl0yCj0OvqQtObLVxM4eAwxkT135zpri1/Jh4AFZNVbKtX1hJRbDRCjxTu+hVrXraWHgfkLR9K5bIinMqL+2ysi4clWQZc1IHjW61DDjGaHpNqWWE2pc/oJB/Emg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty2QW/+sRFpdOqVl58OhUXSOi7BfAVkj5HeGHEBtZZQ=;
 b=ktMKkEEvvkZlB9AzwZwXPq0DDGeIVIgzhCHazwIXdO2saUjRs7Yo7kfBM5VaHtNlqUMdUmdMh/B6bNH5vyQlTkqOXNwTDSvxvj1DUQ/6DUeRSpSXCN+SLCcdkWTmS/s+SsFd/TzDukDG8BhVfIb/VVNqMfAThXPzpMaFkJ7C3X4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3925.eurprd04.prod.outlook.com (2603:10a6:209:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 09:48:36 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:48:36 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 00/13] amphion video decoder/encoder driver
Date:   Tue, 30 Nov 2021 17:48:01 +0800
Message-Id: <cover.1638263914.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SI2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 30 Nov 2021 09:48:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff33f937-c847-49d6-d479-08d9b3e69415
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3925:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB392587F72FE3091B5355B300E7679@AM6PR0402MB3925.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHyqOt8N8oXzp7rKo38EMxZJCmcBx+p0VZCvjpJAr+sIyECcD6i3w6rkAulgQ5ZIrf4UFUHPPV7Qo1p3wV0MU7dxTVt/3B7YhSgHjqtSFMcIlzuboeTvrPlFYKdTaMPqywCI13HXlu9kFd0CZ+y4yYkQ/J/Yl8R/U+MhmhL6uzjD0Q21mLjCou1OzwQqTq9hz21LBZgFgSDkQ0iZOPV8h801OYXTedBi7fHbk2i8t+mYxF3dFhX5xQXdnNR8CJZnUrFDpvvQU5sMzDx+VYwtzqF9TQ/ttOZayGNZCKq+ICkdvWG+WUQB8z700Qj7kNDouRrlY0C83P658W8hTECwQO8N2HZWra7YsT2l1bJNTGvane1uOB7fqU38YbEz2XSuhrISx30GtlSUWlckrCbIRN2zu9jS6L8aM7dpmL7rIggp96JJDacdA1ars+jvRMSnVwexQS8zWKBNg/8QdFLI668YIF96AVP3hmKlYXozKR8WyjjGCHG626zr+hTiWvYM/M1XEDdJrHv8BCI7Yfl9PE9OOQghulCgzPP9bqySF/eevoqumQDtMvoLHbvDZ5xhgIzouQlZenBPSURqro4qOG+sgl4cemFU+nMq/jjsGtJe3bPEzHG+kov730LcnagET3zr/Y05sXACoLUzGoppdBXR71U+UOCH5OUazaDzBzxCTK0p6qjkcL4o71tujDWsITbIpdxh3w8bjR75I4KoB0/b+P3a8aLhJRBTXwfLC2xZIlYZGoNlKE/R1nQir1clfnIx0Hue1YfE0genE2JWNx3Rx7qOikd1xLBMWg8qg3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(5660300002)(52116002)(8936002)(6666004)(966005)(508600001)(66556008)(7416002)(316002)(86362001)(6486002)(26005)(186003)(956004)(36756003)(2906002)(8676002)(7696005)(44832011)(66476007)(4326008)(38350700002)(30864003)(2616005)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PEvbQ56txXpWlQLZm6QgRsjW9+rOYWqZAfdpdlBq9Q4DlG2XK0oJe9/wjwA1?=
 =?us-ascii?Q?AiqcAiEn7ZUAvWtJvq7xyTSodkGH+X2ZgrTYu8FQ0jUq4y7ZjFjEVrTRBxGm?=
 =?us-ascii?Q?X06AsqutLHqut6H2cjsNjnDWU4tg+OeCpDVsVdCENabwOEJ17TIdaeU3NBy4?=
 =?us-ascii?Q?Vni2EM+M8mW6i5kmS/ISpdXTtMGLnUrI9FjpXgHwvaUKNO2j5MO3QF6nSTta?=
 =?us-ascii?Q?kwJb4+WdF4gAA8Y77T3RC8TFXFyhNrHW0ibYWFvDL58fMW8uIzKVjzr8T+/Q?=
 =?us-ascii?Q?YOVLJE/jPAGKJBWFbquRl+tSI0qg4CxWCwo6NIh8q9F4v8OKndTYzzGnX9it?=
 =?us-ascii?Q?RwTQ6cvKi1gGDhrQ0kaZiLTfRM7mtfBnige12En8/HQbrx2qXsrVUu4qSE1h?=
 =?us-ascii?Q?rLDo9YKB3VRjC90Jrq/96nbsHu5ikYHSTU2ZD4/MgD2/1qErwI6g44AfeU7T?=
 =?us-ascii?Q?+qSTejAkJn61eIQ/EiRP5EVIv5mKuuCzNuev9P5xGGY960Bl+E5OP1aKhWJZ?=
 =?us-ascii?Q?72nV6vnB9mHAD14fHayUmC8WswAoux8aBKOql9QF9rPzNldaJpjxFslRCxhw?=
 =?us-ascii?Q?c5tsJiNAE0KghM89HIGOcWWfTzUlIbTaqMG7FqAuGTJPVaFOkc3d2hJnNm72?=
 =?us-ascii?Q?sa/0G5Itb9W5gFBh3YQFnd97wAxuuM4uTm4/rPJRed36TZpEjwzx7Bo1kZeS?=
 =?us-ascii?Q?PpoVNW41Uy9DlHjHBJvlhNOeqc16cEvPNYoVqh4pSsDZpvsYGodJhD5S0kRg?=
 =?us-ascii?Q?lJM/RiT33ZraNs/Xz4eCe5Y1UOQLB5Kpwqry3tNw4y+4KqxhcolCsGX4jwPl?=
 =?us-ascii?Q?DoX93b/bpjIgwXEzsubSgkTtyzSW7t8gr2ph7DbQc9Oi4Fp/b88y8sM7HgoW?=
 =?us-ascii?Q?4Uxb6q+WiSlYcDonnA/5mksc/PkSCgwxcjAPx9gn5KxgeRUt6qZJtQLDiAPy?=
 =?us-ascii?Q?S/zB8yZBpmMAEYXHnWH/P5NxeYyIrQndZ5zepTAj0yokwt1rHow2XivNfpDY?=
 =?us-ascii?Q?sIZ7dQO8G+AlILSIYZubTPDLqZOGi/mGkGvSKxAKE5xEITiY1T6VtzKAj6sq?=
 =?us-ascii?Q?wjwZR2yjpLWWlyvT6pislFhjVdw786/ZhJElo6vh72+mh+YBLFP9J+a4giKF?=
 =?us-ascii?Q?NehUJpQzoWJJsYAy74NcHNHo4+Fc+LmUZ9j2gk2MtQM/A0amS6YxVr3CFMGx?=
 =?us-ascii?Q?wIXBteU+M84gO0QC7WdnpMuKgyAuMOpJbgYCuRWe64kqoHir4eHChy0cmGwD?=
 =?us-ascii?Q?79nA197ykwVrD38UZ/obXfQeco/O9Xy5E5u+eC+fGhbhxV639IkQ2DyvSQeS?=
 =?us-ascii?Q?K6qzxgSgvFEmNBTjcL7Z3wQ0kENn38YGoIfW9mC+9w3qaRsd1MiWwDqiDblW?=
 =?us-ascii?Q?5RvUk4hkExKEvab1HstaUP7QshuUaX7K/dFFyfFaV8FO8vSTl4b2X95pXOw4?=
 =?us-ascii?Q?21i8/G9fwZo/fWRuKQufb5EUKM7RIGs4tHM996EwC8yqYYcvqb5Qu1d5/NB6?=
 =?us-ascii?Q?6DZRbwMqR/6V9eYfgrQvzcJApYWJd+Qy5nPBaB9LEv+0hA2tGEVeEREU/bVh?=
 =?us-ascii?Q?7viv3AG8JCcp3pQ5GqPhdS+Lur4YO2Qtqsg0QMhxnYHi6c58ihYxQAQoCMHR?=
 =?us-ascii?Q?ealrix5P4xEbeYycV3dvsMY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff33f937-c847-49d6-d479-08d9b3e69415
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 09:48:36.0882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReyUmAj6IPCg/kL9d3zZcL19mGIQfCyAps9QYP1utyW0lfBrcWHsyIfG3SM7lGFiNsJnnIF4z9Sk8oD1FlKGCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3925
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
  media:Add nv12mt_8l128 and nv12mt_10be_8l128 video format.
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
 .../media/v4l/pixfmt-yuv-planar.rst           |   15 +
 MAINTAINERS                                   |    9 +
 .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi |   72 +
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   17 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   24 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/firmware/imx/scu-pd.c                 |    4 +
 drivers/media/platform/Kconfig                |   19 +
 drivers/media/platform/Makefile               |    2 +
 drivers/media/platform/amphion/Makefile       |   20 +
 drivers/media/platform/amphion/vdec.c         | 1680 +++++++++++++++++
 drivers/media/platform/amphion/venc.c         | 1351 +++++++++++++
 drivers/media/platform/amphion/vpu.h          |  357 ++++
 drivers/media/platform/amphion/vpu_cmds.c     |  439 +++++
 drivers/media/platform/amphion/vpu_cmds.h     |   25 +
 drivers/media/platform/amphion/vpu_codec.h    |   67 +
 drivers/media/platform/amphion/vpu_color.c    |  190 ++
 drivers/media/platform/amphion/vpu_core.c     |  906 +++++++++
 drivers/media/platform/amphion/vpu_core.h     |   15 +
 drivers/media/platform/amphion/vpu_dbg.c      |  495 +++++
 drivers/media/platform/amphion/vpu_defs.h     |  186 ++
 drivers/media/platform/amphion/vpu_drv.c      |  265 +++
 drivers/media/platform/amphion/vpu_helpers.c  |  436 +++++
 drivers/media/platform/amphion/vpu_helpers.h  |   71 +
 drivers/media/platform/amphion/vpu_imx8q.c    |  271 +++
 drivers/media/platform/amphion/vpu_imx8q.h    |  116 ++
 drivers/media/platform/amphion/vpu_malone.c   | 1679 ++++++++++++++++
 drivers/media/platform/amphion/vpu_malone.h   |   42 +
 drivers/media/platform/amphion/vpu_mbox.c     |  124 ++
 drivers/media/platform/amphion/vpu_mbox.h     |   16 +
 drivers/media/platform/amphion/vpu_msgs.c     |  414 ++++
 drivers/media/platform/amphion/vpu_msgs.h     |   14 +
 drivers/media/platform/amphion/vpu_rpc.c      |  279 +++
 drivers/media/platform/amphion/vpu_rpc.h      |  464 +++++
 drivers/media/platform/amphion/vpu_v4l2.c     |  703 +++++++
 drivers/media/platform/amphion/vpu_v4l2.h     |   54 +
 drivers/media/platform/amphion/vpu_windsor.c  | 1222 ++++++++++++
 drivers/media/platform/amphion/vpu_windsor.h  |   39 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |    2 +
 include/uapi/linux/videodev2.h                |    2 +
 41 files changed, 12287 insertions(+)
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


base-commit: 999ed03518cb01aa9ef55c025db79567eec6268c
-- 
2.33.0

