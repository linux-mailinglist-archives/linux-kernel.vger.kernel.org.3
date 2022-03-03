Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA4E4CB494
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiCCBzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiCCBzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:55:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79072F9F98
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:54:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EBDBB82132
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B4DC004E1;
        Thu,  3 Mar 2022 01:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646272485;
        bh=2zpcMz+EQ09fMOlU5HGSenxjVwDgGz5varO+fnzOgWs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IoTgSdfmx/hEScRr+JrOxKcbAsamzIdGFTWyffprUZKW4mLUq1oORkA7bQpq752LC
         J/Q7lScTVq5OcOavAKo40m3BMqh0KZCewHsqIb9rg1XufnvnKQA92zkWMt2V5LiCGp
         cjD9zW9s6W+XK6aMVR7uHWzDnk0Pv0rTlsCWLTRc8DcIOPbBd6z/mrgcCS2CXsUjgA
         GFA5RSxYYCeylNx3vCaKItwENaDTLOdycqLHxPvXKYEfV2nKBbSiZkk0KQ5lTVWIH9
         /jug/09LH2t/MW9f95V+LEIC0Y0S+/+kIw59h+IjL50iDcTUq7WvdaJ6rVKW6qE9Au
         C4/G3CCOagK3g==
Date:   Thu, 3 Mar 2022 10:54:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ndesaulniers@google.com, rostedt@goodmis.org,
        samitolvanen@google.com, x86@kernel.org
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-Id: <20220303105440.bd8bb739257a05846b5f2185@kernel.org>
In-Reply-To: <1646236764.vx04n8yp12.naveen@linux.ibm.com>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.892372059@infradead.org>
        <20220228150705.aab2d654b973109bab070ffe@kernel.org>
        <20220228232513.GH11184@worktop.programming.kicks-ass.net>
        <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
        <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
        <1646154463.4r1sh4kjf0.naveen@linux.ibm.com>
        <20220301191245.GI11184@worktop.programming.kicks-ass.net>
        <20220301200547.GK11184@worktop.programming.kicks-ass.net>
        <1646236764.vx04n8yp12.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2022 21:47:03 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Peter Zijlstra wrote:
> > --- a/arch/powerpc/kernel/kprobes.c
> > +++ b/arch/powerpc/kernel/kprobes.c
> > @@ -105,6 +105,27 @@ kprobe_opcode_t *kprobe_lookup_name(cons
> >  	return addr;
> >  }
> > 
> > +static bool arch_kprobe_on_func_entry(unsigned long offset)
> > +{
> > +#ifdef PPC64_ELF_ABI_v2
> > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > +	return offset <= 16;
> > +#else
> > +	return offset <= 8;
> > +#endif
> > +#else
> > +	return !offset;
> > +#endif
> > +}
> > +
> > +/* XXX try and fold the magic of kprobe_lookup_name() in this */
> > +kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
> > +					 bool *on_func_entry)
> > +{
> > +	*on_func_entry = arch_kprobe_on_func_entry(offset);
> > +	return (kprobe_opcode_t *)(addr + offset);
> > +}
> > +
> 
> With respect to kprobe_lookup_name(), one of the primary motivations there was 
> the issue with function descriptors for the previous elf v1 ABI (it likely also 
> affects ia64/parisc). I'm thinking it'll be simpler if we have a way to obtain 
> function entry point. Something like this:
> 
> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index 4176c7eca7b5aa..8c57cc5b77f9ae 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -73,6 +73,12 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
>  /* Lookup the address for a symbol. Returns 0 if not found. */
>  unsigned long kallsyms_lookup_name(const char *name);
>  
> +/* Return function entry point by additionally dereferencing function descriptor */
> +static inline unsigned long kallsyms_lookup_function(const char *name)
> +{
> +	return (unsigned long)dereference_symbol_descriptor((void *)kallsyms_lookup_name(name));
> +}
> +
>  extern int kallsyms_lookup_size_offset(unsigned long addr,
>  				  unsigned long *symbolsize,
>  				  unsigned long *offset);
> @@ -103,6 +109,11 @@ static inline unsigned long kallsyms_lookup_name(const char *name)
>  	return 0;
>  }
>  
> +static inline unsigned long kallsyms_lookup_function(const char *name)
> +{
> +	return 0;
> +}
> +
>  static inline int kallsyms_lookup_size_offset(unsigned long addr,
>  					      unsigned long *symbolsize,
>  					      unsigned long *offset)
> 
> 
> With that, we can fold some of the code from kprobe_lookup_name() into 
> arch_adjust_kprobe_addr() and remove kprobe_lookup_name(). This should also 
> address Masami's concerns with powerpc promoting all probes at function entry 
> into a probe at the ftrace location.

Good point, this looks good to me.
And "kallsyms_lookup_entry_address()" will be the preferable name.

