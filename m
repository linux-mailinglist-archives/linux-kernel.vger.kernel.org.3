Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C18B47B4AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhLTVF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhLTVFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:05:25 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624B4C061574;
        Mon, 20 Dec 2021 13:05:25 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v64so32551210ybi.5;
        Mon, 20 Dec 2021 13:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11d8rru2EETSidFcm3mKKqRNQPAVKAx85vb8qThmIl0=;
        b=UDKiiLBkBaWzvDkcGzMCHFrjzyHmxnl2QCjJMRz1Z5V7OdHVKmD6HWdmxdcbyc5Be8
         gZ+YvUM6twHNZb/cD09bV4u3UpKDNcuBFBf0v8/bvpOv3wcLA49KYlleZAVn2QQANpXR
         UwYdULLdZFWM+ElsQNmVuG4sj50bl82i0JChCsXi9ppNYf/GeQRVJ5me2Y0ToslMFR8R
         N6U8A89YCarRlmJpPak5pPM9ghDfYmwqNKQ6gfjXdddkJgtczfLnk6D7IioqMi/MXZsz
         TS+zK8mMxsVNRtw78aBm36rAyK+olnV2bbmXhP8ZbLgLM0xHvWMivN4aKD/R9QqRxUR7
         1tIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11d8rru2EETSidFcm3mKKqRNQPAVKAx85vb8qThmIl0=;
        b=ysgQhOp4lx1tzDxLLBZCbASrhibyRPXWNXrfVArtWxc3Dj1MCmS95gaVY+3KIg/G1M
         dRRkXFBgjofnrD1VI17xInUZ6RvwazA0AJoQiRXTHiFQG5AU5tjQs+z/D1LNSKZ/qcqM
         0+njN+C06wEmmb+9mYil5X6+xJUuNt1wayAZsOmmuhsn+lVrUXHipAHT+Syst5g4wWEW
         04LTXAB72S5ypGz9BoU/WTKVXGbD3p8tkBWu4v2jHViC2UB8EKz7+KsRYtBygsA/Nh3P
         BqCDrR7y6zV5NQZwSjRLepflU0tQjPVQLS3fBx4LHt9h5ILPk/4bKcET2JTMG258PexX
         abrw==
X-Gm-Message-State: AOAM530aGks7kppmjUtXlx9CkAv4IzPY98RMFSVo9i4dHXB3KaEPAZJz
        08x1ycTNoBlwABGKZg5uTJ7ljYCxq8NoARKCe8c=
X-Google-Smtp-Source: ABdhPJw7iPUl2I11F5tO5pNQm+Kffo/hSzHDFBQA327eaz9L75bQW8MdDDnHSCZyFUSLgRXKNSEiNsrYvFi0/oiqzco=
X-Received: by 2002:a5b:ecd:: with SMTP id a13mr2878221ybs.251.1640034324516;
 Mon, 20 Dec 2021 13:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 20 Dec 2021 21:04:58 +0000
