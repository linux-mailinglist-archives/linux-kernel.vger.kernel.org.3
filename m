Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD14C8681
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiCAIaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiCAIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:30:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6D01CFF5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WVa24oqklH98k746ClDp4T/iR77u9/DQKhanCUCi1QU=; b=OF/PSqSL3lUgxwg9ZagEuImKOJ
        ynDFPShbK7CvcNDT+9RlWxk8GA6iwDqzZ9H2P33L1yS7SqFP4r4OOfqE7YmE0KK5yUn9NTodZci/c
        L+ihJmjzSg9FSGTuagsM661ITU8xMnTK8bKyIfJ1TV4m9gSlOSh0BHyQDnx5oq2LtUtJWazVz/kg9
        FFX3OY4gLAAbEB34NxSBblrZZadozo6H63b/jhEvsWZKUTSBp7+M8pRtqw51XN67BEY+F8zaL1CGA
        zbO9tpcYSbuC+03bVghttvIc6qjF2JIUtASTtmwe3QqBFbmZvVrmhFjZ8KjNzEeMVSc8ZDudzHTlE
        h9NyOm6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOxsK-009Ol4-9R; Tue, 01 Mar 2022 08:28:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDD183001D0;
        Tue,  1 Mar 2022 09:28:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACDA42024C933; Tue,  1 Mar 2022 09:28:49 +0100 (CET)
Date:   Tue, 1 Mar 2022 09:28:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, alexei.starovoitov@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.892372059@infradead.org>
 <20220228150705.aab2d654b973109bab070ffe@kernel.org>
 <20220228232513.GH11184@worktop.programming.kicks-ass.net>
 <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 11:49:05AM +0900, Masami Hiramatsu wrote:
> > +static kprobe_opcode_t *
> > +_kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
> > +	     unsigned long offset, bool *on_func_entry)
> >  {
> >  	if ((symbol_name && addr) || (!symbol_name && !addr))
> >  		goto invalid;
> >  
> >  	if (symbol_name) {
> > +		/*
> > +		 * Input: @sym + @offset
> > +		 * Output: @addr + @offset
> > +		 *
> > +		 * NOTE: kprobe_lookup_name() does *NOT* fold the offset
> > +		 *       argument into it's output!
> > +		 */
> >  		addr = kprobe_lookup_name(symbol_name, offset);
> 
> Hmm, there are 2 issues.
> 
> - the 'addr' includes the 'offset' here.

AFAICT it doesn't (I ever wrote that in the comment on top). There's two
implementations of kprobe_lookup_name(), the weak version doesn't even
use the offset argument, and the PowerPC implementation only checks for
!offset and doesn't fold it.

> - the 'offset' is NOT limited under the symbol size.
>   (e.g. symbol_name = "_text" and @offset points the offset of target symbol from _text)
> 
> This means we need to call kallsyms_lookup_size_offset() in this case too.

I'm feeling we should error out in that case. Using sym+offset beyond
the limits of sym is just daft.

But if you really want/need to retain that, then yes, we need that
else branch unconditionally :/
