Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E2D4E3FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbiCVNmk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Mar 2022 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbiCVNmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:42:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A404F7DA95
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40910B81CFF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BF8C340EC;
        Tue, 22 Mar 2022 13:41:02 +0000 (UTC)
Date:   Tue, 22 Mar 2022 09:41:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mark.rutland@arm.com, mingo@redhat.com, tglx@linutronix.de,
        catalin.marinas@arm.com, will@kernel.org,
        dave.hansen@linux.intel.com, broonie@kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, qirui.001@bytedance.com
Subject: Re: [PATCH v3 3/3] arm64/ftrace: Make function graph use ftrace
 directly
Message-ID: <20220322094100.73dc3ad0@gandalf.local.home>
In-Reply-To: <c8b7508b-ce2a-c7dc-92c4-ca5f17992844@bytedance.com>
References: <20220224093251.49971-1-zhouchengming@bytedance.com>
        <20220224093251.49971-3-zhouchengming@bytedance.com>
        <c8b7508b-ce2a-c7dc-92c4-ca5f17992844@bytedance.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 20:48:00 +0800
Chengming Zhou <zhouchengming@bytedance.com> wrote:

> Hello,
> 
> ping... have any comments?

Hi Chengming,

BTW, if you don't hear back for a week, it's OK to send a ping. You don't
need to wait a month. Usually, it's just that the maintainers have other
priorities and will try to look at it when they get a chance, but then
forget to do so :-/


> 
> Thanks.
> 
> On 2022/2/24 5:32 下午, Chengming Zhou wrote:
> > As we do in commit 0c0593b45c9b ("x86/ftrace: Make function graph
> > use ftrace directly"), we don't need special hook for graph tracer,
> > but instead we use graph_ops:func function to install return_hooker.
> > 
> > Since commit 3b23e4991fb6 ("arm64: implement ftrace with regs") add
> > implementation for FTRACE_WITH_REGS on arm64, we can easily adopt
> > the same cleanup on arm64. And this cleanup only changes the
> > FTRACE_WITH_REGS implementation, so the mcount-based implementation
> > is unaffected.
> > 
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > ---
> > Changes in v3:
> >  - Add comments in ftrace_graph_func() as suggested by Steve.
> > 
> > Changes in v2:
> >  - Remove FTRACE_WITH_REGS ftrace_graph_caller asm as suggested by Mark.
> > ---
> >  arch/arm64/include/asm/ftrace.h  |  7 +++++++
> >  arch/arm64/kernel/entry-ftrace.S | 17 -----------------
> >  arch/arm64/kernel/ftrace.c       | 17 +++++++++++++++++
> >  3 files changed, 24 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index 1494cfa8639b..dbc45a4157fa 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -80,8 +80,15 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
> >  
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> >  struct dyn_ftrace;
> > +struct ftrace_ops;
> > +struct ftrace_regs;
> > +
> >  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> >  #define ftrace_init_nop ftrace_init_nop
> > +
> > +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> > +		       struct ftrace_ops *op, struct ftrace_regs *fregs);
> > +#define ftrace_graph_func ftrace_graph_func
> >  #endif
> >  
> >  #define ftrace_return_address(n) return_address(n)
> > diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> > index e535480a4069..d42a205ef625 100644
> > --- a/arch/arm64/kernel/entry-ftrace.S
> > +++ b/arch/arm64/kernel/entry-ftrace.S
> > @@ -97,12 +97,6 @@ SYM_CODE_START(ftrace_common)
> >  SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
> >  	bl	ftrace_stub
> >  
> > -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > -SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL) // ftrace_graph_caller();
> > -	nop				// If enabled, this will be replaced
> > -					// "b ftrace_graph_caller"
> > -#endif
> > -
> >  /*
> >   * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
> >   * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
> > @@ -127,17 +121,6 @@ ftrace_common_return:
> >  	ret	x9
> >  SYM_CODE_END(ftrace_common)
> >  
> > -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > -SYM_CODE_START(ftrace_graph_caller)
> > -	ldr	x0, [sp, #S_PC]
> > -	sub	x0, x0, #AARCH64_INSN_SIZE	// ip (callsite's BL insn)
> > -	add	x1, sp, #S_LR			// parent_ip (callsite's LR)
> > -	ldr	x2, [sp, #PT_REGS_SIZE]	   	// parent fp (callsite's FP)
> > -	bl	prepare_ftrace_return
> > -	b	ftrace_common_return
> > -SYM_CODE_END(ftrace_graph_caller)
> > -#endif
> > -
> >  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >  
> >  /*
> > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > index 4506c4a90ac1..35eb7c9b5e53 100644
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -268,6 +268,22 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
> >  }
> >  
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> > +
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS

Is there a case were we have DYNAMIC_FTRACE but not
DYNAMIC_FTRACE_WITH_REGS?

> > +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> > +		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> > +{
> > +	/*
> > +	 * Athough graph_ops doesn't have FTRACE_OPS_FL_SAVE_REGS set in flags,
> > +	 * regs can't be NULL in DYNAMIC_FTRACE_WITH_REGS. By design, it should
> > +	 * be fixed when DYNAMIC_FTRACE_WITH_ARGS is implemented.
> > +	 */
> > +	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
> > +	unsigned long *parent = (unsigned long *)&procedure_link_pointer(regs);
> > +
> > +	prepare_ftrace_return(ip, parent, frame_pointer(regs));
> > +}
> > +#else

You deleted ftrace_graph_caller above from entry-ftrace.S, if we can get
here with some options, wouldn't that break the build?

-- Steve


> >  /*
> >   * Turn on/off the call to ftrace_graph_caller() in ftrace_caller()
> >   * depending on @enable.
> > @@ -297,5 +313,6 @@ int ftrace_disable_ftrace_graph_caller(void)
> >  {
> >  	return ftrace_modify_graph_caller(false);
> >  }
> > +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >  #endif /* CONFIG_DYNAMIC_FTRACE */
> >  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */  

