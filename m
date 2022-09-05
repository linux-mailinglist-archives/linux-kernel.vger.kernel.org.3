Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2DC5ACE93
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiIEJK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbiIEJKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:10:23 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF8B2529E;
        Mon,  5 Sep 2022 02:10:20 -0700 (PDT)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2859A5GC022169;
        Mon, 5 Sep 2022 18:10:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2859A5GC022169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662369006;
        bh=4BbPbSzeFLnJFI+hMdkPwj9aQwOKx7JySs0IWqZPQ0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K/mdEeMRVWUJ43uBAY659SEzldpJrYqmzDMddLj0aB0c56GoecW80PmlDDWYOBpfL
         9bHh6vsGCFA/d53NC+q3BwVLoFvzDrUKtMgyA3z5iGlNJBpLEaIcyQ0Of/foUdMafK
         zUOic0nRiESCOt98VhDySaaAXwmn4LntcT8541AJv/6pNJrCT6OZinJjDcgbCVlaNR
         okCu1UQFRXhzxW4aTnxWqabtQZrmYjiMBpjnShwT8s7LKypx4NZE24sUBg2m2v+Ip7
         IDLxZ4oZmMkjpIUx3qQ9CZsDLW2VJES/duDlV3G+bE/05uV9/obzK5bLWM5Uuq4Mxx
         A1L8Hj+SAmV0w==
X-Nifty-SrcIP: [209.85.161.52]
Received: by mail-oo1-f52.google.com with SMTP id n11-20020a4aa7cb000000b0044b3583d373so1400849oom.2;
        Mon, 05 Sep 2022 02:10:06 -0700 (PDT)
X-Gm-Message-State: ACgBeo115IqWZ9mykR52DDHBrO/JPysEI0nBwxkvP5uKVTKQNwQRiLIx
        mvrJpqamLlada7KVhSKKuOZ2J1mdtyNFf/WG/xA=
X-Google-Smtp-Source: AA6agR762y627dWmUGyX6sAQX7gCT5K0+/66Ge89+EYNKHtueHA4CGyB7PqUnbc1v/EXYM/a2gYwd3gnsxX4Rw7avhg=
X-Received: by 2002:a4a:9789:0:b0:451:437b:cc58 with SMTP id
 w9-20020a4a9789000000b00451437bcc58mr6570173ooi.96.1662369004999; Mon, 05 Sep
 2022 02:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220831184408.2778264-1-ndesaulniers@google.com>
 <20220831184408.2778264-3-ndesaulniers@google.com> <Yw+8QgtSbB2/3Eiq@dev-arch.thelio-3990X>
In-Reply-To: <Yw+8QgtSbB2/3Eiq@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 5 Sep 2022 18:09:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNASQJ-B2kRGXea-dQt+1BgEsp_aLEPS_uJb1R6FSOj1Khg@mail.gmail.com>
Message-ID: <CAK7LNASQJ-B2kRGXea-dQt+1BgEsp_aLEPS_uJb1R6FSOj1Khg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] Makefile.compiler: Use KBUILD_AFLAGS for as-option
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
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
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 4:53 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Aug 31, 2022 at 11:44:05AM -0700, Nick Desaulniers wrote:
> > as-instr uses KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS.  This can
> > cause as-option to fail unexpectedly because clang will emit
> > -Werror,-Wunused-command-line-argument for various -m and -f flags for
> > assembler sources.
>
> Now that I am looking closer at it, where does that '-Werror' come from?




The related commit is
c3f0d0bc5b01ad90c45276952802455750444b4f

The previous discussion with Arnd is
https://lore.kernel.org/linux-kbuild/20170314213724.3836900-1-arnd@arndb.de/





> For cc-option, we add it to elevate clang's warnings about unused '-f',
> '-m', and '-W' flags to errors so that we do not add those flags.
> However, I do not see '-Werror' in as-option. I am going to assume it
> came from CONFIG_WERROR, as I believe Android has that turned on by
> default.


CONFIG_WERROR is added to CFLAGS.
But, I guess it is more correct to do likewise for others.
(https://patchwork.kernel.org/project/linux-kbuild/patch/20220905083619.672091-1-masahiroy@kernel.org/)



> I think that is the real problem: without '-Werror', the only
> error that should come from as-option is when an option isn't supported
> by the assembler, as clang will still warn but those will not be fatal
> but with '-Werror', those warnings turn fatal, causing all subsequent
> as-option calls to fail.



Presumably, it is correct to add -Werror to as-option as well.
We have no reason to add it to cc-option, but not to as-option.




I also believe '-x assembler' should be changed to
'-x assembler-with-cpp'.


As I mentioned somewhere before, our assembly code (*.S) is always
preprocessed. There is no *.s file in the kernel source tree.


So, '-x assembler-with-cpp' matches the real situation.


One interesting thing is, clang does not warn
[-Wunused-command-line-argument] for *.S files.




$ clang -fomit-frame-pointer -c -x assembler /dev/null -o /dev/null
clang: warning: argument unused during compilation:
'-fomit-frame-pointer' [-Wunused-command-line-argument]

$ clang -fomit-frame-pointer -c -x assembler-with-cpp /dev/null -o /dev/null



The root cause is we are using '-x assembler', which
never happens in the kernel tree.




To sum up, the code I think correct is:


as-option = $(call try-run,\
   $(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp
/dev/null -o "$$TMP",$(1),$(2))






> Do not get me wrong, I still believe this is the correct fix but I think
> it would be good to describe exactly under which conditions this is a
> real issue in case we ever have to revisit this.
>
> > Callers of as-option (and as-instr) likely want to be adding flags to
> > KBUILD_AFLAGS/aflags-y, not KBUILD_CFLAGS/cflags-y.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1699
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Regardless of changes to the commit message:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> > Changes v1 -> v2:
> > * Split off changes to arch/x86/boot/compressed/Makefile into parent
> >   patch, as per Masahiro.
> >
> >  scripts/Makefile.compiler | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> > index 94d0d40cddb3..d1739f0d3ce3 100644
> > --- a/scripts/Makefile.compiler
> > +++ b/scripts/Makefile.compiler
> > @@ -29,13 +29,13 @@ try-run = $(shell set -e;         \
> >       fi)
> >
> >  # as-option
> > -# Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
> > +# Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
> >
> >  as-option = $(call try-run,\
> > -     $(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
> > +     $(CC) $(KBUILD_AFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
> >
> >  # as-instr
> > -# Usage: cflags-y += $(call as-instr,instr,option1,option2)
> > +# Usage: aflags-y += $(call as-instr,instr,option1,option2)
> >
> >  as-instr = $(call try-run,\
> >       printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
> > --
> > 2.37.2.672.g94769d06f0-goog
> >



--
Best Regards



Masahiro Yamada
