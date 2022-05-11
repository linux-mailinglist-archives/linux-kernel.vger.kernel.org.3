Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679AA522B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 06:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiEKEzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 00:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiEKEzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 00:55:37 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3781D7A45E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 21:55:36 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id n24so1384391oie.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 21:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtVYbChrQb9+TbAIbuoATF9Q1J0NgY2dl10/0GKd40Y=;
        b=Eth5/BcDhOsEjKlKqiQqgbB2THavdp8z3RyNtk5YZAEHxfd9cVU7iNxRneXMRjxQZt
         gEmtJASQ+JHR29IBv/kVR+yk9f4IPghCgmQ2YlgbuvwNHHNzW5B3e0lznhEam6bjpvR/
         qh476h+Pf9YBu5zOMvhF0UjnTtc6O2LvJ55JQmtXpyMw2tbnpNqRO1BxPPWVgyPTCwI3
         G2bd0CyyNXSOb2Z/VRocApl8C0gWZoXlvHkAx6eO7MIRMap+cZFOFeLPxs4mNpZfTrOB
         8HbDHOPKfrJqyHPkpgc69cYLh/y+P6ZgU+3Y1HY+Q9I2uxXGPoGriuXIUlwxfcFYc1Yc
         3CpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtVYbChrQb9+TbAIbuoATF9Q1J0NgY2dl10/0GKd40Y=;
        b=FbL8VyfcMMDPzZZbG7YKQbFr8s0GHkuhP8s0lw6XAIHjmrZaZlE5/S00DdIFyb6+uA
         Xvi92DnTPzcnNqPrUZKLNlvcGMHYPqeSMwbzDbR425MfPLzANatKnq2HOXNwPuWlQOUQ
         8d9LrfIi3tbBIlJ7A48KbAXy4VBy4atyPo32OohxnAgOi0lWB8wH2L+oGnNZ3sB0jYM8
         bW3BDJZHBhJJREdeWhrmKNFN2FEZTvUvplqd9QeACLCq8hvZbEgS6WW82qygX3xOb1M9
         JjNIqH0x99fziR3vJoIYTGx+rVTKpbhKF45KCXbq+iW/Om5EcbqzLozYp50BXvYxBO27
         1IBA==
X-Gm-Message-State: AOAM532wct9/NMvfI6/8/VxeeolX//+Dz0w9tyfanSb6RTjoqFM9tJTd
        Et+bzLgQB3EnOJ1lQu8NG9oTE8yAQlRdtxacZ/4=
X-Google-Smtp-Source: ABdhPJzwwFDw0VN3O8LuhruIoQBdA3jN1sQ6Mq3A8i+EhwCkbeEgwDrzC3GB+aabxhUD+hK1xiT5X6aBc7GGAaLDSrE=
X-Received: by 2002:a05:6808:1202:b0:2f9:c7b4:fd56 with SMTP id
 a2-20020a056808120200b002f9c7b4fd56mr1564634oil.55.1652244934349; Tue, 10 May
 2022 21:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220510154750.212913-1-yury.norov@gmail.com> <20220510154750.212913-9-yury.norov@gmail.com>
 <CAMo8Bf+JiyKD=g00whNOYGynx_0KjC_wJtpEBCB2ynFZ3U+e_Q@mail.gmail.com> <Ynq6JxyfBKK4SMZj@yury-laptop>
In-Reply-To: <Ynq6JxyfBKK4SMZj@yury-laptop>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 10 May 2022 21:55:23 -0700
Message-ID: <CAMo8BfKW15_vLWLHmxPDzB4qWNkH6R8yYJ4fMtVXRge6eMj3yA@mail.gmail.com>
Subject: Re: [PATCH 08/22] bitops: introduce MANY_BITS() macro
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 12:16 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> Hi Max,
>
> On Tue, May 10, 2022 at 10:57:25AM -0700, Max Filippov wrote:
> > Hi Yury,
> >
> > On Tue, May 10, 2022 at 8:48 AM Yury Norov <yury.norov@gmail.com> wrote:
> > > arch/xtensa/kernel/traps.c and include/linux/log2.h define very similar
> > > functions with different behaviour. XTENSA defines IS_POW2(), and
> > > log2.h defines is_power_of_2(). The difference is that IS_POW2()
> > > considers 0 as power of 2, while is_power_of_2() - does not.
> >
> > IS_POW2 is constructed this way because we know that there is at least
> > one non-zero bit in the value that it tests.
> >
> > > This discrepancy may confuse reader. From mathematical point of view,
> > > 0 is not a power of 2.
> >
> > If it would reduce the confusion we can add a check that the value is
> > non-zero in the IS_POW2 macro.
> >
> > I'd really like to not introduce the local macro and just use something
> > standard,
>
> This patch introduces a macro MANY_BITS() in include/linux/bitops.h, which
> is a full analogue of IS_POW2(). Would it work for you to switch to
> MANY_BITS()?

It would, I guess. It would also work if is_power_of_2 was a macro.

-- 
Thanks.
-- Max
