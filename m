Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB2D49507D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348039AbiATOoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355000AbiATOob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:44:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B44DC061574;
        Thu, 20 Jan 2022 06:44:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B014A617D1;
        Thu, 20 Jan 2022 14:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDE9C340E0;
        Thu, 20 Jan 2022 14:44:27 +0000 (UTC)
Message-ID: <d0540f65-ccc8-cfc8-d5c6-8dc40603b18d@xs4all.nl>
Date:   Thu, 20 Jan 2022 15:44:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v14 00/13] amphion video decoder/encoder driver
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1638865027.git.ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <cover.1638865027.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

Running 'scripts/checkpatch.pl --strict' over the patches gives me lots
of issues, most of them easily fixed.

As always with checkpatch, use common sense since not everything can be
fixed.

You probably ran checkpatch.pl without the --strict option, but in the media
subsystem we use that option.

Note that sparse and smatch are happy, so it is just the checkpatch issues
that need to be improved.

On 12/7/21 09:24, Ming Qian wrote:
> Hi all,
> 
> This patch series adds support for
> the amphion video encoder and decoder
> via the VPU block present in imx8q platforms.
> Currently, support for IMX8QXP and IMX8QM is included.
> 
> It features decoding for the following formats:
> - H.264
> - HEVC
> - MPEG4
> - MPEG2
> - VC1
> - VP8
> 
> It features encoding for the following formats:
> - H.264
> 
> The driver creates a separate device node for the encoder and decoder.
> 
> This driver is dependent on vpu firmwares.
> The firmwares have been submitted to linux-firmware.
> The firmware patch is since commit
> b563148fd28623f6b6ce68bb06c3dd3bd138b058:
> linux-firmware: Update firmware file for Intel Bluetooth 9462
> (Fri Oct 8 16:30:14 2021 +0530)
> 
> and it's available in the git repository at:
>     https://github.com/mingqian-0/linux-firmware.git
> 
> for you to fetch changes up to bb3eee4f99589d4910dee4c053a3a685546b5dbb:
> amphion: add VPU firmwares for NXP i.MX8Q SoCs
> (Tue Oct 12 15:09:57 2021 +0800)
> 
> encoder is tested with gstreamer
> decoder is tested with gstreamer, but the following patches are required:
> https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1379
> https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1381
> 
> 
> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

For v15 please add this tag from Nicolas to the patch(es) that it applies to.
Tags in the cover letter are ignored.

Regarding patch 12/13 (firmware patch): who will take that? I think it should
go through Shawn Guo, or if he can Ack it, then I can take it with the rest of
the series as well.

Regards,

	Hans

