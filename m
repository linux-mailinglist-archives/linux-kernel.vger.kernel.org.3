Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1147544B93
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbiFIMSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbiFIMSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:18:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32ED15730
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:18:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c4so5651089lfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCB93MU2lyB4bbkAlS32u/raZUY6pI3+1JJtxGQYwOs=;
        b=SnGVLIFVmkWS/5O3WR5Yn2W2Ds1NFqEfS3sI+ejy5eoIAJbLfPG165wJGZZKyDgJX6
         IgbU7A4xDIoB4/5BJPf3t9jq3L2YzNf5tEl48IUCjpABmyCvmqoF6ZvT4hx8E3sNDw27
         gdOttApmEh9PCcTdXgKIET8ItTeCRFIXikV9nCjm+xRC415Jh6PGndXoZGJmxiTADG0s
         +iq25xjR3o1sMUNjuHcZjsEe+P+bGz8WqiC2RDA/GZ6/ddEoDBVWiczPATaRuUyQHC5K
         vocV4QEFzvN97BYgCXdHQ7nLfENH2uTjFwOpCdClRH5hQ53JLHFCWzs6ZrDPecvXlYOY
         n54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCB93MU2lyB4bbkAlS32u/raZUY6pI3+1JJtxGQYwOs=;
        b=WDT+91O5cjCw2qTlUowYc0yH+fl2/nngn83CVRQfF8Lq16Nu+dvFxi8QX0vduSvFyl
         nJMJifp2PcIq5P0b2OFujMjMp87xQaz3TgUVkeHTAd3YNx/PIZpWqJtsBL2jIy3r1+k9
         TICc9a+ci8sfbA7yL1x16Xlz9/CUCtt9ryR/k4hn2a/H1Ouzv9hksVzPaXrCkB3ylRDi
         rtxDkWhkkadrPGRRGZw3fUn3BLEP87Hi4wcYYaGBZH59njUjSJqOm7mARcFp4G6S6lp6
         GWGw+fKWmif9S/EenGzeKTORubx3NF1Bk2TqFUnhp2vvDvQkGxlJWXO3zaVAihzgrp2r
         miQA==
X-Gm-Message-State: AOAM5309PiHBVfcDwZSkzbh+KwmHzKiYJd0QWj/4QLHd7LpjQh9YTXk7
        zjgCMXS/LvgsjCuJNOOOGTr1VxfS9Ge9CL9DaUY7Ng==
X-Google-Smtp-Source: ABdhPJy/2ggc9B0vGeMRo0sX4stf8bv7Rwug9333U8wn2aBgx+asd6E1GNcEibqrTYwRXm68Iqlt0BoAgM0kft2UWtM=
X-Received: by 2002:a05:6512:3f13:b0:464:f55f:7806 with SMTP id
 y19-20020a0565123f1300b00464f55f7806mr25244406lfa.598.1654777110811; Thu, 09
 Jun 2022 05:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <Ymjy3rHRenba7r7R@alley> <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de> <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de> <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
 <87y1zkkrjy.fsf@jogness.linutronix.de> <CAMuHMdVmoj3Tqz65VmSuVL2no4+bGC=qdB8LWoB=vyASf9vS+g@mail.gmail.com>
 <87fske3wzw.fsf@jogness.linutronix.de> <YqHgdECTYFNJgdGc@zx2c4.com>
In-Reply-To: <YqHgdECTYFNJgdGc@zx2c4.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 14:18:19 +0200
Message-ID: <CACT4Y+ajfVUkqAjAin73ftqAz=HmLX=p=S=HRV1qe-8_y36J+A@mail.gmail.com>
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for per-console locking
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 at 13:59, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi John,
>
> On Thu, Jun 09, 2022 at 01:25:15PM +0206, John Ogness wrote:
> > (Added RANDOM NUMBER DRIVER and KFENCE people.)
>
> Thanks.
>
> > I am guessing you have CONFIG_PROVE_RAW_LOCK_NESTING enabled?
> >
> > We are seeing a spinlock (base_crng.lock) taken while holding a
> > raw_spinlock (meta->lock).
> >
> > kfence_guarded_alloc()
> >   raw_spin_trylock_irqsave(&meta->lock, flags)
> >     prandom_u32_max()
> >       prandom_u32()
> >         get_random_u32()
> >           get_random_bytes()
> >             _get_random_bytes()
> >               crng_make_state()
> >                 spin_lock_irqsave(&base_crng.lock, flags);
> >
> > I expect it is allowed to create kthreads via kthread_run() in
> > early_initcalls.
>
> AFAIK, CONFIG_PROVE_RAW_LOCK_NESTING is useful for teasing out cases
> where RT's raw spinlocks will nest wrong with RT's sleeping spinlocks.
> But nobody who wants an RT kernel will be using KFENCE. So this seems
> like a non-issue? Maybe just add a `depends on !KFENCE` to
> PROVE_RAW_LOCK_NESTING?

Don't know if there are other good solutions (of similar simplicity).
But fwiw this is not about the target production environment. Real
production uses of RT kernels will probably not enable LOCKDEP,
PROVE_RAW_LOCK_NESTING and other debugging configs.
This is about detecting as many bugs as possible in testing
environments. And testing environments can well have both LOCKDEP and
KFENCE enabled. Any such limitation will require doubling the number
of tested configurations.

Btw, should this new CONFIG_PROVE_RAW_LOCK_NESTING be generally
enabled on testing systems? We don't have it enabled on syzbot.
