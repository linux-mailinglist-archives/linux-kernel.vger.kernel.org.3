Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247A249D421
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiAZVKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiAZVKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:10:00 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F45C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:10:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so826087pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tYDHNpCyJMrhlfLdWcTGq0aLjyHZFNie0hu9GypnFpw=;
        b=BtHh2bZJz8WOmIVHiyJ4B5iNLx/r0TuQgmOzh2mcoKAKVaNvuyu3yGT+LgdgSpLTbb
         6JOwzNRRBrpzkHESupujsKm6C1mnseEGZ4elW7r4Fp+95Zs7Fj8xcncOrIQUDL2d8uEW
         MTh+vB2bp1ejZFiJzEyPPa/dhQj+pgJTjQ38Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tYDHNpCyJMrhlfLdWcTGq0aLjyHZFNie0hu9GypnFpw=;
        b=j0IkbbMMSSGTCBQXvKMk+LYXn/OYxsHQF4BI7+WNMkVn8u/p6ElJjltYD2VxNneSY5
         TeWlfNqa+F9KPwiLVvjiTQViZvCOITEOWMvUVLf5roi/O4nct1s3adLpIqtZNv1bv7v5
         91jCu6PoIzo1G6CUcmUC8yakVW/1rg0yX9LDc3+uQTGcnB0zYVbAzo3gds18jwMpG5FB
         5xmPNBdyqCAJWtFJR8/PU08bsx18BiMlrqfnhwG3I3PJ+ES9Fztq6sLozAT+bSO3wDX4
         IB1RwMBzV1fYdkU4IoqzaviVBTdiO70nqNKwv5BGhdywdK0JYmz3BUQ9pYmAs03t2+et
         EtBw==
X-Gm-Message-State: AOAM532iN50XUhhiiNaAh5sy8BWeCnajkWtKI/d1WB5LLMNSNfZIML3U
        w2+UOlu+xf4OPw0DNYA/rqCBAQ==
X-Google-Smtp-Source: ABdhPJwV+LWCbalaSeDtSG6cRcoMExxaDxPvqOoOUDNClgjTjPvpVSpB7loAIxkMN9m/f5HlsPk9cg==
X-Received: by 2002:a17:902:bc4c:: with SMTP id t12mr907572plz.76.1643231399224;
        Wed, 26 Jan 2022 13:09:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j33sm2559458pgl.90.2022.01.26.13.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:09:58 -0800 (PST)
Date:   Wed, 26 Jan 2022 13:09:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel test robot <lkp@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v3 1/3] string: Make stpcpy() possible to use
Message-ID: <202201261300.68D0EEB8@keescook>
References: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
 <CAKwvOdkBAe4qMdFgDFWNLHMsJrW+PBwa7-hAL5T9fReQqNiF7g@mail.gmail.com>
 <YfGPBi2VWlRHqxXe@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfGPBi2VWlRHqxXe@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 08:12:22PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 09:49:38AM -0800, Nick Desaulniers wrote:
> > On Wed, Jan 26, 2022 at 6:19 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > It is a good rule to avoid submitting code without users.
> > > Currently the stpcpy() is unusable due to missed declaration.
> > > Any attempts to use it will bring something like:
> > >
> > >   error: implicit declaration of function ‘stpcpy’ [-Werror=implicit-function-declaration]
> > >
> > > Move declaration to the header and guard it as other string functions.
> 
> ...
> 
> > Recall the discussion from Kees:
> > https://lore.kernel.org/lkml/CAK7LNAQXo5-5W6hvNMEVPBPf3tRWaf-pQdSR-0OHyi4RCGhjsQ@mail.gmail.com/
> > and
> > https://lore.kernel.org/lkml/202008150921.B70721A359@keescook/
> 
> For the record :-)
> https://lore.kernel.org/lkml/CAHp75VfniSw3AFTyyDk2OoAChGx7S6wF7sZKpJXNHmk97BoRXA@mail.gmail.com/
> [...
> strcpy() is not a bad API for the cases when you know what you are
> doing. A problem that most of the developers do not know what they are
> doing.
> No need to split everything to bad and good by its name or semantics,
> each API has its own pros and cons and programmers must use their
> brains.
> ...]

Developers should not need to remember to avoid foot-guns; the toolchain
should be doing all of that. The trouble is that C (and its standard
libs) are filled with foot-guns.

I do not want to add another foot-gun API to the kernel; we've been
working very hard to _remove_ them. :) If the kernel's stpcpy() _only_
worked on all known-size strings, etc, so that memory safety could be
determined at compile-time, then I'd have no objection.

What's not clear to me is if such macro versions would be workable for
the reason stpcpy() was added in the first place, which was the compiler
transforming other calls stuff into library calls it thinks are defined.

Totally untested:

#define stpcpy(dst, src) ({					\
	size_t _stp__dst = __builtin_object_size(dst, 1);	\
	size_t _stp__src = __builtin_object_size(src, 1);	\
								\
	BUILD_BUG_ON(_stp__dst == -1 || _stp__src == -1);	\
	BUILD_BUG_ON(_stp__src > _stp__dst);			\
								\
	__builtin_stpcpy(dst, src);				\
})

(Is there even a __builtin_stpcpy()?)

-- 
Kees Cook
