Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D9657A834
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiGSUa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiGSUa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:30:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3623AE53
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EhAQvwaevKh3pTHDvToDsAZlIpgY9BkuDp0kjzFLTYM=; b=g3EKJytb1NSpCKBNIpVGuaX2Sd
        IC/+RSRH7TX9wa8Fz5C8z2aQe2GA/k/q/UFX6LJOIshTYqjO1MIqqibMOFlK0hEip82vUitK8QfQ4
        mygVfYajR7yP++uxp4YGsp7gyb6m3Ngt5+M8uXBhCFzKtAMHvTpNscaEYx0W0x4LF1G3BoSqhNtrX
        3A5OLNOuQJqkbFPuI1Ncl0To9Z/pFSDTOIq4Kb5hCidm3J1UBxkcfs/JAkLeGV1l4JkYyidM0AkyV
        bBeMWBta8RFiESK1mKNrtuw8eJRlWtNhKFRro8RrvVC/F0ojevMBBuPlhXcomkzeFBBtYQUuWd03D
        Qqqk2JLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDtrH-005ARS-AS; Tue, 19 Jul 2022 20:30:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2A369802A4; Tue, 19 Jul 2022 22:30:18 +0200 (CEST)
Date:   Tue, 19 Jul 2022 22:30:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] ftrace/x86: Remove jumps to ftrace_epilogue and
 simplify trampolines
Message-ID: <YtcUWvm04I0ME2Rm@worktop.programming.kicks-ass.net>
References: <20220719152353.4c25e2eb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719152353.4c25e2eb@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:24:05PM -0400, Steven Rostedt wrote:
> @@ -356,12 +353,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  	if (WARN_ON(ret < 0))
>  		goto fail;
>  
> -	ip = trampoline + size;
> -	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
> -		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, &__x86_return_thunk, JMP32_INSN_SIZE);
> -	else
> -		memcpy(ip, retq, sizeof(retq));
> -
>  	/* No need to test direct calls on created trampolines */
>  	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
>  		/* NOP the jnz 1f; but make sure it's a 2 byte jnz */

> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index dfeb227de561..6294c14c51c9 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -164,7 +164,7 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
>  	movq %rax, MCOUNT_REG_SIZE(%rsp)
>  
>  	restore_mcount_regs
> -
> +	RET
>  	/*
>  	 * The code up to this label is copied into trampolines so
>  	 * think twice before adding any new code or changing the

I like the idea, but I think this is broken. When those RETs become 'JMP
__x86_return_thunk' you can't simply copy the instruction. You also have
to fix up the relative addressing.
