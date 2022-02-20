Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC1E4BCDEA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243877AbiBTKJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 05:09:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiBTKJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:09:30 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02DE45AEE;
        Sun, 20 Feb 2022 02:09:06 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B19BD25B;
        Sun, 20 Feb 2022 11:09:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1645351745;
        bh=A906u2pGDzIuV7ecNtTPSVbGE8HtzZhpSaGJK3h6hvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2KfLmP8B+BiF2YyLsDX/UUaZ4aZiyNg07gy8hZ/+aBfoAZ+CjkGrk8sG3wAIrJT8
         ARn5EBNXErdivB/FSt1519HRH/y2cF7mk6IP9wC5ZVu60nmlIDemurZxcn2Qu7Syif
         soqTlWv91UriztYwqN0s08HrYw1ziBCvV9nE2vKk=
Date:   Sun, 20 Feb 2022 12:08:55 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v5 04/11] media: bcm2835-unicam: Add support for
 CCP2/CSI2 camera interface
Message-ID: <YhITN2aa81v1ThM3@pendragon.ideasonboard.com>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-5-jeanmichel.hautbois@ideasonboard.com>
 <af385681-ab49-fd63-52a3-38f9521c8d20@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af385681-ab49-fd63-52a3-38f9521c8d20@i2se.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Feb 20, 2022 at 11:01:26AM +0100, Stefan Wahren wrote:
