Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8100F532D01
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiEXPMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238713AbiEXPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:12:17 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D502A63BC2;
        Tue, 24 May 2022 08:12:12 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id t13so5151443ilm.9;
        Tue, 24 May 2022 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gu6XrP09brfzVASce66siSDhg75Ij5bF3a/2sse9FTI=;
        b=Gx5DLI2+S6FgASvjmxzOMLEBTLLzoAeOJHUNf3qse7ftzHJRZNKIGlYfA7vzGBgRTO
         qTgrr/QrMpssZBVPExxUekM5wFpDSCMG20g+mdIisIrrqbSj8j8ach4aeT+H+1CPDjcY
         ofuIYAFZ0a1ST0nZaCgMaH9g0s8MDKoG8WUVuGjlCh3vgQMUp8zwHIFKbe8dhL1HhQTe
         sZWf5vyTao7FwxYkNnBY5UxCjXGw7WvpGDwAKwR0hZcAz9ljJn2ttXMG4oHl2DC/BtQd
         krQkv/WkL/ceZkaPabiR+mwCrn4tbOibG9mbSGHQ9sK9s67DEn4CdB96hUXVE/XXsJbF
         NRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gu6XrP09brfzVASce66siSDhg75Ij5bF3a/2sse9FTI=;
        b=437c6i0vOdcyGq0Uidsdb1DAZmgoVljbw7JpnkngKVCpx16FoqkIVmhVun+Hgudw0G
         T0hkN4P0iBWDOSEUEWRmEseyEYosihqvyTiJvHNJmbrP4WRuDpyAkR20xtTcaBXUF/L7
         jdqaFmv+iCpofuroh0gKTXoEDH+/veq0p3L5qKsjb91EKfDaMTPigjCZumSCMKPp4chS
         E8HcqhTnZChw6GZP4yd963dNqBUdHeowEQocttVICM67T/uSTMPWeSVliZzE4izO/wiW
         jmQGU27nKAyZMTjKTCAB9zvxP6jYV8HLLf+G+KUVpi4fm96wS4MWcD3a2I/iYF9+CgZZ
         b4vw==
X-Gm-Message-State: AOAM530Aq8eg1igwpWpM1xNfdAUmNjiDhbP++NXEQsBpsev3SFxnmT3b
        2MVKlPKozSIAe9OLjdbXyh94uOvHhk6kRvzk7o+TVmHh1qPEnQ==
X-Google-Smtp-Source: ABdhPJxToNDnooDvM+F5z9jrpwZB87LsQbRXfl7xzsJlSJuT69wEeUzQA9y0IHhR27j6+JEjpMOS30/zFL5koffPamM=
X-Received: by 2002:a05:6e02:170b:b0:2cf:970f:6050 with SMTP id
 u11-20020a056e02170b00b002cf970f6050mr14549964ill.5.1653405130972; Tue, 24
 May 2022 08:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220523020209.11810-22-ojeda@kernel.org>
 <CAKwvOdkTjxNEmCTnuH5f41WB50ef6ErBM2Kp2zJ-t9q_5U8rBA@mail.gmail.com>
In-Reply-To: <CAKwvOdkTjxNEmCTnuH5f41WB50ef6ErBM2Kp2zJ-t9q_5U8rBA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 24 May 2022 17:12:00 +0200
Message-ID: <CANiq72=QJsScPweqWO8w6t4wDKKd3ZWFkA6Dcto6qpJ8QcfgOg@mail.gmail.com>
Subject: Re: [PATCH v7 21/25] Kbuild: add Rust support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
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
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 8:45 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I'm super not into having the rust optimization level differ from the
> C optimization level.  This is just someone having too much fun
> wrapping every compiler flag in a kbuild option.  Either folks wan't

I mean, `Makefile`s are not my favorite pastime... :)

> smaller size or more optimizations. Allowing for RUST_OPT_LEVEL_S and
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE or RUST_OPT_LEVEL_3 and
> CONFIG_CC_OPTIMIZE_FOR_SIZE is just wacky nonsense that's going to
> make randconfig bug reports more confusing to tease out.

I think what is important is to decide whether extra levels, for C and
Rust, should be kept compile-able/maintained or not (I also replied in
the `-O1` for C thread [1]).

Note that the Rust side can be compiled as `-O0` or `-O1` at the
moment, which is something we do not have for the C side; thus having
only the C == Rust option means we will not have a configuration with
those anymore.

For me it is less complex to not have them, and I have not heard more
opinions on this, either for or against (apart from that thread
suggesting `-O1` for the C side), so if nobody else chimes in, I will
remove them.

[1] https://lore.kernel.org/lkml/CANiq72kySVvOQ7eqwe0Jzz3V0JTtrcqODHR9Ty4-sfDMdzP6XQ@mail.gmail.com/

Cheers,
Miguel
