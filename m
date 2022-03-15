Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE34DA097
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350336AbiCOQ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346711AbiCOQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:57:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F97574B2;
        Tue, 15 Mar 2022 09:56:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hw13so40844606ejc.9;
        Tue, 15 Mar 2022 09:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c0Q22kpGLVZq/R4WLU6kl2JzaO/emU6B5qw6iFxTTnk=;
        b=nkppdkb4w3W3RmuSkaW7X7X834GwEP8BcqYaHW6IbiaIjIOLtdoFISOpGh+UFyvkpK
         rgvHTlRpftx+n5OtJipmyqcyI0fg+M5Nd3qz0npsXTH3lhrIMJImrzY/3ikee2oHNrE0
         HZzrwOlsLlsVbRGwZQNC5VmbFWAaRAvEVPpfo7UWIJ1bk+5SM6E4qOaT9HfIlQ08acfS
         90bxgjQ01adADEFBdG8HugC6qkGlZ+djyyUsUNV43bCtdWnTgfuuuedwt1kij5s2y7eQ
         UiEbkb3bTbv2rIMVrhCXNb4TyftlwOwojvrueDvj4fgi82Rtfn0a6u8wa81DnP0hE1nG
         GzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c0Q22kpGLVZq/R4WLU6kl2JzaO/emU6B5qw6iFxTTnk=;
        b=GQzxrBEuOpYMgNdy4duNZnczBXBTaFU46xiYEN4g47oRI02MJHQX4Y4JfcWr0xDdLO
         fNC/vNNKEUxhixAmNM8d5EEq82FargRrYSj8JtEeK3N2kMOaEvpataiPUNkNxFwZpuH8
         YBqNe3FoMqqNtfm8OOz5tAwcvxyXlmvaPka3C3/DSTybVm/qDbgv/s0xozqEr7edKhTg
         GcFI4vmg32Zm1Rd51JwL+wF6y9ZBwg4OwTFsWDmIsQiMboDeYfglVAIhaZiqfVRfQ/Nq
         w0z4unmFMZdEKYPlhWDjj0k6MUq5/16v1SX4NPbBoMjl8TBD8I3YevCllyi9gIvblUyq
         iA+A==
X-Gm-Message-State: AOAM532vX/C/ZOnzqCMEzqnuRYrsIIZsuhoeyuwkuwP5Y08LPbv5FS0T
        luxt+GbGK4mzQ+sv74K4oKU=
X-Google-Smtp-Source: ABdhPJwKxr5OccFB7rrLAlG9vuFY6y4EcCrPoPUEU4VBoGHbde2eqW38JFpRTIzyeXetqTfwmHmJpg==
X-Received: by 2002:a17:906:c211:b0:6ce:e221:4c21 with SMTP id d17-20020a170906c21100b006cee2214c21mr23819148ejz.691.1647363384322;
        Tue, 15 Mar 2022 09:56:24 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640210ce00b00413211746d4sm9813056edu.51.2022.03.15.09.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 09:56:23 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 37/67] media: platform: Kconfig: sort entries
Date:   Tue, 15 Mar 2022 17:56:22 +0100
Message-ID: <3163040.44csPzL39Z@kista>
In-Reply-To: <76c0f364de11dc6a9a27f2d294145f261b7d0e61.1647274406.git.mchehab@kernel.org>
References: <cover.1647274406.git.mchehab@kernel.org> <76c0f364de11dc6a9a27f2d294145f261b7d0e61.1647274406.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 14. marec 2022 ob 17:34:32 CET je Mauro Carvalho Chehab 
napisal(a):
> Now that each non-generic driver has their own directory,
> sort the entries.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---

