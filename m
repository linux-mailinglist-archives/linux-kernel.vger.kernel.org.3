Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AF55272E7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 18:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiENQ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiENQ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 12:27:54 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011552CE18
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 09:27:53 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 24EGRdvN005103
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 01:27:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 24EGRdvN005103
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652545660;
        bh=U5dGlEecDnUtacsW7JN0vjLDi97Aeo5TM9Zryhdd8k8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=po2L6BCtmDYAR1YpThPMOyQzQRONg7xEuhvoLO00ziTl0e97fGEeGXXJjl9F8w71M
         mqQD7BmyTm34oS3ZHlwvwTRVaP2/cFO3cmCjhl+/x7UqmvdFHIZpBMJBDQzYwlsOPU
         Go8T9Cdy2KnqJLCgfQYVn87UMM5wm8nMIRJ6EGy6/rFRhBPlNByioCdeYxkNIyDrE3
         nlcSydM7HsTKOSPsDh9lsSSrT0GN7ADawxuXQwv8Fhhgiv0Zx3p1qI8O3ehdiTq/Do
         Nm+UJLIPQun/QKitPLTY3lXyF6XdbfFK1VIJS1UO/3Z8q0bBUYlTI2VBe9nCGoTJz9
         39spLhYG2lhPg==
X-Nifty-SrcIP: [209.85.214.175]
Received: by mail-pl1-f175.google.com with SMTP id s14so10702645plk.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 09:27:40 -0700 (PDT)
X-Gm-Message-State: AOAM533L0kXMOuQblDMJ9FURDuICmQbRoDLp0Zw0xAjB9faM+H6II4/I
        HI5GaHDJV+VPqyFb+extrZbOXeU0TZ3A6Boeu14=
X-Google-Smtp-Source: ABdhPJzpJ28/pSSUxIXWLQ0I+AmJhfpuaXfE4Y8A9Nqe7RPNBxgtm37xc3XY6bsZ9D2KzQRz1rJaN0kpReXpUr817b0=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr9984452plh.99.1652545659306; Sat, 14 May
 2022 09:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-1-mailhol.vincent@wanadoo.fr> <20220507131146.834810-3-mailhol.vincent@wanadoo.fr>
 <CAK7LNATuvQhiZZ8A9+RcLYKmbugi6S61Aw5CStc3xbfGM-L34Q@mail.gmail.com>
 <20220514131448.GL76023@worktop.programming.kicks-ass.net> <20220514145551.GC100765@worktop.programming.kicks-ass.net>
In-Reply-To: <20220514145551.GC100765@worktop.programming.kicks-ass.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 15 May 2022 01:26:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR+F5PspM+6CP+H+443nJYy+Rg3jmKp1NyJeepq9sSFQA@mail.gmail.com>
Message-ID: <CAK7LNAR+F5PspM+6CP+H+443nJYy+Rg3jmKp1NyJeepq9sSFQA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] kbuild: call check-atomics.sh only if
 prerequisites change
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 11:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, May 14, 2022 at 03:14:48PM +0200, Peter Zijlstra wrote:
> > On Sat, May 14, 2022 at 04:01:18AM +0900, Masahiro Yamada wrote:
> > > I wrote a different patch.
> > > https://lore.kernel.org/lkml/20220513185340.239753-1-masahiroy@kernel.org/T/#u
> >
> > I'm not seeing that in my inbox :-(
> >
> > AFAICT this way 'make tags' will not find and index the files, which is
> > a total no-go.
> >
> > NAK
>
> Additionally, if you spuriously regenerate these files, you'll risk
> rebuilding huge parts of the kernel through the dependencies.

This is just one-time copying.
Rebuild only happens just once.


BTW, gen-atomics.sh takes more than 1 sec.
Do you think gen-atomics.sh can be much faster
if it is rewritten by Python or Perl?
Then, we can drop 5000 lines from the git repository.



-- 
Best Regards
Masahiro Yamada
