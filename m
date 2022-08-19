Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F07D5997BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347041AbiHSIlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347247AbiHSIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:41:22 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C63065A9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:41:20 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 27J8f3fl029474
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:41:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 27J8f3fl029474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660898464;
        bh=elvJSR7vlV3+9hGJEzaFU22AXaxpLvwDSpIIG1By0OI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M3MYw5zjV5tmsDfz0WFsSH/UHyRObGnMjQHRQIbuz8usKEC+WqfUf1m1b8UTo83vp
         BUyM4ek71n2Hn0pU8Z4VLRohkkimdwF7M5woCDpH5h2h6t+WJ8t7iay06GrbQ9J8/5
         LT5QRAujT4wyMKYFC8RJmrByE738Ys6XXk+a1OHdpA+YkKV3Zxlj4x3PbXAvmOT1KV
         +CCZaIfj9TsdQeo9gqOad5YScBylGl+ot/+vtWUkB1/IgdW9CAhZyoX6l0jLRKRWJP
         vX2s+987lDGTl5Wjc36KvNSwjRhh9yi1HwHmgwwgzFdFxYPJQrgSkq20v/64POjZPU
         iocaDjcSkhfpg==
X-Nifty-SrcIP: [209.85.221.50]
Received: by mail-wr1-f50.google.com with SMTP id e20so3879146wri.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:41:04 -0700 (PDT)
X-Gm-Message-State: ACgBeo2gkIQpsMmNXfDJz348i2XH6SHRJd+JHoylz2b6tX/eMWuMoiDQ
        KnnbzY7+29C6epOGBG1fvDOACr3gNIsZ7YPdKmY=
X-Google-Smtp-Source: AA6agR5HEcaN88E9g+nMSw3Osr2KzWiyDKgo9L6/Vq73IbJZblciYjk3mFszyHCGnZGpJJCir8rmACLMq4lo18gHGGA=
X-Received: by 2002:a05:6000:1acb:b0:223:5de3:f8bf with SMTP id
 i11-20020a0560001acb00b002235de3f8bfmr3503379wry.691.1660898462663; Fri, 19
 Aug 2022 01:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220804190320.262510-1-alexandre.belloni@bootlin.com>
 <CAKwvOd=3N8_Rx1P8J7pVnjM6sEzJA233BnwmD1VyMRqgujq2_Q@mail.gmail.com>
 <7eacd1d9-42ba-fd61-7f37-0635cebcb33d@infradead.org> <e902a360e3759c7f87d98d71d79a0d5cbe935e3e.camel@linuxfoundation.org>
 <CAK7LNART2XQYy2hN1afODbuCMj+_VX9Ojh5nVCoY-hwXRAwSWA@mail.gmail.com> <0725ccc9abce84695573539c5f3d9d061384469d.camel@linuxfoundation.org>
In-Reply-To: <0725ccc9abce84695573539c5f3d9d061384469d.camel@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 19 Aug 2022 17:40:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQTHO3Za9UpeCCkdNo-mQS8ORgbfwXCJKKr4FCZ3VqT2Q@mail.gmail.com>
Message-ID: <CAK7LNAQTHO3Za9UpeCCkdNo-mQS8ORgbfwXCJKKr4FCZ3VqT2Q@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with dash
To:     Richard Purdie <richard.purdie@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 6:46 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Fri, 2022-08-19 at 04:31 +0900, Masahiro Yamada wrote:
> > On Thu, Aug 18, 2022 at 6:14 PM Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > >
> > > This problem is a little more subtle.
> > >
> > > As far as I could work out, exec() is used on entries like this in
> > > kConfig. exec() falls back to /bin/sh so it is hard to see where this
> > > would be changed to be /bin/bash.
> >
> >
> >
> > Kconfig uses popen() to execute a shell command.
> >
> > See do_shell() in scripts/kconfig/preprocess.c
> >
> > popen(3) says that
> > "the command is passed to /bin/sh using the -c flag.
> > interpretation, if any, is performed by the shell."
> >
> > GNU Make is the same.
> > Make uses /bin/sh to execute commands in
> > recipe lines and $(shell ...) functions.
> > You can change the default shell via 'SHELL' variable.
>
> That makes sense. I don't think we can easily change the shell popen()
> uses.
>
> >
> > BTW, Richard is here, so let me ask about BitBake.
> >
> > The manual [3] clearly says:
> >
> > "When you create these types of functions in your recipe or class files,
> > you need to follow the shell programming rules. The scripts are
> > executed by /bin/sh,
> > which may not be a bash shell but might be something such as dash.
> > You should not use Bash-specific script (bashisms)"
> >
> > I just thought BitBake ran shell code in bash before,
> > but I might have misunderstood.
> > Do OE/Yocto allow only POSIX shell code?
>
> Bitbake runs shell code with /bin/sh so we don't allow bashisms and
> that has always been the case.
>
> Like this case in the kernel, we do get people submitting changes which
> were only tested with bash which can be frustrating but the manual and
> our policy is quite clear. We just fix any that do creep through and
> have test systems that have dash to try and catch them too.
>
> Cheers,
>
> Richard


Thanks.
So, Bitbake is the same approach as the kernel.




This is a patch set to use bash forcibly. FWIW.

https://lore.kernel.org/lkml/20220819065604.295572-1-masahiroy@kernel.org/





-- 
Best Regards
Masahiro Yamada