Thank you,
> 
> 
> - Naveen
> 
> 
> ---
>  arch/powerpc/kernel/kprobes.c | 70 +++--------------------------------
>  include/linux/kprobes.h       |  1 -
>  kernel/kprobes.c              | 19 ++--------
>  kernel/trace/trace_kprobe.c   |  2 +-
>  4 files changed, 9 insertions(+), 83 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 7dae0b01abfbd6..46aa2b9e44c27c 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -41,70 +41,6 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
>  		 addr < (unsigned long)__head_end);
>  }
>  
> -kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
> -{
> -	kprobe_opcode_t *addr = NULL;
> -
> -#ifdef PPC64_ELF_ABI_v2
> -	/* PPC64 ABIv2 needs local entry point */
> -	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
> -	if (addr && !offset) {
> -#ifdef CONFIG_KPROBES_ON_FTRACE
> -		unsigned long faddr;
> -		/*
> -		 * Per livepatch.h, ftrace location is always within the first
> -		 * 16 bytes of a function on powerpc with -mprofile-kernel.
> -		 */
> -		faddr = ftrace_location_range((unsigned long)addr,
> -					      (unsigned long)addr + 16);
> -		if (faddr)
> -			addr = (kprobe_opcode_t *)faddr;
> -		else
> -#endif
> -			addr = (kprobe_opcode_t *)ppc_function_entry(addr);
> -	}
> -#elif defined(PPC64_ELF_ABI_v1)
> -	/*
> -	 * 64bit powerpc ABIv1 uses function descriptors:
> -	 * - Check for the dot variant of the symbol first.
> -	 * - If that fails, try looking up the symbol provided.
> -	 *
> -	 * This ensures we always get to the actual symbol and not
> -	 * the descriptor.
> -	 *
> -	 * Also handle <module:symbol> format.
> -	 */
> -	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
> -	bool dot_appended = false;
> -	const char *c;
> -	ssize_t ret = 0;
> -	int len = 0;
> -
> -	if ((c = strnchr(name, MODULE_NAME_LEN, ':')) != NULL) {
> -		c++;
> -		len = c - name;
> -		memcpy(dot_name, name, len);
> -	} else
> -		c = name;
> -
> -	if (*c != '\0' && *c != '.') {
> -		dot_name[len++] = '.';
> -		dot_appended = true;
> -	}
> -	ret = strscpy(dot_name + len, c, KSYM_NAME_LEN);
> -	if (ret > 0)
> -		addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
> -
> -	/* Fallback to the original non-dot symbol lookup */
> -	if (!addr && dot_appended)
> -		addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
> -#else
> -	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
> -#endif
> -
> -	return addr;
> -}
> -
>  static bool arch_kprobe_on_func_entry(unsigned long offset)
>  {
>  #ifdef PPC64_ELF_ABI_v2
> @@ -118,11 +54,15 @@ static bool arch_kprobe_on_func_entry(unsigned long offset)
>  #endif
>  }
>  
> -/* XXX try and fold the magic of kprobe_lookup_name() in this */
>  kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
>  					 bool *on_func_entry)
>  {
>  	*on_func_entry = arch_kprobe_on_func_entry(offset);
> +#ifdef PPC64_ELF_ABI_v2
> +	/* Promote probes on the GEP to the LEP */
> +	if (!offset)
> +		addr = ppc_function_entry((void *)addr);
> +#endif
>  	return (kprobe_opcode_t *)(addr + offset);
>  }
>  
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 9c28f7a0ef4268..dad375056ba049 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -382,7 +382,6 @@ static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
>  	return this_cpu_ptr(&kprobe_ctlblk);
>  }
>  
> -kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
>  kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset, bool *on_func_entry);
>  
>  int register_kprobe(struct kprobe *p);
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 8be57fdc19bdc0..066fa644e9dfa3 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -67,12 +67,6 @@ static bool kprobes_all_disarmed;
>  static DEFINE_MUTEX(kprobe_mutex);
>  static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
>  
> -kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
> -					unsigned int __unused)
> -{
> -	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
> -}
> -
>  /*
>   * Blacklist -- list of 'struct kprobe_blacklist_entry' to store info where
>   * kprobes can not probe.
> @@ -1481,7 +1475,7 @@ bool within_kprobe_blacklist(unsigned long addr)
>  		if (!p)
>  			return false;
>  		*p = '\0';
> -		addr = (unsigned long)kprobe_lookup_name(symname, 0);
> +		addr = kallsyms_lookup_function(symname);
>  		if (addr)
>  			return __within_kprobe_blacklist(addr);
>  	}
> @@ -1524,14 +1518,7 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
>  		goto invalid;
>  
>  	if (symbol_name) {
> -		/*
> -		 * Input: @sym + @offset
> -		 * Output: @addr + @offset
> -		 *
> -		 * NOTE: kprobe_lookup_name() does *NOT* fold the offset
> -		 *       argument into it's output!
> -		 */
> -		addr = kprobe_lookup_name(symbol_name, offset);
> +		addr = (kprobe_opcode_t *)kallsyms_lookup_function(symbol_name);
>  		if (!addr)
>  			return ERR_PTR(-ENOENT);
>  	}
> @@ -2621,7 +2608,7 @@ static int __init init_kprobes(void)
>  		/* lookup the function address from its name */
>  		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
>  			kretprobe_blacklist[i].addr =
> -				kprobe_lookup_name(kretprobe_blacklist[i].name, 0);
> +				(void *)kallsyms_lookup_function(kretprobe_blacklist[i].name);
>  			if (!kretprobe_blacklist[i].addr)
>  				pr_err("Failed to lookup symbol '%s' for kretprobe blacklist. Maybe the target function is removed or renamed.\n",
>  				       kretprobe_blacklist[i].name);
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 508f14af4f2c7e..a8d01954051e60 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -461,7 +461,7 @@ static bool within_notrace_func(struct trace_kprobe *tk)
>  		if (!p)
>  			return true;
>  		*p = '\0';
> -		addr = (unsigned long)kprobe_lookup_name(symname, 0);
> +		addr = kallsyms_lookup_function(symname);
>  		if (addr)
>  			return __within_notrace_func(addr);
>  	}
> -- 
> 2.35.1
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
