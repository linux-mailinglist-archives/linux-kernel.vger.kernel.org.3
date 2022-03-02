Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2CB4CAEC5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbiCBTd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbiCBTdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:33:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35F727B00
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X9ciUMyWsngy1GScpshbLN+2Gw7PXDG2YHYfvfouPuY=; b=u9I+yxhlPYvCWcerzCR7coP/xt
        tIsMES+FdQxmiwGfmYnkO3IvYDS0tzB4Me1yFcfbYM72uf3qGnFFuuK4ZyOs11VjEQCFi1Ty6Ol/L
        jr2fj+z6u5nb61G+IIM/oJTz0BXQL7E+U12QLy1ifGEB3NH760RunCkWWnnrjtRd26DpMoknw1c5W
        Sun4dfdPXLeacXlLGj8Zoz4ZMgX+35XhTn9qLvqf4i+6Lu2bC3khbFVRIaRokrTBpzn99QVpZY/6S
        SNDQWzkjK/UnvnmhmDbuWLsAbAqLPOHDXnru3P3zvbls7OGTVV6JvslgQZkye0QwqdeHMuAOK0CUU
        sW35pJjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPUiM-00AvCr-1c; Wed, 02 Mar 2022 19:32:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2AF243001EA;
        Wed,  2 Mar 2022 20:32:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F8A7202395D9; Wed,  2 Mar 2022 20:32:45 +0100 (CET)
Date:   Wed, 2 Mar 2022 20:32:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ndesaulniers@google.com, rostedt@goodmis.org,
        samitolvanen@google.com, x86@kernel.org
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <Yh/GXaqzDNfp93Jd@hirez.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646236764.vx04n8yp12.naveen@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 09:47:03PM +0530, Naveen N. Rao wrote:

> With respect to kprobe_lookup_name(), one of the primary motivations there
> was the issue with function descriptors for the previous elf v1 ABI (it
> likely also affects ia64/parisc). I'm thinking it'll be simpler if we have a
> way to obtain function entry point. Something like this:
> 
> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index 4176c7eca7b5aa..8c57cc5b77f9ae 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -73,6 +73,12 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
> /* Lookup the address for a symbol. Returns 0 if not found. */
> unsigned long kallsyms_lookup_name(const char *name);
> 
> +/* Return function entry point by additionally dereferencing function descriptor */
> +static inline unsigned long kallsyms_lookup_function(const char *name)
> +{
> +	return (unsigned long)dereference_symbol_descriptor((void *)kallsyms_lookup_name(name));
> +}
> +
> extern int kallsyms_lookup_size_offset(unsigned long addr,
> 				  unsigned long *symbolsize,
> 				  unsigned long *offset);
> @@ -103,6 +109,11 @@ static inline unsigned long kallsyms_lookup_name(const char *name)
> 	return 0;
> }
> 
> +static inline unsigned long kallsyms_lookup_function(const char *name)
> +{
> +	return 0;
> +}
> +
> static inline int kallsyms_lookup_size_offset(unsigned long addr,
> 					      unsigned long *symbolsize,
> 					      unsigned long *offset)
> 
> 
> With that, we can fold some of the code from kprobe_lookup_name() into
> arch_adjust_kprobe_addr() and remove kprobe_lookup_name(). This should also
> address Masami's concerns with powerpc promoting all probes at function
> entry into a probe at the ftrace location.

Yes, this looks entirely reasonable to me.

> ---

> kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
> 					 bool *on_func_entry)
> {
> 	*on_func_entry = arch_kprobe_on_func_entry(offset);
> +#ifdef PPC64_ELF_ABI_v2
> +	/* Promote probes on the GEP to the LEP */
> +	if (!offset)
> +		addr = ppc_function_entry((void *)addr);
> +#endif
> 	return (kprobe_opcode_t *)(addr + offset);
> }

I wonder if you also want to tighten up on_func_entry? Wouldn't the
above suggest something like:

kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
					 bool *on_func_entry)
{
#ifdef PPC64_ELF_ABI_V2
	unsigned long entry = ppc_function_entry((void *)addr) - addr;
	*on_func_entry = !offset || offset == entry;
	if (*on_func_entry)
		offset = entry;
#else
	*on_func_entry = !offset;
#endif
	return (void *)(addr + offset);
}

Then you can also go and delete the arch_kprobe_on_func_entry rudment.

For the rest, Yay at cleanups!, lots of magic code gone.
