Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46F856B0F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 05:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbiGHD1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 23:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiGHD1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:27:44 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9011C747A3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 20:27:43 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id he28so25634963qtb.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 20:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Fkdge/Nw+hp2LyWDD1RraaWizvaUbNrgq9CNzWE36oI=;
        b=Z0O4AZvZL310mr4YeJPsjbOoNh8onqFaE/pWH//yE7WVUTEaK2bQ/qUbKFRev6wiWM
         7B+3pNjELKQtQ35iL5Ti25V89NS2O/qguKW/B2u0aHlBBJGXWzyl6e5EVnQmQMaKIcfy
         iDOgUQl+XiigijRCbeSJUA0JQVppMzui5IVJtWiZWooAD7TJAti/V4oKeTF3Q8Z1oBMw
         LFrc0y1HEyE1yA3GJ0/v3LfEJqvbsGi1c/E646hU2xlWGfeKY7U84PypmiHtZ8oUo9R9
         EWzLzVhm8TasMdtEQIi+FBfKdfM02XmmD5gZcASQ05L929yb79/b+eQ0Kw8+y6PA01gR
         lpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Fkdge/Nw+hp2LyWDD1RraaWizvaUbNrgq9CNzWE36oI=;
        b=GSH7olLITW9fvo0h88OXmP6fK84tTXyO923NtX/y4sAiRP7eONgvCpR/qiynhnVw/A
         4USL5XmC9nnj/X9pmfhDC0NjyPmtlJRr2uGZ4Qmaz30c1mLkkaRbEriIkOqApzYR4XRJ
         YUxUz+LAEcXTH5kRIBRVNHBIidqDy0in17WJjQnIpcosLF/8b/yzQNmu13WostNuH1Bt
         fSNzNLv0V4EKq4RS8EFJC9LVmVjaqGNSa5YY80xwo4go5aXYqKkQyDcyMlZdA6uBOFQz
         gEY6yKBmxNsv92CiOiNPr7/IF3+oGbzwC8HgZ08GjEUQfs/mykS0w9oMi92a8+QhVHDw
         8sQg==
X-Gm-Message-State: AJIora/8DnP5tiQA0nhbj+hu4koDyr9XmaoCur8JacptV9fDBvujBdwd
        NlXqKzoxjCajAq0nF7SEaAt3IlPvyTNtbw==
X-Google-Smtp-Source: AGRyM1vXypjVqTpH1CyAa1HHU80BKivIBbnRrcSR4/b8WpNNVUA/LaHgEMeY/tpwdkEHNhe/iWeXYg==
X-Received: by 2002:a05:622a:178e:b0:31d:49dd:c35 with SMTP id s14-20020a05622a178e00b0031d49dd0c35mr1169035qtk.555.1657250862606;
        Thu, 07 Jul 2022 20:27:42 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c13-20020a05620a164d00b006a6a4b43c01sm31604577qko.38.2022.07.07.20.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 20:27:42 -0700 (PDT)
Date:   Thu, 7 Jul 2022 20:27:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Nadav Amit <nadav.amit@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] x86/mm/tlb: avoid reading mm_tlb_gen when possible
In-Reply-To: <20220606180123.2485171-1-namit@vmware.com>
Message-ID: <df9e416a-a6a2-34a-9fa9-dcb92fe6cee2@google.com>
References: <20220606180123.2485171-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022, Nadav Amit wrote:

> From: Nadav Amit <namit@vmware.com>
> 
> On extreme TLB shootdown storms, the mm's tlb_gen cacheline is highly
> contended and reading it should (arguably) be avoided as much as
> possible.
> 
> Currently, flush_tlb_func() reads the mm's tlb_gen unconditionally,
> even when it is not necessary (e.g., the mm was already switched).
> This is wasteful.
> 
> Moreover, one of the existing optimizations is to read mm's tlb_gen to
> see if there are additional in-flight TLB invalidations and flush the
> entire TLB in such a case. However, if the request's tlb_gen was already
> flushed, the benefit of checking the mm's tlb_gen is likely to be offset
> by the overhead of the check itself.
> 
> Running will-it-scale with tlb_flush1_threads show a considerable
> benefit on 56-core Skylake (up to +24%):
> 
> threads		Baseline (v5.17+)	+Patch
> 1		159960			160202
> 5		310808			308378 (-0.7%)
> 10		479110			490728
> 15		526771			562528
> 20		534495			587316
> 25		547462			628296
> 30		579616			666313
> 35		594134			701814
> 40		612288			732967
> 45		617517			749727
> 50		637476			735497
> 55		614363			778913 (+24%)
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> 
> --
> 
> Note: The benchmarked kernels include Dave's revert of commit
> 6035152d8eeb ("x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
> tlb_is_not_lazy()
> ---
>  arch/x86/mm/tlb.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index d400b6d9d246..d9314cc8b81f 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -734,10 +734,10 @@ static void flush_tlb_func(void *info)
>  	const struct flush_tlb_info *f = info;
>  	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
>  	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> -	u64 mm_tlb_gen = atomic64_read(&loaded_mm->context.tlb_gen);
>  	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
>  	bool local = smp_processor_id() == f->initiating_cpu;
>  	unsigned long nr_invalidate = 0;
> +	u64 mm_tlb_gen;
>  
>  	/* This code cannot presently handle being reentered. */
>  	VM_WARN_ON(!irqs_disabled());
> @@ -771,6 +771,22 @@ static void flush_tlb_func(void *info)
>  		return;
>  	}
>  
> +	if (f->new_tlb_gen <= local_tlb_gen) {
> +		/*
> +		 * The TLB is already up to date in respect to f->new_tlb_gen.
> +		 * While the core might be still behind mm_tlb_gen, checking
> +		 * mm_tlb_gen unnecessarily would have negative caching effects
> +		 * so avoid it.
> +		 */
> +		return;
> +	}
> +
> +	/*
> +	 * Defer mm_tlb_gen reading as long as possible to avoid cache
> +	 * contention.
> +	 */
> +	mm_tlb_gen = atomic64_read(&loaded_mm->context.tlb_gen);
> +
>  	if (unlikely(local_tlb_gen == mm_tlb_gen)) {
>  		/*
>  		 * There's nothing to do: we're already up to date.  This can
> -- 
> 2.25.1

I'm sorry, but bisection and reversion show that this commit,
aa44284960d550eb4d8614afdffebc68a432a9b4 in current linux-next,
is responsible for the "internal compiler error: Segmentation fault"s
I get when running kernel builds on tmpfs in 1G memory, lots of swapping.

That tmpfs is using huge pages as much as it can, so splitting and
collapsing, compaction and page migration entailed, in case that's
relevant (maybe this commit is perfect, but there's a TLB flushing
bug over there in mm which this commit just exposes).

Whether those segfaults happen without the huge page element,
I have not done enough testing to tell - there are other bugs with
swapping in current linux-next, indeed, I wouldn't even have found
this one, if I hadn't already been on a bisection for another bug,
and got thrown off course by these segfaults.

I hope that you can work out what might be wrong with this,
but meantime I think it needs to be reverted.

Thanks,
Hugh
