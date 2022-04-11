Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D844FB5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbiDKIUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343669AbiDKIUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:20:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D931A33A10;
        Mon, 11 Apr 2022 01:18:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649665111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xjhhzRNcm78JGgGtLG6mgwaGj8Cww0Tlt26NaB6GyE8=;
        b=bQRUSKc6DEfWq2JW4zBYVX9dk6BAlFAOz8ziZI1nuAr8ThUSn9e4Pp4TH0bz7ykDdAbytZ
        7E1JFmxLLPSA9yL/pLdV+Narb8ojwoUuHfRpcDWF7RSs/XNw8NP/mtP12PhEDKsDgxWdwX
        vj1X7Tk9jubTJlEIAMDexIL70/zM+Ev13+w45xEIm/Pg10UwmbczcL33LQfaYjkFbjCAwR
        nWRv8uLzxf0uwY7wWrnhC9hKJv5hsVxGhFPLc//BILYIvle9sl9xbz+4/B2WaiAREmOlO7
        QMeWCwYxU6fvIGepcveLrvpqjGJJ/UVr5H5Gu5FcUTDSJ2ZLo6XAuABFlQLZ3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649665111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xjhhzRNcm78JGgGtLG6mgwaGj8Cww0Tlt26NaB6GyE8=;
        b=dYt2Xa6X2UETGYKSaI3sFGG38t3wto/bY9ksZnmh+Jh5QgkWcPQfA5MzFrnWyF0a21HHlJ
        MeANaRegf0On2MDw==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
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
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v2 03/11] m68k: use ktime_read_raw_clock() for
 random_get_entropy() instead of zero
In-Reply-To: <20220410214951.55294-4-Jason@zx2c4.com>
References: <20220410214951.55294-1-Jason@zx2c4.com>
 <20220410214951.55294-4-Jason@zx2c4.com>
Date:   Mon, 11 Apr 2022 10:18:30 +0200
Message-ID: <87sfqkf2y1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10 2022 at 23:49, Jason A. Donenfeld wrote:

> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is really not the best we can do.
> Instead, at least calling ktime_read_raw_clock() would be preferable,
> because that always needs to return _something_, even falling back to
> jiffies eventually. It's not as though ktime_read_raw_clock() is super
> high precision or guaranteed to be entropic, but basically anything
> that's not zero all the time is better than returning zero all the time.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/m68k/include/asm/timex.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/m68k/include/asm/timex.h b/arch/m68k/include/asm/timex.h
> index 6a21d9358280..5351b10e1b18 100644
> --- a/arch/m68k/include/asm/timex.h
> +++ b/arch/m68k/include/asm/timex.h
> @@ -35,7 +35,7 @@ static inline unsigned long random_get_entropy(void)
>  {
>  	if (mach_random_get_entropy)
>  		return mach_random_get_entropy();
> -	return 0;
> +	return ktime_read_raw_clock();

I'd rather do something like this in a common header:

unsigned long random_get_entropy_fallback(void);

and use random_get_entropy_fallback() in the architecture specific
files.

That way you can encapsulate the fallback implementation in the random
code and if it turns out that ktime_read_raw_clock() is a stupid idea or
someone has a better idea then you have to change exactly one place and
not patch the whole tree again.

Thanks,

        tglx
