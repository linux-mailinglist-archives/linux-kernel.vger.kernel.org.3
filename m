Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF164A5124
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379942AbiAaVKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380007AbiAaVJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:09:42 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86057C061401
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:09:42 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 133so13431618pgb.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QkhfbO5ZuAnM+4vhyHXHVmq11kG0AqyRd/tsjcMAl14=;
        b=F/nlSE/yNJSASXLMWSaLGYR1yLL+hmZl/FP19SuvRwCudcOLOFjyjyVSys+cJHT9bd
         DiZvJM5FOigFZ+06vJkHc2u3C3fnV1/DSbQTDMK18auGH7E+/aYpx456r1n6VPV2cenW
         5C7lLsPmpGYiN/CdnhIbAxw1RAA+Yh655yk9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QkhfbO5ZuAnM+4vhyHXHVmq11kG0AqyRd/tsjcMAl14=;
        b=d4CV987G2kaFuL860QncG1L2QQHCp6euUPZvLvaGESJOYqs+jig7oswP5dUMAOjpuK
         4Vq2dR5oP0RSEQVPmqWZFSQE1xIB+58Jo3sNXfO6u5mywGq9Ju4hiq4ruXSPYcREwHc1
         31qerwKluwj5ij3DtzvsEqlEa4cy7fI5/ahrzxzPuM2EZRzUuzfJOB/CZVCWx5r7zpyT
         SNRmte09V/xHSoUtdaM/+yn4Kb3AKATx0e1NPs0VX1qdi6LliX72cePzXnDIHs8OcVWO
         fEiayBWCyIk6fF2wbe+D1CV+f0B14zPbR9byos0WgyQFZz0kf3VXzEAQDgFfzqI5v8pz
         9wsg==
X-Gm-Message-State: AOAM533Bzc1H9wanyYLo29ifk7ySaHJqqdrN0bM52EZVZ8TWjzWnZ72m
        GbfnUp87yF3FkqERnUpso7vmOw==
X-Google-Smtp-Source: ABdhPJwLHNNlfqh8k0yscOHN38ElXx7ca741f/SViX5QRk7Zaq7yJAYAxfp6QboGV6M3GgXg8Lw/Tg==
X-Received: by 2002:a62:1dcc:: with SMTP id d195mr22080045pfd.4.1643663382057;
        Mon, 31 Jan 2022 13:09:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bj7sm228915pjb.9.2022.01.31.13.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:09:41 -0800 (PST)
Date:   Mon, 31 Jan 2022 13:09:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fortify: Update compile-time tests for Clang 14
Message-ID: <202201311306.0FC6E303@keescook>
References: <20220130181616.420092-1-keescook@chromium.org>
 <CAKwvOdmETY-j9B9vms4d31kAc0xb1yE902KijiH2baY5-M=fLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmETY-j9B9vms4d31kAc0xb1yE902KijiH2baY5-M=fLQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 11:09:27AM -0800, Nick Desaulniers wrote:
> On Sun, Jan 30, 2022 at 10:16 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Clang 14 introduces support for compiletime_assert(). Update the
> > compile-time warning regex to catch Clang's variant of the warning text
> > in preparation for Clang supporting CONFIG_FORTIFY_SOURCE.
> 
> https://twitter.com/ifosteve/status/1190348262500421634?lang=en
> error messages can change over time. More thoughts below.

Sure, but I don't want the compile-time checks to silently regress,
which requires looking specifically for the error.

> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: linux-hardening@vger.kernel.org
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > I'm splitting this patch out of the main Clang FORTIFY enabling patch.
> > ---
> >  scripts/test_fortify.sh | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/test_fortify.sh b/scripts/test_fortify.sh
> > index a4da365508f0..c2688ab8281d 100644
> > --- a/scripts/test_fortify.sh
> > +++ b/scripts/test_fortify.sh
> > @@ -46,8 +46,12 @@ if "$@" -Werror -c "$IN" -o "$OUT".o 2> "$TMP" ; then
> >                 status="warning: unsafe ${FUNC}() usage lacked '$WANT' symbol in $IN"
> >         fi
> >  else
> > -       # If the build failed, check for the warning in the stderr (gcc).
> > -       if ! grep -q -m1 "error: call to .\b${WANT}\b." "$TMP" ; then
> > +       # If the build failed, check for the warning in the stderr.
> > +       # GCC:
> > +       # ./include/linux/fortify-string.h:316:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> > +       # Clang 14:
> > +       # ./include/linux/fortify-string.h:316:4: error: call to __write_overflow_field declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> > +       if ! grep -Eq -m1 "error: call to .?\b${WANT}\b.?" "$TMP" ; then
> 
> Doesn't this depend on -Werror being set? I guess it did so before
> hand, too, but couldn't I unset CONFIG_WERROR then this check would
> still fail (since instead of `error:` we'd have `warning:`)? If we
> used __attribute__((error(""))) then this would always be an error.
> Right now, it is only because -Werror is set promoting the warning
> diagnostic to an error.

Right, see earlier up in the script. "-Werror" is explicitly set:

line 40: if "$@" -Werror -c "$IN" -o "$OUT".o 2> "$TMP" ; then

-- 
Kees Cook
