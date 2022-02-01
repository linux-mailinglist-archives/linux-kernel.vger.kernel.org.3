Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387754A57BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiBAH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiBAH2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:28:25 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681EFC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:28:25 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id s1so13524566ilj.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAgSBjoIyHX/oj6lIax6JelSVxl32DfZwuq22tKBhtQ=;
        b=GZTAj95orWtrp09+80TRvqGSNDC1HpefGz3cLqYw5Go1K/wzNTUUXiGmKulYMvgqoF
         l+qUZ1rdFCCz2Ipn2ZvNkCh81k+R75didtuwiwsiwt+ycsQhDZbo9fVOhwnIhXTkOOBA
         osv1oVy2xuzW/P6Zz7D8qGMJcuMVWa+YEU4Kl4TsLSjqpdx8NhVU1Ba5jdzL7bOYbEkE
         M6v8zb2h4c9W8YHJ6um1FpYY6xN3ccIMplK3TRu1+EcFXP9MemqRns+0xeit8JwNhR23
         6zmRQ4iPDmZbwzFJqlExcDQwvMkrLRTgfpgtlxc0ogaTaC6XUgh8lCMx/t79Dz+pGNFA
         mhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAgSBjoIyHX/oj6lIax6JelSVxl32DfZwuq22tKBhtQ=;
        b=ippuPl9eHBW/d79dl8KTRxyYRz8PTK7pZBWonT9QW5LSzYbPQyQ6f4mnQXvplYa39G
         ZBGJIkKwcOJpscehjIn6kbdaPv0zIWFfjCFiU1WmAd/QlFFDGzozAC2CIALkjKpSZ382
         A4DaGl7ahWWfc75CEcnMQg5Hkoyr/ezcF8ovVoMN1mN8xpoZGnCMo0smayYq/e+5S1Oz
         rIDeZ3Vd8yr0Hg5vqH5yDPPzsyZOeekDXkjpvFbEv3ZCvGj1S+ZHOEYA3BmXde9R1+oQ
         Hb3EmQ0EKlJ9ek6paQwUIEmDtjmw8/O3RfppvAB71a9dum2NypY0VcGcSbZnZSboWBuh
         5Gnw==
X-Gm-Message-State: AOAM532NVOZHLiVH9IiR7ngaAXxfuJbZEE2L/1FReriCML+l04/TQ8cm
        l7MhWOo/j8Hzysx6gIZD/ElauTdb/VY79WbKAB08SMzVFIc=
X-Google-Smtp-Source: ABdhPJzHz6JBQ7k+GyJaIJ/K8d3sniHClIA5KopFfYqMhn/0cOUh6vXgvEAi9LWBL/8Tkm+DiQiYHlpt2gpUznNbmT8=
X-Received: by 2002:a05:6e02:1d17:: with SMTP id i23mr13949747ila.185.1643700504626;
 Mon, 31 Jan 2022 23:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com> <20220126233454.3362047-8-eranian@google.com>
 <YfKVYbYDYfIOq32I@hirez.programming.kicks-ass.net>
In-Reply-To: <YfKVYbYDYfIOq32I@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 31 Jan 2022 23:28:13 -0800
Message-ID: <CABPqkBQBNyXQrdRGzzK-oN6bty6nLC3UfbDfkqGiE8wFKZFCSw@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] perf/x86/amd: make Zen3 branch sampling opt-in
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 4:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 26, 2022 at 03:34:48PM -0800, Stephane Eranian wrote:
> > This patch adds a kernel config option to make support
> > for AMD Zen3 Branch Sampling (BRS) an opt-in compile
> > time option.
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > ---
> >  arch/x86/events/Kconfig      |  8 ++++++
> >  arch/x86/events/amd/Makefile |  3 ++-
> >  arch/x86/events/perf_event.h | 49 ++++++++++++++++++++++++++++--------
> >  3 files changed, 49 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
> > index d6cdfe631674..1dc002ef66da 100644
> > --- a/arch/x86/events/Kconfig
> > +++ b/arch/x86/events/Kconfig
> > @@ -44,4 +44,12 @@ config PERF_EVENTS_AMD_UNCORE
> >
> >         To compile this driver as a module, choose M here: the
> >         module will be called 'amd-uncore'.
> > +
> > +config PERF_EVENTS_AMD_BRS
> > +     depends on PERF_EVENTS && CPU_SUP_AMD
> > +     tristate "AMD Zen3 Branch Sampling support"
>
> tristate ?!

Ok, I will fix that in V6.
Thanks.
