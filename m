Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806304D634C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbiCKOUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343499AbiCKOUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:20:08 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF3D1B3089;
        Fri, 11 Mar 2022 06:19:04 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id r127so7007188qke.13;
        Fri, 11 Mar 2022 06:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHCpBusebCbgxUIJ1/NXRjOMzp7EqZ0gugR3QmXqfKc=;
        b=SO1Fn01vS8GdyjEJ6um3E3bjLMsMNd8cZSLcWzWmmP95eH6HYEci+6e3tv6uZKhMeg
         jBmqCDlvgNjEpd/BtrAtBiCYAWG9KHGkwo0GhgkGQUp5Zkcj7oZHTBwcoEE585tz1Wcx
         MsO0nQAMkFSP/lCjGVVbOufvfrMkNUvBONpx9P8/xqeT9SASo3056HoPvPUK2l0z9nKQ
         EwofZZGoT/7hS3I9nQoh5TxsVlFSdftydKpII7E/L0RnestZQD4qyoAXfoZHsytZcR4L
         GwNdHqRaftSwdEwSYqo/ODWUJSZ8G5W6WM5ixaEB0UqHc3fpqR+d4rZwhD3znd2d8wuf
         NOSg==
X-Gm-Message-State: AOAM530MBDG+5VIbWHBkbn8GtHUl4Ek8fc0B1qojt6jPsWaUJxnfW7+8
        uynzso3sMjB5W3YpnwWsv6DlpIEEuRWnZA==
X-Google-Smtp-Source: ABdhPJwHWjUUvKkryclSo/Aaby9DdLFQj3iRVQF1Eao2M5paEZW+PEOuzti8xAUBvQX86u2qT6cJhA==
X-Received: by 2002:a05:620a:424d:b0:67d:2bad:4450 with SMTP id w13-20020a05620a424d00b0067d2bad4450mr6741034qko.171.1647008342477;
        Fri, 11 Mar 2022 06:19:02 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id d12-20020a05620a158c00b00648ec3fcbdfsm3792474qkk.72.2022.03.11.06.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 06:19:01 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id e186so17311530ybc.7;
        Fri, 11 Mar 2022 06:19:01 -0800 (PST)
X-Received: by 2002:a25:dc4:0:b0:629:2337:f9ea with SMTP id
 187-20020a250dc4000000b006292337f9eamr8077424ybn.6.1647008340690; Fri, 11 Mar
 2022 06:19:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1647006877.git.mchehab@kernel.org> <b7e9058b5caac542eb06b5ae313d72218ff848e3.1647006877.git.mchehab@kernel.org>
In-Reply-To: <b7e9058b5caac542eb06b5ae313d72218ff848e3.1647006877.git.mchehab@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Mar 2022 15:18:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWLaVdUR+pZpqof7bh3E2FEYOykEH+icLy07u9jYa-_rA@mail.gmail.com>
Message-ID: <CAMuHMdWLaVdUR+pZpqof7bh3E2FEYOykEH+icLy07u9jYa-_rA@mail.gmail.com>
Subject: Re: [PATCH v2 10/38] media: platform: place Renesas drivers on a
 separate dir
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Herman <herman.yim88@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>,
        Ming Qian <ming.qian@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Fri, Mar 11, 2022 at 3:08 PM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
