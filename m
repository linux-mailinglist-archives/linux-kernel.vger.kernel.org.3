Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9934FF70F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiDMMsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiDMMsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:48:51 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A08B31EAF3;
        Wed, 13 Apr 2022 05:46:30 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3F3EF92009C; Wed, 13 Apr 2022 14:46:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2EF4892009B;
        Wed, 13 Apr 2022 13:46:29 +0100 (BST)
Date:   Wed, 13 Apr 2022 13:46:29 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
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
In-Reply-To: <20220413122546.GA11860@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-5-Jason@zx2c4.com> <20220413122546.GA11860@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022, Thomas Bogendoerfer wrote:

> > diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
> > index b05bb70a2e46..abc60a6395e3 100644
> > --- a/arch/mips/include/asm/timex.h
> > +++ b/arch/mips/include/asm/timex.h
> > @@ -94,7 +94,7 @@ static inline unsigned long random_get_entropy(void)
> >  	else if (likely(imp != PRID_IMP_R6000 && imp != PRID_IMP_R6000A))
> >  		return read_c0_random();
> >  	else
> > -		return 0;	/* no usable register */
> > +		return random_get_entropy_fallback();	/* no usable register */
> >  }
> >  #define random_get_entropy random_get_entropy
> >  
> > -- 
> > 2.35.1
> 
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

 Or we could drop the PRID_IMP_R6000/A check and the final `else' clause 
entirely, as we don't even pretend to support the R6k at all anymore, and 
this is the final reference remaining.  For one we no longer handle the 
CPU in `cpu_probe_legacy' so any attempt to boot on such a CPU would 
inevitably fail as no CPU options would be set (we probably should have a 
`panic' or suchlike as the default case for the switch statement there).

 Therefore I'm all for removing this piece instead, complementing commit 
3b2db173f012 ("MIPS: Remove unused R6000 support"), where it should have 
really happened.

  Maciej
