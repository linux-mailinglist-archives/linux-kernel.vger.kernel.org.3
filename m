Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FC74E3B86
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiCVJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiCVJPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:15:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688BE27FD7;
        Tue, 22 Mar 2022 02:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49E47B81C59;
        Tue, 22 Mar 2022 09:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2EDC340EC;
        Tue, 22 Mar 2022 09:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647940460;
        bh=XLKMdRAIX0nYrl2p4w81ykVRbgprFa+E9oJol4peM2I=;
        h=Date:From:To:Cc:Subject:From;
        b=hxH776HuOQEdSpzo6qo498IBhadFgRe6+3rygOKRnxjjt9C1KHWZ9QDCuI77wfade
         NEdivYoo99R65nG5nn4gPJnc3NqAVQ3out6LbWfIY4mY5OVsIKq6Nq13EZ8W0eHJ+l
         2b+5ZUQTSnM7KoWBTRlwy6xsC6esPGn5appclfnC3S0hHhAt3xIaPDfcLmnevgu36V
         CAlzOPJLUwgcHmxtUoq/fySnOnn9oX2TmtZYYeqQ17HiXmJ5UlsquaNPcDKbTUowCx
         0yxXrWsawi9ZAm1zAhkeHSQxXpBducvdIXGobh5U8cH6BntSV/MKP94hgknyjP5r5A
         7KLprvp1CsSyg==
Date:   Tue, 22 Mar 2022 10:14:06 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v5.18-rc1] media updates
Message-ID: <20220322101406.459e2950@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v5.18-1

For:

  - a major reorg at platform Kconfig/Makefile files, organizing them per
    vendor. The other media Kconfig/Makefile files also sorted;
  - New sensor drivers: hi847, isl7998x, ov08d10;
  - New Amphion vpu decoder stateful driver;
  - New Atmel microchip csi2dc driver;
  - tegra-vde driver promoted from staging;
  - atomisp: some fixes for it to work on BYT;
  - imx7-mipi-csis driver promoted from staging and renamed;
  - camss driver got initial support for VFE hardware version Titan 480;
  - mtk-vcodec has gained support for MT8192;
  - lots of driver changes, fixes and improvements.

PS.: Please notice that the diff changes and stat is huge mostly due to
the build system file shift.

Regards,
Mauro

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v5.18-1

for you to fetch changes up to ba2c670ae84bad705ec023bfa7a48f7f8eab5e16:

  media: nxp: Restrict VIDEO_IMX_MIPI_CSIS to ARCH_MXC or COMPILE_TEST (202=
2-03-21 15:21:28 +0100)

----------------------------------------------------------------
media updates for v5.18-rc1

----------------------------------------------------------------
Adam Ford (4):
      media: dt-bindings: media: nxp, imx8mq-vpu: Split G1 and G2 nodes
      media: hantro: Allow i.MX8MQ G1 and G2 to run independently
      media: dt-bindings: media: nxp, imx8mq-vpu: Add support for G1 on imx=
8mm
      media: hantro: Add support for i.MX8MM Hantro-G1

Alain Volmat (1):
      media: stm32: dcmi: create a dma scatterlist based on DMA max_sg_burs=
t value

Alexander Stein (1):
      media: staging: media: imx: imx7_mipi_csis: Store colorspace in set_f=
mt as well

Ameer Hamza (1):
      media: venus: vdec: fixed possible memory leak issue

Angus Ainslie (1):
      media: i2c: dw9714: add optional regulator support

Benjamin Gaignard (4):
      media: hevc: Remove RPS named flags
      media: hevc: Embedded indexes in RPS
      media: MAINTAINERS: Update Benjamin Gaignard maintainer status
      media: platform: mtk-vcodec: Do not force /dev/videoX node number

Benjamin Mugnier (1):
      media: MAINTAINERS: Change maintainers for mipid02 driver

Bingbu Cao (2):
      media: ov2740: identify module after subdev initialisation
      media: ov5675: use group write to update digital gain

Bryan O'Donoghue (9):
      media: camss: Add SM8250 bandwdith configuration support
      media: camss: Do vfe_get/vfe_put for csid on sm8250
      media: camss: Apply vfe_get/vfe_put fix to SDM845
      media: dt-bindings: media: camss: Fixup vdda regulator descriptions s=
dm845
      media: dt-bindings: media: camss: Add vdda supply declarations sm8250
      media: camss: Add regulator_bulk support
      media: camss: Set unused regulators to the empty set
      media: camss: Point sdm845 at the correct vdda regulators
      media: camss: Point sm8250 at the correct vdda regulators

Chen-Yu Tsai (9):
      media: docs: vidioc-dqbuf: State all remaining fields are filled by d=
river
      media: v4l2-mem2mem: Apply DST_QUEUE_OFF_BASE on MMAP buffers across =
ioctls
      media: hantro: Fix overfill bottom register field name
      media: hantro: Support cropping visible area for encoders
      media: hantro: jpeg: Add JFIF APP0 segment to JPEG encoder output
      media: hantro: jpeg: Add COM segment to JPEG header to align image sc=
an
      media: hantro: Implement V4L2_CID_JPEG_ACTIVE_MARKER control
      media: hantro: output encoded JPEG content directly to capture buffers
      media: hantro: jpeg: Remove open-coded size in quantization table code

Christian Hewitt (1):
      drivers: meson: vdec: add VP9 support to GXM

Christophe JAILLET (2):
      media: v4l2-dev: Use non-atomic bitmap API when applicable
      media: Remove usage of the deprecated "pci-dma-compat.h" API

Colin Ian King (12):
      media: gspca: make array regs_to_read static const
      media: media/radio: make array probe_ports static const
      media: v4l2-ctrls: make array range static
      media: atomisp: make array idx_map static const
      media: saa7115: make static read-only array lcr2vbi const
      media: gspca: remove redundant assignment of variable n
      media: mtk-jpeg: remove redundant initialization of variable plane_fmt
      media: saa7134: remove redundant assignment to variable id
      media: saa7164: remove redundant assignment to variable idx
      media: dvb_frontend: make static read-only array DIB3000MC_I2C_ADDRES=
S const
      media: dib7000p: make static read-only arrays notch and sine const
      media: dvb_frontends: make static read-only array fec_tab const

Corentin Labbe (14):
      media: staging: media: zoran: move module parameter checks to zoran_p=
robe
      media: staging: media: zoran: use module_pci_driver
      media: staging: media: zoran: rename debug module parameter
      media: staging: media: zoran: add debugfs
      media: staging: media: zoran: videocode: remove procfs
      media: staging: media: zoran: merge all modules
      media: staging: media: zoran: remove vidmem
      media: staging: media: zoran: move videodev alloc
      media: staging: media: zoran: move config select on primary kconfig
      media: staging: media: zoran: introduce zoran_i2c_init
      media: staging: media: zoran: fix usage of vb2_dma_contig_set_max_seg=
_size
      media: staging: media: zoran: clean unused code
      media: staging: media: zoran: fix counting buffer in reserve
      media: staging: media: zoran: calculate the right buffer number for z=
oran_reap_stat_com

Dafna Hirschfeld (6):
      media: rkisp1: fix grey format iommu page faults
      media: stk1160: fix number of buffers in case not all buffers are cre=
ated
      media: stk1160: If start stream fails, return buffers with VB2_BUF_ST=
ATE_QUEUED
      media: stk1160: move transfer_buffer and urb to same struct 'stk1160_=
urb'
      media: stk1160: use dma_alloc_noncontiguous API
      media: MAINTAINERS: update rksip1 maintainers info

Dan Carpenter (2):
      media: i2c: ov08d10: Unlock on error in ov08d10_enum_frame_size()
      media: usb: go7007: s2250-board: fix leak in probe()

Daniel Gonz=C3=A1lez Cabanelas (1):
      media: cx88-mpeg: clear interrupt status register before streaming vi=
deo

Daniel Lundberg Pedersen (1):
      media: docs: v4l2grab.c.rst: change unintended assignment

Daniel Scally (1):
      media: i2c: Fix pixel array positions in ov8865

Deborah Brouwer (1):
      media: vivid: fix timestamp and sequence wrapping

Dmitry Osipenko (6):
      media: v4l2-ctrls: Add new V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags
      media: staging: tegra-vde: Factor out H.264 code
      media: staging: tegra-vde: Support V4L stateless video decoder API
      media: staging: tegra-vde: Remove legacy UAPI support
      media: staging: tegra-vde: Bump BSEV DMA timeout
      media: staging: tegra-vde: De-stage driver

Dongliang Mu (2):
      media: em28xx: initialize refcount before kref_get
      media: hdpvr: initialize dev->worker at hdpvr_register_videodev

Ettore Chimenti (1):
      media: cec: seco: add newlines in debug messages

Eugen Hristev (13):
      media: MAINTAINERS: add microchip csi2dc
      media: dt-bindings: media: atmel: csi2dc: add bindings for microchip =
csi2dc
      media: atmel: introduce microchip csi2dc driver
      media: atmel: atmel-isc: split the clock code into separate source fi=
le
      media: atmel: atmel-isc: replace video device name with module name
      media: atmel: atmel-sama7g5-isc: fix ispck leftover
      media: atmel: atmel-isc-base: remove frameintervals VIDIOC
      media: atmel: atmel-isc-base: report frame sizes as full supported ra=
nge
      media: atmel: atmel-isc-base: fix bytesperline value for planar forma=
ts
      media: atmel: atmel-isc-base: add wb debug messages
      media: atmel: atmel-isc-base: clamp wb gain coefficients
      media: atmel: atmel-sama7g5-isc: fix UYVY input format mbus_code typo
      media: atmel: atmel-isc: add raw Bayer 8bit 10bit output formats

Geert Uytterhoeven (1):
      media: rcar-csi2: Drop comma after SoC match table sentinel

Gustavo A. R. Silva (1):
      media: usb: pwc-uncompress: Use struct_size() helper in pwc_decompres=
s()

Hans Verkuil (8):
      media: staging: media: zoran: fix various V4L2 compliance errors
      media: staging: media: zoran: fix TRY_FMT handling
      media: staging: media: zoran: drop kernel log spam
      media: staging: media: zoran: drop read/write support
      pixfmt-yuv-planar.rst: fix typo: 'Cr, Cr' -> 'Cr, Cb'
      ivtv: fix incorrect device_caps for ivtvfb
      media: pixfmt-yuv-planar.rst: fix PIX_FMT labels
      media: m5mols/m5mols.h: document new reset field

Hans de Goede (10):
      media: atomisp: Don't use ifdef on IS_ISP2401
      media: atomisp: Don't use ifdef ISP2400
      media: atomisp: Use irci_stable_candrpv_0415_20150423_1753 fw for byt
      media: atomisp_gmin_platform: Fix axp_regulator_set() writing to the =
wrong register
      media: atomisp_gmin_platform: Add enable-count to gmin_[v1p8|v2p8]_ct=
rl()
      media: atomisp_gmin_platform: Set ELDO1 to 1.6V on devices with an AX=
P288 PMIC
      media: atomisp_gmin_platform: Do not turn ELDO2 off from axp_v1p8_on()
      media: atomisp_gmin_platform: Base CsiPort default on detected CLK
      media: atomisp_gmin_platform: Add DMI quirk to not turn AXP ELDO2 reg=
ulator off on some boards
      media: i2c: ov5648: Fix lockdep error

Hsin-Yi Wang (2):
      media: dt-bindings: mediatek: convert mtk jpeg decoder/encoder to yaml
      media: dt-bindings: mediatek: Add mediatek, mt8183-jpgenc compatible

Jacopo Mondi (12):
      media: dt-bindings: media: max9286: Re-indent example
      media: dt-bindings: media: max9286: Define 'maxim,gpio-poc'
      media: i2c: max9286: Use "maxim,gpio-poc" property
      media: imx: De-stage imx7-mipi-csis
      media: imx: Rename imx7-mipi-csis.c to imx-mipi-csis.c
      media: imx: imx7-media-csi: Use dual sampling for YUV 1X16
      media: imx: imx-mipi-csis: Set PIXEL_MODE for YUV422
      media: imx: imx-mipi-csis: Add RGB565_1X16
      media: imx: imx-mipi-csis: Add BGR888
      media: imx: imx-mipi-csis: Add output format
      media: imx: imx8mq-mipi-csi2: Remove YUV422 2X8
      media: imx: csis: Store pads format separately

Jakob Koschel (1):
      media: saa7134: fix incorrect use to determine if list is empty

Jammy Huang (11):
      media: aspeed: use v4l2_info/v4l2_warn/v4l2_dbg for log
      media: aspeed: add more debug log messages
      media: aspeed: Fix no complete irq for non-64-aligned width
      media: aspeed: Correct value for h-total-pixels
      media: aspeed: Use FIELD_GET to improve readability
      media: aspeed: Correct values for detected timing
      media: aspeed: add comments and macro
      media: aspeed: Add macro for the fields of the mode-detect registers
      media: aspeed: Fix unstable timing detection
      media: aspeed: Use full swing as JFIF to fix incorrect color
      media: aspeed: Use of_device_get_match_data() helper

Janusz Krzysztofik (4):
      media: ov6650: Fix set format try processing path
      media: ov6650: Add try support to selection API operations
      media: ov6650: Fix crop rectangle affected by set format
      media: ov6650: Fix missing frame interval enumeration support

Jean-Michel Hautbois (1):
      media: doc: pixfmt-yuv: Fix V4L2-PIX-FMT-Y10P format

Jernej Skrabec (4):
      media: cedrus: Add watchdog for job completion
      media: cedrus: H265: Fix neighbour info buffer size
      media: cedrus: h264: Fix neighbour info buffer size
      media: hantro: sunxi: Fix VP9 steps

Jiasheng Jiang (3):
      media: mtk-vcodec: potential dereference of null pointer
      media: meson: vdec: potential dereference of null pointer
      media: vidtv: Check for null return of vzalloc

Jimmy Su (1):
      media: i2c: Add ov08d10 camera sensor driver

Johan Hovold (4):
      media: davinci: vpif: fix unbalanced runtime PM get
      media: davinci: vpif: fix unbalanced runtime PM enable
      media: davinci: vpif: fix use-after-free on driver unbind
      media: davinci: vpif: drop probe printk

Jonathan Marek (16):
      media: dt-bindings: media: camss: Add qcom,sm8250-camss binding
      media: camss: csiphy-3ph: don't print HW version as an error
      media: camss: csiphy-3ph: disable interrupts
      media: camss: csiphy-3ph: add support for SM8250 CSI DPHY
      media: camss: csid-170: fix non-10bit formats
      media: camss: csid-170: don't enable unused irqs
      media: camss: csid-170: remove stray comment
      media: camss: csid-170: support more than one lite vfe
      media: camss: csid-170: set the right HALT_CMD when disabled
      media: camss: csid: allow csid to work without a regulator
      media: camss: remove vdda-csiN from sdm845 resources
      media: camss: fix VFE irq name
      media: camss: vfe-170: fix "VFE halt timeout" error
      media: camss: Add initial support for VFE hardware version Titan 480
      media: camss: add support for V4L2_PIX_FMT_GREY for sdm845 HW
      media: camss: add support for SM8250 camss

Julia Lawall (2):
      media: cx18: use GFP_KERNEL
      media: fsl-viu: use GFP_KERNEL

