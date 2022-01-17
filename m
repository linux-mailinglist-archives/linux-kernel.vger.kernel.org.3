Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018B04909DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiAQN6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:58:44 -0500
Received: from foss.arm.com ([217.140.110.172]:58574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233038AbiAQN6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:58:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D0091FB;
        Mon, 17 Jan 2022 05:58:43 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.38.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C12D83F766;
        Mon, 17 Jan 2022 05:58:41 -0800 (PST)
Date:   Mon, 17 Jan 2022 13:58:39 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: arch/powerpc/kernel/stacktrace.c:171:9: error: implicit
 declaration of function 'nmi_cpu_backtrace'
Message-ID: <20220117135839.GF87485@C02TD0UTHF1T.local>
References: <202201140631.ZuSwa9QF-lkp@intel.com>
 <YeE2VWwHO50gFw9M@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeE2VWwHO50gFw9M@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 09:37:41AM +0100, Peter Zijlstra wrote:
> On Fri, Jan 14, 2022 at 06:13:37AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   fb3b0673b7d5b477ed104949450cd511337ba3c6
> > commit: 1614b2b11fab29dd4ff31ebba9d266961f5af69e arch: Make ARCH_STACKWALK independent of STACKTRACE
> > date:   5 weeks ago
> > config: powerpc64-randconfig-r025-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140631.ZuSwa9QF-lkp@intel.com/config)
> > compiler: powerpc64-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1614b2b11fab29dd4ff31ebba9d266961f5af69e
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 1614b2b11fab29dd4ff31ebba9d266961f5af69e
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    arch/powerpc/kernel/stacktrace.c: In function 'handle_backtrace_ipi':
> > >> arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration of function 'nmi_cpu_backtrace' [-Werror=implicit-function-declaration]
> >      171 |         nmi_cpu_backtrace(regs);
> >          |         ^~~~~~~~~~~~~~~~~
> >    arch/powerpc/kernel/stacktrace.c: At top level:
> >    arch/powerpc/kernel/stacktrace.c:224:6: warning: no previous prototype for 'arch_trigger_cpumask_backtrace' [-Wmissing-prototypes]
> >      224 | void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> >          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    arch/powerpc/kernel/stacktrace.c: In function 'arch_trigger_cpumask_backtrace':
> > >> arch/powerpc/kernel/stacktrace.c:226:9: error: implicit declaration of function 'nmi_trigger_cpumask_backtrace'; did you mean 'arch_trigger_cpumask_backtrace'? [-Werror=implicit-function-declaration]
> >      226 |         nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace_ipi);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >          |         arch_trigger_cpumask_backtrace
> >    cc1: some warnings being treated as errors
> 
> I suppose this ought to cure things...
> 
> diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
> index a2443d61728e..bde1aaedeb72 100644
> --- a/arch/powerpc/kernel/stacktrace.c
> +++ b/arch/powerpc/kernel/stacktrace.c
> @@ -165,7 +165,7 @@ int __no_sanitize_address arch_stack_walk_reliable(stack_trace_consume_fn consum
>  	return 0;
>  }
>  
> -#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI)
> +#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI) && defined(CONFIG_STACKTRACE)
>  static void handle_backtrace_ipi(struct pt_regs *regs)
>  {
>  	nmi_cpu_backtrace(regs);

Hmm...

In include/linux/nmi.h we have:

| #ifdef arch_trigger_cpumask_backtrace
| ...
| bool nmi_cpu_backtrace(struct pt_regs *regs);
| #else
| ...
| #endif 

... and in lib/nmi_backtrace.c we have:

| #ifdef arch_trigger_cpumask_backtrace
| ...
| bool nmi_cpu_backtrace(struct pt_regs *regs)
| {
|    ...
| }
| ...
| #endif 

In arch/powerpc/include/asm/nmi.h we have:

| #if defined(CONFIG_NMI_IPI) && defined(CONFIG_STACKTRACE)
| extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
|                                            bool exclude_self);
| #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
| #endif

Either it's sufficient to check only CONFIG_NMI_IPI &&
CONFIG_STACKTRACE, or there's a latent bug when CONFIG_NMI_IPI &&
CONFIG_STACKTRACE && !CONFIG_PPC_BOOK3S_64.

For consistency with teh other ifedeffery I reckon this should be:

| #if defined(CONFIG_NMI_IPI) && defined(CONFIG_STACKTRACE)

... and we need to adjust the comment for hte #endif, too.

Otherwise, this makes sense to me -- did you plan to send this as a
patch, or did you want someone else to spin one?

Thanks,
Mark.
