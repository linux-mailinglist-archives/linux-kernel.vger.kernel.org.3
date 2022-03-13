Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4424D7515
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 12:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiCMMAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 08:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiCMMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 08:00:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1651D25E88;
        Sun, 13 Mar 2022 04:59:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C062C492;
        Sun, 13 Mar 2022 12:59:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647172761;
        bh=2KHd2mtefEmvKWJtyswFnBPxpf8PGYWwKivi8REA7VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5+2f3qYyNhsh21BGuAPQGSxoecJTUCJk94W9DXtfWsOw00Kc1GM0oL3isbgklIKQ
         CDWWQ8knRJepBSoDBwdpKkxe8IqfPKwaET5JbC/22rGpc37fpIXX/NrpYXVDCs6wwE
         q1G08QnFez/16rZ4PwJ+Fv7hdFXmQBa/6L8+pZd4=
Date:   Sun, 13 Mar 2022 13:59:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] media: Kconfig: cleanup VIDEO_DEV dependencies
Message-ID: <Yi3ciCTbHrxYUatX@pendragon.ideasonboard.com>
References: <42ae3d28d4d822f3e14db76b99f2f4c41688ae3e.1647155467.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42ae3d28d4d822f3e14db76b99f2f4c41688ae3e.1647155467.git.mchehab@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Thank you for the patch.

Trimming the CC list to keep a few mailing lists only.

On Sun, Mar 13, 2022 at 08:12:05AM +0100, Mauro Carvalho Chehab wrote:
> media Kconfig has two entries associated to V4L API:
> VIDEO_DEV and VIDEO_V4L2.
> 
> On Kernel 2.6.x, there were two V4L APIs, each one with its own flag.
> VIDEO_DEV were meant to:
> 	1) enable Video4Linux and make its Kconfig options to appear;
> 	2) it makes the Kernel build the V4L core.
> 
> while VIDEO_V4L2 where used to distinguish between drivers that
> implement the newer API and drivers that implemented the former one.
> 
> With time, such meaning changed, specially after the removal of
> all V4L version 1 drivers.
> 
> At the current implementation, VIDEO_DEV only does (1): it enables
> the media options related to V4L, that now has:
> 
> 	menu "Video4Linux options"
> 		visible if VIDEO_DEV
> 
> 	source "drivers/media/v4l2-core/Kconfig"
> 	endmenu
> 
> but it doesn't affect anymore the V4L core drivers.
> 
> The rationale is that the V4L2 core has a "soft" dependency
> at the I2C bus, and now requires to select a number of other
> Kconfig options:
> 
> 	config VIDEO_V4L2
> 		tristate
> 		depends on (I2C || I2C=n) && VIDEO_DEV
> 		select RATIONAL
> 		select VIDEOBUF2_V4L2 if VIDEOBUF2_CORE
> 		default (I2C || I2C=n) && VIDEO_DEV
> 
> In the past, merging them would be tricky, but it seems that it is now
> possible to merge those symbols, in order to simplify V4L dependencies.
> 
> Let's keep VIDEO_DEV, as this one is used on some make *defconfig
> configurations.

I would have gone for VIDEO_V4L2, but if it makes configuration changes
easier to handle, VIDEO_DEV is fine with me too.

> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  drivers/input/rmi4/Kconfig                    |   2 +-
>  drivers/input/touchscreen/Kconfig             |   4 +-
>  drivers/media/Kconfig                         |   3 +
>  drivers/media/common/saa7146/Kconfig          |   2 +-
>  drivers/media/dvb-core/Kconfig                |   2 +-
>  drivers/media/dvb-frontends/Kconfig           |   4 +-
>  drivers/media/i2c/Kconfig                     | 250 +++++++++---------
>  drivers/media/i2c/ccs/Kconfig                 |   2 +-
>  drivers/media/i2c/cx25840/Kconfig             |   2 +-
>  drivers/media/i2c/et8ek8/Kconfig              |   2 +-
>  drivers/media/i2c/m5mols/Kconfig              |   2 +-
>  drivers/media/pci/Kconfig                     |   2 +-
>  drivers/media/pci/bt8xx/Kconfig               |   2 +-
>  drivers/media/pci/cobalt/Kconfig              |   2 +-
>  drivers/media/pci/cx18/Kconfig                |   2 +-
>  drivers/media/pci/dt3155/Kconfig              |   2 +-
>  drivers/media/pci/intel/ipu3/Kconfig          |   2 +-
>  drivers/media/pci/ivtv/Kconfig                |   2 +-
>  drivers/media/pci/meye/Kconfig                |   2 +-
>  drivers/media/pci/saa7146/Kconfig             |   6 +-
>  drivers/media/pci/sta2x11/Kconfig             |   2 +-
>  drivers/media/pci/tw5864/Kconfig              |   2 +-
>  drivers/media/pci/tw68/Kconfig                |   2 +-
>  drivers/media/pci/tw686x/Kconfig              |   2 +-
>  drivers/media/platform/Kconfig                |   6 +-
>  drivers/media/platform/allegro-dvt/Kconfig    |   2 +-
>  drivers/media/platform/am437x/Kconfig         |   2 +-
>  drivers/media/platform/amphion/Kconfig        |   2 +-
>  drivers/media/platform/aspeed/Kconfig         |   2 +-
>  drivers/media/platform/atmel/Kconfig          |   8 +-
>  drivers/media/platform/cadence/Kconfig        |   4 +-
>  drivers/media/platform/coda/Kconfig           |   2 +-
>  drivers/media/platform/davinci/Kconfig        |  12 +-
>  drivers/media/platform/exynos-gsc/Kconfig     |   2 +-
>  drivers/media/platform/exynos4-is/Kconfig     |   2 +-
>  drivers/media/platform/intel/Kconfig          |   2 +-
>  drivers/media/platform/marvell-ccic/Kconfig   |   4 +-
>  drivers/media/platform/meson/ge2d/Kconfig     |   2 +-
>  drivers/media/platform/mtk-jpeg/Kconfig       |   2 +-
>  drivers/media/platform/mtk-mdp/Kconfig        |   2 +-
>  drivers/media/platform/mtk-vcodec/Kconfig     |   2 +-
>  drivers/media/platform/mtk-vpu/Kconfig        |   2 +-
>  drivers/media/platform/nxp/Kconfig            |   8 +-
>  drivers/media/platform/nxp/imx-jpeg/Kconfig   |   2 +-
>  drivers/media/platform/omap/Kconfig           |   2 +-
>  drivers/media/platform/omap3isp/Kconfig       |   2 +-
>  drivers/media/platform/qcom/camss/Kconfig     |   2 +-
>  drivers/media/platform/qcom/venus/Kconfig     |   2 +-
>  drivers/media/platform/renesas/Kconfig        |  12 +-
>  .../media/platform/renesas/rcar-vin/Kconfig   |   4 +-
>  drivers/media/platform/rockchip/rga/Kconfig   |   2 +-
>  .../media/platform/rockchip/rkisp1/Kconfig    |   2 +-
>  drivers/media/platform/s3c-camif/Kconfig      |   2 +-
>  drivers/media/platform/s5p-g2d/Kconfig        |   2 +-
>  drivers/media/platform/s5p-jpeg/Kconfig       |   2 +-
>  drivers/media/platform/s5p-mfc/Kconfig        |   2 +-
>  drivers/media/platform/sti/bdisp/Kconfig      |   2 +-
>  drivers/media/platform/sti/delta/Kconfig      |   2 +-
>  drivers/media/platform/sti/hva/Kconfig        |   2 +-
>  drivers/media/platform/stm32/Kconfig          |   4 +-
>  .../media/platform/sunxi/sun4i-csi/Kconfig    |   2 +-
>  .../media/platform/sunxi/sun6i-csi/Kconfig    |   2 +-
>  drivers/media/platform/sunxi/sun8i-di/Kconfig |   2 +-
>  .../media/platform/sunxi/sun8i-rotate/Kconfig |   2 +-
>  drivers/media/platform/tegra/vde/Kconfig      |   2 +-
>  drivers/media/platform/ti-vpe/Kconfig         |   4 +-
>  drivers/media/platform/via/Kconfig            |   2 +-
>  drivers/media/platform/xilinx/Kconfig         |   2 +-
>  drivers/media/radio/Kconfig                   |  54 ++--
>  drivers/media/radio/si470x/Kconfig            |   2 +-
>  drivers/media/radio/wl128x/Kconfig            |   2 +-
>  drivers/media/spi/Kconfig                     |   4 +-
>  drivers/media/test-drivers/Kconfig            |   2 +-
>  drivers/media/test-drivers/vicodec/Kconfig    |   2 +-
>  drivers/media/test-drivers/vimc/Kconfig       |   2 +-
>  drivers/media/test-drivers/vivid/Kconfig      |   2 +-
>  drivers/media/tuners/Kconfig                  |   6 +-
>  drivers/media/tuners/e4000.c                  |   6 +-
>  drivers/media/tuners/fc2580.c                 |   6 +-
>  drivers/media/usb/airspy/Kconfig              |   2 +-
>  drivers/media/usb/au0828/Kconfig              |   6 +-
>  drivers/media/usb/cpia2/Kconfig               |   2 +-
>  drivers/media/usb/dvb-usb-v2/Kconfig          |   8 +-
>  drivers/media/usb/dvb-usb/Kconfig             |   4 +-
>  drivers/media/usb/gspca/Kconfig               |  96 +++----
>  drivers/media/usb/gspca/gl860/Kconfig         |   2 +-
>  drivers/media/usb/gspca/m5602/Kconfig         |   2 +-
>  drivers/media/usb/hackrf/Kconfig              |   2 +-
>  drivers/media/usb/hdpvr/Kconfig               |   2 +-
>  drivers/media/usb/msi2500/Kconfig             |   2 +-
>  drivers/media/usb/pvrusb2/Kconfig             |   2 +-
>  drivers/media/usb/pwc/Kconfig                 |   2 +-
>  drivers/media/usb/s2255/Kconfig               |   2 +-
>  drivers/media/usb/stkwebcam/Kconfig           |   2 +-
>  drivers/media/usb/usbtv/Kconfig               |   2 +-
>  drivers/media/usb/uvc/Kconfig                 |   2 +-
>  drivers/media/usb/zr364xx/Kconfig             |   2 +-
>  drivers/media/v4l2-core/Kconfig               |  12 +-
>  drivers/media/v4l2-core/Makefile              |   2 +-
>  drivers/staging/media/atomisp/Kconfig         |   2 +-
>  drivers/staging/media/atomisp/i2c/Kconfig     |  14 +-
>  drivers/staging/media/hantro/Kconfig          |   2 +-
>  drivers/staging/media/imx/Kconfig             |   2 +-
>  drivers/staging/media/ipu3/Kconfig            |   2 +-
>  drivers/staging/media/max96712/Kconfig        |   2 +-
>  drivers/staging/media/meson/vdec/Kconfig      |   2 +-
>  drivers/staging/media/omap4iss/Kconfig        |   2 +-
>  drivers/staging/media/rkvdec/Kconfig          |   2 +-
>  drivers/staging/media/sunxi/cedrus/Kconfig    |   2 +-
>  drivers/staging/media/tegra-video/Kconfig     |   2 +-
>  drivers/staging/media/zoran/Kconfig           |   2 +-
>  drivers/staging/most/video/Kconfig            |   2 +-
>  .../vc04_services/bcm2835-camera/Kconfig      |   2 +-
>  drivers/usb/gadget/Kconfig                    |   2 +-
>  drivers/usb/gadget/legacy/Kconfig             |   2 +-
>  sound/pci/Kconfig                             |   4 +-
>  116 files changed, 363 insertions(+), 368 deletions(-)