Kees Cook (1):
      media: omap3isp: Use struct_group() for memcpy() region

Lad Prabhakar (13):
      media: vsp1: Use platform_get_irq() to get the interrupt
      media: camss: Use platform_get_irq_byname() to get the interrupt
      media: bdisp: Use platform_get_irq() to get the interrupt
      media: s5p-mfc: Use platform_get_irq() to get the interrupt
      media: stm32-dma2d: Use platform_get_irq() to get the interrupt
      media: exynos-gsc: Use platform_get_irq() to get the interrupt
      media: marvell-ccic: Use platform_get_irq() to get the interrupt
      media: exynos4-is: Use platform_get_irq() to get the interrupt
      media: s5p-g2d: Use platform_get_irq() to get the interrupt
      media: mtk-vpu: Drop unnecessary call to platform_get_resource()
      media: coda: Use platform_get_irq() to get the interrupt
      media: davinci: vpif: Use platform_get_irq_optional() to get the inte=
rrupt
      media: dt-bindings: media: renesas,csi2: Update data-lanes property

Laurent Pinchart (22):
      media: staging: media: imx: imx7-mipi-csis: Dump MIPI_CSIS_FRAME_COUN=
TER_CH0 register
      media: staging: media: imx: imx7_mipi_csis: Add timings override thro=
ugh debugfs
      media: staging: media: imx: imx7-mipi-csis: Make subdev name unique
      media: pxa_camera: Drop usage of .set_mbus_config()
      media: i2c: ov6650: Drop implementation of .set_mbus_config()
      media: v4l2-subdev: Drop .set_mbus_config() operation
      media: v4l2-fwnode: Move bus config structure to v4l2_mediabus.h
      media: i2c: max9286: Implement media entity .link_validate() operation
      media: vimc: Add support for contiguous DMA buffers
      media: v4l2-mediabus: Use structures to describe bus configuration
      media: v4l2-mediabus: Drop legacy V4L2_MBUS_CSI2_*_LANE flags
      media: v4l2-mediabus: Drop legacy V4L2_MBUS_CSI2_CHANNEL_* flags
      media: v4l2-mediabus: Drop V4L2_MBUS_CSI2_CONTINUOUS_CLOCK flag
      media: Define MIPI CSI-2 data types in a shared header file
      media: rcar-isp: Use mipi-csi2.h
      media: rcar-csi2: Use mipi-csi2.h
      media: xilinx: csi2rxss: Use mipi-csi2.h
      media: media-entity: Add media_pad_is_streaming() helper function
      media: media-entity: Simplify media_pipeline_start()
      media: media-entity: Clarify media_entity_cleanup() usage
      media: doc: pixfmt-rgb: Fix V4L2_PIX_FMT_BGR24 format description
      media: nxp: Restrict VIDEO_IMX_MIPI_CSIS to ARCH_MXC or COMPILE_TEST

Linus Walleij (8):
      media: cec: seco: Drop pointless include
      media: i2c: ccs: Drop unused include
      media: i2c: imx274: Drop surplus includes
      media: adv7511: Drop unused include
      media: mt9m111: Drop unused include
      media: noon010p30: Convert to use GPIO descriptors
      media: m5mols: Convert to use GPIO descriptors
      media: adv7183: Convert to GPIO descriptors

Marek Vasut (2):
      media: dt-bindings: Add Intersil ISL79987 DT bindings
      media: i2c: isl7998x: Add driver for Intersil ISL7998x

Mark Brown (1):
      media: i2c: max2175: Use rbtree rather than flat register cache

Martin Kepplinger (6):
      media: imx: imx8mq-mipi-csi2: remove wrong irq config write operation
      media: imx: imx8mq-mipi_csi2: fix system resume
      media: imx: imx7-media-csi: add support for imx8mq
      media: dt-bindings: media: document imx8mq support for imx7-csi
      media: dt-binding: media: hynix,hi846: use $defs/port-base port descr=
iption
      media: dt-bindings: media: hynix,hi846: add link-frequencies descript=
ion

Mauro Carvalho Chehab (72):
      Merge tag 'br-v5.18l' of git://linuxtv.org/hverkuil/media_tree into m=
edia_stage
      Merge tag 'br-v5.18q' of git://linuxtv.org/hverkuil/media_tree into m=
edia_stage
      Merge tag 'for-5.18-2.6-signed' of git://linuxtv.org/sailus/media_tre=
e into media_stage
      Merge tag 'br-v5.18r' of git://linuxtv.org/hverkuil/media_tree into m=
edia_stage
      Merge tag 'br-v5.18s' of git://linuxtv.org/hverkuil/media_tree into m=
edia_stage
      media: xc2028: rename the driver from tuner-xc2028
      media: Makefiles: remove extra spaces
      media: Makefiles: sort entries where it fits
      media: platform: Makefile: reorganize its contents
      media: platform: move platform menu dependencies to drivers
      media: platform: place Aspeed driver on a separate dir
      media: platform: place NXP drivers on a separate dir
      media: platform: place Intel drivers on a separate dir
      media: platform: place Via drivers on a separate dir
      media: platform: place Renesas drivers on a separate dir
      media: platform: allegro-dvt: move config to its own file
      media: platform: amphion: move config to its own file
      media: platform: coda: move config to its own file
      media: platform: exynos-gsc: move config to its own file
      media: platform: ge2d: move config to its own file
      media: platform: mtk-jpeg: move config to its own file
      media: platform: mtk-mdp: move config to its own file
      media: platform: mtk-vcodec: move config to its own file
      media: platform: mtk-vpu: move config to its own file
      media: platform: omap3isp: move config to its own file
      media: platform: camss: move config to its own file
      media: platform: venus: move config to its own file
      media: platform: rga: move config to its own file
      media: platform: s3c-camif: move config to its own file
      media: platform: s5p-g2d: move config to its own file
      media: platform: hva: move config to its own file
      media: platform: stm32: move config to its own file
      media: platform: sun8i-di: move config to its own file
      media: platform: sun8i-rotate: move config to its own file
      media: platform: vde: move config to its own file
      media: platform: ti-vpe: move config to its own file
      media: platform: rkisp1: move config to its own file
      media: platform: delta: move config to its own file
      media: platform: bdisp: move config to its own file
      media: platform: s5p-mfc: move config to its own file
      media: platform: s5p-jpeg: move config to its own file
      media: platform: Kconfig: sort entries
      media: platform: move some manufacturer entries
      media: platform: Kconfig: place platform drivers on a submenu
      media: platform: rename coda/ to chips-media/
      media: platform: rename marvell-ccic/ to marvell/
      media: platform: rename meson/ge2d/ to amlogic/meson-ge2d/
      media: platform: rename mtk-jpeg/ to mediatek/mtk-jpeg/
      media: platform: rename mtk-mdp/ to mediatek/mtk-mdp/
      media: platform: rename mtk-vcodec/ to mediatek/mtk-vcodec/
      media: platform: rename mtk-vpu/ to mediatek/mtk-vpu/
      media: platform: rename tegra/vde/ to nvidia/tegra-vde/
      media: platform: rename exynos4-is/ to samsung/exynos4-is/
      media: platform: rename exynos-gsc/ to samsung/exynos-gsc/
      media: platform: rename s3c-camif/ to samsung/s3c-camif/
      media: platform: rename s5p-g2d/ to samsung/s5p-g2d/
      media: platform: rename s5p-jpeg/ to samsung/s5p-jpeg/
      media: platform: rename s5p-mfc/ to samsung/s5p-mfc/
      media: platform: place stm32/ and sti/ under st/ dir
      media: platform: rename am437x/ to ti/am437x/
      media: platform: rename davinci/ to ti/davinci/
      media: platform: rename omap3isp/ to ti/omap3isp/
      media: platform: rename omap/ to ti/omap/
      media: platform: ti/Kconfig: move VPE/CAL entries to it
      media: platform: Create vendor/{Makefile,Kconfig} files
      media: platform/*/Kconfig: make manufacturer menus more uniform
      media: Kconfig: cleanup VIDEO_DEV dependencies
      media: media/*/Kconfig: sort entries
      media: platform: rename mediatek/mtk-jpeg/ to mediatek/jpeg/
      media: atomisp: fix bad usage at error handling logic
      media: i2c: Kconfig: move camera drivers to the top
      media: spi: Kconfig: Place SPI drivers on a single menu

Maxime Jourdan (1):
      media: s5p_mfc_dec: set flags for OUTPUT coded formats

Miaoqian Lin (1):
      media: coda: Fix missing put_device() call in coda_get_vdoa_data

Mikhail Rudenko (1):
      media: sun6i-csi: fix colorspace in sun6i_video_try_fmt()

Ming Qian (19):
      media: imx-jpeg: use NV12M to represent non contiguous NV12
      media: imx-jpeg: fix a bug of accessing array out of bounds
      media: imx-jpeg: Set V4L2_BUF_FLAG_LAST at eos
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
      MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
      media: amphion: add amphion vpu entry in Kconfig and Makefile
      media: amphion: fix an issue that using pm_runtime_get_sync incorrect=
ly
      media: amphion: fix some error related with undefined reference to __=
divdi3
      media: amphion: fix some issues to improve robust
      media: amphion: cleanup media device if register it fail

Mirela Rabulea (2):
      media: imx-jpeg: Prevent decoding NV12M jpegs into single-planar buff=
ers
      media: ov5640: Fix set format, v4l2_mbus_pixelcode not updated

Moses Christopher Bollavarapu (1):
      media: staging: media: atomisp: Use BIT macro instead of left shifting

Muhammad Usama Anjum (1):
      media: imx: imx8mq-mipi_csi2: Remove unneeded code

Neil Armstrong (1):
      media: mexon-ge2d: fixup frames size in registers

Nicolas Dufresne (3):
      media: v4l2-core: Initialize h264 scaling matrix
      doc: media: Document MM21 tiled format
      doc: media: Document VP9 reference_mode miss-placement

Nikita Yushchenko (1):
      media: vsp1: mask interrupts before enabling

Niklas S=C3=B6derlund (3):
      media: rcar-vin: Refactor link notify
      media: rcar-vin: Breakout media link creation
      media: rcar-{csi2,vin}: Move to full Virtual Channel routing per CSI-=
2 IP

Ondrej Zary (1):
      media: bttv: fix WARNING regression on tunerless devices

Paul Pawlowski (1):
      media: uvcvideo: Add support for Apple T2-attached FaceTime HD Camera

Pavel Skripkin (1):
      media: Revert "media: em28xx: add missing em28xx_close_extension"

Peiwei Hu (1):
      media: ir_toy: free before error exiting

Philippe Cornu (1):
      media: MAINTAINERS: update drm/stm drm/sti and cec/sti maintainers

Pratyush Yadav (1):
      media: platform: re-structure TI drivers

Rikard Falkeborn (1):
      media: go7007: Constify static struct snd_device_ops

Robert Foss (2):
      media: dt-bindings: media: camss: Remove clock-lane property
      media: camss: csiphy: Move to hardcode CSI Clock Lane number

Sakari Ailus (6):
      media: v4l: Avoid unaligned access warnings when printing 4cc modifie=
rs
      media: ov5648: Don't pack controls struct
      media: ov8865: Fix indentation in set_selection callback
      media: microchip-csi2dc: Remove VC support for now
      v4l: fwnode: Drop redunant -ENODATA check in property reference parsi=
ng
      v4l: fwnode: Remove now-redundant loop from v4l2_fwnode_parse_referen=
ce()

Sean Young (10):
      media: lirc: simplify gap calculation
      media: mtk-cir: reduce message end to fix nec repeats
      media: mtk-cir: remove superfluous ir_raw_event_reset()
      media: mtk-cir: simplify code
      media: lirc: remove unused lirc features
      media: rc-core: rename ir_raw_event_reset to ir_raw_event_overflow
      media: lirc: report ir receiver overflow
      media: meson-ir-tx: remove incorrect doc comment
      media: lirc: remove unused feature LIRC_CAN_SET_REC_DUTY_CYCLE
      media: gpio-ir-tx: fix transmit with long spaces on Orange Pi PC

Sergey Senozhatsky (1):
      media: videobuf2-dma-contig: Invalidate vmap range before DMA range

Shawn Tu (2):
      media: hi847: Add support for Hi-847 sensor
      media: Add a driver for the og01a1b camera sensor

Shuah Khan (1):
      MAINTAINERS: update media vimc driver maintainers

Souptick Joarder (HPE) (1):
      media: camss: Replace hard coded value with parameter

Stanimir Varbanov (3):
      media: venus: core: Fix kerneldoc warnings
      media: venus: venc: Fix h264 8x8 transform control
      media: venus: hfi_cmds: List HDR10 property as unsupported for v1 and=
 v3

Tom Rix (1):
      media: video/hdmi: handle short reads of hdmi info frame.

Tsuchiya Yuto (1):
      media: atomisp: fix dummy_ptr check to avoid duplicate active_bo

Wang Qing (5):
      media: si21xx: use time_is_before_jiffies() instead of open coding it
      media: stv0299: use time_is_before_jiffies() instead of open coding it
      media: tda8083: use time_is_after_jiffies() instead of open coding it
      media: wl128x: use time_is_before_jiffies() instead of open coding it
      media: vivid: use time_is_after_jiffies() instead of open coding it

Xiongfeng Wang (2):
      media: mtk-vcodec: Add missing of_node_put() in mtk_vdec_hw_prob_done=
()
      media: amphion: Add missing of_node_put() in vpu_core_parse_dt()

Xose Vazquez Perez (1):
      stkwebcam: add new Asus laptop to upside_down table

Xu Wang (1):
      media: mtk-mdp: Remove redundant 'flush_workqueue()' calls

Yang Guang (1):
      media: saa7134: use swap() to make code cleaner

Yang Li (4):
      media: aspeed: Remove duplicated include in aspeed-video.c
      media: imx-jpeg: Remove unnecessary print function dev_err()
      media: mtk-vcodec: Remove duplicated include in mtk_vcodec_enc_drv.c
      media: platform: Remove unnecessary print function dev_err()

Yihao Han (1):
      media: vidtv: use vfree() for memory allocated with vzalloc()

Yong Wu (10):
      media: dt-binding: mediatek: Get rid of mediatek,larb for multimedia =
HW
      media: iommu/mediatek-v1: Free the existed fwspec if the master dev a=
lready has
      media: iommu/mediatek: Return ENODEV if the device is NULL
      media: iommu/mediatek: Add probe_defer for smi-larb
      media: iommu/mediatek: Add device_link between the consumer and the l=
arb devices
      media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
      media: mtk-mdp: Get rid of mtk_smi_larb_get/put
      media: drm/mediatek: Get rid of mtk_smi_larb_get/put
      media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
      media: memory: mtk-smi: Get rid of mtk_smi_larb_get/put

Yongqiang Niu (1):
      media: drm/mediatek: Add pm runtime support for ovl and rdma

YueHaibing (1):
      media: platform: amphion: Fix build error without MAILBOX

Yunfei Dong (20):
      media: mtk-vcodec: Get numbers of register bases from DT
      media: mtk-vcodec: Align vcodec wake up interrupt interface
      media: mtk-vcodec: Refactor vcodec pm interface
      media: mtk-vcodec: export decoder pm functions
      media: dt-bindings: media: mtk-vcodec: Separate video encoder and dec=
