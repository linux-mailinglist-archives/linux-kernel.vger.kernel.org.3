Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390554C9775
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiCAVD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiCAVDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:03:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E098F5BD21
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DODOXPmzt0IoLqmiG63sNdN99SgG8nr/4PymavvjZ18=; b=X413e6ZADBz8A3hPcbJyVS4PnF
        UIGYB4KfLoRPWac1CvPJTesqsrWpN7VWkLtNuzbCdvpef4eyXgf3OjDmsFYk9uvGCQOKgB1CU1iCt
        APP1g+8YNNzFUwiXPv1t2vgomDTJcWYKs++lNeTKMfOauF6GjKu7WFymetkBDARI22XmYRSsePL+d
        cmKmTu37K9xrMsj0XWeongjDBJcu0GfOvxzeeyHAZs6V7v/kxyluvwjpVz+8CfzyJ+xW7zUOAPHuZ
        iZDJMbxu2+HdAytIfr4/xBVdraa6vf16Z7KtQopx9tWqBsrRh0MzeS44GIxoB9JKULWy9gO9LnbH+
        hw6zFUKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP9dv-009wku-IG; Tue, 01 Mar 2022 21:02:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78F42986271; Tue,  1 Mar 2022 22:02:45 +0100 (CET)
Date:   Tue, 1 Mar 2022 22:02:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Poimboe, Josh" <jpoimboe@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <20220301210245.GM11184@worktop.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.069205370@infradead.org>
 <eed8902f21ba9e5f93562432f6b5920137860a98.camel@intel.com>
 <Yh44YsW8viBscBD0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh44YsW8viBscBD0@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 04:14:42PM +0100, Peter Zijlstra wrote:

> Something like so?
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 399f075ccdc4..5b65f6ec5ee6 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -114,6 +114,14 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	/* store the start address on the stack */
>  	pushq   %rdx
>  
> +	/*
> +	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
> +	 * below.
> +	 */
> +	movq	%cr4, %rax
> +	andq	$~(X86_CR4_CET), %rax
> +	movq	%rax, %cr4
> +
>  	/*
>  	 * Set cr0 to a known state:
>  	 *  - Paging enabled

I *think* it worked, I 'apt install kexec-tools' and copied the magic
commands Josh gave over IRC and the machine went and came back real
quick.

Lacking useful console I can't say much more.

I pushed out a version with these things on.
