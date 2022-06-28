Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB7855DDAE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345191AbiF1MKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345177AbiF1MKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:10:19 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C89340E1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:10:17 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 25SCA1Fj015030
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:10:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 25SCA1Fj015030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656418202;
        bh=JffHlLZUherizBJLBM6/lGEJp5Xw5S7lrKLMg+knO2w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BeUghGFX90w9S5IO0k+SelnLeP+l3MRYfC5E0ae08BxwWRIn3M4wDSO4PjtNk1mZh
         1Z2Ar7YltBJQIXdPrpIGcCwlQFyqFjAhL7Gh6cCxl7CGhOjpzsTuRi3IiOIt0tnEOj
         EVD7zGvg47oprs/TIZ6syY+ojGgI8suZvcHfLuK9aE1cja1xY466dOjQ+OQsO4hUo+
         T42W6ktWrc+txo6xMCZz10DMXRZiWWND0AP3VtzysE1gROO5DXp1hbEy4XcXEpaD7z
         ylaezMY3F0Gsc67hOJ1D4JV0LQsq0/GhAk7R63U4D2ccdLw2SiQpkXy4iteTky/8Ke
         4ogscDZiMxErg==
X-Nifty-SrcIP: [209.85.221.42]
Received: by mail-wr1-f42.google.com with SMTP id r20so17415809wra.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:10:01 -0700 (PDT)
X-Gm-Message-State: AJIora+jIrh/4jQGwSERBoQmXA9XXsxpRJN5rjvEYFJsvyRL7DBNNIkR
        qAhNGjrhf7T0x+DR/YBKdVRq62hmUbCpNT6eQk8=
X-Google-Smtp-Source: AGRyM1tpiwttX8FqPdH5q1m75vQCfluEK71LeFogIy0H3hH7HeevJfBA58bpbgRZ6aatq5fza6yuAwfbPQ2jIvK/h9Q=
X-Received: by 2002:adf:f5ce:0:b0:21b:832c:80dd with SMTP id
 k14-20020adff5ce000000b0021b832c80ddmr17211750wrp.235.1656418200142; Tue, 28
 Jun 2022 05:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <YrrQOifFIiISf/3g@hirez.programming.kicks-ass.net>
 <CAK8P3a2XfzQo6emT4pXXxAjWewdP2LiAe2fOskFf-0suSmBJQQ@mail.gmail.com> <Yrrtm0rRzLMCzKiM@hirez.programming.kicks-ass.net>
In-Reply-To: <Yrrtm0rRzLMCzKiM@hirez.programming.kicks-ass.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 28 Jun 2022 21:09:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNATdKXX5fnNCrJEj9dLgew5f4geCKai5gOrTMWR=vYT0UA@mail.gmail.com>
Message-ID: <CAK7LNATdKXX5fnNCrJEj9dLgew5f4geCKai5gOrTMWR=vYT0UA@mail.gmail.com>
Subject: Re: [RFC][PATCH] kconfig: Add implicit CONFIG_ prefix to IS_ENABLED()
 and co
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.cz>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 9:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 28, 2022 at 01:19:17PM +0200, Arnd Bergmann wrote:
> > On Tue, Jun 28, 2022 at 11:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Since IS_ENABLED() (and friends) are clearly meant to be used on
> > > CONFIG_foo symbols and IS_ENABLED(CONFIG_ is so long and almost an
> > > tautology, allow the more compact usage of: IS_ENABLED(foo).
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > I'd prefer to keep the more verbose usage, mainly because it makes it easier
> > to grep for a symbol. If today you do 'git grep CONFIG_PM_SLEEP', you find
> > all instances in Makefile, in #ifdef and in IS_ENABLED(), though not the
> > references in Kconfig language, which leave out the prefix.
>
> Which is why I never grep for the CONFIG_ thing to begin with, it misses
> the Kconfig site.
>
> > If we remove the prefix for IS_ENABLED(), the same grep fails to get
> > all the results, while searching for the substring without the CONFIG_
> > prefix can end up finding false-positives by finding longer strings (e.g.
> > CONFIG_DEBUG_STACKOVERFLOW vs
> > CONFIG_HAVE_DEBUG_STACKOVERFLOW).
>
> Me being used to that doesn't consider that a real issue :-) I'd much
> rather have the somewhat shorter IS_ENABLED() things.




One more thing worth mentioning, this patch does
not even work correctly.


scripts/basic/fixdep.c searches for CONFIG_ prefix.
This works nicely, and there is no reason to lose this simplicity.


NACK.

-- 
Best Regards
Masahiro Yamada