oder dt-bindings
      media: dt-bindings: media: mtk-vcodec: Adds decoder dt-bindings for m=
t8192
      media: mtk-vcodec: Support MT8192
      media: mtk-vcodec: Add to support multi hardware decode
      media: mtk-vcodec: Use pure single core for MT8183
      media: mtk-vcodec: Add irq interface for multi hardware
      media: mtk-vcodec: Add msg queue feature for lat and core architecture
      media: mtk-vcodec: Generalize power and clock on/off interfaces
      media: mtk-vcodec: Add new interface to lock different hardware
      media: mtk-vcodec: Add work queue for core hardware decode
      media: mtk-vcodec: Support 34bits dma address for vdec
      media: mtk-vcodec: Add core dec and dec end ipi msg
      media: mtk-vcodec: Use codec type to separate different hardware
      media: mtk-vcodec: Remove mtk_vcodec_release_dec_pm
      media: mtk-vcodec: Remove mtk_vcodec_release_enc_pm
      media: uapi: Init VP9 stateless decode params

Zhou Qingyang (1):
      media: ti-vpe: cal: Fix a NULL pointer dereference in cal_ctx_v4l2_in=
it_formats()

Zhuohao Lee (1):
      media: platform: cros-ec: Add brask to the match table

kernel test robot (2):
      media: ov5693: fix boolconv.cocci warnings
      media: ov5693: fix returnvar.cocci warnings

 Documentation/admin-guide/media/fimc.rst           |    2 +-
 Documentation/admin-guide/media/i2c-cardlist.rst   |    2 +-
 Documentation/admin-guide/media/imx7.rst           |    2 +-
 Documentation/admin-guide/media/omap3isp.rst       |    2 +-
 Documentation/admin-guide/media/omap4_camera.rst   |    2 +-
 Documentation/admin-guide/media/vimc.rst           |   13 +
 .../bindings/display/mediatek/mediatek,disp.txt    |    9 -
 .../devicetree/bindings/media/amphion,vpu.yaml     |  180 ++
 .../devicetree/bindings/media/i2c/hynix,hi846.yaml |    6 +-
 .../bindings/media/i2c/isil,isl79987.yaml          |  113 +
 .../bindings/media/i2c/maxim,max9286.yaml          |  275 +-
 .../bindings/media/mediatek,vcodec-decoder.yaml    |  169 ++
 .../bindings/media/mediatek,vcodec-encoder.yaml    |  179 ++
 .../media/mediatek,vcodec-subdev-decoder.yaml      |  265 ++
 .../bindings/media/mediatek-jpeg-decoder.txt       |   38 -
 .../bindings/media/mediatek-jpeg-decoder.yaml      |   80 +
 .../bindings/media/mediatek-jpeg-encoder.txt       |   35 -
 .../bindings/media/mediatek-jpeg-encoder.yaml      |   72 +
 .../devicetree/bindings/media/mediatek-mdp.txt     |    8 -
 .../devicetree/bindings/media/mediatek-vcodec.txt  |  131 -
 .../bindings/media/microchip,csi2dc.yaml           |  197 ++
 ...,imx7-mipi-csi2.yaml =3D> nxp,imx-mipi-csi2.yaml} |    2 +-
 .../devicetree/bindings/media/nxp,imx7-csi.yaml    |    1 +
 .../devicetree/bindings/media/nxp,imx8mq-vpu.yaml  |   68 +-
 .../bindings/media/qcom,msm8916-camss.yaml         |   10 -
 .../bindings/media/qcom,msm8996-camss.yaml         |   20 -
 .../bindings/media/qcom,sdm660-camss.yaml          |   20 -
 .../bindings/media/qcom,sdm845-camss.yaml          |   31 +-
 .../bindings/media/qcom,sm8250-camss.yaml          |  463 +++
 .../devicetree/bindings/media/renesas,csi2.yaml    |    5 +-
 .../media/drivers/davinci-vpbe-devel.rst           |   20 +-
 .../driver-api/media/drivers/fimc-devel.rst        |   14 +-
 Documentation/driver-api/media/v4l2-event.rst      |    2 +-
 .../userspace-api/media/lirc.h.rst.exceptions      |    4 +-
 .../userspace-api/media/rc/lirc-dev-intro.rst      |   11 +-
 .../userspace-api/media/rc/lirc-get-features.rst   |   18 -
 .../media/v4l/ext-ctrls-codec-stateless.rst        |   13 +-
 .../userspace-api/media/v4l/ext-ctrls-codec.rst    |   16 +-
 .../userspace-api/media/v4l/pixfmt-reserved.rst    |   15 +-
 .../userspace-api/media/v4l/pixfmt-rgb.rst         |    2 +-
 .../userspace-api/media/v4l/pixfmt-yuv-luma.rst    |    4 +-
 .../userspace-api/media/v4l/pixfmt-yuv-planar.rst  |   45 +-
 .../userspace-api/media/v4l/v4l2grab.c.rst         |    2 +-
 .../userspace-api/media/v4l/vidioc-qbuf.rst        |    2 +-
 MAINTAINERS                                        |  143 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |    8 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |    9 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   15 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |   36 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |    1 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |    5 +-
 drivers/gpu/ipu-v3/ipu-csi.c                       |    6 +-
 drivers/input/rmi4/Kconfig                         |    2 +-
 drivers/input/touchscreen/Kconfig                  |    4 +-
 drivers/iommu/mtk_iommu.c                          |   34 +
 drivers/iommu/mtk_iommu_v1.c                       |   42 +-
 drivers/media/Kconfig                              |   11 +-
 drivers/media/Makefile                             |    4 +-
 drivers/media/cec/platform/Makefile                |   16 +-
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c   |    2 +
 drivers/media/cec/platform/seco/seco-cec.c         |   57 +-
 drivers/media/common/Kconfig                       |   16 +-
 drivers/media/common/Makefile                      |    7 +-
 drivers/media/common/saa7146/Kconfig               |    2 +-
 drivers/media/common/videobuf2/Makefile            |    8 +-
 .../media/common/videobuf2/videobuf2-dma-contig.c  |   12 +-
 drivers/media/dvb-core/Kconfig                     |    2 +-
 drivers/media/dvb-frontends/Kconfig                |  663 +++--
 drivers/media/dvb-frontends/Makefile               |  193 +-
 drivers/media/dvb-frontends/dib3000mc.c            |    2 +-
 drivers/media/dvb-frontends/dib7000p.c             |    4 +-
 drivers/media/dvb-frontends/si21xx.c               |    2 +-
 drivers/media/dvb-frontends/stv0299.c              |    9 +-
 drivers/media/dvb-frontends/tda8083.c              |    2 +-
 drivers/media/firewire/Makefile                    |    2 +-
 drivers/media/i2c/Kconfig                          | 2091 +++++++-------
 drivers/media/i2c/Makefile                         |  192 +-
 drivers/media/i2c/adv7180.c                        |   10 +-
 drivers/media/i2c/adv7183.c                        |   51 +-
 drivers/media/i2c/adv748x/adv748x-csi2.c           |   18 +-
 drivers/media/i2c/adv7511-v4l2.c                   |    3 +-
 drivers/media/i2c/adv7604.c                        |    2 +-
 drivers/media/i2c/adv7842.c                        |    2 +-
 drivers/media/i2c/ccs/Kconfig                      |    2 +-
 drivers/media/i2c/ccs/ccs-core.c                   |    1 -
 drivers/media/i2c/cx25840/Kconfig                  |    2 +-
 drivers/media/i2c/dw9714.c                         |   42 +-
 drivers/media/i2c/et8ek8/Kconfig                   |    2 +-
 drivers/media/i2c/hi847.c                          | 3012 ++++++++++++++++=
