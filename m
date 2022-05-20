Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844B052EB72
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348933AbiETMCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348947AbiETMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:02:35 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A11149156;
        Fri, 20 May 2022 05:02:26 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id eq14so6519377qvb.4;
        Fri, 20 May 2022 05:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65WlQ7s8g42M5C+5yY3Awf+CpXZTfjugQxcprooIu8U=;
        b=H4H5LtAxlH368rGbeiAUynQDnrh/BXQmBONueTt/4LyjcN0gRD5Imh2Eb1wviOUidU
         ZaUNCljmMzVu97ucZAG88dMS1MttqTcGDsQg/Rb9zRXxOIaCK4FpqBsOOe5VSv2HoqYc
         Vx0WW/UDHb0QINToSOROo7wHOHxDBuqASpjNZFd7K2gObbkr8/fnsjW4eRin9K9KDgOV
         gyxvmRiOwG423nqWVrpdKsGvq11JuIGYl8MwC2xCyIhHWZ/mH+Cs9XJGGAP8zlPclR5P
         oJWG5EpI//w3ll3p3pi3fskRX3aLUEkm4BytvupZnexgrlQaJ9qf6FJb9hqoLY4RiTQs
         FOWw==
X-Gm-Message-State: AOAM533pCWAUb2WxgWalUoN0CfNCLXzZ91kz5YqhhFQEsX/XgtJlT/bk
        LZmaI5VWbgGA95xXxOnYDWb7VQbtBurznw==
X-Google-Smtp-Source: ABdhPJzxbJUSuKDtFmliNY60ckeR9FwT0HpsWozJ6nrAa6f+qH4bHHCc+oxtXwpVW4zfaDztnxiYAg==
X-Received: by 2002:a05:6214:500c:b0:435:6b7d:5bc3 with SMTP id jo12-20020a056214500c00b004356b7d5bc3mr7641794qvb.92.1653048144744;
        Fri, 20 May 2022 05:02:24 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id he17-20020a05622a601100b002f39b99f6c3sm2850201qtb.93.2022.05.20.05.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 05:02:24 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id t26so13825047ybt.3;
        Fri, 20 May 2022 05:02:23 -0700 (PDT)
X-Received: by 2002:a25:4289:0:b0:64d:746f:5311 with SMTP id
 p131-20020a254289000000b0064d746f5311mr8586423yba.89.1653048143666; Fri, 20
 May 2022 05:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220520091602.179078-1-javierm@redhat.com>
In-Reply-To: <20220520091602.179078-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 May 2022 14:02:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVmFGjGbHz1yo7tOzqtUbMTDkUxaMo2fVSp1HMU=_1emA@mail.gmail.com>
Message-ID: <CAMuHMdVmFGjGbHz1yo7tOzqtUbMTDkUxaMo2fVSp1HMU=_1emA@mail.gmail.com>
Subject: Re: [PATCH] drm/st7735r: Fix module autoloading for Okaya RH128128T
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Lechner <david@lechnology.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
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

Hi Javier,

CC spi

On Fri, May 20, 2022 at 11:16 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The SPI core always reports a "MODALIAS=spi:<foo>", even if the device was
> registered via OF. This means that the st7735r.ko module won't autoload if
> a DT has a node with a compatible "okaya,rh128128t" string.
>
> In that case, kmod expects a "MODALIAS=of:N*T*Cokaya,rh128128t" uevent but
> instead will get a "MODALIAS=spi:rh128128t", which is not present in the
> list of aliases:
>
>   $ modinfo drivers/gpu/drm/tiny/st7735r.ko | grep alias
>   alias:          of:N*T*Cokaya,rh128128tC*
>   alias:          of:N*T*Cokaya,rh128128t
>   alias:          of:N*T*Cjianda,jd-t18003-t01C*
>   alias:          of:N*T*Cjianda,jd-t18003-t01
>   alias:          spi:jd-t18003-t01
>
> To workaround this issue, add in the SPI table an entry for that device.
>
> Fixes: d1d511d516f7 ("drm: tiny: st7735r: Add support for Okaya RH128128T")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch!
We really need to fix this at the subsystem level.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>


> --- a/drivers/gpu/drm/tiny/st7735r.c
> +++ b/drivers/gpu/drm/tiny/st7735r.c
> @@ -174,6 +174,7 @@ MODULE_DEVICE_TABLE(of, st7735r_of_match);
>
>  static const struct spi_device_id st7735r_id[] = {
>         { "jd-t18003-t01", (uintptr_t)&jd_t18003_t01_cfg },
> +       { "rh128128t", (uintptr_t)&rh128128t_cfg },
>         { },
>  };
>  MODULE_DEVICE_TABLE(spi, st7735r_id);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
