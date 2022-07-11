Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B7B570223
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiGKMdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiGKMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C6254F664
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657542779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLHK6FSsmlTe8rHVUXmJ5oVxeF9IHVMTJ0bSKgy1E9I=;
        b=SeN8MJ5EjfZ+MfPcTkdSrel+Vo/jqYevy4efZchDgw9WGBqA4Jl9dDljfkYsGALBEMuIDj
        5oy58stn6OCl/TqJ/k00TujugwIWQGxMUA3bIe/viYKm8IcGUwwJChPa6Jtp+DiiyXyAi/
        0TWFRCn9O155fpLq9vkrLMq1YQm6EZw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-2D31kNc8NMChpaKtFPgoSg-1; Mon, 11 Jul 2022 08:32:58 -0400
X-MC-Unique: 2D31kNc8NMChpaKtFPgoSg-1
Received: by mail-ej1-f72.google.com with SMTP id s4-20020a170906500400b006feaccb3a0eso1021499ejj.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=VLHK6FSsmlTe8rHVUXmJ5oVxeF9IHVMTJ0bSKgy1E9I=;
        b=I8704yiOcPINb4FV+I4yqBgxcJEERxC5Al+oq6c5uaWXvkVqBKSWwVCO/e4Tdd93Hh
         WA5ppcLOAt0XCO7MJ7vqfNhhFs2HtC1451n/A26EOE5eg7U8W8IOlJXjUJQ9DkULECyl
         sIaTWNP0WY26vZwb7VwTb25USJxKiugrYzSXnRkm27849pIPREYX8sMW17xH8Y7sPDCt
         f3EQDxO/bkI8PzMmJApQR/EG4/Gqd88hXx1vtjrEQvwIOfY4hYJY19MHXhiEgfK9Ub2g
         9mVjkUEa0j4ncoJkOXx3LPVhsMMeFrwS/0QxYEiOWasTWkC6e2WC1pUd3BDEKPzQxBtx
         KTsg==
X-Gm-Message-State: AJIora+VVrGivRfO4U+gEkXz2kDc9CiSP35VzzLSQaUm3c/cuL9EzUpx
        +NGRV6KeVvky7/ENoxmoRP01KBMHAUXOpHH5kDY5ademuBu51qh0haidxFVqxLGL6MH3XpcjxjU
        h8EP+F7TETUo2/rq5LS5naLQg
X-Received: by 2002:a05:6402:12d8:b0:43a:6a70:9039 with SMTP id k24-20020a05640212d800b0043a6a709039mr24742331edx.379.1657542776726;
        Mon, 11 Jul 2022 05:32:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1us6SBJWHNr8TZdMIqEfnLSad94s/7Cw7fuwBEAI0bhoJTJ6NhECbI82jsWNg6Vih3GxWKM6w==
X-Received: by 2002:a05:6402:12d8:b0:43a:6a70:9039 with SMTP id k24-20020a05640212d800b0043a6a709039mr24742309edx.379.1657542776528;
        Mon, 11 Jul 2022 05:32:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b00722dceb3f8bsm2637429ejh.151.2022.07.11.05.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:32:56 -0700 (PDT)
Message-ID: <c4f4700a-acaf-2ae1-6ccb-4d388a512a5d@redhat.com>
Date:   Mon, 11 Jul 2022 14:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/4] drm: rename CMA helpers to DMA helpers
Content-Language: en-US
To:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220707174003.1390017-1-dakr@redhat.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20220707174003.1390017-1-dakr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 19:39, Danilo Krummrich wrote:
> This patch series renames all CMA helpers to DMA helpers - considering the
> hierarchy of APIs (mm/cma -> dma -> gem/fb dma helpers) calling them DMA
> helpers seems to be more applicable.
> 
> Additionally, commit e57924d4ae80 ("drm/doc: Task to rename CMA helpers")
> requests to rename the CMA helpers and implies that people seem to be confused
> about the naming.
> 
> The patches are compile-time tested building a x86_64 kernel with
> `make allyesconfig && make drivers/gpu/drm`.
> 
> Changes in v2:
>    - Fixed up comments for consistent memory/address classification
>      (DMA-contiguous)
>    - Added a patch to rename struct drm_gem_dma_object.{paddr => dma_addr}
> 
> Changes in v3:
>    - Use a ccoccinelle script for
>      "drm/gem: rename struct drm_gem_dma_object.{paddr => dma_addr}" for fixing
>      up missing drivers and compile-test on x86_64, arm and arm64.
> 
> Danilo Krummrich (4):
>    drm/fb: rename FB CMA helpers to FB DMA helpers
>    drm/gem: rename GEM CMA helpers to GEM DMA helpers
>    drm/gem: rename struct drm_gem_dma_object.{paddr => dma_addr}
>    drm/todo: remove task to rename CMA helpers
Since those patches are based on Linus' tree they (unsurprisingly) don't 
apply on drm-next cleanly.

