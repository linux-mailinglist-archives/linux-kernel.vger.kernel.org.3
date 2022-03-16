Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F40F4DB93B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347769AbiCPURC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiCPURA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:17:00 -0400
Received: from audible.transient.net (audible.transient.net [24.143.126.66])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 76E366D87F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:15:45 -0700 (PDT)
Received: (qmail 9556 invoked from network); 16 Mar 2022 20:15:44 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 16 Mar 2022 20:15:44 -0000
Received: (nullmailer pid 2639 invoked by uid 1000);
        Wed, 16 Mar 2022 20:15:43 -0000
Date:   Wed, 16 Mar 2022 20:15:43 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: system locks up with CONFIG_SLS=Y; 5.17.0-rc
Message-ID: <YjJFb02Fc0jeoIW4@audible.transient.net>
Mail-Followup-To: Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <YjGzJwjrvxg5YZ0Z@audible.transient.net>
 <YjHYh3XRbHwrlLbR@zn.tnic>
 <YjIwRR5UsTd3W4Bj@audible.transient.net>
 <YjI69aUseN/IuzTj@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjI69aUseN/IuzTj@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov wrote:
> On Wed, Mar 16, 2022 at 06:45:25PM +0000, Jamie Heilman wrote:
> > Yep that worked, here's output, you can see the network get set up and
> > then boom:
> 
> Thx, that was very useful. Does this below fix it, per chance:

It does indeed!

> ---
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index f667bd8df533..e88ce4171c4a 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -430,8 +430,11 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
>  	FOP_END
>  
>  /* Special case for SETcc - 1 instruction per cc */
> +
> +#define SETCC_ALIGN 8
> +
>  #define FOP_SETCC(op) \
> -	".align 4 \n\t" \
> +	".align " __stringify(SETCC_ALIGN) " \n\t" \
>  	".type " #op ", @function \n\t" \
>  	#op ": \n\t" \
>  	ASM_ENDBR \
> @@ -1049,7 +1052,7 @@ static int em_bsr_c(struct x86_emulate_ctxt *ctxt)
>  static __always_inline u8 test_cc(unsigned int condition, unsigned long flags)
>  {
>  	u8 rc;
> -	void (*fop)(void) = (void *)em_setcc + 4 * (condition & 0xf);
> +	void (*fop)(void) = (void *)em_setcc + SETCC_ALIGN * (condition & 0xf);
>  
>  	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
>  	asm("push %[flags]; popf; " CALL_NOSPEC
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
