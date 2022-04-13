Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F58A4FF5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiDMLoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiDMLoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:44:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F84532C3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:41:51 -0700 (PDT)
Received: from zn.tnic (p200300ea971b584e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:584e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA6631EC0528;
        Wed, 13 Apr 2022 13:41:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649850105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vrSuktU3IKV4kxVHDDfcm/5ZWdX3F9km7GwmFzhrtTE=;
        b=TQSr1CZVZ8mMXafk59pQiMXlPDNISVxulBYYnkygCHk50FgNdmVS6CvXjIsAK4lwsFbyQO
        mutXP1YukfA9PA5l9VeiFlCmiBHVq21vvR0pBa9xDd3E7RuB4xyxFeE6QxCtyHyGlCd04z
        x6FqRMM+dfwsrK6RgqQ54NLuPcd+upk=
Date:   Wed, 13 Apr 2022 13:41:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brian Gerst <brgerst@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/4] ELF: Remove elf_core_copy_kernel_regs()
Message-ID: <Yla2+ItaT0TuuDND@zn.tnic>
References: <20220325153953.162643-1-brgerst@gmail.com>
 <20220325153953.162643-3-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325153953.162643-3-brgerst@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ PPC ML as an FYI that this change will come through tip.

On Fri, Mar 25, 2022 at 11:39:51AM -0400, Brian Gerst wrote:
> x86-32 was the last architecture that implemented separate user and
> kernel registers.
> 
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/powerpc/kernel/fadump.c               | 2 +-
>  arch/powerpc/platforms/powernv/opal-core.c | 2 +-
>  include/linux/elfcore.h                    | 9 ---------
>  kernel/kexec_core.c                        | 2 +-
>  4 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 4fdb7c77fda1..c0cf17196d6c 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -752,7 +752,7 @@ u32 *__init fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
>  	 * FIXME: How do i get PID? Do I really need it?
>  	 * prstatus.pr_pid = ????
>  	 */
> -	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
> +	elf_core_copy_regs(&prstatus.pr_reg, regs);
>  	buf = append_elf_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
>  			      &prstatus, sizeof(prstatus));
>  	return buf;
> diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
> index 0331f1973f0e..dd6e99edff76 100644
> --- a/arch/powerpc/platforms/powernv/opal-core.c
> +++ b/arch/powerpc/platforms/powernv/opal-core.c
> @@ -112,7 +112,7 @@ static void __init fill_prstatus(struct elf_prstatus *prstatus, int pir,
>  			  struct pt_regs *regs)
>  {
>  	memset(prstatus, 0, sizeof(struct elf_prstatus));
> -	elf_core_copy_kernel_regs(&(prstatus->pr_reg), regs);
> +	elf_core_copy_regs(&(prstatus->pr_reg), regs);
>  
>  	/*
>  	 * Overload PID with PIR value.
> diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
> index f8e206e82476..346a8b56cdc8 100644
> --- a/include/linux/elfcore.h
> +++ b/include/linux/elfcore.h
> @@ -84,15 +84,6 @@ static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *re
>  #endif
>  }
>  
> -static inline void elf_core_copy_kernel_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
> -{
> -#ifdef ELF_CORE_COPY_KERNEL_REGS
> -	ELF_CORE_COPY_KERNEL_REGS((*elfregs), regs);
> -#else
> -	elf_core_copy_regs(elfregs, regs);
> -#endif
> -}
> -
>  static inline int elf_core_copy_task_regs(struct task_struct *t, elf_gregset_t* elfregs)
>  {
>  #if defined (ELF_CORE_COPY_TASK_REGS)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 68480f731192..be4b54c2c615 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1078,7 +1078,7 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
>  		return;
>  	memset(&prstatus, 0, sizeof(prstatus));
>  	prstatus.common.pr_pid = current->pid;
> -	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
> +	elf_core_copy_regs(&prstatus.pr_reg, regs);
>  	buf = append_elf_note(buf, KEXEC_CORE_NOTE_NAME, NT_PRSTATUS,
>  			      &prstatus, sizeof(prstatus));
>  	final_note(buf);
> -- 
> 2.35.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
