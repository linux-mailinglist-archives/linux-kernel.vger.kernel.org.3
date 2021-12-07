Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E175046AFB5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354917AbhLGB1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:27:34 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:37620 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1351889AbhLGB1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:27:33 -0500
X-IronPort-AV: E=Sophos;i="5.87,293,1631545200"; 
   d="scan'208";a="102606236"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2021 10:24:02 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C15A24172F32;
        Tue,  7 Dec 2021 10:23:59 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 0/3] Add driver for Renesas RZ/G2L CRU module
Date:   Tue,  7 Dec 2021 01:23:48 +0000
Message-Id: <20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series aims to add driver support to CRU module found
on Renesas RZ/G2L SoC.

The Camera Data Receiving Unit (CRU) consists of a MIPI CSI-2
block and an Image Processing block. The Image Processing block
can receive video data received from the external Digital Parallel
Interface or MIPI CSI-2 block, and perform appropriate image
processing for each.

More details:
* https://renesas.info/wiki/File:CRU.png
* https://www.renesas.com/document/mah/
  rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en&r=1467981

Currently the driver has been tested using yavta and Gstreamer
on RZ/G2L SMARC EVK using the ov5645 sensor on CSI2 interface
only.

root@smarc-rzg2l:~# media-ctl -p
Media controller API version 5.16.0

Media device information
------------------------
driver          rzg2l_cru
model           renesas,rzg2l-cru
serial
bus info        platform:10830000.video
hw revision     0x0
driver version  5.16.0

Device topology
- entity 1: rzg2l_cru 10830000.video (5 pads, 5 links)
            type V4L2 subdev subtype Unknown flags 0
            device node name /dev/v4l-subdev0
        pad0: Sink
                [fmt:unknown/0x0]
                <- "ov5645 0-003c":0 [ENABLED,IMMUTABLE]
        pad1: Source
                [fmt:unknown/0x0]
                -> "CRU output":0 []
        pad2: Source
                [fmt:unknown/0x0]
                -> "CRU output":0 []
        pad3: Source
                [fmt:unknown/0x0]
                -> "CRU output":0 []
        pad4: Source
                [fmt:unknown/0x0]
                -> "CRU output":0 []

- entity 7: ov5645 0-003c (1 pad, 1 link)
            type V4L2 subdev subtype Sensor flags 0
            device node name /dev/v4l-subdev1
        pad0: Source
                [fmt:UYVY8_2X8/1920x1080 field:none colorspace:srgb
                 crop:(0,0)/1920x1080]
                -> "rzg2l_cru 10830000.video":0 [ENABLED,IMMUTABLE]

- entity 15: CRU output (1 pad, 4 links)
             type Node subtype V4L flags 0
             device node name /dev/video0
        pad0: Sink
                <- "rzg2l_cru 10830000.video":1 []
                <- "rzg2l_cru 10830000.video":2 []
                <- "rzg2l_cru 10830000.video":3 []
                <- "rzg2l_cru 10830000.video":4 []

root@smarc-rzg2l:~#
root@smarc-rzg2l:~# v4l2-compliance -s
v4l2-compliance 1.22.1-4864, 64 bits, 64-bit time_t
v4l2-compliance SHA: 47c8c377cf29 2021-10-23 15:12:35

Compliance test for rzg2l_cru device /dev/video0:

Driver Info:
        Driver name      : rzg2l_cru
        Card type        : RZG2L_CRU
        Bus info         : platform:10830000.video
        Driver version   : 5.16.0
        Capabilities     : 0xa5200001
                Video Capture
                Read/Write
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x25200001
                Video Capt[   32.432429] rzg2l-cru 10830000.video: =================  START STATUS  =================
ure
                Read/Write
                Str[   32.442279] rzg2l-cru 10830000.video: ==================  END STATUS  ==================
eaming
                Extended Pix Format
Media Driver Info:
        Driver name      : rzg2l_cru
        Model            : renesas,rzg2l-cru
        Serial           :
        Bus info         : platform:10830000.video
        Media version    : 5.16.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 5.16.0
Interface Info:
        ID               : 0x03000011
        Type             : V4L Video
Entity Info:
        ID               : 0x0000000f (15)
        Name             : CRU output
        Function         : V4L2 I/O
        Pad 0x01000010   : 0: Sink
          Link 0x02000013: from remote pad 0x1000003 of entity 'rzg2l_cru 10830000.video' (Video Pixel Formatter): Data, Enabled
          Link 0x02000015: from remote pad 0x1000004 of entity 'rzg2l_cru 10830000.video' (Video Pixel Formatter): Data
          Link 0x02000017: from remote pad 0x1000005 of entity 'rzg2l_cru 10830000.video' (Video Pixel Formatter): Data
          Link 0x02000019: from remote pad 0x1000006 of entity 'rzg2l_cru 10830000.video' (Video Pixel Formatter): Data

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
        test VIDIOC_LOG_STATUS: OK

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 1 Audio Inputs: 0 Tuners: 0

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

Control ioctls (Input 0):
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
        test VIDIOC_QUERYCTRL: OK (Not Supported)
        test VIDIOC_G/S_CTRL: OK (Not Supported)
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 0 Private Controls: 0

Format ioctls (Input 0):
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK

Codec ioctls (Input 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Test input 0:

Streaming ioctls:
        test read/write: OK
        test blocking wait: OK
        test MMAP (no poll): OK
        test MMAP (select): OK
        test MMAP (epoll): OK
        test USERPTR (no poll): OK (Not Supported)
        test USERPTR (select): OK (Not Supported)
        test DMABUF: Cannot test, specify --expbuf-device

Total for rzg2l_cru device /dev/video0: 53, Succeeded: 53, Failed: 0, Warnings: 0
root@smarc-rzg2l:~#

Cheers,
Prabhakar

Lad Prabhakar (3):
  media: dt-bindings: media: Document RZ/G2L CRU block
  media: platform: Add CRU driver for RZ/G2L SoC
  arm64: dts: renesas: r9a07g044: Add CRU node

 .../bindings/media/renesas,rzg2l-cru.yaml     | 227 ++++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  59 ++
 drivers/media/platform/Kconfig                |   1 +
 drivers/media/platform/Makefile               |   2 +
 drivers/media/platform/rzg2l-cru/Kconfig      |  15 +
 drivers/media/platform/rzg2l-cru/Makefile     |   4 +
 drivers/media/platform/rzg2l-cru/rzg2l-core.c | 473 ++++++++++++
 drivers/media/platform/rzg2l-cru/rzg2l-cru.h  | 244 ++++++
 drivers/media/platform/rzg2l-cru/rzg2l-csi2.c | 625 ++++++++++++++++
 drivers/media/platform/rzg2l-cru/rzg2l-dma.c  | 703 ++++++++++++++++++
 drivers/media/platform/rzg2l-cru/rzg2l-v4l2.c | 361 +++++++++
 11 files changed, 2714 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
 create mode 100644 drivers/media/platform/rzg2l-cru/Kconfig
 create mode 100644 drivers/media/platform/rzg2l-cru/Makefile
 create mode 100644 drivers/media/platform/rzg2l-cru/rzg2l-core.c
 create mode 100644 drivers/media/platform/rzg2l-cru/rzg2l-cru.h
 create mode 100644 drivers/media/platform/rzg2l-cru/rzg2l-csi2.c
 create mode 100644 drivers/media/platform/rzg2l-cru/rzg2l-dma.c
 create mode 100644 drivers/media/platform/rzg2l-cru/rzg2l-v4l2.c

-- 
2.17.1

