Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D02351461C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357158AbiD2KAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356858AbiD2KAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:00:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0649845056
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:56:51 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 641A71EC0453;
        Fri, 29 Apr 2022 11:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651226206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P6nVGbXmK9ane5yuQmzTXtIPlhp6mW5fJBNK+HaVpm4=;
        b=EzpLc3I5j88UyAQTdMlQ09fKfbhrTqs7yM423vejo8SX/GgDONABl/vO3exSiLz5Ulalzb
        c3xiaH1aHYz2/zG9k29cj6GLflOH53B1ToIvieRXcJNo9XDtS0vHegloQzUlyW7XkvmCDu
        dHCf61ITSHAjmfybQgbwJsI6f+56+8o=
Date:   Fri, 29 Apr 2022 11:56:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        =?utf-8?Q?J=C3=BCrgen?= Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH V6 6/8] x86/entry: Convert SWAPGS to swapgs and remove
 the definition of SWAPGS
Message-ID: <Ymu2XC7k8Xj/vMjG@zn.tnic>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-7-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220421141055.316239-7-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:10:53PM +0800, Lai Jiangshan wrote:
> diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
> index 4fdb007cddbd..c5aeb0819707 100644
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -50,7 +50,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
>  	UNWIND_HINT_EMPTY
>  	ENDBR
>  	/* Interrupts are off on entry. */
> -	SWAPGS
> +	swapgs
>  
>  	pushq	%rax
>  	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax

I'm not sure about this: why can't XENPV do a 32-bit syscall through the vdso?

Also, looking at this, Jürgen, it looks kinda spaghetti to me:

entry_SYSENTER_compat

...

        /* XEN PV guests always use IRET path */
        ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
                    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV


then at that swapgs_restore_regs_and_return_to_usermode label:

#ifdef CONFIG_XEN_PV
        ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
#endif


Can we simply jump directly to xenpv_restore_regs_and_return_to_usermode
from entry_SYSENTER_compat or is that CONFIG_DEBUG_ENTRY chunk there
needed?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
