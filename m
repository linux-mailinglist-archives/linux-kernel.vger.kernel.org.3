Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62A654FB23
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383271AbiFQQce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383264AbiFQQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:32:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C29C44A00
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:32:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c4so7690821lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1BjKgqzkb8k+EA7WjeZGM7NzWRat+g8ENXrH+yDNT4=;
        b=Z0GR2WW0woH/OoKC6xJWNeyL+rmtSqQdxLlC1Z61A8J2I+X8zkigvk3PzSTuIlU9HB
         JkXkHXUrdOCrpkmRWFpD81AsGgKg9Dma67Xjd8ZkXGiCjOn+Ji/xHZpqbChUI+olxA8t
         z3lroIvPfZSWQ4L2BvV+nT+4c8YuZuIcwUwn/V79cvUEXemsyfI9r5BP+17egzxmUKRM
         Qadg7PkTBQigP9DiBEi+ggHuICrsi5+s2yzH0D/kBKaboQHTiSXiS59e+eZ3Vogls8mW
         /p5YjGspCFAkdN5RqeI8gx84VnLnvAIcji/rifoh8Mfn4fuxn1LwoSqV11ps+ZtIQ5Ig
         am6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1BjKgqzkb8k+EA7WjeZGM7NzWRat+g8ENXrH+yDNT4=;
        b=fuy9zstIaKeLPDW9XHIvMkdFLMpqCSF6YBfMHaPHwO7+53ehlZJPq1Z3zF8kodsXTD
         4ene6rTQ9Wm18I7pvJCZIyqJ6i1JShhRykmLp/K9g5xaiL16ZJNmjOCCdT1p3Bsu97Ma
         Oj1WGbZMMNDNDy3HN4/xx+cj4ExWmGvayARSPn/kubqkDlxQ6huFFzX+48wX+9uDrkUW
         z6RpMOiwHAtMFpsR6kR4bxl2XPqX9biTHtiCr/FEXBGA/hHW/ZGO4hpPHYQR6csCEZMF
         0m4SNorWpbRX1PEIc7jaKDVlLfRdGGa+qklcFAiAkQqwnqaRtNUvYu7CSJ6WIjOVXTaI
         sJXg==
X-Gm-Message-State: AJIora+zIQ7zjxcPBGyVwSwu2OjMIh6elXdidRuS2BCXooJKgf4/R3AQ
        TlxsZ7dmgx9otBxiPNZc3qU2Np5l4UfvYnUIeuhZfw==
X-Google-Smtp-Source: AGRyM1tQkylKKg1KNaqr/lKtvraCKG7e+Kb14y5tKT0S4FILqUkpk+GYk2MmyU3A0RHdixGbQXfov2i5Mn+0wGRPa1k=
X-Received: by 2002:a05:6512:3f9f:b0:47d:c87e:f8f3 with SMTP id
 x31-20020a0565123f9f00b0047dc87ef8f3mr6173106lfa.401.1655483546329; Fri, 17
 Jun 2022 09:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220616104541.16289-1-jslaby@suse.cz> <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
 <CA+icZUV6bM2_jxyROK5B4XRid6fv8oX6YYNEdHUX8e_1OAdQYA@mail.gmail.com> <CA+icZUUSTcrJqZB-gwNYt5objVg1J5+Ous6_hof0_A6eVCM-Kg@mail.gmail.com>
In-Reply-To: <CA+icZUUSTcrJqZB-gwNYt5objVg1J5+Ous6_hof0_A6eVCM-Kg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Jun 2022 09:32:15 -0700
Message-ID: <CAKwvOdmb5xdF70TzNp=4STCpzkGh16FnuKE1KbdzDhHt=OuRFA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
To:     Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 3:35 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jun 17, 2022 at 12:53 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Thu, Jun 16, 2022 at 4:09 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Thu, Jun 16, 2022 at 12:45 PM Jiri Slaby <jslaby@suse.cz> wrote:
> > > >
> > > > Until the link-vmlinux.sh split (cf. the commit below), the linker was
> > > > run with jobserver set in MAKEFLAGS. After the split, the command in
> > > > Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
> > > > is lost.
> > > >
> > > > Restore it as linkers working in parallel (esp. the LTO ones) make a use
> > > > of it.

TBH, I agree with Masahiro. I didn't understand this comment "esp. the
LTO ones."  Jiri, can you clarify what you mean here?

> [ CC Nathan and Sami ]
>
> I re-checked as my build-time takes approx. 15mins more than usual
> with Linux v5.17.
>
> [ Perf - seconds time elapsed ]
> v5.17: approx. 12500
> v5.19: approx. 13500
>
> +1.000 secs = +16,67mins

Does this patch make a difference?
https://lore.kernel.org/linux-kbuild/20220616195759.3214538-1-samitolvanen@google.com/

-- 
Thanks,
~Nick Desaulniers
