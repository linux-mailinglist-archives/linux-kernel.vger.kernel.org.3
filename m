Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D414D4CDF6D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiCDUkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCDUkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:40:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F007224767
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jUDouBpgOJWYtyezvaL5EXft0NuB4nkuXXcHorGk0e4=; b=pq5RoNsxsAczkCwyHy0GenNvRp
        MUiX5MrxgZaOMdsVlZEtG0c1SMLR0kjaIBi1aGD2CUA0gtMsriC5CQPv4Arms7xkU13CIgn8NYDse
        ETyNUVgIvcQWFvT5ZtDvx/jqrJae/NWPky95/OUUWj1IhgMz3d5VQho6W5s3AjfNsmMEdt09Piq7M
        a3LthAqwJlnzRVYo/qzowisnFzcSN3aco2meDQlOInA1B0OUnN20JGIssEOrKNR/oc6gpXBu5C37P
        8ioZbqnWLF0loOAovrKHQqu6QvUUv7MhnEFR98CFnhQXLHwQoowFkHZUiVZ+hiTxXxxUePHiDWx/l
        58SGJBGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQEhk-00FJAI-0A; Fri, 04 Mar 2022 20:39:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E308C98624E; Fri,  4 Mar 2022 21:39:10 +0100 (CET)
Date:   Fri, 4 Mar 2022 21:39:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 22/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <20220304203910.GR11184@worktop.programming.kicks-ass.net>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.299051388@infradead.org>
 <20220304180720.qkvvjtsbbnfugxxy@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304180720.qkvvjtsbbnfugxxy@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 10:07:20AM -0800, Josh Poimboeuf wrote:
> On Thu, Mar 03, 2022 at 12:23:43PM +0100, Peter Zijlstra wrote:
> > @@ -310,6 +311,7 @@ void machine_kexec(struct kimage *image)
> >  	/* Interrupts aren't acceptable while we reboot */
> >  	local_irq_disable();
> >  	hw_breakpoint_disable();
> > +	cet_disable();
> >  
> >  	if (image->preserve_context) {
> >  #ifdef CONFIG_X86_IO_APIC
> > --- a/arch/x86/kernel/relocate_kernel_64.S
> > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > @@ -115,6 +115,14 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_ma
> >  	pushq   %rdx
> >  
> >  	/*
> > +	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
> > +	 * below.
> > +	 */
> > +	movq	%cr4, %rax
> > +	andq	$~(X86_CR4_CET), %rax
> > +	movq	%rax, %cr4
> > +
> > +	/*
> >  	 * Set cr0 to a known state:
> >  	 *  - Paging enabled
> >  	 *  - Alignment check disabled
> 
> This probably belongs in a separate patch...

A x86/ibt,kexec patch has just been born...
