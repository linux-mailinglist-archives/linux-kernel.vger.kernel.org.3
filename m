Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83CF4C11D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbiBWLtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiBWLtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:49:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037E1E99;
        Wed, 23 Feb 2022 03:49:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B18D3B81F01;
        Wed, 23 Feb 2022 11:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2F0C340F5;
        Wed, 23 Feb 2022 11:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645616951;
        bh=+ioWVHNgMYeDeBDsUP7f/drz0hwa8yRvXmdVGF3eiFQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=amipTyugIxJO3OK3SYdgOFAUabSp6w39r0/eyVWT+fJDXgPBbmQOnORSBUTQR+O0Z
         bjZnZzvujx/rFKnqDifCEtVemDXzMXqCYKkWzWDOVRjTqXoFletbgV1Av+aN7SdIdv
         ls/RPtf/RUjv5uqSdUbrTvKFxt/BGjABV70qd1mf2zDB9oVwFHEZKP3LdgQ0rK66jn
         Cy0KwhZpUuoUvvLku+ZvlMUo7MuzAAzpc323fDtqdartLYEiI2YbFLE5m6bEWe0vQ0
         KvVXhHWvrqeFmU0UBHkCw5wWBJrMROVNWfDNRBUdmFK0gB7WfGkZosotO2JFzH6qFq
         NqlkwHQKA7Yuw==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2d641c31776so207344117b3.12;
        Wed, 23 Feb 2022 03:49:11 -0800 (PST)
X-Gm-Message-State: AOAM531FmkAkHwypMZMbzEO1qM6HqEvbzbH0S7SZ3J98W+sstX18ySYc
        ypgn7AmAjliO6BucVd44MMyY3g0dstlBQNeZ3co=
X-Google-Smtp-Source: ABdhPJwQIornAPE/LrSfmaLY9p5F4ZAJgJS6+jzrvvmVxK04wF1Vvvs+R7teI3vNg74R7BJvxG5X95O2qSVBFpjInRc=
X-Received: by 2002:a81:4a45:0:b0:2d6:b212:6a76 with SMTP id
 x66-20020a814a45000000b002d6b2126a76mr26808813ywa.60.1645616950272; Wed, 23
 Feb 2022 03:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20220222095736.24898-1-ashimida@linux.alibaba.com> <YhUvp5RHkTlBXX3o@lakrids>
In-Reply-To: <YhUvp5RHkTlBXX3o@lakrids>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Feb 2022 12:48:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHXz_CFL1A53J+h6EgRCKcrRfd_pMAy9Z+PztfzZYAawg@mail.gmail.com>
Message-ID: <CAMj1kXHXz_CFL1A53J+h6EgRCKcrRfd_pMAy9Z+PztfzZYAawg@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] AARCH64: Add gcc Shadow Call Stack support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Dan Li <ashimida@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, luc.vanoostenryck@gmail.com,
        Marco Elver <elver@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 at 19:48, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi,
>
> On Tue, Feb 22, 2022 at 01:57:36AM -0800, Dan Li wrote:
> > Shadow call stack is available in GCC > 11.2.0, this patch makes
> > the corresponding kernel configuration available when compiling
> > the kernel with gcc.
>
> Neat!
>
> My local GCC devs told me that means GCC 12.x.x rather than 11.2.x or
> 11.3.x, so as others have said it'd be clearer to say `GCC >= 12.0.0`.
>
> I'd like to try this with a GCC binary before I provide an Ack or R-b;
> but in the mean time I have a few comments below.
>
> > Note that the implementation in GCC is slightly different from Clang.
> > With SCS enabled, functions will only pop x30 once in the epilogue,
> > like:
> >
> >    str     x30, [x18], #8
> >    stp     x29, x30, [sp, #-16]!
> >    ......
> > -  ldp     x29, x30, [sp], #16          //clang
> > +  ldr     x29, [sp], #16       //GCC
> >    ldr     x30, [x18, #-8]!
>
> Given the prologue still pushes both x29 and x30 (which we critically
> depend upon) that sounds OK to me.
>

Indeed.

What did come up in the discussion on the GCC side was runtime
patching (to avoid the overhead of having both PAC and SCS), but it
seems far more likely that we would patch PACIASP/AUTIASP instructions
into SCS pushes/pops rather than the other way around, and so loading
x30 only once should be fine.
