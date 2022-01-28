Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982214A0146
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbiA1T7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiA1T7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:59:30 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D44C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:59:30 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h14so7149414plf.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k+KRxXOu730X8LGDY8ibWFrqzfk6XaCWgUlQ/FJX/1g=;
        b=QzY57hp7L7C4IZbQuK3maGb3nj+uWYpqF0Yyk5wwLy6/eJqluG4XaJR5X9c6vaBhca
         +4eW4VquXi25Krzxq/EFw4Jf45zqP9xeHpsX+yvvP8hH1WFNrNHqwwapMmFbvrCgnuEd
         huCEf62r6D+yDp31w66z0o2a9sMjTQoSXNUmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k+KRxXOu730X8LGDY8ibWFrqzfk6XaCWgUlQ/FJX/1g=;
        b=aJVBytcKrPa0BzAmoz1lGJFyPd0x67f6rdY8EVG/DENeMCBTXSH6Rmiyix7As8KcX/
         m1yJojivRS60/RWIx4JVHfCG00HAi1bxr7/+M/NTxwu0XDuiEp0hioHZeju77y/FHAJL
         axt8P1mOEhnfe9m7LpL8zjmjfmGXetMGT/u51Q6dFB21uqy8S0ld+N/rUIW6J5yOIqyg
         RxCYFuPE6WA3Cx1jCpMY+J49vaWaZCXZKiwn2GEO+NqyUetieQPjd4fFfFIE5hthwdeo
         rEoGmgJBRvFG71aud4zuAqsOLg2zGLqflMJtVEGH7R2IIJx5GRXFQAM1l8VCzywlG+Gz
         yVGw==
X-Gm-Message-State: AOAM533zfLlTYkpBItJ3uuhk9k4GUgaWukG1knEJHvqJ/jWwVLWVEYhI
        gt/nOHFuQ6AB0tHhOuuEzBu5dg==
X-Google-Smtp-Source: ABdhPJy8LTGWug/n9PhrrQSoic5rIepzJSa4BJy1U3x25juPbd5YbLoVYVpCcIMuiwlMvw/asyemWA==
X-Received: by 2002:a17:90b:1c8d:: with SMTP id oo13mr11600468pjb.59.1643399969749;
        Fri, 28 Jan 2022 11:59:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o11sm22920833pgj.33.2022.01.28.11.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 11:59:29 -0800 (PST)
Date:   Fri, 28 Jan 2022 11:59:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Alexander Potapenko <glider@google.com>, llvm@lists.linux.dev,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] stack: Constrain stack offset randomization with
 Clang builds
Message-ID: <202201281141.2491039E@keescook>
References: <20220128114446.740575-1-elver@google.com>
 <20220128114446.740575-2-elver@google.com>
 <202201281058.83EC9565@keescook>
 <CANpmjNNaQ=06PfmPudBsLG7r9RsFXYo-NQR4CSM=iO11LFSHKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNaQ=06PfmPudBsLG7r9RsFXYo-NQR4CSM=iO11LFSHKw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 08:23:02PM +0100, Marco Elver wrote:
> On Fri, 28 Jan 2022 at 20:10, Kees Cook <keescook@chromium.org> wrote:
> [...]
> > >       2. Architectures adding add_random_kstack_offset() to syscall
> > >          entry implemented in C require them to be 'noinstr' (e.g. see
> > >          x86 and s390). The potential problem here is that a call to
> > >          memset may occur, which is not noinstr.
> [...]
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -1163,6 +1163,7 @@ config RANDOMIZE_KSTACK_OFFSET
> > >       bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
> > >       default y
> > >       depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> > > +     depends on INIT_STACK_NONE || !CC_IS_CLANG || CLANG_VERSION >= 140000
> >
> > This makes it _unavailable_ for folks with Clang < 14, which seems
> > too strong, especially since it's run-time off by default. I'd prefer
> > dropping this hunk and adding some language to the _DEFAULT help noting
> > the specific performance impact on Clang < 14.
> 
> You're right, if it was only about performance. But there's the
> correctness issue with ARCH_WANTS_NOINSTR architectures, where we
> really shouldn't emit a call. In those cases, even if compiled in,
> enabling the feature may cause trouble.

Hrm. While I suspect instrumentation of memset() from a C function that is
about to turn on instrumentation is likely quite safe, I guess the size
of the venn diagram overlap of folks wanting to use kstack randomization
and an older Clang quickly approaches zero. But everyone building with
an older Clang gets warnings spewed, so I agree: let's opt for complete
correctness here, and make this >= 14 as you have done.

-- 
Kees Cook