Message-ID: <CA+V-a8tVjv4gtGWD55Mh8e-P2gFSXYnwP26LsDi1yj3sCfCdMA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add driver for Renesas RZ/G2L CRU module
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 1:24 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Hi All,
>
> This patch series aims to add driver support to CRU module found
> on Renesas RZ/G2L SoC.
>
> The Camera Data Receiving Unit (CRU) consists of a MIPI CSI-2
> block and an Image Processing block. The Image Processing block
> can receive video data received from the external Digital Parallel
> Interface or MIPI CSI-2 block, and perform appropriate image
> processing for each.
>
> More details:
> * https://renesas.info/wiki/File:CRU.png
> * https://www.renesas.com/document/mah/
>   rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en&r=1467981
>
> Currently the driver has been tested using yavta and Gstreamer
> on RZ/G2L SMARC EVK using the ov5645 sensor on CSI2 interface
> only.
>
> root@smarc-rzg2l:~# media-ctl -p
> Media controller API version 5.16.0
>
> Media device information
> ------------------------
> driver          rzg2l_cru
> model           renesas,rzg2l-cru
> serial
> bus info        platform:10830000.video
> hw revision     0x0
> driver version  5.16.0
>
> Device topology
> - entity 1: rzg2l_cru 10830000.video (5 pads, 5 links)
>             type V4L2 subdev subtype Unknown flags 0
>             device node name /dev/v4l-subdev0
>         pad0: Sink
>                 [fmt:unknown/0x0]
>                 <- "ov5645 0-003c":0 [ENABLED,IMMUTABLE]
>         pad1: Source
>                 [fmt:unknown/0x0]
>                 -> "CRU output":0 []
>         pad2: Source
>                 [fmt:unknown/0x0]
>                 -> "CRU output":0 []
>         pad3: Source
>                 [fmt:unknown/0x0]
>                 -> "CRU output":0 []
>         pad4: Source
>                 [fmt:unknown/0x0]
>                 -> "CRU output":0 []
>
> - entity 7: ov5645 0-003c (1 pad, 1 link)
>             type V4L2 subdev subtype Sensor flags 0
>             device node name /dev/v4l-subdev1
>         pad0: Source
>                 [fmt:UYVY8_2X8/1920x1080 field:none colorspace:srgb
>                  crop:(0,0)/1920x1080]
>                 -> "rzg2l_cru 10830000.video":0 [ENABLED,IMMUTABLE]
>
> - entity 15: CRU output (1 pad, 4 links)
>              type Node subtype V4L flags 0
>              device node name /dev/video0
>         pad0: Sink
>                 <- "rzg2l_cru 10830000.video":1 []
>                 <- "rzg2l_cru 10830000.video":2 []
>                 <- "rzg2l_cru 10830000.video":3 []
>                 <- "rzg2l_cru 10830000.video":4 []
>
> root@smarc-rzg2l:~#
> root@smarc-rzg2l:~# v4l2-compliance -s
> v4l2-compliance 1.22.1-4864, 64 bits, 64-bit time_t
> v4l2-compliance SHA: 47c8c377cf29 2021-10-23 15:12:35
>
> Compliance test for rzg2l_cru device /dev/video0:
>
> Driver Info:
>         Driver name      : rzg2l_cru
>         Card type        : RZG2L_CRU
>         Bus info         : platform:10830000.video
>         Driver version   : 5.16.0
>         Capabilities     : 0xa5200001
>                 Video Capture
>                 Read/Write
>                 Streaming
>                 Extended Pix Format
>                 Device Capabilities
>         Device Caps      : 0x25200001
>                 Video Capt[   32.432429] rzg2l-cru 10830000.video: =================  START STATUS  =================
> ure
>                 Read/Write
>                 Str[   32.442279] rzg2l-cru 10830000.video: ==================  END STATUS  ==================
> eaming
>                 Extended Pix Format
> Media Driver Info:
>         Driver name      : rzg2l_cru
>         Model            : renesas,rzg2l-cru
>         Serial           :
>         Bus info         : platform:10830000.video
>         Media version    : 5.16.0
>         Hardware revision: 0x00000000 (0)
>         Driver version   : 5.16.0
> Interface Info:
>         ID               : 0x03000011
>         Type             : V4L Video
> Entity Info:
>         ID               : 0x0000000f (15)
>         Name             : CRU output
>         Function         : V4L2 I/O
>         Pad 0x01000010   : 0: Sink
>           Link 0x02000013: from remote pad 0x1000003 of entity 'rzg2l_cru 10830000.video' (Video Pixel Formatter): Data, Enabled
>           Link 0x02000015: from remote pad 0x1000004 of entity 'rzg2l_cru 10830000.video' (Video Pixel Formatter): Data
>           Link 0x02000017: from remote pad 0x1000005 of entity 'rzg2l_cru 10830000.video' (Video Pixel Formatter): Data
>           Link 0x02000019: from remote pad 0x1000006 of entity 'rzg2l_cru 10830000.video' (Video Pixel Formatter): Data
>
> Required ioctls:
>         test MC information (see 'Media Driver Info' above): OK
>         test VIDIOC_QUERYCAP: OK
>         test invalid ioctls: OK
>
> Allow for multiple opens:
>         test second /dev/video0 open: OK
>         test VIDIOC_QUERYCAP: OK
>         test VIDIOC_G/S_PRIORITY: OK
>         test for unlimited opens: OK
>
> Debug ioctls:
>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>         test VIDIOC_LOG_STATUS: OK
>
> Input ioctls:
>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>         test VIDIOC_G/S/ENUMINPUT: OK
>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>         Inputs: 1 Audio Inputs: 0 Tuners: 0
>
> Output ioctls:
>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>         Outputs: 0 Audio Outputs: 0 Modulators: 0
>
> Input/Output configuration ioctls:
>         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>         test VIDIOC_G/S_EDID: OK (Not Supported)
>
> Control ioctls (Input 0):
>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
>         test VIDIOC_QUERYCTRL: OK (Not Supported)
>         test VIDIOC_G/S_CTRL: OK (Not Supported)
>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>         Standard Controls: 0 Private Controls: 0
>
> Format ioctls (Input 0):
>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>         test VIDIOC_G/S_PARM: OK (Not Supported)
>         test VIDIOC_G_FBUF: OK (Not Supported)
>         test VIDIOC_G_FMT: OK
>         test VIDIOC_TRY_FMT: OK
>         test VIDIOC_S_FMT: OK
>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>         test Cropping: OK (Not Supported)
>         test Composing: OK (Not Supported)
>         test Scaling: OK
>
> Codec ioctls (Input 0):
>         test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>         test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
>
> Buffer ioctls (Input 0):
>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>         test VIDIOC_EXPBUF: OK
>         test Requests: OK (Not Supported)
>
> Test input 0:
>
> Streaming ioctls:
>         test read/write: OK
>         test blocking wait: OK
>         test MMAP (no poll): OK
>         test MMAP (select): OK
>         test MMAP (epoll): OK
>         test USERPTR (no poll): OK (Not Supported)
>         test USERPTR (select): OK (Not Supported)
>         test DMABUF: Cannot test, specify --expbuf-device
>
> Total for rzg2l_cru device /dev/video0: 53, Succeeded: 53, Failed: 0, Warnings: 0
> root@smarc-rzg2l:~#
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (3):
>   media: dt-bindings: media: Document RZ/G2L CRU block
>   media: platform: Add CRU driver for RZ/G2L SoC
>   arm64: dts: renesas: r9a07g044: Add CRU node
>
>  .../bindings/media/renesas,rzg2l-cru.yaml     | 227 ++++++
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  59 ++
>  drivers/media/platform/Kconfig                |   1 +
>  drivers/media/platform/Makefile               |   2 +
>  drivers/media/platform/rzg2l-cru/Kconfig      |  15 +
>  drivers/media/platform/rzg2l-cru/Makefile     |   4 +
>  drivers/media/platform/rzg2l-cru/rzg2l-core.c | 473 ++++++++++++
>  drivers/media/platform/rzg2l-cru/rzg2l-cru.h  | 244 ++++++
>  drivers/media/platform/rzg2l-cru/rzg2l-csi2.c | 625 ++++++++++++++++
>  drivers/media/platform/rzg2l-cru/rzg2l-dma.c  | 703 ++++++++++++++++++
>  drivers/media/platform/rzg2l-cru/rzg2l-v4l2.c | 361 +++++++++
>  11 files changed, 2714 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
>  create mode 100644 drivers/media/platform/rzg2l-cru/Kconfig
>  create mode 100644 drivers/media/platform/rzg2l-cru/Makefile
>  create mode 100644 drivers/media/platform/rzg2l-cru/rzg2l-core.c
>  create mode 100644 drivers/media/platform/rzg2l-cru/rzg2l-cru.h
>  create mode 100644 drivers/media/platform/rzg2l-cru/rzg2l-csi2.c
>  create mode 100644 drivers/media/platform/rzg2l-cru/rzg2l-dma.c
>  create mode 100644 drivers/media/platform/rzg2l-cru/rzg2l-v4l2.c
>
Gentle ping.

Cheers,
Prabhakar
