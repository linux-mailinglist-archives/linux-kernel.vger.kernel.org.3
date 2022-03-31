Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2428D4EDD8F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiCaPma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbiCaPmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E8B4C402;
        Thu, 31 Mar 2022 08:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F9C361B6C;
        Thu, 31 Mar 2022 15:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01886C340ED;
        Thu, 31 Mar 2022 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648741028;
        bh=1WPwzaVch64w0jPi0NN43I4/H8/WTq+VtwzIW+KkQKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNmWiGT+crMQsM0b3tQ+NN/NzxNDX8/ABeNcRPmBNkdmXt7kmIb3hVQ0nHMHWfWku
         9/l2fK1sHy2Elc7UGMtooY/262uX9gkPe2CLYRb1T5z5pfjHi+L0R2Sok2wSRI+4KN
         xiGlR3mUDFoYPoY0uH6ttuz0i19W5JoJGKAD7XV5RT6lzlKEafCkzoKcOkqzcGhZ7b
         OfRl/2UvC3QgSmYnSrjhdfvfiMTuCv0O3wj5VlqlXEK61YjhnCQ5jw9AXee1W/nMqO
         N91d5dq9OkpWt2sQahIYVpKw/gHr48+8zOlpB0wh0ysz9+XjG/KI4Fbu5u0qKb7hvx
         zZuxrPq+apX9Q==
Date:   Thu, 31 Mar 2022 08:37:01 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/2] kbuild: Remove '-mno-global-merge'
Message-ID: <YkXKnRwvbMdvOtlJ@thelio-3990X>
References: <20220330234528.1426991-1-nathan@kernel.org>
 <20220330234528.1426991-2-nathan@kernel.org>
 <CA+icZUXrVgGyaujA1iQEw5P3nJHVwMtbFxpE2gKktaxW0Xg-wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXrVgGyaujA1iQEw5P3nJHVwMtbFxpE2gKktaxW0Xg-wg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:11:12AM +0200, Sedat Dilek wrote:
> On Thu, Mar 31, 2022 at 5:27 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > This flag is specific to clang, where it is only used by the 32-bit and
> > 64-bit ARM backends. In certain situations, the presence of this flag
> > will cause a warning, as shown by commit 6580c5c18fb3 ("um: clang: Strip
> > out -mno-global-merge from USER_CFLAGS").
> >
> > Since commit 61163efae020 ("kbuild: LLVMLinux: Add Kbuild support for
> > building kernel with Clang") that added this flag back in 2014, there
> > have been quite a few changes to the GlobalMerge pass in LLVM. Building
> > several different ARCH=arm and ARCH=arm64 configurations with LLVM 11
> > (minimum) and 15 (current main version) with this flag removed (i.e.,
> > with the default of '-mglobal-merge') reveals no modpost warnings, so it
> > is likely that the issue noted in the comment is no longer relevant due
> > to changes in LLVM or modpost, meaning this flag can be removed.
> >
> > If any new warnings show up that are a result of the removal of this
> > flag, it can be added back under arch/arm{,64}/Makefile to avoid
> > warnings on other architectures.
> >
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  Makefile | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index daeb5c88b50b..f2723d9bfca4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -784,10 +784,6 @@ ifdef CONFIG_CC_IS_CLANG
> >  KBUILD_CPPFLAGS += -Qunused-arguments
> >  # The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
> >  KBUILD_CFLAGS += -Wno-gnu
> > -# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
> > -# source of a reference will be _MergedGlobals and not on of the whitelisted names.
> > -# See modpost pattern 2
> > -KBUILD_CFLAGS += -mno-global-merge
> >  else
> >
> >  # gcc inanely warns about local variables called 'main'
> > --
> > 2.35.1
> >
> 
> I have tested this several times and was able to boot into bar metal -
> no problems with building and/or booting my kernel-modules.
> 
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

I would be very concerned if you did see any impact, given this flag is
ARM specific :) thanks as always for verifying!

> Just as a side-note:
> As with Linux v5.18-rc1 and -std=gnu11 we change the above comment ...?
> 
> # The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
> KBUILD_CFLAGS += -Wno-gnu

It was updated as part of the shift to '-std=gnu11':

https://git.kernel.org/linus/e8c07082a810fbb9db303a2b66b66b8d7e588b53

The UML tree is based on 5.17-rc6, which does not have that change.
There should not be a merge conflict though.

Cheers,
Nathan
