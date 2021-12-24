Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D70E47EEA4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 12:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352614AbhLXLuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 06:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbhLXLuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 06:50:18 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2675FC061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 03:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mJHt544TExE5Pu4Gn+mq7gBB4fnKpsXYDsqrLap7G7o=; b=bwYCRyE5MfpCFrPWwbwI5LCmgj
        rsC8E12BQg36YBNdX/6+FlrZaAiOMKt/sILnOZUe9INKQAde7dtYZdsISl5KNCEknjnRdEVRYq0Ny
        VSxmuyTzxdpm2qTfIclCKW737bCbIT3zJfBvoyNq3qoVQKARW+Ylx1re0BpNJvrI3kbbqwM0WJgi7
        mSF2bqvN9JO2W4xwp0m1UQ0+8pAoCB+wFZvywLcOjBYz3/ccWuRQ3TmMOobbdLFMJsV95gWkmU3XP
        BFUa5+8OUAr0qULOXj4VDOblc9oMDLpXrIYZNXymV3112vsTNy/9TZ72SSxmGsX7QYJkYy7uQyDBQ
        gk7r1voQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0j5G-003HWr-Lq; Fri, 24 Dec 2021 11:50:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A621330003C;
        Fri, 24 Dec 2021 12:50:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89FC72024319B; Fri, 24 Dec 2021 12:50:01 +0100 (CET)
Date:   Fri, 24 Dec 2021 12:50:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH v2] x86/mce: Reduce number of machine checks taken during
 recovery
Message-ID: <YcWz6aEfsOZlHHXp@hirez.programming.kicks-ass.net>
References: <20211215222016.1390235-1-tony.luck@intel.com>
 <20211218005322.GM16608@worktop.programming.kicks-ass.net>
 <YcTW5dh8yTGucDd+@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcTW5dh8yTGucDd+@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 12:07:01PM -0800, Luck, Tony wrote:
> diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
> index e6ac38587b40..26781cbe7e37 100644
> --- a/arch/x86/lib/copy_user_64.S
> +++ b/arch/x86/lib/copy_user_64.S
> @@ -212,6 +212,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
>   * Don't try to copy the tail if machine check happened
>   *
>   * Input:
> + * eax x86 trap number - set by fixup_excpetion()

That's inaccurate, fixup_exception() (event if it's spelled correctly)
does not unconditionally set the trap number in RAX, that's only done by
ex_handler_fault() (or ex_handler_sgx()), which means all flows into
this function must pass through: EX_TYPE_FAULT, EX_TYPE_FAULT_MCE or
EX_TYPE_COPY.

Boris might fix up your comment if he applies I suppose..

>   * rdi destination
>   * rsi source
>   * rdx count
> @@ -220,12 +221,20 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
>   * eax uncopied bytes or 0 if successful.
>   */
>  SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
> +	cmp $X86_TRAP_MC,%eax
> +	je 3f
> +
>  	movl %edx,%ecx
>  1:	rep movsb
>  2:	mov %ecx,%eax
>  	ASM_CLAC
>  	RET
>  
> +3:
> +	movl %edx,%eax
> +	ASM_CLAC
> +	RET
> +
>  	_ASM_EXTABLE_CPY(1b, 2b)
>  
>  .Lcopy_user_handle_align:
> 
> base-commit: 82a8954acd93ae95d6252fb93a3d210c8f71b093
> -- 
> 2.31.1
> 
