Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CA74FB044
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbiDJU7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242351AbiDJU7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:59:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BFF11C2D;
        Sun, 10 Apr 2022 13:57:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649624223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hE+Xcw0JizEU8Wnq0ZP70KLvw79L4CjFSDQ+JeFdg1E=;
        b=wcxdyIRUujqol7xM6/jNUaTiJK9LjQ2TxNswzkFqW9IdoCXdLl06LKnKcZu+/PhgcujoFD
        4BL6UvqV2KyZxKcXAHyaYhKgWh+hW7kmtVsrR50bN2kEyItTRS4qenN4xdW+pqDVD/EBQJ
        FRBUDZAXAnKdCAGLESQsbxyitf9btYLvPr88J6g6SWQULeVv1+BpRryz8V4vlo0Sxn5A1B
        B7jn62NOZrsua6pLpW1KUXCpCdbVHaodhuhDNbeQMQoqpedjr6x5wCT5mekwEWTjKpLkBQ
        ZhVOGqfjVtVh2uqjxiB4TKZirCwCtL5e55pMSWAO2Ry+8zKLnyd7j8EtVVFiMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649624223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hE+Xcw0JizEU8Wnq0ZP70KLvw79L4CjFSDQ+JeFdg1E=;
        b=WYkLY0CPXnB/0QIxOUzf7pdAwpOuVx9Tljat/8ZOy+GrRKgqIku37SjusWmBW3We4uxu9x
        QGtzsFUk86/12iAg==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
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
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH RFC v1 00/10] archs/random: fallback to using
 sched_clock() if no cycle counter
In-Reply-To: <YlLo8JVOS6FDmWUM@zx2c4.com>
References: <20220408182145.142506-1-Jason@zx2c4.com> <87wnfxhm3n.ffs@tglx>
 <YlLo8JVOS6FDmWUM@zx2c4.com>
Date:   Sun, 10 Apr 2022 22:57:02 +0200
Message-ID: <877d7whd29.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason,

On Sun, Apr 10 2022 at 16:25, Jason A. Donenfeld wrote:
> On Sun, Apr 10, 2022 at 01:29:32AM +0200, Thomas Gleixner wrote:
>> But the below uncompiled hack gives you access to the 'best' clocksource
>> of a machine, i.e. the one which the platform decided to be the one
>> which is giving the best resolution. The minimal bitwidth of that is
>> AFAICT 20 bits. In the jiffies case this will at least advance every
>> tick.
>
> Oh, huh, that's pretty cool. I can try to make a commit out of that. Are
> you suggesting I use this as the fallback for all platforms that
> currently return zero, or just for m68k per Arnd's suggestion, and then
> use sched_clock() for the others? It sounds to me like you're saying
> this would be best for all of them. If so, that'd be quite nice.

It's the best in terms of timekeeping. Not the fastest :)

>> The price, e.g. on x86 would be that RDTSC would be invoked via an
>> indirect function call. Not the end of the world...
>
> Well on x86, random_get_entropy() is overridden in the arch/ code to
> call get_cycles(). So this would really just be for 486 and for other
> architectures with no cycle counter that are currently returning zero.
> However, this brings up a good point: if your proposed
> ktime_read_raw_clock() function really is so nice, should it be used
> everywhere unconditionally with no arch-specific overrides? On x86, is
> it really guaranteed to be RDTSC, and not, say, some off-core HPET
> situation? And is this acceptable to call from the hard irq handler?

No, that's the sad part. On system where TSC is unstable (for whatever
reason) this might fallback to some off-core clock (HPET, PMTIMER).
The good news is that this is mostly affecting older systems. After 20+
years of complaining the hardware people seem to have figured out that a
fast accessible and realiable clocksource is something useful. :)

> Not yet having too much knowledge, I'm tentatively leaning toward the
> safe side, of just using ktime_read_raw_clock() in the current places
> that return zero all the time -- that is, for the purpose this patchset
> has.

That's probably a good approach and it's init/runtime discoverable.

Thanks,

        tglx
