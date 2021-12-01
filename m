Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39674464DD4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349261AbhLAM3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349118AbhLAM2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:28:51 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724AAC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 04:25:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p18so20182913wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 04:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/VpVmarBw9whoqo69hsGGcwvYMobgPzZpxkfiHB1VAE=;
        b=dmcIwASmKxEiWRNHj8WOjEWpPZk1NcpcbBvh3PINxB6azAoPR0GORremUYkq/u5p4c
         45RtiTHpN8S9UZEpqeOy5/e6zUJDapJGiDbu9gcYLKKGI6tl90chdOjMaIqO+sQrWs1B
         psyg/Kfja++NgRryn6pOYBhrjPINvzJTk9XV8dWXdFGDDV47Ou1NDg2ZReSBbMUeznHG
         oOO5zmk4Fe1JaqLFRiwW4gBD+yBHTC0kPmI+lhmiu5ksNtPkYSkoAAtXYZQe0N2JIz4K
         H6SvtyfFJnB63I8OKmhjborpHNUlQ/9FbRc9DxfiVl8e7Td9Dr4aXzxlKwNlCOXehJgC
         7DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/VpVmarBw9whoqo69hsGGcwvYMobgPzZpxkfiHB1VAE=;
        b=x4UeLPIc48J08l4ZukM2DKMj0VDjf201F8pBWzFtxrPf+BnLDWZjWW4UGMObudgSL9
         bUEmZE4bUF4as2XEK2ebR7k4Bp5aAxXhNaiTGJB+4y2E73UUBSifbw8BigfPRmwwUxkO
         0fYEdwqmAdcUZ17DrwvZKW2U30KTXF4v89rAQogmpIu0XJcTJRIReqZ9K67PPnm+XvZD
         ekCE8Hxz0RO2EMFuh6XhBOMwa3p/jgRv7pEOsXDB+p2B6dfSrQ8JBZ9/PIO01o/pcMjr
         5bcRXtI0AunJE9KszogAu63LHdKEcim3/ZTU/we6Chfbush8qD7zfO67wjXQNfz4JSQa
         Lkdw==
X-Gm-Message-State: AOAM532liZ/07ecz1hipuR7rw69KTbDpCj4tp3bExn3Nl3ooYOCvRwkq
        OV5HeNBaCQudOHpzpssRB4NkzQ==
X-Google-Smtp-Source: ABdhPJxzp6GynBFkmQPfRx/32lBrntPbRnhAZHHSbOIjnmSDWQTHJ3NhSLS92l5ME1N2JmnEzcnBbA==
X-Received: by 2002:a1c:1c1:: with SMTP id 184mr6601857wmb.1.1638361528876;
        Wed, 01 Dec 2021 04:25:28 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:95ad:1401:cf07:6d1a])
        by smtp.gmail.com with ESMTPSA id h13sm19707105wrx.82.2021.12.01.04.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 04:25:28 -0800 (PST)
Date:   Wed, 1 Dec 2021 13:25:22 +0100
From:   Marco Elver <elver@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joey.gouly@arm.com
Subject: Re: [PATCH v2] arm64: Enable KCSAN
Message-ID: <YadpsjyfdozccsOT@elver.google.com>
References: <20211129145732.27000-1-wangkefeng.wang@huawei.com>
 <YadiUPpJ0gADbiHQ@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YadiUPpJ0gADbiHQ@FVFF77S0Q05N>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:53AM +0000, Mark Rutland wrote:
[...]
> * In the past clang did not have an attribute to suppress tsan instrumenation
>   and would instrument noinstr regions. I'm not sure when clang gained the
>   relevant attribute to supress this, but we will need to depend on this
>   existing, either based on the clang version or with a test for the attribute.
> 
>   (If we're lucky, clang 12.0.0 is sufficient, and we solve BTI and this in one
>   go).
> 
>   I *think* GCC always had an attribute, but I'm not certain.
> 
>   Marco, is there an existing dependency somewhere for this to work on x86? I
>   thought there was an objtool pass to NOP this out, but I couldn't find it in
>   mainline. If x86 is implicitly depending on a sufficiently recent version of
>   clang, we add something to the common KCSAN Kconfig for ARCH_WANTS_NO_INSTR?

Apologies for the confusion w.r.t. attributes and which sanitizers on
which compilers respect which attributes. I think you may be confusing
things with KCOV (see 540540d06e9d9). I think the various 'select
ARCH_HAS_KCOV' may need adjusting, that is true.

But KCOV != KCSAN, and for KCSAN the story is different. Since the first
version of KCSAN in 5.8, we've had a working __no_kcsan (aka
__no_sanitize_thread) with all versions of Clang and GCC that support
KCSAN (see HAVE_KCSAN_COMPILER).

The recent discussion was for CONFIG_KCSAN_WEAK_MEMORY [1], because
Clang's no_sanitize("thread") would still instrument builtin atomics and
__tsan_func_{entry,exit}, which only that mode would start inserting
instrumentation for. That's not in mainline yet.

[1] https://lkml.kernel.org/r/20211130114433.2580590-1-elver@google.com

It is true that v1 and v2 of that series would have caused issues on
arm64, but after our discussion last week and tried a little harder and
v3 does the right thing for all architectures now and __no_kcsan will
disable all instrumentation (even for barriers).

So the attribute and noinstr story should not need anything else, and
the new KCSAN_WEAK_MEMORY has all right Kconfig dependencies in place
when it lands in mainline.

> * There are some latent issues with some code (e.g. alternatives, patching, insn)
>   code being instrumentable even though this is unsound, and depending on
>   compiler choices this can happen to be fine or can result in boot-time
>   failures (I saw lockups when I started trying to add KCSAN for arm64).
> 
>   While this isn't just a KCSAN problem, fixing that requires some fairly
>   significant rework to a bunch of code, and until that's done we're on very
>   shaky ground. So I'd like to make KCSAN depend on EXPERT for now.

I take it you mean arm64 should do 'select HAVE_ARCH_KCSAN if EXPERT'. I
certainly don't mind, but usually folks interested in running debug
tools won't be stopped by a dependency on EXPERT. You could do 'select
HAVE_ARCH_KCSAN if BROKEN' which is more likely to prevent usage while
things are still likely to be broken on arm64.

Thanks,
-- Marco
