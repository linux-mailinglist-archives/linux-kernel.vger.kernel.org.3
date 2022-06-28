Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25055E02A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243882AbiF1D4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbiF1D4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:56:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F627B35;
        Mon, 27 Jun 2022 20:56:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DDE2B81C18;
        Tue, 28 Jun 2022 03:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9E4C3411D;
        Tue, 28 Jun 2022 03:56:13 +0000 (UTC)
Date:   Mon, 27 Jun 2022 23:56:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v11 10/14] module: kallsyms: Fix suspicious rcu usage
Message-ID: <20220627235612.4796c837@gandalf.local.home>
In-Reply-To: <20220310102413.3438665-11-atomlin@redhat.com>
References: <20220310102413.3438665-1-atomlin@redhat.com>
        <20220310102413.3438665-11-atomlin@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 10:24:09 +0000
Aaron Tomlin <atomlin@redhat.com> wrote:

> No functional change.

There most definitely is a functional change here.

> 
> The purpose of this patch is to address the various Sparse warnings
> due to the incorrect dereference/or access of an __rcu pointer.
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  kernel/module/kallsyms.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index 1b0780e20aab..a3da0686a2a6 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -171,14 +171,17 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
>  	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
>  
>  	/* Set up to point into init section. */
> -	mod->kallsyms = mod->init_layout.base + info->mod_kallsyms_init_off;
> +	mod->kallsyms = (void __rcu *)mod->init_layout.base +
> +		info->mod_kallsyms_init_off;
>  
> +	preempt_disable();

        ^^^^^^^^^^^^^^^^^^


>  	/* The following is safe since this pointer cannot change */
> -	mod->kallsyms->symtab = (void *)symsec->sh_addr;
> -	mod->kallsyms->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
> +	rcu_dereference_sched(mod->kallsyms)->symtab = (void *)symsec->sh_addr;
> +	rcu_dereference_sched(mod->kallsyms)->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
>  	/* Make sure we get permanent strtab: don't use info->strtab. */
> -	mod->kallsyms->strtab = (void *)info->sechdrs[info->index.str].sh_addr;
> -	mod->kallsyms->typetab = mod->init_layout.base + info->init_typeoffs;
> +	rcu_dereference_sched(mod->kallsyms)->strtab =
> +		(void *)info->sechdrs[info->index.str].sh_addr;
> +	rcu_dereference_sched(mod->kallsyms)->typetab = mod->init_layout.base + info->init_typeoffs;
>  
>  	/*
>  	 * Now populate the cut down core kallsyms for after init
> @@ -187,20 +190,22 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
>  	mod->core_kallsyms.symtab = dst = mod->core_layout.base + info->symoffs;
>  	mod->core_kallsyms.strtab = s = mod->core_layout.base + info->stroffs;
>  	mod->core_kallsyms.typetab = mod->core_layout.base + info->core_typeoffs;
> -	src = mod->kallsyms->symtab;
> -	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
> -		mod->kallsyms->typetab[i] = elf_type(src + i, info);
> +	src = rcu_dereference_sched(mod->kallsyms)->symtab;
> +	for (ndst = i = 0; i < rcu_dereference_sched(mod->kallsyms)->num_symtab; i++) {

How big is this loop?

> +		rcu_dereference_sched(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
>  		if (i == 0 || is_livepatch_module(mod) ||
>  		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
>  				   info->index.pcpu)) {
>  			mod->core_kallsyms.typetab[ndst] =
> -			    mod->kallsyms->typetab[i];
> +			    rcu_dereference_sched(mod->kallsyms)->typetab[i];
>  			dst[ndst] = src[i];
>  			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
> -			s += strscpy(s, &mod->kallsyms->strtab[src[i].st_name],
> +			s += strscpy(s,
> +				     &rcu_dereference_sched(mod->kallsyms)->strtab[src[i].st_name],
>  				     KSYM_NAME_LEN) + 1;
>  		}
>  	}
> +	preempt_enable();

        ^^^^^^^^^^^^^^^^^

This just introduced an unbounded latency and will fail PREEMPT_RT.

-- Steve

>  	mod->core_kallsyms.num_symtab = ndst;
>  }
>  
> @@ -478,11 +483,16 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
>  
>  	mutex_lock(&module_mutex);
>  	list_for_each_entry(mod, &modules, list) {
> -		/* We hold module_mutex: no need for rcu_dereference_sched */
> -		struct mod_kallsyms *kallsyms = mod->kallsyms;
> +		struct mod_kallsyms *kallsyms;
>  
>  		if (mod->state == MODULE_STATE_UNFORMED)
>  			continue;
> +
> +		/* Use rcu_dereference_sched() to remain compliant with the sparse tool */
> +		preempt_disable();
> +		kallsyms = rcu_dereference_sched(mod->kallsyms);
> +		preempt_enable();
> +
>  		for (i = 0; i < kallsyms->num_symtab; i++) {
>  			const Elf_Sym *sym = &kallsyms->symtab[i];
>  

