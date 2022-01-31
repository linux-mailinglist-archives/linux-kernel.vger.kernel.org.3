Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0E24A517E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359860AbiAaVeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241365AbiAaVes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:34:48 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA20C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:34:48 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p27so29706598lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fY293kK68vvdcex/3vE1UuGsMyzMf3hMzbBW0CECXWo=;
        b=sbuqsKlKtbosk9vnW8XyVA7uztBNuHZfZtcNYRiovUgAycS22JZkJ7MxOjZiMGYokE
         xhXCNkbCRNT88OXvTMndIJGfh2RMckU46x0hrSqGUrxA1AJFOX8bMhXN3oqNP8+elCU0
         lvDAlF8N3I1u2nhtJaNaqw50gxUEox/7eGGrd2H8M1MqUxiEK4xBNMrtaG72GFm6gQLD
         qpV2iT3ZgC3M5XpLy/d3zAQeGz90PRYlxIDLCQX2VGb4CyN+fEuNTon7uZ+TdCW3h+Lm
         bOazphReVxD2+MfnXlHtsZydG2omK43C943jxFBmLXKyDFoYPGqR1UCZxsGliywnVtxc
         xU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fY293kK68vvdcex/3vE1UuGsMyzMf3hMzbBW0CECXWo=;
        b=hcO2HT7WPiRQmIOdQlK0eCxzzhW6LzPBO3wQ/m4GGYjf46IhAlKAQnVSNqanZE7izr
         8r5RWVQkdA0+vpXgmDQ4mlQhM5a6kKkCqzaqByCuzX15UIX/nW/rdGhfNzI/98ZSqdfD
         9HLVPQBm5ziE46Ark9g1zTJEClIfcPbnJ6f2KDZeufwMoO2/ND8Dw4N8MlhRwNksOrlN
         Oa7q3u8AtLpfMFP1h7WCOp8wWtyTX91whBnCp5/VTiAyKu++TPOukzNkQd+qdDK1plqp
         3KXeqksBd0wBNXqiN/K44lgu+PFOZax8/n8HUh9McuQsstNnNkaaJwnlkJmE79xxqqYD
         rW/w==
X-Gm-Message-State: AOAM533TbnughG0wuuVyjcWxRkgtcMnhxKOHxiqSv0wTyunPXwupVNi/
        Oar8fTUpkuEh8csM8HutQv+XWqoAdN7XrSVC/E04mg==
X-Google-Smtp-Source: ABdhPJzxDldmaLxKkITPTgpnzqLDLhm+/u9GBYoFF9PlNaTLN1bwfw05dn5ekB7WpU3SJDjImTN/TnaMqBt9M4u2EEc=
X-Received: by 2002:ac2:4e10:: with SMTP id e16mr17500223lfr.444.1643664886497;
 Mon, 31 Jan 2022 13:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20220130181616.420092-1-keescook@chromium.org>
 <CAKwvOdmETY-j9B9vms4d31kAc0xb1yE902KijiH2baY5-M=fLQ@mail.gmail.com> <202201311306.0FC6E303@keescook>
In-Reply-To: <202201311306.0FC6E303@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Jan 2022 13:34:34 -0800
Message-ID: <CAKwvOdnXKfhJQimh6rLe6nU2NrrovbKDGqujinqptoyHyiTKYQ@mail.gmail.com>
Subject: Re: [PATCH] fortify: Update compile-time tests for Clang 14
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 1:09 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jan 31, 2022 at 11:09:27AM -0800, Nick Desaulniers wrote:
> > On Sun, Jan 30, 2022 at 10:16 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Clang 14 introduces support for compiletime_assert(). Update the
> > > compile-time warning regex to catch Clang's variant of the warning text
> > > in preparation for Clang supporting CONFIG_FORTIFY_SOURCE.
> >
> > https://twitter.com/ifosteve/status/1190348262500421634?lang=en
> > error messages can change over time. More thoughts below.
>
> Sure, but I don't want the compile-time checks to silently regress,
> which requires looking specifically for the error.
>
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: linux-hardening@vger.kernel.org
> > > Cc: llvm@lists.linux.dev
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > I'm splitting this patch out of the main Clang FORTIFY enabling patch.
> > > ---
> > >  scripts/test_fortify.sh | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/scripts/test_fortify.sh b/scripts/test_fortify.sh
> > > index a4da365508f0..c2688ab8281d 100644
> > > --- a/scripts/test_fortify.sh
> > > +++ b/scripts/test_fortify.sh
> > > @@ -46,8 +46,12 @@ if "$@" -Werror -c "$IN" -o "$OUT".o 2> "$TMP" ; then
> > >                 status="warning: unsafe ${FUNC}() usage lacked '$WANT' symbol in $IN"
> > >         fi
> > >  else
> > > -       # If the build failed, check for the warning in the stderr (gcc).
> > > -       if ! grep -q -m1 "error: call to .\b${WANT}\b." "$TMP" ; then
> > > +       # If the build failed, check for the warning in the stderr.
> > > +       # GCC:
> > > +       # ./include/linux/fortify-string.h:316:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> > > +       # Clang 14:
> > > +       # ./include/linux/fortify-string.h:316:4: error: call to __write_overflow_field declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> > > +       if ! grep -Eq -m1 "error: call to .?\b${WANT}\b.?" "$TMP" ; then
> >
> > Doesn't this depend on -Werror being set? I guess it did so before
> > hand, too, but couldn't I unset CONFIG_WERROR then this check would
> > still fail (since instead of `error:` we'd have `warning:`)? If we
> > used __attribute__((error(""))) then this would always be an error.
> > Right now, it is only because -Werror is set promoting the warning
> > diagnostic to an error.
>
> Right, see earlier up in the script. "-Werror" is explicitly set:
>
> line 40: if "$@" -Werror -c "$IN" -o "$OUT".o 2> "$TMP" ; then

Yep, I missed that.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> --
> Kees Cook



-- 
Thanks,
~Nick Desaulniers
