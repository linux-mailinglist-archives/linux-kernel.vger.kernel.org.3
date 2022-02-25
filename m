Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9317F4C433A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbiBYLVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiBYLVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:21:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94F721DF19
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CkQKHfXHcP4U0h6j4AIzYw5C4UqDwewYRL04vYWYbJM=; b=jkRMBMDVF9HF2jmJxoBj96sj+B
        tfKJr4BjF+HQh6ZUU4RDFI9i8DyT4uHIZ2zNPkU4O+1SkKWDOeTNA2H37VkCh9AP4TXxn5ynyRwDu
        DB87ysaUqu83mxPaqMApTukxXhlYXPdP48ii8qAxXqEVRpP+SrYZJFwBOwEbY0jBcsLYyOXr0ovGB
        4wBBlB0ugkc4d71Aaqznol3iUv8PP9S4paxYcSj0K5IIj3VxSIKkyW1k0zn4stSX8ROfGOMMrEViM
        vWrStEGxqy3P76IfTYYMh5NR7oxgX5ySiJNg8axpKdRahUB75xFJVuKFglntoTy9Mw6cy7aAAvKGJ
        rVRvaNUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNYeV-005jMc-Iw; Fri, 25 Feb 2022 11:20:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D4F93001C0;
        Fri, 25 Feb 2022 12:20:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 019BA2D66F33D; Fri, 25 Feb 2022 12:20:46 +0100 (CET)
Date:   Fri, 25 Feb 2022 12:20:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 16/39] x86/bpf: Add ENDBR instructions to prologue and
 trampoline
Message-ID: <Yhi7jsnP8bRnx3If@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.950111925@infradead.org>
 <20220224233731.7hdwbszv5c6fgx4y@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224233731.7hdwbszv5c6fgx4y@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:37:31PM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 24, 2022 at 03:51:54PM +0100, Peter Zijlstra wrote:
> > @@ -339,9 +350,18 @@ static int __bpf_arch_text_poke(void *ip
> >  	u8 *prog;
> >  	int ret;
> >  
> > +#ifdef CONFIG_X86_KERNEL_IBT
> > +	if (is_endbr(*(u32 *)ip))
> > +		ip += 4;
> > +#endif
> > +
> >  	memcpy(old_insn, nop_insn, X86_PATCH_SIZE);
> >  	if (old_addr) {
> >  		prog = old_insn;
> > +#ifdef CONFIG_X86_KERNEL_IBT
> > +		if (is_endbr(*(u32 *)old_addr))
> > +			old_addr += 4;
> > +#endif
> >  		ret = t == BPF_MOD_CALL ?
> >  		      emit_call(&prog, old_addr, ip) :
> >  		      emit_jump(&prog, old_addr, ip);
> > @@ -352,6 +372,10 @@ static int __bpf_arch_text_poke(void *ip
> >  	memcpy(new_insn, nop_insn, X86_PATCH_SIZE);
> >  	if (new_addr) {
> >  		prog = new_insn;
> > +#ifdef CONFIG_X86_KERNEL_IBT
> > +		if (is_endbr(*(u32 *)new_addr))
> > +			new_addr += 4;
> > +#endif
> 
> All the above ifdef-itis should be able to be removed since is_endbr()
> returns false for !IBT.

So I've been pondering a skip_endbr() function for all these sites.

I just couldn't decide making it a 'function' and having a signature
like:

	ip = skip_endbr(ip);

or making it macro magic and it reading:

	skip_endbr(ip);

Which is why I've not cleaned it up yet.  This being C(ish) I suppose
the former is less confusing, so let me go do that.

