Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367325AF078
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiIFQd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiIFQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF87684EE9;
        Tue,  6 Sep 2022 09:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 261D8615AD;
        Tue,  6 Sep 2022 16:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69A6C433D6;
        Tue,  6 Sep 2022 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662480495;
        bh=zCc7fKyX2vVh00Skn6XiWidfTXu0QhuXY1caqeayhMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ba9F9jP6xg9kM/goDxi/ZxniQ8EZq0lcpVWdjBcc+ux0XgBUqqCPRAweRuoyu2z9e
         r+joBj/rUf8bX8zUIFs8W7qJieAyaT8X1CqQ2gu5KWXzD4xgONbx78+Y0F6U9F5OKa
         Bq732ZHvCASpV2p3JitatXHhcrNM4qh+UAfssAQKAHDRKplbHOH5YZPP40mbCZZIzP
         AIbTA6WW+f9wd4/x1ZppyWmCupDzBZolui7qTwPrIpXidy/y9fNW4Dq1r5A5MOLO1h
         yABXALX0TfV6e8RHoeC8VlqKW6V/huyMWAKqmENRC1vdxA1g1jS4s9cYQizU2E2QRo
         i7Z1dJk+JwaTQ==
Date:   Tue, 6 Sep 2022 09:08:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
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
Subject: Re: [PATCH v2 2/5] Makefile.compiler: Use KBUILD_AFLAGS for as-option
Message-ID: <YxdwbKA5ThYJcPBP@dev-arch.thelio-3990X>
References: <20220831184408.2778264-1-ndesaulniers@google.com>
 <20220831184408.2778264-3-ndesaulniers@google.com>
 <Yw+8QgtSbB2/3Eiq@dev-arch.thelio-3990X>
 <CAK7LNASQJ-B2kRGXea-dQt+1BgEsp_aLEPS_uJb1R6FSOj1Khg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASQJ-B2kRGXea-dQt+1BgEsp_aLEPS_uJb1R6FSOj1Khg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 06:09:28PM +0900, Masahiro Yamada wrote:
> On Thu, Sep 1, 2022 at 4:53 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Wed, Aug 31, 2022 at 11:44:05AM -0700, Nick Desaulniers wrote:
> > > as-instr uses KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS.  This can
> > > cause as-option to fail unexpectedly because clang will emit
> > > -Werror,-Wunused-command-line-argument for various -m and -f flags for
> > > assembler sources.
> >
> > Now that I am looking closer at it, where does that '-Werror' come from?
> 
> The related commit is
> c3f0d0bc5b01ad90c45276952802455750444b4f
> 
> The previous discussion with Arnd is
> https://lore.kernel.org/linux-kbuild/20170314213724.3836900-1-arnd@arndb.de/

Right, although this is for cc-option, not as-option, no?

> > For cc-option, we add it to elevate clang's warnings about unused '-f',
> > '-m', and '-W' flags to errors so that we do not add those flags.
> > However, I do not see '-Werror' in as-option. I am going to assume it
> > came from CONFIG_WERROR, as I believe Android has that turned on by
> > default.
> 
> CONFIG_WERROR is added to CFLAGS.
> But, I guess it is more correct to do likewise for others.
> (https://patchwork.kernel.org/project/linux-kbuild/patch/20220905083619.672091-1-masahiroy@kernel.org/)

Ack.

> > I think that is the real problem: without '-Werror', the only
> > error that should come from as-option is when an option isn't supported
> > by the assembler, as clang will still warn but those will not be fatal
> > but with '-Werror', those warnings turn fatal, causing all subsequent
> > as-option calls to fail.
> 
> Presumably, it is correct to add -Werror to as-option as well.
> We have no reason to add it to cc-option, but not to as-option.
> 
> I also believe '-x assembler' should be changed to
> '-x assembler-with-cpp'.
> 
> As I mentioned somewhere before, our assembly code (*.S) is always
> preprocessed. There is no *.s file in the kernel source tree.
> 
> So, '-x assembler-with-cpp' matches the real situation.

All good points, I think that is a good fix as well.

> One interesting thing is, clang does not warn
> [-Wunused-command-line-argument] for *.S files.
> 
> $ clang -fomit-frame-pointer -c -x assembler /dev/null -o /dev/null
> clang: warning: argument unused during compilation:
> '-fomit-frame-pointer' [-Wunused-command-line-argument]
> 
> $ clang -fomit-frame-pointer -c -x assembler-with-cpp /dev/null -o /dev/null

Interesting... I suspect that is likely intentional, as some compiler
flags could be used during preprocessing (it's come up before:
https://github.com/llvm/llvm-project/issues/55656) but I was not able to
figure out exactly where in clang the flags were consumed but Driver.cpp
is quite large and I didn't look too hard :)

More importantly, it still allows us to catch invalid assembler
arguments:

$ clang -c -x assembler-with-cpp /dev/null -o /dev/null -Wa,-foo
clang-16: error: unsupported argument '-foo' to option '-Wa,'

$ clang -c -x assembler-with-cpp /dev/null -o /dev/null -Wa,--noexecstack

> The root cause is we are using '-x assembler', which
> never happens in the kernel tree.
> 
> To sum up, the code I think correct is:
> 
> as-option = $(call try-run,\
>    $(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp
> /dev/null -o "$$TMP",$(1),$(2))
> 

Agreed. Thank you as always for your feedback!

Cheers,
Nathan