> Am 08.02.22 um 16:50 schrieb Jean-Michel Hautbois:
> > Add driver for the Unicam camera receiver block on BCM283x processors.
> > It is represented as two video device nodes: unicam-image and
> > unicam-embedded which are connected to an internal subdev (named
> > unicam-subdev) in order to manage streams routing.
> >
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> >
> > ---
> > v4:
> >   - Add the vendor prefox for DT name
> >   - Use the reg-names in DT parsing
> >   - Remove MAINTAINERS entry
> >
> > v3 main changes:
> >   - Change code organization
> >   - Remove unused variables
> >   - Correct the fmt_meta functions
> >   - Rewrite the start/stop streaming
> >     - You can now start the image node alone, but not the metadata one
> >     - The buffers are allocated per-node
> >     - only the required stream is started, if the route exists and is
> >       enabled
> >   - Prefix the macros with UNICAM_ to not have too generic names
> >   - Drop colorspace support
> >     -> This is causing issues in the try-fmt v4l2-compliance test
> >   test VIDIOC_G_FMT: OK
> > 	fail: v4l2-test-formats.cpp(363): colorspace >= 0xff
> > 	fail: v4l2-test-formats.cpp(465): testColorspace(!node->is_io_mc, pix.pixelformat, pix.colorspace, pix.ycbcr_enc, pix.quantization)
> >   test VIDIOC_TRY_FMT: FAIL
> > 	fail: v4l2-test-formats.cpp(363): colorspace >= 0xff
> > 	fail: v4l2-test-formats.cpp(465): testColorspace(!node->is_io_mc, pix.pixelformat, pix.colorspace, pix.ycbcr_enc, pix.quantization)
> >   test VIDIOC_S_FMT: FAIL
> >
> > v2: Remove the unicam_{info,debug,error} macros and use
> > dev_dbg/dev_err instead.
> > ---
> >  drivers/media/platform/Kconfig                |    1 +
> >  drivers/media/platform/Makefile               |    2 +
> >  drivers/media/platform/bcm2835/Kconfig        |   21 +
> >  drivers/media/platform/bcm2835/Makefile       |    3 +
> >  .../platform/bcm2835/bcm2835-unicam-regs.h    |  253 ++
> >  .../media/platform/bcm2835/bcm2835-unicam.c   | 2570 +++++++++++++++++
> >  6 files changed, 2850 insertions(+)
> >  create mode 100644 drivers/media/platform/bcm2835/Kconfig
> >  create mode 100644 drivers/media/platform/bcm2835/Makefile
> >  create mode 100644 drivers/media/platform/bcm2835/bcm2835-unicam-regs.h
> >  create mode 100644 drivers/media/platform/bcm2835/bcm2835-unicam.c
> >
> > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> > index 9fbdba0fd1e7..033b0358fbb8 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -170,6 +170,7 @@ source "drivers/media/platform/am437x/Kconfig"
> >  source "drivers/media/platform/xilinx/Kconfig"
> >  source "drivers/media/platform/rcar-vin/Kconfig"
> >  source "drivers/media/platform/atmel/Kconfig"
> > +source "drivers/media/platform/bcm2835/Kconfig"
> >  source "drivers/media/platform/sunxi/Kconfig"
> >  
> >  config VIDEO_TI_CAL
> > diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> > index 28eb4aadbf45..18894fc586aa 100644
> > --- a/drivers/media/platform/Makefile
> > +++ b/drivers/media/platform/Makefile
> > @@ -86,6 +86,8 @@ obj-$(CONFIG_VIDEO_QCOM_CAMSS)		+= qcom/camss/
> >  
> >  obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
> >  
> > +obj-$(CONFIG_VIDEO_BCM2835_UNICAM)	+= bcm2835/
> > +
> >  obj-y					+= sunxi/
> >  
> >  obj-$(CONFIG_VIDEO_MESON_GE2D)		+= meson/ge2d/
> > diff --git a/drivers/media/platform/bcm2835/Kconfig b/drivers/media/platform/bcm2835/Kconfig
> > new file mode 100644
> > index 000000000000..1691541da905
> > --- /dev/null
> > +++ b/drivers/media/platform/bcm2835/Kconfig
> > @@ -0,0 +1,21 @@
> > +# Broadcom VideoCore4 V4L2 camera support
> > +
> > +config VIDEO_BCM2835_UNICAM
> > +	tristate "Broadcom BCM283x/BCM271x Unicam video capture driver"
> > +	depends on ARCH_BCM2835 || COMPILE_TEST
> > +	depends on VIDEO_V4L2
> > +	select MEDIA_CONTROLLER
> > +	select VIDEO_V4L2_SUBDEV_API
> > +	select V4L2_FWNODE
> > +	select VIDEOBUF2_DMA_CONTIG
> > +	help
> > +	  Say Y here to enable support for the BCM283x/BCM271x CSI-2 receiver.
> > +	  This is a V4L2 driver that controls the CSI-2 receiver directly,
> > +	  independently from the VC4 firmware.
> > +	  This driver is mutually exclusive with the use of bcm2835-camera. The
> > +	  firmware will disable all access to the peripheral from within the
> > +	  firmware if it finds a DT node using it, and bcm2835-camera will
> > +	  therefore fail to probe.
> > +
> > +	  To compile this driver as a module, choose M here. The module will be
> > +	  called bcm2835-unicam.
> > diff --git a/drivers/media/platform/bcm2835/Makefile b/drivers/media/platform/bcm2835/Makefile
> > new file mode 100644
> > index 000000000000..a98aba03598a
> > --- /dev/null
> > +++ b/drivers/media/platform/bcm2835/Makefile
> > @@ -0,0 +1,3 @@
> > +# Makefile for BCM2835 Unicam driver
> > +
> > +obj-$(CONFIG_VIDEO_BCM2835_UNICAM) += bcm2835-unicam.o
> > diff --git a/drivers/media/platform/bcm2835/bcm2835-unicam-regs.h b/drivers/media/platform/bcm2835/bcm2835-unicam-regs.h
> > new file mode 100644
> > index 000000000000..b8d297076a02
> > --- /dev/null
> > +++ b/drivers/media/platform/bcm2835/bcm2835-unicam-regs.h
> > @@ -0,0 +1,253 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +/*
> > + * Copyright (C) 2017-2020 Raspberry Pi Trading.
> > + * Dave Stevenson <dave.stevenson@raspberrypi.com>
> > + */
> > +
> > +#ifndef VC4_REGS_UNICAM_H
> > +#define VC4_REGS_UNICAM_H
> > +
> > +/*
> > + * The following values are taken from files found within the code drop
> > + * made by Broadcom for the BCM21553 Graphics Driver, predominantly in
> > + * brcm_usrlib/dag/vmcsx/vcinclude/hardware_vc4.h.
> > + * They have been modified to be only the register offset.
> > + */
> > +#define UNICAM_CTRL		0x000
> > +#define UNICAM_STA		0x004
> > +#define UNICAM_ANA		0x008
> > +#define UNICAM_PRI		0x00c
> > +#define UNICAM_CLK		0x010
> > +#define UNICAM_CLT		0x014
> > +#define UNICAM_DAT0		0x018
> > +#define UNICAM_DAT1		0x01c
> > +#define UNICAM_DAT2		0x020
> > +#define UNICAM_DAT3		0x024
> > +#define UNICAM_DLT		0x028
> > +#define UNICAM_CMP0		0x02c
> > +#define UNICAM_CMP1		0x030
> > +#define UNICAM_CAP0		0x034
> > +#define UNICAM_CAP1		0x038
> > +#define UNICAM_ICTL		0x100
> > +#define UNICAM_ISTA		0x104
> > +#define UNICAM_IDI0		0x108
> > +#define UNICAM_IPIPE		0x10c
> > +#define UNICAM_IBSA0		0x110
> > +#define UNICAM_IBEA0		0x114
> > +#define UNICAM_IBLS		0x118
> > +#define UNICAM_IBWP		0x11c
> > +#define UNICAM_IHWIN		0x120
> > +#define UNICAM_IHSTA		0x124
> > +#define UNICAM_IVWIN		0x128
> > +#define UNICAM_IVSTA		0x12c
> > +#define UNICAM_ICC		0x130
> > +#define UNICAM_ICS		0x134
> > +#define UNICAM_IDC		0x138
> > +#define UNICAM_IDPO		0x13c
> > +#define UNICAM_IDCA		0x140
> > +#define UNICAM_IDCD		0x144
> > +#define UNICAM_IDS		0x148
> > +#define UNICAM_DCS		0x200
> > +#define UNICAM_DBSA0		0x204
> > +#define UNICAM_DBEA0		0x208
> > +#define UNICAM_DBWP		0x20c
> > +#define UNICAM_DBCTL		0x300
> > +#define UNICAM_IBSA1		0x304
> > +#define UNICAM_IBEA1		0x308
> > +#define UNICAM_IDI1		0x30c
> > +#define UNICAM_DBSA1		0x310
> > +#define UNICAM_DBEA1		0x314
> > +#define UNICAM_MISC		0x400
> > +
> > +/*
> > + * The following bitmasks are from the kernel released by Broadcom
> > + * for Android - https://android.googlesource.com/kernel/bcm/
> > + * The Rhea, Hawaii, and Java chips all contain the same VideoCore4
> > + * Unicam block as BCM2835, as defined in eg
> > + * arch/arm/mach-rhea/include/mach/rdb_A0/brcm_rdb_cam.h and similar.
> > + * Values reworked to use the kernel BIT and GENMASK macros.
> > + *
> > + * Some of the bit mnenomics have been amended to match the datasheet.
> > + */
> > +/* UNICAM_CTRL Register */
> > +#define UNICAM_CPE		BIT(0)
> > +#define UNICAM_MEM		BIT(1)
> > +#define UNICAM_CPR		BIT(2)
> > +#define UNICAM_CPM_MASK		GENMASK(3, 3)
> > +#define UNICAM_CPM_CSI2		0
> > +#define UNICAM_CPM_CCP2		1
> > +#define UNICAM_SOE		BIT(4)
> > +#define UNICAM_DCM_MASK		GENMASK(5, 5)
> > +#define UNICAM_DCM_STROBE	0
> > +#define UNICAM_DCM_DATA		1
> > +#define UNICAM_SLS		BIT(6)
> > +#define UNICAM_PFT_MASK		GENMASK(11, 8)
> > +#define UNICAM_OET_MASK		GENMASK(20, 12)
> > +
> > +/* UNICAM_STA Register */
> > +#define UNICAM_SYN		BIT(0)
> > +#define UNICAM_CS		BIT(1)
> > +#define UNICAM_SBE		BIT(2)
> > +#define UNICAM_PBE		BIT(3)
> > +#define UNICAM_HOE		BIT(4)
> > +#define UNICAM_PLE		BIT(5)
> > +#define UNICAM_SSC		BIT(6)
> > +#define UNICAM_CRCE		BIT(7)
> > +#define UNICAM_OES		BIT(8)
> > +#define UNICAM_IFO		BIT(9)
> > +#define UNICAM_OFO		BIT(10)
> > +#define UNICAM_BFO		BIT(11)
> > +#define UNICAM_DL		BIT(12)
> > +#define UNICAM_PS		BIT(13)
> > +#define UNICAM_IS		BIT(14)
> > +#define UNICAM_PI0		BIT(15)
> > +#define UNICAM_PI1		BIT(16)
> > +#define UNICAM_FSI_S		BIT(17)
> > +#define UNICAM_FEI_S		BIT(18)
> > +#define UNICAM_LCI_S		BIT(19)
> > +#define UNICAM_BUF0_RDY		BIT(20)
> > +#define UNICAM_BUF0_NO		BIT(21)
> > +#define UNICAM_BUF1_RDY		BIT(22)
> > +#define UNICAM_BUF1_NO		BIT(23)
> > +#define UNICAM_DI		BIT(24)
> > +
> > +#define UNICAM_STA_MASK_ALL \
> > +		(UNICAM_DL | \
> > +		UNICAM_SBE | \
> > +		UNICAM_PBE | \
> > +		UNICAM_HOE | \
> > +		UNICAM_PLE | \
> > +		UNICAM_SSC | \
> > +		UNICAM_CRCE | \
> > +		UNICAM_IFO | \
> > +		UNICAM_OFO | \
> > +		UNICAM_PS | \
> > +		UNICAM_PI0 | \
> > +		UNICAM_PI1)
> > +
> > +/* UNICAM_ANA Register */
> > +#define UNICAM_APD		BIT(0)
> > +#define UNICAM_BPD		BIT(1)
> > +#define UNICAM_AR		BIT(2)
> > +#define UNICAM_DDL		BIT(3)
> > +#define UNICAM_CTATADJ_MASK	GENMASK(7, 4)
> > +#define UNICAM_PTATADJ_MASK	GENMASK(11, 8)
> > +
> > +/* UNICAM_PRI Register */
> > +#define UNICAM_PE		BIT(0)
> > +#define UNICAM_PT_MASK		GENMASK(2, 1)
> > +#define UNICAM_NP_MASK		GENMASK(7, 4)
> > +#define UNICAM_PP_MASK		GENMASK(11, 8)
> > +#define UNICAM_BS_MASK		GENMASK(15, 12)
> > +#define UNICAM_BL_MASK		GENMASK(17, 16)
> > +
> > +/* UNICAM_CLK Register */
> > +#define UNICAM_CLE		BIT(0)
> > +#define UNICAM_CLPD		BIT(1)
> > +#define UNICAM_CLLPE		BIT(2)
> > +#define UNICAM_CLHSE		BIT(3)
> > +#define UNICAM_CLTRE		BIT(4)
> > +#define UNICAM_CLAC_MASK	GENMASK(8, 5)
> > +#define UNICAM_CLSTE		BIT(29)
> > +
> > +/* UNICAM_CLT Register */
> > +#define UNICAM_CLT1_MASK	GENMASK(7, 0)
> > +#define UNICAM_CLT2_MASK	GENMASK(15, 8)
> > +
> > +/* UNICAM_DATn Registers */
> > +#define UNICAM_DLE		BIT(0)
> > +#define UNICAM_DLPD		BIT(1)
> > +#define UNICAM_DLLPE		BIT(2)
> > +#define UNICAM_DLHSE		BIT(3)
> > +#define UNICAM_DLTRE		BIT(4)
> > +#define UNICAM_DLSM		BIT(5)
> > +#define UNICAM_DLFO		BIT(28)
> > +#define UNICAM_DLSTE		BIT(29)
> > +
> > +#define UNICAM_DAT_MASK_ALL	(UNICAM_DLSTE | UNICAM_DLFO)
> > +
> > +/* UNICAM_DLT Register */
> > +#define UNICAM_DLT1_MASK	GENMASK(7, 0)
> > +#define UNICAM_DLT2_MASK	GENMASK(15, 8)
> > +#define UNICAM_DLT3_MASK	GENMASK(23, 16)
> > +
> > +/* UNICAM_ICTL Register */
> > +#define UNICAM_FSIE		BIT(0)
> > +#define UNICAM_FEIE		BIT(1)
> > +#define UNICAM_IBOB		BIT(2)
> > +#define UNICAM_FCM		BIT(3)
> > +#define UNICAM_TFC		BIT(4)
> > +#define UNICAM_LIP_MASK		GENMASK(6, 5)
> > +#define UNICAM_LCIE_MASK	GENMASK(28, 16)
> > +
> > +/* UNICAM_IDI0/1 Register */
> > +#define UNICAM_ID0_MASK		GENMASK(7, 0)
> > +#define UNICAM_ID1_MASK		GENMASK(15, 8)
> > +#define UNICAM_ID2_MASK		GENMASK(23, 16)
> > +#define UNICAM_ID3_MASK		GENMASK(31, 24)
> > +
> > +/* UNICAM_ISTA Register */
> > +#define UNICAM_FSI		BIT(0)
> > +#define UNICAM_FEI		BIT(1)
> > +#define UNICAM_LCI		BIT(2)
> > +
> > +#define UNICAM_ISTA_MASK_ALL	(UNICAM_FSI | UNICAM_FEI | UNICAM_LCI)
> > +
> > +/* UNICAM_IPIPE Register */
> > +#define UNICAM_PUM_MASK		GENMASK(2, 0)
> > +/* Unpacking modes */
> > +#define UNICAM_PUM_NONE		0
> > +#define UNICAM_PUM_UNPACK6	1
> > +#define UNICAM_PUM_UNPACK7	2
> > +#define UNICAM_PUM_UNPACK8	3
> > +#define UNICAM_PUM_UNPACK10	4
> > +#define UNICAM_PUM_UNPACK12	5
> > +#define UNICAM_PUM_UNPACK14	6
> > +#define UNICAM_PUM_UNPACK16	7
> > +#define UNICAM_DDM_MASK		GENMASK(6, 3)
> > +#define UNICAM_PPM_MASK		GENMASK(9, 7)
> > +/* Packing modes */
> > +#define UNICAM_PPM_NONE		0
> > +#define UNICAM_PPM_PACK8	1
> > +#define UNICAM_PPM_PACK10	2
> > +#define UNICAM_PPM_PACK12	3
> > +#define UNICAM_PPM_PACK14	4
> > +#define UNICAM_PPM_PACK16	5
> > +#define UNICAM_DEM_MASK		GENMASK(11, 10)
> > +#define UNICAM_DEBL_MASK	GENMASK(14, 12)
> > +#define UNICAM_ICM_MASK		GENMASK(16, 15)
> > +#define UNICAM_IDM_MASK		GENMASK(17, 17)
> > +
> > +/* UNICAM_ICC Register */
> > +#define UNICAM_ICFL_MASK	GENMASK(4, 0)
> > +#define UNICAM_ICFH_MASK	GENMASK(9, 5)
> > +#define UNICAM_ICST_MASK	GENMASK(12, 10)
> > +#define UNICAM_ICLT_MASK	GENMASK(15, 13)
> > +#define UNICAM_ICLL_MASK	GENMASK(31, 16)
> > +
> > +/* UNICAM_DCS Register */
> > +#define UNICAM_DIE		BIT(0)
> > +#define UNICAM_DIM		BIT(1)
> > +#define UNICAM_DBOB		BIT(3)
> > +#define UNICAM_FDE		BIT(4)
> > +#define UNICAM_LDP		BIT(5)
> > +#define UNICAM_EDL_MASK		GENMASK(15, 8)
> > +
> > +/* UNICAM_DBCTL Register */
> > +#define UNICAM_DBEN		BIT(0)
> > +#define UNICAM_BUF0_IE		BIT(1)
> > +#define UNICAM_BUF1_IE		BIT(2)
> > +
> > +/* UNICAM_CMP[0,1] register */
> > +#define UNICAM_PCE		BIT(31)
> > +#define UNICAM_GI		BIT(9)
> > +#define UNICAM_CPH		BIT(8)
> > +#define UNICAM_PCVC_MASK	GENMASK(7, 6)
> > +#define UNICAM_PCDT_MASK	GENMASK(5, 0)
> > +
> > +/* UNICAM_MISC register */
> > +#define UNICAM_FL0		BIT(6)
> > +#define UNICAM_FL1		BIT(9)
> > +
> > +#endif
> > diff --git a/drivers/media/platform/bcm2835/bcm2835-unicam.c b/drivers/media/platform/bcm2835/bcm2835-unicam.c
> > new file mode 100644
> > index 000000000000..470e691637c7
> > --- /dev/null
> > +++ b/drivers/media/platform/bcm2835/bcm2835-unicam.c
> > @@ -0,0 +1,2570 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * BCM283x / BCM271x Unicam Capture Driver
> > + *
> > + * Copyright (C) 2017-2020 - Raspberry Pi (Trading) Ltd.
> > + *
> > + * Dave Stevenson <dave.stevenson@raspberrypi.com>
> > + *
> > + * Based on TI am437x driver by
> > + *   Benoit Parrot <bparrot@ti.com>
> > + *   Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > + *
> > + * and TI CAL camera interface driver by
> > + *    Benoit Parrot <bparrot@ti.com>
> > + *
> > + *
> > + * There are two camera drivers in the kernel for BCM283x - this one
> > + * and bcm2835-camera (currently in staging).
> > + *
> > + * This driver directly controls the Unicam peripheral - there is no
> > + * involvement with the VideoCore firmware. Unicam receives CSI-2 or
> > + * CCP2 data and writes it into SDRAM.
> > + * The only potential processing options are to repack Bayer data into an
> > + * alternate format, and applying windowing.
> > + * The repacking does not shift the data, so can repack V4L2_PIX_FMT_Sxxxx10P
> > + * to V4L2_PIX_FMT_Sxxxx10, or V4L2_PIX_FMT_Sxxxx12P to V4L2_PIX_FMT_Sxxxx12,
> > + * but not generically up to V4L2_PIX_FMT_Sxxxx16. The driver will add both
> > + * formats where the relevant formats are defined, and will automatically
> > + * configure the repacking as required.
> > + * Support for windowing may be added later.
> > + *
> > + * It should be possible to connect this driver to any sensor with a
> > + * suitable output interface and V4L2 subdevice driver.
> > + *
> > + * bcm2835-camera uses the VideoCore firmware to control the sensor,
> > + * Unicam, ISP, and all tuner control loops. Fully processed frames are
> > + * delivered to the driver by the firmware. It only has sensor drivers
> > + * for Omnivision OV5647, and Sony IMX219 sensors.
> > + *
> > + * The two drivers are mutually exclusive for the same Unicam instance.
> > + * The VideoCore firmware checks the device tree configuration during boot.
> > + * If it finds device tree nodes called csi0 or csi1 it will block the
> > + * firmware from accessing the peripheral, and bcm2835-camera will
> > + * not be able to stream data.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/pinctrl/consumer.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/slab.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/videodev2.h>
> > +
> > +#include <media/v4l2-async.h>
> > +#include <media/v4l2-common.h>
> > +#include <media/v4l2-ctrls.h>
> > +#include <media/v4l2-dev.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-dv-timings.h>
> > +#include <media/v4l2-event.h>
> > +#include <media/v4l2-ioctl.h>
> > +#include <media/v4l2-fwnode.h>
> > +#include <media/v4l2-mc.h>
> > +#include <media/videobuf2-dma-contig.h>
> > +
> > +#include "bcm2835-unicam-regs.h"
> > +
> > +#define UNICAM_MODULE_NAME	"unicam"
> > +
> ...
> > +
> > +static int unicam_sd_enable_streams(struct v4l2_subdev *sd, u32 pad,
> > +				    u64 streams_mask)
> > +{
> > +	struct unicam_device *unicam = sd_to_unicam_device(sd);
> > +	struct v4l2_subdev_state *state;
> > +	u32 other_pad, other_stream;
> > +	int ret;
> > +
> > +	if (WARN_ON(streams_mask != 1))
> > +		return -EINVAL;
>
> Can we print some error message additionally to the stacktrace?

I would actually drop this check. The .enable_streams() and
.disable_streams() operations are supposed to be called using new helper
functions that will be included in the v11 of the V4L2 streams series,
the streams mask check should be moved there.

> > +
> > +	state = v4l2_subdev_lock_active_state(sd);
> > +
> > +	ret = v4l2_subdev_routing_find_opposite_end(&state->routing, pad, 0,
> > +						    &other_pad, &other_stream);
> > +
> > +	v4l2_subdev_unlock_state(state);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	unicam->sequence = 0;
> > +
> > +	dev_dbg(unicam->dev, "Running with %u data lanes\n",
> > +		unicam->active_data_lanes);
> > +
> > +	ret = clk_set_min_rate(unicam->vpu_clock, UNICAM_MIN_VPU_CLOCK_RATE);
> > +	if (ret) {
> > +		dev_err(unicam->dev, "failed to set up VPU clock\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = clk_prepare_enable(unicam->vpu_clock);
> > +	if (ret) {
> > +		dev_err(unicam->dev, "Failed to enable VPU clock: %d\n", ret);
> > +		goto err_vpu_clock;
> > +	}
> > +
> > +	ret = clk_set_rate(unicam->clock, 100 * 1000 * 1000);
> > +	if (ret) {
> > +		dev_err(unicam->dev, "failed to set up CSI clock\n");
> > +		goto err_vpu_prepare;
> > +	}
> > +
> > +	ret = clk_prepare_enable(unicam->clock);
> > +	if (ret) {
> > +		dev_err(unicam->dev, "Failed to enable CSI clock: %d\n", ret);
> > +		goto err_vpu_prepare;
> > +	}
> > +
> > +	ret = v4l2_subdev_call(unicam->sensor.subdev, video, enable_streams,
> > +			       unicam->sensor.pad->index, BIT(other_stream));
> > +
> > +	if (ret && ret == -ENOIOCTLCMD)
> > +		ret = v4l2_subdev_call(unicam->sensor.subdev, video, s_stream, 1);
> > +
> > +	if (ret) {
> > +		dev_err(unicam->dev, "stream on failed in subdev\n");
> > +		goto err_enable_stream;
> > +	}
> > +
> > +	unicam->subdev.streaming = true;
> > +
> > +	return 0;
> > +
> > +err_enable_stream:
> > +	clk_disable_unprepare(unicam->clock);
> > +err_vpu_prepare:
> > +	clk_disable_unprepare(unicam->vpu_clock);
> > +err_vpu_clock:
> > +	if (clk_set_min_rate(unicam->vpu_clock, 0))
> > +		dev_err(unicam->dev, "failed to reset the VPU clock\n");
> > +	return ret;
> > +}
> > +
> > +static int unicam_sd_disable_streams(struct v4l2_subdev *sd, u32 pad,
> > +				     u64 streams_mask)
> > +{
> > +	struct unicam_device *unicam = sd_to_unicam_device(sd);
> > +	struct v4l2_subdev_state *state;
> > +	u32 other_pad, other_stream;
> > +	int ret;
> > +
> > +	if (WARN_ON(streams_mask != 1))
> > +		return -EINVAL;
> Can we print some error message additionally to the stacktrace?
> > +
> > +	state = v4l2_subdev_lock_active_state(sd);
> > +
> > +	ret = v4l2_subdev_routing_find_opposite_end(&state->routing, pad, 0,
> > +						    &other_pad, &other_stream);
> > +
> > +	v4l2_subdev_unlock_state(state);
> > +
> > +	if (ret) {
> > +		dev_err(unicam->dev, "disable streams failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = v4l2_subdev_call(unicam->sensor.subdev, video, disable_streams,
> > +			       unicam->sensor.pad->index, BIT(other_stream));
> > +
> > +	if (ret && ret == -ENOIOCTLCMD) {
> > +		/* The sensor does not support disable streams. */
> > +		if (unicam->node[UNICAM_IMAGE_NODE].streaming &&
> > +		    other_pad == unicam->node[UNICAM_METADATA_NODE].pad.index) {
> > +			/* We won't stop the sensor yet. */
> > +			unicam->subdev.streaming = false;
> > +			return 0;
> > +		}
> > +		/* There is no more the metadata node, we can stop. */
> > +		ret = v4l2_subdev_call(unicam->sensor.subdev, video, s_stream, 0);
> > +	}
> > +
> > +	clk_disable_unprepare(unicam->clock);
> > +	if (clk_set_min_rate(unicam->vpu_clock, 0))
> > +		dev_err(unicam->dev, "failed to reset the VPU clock\n");
> > +	clk_disable_unprepare(unicam->vpu_clock);
> > +
> > +	unicam->subdev.streaming = false;
> > +
> > +	return 0;
> > +}
> > +
> > +static int unicam_subdev_set_pad_format(struct v4l2_subdev *sd,
> > +					struct v4l2_subdev_state *state,
> > +					struct v4l2_subdev_format *format)
> > +{
> > +	struct unicam_device *unicam = sd_to_unicam_device(sd);
> > +	struct v4l2_mbus_framefmt *sink_format, *source_format;
> > +	const struct unicam_fmt *fmtinfo;
> > +	int ret = 0;
> > +
> > +	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE && unicam->subdev.streaming)
> > +		return -EBUSY;
> > +
> > +	/* No transcoding, source and sink formats must match. */
> > +	if (unicam_sd_pad_is_source(format->pad))
> > +		return v4l2_subdev_get_fmt(sd, state, format);
> > +
> > +	fmtinfo = unicam_find_format_by_code(format->format.code, format->pad);
> > +	if (!fmtinfo)
> > +		fmtinfo = &unicam_image_formats[0];
> > +
> > +	if (format->pad == UNICAM_SD_PAD_SOURCE_IMAGE) {
> > +		format->format.width = clamp_t(unsigned int,
> > +					       format->format.width,
> > +					       UNICAM_MIN_WIDTH,
> > +					       UNICAM_MAX_WIDTH);
> > +		format->format.height = clamp_t(unsigned int,
> > +						format->format.height,
> > +						UNICAM_MIN_HEIGHT,
> > +						UNICAM_MAX_HEIGHT);
> > +	}
> > +	format->format.field = V4L2_FIELD_NONE;
> > +
> > +	v4l2_subdev_lock_state(state);
> > +
> > +	sink_format = v4l2_state_get_stream_format(state, format->pad,
> > +						   format->stream);
> > +	source_format = v4l2_subdev_state_get_opposite_stream_format(state,
> > +								     format->pad,
> > +								     format->stream);
> > +	if (!sink_format || !source_format) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	*sink_format = format->format;
> > +	*source_format = format->format;
> > +out:
> > +	v4l2_subdev_unlock_state(state);
> > +
> > +	return ret;
> > +}
> > +
> > +static int unicam_subdev_enum_frame_size(struct v4l2_subdev *sd,
> > +					 struct v4l2_subdev_state *state,
> > +					 struct v4l2_subdev_frame_size_enum *fse)
> > +{
> > +	const struct unicam_fmt *fmtinfo;
> > +	u32 pad, stream;
> > +	int ret = -EINVAL;
> > +
> > +	if (fse->index > 0)
> > +		return ret;
> > +
> > +	v4l2_subdev_lock_state(state);
> > +
> > +	ret = v4l2_subdev_routing_find_opposite_end(&state->routing, fse->pad,
> > +						    fse->stream, &pad,
> > +						    &stream);
> > +	if (ret)
> > +		goto out;
> > +
> > +	if (unicam_sd_pad_is_source(fse->pad)) {
> > +		/* No transcoding, source and sink formats must match. */
> > +		struct v4l2_mbus_framefmt *fmt;
> > +
> > +		fmt = v4l2_state_get_stream_format(state, pad, stream);
> > +		if (!fmt)
> > +			goto out;
> > +
> > +		if (fse->code != fmt->code)
> > +			goto out;
> > +
> > +		fse->min_width = fmt->width;
> > +		fse->max_width = fmt->width;
> > +		fse->min_height = fmt->height;
> > +		fse->max_height = fmt->height;
> > +	} else {
> > +		fmtinfo = unicam_find_format_by_code(fse->code, pad);
> > +		if (!fmtinfo)
> > +			goto out;
> > +
> > +		fse->min_width = UNICAM_MIN_WIDTH;
> > +		fse->max_width = UNICAM_MAX_WIDTH;
> > +		fse->min_height = UNICAM_MIN_HEIGHT;
> > +		fse->max_height = UNICAM_MAX_HEIGHT;
> > +	}
> > +
> > +out:
> > +	v4l2_subdev_unlock_state(state);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct v4l2_subdev_video_ops unicam_subdev_video_ops = {
> > +	.enable_streams	= unicam_sd_enable_streams,
> > +	.disable_streams = unicam_sd_disable_streams,
> > +};
> > +
> > +static const struct v4l2_subdev_pad_ops unicam_subdev_pad_ops = {
> > +	.init_cfg		= unicam_subdev_init_cfg,
> > +	.enum_mbus_code		= unicam_subdev_enum_mbus_code,
> > +	.get_fmt		= v4l2_subdev_get_fmt,
> > +	.set_fmt		= unicam_subdev_set_pad_format,
> > +	.set_routing		= unicam_subdev_set_routing,
> > +	.enum_frame_size	= unicam_subdev_enum_frame_size,
> > +};
> > +
> > +static const struct v4l2_subdev_ops unicam_subdev_ops = {
> > +	.video		= &unicam_subdev_video_ops,
> > +	.pad		= &unicam_subdev_pad_ops,
> > +};
> > +
> > +static const struct media_entity_operations unicam_subdev_media_ops = {
> > +	.link_validate = v4l2_subdev_link_validate,
> > +	.has_route = v4l2_subdev_has_route,
> > +};
> > +
> > +static int unicam_init_and_register_subdev(struct unicam_device *unicam)
> > +{
> > +	struct v4l2_subdev *sd = &unicam->subdev.sd;
> > +	int ret;
> > +
> > +	v4l2_subdev_init(sd, &unicam_subdev_ops);
> > +	v4l2_set_subdevdata(sd, unicam);
> > +	unicam->subdev.sd.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
> > +	unicam->subdev.sd.entity.ops = &unicam_subdev_media_ops;
> > +	unicam->subdev.sd.dev = unicam->dev;
> > +	unicam->subdev.sd.owner = THIS_MODULE;
> > +	unicam->subdev.sd.flags = V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_MULTIPLEXED;
> > +	snprintf(unicam->subdev.sd.name, sizeof(unicam->subdev.sd.name), "unicam-subdev");
> > +
> > +	unicam->subdev.pads[UNICAM_SD_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
> > +
> > +	unicam->subdev.pads[UNICAM_SD_PAD_SOURCE_IMAGE].flags = MEDIA_PAD_FL_SOURCE;
> > +	unicam->subdev.pads[UNICAM_SD_PAD_SOURCE_METADATA].flags = MEDIA_PAD_FL_SOURCE;
> > +
> > +	ret = media_entity_pads_init(&sd->entity,
> > +				     ARRAY_SIZE(unicam->subdev.pads), unicam->subdev.pads);
> > +	if (ret) {
> > +		dev_err(unicam->dev, "Could not init media entity");
> > +		return ret;
> > +	}
> > +
> > +	ret = v4l2_subdev_init_finalize(sd);
> > +	if (ret) {
> > +		dev_err(unicam->dev, "Could not finalize init for subdev");
> > +		return ret;
> > +	}
> > +
> > +	return v4l2_device_register_subdev(&unicam->v4l2_dev, sd);
> > +}
> > +
> > +/* -----------------------------------------------------------------------------
> > + * Videobuf2 Queue Operations
> > + */
> > +
> > +static int unicam_queue_setup(struct vb2_queue *vq,
> > +			      unsigned int *nbuffers,
> > +			      unsigned int *nplanes,
> > +			      unsigned int sizes[],
> > +			      struct device *alloc_devs[])
> > +{
> > +	struct unicam_node *node = vb2_get_drv_priv(vq);
> > +	struct unicam_device *unicam = node->dev;
> > +	unsigned int size = is_image_node(node) ?
> > +				node->v_fmt.fmt.pix.sizeimage :
> > +				node->v_fmt.fmt.meta.buffersize;
> > +
> > +	if (vq->num_buffers + *nbuffers < 3)
> > +		*nbuffers = 3 - vq->num_buffers;
> > +
> > +	if (*nplanes) {
> > +		if (sizes[0] < size) {
> > +			dev_dbg(unicam->dev, "sizes[0] %i < size %u\n", sizes[0],
> > +				size);
> > +			return -EINVAL;
> > +		}
> > +		size = sizes[0];
> > +	}
> > +
> > +	*nplanes = 1;
> > +	sizes[0] = size;
> > +
> > +	return 0;
> > +}
> > +
> > +static int unicam_buffer_prepare(struct vb2_buffer *vb)
> > +{
> > +	struct unicam_node *node = vb2_get_drv_priv(vb->vb2_queue);
> > +	struct unicam_device *unicam = node->dev;
> > +	struct unicam_buffer *buf = to_unicam_buffer(vb);
> > +	unsigned long size;
> > +
> > +	if (WARN_ON(!node->fmt))
> > +		return -EINVAL;
> Can we print some error message additionally to the stacktrace?
> > +
> > +	size = is_image_node(node) ? node->v_fmt.fmt.pix.sizeimage :
> > +				     node->v_fmt.fmt.meta.buffersize;
> > +	if (vb2_plane_size(vb, 0) < size) {
> > +		dev_dbg(unicam->dev, "data will not fit into plane (%lu < %lu)\n",
> > +			vb2_plane_size(vb, 0), size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	vb2_set_plane_payload(&buf->vb.vb2_buf, 0, size);
> > +	return 0;
> > +}
> > +
> ...
> > +
> > +static int unicam_connect_of_subdevs(struct unicam_device *unicam)
> > +{
> > +	struct v4l2_fwnode_endpoint ep = { };
> > +	struct fwnode_handle *ep_handle;
> > +	struct v4l2_async_subdev *asd;
> > +	unsigned int lane;
> > +	int ret = -EINVAL;
> > +
> > +	if (of_property_read_u32(unicam->dev->of_node, "brcm,num-data-lanes",
> > +				 &unicam->max_data_lanes) < 0) {
> > +		dev_err(unicam->dev, "DT property %s not set\n",
> > +			"brcm,num-data-lanes");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Get the local endpoint and remote device. */
> > +	ep_handle = fwnode_graph_get_endpoint_by_id(dev_fwnode(unicam->dev),
> > +						    0, 0,
> > +						    FWNODE_GRAPH_ENDPOINT_NEXT);
> > +	if (!ep_handle) {
> > +		dev_err(unicam->dev, "No endpoint\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	/* Parse the local endpoint and validate its configuration. */
> > +	if (v4l2_fwnode_endpoint_alloc_parse(ep_handle, &ep)) {
> > +		dev_err(unicam->dev, "could not parse endpoint\n");
> > +		goto cleanup_exit;
> > +	}
> > +
> > +	dev_dbg(unicam->dev, "parsed local endpoint, bus_type %u\n",
> > +		ep.bus_type);
> > +
> > +	unicam->bus_type = ep.bus_type;
> > +
> > +	switch (ep.bus_type) {
> > +	case V4L2_MBUS_CSI2_DPHY:
> > +		switch (ep.bus.mipi_csi2.num_data_lanes) {
> > +		case 1:
> > +		case 2:
> > +		case 4:
> > +			break;
> > +
> > +		default:
> > +			dev_err(unicam->dev, "%u data lanes not supported\n",
> > +				ep.bus.mipi_csi2.num_data_lanes);
> > +			goto cleanup_exit;
> > +		}
> > +
> > +		for (lane = 0; lane < ep.bus.mipi_csi2.num_data_lanes; lane++) {
> > +			if (ep.bus.mipi_csi2.data_lanes[lane] != lane + 1) {
> > +				dev_err(unicam->dev, "data lanes reordering not supported\n");
> > +				goto cleanup_exit;
> > +			}
> > +		}
> > +
> > +		if (ep.bus.mipi_csi2.num_data_lanes > unicam->max_data_lanes) {
> > +			dev_err(unicam->dev, "endpoint requires %u data lanes when %u are supported\n",
> > +				ep.bus.mipi_csi2.num_data_lanes,
> > +				unicam->max_data_lanes);
> > +		}
> > +
> > +		unicam->active_data_lanes = ep.bus.mipi_csi2.num_data_lanes;
> > +		unicam->bus_flags = ep.bus.mipi_csi2.flags;
> > +
> > +		break;
> > +
> > +	case V4L2_MBUS_CCP2:
> > +		if (ep.bus.mipi_csi1.clock_lane != 0 ||
> > +		    ep.bus.mipi_csi1.data_lane != 1) {
> > +			dev_err(unicam->dev, "unsupported lanes configuration\n");
> > +			goto cleanup_exit;
> > +		}
> > +
> > +		unicam->max_data_lanes = 1;
> > +		unicam->active_data_lanes = 1;
> > +		unicam->bus_flags = ep.bus.mipi_csi1.strobe;
> > +		break;
> > +
> > +	default:
> > +		/* Unsupported bus type */
> > +		dev_err(unicam->dev, "unsupported bus type %u\n",
> > +			ep.bus_type);
> > +		goto cleanup_exit;
> > +	}
> > +
> > +	dev_dbg(unicam->dev, "%s bus, %u data lanes, flags=0x%08x\n",
> > +		unicam->bus_type == V4L2_MBUS_CSI2_DPHY ? "CSI-2" : "CCP2",
> > +		unicam->active_data_lanes, unicam->bus_flags);
> > +
> > +	/* Initialize and register the async notifier. */
> > +	v4l2_async_nf_init(&unicam->notifier);
> > +
> > +	asd = v4l2_async_nf_add_fwnode_remote(&unicam->notifier, ep_handle,
> > +					      struct v4l2_async_subdev);
> > +
> > +	fwnode_handle_put(ep_handle);
> > +	ep_handle = NULL;
> > +
> > +	if (IS_ERR(asd)) {
> please provide a log entry here
> > +		ret = PTR_ERR(asd);
> > +		goto cleanup_exit;
> > +	}
> > +
> > +	unicam->notifier.ops = &unicam_async_ops;
> > +
> > +	ret = v4l2_async_nf_register(&unicam->v4l2_dev, &unicam->notifier);
> > +	if (ret) {
> > +		dev_err(unicam->dev, "Error registering device notifier: %d\n", ret);
> > +		goto cleanup_exit;
> > +	}
> > +
> > +	return 0;
> > +
> > +cleanup_exit:
> > +	v4l2_fwnode_endpoint_free(&ep);
> > +	fwnode_handle_put(ep_handle);
> > +
> > +	return ret;
> > +}
> > +
> > +static int unicam_media_dev_init(struct unicam_device *unicam)
> > +{
> > +	int ret = 0;
> no need to init ret here
> > +
> > +	unicam->mdev.dev = unicam->dev;
> > +	strscpy(unicam->mdev.model, UNICAM_MODULE_NAME,
> > +		sizeof(unicam->mdev.model));
> > +	strscpy(unicam->mdev.serial, "", sizeof(unicam->mdev.serial));
> > +	snprintf(unicam->mdev.bus_info, sizeof(unicam->mdev.bus_info),
> > +		 "platform:%s", dev_name(unicam->dev));
> > +	unicam->mdev.hw_revision = 0;
> > +
> > +	media_device_init(&unicam->mdev);
> > +
> > +	unicam->v4l2_dev.mdev = &unicam->mdev;
> > +
> > +	ret = v4l2_device_register(unicam->dev, &unicam->v4l2_dev);
> > +	if (ret < 0) {
> > +		dev_err(unicam->dev,
> > +			"Unable to register v4l2 device\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = media_device_register(&unicam->mdev);
> > +	if (ret < 0) {
> > +		dev_err(unicam->dev,
> > +			"Unable to register media-controller device\n");
> > +		goto err_v4l2_unregister;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_v4l2_unregister:
> > +	v4l2_device_unregister(&unicam->v4l2_dev);
> > +	return ret;
> > +}
> > +
> > +static int unicam_probe(struct platform_device *pdev)
> > +{
> > +	struct unicam_device *unicam;
> > +	int ret = 0;
> > +
> > +	unicam = kzalloc(sizeof(*unicam), GFP_KERNEL);
> > +	if (!unicam)
> > +		return -ENOMEM;
> > +
> > +	kref_init(&unicam->kref);
> > +	unicam->dev = &pdev->dev;
> > +	/* set the driver data in platform device */
> > +	platform_set_drvdata(pdev, unicam);
> > +
> > +	unicam->base = devm_platform_ioremap_resource_byname(pdev, "unicam");
> > +	if (IS_ERR(unicam->base)) {
> > +		ret = PTR_ERR(unicam->base);
> > +		goto err_unicam_put;
> > +	}
> > +
> > +	unicam->clk_gate_base = devm_platform_ioremap_resource_byname(pdev, "cmi");
> > +	if (IS_ERR(unicam->clk_gate_base)) {
> > +		ret = PTR_ERR(unicam->clk_gate_base);
> > +		goto err_unicam_put;
> > +	}
> > +
> > +	unicam->clock = devm_clk_get(&pdev->dev, "lp");
> > +	if (IS_ERR(unicam->clock)) {
> > +		dev_err(unicam->dev, "Failed to get lp clock\n");
> > +		ret = PTR_ERR(unicam->clock);
> > +		goto err_unicam_put;
> > +	}
> > +
> > +	unicam->vpu_clock = devm_clk_get(&pdev->dev, "vpu");
> > +	if (IS_ERR(unicam->vpu_clock)) {
> > +		dev_err(unicam->dev, "Failed to get vpu clock\n");
> > +		ret = PTR_ERR(unicam->vpu_clock);
> > +		goto err_unicam_put;
> > +	}
> > +
> > +	ret = platform_get_irq(pdev, 0);
> > +	if (ret <= 0) {
> > +		dev_err(&pdev->dev, "No IRQ resource\n");
> > +		ret = -EINVAL;
> > +		goto err_unicam_put;
> > +	}
> > +
> > +	ret = devm_request_irq(&pdev->dev, ret, unicam_isr, 0,
> > +			       "unicam_capture0", unicam);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Unable to request interrupt\n");
> > +		ret = -EINVAL;
> > +		goto err_unicam_put;
> > +	}
> > +
> > +	ret = unicam_media_dev_init(unicam);
> > +	if (ret) {
> > +		dev_err(unicam->dev,
> > +			"Unable to initialize media device\n");
> > +		goto err_unicam_put;
> > +	}
> > +
> > +	ret = unicam_init_and_register_subdev(unicam);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to register internal subdev\n");
> 
> please drop this unnecessary log entry, because the called function
> already provide more helpful log entries.
> 
> Best regards
> 
> > +		goto err_media_unregister;
> > +	}
> > +
> > +	ret = unicam_connect_of_subdevs(unicam);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to connect subdevs\n");
> > +		goto err_subdev_unregister;
> > +	}
> > +
> > +	/* Enable the block power domain */
> > +	pm_runtime_enable(&pdev->dev);
> > +
> > +	return 0;
> > +
> > +err_subdev_unregister:
> > +	v4l2_subdev_cleanup(&unicam->subdev.sd);
> > +err_media_unregister:
> > +	media_device_unregister(&unicam->mdev);
> > +err_unicam_put:
> > +	unicam_put(unicam);
> > +
> > +	return ret;
> > +}
> > +
> > +static int unicam_remove(struct platform_device *pdev)
> > +{
> > +	struct unicam_device *unicam = platform_get_drvdata(pdev);
> > +
> > +	unicam_unregister_nodes(unicam);
> > +	v4l2_device_unregister(&unicam->v4l2_dev);
> > +	media_device_unregister(&unicam->mdev);
> > +	v4l2_async_nf_unregister(&unicam->notifier);
> > +	unicam_put(unicam);
> > +
> > +	pm_runtime_disable(&pdev->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id unicam_of_match[] = {
> > +	{ .compatible = "brcm,bcm2835-unicam", },
> > +	{ /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, unicam_of_match);
> > +
> > +static struct platform_driver unicam_driver = {
> > +	.probe		= unicam_probe,
> > +	.remove		= unicam_remove,
> > +	.driver = {
> > +		.name	= UNICAM_MODULE_NAME,
> > +		.of_match_table = of_match_ptr(unicam_of_match),
> > +	},
> > +};
> > +
> > +module_platform_driver(unicam_driver);
> > +
> > +MODULE_AUTHOR("Dave Stevenson <dave.stevenson@raspberrypi.com>");
> > +MODULE_DESCRIPTION("BCM2835 Unicam driver");
> > +MODULE_LICENSE("GPL");

-- 
Regards,

Laurent Pinchart
