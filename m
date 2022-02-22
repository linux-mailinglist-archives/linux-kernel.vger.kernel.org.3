Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5B44BF34F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiBVIPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBVIPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:15:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B2A151D23;
        Tue, 22 Feb 2022 00:14:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5F83B8189E;
        Tue, 22 Feb 2022 08:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60B6C340E8;
        Tue, 22 Feb 2022 08:14:30 +0000 (UTC)
Message-ID: <621be862-7478-dc70-3f65-db9b95115821@xs4all.nl>
Date:   Tue, 22 Feb 2022 09:14:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v16 03/13] media: amphion: add amphion vpu device driver
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1645422822.git.ming.qian@nxp.com>
 <1ccdc8c9b7d521f3f839bb2c8d269aa299cd0595.1645422822.git.ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <1ccdc8c9b7d521f3f839bb2c8d269aa299cd0595.1645422822.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/22 07:10, Ming Qian wrote:
> The amphion vpu codec ip contains encoder and decoder.
> Windsor is the encoder, it supports to encode H.264.
> Malone is the decoder, it features a powerful
> video processing unit able to decode many formats,
> such as H.264, HEVC, and other formats.
> 
> This Driver is for this IP that is based on the v4l2 mem2mem framework.
> 
> Supported SoCs are: IMX8QXP, IMX8QM
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
> Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  arch/arm64/configs/defconfig               |   1 +
>  drivers/media/platform/Kconfig             |  19 ++
>  drivers/media/platform/Makefile            |   2 +
>  drivers/media/platform/amphion/Makefile    |  20 ++
>  drivers/media/platform/amphion/vpu.h       | 356 +++++++++++++++++++++
>  drivers/media/platform/amphion/vpu_defs.h  | 187 +++++++++++
>  drivers/media/platform/amphion/vpu_drv.c   | 260 +++++++++++++++
>  drivers/media/platform/amphion/vpu_imx8q.c | 271 ++++++++++++++++
>  drivers/media/platform/amphion/vpu_imx8q.h | 115 +++++++
>  9 files changed, 1231 insertions(+)
>  create mode 100644 drivers/media/platform/amphion/Makefile
>  create mode 100644 drivers/media/platform/amphion/vpu.h
>  create mode 100644 drivers/media/platform/amphion/vpu_defs.h
>  create mode 100644 drivers/media/platform/amphion/vpu_drv.c
>  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.c
>  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.h
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 30516dc0b70e..5423075730f8 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -662,6 +662,7 @@ CONFIG_V4L_PLATFORM_DRIVERS=y
>  CONFIG_VIDEO_RCAR_CSI2=m
>  CONFIG_VIDEO_RCAR_VIN=m
>  CONFIG_VIDEO_SUN6I_CSI=m
> +CONFIG_VIDEO_AMPHION_VPU=m
>  CONFIG_V4L_MEM2MEM_DRIVERS=y
>  CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
>  CONFIG_VIDEO_SAMSUNG_S5P_MFC=m

This must be a separate patch! The media subsystem doesn't maintain defconfig.

> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 9fbdba0fd1e7..947ae16c73f5 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -216,6 +216,25 @@ config VIDEO_RCAR_ISP
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rcar-isp.
>  
> +config VIDEO_AMPHION_VPU
> +	tristate "Amphion VPU (Video Processing Unit) Codec IP"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	depends on MEDIA_SUPPORT
> +	depends on VIDEO_DEV
> +	depends on VIDEO_V4L2
> +	select MEDIA_CONTROLLER
> +	select V4L2_MEM2MEM_DEV
> +	select VIDEOBUF2_DMA_CONTIG
> +	select VIDEOBUF2_VMALLOC
> +	help
> +	  Amphion VPU Codec IP contains two parts: Windsor and Malone.
> +	  Windsor is encoder that supports H.264, and Malone is decoder
> +	  that supports H.264, HEVC, and other video formats.
> +	  This is a V4L2 driver for NXP MXC 8Q video accelerator hardware.
> +	  It accelerates encoding and decoding operations on
> +	  various NXP SoCs.
> +	  To compile this driver as a module choose m here.
> +
>  endif # V4L_PLATFORM_DRIVERS
>  
>  menuconfig V4L_MEM2MEM_DRIVERS

This Kconfig entry is in the wrong place: this driver is a mem2mem driver, so
it should be in the following section (V4L_MEM2MEM_DRIVERS).

Regards,

	Hans
