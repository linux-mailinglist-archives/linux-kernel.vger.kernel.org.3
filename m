Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771BE57CDD1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiGUOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiGUOhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:37:19 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8785F92
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:37:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a13so1888287ljr.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNboldPsa6NL6HkP/uwDWmY1V1v2qEdKxOLHr3lu02Y=;
        b=ZVvu2qk0IlAhphe1eVCBnTvpyhOOSQMyU+xpDJLvQ9qlxwlG0hmkA8E5d7I4JwXODd
         l/BfagBbNh+gciltJqzYvBi4XDSQ+XeFsxzBYD9bJmbjaRiqkLhKWaVCpY7hcPss154R
         8HHgXIhNffDFUBEAKqZ7NwCO0OBaks9Pk/daeX3rfrpQN8ex0PIIROmtjM5TraBaswXg
         22zWic7d0Q+SNfI3kS4K9MqDfNTLMXMdctjMPTYLTPX4Xgo9Rzgc2L2MGV7WfUEx3rMC
         R4hVbPoT1zkROkQKXgHdr5T59ehxDWhJhkkyFGj9tWGTjaCuj3y2KHL78bBUbyVevAr2
         BoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNboldPsa6NL6HkP/uwDWmY1V1v2qEdKxOLHr3lu02Y=;
        b=0VTrngZQqyVOiQml68LuxU51eZP++wCVe6w2cGTtyjlI1dwWHfU8CovLxv45TZUqIi
         7GKOcf70Vj+hL7azQv1dGLhQM9IpOPImphheKKY3NbzM3uRXaau0lpb4YH9bH8gLCPpm
         xht4bfbiBETn18Bv2AWGlpsUtAnRlLUmQ1+oNONJqRywUM3sMd89vEX/PANEmaB1V+pE
         JlL0O6/Vkw+EN14jHjs8riqGMR2LUUbB+nHjyeZUfLT8+48ct8Slp4PqKbJ4QVg3GQ3S
         BGaWjX3BvfOSk2qQm9EGMiKFSI2yLFtVzkEMntnDXSNVTBQjT9rDFGdBSAJzq6CO2lrl
         Yegg==
X-Gm-Message-State: AJIora8o25p0cGtwt/3a2aZsJCZef5RrCXDzouHaOXmw0usprVH7ihY9
        u5DZ0rcPJAnDC++x8kAy3861+21C8EltzK6JEWDfEw==
X-Google-Smtp-Source: AGRyM1unUkT7KHAbSoQ8LxQrFMd0W4nlZA2BSaWIotCDnTIk04ut6fiwktEBu7yTRhA4MEq29l5ofVGmrS/AEcslm4U=
X-Received: by 2002:a2e:8609:0:b0:25d:6af0:63b5 with SMTP id
 a9-20020a2e8609000000b0025d6af063b5mr19769192lji.360.1658414236802; Thu, 21
 Jul 2022 07:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220720232332.2720091-1-justinstitt@google.com> <CAKwvOdnSjyOdCZZ9AegCyfns3bvH3fbtbVgdThO2+rJAE=1bag@mail.gmail.com>
In-Reply-To: <CAKwvOdnSjyOdCZZ9AegCyfns3bvH3fbtbVgdThO2+rJAE=1bag@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Jul 2022 07:37:05 -0700
Message-ID: <CAKwvOdmtiRb4FRBS3BVNbDmOn3S2sfSrMYrC+5Te9A2jyr=CXQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile.extrawarn: re-enable -Wformat for clang
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>,
        youngmin.nam@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 7:27 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jul 20, 2022 at 4:23 PM Justin Stitt <justinstitt@google.com> wrote:
> >
> > There's been an ongoing mission to re-enable the -Wformat warning for
> > Clang. A previous attempt at enabling the warning showed that there were
> > many instances of this warning throughout the codebase. The sheer amount
> > of these warnings really polluted builds and thus -Wno-format was added
> > to _temporarily_ toggle them off.
> >
> > After many patches the warning has largely been eradicated for x86,
> > x86_64, arm, and arm64 on a variety of configs. The time to enable the
> > warning has never been better as it seems for the first time we are
> > ahead of them and can now solve them as they appear rather than tackling
> > from a backlog.
> >
> > As to the root cause of this large backlog of warnings, Clang seems to
> > pickup on some more nuanced cases of format warnings caused by implicit
> > integer conversion as well as default argument promotions from
> > printf-like functions.
> >
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/378
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Previous attempt: (https://patchwork.kernel.org/project/linux-kbuild/patch/20190201210853.244043-1-jflat@chromium.org/)
> >
> > Note:
> > For this patch to land on its feet, the plethora of supporting patches that
> > fixed various -Wformat warnings need to be picked up. Thanfully, a lot
> > of them have!
> >
> > Here are the patches still waiting to be picked up:
> > * https://lore.kernel.org/all/20220718230626.1029318-1-justinstitt@google.com/
> > * https://lore.kernel.org/all/20220711222919.2043613-1-justinstitt@google.com/
>
> Hi Masahiro, Nathan, and Tom,
> What are your thoughts for _when_ in the release cycle this should be
> picked up?  I worry that if we don't remove this soon, we will
> backslide, and more -Wformat issues will crop up making removing this
> in the future like digging in sand.  Justin has chased down many
> instances of this warning, and I'm happy to help clean up fallout from
> landing this.

Otherwise, we probably want to look at picking up Youngmin's patch ASAP.
https://lore.kernel.org/all/20220716084532.2324050-1-youngmin.nam@samsung.com/

(This thread, for context for Youngmin:
https://lore.kernel.org/llvm/20220720232332.2720091-1-justinstitt@google.com/)

>
> >
> >  scripts/Makefile.extrawarn | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> > index f5f0d6f09053..9bbaf7112a9b 100644
> > --- a/scripts/Makefile.extrawarn
> > +++ b/scripts/Makefile.extrawarn
> > @@ -47,7 +47,6 @@ else
> >
> >  ifdef CONFIG_CC_IS_CLANG
> >  KBUILD_CFLAGS += -Wno-initializer-overrides
> > -KBUILD_CFLAGS += -Wno-format
> >  KBUILD_CFLAGS += -Wno-sign-compare
> >  KBUILD_CFLAGS += -Wno-format-zero-length
> >  KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
