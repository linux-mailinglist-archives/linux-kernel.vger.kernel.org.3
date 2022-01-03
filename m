Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077C148367F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiACR6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiACR6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:58:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111CC061761;
        Mon,  3 Jan 2022 09:58:08 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28C1A1EC0118;
        Mon,  3 Jan 2022 18:58:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641232683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lg6/SYBjwUEm8ZWAi8vMp09yL3c8/qSiwWmVSfDOZsI=;
        b=cigFZ3t+av441lOj6j6kLxBruXe7oY02YdcKvTWUtOdgK+yXsRxtr2QH6Ji1J5C6xMDYNI
        3OT2Lyz79LWuY2XjIVwXoH12SqzYMa8NLLExRsTBhbb4mPdi51hkdpojujEj0mlU0WUt+L
        69kmi6dje7xywQzF0lEj9yye60AiCPk=
Date:   Mon, 3 Jan 2022 18:58:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     llvm@lists.linux.dev
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-tip-commits@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [tip: objtool/urgent] compiler.h: Fix annotation macro
 misplacement with Clang
Message-ID: <YdM5Kh1NOKEwDwAP@zn.tnic>
References: <0417e96909b97a406323409210de7bf13df0b170.1636410380.git.jpoimboe@redhat.com>
 <164016423099.16921.16996655982787145621.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <164016423099.16921.16996655982787145621.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if clang folks have seen this and perhaps have a comment as to
why the volatile gets ingored... Added.

On Wed, Dec 22, 2021 at 09:10:30AM -0000, tip-bot2 for Josh Poimboeuf wrote:
> The following commit has been merged into the objtool/urgent branch of tip:
> 
> Commit-ID:     dcce50e6cc4d86a63dc0a9a6ee7d4f948ccd53a1
> Gitweb:        https://git.kernel.org/tip/dcce50e6cc4d86a63dc0a9a6ee7d4f948ccd53a1
> Author:        Josh Poimboeuf <jpoimboe@redhat.com>
> AuthorDate:    Mon, 08 Nov 2021 14:35:59 -08:00
> Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
> CommitterDate: Tue, 21 Dec 2021 15:09:46 -08:00
> 
> compiler.h: Fix annotation macro misplacement with Clang
> 
> When building with Clang and CONFIG_TRACE_BRANCH_PROFILING, there are a
> lot of unreachable warnings, like:
> 
>   arch/x86/kernel/traps.o: warning: objtool: handle_xfd_event()+0x134: unreachable instruction
> 
> Without an input to the inline asm, 'volatile' is ignored for some
> reason and Clang feels free to move the reachable() annotation away from
> its intended location.
> 
> Fix that by re-adding the counter value to the inputs.
> 
> Fixes: f1069a8756b9 ("compiler.h: Avoid using inline asm operand modifiers")
> Fixes: c199f64ff93c ("instrumentation.h: Avoid using inline asm operand modifiers")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Link: https://lore.kernel.org/r/0417e96909b97a406323409210de7bf13df0b170.1636410380.git.jpoimboe@redhat.com
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: x86@kernel.org
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Miroslav Benes <mbenes@suse.cz>
> ---
>  include/linux/compiler.h        | 4 ++--
>  include/linux/instrumentation.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 3d5af56..429dceb 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -121,7 +121,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  	asm volatile(__stringify_label(c) ":\n\t"			\
>  		     ".pushsection .discard.reachable\n\t"		\
>  		     ".long " __stringify_label(c) "b - .\n\t"		\
> -		     ".popsection\n\t");				\
> +		     ".popsection\n\t" : : "i" (c));			\
>  })
>  #define annotate_reachable() __annotate_reachable(__COUNTER__)
>  
> @@ -129,7 +129,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  	asm volatile(__stringify_label(c) ":\n\t"			\
>  		     ".pushsection .discard.unreachable\n\t"		\
>  		     ".long " __stringify_label(c) "b - .\n\t"		\
> -		     ".popsection\n\t");				\
> +		     ".popsection\n\t" : : "i" (c));			\
>  })
>  #define annotate_unreachable() __annotate_unreachable(__COUNTER__)
>  
> diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
> index fa2cd8c..24359b4 100644
> --- a/include/linux/instrumentation.h
> +++ b/include/linux/instrumentation.h
> @@ -11,7 +11,7 @@
>  	asm volatile(__stringify(c) ": nop\n\t"				\
>  		     ".pushsection .discard.instr_begin\n\t"		\
>  		     ".long " __stringify(c) "b - .\n\t"		\
> -		     ".popsection\n\t");				\
> +		     ".popsection\n\t" : : "i" (c));			\
>  })
>  #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
>  
> @@ -50,7 +50,7 @@
>  	asm volatile(__stringify(c) ": nop\n\t"				\
>  		     ".pushsection .discard.instr_end\n\t"		\
>  		     ".long " __stringify(c) "b - .\n\t"		\
> -		     ".popsection\n\t");				\
> +		     ".popsection\n\t" : : "i" (c));			\
>  })
>  #define instrumentation_end() __instrumentation_end(__COUNTER__)
>  #else

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
