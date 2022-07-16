Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BFF576CAA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 10:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiGPI5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiGPI5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 04:57:43 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D35B7F4;
        Sat, 16 Jul 2022 01:57:42 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id w16so3143262ilh.0;
        Sat, 16 Jul 2022 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYks55HxgsoLlm9FNEz/2R9Y4bixjWKaygGPwKIVjx0=;
        b=m7RolDKDIlPqQgPf5OTP/N6sK1eysv8GJE4Xfn8CjMg0SxwuCaAjEySP55tmXp5JVI
         UpIwNpbxTFBX8XrQHPTU10osewAMlkpehUSHMxLE/z5AscetNKSTakXBmT4sFuZxvdSj
         6pLhVxcEz3FFMTM6nM4GdyvOJqmUEFJQCr3AOL0xm1yUFCsUy47Z3rBXZtMZzmMP/h9s
         7WpW+a65qg8gkRMjnKQbAyPOY44lzJH7wId88CcIuxY+ie25eQBbKgS5dR4nb4qAp0au
         boOEvL+LfokeBh3nWrS03XXVnUDvFPo3DxazMu+hCulyNuyUUotHieO4rDvfdCn9+u/Z
         mv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYks55HxgsoLlm9FNEz/2R9Y4bixjWKaygGPwKIVjx0=;
        b=ktvSdf4TMlb6Q1Hgv6aOYZpPzziBvaLsMchFmkogOS3H0KsNo45A3vYq5IIBzlZ2cx
         FHfO1TCWqKSjhkQtaTPtbJiH0vPdQOBjmIX6zjMr+gzOCv3NRQQB28+ya1uYcv/C3Z+n
         qMvSLAXKCn7YcxIh2Khg60uL8fAj63x6Ol/+HNSE6PRQvP1M/uit84mDsNuhnAuBcB0t
         DiLPKQwbKeTgdJRY69dfFzrqokJLfk4jR/Mvo+h1ErOcB5YlvPrIRSRdj913txzXf2kw
         /xK+u923Ofe2YHINzJ/1aVBqQ0ivEDIMLAhgMTwiwx4XI4KQzegauXIuKG2WO8uCTuzo
         3SHw==
X-Gm-Message-State: AJIora/my00CYN3G9LOlSE0yJvFck04MyC4PjO0xyGrs/jfUoT0LOqOY
        JgZCFT8N5WiVJUDHda09GvnnQwqHboUlppnEAv8=
X-Google-Smtp-Source: AGRyM1upiXNei9Ij258Ho2aijo3CxpUzFbH2CubB6AzfY4tMP/5ochBIlN/TgfrRN46dYIn9zQ7KIb7ZCJ9pwMhj3ew=
X-Received: by 2002:a05:6e02:1c8d:b0:2dc:8162:282e with SMTP id
 w13-20020a056e021c8d00b002dc8162282emr8874969ill.5.1657961861953; Sat, 16 Jul
 2022 01:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220523020209.11810-22-ojeda@kernel.org>
 <CAK7LNAQZOTjxJyS3WC1sM7LE-An7DL8xoW=-s1ONe7cq4YukNQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQZOTjxJyS3WC1sM7LE-An7DL8xoW=-s1ONe7cq4YukNQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 16 Jul 2022 10:57:30 +0200
Message-ID: <CANiq72k1aPQuvAL=TqNQVBZBmxojKfPBKU3v_2_B=731fhuJbQ@mail.gmail.com>
Subject: Re: [PATCH v7 21/25] Kbuild: add Rust support
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Daniel Xu <dxu@dxuuu.xyz>, Miguel Cano <macanroj@gmail.com>,
        David Gow <davidgow@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Sat, Jul 16, 2022 at 10:23 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Is it intentional to print the successful message to stderr?

I think it makes sense to change it to `stdout`, given the message is
the main point of running `rustavailable` for normal users, and those
that just want the status code may ignore it.

Thanks for taking a look again!

Cheers,
Miguel