Please let me know if you want me to send a rebased version for drm-next.

- Danilo
> 
>   Documentation/gpu/drm-kms-helpers.rst         |   8 +-
>   Documentation/gpu/drm-mm.rst                  |  16 +-
>   Documentation/gpu/todo.rst                    |  13 -
>   drivers/gpu/drm/Kconfig                       |   4 +-
>   drivers/gpu/drm/Makefile                      |   6 +-
>   drivers/gpu/drm/arm/Kconfig                   |   4 +-
>   drivers/gpu/drm/arm/display/Kconfig           |   2 +-
>   .../arm/display/komeda/komeda_framebuffer.c   |  12 +-
>   .../gpu/drm/arm/display/komeda/komeda_kms.c   |  10 +-
>   drivers/gpu/drm/arm/hdlcd_crtc.c              |   6 +-
>   drivers/gpu/drm/arm/hdlcd_drv.c               |   8 +-
>   drivers/gpu/drm/arm/malidp_drv.c              |  10 +-
>   drivers/gpu/drm/arm/malidp_mw.c               |   8 +-
>   drivers/gpu/drm/arm/malidp_planes.c           |  34 +-
>   drivers/gpu/drm/armada/armada_gem.c           |   6 +-
>   drivers/gpu/drm/aspeed/Kconfig                |   2 +-
>   drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c      |  10 +-
>   drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |   8 +-
>   drivers/gpu/drm/atmel-hlcdc/Kconfig           |   2 +-
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |   6 +-
>   .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |   8 +-
>   ...rm_fb_cma_helper.c => drm_fb_dma_helper.c} |  67 ++--
>   drivers/gpu/drm/drm_file.c                    |   2 +-
>   drivers/gpu/drm/drm_format_helper.c           |   4 +-
>   ..._gem_cma_helper.c => drm_gem_dma_helper.c} | 314 +++++++++---------
>   drivers/gpu/drm/drm_mipi_dbi.c                |   2 +-
>   drivers/gpu/drm/fsl-dcu/Kconfig               |   2 +-
>   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |   8 +-
>   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c     |   2 +-
>   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c   |  10 +-
>   drivers/gpu/drm/hisilicon/kirin/Kconfig       |   2 +-
>   .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   |  14 +-
>   .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |   4 +-
>   drivers/gpu/drm/imx/Kconfig                   |   2 +-
>   drivers/gpu/drm/imx/dcss/Kconfig              |   2 +-
>   drivers/gpu/drm/imx/dcss/dcss-kms.c           |   6 +-
>   drivers/gpu/drm/imx/dcss/dcss-plane.c         |  18 +-
>   drivers/gpu/drm/imx/imx-drm-core.c            |  10 +-
>   drivers/gpu/drm/imx/imx-drm.h                 |   2 +-
>   drivers/gpu/drm/imx/ipuv3-crtc.c              |   4 +-
>   drivers/gpu/drm/imx/ipuv3-plane.c             |  28 +-
>   drivers/gpu/drm/ingenic/Kconfig               |   2 +-
>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  14 +-
>   drivers/gpu/drm/ingenic/ingenic-ipu.c         |  12 +-
>   drivers/gpu/drm/kmb/Kconfig                   |   2 +-
>   drivers/gpu/drm/kmb/kmb_drv.c                 |   6 +-
>   drivers/gpu/drm/kmb/kmb_plane.c               |  10 +-
>   drivers/gpu/drm/mcde/Kconfig                  |   2 +-
>   drivers/gpu/drm/mcde/mcde_display.c           |   8 +-
>   drivers/gpu/drm/mcde/mcde_drv.c               |  10 +-
>   drivers/gpu/drm/mediatek/Kconfig              |   2 +-
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   2 +-
>   drivers/gpu/drm/mediatek/mtk_drm_gem.c        |   4 +-
>   drivers/gpu/drm/meson/Kconfig                 |   2 +-
>   drivers/gpu/drm/meson/meson_drv.c             |  10 +-
>   drivers/gpu/drm/meson/meson_overlay.c         |  18 +-
>   drivers/gpu/drm/meson/meson_plane.c           |  10 +-
>   drivers/gpu/drm/msm/msm_drv.c                 |   2 +-
>   drivers/gpu/drm/mxsfb/Kconfig                 |   2 +-
>   drivers/gpu/drm/mxsfb/mxsfb_drv.c             |   6 +-
>   drivers/gpu/drm/mxsfb/mxsfb_kms.c             |  34 +-
>   drivers/gpu/drm/panel/Kconfig                 |   2 +-
>   drivers/gpu/drm/panel/panel-ilitek-ili9341.c  |   6 +-
>   drivers/gpu/drm/pl111/Kconfig                 |   2 +-
>   drivers/gpu/drm/pl111/pl111_display.c         |   8 +-
>   drivers/gpu/drm/pl111/pl111_drv.c             |  10 +-
>   drivers/gpu/drm/rcar-du/Kconfig               |   2 +-
>   drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |   4 +-
>   drivers/gpu/drm/rcar-du/rcar_du_drv.c         |   6 +-
>   drivers/gpu/drm/rcar-du/rcar_du_kms.c         |  38 +--
>   drivers/gpu/drm/rcar-du/rcar_du_plane.c       |  10 +-
>   drivers/gpu/drm/rcar-du/rcar_du_vsp.c         |   8 +-
>   drivers/gpu/drm/rockchip/Kconfig              |   2 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |   2 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c   |   4 +-
>   drivers/gpu/drm/shmobile/Kconfig              |   2 +-
>   drivers/gpu/drm/shmobile/shmob_drm_crtc.c     |  14 +-
>   drivers/gpu/drm/shmobile/shmob_drm_drv.c      |   6 +-
>   drivers/gpu/drm/shmobile/shmob_drm_kms.c      |   4 +-
>   drivers/gpu/drm/shmobile/shmob_drm_kms.h      |   2 +-
>   drivers/gpu/drm/shmobile/shmob_drm_plane.c    |  14 +-
>   drivers/gpu/drm/solomon/ssd130x.c             |   2 +-
>   drivers/gpu/drm/sprd/Kconfig                  |   2 +-
>   drivers/gpu/drm/sprd/sprd_dpu.c               |  10 +-
>   drivers/gpu/drm/sprd/sprd_drm.c               |   6 +-
>   drivers/gpu/drm/sti/Kconfig                   |   2 +-
>   drivers/gpu/drm/sti/sti_cursor.c              |  14 +-
>   drivers/gpu/drm/sti/sti_drv.c                 |   8 +-
>   drivers/gpu/drm/sti/sti_gdp.c                 |  18 +-
>   drivers/gpu/drm/sti/sti_hqvdp.c               |  18 +-
>   drivers/gpu/drm/sti/sti_plane.c               |   4 +-
>   drivers/gpu/drm/stm/Kconfig                   |   2 +-
>   drivers/gpu/drm/stm/drv.c                     |  12 +-
>   drivers/gpu/drm/stm/ltdc.c                    |  16 +-
>   drivers/gpu/drm/sun4i/Kconfig                 |   2 +-
>   drivers/gpu/drm/sun4i/sun4i_backend.c         |  16 +-
>   drivers/gpu/drm/sun4i/sun4i_drv.c             |  10 +-
>   drivers/gpu/drm/sun4i/sun4i_frontend.c        |  26 +-
>   drivers/gpu/drm/sun4i/sun8i_mixer.c           |   4 +-
>   drivers/gpu/drm/sun4i/sun8i_ui_layer.c        |  22 +-
>   drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  22 +-
>   drivers/gpu/drm/tegra/fb.c                    |   2 +-
>   drivers/gpu/drm/tidss/Kconfig                 |   2 +-
>   drivers/gpu/drm/tidss/tidss_crtc.c            |   4 +-
>   drivers/gpu/drm/tidss/tidss_dispc.c           |  28 +-
>   drivers/gpu/drm/tidss/tidss_drv.c             |   6 +-
>   drivers/gpu/drm/tidss/tidss_kms.c             |   2 +-
>   drivers/gpu/drm/tidss/tidss_plane.c           |   2 +-
>   drivers/gpu/drm/tilcdc/Kconfig                |   2 +-
>   drivers/gpu/drm/tilcdc/tilcdc_crtc.c          |  10 +-
>   drivers/gpu/drm/tilcdc/tilcdc_drv.c           |   6 +-
>   drivers/gpu/drm/tiny/Kconfig                  |  22 +-
>   drivers/gpu/drm/tiny/arcpgu.c                 |  14 +-
>   drivers/gpu/drm/tiny/hx8357d.c                |   6 +-
>   drivers/gpu/drm/tiny/ili9163.c                |   6 +-
>   drivers/gpu/drm/tiny/ili9225.c                |  12 +-
>   drivers/gpu/drm/tiny/ili9341.c                |   6 +-
>   drivers/gpu/drm/tiny/ili9486.c                |   6 +-
>   drivers/gpu/drm/tiny/mi0283qt.c               |   6 +-
>   drivers/gpu/drm/tiny/panel-mipi-dbi.c         |   6 +-
>   drivers/gpu/drm/tiny/repaper.c                |  12 +-
>   drivers/gpu/drm/tiny/st7586.c                 |  12 +-
>   drivers/gpu/drm/tiny/st7735r.c                |   6 +-
>   drivers/gpu/drm/tve200/Kconfig                |   2 +-
>   drivers/gpu/drm/tve200/tve200_display.c       |  12 +-
>   drivers/gpu/drm/tve200/tve200_drv.c           |   8 +-
>   drivers/gpu/drm/v3d/v3d_drv.c                 |   2 +-
>   drivers/gpu/drm/v3d/v3d_gem.c                 |   4 +-
>   drivers/gpu/drm/vc4/Kconfig                   |   2 +-
>   drivers/gpu/drm/vc4/vc4_bo.c                  |  46 +--
>   drivers/gpu/drm/vc4/vc4_crtc.c                |  10 +-
>   drivers/gpu/drm/vc4/vc4_drv.c                 |   8 +-
>   drivers/gpu/drm/vc4/vc4_drv.h                 |  18 +-
>   drivers/gpu/drm/vc4/vc4_gem.c                 |  12 +-
>   drivers/gpu/drm/vc4/vc4_irq.c                 |   2 +-
>   drivers/gpu/drm/vc4/vc4_plane.c               |  14 +-
>   drivers/gpu/drm/vc4/vc4_render_cl.c           |  40 +--
>   drivers/gpu/drm/vc4/vc4_txp.c                 |   8 +-
>   drivers/gpu/drm/vc4/vc4_v3d.c                 |   8 +-
>   drivers/gpu/drm/vc4/vc4_validate.c            |  28 +-
>   drivers/gpu/drm/vc4/vc4_validate_shaders.c    |   2 +-
>   drivers/gpu/drm/xlnx/Kconfig                  |   2 +-
>   drivers/gpu/drm/xlnx/zynqmp_disp.c            |   8 +-
>   drivers/gpu/drm/xlnx/zynqmp_dpsub.c           |   8 +-
>   ...rm_fb_cma_helper.h => drm_fb_dma_helper.h} |  10 +-
>   include/drm/drm_gem.h                         |   2 +-
>   ..._gem_cma_helper.h => drm_gem_dma_helper.h} | 158 ++++-----
>   147 files changed, 899 insertions(+), 899 deletions(-)
>   rename drivers/gpu/drm/{drm_fb_cma_helper.c => drm_fb_dma_helper.c} (60%)
>   rename drivers/gpu/drm/{drm_gem_cma_helper.c => drm_gem_dma_helper.c} (56%)
>   rename include/drm/{drm_fb_cma_helper.h => drm_fb_dma_helper.h} (56%)
>   rename include/drm/{drm_gem_cma_helper.h => drm_gem_dma_helper.h} (53%)
> 