[snip]

> diff --git a/drivers/media/pci/tw5864/Kconfig b/drivers/media/pci/tw5864/Kconfig
> index d376d4ed65b9..0a0f3191f238 100644
> --- a/drivers/media/pci/tw5864/Kconfig
> +++ b/drivers/media/pci/tw5864/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config VIDEO_TW5864
>  	tristate "Techwell TW5864 video/audio grabber and encoder"
> -	depends on VIDEO_DEV && PCI && VIDEO_V4L2
> +	depends on VIDEO_DEV && PCI && VIDEO_DEV

You can drop the second VIDEO_DEV.

>  	select VIDEOBUF2_DMA_CONTIG
>  	help
>  	  Support for boards based on Techwell TW5864 chip which provides
> diff --git a/drivers/media/pci/tw68/Kconfig b/drivers/media/pci/tw68/Kconfig
> index af0cb60337bb..ef29be7db493 100644
> --- a/drivers/media/pci/tw68/Kconfig
> +++ b/drivers/media/pci/tw68/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config VIDEO_TW68
>  	tristate "Techwell tw68x Video For Linux"
> -	depends on VIDEO_DEV && PCI && VIDEO_V4L2
> +	depends on VIDEO_DEV && PCI && VIDEO_DEV

Here too.

Apart from that, the patch looks good to me.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I have however not evaluated the impact it will have on make oldconfig.

>  	select VIDEOBUF2_DMA_SG
>  	help
>  	  Support for Techwell tw68xx based frame grabber boards.

[snip]

-- 
Regards,

Laurent Pinchart
