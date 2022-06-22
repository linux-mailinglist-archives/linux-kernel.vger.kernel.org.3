Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2346F555203
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377262AbiFVRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377205AbiFVRKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF8C23F30B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655917773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwE0a9PC37waDzGpK64QMjVnshbm6LUfxIuUv+3detE=;
        b=V89CvEhpoLe3JAFxddESgh+HfkZnIAbPol3Olb3Qv7pXlXNr8kzOQUQqGZj7nw+EQoCEiK
        9np+9WsagbuJjGD2BlGqDbqu/m+okADfCxIRlz206y2aG2CpePadskbjfcvIVjcymVDOIt
        7s72wh8caw5n4/EKYRHeCzX4140Utkg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-CMtuCWFWNuyk6lneCrY_7w-1; Wed, 22 Jun 2022 13:09:28 -0400
X-MC-Unique: CMtuCWFWNuyk6lneCrY_7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A4458001EA;
        Wed, 22 Jun 2022 17:09:27 +0000 (UTC)
Received: from starship (unknown [10.40.194.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1666B40D2962;
        Wed, 22 Jun 2022 17:09:21 +0000 (UTC)
Message-ID: <70deac4c885b2bf41daecaed054f80f867ed19de.camel@redhat.com>
Subject: Re: [PATCH 4/4] x86/cpuid: check for dependencies violations in
 CPUID and attempt to fix them
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jane Malalane <jane.malalane@citrix.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 22 Jun 2022 20:09:20 +0300
In-Reply-To: <c271cbf5-dfb5-c3dd-002b-9a358c90e984@intel.com>
References: <20220622144820.751402-1-mlevitsk@redhat.com>
         <20220622144820.751402-5-mlevitsk@redhat.com>
         <c271cbf5-dfb5-c3dd-002b-9a358c90e984@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-22 at 08:32 -0700, Dave Hansen wrote:
> On 6/22/22 07:48, Maxim Levitsky wrote:
> > Due to configuration bugs, sometimes a CPU feature is disabled in CPUID,
> > but not features that depend on it.
> > 
> > While the above is not supported, the kernel should try to not crash,
> > and clearing the dependent cpu caps is the best way to do it.
> 
> That's a rather paltry changelog.
> 
> If I remember correctly, there's a crystal clear problem:
> 
> 	If a CPU enumerates support for AVX2 but AVX via CPUID, the
> 	kernel crashes.
> 
> There's also a follow-on problem.  The kernel has all the data it needs
> to fix this, but just doesn't consult it:
> 
> 	To make matters worse, the kernel _knows_ that this is an ill-
> 	advised situation: The kernel prevents itself from clearing the
> 	software representation of the AVX CPUID bit without also
> 	clearing AVX2.
> 
> 	But, the kernel only consults this knowledge when it is clearing
> 	cpu_cap bits.  It does not consult this information when it is
> 	populating those cpu_cap bits.

Yes, I agree. I'll update the changelog with something more in depth.

> 
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index 4cc79971d2d847..c83a8f447d6aed 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -1469,7 +1469,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
> >  			this_cpu->c_early_init(c);
> >  
> >  		c->cpu_index = 0;
> > -		filter_cpuid_features(c, false);
> > +		filter_cpuid_features(c, true);
> >  
> >  		if (this_cpu->c_bsp_init)
> >  			this_cpu->c_bsp_init(c);
> > @@ -1757,7 +1757,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
> >  	 */
> >  
> >  	/* Filter out anything that depends on CPUID levels we don't have */
> > -	filter_cpuid_features(c, true);
> > +	filter_cpuid_features(c, false);
> >  
> >  	/* If the model name is still unset, do table lookup. */
> >  	if (!c->x86_model_id[0]) {
> 
> While we're at it, could we please rid ourselves of this unreadable
> mystery true/false gunk?

It is present if I understand the code correctly to avoid printing a warning twice.
It used to be 'warn' parameter, and I changed it to 'early' parameter, 
inverting its boolean value, because I have seen that warning is not printed at all, 
and I assumed that it is because the first early call already clears the cpuid cap
and the second call doesn't get the warning.

Now however, looking at that I think that the same will
happen with the cpuid level fitering as well, and thus we can just remove that
'warn' parameter.

> 
> > diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> > index bcb091d02a754b..6d9c0e39851805 100644
> > --- a/arch/x86/kernel/cpu/cpuid-deps.c
> > +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> > @@ -94,6 +94,11 @@ static inline void clear_feature(struct cpuinfo_x86 *c, unsigned int feature)
> >  		set_bit(feature, (unsigned long *)cpu_caps_cleared);
> >  }
> >  
> > +static inline bool test_feature(struct cpuinfo_x86 *c, unsigned int feature)
> > +{
> > +	return test_bit(feature, (unsigned long *)c->x86_capability);
> > +}
> > +
> >  /* Take the capabilities and the BUG bits into account */
> >  #define MAX_FEATURE_BITS ((NCAPINTS + NBUGINTS) * sizeof(u32) * 8)
> >  
> > @@ -127,6 +132,7 @@ void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature)
> >  	} while (changed);
> >  }
> >  
> > +
> >  void setup_clear_cpu_cap(unsigned int feature)
> 
> More superfluous whitespace.

