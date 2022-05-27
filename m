Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9835366AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244575AbiE0Rm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbiE0Rmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:42:54 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA2139BB7;
        Fri, 27 May 2022 10:42:49 -0700 (PDT)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 24RHgUrI002068;
        Sat, 28 May 2022 02:42:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 24RHgUrI002068
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653673351;
        bh=vO9l5kDkkTIQWSumWYQ1Vkw7B/XqoY7ZfQPx5PWESBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t/RUfi9Sh5h28itWUOQb0HeUskZksbBYC0U2grK7iHf83mD7gmeY6+WY5DQxn2pst
         LvLeoRRjNyowE7U7Ni7dLwGqtu3YaqFDS+74L/C9BQmYytoqcbwBSObFeNnGRYteH9
         64VVJtWv5hAMA0wIGEx51mm5eCKE3rPpd6hx7aZ6rH/eJ21NQbHHOg+PHw67DGzXRF
         XH0qHk5Rc6FVAxgFPdVeQ+US4wPL5p3JNeJJxXjvDebmzBAdAguNm7pZhK3Jkl8KGj
         K1w5TWxnznynXACulsOv5l5mWjTlvaR/6XbUvRm/irKTe9HzptX5huwsjXrvHWUoop
         XK1vn5dmbrHtA==
X-Nifty-SrcIP: [209.85.214.182]
Received: by mail-pl1-f182.google.com with SMTP id m1so4735152plx.3;
        Fri, 27 May 2022 10:42:30 -0700 (PDT)
X-Gm-Message-State: AOAM533KckRom8nyn2mzA2yPpVGuC5o0nlVMK610CP6xZqv3IiC1HGRl
        PNT/30uXYdoDPfE98SkiKHC/8nQUdktwPzZdH9E=
X-Google-Smtp-Source: ABdhPJwMiVJv7kLsX2ZZRH8xMYaGS8e37WqzfbRucz+6H3VdKMbNmq62R7H5jsGDhOOZp00zV+5CyfxMkWGovyzpsEM=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr44301921plh.99.1653673349915; Fri, 27
 May 2022 10:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220527100155.1996314-1-masahiroy@kernel.org>
 <20220527100155.1996314-9-masahiroy@kernel.org> <20220527155053.i4xfrlupuqfu4kem@treble>
In-Reply-To: <20220527155053.i4xfrlupuqfu4kem@treble>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 28 May 2022 02:41:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkUJO=8GprusO6-o7=_yg2zVDPHecoNN_075a_Y4U-7w@mail.gmail.com>
Message-ID: <CAK7LNAQkUJO=8GprusO6-o7=_yg2zVDPHecoNN_075a_Y4U-7w@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] kbuild: rebuild multi-object modules when objtool
 is updated
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 12:50 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Fri, May 27, 2022 at 07:01:55PM +0900, Masahiro Yamada wrote:
> > When CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT is enabled, objtool for
> > multi-object modules is postponed until the objects are linked together.
> >
> > Make sure to re-run objtool and re-link multi-object modules when
> > objtool is updated.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > Reviewed-by: Nicolas Schier <n.schier@avm.de>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)
>
> Hi Masahiro,
>
> Is it also possible to rebuild vmlinux.o when objtool changes, for
> CONFIG_LTO_CLANG, CONFIG_X86_KERNEL_IBT, or CONFIG_NOINSTR_VALIDATION?
> That doesn't seem to be happening.
>
> --
> Josh

Yes.
Actually, it is already on my TODO list,
but it requires more effort.

I will aim for v5.20.







-- 
Best Regards
Masahiro Yamada
