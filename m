Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4905046AF4F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378639AbhLGAop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351468AbhLGAoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:44:44 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05ECC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:41:14 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bi37so29533132lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIdEL53nOuAEWWraBxH2Sf1OMMrte3ZBjFe55W9HpZQ=;
        b=E3O5kgNkwKpGJAfYijYIis3nIYzqNI5uKUm+57c585pwv/tbe2hXRW79KARrf7k0uU
         xCa/ufxVvEanx8hkDRlRjTOItfQh71Y3IWsybe2U0IgNRLT7zbzouAZNHUOCtnRTEOfu
         MS5tJBOYoon2o6PHpiKdGvdmlPaXK6HPh09Pkh1MVb8Kw1NNrIQQsXKFJdhq6Om1x26y
         Yt3z+FOhW5Zu+exusnHVME0R4R3Cm/ynN0CDFHBVasJBLPzY/GhVvZhiZsjCwHTJ0BhF
         Mr16b/Q6pO+Va7Ws+IBcFgIWCIsRYPZGgd1/CPwtc7ocEtcSArSMpN/8G9kTC5uSyDjq
         mhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIdEL53nOuAEWWraBxH2Sf1OMMrte3ZBjFe55W9HpZQ=;
        b=WXgkFLTh7RDlZRehgDGwgpNzoW+VfoZiI6A50C5chVy57C7LfNINrsXdHNfgobcEQ2
         EZq7lZMB5ZfYMVXXuxdrOcjgmUKL6YpRdOkbwfG6Wo+jYA9Y5EMNqLWW2VMf77U233U7
         SiJmcdeS6m+omTxx1C+iW5Fx+T+Zg2iLeGzImnswyvhywbuo/vDpPlwh2lcNvEkxffZt
         RX+E7Sl8a+DNCl9N8+BVzY5v+OsSf0Zmab2AlCTZP9/yof7tML/LOUfwaKtGc8ppbH/c
         eOoh2P3R7Ad31fG44UaQFbjRYozsGTsyvr4hvROIwUHuNtz1IvPHB+SpaIQcYo6z//eX
         Qy1w==
X-Gm-Message-State: AOAM533gitXlMURKNGz1aS+jbBzO15yQ2ehoxvZ8B0ckM4BAbzegEf99
        C3n9LkYnZyorGby69uOlbo9fhzN2HlLuuLisL+cUJc8xpST71Q==
X-Google-Smtp-Source: ABdhPJzhj5DNFAKr3BTQqYHXWFPODGzuEK9YDqY1brCLRpCiSW6jgBE1YVxRQOsGdhG3vbOnzYjUIgTsolXxUHeDZqg=
X-Received: by 2002:a05:6512:228c:: with SMTP id f12mr8230554lfu.550.1638837672966;
 Mon, 06 Dec 2021 16:41:12 -0800 (PST)
MIME-Version: 1.0
References: <CAKwvOdnoxaHHYMN-=fW6-W_bN+VrWvD32cidGa7qnYHmR=k2YA@mail.gmail.com>
In-Reply-To: <CAKwvOdnoxaHHYMN-=fW6-W_bN+VrWvD32cidGa7qnYHmR=k2YA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Dec 2021 16:41:00 -0800
Message-ID: <CAKwvOdkgHhOTKbb4vm9p7uDvvp7eXpTg2cb4rvr1jFgyAgSb-w@mail.gmail.com>
Subject: Re: [PATCH] numa: mark __next_node() as __always_inline to fix
 section mismatch
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 12:57 PM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> From: Nick Desaulniers <ndesaulniers@google.com>
> Date: Mon, 6 Dec 2021 11:43:47 -0800
>
> > On Mon, Dec 6, 2021 at 8:19 AM Alexander Lobakin
> > <alexandr.lobakin@intel.com> wrote:
> > >
> > > Clang (13) uninlines __next_node() which emits the following warning
> > > due to that this function is used in init code (amd_numa_init(),
> > > sched_init_numa() etc.):
> > >
> > > WARNING: modpost: vmlinux.o(.text+0x927ee): Section mismatch
> > > in reference from the function __next_node() to the variable
> > > .init.data:numa_nodes_parsed
> > > The function __next_node() references
> > > the variable __initdata numa_nodes_parsed.
> > > This is often because __next_node lacks a __initdata
> > > annotation or the annotation of numa_nodes_parsed is wrong.
> > >
> > > Mark __next_node() as __always_inline() so it won't get uninlined.
> > > bloat-o-meter over x86_64 binaries says this:
> > >
> > > scripts/bloat-o-meter -c vmlinux.baseline vmlinux
> > > add/remove: 1/1 grow/shrink: 2/7 up/down: 446/-2166 (-1720)
> > > Function                                     old     new   delta
> > > apply_wqattrs_cleanup                          -     410    +410
> > > amd_numa_init                                814     842     +28
> > > sched_init_numa                             1338    1346      +8
> > > find_next_bit                                 38      19     -19
> > > __next_node                                   45       -     -45
> > > apply_wqattrs_prepare                       1069     799    -270
> > > wq_nice_store                                688     414    -274
> > > wq_numa_store                                805     433    -372
> > > wq_cpumask_store                             789     402    -387
> > > apply_workqueue_attrs                        538     147    -391
> > > workqueue_set_unbound_cpumask                947     539    -408
> > > Total: Before=14422603, After=14420883, chg -0.01%
> > >
> > > So it's both win-win in terms of resolving section mismatch and
> > > saving some text size (-1.7 Kb is quite nice).
> > >
> > > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> >
> > Thanks for the patch.  See this thread:
> > https://github.com/ClangBuiltLinux/linux/issues/1302
> >
> > There's a lot more instances of these based on config.  Something like
> > https://github.com/ClangBuiltLinux/linux/issues/1302#issuecomment-807260475
> > would be more appropriate for fixing all instances, but I think this
> > is more so an issue with the inline cost model in LLVM.
> >
> > I need to finish off https://reviews.llvm.org/D111456, and request
> > that https://reviews.llvm.org/D111272 which landed in clang-14 get
> > backported to the 13.0.1 release which should also help.
>
> Oh I see. Sorry for redundant posting, non-applicable then.

No worries; it's a complex issue.  I appreciate that you took the time
to test with clang, understand the issue, and send a patch.
++beers_owed;

If you'd like, I can add you to our github org if you'd like to be
cc'ed on issues there; just ping me privately off thread with your
github account and I'll add you.
https://github.com/ClangBuiltLinux

> We'll wait for these Clang/LLVM works to be finised, thanks!
>
> >
> > > ---
> > >  include/linux/nodemask.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> > > index 567c3ddba2c4..55ba2c56f39b 100644
> > > --- a/include/linux/nodemask.h
> > > +++ b/include/linux/nodemask.h
> > > @@ -266,7 +266,7 @@ static inline int __first_node(const nodemask_t *srcp)
> > >  }
> > >
> > >  #define next_node(n, src) __next_node((n), &(src))
> > > -static inline int __next_node(int n, const nodemask_t *srcp)
> > > +static __always_inline int __next_node(int n, const nodemask_t *srcp)
> > >  {
> > >         return min_t(int,MAX_NUMNODES,find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
> > >  }
> > > --
> > > 2.33.1
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
> Al
>


-- 
Thanks,
~Nick Desaulniers
