Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880BB48AE09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbiAKM6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:58:08 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:35660 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbiAKM6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:58:03 -0500
Received: by mail-ua1-f43.google.com with SMTP id m90so14257299uam.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 04:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Az9SJsw+wZpmJKB6Xg6YAXw2YkxdJkbobQxJTC0e2pw=;
        b=ucrAI6P1Z+GeXW+Au/TMmB8VlVZgvqusPNmNHdnArKrWh4IxTilmPqHWfUWpSElvqW
         XsQ+kYIAkEXBD1OCS7CTu66KJ0wdXQ45mMkMHw0LvMFQc+dBlSCPevgmJ2NBLEvCh1eP
         Q51xSAjiDDc14NNp5hvl4LATT+MhGtG5Th7Xwwo8fKL3H8DR6+csSBmbUyznGU7JCDrD
         KxDY65qqri0BEa0Asfd8TutFcJ5YRaZcjMcCfJwUw6S+Peku8ttF3xBqnPemzZEUfE9b
         YNr1T8cdKxSIMEzfNFRhu7kiEi85NMfp5gDd9ioLhJbbnOQ21Kv2X1gMShByF4N6EIhE
         /6oQ==
X-Gm-Message-State: AOAM532YBoc2Sh2WP1nPoSrlmMUlAG2mfThXF/b8lmDthVvMRpgsQKyt
        gqmPUncfI5ND9CGfuM8VhxZaAz6MpOkgfw==
X-Google-Smtp-Source: ABdhPJyHaYaVrrxzm/kvqu6Hs2sPIxxgFC7V89jTWlIN6Apz2jIV0lSb5lJdgQI2/0VIb7LFB3nIoQ==
X-Received: by 2002:ab0:5973:: with SMTP id o48mr1763465uad.54.1641905882901;
        Tue, 11 Jan 2022 04:58:02 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id e74sm5406984vke.51.2022.01.11.04.58.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 04:58:02 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id n124so5631686vke.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 04:58:02 -0800 (PST)
X-Received: by 2002:ac5:c967:: with SMTP id t7mr2170857vkm.20.1641905882170;
 Tue, 11 Jan 2022 04:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20211223141113.1240679-1-Jason@zx2c4.com> <20211223141113.1240679-2-Jason@zx2c4.com>
 <CAMuHMdU0spv9X_wErkBBWQ9kV9f1zE_YNcu5nPbTG_64Lh_h0w@mail.gmail.com>
 <CAHmME9pZu-UvCK=uP-sxXL127BmbjmrD2=M7cNd9vHdJEsverw@mail.gmail.com> <Yd18+iQ8zicsSPa0@zx2c4.com>
In-Reply-To: <Yd18+iQ8zicsSPa0@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Jan 2022 13:57:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVJSAe_uQ0yzBL9gkzhW+8Po81Eh332NFENMHCUqbw-dQ@mail.gmail.com>
Message-ID: <CAMuHMdVJSAe_uQ0yzBL9gkzhW+8Po81Eh332NFENMHCUqbw-dQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, Jan 11, 2022 at 1:50 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Tue, Jan 11, 2022 at 1:28 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > If you're really quite concerned about m68k code size, I can probably

It's not just m68k. There exist ARM SoCs with 8 MiB builtin SRAM that
are used in products running Linux.

> > do some things to reduce that. For example, blake2s256_hmac is only
> > used by wireguard and it could probably be made local there. And with
> > some trivial loop re-rolling, I can shave off another 2300 bytes. And
> > I bet I can find a few other things too. The question is: how
> > important is this to you?
>
> And with another trick (see below), another extra 1000 bytes or so
> shaved off. Aside from moving blake2s256_hmac, I'm not really super
> enthusiastic about making these changes, but depending on how important
> this is to you, maybe we can make something work. There are probably
> additional possibilities too with the code.

Cool, much more than 1000 bytes:

add/remove: 1/0 grow/shrink: 0/1 up/down: 160/-4032 (-3872)
Function                                     old     new   delta
blake2s_sigma                                  -     160    +160
blake2s_compress_generic                    4448     416   -4032
Total: Before=4227876, After=4224004, chg -0.09%

I don't know what the impact is on performance, and if the compiler
might do a good job unrolling this again when performance matters
(i.e. if CONFIG_CC_OPTIMIZE_FOR_SIZE is not set).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
