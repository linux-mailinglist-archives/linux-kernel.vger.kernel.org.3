Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA00951ED7D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiEHMlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiEHMlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:41:16 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2B1261F
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:37:26 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2ef5380669cso119721757b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 05:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VuJms/7a1Fox6UxpgPi9Undwrl7KJZiaeog6B+JELcQ=;
        b=ybmIW7T5t43ZPNwEQL+rAnQdovWfEUDtovGqS16yWN4UtHFcnKa02ohqPtBFVPjnAd
         WtjEAbp6oUGVWDjKuIKp30+cLQKUhs1P3jYsnkjYL7LFuID+E9oI6Lv9WkvoIRR4ytYq
         wqxbDSIzoDeucb9XM+UjJvtZyU8vY6TZq2sSK/NlrrpDg0PwVgQ0GrAN2lvu/1ZfBDkE
         lOc+YQ3lPGCUY2XRGtl+fntttry2yWMgZrHp/RDfFOt9VFoE90Qrd3hPlluWefbRGRFP
         BSG19GDwJVbOAZ5rxUESwV5lBRLIZqZjqidgMaSjuo+/uGR5sxvSBPbBf0q7OKPEhNPj
         vmVQ==
X-Gm-Message-State: AOAM5325K+6N8KEzUp50cKzqk6p1rCCIEfSyTheB3M/PvysV9/VT0gRu
        GQJdVuy39B3Jn4Ca1ht/eVC7LImQ7sIjOqzRUig=
X-Google-Smtp-Source: ABdhPJwqPVBmsbXYYleGS+D6FFVgxG71RmE5EyifsmaLuQSBOUC4KaebQhU7H5hZiCQNN/alYIXz1JtjByrUlXJG2AA=
X-Received: by 2002:a81:8cf:0:b0:2f4:da59:9eef with SMTP id
 198-20020a8108cf000000b002f4da599eefmr10253166ywi.78.1652013445268; Sun, 08
 May 2022 05:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220306171009.1973074-1-mailhol.vincent@wanadoo.fr>
 <20220508100907.61231-1-mailhol.vincent@wanadoo.fr> <CAK8P3a3Fw2T0WSkxv4DiTG2wGkKcs24StPx-BG_vi=ffa9OLVA@mail.gmail.com>
In-Reply-To: <CAK8P3a3Fw2T0WSkxv4DiTG2wGkKcs24StPx-BG_vi=ffa9OLVA@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 8 May 2022 21:37:14 +0900
Message-ID: <CAMZ6RqK9d0hFwYebaArKjod4LJVGQgfDygpbGdBu-4BCDUR_SA@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] x86/build: add -fno-builtin flag to prevent shadowing
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>
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

Hi Arnd,

+CC: Kees Cook

On Sun. 8 May 2022 at 19:27, Arnd Bergmann <arnd@kernel.org> wrote:
> On Sun, May 8, 2022 at 12:09 PM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > Aside of the __builtin_foo() ones, x86 does not directly rely on any
> > builtin functions.
> >
> > However, such builtin functions are not explicitly deactivated,
> > creating some collisions, concrete example being ffs() from bitops.h,
> > c.f.:
> >
> > | ./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs' shadows a built-in function [-Wshadow]
> > |   283 | static __always_inline int ffs(int x)
> >
> > This patch adds -fno-builtin to KBUILD_CFLAGS for the x86
> > architectures in order to prevent shadowing of builtin functions.
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> > FYI, I tested this patch on a "make allyesconfig" for both x86_32 and
> > x86_64.
> >
> > This is a resend. Only difference is that I dropped the RFC flag and
> > added Arnd in CC because he did a similar patch to fix ffs shadow
> > warnings in the past:
> >
> > https://lore.kernel.org/all/20201026160006.3704027-1-arnd@kernel.org/
>
> I think this is a correct change, but unfortunately it exposes a clang bug
>  with -mregparm=3. Nick should be able to provide more details, I think
> he has a plan.

Interesting. I admittedly did not do extensive tests on clang
but I would have expected the Linux kernel bot to have warned me
on my previous patch.

I did research on mregparm and clang. I found this thread:
https://lore.kernel.org/r/20220208225350.1331628-9-keescook@chromium.org

and the associated LLVM issue:
https://github.com/llvm/llvm-project/issues/53645

Those threads mention that some clang builtins become unusable
when combining -mregparm=3 and -m32. But I could not find a
bug reference about -mregparm=3 and -fno-builtin combination.

Could you just double confirm that you indeed saw the issue with
-fno-builtin? If that the case, I am really curious to get the
details :)


Yours sincerely,
Vincent Mailhol
