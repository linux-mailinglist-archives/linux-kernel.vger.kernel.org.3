Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876995001F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbiDMWij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiDMWih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:38:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7E84D61A;
        Wed, 13 Apr 2022 15:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64C5961FA2;
        Wed, 13 Apr 2022 22:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470EDC385A3;
        Wed, 13 Apr 2022 22:36:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G9/lJZvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649889364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/qY7Q5+txJsN2VM3hmo/BuFNHf1fzlowER9ysRVbtU=;
        b=G9/lJZvutks3OBqL5Nu4B1yW4jBFb7W4ukR3afqp2x1riI/HnkanKh59pDPmGb6Y90x99g
        9x0vTbtaEb+KLGvTJAFyA66m7Xv29xQZ9oYexjJfdBOtaFoBppboktTAxX/1YKeV1Yw39n
        a37nwgA1eGMO6ujUD1Zudlu5gCeStNI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fe08f002 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Apr 2022 22:36:03 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2ebf4b91212so37963667b3.8;
        Wed, 13 Apr 2022 15:36:02 -0700 (PDT)
X-Gm-Message-State: AOAM531082+ZhP0yMYZsQtDpQlAfCkMl9qsIMk8+jr7dmLsTWeC1qJ6B
        ANbQAjMCVqv/6F8uDKqzlhlEKHzGz8Q/xF41O6Q=
X-Google-Smtp-Source: ABdhPJzIgqKFKpMhZPLEtAEhlDJTJz5RK85xvL5Zr9EJ3NPhLwoCvgqk5B4Jz+dLnTIilLBy7lbr9KCRJA+XIbc15b8=
X-Received: by 2002:a81:1a49:0:b0:2eb:f4cd:b3f1 with SMTP id
 a70-20020a811a49000000b002ebf4cdb3f1mr976064ywa.231.1649889360067; Wed, 13
 Apr 2022 15:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-5-Jason@zx2c4.com>
 <20220413122546.GA11860@alpha.franken.de> <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 14 Apr 2022 00:35:49 +0200
X-Gmail-Original-Message-ID: <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
Message-ID: <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] mips: use fallback for random_get_entropy()
 instead of zero
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
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

Hi Maciej,

On Wed, Apr 13, 2022 at 2:46 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Wed, 13 Apr 2022, Thomas Bogendoerfer wrote:
>
> > > diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
> > > index b05bb70a2e46..abc60a6395e3 100644
> > > --- a/arch/mips/include/asm/timex.h
> > > +++ b/arch/mips/include/asm/timex.h
> > > @@ -94,7 +94,7 @@ static inline unsigned long random_get_entropy(void)
> > >     else if (likely(imp != PRID_IMP_R6000 && imp != PRID_IMP_R6000A))
> > >             return read_c0_random();
> > >     else
> > > -           return 0;       /* no usable register */
> > > +           return random_get_entropy_fallback();   /* no usable register */
> > >  }
> > >  #define random_get_entropy random_get_entropy
> > >
> > > --
> > > 2.35.1
> >
> > Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>
>  Or we could drop the PRID_IMP_R6000/A check and the final `else' clause
> entirely, as we don't even pretend to support the R6k at all anymore, and
> this is the final reference remaining.  For one we no longer handle the
> CPU in `cpu_probe_legacy' so any attempt to boot on such a CPU would
> inevitably fail as no CPU options would be set (we probably should have a
> `panic' or suchlike as the default case for the switch statement there).
>
>  Therefore I'm all for removing this piece instead, complementing commit
> 3b2db173f012 ("MIPS: Remove unused R6000 support"), where it should have
> really happened.

That's fine with me, if that's what Thomas wants to do, and I can
submit a v5 with that in it. Indeed, from our previous conversations,
I'm aware that the `else` there is probably never hit.

However, one thing that I've been thinking about is that the c0 random
register is actually kind of garbage. In my fuzzy decade-old memory of
MIPS, I believe the c0 random register starts at the maximum number of
TLB entries (16?), and then counts down cyclically, decrementing once
per CPU cycle. Is that right?

If it is, there are some real pros and cons here to consider:
- Pro: decrementing each CPU cycle means pretty good granularity
- Con: wrapping at, like, 16 or something really is very limited, to
the point of being almost bad

Meanwhile, on systems without the c0 cycles counter, what is the
actual resolution of random_get_entropy_fallback()? Is this just
falling back to jiffies?

IF (a) the fallback is jiffies AND (b) c0 wraps at 16, then actually,
what would be really nice would be something like:

    return (jiffies << 4) | read_c0_random();

It seems like that would give us something somewhat more ideal than
the status quo. Still crap, of course, but undoubtedly better.

Unfortunately, I don't know enough about whether assumptions (a) and
(b) hold for all hardware that doesn't have the c0 cycle counter. Can
you or Thomas confirm/deny this? And if it is more nuanced than my
optimistic assumption above, can we think of some scheme together that
nicely combines jiffies or the fallback function with the c0 random
register that would be sensible?

Jason
