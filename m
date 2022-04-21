Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFBF50AA77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441804AbiDUVJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbiDUVJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:09:02 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E17447AE4;
        Thu, 21 Apr 2022 14:06:11 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nhe01-0007Hb-00; Thu, 21 Apr 2022 23:06:01 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 79792C01A0; Thu, 21 Apr 2022 23:05:25 +0200 (CEST)
Date:   Thu, 21 Apr 2022 23:05:25 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>,
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
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v5 04/11] mips: use fallback for random_get_entropy()
 instead of just c0 random
Message-ID: <20220421210525.GA16228@alpha.franken.de>
References: <20220419111650.1582274-1-Jason@zx2c4.com>
 <20220419111650.1582274-5-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419111650.1582274-5-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 01:16:43PM +0200, Jason A. Donenfeld wrote:
> For situations in which we don't have a c0 counter register available,
> we've been falling back to reading the c0 "random" register, which is
> usually bounded by the amount of TLB entries and changes every other
> cycle or so. This means it wraps extremely often. We can do better by
> combining this fast-changing counter with a potentially slower-changing
> counter from random_get_entropy_fallback() in the more significant bits.
> This commit combines the two, taking into account that the changing bits
> are in a different bit position depending on the CPU model. In addition,
> we previously were falling back to 0 for ancient CPUs that Linux does
> not support anyway; remove that dead path entirely.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> ThomasB - I dropped your Ack from v4, because this is pretty different
> from v4 now.
> 
> Maciej - you mentioned you had a test rig. Think you could provide a
> "Tested-by" if this approach works?
> 
>  arch/mips/include/asm/timex.h | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
> index b05bb70a2e46..e3f5460a923b 100644
> --- a/arch/mips/include/asm/timex.h
> +++ b/arch/mips/include/asm/timex.h
> @@ -80,21 +80,19 @@ static inline cycles_t get_cycles(void)
>  /*
>   * Like get_cycles - but where c0_count is not available we desperately
>   * use c0_random in an attempt to get at least a little bit of entropy.
> - *
> - * R6000 and R6000A neither have a count register nor a random register.
> - * That leaves no entropy source in the CPU itself.
>   */
>  static inline unsigned long random_get_entropy(void)
>  {
> -	unsigned int prid = read_c0_prid();
> -	unsigned int imp = prid & PRID_IMP_MASK;
> +	unsigned int c0_random;
>  
> -	if (can_use_mips_counter(prid))
> +	if (can_use_mips_counter(read_c0_prid()))
>  		return read_c0_count();
> -	else if (likely(imp != PRID_IMP_R6000 && imp != PRID_IMP_R6000A))
> -		return read_c0_random();
> +
> +	if (cpu_has_3kex)
> +		c0_random = (read_c0_random() >> 8) & 0x3f;
>  	else
> -		return 0;	/* no usable register */
> +		c0_random = read_c0_random() & 0x3f;
> +	return (random_get_entropy_fallback() << 6) | (0x3f - c0_random);
>  }
>  #define random_get_entropy random_get_entropy
>  
> -- 
> 2.35.1

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
