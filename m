Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296D04D7422
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 10:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiCMJ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 05:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiCMJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 05:59:18 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE48286E28;
        Sun, 13 Mar 2022 01:58:06 -0800 (PST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 22D9vU86012387;
        Sun, 13 Mar 2022 18:57:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 22D9vU86012387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1647165451;
        bh=CVkDJWyjpgTbqf6NbvF5iJ65YgXX8GQWf/kMJmCia3g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r9LI2x/9NAE1AoERxMehOCqYpS9WGx0aX+pWHCwYe9rLf14pmrAZXu0d+6bcuSwjr
         5NiporrUwu4R2//I8cUEyARY012ijFlVWZJLEKbj7+PW/tLsSR3gIXwzvia8b0MiRV
         nMC6BELhGc/zWrubnXgpjqB5j5wXWkqFWDlEIwKoy/e35UtiOj50bMLBNbauV+rnEh
         qiCx8d8pRHVAE2KMSaqjZuXyAIPND7WcLwqp2jCKu9pIp8IrtE5JKMWdjrdzroREjI
         K3QY4g6m8AFTTD1kWqeQTqMBVxL45YHe5hl9ccyuyKTtv//oVEYpPXPinKsyhtbZ5R
         ZlmBbXQ3WxaTA==
X-Nifty-SrcIP: [209.85.210.178]
Received: by mail-pf1-f178.google.com with SMTP id h2so7769220pfh.6;
        Sun, 13 Mar 2022 01:57:30 -0800 (PST)
X-Gm-Message-State: AOAM530acmuzjnJs6hZo7IAG1pAFPqQAAxIoaajNkcfg27XVtOBmeweD
        sQR+xzwAKm0ncyIS1tJuSPFNpIqxfLk1B/ycq+8=
X-Google-Smtp-Source: ABdhPJzT5Nq4XZCfY/Rsvf1/ZbAx301JNi+kv1+XtIjZ5cbv7gStF2u34m1AvSCoAQBU1vfZQOvAbOSGxl7Lc/8zh58=
X-Received: by 2002:a05:6a00:24cd:b0:4f7:2340:a6cf with SMTP id
 d13-20020a056a0024cd00b004f72340a6cfmr18488551pfv.36.1647165450123; Sun, 13
 Mar 2022 01:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20220305125605.149913-1-masahiroy@kernel.org> <CAKwvOdkYs8wkFOGpPc6SKY8CSFHdT8t_AJdFTkSCr+43dm20Mg@mail.gmail.com>
In-Reply-To: <CAKwvOdkYs8wkFOGpPc6SKY8CSFHdT8t_AJdFTkSCr+43dm20Mg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 13 Mar 2022 18:56:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASbauVkv298jVZhgEnKGSznKSwyA82kEBL39E1KvsMx3w@mail.gmail.com>
Message-ID: <CAK7LNASbauVkv298jVZhgEnKGSznKSwyA82kEBL39E1KvsMx3w@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add --target to correctly cross-compile UAPI
 headers with Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Fangrui Song <maskray@google.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 4:16 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sat, Mar 5, 2022 at 4:56 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > When you compile-test UAPI headers (CONFIG_UAPI_HEADER_TEST=y) with
> > Clang, they are currently compiled for the host target (likely x86_64)
> > regardless of the given ARCH=.
> >
> > In fact, some exported headers include libc headers. For example,
> > include/uapi/linux/agpgart.h includes <stdlib.h> after being exported.
> > The header search paths should match to the target we are compiling
> > them for.
>
> Isn't that a bug in that header though? Why does it inconsistently use
> size_t vs. __kernel_size_t. Shouldn't it be consistently using
> __kernel_size_t? (Seeing TRUE/FALSE defined in such a low level header
> is also *yikes*.) Are there platforms where sizeof(size_t) !=
> sizeof(__kernel_size_t)?

size_t and __kernel_size_t are always the same.

For uapi headers  (include/uapi, arch/*/include/uapi), __kernel_size_t
should be used.


See this series, which is already available in linux-next.

https://lore.kernel.org/all/20220210021129.3386083-1-masahiroy@kernel.org/


>
> Usually to bootstrap a toolchain you need to start with kernel headers
> to bootstrap the libc.  It seems like some kind of circular dependency
> to me if kernel headers are dependent on libc headers.

Right, ideally, UAPI headers should be self-contained.
Hence, CONFIG_UAPI_HEADER_TEST exists.
But, I am not sure how far we can obey this rule.

Arnd Bergmann is an expert in this area.

The number of "no-header-test" in usr/include/Makefile
is gradually decreasing, but there are still more than 30.
They must be checked one by one.





> Hence my
> previous comment about -ffreestanding.

To ensure that we are not including any header from the system,
-nostdinc is a more correct flag.


-ffreestanding still allows system headers to be included.


I am skeptical about adding -ffreestanding here.
Please note we are compiling the user-space on the operating
system (this is what is called "hosted environment", which is
opposed to the "freestanding environment").




>
> >
> > Pick up the --target triple from KBUILD_CFLAGS in the same ways as
> > commit 7f58b487e9ff ("kbuild: make Clang build userprogs for target
> > architecture").
>
> Oh boy thanks for finding+fixing this! I still suspect we shouldn't
> need a cross-libc for UAPI header testing, and that the kernel headers
> simply need to be cleaned up. But regardless of that it doesn't make
> sense to use the wrong target when checking headers generated for the
> target. Thanks for the patch (and sorry I've been falling behind on
> code review lately).
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v2:
> >   - Reword the commit description to mention agpgart.h instead of
> >     asound.h because the latter is in the no-header-test list.
> >
> >  usr/include/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/usr/include/Makefile b/usr/include/Makefile
> > index ac206fb27c65..4215801e1110 100644
> > --- a/usr/include/Makefile
> > +++ b/usr/include/Makefile
> > @@ -10,7 +10,7 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
> >
> >  # In theory, we do not care -m32 or -m64 for header compile tests.
> >  # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
> > -UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
> > +UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
> >
> >  # USERCFLAGS might contain sysroot location for CC.
> >  UAPI_CFLAGS += $(USERCFLAGS)
> > --
> > 2.32.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
