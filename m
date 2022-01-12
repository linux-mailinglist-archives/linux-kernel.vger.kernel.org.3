Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315E148BF1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351310AbiALHjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:39:43 -0500
Received: from mail-vk1-f179.google.com ([209.85.221.179]:33685 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351328AbiALHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:39:39 -0500
Received: by mail-vk1-f179.google.com with SMTP id g5so1133998vkg.0;
        Tue, 11 Jan 2022 23:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHfD03WmQisvwQlA0yVYr+t2tOrW8sr+EcU6Wg5KSck=;
        b=1YMG+rRXfwavl134UZ73NS6rtboS3cxSjqHMnAkxxJbZOptDl9DzPUZbmjyGfXXksp
         1kD9F3qW2KgAVydvfflcLxIHIix4CsvUxMb4bZMeegeICcRQJzRP5bpu99edyQxvbnsM
         twyYG1hLfhElGdqknfmIV2qLSm4pSYjtjOWJL82iHHidOD1pOu36NsFf5d8VsMJ83G3J
         YaVWQW6aot349tc1eLDzjBEa+tRt6JC2vZL5FfykUZcr+pyj92PpLvkh2xUGRKLN7G+U
         5n96x8tgZA6WLCKBRo/6oxsO8HIs/SL512JtkzP3MDbSZtt7GlzssmJr9uQLWZJuLWDV
         yqmA==
X-Gm-Message-State: AOAM532MuuqpFexqY2FicgdHavTTWFcgAlxY9AjS3+Hi38qM6ATOx2Z+
        wyNmkBNFbF0vVbwp2JdCbdP/v64mWA9zbQ==
X-Google-Smtp-Source: ABdhPJzuxtsPnI37YIYK5BxpU/cRukaZdYXc3zFpmpzwFNlkrcvFJA/MFm52jHebuMxsnSbo8Nc/xA==
X-Received: by 2002:a1f:3490:: with SMTP id b138mr3856785vka.31.1641973178972;
        Tue, 11 Jan 2022 23:39:38 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id s47sm2201128uad.17.2022.01.11.23.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 23:39:38 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id n12so1073619vkc.12;
        Tue, 11 Jan 2022 23:39:38 -0800 (PST)
X-Received: by 2002:a1f:384b:: with SMTP id f72mr4068168vka.0.1641973178116;
 Tue, 11 Jan 2022 23:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20211202191630.12450-1-jaschultz@microsoft.com> <20211202191630.12450-3-jaschultz@microsoft.com>
In-Reply-To: <20211202191630.12450-3-jaschultz@microsoft.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jan 2022 08:39:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUPwo7pCSwY8_9xTaDruTHt6d=wHiNHvRmE71k8hWeLBw@mail.gmail.com>
Message-ID: <CAMuHMdUPwo7pCSwY8_9xTaDruTHt6d=wHiNHvRmE71k8hWeLBw@mail.gmail.com>
Subject: Re: [PATCH 2/5] platform: surface: Propagate ACPI Dependency
To:     Jarrett Schultz <jaschultzms@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarrett,

On Mon, Dec 6, 2021 at 4:03 PM Jarrett Schultz <jaschultzms@gmail.com> wrote:
> Since the Surface XBL Driver does not depend on ACPI, the
> platform/surface directory as a whole no longer depends on ACPI. With
> respect to this, the ACPI dependency is moved into each config that depends
> on ACPI individually.
>
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>

Thanks for your patch, which is now commit 272479928172edf0 ("platform:
surface: Propagate ACPI Dependency").

> --- a/drivers/platform/surface/Kconfig
> +++ b/drivers/platform/surface/Kconfig
> @@ -5,7 +5,6 @@
>
>  menuconfig SURFACE_PLATFORMS
>         bool "Microsoft Surface Platform-Specific Device Drivers"
> -       depends on ACPI
>         default y
>         help
>           Say Y here to get to see options for platform-specific device drivers

Without any dependency, all users configuring a kernel are now asked
about this. Is there any other platform dependency that can be used
instead?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