Sorry about that, will check better next time.
> 
> >  {
> >  	clear_cpu_cap(&boot_cpu_data, feature);
> > @@ -137,6 +143,10 @@ void setup_clear_cpu_cap(unsigned int feature)
> >   * Some CPU features depend on higher CPUID levels, which may not always
> >   * be available due to CPUID level capping or broken virtualization
> >   * software.  Add those features to this table to auto-disable them.
> > + *
> > + * Also due to configuration bugs, some CPUID features might be present
> > + * while CPUID features that they depend on are not present,
> > + * e.g a AVX2 present but AVX is not present.
> >   */
> >  struct cpuid_dependent_feature {
> >  	u32 feature;
> > @@ -151,9 +161,10 @@ cpuid_dependent_features[] = {
> >  	{ 0, 0 }
> >  };
> >  
> > -void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn)
> > +void filter_cpuid_features(struct cpuinfo_x86 *c, bool early)
> >  {
> 
> I have at least an inkling what 'warn' could mean.  But, 'early'?  One
> man's 'early' is another one's 'late'.

I understand what you mean, as I said above, I will try to reproduce
the original issue of cpuid level mismatch and see if I can remove
the warn parameter at all.


> 
> >  	const struct cpuid_dependent_feature *df;
> > +	const struct cpuid_dep *d;
> >  
> >  	for (df = cpuid_dependent_features; df->feature; df++) {
> >  
> > @@ -172,10 +183,22 @@ void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn)
> >  			continue;
> >  
> >  		clear_cpu_cap(c, df->feature);
> > -		if (!warn)
> > +		if (early)
> >  			continue;
> 
> Why is it that 'early' calls don't want warnings?

I don't know to be honest, except that I assumed that this
allows to not print the warning twice, but as I said above,
I might be able to just remove that code.


> 
> >  		pr_warn("CPU: CPU feature " X86_CAP_FMT " disabled, no CPUID level 0x%x\n",
> >  			x86_cap_flag(df->feature), df->level);
> >  	}
> > +
> > +	for (d = cpuid_deps; d->feature; d++) {
> > +
> > +		if (!test_feature(c, d->feature) || test_feature(c, d->depends))
> > +			continue;
> > +
> > +		clear_feature(c, d->feature);
> > +
> > +		pr_warn("CPU: CPU feature " X86_CAP_FMT " disabled, because it depends on "
> > +			X86_CAP_FMT " which is not supported in CPUID\n",
> > +			x86_cap_flag(d->feature), x86_cap_flag(d->depends));
> > +	}
> >  }
> 
> The do_clear_cpu_cap() does this with a loop, presumably because a later
> (higher index in the array) feature in cpuid_deps[] could theoretically
> clear an earlier (lower index) feature.

Sorry this is my silly mistake. I intended to call clear_cpu_cap here,
which will if needed disable all the depedencies, so a loop doesn't
seem to be needed here. 

It's not very efficient but this is only done once per vCPU so shouldn't matter.


> 
> Also, is that message strictly correct?  There might have been a
> clearcpuid= argument or even another dependency that ended up clearing a
> bit.  It might have nothing to do with CPUID itself.

I think it should work, because clearcpuid= will end up calling clear_cpu_cap
which will disable both the requested feature and everything that depends on
it, thus filter_cpuid_features should not notice any inconsistencies.

Other way around, if the clear_cpu_cap is called before filter_cpuid_features,
it might 'fix' the inconsistency, and silence the warning but that isn't an
issue IMHO.


Thanks a lot for the review,
Best regards,
	Maxim Levitsky

> 


