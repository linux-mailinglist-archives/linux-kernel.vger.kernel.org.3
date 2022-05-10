Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70712521CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbiEJOpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344748AbiEJOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAE524641E;
        Tue, 10 May 2022 07:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1849B6062B;
        Tue, 10 May 2022 14:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0D7C385C2;
        Tue, 10 May 2022 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652191419;
        bh=KjDXrMRIgjl9mqK+1lZepnUpO/sXpVuQ6BE0MJGcLl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ftzgu9vNda3LniGP6pt1aUYcmfQNMsGRCzzkPe7Ju5jVv55Vo8Km6RS6REDd052BK
         ZPSzQRrNz/z5Du+mxpMlcqlPRTPsmXopKmmYWzaDphQboUeez0V7FKSP1JjN23tjlb
         YbJIEKiZUVtLttBvGAarW3b+yiJOB2QP7KW1vJBiLvnWPZAb6OYhQqogyC9ukkZgj4
         JkP8meYhGRCkL0uFRsxf0b5UAMx61qj+hYK3iSmMDh4I6KugoCSWl0zalm+qzFmdLE
         f0pb8YOFwvDDTqVNFf219lp7UUQPvIwvUm5Y3ccEBaBLTXfjz6Lc80JiSmYd/GrMkM
         zVa5iw1mP7J7g==
Date:   Tue, 10 May 2022 15:03:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-trace-devel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Kiss <daniel.kiss@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] arm64: Forget syscall if different from
 execve*()
Message-ID: <20220510140333.GA28104@willie-the-truck>
References: <20220509151958.441240-1-flaniel@linux.microsoft.com>
 <20220509151958.441240-2-flaniel@linux.microsoft.com>
 <20220510105948.GB27557@willie-the-truck>
 <2826417.e9J7NaK4W3@pwmachine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2826417.e9J7NaK4W3@pwmachine>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 03:00:11PM +0100, Francis Laniel wrote:
> Le mardi 10 mai 2022, 11:59:48 BST Will Deacon a écrit :
> > On Mon, May 09, 2022 at 04:19:57PM +0100, Francis Laniel wrote:
> > > diff --git a/arch/arm64/include/asm/processor.h
> > > b/arch/arm64/include/asm/processor.h index 73e38d9a540c..e12ceb363d6a
> > > 100644
> > > --- a/arch/arm64/include/asm/processor.h
> > > +++ b/arch/arm64/include/asm/processor.h
> > > @@ -34,6 +34,8 @@
> > > 
> > >  #include <vdso/processor.h>
> > > 
> > > +#include <asm-generic/unistd.h>
> > > +
> > > 
> > >  #include <asm/alternative.h>
> > >  #include <asm/cpufeature.h>
> > >  #include <asm/hw_breakpoint.h>
> > > 
> > > @@ -250,8 +252,12 @@ void tls_preserve_current_state(void);
> > > 
> > >  static inline void start_thread_common(struct pt_regs *regs, unsigned
> > >  long pc) {
> > > 
> > > +	s32 previous_syscall = regs->syscallno;
> > > 
> > >  	memset(regs, 0, sizeof(*regs));
> > > 
> > > -	forget_syscall(regs);
> > > +	if (previous_syscall == __NR_execve || previous_syscall ==
> > > __NR_execveat)
> > > +		regs->syscallno = previous_syscall;
> > > +	else
> > > +		forget_syscall(regs);
> > 
> > Hmm, this really looks like a bodge and it doesn't handle the compat case
> > either.
> > 
> > How do other architectures handle this?
> 
> My understanding of others architectures is quite limited, but here are my 
> findings and understanding of some of them:
> * arm (32 bits) EABI: start_thread() sets r7 to previous r7 for ELF FDPIC  and 
> to 0 for other binfmts [1].
> * arm (32 bits) OABI: syscall number is set to -1 if 
> ptrace_report_syscall_entry() failed [2].
> * mips: start_thread() does not modify current_thread_info->syscall which is 
> taken directly from v0 [3, 4].
> * riscv: start_thread() does not modify a7 [5].
> * x86_64: start_thread_common() does not touch orig_ax which seems to contain 
> the syscall number [6].

Hmm, so the million dollar question is why on Earth we have that
forget_syscall() call to start with. Amusingly I've, err, forgotten;
forget_forget_syscall() perhaps?

Catalin? It's been there since day one afaict.

Will
