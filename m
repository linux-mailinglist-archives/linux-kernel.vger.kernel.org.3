Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556FB559A12
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiFXNEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXNEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:04:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED1C43EDF;
        Fri, 24 Jun 2022 06:04:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70A63B827B2;
        Fri, 24 Jun 2022 13:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71C3C341C0;
        Fri, 24 Jun 2022 13:04:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PKMvwX+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656075872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1AD2JTwzEZZmB9x9wgRCyqulDsjFck59n65sLgL8zP4=;
        b=PKMvwX+XxGk0rzspnBQ4HekkUXdtfxKMr8HBrzRBdJoB4wbKFsurLTzMaDyS2JIfy1bnEn
        71TB3pQWjahxttdtujDQU+LefYtu3pddo7Ddu/zXsMCNn3g7CyT0lgPCnAbRHf6ELTO4Dq
        KlK/4s9pWSIikfc0IQ+/9ecbb/KjWhg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 999bdd6e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 24 Jun 2022 13:04:31 +0000 (UTC)
Received: by mail-io1-f43.google.com with SMTP id r133so2620352iod.3;
        Fri, 24 Jun 2022 06:04:31 -0700 (PDT)
X-Gm-Message-State: AJIora/UOLJ+od33vcB+85DiBCDkmTsdLw5l5/JDbl1IvcjRzMJsyCqP
        lGU9+JtX5h+eUp3+64UO6dtYCkn+uYpV8DEOEtw=
X-Google-Smtp-Source: AGRyM1uo9ANk98S66aQl+us7wOOHTaTQlSDx1P0iA3tZNcY+HUBiJtQI8am7cm6IyUGLpkmKMrRcvG3mXNtBLVPnM8A=
X-Received: by 2002:a02:9709:0:b0:339:ef87:c30b with SMTP id
 x9-20020a029709000000b00339ef87c30bmr3981461jai.214.1656075870353; Fri, 24
 Jun 2022 06:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220423212623.1957011-1-Jason@zx2c4.com> <20220423212623.1957011-10-Jason@zx2c4.com>
 <alpine.DEB.2.21.2204250113440.9383@angie.orcam.me.uk> <YmicjVbkcppfzE1E@zx2c4.com>
In-Reply-To: <YmicjVbkcppfzE1E@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 24 Jun 2022 15:04:19 +0200
X-Gmail-Original-Message-ID: <CAHmME9r-wTkNGVj0sBOM5LVY=jdAw99gne-1g-mwjBnk3q7VqQ@mail.gmail.com>
Message-ID: <CAHmME9r-wTkNGVj0sBOM5LVY=jdAw99gne-1g-mwjBnk3q7VqQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/17] mips: use fallback for random_get_entropy()
 instead of just c0 random
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Maciej,

On Wed, Apr 27, 2022 at 3:29 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey Maciej,
>
> On Tue, Apr 26, 2022 at 09:28:39PM +0100, Maciej W. Rozycki wrote:
> > On Sat, 23 Apr 2022, Jason A. Donenfeld wrote:
> >
> > > diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
> > > index b05bb70a2e46..8cfa485d19e6 100644
> > > --- a/arch/mips/include/asm/timex.h
> > > +++ b/arch/mips/include/asm/timex.h
> > [...]
> > > +   if (cpu_has_3kex)
> > > +           c0_random = (read_c0_random() >> 8) & 0x3f;
> >
> >  Hmm, I wonder whether we do need to mask the contents of the register out
> > here given that known implementations return zeros in reserved bits.  Even
> > though R3000 documentation I have access to makes no guarantee as to the
> > values of the reserved bits here I think we can safely proceed according
> > to what systems we do actually support do (even though it only saves one
> > instruction).
> >
> > >     else
> > > -           return 0;       /* no usable register */
> > > +           c0_random = read_c0_random() & 0x3f;
> >
> >  Here the architecture guarantees unused bits to be zero, but the number
> > of them varies between implementations.  However we'll only ever use this
> > leg for the R4000/R4400 processors, which have 48 TLB entries, and for the
> > Ingenic XBurst cores, which I have now verified in documentation (which
> > user-reported dumps from /proc/cpuinfo are consistent with) that have 32
> > TLB entries.  So I think this mask operation can go as well.
> >
> >  I guess these updates can be made with a follow-up change though.
>
> There is lots of optimization potential on a few fronts we've identified
> in this thread. Let's save these for a follow-up. I'd rather this
> initial one be at least somewhat simple, so that as it gets optimized,
> it'll be easy to handle regressions. Also, it probably makes sense for
> you to send the patches for these, since you have both the hardware
> chops and the hardware itself to assess these ideas. I am interested in
> the topic though, so please do CC me.

Everything has been upstream for a little while now, which means
development of this can move back to the proper MIPS tree like normal.
Did you want to submit some optimizations? Would be happy to look at
whatever you have in mind.

Jason
