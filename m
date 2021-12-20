Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF86847B347
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbhLTS47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:56:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54832 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240092AbhLTS46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:56:58 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDD861EC03E3;
        Mon, 20 Dec 2021 19:56:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640026613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=b1X+g4YTEFKWkDa+EeT00pYJALymcKesJUx7buSoYsw=;
        b=GvTc9ISu+5pWT8q92vl8Xar/1lvq9JctiQ2Mk4aIgLK9Y1YCLvUAKSCHpaioDbk/BI4ell
        TnF+gDmhPUX5BuX+h8G0NcH2+tnbloO38qQRjwp/nLzMoJ3luT/g2fLwoM1HlvAjSXbYls
        9c5N7IBLJvtUYwScn2t7rLSvxnpCejg=
Date:   Mon, 20 Dec 2021 19:56:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/4] x86/entry: Make paranoid_exit() callable
Message-ID: <YcDR92+JFkVAZi5c@zn.tnic>
References: <20211213150340.9419-1-jiangshanlai@gmail.com>
 <20211213150340.9419-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213150340.9419-2-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:03:37PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Move the last JMP out of paranoid_exit() and make it callable.
> 
> It will allow asm_exc_nmi() to call it and avoid duplicated code.
> 
> No functional change intended.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry_64.S | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 44dadea935f7..3dc3cec03425 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -439,7 +439,8 @@ SYM_CODE_START(\asmsym)
>  
>  	call	\cfunc
>  
> -	jmp	paranoid_exit
> +	call	paranoid_exit
> +	jmp	restore_regs_and_return_to_kernel

I guess but I don't like the glueing of the CALL to paranoid_exit with
the JMP to the restore_regs_and_return_to_kernel label. That reads
to me as, "if you're calling paranoid_exit() you must jump to the
restore_regs_and_return_to_kernel label but not always."

So I'm thinking you should leave the jump to that label inside
paranoid_exit() and use its %rbx argument to control when to jump to it
and when not.

I.e., not jump to it in the NMI case.

AFAICT, ofc. asm is always nasty to stare at.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
