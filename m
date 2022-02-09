Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12034AF161
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiBIMWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiBIMWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:22:17 -0500
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF66C050CD6;
        Wed,  9 Feb 2022 04:21:20 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id n14so1041071vkk.6;
        Wed, 09 Feb 2022 04:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qpoc5vmMmNDH+SrdCpaRcSXbVfsZOqQW8hec7Ijd/W8=;
        b=ArD4G//zP3yLwuMGcWoJ2B3IVTAR8qSew1W2MVeIxkwE+hWsLncpqv87lPNyYy+Wcz
         P8fma/r/mGhnh0lagdPEeBorD5nGn+D5Oc94NLH3rF/+rp2SVj3PoTwOJuxRV5mqvJ0U
         SBIJRDCSwDmo0+4Rqw8KHj/aGiRxC5vB6y/1Pn8zbm1PDW98ZqOQ/1BTxEfGuM1L92IK
         MmRE8aCUj9WyJ/Yrqd+/xPxLagy7Af1MXR+2LJ8vxhMTMadHYNCREBHu8gOPRBbBDvV5
         fh4zZdNmmyTcaM9PkqmX/Q1w0+eBmyMGgffmynR06VnJw2dpM/AqvYNATsTluuNUuKYi
         ksJA==
X-Gm-Message-State: AOAM5316/DP3e8Yck+xnsgA2Gcr/OgC/+Pfp78XU9lCVFQYxfSc9yVZK
        oVmV+XxN+c8vDOBE7orSGrbD5VAumbeLAw==
X-Google-Smtp-Source: ABdhPJzA8Nb5Ynlu3dxmAEFYqo4HjgeFecHCEbGvMRuN2IdMaKoLz/CP4fa2jkVRTUw+wuBwx+sDBQ==
X-Received: by 2002:a1f:e745:: with SMTP id e66mr693844vkh.24.1644409279633;
        Wed, 09 Feb 2022 04:21:19 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id r14sm1517652vke.20.2022.02.09.04.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 04:21:19 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id j26so881462vso.12;
        Wed, 09 Feb 2022 04:21:19 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr553685vse.38.1644409278954;
 Wed, 09 Feb 2022 04:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20220209090314.2511959-1-javierm@redhat.com> <20220209090314.2511959-5-javierm@redhat.com>
In-Reply-To: <20220209090314.2511959-5-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Feb 2022 13:21:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXOfz94gD+SpGRS7HazxA_PN3n2D=Q04CPm-eEMb_CkEw@mail.gmail.com>
Message-ID: <CAMuHMdXOfz94gD+SpGRS7HazxA_PN3n2D=Q04CPm-eEMb_CkEw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] drm/solomon: Add SSD130X OLED displays I2C support
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
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

On Wed, Feb 9, 2022 at 10:03 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The ssd130x driver only provides the core support for these devices but it
> does not have any bus transport logic. Add a driver to interface over I2C.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c

> +static const struct of_device_id ssd130x_of_match[] = {
> +       {
> +               .compatible = "solomon,ssd1305fb-i2c",
> +               .data = (void *)&ssd130x_ssd1305_deviceinfo,

The casts are not needed.

> +       },
> +       {
> +               .compatible = "solomon,ssd1306fb-i2c",
> +               .data = (void *)&ssd130x_ssd1306_deviceinfo,
> +       },
> +       {
> +               .compatible = "solomon,ssd1307fb-i2c",
> +               .data = (void *)&ssd130x_ssd1307_deviceinfo,
> +       },
> +       {
> +               .compatible = "solomon,ssd1309fb-i2c",
> +               .data = (void *)&ssd130x_ssd1309_deviceinfo,
> +       },
> +       { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ssd130x_of_match);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
