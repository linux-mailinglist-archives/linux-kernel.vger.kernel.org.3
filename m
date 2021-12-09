Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084F246E8B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhLINCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbhLINCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:02:21 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81183C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:58:48 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so1663925ooe.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 04:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxsC+6JiZmFDaNw110BSUcqVFCAa+894CcThmcjMkw4=;
        b=ODJRjouncmQdis6R3Wkh0AAmsVvD75zmtLay+9U5trU4UpmYi+Oafvfm9sYnpZKsNL
         +irLZobZ5CaBUGopda5OwI8/bBOPE//XpncmNzbCZxDrcpwvZHA35nNFZZful9gS93z9
         gffPJXdFC1OHKb9ZlVzm3VEkvl2maD5ppEcIOpcUR7zICKJlYcNPm9G3T3edTzp8qPNK
         4RZaSjhSb0qco+YzxVmH9msEqP4GGXzg6r+yr+uustf2sqOcsAx2ut9+mYs7tW1+Ne3s
         s03kNoTB7kVEt3lkJ/+JkIPVrQtJG+cdPH6uiAvTYrG9GiWbD60xezK8cLkJ+ErnbUZe
         c+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxsC+6JiZmFDaNw110BSUcqVFCAa+894CcThmcjMkw4=;
        b=70MneStzqcmFJO6nuB4ceF7VF+LVr6OXZYRDjRZr+zbQgdFm8SFRLliPGuSMV3pQa3
         y2HhmQ/5paKrFbBup17M5nR8p4cx/wzvRUza4qtlpOgDzjImOCnPGCa3nn5DsvLT0Bdx
         2tCNEowEaTG66YEs46JhVkV4fvJZqeSdSbxeQOKrlr3ZfIShOgo2graU/mUIFkeEV0Cg
         4f86jkREic4kX3M6CjFUanTT5VdbjNL/kQSss6zj+gyn9en4t0i/Kp3oJWimvuIRZmkL
         2FrOhqWA2g8fqnvGIXwHbaQd1rY0Eoh6kya2fhcfbjcjA4COfyH4erk+jVYXer25yNUq
         +CRg==
X-Gm-Message-State: AOAM5324oxU0/2ydSCgoC5/euPH/Hop5TmrtuebjA0O5q0eWwdee/K1g
        XLvGiHBSkD0DcmTC/I3tBey2WgwPtNukpHMsiBpJmA==
X-Google-Smtp-Source: ABdhPJx1kHulafJl7mfoeK/Aaae12wnFfqTO5IQ/HVdFm8xIC0tzHu8TGZCUdVjrgJX5a2XnFm74ss0UQEZzk/RMIwM=
X-Received: by 2002:a4a:cf12:: with SMTP id l18mr3585635oos.25.1639054727653;
 Thu, 09 Dec 2021 04:58:47 -0800 (PST)
MIME-Version: 1.0
References: <YbHTKUjEejZCLyhX@elver.google.com> <YbHaASWR07kPfabg@hirez.programming.kicks-ass.net>
In-Reply-To: <YbHaASWR07kPfabg@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Dec 2021 13:58:35 +0100
Message-ID: <CANpmjNODi8sLHe8JoU-phddf++vh+1sW90b08j-yM7chsecxyg@mail.gmail.com>
Subject: Re: randomize_kstack: To init or not to init?
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 at 11:27, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Dec 09, 2021 at 10:58:01AM +0100, Marco Elver wrote:
[...]
> > There are several options:
> >
> >       A. Make memset (and probably all other mem-transfer functions)
> >          noinstr compatible, if that is even possible. This only solves
> >          problem #2.
>
> While we can shut up objtool real easy, the bigger problem is that
> noinstr also excludes things like kprobes and breakpoints and other such
> goodness from being placed in the text.
>
> >       B. A workaround could be using a VLA with
> >          __attribute__((uninitialized)), but requires some restructuring
> >          to make sure the VLA remains in scope and other trickery to
> >          convince the compiler to not give up that stack space.
> >
> >       C. Introduce a new __builtin_alloca_uninitialized().
> >
> > I think #C would be the most robust solution, but means this would
> > remain as-is for a while.
> >
> > Preferences?
>
> I'm with you on C.

Seems simple enough, so I've sent https://reviews.llvm.org/D115440 --
either way, there needs to be support to not initialize alloca'd
memory. Let's see where we end up.
