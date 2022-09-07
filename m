Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F1A5AFB48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiIGE1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIGE1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:27:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC785F86
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:27:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k17so8027929wmr.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 21:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+FvGAIQA6g0/NKJ5BUw0y3xxvyJZjvMl5VPNjIGS+gw=;
        b=fpFTiwJW/9HvCH0gN6PmxI2K53uPz9gBdr1uC6fWNNa+Yx2q4zXBfLBnLrLL4w3XVx
         SLH0tKobr810W8SeuIsF/R2PCYkbKSLv+lmLCZskEcCW/ReZBReXUqszaDzEfFcTKv5a
         nlDcskBpwttZ34MdXcWaUtu6tDmajbA9c41A/neaA2mh3GnOvQKKqzuB1ioTDStJQQXt
         xna02FYQMvtubUmq9TwhowBPyJ7e1nA1MBzfX5LWcMRawYKCTR5xizIKZeEBxzDEnR/2
         uIhvFAPVIakt8m/dzFlXO7ui+42zBaUsdjRuE1ZQ5tGPkhpeNVPMTm3qieQMennUpYpz
         Ss5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+FvGAIQA6g0/NKJ5BUw0y3xxvyJZjvMl5VPNjIGS+gw=;
        b=37/PNjlAToz1PcxRjFvp6fruQepJKWEZOUudKXwBpWoiG0DxoTrY6cMebHWm2s4/+A
         zKn/NHbLTWuOJ1/A2dKIo+S32C0c0QWYKYm8qrr8hTiWCOsGbB9BLvOu+YNXAhDVaY3r
         iEJ6sXIYcQZPNf+yyh+BmDwDtOfplW29nr/Y1/H9uDj/k1o7PIh4APQ2NHri9IfGe1zw
         McYrNN2Tt+WZBDC4q+DOk7X9PaqlFutQthB/Mp10jRP+ab9uL14poVzCENYySfZ/2r5e
         vi47BGmjL3JJ5yBhroSEmGAIFN/D284E8T7N1UzOHf5+SEoLX78MPJMvZ7eN5I2gyxZs
         QH0g==
X-Gm-Message-State: ACgBeo2OQAFW8whXZSV6KSoXwul4UB+1qLL2MEKv9/vpMWCBD5u/uRPh
        ho4ITljCLinh5CTV7uINbt24Q6b0qzcu1p99fk9zKQ==
X-Google-Smtp-Source: AA6agR7UdGjjmLFmbENHxkNrUGWnPqjf+1gmEg2hCrJPIR4g+trGtUUyjsmLEtD6nr9EhMHcg0XC6n+JH7pk509CMSI=
X-Received: by 2002:a05:600c:ad2:b0:3a5:36ca:ec38 with SMTP id
 c18-20020a05600c0ad200b003a536caec38mr685223wmr.21.1662524839234; Tue, 06 Sep
 2022 21:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220831184408.2778264-1-ndesaulniers@google.com>
 <20220831184408.2778264-5-ndesaulniers@google.com> <CAK7LNATWDH01=ZKLnsxc0vcib1zGDbEq8jLQwhWP7HkkmSb_Mw@mail.gmail.com>
In-Reply-To: <CAK7LNATWDH01=ZKLnsxc0vcib1zGDbEq8jLQwhWP7HkkmSb_Mw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 6 Sep 2022 21:27:07 -0700
Message-ID: <CAKwvOdnU4xLuPzTo1_PN3bfvVS3=2UbwsNP_BRYLxHa-e1J+ng@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] Makefile.debug: re-enable debug info for .S files
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        X86 ML <x86@kernel.org>,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>
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

On Mon, Sep 5, 2022 at 12:50 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Sep 1, 2022 at 3:44 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Alexey reported that the fraction of unknown filename instances in
> > kallsyms grew from ~0.3% to ~10% recently; Bill and Greg tracked it down
> > to assembler defined symbols, which regressed as a result of:
> >
> > commit b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
> >
> > In that commit, I allude to restoring debug info for assembler defined
> > symbols in a follow up patch, but it seems I forgot to do so in
> >
> > commit a66049e2cf0e ("Kbuild: make DWARF version a choice")
> >
> > This patch does a few things:
> > 1. Add -g to KBUILD_AFLAGS. This will instruct the compiler to instruct
> >    the assembler to emit debug info. But this can cause an issue for
> >    folks using a newer compiler but older assembler, because the
> >    implicit default DWARF version changed from v4 to v5 in gcc-11 and
> >    clang-14.
>
>
>
> What kind of bad things happen for "KBUILD_AFLAGS += -g"?
>
>
> I think 'gcc -g -c -o foo.o foo.S' will invoke 'as --gdwarf-2' as the backend
> if gcc is configured to work with old binutils.

That's fine for CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT I think?

What other problems were you envisioning?

>
>
>
>
> > diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> > index 9f39b0130551..46e88f0ca998 100644
> > --- a/scripts/Makefile.debug
> > +++ b/scripts/Makefile.debug
> > @@ -4,18 +4,32 @@ ifdef CONFIG_DEBUG_INFO_SPLIT
> >  DEBUG_CFLAGS   += -gsplit-dwarf
> >  else
> >  DEBUG_CFLAGS   += -g
> > +KBUILD_AFLAGS  += -g
> >  endif
> >
> > -ifndef CONFIG_AS_IS_LLVM
> > -KBUILD_AFLAGS  += -Wa,-gdwarf-2
> > +ifdef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> > +# gcc-11+, clang-14+
> > +ifeq ($(call cc-min-version, 110000, 140000),y)
> > +dwarf-version-y := 5
> > +else
> > +dwarf-version-y := 4
>
>
>
> If you explicitly specify the DWARF version
> for CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT,
> what is the point of CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT?
>
>
> When CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y,
> I believe the right thing to do is to pass only -g,
> and let the tool do whatever it thinks is appropriate.

Ok, sure, I will revise.

>
>
>
>
>
>
> >  endif
> > -
> > -ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> > +else # !CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
> >  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> >  endif
> >
> > +# Binutils 2.35+ (or clang) required for -gdwarf-{4|5}.
> > +# https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
> > +ifneq ($(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y)),)
>
>
>
> When is this as-option supposed to fail?
>
>
> Binutils <= 2.34 always accepts whatever -gdwarf-* option.
> Surprisingly or not, it accepts -gdwarf-6, -gdwarf-7, ...
>
> No matter what DWARF version you specify, GAS silently downgrades
> it to DWARF-2.
>
>
> masahiro@zoe:~/tools/binutils-2.34/bin$ ./as --version | head -n 1
> GNU assembler (GNU Binutils) 2.34
> masahiro@zoe:~/tools/binutils-2.34/bin$ cat /dev/null | ./as -gdwarf-5
> -o /dev/null -
> masahiro@zoe:~/tools/binutils-2.34/bin$ echo $?
> 0
> masahiro@zoe:~/tools/binutils-2.34/bin$ cat /dev/null | ./as
> -gdwarf-100 -o /dev/null -
> masahiro@zoe:~/tools/binutils-2.34/bin$ echo $?
> 0

ah, right. Maybe an explicit version check is necessary then.

>
>
>
>
> Overall, I am not convinced with this patch.
>
>
>
> Please see the attached patch.
> Is there any problem with writing this more simply?


Thanks for the inspiration, I will use that as an inspiration/base for
a new patch.
-- 
Thanks,
~Nick Desaulniers