> 
> 
> Changelog:
> 
> v14
> - fix some errors according to Hans's comments
> 
> v13
> - make a workaround that avoid firmware entering wfi wrongly
> 
> v12
> - support reset decoder when starting a new stream
> - don't append an empty last buffer, set last_buffer_dequeued
> - improve the resolution change flow
> - return all buffers if start_streaming fail
> - fill encoder capture buffer's filed to none
> - fix a bug in calculating bytesperline
> 
> v11
> - fix dt_binding_check error after upgrade dtschema
> - remove "default y"
> - add media device
> 
> v10
> - refine vpu log, remove custom logging infrastructure
> - support non contiguous planes format nv12m instead of nv12
> - rename V4L2_PIX_FMT_NV12_8L128 to V4L2_PIX_FMT_NV12MT_8L128
> - rename V4L2_PIX_FMT_NV12_10BE_8L128 to V4L2_PIX_FMT_NV12MT_10BE_8L128
> - merge two module into one
> - fix kernel panic in rmmod
> 
> v9
> - drop V4L2_BUF_FLAG_CODECCONFIG
> - drop V4L2_EVENT_CODEC_ERROR
> - drop V4L2_EVENT_SKIP - use the v4l2_buffer.sequence counter
> - fix some build warnings with W=1 reported by kernel test robot
> 
> v8
> - move driver from driver/media/platform/imx/vpu-8q to
>   driver/media/platform/amphion
> - rename driver name to amphion
> - remove imx_vpu.h
> - move the definition of V4L2_EVENT_CODEC_ERROR to videodev2.h
> - move the definition of V4L2_EVENT_SKIP to videodev2.h
> 
> v7
> - fix build warnings with W=1 reported by kernel test robot
> 
> v6:
> - rename V4L2_PIX_FMT_NT8 to V4L2_PIX_FMT_NV12_8L128
> - rename V4L2_PIX_FMT_NT10 to V4L2_PIX_FMT_NV12_10BE_8L128
> 
> v5:
> - move some definition from imx_vph.h to videodev2.h
> - remove some unnecessary content
> - add some documentation descriptions
> - pass the lateset v4l2-compliance test
> 
> v4:
> - redefine the memory-region in devicetree bindings documentation
> - use v4l2's mechanism to implement synchronize queuing ioctl
> - remove the unnecessary mutex ioctl_sync
> - don't notify source change event if the parameters are same as previously established
> - add flag V4L2_FMT_FLAG_DYN_RESOLUTION to decoder's capture format
> 
> v3:
> - don't make vpu device node a simple-bus
> - trigger probing vpu core in the driver
> - remove unnecessary vpu core index property
> 
> v2:
> - fix dt bindings build error
> - split driver patch into several parts to avoid exceeding bytes limit
> 
> Compliance
> ==========
> # v4l2-compliance -d /dev/video0
> v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t
> v4l2-compliance SHA: 493af03f3c57 2021-10-08 17:23:11
> 
> Compliance test for amphion-vpu device /dev/video0:
> 
> Driver Info:
> 	Driver name      : amphion-vpu
> 	Card type        : amphion vpu decoder
> 	Bus info         : platform: amphion-vpu
> 	Driver version   : 5.15.0
> 	Capabilities     : 0x84204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x04204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 	Detected Stateful Decoder
> Media Driver Info:
> 	Driver name      : amphion-vpu
> 	Model            : amphion-vpu
> 	Serial           :
> 	Bus info         : platform: amphion-vpu
> 	Media version    : 5.15.0
> 	Hardware revision: 0x00000000 (0)
> 	Driver version   : 5.15.0
> Interface Info:
> 	ID               : 0x0300000c
> 	Type             : V4L Video
> Entity Info:
> 	ID               : 0x00000001 (1)
> 	Name             : amphion-vpu-decoder-source
> 	Function         : V4L2 I/O
> 	Pad 0x01000002   : 0: Source
> 	  Link 0x02000008: to remote pad 0x1000004 of entity 'amphion-vpu-decoder-proc' (Video Decoder): Data, Enabled, Immutable
> 
> Required ioctls:
> 	test MC information (see 'Media Driver Info' above): OK
> 	test VIDIOC_QUERYCAP: OK
> 	test invalid ioctls: OK
> 
> Allow for multiple opens:
> 	test second /dev/video0 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 	test VIDIOC_QUERYCTRL: OK
> 	test VIDIOC_G/S_CTRL: OK
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 3 Private Controls: 0
> 
> Format ioctls:
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK (Not Supported)
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 	test VIDIOC_S_FMT: OK
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK (Not Supported)
> 	test Composing: OK
> 	test Scaling: OK (Not Supported)
> 
> Codec ioctls:
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK
> 
> Buffer ioctls:
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 	test VIDIOC_EXPBUF: OK
> 	test Requests: OK (Not Supported)
> 
> Total for amphion-vpu device /dev/video0: 46, Succeeded: 46, Failed: 0, Warnings: 0
> 
> # v4l2-compliance -d /dev/video1
> v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t
> v4l2-compliance SHA: 493af03f3c57 2021-10-08 17:23:11
> 
> Compliance test for amphion-vpu device /dev/video1:
> 
> Driver Info:
> 	Driver name      : amphion-vpu
> 	Card type        : amphion vpu encoder
> 	Bus info         : platform: amphion-vpu
> 	Driver version   : 5.15.0
> 	Capabilities     : 0x84204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x04204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 	Detected Stateful Encoder
> Media Driver Info:
> 	Driver name      : amphion-vpu
> 	Model            : amphion-vpu
> 	Serial           :
> 	Bus info         : platform: amphion-vpu
> 	Media version    : 5.15.0
> 	Hardware revision: 0x00000000 (0)
> 	Driver version   : 5.15.0
> Interface Info:
> 	ID               : 0x0300001a
> 	Type             : V4L Video
> Entity Info:
> 	ID               : 0x0000000f (15)
> 	Name             : amphion-vpu-encoder-source
> 	Function         : V4L2 I/O
> 	Pad 0x01000010   : 0: Source
> 	  Link 0x02000016: to remote pad 0x1000012 of entity 'amphion-vpu-encoder-proc' (Video Encoder): Data, Enabled, Immutable
> 
> Required ioctls:
> 	test MC information (see 'Media Driver Info' above): OK
> 	test VIDIOC_QUERYCAP: OK
> 	test invalid ioctls: OK
> 
> Allow for multiple opens:
> 	test second /dev/video1 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 	test VIDIOC_QUERYCTRL: OK
> 	test VIDIOC_G/S_CTRL: OK
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 20 Private Controls: 0
> 
> Format ioctls:
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 	test VIDIOC_S_FMT: OK
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK
> 	test Composing: OK (Not Supported)
> 	test Scaling: OK (Not Supported)
> 
> Codec ioctls:
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls:
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 	test VIDIOC_EXPBUF: OK
> 	test Requests: OK (Not Supported)
> 
> Total for amphion-vpu device /dev/video1: 46, Succeeded: 46, Failed: 0, Warnings: 0
> 
> # v4l2-compliance -d /dev/media0
> v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t
> v4l2-compliance SHA: 493af03f3c57 2021-10-08 17:23:11
> 
> Compliance test for amphion-vpu device /dev/media0:
> 
> Media Driver Info:
> 	Driver name      : amphion-vpu
> 	Model            : amphion-vpu
> 	Serial           :
> 	Bus info         : platform: amphion-vpu
> 	Media version    : 5.15.0
> 	Hardware revision: 0x00000000 (0)
> 	Driver version   : 5.15.0
> 
> Required ioctls:
> 	test MEDIA_IOC_DEVICE_INFO: OK
> 	test invalid ioctls: OK
> 
> Allow for multiple opens:
> 	test second /dev/media0 open: OK
> 	test MEDIA_IOC_DEVICE_INFO: OK
> 	test for unlimited opens: OK
> 
> Media Controller ioctls:
> 	test MEDIA_IOC_G_TOPOLOGY: OK
> 	Entities: 6 Interfaces: 2 Pads: 8 Links: 8
> 	test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
> 	test MEDIA_IOC_SETUP_LINK: OK
> 
> Total for amphion-vpu device /dev/media0: 8, Succeeded: 8, Failed: 0, Warnings: 0
> 
> Ming Qian (13):
>   dt-bindings: media: amphion: add amphion video codec bindings
>   media: add nv12m_8l128 and nv12m_10be_8l128 video format.
>   media: amphion: add amphion vpu device driver
>   media: amphion: add vpu core driver
>   media: amphion: implement vpu core communication based on mailbox
>   media: amphion: add vpu v4l2 m2m support
>   media: amphion: add v4l2 m2m vpu encoder stateful driver
>   media: amphion: add v4l2 m2m vpu decoder stateful driver
>   media: amphion: implement windsor encoder rpc interface
>   media: amphion: implement malone decoder rpc interface
>   ARM64: dts: freescale: imx8q: add imx vpu codec entries
>   firmware: imx: scu-pd: imx8q: add vpu mu resources
>   MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
> 
>  .../bindings/media/amphion,vpu.yaml           |  180 ++
>  .../media/v4l/pixfmt-yuv-planar.rst           |   28 +-
>  MAINTAINERS                                   |    9 +
>  .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi |   72 +
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   17 +
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   24 +
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/firmware/imx/scu-pd.c                 |    4 +
>  drivers/media/platform/Kconfig                |   19 +
>  drivers/media/platform/Makefile               |    2 +
>  drivers/media/platform/amphion/Makefile       |   20 +
>  drivers/media/platform/amphion/vdec.c         | 1692 +++++++++++++++++
>  drivers/media/platform/amphion/venc.c         | 1354 +++++++++++++
>  drivers/media/platform/amphion/vpu.h          |  356 ++++
>  drivers/media/platform/amphion/vpu_cmds.c     |  437 +++++
>  drivers/media/platform/amphion/vpu_cmds.h     |   25 +
>  drivers/media/platform/amphion/vpu_codec.h    |   67 +
>  drivers/media/platform/amphion/vpu_color.c    |  186 ++
>  drivers/media/platform/amphion/vpu_core.c     |  872 +++++++++
>  drivers/media/platform/amphion/vpu_core.h     |   15 +
>  drivers/media/platform/amphion/vpu_dbg.c      |  497 +++++
>  drivers/media/platform/amphion/vpu_defs.h     |  186 ++
>  drivers/media/platform/amphion/vpu_drv.c      |  260 +++
>  drivers/media/platform/amphion/vpu_helpers.c  |  416 ++++
>  drivers/media/platform/amphion/vpu_helpers.h  |   70 +
>  drivers/media/platform/amphion/vpu_imx8q.c    |  271 +++
>  drivers/media/platform/amphion/vpu_imx8q.h    |  116 ++
>  drivers/media/platform/amphion/vpu_malone.c   | 1630 ++++++++++++++++
>  drivers/media/platform/amphion/vpu_malone.h   |   42 +
>  drivers/media/platform/amphion/vpu_mbox.c     |  118 ++
>  drivers/media/platform/amphion/vpu_mbox.h     |   16 +
>  drivers/media/platform/amphion/vpu_msgs.c     |  388 ++++
>  drivers/media/platform/amphion/vpu_msgs.h     |   14 +
>  drivers/media/platform/amphion/vpu_rpc.c      |  265 +++
>  drivers/media/platform/amphion/vpu_rpc.h      |  453 +++++
>  drivers/media/platform/amphion/vpu_v4l2.c     |  733 +++++++
>  drivers/media/platform/amphion/vpu_v4l2.h     |   56 +
>  drivers/media/platform/amphion/vpu_windsor.c  | 1207 ++++++++++++
>  drivers/media/platform/amphion/vpu_windsor.h  |   39 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |    2 +
>  include/uapi/linux/videodev2.h                |    2 +
>  41 files changed, 12158 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/amphion,vpu.yaml
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
>  create mode 100644 drivers/media/platform/amphion/Makefile
>  create mode 100644 drivers/media/platform/amphion/vdec.c
>  create mode 100644 drivers/media/platform/amphion/venc.c
>  create mode 100644 drivers/media/platform/amphion/vpu.h
>  create mode 100644 drivers/media/platform/amphion/vpu_cmds.c
>  create mode 100644 drivers/media/platform/amphion/vpu_cmds.h
>  create mode 100644 drivers/media/platform/amphion/vpu_codec.h
>  create mode 100644 drivers/media/platform/amphion/vpu_color.c
>  create mode 100644 drivers/media/platform/amphion/vpu_core.c
>  create mode 100644 drivers/media/platform/amphion/vpu_core.h
>  create mode 100644 drivers/media/platform/amphion/vpu_dbg.c
>  create mode 100644 drivers/media/platform/amphion/vpu_defs.h
>  create mode 100644 drivers/media/platform/amphion/vpu_drv.c
>  create mode 100644 drivers/media/platform/amphion/vpu_helpers.c
>  create mode 100644 drivers/media/platform/amphion/vpu_helpers.h
>  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.c
>  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.h
>  create mode 100644 drivers/media/platform/amphion/vpu_malone.c
>  create mode 100644 drivers/media/platform/amphion/vpu_malone.h
>  create mode 100644 drivers/media/platform/amphion/vpu_mbox.c
>  create mode 100644 drivers/media/platform/amphion/vpu_mbox.h
>  create mode 100644 drivers/media/platform/amphion/vpu_msgs.c
>  create mode 100644 drivers/media/platform/amphion/vpu_msgs.h
>  create mode 100644 drivers/media/platform/amphion/vpu_rpc.c
>  create mode 100644 drivers/media/platform/amphion/vpu_rpc.h
>  create mode 100644 drivers/media/platform/amphion/vpu_v4l2.c
>  create mode 100644 drivers/media/platform/amphion/vpu_v4l2.h
>  create mode 100644 drivers/media/platform/amphion/vpu_windsor.c
>  create mode 100644 drivers/media/platform/amphion/vpu_windsor.h
> 
> 
> base-commit: 1f1517fafda598839a02e39968c5063ddcfa51fc
