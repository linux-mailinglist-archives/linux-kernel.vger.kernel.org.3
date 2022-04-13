Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266DA4FF6D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiDMM3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbiDMM3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:29:43 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6911F5DA67;
        Wed, 13 Apr 2022 05:27:20 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nec5a-0004a6-00; Wed, 13 Apr 2022 14:27:14 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 1A3DEC0183; Wed, 13 Apr 2022 14:25:46 +0200 (CEST)
Date:   Wed, 13 Apr 2022 14:25:46 +0200
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
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v4 04/11] mips: use fallback for random_get_entropy()
 instead of zero
Message-ID: <20220413122546.GA11860@alpha.franken.de>
References: <20220413115411.21489-1-Jason@zx2c4.com>
 <20220413115411.21489-5-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413115411.21489-5-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 01:54:04PM +0200, Jason A. Donenfeld wrote:
> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is really not the best we can do.
> Instead, at least calling random_get_entropy_fallback() would be
> preferable, because that always needs to return _something_, even
> falling back to jiffies eventually. It's not as though
> random_get_entropy_fallback() is super high precision or guaranteed to
> be entropic, but basically anything that's not zero all the time is
> better than returning zero all the time.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/mips/include/asm/timex.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
> index b05bb70a2e46..abc60a6395e3 100644
> --- a/arch/mips/include/asm/timex.h
> +++ b/arch/mips/include/asm/timex.h
> @@ -94,7 +94,7 @@ static inline unsigned long random_get_entropy(void)
>  	else if (likely(imp != PRID_IMP_R6000 && imp != PRID_IMP_R6000A))
>  		return read_c0_random();
>  	else
> -		return 0;	/* no usable register */
> +		return random_get_entropy_fallback();	/* no usable register */
>  }
>  #define random_get_entropy random_get_entropy
>  
> -- 
> 2.35.1

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
