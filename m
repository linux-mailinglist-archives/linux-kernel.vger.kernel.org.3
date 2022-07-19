Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7C5797D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiGSKsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiGSKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:47:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C65CE3D;
        Tue, 19 Jul 2022 03:47:57 -0700 (PDT)
Received: from zn.tnic (p200300ea97297609329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:7609:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 315601EC04D6;
        Tue, 19 Jul 2022 12:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658227671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=itxQexl6sj7uyxfVl7DeFw4Cg1ss0IG70VFcnixr/7s=;
        b=b410x885IhieOidIYERnkO1GPUK8UXT1/Gg40HuooGSEIOMVEqdU50oUWHTW0ynG2CFaSG
        0XoVc9VJ8bWoc0/oiJGGsJTwl9ggAbSOWZA2mrAcVVPKGagDAQ9Wu23YoQc3Uk2nEnP61G
        Yj0BYs0RVoahETfOz+/Ju8GVDm+Chwg=
Date:   Tue, 19 Jul 2022 12:47:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        brchuckz@netscape.net, jbeulich@suse.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] x86: add wrapper functions for mtrr functions
 handling also pat
Message-ID: <YtaLtNYXsntADBMs@zn.tnic>
References: <20220715142549.25223-1-jgross@suse.com>
 <20220715142549.25223-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220715142549.25223-3-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop stable.

On Fri, Jul 15, 2022 at 04:25:48PM +0200, Juergen Gross wrote:
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 5c934b922450..e2140204fb7e 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -865,7 +865,14 @@ bool arch_is_platform_page(u64 paddr);
>  #define arch_is_platform_page arch_is_platform_page
>  #endif
>  
> +extern bool cache_aps_delayed_init;
> +
>  void cache_disable(void);
>  void cache_enable(void);
> +void cache_bp_init(void);
> +void cache_ap_init(void);
> +void cache_set_aps_delayed_init(void);
> +void cache_aps_init(void);
> +void cache_bp_restore(void);
>  
>  #endif /* _ASM_X86_PROCESSOR_H */

Use arch/x86/include/asm/cacheinfo.h instead.

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index e43322f8a4ef..0a1bd14f7966 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1929,7 +1929,7 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
>  #ifdef CONFIG_X86_32
>  	enable_sep_cpu();
>  #endif
> -	mtrr_ap_init();
> +	cache_ap_init();
>  	validate_apic_and_package_id(c);
>  	x86_spec_ctrl_setup_ap();
>  	update_srbds_msr();
> @@ -2403,3 +2403,45 @@ void cache_enable(void) __releases(cache_disable_lock)
>  
>  	raw_spin_unlock(&cache_disable_lock);
>  }
> +
> +void __init cache_bp_init(void)
> +{
> +	if (IS_ENABLED(CONFIG_MTRR))
> +		mtrr_bp_init();
> +	else
> +		pat_disable("PAT support disabled because CONFIG_MTRR is disabled in the kernel.");
> +}
> +
> +void cache_ap_init(void)
> +{
> +	if (cache_aps_delayed_init)
> +		return;
> +
> +	mtrr_ap_init();
> +}
> +
> +bool cache_aps_delayed_init;
> +
> +void cache_set_aps_delayed_init(void)
> +{
> +	cache_aps_delayed_init = true;
> +}

What's the point of a variable and a setter function?

You can either make this var __ro_after_init and then use it everywhere
or make it static and use a setter and getter.

> +
> +void cache_aps_init(void)
> +{
> +	/*
> +	 * Check if someone has requested the delay of AP cache initialization,
> +	 * by doing cache_set_aps_delayed_init(), prior to this point. If not,
> +	 * then we are done.
> +	 */
> +	if (!cache_aps_delayed_init)
> +		return;
> +
> +	mtrr_aps_init();
> +	cache_aps_delayed_init = false;
> +}
> +
> +void cache_bp_restore(void)
> +{
> +	mtrr_bp_restore();
> +}
> diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
> index 2746cac9d8a9..c1593cfae641 100644
> --- a/arch/x86/kernel/cpu/mtrr/mtrr.c
> +++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
> @@ -69,7 +69,6 @@ unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
>  static DEFINE_MUTEX(mtrr_mutex);
>  
>  u64 size_or_mask, size_and_mask;
> -static bool mtrr_aps_delayed_init;
>  
>  static const struct mtrr_ops *mtrr_ops[X86_VENDOR_NUM] __ro_after_init;
>  
> @@ -176,7 +175,8 @@ static int mtrr_rendezvous_handler(void *info)
>  	if (data->smp_reg != ~0U) {
>  		mtrr_if->set(data->smp_reg, data->smp_base,
>  			     data->smp_size, data->smp_type);
> -	} else if (mtrr_aps_delayed_init || !cpu_online(smp_processor_id())) {
> +	} else if ((use_intel() && cache_aps_delayed_init) ||

What's the use_intel() for?

> +		   !cpu_online(smp_processor_id())) {
>  		mtrr_if->set_all();
>  	}
>  	return 0;
> @@ -789,7 +789,7 @@ void mtrr_ap_init(void)
>  	if (!mtrr_enabled())
>  		return;
>  
> -	if (!use_intel() || mtrr_aps_delayed_init)
> +	if (!use_intel())

And here you remove the mtrr_aps_delayed_init check but you have the
corresponding check of cache_aps_delayed_init in the caller. Hmm.

So it looks like you're pushing some of the logic into the cache_*
functions, one level up.

But it is really hard to follow what you're doing here.

And that mtrr_aps_delayed_init thing is not making it any easier. It
gets set during init unconditionally and once APs have been setup, it
gets cleared.

And, AFAICT, it is used so that the MTRRs are not set when single APs
get onlined but it is all done in one fell swoop in mtrr_aps_init() and
then that delayed_init var gets cleared.

But then I don't understand what the point is of that pushing of
cache_aps_delayed_init up into the cache_* functions.

/me greps a while longer...

Ah, ok, I think I see where this is going. The delayed thing is relevant
for PAT too because pat_init() happens also as part of the ->set_all()
rendezvous dance.

Right, so, this patch needs a *lot* more commit message text. You need
to explain why you're doing what you're doing and explain it in detail.

Perhaps even split the patch further into one adding the cache_* helpers
and another converting to them.

And, also, you probably should stick the small fix for the whole deal
in front of the patchset so that we have a stable backport - I wouldn't
want to backport all that more involved rework to stable.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
