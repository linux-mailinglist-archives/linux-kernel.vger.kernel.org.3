Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1589354C5F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347768AbiFOKWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242728AbiFOKVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:21:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EFA5130A;
        Wed, 15 Jun 2022 03:20:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 626BDCE1EAF;
        Wed, 15 Jun 2022 10:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A222FC3411C;
        Wed, 15 Jun 2022 10:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655288435;
        bh=ADWNwalPsj7wlzAK4STHI1I3vbvADJHLuzQJhszxX8c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y7wogYQbzqKyD6JEqXbaMxzp/l8MWvg+8x9iOIJ+wpI+Ktjxakhgy/0uDZVfe/73b
         Aq+okQgvH8mxgO8oRvY+kYStktMkS3/ksME5k6wZoo/WN5cgyUgeXEWDLIFRn4gMtZ
         vIQEymiSa90u/BGkczf9XwvnVz4N2tpkuHjTf7YEnaAufwbuXcH0ym6IaIwYvhF0b1
         7ygSeQoPdgvK/1avI8sHeS8nRRAZ0pucud/TEcCijnRkUp8e5K+o8ypNiR2QsKkyz+
         oSdFGBlTJMRVEtLSQSdbHiwCjJVt5UvyBKm8GBE2b25/2Qs3eNrg18F4/1fxaX8D6Y
         lnsfzZkCSi6bw==
Received: by mail-ot1-f50.google.com with SMTP id s20-20020a056830439400b0060c3e43b548so8499707otv.7;
        Wed, 15 Jun 2022 03:20:35 -0700 (PDT)
X-Gm-Message-State: AOAM5306pP1JuWW0En0s8WX5ZOa74779Pa/KGiSFZvHv1GTKr7GePTH+
        dy6vQS+vm5aNs5eJUujddrZdv5vJJliFKv7s/5c=
X-Google-Smtp-Source: ABdhPJwWPYfdpESn/ZfR63iU+BQ4uVPMs4SdDmopyiZZb6tFOGP0dMOcdj9I8c73xtXC57WSh/UYFNp5DHskI5jx+vs=
X-Received: by 2002:a9d:37a3:0:b0:60c:5427:1f56 with SMTP id
 x32-20020a9d37a3000000b0060c54271f56mr3970819otb.71.1655288434829; Wed, 15
 Jun 2022 03:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220608104512.1176209-1-ardb@kernel.org> <20220608104512.1176209-4-ardb@kernel.org>
 <Yqmr6fvu4OYkarCm@FVFF77S0Q05N> <YqmvL2Biw3TnIl7a@hirez.programming.kicks-ass.net>
In-Reply-To: <YqmvL2Biw3TnIl7a@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Jun 2022 12:20:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHUQMA5A54KnVDR+dbwVv+H25xCJyUBpTkrYF7FgpNr8w@mail.gmail.com>
Message-ID: <CAMj1kXHUQMA5A54KnVDR+dbwVv+H25xCJyUBpTkrYF7FgpNr8w@mail.gmail.com>
Subject: Re: [PATCH 3/3] jump_label: make initial NOP patching the special case
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:S390" <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 at 12:06, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jun 15, 2022 at 10:52:41AM +0100, Mark Rutland wrote:
> > On Wed, Jun 08, 2022 at 12:45:12PM +0200, Ard Biesheuvel wrote:
> > > Instead of defaulting to patching NOP opcodes at init time, and leaving
> > > it to the architectures to override this if this is not needed, switch
> > > to a model where doing nothing is the default. This is the common case
> > > by far, as only MIPS requires NOP patching at init time. On all other
> > > architectures, the correct encodings are emitted by the compiler and so
> > > no initial patching is needed.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  Documentation/staging/static-keys.rst |  3 ---
> > >  arch/arc/kernel/jump_label.c          | 13 -------------
> > >  arch/arm/kernel/jump_label.c          |  6 ------
> > >  arch/arm64/kernel/jump_label.c        | 11 -----------
> > >  arch/mips/include/asm/jump_label.h    |  2 ++
> > >  arch/parisc/kernel/jump_label.c       | 11 -----------
> > >  arch/riscv/kernel/jump_label.c        | 12 ------------
> > >  arch/s390/kernel/jump_label.c         |  5 -----
> > >  arch/x86/kernel/jump_label.c          | 13 -------------
> > >  kernel/jump_label.c                   | 14 +++-----------
> > >  10 files changed, 5 insertions(+), 85 deletions(-)
> >
> > I have one minor comment below, but either way this is a nice cleanup (and I'm
> > always happy to see __weak functions disappear), so FWIW:
>
> (I've got a new found hatred for __weak after having had to fix so many
> objtool issues with it, so yeah, that).
>
> >
> >   Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> With the thing Mark pointed out fixed:
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> (although, I'll probably be the one to eventually apply these I suppose,
> unless they're needed in a different tree?)

Not really - this just came up when Jason was looking into how to
enable jump labels extremely early on every single architecture, but
fortunately, that issue got fixed in a different way.

I'll respin and resend and leave it to you to apply them whenever convenient.