++++
 drivers/media/i2c/imx274.c                         |    2 -
 drivers/media/i2c/isl7998x.c                       | 1628 +++++++++++
 drivers/media/i2c/m5mols/Kconfig                   |    2 +-
 drivers/media/i2c/m5mols/m5mols.h                  |    3 +
 drivers/media/i2c/m5mols/m5mols_capture.c          |    1 -
 drivers/media/i2c/m5mols/m5mols_core.c             |   29 +-
 drivers/media/i2c/max2175.c                        |    2 +-
 drivers/media/i2c/max9286.c                        |  125 +-
 drivers/media/i2c/ml86v7667.c                      |    5 +-
 drivers/media/i2c/mt9m001.c                        |    8 +-
 drivers/media/i2c/mt9m111.c                        |   15 +-
 drivers/media/i2c/noon010pc30.c                    |   75 +-
 drivers/media/i2c/og01a1b.c                        | 1128 ++++++++
 drivers/media/i2c/ov08d10.c                        | 1528 ++++++++++
 drivers/media/i2c/ov2740.c                         |    8 +-
 drivers/media/i2c/ov5640.c                         |   14 +-
 drivers/media/i2c/ov5648.c                         |   16 +-
 drivers/media/i2c/ov5675.c                         |   32 +-
 drivers/media/i2c/ov5693.c                         |    9 +-
 drivers/media/i2c/ov6650.c                         |  206 +-
 drivers/media/i2c/ov8865.c                         |   12 +-
 drivers/media/i2c/ov9640.c                         |    8 +-
 drivers/media/i2c/saa7115.c                        |    2 +-
 drivers/media/i2c/tc358743.c                       |   26 +-
 drivers/media/i2c/tvp5150.c                        |    6 +-
 drivers/media/mc/mc-entity.c                       |   55 +-
 drivers/media/mmc/Kconfig                          |    1 +
 drivers/media/pci/Kconfig                          |   31 +-
 drivers/media/pci/Makefile                         |   22 +-
 drivers/media/pci/bt8xx/Kconfig                    |    2 +-
 drivers/media/pci/bt8xx/bttv-driver.c              |    4 +-
 drivers/media/pci/cobalt/Kconfig                   |    2 +-
 drivers/media/pci/cx18/Kconfig                     |    2 +-
 drivers/media/pci/cx18/cx18-driver.c               |    4 +-
 drivers/media/pci/cx18/cx18-dvb.c                  |    2 +-
 drivers/media/pci/cx18/cx18-gpio.c                 |    2 +-
 drivers/media/pci/cx18/cx18-queue.h                |    6 +-
 drivers/media/pci/cx23885/cx23885-cards.c          |    2 +-
 drivers/media/pci/cx23885/cx23885-dvb.c            |    2 +-
 drivers/media/pci/cx23885/cx23885-input.c          |    2 +-
 drivers/media/pci/cx23885/cx23885-video.c          |    2 +-
 drivers/media/pci/cx88/cx88-mpeg.c                 |    3 +
 drivers/media/pci/cx88/cx88.h                      |    2 +-
 drivers/media/pci/dt3155/Kconfig                   |    2 +-
 drivers/media/pci/intel/ipu3/Kconfig               |    2 +-
 drivers/media/pci/ivtv/Kconfig                     |    2 +-
 drivers/media/pci/ivtv/ivtv-driver.c               |    2 +-
 drivers/media/pci/ivtv/ivtv-driver.h               |    1 -
 drivers/media/pci/ivtv/ivtv-gpio.c                 |    2 +-
 drivers/media/pci/ivtv/ivtv-ioctl.c                |   10 +-
 drivers/media/pci/ivtv/ivtv-queue.h                |   25 +-
 drivers/media/pci/ivtv/ivtv-streams.c              |   11 +-
 drivers/media/pci/ivtv/ivtv-udma.h                 |    8 +-
 drivers/media/pci/meye/Kconfig                     |    2 +-
 drivers/media/pci/saa7134/saa7134-alsa.c           |    4 +-
 drivers/media/pci/saa7134/saa7134-cards.c          |    2 +-
 drivers/media/pci/saa7134/saa7134-dvb.c            |    2 +-
 drivers/media/pci/saa7134/saa7134-video.c          |   11 +-
 drivers/media/pci/saa7146/Kconfig                  |    6 +-
 drivers/media/pci/saa7164/saa7164-cmd.c            |    1 -
 drivers/media/pci/sta2x11/Kconfig                  |    2 +-
 drivers/media/pci/tw5864/Kconfig                   |    2 +-
 drivers/media/pci/tw68/Kconfig                     |    2 +-
 drivers/media/pci/tw686x/Kconfig                   |    2 +-
 drivers/media/platform/Kconfig                     |  696 +----
 drivers/media/platform/Makefile                    |  110 +-
 drivers/media/platform/allegro-dvt/Kconfig         |   19 +
 drivers/media/platform/amlogic/Kconfig             |    5 +
 drivers/media/platform/amlogic/Makefile            |    2 +
 drivers/media/platform/amlogic/meson-ge2d/Kconfig  |   14 +
 .../{meson/ge2d =3D> amlogic/meson-ge2d}/Makefile    |    0
 .../{meson/ge2d =3D> amlogic/meson-ge2d}/ge2d-regs.h |    0
 .../{meson/ge2d =3D> amlogic/meson-ge2d}/ge2d.c      |   24 +-
 drivers/media/platform/amphion/Kconfig             |   22 +
 drivers/media/platform/amphion/Makefile            |   20 +
 drivers/media/platform/amphion/vdec.c              | 1656 +++++++++++
 drivers/media/platform/amphion/venc.c              | 1358 +++++++++
 drivers/media/platform/amphion/vpu.h               |  362 +++
 drivers/media/platform/amphion/vpu_cmds.c          |  433 +++
 drivers/media/platform/amphion/vpu_cmds.h          |   25 +
 drivers/media/platform/amphion/vpu_codec.h         |   68 +
 drivers/media/platform/amphion/vpu_color.c         |  183 ++
 drivers/media/platform/amphion/vpu_core.c          |  879 ++++++
 drivers/media/platform/amphion/vpu_core.h          |   15 +
 drivers/media/platform/amphion/vpu_dbg.c           |  494 ++++
 drivers/media/platform/amphion/vpu_defs.h          |  187 ++
 drivers/media/platform/amphion/vpu_drv.c           |  261 ++
 drivers/media/platform/amphion/vpu_helpers.c       |  414 +++
 drivers/media/platform/amphion/vpu_helpers.h       |   71 +
 drivers/media/platform/amphion/vpu_imx8q.c         |  271 ++
 drivers/media/platform/amphion/vpu_imx8q.h         |  115 +
 drivers/media/platform/amphion/vpu_malone.c        | 1644 +++++++++++
 drivers/media/platform/amphion/vpu_malone.h        |   44 +
 drivers/media/platform/amphion/vpu_mbox.c          |  118 +
 drivers/media/platform/amphion/vpu_mbox.h          |   16 +
 drivers/media/platform/amphion/vpu_msgs.c          |  385 +++
 drivers/media/platform/amphion/vpu_msgs.h          |   14 +
 drivers/media/platform/amphion/vpu_rpc.c           |  259 ++
 drivers/media/platform/amphion/vpu_rpc.h           |  461 +++
 drivers/media/platform/amphion/vpu_v4l2.c          |  713 +++++
 drivers/media/platform/amphion/vpu_v4l2.h          |   55 +
 drivers/media/platform/amphion/vpu_windsor.c       | 1173 ++++++++
 drivers/media/platform/amphion/vpu_windsor.h       |   37 +
 drivers/media/platform/aspeed/Kconfig              |   13 +
 drivers/media/platform/aspeed/Makefile             |    2 +
 drivers/media/platform/{ =3D> aspeed}/aspeed-video.c |  301 +-
 drivers/media/platform/atmel/Kconfig               |   28 +-
 drivers/media/platform/atmel/Makefile              |    4 +-
 drivers/media/platform/atmel/atmel-isc-base.c      |  397 +--
 drivers/media/platform/atmel/atmel-isc-clk.c       |  311 ++
 drivers/media/platform/atmel/atmel-isc.h           |   11 +
 drivers/media/platform/atmel/atmel-sama5d2-isc.c   |   24 +
 drivers/media/platform/atmel/atmel-sama7g5-isc.c   |   32 +-
 drivers/media/platform/atmel/microchip-csi2dc.c    |  792 +++++
 drivers/media/platform/cadence/Kconfig             |   16 +-
 drivers/media/platform/chips-media/Kconfig         |   20 +
 .../media/platform/{coda =3D> chips-media}/Makefile  |    0
 .../platform/{coda =3D> chips-media}/coda-bit.c      |    0
 .../platform/{coda =3D> chips-media}/coda-common.c   |    1 +
 .../platform/{coda =3D> chips-media}/coda-gdi.c      |    0
 .../platform/{coda =3D> chips-media}/coda-h264.c     |    0
 .../platform/{coda =3D> chips-media}/coda-jpeg.c     |    0
 .../platform/{coda =3D> chips-media}/coda-mpeg2.c    |    0
 .../platform/{coda =3D> chips-media}/coda-mpeg4.c    |    0
 .../media/platform/{coda =3D> chips-media}/coda.h    |    0
 .../platform/{coda =3D> chips-media}/coda_regs.h     |    2 +-
 .../platform/{coda =3D> chips-media}/imx-vdoa.c      |    9 +-
 .../platform/{coda =3D> chips-media}/imx-vdoa.h      |    0
 .../media/platform/{coda =3D> chips-media}/trace.h   |    2 +-
 drivers/media/platform/intel/Kconfig               |   14 +
 drivers/media/platform/intel/Makefile              |    2 +
 drivers/media/platform/{ =3D> intel}/pxa_camera.c    |   21 +-
 .../platform/{marvell-ccic =3D> marvell}/Kconfig     |    9 +-
 .../platform/{marvell-ccic =3D> marvell}/Makefile    |    0
 .../{marvell-ccic =3D> marvell}/cafe-driver.c        |    0
 .../platform/{marvell-ccic =3D> marvell}/mcam-core.c |    0
 .../platform/{marvell-ccic =3D> marvell}/mcam-core.h |    0
 .../{marvell-ccic =3D> marvell}/mmp-driver.c         |    8 +-
 drivers/media/platform/mediatek/Kconfig            |    8 +
 drivers/media/platform/mediatek/Makefile           |    5 +
 drivers/media/platform/mediatek/jpeg/Kconfig       |   16 +
 .../platform/{mtk-jpeg =3D> mediatek/jpeg}/Makefile  |    0
 .../{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_core.c    |   47 +-
 .../{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_core.h    |    2 -
 .../{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_dec_hw.c  |    0
 .../{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_dec_hw.h  |    0
 .../jpeg}/mtk_jpeg_dec_parse.c                     |    0
 .../jpeg}/mtk_jpeg_dec_parse.h                     |    0
 .../{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_dec_reg.h |    0
 .../{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_enc_hw.c  |    0
 .../{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_enc_hw.h  |    0
 drivers/media/platform/mediatek/mdp/Kconfig        |   17 +
 .../platform/{mtk-mdp =3D> mediatek/mdp}/Makefile    |    2 +-
 .../{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_comp.c       |   40 -
 .../{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_comp.h       |    2 -
 .../{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_core.c       |    3 -
 .../{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_core.h       |    0
 .../{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_ipi.h        |    0
 .../{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_m2m.c        |    0
 .../{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_m2m.h        |    0
 .../{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_regs.c       |    0
 .../{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_regs.h       |    0
 .../{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_vpu.c        |    0
 .../{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_vpu.h        |    0
 drivers/media/platform/mediatek/vcodec/Kconfig     |   36 +
 .../{mtk-vcodec =3D> mediatek/vcodec}/Makefile       |    6 +-
 .../vcodec}/mtk_vcodec_dec.c                       |    4 +-
 .../vcodec}/mtk_vcodec_dec.h                       |    1 +
 .../vcodec}/mtk_vcodec_dec_drv.c                   |  199 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec_hw.c   |  200 ++
 .../platform/mediatek/vcodec/mtk_vcodec_dec_hw.h   |   56 +
 .../platform/mediatek/vcodec/mtk_vcodec_dec_pm.c   |  169 ++
 .../platform/mediatek/vcodec/mtk_vcodec_dec_pm.h   |   19 +
 .../vcodec}/mtk_vcodec_dec_stateful.c              |    2 +
 .../vcodec}/mtk_vcodec_dec_stateless.c             |   21 +
 .../vcodec}/mtk_vcodec_drv.h                       |   77 +-
 .../vcodec}/mtk_vcodec_enc.c                       |    1 -
 .../vcodec}/mtk_vcodec_enc.h                       |    0
 .../vcodec}/mtk_vcodec_enc_drv.c                   |   22 +-
 .../vcodec}/mtk_vcodec_enc_pm.c                    |   55 +-
 .../vcodec}/mtk_vcodec_enc_pm.h                    |    3 +-
 .../vcodec}/mtk_vcodec_fw.c                        |    0
 .../vcodec}/mtk_vcodec_fw.h                        |    2 +-
 .../vcodec}/mtk_vcodec_fw_priv.h                   |    0
 .../vcodec}/mtk_vcodec_fw_scp.c                    |    0
 .../vcodec}/mtk_vcodec_fw_vpu.c                    |    2 +
 .../platform/mediatek/vcodec/mtk_vcodec_intr.c     |   43 +
 .../vcodec}/mtk_vcodec_intr.h                      |    5 +-
 .../vcodec}/mtk_vcodec_util.c                      |   59 +-
 .../vcodec}/mtk_vcodec_util.h                      |    8 +-
 .../vcodec}/vdec/vdec_h264_if.c                    |    2 +-
 .../vcodec}/vdec/vdec_h264_req_if.c                |    2 +-
 .../vcodec}/vdec/vdec_vp8_if.c                     |    2 +-
 .../vcodec}/vdec/vdec_vp9_if.c                     |    2 +-
 .../vcodec}/vdec_drv_base.h                        |    0
 .../{mtk-vcodec =3D> mediatek/vcodec}/vdec_drv_if.c  |   21 +-
 .../{mtk-vcodec =3D> mediatek/vcodec}/vdec_drv_if.h  |    0
 .../{mtk-vcodec =3D> mediatek/vcodec}/vdec_ipi_msg.h |   16 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c      |  290 ++
 .../platform/mediatek/vcodec/vdec_msg_queue.h      |  153 +
 .../{mtk-vcodec =3D> mediatek/vcodec}/vdec_vpu_if.c  |   46 +-
 .../{mtk-vcodec =3D> mediatek/vcodec}/vdec_vpu_if.h  |   22 +
 .../vcodec}/venc/venc_h264_if.c                    |    2 +-
 .../vcodec}/venc/venc_vp8_if.c                     |    2 +-
 .../vcodec}/venc_drv_base.h                        |    0
 .../{mtk-vcodec =3D> mediatek/vcodec}/venc_drv_if.c  |    0
 .../{mtk-vcodec =3D> mediatek/vcodec}/venc_drv_if.h  |    0
 .../{mtk-vcodec =3D> mediatek/vcodec}/venc_ipi_msg.h |    0
 .../{mtk-vcodec =3D> mediatek/vcodec}/venc_vpu_if.c  |    0
 .../{mtk-vcodec =3D> mediatek/vcodec}/venc_vpu_if.h  |    0
 drivers/media/platform/mediatek/vpu/Kconfig        |   15 +
 .../platform/{mtk-vpu =3D> mediatek/vpu}/Makefile    |    0
 .../platform/{mtk-vpu =3D> mediatek/vpu}/mtk_vpu.c   |   10 +-
 .../platform/{mtk-vpu =3D> mediatek/vpu}/mtk_vpu.h   |    0
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  |  145 -
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h  |   20 -
 .../media/platform/mtk-vcodec/mtk_vcodec_intr.c    |   45 -
 drivers/media/platform/nvidia/Kconfig              |    5 +
 drivers/media/platform/nvidia/Makefile             |    3 +
 drivers/media/platform/nvidia/tegra-vde/Kconfig    |   17 +
 drivers/media/platform/nvidia/tegra-vde/Makefile   |    3 +
 .../platform/nvidia}/tegra-vde/dmabuf-cache.c      |    2 +-
 drivers/media/platform/nvidia/tegra-vde/h264.c     |  946 ++++++
 .../platform/nvidia}/tegra-vde/iommu.c             |    2 +-
 .../platform/nvidia}/tegra-vde/trace.h             |    2 +-
 drivers/media/platform/nvidia/tegra-vde/v4l2.c     | 1018 +++++++
 drivers/media/platform/nvidia/tegra-vde/vde.c      |  551 ++++
 drivers/media/platform/nvidia/tegra-vde/vde.h      |  242 ++
 drivers/media/platform/nxp/Kconfig                 |   55 +
 drivers/media/platform/nxp/Makefile                |    8 +
 drivers/media/platform/{ =3D> nxp}/fsl-viu.c         |    2 +-
 drivers/media/platform/{ =3D> nxp}/imx-jpeg/Kconfig  |    3 +-
 drivers/media/platform/{ =3D> nxp}/imx-jpeg/Makefile |    0
 .../platform/{ =3D> nxp}/imx-jpeg/mxc-jpeg-hw.c      |    0
 .../platform/{ =3D> nxp}/imx-jpeg/mxc-jpeg-hw.h      |    0
 .../media/platform/{ =3D> nxp}/imx-jpeg/mxc-jpeg.c   |   63 +-
 .../media/platform/{ =3D> nxp}/imx-jpeg/mxc-jpeg.h   |    1 +
 .../platform/nxp/imx-mipi-csis.c}                  |  123 +-
 drivers/media/platform/{ =3D> nxp}/imx-pxp.c         |    0
 drivers/media/platform/{ =3D> nxp}/imx-pxp.h         |    0
 drivers/media/platform/{ =3D> nxp}/mx2_emmaprp.c     |    0
 drivers/media/platform/qcom/Kconfig                |    6 +
 drivers/media/platform/qcom/Makefile               |    3 +
 drivers/media/platform/qcom/camss/Kconfig          |    9 +
 drivers/media/platform/qcom/camss/Makefile         |    3 +-
 .../camss/{camss-csid-170.c =3D> camss-csid-gen2.c}  |   34 +-
 drivers/media/platform/qcom/camss/camss-csid.c     |   91 +-
 drivers/media/platform/qcom/camss/camss-csid.h     |    5 +-
 .../platform/qcom/camss/camss-csiphy-2ph-1-0.c     |   19 +-
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |  199 +-
 drivers/media/platform/qcom/camss/camss-csiphy.c   |   42 +-
 drivers/media/platform/qcom/camss/camss-csiphy.h   |    7 +
 drivers/media/platform/qcom/camss/camss-ispif.c    |   12 +-
 drivers/media/platform/qcom/camss/camss-vfe-170.c  |   12 +-
 drivers/media/platform/qcom/camss/camss-vfe-480.c  |  564 ++++
 drivers/media/platform/qcom/camss/camss-vfe.c      |   29 +-
 drivers/media/platform/qcom/camss/camss-vfe.h      |    4 +
 drivers/media/platform/qcom/camss/camss-video.c    |    5 +-
 drivers/media/platform/qcom/camss/camss.c          |  368 ++-
 drivers/media/platform/qcom/camss/camss.h          |   20 +-
 drivers/media/platform/qcom/venus/Kconfig          |   14 +
 drivers/media/platform/qcom/venus/core.h           |    4 +
 drivers/media/platform/qcom/venus/helpers.c        |    2 +-
 drivers/media/platform/qcom/venus/hfi_cmds.c       |    2 +
 drivers/media/platform/qcom/venus/venc.c           |    4 +-
 drivers/media/platform/qcom/venus/venc_ctrls.c     |    6 +-
 drivers/media/platform/renesas/Kconfig             |  121 +
 drivers/media/platform/renesas/Makefile            |   15 +
 drivers/media/platform/{ =3D> renesas}/rcar-fcp.c    |    0
 drivers/media/platform/{ =3D> renesas}/rcar-isp.c    |   32 +-
 .../media/platform/{ =3D> renesas}/rcar-vin/Kconfig  |    6 +-
 .../media/platform/{ =3D> renesas}/rcar-vin/Makefile |    0
 .../platform/{ =3D> renesas}/rcar-vin/rcar-core.c    |  389 +--
 .../platform/{ =3D> renesas}/rcar-vin/rcar-csi2.c    |  132 +-
 .../platform/{ =3D> renesas}/rcar-vin/rcar-dma.c     |    2 +-
 .../platform/{ =3D> renesas}/rcar-vin/rcar-v4l2.c    |    0
 .../platform/{ =3D> renesas}/rcar-vin/rcar-vin.h     |   20 +-
 drivers/media/platform/{ =3D> renesas}/rcar_drif.c   |    0
 drivers/media/platform/{ =3D> renesas}/rcar_fdp1.c   |    0
 drivers/media/platform/{ =3D> renesas}/rcar_jpu.c    |    2 +-
 drivers/media/platform/{ =3D> renesas}/renesas-ceu.c |    0
 drivers/media/platform/{ =3D> renesas}/sh_vou.c      |    0
 drivers/media/platform/{ =3D> renesas}/vsp1/Makefile |    0
 drivers/media/platform/{ =3D> renesas}/vsp1/vsp1.h   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_brx.c   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_brx.h   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_clu.c   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_clu.h   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_dl.c    |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_dl.h    |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_drm.c   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_drm.h   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_drv.c   |   47 +-
 .../platform/{ =3D> renesas}/vsp1/vsp1_entity.c      |    0
 .../platform/{ =3D> renesas}/vsp1/vsp1_entity.h      |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_hgo.c   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_hgo.h   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_hgt.c   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_hgt.h   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_histo.c |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_histo.h |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_hsit.c  |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_hsit.h  |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_lif.c   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_lif.h   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_lut.c   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_lut.h   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_pipe.c  |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_pipe.h  |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_regs.h  |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_rpf.c   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_rwpf.c  |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_rwpf.h  |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_sru.c   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_sru.h   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_uds.c   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_uds.h   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_uif.c   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_uif.h   |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_video.c |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_video.h |    0
 .../media/platform/{ =3D> renesas}/vsp1/vsp1_wpf.c   |    0
 drivers/media/platform/rockchip/Kconfig            |    6 +
 drivers/media/platform/rockchip/Makefile           |    3 +
 drivers/media/platform/rockchip/rga/Kconfig        |   14 +
 drivers/media/platform/rockchip/rkisp1/Kconfig     |   19 +
 .../platform/rockchip/rkisp1/rkisp1-capture.c      |   28 +-
 drivers/media/platform/samsung/Kconfig             |   10 +
 drivers/media/platform/samsung/Makefile            |    7 +
 drivers/media/platform/samsung/exynos-gsc/Kconfig  |   10 +
 .../platform/{ =3D> samsung}/exynos-gsc/Makefile     |    0
 .../platform/{ =3D> samsung}/exynos-gsc/gsc-core.c   |   14 +-
 .../platform/{ =3D> samsung}/exynos-gsc/gsc-core.h   |    0
 .../platform/{ =3D> samsung}/exynos-gsc/gsc-m2m.c    |    0
 .../platform/{ =3D> samsung}/exynos-gsc/gsc-regs.c   |    0
 .../platform/{ =3D> samsung}/exynos-gsc/gsc-regs.h   |    0
 .../platform/{ =3D> samsung}/exynos4-is/Kconfig      |    3 +-
 .../platform/{ =3D> samsung}/exynos4-is/Makefile     |    0
 .../platform/{ =3D> samsung}/exynos4-is/common.c     |    5 +-
 .../platform/{ =3D> samsung}/exynos4-is/common.h     |    0
 .../{ =3D> samsung}/exynos4-is/fimc-capture.c        |    0
 .../platform/{ =3D> samsung}/exynos4-is/fimc-core.c  |   11 +-
 .../platform/{ =3D> samsung}/exynos4-is/fimc-core.h  |    0
 .../{ =3D> samsung}/exynos4-is/fimc-is-command.h     |    0
 .../{ =3D> samsung}/exynos4-is/fimc-is-errno.c       |    0
 .../{ =3D> samsung}/exynos4-is/fimc-is-errno.h       |    0
 .../{ =3D> samsung}/exynos4-is/fimc-is-i2c.c         |    0
 .../{ =3D> samsung}/exynos4-is/fimc-is-i2c.h         |    0
 .../{ =3D> samsung}/exynos4-is/fimc-is-param.c       |    0
 .../{ =3D> samsung}/exynos4-is/fimc-is-param.h       |    0
 .../{ =3D> samsung}/exynos4-is/fimc-is-regs.c        |    0
 .../{ =3D> samsung}/exynos4-is/fimc-is-regs.h        |    0
 .../{ =3D> samsung}/exynos4-is/fimc-is-sensor.c      |    0
 .../{ =3D> samsung}/exynos4-is/fimc-is-sensor.h      |    0
 .../platform/{ =3D> samsung}/exynos4-is/fimc-is.c    |    0
 .../platform/{ =3D> samsung}/exynos4-is/fimc-is.h    |    0
 .../{ =3D> samsung}/exynos4-is/fimc-isp-video.c      |    0
 .../{ =3D> samsung}/exynos4-is/fimc-isp-video.h      |    0
 .../platform/{ =3D> samsung}/exynos4-is/fimc-isp.c   |    2 +-
 .../platform/{ =3D> samsung}/exynos4-is/fimc-isp.h   |    0
 .../{ =3D> samsung}/exynos4-is/fimc-lite-reg.c       |    0
 .../{ =3D> samsung}/exynos4-is/fimc-lite-reg.h       |    0
 .../platform/{ =3D> samsung}/exynos4-is/fimc-lite.c  |   17 +-
 .../platform/{ =3D> samsung}/exynos4-is/fimc-lite.h  |    0
 .../platform/{ =3D> samsung}/exynos4-is/fimc-m2m.c   |    0
 .../platform/{ =3D> samsung}/exynos4-is/fimc-reg.c   |    0
 .../platform/{ =3D> samsung}/exynos4-is/fimc-reg.h   |    0
 .../platform/{ =3D> samsung}/exynos4-is/media-dev.c  |    0
 .../platform/{ =3D> samsung}/exynos4-is/media-dev.h  |    0
 .../platform/{ =3D> samsung}/exynos4-is/mipi-csis.c  |    0
 .../platform/{ =3D> samsung}/exynos4-is/mipi-csis.h  |    0
 drivers/media/platform/samsung/s3c-camif/Kconfig   |   15 +
 .../platform/{ =3D> samsung}/s3c-camif/Makefile      |    0
 .../{ =3D> samsung}/s3c-camif/camif-capture.c        |    0
 .../platform/{ =3D> samsung}/s3c-camif/camif-core.c  |    0
 .../platform/{ =3D> samsung}/s3c-camif/camif-core.h  |    0
 .../platform/{ =3D> samsung}/s3c-camif/camif-regs.c  |    0
 .../platform/{ =3D> samsung}/s3c-camif/camif-regs.h  |    0
 drivers/media/platform/samsung/s5p-g2d/Kconfig     |   11 +
 .../media/platform/{ =3D> samsung}/s5p-g2d/Makefile  |    0
 .../media/platform/{ =3D> samsung}/s5p-g2d/g2d-hw.c  |    0
 .../platform/{ =3D> samsung}/s5p-g2d/g2d-regs.h      |    0
 drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d.c |   10 +-
 drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d.h |    0
 drivers/media/platform/samsung/s5p-jpeg/Kconfig    |   12 +
 .../media/platform/{ =3D> samsung}/s5p-jpeg/Makefile |    0
 .../platform/{ =3D> samsung}/s5p-jpeg/jpeg-core.c    |    2 +-
 .../platform/{ =3D> samsung}/s5p-jpeg/jpeg-core.h    |    2 +-
 .../{ =3D> samsung}/s5p-jpeg/jpeg-hw-exynos3250.c    |    0
 .../{ =3D> samsung}/s5p-jpeg/jpeg-hw-exynos3250.h    |    2 +-
 .../{ =3D> samsung}/s5p-jpeg/jpeg-hw-exynos4.c       |    0
 .../{ =3D> samsung}/s5p-jpeg/jpeg-hw-exynos4.h       |    0
 .../platform/{ =3D> samsung}/s5p-jpeg/jpeg-hw-s5p.c  |    2 +-
 .../platform/{ =3D> samsung}/s5p-jpeg/jpeg-hw-s5p.h  |    2 +-
 .../platform/{ =3D> samsung}/s5p-jpeg/jpeg-regs.h    |    2 +-
 drivers/media/platform/samsung/s5p-mfc/Kconfig     |    9 +
 .../media/platform/{ =3D> samsung}/s5p-mfc/Makefile  |    0
 .../platform/{ =3D> samsung}/s5p-mfc/regs-mfc-v10.h  |    0
 .../platform/{ =3D> samsung}/s5p-mfc/regs-mfc-v6.h   |    0
 .../platform/{ =3D> samsung}/s5p-mfc/regs-mfc-v7.h   |    0
 .../platform/{ =3D> samsung}/s5p-mfc/regs-mfc-v8.h   |    0
 .../platform/{ =3D> samsung}/s5p-mfc/regs-mfc.h      |    0
 .../media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc.c |   11 +-
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_cmd.c   |    2 +-
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_cmd.h   |    2 +-
 .../{ =3D> samsung}/s5p-mfc/s5p_mfc_cmd_v5.c         |    2 +-
 .../{ =3D> samsung}/s5p-mfc/s5p_mfc_cmd_v5.h         |    2 +-
 .../{ =3D> samsung}/s5p-mfc/s5p_mfc_cmd_v6.c         |    2 +-
 .../{ =3D> samsung}/s5p-mfc/s5p_mfc_cmd_v6.h         |    2 +-
 .../{ =3D> samsung}/s5p-mfc/s5p_mfc_common.h         |    1 +
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_ctrl.c  |    2 +-
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_ctrl.h  |    2 +-
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_debug.h |    2 +-
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_dec.c   |   20 +-
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_dec.h   |    2 +-
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_enc.c   |    2 +-
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_enc.h   |    2 +-
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_intr.c  |    0
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_intr.h  |    0
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_iommu.h |    0
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_opr.c   |    2 +-
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_opr.h   |    2 +-
 .../{ =3D> samsung}/s5p-mfc/s5p_mfc_opr_v5.c         |    0
 .../{ =3D> samsung}/s5p-mfc/s5p_mfc_opr_v5.h         |    0
 .../{ =3D> samsung}/s5p-mfc/s5p_mfc_opr_v6.c         |    2 +-
 .../{ =3D> samsung}/s5p-mfc/s5p_mfc_opr_v6.h         |    2 +-
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_pm.c    |    2 +-
 .../platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_pm.h    |    2 +-
 drivers/media/platform/st/Kconfig                  |    6 +
 drivers/media/platform/st/Makefile                 |    7 +
 drivers/media/platform/st/sti/Kconfig              |    5 +
 drivers/media/platform/st/sti/Makefile             |    6 +
 drivers/media/platform/st/sti/bdisp/Kconfig        |   10 +
 drivers/media/platform/{ =3D> st}/sti/bdisp/Makefile |    0
 .../platform/{ =3D> st}/sti/bdisp/bdisp-debug.c      |    0
 .../platform/{ =3D> st}/sti/bdisp/bdisp-filter.h     |    0
 .../media/platform/{ =3D> st}/sti/bdisp/bdisp-hw.c   |    0
 .../media/platform/{ =3D> st}/sti/bdisp/bdisp-reg.h  |    0
 .../media/platform/{ =3D> st}/sti/bdisp/bdisp-v4l2.c |   10 +-
 drivers/media/platform/{ =3D> st}/sti/bdisp/bdisp.h  |    0
 .../media/platform/{ =3D> st}/sti/c8sectpfe/Kconfig  |    1 +
 .../media/platform/{ =3D> st}/sti/c8sectpfe/Makefile |    0
 .../{ =3D> st}/sti/c8sectpfe/c8sectpfe-common.c      |    0
 .../{ =3D> st}/sti/c8sectpfe/c8sectpfe-common.h      |    0
 .../{ =3D> st}/sti/c8sectpfe/c8sectpfe-core.c        |    0
 .../{ =3D> st}/sti/c8sectpfe/c8sectpfe-core.h        |    0
 .../{ =3D> st}/sti/c8sectpfe/c8sectpfe-debugfs.c     |    0
 .../{ =3D> st}/sti/c8sectpfe/c8sectpfe-debugfs.h     |    0
 .../{ =3D> st}/sti/c8sectpfe/c8sectpfe-dvb.c         |    0
 .../{ =3D> st}/sti/c8sectpfe/c8sectpfe-dvb.h         |    0
 drivers/media/platform/st/sti/delta/Kconfig        |   36 +
 drivers/media/platform/{ =3D> st}/sti/delta/Makefile |    0
 .../media/platform/{ =3D> st}/sti/delta/delta-cfg.h  |    0
 .../platform/{ =3D> st}/sti/delta/delta-debug.c      |    0
 .../platform/{ =3D> st}/sti/delta/delta-debug.h      |    0
 .../media/platform/{ =3D> st}/sti/delta/delta-ipc.c  |    0
 .../media/platform/{ =3D> st}/sti/delta/delta-ipc.h  |    0
 .../media/platform/{ =3D> st}/sti/delta/delta-mem.c  |    0
 .../media/platform/{ =3D> st}/sti/delta/delta-mem.h  |    0
 .../platform/{ =3D> st}/sti/delta/delta-mjpeg-dec.c  |    0
 .../platform/{ =3D> st}/sti/delta/delta-mjpeg-fw.h   |    0
 .../platform/{ =3D> st}/sti/delta/delta-mjpeg-hdr.c  |    0
 .../platform/{ =3D> st}/sti/delta/delta-mjpeg.h      |    0
 .../media/platform/{ =3D> st}/sti/delta/delta-v4l2.c |    0
 drivers/media/platform/{ =3D> st}/sti/delta/delta.h  |    0
 drivers/media/platform/st/sti/hva/Kconfig          |   26 +
 drivers/media/platform/{ =3D> st}/sti/hva/Makefile   |    0
 .../media/platform/{ =3D> st}/sti/hva/hva-debugfs.c  |    0
 drivers/media/platform/{ =3D> st}/sti/hva/hva-h264.c |    0
 drivers/media/platform/{ =3D> st}/sti/hva/hva-hw.c   |    0
 drivers/media/platform/{ =3D> st}/sti/hva/hva-hw.h   |    0
 drivers/media/platform/{ =3D> st}/sti/hva/hva-mem.c  |    0
 drivers/media/platform/{ =3D> st}/sti/hva/hva-mem.h  |    0
 drivers/media/platform/{ =3D> st}/sti/hva/hva-v4l2.c |    0
 drivers/media/platform/{ =3D> st}/sti/hva/hva.h      |    0
 drivers/media/platform/st/stm32/Kconfig            |   31 +
 drivers/media/platform/{ =3D> st}/stm32/Makefile     |    0
 .../media/platform/{ =3D> st}/stm32/dma2d/dma2d-hw.c |    0
 .../platform/{ =3D> st}/stm32/dma2d/dma2d-regs.h     |    0
 .../media/platform/{ =3D> st}/stm32/dma2d/dma2d.c    |    9 +-
 .../media/platform/{ =3D> st}/stm32/dma2d/dma2d.h    |    0
 drivers/media/platform/{ =3D> st}/stm32/stm32-dcmi.c |   53 +-
 drivers/media/platform/sunxi/Kconfig               |    4 +
 drivers/media/platform/sunxi/sun4i-csi/Kconfig     |    3 +-
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h |    2 +-
 drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c |    2 +-
 drivers/media/platform/sunxi/sun6i-csi/Kconfig     |    3 +-
 .../media/platform/sunxi/sun6i-csi/sun6i_video.c   |    6 +-
 drivers/media/platform/sunxi/sun8i-di/Kconfig      |   14 +
 drivers/media/platform/sunxi/sun8i-rotate/Kconfig  |   14 +
 drivers/media/platform/ti/Kconfig                  |   69 +
 drivers/media/platform/ti/Makefile                 |    7 +
 drivers/media/platform/{ =3D> ti}/am437x/Kconfig     |    3 +-
 drivers/media/platform/{ =3D> ti}/am437x/Makefile    |    0
 .../media/platform/{ =3D> ti}/am437x/am437x-vpfe.c   |    0
 .../media/platform/{ =3D> ti}/am437x/am437x-vpfe.h   |    0
 .../platform/{ =3D> ti}/am437x/am437x-vpfe_regs.h    |    0
 drivers/media/platform/ti/cal/Makefile             |    3 +
 .../platform/{ti-vpe =3D> ti/cal}/cal-camerarx.c     |    6 +-
 .../media/platform/{ti-vpe =3D> ti/cal}/cal-video.c  |    3 +
 drivers/media/platform/{ti-vpe =3D> ti/cal}/cal.c    |    0
 drivers/media/platform/{ti-vpe =3D> ti/cal}/cal.h    |    0
 .../media/platform/{ti-vpe =3D> ti/cal}/cal_regs.h   |    0
 drivers/media/platform/{ =3D> ti}/davinci/Kconfig    |   18 +-
 drivers/media/platform/{ =3D> ti}/davinci/Makefile   |    0
 .../platform/{ =3D> ti}/davinci/ccdc_hw_device.h     |    0
 .../media/platform/{ =3D> ti}/davinci/dm355_ccdc.c   |    0
 .../platform/{ =3D> ti}/davinci/dm355_ccdc_regs.h    |    0
 .../media/platform/{ =3D> ti}/davinci/dm644x_ccdc.c  |    0
 .../platform/{ =3D> ti}/davinci/dm644x_ccdc_regs.h   |    0
 drivers/media/platform/{ =3D> ti}/davinci/isif.c     |    0
 .../media/platform/{ =3D> ti}/davinci/isif_regs.h    |    0
 drivers/media/platform/{ =3D> ti}/davinci/vpbe.c     |    0
 .../media/platform/{ =3D> ti}/davinci/vpbe_display.c |    0
 drivers/media/platform/{ =3D> ti}/davinci/vpbe_osd.c |    0
 .../platform/{ =3D> ti}/davinci/vpbe_osd_regs.h      |    0
 .../media/platform/{ =3D> ti}/davinci/vpbe_venc.c    |    0
 .../platform/{ =3D> ti}/davinci/vpbe_venc_regs.h     |    0
 .../media/platform/{ =3D> ti}/davinci/vpfe_capture.c |    0
 drivers/media/platform/{ =3D> ti}/davinci/vpif.c     |  123 +-
 drivers/media/platform/{ =3D> ti}/davinci/vpif.h     |    0
 .../media/platform/{ =3D> ti}/davinci/vpif_capture.c |   27 +-
 .../media/platform/{ =3D> ti}/davinci/vpif_capture.h |    0
 .../media/platform/{ =3D> ti}/davinci/vpif_display.c |   24 +-
 .../media/platform/{ =3D> ti}/davinci/vpif_display.h |    0
 drivers/media/platform/{ =3D> ti}/davinci/vpss.c     |    0
 drivers/media/platform/{ =3D> ti}/omap/Kconfig       |    3 +-
 drivers/media/platform/{ =3D> ti}/omap/Makefile      |    0
 drivers/media/platform/{ =3D> ti}/omap/omap_vout.c   |    0
 .../media/platform/{ =3D> ti}/omap/omap_vout_vrfb.c  |    0
 .../media/platform/{ =3D> ti}/omap/omap_vout_vrfb.h  |    0
 .../media/platform/{ =3D> ti}/omap/omap_voutdef.h    |    0
 .../media/platform/{ =3D> ti}/omap/omap_voutlib.c    |    0
 .../media/platform/{ =3D> ti}/omap/omap_voutlib.h    |    0
 drivers/media/platform/ti/omap3isp/Kconfig         |   21 +
 drivers/media/platform/{ =3D> ti}/omap3isp/Makefile  |    0
 .../platform/{ =3D> ti}/omap3isp/cfa_coef_table.h    |    0
 .../media/platform/{ =3D> ti}/omap3isp/gamma_table.h |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/isp.c     |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/isp.h     |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/ispccdc.c |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/ispccdc.h |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/ispccp2.c |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/ispccp2.h |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/ispcsi2.c |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/ispcsi2.h |    0
 .../media/platform/{ =3D> ti}/omap3isp/ispcsiphy.c   |    0
 .../media/platform/{ =3D> ti}/omap3isp/ispcsiphy.h   |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/isph3a.h  |    0
 .../media/platform/{ =3D> ti}/omap3isp/isph3a_aewb.c |    0
 .../media/platform/{ =3D> ti}/omap3isp/isph3a_af.c   |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/isphist.c |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/isphist.h |    0
 .../media/platform/{ =3D> ti}/omap3isp/isppreview.c  |    0
 .../media/platform/{ =3D> ti}/omap3isp/isppreview.h  |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/ispreg.h  |    0
 .../media/platform/{ =3D> ti}/omap3isp/ispresizer.c  |    0
 .../media/platform/{ =3D> ti}/omap3isp/ispresizer.h  |    0
 drivers/media/platform/{ =3D> ti}/omap3isp/ispstat.c |    5 +-
 drivers/media/platform/{ =3D> ti}/omap3isp/ispstat.h |    0
 .../media/platform/{ =3D> ti}/omap3isp/ispvideo.c    |    0
 .../media/platform/{ =3D> ti}/omap3isp/ispvideo.h    |    0
 .../{ =3D> ti}/omap3isp/luma_enhance_table.h         |    0
 .../{ =3D> ti}/omap3isp/noise_filter_table.h         |    0
 .../media/platform/{ =3D> ti}/omap3isp/omap3isp.h    |    0
 drivers/media/platform/{ti-vpe =3D> ti/vpe}/Makefile |    4 -
 drivers/media/platform/{ti-vpe =3D> ti/vpe}/csc.c    |    0
 drivers/media/platform/{ti-vpe =3D> ti/vpe}/csc.h    |    0
 drivers/media/platform/{ti-vpe =3D> ti/vpe}/sc.c     |    0
 drivers/media/platform/{ti-vpe =3D> ti/vpe}/sc.h     |    0
 .../media/platform/{ti-vpe =3D> ti/vpe}/sc_coeff.h   |    0
 drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpdma.c  |    0
 drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpdma.h  |    0
 .../media/platform/{ti-vpe =3D> ti/vpe}/vpdma_priv.h |    0
 drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpe.c    |    0
 .../media/platform/{ti-vpe =3D> ti/vpe}/vpe_regs.h   |    0
 drivers/media/platform/via/Kconfig                 |   14 +
 drivers/media/platform/via/Makefile                |    2 +
 drivers/media/platform/{ =3D> via}/via-camera.c      |    0
 drivers/media/platform/{ =3D> via}/via-camera.h      |    0
 drivers/media/platform/xilinx/Kconfig              |   10 +-
 drivers/media/platform/xilinx/xilinx-csi2rxss.c    |  106 +-
 drivers/media/radio/Kconfig                        |  348 ++-
 drivers/media/radio/Makefile                       |   43 +-
 drivers/media/radio/radio-sf16fmi.c                |    2 +-
 drivers/media/radio/si470x/Kconfig                 |    2 +-
 drivers/media/radio/wl128x/Kconfig                 |    2 +-
 drivers/media/radio/wl128x/fmdrv_common.c          |    3 +-
 drivers/media/rc/Kconfig                           |  376 +--
 drivers/media/rc/Makefile                          |   47 +-
 drivers/media/rc/fintek-cir.c                      |    2 +-
 drivers/media/rc/gpio-ir-tx.c                      |   28 +-
 drivers/media/rc/igorplugusb.c                     |    2 +-
 drivers/media/rc/iguanair.c                        |    2 +-
 drivers/media/rc/ir-hix5hd2.c                      |    2 +-
 drivers/media/rc/ir-imon-decoder.c                 |    2 +-
 drivers/media/rc/ir-jvc-decoder.c                  |    2 +-
 drivers/media/rc/ir-mce_kbd-decoder.c              |    2 +-
 drivers/media/rc/ir-nec-decoder.c                  |    2 +-
 drivers/media/rc/ir-rc5-decoder.c                  |    2 +-
 drivers/media/rc/ir-rc6-decoder.c                  |    2 +-
 drivers/media/rc/ir-rcmm-decoder.c                 |    2 +-
 drivers/media/rc/ir-sanyo-decoder.c                |    4 +-
 drivers/media/rc/ir-sharp-decoder.c                |    2 +-
 drivers/media/rc/ir-sony-decoder.c                 |    2 +-
 drivers/media/rc/ir-xmp-decoder.c                  |    2 +-
 drivers/media/rc/ir_toy.c                          |    2 +-
 drivers/media/rc/ite-cir.c                         |    2 +-
 drivers/media/rc/keymaps/Makefile                  |   34 +-
 drivers/media/rc/lirc_dev.c                        |   36 +-
 drivers/media/rc/meson-ir-tx.c                     |    2 +-
 drivers/media/rc/mtk-cir.c                         |   39 +-
 drivers/media/rc/nuvoton-cir.c                     |    2 +-
 drivers/media/rc/rc-core-priv.h                    |    2 +-
 drivers/media/rc/rc-ir-raw.c                       |    2 -
 drivers/media/rc/rc-loopback.c                     |    6 +-
 drivers/media/rc/st_rc.c                           |    2 +-
 drivers/media/rc/sunxi-cir.c                       |    2 +-
 drivers/media/rc/winbond-cir.c                     |    2 +-
 drivers/media/spi/Kconfig                          |   26 +-
 drivers/media/spi/Makefile                         |    7 +-
 drivers/media/test-drivers/Kconfig                 |    8 +-
 drivers/media/test-drivers/Makefile                |   14 +-
 drivers/media/test-drivers/vicodec/Kconfig         |    2 +-
 drivers/media/test-drivers/vidtv/Kconfig           |    1 -
 drivers/media/test-drivers/vidtv/vidtv_s302m.c     |   17 +-
 drivers/media/test-drivers/vimc/Kconfig            |    3 +-
 drivers/media/test-drivers/vimc/vimc-capture.c     |    9 +-
 drivers/media/test-drivers/vimc/vimc-common.h      |    7 +
 drivers/media/test-drivers/vimc/vimc-core.c        |   10 +
 drivers/media/test-drivers/vivid/Kconfig           |    2 +-
 drivers/media/test-drivers/vivid/vivid-core.h      |    5 +-
 drivers/media/test-drivers/vivid/vivid-ctrls.c     |   32 +-
 .../media/test-drivers/vivid/vivid-kthread-cap.c   |   10 +-
 .../media/test-drivers/vivid/vivid-kthread-out.c   |   12 +-
 .../media/test-drivers/vivid/vivid-kthread-touch.c |   10 +-
 drivers/media/test-drivers/vivid/vivid-sdr-cap.c   |   15 +-
 drivers/media/test-drivers/vivid/vivid-touch-cap.c |    2 +-
 drivers/media/tuners/Kconfig                       |  241 +-
 drivers/media/tuners/Makefile                      |   66 +-
 drivers/media/tuners/e4000.c                       |    6 +-
 drivers/media/tuners/fc2580.c                      |    6 +-
 drivers/media/tuners/tuner-types.c                 |    2 +-
 .../{tuner-xc2028-types.h =3D> xc2028-types.h}       |    6 +-
 drivers/media/tuners/{tuner-xc2028.c =3D> xc2028.c}  |    6 +-
 drivers/media/tuners/{tuner-xc2028.h =3D> xc2028.h}  |    2 +-
 drivers/media/tuners/xc4000.c                      |    2 +-
 drivers/media/usb/Kconfig                          |   33 +-
 drivers/media/usb/Makefile                         |   40 +-
 drivers/media/usb/airspy/Kconfig                   |    2 +-
 drivers/media/usb/au0828/Kconfig                   |    6 +-
 drivers/media/usb/cpia2/Kconfig                    |    2 +-
 drivers/media/usb/dvb-usb-v2/Kconfig               |   34 +-
 drivers/media/usb/dvb-usb/Kconfig                  |  368 +--
 drivers/media/usb/dvb-usb/cxusb.c                  |    2 +-
 drivers/media/usb/dvb-usb/dib0700_devices.c        |    2 +-
 drivers/media/usb/em28xx/em28xx-cards.c            |   13 +-
 drivers/media/usb/em28xx/em28xx-i2c.c              |    2 +-
 drivers/media/usb/em28xx/em28xx.h                  |    2 +-
 drivers/media/usb/go7007/s2250-board.c             |   10 +-
 drivers/media/usb/go7007/snd-go7007.c              |    2 +-
 drivers/media/usb/gspca/Kconfig                    |  121 +-
 drivers/media/usb/gspca/Makefile                   |   88 +-
 drivers/media/usb/gspca/gl860/Kconfig              |    2 +-
 drivers/media/usb/gspca/jl2005bcd.c                |    4 +-
 drivers/media/usb/gspca/m5602/Kconfig              |    2 +-
 drivers/media/usb/gspca/pac7302.c                  |    1 -
 drivers/media/usb/hackrf/Kconfig                   |    2 +-
 drivers/media/usb/hdpvr/Kconfig                    |    2 +-
 drivers/media/usb/hdpvr/hdpvr-video.c              |    4 +-
 drivers/media/usb/msi2500/Kconfig                  |    2 +-
 drivers/media/usb/pvrusb2/Kconfig                  |    2 +-
 drivers/media/usb/pwc/Kconfig                      |    2 +-
 drivers/media/usb/pwc/pwc-uncompress.c             |    2 +-
 drivers/media/usb/s2255/Kconfig                    |    2 +-
 drivers/media/usb/stk1160/stk1160-core.c           |    2 +-
 drivers/media/usb/stk1160/stk1160-v4l.c            |   16 +-
 drivers/media/usb/stk1160/stk1160-video.c          |  142 +-
 drivers/media/usb/stk1160/stk1160.h                |   23 +-
 drivers/media/usb/stkwebcam/Kconfig                |    2 +-
 drivers/media/usb/stkwebcam/stk-webcam.c           |    7 +
 drivers/media/usb/tm6000/tm6000-cards.c            |    2 +-
 drivers/media/usb/tm6000/tm6000-dvb.c              |    2 +-
 drivers/media/usb/tm6000/tm6000-i2c.c              |    2 +-
 drivers/media/usb/usbtv/Kconfig                    |    2 +-
 drivers/media/usb/uvc/Kconfig                      |    2 +-
 drivers/media/usb/uvc/uvc_driver.c                 |    9 +
 drivers/media/usb/zr364xx/Kconfig                  |    2 +-
 drivers/media/v4l2-core/Kconfig                    |   12 +-
 drivers/media/v4l2-core/Makefile                   |   34 +-
 drivers/media/v4l2-core/tuner-core.c               |    2 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |   20 +-
 drivers/media/v4l2-core/v4l2-dev.c                 |   68 +-
 drivers/media/v4l2-core/v4l2-fwnode.c              |   46 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |   14 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c             |   53 +-
 drivers/media/v4l2-core/v4l2-subdev.c              |    8 -
 drivers/memory/mtk-smi.c                           |   14 -
 drivers/staging/media/Kconfig                      |    2 -
 drivers/staging/media/Makefile                     |    1 -
 drivers/staging/media/atomisp/Kconfig              |    2 +-
 drivers/staging/media/atomisp/i2c/Kconfig          |   14 +-
 drivers/staging/media/atomisp/pci/atomisp_acc.c    |   28 +-
 .../media/atomisp/pci/atomisp_compat_css20.c       |    4 +-
 .../media/atomisp/pci/atomisp_gmin_platform.c      |  148 +-
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |   21 +-
 drivers/staging/media/atomisp/pci/hmm/hmm.c        |    7 +-
 .../staging/media/atomisp/pci/ia_css_acc_types.h   |    5 +-
 drivers/staging/media/atomisp/pci/ia_css_env.h     |    9 +-
 .../media/atomisp/pci/ia_css_event_public.h        |   33 +-
 drivers/staging/media/atomisp/pci/ia_css_irq.h     |   77 +-
 .../isp/kernels/macc/macc1_5/ia_css_macc1_5.host.c |    2 +-
 .../pci/runtime/debug/interface/ia_css_debug.h     |   31 +-
 .../staging/media/atomisp/pci/sh_css_firmware.c    |    4 +
 drivers/staging/media/hantro/Kconfig               |    2 +-
 drivers/staging/media/hantro/TODO                  |    7 -
 drivers/staging/media/hantro/hantro.h              |    1 -
 drivers/staging/media/hantro/hantro_drv.c          |   52 +-
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c  |   27 +-
 drivers/staging/media/hantro/hantro_h1_jpeg_enc.c  |   41 +-
 drivers/staging/media/hantro/hantro_h1_regs.h      |    2 +-
 drivers/staging/media/hantro/hantro_hw.h           |   13 +-
 drivers/staging/media/hantro/hantro_jpeg.c         |   86 +-
 drivers/staging/media/hantro/hantro_jpeg.h         |    2 +-
 drivers/staging/media/hantro/hantro_v4l2.c         |   77 +
 drivers/staging/media/hantro/imx8m_vpu_hw.c        |   62 +-
 .../media/hantro/rockchip_vpu2_hw_jpeg_enc.c       |   44 +-
 drivers/staging/media/hantro/rockchip_vpu_hw.c     |    6 -
 drivers/staging/media/hantro/sunxi_vpu_hw.c        |    4 +-
 drivers/staging/media/imx/Kconfig                  |    2 +-
 drivers/staging/media/imx/Makefile                 |    1 -
 drivers/staging/media/imx/TODO                     |   25 +
 drivers/staging/media/imx/imx-media-csi.c          |    7 +-
 drivers/staging/media/imx/imx6-mipi-csi2.c         |   25 +-
 drivers/staging/media/imx/imx7-media-csi.c         |   64 +-
 drivers/staging/media/imx/imx8mq-mipi-csi2.c       |   81 +-
 drivers/staging/media/ipu3/Kconfig                 |    2 +-
 drivers/staging/media/max96712/Kconfig             |    2 +-
 drivers/staging/media/max96712/max96712.c          |    2 +-
 drivers/staging/media/meson/vdec/Kconfig           |    2 +-
 drivers/staging/media/meson/vdec/esparser.c        |    7 +-
 drivers/staging/media/meson/vdec/vdec_helpers.c    |    8 +-
 drivers/staging/media/meson/vdec/vdec_helpers.h    |    4 +-
 drivers/staging/media/meson/vdec/vdec_platform.c   |   12 +
 drivers/staging/media/omap4iss/Kconfig             |    2 +-
 drivers/staging/media/rkvdec/Kconfig               |    2 +-
 drivers/staging/media/sunxi/cedrus/Kconfig         |    2 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c        |    2 +
 drivers/staging/media/sunxi/cedrus/cedrus.h        |    3 +
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c    |    4 +
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c   |    2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c   |    4 +-
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c     |   25 +
 drivers/staging/media/sunxi/cedrus/cedrus_hw.h     |    2 +
 drivers/staging/media/tegra-vde/Kconfig            |   10 -
 drivers/staging/media/tegra-vde/Makefile           |    3 -
 drivers/staging/media/tegra-vde/TODO               |    4 -
 drivers/staging/media/tegra-vde/uapi.h             |   73 -
 drivers/staging/media/tegra-vde/vde.c              | 1358 ---------
 drivers/staging/media/tegra-vde/vde.h              |  125 -
 drivers/staging/media/tegra-video/Kconfig          |    2 +-
 drivers/staging/media/zoran/Kconfig                |   40 +-
 drivers/staging/media/zoran/Makefile               |    8 +-
 drivers/staging/media/zoran/videocodec.c           |   68 +-
 drivers/staging/media/zoran/videocodec.h           |    4 +-
 drivers/staging/media/zoran/zoran.h                |   18 +-
 drivers/staging/media/zoran/zoran_card.c           |  398 ++-
 drivers/staging/media/zoran/zoran_device.c         |   15 +-
 drivers/staging/media/zoran/zoran_device.h         |    2 -
 drivers/staging/media/zoran/zoran_driver.c         |   56 +-
 drivers/staging/media/zoran/zr36016.c              |   25 +-
 drivers/staging/media/zoran/zr36016.h              |    2 +
 drivers/staging/media/zoran/zr36050.c              |   24 +-
 drivers/staging/media/zoran/zr36050.h              |    2 +
 drivers/staging/media/zoran/zr36060.c              |   23 +-
 drivers/staging/media/zoran/zr36060.h              |    2 +
 drivers/staging/most/video/Kconfig                 |    2 +-
 .../staging/vc04_services/bcm2835-camera/Kconfig   |    2 +-
 drivers/usb/gadget/Kconfig                         |    2 +-
 drivers/usb/gadget/legacy/Kconfig                  |    2 +-
 include/media/hevc-ctrls.h                         |    6 +-
 include/media/i2c/m5mols.h                         |    4 -
 include/media/i2c/noon010pc30.h                    |    4 -
 include/media/media-entity.h                       |   25 +-
 include/media/mipi-csi2.h                          |   45 +
 include/media/rc-core.h                            |   12 +-
 include/media/v4l2-fwnode.h                        |   61 +-
 include/media/v4l2-mediabus.h                      |  104 +-
 include/media/v4l2-subdev.h                        |   13 -
 include/soc/mediatek/smi.h                         |   20 -
 include/uapi/linux/lirc.h                          |   16 +-
 include/uapi/linux/omap3isp.h                      |   21 +-
 include/uapi/linux/v4l2-controls.h                 |    8 +
 include/uapi/linux/videodev2.h                     |    2 +
 sound/pci/Kconfig                                  |    4 +-
 884 files changed, 34819 insertions(+), 8966 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/amphion,vpu.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/isil,isl799=
