Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C3E577E53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiGRJGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiGRJGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:06:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE911810;
        Mon, 18 Jul 2022 02:06:39 -0700 (PDT)
Received: from zn.tnic (p200300ea972976d7329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:76d7:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 587111EC01D2;
        Mon, 18 Jul 2022 11:06:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658135194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ihss3YrDFeRSrPaoH6TZscubvczFQt139Rkg8cAGjTo=;
        b=AyRYEDz7aRBJvH3jGPMq6nwF/u+GBRcwKb/Nhks7uErlAIMoaG/Zog2kgCFJoVWn5eLy6W
        4mqmZNVnJ7so/T6++755xoTkcCenmqRbiNTA2xdN2HEGDzf5CtyQc9gyi343lNaeezEtWq
        htY4C8tG09o0ywNZ8YjML4f53IHAKBs=
Date:   Mon, 18 Jul 2022 11:06:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/fpu] intel_idle: Add a new flag to initialize the AMX
 state
Message-ID: <YtUimvkv+rDJJ9zu@zn.tnic>
References: <20220608164748.11864-3-chang.seok.bae@intel.com>
 <165524723823.4207.14519279505087770025.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165524723823.4207.14519279505087770025.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is conflicting with the retbleed changes which went upstream and
resolving those conflicts would practically mean rewriting your patches.

Can you please redo them ontop of -rc7 and send them again?

This is not something we normally do but retbleed is not something
normal so..

Thanks!

On Tue, Jun 14, 2022 at 10:53:58PM -0000, tip-bot2 for Chang S. Bae wrote:
> The following commit has been merged into the x86/fpu branch of tip:
> 
> Commit-ID:     f08ef9057b7b110f44cd364744ba6b5f0115390f
> Gitweb:        https://git.kernel.org/tip/f08ef9057b7b110f44cd364744ba6b5f0115390f
> Author:        Chang S. Bae <chang.seok.bae@intel.com>
> AuthorDate:    Tue, 14 Jun 2022 09:41:16 -07:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Tue, 14 Jun 2022 15:48:58 -07:00
> 
> intel_idle: Add a new flag to initialize the AMX state
> 
> The non-initialized AMX state can be the cause of C-state demotion from C6
> to C1E. This low-power idle state may improve power savings and thus result
> in a higher available turbo frequency budget.
> 
> This behavior is implementation-specific. Initialize the state for the C6
> entrance of Sapphire Rapids as needed.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Zhang Rui <rui.zhang@intel.com>
> Link: https://lkml.kernel.org/r/20220608164748.11864-3-chang.seok.bae@intel.com
> Link: https://lkml.kernel.org/r/20220614164116.5196-1-chang.seok.bae@intel.com
> ---
>  drivers/idle/intel_idle.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 424ef47..8a19ba1 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -54,6 +54,7 @@
>  #include <asm/intel-family.h>
>  #include <asm/mwait.h>
>  #include <asm/msr.h>
> +#include <asm/fpu/api.h>
>  
>  #define INTEL_IDLE_VERSION "0.5.1"
>  
> @@ -106,6 +107,11 @@ static unsigned int mwait_substates __initdata;
>  #define CPUIDLE_FLAG_ALWAYS_ENABLE	BIT(15)
>  
>  /*
> + * Initialize large xstate for the C6-state entrance.
> + */
> +#define CPUIDLE_FLAG_INIT_XSTATE	BIT(16)
> +
> +/*
>   * MWAIT takes an 8-bit "hint" in EAX "suggesting"
>   * the C-state (top nibble) and sub-state (bottom nibble)
>   * 0x00 means "MWAIT(C1)", 0x10 means "MWAIT(C2)" etc.
> @@ -159,6 +165,13 @@ static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
>  	return ret;
>  }
>  
> +static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
> +				       struct cpuidle_driver *drv, int index)
> +{
> +	fpu_idle_fpregs();
> +	return __intel_idle(dev, drv, index);
> +}
> +
>  /**
>   * intel_idle_s2idle - Ask the processor to enter the given idle state.
>   * @dev: cpuidle device of the target CPU.
> @@ -174,8 +187,12 @@ static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
>  static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
>  				       struct cpuidle_driver *drv, int index)
>  {
> -	unsigned long eax = flg2MWAIT(drv->states[index].flags);
>  	unsigned long ecx = 1; /* break on interrupt flag */
> +	struct cpuidle_state *state = &drv->states[index];
> +	unsigned long eax = flg2MWAIT(state->flags);
> +
> +	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE)
> +		fpu_idle_fpregs();
>  
>  	mwait_idle_with_hints(eax, ecx);
>  
> @@ -910,7 +927,8 @@ static struct cpuidle_state spr_cstates[] __initdata = {
>  	{
>  		.name = "C6",
>  		.desc = "MWAIT 0x20",
> -		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
> +		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED |
> +					   CPUIDLE_FLAG_INIT_XSTATE,
>  		.exit_latency = 290,
>  		.target_residency = 800,
>  		.enter = &intel_idle,
> @@ -1819,6 +1837,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
>  		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE)
>  			drv->states[drv->state_count].enter = intel_idle_irq;
>  
> +		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_INIT_XSTATE)
> +			drv->states[drv->state_count].enter = intel_idle_xstate;
> +
>  		if ((disabled_states_mask & BIT(drv->state_count)) ||
>  		    ((icpu->use_acpi || force_use_acpi) &&
>  		     intel_idle_off_by_default(mwait_hint) &&

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
