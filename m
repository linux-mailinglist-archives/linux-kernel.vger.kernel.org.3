Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944C6506D26
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351930AbiDSNMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbiDSNMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:12:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB58335DC3;
        Tue, 19 Apr 2022 06:09:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92A48106F;
        Tue, 19 Apr 2022 06:09:22 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.75.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A73B3F766;
        Tue, 19 Apr 2022 06:09:19 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:09:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, keescook@chromium.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, hpa@zytor.com,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/8] stacktrace: Change callback prototype to pass
 more information
Message-ID: <Yl60euwfis+u92cA@FVFF77S0Q05N>
References: <20220418132217.1573072-1-zhe.he@windriver.com>
 <20220418132217.1573072-2-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418132217.1573072-2-zhe.he@windriver.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 09:22:10PM +0800, He Zhe wrote:
> Currently stack_trace_consume_fn can only have pc of each frame of the
> stack. Copying-beyond-the-frame-detection also needs fp of current and
> previous frame. Other detection algorithm in the future may need more
> information of the frame.
> 
> We define a frame_info to include them all.
> 
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  include/linux/stacktrace.h |  9 ++++++++-
>  kernel/stacktrace.c        | 10 +++++-----
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
> index 97455880ac41..5a61bfafe6f0 100644
> --- a/include/linux/stacktrace.h
> +++ b/include/linux/stacktrace.h
> @@ -10,15 +10,22 @@ struct pt_regs;
>  
>  #ifdef CONFIG_ARCH_STACKWALK
>  
> +struct frame_info {
> +	unsigned long pc;
> +	unsigned long fp;
> +	unsigned long prev_fp;
> +};

I don't think this should be exposed through a generic interface; the `fp` and
`prev_fp` values are only meaningful with arch-specific knowledge, and they're
*very* easy to misuse (e.g. when transitioning from one stack to another).
There's also a bunch of other information one may or may not want, depending on
what you're trying to achieve.

I am happy to have an arch-specific internal unwinder where we can access this
information, and *maybe* it makes sense to have a generic API that passes some
opaque token, but I don't think we should make the structure generic.

Thanks,
Mark.

> +
>  /**
>   * stack_trace_consume_fn - Callback for arch_stack_walk()
>   * @cookie:	Caller supplied pointer handed back by arch_stack_walk()
>   * @addr:	The stack entry address to consume
> + * @fi:	The frame information to consume
>   *
>   * Return:	True, if the entry was consumed or skipped
>   *		False, if there is no space left to store
>   */
> -typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr);
> +typedef bool (*stack_trace_consume_fn)(void *cookie, struct frame_info *fi);
>  /**
>   * arch_stack_walk - Architecture specific function to walk the stack
>   * @consume_entry:	Callback which is invoked by the architecture code for
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> index 9ed5ce989415..2d0a2812e92b 100644
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -79,7 +79,7 @@ struct stacktrace_cookie {
>  	unsigned int	len;
>  };
>  
> -static bool stack_trace_consume_entry(void *cookie, unsigned long addr)
> +static bool stack_trace_consume_entry(void *cookie, struct frame_info *fi)
>  {
>  	struct stacktrace_cookie *c = cookie;
>  
> @@ -90,15 +90,15 @@ static bool stack_trace_consume_entry(void *cookie, unsigned long addr)
>  		c->skip--;
>  		return true;
>  	}
> -	c->store[c->len++] = addr;
> +	c->store[c->len++] = fi->pc;
>  	return c->len < c->size;
>  }
>  
> -static bool stack_trace_consume_entry_nosched(void *cookie, unsigned long addr)
> +static bool stack_trace_consume_entry_nosched(void *cookie, struct frame_info *fi)
>  {
> -	if (in_sched_functions(addr))
> +	if (in_sched_functions(fi->pc))
>  		return true;
> -	return stack_trace_consume_entry(cookie, addr);
> +	return stack_trace_consume_entry(cookie, fi);
>  }
>  
>  /**
> -- 
> 2.25.1
> 
