Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35DA58B49A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiHFIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiHFIrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:47:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF788380
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 01:47:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id tl27so8672046ejc.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S8U+XjCKUr1cdBVuHjbyU1yjWuD71pUjOVEJ7kC3SxM=;
        b=pV5ciy6LaN0DAZ70WSK6swMa4WaH1+ESUnLx7Bv7R4hRJi3u4kAkA6G7kpRRQsI8ty
         z0OQTkUV6xhBfUHr0pb5zGd0ZXhJsDNujJmzE3FG0P3TiNz814rVfud4sleBAQs2z7h3
         zUKhlYxjf7SPP6wq2oXeYbkeZBLoIhc1vkw88TdTAwDpdGNrxquHyoy1QqdAuad1JN2s
         zDylmcFLShrJc5wwgiJpc7rC6lEwmAhI4WgJZ4nPw/xrIJyW75Deh2Ur2c9s1jI4bkW/
         W7+Tz8e5kr2dWOdytqaDB24GSi08zLOMdzDeEqwpEKxPDVIipqiqSkjR802KrchPokxL
         hN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=S8U+XjCKUr1cdBVuHjbyU1yjWuD71pUjOVEJ7kC3SxM=;
        b=EtPixvJeJMabInLFAvxZLVPeR9du1MNLfCypw36BVlfwUTBfVM+KGUnJbfgWY8DsGT
         iIqZHmiyP67ulth1krWdSI8HAodBV8dE8qM2dAAM4lvob6MyKdPCrN9FtNNSjjQNxODZ
         r5THcKgtsPEn0KbQ+86Ca4rDtSIN15nDHUwFeKZhzrrynN6dsfnimMrPU/CaS8V9EQXe
         6B1UAQLAxBM6HEoloTOijrd1Vsm2djnlGoNCg7CpJJmaSVnPEVyeQaf1SmgwlBcueEcP
         DWVnBjJVsXApb519mRIIopjw3MBvVq1z6/i4ElWnSSYa3RFdGLHGDKRxzwD3iNDMG4rr
         UUVg==
X-Gm-Message-State: ACgBeo28hzl4hA7Aji+vZTJEH+l97H8qt5ZA3p4vBW63KBmE0NV4/VGx
        DmrH8Bbdm10ENHW2KFtLLA1JeQFmwBU=
X-Google-Smtp-Source: AA6agR4A2w6523kxXqxT0UL8zaicwOBvnieSfqD+STtA0Quv99bFOLQaRCyoaDZ2px2VInEM8PFjaw==
X-Received: by 2002:a17:907:9628:b0:731:1e3:b168 with SMTP id gb40-20020a170907962800b0073101e3b168mr3970205ejc.526.1659775632241;
        Sat, 06 Aug 2022 01:47:12 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709062f0700b00730165d7f41sm2528510eji.13.2022.08.06.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 01:47:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 6 Aug 2022 10:47:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3] x86,mm: print likely CPU at segfault time
Message-ID: <Yu4qja8L2ulHaqVt@gmail.com>
References: <20220805101644.2e674553@imladris.surriel.com>
 <Yu0o3J2T5QwKtoan@zn.tnic>
 <20220805104007.115359b5@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805104007.115359b5@imladris.surriel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rik van Riel <riel@surriel.com> wrote:

> On Fri, 5 Aug 2022 16:27:40 +0200
> Borislav Petkov <bp@alien8.de> wrote:
> 
> > On Fri, Aug 05, 2022 at 10:16:44AM -0400, Rik van Riel wrote:
> > > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > > index fad8faa29d04..c7a5bbf40367 100644
> > > --- a/arch/x86/mm/fault.c
> > > +++ b/arch/x86/mm/fault.c
> > > @@ -769,6 +769,8 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
> > >  		unsigned long address, struct task_struct *tsk)
> > >  {
> > >  	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
> > > +	/* This is a racy snapshot, but it's better than nothing. */
> > > +	int cpu = raw_smp_processor_id();  
> > 
> > Please read this in exc_page_fault() and hand it down to helpers.
> 
> Below is the change that implements your suggestion.
> 
> If there is consensus among the x86 maintainers that this is
> desirable, I am more than happy to merge that change into my
> patch and resubmit v4.
> 
> I don't have a strong opinion either way.
> 
> ---8<---
> 
> From 444f8588f0edfd8586a86e85191ad8fa8b7c6a6c Mon Sep 17 00:00:00 2001
> From: Rik van Riel <riel@surriel.com>
> Date: Fri, 5 Aug 2022 10:32:11 -0400
> Subject: [PATCH 2/2] x86,mm: get CPU number for segfault printk before
>  enabling preemption
> 
> Get the CPU number for the segfault printk earlier in the page fault
> handler, before preemption is enabled.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  arch/x86/mm/fault.c | 58 +++++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index c7a5bbf40367..bd06b22826b2 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -766,11 +766,9 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
>   */
>  static inline void
>  show_signal_msg(struct pt_regs *regs, unsigned long error_code,
> -		unsigned long address, struct task_struct *tsk)
> +		unsigned long address, struct task_struct *tsk, int cpu)

