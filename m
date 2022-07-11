Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4E5570C97
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiGKVQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiGKVQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:16:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FBE80531
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:16:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id h23so10906993ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0dZKbSqpa4RMujXbJGg6O0Ik7zsKtCn/44ZHpByEck=;
        b=e6FVL2N1GoCx6ewvM5xcIt8X8A6DT47CZWwxmgZ6VEhVfW/hLzx4AqmMaA8ZxTGFWS
         uYsECq9XltW1jX3WXVDCSl4hyA9wycz2iyuri01alyZn2ODyJEot44R/twY9O5rDye4a
         okyW5qblZM0/RglcNNdkRWagXv8tPsS3+AXd314ElWLjuM77zrlG4L/FF+NpVR2YLvre
         Egz2+eM0ShDiJiiv8apuJHGtKQXg0HaU7gPvRPFxF6UE4x4PTRSalTbp4Nan52wvFcYl
         c/LTWEM3iI+8HolUo3hHSptP5Ux92BrNrF/ln3ThBN9BCLSH90A3+Pd7o1pLhD6YRk89
         TP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0dZKbSqpa4RMujXbJGg6O0Ik7zsKtCn/44ZHpByEck=;
        b=Co6mslfsJxBzn2lfuNrFRMTswIxsKcyTUAgrCWOjFrIql8L8TGz7LopOZYPoTOvpjE
         TzgT+ZxyzinNhUA8AKTMA3+VN2MvtrjnIqwPJuuO1/+VWKzuP7hmjJsXwA3FqUQp5W2G
         SmsAV96WsSNhCV2LNB/oXqnkQ/OhgwkvLP7EsdnDOSB6/THXZHngVS+WwzratfVpRb/S
         qKvFUd+27AIsyIphnCwXmLaFBV5t3kCnRHaufUSrK9P4bZTFZEcw4fjrM6jyS4E47F3K
         phm09FiBDVBOzMRGoI2UwzUt28ptKlpIwchA8mpe5PloC3139idun2nsyf2YT46ZtVU6
         cC4w==
X-Gm-Message-State: AJIora/2c1SZwyUVNMsqPxZmDyhL2uy8cIDAITIgiRa60N3VjhxPHapy
        U957f7J8WggTnePP2NI7TbkkHg3Wn3KoUyCrEW6qvw==
X-Google-Smtp-Source: AGRyM1tGmmZU3SpBCKiz6GQosaxZhhIYryeBP+xKYRre/YM9KWGoV/EtlPDw7fJzN8sXY5wD80lfJtt1tOD20TpLJD0=
X-Received: by 2002:a17:906:5a5b:b0:72b:39cf:6042 with SMTP id
 my27-20020a1709065a5b00b0072b39cf6042mr13921828ejc.301.1657574163407; Mon, 11
 Jul 2022 14:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220706182901.78949-1-jernej.skrabec@gmail.com>
In-Reply-To: <20220706182901.78949-1-jernej.skrabec@gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 11 Jul 2022 18:15:52 -0300
Message-ID: <CAAEAJfBYXXZ2CGFTQFEsBNGu8++MW=jsXNpO1F8T-K2m-jAu7A@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] media: hantro: Add 10-bit support
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jernej,

On Wed, Jul 6, 2022 at 3:29 PM Jernej Skrabec <jernej.skrabec@gmail.com> wrote:
>
> This series adds support for 10-bit format handling in Hantro driver.
> Most patches adjust postproc behaviour to be more universal. There is
> a lot of assumptions, which need to be replaced with more generalized.
>
> Tested on Allwinner H6. Tested with vp92-2-20-10bit-yuv420.webm sample,
> which produces correct checksum.
>
> Please take a look.
>

Looks really good.

Thanks for working on this.
Ezequiel

> Best regards,
> Jernej
>
> Changes fron v2:
> - rebased on media-stage/master
> - added P010 4L4 format documentation
> - added t-b and r-b tags
>
> Changes from RFC:
> - fixed typo in function name
> - removed merged patch (P010 format)
> - removed broken patch (sunxi frequency change)
> - added new patch (media: hantro: postproc: Properly calculate chroma offset)
> - added r-b from Ezequiel
>
> Ezequiel Garcia (1):
>   media: Add P010 tiled format
>
> Jernej Skrabec (6):
>   media: hantro: Support format filtering by depth
>   media: hantro: postproc: Fix buffer size calculation
>   media: hantro: postproc: Fix legacy regs configuration
>   media: hantro: postproc: Properly calculate chroma offset
>   media: hantro: Store VP9 bit depth in context
>   media: hantro: sunxi: Enable 10-bit decoding
>
>  .../media/v4l/pixfmt-yuv-planar.rst           | 18 +++++--
>  drivers/media/v4l2-core/v4l2-common.c         |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>  drivers/staging/media/hantro/hantro.h         |  4 ++
>  drivers/staging/media/hantro/hantro_drv.c     | 23 +++++++++
>  .../staging/media/hantro/hantro_g2_vp9_dec.c  |  8 ---
>  .../staging/media/hantro/hantro_postproc.c    | 38 +++++++++++---
>  drivers/staging/media/hantro/hantro_v4l2.c    | 50 +++++++++++++++++--
>  drivers/staging/media/hantro/hantro_v4l2.h    |  3 ++
>  drivers/staging/media/hantro/sunxi_vpu_hw.c   | 27 ++++++++++
>  include/uapi/linux/videodev2.h                |  1 +
>  11 files changed, 151 insertions(+), 23 deletions(-)
>
> --
> 2.37.0
>
