Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91A449B630
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578293AbiAYOZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:25:56 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:46762 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578679AbiAYOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:20:58 -0500
Received: by mail-ua1-f43.google.com with SMTP id c36so37608502uae.13;
        Tue, 25 Jan 2022 06:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N429jTRG2O6NpwCQqF4KlOiX82MStuHyIsrCgU8SIEI=;
        b=SwSrGk3NaP00TQJUYmXnZs/orTsj+vlnuiugvHFevLsmwa7oNsedl31vXLaaMHhPky
         sesQzq5/cceh5dX15EzAYhOD+zoVX+h5JQzRv6RRCOvp638Cvs8g77tj4Zx5AfQWPWw6
         QaKXCZgJ0k1/4BRUb3/aoHHi6dVP1x6HyIbAf2Ta0ZoVoSj8v/KtH7umjNkMCc6Iwq9Q
         DcXVDCg1btusDs0Q1Kt7JwBcW6NtMWMFtcCGjPZEw4DJpOVczKSoOXz1xym2UdyFa97F
         vHckb1qY2KJoX8v88GjNctBUVZ3A7Qij2AaF8p9t2gnkMYHD314d6wD42ZHjXOIwSTB5
         gaTg==
X-Gm-Message-State: AOAM533sD5rVNdXvVmuCgh9dkLEeM2rJrfkjLFAO7pqzID4+J6PZETjc
        dvVxA/b3ZtPOQPIiZjHBkrwtQlvHXD9dvQZg
X-Google-Smtp-Source: ABdhPJwRy1ZyMEDc6L+ES1Y7H4L11mpJAP4Bu5+tAHDCTAofUYCmWfJPBVYQwK0Ee8ttzqw4zLGiEA==
X-Received: by 2002:ab0:1543:: with SMTP id p3mr7204112uae.88.1643120450538;
        Tue, 25 Jan 2022 06:20:50 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id k203sm3376480vka.56.2022.01.25.06.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 06:20:50 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id n15so36117376uaq.5;
        Tue, 25 Jan 2022 06:20:49 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr3524348vse.38.1643120449745;
 Tue, 25 Jan 2022 06:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20220118182003.3385019-1-keescook@chromium.org>
In-Reply-To: <20220118182003.3385019-1-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jan 2022 15:20:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWu-unMfV1U_HAKwJwPkB_LY3kU88_D69M=bX8y1B=QTg@mail.gmail.com>
Message-ID: <CAMuHMdWu-unMfV1U_HAKwJwPkB_LY3kU88_D69M=bX8y1B=QTg@mail.gmail.com>
Subject: Re: [PATCH 5.17-rc1 v2] eeprom: at25: Restore missing allocation
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

Thanks for your patch!

On Fri, Jan 21, 2022 at 12:33 AM Kees Cook <keescook@chromium.org> wrote:
> The at25 driver regressed in v5.17-rc1 due to a broken conflict
> resolution: the allocation of the object was accidentally removed. Restore
> it.
>
> This was found when building under CONFIG_FORTIFY_SOURCE=y and
> -Warray-bounds, which complained about strncpy() being used against an
> empty object:
>
> In function 'strncpy',
>     inlined from 'at25_fw_to_chip.constprop' at drivers/misc/eeprom/at25.c:312:2:
> ./include/linux/fortify-string.h:48:33: warning: '__builtin_strncpy' offset [0, 9] is out of the bounds [0, 0] [-Warray-bounds]
>    48 | #define __underlying_strncpy    __builtin_strncpy
>       |                                 ^
> ./include/linux/fortify-string.h:59:16: note: in expansion of macro '__underlying_strncpy'
>    59 |         return __underlying_strncpy(p, q, size);
>       |                ^~~~~~~~~~~~~~~~~~~~
> In function 'strncpy',
>     inlined from 'at25_fram_to_chip' at drivers/misc/eeprom/at25.c:373:2,
>     inlined from 'at25_probe' at drivers/misc/eeprom/at25.c:453:10:
> ./include/linux/fortify-string.h:48:33: warning: '__builtin_strncpy' offset [0, 9] is out of the bounds [0, 0] [-Warray-bounds]
>    48 | #define __underlying_strncpy    __builtin_strncpy
>       |                                 ^
> ./include/linux/fortify-string.h:59:16: note: in expansion of macro '__underlying_strncpy'
>    59 |         return __underlying_strncpy(p, q, size);
>       |                ^~~~~~~~~~~~~~~~~~~~

On real hardware:

    Unable to handle kernel access to user memory outside uaccess
routines at virtual address 0000000000000028
    ...
    pc : __mutex_init+0x20/0x68
    lr : at25_probe+0x8c/0x4d8


> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
