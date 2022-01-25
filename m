Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A5449B793
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345011AbiAYP2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:28:47 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:33774 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343808AbiAYPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:25:59 -0500
Received: by mail-ua1-f45.google.com with SMTP id u6so38098405uaq.0;
        Tue, 25 Jan 2022 07:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDZLNNI8bYyTslSgTWAgw/zQxPHro7WjafgbKw4LNRo=;
        b=dM+3K6FIBIr67m8hIBLOzHv13bxI28/tTu06WftoV2xDK3h84F9SiBJhbNIMrwOmFv
         9H62idOHzSS3Ow4uqXK83kt43pxlPsk+Tq57IzVMYicsVKw385vu2CDRqJw1aobKIjhR
         mrV1f6fi2S3FrGakx2MghIZiFOJwFxCsuqVHwpsb0f/T96y8g1AwROoSp+J0JXE7pnBU
         QHb2wcXSp6so9WY+8ZPeAYwef8vLaOnINkKfGCU95dfl07K48OscZ7uOCnQ0XQFBpOmS
         IAHfTitNK4NPsbiHLE/BLGGB6T9Zx5PO8v3xSSlG/8mazh7Z9ToHn1f+U/X3lVP1F7M8
         SUQg==
X-Gm-Message-State: AOAM53243CefptTYwIPRErexcViypNZDd8FviIhjE1KlLBoJSp/Yzn0O
        Ws8zHlJhXlQIf8jFB5LqsMxe2z9NHCcLy/m5
X-Google-Smtp-Source: ABdhPJz03PZ1ctx6US/HQo/SGmt/9jn5OMdKWd75V+MKGSyaiUavn+bDabmGnBrehBd/6IEh4DSOYQ==
X-Received: by 2002:a67:c889:: with SMTP id v9mr5953435vsk.30.1643124353063;
        Tue, 25 Jan 2022 07:25:53 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id g22sm1114451vsk.26.2022.01.25.07.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 07:25:51 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id b37so20321618uad.12;
        Tue, 25 Jan 2022 07:25:51 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr3702988vse.38.1643124351338;
 Tue, 25 Jan 2022 07:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20220118182003.3385019-1-keescook@chromium.org> <CAMuHMdWu-unMfV1U_HAKwJwPkB_LY3kU88_D69M=bX8y1B=QTg@mail.gmail.com>
In-Reply-To: <CAMuHMdWu-unMfV1U_HAKwJwPkB_LY3kU88_D69M=bX8y1B=QTg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jan 2022 16:25:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXzEWN7B122ca279t4RPSSWGL29jzTgMdSoJ+Y56jEQYw@mail.gmail.com>
Message-ID: <CAMuHMdXzEWN7B122ca279t4RPSSWGL29jzTgMdSoJ+Y56jEQYw@mail.gmail.com>
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

On Tue, Jan 25, 2022 at 3:20 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Jan 21, 2022 at 12:33 AM Kees Cook <keescook@chromium.org> wrote:
> > The at25 driver regressed in v5.17-rc1 due to a broken conflict
> > resolution: the allocation of the object was accidentally removed. Restore
> > it.
> >
> > This was found when building under CONFIG_FORTIFY_SOURCE=y and
> > -Warray-bounds, which complained about strncpy() being used against an
> > empty object:
> >
> > In function 'strncpy',
> >     inlined from 'at25_fw_to_chip.constprop' at drivers/misc/eeprom/at25.c:312:2:
> > ./include/linux/fortify-string.h:48:33: warning: '__builtin_strncpy' offset [0, 9] is out of the bounds [0, 0] [-Warray-bounds]
> >    48 | #define __underlying_strncpy    __builtin_strncpy
> >       |                                 ^
> > ./include/linux/fortify-string.h:59:16: note: in expansion of macro '__underlying_strncpy'
> >    59 |         return __underlying_strncpy(p, q, size);
> >       |                ^~~~~~~~~~~~~~~~~~~~
> > In function 'strncpy',
> >     inlined from 'at25_fram_to_chip' at drivers/misc/eeprom/at25.c:373:2,
> >     inlined from 'at25_probe' at drivers/misc/eeprom/at25.c:453:10:
> > ./include/linux/fortify-string.h:48:33: warning: '__builtin_strncpy' offset [0, 9] is out of the bounds [0, 0] [-Warray-bounds]
> >    48 | #define __underlying_strncpy    __builtin_strncpy
> >       |                                 ^
> > ./include/linux/fortify-string.h:59:16: note: in expansion of macro '__underlying_strncpy'
> >    59 |         return __underlying_strncpy(p, q, size);
> >       |                ^~~~~~~~~~~~~~~~~~~~
>
> On real hardware:
>
>     Unable to handle kernel access to user memory outside uaccess
> routines at virtual address 0000000000000028
>     ...
>     pc : __mutex_init+0x20/0x68
>     lr : at25_probe+0x8c/0x4d8

To avoid confusion: of course the crash happens only without Kees'
patch.  I just wanted to point out what happens when you boot on
real hardware, as it might be worthwhile to add that to the commit
description.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