87.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec=
-decoder.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec=
-encoder.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec=
-subdev-decoder.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-d=
ecoder.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-d=
ecoder.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-e=
ncoder.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-e=
ncoder.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/mediatek-vcodec=
.txt
 create mode 100644 Documentation/devicetree/bindings/media/microchip,csi2d=
c.yaml
 rename Documentation/devicetree/bindings/media/{nxp,imx7-mipi-csi2.yaml =
=3D> nxp,imx-mipi-csi2.yaml} (98%)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,sm8250-cam=
ss.yaml
 create mode 100644 drivers/media/i2c/hi847.c
 create mode 100644 drivers/media/i2c/isl7998x.c
 create mode 100644 drivers/media/i2c/og01a1b.c
 create mode 100644 drivers/media/i2c/ov08d10.c
 create mode 100644 drivers/media/platform/allegro-dvt/Kconfig
 create mode 100644 drivers/media/platform/amlogic/Kconfig
 create mode 100644 drivers/media/platform/amlogic/Makefile
 create mode 100644 drivers/media/platform/amlogic/meson-ge2d/Kconfig
 rename drivers/media/platform/{meson/ge2d =3D> amlogic/meson-ge2d}/Makefil=
e (100%)
 rename drivers/media/platform/{meson/ge2d =3D> amlogic/meson-ge2d}/ge2d-re=
