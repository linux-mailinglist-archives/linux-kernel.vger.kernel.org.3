Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2985354228A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiFHBI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384308AbiFGVy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:54:26 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1BC24ACB0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:13:28 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x7so13367470qta.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4teGkJzSagIZsgcLH+V56SrWNU+r6L/guCBWA6f0Qx0=;
        b=3OtrolWNBaQ/dE9qE4EGS7WgvMx2oysccdSM1jEL25Kn+6RkTPIDbl3pl6Rl1Q0dTF
         pLmjhp5oxcUt7N1zKlZe2YAyt09pXOHzG9fq7/+RfNwvcD8V6X01TUifaLzkyfWIfdxz
         FjnKTNT7AjjPVl3urL7aoTdg5e6GF/wQB0JZfBDxBtUeAStrupA6cyNk43lCSoTH0nlO
         pnIXWsYD2GjkJw8ItmvKGASfqgdTZ5zBDCIrCJfpNKRwqf2CO8uSULfV00nlO6QkGwfl
         Yz3j0tKnNy2gB7tALH2PQZQhXEQuVBKT20wzioUzWnTP3wQv7q15V1aS6ypEbxfoQBTZ
         6flg==
X-Gm-Message-State: AOAM532D3LAECNtwYqFPB94Q37/epJPhmdYa0Zh8er3tWk9rXvJSo0eb
        VKa+6ZQZr4JyC1kwHye/2xXREogEKaLKtg==
X-Google-Smtp-Source: ABdhPJxHWbwkc1XDusK9z603PBe4aFo2yqSvJ2ginHeVApmUqepWDePUCiNKSuD+3h9rxyuCnen0QQ==
X-Received: by 2002:a05:622a:20a:b0:304:f641:d715 with SMTP id b10-20020a05622a020a00b00304f641d715mr5478865qtx.436.1654629146820;
        Tue, 07 Jun 2022 12:12:26 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a284a00b006a6e13e2b4bsm1865129qkp.24.2022.06.07.12.12.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 12:12:26 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id w2so32702466ybi.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:12:26 -0700 (PDT)
X-Received: by 2002:a25:cc53:0:b0:65c:b19c:fac1 with SMTP id
 l80-20020a25cc53000000b0065cb19cfac1mr30127900ybf.89.1654629145915; Tue, 07
 Jun 2022 12:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tw62EZfAm0PbiOPmMrpfR98QMFTWGEQcA34G4ap4xxNkA@mail.gmail.com>
 <CAMuHMdXb5-gOVRsQx6tDqjQMD9cC-p=o56VuF2cBPWyMFRgHMA@mail.gmail.com> <CAHk-=wgcv_YewP0rgwR1+gj3YF-7Jz8WPVzDgndx0DVMVKzV=Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgcv_YewP0rgwR1+gj3YF-7Jz8WPVzDgndx0DVMVKzV=Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Jun 2022 21:12:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-HQZ3ZozS8AEP2P6aU3eMp6jO-GYOCOFOju_rcxOg+w@mail.gmail.com>
Message-ID: <CAMuHMdU-HQZ3ZozS8AEP2P6aU3eMp6jO-GYOCOFOju_rcxOg+w@mail.gmail.com>
Subject: Re: [git pull] drm for 5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Jun 7, 2022 at 8:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jun 7, 2022 at 3:23 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > These header files are heavy users of large constants lacking the "U"
> > suffix e.g.:
> >
> >     #define NB_ADAPTER_ID__SUBSYSTEM_ID_MASK 0xFFFF0000L
>
> As Andreas says, this is not undefined behavior.
>
> A hexadecimal integer constant will always get a type that fits the
> actual value. So on a 32-bit architecture, because 0xFFFF0000 doesn't
> fit in 'long', it will automatically become 'unsigned long'.
>
> Now, a C compiler might still warn about such implicit type
> conversions, but I'd be a bit surprised if any version of gcc actually
> would do that, because this behavior for hex constants is *very*
> traditional, and very common.
>
> It's also true that the type of the constant - but not the value -
> will be different on 32-bit and 64-bit architectures (ie on 64-bit, it
> will be plain "long" and never extended to "unsigned long", because
> the hex value obviously fits just fine).
>
> I don't see any normal situation where that really matters, since any
> normal use will have the same result.
>
> The case you point to at
>
>   https://lore.kernel.org/r/CAK8P3a0QrihBR_2FQ7uZ5w2JmLjv7czfrrarCMmJOhvNdJ3p9g@mail.gmail.com
>
> is very different, because the constant "1" is always just a plain
> signed "int". So when you do "(1 << 31)", that is now a signed integer
> with the top bit set, and so it will have an actual negative value,
> and that can cause various problems (when right-shifted, or when
> compared to other values).
>
> But hexadecimal constants can be signed types, but they never have
> negative values.

Thank you, I stand corrected.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
