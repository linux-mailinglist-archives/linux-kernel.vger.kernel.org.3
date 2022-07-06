Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CD9569146
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiGFR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiGFR7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:59:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FFB29C84;
        Wed,  6 Jul 2022 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OYgCfPr17FuNNS3i7T8/+pPqO4BBUG/Cc2fFpfiZ7Oo=; b=P7V+Trm6JddmaQmgCWxREId4CA
        F0lXawIaH9L5F/RFLUFqOexOpc3VUiSq33esaDgmRJTQcLap1u5PsMyXl67McsfQzPWGknlJLjEj1
        gt0Bo9JKUxvcMlv5a2NRmvXwNnQqJn3JBtvHyC0XPbzVqmcWFcyb/raI+B/+et1axPSuBIwvxdrSy
        Y3kiW7OV6cDBix9zGGu0TAhLa2CAcNNaUz7/kX5o1+anc9AvAWSnfCSTBmH76gbsHPxsdkUexQz7z
        uRZrQicD7cqdVeTJAhQ4YcVNlBYfdNlS3zABJtnF3ea1irGha1HGGmFS6Sj++EbDFUqvKayYDK0Vv
        dLfXGnGA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o99IT-00BsCZ-HS; Wed, 06 Jul 2022 17:58:45 +0000
Date:   Wed, 6 Jul 2022 10:58:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     rostedt@goodmis.org, cl@linux.com, pmladek@suse.com,
        mbenes@suse.cz, christophe.leroy@csgroup.eu,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, oleksandr@natalenko.name, neelx@redhat.com,
        daniel.thompson@linaro.org, hch@infradead.org, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] module: kallsyms: Ensure preemption in add_kallsyms()
 with PREEMPT_RT
Message-ID: <YsXNVSAtO+VDggcI@bombadil.infradead.org>
References: <20220704161753.4033684-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704161753.4033684-1-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Aaron, thanks again!

On Mon, Jul 04, 2022 at 05:17:53PM +0100, Aaron Tomlin wrote:
> To disable preemption in the context of add_kallsyms() is incorrect.

Why, what broke? Did this used to work? Was the commit in question a
regression then? Clarifying all this will help a lot.

The commit log is better but yet doesn't make it easy for me to tell
if I should send this to Linus as a fix in the rc series.

  Luis

> Before kallsyms-specific data is prepared/or set-up, we ensure that
> the unformed module is known to be unique i.e. does not already exist
> (see load_module()). Therefore, we can fix this by using the common RCU
> primitive as this section of code can be safely preempted.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 08126db5ff73 ("module: kallsyms: Fix suspicious rcu usage")
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  kernel/module/kallsyms.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index 3e11523bc6f6..0b6fd82d5898 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -174,14 +174,14 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
>  	mod->kallsyms = (void __rcu *)mod->init_layout.base +
>  		info->mod_kallsyms_init_off;
>  
> -	preempt_disable();
> +	rcu_read_lock();
>  	/* The following is safe since this pointer cannot change */
> -	rcu_dereference_sched(mod->kallsyms)->symtab = (void *)symsec->sh_addr;
> -	rcu_dereference_sched(mod->kallsyms)->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
> +	rcu_dereference(mod->kallsyms)->symtab = (void *)symsec->sh_addr;
> +	rcu_dereference(mod->kallsyms)->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
>  	/* Make sure we get permanent strtab: don't use info->strtab. */
> -	rcu_dereference_sched(mod->kallsyms)->strtab =
> +	rcu_dereference(mod->kallsyms)->strtab =
>  		(void *)info->sechdrs[info->index.str].sh_addr;
> -	rcu_dereference_sched(mod->kallsyms)->typetab = mod->init_layout.base + info->init_typeoffs;
> +	rcu_dereference(mod->kallsyms)->typetab = mod->init_layout.base + info->init_typeoffs;
>  
>  	/*
>  	 * Now populate the cut down core kallsyms for after init
> @@ -190,22 +190,22 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
>  	mod->core_kallsyms.symtab = dst = mod->data_layout.base + info->symoffs;
>  	mod->core_kallsyms.strtab = s = mod->data_layout.base + info->stroffs;
>  	mod->core_kallsyms.typetab = mod->data_layout.base + info->core_typeoffs;
> -	src = rcu_dereference_sched(mod->kallsyms)->symtab;
> -	for (ndst = i = 0; i < rcu_dereference_sched(mod->kallsyms)->num_symtab; i++) {
> -		rcu_dereference_sched(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
> +	src = rcu_dereference(mod->kallsyms)->symtab;
> +	for (ndst = i = 0; i < rcu_dereference(mod->kallsyms)->num_symtab; i++) {
> +		rcu_dereference(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
>  		if (i == 0 || is_livepatch_module(mod) ||
>  		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
>  				   info->index.pcpu)) {
>  			mod->core_kallsyms.typetab[ndst] =
> -			    rcu_dereference_sched(mod->kallsyms)->typetab[i];
> +			    rcu_dereference(mod->kallsyms)->typetab[i];
>  			dst[ndst] = src[i];
>  			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
> -			s += strscpy(s,
> -				     &rcu_dereference_sched(mod->kallsyms)->strtab[src[i].st_name],
> +			s += strlcpy(s,
> +				     &rcu_dereference(mod->kallsyms)->strtab[src[i].st_name],
>  				     KSYM_NAME_LEN) + 1;
>  		}
>  	}
> -	preempt_enable();
> +	rcu_read_unlock();
>  	mod->core_kallsyms.num_symtab = ndst;
>  }
>  
> -- 
> 2.34.3
> 
