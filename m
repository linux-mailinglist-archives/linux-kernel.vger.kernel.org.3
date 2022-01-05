Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECEC484CDA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 04:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiAEDZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 22:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiAEDZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 22:25:03 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F354C061792
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 19:25:03 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 196so33952080pfw.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 19:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wkuN5scY3yiYZRl2fRuA4WGrOv7r3w+Jln9UFNacBQM=;
        b=sMREvPRxGZUwa08eFtR2hiuXSNQvK2z3b4UkIDQKPgoibmig3YKSC5pe3mtAttY7h4
         XwK6GVkzJlAQFD2wxzX0eBRmZPIqCLwyrJwVVyBuYbzzF8v1N7MwQVj3P7PuIuTVvo0A
         rEP82aGHqFCbL7ltVQA9rwNIlRiurCUsJqIQJ75u9fKPGEUjWr+Bd51S25yKt9bNwyWq
         rcSVy1OCjWXA6fj3PLmN+GdKcNL6LzYc5Ao8OxtZok7AYQCkWdnX56ev9cPw3c3+UGgs
         dVVe/F8gBmvEA8sYC1WCJBKNz2MM65RNUa7GnJFiSHqVSKWr0g4rG/r7YmFBeeHCDHyO
         Sfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wkuN5scY3yiYZRl2fRuA4WGrOv7r3w+Jln9UFNacBQM=;
        b=M+LhTLYx3nCT24j5NMb+rBSIAutBET8lzbw/ieLfuCvJH+ylLx6OZBKT1TwexCByvw
         gu+r4nXryEQwXHw6nIKfr1EWr+tGS63ckQndSCrjrFpW9IiGFWi5tZepxqCI/0Vr0Tuh
         TuQlsVBpeVcMtEOuZEvnv8tzBS6eT4w4Vyuz5IcT6d5s6RSBL9essIC4GeD+wbVBiqkP
         z+/5yu5px9c/JSBKmHhUbUqgu6C/+vTWBFaIFNiGwcA7CU1EybRh7GmI0jzkxPDJceti
         2EhS78YmS2m9pD2bZzybwine1+J1mveY6GMHWsogXK5IDQrLENL8RkVsG33ltRtVKSSt
         wNvQ==
X-Gm-Message-State: AOAM531V7FGl0XHGJGtaQBp34RCwreIWxp4hmv98jM+C44O4JlxOx+KZ
        v6uqrYqGLr06MzjmTURK54rQpQ==
X-Google-Smtp-Source: ABdhPJwILBGPaWIQmEOPR6iQ9ZbM+KK4UsIg1jEugYbcKOG7KIm+OYdMXveHNWvOBlsyyUCtrfOdgA==
X-Received: by 2002:a63:8149:: with SMTP id t70mr46472429pgd.71.1641353102364;
        Tue, 04 Jan 2022 19:25:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:b78:5a0b:6f2e:23e9])
        by smtp.gmail.com with ESMTPSA id a15sm663138pjo.49.2022.01.04.19.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 19:25:02 -0800 (PST)
Date:   Tue, 4 Jan 2022 19:24:56 -0800
From:   =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@alien8.de>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v9 02/15] livepatch: use `-z unique-symbol` if available
 to nuke pos-based search
Message-ID: <20220105032456.hs3od326sdl4zjv4@google.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
 <20211223002209.1092165-3-alexandr.lobakin@intel.com>
 <Yc2Tqc69W9ukKDI1@zn.tnic>
 <CAFP8O3K1mkiCGMTEeuSifZtr2piHsKTjP5TOA25nqpv2SrbzYQ@mail.gmail.com>
 <alpine.LSU.2.21.2201031447140.15051@pobox.suse.cz>
 <20220103160615.7904-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220103160615.7904-1-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-03, Alexander Lobakin wrote:
>From: Miroslav Benes <mbenes@suse.cz>
>Date: Mon, 3 Jan 2022 14:55:42 +0100 (CET)
>
>> On Thu, 30 Dec 2021, Fāng-ruì Sòng wrote:
>>
>> > On Thu, Dec 30, 2021 at 3:11 AM Borislav Petkov <bp@alien8.de> wrote:
>> > >
>> > > On Thu, Dec 23, 2021 at 01:21:56AM +0100, Alexander Lobakin wrote:
>> > > > [PATCH v9 02/15] livepatch: use `-z unique-symbol` if available to nuke pos-based search
>>
>> ...
>>
>> > Apologies since I haven't read the patch series.
>> >
>> > The option does not exist in ld.lld and I am a bit concerning about
>> > its semantics: https://maskray.me/blog/2020-11-15-explain-gnu-linker-options#z-unique-symbol
>> >
>> > I thought that someone forwarded my comments (originally posted months
>> > on a feature request ago) here but seems not.
>> > (I am a ld.lld maintainer.)
>>
>> Do you mean
>> https://lore.kernel.org/all/20210123225928.z5hkmaw6qjs2gu5g@google.com/T/#u
>> ?
>>
>> Unfortunately, it did not lead anywhere. I think that '-z unique-symbol'
>> option should work fine as long as the live patching is concerned. Maybe I
>> misunderstood but your concerns mentioned at the blog do not apply. The
>> stability is not an issue for us since we (KLP) always work with already
>> built and fixed kernel. And(at least) GCC already uses number suffices for
>> IPA clones and it has not been a problem anywhere.

The stability problem may not happen frequently but is possible if the
compiler performs some IPA with new code.

Such disturbence is probably more likely with LTO or PGO.
For Clang LTO, Makefile currently specifies -mllvm -import-instr-limit=5.
If a function close to the boundary happens to cross the boundary,
if inlined into other translation units, the stability issue may affect
many translation units.

>LLD doesn't have such an option, so FG-KASLR + livepatching builds
>wouldn't be available for LLVM with the current approach (or we'd
>still need a stub that prints "FG-KASLR is not compatible with
>sympos != 0").
>Unfortunately, I discovered this a bit late, just after sending this
>revision.
>
>OTOH, there's no easy alternative. <file + function> pair looks
>appealing, but is it even possible for now to implement in the
>kernel without much refactoring?

<file + symbol> pair looks good to me and will solve the stability problem.