For sunxi:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
> To avoid mailbombing on a large number of people, only mailing lists were C/
C on the cover.
> See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.
1647274406.git.mchehab@kernel.org/
> 
>  drivers/media/platform/Kconfig | 98 +++++++++++++++-------------------
>  1 file changed, 43 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index d5aedc6b5ca3..b7c60969c974 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -29,84 +29,72 @@ config V4L_MEM2MEM_DRIVERS
>  	  to capture and output drivers, which use memory buffers for just
>  	  one of those.
>  
> +# Ancillary drivers
> +
> +config VIDEO_MEM2MEM_DEINTERLACE
> +	tristate "Deinterlace support"
> +	depends on V4L_MEM2MEM_DRIVERS
> +	depends on VIDEO_DEV && VIDEO_V4L2
> +	depends on HAS_DMA
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_MEM2MEM_DEV
> +	help
> +	    Generic deinterlacing V4L2 driver.
> +
> +config VIDEO_MUX
> +	tristate "Video Multiplexer"
> +	depends on V4L_PLATFORM_DRIVERS
> +	select MULTIPLEXER
> +	depends on VIDEO_V4L2 && OF
> +	select MEDIA_CONTROLLER
> +	select VIDEO_V4L2_SUBDEV_API
> +	select REGMAP
> +	select V4L2_FWNODE
> +	help
> +	  This driver provides support for N:1 video bus multiplexers.
> +
> +# Platform drivers - Please keep it alphabetically sorted
> +
> +# TODO: create per-manufacturer directories
> +
>  source "drivers/media/platform/allegro-dvt/Kconfig"
> -source "drivers/media/platform/nxp/Kconfig"
> -
> -source "drivers/media/platform/renesas/Kconfig"
> -
> -# V4L platform drivers
> -
> -source "drivers/media/platform/marvell-ccic/Kconfig"
> -
> -source "drivers/media/platform/via/Kconfig"
> -
> +source "drivers/media/platform/am437x/Kconfig"
>  source "drivers/media/platform/amphion/Kconfig"
> +source "drivers/media/platform/aspeed/Kconfig"
> +source "drivers/media/platform/atmel/Kconfig"
>  source "drivers/media/platform/cadence/Kconfig"
> -
>  source "drivers/media/platform/coda/Kconfig"
>  source "drivers/media/platform/davinci/Kconfig"
> -
>  source "drivers/media/platform/exynos-gsc/Kconfig"
> +source "drivers/media/platform/exynos4-is/Kconfig"
> +source "drivers/media/platform/intel/Kconfig"
> +source "drivers/media/platform/marvell-ccic/Kconfig"
>  source "drivers/media/platform/meson/ge2d/Kconfig"
>  source "drivers/media/platform/mtk-jpeg/Kconfig"
>  source "drivers/media/platform/mtk-mdp/Kconfig"
>  source "drivers/media/platform/mtk-vcodec/Kconfig"
>  source "drivers/media/platform/mtk-vpu/Kconfig"
> -source "drivers/media/platform/omap3isp/Kconfig"
> +source "drivers/media/platform/nxp/Kconfig"
>  source "drivers/media/platform/omap/Kconfig"
> +source "drivers/media/platform/omap3isp/Kconfig"
>  source "drivers/media/platform/qcom/camss/Kconfig"
>  source "drivers/media/platform/qcom/venus/Kconfig"
> -
> -source "drivers/media/platform/aspeed/Kconfig"
> +source "drivers/media/platform/renesas/Kconfig"
>  source "drivers/media/platform/rockchip/rga/Kconfig"
>  source "drivers/media/platform/rockchip/rkisp1/Kconfig"
>  source "drivers/media/platform/s3c-camif/Kconfig"
>  source "drivers/media/platform/s5p-g2d/Kconfig"
>  source "drivers/media/platform/s5p-jpeg/Kconfig"
> +source "drivers/media/platform/s5p-mfc/Kconfig"
> +source "drivers/media/platform/sti/bdisp/Kconfig"
> +source "drivers/media/platform/sti/c8sectpfe/Kconfig"
> +source "drivers/media/platform/sti/delta/Kconfig"
>  source "drivers/media/platform/sti/hva/Kconfig"
>  source "drivers/media/platform/stm32/Kconfig"
> +source "drivers/media/platform/sunxi/Kconfig"
>  source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
>  source "drivers/media/platform/sunxi/sun8i-rotate/Kconfig"
>  source "drivers/media/platform/tegra/vde/Kconfig"
>  source "drivers/media/platform/ti-vpe/Kconfig"
> -
> -config VIDEO_MUX
> -	tristate "Video Multiplexer"
> -	depends on V4L_PLATFORM_DRIVERS
> -	select MULTIPLEXER
> -	depends on VIDEO_V4L2 && OF
> -	select MEDIA_CONTROLLER
> -	select VIDEO_V4L2_SUBDEV_API
> -	select REGMAP
> -	select V4L2_FWNODE
> -	help
> -	  This driver provides support for N:1 video bus multiplexers.
> -
> -source "drivers/media/platform/intel/Kconfig"
> -
> -source "drivers/media/platform/exynos4-is/Kconfig"
> -source "drivers/media/platform/am437x/Kconfig"
> +source "drivers/media/platform/via/Kconfig"
>  source "drivers/media/platform/xilinx/Kconfig"
> -source "drivers/media/platform/atmel/Kconfig"
> -source "drivers/media/platform/sunxi/Kconfig"
> -
> -# Mem2mem drivers
> -
> -config VIDEO_MEM2MEM_DEINTERLACE
> -	tristate "Deinterlace support"
> -	depends on V4L_MEM2MEM_DRIVERS
> -	depends on VIDEO_DEV && VIDEO_V4L2
> -	depends on HAS_DMA
> -	select VIDEOBUF2_DMA_CONTIG
> -	select V4L2_MEM2MEM_DEV
> -	help
> -	    Generic deinterlacing V4L2 driver.
> -
> -source "drivers/media/platform/s5p-mfc/Kconfig"
> -
> -source "drivers/media/platform/sti/bdisp/Kconfig"
> -
> -source "drivers/media/platform/sti/delta/Kconfig"
> -
> -# DVB platform drivers
> -source "drivers/media/platform/sti/c8sectpfe/Kconfig"
> -- 
> 2.35.1
> 
> 