gs.h (100%)
 rename drivers/media/platform/{meson/ge2d =3D> amlogic/meson-ge2d}/ge2d.c =
(98%)
 create mode 100644 drivers/media/platform/amphion/Kconfig
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
 create mode 100644 drivers/media/platform/aspeed/Kconfig
 create mode 100644 drivers/media/platform/aspeed/Makefile
 rename drivers/media/platform/{ =3D> aspeed}/aspeed-video.c (84%)
 create mode 100644 drivers/media/platform/atmel/atmel-isc-clk.c
 create mode 100644 drivers/media/platform/atmel/microchip-csi2dc.c
 create mode 100644 drivers/media/platform/chips-media/Kconfig
 rename drivers/media/platform/{coda =3D> chips-media}/Makefile (100%)
 rename drivers/media/platform/{coda =3D> chips-media}/coda-bit.c (100%)
 rename drivers/media/platform/{coda =3D> chips-media}/coda-common.c (99%)
 rename drivers/media/platform/{coda =3D> chips-media}/coda-gdi.c (100%)
 rename drivers/media/platform/{coda =3D> chips-media}/coda-h264.c (100%)
 rename drivers/media/platform/{coda =3D> chips-media}/coda-jpeg.c (100%)
 rename drivers/media/platform/{coda =3D> chips-media}/coda-mpeg2.c (100%)
 rename drivers/media/platform/{coda =3D> chips-media}/coda-mpeg4.c (100%)
 rename drivers/media/platform/{coda =3D> chips-media}/coda.h (100%)
 rename drivers/media/platform/{coda =3D> chips-media}/coda_regs.h (99%)
 rename drivers/media/platform/{coda =3D> chips-media}/imx-vdoa.c (97%)
 rename drivers/media/platform/{coda =3D> chips-media}/imx-vdoa.h (100%)
 rename drivers/media/platform/{coda =3D> chips-media}/trace.h (98%)
 create mode 100644 drivers/media/platform/intel/Kconfig
 create mode 100644 drivers/media/platform/intel/Makefile
 rename drivers/media/platform/{ =3D> intel}/pxa_camera.c (99%)
 rename drivers/media/platform/{marvell-ccic =3D> marvell}/Kconfig (83%)
 rename drivers/media/platform/{marvell-ccic =3D> marvell}/Makefile (100%)
 rename drivers/media/platform/{marvell-ccic =3D> marvell}/cafe-driver.c (1=
00%)
 rename drivers/media/platform/{marvell-ccic =3D> marvell}/mcam-core.c (100=
%)
 rename drivers/media/platform/{marvell-ccic =3D> marvell}/mcam-core.h (100=
%)
 rename drivers/media/platform/{marvell-ccic =3D> marvell}/mmp-driver.c (98=
%)
 create mode 100644 drivers/media/platform/mediatek/Kconfig
 create mode 100644 drivers/media/platform/mediatek/Makefile
 create mode 100644 drivers/media/platform/mediatek/jpeg/Kconfig
 rename drivers/media/platform/{mtk-jpeg =3D> mediatek/jpeg}/Makefile (100%)
 rename drivers/media/platform/{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_core.=
c (97%)
 rename drivers/media/platform/{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_core.=
h (99%)
 rename drivers/media/platform/{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_dec_h=
w.c (100%)
 rename drivers/media/platform/{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_dec_h=
w.h (100%)
 rename drivers/media/platform/{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_dec_p=
arse.c (100%)
 rename drivers/media/platform/{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_dec_p=
arse.h (100%)
 rename drivers/media/platform/{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_dec_r=
eg.h (100%)
 rename drivers/media/platform/{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_enc_h=
w.c (100%)
 rename drivers/media/platform/{mtk-jpeg =3D> mediatek/jpeg}/mtk_jpeg_enc_h=
w.h (100%)
 create mode 100644 drivers/media/platform/mediatek/mdp/Kconfig
 rename drivers/media/platform/{mtk-mdp =3D> mediatek/mdp}/Makefile (78%)
 rename drivers/media/platform/{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_comp.c (=
62%)
 rename drivers/media/platform/{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_comp.h (=
94%)
 rename drivers/media/platform/{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_core.c (=
98%)
 rename drivers/media/platform/{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_core.h (=
100%)
 rename drivers/media/platform/{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_ipi.h (1=
00%)
 rename drivers/media/platform/{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_m2m.c (1=
00%)
 rename drivers/media/platform/{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_m2m.h (1=
00%)
 rename drivers/media/platform/{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_regs.c (=
100%)
 rename drivers/media/platform/{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_regs.h (=
100%)
 rename drivers/media/platform/{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_vpu.c (1=
00%)
 rename drivers/media/platform/{mtk-mdp =3D> mediatek/mdp}/mtk_mdp_vpu.h (1=
00%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/Kconfig
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/Makefile (=
86%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_dec.c (99%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_dec.h (97%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_dec_drv.c (73%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_h=
w.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_h=
w.h
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_p=
m.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_p=
m.h
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_dec_stateful.c (99%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_dec_stateless.c (92%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_drv.h (86%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_enc.c (99%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_enc.h (100%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_enc_drv.c (96%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_enc_pm.c (64%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_enc_pm.h (76%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_fw.c (100%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_fw.h (97%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_fw_priv.h (100%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_fw_scp.c (100%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_fw_vpu.c (98%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_intr.h (69%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_util.c (61%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/mtk_vcodec=
_util.h (87%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/vdec/vdec_=
h264_if.c (99%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/vdec/vdec_=
h264_req_if.c (99%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/vdec/vdec_=
vp8_if.c (99%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/vdec/vdec_=
vp9_if.c (99%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/vdec_drv_b=
ase.h (100%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/vdec_drv_i=
f.c (79%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/vdec_drv_i=
f.h (100%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/vdec_ipi_m=
sg.h (89%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/vdec_vpu_i=
f.c (81%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/vdec_vpu_i=
f.h (76%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/venc/venc_=
h264_if.c (99%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/venc/venc_=
vp8_if.c (99%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/venc_drv_b=
ase.h (100%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/venc_drv_i=
f.c (100%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/venc_drv_i=
f.h (100%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/venc_ipi_m=
sg.h (100%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/venc_vpu_i=
f.c (100%)
 rename drivers/media/platform/{mtk-vcodec =3D> mediatek/vcodec}/venc_vpu_i=
f.h (100%)
 create mode 100644 drivers/media/platform/mediatek/vpu/Kconfig
 rename drivers/media/platform/{mtk-vpu =3D> mediatek/vpu}/Makefile (100%)
 rename drivers/media/platform/{mtk-vpu =3D> mediatek/vpu}/mtk_vpu.c (99%)
 rename drivers/media/platform/{mtk-vpu =3D> mediatek/vpu}/mtk_vpu.h (100%)
 delete mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
 delete mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h
 delete mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
 create mode 100644 drivers/media/platform/nvidia/Kconfig
 create mode 100644 drivers/media/platform/nvidia/Makefile
 create mode 100644 drivers/media/platform/nvidia/tegra-vde/Kconfig
 create mode 100644 drivers/media/platform/nvidia/tegra-vde/Makefile
 rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vde/dmabuf=
-cache.c (99%)
 create mode 100644 drivers/media/platform/nvidia/tegra-vde/h264.c
 rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vde/iommu.=
c (98%)
 rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vde/trace.=
h (97%)
 create mode 100644 drivers/media/platform/nvidia/tegra-vde/v4l2.c
 create mode 100644 drivers/media/platform/nvidia/tegra-vde/vde.c
 create mode 100644 drivers/media/platform/nvidia/tegra-vde/vde.h
 create mode 100644 drivers/media/platform/nxp/Kconfig
 create mode 100644 drivers/media/platform/nxp/Makefile
 rename drivers/media/platform/{ =3D> nxp}/fsl-viu.c (99%)
 rename drivers/media/platform/{ =3D> nxp}/imx-jpeg/Kconfig (85%)
 rename drivers/media/platform/{ =3D> nxp}/imx-jpeg/Makefile (100%)
 rename drivers/media/platform/{ =3D> nxp}/imx-jpeg/mxc-jpeg-hw.c (100%)
 rename drivers/media/platform/{ =3D> nxp}/imx-jpeg/mxc-jpeg-hw.h (100%)
 rename drivers/media/platform/{ =3D> nxp}/imx-jpeg/mxc-jpeg.c (97%)
 rename drivers/media/platform/{ =3D> nxp}/imx-jpeg/mxc-jpeg.h (99%)
 rename drivers/{staging/media/imx/imx7-mipi-csis.c =3D> media/platform/nxp=
/imx-mipi-csis.c} (91%)
 rename drivers/media/platform/{ =3D> nxp}/imx-pxp.c (100%)
 rename drivers/media/platform/{ =3D> nxp}/imx-pxp.h (100%)
 rename drivers/media/platform/{ =3D> nxp}/mx2_emmaprp.c (100%)
 create mode 100644 drivers/media/platform/qcom/Kconfig
 create mode 100644 drivers/media/platform/qcom/Makefile
 create mode 100644 drivers/media/platform/qcom/camss/Kconfig
 rename drivers/media/platform/qcom/camss/{camss-csid-170.c =3D> camss-csid=
-gen2.c} (95%)
 create mode 100644 drivers/media/platform/qcom/camss/camss-vfe-480.c
 create mode 100644 drivers/media/platform/qcom/venus/Kconfig
 create mode 100644 drivers/media/platform/renesas/Kconfig
 create mode 100644 drivers/media/platform/renesas/Makefile
 rename drivers/media/platform/{ =3D> renesas}/rcar-fcp.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/rcar-isp.c (95%)
 rename drivers/media/platform/{ =3D> renesas}/rcar-vin/Kconfig (87%)
 rename drivers/media/platform/{ =3D> renesas}/rcar-vin/Makefile (100%)
 rename drivers/media/platform/{ =3D> renesas}/rcar-vin/rcar-core.c (68%)
 rename drivers/media/platform/{ =3D> renesas}/rcar-vin/rcar-csi2.c (93%)
 rename drivers/media/platform/{ =3D> renesas}/rcar-vin/rcar-dma.c (99%)
 rename drivers/media/platform/{ =3D> renesas}/rcar-vin/rcar-v4l2.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/rcar-vin/rcar-vin.h (92%)
 rename drivers/media/platform/{ =3D> renesas}/rcar_drif.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/rcar_fdp1.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/rcar_jpu.c (99%)
 rename drivers/media/platform/{ =3D> renesas}/renesas-ceu.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/sh_vou.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/Makefile (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_brx.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_brx.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_clu.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_clu.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_dl.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_dl.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_drm.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_drm.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_drv.c (96%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_entity.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_entity.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_hgo.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_hgo.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_hgt.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_hgt.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_histo.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_histo.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_hsit.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_hsit.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_lif.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_lif.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_lut.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_lut.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_pipe.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_pipe.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_regs.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_rpf.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_rwpf.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_rwpf.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_sru.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_sru.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_uds.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_uds.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_uif.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_uif.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_video.c (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_video.h (100%)
 rename drivers/media/platform/{ =3D> renesas}/vsp1/vsp1_wpf.c (100%)
 create mode 100644 drivers/media/platform/rockchip/Kconfig
 create mode 100644 drivers/media/platform/rockchip/Makefile
 create mode 100644 drivers/media/platform/rockchip/rga/Kconfig
 create mode 100644 drivers/media/platform/rockchip/rkisp1/Kconfig
 create mode 100644 drivers/media/platform/samsung/Kconfig
 create mode 100644 drivers/media/platform/samsung/Makefile
 create mode 100644 drivers/media/platform/samsung/exynos-gsc/Kconfig
 rename drivers/media/platform/{ =3D> samsung}/exynos-gsc/Makefile (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos-gsc/gsc-core.c (99%)
 rename drivers/media/platform/{ =3D> samsung}/exynos-gsc/gsc-core.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos-gsc/gsc-m2m.c (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos-gsc/gsc-regs.c (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos-gsc/gsc-regs.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/Kconfig (96%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/Makefile (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/common.c (92%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/common.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-capture.c (1=
00%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-core.c (99%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-core.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is-command.h=
 (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is-errno.c (=
100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is-errno.h (=
100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is-i2c.c (10=
0%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is-i2c.h (10=
0%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is-param.c (=
100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is-param.h (=
100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is-regs.c (1=
00%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is-regs.h (1=
00%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is-sensor.c =
(100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is-sensor.h =
(100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is.c (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-is.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-isp-video.c =
(100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-isp-video.h =
(100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-isp.c (99%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-isp.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-lite-reg.c (=
100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-lite-reg.h (=
100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-lite.c (99%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-lite.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-m2m.c (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-reg.c (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/fimc-reg.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/media-dev.c (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/media-dev.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/mipi-csis.c (100%)
 rename drivers/media/platform/{ =3D> samsung}/exynos4-is/mipi-csis.h (100%)
 create mode 100644 drivers/media/platform/samsung/s3c-camif/Kconfig
 rename drivers/media/platform/{ =3D> samsung}/s3c-camif/Makefile (100%)
 rename drivers/media/platform/{ =3D> samsung}/s3c-camif/camif-capture.c (1=
00%)
 rename drivers/media/platform/{ =3D> samsung}/s3c-camif/camif-core.c (100%)
 rename drivers/media/platform/{ =3D> samsung}/s3c-camif/camif-core.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/s3c-camif/camif-regs.c (100%)
 rename drivers/media/platform/{ =3D> samsung}/s3c-camif/camif-regs.h (100%)
 create mode 100644 drivers/media/platform/samsung/s5p-g2d/Kconfig
 rename drivers/media/platform/{ =3D> samsung}/s5p-g2d/Makefile (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d-hw.c (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d-regs.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d.c (99%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d.h (100%)
 create mode 100644 drivers/media/platform/samsung/s5p-jpeg/Kconfig
 rename drivers/media/platform/{ =3D> samsung}/s5p-jpeg/Makefile (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-jpeg/jpeg-core.c (99%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-jpeg/jpeg-core.h (99%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-jpeg/jpeg-hw-exynos3250.=
c (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-jpeg/jpeg-hw-exynos3250.=
h (97%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-jpeg/jpeg-hw-exynos4.c (=
100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-jpeg/jpeg-hw-exynos4.h (=
100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-jpeg/jpeg-hw-s5p.c (99%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-jpeg/jpeg-hw-s5p.h (97%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-jpeg/jpeg-regs.h (99%)
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/Kconfig
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/Makefile (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/regs-mfc-v10.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/regs-mfc-v6.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/regs-mfc-v7.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/regs-mfc-v8.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/regs-mfc.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc.c (99%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_cmd.c (89%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_cmd.h (92%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_cmd_v5.c (98=
%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_cmd_v5.h (82=
%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_cmd_v6.c (98=
%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_cmd_v6.h (82=
%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_common.h (99=
%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_ctrl.c (99%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_ctrl.h (92%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_debug.h (95%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_dec.c (97%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_dec.h (90%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_enc.c (99%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_enc.h (90%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_intr.c (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_intr.h (100%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_iommu.h (100=
%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_opr.c (98%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_opr.h (99%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_opr_v5.c (10=
0%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_opr_v5.h (10=
0%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_opr_v6.c (99=
%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_opr_v6.h (96=
%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_pm.c (97%)
 rename drivers/media/platform/{ =3D> samsung}/s5p-mfc/s5p_mfc_pm.h (87%)
 create mode 100644 drivers/media/platform/st/Kconfig
 create mode 100644 drivers/media/platform/st/Makefile
 create mode 100644 drivers/media/platform/st/sti/Kconfig
 create mode 100644 drivers/media/platform/st/sti/Makefile
 create mode 100644 drivers/media/platform/st/sti/bdisp/Kconfig
 rename drivers/media/platform/{ =3D> st}/sti/bdisp/Makefile (100%)
 rename drivers/media/platform/{ =3D> st}/sti/bdisp/bdisp-debug.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/bdisp/bdisp-filter.h (100%)
 rename drivers/media/platform/{ =3D> st}/sti/bdisp/bdisp-hw.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/bdisp/bdisp-reg.h (100%)
 rename drivers/media/platform/{ =3D> st}/sti/bdisp/bdisp-v4l2.c (99%)
 rename drivers/media/platform/{ =3D> st}/sti/bdisp/bdisp.h (100%)
 rename drivers/media/platform/{ =3D> st}/sti/c8sectpfe/Kconfig (96%)
 rename drivers/media/platform/{ =3D> st}/sti/c8sectpfe/Makefile (100%)
 rename drivers/media/platform/{ =3D> st}/sti/c8sectpfe/c8sectpfe-common.c =
(100%)
 rename drivers/media/platform/{ =3D> st}/sti/c8sectpfe/c8sectpfe-common.h =
(100%)
 rename drivers/media/platform/{ =3D> st}/sti/c8sectpfe/c8sectpfe-core.c (1=
00%)
 rename drivers/media/platform/{ =3D> st}/sti/c8sectpfe/c8sectpfe-core.h (1=
00%)
 rename drivers/media/platform/{ =3D> st}/sti/c8sectpfe/c8sectpfe-debugfs.c=
 (100%)
 rename drivers/media/platform/{ =3D> st}/sti/c8sectpfe/c8sectpfe-debugfs.h=
 (100%)
 rename drivers/media/platform/{ =3D> st}/sti/c8sectpfe/c8sectpfe-dvb.c (10=
0%)
 rename drivers/media/platform/{ =3D> st}/sti/c8sectpfe/c8sectpfe-dvb.h (10=
0%)
 create mode 100644 drivers/media/platform/st/sti/delta/Kconfig
 rename drivers/media/platform/{ =3D> st}/sti/delta/Makefile (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta-cfg.h (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta-debug.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta-debug.h (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta-ipc.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta-ipc.h (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta-mem.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta-mem.h (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta-mjpeg-dec.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta-mjpeg-fw.h (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta-mjpeg-hdr.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta-mjpeg.h (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta-v4l2.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/delta/delta.h (100%)
 create mode 100644 drivers/media/platform/st/sti/hva/Kconfig
 rename drivers/media/platform/{ =3D> st}/sti/hva/Makefile (100%)
 rename drivers/media/platform/{ =3D> st}/sti/hva/hva-debugfs.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/hva/hva-h264.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/hva/hva-hw.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/hva/hva-hw.h (100%)
 rename drivers/media/platform/{ =3D> st}/sti/hva/hva-mem.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/hva/hva-mem.h (100%)
 rename drivers/media/platform/{ =3D> st}/sti/hva/hva-v4l2.c (100%)
 rename drivers/media/platform/{ =3D> st}/sti/hva/hva.h (100%)
 create mode 100644 drivers/media/platform/st/stm32/Kconfig
 rename drivers/media/platform/{ =3D> st}/stm32/Makefile (100%)
 rename drivers/media/platform/{ =3D> st}/stm32/dma2d/dma2d-hw.c (100%)
 rename drivers/media/platform/{ =3D> st}/stm32/dma2d/dma2d-regs.h (100%)
 rename drivers/media/platform/{ =3D> st}/stm32/dma2d/dma2d.c (99%)
 rename drivers/media/platform/{ =3D> st}/stm32/dma2d/dma2d.h (100%)
 rename drivers/media/platform/{ =3D> st}/stm32/stm32-dcmi.c (97%)
 create mode 100644 drivers/media/platform/sunxi/sun8i-di/Kconfig
 create mode 100644 drivers/media/platform/sunxi/sun8i-rotate/Kconfig
 create mode 100644 drivers/media/platform/ti/Kconfig
 create mode 100644 drivers/media/platform/ti/Makefile
 rename drivers/media/platform/{ =3D> ti}/am437x/Kconfig (88%)
 rename drivers/media/platform/{ =3D> ti}/am437x/Makefile (100%)
 rename drivers/media/platform/{ =3D> ti}/am437x/am437x-vpfe.c (100%)
 rename drivers/media/platform/{ =3D> ti}/am437x/am437x-vpfe.h (100%)
 rename drivers/media/platform/{ =3D> ti}/am437x/am437x-vpfe_regs.h (100%)
 create mode 100644 drivers/media/platform/ti/cal/Makefile
 rename drivers/media/platform/{ti-vpe =3D> ti/cal}/cal-camerarx.c (99%)
 rename drivers/media/platform/{ti-vpe =3D> ti/cal}/cal-video.c (99%)
 rename drivers/media/platform/{ti-vpe =3D> ti/cal}/cal.c (100%)
 rename drivers/media/platform/{ti-vpe =3D> ti/cal}/cal.h (100%)
 rename drivers/media/platform/{ti-vpe =3D> ti/cal}/cal_regs.h (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/Kconfig (90%)
 rename drivers/media/platform/{ =3D> ti}/davinci/Makefile (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/ccdc_hw_device.h (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/dm355_ccdc.c (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/dm355_ccdc_regs.h (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/dm644x_ccdc.c (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/dm644x_ccdc_regs.h (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/isif.c (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/isif_regs.h (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpbe.c (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpbe_display.c (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpbe_osd.c (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpbe_osd_regs.h (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpbe_venc.c (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpbe_venc_regs.h (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpfe_capture.c (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpif.c (84%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpif.h (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpif_capture.c (99%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpif_capture.h (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpif_display.c (99%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpif_display.h (100%)
 rename drivers/media/platform/{ =3D> ti}/davinci/vpss.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap/Kconfig (89%)
 rename drivers/media/platform/{ =3D> ti}/omap/Makefile (100%)
 rename drivers/media/platform/{ =3D> ti}/omap/omap_vout.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap/omap_vout_vrfb.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap/omap_vout_vrfb.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap/omap_voutdef.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap/omap_voutlib.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap/omap_voutlib.h (100%)
 create mode 100644 drivers/media/platform/ti/omap3isp/Kconfig
 rename drivers/media/platform/{ =3D> ti}/omap3isp/Makefile (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/cfa_coef_table.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/gamma_table.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/isp.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/isp.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispccdc.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispccdc.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispccp2.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispccp2.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispcsi2.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispcsi2.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispcsiphy.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispcsiphy.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/isph3a.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/isph3a_aewb.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/isph3a_af.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/isphist.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/isphist.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/isppreview.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/isppreview.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispreg.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispresizer.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispresizer.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispstat.c (99%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispstat.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispvideo.c (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/ispvideo.h (100%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/luma_enhance_table.h (10=
0%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/noise_filter_table.h (10=
0%)
 rename drivers/media/platform/{ =3D> ti}/omap3isp/omap3isp.h (100%)
 rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/Makefile (78%)
 rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/csc.c (100%)
 rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/csc.h (100%)
 rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/sc.c (100%)
 rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/sc.h (100%)
 rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/sc_coeff.h (100%)
 rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpdma.c (100%)
 rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpdma.h (100%)
 rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpdma_priv.h (100%)
 rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpe.c (100%)
 rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpe_regs.h (100%)
 create mode 100644 drivers/media/platform/via/Kconfig
 create mode 100644 drivers/media/platform/via/Makefile
 rename drivers/media/platform/{ =3D> via}/via-camera.c (100%)
 rename drivers/media/platform/{ =3D> via}/via-camera.h (100%)
 rename drivers/media/tuners/{tuner-xc2028-types.h =3D> xc2028-types.h} (96=
%)
 rename drivers/media/tuners/{tuner-xc2028.c =3D> xc2028.c} (99%)
 rename drivers/media/tuners/{tuner-xc2028.h =3D> xc2028.h} (99%)
 delete mode 100644 drivers/staging/media/tegra-vde/Kconfig
 delete mode 100644 drivers/staging/media/tegra-vde/Makefile
 delete mode 100644 drivers/staging/media/tegra-vde/TODO
 delete mode 100644 drivers/staging/media/tegra-vde/uapi.h
 delete mode 100644 drivers/staging/media/tegra-vde/vde.c
 delete mode 100644 drivers/staging/media/tegra-vde/vde.h
 create mode 100644 include/media/mipi-csi2.h

