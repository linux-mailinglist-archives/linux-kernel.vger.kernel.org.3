Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4985AAB3C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiIBJT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbiIBJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:19:11 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732C9C9921;
        Fri,  2 Sep 2022 02:19:07 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2829IljR015545;
        Fri, 2 Sep 2022 18:18:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2829IljR015545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662110327;
        bh=2NU7ltVrdW8WvUhptKYwPRrhqjFrbzpv9sQRVWxQ4iQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=197CkrWH499oMFvUYG74D7yrIrAzL5slRCWZUUncTi3iQL/nNk+tlrifiL79TEf/W
         nw2Ne/Ux2wssrBpGQuyfwTrf+LqDn3qnk26f+B2+27lJ4KlGdRNuVXaPBnRFjbBn0t
         HfctgsmA7nbzQ1/MutlN46MtFVFz+9yVnUKfiPaqimPblTcke/141aOoWmsiofnT2e
         quG7hKJBWgWxiCjZnDnnmT8/SjUrvAUPthqiWtWR7Zay+1FD4yRI1c+uWhWgG1F9zl
         uDboETlZiaXAY43atrH4lt7tBQpdx+99u91N6KWpHeG7Ctr3Bb4w0gvVbQhKHrTbAf
         DpFDcPkDsblKw==
X-Nifty-SrcIP: [209.85.210.42]
Received: by mail-ot1-f42.google.com with SMTP id m21-20020a9d6ad5000000b00638df677850so1038930otq.5;
        Fri, 02 Sep 2022 02:18:47 -0700 (PDT)
X-Gm-Message-State: ACgBeo3f+Gj677HtApUIBfcErx612UYA78FIrURe2Hlt2ee8DBL9m05Q
        and3mQm+UaY0s2qagsnGmp0l2ruzmrePeGNIV3w=
X-Google-Smtp-Source: AA6agR5Jk+EwlwFw19cN+nxmckn79O0R9R8/XDCTaCoK3DCv+k2L1LHlFboI9zmnQD83Lk8T2rvmuPtSDnQx5kmRNNc=
X-Received: by 2002:a9d:4806:0:b0:637:cdca:f8d3 with SMTP id
 c6-20020a9d4806000000b00637cdcaf8d3mr14445392otf.225.1662110326367; Fri, 02
 Sep 2022 02:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <YjhdcJB4FaLfsoyO@gmail.com> <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic> <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <YjsCpoRK7W4l6tSh@zn.tnic> <CAHk-=wi9pLxm+dXoCaiGO+f0EbhyfAR_L510vD0c2=hj6rbMXg@mail.gmail.com>
 <YjwsUT/6PkRPjnHE@gmail.com> <YjySjys3QZAWFlfo@dev-arch.thelio-3990X>
 <YkC08gKqJOUM7CA8@gmail.com> <YkHXQTKImf7Wr+Sk@dev-arch.thelio-3990X> <YxHD1MkulyL3yB9y@gmail.com>
In-Reply-To: <YxHD1MkulyL3yB9y@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 2 Sep 2022 18:18:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyp8SzO3G+th5RgmRNBM_ryKuy0XzaMrdUdo8Sd6RR0A@mail.gmail.com>
Message-ID: <CAK7LNASyp8SzO3G+th5RgmRNBM_ryKuy0XzaMrdUdo8Sd6RR0A@mail.gmail.com>
Subject: Re: [PATCH] x86/config: Make the x86 defconfigs a bit more usable
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 5:50 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Nathan Chancellor <nathan@kernel.org> wrote:
>
> > On Sun, Mar 27, 2022 at 09:03:14PM +0200, Ingo Molnar wrote:
> > > Yeah, good catch! ...
> > >
> > > I use defconfigs by explicitly adding in the architecture:
> > >
> > >   kepler:~/tip> make ARCH=i386 defconfig
> > >
> > >   kepler:~/tip> kconfig-arch
> > >   i386
> > >
> > > ... so never I noticed this bug.
> >
> > Ah, good point!
> >
> > > I fixed this in the latest version (attached).
> > >
> > > Arguably 'make ARCH=i386 savedefconfig' should preserve this, so that
> > > refreshing defconfigs on bi-arch architectures is idempotent, but that's no
> > > excuse to regress the existing defconfig behavior.
> >
> > Hmmm, I thought that it would, but I think the behavior of savedefconfig
> > is actually correct with regards to how it handles CONFIG_64BIT in the
> > presence of an explicit ARCH value, based on how CONFIG_64BIT is
> > defined:
> >
> > config 64BIT
> >       bool "64-bit kernel" if "$(ARCH)" = "x86"
> >       default "$(ARCH)" != "i386"
> >       help
> >         Say yes to build a 64-bit kernel - formerly known as x86_64
> >         Say no to build a 32-bit kernel - formerly known as i386
> >
> > As the default is no when ARCH == i386 and there is no prompt in that
> > situation, "# CONFIG_64BIT is not set" gets dropped, as that is the
> > default. Using savedefconfig without the ARCH variable would do the
> > right thing.
> >
> > I tried playing around with these Kconfig symbols to see if I could get
> > something that would work for savedefconfig with or without ARCH, but I
> > could not really come up with anything. I did not try super hard though,
> > it might still be possible.
>
> Unfortunately, even without the ARCH=i386 'make savedefconfig' doesn't seem
> to be doing the right thing & is dropping the '# CONFIG_64BIT is not set'
> line:


Oh, really?

Without ARCH=i386, it works correctly for me.



masahiro@zoe:~/ref/linux$ make i386_defconfig savedefconfig
#
# No change to .config
#
masahiro@zoe:~/ref/linux$ grep CONFIG_64BIT defconfig
# CONFIG_64BIT is not set




I guess you gave ARCH=i386 somewhere.







>  kepler:~/tip> make ARCH=i386 defconfig
>  *** Default configuration is based on 'i386_defconfig'
>  #
>  # configuration written to .config
>  #
>  kepler:~/tip> make savedefconfig
>  kepler:~/tip> diff -up arch/x86/configs/i386_defconfig defconfig
>  --- arch/x86/configs/i386_defconfig    2022-09-02 10:45:43.117430882 +0200
>  +++ defconfig  2022-09-02 10:46:56.663864901 +0200
>  @@ -282,4 +282,3 @@ CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
>   CONFIG_EARLY_PRINTK_DBGP=y
>   CONFIG_DEBUG_BOOT_PARAMS=y
>   CONFIG_UNWINDER_FRAME_POINTER=y
>  -# CONFIG_64BIT is not set
>  kepler:~/tip>
>
> This is annoying in that every time I modify the i386 defconfig and use
> 'make savedefconfig', I have to manually revert that change ...
>
> This reduces the usability of 'make savedefconfig' quite a bit.
>
> Maybe Masahiro-san can tell me how I'm doing this wrong?
>
> Thanks,
>
>         Ingo



--
Best Regards
Masahiro Yamada