> In order to cleanup the main platform media directory, move Renesas
> driver to its own directory.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/
>
>  MAINTAINERS                                   |  16 +--
>  drivers/media/platform/Kconfig                | 113 +----------------
>  drivers/media/platform/Makefile               |   9 +-
>  drivers/media/platform/renesas/Kconfig        | 119 ++++++++++++++++++
>  drivers/media/platform/renesas/Makefile       |  14 +++
>  .../media/platform/{ => renesas}/rcar-fcp.c   |   0
>  .../media/platform/{ => renesas}/rcar-isp.c   |   0
>  .../platform/{ => renesas}/rcar-vin/Kconfig   |   0
>  .../platform/{ => renesas}/rcar-vin/Makefile  |   0
>  .../{ => renesas}/rcar-vin/rcar-core.c        |   0
>  .../{ => renesas}/rcar-vin/rcar-csi2.c        |   0
>  .../{ => renesas}/rcar-vin/rcar-dma.c         |   0
>  .../{ => renesas}/rcar-vin/rcar-v4l2.c        |   0
>  .../{ => renesas}/rcar-vin/rcar-vin.h         |   0
>  .../media/platform/{ => renesas}/rcar_drif.c  |   0
>  .../media/platform/{ => renesas}/rcar_fdp1.c  |   0
>  .../media/platform/{ => renesas}/rcar_jpu.c   |   0
>  .../platform/{ => renesas}/renesas-ceu.c      |   0
>  drivers/media/platform/{ => renesas}/sh_vou.c |   0
>  19 files changed, 144 insertions(+), 127 deletions(-)
>  create mode 100644 drivers/media/platform/renesas/Kconfig
>  create mode 100644 drivers/media/platform/renesas/Makefile
>  rename drivers/media/platform/{ => renesas}/rcar-fcp.c (100%)
>  rename drivers/media/platform/{ => renesas}/rcar-isp.c (100%)
>  rename drivers/media/platform/{ => renesas}/rcar-vin/Kconfig (100%)
>  rename drivers/media/platform/{ => renesas}/rcar-vin/Makefile (100%)
>  rename drivers/media/platform/{ => renesas}/rcar-vin/rcar-core.c (100%)
>  rename drivers/media/platform/{ => renesas}/rcar-vin/rcar-csi2.c (100%)
>  rename drivers/media/platform/{ => renesas}/rcar-vin/rcar-dma.c (100%)
>  rename drivers/media/platform/{ => renesas}/rcar-vin/rcar-v4l2.c (100%)
>  rename drivers/media/platform/{ => renesas}/rcar-vin/rcar-vin.h (100%)
>  rename drivers/media/platform/{ => renesas}/rcar_drif.c (100%)
>  rename drivers/media/platform/{ => renesas}/rcar_fdp1.c (100%)
>  rename drivers/media/platform/{ => renesas}/rcar_jpu.c (100%)
>  rename drivers/media/platform/{ => renesas}/renesas-ceu.c (100%)
>  rename drivers/media/platform/{ => renesas}/sh_vou.c (100%)

Looks like you missed the vsp1 driver code and its entry in the
MAINTAINERS file...

> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig

> -
> -config VIDEO_RENESAS_VSP1
> -       tristate "Renesas VSP1 Video Processing Engine"
> -       depends on V4L_MEM2MEM_DRIVERS
> -       depends on VIDEO_V4L2
> -       depends on ARCH_RENESAS || COMPILE_TEST
> -       depends on (!ARM64 && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
> -       select MEDIA_CONTROLLER
> -       select VIDEO_V4L2_SUBDEV_API
> -       select VIDEOBUF2_DMA_CONTIG
> -       select VIDEOBUF2_VMALLOC
> -       help
> -         This is a V4L2 driver for the Renesas VSP1 video processing engine.
> -
> -         To compile this driver as a module, choose M here: the module
> -         will be called vsp1.
> -
>  config VIDEO_ROCKCHIP_RGA
>         tristate "Rockchip Raster 2d Graphic Acceleration Unit"
>         depends on V4L_MEM2MEM_DRIVERS

> --- /dev/null
> +++ b/drivers/media/platform/renesas/Kconfig

> +
> +config VIDEO_RENESAS_VSP1
> +       tristate "Renesas VSP1 Video Processing Engine"
> +       depends on V4L_MEM2MEM_DRIVERS
> +       depends on VIDEO_V4L2
> +       depends on ARCH_RENESAS || COMPILE_TEST
> +       depends on (!ARM64 && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
> +       select MEDIA_CONTROLLER
> +       select VIDEO_V4L2_SUBDEV_API
> +       select VIDEOBUF2_DMA_CONTIG
> +       select VIDEOBUF2_VMALLOC
> +       help
> +         This is a V4L2 driver for the Renesas VSP1 video processing engine.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called vsp1.
> +

... but you did move its Kconfig entry.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