>  __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
> -		       unsigned long address, u32 pkey, int si_code)
> +		       unsigned long address, u32 pkey, int si_code, int cpu)

> -		show_signal_msg(regs, error_code, address, tsk);
> +		show_signal_msg(regs, error_code, address, tsk, cpu);

> -		     unsigned long address)
> +		     unsigned long address, int cpu)

> -	   unsigned long address, u32 pkey, int si_code)
> +	   unsigned long address, u32 pkey, int si_code, int cpu)

> -	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code);
> +	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code, cpu);

> -bad_area(struct pt_regs *regs, unsigned long error_code, unsigned long address)
> +bad_area(struct pt_regs *regs, unsigned long error_code, unsigned long address,
> +	 int cpu)
>  {
> -	__bad_area(regs, error_code, address, 0, SEGV_MAPERR);
> +	__bad_area(regs, error_code, address, 0, SEGV_MAPERR, cpu);

>  bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
> -		      unsigned long address, struct vm_area_struct *vma)
> +		      unsigned long address, struct vm_area_struct *vma,
> +		      int cpu)

> -		__bad_area(regs, error_code, address, pkey, SEGV_PKUERR);
> +		__bad_area(regs, error_code, address, pkey, SEGV_PKUERR, cpu);
>  	} else {
> -		__bad_area(regs, error_code, address, 0, SEGV_ACCERR);
> +		__bad_area(regs, error_code, address, 0, SEGV_ACCERR, cpu);

>  static void
>  do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
> -		   unsigned long address)
> +		   unsigned long address, int cpu)

> -	bad_area_nosemaphore(regs, hw_error_code, address);
> +	bad_area_nosemaphore(regs, hw_error_code, address, cpu);

>  void do_user_addr_fault(struct pt_regs *regs,
>  			unsigned long error_code,
> -			unsigned long address)
> +			unsigned long address,
> +			int cpu)

> -		bad_area_nosemaphore(regs, error_code, address);
> +		bad_area_nosemaphore(regs, error_code, address, cpu);

> -			bad_area_nosemaphore(regs, error_code, address);
> +			bad_area_nosemaphore(regs, error_code, address, cpu);

> -		bad_area(regs, error_code, address);
> +		bad_area(regs, error_code, address, cpu);

> -		bad_area(regs, error_code, address);
> +		bad_area(regs, error_code, address, cpu);

> -		bad_area(regs, error_code, address);
> +		bad_area(regs, error_code, address, cpu);

> -		bad_area_access_error(regs, error_code, address, vma);
> +		bad_area_access_error(regs, error_code, address, vma, cpu);

> -			bad_area_nosemaphore(regs, error_code, address);
> +			bad_area_nosemaphore(regs, error_code, address, cpu);

> -			      unsigned long address)
> +			      unsigned long address, int cpu)

> -		do_kern_addr_fault(regs, error_code, address);
> +		do_kern_addr_fault(regs, error_code, address, cpu);

> -		do_user_addr_fault(regs, error_code, address);
> +		do_user_addr_fault(regs, error_code, address, cpu);

>  DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
>  {
>  	unsigned long address = read_cr2();
> +	int cpu = raw_smp_processor_id();
>  	irqentry_state_t state;
>  
>  	prefetchw(&current->mm->mmap_lock);
> @@ -1547,7 +1549,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
>  	state = irqentry_enter(regs);
>  
>  	instrumentation_begin();
> -	handle_page_fault(regs, error_code, address);
> +	handle_page_fault(regs, error_code, address, cpu);

Not convinced that this is a good change: this will bloat all the affected 
code by a couple of dozen instructions - for no good reason in the context 
of this patch.

Boris, why should we do this? Extracting a parameter at higher levels and 
passing it down to lower levels is almost always a bad idea from a code 
generation POV, unless the majority of lower levels needs this information 
anyway (which isn't the case here).

Thanks,

	Ingo
